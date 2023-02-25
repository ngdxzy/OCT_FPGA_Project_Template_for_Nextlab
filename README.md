# OCT-FPGA template project for Nextlab 

Rewrite for OCT-FPGA/udp-network-demo (https://github.com/OCT-FPGA/udp-network-demo.git)
Makefile based on (https://github.com/ngdxzy/Vitis_Make.git)

This work can onlt be run on OCT-FPGA fpga-tools server.

## Differences with OCT-FPGA/udp-network-demo

Reorgnized the files, the current project architecture is like this:

    .
    ├── Makefile
    ├── README.md
    ├── host_src
    │   ├── alice29.txt
    │   ├── fileops.cpp
    │   ├── fileops.h
    │   ├── host_receiver_native.cpp
    │   ├── host_sender_native.cpp
    │   └── oct_fpga.hpp
    ├── kernel_src
    │   ├── Base_IPs
    │   │   ├── cmac_0.xo
    │   │   ├── cmac_1.xo
    │   │   ├── networklayer.xo
    │   │   └── synthesis_results_HMB
    │   ├── bit_container_0
    │   │   ├── Makefile
    │   │   ├── aes
    │   │   ├── data_pack.cpp
    │   │   ├── linker.cfg
    │   │   ├── rxkrnl.cpp
    │   │   ├── txkrnl.cpp
    │   │   ├── xcd.log
    │   │   └── xrc.log
    │   ├── bit_container_1
    │   │   ├── Makefile
    │   │   ├── bridge.cpp
    │   │   ├── linker.cfg
    │   │   ├── xcd.log
    │   │   └── xrc.log
    │   ├── post_sys_link.tcl
    │   └── templates
    │       ├── connectivity_if0.ini
    │       ├── connectivity_if1.ini
    │       └── connectivity_if3.ini
    └── vitis_setup.sh

### Some important files and folders

#### host_src
All host sources. In this template project, simplified sender program and receiver program are included.

#### host_src/fileops
Read file into dynamic allocated RAM space. Provided by OCT-FPGA group.

#### oct_fpga.hpp
APIs for OCT-FPGA key kernels (networklayer and cmac). Two classes are defined in the header file and all communications between host and FPGA kernels are implemented by Xilinx Native APIs rather than opencl based APIs used by OCT-FPGA group.

#### kernel_src/Base_IPs
Supported IPs for OCT-FPGA infrastructure. Provided by OCT-FPGA group.

#### kernel_src/bit_container_*
Since different FPGAs may use different bitstreams in future, multiplie bitstreams are required. To avoid creating independent project for each bitstream, user can just create folders named as ```bit_container_<#>```. Each bit_container has its own Makefile. User have to change the ```CONTAINER_ID := <#>``` in the Makefile to avoid confliction. This scheme could be improved in future.

#### kernel_src/post_sys_lick.tcl
It could be a vivado tcl file to connect clocks to CMAC kernels. Provided by OCT-FPGA group.

#### kernel_src/templates:
Template linker file provided by OCT-FPGA group. It is just for reference. User have to provide the link information in ```kernel_src/bit_container_*/linker.cfg```. In addition, user have to chaneg the ```messageDb=../../build/vivado/bit_container_<#>.mdb``` at the begining of the linker file, but do not delete anything inside the ```[advanced]``` section.

#### vitis_setup.sh
A script just for set environment variables including the floating license for generating bitstream for CMAC. It must be sourced before making.

## Differences with original Vitis_Make

The OCT-FPGA has cross FPGA functions so it is impossible to do any emulations. Therefore, the build target is hw by default. This also avoids all possible debuging tools provided by Xilinx. Therefore, it is suggested to evaluate each user IP in Vitis_HLS first and then put them into this project. Hence, make targets like run, kill that were supported by Vitis_Make project templated are removed.

The Makefile in the first folder detectes how many bit_containers are required first, and it calls each Makefile inside ```kernel_src/bit_container_*``` to build all bit_containers.

Now, the Makefile doesn't copy built files into the project folder. User can find them in ```build``` folder (it will show up after build). Host exes are in ```build/host```, bit containers are in ```build/bit_container_*/vivado/``` 


# How to use
To run, simply type:

```shell

make <target> -j<threads_allowed> 

```

For example, if you want build kernels with 8 threads in parallel for hardware emulation, run:

```shell

make kernel -j8 TARGET=hw_emu

```


# Targets

## all (default target)

Build kernels, link kernels, build host program and copy them to the current folder.

## kernel

Build kernels. The new kernels are saved in the ./build/vitis_hls. The temporay hls projects are also saved there so that they can be opend with GUI and you can check the scheduling and debuging the kernel.

To open the vitis_hls project for each kernel, you can use:
```shell

vitis_hls -p build/bit_container_*/vitis_hls/<kernel_name>/<kernel_name>/<kernel_name>

```


## link

Link the kernels. The linker file ./kernel_src/linker.cfg shall be edit beforehead. The xclbin will be generated in ./build/vivado. Build link will trigger build the kernels if the kernels haven't been build before.

To open the vivado project, you can use:
```shell

vivado -p build/bit_container_*/vivado/link/vivado/vpl/prj/prj.xpr

```
## host

Just build the host excutable file. It does not depend on any other objects.

## clean

Clean up the project. Be careful.

