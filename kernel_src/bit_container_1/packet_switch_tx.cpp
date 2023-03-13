#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 96, 1, TDWIDTH> socket_pkt;
typedef ap_axiu<DWIDTH, 96, 1, TDWIDTH> user_pkt;


extern "C" {

void packet_switch_tx(hls::stream<socket_pkt>& stream_in_0, hls::stream<socket_pkt>& stream_in_1, hls::stream<user_pkt>& stream_out){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS PIPELINE II=1 style=flp
    const ap_uint<64> KEEP_VALID = 0xFFFFFFFFFFFFFFFF;
	socket_pkt i_temp;
    user_pkt o_temp;
    bool valid;
    if (!stream_in_0.empty()){
        stream_in_0.read(i_temp);
        valid = true;
    }
    else if (!stream_in_1.empty()){
        stream_in_1.read(i_temp);
        valid = true;
    }
    else{
        valid = false;
    }
    if (valid){
        o_temp.data = i_temp.data;
        o_temp.keep = i_temp.keep;
        o_temp.last = i_temp.last;
        o_temp.dest = i_temp.dest;
        o_temp.user = i_temp.user;
        stream_out << o_temp;
    }
}

}
