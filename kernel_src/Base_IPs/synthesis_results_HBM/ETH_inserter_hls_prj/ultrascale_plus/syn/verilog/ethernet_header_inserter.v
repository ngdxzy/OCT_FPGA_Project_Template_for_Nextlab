// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.2 (64-bit)
// Version: 2021.2
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="ethernet_header_inserter_ethernet_header_inserter,hls_ip_2021_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu280-fsvh2892-2L-e,HLS_INPUT_CLOCK=3.100000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=2.815938,HLS_SYN_LAT=9,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=13968,HLS_SYN_LUT=7595,HLS_VERSION=2021_2}" *)

module ethernet_header_inserter (
        ap_local_block,
        ap_local_deadlock,
        dataIn_TDATA,
        dataIn_TKEEP,
        dataIn_TSTRB,
        dataIn_TLAST,
        dataOut_TDATA,
        dataOut_TKEEP,
        dataOut_TSTRB,
        dataOut_TLAST,
        arpTableReplay_TDATA,
        arpTableRequest_TDATA,
        myMacAddress,
        regSubNetMask,
        regDefaultGateway,
        ap_clk,
        ap_rst_n,
        dataIn_TVALID,
        dataIn_TREADY,
        arpTableRequest_TVALID,
        arpTableRequest_TREADY,
        arpTableReplay_TVALID,
        arpTableReplay_TREADY,
        dataOut_TVALID,
        dataOut_TREADY
);


output   ap_local_block;
output   ap_local_deadlock;
input  [511:0] dataIn_TDATA;
input  [63:0] dataIn_TKEEP;
input  [63:0] dataIn_TSTRB;
input  [0:0] dataIn_TLAST;
output  [511:0] dataOut_TDATA;
output  [63:0] dataOut_TKEEP;
output  [63:0] dataOut_TSTRB;
output  [0:0] dataOut_TLAST;
input  [127:0] arpTableReplay_TDATA;
output  [31:0] arpTableRequest_TDATA;
input  [47:0] myMacAddress;
input  [31:0] regSubNetMask;
input  [31:0] regDefaultGateway;
input   ap_clk;
input   ap_rst_n;
input   dataIn_TVALID;
output   dataIn_TREADY;
output   arpTableRequest_TVALID;
input   arpTableRequest_TREADY;
input   arpTableReplay_TVALID;
output   arpTableReplay_TREADY;
output   dataOut_TVALID;
input   dataOut_TREADY;

 reg    ap_rst_n_inv;
