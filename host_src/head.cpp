#include <iostream>
#include <stdio.h>
#include <xrt/xrt_device.h>         // bitstream
#include <xrt/xrt_bo.h>             // buffers
#include <xrt/xrt_kernel.h>         // kernels, runs
#include <experimental/xrt_ip.h>    // IP direct control
#include <unistd.h>                 // sleep

#include "fileops.h"

#define MY_IP_ADDR 0xC0A80101
#define THEIR_IP_ADDR 0xC0A80102
#define IP_GATEWAY 0xC0A801FF

typedef struct userMetadata {
    unsigned int     myIP;
    unsigned int     theirIP;
    unsigned short   myPort;
    unsigned short   theirPort;
    unsigned int     reserved;
}MetaData;
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
    
    xrt::ip dp_0 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_0}");
    xrt::ip dp_1 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_1}");

    dp_0.write_register(0x10, 2);
    dp_1.write_register(0x10, 3);

    // user logic
    // TX
    xrt::kernel txKernel_0 = xrt::kernel(device, overlay_uuid, "txkrnl:{txkrnl_0}");
    xrt::kernel txKernel_1 = xrt::kernel(device, overlay_uuid, "txkrnl:{txkrnl_1}");

    char* text_tx_0 = readFile("./alice29.txt");

    if (text_tx_0 != NULL){
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

    char* text_tx_1 = readFile("./ALICE29.txt");

    if (text_tx_1 != NULL){
        printf("File ALICE29.txt read!\n");
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

    xrt::bo tx_buffer_0 = xrt::bo(device, 16384, txKernel_0.group_id(0));
    xrt::bo tx_buffer_1 = xrt::bo(device, 16384, txKernel_1.group_id(0));

    tx_buffer_0.write(text_tx_0);
    tx_buffer_0.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    tx_buffer_1.write(text_tx_1);
    tx_buffer_1.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    xrt::run txKernel_0_run = xrt::run(txKernel_0);
    xrt::run txKernel_1_run = xrt::run(txKernel_1);

    txKernel_0_run.set_arg(0, tx_buffer_0) ;
    txKernel_0_run.set_arg(1, packet_size_in_byte) ;

    txKernel_1_run.set_arg(0, tx_buffer_1) ;
    txKernel_1_run.set_arg(1, packet_size_in_byte) ;

    txKernel_0_run.start();
    txKernel_1_run.start();
    
    printf("All kernel started!\n");
    
    txKernel_0_run.wait();
    txKernel_1_run.wait();

    printf("All kernel finished!\n");

    // RX
    xrt::kernel rxKernel_0 = xrt::kernel(device, overlay_uuid, "rxkrnl:{rxkrnl_0}");
    xrt::kernel rxKernel_1 = xrt::kernel(device, overlay_uuid, "rxkrnl:{rxkrnl_1}");

    char text_rx_0[16384];
    char text_rx_1[16384];

    xrt::bo rx_buffer_0 = xrt::bo(device, sizeof(text_rx_0), rxKernel_0.group_id(0));
    xrt::bo rx_buffer_1 = xrt::bo(device, sizeof(text_rx_1), rxKernel_1.group_id(0));


    xrt::run rxKernel_0_run = xrt::run(rxKernel_0);
    xrt::run rxKernel_1_run = xrt::run(rxKernel_1);

    rxKernel_0_run.set_arg(0, rx_buffer_0) ;
    rxKernel_0_run.set_arg(1, packet_size_in_byte) ;

    rxKernel_1_run.set_arg(0, rx_buffer_1) ;
    rxKernel_1_run.set_arg(1, packet_size_in_byte) ;

    rxKernel_0_run.start();
    rxKernel_1_run.start();
    
    printf("All kernel started!\n");
    
    // the wait() is not called in case some data is lost and that will stuck the whole program.
    // wait for 3 seconds and synchronize data back.
    // rxKernel_run.wait();
    sleep(3);

    printf("All kernel finished!\n");
    rx_buffer_0.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    rx_buffer_0.read(text_rx_0);
    
    rx_buffer_1.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    rx_buffer_1.read(text_rx_1);

    printf("************************* Rx Kernel 0 **************************\n");
    for (int i = 0; i < packet_size_in_byte; i++){
        printf("%c", text_rx_0[i]);
        if ((i > 0) && (i % 64 == 0)){
            printf("\n");
        }
    }
    printf("\n************************* Rx Kernel 1 **************************\n");
    for (int i = 0; i < packet_size_in_byte; i++){
        printf("%c", text_rx_1[i]);
        if ((i > 0) && (i % 64 == 0)){
            printf("\n");
        }
    }
    printf("\n****************************************************************\n");
    FILE* fp = fopen("./data_received_0.txt", "w");
    if (fp == NULL){
        printf("Failed to open data_received.txt");
    }
    
    for (int i = 0; i < (packet_size_in_byte >> 6); i++){
        fprintf(fp, "Packet %02d: Text: |", i);
        for (int j = 0; j < 64; j++){
            fprintf(fp, "%c", text_rx_0[i * 64 + j]);
        }
        fprintf(fp, "\n");
    }

    fclose(fp);

    fp = fopen("./data_received_1.txt", "w");
    if (fp == NULL){
        printf("Failed to open data_received.txt");
    }
    
    for (int i = 0; i < (packet_size_in_byte >> 6); i++){
        fprintf(fp, "Packet %02d: Text: |", i);
        for (int j = 0; j < 64; j++){
            fprintf(fp, "%c", text_rx_1[i * 64 + j]);
        }
        fprintf(fp, "\n");
    }

    fclose(fp);
    return 0;


}
