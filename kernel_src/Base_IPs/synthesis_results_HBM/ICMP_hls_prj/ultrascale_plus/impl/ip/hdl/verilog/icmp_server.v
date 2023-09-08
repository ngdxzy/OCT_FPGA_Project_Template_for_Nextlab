// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.2 (64-bit)
// Version: 2021.2
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="icmp_server_icmp_server,hls_ip_2021_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu280-fsvh2892-2L-e,HLS_INPUT_CLOCK=3.100000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=2.372813,HLS_SYN_LAT=2,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1481,HLS_SYN_LUT=568,HLS_VERSION=2021_2}" *)

module icmp_server (
        ap_local_block,
        ap_local_deadlock,
        ap_clk,
        ap_rst_n,
        s_axis_icmp_TDATA,
        s_axis_icmp_TVALID,
        s_axis_icmp_TREADY,
        s_axis_icmp_TKEEP,
        s_axis_icmp_TSTRB,
        s_axis_icmp_TLAST,
        myIpAddress,
        m_axis_icmp_TDATA,
        m_axis_icmp_TVALID,
        m_axis_icmp_TREADY,
        m_axis_icmp_TKEEP,
        m_axis_icmp_TSTRB,
        m_axis_icmp_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

output   ap_local_block;
output   ap_local_deadlock;
input   ap_clk;
input   ap_rst_n;
input  [511:0] s_axis_icmp_TDATA;
input   s_axis_icmp_TVALID;
output   s_axis_icmp_TREADY;
input  [63:0] s_axis_icmp_TKEEP;
input  [63:0] s_axis_icmp_TSTRB;
input  [0:0] s_axis_icmp_TLAST;
input  [31:0] myIpAddress;
output  [511:0] m_axis_icmp_TDATA;
output   m_axis_icmp_TVALID;
input   m_axis_icmp_TREADY;
output  [63:0] m_axis_icmp_TKEEP;
output  [63:0] m_axis_icmp_TSTRB;
output  [0:0] m_axis_icmp_TLAST;

 reg    ap_rst_n_inv;
reg   [31:0] myIpAddress_0_data_reg;
reg    myIpAddress_0_vld_reg;
reg    myIpAddress_0_ack_out;
reg   [2:0] aiFSMState;
reg   [31:0] ipDestination_V;
reg   [7:0] icmpType_V;
reg   [7:0] icmpCode_V;
reg   [15:0] auxInchecksum_r_V;
reg   [0:0] prevWord_last_V;
reg   [16:0] icmpChecksum_V;
reg   [511:0] prevWord_data_V;
reg   [63:0] prevWord_keep_V;
reg   [63:0] prevWord_strb_V;
reg    s_axis_icmp_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
wire   [0:0] grp_nbreadreq_fu_212_p6;
reg    m_axis_icmp_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [2:0] aiFSMState_load_reg_1142;
reg    ap_enable_reg_pp0_iter2;
reg   [2:0] aiFSMState_load_reg_1142_pp0_iter1_reg;
reg   [0:0] tmp_1_reg_1172;
reg   [0:0] tmp_1_reg_1172_pp0_iter1_reg;
reg    ap_predicate_op12_read_state1;
reg    ap_predicate_op26_read_state1;
reg    ap_predicate_op38_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_predicate_op161_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
reg    ap_predicate_op181_write_state3;
wire    regslice_both_m_axis_icmp_V_data_V_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [31:0] ipDestination_V_load_reg_1146;
reg   [0:0] currWord_last_V_reg_1151;
wire   [0:0] icmp_ln1064_1_fu_316_p2;
reg   [0:0] icmp_ln1064_1_reg_1162;
wire   [0:0] icmp_ln1064_2_fu_322_p2;
reg   [0:0] icmp_ln1064_2_reg_1167;
reg   [511:0] tmp_data_V_3_reg_1176;
reg   [63:0] tmp_keep_V_3_reg_1181;
reg   [63:0] tmp_strb_V_3_reg_1186;
wire   [0:0] grp_fu_260_p1;
reg   [0:0] tmp_last_V_3_reg_1191;
reg   [0:0] tmp_reg_1196;
wire   [16:0] ret_14_fu_764_p2;
reg   [16:0] ret_14_reg_1200;
wire   [18:0] ret_17_fu_806_p2;
reg   [18:0] ret_17_reg_1205;
wire   [511:0] p_Result_35_fu_1000_p5;
reg    ap_block_pp0_stage0_subdone;
wire   [2:0] select_ln170_fu_1040_p3;
wire   [2:0] select_ln202_fu_302_p3;
reg   [2:0] ap_sig_allocacmp_aiFSMState_load;
wire   [15:0] checksum_fu_1130_p2;
wire   [16:0] add_ln326_fu_680_p2;
reg    ap_block_pp0_stage0_01001;
wire   [7:0] trunc_ln674_1_fu_334_p1;
wire   [7:0] p_Result_9_fu_338_p4;
wire   [7:0] p_Result_10_fu_356_p4;
wire   [7:0] p_Result_11_fu_366_p4;
wire   [7:0] p_Result_12_fu_384_p4;
wire   [7:0] p_Result_13_fu_394_p4;
wire   [7:0] p_Result_14_fu_412_p4;
wire   [7:0] p_Result_15_fu_422_p4;
wire   [7:0] p_Result_16_fu_440_p4;
wire   [7:0] p_Result_17_fu_450_p4;
wire   [7:0] p_Result_18_fu_468_p4;
wire   [7:0] p_Result_19_fu_478_p4;
wire   [7:0] p_Result_20_fu_496_p4;
wire   [7:0] p_Result_21_fu_506_p4;
wire   [7:0] p_Result_22_fu_524_p4;
wire   [7:0] p_Result_23_fu_534_p4;
wire   [7:0] p_Result_24_fu_552_p4;
wire   [7:0] p_Result_25_fu_562_p4;
wire   [7:0] p_Result_32_fu_658_p4;
wire   [7:0] p_Result_31_fu_648_p4;
wire   [15:0] tmp_s_fu_668_p3;
wire   [16:0] zext_ln326_fu_676_p1;
wire   [7:0] p_Result_26_fu_580_p4;
wire   [7:0] p_Result_27_fu_590_p4;
wire   [15:0] checksumL0_V_fu_692_p3;
wire   [15:0] checksumL0_V_10_fu_572_p3;
wire   [16:0] zext_ln232_1_fu_704_p1;
wire   [16:0] zext_ln232_fu_700_p1;
wire   [15:0] checksumL0_V_11_fu_544_p3;
wire   [15:0] checksumL0_V_12_fu_516_p3;
wire   [16:0] zext_ln232_3_fu_718_p1;
wire   [16:0] zext_ln232_2_fu_714_p1;
wire   [15:0] checksumL0_V_13_fu_488_p3;
wire   [15:0] checksumL0_V_14_fu_460_p3;
wire   [16:0] zext_ln232_5_fu_732_p1;
wire   [16:0] zext_ln232_4_fu_728_p1;
wire   [15:0] checksumL0_V_15_fu_432_p3;
wire   [15:0] checksumL0_V_16_fu_404_p3;
wire   [16:0] zext_ln232_7_fu_746_p1;
wire   [16:0] zext_ln232_6_fu_742_p1;
wire   [15:0] checksumL0_V_17_fu_376_p3;
wire   [15:0] checksumL0_V_18_fu_348_p3;
wire   [16:0] zext_ln232_9_fu_760_p1;
wire   [16:0] zext_ln232_8_fu_756_p1;
wire   [16:0] ret_10_fu_708_p2;
wire   [16:0] ret_11_fu_722_p2;
wire   [17:0] zext_ln232_11_fu_774_p1;
wire   [17:0] zext_ln232_10_fu_770_p1;
wire   [16:0] ret_12_fu_736_p2;
wire   [16:0] ret_13_fu_750_p2;
wire   [17:0] zext_ln232_13_fu_788_p1;
wire   [17:0] zext_ln232_12_fu_784_p1;
wire   [17:0] ret_15_fu_778_p2;
wire   [17:0] ret_16_fu_792_p2;
wire   [18:0] zext_ln232_15_fu_802_p1;
wire   [18:0] zext_ln232_14_fu_798_p1;
wire   [511:0] p_Result_1_fu_860_p5;
wire   [511:0] p_Result_3_fu_872_p5;
wire   [511:0] p_Result_4_fu_884_p5;
wire   [31:0] p_Result_s_26_fu_896_p4;
wire   [511:0] p_Result_5_fu_906_p5;
wire   [31:0] p_Result_2_fu_918_p4;
wire   [0:0] tmp_4_fu_948_p3;
wire   [15:0] zext_ln223_2_fu_956_p1;
wire   [15:0] p_Result_8_fu_944_p1;
wire   [511:0] p_Result_7_fu_928_p5;
wire   [15:0] icmpChecksumTmp_V_fu_960_p2;
wire   [7:0] trunc_ln674_fu_988_p1;
wire   [7:0] p_Result_6_fu_978_p4;
wire   [511:0] p_Result_34_fu_966_p5;
wire   [15:0] tmp_3_fu_992_p3;
wire   [0:0] icmp_ln1064_fu_1013_p2;
wire   [0:0] icmp_ln1064_3_fu_1018_p2;
wire   [0:0] and_ln170_1_fu_1029_p2;
wire   [0:0] and_ln170_fu_1024_p2;
wire   [0:0] and_ln170_2_fu_1034_p2;
wire   [19:0] zext_ln232_16_fu_1054_p1;
wire   [19:0] zext_ln232_17_fu_1057_p1;
wire   [19:0] ret_18_fu_1060_p2;
wire   [15:0] trunc_ln357_fu_1066_p1;
wire   [3:0] p_Result_33_fu_1070_p4;
wire   [16:0] zext_ln223_fu_1080_p1;
wire   [16:0] zext_ln223_1_fu_1084_p1;
wire   [15:0] zext_ln223_3_fu_1088_p1;
wire   [15:0] add_ln45_fu_1098_p2;
wire   [16:0] checksumL4_r_V_fu_1092_p2;
wire   [0:0] p_Result_s_fu_1110_p3;
wire   [15:0] checksumL4_o_V_fu_1104_p2;
wire   [15:0] trunc_ln649_fu_1118_p1;
wire   [15:0] select_ln819_fu_1122_p3;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_s_axis_icmp_V_data_V_U_apdone_blk;
wire   [511:0] s_axis_icmp_TDATA_int_regslice;
wire    s_axis_icmp_TVALID_int_regslice;
reg    s_axis_icmp_TREADY_int_regslice;
wire    regslice_both_s_axis_icmp_V_data_V_U_ack_in;
wire    regslice_both_s_axis_icmp_V_keep_V_U_apdone_blk;
wire   [63:0] s_axis_icmp_TKEEP_int_regslice;
wire    regslice_both_s_axis_icmp_V_keep_V_U_vld_out;
wire    regslice_both_s_axis_icmp_V_keep_V_U_ack_in;
wire    regslice_both_s_axis_icmp_V_strb_V_U_apdone_blk;
wire   [63:0] s_axis_icmp_TSTRB_int_regslice;
wire    regslice_both_s_axis_icmp_V_strb_V_U_vld_out;
wire    regslice_both_s_axis_icmp_V_strb_V_U_ack_in;
wire    regslice_both_s_axis_icmp_V_last_V_U_apdone_blk;
wire   [0:0] s_axis_icmp_TLAST_int_regslice;
wire    regslice_both_s_axis_icmp_V_last_V_U_vld_out;
wire    regslice_both_s_axis_icmp_V_last_V_U_ack_in;
reg   [511:0] m_axis_icmp_TDATA_int_regslice;
reg    m_axis_icmp_TVALID_int_regslice;
wire    m_axis_icmp_TREADY_int_regslice;
wire    regslice_both_m_axis_icmp_V_data_V_U_vld_out;
wire    regslice_both_m_axis_icmp_V_keep_V_U_apdone_blk;
reg   [63:0] m_axis_icmp_TKEEP_int_regslice;
wire    regslice_both_m_axis_icmp_V_keep_V_U_ack_in_dummy;
wire    regslice_both_m_axis_icmp_V_keep_V_U_vld_out;
wire    regslice_both_m_axis_icmp_V_strb_V_U_apdone_blk;
reg   [63:0] m_axis_icmp_TSTRB_int_regslice;
wire    regslice_both_m_axis_icmp_V_strb_V_U_ack_in_dummy;
wire    regslice_both_m_axis_icmp_V_strb_V_U_vld_out;
wire    regslice_both_m_axis_icmp_V_last_V_U_apdone_blk;
reg   [0:0] m_axis_icmp_TLAST_int_regslice;
wire    regslice_both_m_axis_icmp_V_last_V_U_ack_in_dummy;
wire    regslice_both_m_axis_icmp_V_last_V_U_vld_out;
reg    ap_condition_901;
reg    ap_condition_906;
reg    ap_condition_911;
reg    ap_condition_292;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 myIpAddress_0_data_reg = 32'd0;
#0 myIpAddress_0_vld_reg = 1'b0;
#0 aiFSMState = 3'd0;
#0 ipDestination_V = 32'd0;
#0 icmpType_V = 8'd0;
#0 icmpCode_V = 8'd0;
#0 auxInchecksum_r_V = 16'd0;
#0 prevWord_last_V = 1'd0;
#0 icmpChecksum_V = 17'd0;
#0 prevWord_data_V = 512'd0;
#0 prevWord_keep_V = 64'd0;
#0 prevWord_strb_V = 64'd0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
end

icmp_server_regslice_both #(
    .DataWidth( 512 ))
