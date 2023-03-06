#include <iostream>
#include <stdio.h>
#include <xrt/xrt_device.h>         // bitstream
#include <xrt/xrt_bo.h>             // buffers
#include <xrt/xrt_kernel.h>         // kernels, runs
#include <experimental/xrt_ip.h>    // IP direct control
#include "oct_fpga.hpp"

// My IP address: 192.168.1.1 
// Their IP address: 192.168.1.2 
// GATEWAY: 192.168.1.255
#define MY_IP_ADDR 0xC0A80102
#define THEIR_IP_ADDR 0xC0A80101
#define IP_GATEWAY 0xC0A801FF

// #define DEBUG

// udp_setup <bit_container.xclbin> MY_IP THEIR_IP MP TP SOCKET_ID

int main(int argc, char* argv[]){
    
    char* xclbinFilename;

    unsigned int my_ip;

    int cmac_id = 0;

    if (argc < 2){
        printf("Usage: %s <XCLBIN File> \n", argv[0]);
        return EXIT_FAILURE;
    }
    else{
        xclbinFilename = argv[1];
        printf("Using FPGA binary file specfied through the command line: %s \n", xclbinFilename);
    }

    FILE* conf_file;
    if (argc > 2){
        conf_file = fopen(argv[2], "r");
    }
    else{
        conf_file = fopen("net_config.ini", "r");
    }

    if (argc > 3){
        cmac_id = atoi(argv[3]);
    }
    printf("Setting up CMAC %d\n", cmac_id);

    if (conf_file == NULL){
        printf("Cannot read conf file!\n");
        return -1;
    }

    unsigned char* mp = (unsigned char*) (&my_ip);
    fscanf(conf_file, "%hhu.%hhu.%hhu.%hhu", mp+3, mp+2, mp+1, mp);
    printf("Get user specified IP address: %x\n", my_ip);

    socket_type sockets[16] = {};
    
    for (int i = 0; i < 16; i++){
        unsigned int their_ip;
        unsigned short their_port;
        unsigned short my_port;
        unsigned char* p = (unsigned char*) (&their_ip);
        if (EOF != fscanf(conf_file, "%hu:%hhu.%hhu.%hhu.%hhu:%hu",&my_port, p+3, p+2, p+1, p, &their_port)){
            printf("Get %02dth socket conncection %hhu.%hhu.%hhu.%hhu:%hu <->  %hhu.%hhu.%hhu.%hhu:%hu\n", i, *(mp+3), *(mp+2), *(mp+1), *(mp+0), my_port, *(p+3), *(p+2), *(p+1), *(p+0), their_port);
            sockets[i].their_port = their_port;
            sockets[i].their_ip = their_ip;
            sockets[i].my_port = my_port;
            sockets[i].valid = true;
        }
        else{
            break;
        }
    }
    
    long mac_address = (0xf0f1f2f3f4f5 & 0xFFFFFFFFF00) + (my_ip & 0xFF);
    unsigned int gateway = my_ip | 0xFF;
    printf("Using gateway: %x\n", gateway);
    printf("Using MAC: %lx\n", mac_address);

#ifndef DEBUG
    // Load xclbin 
    printf("Loading %s \n", xclbinFilename);
    
    unsigned int device_id = 0; // by default
    auto device = xrt::device(device_id);
    
    std::cout << "Device name:  " <<  device.get_info<xrt::info::device::name>() << std::endl;
    std::cout << "Device bdf:   " <<  device.get_info<xrt::info::device::bdf>() << std::endl;

    xrt::uuid overlay_uuid = device.load_xclbin(xclbinFilename);

    char cmac_ip_name[64];
    char network_ip_name[64];

    if (cmac_id == 0){
        sprintf(cmac_ip_name, "cmac_0");
        sprintf(network_ip_name, "networklayer:{networklayer_0}");
    }
    else{
        sprintf(cmac_ip_name, "cmac_1");
        sprintf(network_ip_name, "networklayer:{networklayer_1}");
    }
    
    cmac cmac_inst = cmac(device, overlay_uuid, cmac_ip_name);

    network_layer network_inst = network_layer(device, overlay_uuid, network_ip_name);
    
    network_inst.set_self_ip(my_ip, mac_address, gateway);

    network_inst.enable_socket(-1); // disable all sockets

    int num_of_sockets = network_inst.get_hardware_sockets_number();

    printf("There are %d hardware sockets.\n", num_of_sockets);

    // define user sockets 
    
    for (int i = 0; i < 16; i++){
        network_inst.set_socket(i, sockets[i]);
    }
    
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
#endif

    return 0;


}
