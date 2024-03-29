// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.2 (64-bit)
// Version: 2021.2
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module udp_rxEngPacketDropper (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rthDropFifo_dout,
        rthDropFifo_empty_n,
        rthDropFifo_read,
        ureDataPayload_dout,
        ureDataPayload_empty_n,
        ureDataPayload_read,
        DataOutApp_TREADY,
        DataOutApp_TDATA,
        DataOutApp_TVALID,
        DataOutApp_TKEEP,
        DataOutApp_TSTRB,
        DataOutApp_TUSER,
        DataOutApp_TLAST,
        DataOutApp_TDEST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [159:0] rthDropFifo_dout;
input   rthDropFifo_empty_n;
output   rthDropFifo_read;
input  [1023:0] ureDataPayload_dout;
input   ureDataPayload_empty_n;
output   ureDataPayload_read;
input   DataOutApp_TREADY;
output  [511:0] DataOutApp_TDATA;
output   DataOutApp_TVALID;
output  [63:0] DataOutApp_TKEEP;
output  [63:0] DataOutApp_TSTRB;
output  [95:0] DataOutApp_TUSER;
output  [0:0] DataOutApp_TLAST;
output  [15:0] DataOutApp_TDEST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rthDropFifo_read;
reg ureDataPayload_read;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] tmp_i_nbreadreq_fu_98_p3;
reg    ap_predicate_op19_read_state1;
wire   [0:0] tmp_i_179_nbreadreq_fu_112_p3;
reg    ap_predicate_op37_read_state1;
reg    ap_done_reg;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] repd_state_load_reg_313;
reg   [0:0] tmp_i_179_reg_324;
reg   [0:0] response_drop_V_load_reg_317;
reg    ap_predicate_op53_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_state2_io;
reg   [0:0] repd_state_load_reg_313_pp0_iter1_reg;
reg   [0:0] tmp_i_179_reg_324_pp0_iter1_reg;
reg   [0:0] response_drop_V_load_reg_317_pp0_iter1_reg;
reg    ap_predicate_op54_write_state3;
wire    regslice_both_DataOutApp_V_data_V_U_apdone_blk;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] repd_state;
reg   [0:0] response_drop_V;
reg   [15:0] response_id_V;
reg   [31:0] response_user_myIP_V;
reg   [31:0] response_user_theirIP_V;
reg   [15:0] response_user_myPort_V;
reg   [15:0] response_user_theirPort_V;
reg    DataOutApp_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    rthDropFifo_blk_n;
reg    ureDataPayload_blk_n;
reg    ap_block_pp0_stage0_11001;
wire   [511:0] currWord_data_V_fu_251_p1;
reg   [511:0] currWord_data_V_reg_328;
reg   [63:0] currWord_keep_V_reg_333;
wire   [0:0] currWord_last_V_fu_265_p3;
reg   [0:0] currWord_last_V_reg_338;
wire   [15:0] trunc_ln144_fu_157_p1;
reg    ap_block_pp0_stage0_01001;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    DataOutApp_TVALID_int_regslice;
wire    DataOutApp_TREADY_int_regslice;
wire    regslice_both_DataOutApp_V_data_V_U_vld_out;
wire    regslice_both_DataOutApp_V_keep_V_U_apdone_blk;
wire    regslice_both_DataOutApp_V_keep_V_U_ack_in_dummy;
wire    regslice_both_DataOutApp_V_keep_V_U_vld_out;
wire    regslice_both_DataOutApp_V_strb_V_U_apdone_blk;
wire    regslice_both_DataOutApp_V_strb_V_U_ack_in_dummy;
wire    regslice_both_DataOutApp_V_strb_V_U_vld_out;
wire    regslice_both_DataOutApp_V_user_V_U_apdone_blk;
wire   [95:0] DataOutApp_TUSER_int_regslice;
wire    regslice_both_DataOutApp_V_user_V_U_ack_in_dummy;
wire    regslice_both_DataOutApp_V_user_V_U_vld_out;
wire    regslice_both_DataOutApp_V_last_V_U_apdone_blk;
wire    regslice_both_DataOutApp_V_last_V_U_ack_in_dummy;
wire    regslice_both_DataOutApp_V_last_V_U_vld_out;
wire    regslice_both_DataOutApp_V_dest_V_U_apdone_blk;
wire    regslice_both_DataOutApp_V_dest_V_U_ack_in_dummy;
wire    regslice_both_DataOutApp_V_dest_V_U_vld_out;
reg    ap_condition_179;
reg    ap_condition_176;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_done_reg = 1'b0;
#0 repd_state = 1'd0;
#0 response_drop_V = 1'd0;
#0 response_id_V = 16'd0;
#0 response_user_myIP_V = 32'd0;
#0 response_user_theirIP_V = 32'd0;
#0 response_user_myPort_V = 16'd0;
#0 response_user_theirPort_V = 16'd0;
end

