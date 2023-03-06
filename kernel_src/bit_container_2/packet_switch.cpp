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
void packet_switch(hls::stream<socket_pkt>& stream_in, hls::stream<user_pkt>& stream_out){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS PIPELINE II=1 style=flp
    const ap_uint<64> KEEP_VALID = 0xFFFFFFFFFFFFFFFF;
	socket_pkt i_temp;
    user_pkt o_temp;
	stream_in >> i_temp;
    o_temp = i_temp.data;
    if (i_temp.keep == KEEP_VALID){
	    stream_out << o_temp;
    }    
}

}
