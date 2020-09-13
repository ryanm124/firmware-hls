#ifndef TRACKLETENGINEUNIT_H
#define TRACKLETENGINEUNIT_H

#include "Constants.h"
#include "VMStubTEOuterMemoryCM.h"

class TrackletEngineUnitBase {
 public:
  enum BitWidths{
    kNBitsBuffer=4
  };
};

template<int VMSTEType>
class TrackletEngineUnit : public TrackletEngineUnitBase {

 public:
  typedef ap_uint<VMStubTEOuter<VMSTEType>::kVMSTEOIDSize+AllStubInner<BARRELPS>::kAllStubInnerSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<TrackletEngineUnitBase::kNBitsBuffer> INDEX;

 TrackletEngineUnit(const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs): 
  outervmstubs_(outervmstubs) {
    idle_ = true;
  }

 inline void init(BXType bxin, 
		  AllStubInner<BARRELPS>::AllStubInnerData innerstub,
		  ap_uint<64> memstubs,
		  ap_uint<3> slot,
		  ap_uint<3> rzbinfirst,
		  ap_uint<3> rzbindiffmax
 ) {
#pragma HLS inline
  idle_ = false;
  bx_ = bxin;
  memstubs_ = memstubs;
  //std::cout << "TEUnit::init memstubs = "<<memstubs.to_string(2)<<std::endl; 
  memindex_ = 0;
  istub_=0;
  innerstub_=innerstub;
  //innerfinephi_=innerfinephi;
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
  //std::cout << "TEUNIT read: "<<this<<" "<<readindex_<<std::endl;
  return stubids_[readindex_++];
}

void write(STUBID stubs) {
#pragma HLS inline  
  //std::cout << "TEUNIT write: "<<this<<" "<<writeindex_<<std::endl;
  stubids_[writeindex_++]=stubs;
}

 inline void step(const ap_uint<1> ptinnerLUT[256], 
		  const ap_uint<1> ptouterLUT[256]) {
#pragma HLS inline
#pragma HLS PIPELINE II=1
#pragma HLS dependence variable=istub intra WAR true
  if(idle()) return;

  ap_uint<3> ireg;
  ap_uint<1> next;
  ap_uint<4> nstubs;

  (ireg, next, nstubs)=memstubs_.range((memindex_*8)+7,memindex_*8);

  if (nstubs==0) {
    idle_=true;
    return;
  }

  if (full())
    return;

  ap_uint<3> ibin(slot_+next);

  ap_uint<12> stubadd( ((ireg, ibin),istub_) );

  assert(nstubs==outervmstubs_.getEntries(bx_,(ireg,ibin)));

  const auto& outervmstub = outervmstubs_.read_mem(bx_,stubadd);

  const auto& finephi = outervmstub.getFinePhi();
  const auto& rzbin = (next, outervmstub.getFineZ()); 

  ap_uint<2> iAllstub=1; //FIXME need to be template parameter
  ap_uint<8> outerfinephi = ((iAllstub, ireg), finephi);

  int nbitsfinephidiff=5;

  int idphi =  outerfinephi - AllStubInner<BARRELPS>(innerstub_).getFinePhi();
  bool inrange = abs(idphi) < (1<<(nbitsfinephidiff));

  if (idphi<0) idphi+=(1<<nbitsfinephidiff);

  if  (!(rzbin<rzbinfirst_ || rzbin > rzbinfirst_ + rzbindiffmax_)) {

    const auto& outerbend = outervmstub.getBend();
    const auto& innerbend = innerstub_.getBend();

    auto ptinnerindex = (idphi, innerbend);
    auto ptouterindex = (idphi, outerbend);
    
    if (inrange && ptinnerLUT[ptinnerindex] && ptouterLUT[ptouterindex]){
      write( (outervmstub.getIndex(), innerstub_.raw()) );
    }
  }

  istub_++;
  if(istub_==nstubs) {
    istub_=0;
    memindex_++;
    if (memindex_==0) {
      idle_=true;
    } else {
      ((ireg,next),nstubs)=memstubs_.range((memindex_*8)+7,memindex_*8);
      if (nstubs==0) {
	idle_=true;
      }
    }
  } // if(buffernotempty)
  return;

} // end step
 
 private:

 ap_uint<64> memstubs_;
 ap_uint<3> memindex_;

 ap_uint<3> slot_;
 ap_uint<3> rzbinfirst_;
 ap_uint<3> rzbindiffmax_;

 AllStubInner<BARRELPS> innerstub_; 

 const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs_;

 INDEX writeindex_;
 INDEX readindex_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 STUBID stubids_[1<<TrackletEngineUnitBase::kNBitsBuffer];

}; // end class


#endif