wire    entry_proc_U0_ap_start;
wire    entry_proc_U0_ap_done;
wire    entry_proc_U0_ap_continue;
wire    entry_proc_U0_ap_idle;
wire    entry_proc_U0_ap_ready;
wire    entry_proc_U0_start_out;
wire    entry_proc_U0_start_write;
wire   [47:0] entry_proc_U0_myMacAddress_c_din;
wire    entry_proc_U0_myMacAddress_c_write;
wire    broadcaster_and_mac_request_U0_ap_start;
wire    broadcaster_and_mac_request_U0_ap_done;
wire    broadcaster_and_mac_request_U0_ap_continue;
wire    broadcaster_and_mac_request_U0_ap_idle;
wire    broadcaster_and_mac_request_U0_ap_ready;
wire   [1023:0] broadcaster_and_mac_request_U0_ip_header_out_din;
wire    broadcaster_and_mac_request_U0_ip_header_out_write;
wire   [1023:0] broadcaster_and_mac_request_U0_no_ip_header_out_din;
wire    broadcaster_and_mac_request_U0_no_ip_header_out_write;
wire    broadcaster_and_mac_request_U0_start_out;
wire    broadcaster_and_mac_request_U0_start_write;
wire    broadcaster_and_mac_request_U0_dataIn_TREADY;
wire   [31:0] broadcaster_and_mac_request_U0_arpTableRequest_TDATA;
wire    broadcaster_and_mac_request_U0_arpTableRequest_TVALID;
wire    compute_and_insert_ip_checksum_U0_ap_start;
wire    compute_and_insert_ip_checksum_U0_ap_done;
wire    compute_and_insert_ip_checksum_U0_ap_continue;
wire    compute_and_insert_ip_checksum_U0_ap_idle;
wire    compute_and_insert_ip_checksum_U0_ap_ready;
wire    compute_and_insert_ip_checksum_U0_ip_header_out_read;
wire   [1023:0] compute_and_insert_ip_checksum_U0_ip_header_checksum_din;
wire    compute_and_insert_ip_checksum_U0_ip_header_checksum_write;
wire    handle_output_U0_ap_start;
wire    handle_output_U0_ap_done;
wire    handle_output_U0_ap_continue;
wire    handle_output_U0_ap_idle;
wire    handle_output_U0_ap_ready;
wire    handle_output_U0_myMacAddress_read;
wire    handle_output_U0_no_ip_header_out_read;
wire    handle_output_U0_ip_header_checksum_read;
wire    handle_output_U0_arpTableReplay_TREADY;
wire   [511:0] handle_output_U0_dataOut_TDATA;
wire    handle_output_U0_dataOut_TVALID;
wire   [63:0] handle_output_U0_dataOut_TKEEP;
wire   [63:0] handle_output_U0_dataOut_TSTRB;
wire   [0:0] handle_output_U0_dataOut_TLAST;
wire    myMacAddress_c_full_n;
wire   [47:0] myMacAddress_c_dout;
wire    myMacAddress_c_empty_n;
wire    ip_header_out_full_n;
wire   [1023:0] ip_header_out_dout;
wire    ip_header_out_empty_n;
wire    no_ip_header_out_full_n;
wire   [1023:0] no_ip_header_out_dout;
wire    no_ip_header_out_empty_n;
wire    ip_header_checksum_full_n;
wire   [1023:0] ip_header_checksum_dout;
wire    ip_header_checksum_empty_n;
wire   [0:0] start_for_handle_output_U0_din;
wire    start_for_handle_output_U0_full_n;
wire   [0:0] start_for_handle_output_U0_dout;
wire    start_for_handle_output_U0_empty_n;
wire   [0:0] start_for_compute_and_insert_ip_checksum_U0_din;
wire    start_for_compute_and_insert_ip_checksum_U0_full_n;
wire   [0:0] start_for_compute_and_insert_ip_checksum_U0_dout;
wire    start_for_compute_and_insert_ip_checksum_U0_empty_n;

ethernet_header_inserter_entry_proc entry_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(entry_proc_U0_ap_start),
    .start_full_n(start_for_handle_output_U0_full_n),
    .ap_done(entry_proc_U0_ap_done),
    .ap_continue(entry_proc_U0_ap_continue),
    .ap_idle(entry_proc_U0_ap_idle),
    .ap_ready(entry_proc_U0_ap_ready),
    .start_out(entry_proc_U0_start_out),
    .start_write(entry_proc_U0_start_write),
    .myMacAddress(myMacAddress),
    .myMacAddress_c_din(entry_proc_U0_myMacAddress_c_din),
    .myMacAddress_c_full_n(myMacAddress_c_full_n),
    .myMacAddress_c_write(entry_proc_U0_myMacAddress_c_write)
);

ethernet_header_inserter_broadcaster_and_mac_request broadcaster_and_mac_request_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(broadcaster_and_mac_request_U0_ap_start),
    .start_full_n(start_for_compute_and_insert_ip_checksum_U0_full_n),
    .ap_done(broadcaster_and_mac_request_U0_ap_done),
    .ap_continue(broadcaster_and_mac_request_U0_ap_continue),
    .ap_idle(broadcaster_and_mac_request_U0_ap_idle),
    .ap_ready(broadcaster_and_mac_request_U0_ap_ready),
    .dataIn_TVALID(dataIn_TVALID),
    .arpTableRequest_TREADY(arpTableRequest_TREADY),
    .ip_header_out_din(broadcaster_and_mac_request_U0_ip_header_out_din),
    .ip_header_out_full_n(ip_header_out_full_n),
    .ip_header_out_write(broadcaster_and_mac_request_U0_ip_header_out_write),
    .no_ip_header_out_din(broadcaster_and_mac_request_U0_no_ip_header_out_din),
    .no_ip_header_out_full_n(no_ip_header_out_full_n),
    .no_ip_header_out_write(broadcaster_and_mac_request_U0_no_ip_header_out_write),
    .start_out(broadcaster_and_mac_request_U0_start_out),
    .start_write(broadcaster_and_mac_request_U0_start_write),
    .dataIn_TDATA(dataIn_TDATA),
    .dataIn_TREADY(broadcaster_and_mac_request_U0_dataIn_TREADY),
    .dataIn_TKEEP(dataIn_TKEEP),
    .dataIn_TSTRB(dataIn_TSTRB),
    .dataIn_TLAST(dataIn_TLAST),
    .arpTableRequest_TDATA(broadcaster_and_mac_request_U0_arpTableRequest_TDATA),
    .arpTableRequest_TVALID(broadcaster_and_mac_request_U0_arpTableRequest_TVALID),
    .regSubNetMask(regSubNetMask),
    .regDefaultGateway(regDefaultGateway)
);

