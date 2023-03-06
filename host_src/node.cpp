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
    
    xrt::ip dp_0 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_0}");
    xrt::ip dp_1 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_1}");

    dp_0.write_register(0x10, 0);
    dp_1.write_register(0x10, 0);

    printf("All kernel finished!\n");
    
    return 0;


}
