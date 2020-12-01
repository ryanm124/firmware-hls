#include "TrackletProcessor.h"

ap_uint<1> nearFullTEBuff(const ap_uint<3>& writeptr, const ap_uint<3>& readptr) {
  ap_uint<3> writeptr1=writeptr+1;
  ap_uint<3> writeptr2=writeptr+2;
  ap_uint<3> writeptr3=writeptr+3;
  ap_uint<1> result=writeptr1==readptr||writeptr2==readptr||writeptr3==readptr;
  return result;
}

ap_uint<256> nearFullTEUnitInit() {

  ap_uint<256> lut(0);
  int i;
  for(i=0;i<256;i++) {
    ap_uint<4> wptr,rptr;
    ap_uint<8> address(i);
    (rptr,wptr)=address;
    ap_uint<4> wptr1=wptr+1;
    ap_uint<4> wptr2=wptr+2;
    ap_uint<1> result=wptr1==rptr||wptr2==rptr;
    lut[i]=result;
  }
  return lut;
}



////////////////////////////////////////////////////////////////////////////////
// Top functions for various TrackletProcessors (TP). For each iteration of
// the main processing loop, a TC retrieves a pair of stub indices from one of
// the stub-pair memories, and in turn, these indices are used to retrieve one
// stub each from an inner and an outer all-stub memory. This pair of stubs is
// used to calculate a rough set of helix parameters, which are written to the
// tracklet-parameter memory if the tracklet passes cuts on rinv and z0. Rough
// projections to additional layers and disks are also calculated and are
// written to the appropriate tracklet-projection memories.
////////////////////////////////////////////////////////////////////////////////
void TrackletProcessor_L1L2D(
    const BXType bx,
    const ap_uint<10> lut[2048],
    const ap_uint<8> regionlut[2048],
    const AllStubInnerMemory<BARRELPS> innerStubs[2],
    const AllStubMemory<BARRELPS>* outerStubs,
    const VMStubTEOuterMemoryCM<BARRELPS> outerVMStubs[6],
    TrackletParameterMemory * trackletParameters,
    TrackletProjectionMemory<BARRELPS> projout_barrel_ps[TC::N_PROJOUT_BARRELPS],
    TrackletProjectionMemory<BARREL2S> projout_barrel_2s[TC::N_PROJOUT_BARREL2S],
    TrackletProjectionMemory<DISK> projout_disk[TC::N_PROJOUT_DISK]
) {
#pragma HLS inline recursive
#pragma HLS resource variable=lut core=ROM_2P_BRAM  latency=1
#pragma HLS resource variable=regionlut core=ROM_2P_BRAM latency=1
#pragma HLS resource variable=innerStubs[0].get_mem() latency=1
#pragma HLS resource variable=innerStubs[1].get_mem() latency=1
#pragma HLS resource variable=outerStubs->get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[0].get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[1].get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[2].get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[3].get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[4].get_mem() latency=1
#pragma HLS resource variable=outerVMStubs[5].get_mem() latency=1
#pragma HLS array_partition variable=outerVMStubs complete dim=1
#pragma HLS array_partition variable=projout_barrel_ps complete
#pragma HLS array_partition variable=projout_barrel_2s complete
#pragma HLS array_partition variable=projout_disk complete
  //#pragma HLS resource variable=stubptinnerlut core=ROM_1P_LUTRAM
  //#pragma HLS resource variable=stubptouterlut core=ROM_1P_LUTRAM

 TP_L1L2D: TrackletProcessor<TC::L1L2, 
			     TC::D, 
			     2, //TEBuffers
			     6, //TE units
			     BARRELPS, 
			     BARRELPS, 
			     2, 
			     108>(bx, 
				  lut, 
				  regionlut, 
				  innerStubs, 
				  outerStubs, 
				  outerVMStubs,
				  trackletParameters,
				  projout_barrel_ps,
				  projout_barrel_2s,
				  projout_disk
				  );

}

////////////////////////////////////////////////////////////////////////////////
