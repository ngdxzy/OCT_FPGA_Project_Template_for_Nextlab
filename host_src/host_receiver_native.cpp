#include <iostream>
#include <stdio.h>
#include <xrt/xrt_device.h>         // bitstream
#include <xrt/xrt_bo.h>             // buffers
#include <xrt/xrt_kernel.h>         // kernels, runs
#include <experimental/xrt_ip.h>    // IP direct control
#include "oct_fpga.hpp"
#include "fileops.h"

// My IP address: 192.168.1.1 
// Their IP address: 192.168.1.2 
// GATEWAY: 192.168.1.255
#define MY_IP_ADDR 0xC0A80102
#define THEIR_IP_ADDR 0xC0A80101
#define IP_GATEWAY 0xC0A801FF

int main(int argc, char* argv[]){
    
    char* xclbinFilename;

    if (argc < 2){
        printf("Usage: %s <XCLBIN File> \n", argv[0]);
        return EXIT_FAILURE;
    }
    else{
        xclbinFilename = argv[1];
        printf("Using FPGA binary file specfied through the command line: %s \n", xclbinFilename);
    }

    // Load xclbin 
    printf("Loading %s \n", xclbinFilename);
    
    unsigned int device_id = 0; // by default
    auto device = xrt::device(device_id);
    
    std::cout << "Device name:  " <<  device.get_info<xrt::info::device::name>() << std::endl;
    std::cout << "Device bdf:   " <<  device.get_info<xrt::info::device::bdf>() << std::endl;

    xrt::uuid overlay_uuid = device.load_xclbin(xclbinFilename);
    
    cmac cmac_inst = cmac(device, overlay_uuid, "cmac_0");
    network_layer network_inst = network_layer(device, overlay_uuid, "networklayer");
    
    long mac_address = (0xf0f1f2f3f4f5 & 0xFFFFFFFFFF0) + (MY_IP_ADDR & 0xF);
    network_inst.set_self_ip(MY_IP_ADDR, mac_address, IP_GATEWAY);

    network_inst.enable_socket(-1); // disable all sockets

    int num_of_sockets = network_inst.get_hardware_sockets_number();

    printf("There are %d hardware sockets.\n", num_of_sockets);

    // define user sockets 
    socket_type T_receiver_socket;
    
    // 192.168.1.1:50000 -> 192.168.1.2:60000
    
    T_receiver_socket.their_ip = THEIR_IP_ADDR;

    T_receiver_socket.their_port = 50000;
    T_receiver_socket.my_port = 60000;
    

    network_inst.set_socket(0, T_receiver_socket);
    
    network_inst.enable_socket(0);
    
    network_inst.arp_discover();
    
    unsigned int tx_status = 0;
    unsigned int rx_status = 0;
    tx_status = cmac_inst.get_tx_status();
    rx_status = cmac_inst.get_rx_status();

    printf("TX status %d\n", tx_status);
    printf("RX status %d\n", rx_status);

    if (rx_status & 0x01){
        printf("Link is as active!\n");
    }
    else{
        printf("Link is not active!\n");
    }

    // user logic
    uint32_t packet_size_in_byte = 1408;
    // RX
    xrt::kernel rxKernel = xrt::kernel(device, overlay_uuid, "rxkrnl");

    char text_rx[1408];

    xrt::bo rx_buffer = xrt::bo(device, 1408, rxKernel.group_id(0));

    xrt::run rxKernel_run = xrt::run(rxKernel);

    rxKernel_run.set_arg(0, rx_buffer) ;
    rxKernel_run.set_arg(2, packet_size_in_byte) ;
    rxKernel_run.set_arg(3, 0) ;

    rxKernel_run.start();
    
    printf("All kernel started!\n");
    

    rxKernel_run.wait();

    printf("All kernel finished!\n");
    rx_buffer.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    rx_buffer.read(text_rx);
    

    printf("************************************************\n");
    for (int i = 0; i < 1408; i++){
        printf("%c", text_rx[i]);
    }
    printf("\n************************************************\n");

    getchar();
    return 0;


}
