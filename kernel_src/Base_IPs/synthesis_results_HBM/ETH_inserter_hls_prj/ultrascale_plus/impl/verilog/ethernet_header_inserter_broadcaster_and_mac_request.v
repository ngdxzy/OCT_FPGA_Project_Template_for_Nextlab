// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.2 (64-bit)
// Version: 2021.2
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module ethernet_header_inserter_broadcaster_and_mac_request (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        dataIn_TVALID,
        arpTableRequest_TREADY,
        ip_header_out_din,
        ip_header_out_full_n,
        ip_header_out_write,
        no_ip_header_out_din,
        no_ip_header_out_full_n,
        no_ip_header_out_write,
        start_out,
        start_write,
        dataIn_TDATA,
        dataIn_TREADY,
        dataIn_TKEEP,
        dataIn_TSTRB,
        dataIn_TLAST,
        arpTableRequest_TDATA,
        arpTableRequest_TVALID,
        regSubNetMask,
        regDefaultGateway
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   dataIn_TVALID;
input   arpTableRequest_TREADY;
output  [1023:0] ip_header_out_din;
input   ip_header_out_full_n;
output   ip_header_out_write;
output  [1023:0] no_ip_header_out_din;
input   no_ip_header_out_full_n;
output   no_ip_header_out_write;
output   start_out;
output   start_write;
input  [511:0] dataIn_TDATA;
output   dataIn_TREADY;
input  [63:0] dataIn_TKEEP;
input  [63:0] dataIn_TSTRB;
input  [0:0] dataIn_TLAST;
output  [31:0] arpTableRequest_TDATA;
output   arpTableRequest_TVALID;
input  [31:0] regSubNetMask;
input  [31:0] regDefaultGateway;

reg ap_done;
reg ap_idle;
reg ip_header_out_write;
reg no_ip_header_out_write;
reg start_write;

reg    real_start;
reg    start_once_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
reg    internal_ap_ready;
wire   [0:0] tmp_nbreadreq_fu_58_p6;
reg    ap_predicate_op19_read_state1;
reg    ap_predicate_op36_read_state1;
reg    ap_done_reg;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] bmr_fsm_state_load_reg_209;
reg   [0:0] tmp_reg_213;
reg   [0:0] icmp_ln1064_reg_232;
reg    ap_predicate_op45_write_state2;
reg    ap_predicate_op46_write_state2;
reg    ap_predicate_op49_write_state2;
reg    ap_predicate_op52_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
reg   [0:0] bmr_fsm_state_load_reg_209_pp0_iter1_reg;
reg   [0:0] tmp_reg_213_pp0_iter1_reg;
reg   [0:0] icmp_ln1064_reg_232_pp0_iter1_reg;
reg    ap_predicate_op53_write_state3;
reg    ap_predicate_op55_write_state3;
wire    regslice_both_arpTableRequest_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] bmr_fsm_state;
reg    dataIn_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    arpTableRequest_TDATA_blk_n;
reg    ip_header_out_blk_n;
reg    no_ip_header_out_blk_n;
reg   [511:0] reg_129;
reg    ap_block_pp0_stage0_11001;
reg   [63:0] reg_133;
wire   [0:0] grp_fu_125_p1;
reg   [0:0] tmp_last_V_reg_217;
wire   [31:0] dst_ip_addr_V_fu_141_p4;
reg   [31:0] dst_ip_addr_V_reg_222;
reg   [31:0] lhs_V_1_reg_227;
wire   [0:0] icmp_ln1064_fu_163_p2;
reg   [0:0] tmp_last_V_2_reg_236;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] xor_ln1064_fu_151_p2;
wire   [31:0] and_ln1064_fu_157_p2;
wire   [576:0] tmp_32_i_fu_181_p4;
wire   [576:0] tmp_31_i_fu_195_p4;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_dataIn_V_data_V_U_apdone_blk;
wire   [511:0] dataIn_TDATA_int_regslice;
wire    dataIn_TVALID_int_regslice;
reg    dataIn_TREADY_int_regslice;
wire    regslice_both_dataIn_V_data_V_U_ack_in;
wire    regslice_both_dataIn_V_keep_V_U_apdone_blk;
wire   [63:0] dataIn_TKEEP_int_regslice;
wire    regslice_both_dataIn_V_keep_V_U_vld_out;
wire    regslice_both_dataIn_V_keep_V_U_ack_in;
wire    regslice_both_dataIn_V_strb_V_U_apdone_blk;
wire   [63:0] dataIn_TSTRB_int_regslice;
wire    regslice_both_dataIn_V_strb_V_U_vld_out;
wire    regslice_both_dataIn_V_strb_V_U_ack_in;
wire    regslice_both_dataIn_V_last_V_U_apdone_blk;
wire   [0:0] dataIn_TLAST_int_regslice;
wire    regslice_both_dataIn_V_last_V_U_vld_out;
wire    regslice_both_dataIn_V_last_V_U_ack_in;
reg   [31:0] arpTableRequest_TDATA_int_regslice;
reg    arpTableRequest_TVALID_int_regslice;
wire    arpTableRequest_TREADY_int_regslice;
wire    regslice_both_arpTableRequest_U_vld_out;
reg    ap_condition_241;
reg    ap_condition_391;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_done_reg = 1'b0;
#0 bmr_fsm_state = 1'd0;
end

