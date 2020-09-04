#include "TrackletProcessor.h"

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
    const AllStubMemory<BARRELPS> innerStubs[2],
    const AllStubMemory<BARRELPS>* outerStubs,
    TrackletParameterMemory * trackletParameters,
    TrackletProjectionMemory<BARRELPS> projout_barrel_ps[TC::N_PROJOUT_BARRELPS],
    TrackletProjectionMemory<BARREL2S> projout_barrel_2s[TC::N_PROJOUT_BARREL2S],
    TrackletProjectionMemory<DISK> projout_disk[TC::N_PROJOUT_DISK]
) {
#pragma HLS inline recursive
#pragma HLS resource variable=innerStubs.get_mem() latency=2
#pragma HLS resource variable=outerStubs.get_mem() latency=2
#pragma HLS resource variable=stubPairs.get_mem() latency=2
#pragma HLS array_partition variable=projout_barrel_ps complete
#pragma HLS array_partition variable=projout_barrel_2s complete
#pragma HLS array_partition variable=projout_disk complete

TC_L1L2D: TrackletCalculator<
  TC::L1L2,
  TC::D,
  InnerRegion<TC::L1L2>(),
  OuterRegion<TC::L1L2>(),
  NASMemInner<TC::L1L2, TC::D>(),
  NASMemOuter<TC::L1L2, TC::D>(),
  NSPMem<TC::L1L2, TC::D>(),
  kMaxProc
 >(
    bx,
    innerStubs,
    outerStubs,
    trackletParameters,
    projout_barrel_ps,
    projout_barrel_2s,
    projout_disk
  );
}

////////////////////////////////////////////////////////////////////////////////
