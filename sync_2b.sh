#!/bin/bash
scp build/host/head_bin OCT_FPGA_NODE0:~/
scp build/host/node_bin OCT_FPGA_NODE1:~/
scp build/host/tail_bin OCT_FPGA_NODE1:~/

scp build/bit_container_0/bit_container_0.xclbin OCT_FPGA_NODE0:~/
scp build/bit_container_2/bit_container_2.xclbin OCT_FPGA_NODE1:~/
scp build/bit_container_1/bit_container_1.xclbin OCT_FPGA_NODE1:~/
# scp build/bit_container_1/bit_container_1.xclbin OCT_FPGA_NODE1:~/

scp host_src/alice29.txt OCT_FPGA_NODE0:~/
scp host_src/ALICE29.txt OCT_FPGA_NODE0:~/

scp head_ip_2b.ini OCT_FPGA_NODE0:~/
scp node_ip_2b.ini OCT_FPGA_NODE1:~/
scp tail_ip_2b.ini OCT_FPGA_NODE1:~/

scp build/host/udp_setup OCT_FPGA_NODE0:~/
scp build/host/udp_setup OCT_FPGA_NODE1:~/