regslice_both_s_axis_icmp_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(s_axis_icmp_TDATA),
    .vld_in(s_axis_icmp_TVALID),
    .ack_in(regslice_both_s_axis_icmp_V_data_V_U_ack_in),
    .data_out(s_axis_icmp_TDATA_int_regslice),
    .vld_out(s_axis_icmp_TVALID_int_regslice),
    .ack_out(s_axis_icmp_TREADY_int_regslice),
    .apdone_blk(regslice_both_s_axis_icmp_V_data_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 64 ))
regslice_both_s_axis_icmp_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(s_axis_icmp_TKEEP),
    .vld_in(s_axis_icmp_TVALID),
    .ack_in(regslice_both_s_axis_icmp_V_keep_V_U_ack_in),
    .data_out(s_axis_icmp_TKEEP_int_regslice),
    .vld_out(regslice_both_s_axis_icmp_V_keep_V_U_vld_out),
    .ack_out(s_axis_icmp_TREADY_int_regslice),
    .apdone_blk(regslice_both_s_axis_icmp_V_keep_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 64 ))
regslice_both_s_axis_icmp_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(s_axis_icmp_TSTRB),
    .vld_in(s_axis_icmp_TVALID),
    .ack_in(regslice_both_s_axis_icmp_V_strb_V_U_ack_in),
    .data_out(s_axis_icmp_TSTRB_int_regslice),
    .vld_out(regslice_both_s_axis_icmp_V_strb_V_U_vld_out),
    .ack_out(s_axis_icmp_TREADY_int_regslice),
    .apdone_blk(regslice_both_s_axis_icmp_V_strb_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 1 ))
