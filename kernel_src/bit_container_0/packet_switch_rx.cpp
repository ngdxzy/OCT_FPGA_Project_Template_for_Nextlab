#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 96, 1, TDWIDTH> socket_pkt;
typedef ap_uint<DWIDTH> user_pkt;


extern "C" {
// Out stream format:
// data: 512 bit void data
// keep: should always be -1
// dest: follow the host, now sure what does it means yet
// 
// Function input:
// N: number of bytes to send
// destination: to dest
void packet_switch_rx(hls::stream<socket_pkt>& stream_in, hls::stream<user_pkt>& stream_out_0, hls::stream<user_pkt>& stream_out_1){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS PIPELINE II=1 style=flp
    const ap_uint<64> KEEP_VALID = 0xFFFFFFFFFFFFFFFF;
	socket_pkt i_temp;
    user_pkt o_temp;
	stream_in >> i_temp;
    o_temp = i_temp.data;
    ap_uint<16> port_number = i_temp.user(31, 16);
    if (port_number[0] == 0){
        stream_out_0 << o_temp;
    }
    else{
        stream_out_1 << o_temp;
    }    
}

}
