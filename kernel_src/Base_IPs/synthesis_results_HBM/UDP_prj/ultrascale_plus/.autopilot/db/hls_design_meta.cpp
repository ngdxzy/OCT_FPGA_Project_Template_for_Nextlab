#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_local_block", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_AWVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_AWREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_AWADDR", 10, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_WVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_WREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_WDATA", 32, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_WSTRB", 4, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_ARVALID", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_ARREADY", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_ARADDR", 10, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_RVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_RREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_RDATA", 32, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_RRESP", 2, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_BVALID", 1, hls_out, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_BREADY", 1, hls_in, -1, "", "", 1),
	Port_Property("s_axi_s_axilite_BRESP", 2, hls_out, -1, "", "", 1),
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("rxUdpDataIn_TDATA", 512, hls_in, 0, "axis", "in_data", 1),
	Port_Property("rxUdpDataIn_TKEEP", 64, hls_in, 1, "axis", "in_data", 1),
	Port_Property("rxUdpDataIn_TSTRB", 64, hls_in, 2, "axis", "in_data", 1),
	Port_Property("rxUdpDataIn_TLAST", 1, hls_in, 3, "axis", "in_data", 1),
	Port_Property("txUdpDataOut_TDATA", 512, hls_out, 4, "axis", "out_data", 1),
	Port_Property("txUdpDataOut_TKEEP", 64, hls_out, 5, "axis", "out_data", 1),
	Port_Property("txUdpDataOut_TSTRB", 64, hls_out, 6, "axis", "out_data", 1),
	Port_Property("txUdpDataOut_TLAST", 1, hls_out, 7, "axis", "out_data", 1),
	Port_Property("DataOutApp_TDATA", 512, hls_out, 8, "axis", "out_data", 1),
	Port_Property("DataOutApp_TKEEP", 64, hls_out, 9, "axis", "out_data", 1),
	Port_Property("DataOutApp_TSTRB", 64, hls_out, 10, "axis", "out_data", 1),
	Port_Property("DataOutApp_TUSER", 96, hls_out, 11, "axis", "out_data", 1),
	Port_Property("DataOutApp_TLAST", 1, hls_out, 12, "axis", "out_data", 1),
	Port_Property("DataOutApp_TDEST", 16, hls_out, 13, "axis", "out_data", 1),
	Port_Property("DataInApp_TDATA", 512, hls_in, 14, "axis", "in_data", 1),
	Port_Property("DataInApp_TKEEP", 64, hls_in, 15, "axis", "in_data", 1),
	Port_Property("DataInApp_TSTRB", 64, hls_in, 16, "axis", "in_data", 1),
	Port_Property("DataInApp_TUSER", 96, hls_in, 17, "axis", "in_data", 1),
	Port_Property("DataInApp_TLAST", 1, hls_in, 18, "axis", "in_data", 1),
	Port_Property("DataInApp_TDEST", 16, hls_in, 19, "axis", "in_data", 1),
	Port_Property("myIpAddress", 32, hls_in, 20, "ap_none", "in_data", 1),
	Port_Property("rxUdpDataIn_TVALID", 1, hls_in, 3, "axis", "in_vld", 1),
	Port_Property("rxUdpDataIn_TREADY", 1, hls_out, 3, "axis", "in_acc", 1),
	Port_Property("DataOutApp_TVALID", 1, hls_out, 13, "axis", "out_vld", 1),
	Port_Property("DataOutApp_TREADY", 1, hls_in, 13, "axis", "out_acc", 1),
	Port_Property("DataInApp_TVALID", 1, hls_in, 19, "axis", "in_vld", 1),
	Port_Property("DataInApp_TREADY", 1, hls_out, 19, "axis", "in_acc", 1),
	Port_Property("txUdpDataOut_TVALID", 1, hls_out, 7, "axis", "out_vld", 1),
	Port_Property("txUdpDataOut_TREADY", 1, hls_in, 7, "axis", "out_acc", 1),
};
const char* HLS_Design_Meta::dut_name = "udp";