regslice_both_s_axis_icmp_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(s_axis_icmp_TLAST),
    .vld_in(s_axis_icmp_TVALID),
    .ack_in(regslice_both_s_axis_icmp_V_last_V_U_ack_in),
    .data_out(s_axis_icmp_TLAST_int_regslice),
    .vld_out(regslice_both_s_axis_icmp_V_last_V_U_vld_out),
    .ack_out(s_axis_icmp_TREADY_int_regslice),
    .apdone_blk(regslice_both_s_axis_icmp_V_last_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 512 ))
regslice_both_m_axis_icmp_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TDATA_int_regslice),
    .vld_in(m_axis_icmp_TVALID_int_regslice),
    .ack_in(m_axis_icmp_TREADY_int_regslice),
    .data_out(m_axis_icmp_TDATA),
    .vld_out(regslice_both_m_axis_icmp_V_data_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_data_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 64 ))
regslice_both_m_axis_icmp_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TKEEP_int_regslice),
    .vld_in(m_axis_icmp_TVALID_int_regslice),
    .ack_in(regslice_both_m_axis_icmp_V_keep_V_U_ack_in_dummy),
    .data_out(m_axis_icmp_TKEEP),
    .vld_out(regslice_both_m_axis_icmp_V_keep_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_keep_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 64 ))
