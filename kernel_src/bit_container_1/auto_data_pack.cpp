#include "ap_axi_sdata.h"
#include "ap_int.h"
#include <ap_fixed.h>
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_uint<DWIDTH> data_t;
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
void auto_data_pack(unsigned int destination, hls::stream<data_t>& stream_in, hls::stream<pkt>& stream_out){
#pragma HLS interface ap_ctrl_none port=return
#pragma HLS interface s_axilite port=destination
#pragma HLS PIPELINE II=1 style=flp
    static ap_uint<5> pkt_counter = 0;
    static ap_uint<11> watching_dog = 0;
    static bool got_data = false;
    data_t i_temp;

    bool valid = stream_in.read_nb(i_temp);

    if (valid){
        pkt o_temp;
        o_temp.data = i_temp;
        o_temp.keep = -1;
        o_temp.dest = destination;
        if (pkt_counter == 21){
            pkt_counter = 0;
            o_temp.last = 1;
            got_data = false;
        }
        else{
            pkt_counter++;
            o_temp.last = 0;
            got_data = true;
        }
        stream_out << o_temp;
        watching_dog = 0; 
    }
    else if (got_data){
        if (watching_dog == 1023){
            pkt o_temp;
            o_temp.data = 0;
            o_temp.keep = 0;
            o_temp.last = 1;
            o_temp.dest = destination;
            stream_out << o_temp;
            watching_dog = 0;
            pkt_counter  = 0;
            got_data = false;
        }    
        else{
            watching_dog++;
        }
    }

}
}