udp_regslice_both #(
    .DataWidth( 512 ))
regslice_both_DataOutApp_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(currWord_data_V_reg_328),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(DataOutApp_TREADY_int_regslice),
    .data_out(DataOutApp_TDATA),
    .vld_out(regslice_both_DataOutApp_V_data_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_data_V_U_apdone_blk)
);

udp_regslice_both #(
    .DataWidth( 64 ))
regslice_both_DataOutApp_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(currWord_keep_V_reg_333),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(regslice_both_DataOutApp_V_keep_V_U_ack_in_dummy),
    .data_out(DataOutApp_TKEEP),
    .vld_out(regslice_both_DataOutApp_V_keep_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_keep_V_U_apdone_blk)
);

udp_regslice_both #(
    .DataWidth( 64 ))
regslice_both_DataOutApp_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(64'd0),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(regslice_both_DataOutApp_V_strb_V_U_ack_in_dummy),
    .data_out(DataOutApp_TSTRB),
    .vld_out(regslice_both_DataOutApp_V_strb_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_strb_V_U_apdone_blk)
);

udp_regslice_both #(
    .DataWidth( 96 ))
regslice_both_DataOutApp_V_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(DataOutApp_TUSER_int_regslice),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(regslice_both_DataOutApp_V_user_V_U_ack_in_dummy),
    .data_out(DataOutApp_TUSER),
    .vld_out(regslice_both_DataOutApp_V_user_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_user_V_U_apdone_blk)
);

udp_regslice_both #(
    .DataWidth( 1 ))
regslice_both_DataOutApp_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(currWord_last_V_reg_338),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(regslice_both_DataOutApp_V_last_V_U_ack_in_dummy),
    .data_out(DataOutApp_TLAST),
    .vld_out(regslice_both_DataOutApp_V_last_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_last_V_U_apdone_blk)
);

udp_regslice_both #(
    .DataWidth( 16 ))
