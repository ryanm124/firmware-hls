#ifndef TRACKLETENGINEUNIT_H
#define TRACKLETENGINEUNIT_H

#include "Constants.h"
#include "VMStubTEOuterMemory.h"

class TrackletEngineUnitBase {
 public:
  enum BitWidths{
    kNBitsBuffer=4
  };
};

template<int VMSTEType>
class TrackletEngineUnit : public TrackletEngineUnitBase {

 public:
  typedef ap_uint<VMStubTEOuter<VMSTEType>::kVMSTEOIDSize+AllStub<BARRELPS>::kAllStubSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<TrackletEngineUnitBase::kNBitsBuffer> INDEX;

 TrackletEngineUnit(const VMStubTEOuterMemory<VMSTEType> &outervmstubs): 
  outervmstubs_(outervmstubs) {
    idle_ = true;
  }

/*
~TrackletEngineUnit() {
  delete[] stubids;
}
*/

 inline void init(BXType bxin, 
		  AllStub<BARRELPS>::AllStubData innerstub,
		  ap_uint<3> slot,
		  ap_uint<3> rzbinfirst,
		  ap_uint<3> rzbindiffmax
 ) {
#pragma HLS inline
  writeindex_ = 0;
  readindex_ = 0;
  idle_ = true;
  bx_ = bxin;
  memindex_ = 0;
  istub_=0;
  innerstub_=innerstub;
  slot_=slot;
  rzbinfirst_=rzbinfirst;
  rzbindiffmax_=rzbindiffmax;
}
 

 void reset() {
   writeindex_ = 0;
   readindex_ = 0;
   idle_ = true;
 }

bool empty() {
#pragma HLS inline  
  return (writeindex_==readindex_);
}

bool idle() {
#pragma HLS inline  
  return idle_;
}

bool full() {
  return (writeindex_+1==readindex_);
}

STUBID read() {
#pragma HLS inline  
  return stubids_[readindex_++];
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

  ap_uint<12> stubadd( ((ireg, slot_+next),istub_) );
  
  auto& outervmstub = outervmstubs_.read_mem(bx_,stubadd);

  const auto& finephi = outervmstub.getFinePhi();
  const auto& rzbin = (next, outervmstub.getFineZ()); 

  ap_uint<2> iAllstub=1; //FIXME need to be template parameter
  ap_uint<8> outerfinephi = ((iAllstub, ireg), finephi);

  ap_uint<8> innerfinephi = innerstub_.getPhi().range(AllStubBase<BARRELPS>::kASPhiSize,AllStubBase<BARRELPS>::kASPhiSize-8+1);

  int idphi =  outerfinephi - innerfinephi;
  bool inrange = abs(idphi) < (1<<5);

  if  (rzbin<rzbinfirst_ || rzbin > rzbinfirst_ + rzbindiffmax_)
    return;

  const auto& outerbend = outervmstub.getBend();
  const auto& innerbend = innerstub_.getBend();

  auto ptinnerindex = (idphi, innerbend);
  auto ptouterindex = (idphi, outerbend);

  if (inrange && ptinnerLUT_[ptinnerindex] && ptouterLUT_[ptouterindex])
    write( (outervmstub.getID(), innerstub_) );
  
  

  istub_++;
  if(istub_==nstubs) {
    istub_=0;
    memindex_++;
    if (memindex_==0) {
      idle_ = true;
    }
 
  } // if(buffernotempty)
  return;

} // end step
 
 private:

 ap_uint<64> memstubs_;
 ap_uint<4> memindex_;

 ap_uint<3> slot_;
 ap_uint<3> rzbinfirst_;
 ap_uint<3> rzbindiffmax_;

 AllStub<BARRELPS> innerstub_; 

 const VMStubTEOuterMemory<VMSTEType> &outervmstubs_;

 INDEX writeindex_;
 INDEX readindex_;
 //NSTUBS nstubs_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 STUBID stubids_[1<<TrackletEngineUnitBase::kNBitsBuffer];

 bool ptinnerLUT_[1<<8]; 
 bool ptouterLUT_[1<<8]; 

}; // end class


#endif
