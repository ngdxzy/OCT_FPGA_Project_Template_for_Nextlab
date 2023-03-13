/**********
Copyright (c) 2019-2020, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/
/* This is a stream to memory mapped data mover kernel which takes input from a
stream and writes data
to global memory via memory mapped interface */

#include "ap_axi_sdata.h"
#include "ap_int.h"
#include "hls_stream.h"

#define DWIDTH 512
#define TDWIDTH 16

typedef ap_uint<DWIDTH> pkt;

typedef struct userMetadata {
    ap_uint<32>     myIP;
    ap_uint<32>     theirIP;
    ap_uint<16>     myPort;
    ap_uint<16>     theirPort;
}MetaData;

extern "C" {
void rxkrnl(
    ap_uint<DWIDTH> *out,     // Write only memory mapped
    unsigned int     size,     // Size in bytes
    hls::stream<pkt> &n2k    // Internal Stream
) {
#pragma HLS INTERFACE m_axi port = out offset = slave bundle = gmem
#pragma HLS INTERFACE axis port = n2k
#pragma HLS INTERFACE s_axilite port = out
#pragma HLS INTERFACE s_axilite port = size 
#pragma HLS INTERFACE s_axilite port = return

data_mover:
	int i = 0;
  	// Auto-pipeline is going to apply pipeline to this loop
  	for (unsigned int i = 0; i < ((size >> 6)); i++) {
	    ap_uint<512> tmp;
		n2k.read(tmp);
        out[i] = tmp;
  	}

}
}