regslice_both_DataOutApp_V_dest_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(response_id_V),
    .vld_in(DataOutApp_TVALID_int_regslice),
    .ack_in(regslice_both_DataOutApp_V_dest_V_U_ack_in_dummy),
    .data_out(DataOutApp_TDEST),
    .vld_out(regslice_both_DataOutApp_V_dest_V_U_vld_out),
    .ack_out(DataOutApp_TREADY),
    .apdone_blk(regslice_both_DataOutApp_V_dest_V_U_apdone_blk)
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
            ap_enable_reg_pp0_iter1 <= ap_start;
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
    if ((1'b1 == ap_condition_176)) begin
        if ((1'b1 == ap_condition_179)) begin
            repd_state <= 1'd0;
        end else if (((tmp_i_nbreadreq_fu_98_p3 == 1'd1) & (repd_state == 1'd0))) begin
            repd_state <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_i_179_nbreadreq_fu_112_p3 == 1'd1) & (repd_state == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        currWord_data_V_reg_328 <= currWord_data_V_fu_251_p1;
        currWord_keep_V_reg_333 <= {{ureDataPayload_dout[575:512]}};
        currWord_last_V_reg_338 <= ureDataPayload_dout[32'd576];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        repd_state_load_reg_313 <= repd_state;
        repd_state_load_reg_313_pp0_iter1_reg <= repd_state_load_reg_313;
        response_drop_V_load_reg_317 <= response_drop_V;
        response_drop_V_load_reg_317_pp0_iter1_reg <= response_drop_V_load_reg_317;
        tmp_i_179_reg_324_pp0_iter1_reg <= tmp_i_179_reg_324;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_i_nbreadreq_fu_98_p3 == 1'd1) & (repd_state == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        response_drop_V <= rthDropFifo_dout[32'd128];
        response_id_V <= trunc_ln144_fu_157_p1;
        response_user_myIP_V <= {{rthDropFifo_dout[63:32]}};
        response_user_myPort_V <= {{rthDropFifo_dout[111:96]}};
        response_user_theirIP_V <= {{rthDropFifo_dout[95:64]}};
        response_user_theirPort_V <= {{rthDropFifo_dout[127:112]}};
    end
end

always @ (posedge ap_clk) begin
    if (((repd_state == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_i_179_reg_324 <= tmp_i_179_nbreadreq_fu_112_p3;
    end
end

always @ (*) begin
    if ((((ap_predicate_op54_write_state3 == 1'b1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_predicate_op53_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)))) begin
        DataOutApp_TDATA_blk_n = DataOutApp_TREADY_int_regslice;
    end else begin
        DataOutApp_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op53_write_state2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        DataOutApp_TVALID_int_regslice = 1'b1;
    end else begin
        DataOutApp_TVALID_int_regslice = 1'b0;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_done_reg == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        rthDropFifo_blk_n = rthDropFifo_empty_n;
    end else begin
        rthDropFifo_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op19_read_state1 == 1'b1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rthDropFifo_read = 1'b1;
    end else begin
        rthDropFifo_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_done_reg == 1'b0) & (ap_predicate_op37_read_state1 == 1'b1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ureDataPayload_blk_n = ureDataPayload_empty_n;
    end else begin
        ureDataPayload_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op37_read_state1 == 1'b1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ureDataPayload_read = 1'b1;
    end else begin
        ureDataPayload_read = 1'b0;
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

assign DataOutApp_TUSER_int_regslice = {{{{response_user_myIP_V}, {response_user_theirIP_V}}, {response_user_myPort_V}}, {response_user_theirPort_V}};

assign DataOutApp_TVALID = regslice_both_DataOutApp_V_data_V_U_vld_out;

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_predicate_op53_write_state2 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op37_read_state1 == 1'b1) & (ureDataPayload_empty_n == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (rthDropFifo_empty_n == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_DataOutApp_V_data_V_U_apdone_blk == 1'b1) | ((ap_predicate_op54_write_state3 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((ap_predicate_op53_write_state2 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)))) | ((ap_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op37_read_state1 == 1'b1) & (ureDataPayload_empty_n == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (rthDropFifo_empty_n == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_DataOutApp_V_data_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state3_io) | ((ap_predicate_op54_write_state3 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((ap_predicate_op53_write_state2 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)))) | ((ap_start == 1'b1) & ((ap_done_reg == 1'b1) | ((ap_predicate_op37_read_state1 == 1'b1) & (ureDataPayload_empty_n == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (rthDropFifo_empty_n == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_both_DataOutApp_V_data_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state3_io) | ((ap_predicate_op54_write_state3 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_done_reg == 1'b1) | ((ap_predicate_op37_read_state1 == 1'b1) & (ureDataPayload_empty_n == 1'b0)) | ((ap_predicate_op19_read_state1 == 1'b1) & (rthDropFifo_empty_n == 1'b0)));
end

always @ (*) begin
    ap_block_state2_io = ((ap_predicate_op53_write_state2 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((ap_predicate_op53_write_state2 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice));
end

always @ (*) begin
    ap_block_state3_io = ((ap_predicate_op54_write_state3 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((regslice_both_DataOutApp_V_data_V_U_apdone_blk == 1'b1) | ((ap_predicate_op54_write_state3 == 1'b1) & (1'b0 == DataOutApp_TREADY_int_regslice)));
end

always @ (*) begin
    ap_condition_176 = ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

always @ (*) begin
    ap_condition_179 = ((tmp_i_179_nbreadreq_fu_112_p3 == 1'd1) & (repd_state == 1'd1) & (currWord_last_V_fu_265_p3 == 1'd1));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op19_read_state1 = ((tmp_i_nbreadreq_fu_98_p3 == 1'd1) & (repd_state == 1'd0));
end

always @ (*) begin
    ap_predicate_op37_read_state1 = ((tmp_i_179_nbreadreq_fu_112_p3 == 1'd1) & (repd_state == 1'd1));
end

always @ (*) begin
    ap_predicate_op53_write_state2 = ((response_drop_V_load_reg_317 == 1'd0) & (tmp_i_179_reg_324 == 1'd1) & (repd_state_load_reg_313 == 1'd1));
end

always @ (*) begin
    ap_predicate_op54_write_state3 = ((response_drop_V_load_reg_317_pp0_iter1_reg == 1'd0) & (tmp_i_179_reg_324_pp0_iter1_reg == 1'd1) & (repd_state_load_reg_313_pp0_iter1_reg == 1'd1));
end

assign currWord_data_V_fu_251_p1 = ureDataPayload_dout[511:0];

assign currWord_last_V_fu_265_p3 = ureDataPayload_dout[32'd576];

assign tmp_i_179_nbreadreq_fu_112_p3 = ureDataPayload_empty_n;

assign tmp_i_nbreadreq_fu_98_p3 = rthDropFifo_empty_n;

assign trunc_ln144_fu_157_p1 = rthDropFifo_dout[15:0];

endmodule //udp_rxEngPacketDropper
