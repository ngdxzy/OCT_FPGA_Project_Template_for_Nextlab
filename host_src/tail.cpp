#include <iostream>
#include <stdio.h>
#include <xrt/xrt_device.h>         // bitstream
#include <xrt/xrt_bo.h>             // buffers
#include <xrt/xrt_kernel.h>         // kernels, runs
#include <experimental/xrt_ip.h>    // IP direct control

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
    
    unsigned int device_id = 0; // by default
    auto device = xrt::device(device_id);

    xrt::uuid overlay_uuid = device.load_xclbin(xclbinFilename);
    
    xrt::ip dp_0 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_0}");
    xrt::ip dp_1 = xrt::ip(device, overlay_uuid, "auto_data_pack:{auto_data_pack_1}");

    dp_0.write_register(0x10, 2);
    dp_1.write_register(0x10, 3);

    printf("All kernel finished!\n");
    
    return 0;


}
