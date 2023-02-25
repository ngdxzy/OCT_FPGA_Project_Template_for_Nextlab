#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_axiu<DWIDTH, 1, 1, TDWIDTH> pkt;


extern "C" {
// Out stream format:
// data: 512 bit void data
// keep: should always be -1
// dest: follow the host, now sure what does it means yet
// 
// Function input:
// N: number of bytes to send
// destination: to dest
void bridge(hls::stream<pkt>& stream_in, hls::stream<pkt>& stream_out){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS PIPELINE II=1 stype=frp
	pkt temp;
	stream_in >> temp;
	stream_out << temp;

}
}
