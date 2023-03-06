#include <iostream>
#include <stdio.h>
#include <xrt/xrt_device.h>         // bitstream
#include <xrt/xrt_bo.h>             // buffers
#include <xrt/xrt_kernel.h>         // kernels, runs
#include <experimental/xrt_ip.h>    // IP direct control
#include <unistd.h>                 // sleep

#include "oct_fpga.hpp"
#include "fileops.h"

// My IP address: 192.168.1.1 
// Their IP address: 192.168.1.2 
// GATEWAY: 192.168.1.255
#define MY_IP_ADDR 0xC0A80101
#define THEIR_IP_ADDR 0xC0A80102
#define IP_GATEWAY 0xC0A801FF

int main(int argc, char* argv[]){
    
    char* xclbinFilename;

    uint32_t packet_size_in_byte = 704;
    uint32_t desti = 0;

    if (argc < 2){
        printf("Usage: %s <XCLBIN File> \n", argv[0]);
        return EXIT_FAILURE;
    }
    else{
        xclbinFilename = argv[1];
        printf("Using FPGA binary file specfied through the command line: %s \n", xclbinFilename);
    }
    
    if (argc > 2){
        sscanf(argv[2],"%u", &packet_size_in_byte);
    }
    if (argc > 3){
        sscanf(argv[3], "%u", &desti);
    }

    printf("Send %u Bytes to Sokcet %u\n", packet_size_in_byte, desti);
    // Load xclbin 
    
    unsigned int device_id = 0; // by default
    auto device = xrt::device(device_id);

    xrt::uuid overlay_uuid = device.load_xclbin(xclbinFilename);
    
    xrt::ip dp = xrt::ip(device, overlay_uuid, "auto_data_pack");

    dp.write_register(0x10, 0);
    // user logic
    // TX
    xrt::kernel txKernel = xrt::kernel(device, overlay_uuid, "txkrnl");

    char* text_tx = readFile("./alice29.txt");
    if (text_tx != NULL){
        printf("File alice29.txt read!\n");
        // printf("************************************************\n");
        // for (int i = 0; i < packet_size_in_byte;i++){
        //     printf("%c", text_tx[i]);
        // }
        // printf("\n");
        // printf("************************************************\n");
    }
    else{
        printf("Cannot find the file!\n");
        return -1;
    }
    xrt::bo tx_buffer = xrt::bo(device, 4096, txKernel.group_id(0));

    tx_buffer.write(text_tx);
    tx_buffer.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    xrt::run txKernel_run = xrt::run(txKernel);

    txKernel_run.set_arg(0, tx_buffer) ;
    txKernel_run.set_arg(1, packet_size_in_byte) ;

    

    txKernel_run.start();
    
    printf("All kernel started!\n");
    
    txKernel_run.wait();

    printf("All kernel finished!\n");
    

    // RX
    xrt::kernel rxKernel = xrt::kernel(device, overlay_uuid, "rxkrnl");

    char text_rx[16384];
    unsigned int keep[16384 / 64];
    unsigned int last[16384 / 64];

    int keep_len = packet_size_in_byte >> 6;
//    keep_len++;

    xrt::bo rx_buffer = xrt::bo(device, sizeof(text_rx), rxKernel.group_id(0));
    xrt::bo keep_buffer = xrt::bo(device, sizeof(keep), rxKernel.group_id(1));
    xrt::bo last_buffer = xrt::bo(device, sizeof(last), rxKernel.group_id(2));

    xrt::run rxKernel_run = xrt::run(rxKernel);

    rxKernel_run.set_arg(0, rx_buffer) ;
    rxKernel_run.set_arg(1, keep_buffer) ;
    rxKernel_run.set_arg(2, last_buffer) ;
    rxKernel_run.set_arg(3, packet_size_in_byte) ;

    rxKernel_run.start();
    
    printf("All kernel started!\n");
    

    // rxKernel_run.wait();
    sleep(3);

    printf("All kernel finished!\n");
    rx_buffer.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    rx_buffer.read(text_rx);
    keep_buffer.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    keep_buffer.read(keep);
    last_buffer.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    last_buffer.read(last);
    

    printf("************************************************\n");
    for (int i = 0; i < packet_size_in_byte; i++){
        printf("%c", text_rx[i]);
        if ((i > 0) && (i % 64 == 0)){
            printf("\n");
        }
    }
    printf("\n************************************************\n");
    FILE* fp = fopen("./data_received.txt", "w");
    if (fp == NULL){
        printf("Failed to open data_received.txt");
    }
    
    for (int i = 0; i < keep_len; i++){
        fprintf(fp, "Packet %02d: Text: |", i);
        for (int j = 0; j < 64; j++){
            fprintf(fp, "%c", text_rx[i * 64 + j]);
        }
        fprintf(fp, "| dest: %02u | last: %u\n", keep[i], last[i]);
    }

    fclose(fp);
    return 0;


}