ethernet_header_inserter_regslice_both #(
    .DataWidth( 512 ))
regslice_both_dataIn_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(dataIn_TDATA),
    .vld_in(dataIn_TVALID),
    .ack_in(regslice_both_dataIn_V_data_V_U_ack_in),
    .data_out(dataIn_TDATA_int_regslice),
    .vld_out(dataIn_TVALID_int_regslice),
    .ack_out(dataIn_TREADY_int_regslice),
    .apdone_blk(regslice_both_dataIn_V_data_V_U_apdone_blk)
);

ethernet_header_inserter_regslice_both #(
    .DataWidth( 64 ))
regslice_both_dataIn_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(dataIn_TKEEP),
    .vld_in(dataIn_TVALID),
    .ack_in(regslice_both_dataIn_V_keep_V_U_ack_in),
    .data_out(dataIn_TKEEP_int_regslice),
    .vld_out(regslice_both_dataIn_V_keep_V_U_vld_out),
    .ack_out(dataIn_TREADY_int_regslice),
    .apdone_blk(regslice_both_dataIn_V_keep_V_U_apdone_blk)
);

ethernet_header_inserter_regslice_both #(
    .DataWidth( 64 ))
regslice_both_dataIn_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(dataIn_TSTRB),
    .vld_in(dataIn_TVALID),
    .ack_in(regslice_both_dataIn_V_strb_V_U_ack_in),
    .data_out(dataIn_TSTRB_int_regslice),
    .vld_out(regslice_both_dataIn_V_strb_V_U_vld_out),
    .ack_out(dataIn_TREADY_int_regslice),
    .apdone_blk(regslice_both_dataIn_V_strb_V_U_apdone_blk)
);

ethernet_header_inserter_regslice_both #(
    .DataWidth( 1 ))
regslice_both_dataIn_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(dataIn_TLAST),
    .vld_in(dataIn_TVALID),
    .ack_in(regslice_both_dataIn_V_last_V_U_ack_in),
    .data_out(dataIn_TLAST_int_regslice),
    .vld_out(regslice_both_dataIn_V_last_V_U_vld_out),
    .ack_out(dataIn_TREADY_int_regslice),
    .apdone_blk(regslice_both_dataIn_V_last_V_U_apdone_blk)
);

ethernet_header_inserter_regslice_both #(
    .DataWidth( 32 ))
