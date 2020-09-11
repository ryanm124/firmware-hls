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
  typedef ap_uint<VMStubTEOuter<VMSTEType>::kVMSTEOIDSize+AllStub<BARRELPS>::kAllStubSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<TrackletEngineUnitBase::kNBitsBuffer> INDEX;

 TrackletEngineUnit(const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs): 
  outervmstubs_(outervmstubs) {
    idle_ = true;
  }

 inline void init(BXType bxin, 
		  AllStub<BARRELPS>::AllStubData innerstub,
		  ap_uint<8> innerfinephi,
		  ap_uint<64> memstubs,
		  ap_uint<3> slot,
		  ap_uint<3> rzbinfirst,
		  ap_uint<3> rzbindiffmax
 ) {
#pragma HLS inline
  idle_ = false;
  bx_ = bxin;
  memstubs_ = memstubs;
  std::cout << "TEUnit::init memstubs = "<<memstubs.to_string(2)<<std::endl; 
  memindex_ = 0;
  istub_=0;
  innerstub_=innerstub;
  innerfinephi_=innerfinephi;
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
  std::cout << "TEUNIT read: "<<this<<" "<<readindex_<<std::endl;
  return stubids_[readindex_++];
}

void write(STUBID stubs) {
#pragma HLS inline  
  std::cout << "TEUNIT write: "<<this<<" "<<writeindex_<<std::endl;
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

  ((ireg,next),nstubs)=memstubs_.range((memindex_*8)+7,memindex_*8);
  
  std::cout << "TEUnit memindex_ nstubs : "<<memindex_<<" "<<nstubs<<" "<<memstubs_.to_string(2)<<std::endl;

  if (nstubs==0) {
    idle_=true;
    return;
  }

  if (full())
    return;

  ap_uint<3> ibin(slot_+next);

  ap_uint<12> stubadd( ((ireg, ibin),istub_) );

  std::cout << "istub_ ireg, slot_ next : "<<istub_<<" "<<ireg<<" "<<slot_<<" "<<next<<" "<<(ireg, ibin)
	    <<" nEntries : "<<outervmstubs_.getEntries(bx_,(ireg,ibin))<<std::endl;

  if (nstubs!=outervmstubs_.getEntries(bx_,(ireg,ibin))) {
    std::cout << "ERROR number of stubs not correct " << nstubs << " " << outervmstubs_.getEntries(bx_,(ireg,ibin)) << "ireg = "<<ireg<<" next = " << next<< " slot_ = "<<slot_<<" ibin = "<<ibin<<std::endl;
  }

  const auto& outervmstub = outervmstubs_.read_mem(bx_,stubadd);


  const auto& finephi = outervmstub.getFinePhi();
  const auto& rzbin = (next, outervmstub.getFineZ()); 

  std::cout << "finephi : "<<finephi<<std::endl;

  ap_uint<2> iAllstub=1; //FIXME need to be template parameter
  ap_uint<8> outerfinephi = ((iAllstub, ireg), finephi);

  //ap_uint<8> innerfinephi = innerstub_.getPhi().range(AllStubBase<BARRELPS>::kASPhiSize-1,AllStubBase<BARRELPS>::kASPhiSize-8);

  int nbitsfinephidiff=5;

  int idphi =  outerfinephi - innerfinephi_;
  bool inrange = abs(idphi) < (1<<(nbitsfinephidiff));

  std::cout << "TEUnit outerfinephi innerfinephi idphi inrange : " << outerfinephi<<" "<<innerfinephi_ 
	    << " " << idphi<<" "<<inrange<<std::endl;

  if (idphi<0) idphi+=(1<<nbitsfinephidiff);

  if  (!(rzbin<rzbinfirst_ || rzbin > rzbinfirst_ + rzbindiffmax_)) {

    const auto& outerbend = outervmstub.getBend();
    const auto& innerbend = innerstub_.getBend();

    auto ptinnerindex = (idphi, innerbend);
    auto ptouterindex = (idphi, outerbend);
    
    std::cout << "TEUnit *** Will lookup ptinnerindex ptouterindex inrange innerLUT outerLUT: "
	      <<ptinnerindex<<" "<<ptouterindex<<" "<<inrange<<" "
	      << ptinnerLUT[ptinnerindex] << " " << ptouterLUT[ptouterindex]<<std::endl;
    if (inrange && ptinnerLUT[ptinnerindex] && ptouterLUT[ptouterindex]){
      std::cout << "TEUnit $$$$ Found valid stub pair outer vmstub index : " <<outervmstub.getIndex() 
		<< " outervmstub = "<<outervmstub.raw().to_string(2)<<std::endl;
      write( (outervmstub.getIndex(), innerstub_.raw()) );
    }
  }
    
  std::cout << "Done with TEUnit step" << std::endl;

  istub_++;
  if(istub_==nstubs) {
    istub_=0;
    memindex_++;
    if (memindex_==0) {
      idle_=true;
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

 ap_uint<8> innerfinephi_;
 AllStub<BARRELPS> innerstub_; 

 const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs_;

 INDEX writeindex_;
 INDEX readindex_;
 //NSTUBS nstubs_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 STUBID stubids_[1<<TrackletEngineUnitBase::kNBitsBuffer];

}; // end class


#endif
