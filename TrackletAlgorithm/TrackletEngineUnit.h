#ifndef TRACKLETENGINEUNIT_H
#define TRACKLETENGINEUNIT_H

#include "Constants.h"
#include "VMStubTEMemory.h"

template<int VMProjType> class TrackletEngineUnitBase {};

class TrackletEngineUnitBase {
 public:
  enum BitWidths{
    kNBitsBuffer=4
  };
};

template<int VMSTEType>
class TrackletEngineUnit : public TrackletEngineUnitBase {

 public:
  typedef ap_uint<VMStubMEBase<VMSMEType>::kVMSMEIndexSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<TrackletEngineUnitBase<VMProjType>::kNBitsBuffer> INDEX;

TrackletEngineUnit() {
  nstubs_=0;
  idle_ = true;
}

/*
~TrackletEngineUnit() {
  delete[] stubids;
}
*/

 inline void init(BXType bxin, ap_uint<36> innerstub ) {
#pragma HLS inline
  writeindex_ = 0;
  readindex_ = 0;
  idle_ = false;
  bx_ = bxin;
  memindex_ = 0;
  istub_=0;
  innerstub_=innerstub;

}

bool empty() {
#pragma HLS inline  
  return (writeindex==readindex);
}

bool idle() {
#pragma HLS inline  
  return idle_;
}

STUBID read() {
#pragma HLS inline  
  return stubids_[readptr_++];
}

inline void step() {
#pragma HLS inline
#pragma HLS PIPELINE II=1
#pragma HLS dependence variable=istub intra WAR true
  if(idle()) return;

  ap_uint<4> nstubs=memstubs_.range((memindex_<<4)+3,memindex_<<4);
  
  if (nstubs==0) {
    memindex_++;
    return;
  }

  if (full())
    return;
  
  ap_uint<3> ireg;
  ap_uint<1> next;

  (ireg,next)=memindex_;

  ap_uint<12> stubadd( ((ireg, slot+next),istub_) );
  
  auto& vmstub = outervmstubs.read_mem(bx,stubadd);

  
  

  istub_++;
  if(istub==nstubs) {
    istub_=0;
    memindex_++;
    if (memindex_==0) {
      idle_ = true;
    }
 
  } // if(buffernotempty)
  return false;

} // end step
 
 private:

 ap_uint<64> memstubs_;
 ap_uint<4> memindex_;
 
 INDEX writeindex;
 INDEX readindex;
 NSTUBS nstubs;
 bool idle_;
 BXType bx;
 
 NSTUBS istub=0;
 STUBID stubids[1<<TrackletEngineUnitBase<VMProjType>::kNBitsBuffer];
 ap_int<5> projfinezadj; //FIXME Need replace 5 with const
 ProjectionRouterBuffer<BARREL>::TCID tcid;
 ProjectionRouterBuffer<BARREL>::PRHASSEC isPSseed;
 ProjectionRouterBuffer<BARREL>::VMPZBIN zbin;
 VMProjection<BARREL>::VMPRINV projrinv;
 VMProjection<BARREL>::VMPID projindex;
 
}; // end class


#endif