regslice_both_arpTableRequest_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(arpTableRequest_TDATA_int_regslice),
    .vld_in(arpTableRequest_TVALID_int_regslice),
    .ack_in(arpTableRequest_TREADY_int_regslice),
    .data_out(arpTableRequest_TDATA),
    .vld_out(regslice_both_arpTableRequest_U_vld_out),
    .ack_out(arpTableRequest_TREADY),
    .apdone_blk(regslice_both_arpTableRequest_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= real_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((real_start == 1'b1) & (internal_ap_ready == 1'b0))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_391)) begin
        if (((bmr_fsm_state == 1'd1) & (grp_fu_125_p1 == 1'd1))) begin
            bmr_fsm_state <= 1'd0;
        end else if (((bmr_fsm_state == 1'd0) & (grp_fu_125_p1 == 1'd0))) begin
            bmr_fsm_state <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        bmr_fsm_state_load_reg_209 <= bmr_fsm_state;
        bmr_fsm_state_load_reg_209_pp0_iter1_reg <= bmr_fsm_state_load_reg_209;
        icmp_ln1064_reg_232_pp0_iter1_reg <= icmp_ln1064_reg_232;
        tmp_reg_213 <= tmp_nbreadreq_fu_58_p6;
        tmp_reg_213_pp0_iter1_reg <= tmp_reg_213;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        dst_ip_addr_V_reg_222 <= {{dataIn_TDATA_int_regslice[159:128]}};
        icmp_ln1064_reg_232 <= icmp_ln1064_fu_163_p2;
        lhs_V_1_reg_227 <= regDefaultGateway;
    end
end