ethernet_header_inserter_compute_and_insert_ip_checksum compute_and_insert_ip_checksum_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(compute_and_insert_ip_checksum_U0_ap_start),
    .ap_done(compute_and_insert_ip_checksum_U0_ap_done),
    .ap_continue(compute_and_insert_ip_checksum_U0_ap_continue),
    .ap_idle(compute_and_insert_ip_checksum_U0_ap_idle),
    .ap_ready(compute_and_insert_ip_checksum_U0_ap_ready),
    .ip_header_out_dout(ip_header_out_dout),
    .ip_header_out_empty_n(ip_header_out_empty_n),
    .ip_header_out_read(compute_and_insert_ip_checksum_U0_ip_header_out_read),
    .ip_header_checksum_din(compute_and_insert_ip_checksum_U0_ip_header_checksum_din),
    .ip_header_checksum_full_n(ip_header_checksum_full_n),
    .ip_header_checksum_write(compute_and_insert_ip_checksum_U0_ip_header_checksum_write)
);

ethernet_header_inserter_handle_output handle_output_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(handle_output_U0_ap_start),
    .ap_done(handle_output_U0_ap_done),
    .ap_continue(handle_output_U0_ap_continue),
    .ap_idle(handle_output_U0_ap_idle),
    .ap_ready(handle_output_U0_ap_ready),
    .myMacAddress_dout(myMacAddress_c_dout),
    .myMacAddress_empty_n(myMacAddress_c_empty_n),
    .myMacAddress_read(handle_output_U0_myMacAddress_read),
    .no_ip_header_out_dout(no_ip_header_out_dout),
    .no_ip_header_out_empty_n(no_ip_header_out_empty_n),
    .no_ip_header_out_read(handle_output_U0_no_ip_header_out_read),
    .ip_header_checksum_dout(ip_header_checksum_dout),
    .ip_header_checksum_empty_n(ip_header_checksum_empty_n),
    .ip_header_checksum_read(handle_output_U0_ip_header_checksum_read),
    .arpTableReplay_TVALID(arpTableReplay_TVALID),
    .dataOut_TREADY(dataOut_TREADY),
    .arpTableReplay_TDATA(arpTableReplay_TDATA),
    .arpTableReplay_TREADY(handle_output_U0_arpTableReplay_TREADY),
    .dataOut_TDATA(handle_output_U0_dataOut_TDATA),
    .dataOut_TVALID(handle_output_U0_dataOut_TVALID),
    .dataOut_TKEEP(handle_output_U0_dataOut_TKEEP),
    .dataOut_TSTRB(handle_output_U0_dataOut_TSTRB),
    .dataOut_TLAST(handle_output_U0_dataOut_TLAST)
);

ethernet_header_inserter_fifo_w48_d4_S myMacAddress_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(entry_proc_U0_myMacAddress_c_din),
    .if_full_n(myMacAddress_c_full_n),
    .if_write(entry_proc_U0_myMacAddress_c_write),
    .if_dout(myMacAddress_c_dout),
    .if_empty_n(myMacAddress_c_empty_n),
    .if_read(handle_output_U0_myMacAddress_read)
);

