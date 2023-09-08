#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define UDP_DWIDTH 512
#define TDWIDTH 16

#define USER_DWIDTH 256

#define UDP_CBW 9
#define USE_CBW 8
#define USE_MASK 0xFF


typedef ap_uint<UDP_DWIDTH> socket_pkt;
typedef ap_uint<USER_DWIDTH> user_pkt;

extern "C" {
// Out stream format:
// data: 512 bit void data
// keep: should always be -1
// dest: follow the host, now sure what does it means yet
// 
// Function input:
// N: number of bytes to send
// destination: to dest
void packet_p2s(hls::stream<socket_pkt>& stream_in, hls::stream<user_pkt>& stream_out){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS PIPELINE II=1 style=flp

    static ap_uint<1> even_counter = 0;

    static socket_pkt i_temp;

    if (even_counter == 0){
        stream_in >> i_temp;
    }

    if (even_counter == 0){
        user_pkt o_temp = i_temp(255, 0);
        stream_out << o_temp;
    }
    else{
        user_pkt o_temp = i_temp(511, 256);
        stream_out << o_temp;
    }
    even_counter = even_counter + 1;
}
}