always @ (posedge ap_clk) begin
    if ((((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd0) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        reg_129 <= dataIn_TDATA_int_regslice;
        reg_133 <= dataIn_TKEEP_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_last_V_2_reg_236 <= dataIn_TLAST_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd0) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_last_V_reg_217 <= dataIn_TLAST_int_regslice;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_predicate_op46_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op53_write_state3 == 1'b1)))) begin
        arpTableRequest_TDATA_blk_n = arpTableRequest_TREADY_int_regslice;
    end else begin
        arpTableRequest_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_241)) begin
        if ((ap_predicate_op46_write_state2 == 1'b1)) begin
            arpTableRequest_TDATA_int_regslice = dst_ip_addr_V_reg_222;
        end else if ((ap_predicate_op45_write_state2 == 1'b1)) begin
            arpTableRequest_TDATA_int_regslice = lhs_V_1_reg_227;
        end else begin
            arpTableRequest_TDATA_int_regslice = 'bx;
        end
    end else begin
        arpTableRequest_TDATA_int_regslice = 'bx;
    end
end

always @ (*) begin
    if ((((ap_predicate_op46_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_predicate_op45_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        arpTableRequest_TVALID_int_regslice = 1'b1;
    end else begin
        arpTableRequest_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_done_reg == 1'b0) & (ap_predicate_op36_read_state1 == 1'b1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_done_reg == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)))) begin
        dataIn_TDATA_blk_n = dataIn_TVALID_int_regslice;
    end else begin
        dataIn_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((ap_predicate_op36_read_state1 == 1'b1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_predicate_op19_read_state1 == 1'b1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        dataIn_TREADY_int_regslice = 1'b1;
    end else begin
        dataIn_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_predicate_op49_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ip_header_out_blk_n = ip_header_out_full_n;
    end else begin
        ip_header_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op49_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ip_header_out_write = 1'b1;
    end else begin
        ip_header_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_predicate_op52_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        no_ip_header_out_blk_n = no_ip_header_out_full_n;
    end else begin
        no_ip_header_out_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op52_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        no_ip_header_out_write = 1'b1;
    end else begin
        no_ip_header_out_write = 1'b0;
    end
end

always @ (*) begin
    if (((start_full_n == 1'b0) & (start_once_reg == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (start_once_reg == 1'b0))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign and_ln1064_fu_157_p2 = (xor_ln1064_fu_151_p2 & regSubNetMask);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((real_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op36_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_arpTableRequest_U_apdone_blk == 1'b1) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ap_predicate_op49_write_state2 == 1'b1) & (ip_header_out_full_n == 1'b0)) | ((ap_predicate_op46_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op52_write_state2 == 1'b1) & (no_ip_header_out_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((real_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op36_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_arpTableRequest_U_apdone_blk == 1'b1) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((ap_predicate_op49_write_state2 == 1'b1) & (ip_header_out_full_n == 1'b0)) | ((ap_predicate_op46_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op52_write_state2 == 1'b1) & (no_ip_header_out_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((real_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op36_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_arpTableRequest_U_apdone_blk == 1'b1) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((ap_predicate_op49_write_state2 == 1'b1) & (ip_header_out_full_n == 1'b0)) | ((ap_predicate_op46_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op52_write_state2 == 1'b1) & (no_ip_header_out_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_done_reg == 1'b1) | ((ap_predicate_op36_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (dataIn_TVALID_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state2_io = (((ap_predicate_op46_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((ap_predicate_op49_write_state2 == 1'b1) & (ip_header_out_full_n == 1'b0)) | ((ap_predicate_op46_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op45_write_state2 == 1'b1) & (arpTableRequest_TREADY_int_regslice == 1'b0)) | ((ap_predicate_op52_write_state2 == 1'b1) & (no_ip_header_out_full_n == 1'b0)));
end

always @ (*) begin
    ap_block_state3_io = (((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((regslice_both_arpTableRequest_U_apdone_blk == 1'b1) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op55_write_state3 == 1'b1)) | ((arpTableRequest_TREADY_int_regslice == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_condition_241 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

always @ (*) begin
    ap_condition_391 = ((tmp_nbreadreq_fu_58_p6 == 1'd1) & (real_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = real_start;

always @ (*) begin
    ap_predicate_op19_read_state1 = ((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd0));
end

always @ (*) begin
    ap_predicate_op36_read_state1 = ((tmp_nbreadreq_fu_58_p6 == 1'd1) & (bmr_fsm_state == 1'd1));
end

always @ (*) begin
    ap_predicate_op45_write_state2 = ((icmp_ln1064_reg_232 == 1'd0) & (tmp_reg_213 == 1'd1) & (bmr_fsm_state_load_reg_209 == 1'd0));
end

always @ (*) begin
    ap_predicate_op46_write_state2 = ((icmp_ln1064_reg_232 == 1'd1) & (tmp_reg_213 == 1'd1) & (bmr_fsm_state_load_reg_209 == 1'd0));
end

always @ (*) begin
    ap_predicate_op49_write_state2 = ((tmp_reg_213 == 1'd1) & (bmr_fsm_state_load_reg_209 == 1'd0));
end

always @ (*) begin
    ap_predicate_op52_write_state2 = ((tmp_reg_213 == 1'd1) & (bmr_fsm_state_load_reg_209 == 1'd1));
end

always @ (*) begin
    ap_predicate_op53_write_state3 = ((icmp_ln1064_reg_232_pp0_iter1_reg == 1'd0) & (tmp_reg_213_pp0_iter1_reg == 1'd1) & (bmr_fsm_state_load_reg_209_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op55_write_state3 = ((icmp_ln1064_reg_232_pp0_iter1_reg == 1'd1) & (tmp_reg_213_pp0_iter1_reg == 1'd1) & (bmr_fsm_state_load_reg_209_pp0_iter1_reg == 1'd0));
end

assign ap_ready = internal_ap_ready;

assign arpTableRequest_TVALID = regslice_both_arpTableRequest_U_vld_out;

assign dataIn_TREADY = regslice_both_dataIn_V_data_V_U_ack_in;

assign dst_ip_addr_V_fu_141_p4 = {{dataIn_TDATA_int_regslice[159:128]}};

assign grp_fu_125_p1 = dataIn_TLAST_int_regslice;

assign icmp_ln1064_fu_163_p2 = ((and_ln1064_fu_157_p2 == 32'd0) ? 1'b1 : 1'b0);

assign ip_header_out_din = tmp_32_i_fu_181_p4;

assign no_ip_header_out_din = tmp_31_i_fu_195_p4;

assign start_out = real_start;

assign tmp_31_i_fu_195_p4 = {{{tmp_last_V_2_reg_236}, {reg_133}}, {reg_129}};

assign tmp_32_i_fu_181_p4 = {{{tmp_last_V_reg_217}, {reg_133}}, {reg_129}};

assign tmp_nbreadreq_fu_58_p6 = dataIn_TVALID_int_regslice;

assign xor_ln1064_fu_151_p2 = (regDefaultGateway ^ dst_ip_addr_V_fu_141_p4);

endmodule //ethernet_header_inserter_broadcaster_and_mac_request