regslice_both_m_axis_icmp_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TSTRB_int_regslice),
    .vld_in(m_axis_icmp_TVALID_int_regslice),
    .ack_in(regslice_both_m_axis_icmp_V_strb_V_U_ack_in_dummy),
    .data_out(m_axis_icmp_TSTRB),
    .vld_out(regslice_both_m_axis_icmp_V_strb_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_strb_V_U_apdone_blk)
);

icmp_server_regslice_both #(
    .DataWidth( 1 ))
regslice_both_m_axis_icmp_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(m_axis_icmp_TLAST_int_regslice),
    .vld_in(m_axis_icmp_TVALID_int_regslice),
    .ack_in(regslice_both_m_axis_icmp_V_last_V_U_ack_in_dummy),
    .data_out(m_axis_icmp_TLAST),
    .vld_out(regslice_both_m_axis_icmp_V_last_V_U_vld_out),
    .ack_out(m_axis_icmp_TREADY),
    .apdone_blk(regslice_both_m_axis_icmp_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if ((1'b1 == ap_condition_911)) begin
            aiFSMState <= 3'd1;
        end else if ((1'b1 == ap_condition_906)) begin
            aiFSMState <= 3'd0;
        end else if (((ap_sig_allocacmp_aiFSMState_load == 3'd2) & (1'b1 == 1'b1))) begin
            aiFSMState <= select_ln202_fu_302_p3;
        end else if ((1'b1 == ap_condition_901)) begin
            aiFSMState <= 3'd0;
        end else if (((3'd1 == aiFSMState_load_reg_1142) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
            aiFSMState <= select_ln170_fu_1040_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        aiFSMState_load_reg_1142 <= ap_sig_allocacmp_aiFSMState_load;
        aiFSMState_load_reg_1142_pp0_iter1_reg <= aiFSMState_load_reg_1142;
        currWord_last_V_reg_1151 <= prevWord_last_V;
        ipDestination_V_load_reg_1146 <= ipDestination_V;
        tmp_1_reg_1172_pp0_iter1_reg <= tmp_1_reg_1172;
    end
end

always @ (posedge ap_clk) begin
    if ((~(3'd4 == aiFSMState_load_reg_1142) & ~(3'd1 == aiFSMState_load_reg_1142) & ~(3'd3 == aiFSMState_load_reg_1142) & ~(3'd2 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (tmp_reg_1196 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        auxInchecksum_r_V <= checksum_fu_1130_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (grp_nbreadreq_fu_212_p6 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmpChecksum_V <= add_ln326_fu_680_p2;
        icmpCode_V <= {{s_axis_icmp_TDATA_int_regslice[175:168]}};
        icmpType_V <= {{s_axis_icmp_TDATA_int_regslice[167:160]}};
        ipDestination_V <= {{s_axis_icmp_TDATA_int_regslice[159:128]}};
        prevWord_data_V <= s_axis_icmp_TDATA_int_regslice;
        prevWord_keep_V <= s_axis_icmp_TKEEP_int_regslice;
        prevWord_last_V <= s_axis_icmp_TLAST_int_regslice;
        prevWord_strb_V <= s_axis_icmp_TSTRB_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_sig_allocacmp_aiFSMState_load == 3'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1064_1_reg_1162 <= icmp_ln1064_1_fu_316_p2;
        icmp_ln1064_2_reg_1167 <= icmp_ln1064_2_fu_322_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((((myIpAddress_0_ack_out == 1'b1) & (1'b1 == 1'b1) & (myIpAddress_0_vld_reg == 1'b1)) | ((1'b1 == 1'b1) & (myIpAddress_0_vld_reg == 1'b0)))) begin
        myIpAddress_0_data_reg <= myIpAddress;
    end
end

always @ (posedge ap_clk) begin
    if ((~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (grp_nbreadreq_fu_212_p6 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ret_14_reg_1200 <= ret_14_fu_764_p2;
        ret_17_reg_1205 <= ret_17_fu_806_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_sig_allocacmp_aiFSMState_load == 3'd3) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_1_reg_1172 <= grp_nbreadreq_fu_212_p6;
    end
end

always @ (posedge ap_clk) begin
    if (((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd3) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_data_V_3_reg_1176 <= s_axis_icmp_TDATA_int_regslice;
        tmp_keep_V_3_reg_1181 <= s_axis_icmp_TKEEP_int_regslice;
        tmp_last_V_3_reg_1191 <= s_axis_icmp_TLAST_int_regslice;
        tmp_strb_V_3_reg_1186 <= s_axis_icmp_TSTRB_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if ((~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_1196 <= grp_nbreadreq_fu_212_p6;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((3'd1 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1))) begin
        ap_sig_allocacmp_aiFSMState_load = select_ln170_fu_1040_p3;
    end else begin
        ap_sig_allocacmp_aiFSMState_load = aiFSMState;
    end
end

always @ (*) begin
    if ((((3'd3 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (1'b0 == ap_block_pp0_stage0) & (tmp_1_reg_1172_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((3'd3 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (tmp_1_reg_1172 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1)))) begin
        m_axis_icmp_TDATA_blk_n = m_axis_icmp_TREADY_int_regslice;
    end else begin
        m_axis_icmp_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_292)) begin
        if ((ap_predicate_op161_write_state2 == 1'b1)) begin
            m_axis_icmp_TDATA_int_regslice = tmp_data_V_3_reg_1176;
        end else if ((3'd2 == aiFSMState_load_reg_1142)) begin
            m_axis_icmp_TDATA_int_regslice = p_Result_35_fu_1000_p5;
        end else begin
            m_axis_icmp_TDATA_int_regslice = 'bx;
        end
    end else begin
        m_axis_icmp_TDATA_int_regslice = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_292)) begin
        if ((ap_predicate_op161_write_state2 == 1'b1)) begin
            m_axis_icmp_TKEEP_int_regslice = tmp_keep_V_3_reg_1181;
        end else if ((3'd2 == aiFSMState_load_reg_1142)) begin
            m_axis_icmp_TKEEP_int_regslice = prevWord_keep_V;
        end else begin
            m_axis_icmp_TKEEP_int_regslice = 'bx;
        end
    end else begin
        m_axis_icmp_TKEEP_int_regslice = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_292)) begin
        if ((ap_predicate_op161_write_state2 == 1'b1)) begin
            m_axis_icmp_TLAST_int_regslice = tmp_last_V_3_reg_1191;
        end else if ((3'd2 == aiFSMState_load_reg_1142)) begin
            m_axis_icmp_TLAST_int_regslice = currWord_last_V_reg_1151;
        end else begin
            m_axis_icmp_TLAST_int_regslice = 'bx;
        end
    end else begin
        m_axis_icmp_TLAST_int_regslice = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_292)) begin
        if ((ap_predicate_op161_write_state2 == 1'b1)) begin
            m_axis_icmp_TSTRB_int_regslice = tmp_strb_V_3_reg_1186;
        end else if ((3'd2 == aiFSMState_load_reg_1142)) begin
            m_axis_icmp_TSTRB_int_regslice = prevWord_strb_V;
        end else begin
            m_axis_icmp_TSTRB_int_regslice = 'bx;
        end
    end else begin
        m_axis_icmp_TSTRB_int_regslice = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op161_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1)))) begin
        m_axis_icmp_TVALID_int_regslice = 1'b1;
    end else begin
        m_axis_icmp_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if ((((3'd1 == aiFSMState_load_reg_1142) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        myIpAddress_0_ack_out = 1'b1;
    end else begin
        myIpAddress_0_ack_out = 1'b0;
    end
end

always @ (*) begin
    if ((((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd4) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd3) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (grp_nbreadreq_fu_212_p6 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        s_axis_icmp_TDATA_blk_n = s_axis_icmp_TVALID_int_regslice;
    end else begin
        s_axis_icmp_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op38_read_state1 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op26_read_state1 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op12_read_state1 == 1'b1)))) begin
        s_axis_icmp_TREADY_int_regslice = 1'b1;
    end else begin
        s_axis_icmp_TREADY_int_regslice = 1'b0;
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

assign add_ln326_fu_680_p2 = (zext_ln326_fu_676_p1 + 17'd2048);

assign add_ln45_fu_1098_p2 = (trunc_ln357_fu_1066_p1 + zext_ln223_3_fu_1088_p1);

assign and_ln170_1_fu_1029_p2 = (icmp_ln1064_3_fu_1018_p2 & icmp_ln1064_2_reg_1167);

assign and_ln170_2_fu_1034_p2 = (and_ln170_fu_1024_p2 & and_ln170_1_fu_1029_p2);

assign and_ln170_fu_1024_p2 = (icmp_ln1064_fu_1013_p2 & icmp_ln1064_1_reg_1162);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((1'b1 == 1'b1) & (((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op38_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op26_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op181_write_state3 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op161_write_state2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((1'b1 == 1'b1) & (((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op38_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op26_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op181_write_state3 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op161_write_state2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((1'b1 == 1'b1) & (((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op38_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op26_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op181_write_state3 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op161_write_state2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (m_axis_icmp_TREADY_int_regslice == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op38_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op26_read_state1 == 1'b1)) | ((s_axis_icmp_TVALID_int_regslice == 1'b0) & (ap_predicate_op12_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = (((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op161_write_state2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (m_axis_icmp_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op161_write_state2 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142) & (m_axis_icmp_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state3_io = (((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op181_write_state3 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (m_axis_icmp_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((regslice_both_m_axis_icmp_V_data_V_U_apdone_blk == 1'b1) | ((m_axis_icmp_TREADY_int_regslice == 1'b0) & (ap_predicate_op181_write_state3 == 1'b1)) | ((3'd2 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (m_axis_icmp_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_condition_292 = ((1'b0 == ap_block_pp0_stage0_01001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_condition_901 = ((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd4) & (1'b1 == 1'b1) & (grp_fu_260_p1 == 1'd1));
end

always @ (*) begin
    ap_condition_906 = ((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd3) & (1'b1 == 1'b1) & (grp_fu_260_p1 == 1'd1));
end

always @ (*) begin
    ap_condition_911 = (~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (grp_nbreadreq_fu_212_p6 == 1'd1) & (1'b1 == 1'b1));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);


assign ap_local_deadlock = 1'b0;

always @ (*) begin
    ap_predicate_op12_read_state1 = ((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd4));
end

always @ (*) begin
    ap_predicate_op161_write_state2 = ((3'd3 == aiFSMState_load_reg_1142) & (tmp_1_reg_1172 == 1'd1));
end

always @ (*) begin
    ap_predicate_op181_write_state3 = ((3'd3 == aiFSMState_load_reg_1142_pp0_iter1_reg) & (tmp_1_reg_1172_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op26_read_state1 = ((grp_nbreadreq_fu_212_p6 == 1'd1) & (ap_sig_allocacmp_aiFSMState_load == 3'd3));
end

always @ (*) begin
    ap_predicate_op38_read_state1 = (~(ap_sig_allocacmp_aiFSMState_load == 3'd4) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd2) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd1) & ~(ap_sig_allocacmp_aiFSMState_load == 3'd3) & (grp_nbreadreq_fu_212_p6 == 1'd1));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign checksumL0_V_10_fu_572_p3 = {{p_Result_24_fu_552_p4}, {p_Result_25_fu_562_p4}};

assign checksumL0_V_11_fu_544_p3 = {{p_Result_22_fu_524_p4}, {p_Result_23_fu_534_p4}};

assign checksumL0_V_12_fu_516_p3 = {{p_Result_20_fu_496_p4}, {p_Result_21_fu_506_p4}};

assign checksumL0_V_13_fu_488_p3 = {{p_Result_18_fu_468_p4}, {p_Result_19_fu_478_p4}};

assign checksumL0_V_14_fu_460_p3 = {{p_Result_16_fu_440_p4}, {p_Result_17_fu_450_p4}};

assign checksumL0_V_15_fu_432_p3 = {{p_Result_14_fu_412_p4}, {p_Result_15_fu_422_p4}};

assign checksumL0_V_16_fu_404_p3 = {{p_Result_12_fu_384_p4}, {p_Result_13_fu_394_p4}};

assign checksumL0_V_17_fu_376_p3 = {{p_Result_10_fu_356_p4}, {p_Result_11_fu_366_p4}};

assign checksumL0_V_18_fu_348_p3 = {{trunc_ln674_1_fu_334_p1}, {p_Result_9_fu_338_p4}};

assign checksumL0_V_fu_692_p3 = {{p_Result_26_fu_580_p4}, {p_Result_27_fu_590_p4}};

assign checksumL4_o_V_fu_1104_p2 = (add_ln45_fu_1098_p2 + 16'd1);

assign checksumL4_r_V_fu_1092_p2 = (zext_ln223_fu_1080_p1 + zext_ln223_1_fu_1084_p1);

assign checksum_fu_1130_p2 = (select_ln819_fu_1122_p3 ^ 16'd65535);

assign grp_fu_260_p1 = s_axis_icmp_TLAST_int_regslice;

assign grp_nbreadreq_fu_212_p6 = s_axis_icmp_TVALID_int_regslice;

assign icmpChecksumTmp_V_fu_960_p2 = (zext_ln223_2_fu_956_p1 + p_Result_8_fu_944_p1);

assign icmp_ln1064_1_fu_316_p2 = ((icmpType_V == 8'd8) ? 1'b1 : 1'b0);

assign icmp_ln1064_2_fu_322_p2 = ((icmpCode_V == 8'd0) ? 1'b1 : 1'b0);

assign icmp_ln1064_3_fu_1018_p2 = ((auxInchecksum_r_V == 16'd0) ? 1'b1 : 1'b0);

assign icmp_ln1064_fu_1013_p2 = ((ipDestination_V_load_reg_1146 == myIpAddress_0_data_reg) ? 1'b1 : 1'b0);

assign m_axis_icmp_TVALID = regslice_both_m_axis_icmp_V_data_V_U_vld_out;

assign p_Result_10_fu_356_p4 = {{s_axis_icmp_TDATA_int_regslice[23:16]}};

assign p_Result_11_fu_366_p4 = {{s_axis_icmp_TDATA_int_regslice[31:24]}};

assign p_Result_12_fu_384_p4 = {{s_axis_icmp_TDATA_int_regslice[39:32]}};

assign p_Result_13_fu_394_p4 = {{s_axis_icmp_TDATA_int_regslice[47:40]}};

assign p_Result_14_fu_412_p4 = {{s_axis_icmp_TDATA_int_regslice[55:48]}};

assign p_Result_15_fu_422_p4 = {{s_axis_icmp_TDATA_int_regslice[63:56]}};

assign p_Result_16_fu_440_p4 = {{s_axis_icmp_TDATA_int_regslice[71:64]}};

assign p_Result_17_fu_450_p4 = {{s_axis_icmp_TDATA_int_regslice[79:72]}};

assign p_Result_18_fu_468_p4 = {{s_axis_icmp_TDATA_int_regslice[87:80]}};

assign p_Result_19_fu_478_p4 = {{s_axis_icmp_TDATA_int_regslice[95:88]}};

assign p_Result_1_fu_860_p5 = {{prevWord_data_V[511:72]}, {8'd128}, {prevWord_data_V[63:0]}};

assign p_Result_20_fu_496_p4 = {{s_axis_icmp_TDATA_int_regslice[103:96]}};

assign p_Result_21_fu_506_p4 = {{s_axis_icmp_TDATA_int_regslice[111:104]}};

assign p_Result_22_fu_524_p4 = {{s_axis_icmp_TDATA_int_regslice[119:112]}};

assign p_Result_23_fu_534_p4 = {{s_axis_icmp_TDATA_int_regslice[127:120]}};

assign p_Result_24_fu_552_p4 = {{s_axis_icmp_TDATA_int_regslice[135:128]}};

assign p_Result_25_fu_562_p4 = {{s_axis_icmp_TDATA_int_regslice[143:136]}};

assign p_Result_26_fu_580_p4 = {{s_axis_icmp_TDATA_int_regslice[151:144]}};

assign p_Result_27_fu_590_p4 = {{s_axis_icmp_TDATA_int_regslice[159:152]}};

assign p_Result_2_fu_918_p4 = {{prevWord_data_V[127:96]}};

assign p_Result_31_fu_648_p4 = {{s_axis_icmp_TDATA_int_regslice[191:184]}};

assign p_Result_32_fu_658_p4 = {{s_axis_icmp_TDATA_int_regslice[183:176]}};

assign p_Result_33_fu_1070_p4 = {{ret_18_fu_1060_p2[19:16]}};

assign p_Result_34_fu_966_p5 = {{p_Result_7_fu_928_p5[511:168]}, {8'd0}, {p_Result_7_fu_928_p5[159:0]}};

assign p_Result_35_fu_1000_p5 = {{p_Result_34_fu_966_p5[511:192]}, {tmp_3_fu_992_p3}, {p_Result_34_fu_966_p5[175:0]}};

assign p_Result_3_fu_872_p5 = {{p_Result_1_fu_860_p5[511:96]}, {24'd1}, {p_Result_1_fu_860_p5[71:0]}};

assign p_Result_4_fu_884_p5 = {{p_Result_3_fu_872_p5[511:96]}, {16'd0}, {p_Result_3_fu_872_p5[79:0]}};

assign p_Result_5_fu_906_p5 = {{p_Result_4_fu_884_p5[511:128]}, {p_Result_s_26_fu_896_p4}, {p_Result_4_fu_884_p5[95:0]}};

assign p_Result_6_fu_978_p4 = {{icmpChecksumTmp_V_fu_960_p2[15:8]}};

assign p_Result_7_fu_928_p5 = {{p_Result_5_fu_906_p5[511:160]}, {p_Result_2_fu_918_p4}, {p_Result_5_fu_906_p5[127:0]}};

assign p_Result_8_fu_944_p1 = icmpChecksum_V[15:0];

assign p_Result_9_fu_338_p4 = {{s_axis_icmp_TDATA_int_regslice[15:8]}};

assign p_Result_s_26_fu_896_p4 = {{prevWord_data_V[159:128]}};

assign p_Result_s_fu_1110_p3 = checksumL4_r_V_fu_1092_p2[32'd16];

assign ret_10_fu_708_p2 = (zext_ln232_1_fu_704_p1 + zext_ln232_fu_700_p1);

assign ret_11_fu_722_p2 = (zext_ln232_3_fu_718_p1 + zext_ln232_2_fu_714_p1);

assign ret_12_fu_736_p2 = (zext_ln232_5_fu_732_p1 + zext_ln232_4_fu_728_p1);

assign ret_13_fu_750_p2 = (zext_ln232_7_fu_746_p1 + zext_ln232_6_fu_742_p1);

assign ret_14_fu_764_p2 = (zext_ln232_9_fu_760_p1 + zext_ln232_8_fu_756_p1);

assign ret_15_fu_778_p2 = (zext_ln232_11_fu_774_p1 + zext_ln232_10_fu_770_p1);

assign ret_16_fu_792_p2 = (zext_ln232_13_fu_788_p1 + zext_ln232_12_fu_784_p1);

assign ret_17_fu_806_p2 = (zext_ln232_15_fu_802_p1 + zext_ln232_14_fu_798_p1);

assign ret_18_fu_1060_p2 = (zext_ln232_16_fu_1054_p1 + zext_ln232_17_fu_1057_p1);

assign s_axis_icmp_TREADY = regslice_both_s_axis_icmp_V_data_V_U_ack_in;

assign select_ln170_fu_1040_p3 = ((and_ln170_2_fu_1034_p2[0:0] == 1'b1) ? 3'd2 : 3'd4);

assign select_ln202_fu_302_p3 = ((prevWord_last_V[0:0] == 1'b1) ? 3'd0 : 3'd3);

assign select_ln819_fu_1122_p3 = ((p_Result_s_fu_1110_p3[0:0] == 1'b1) ? checksumL4_o_V_fu_1104_p2 : trunc_ln649_fu_1118_p1);

assign tmp_3_fu_992_p3 = {{trunc_ln674_fu_988_p1}, {p_Result_6_fu_978_p4}};

assign tmp_4_fu_948_p3 = icmpChecksum_V[32'd16];

assign tmp_s_fu_668_p3 = {{p_Result_32_fu_658_p4}, {p_Result_31_fu_648_p4}};

assign trunc_ln357_fu_1066_p1 = ret_18_fu_1060_p2[15:0];

assign trunc_ln649_fu_1118_p1 = checksumL4_r_V_fu_1092_p2[15:0];

assign trunc_ln674_1_fu_334_p1 = s_axis_icmp_TDATA_int_regslice[7:0];

assign trunc_ln674_fu_988_p1 = icmpChecksumTmp_V_fu_960_p2[7:0];

assign zext_ln223_1_fu_1084_p1 = p_Result_33_fu_1070_p4;

assign zext_ln223_2_fu_956_p1 = tmp_4_fu_948_p3;

assign zext_ln223_3_fu_1088_p1 = p_Result_33_fu_1070_p4;

assign zext_ln223_fu_1080_p1 = trunc_ln357_fu_1066_p1;

assign zext_ln232_10_fu_770_p1 = ret_10_fu_708_p2;

assign zext_ln232_11_fu_774_p1 = ret_11_fu_722_p2;

assign zext_ln232_12_fu_784_p1 = ret_12_fu_736_p2;

assign zext_ln232_13_fu_788_p1 = ret_13_fu_750_p2;

assign zext_ln232_14_fu_798_p1 = ret_15_fu_778_p2;

assign zext_ln232_15_fu_802_p1 = ret_16_fu_792_p2;

assign zext_ln232_16_fu_1054_p1 = ret_17_reg_1205;

assign zext_ln232_17_fu_1057_p1 = ret_14_reg_1200;

assign zext_ln232_1_fu_704_p1 = checksumL0_V_10_fu_572_p3;

assign zext_ln232_2_fu_714_p1 = checksumL0_V_11_fu_544_p3;

assign zext_ln232_3_fu_718_p1 = checksumL0_V_12_fu_516_p3;

assign zext_ln232_4_fu_728_p1 = checksumL0_V_13_fu_488_p3;

assign zext_ln232_5_fu_732_p1 = checksumL0_V_14_fu_460_p3;

assign zext_ln232_6_fu_742_p1 = checksumL0_V_15_fu_432_p3;

assign zext_ln232_7_fu_746_p1 = checksumL0_V_16_fu_404_p3;

assign zext_ln232_8_fu_756_p1 = checksumL0_V_17_fu_376_p3;

assign zext_ln232_9_fu_760_p1 = checksumL0_V_18_fu_348_p3;

assign zext_ln232_fu_700_p1 = checksumL0_V_fu_692_p3;

assign zext_ln326_fu_676_p1 = tmp_s_fu_668_p3;


reg find_kernel_block = 0;
assign ap_local_block = find_kernel_block;
// synthesis translate_off
`include "icmp_server_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //icmp_server