ethernet_header_inserter_fifo_w1024_d16_A ip_header_out_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(broadcaster_and_mac_request_U0_ip_header_out_din),
    .if_full_n(ip_header_out_full_n),
    .if_write(broadcaster_and_mac_request_U0_ip_header_out_write),
    .if_dout(ip_header_out_dout),
    .if_empty_n(ip_header_out_empty_n),
    .if_read(compute_and_insert_ip_checksum_U0_ip_header_out_read)
);

ethernet_header_inserter_fifo_w1024_d16_A no_ip_header_out_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(broadcaster_and_mac_request_U0_no_ip_header_out_din),
    .if_full_n(no_ip_header_out_full_n),
    .if_write(broadcaster_and_mac_request_U0_no_ip_header_out_write),
    .if_dout(no_ip_header_out_dout),
    .if_empty_n(no_ip_header_out_empty_n),
    .if_read(handle_output_U0_no_ip_header_out_read)
);

ethernet_header_inserter_fifo_w1024_d16_A ip_header_checksum_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(compute_and_insert_ip_checksum_U0_ip_header_checksum_din),
    .if_full_n(ip_header_checksum_full_n),
    .if_write(compute_and_insert_ip_checksum_U0_ip_header_checksum_write),
    .if_dout(ip_header_checksum_dout),
    .if_empty_n(ip_header_checksum_empty_n),
    .if_read(handle_output_U0_ip_header_checksum_read)
);

ethernet_header_inserter_start_for_handle_output_U0 start_for_handle_output_U0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_handle_output_U0_din),
    .if_full_n(start_for_handle_output_U0_full_n),
    .if_write(entry_proc_U0_start_write),
    .if_dout(start_for_handle_output_U0_dout),
    .if_empty_n(start_for_handle_output_U0_empty_n),
    .if_read(handle_output_U0_ap_ready)
);

ethernet_header_inserter_start_for_compute_and_insert_ip_checksum_U0 start_for_compute_and_insert_ip_checksum_U0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_compute_and_insert_ip_checksum_U0_din),
    .if_full_n(start_for_compute_and_insert_ip_checksum_U0_full_n),
    .if_write(broadcaster_and_mac_request_U0_start_write),
    .if_dout(start_for_compute_and_insert_ip_checksum_U0_dout),
    .if_empty_n(start_for_compute_and_insert_ip_checksum_U0_empty_n),
    .if_read(compute_and_insert_ip_checksum_U0_ap_ready)
);

assign ap_local_block = 1'b0;

assign ap_local_deadlock = 1'b0;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign arpTableReplay_TREADY = handle_output_U0_arpTableReplay_TREADY;

assign arpTableRequest_TDATA = broadcaster_and_mac_request_U0_arpTableRequest_TDATA;

assign arpTableRequest_TVALID = broadcaster_and_mac_request_U0_arpTableRequest_TVALID;

assign broadcaster_and_mac_request_U0_ap_continue = 1'b1;

assign broadcaster_and_mac_request_U0_ap_start = 1'b1;

assign compute_and_insert_ip_checksum_U0_ap_continue = 1'b1;

assign compute_and_insert_ip_checksum_U0_ap_start = start_for_compute_and_insert_ip_checksum_U0_empty_n;

assign dataIn_TREADY = broadcaster_and_mac_request_U0_dataIn_TREADY;

assign dataOut_TDATA = handle_output_U0_dataOut_TDATA;

assign dataOut_TKEEP = handle_output_U0_dataOut_TKEEP;

assign dataOut_TLAST = handle_output_U0_dataOut_TLAST;

assign dataOut_TSTRB = handle_output_U0_dataOut_TSTRB;

assign dataOut_TVALID = handle_output_U0_dataOut_TVALID;

assign entry_proc_U0_ap_continue = 1'b1;

assign entry_proc_U0_ap_start = 1'b1;

assign handle_output_U0_ap_continue = 1'b1;

assign handle_output_U0_ap_start = start_for_handle_output_U0_empty_n;

assign start_for_compute_and_insert_ip_checksum_U0_din = 1'b1;

assign start_for_handle_output_U0_din = 1'b1;

endmodule //ethernet_header_inserter
