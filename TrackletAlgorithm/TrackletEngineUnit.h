#ifndef TRACKLETENGINEUNIT_H
#define TRACKLETENGINEUNIT_H

#include "Constants.h"
#include "VMStubTEOuterMemoryCM.h"

template<int VMSTEType>
class TrackletEngineUnit {

 public:
  enum BitWidths{
    kNBitsBuffer=4,
    kNBitsRZBin=3,
    kNBitsRZFine=3,
    kNBitsPhiBins=3
  };

  typedef ap_uint<VMStubTEOuter<VMSTEType>::kVMSTEOIDSize+AllStubInner<BARRELPS>::kAllStubInnerSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<kNBitsBuffer> INDEX;
  typedef ap_uint<kNBitsRZBin> RZBIN;
  typedef ap_uint<kNBitsRZFine> RZFINE;
  typedef ap_uint<kNBitsPhiBins> PHIBIN;
  typedef ap_uint<2*(1<<kNBitsPhiBins)> MEMMASK;  //Bit mask for used bins for two RZbins
  typedef ap_uint<2*(1<<kNBitsPhiBins)*4> MEMSTUBS; //Number of stubs in bins for two RZbins //FIXME for 4


 TrackletEngineUnit() {

#pragma HLS ARRAY_PARTITION variable=stubptinnerlutnew_ complete dim=1
#pragma HLS ARRAY_PARTITION variable=stubptouterlutnew_ complete dim=1


    idle_ = true;

    ap_uint<1> stubptinnertmp[256] =
#include "../emData/TP/tables/TP_L1L2D_stubptinnercut.tab"
    
    ap_uint<1> stubptoutertmp[256] =
#include "../emData/TP/tables/TP_L1L2D_stubptoutercut.tab"

 for(unsigned int i=0;i<256;i++) {
   stubptinnerlutnew_[i] = stubptinnertmp[i];
   stubptouterlutnew_[i] = stubptoutertmp[i];
 }

  }


 inline void init(BXType bxin, 
		  AllStubInner<BARRELPS>::AllStubInnerData innerstub,
		  MEMSTUBS memstubs,
		  MEMMASK memmask,
		  RZBIN slot,
		  RZFINE rzbinfirst,
		  RZFINE rzbindiffmax
 ) {
#pragma HLS inline
  bx_ = bxin;
  //memstubs_ = memstubs;
  idle_ = false;
  memmask_ = memmask;
  maskmask_ = 0xFFFFFFFF;
  masktmp=memmask;

  (ns15,ns14,ns13,ns12,ns11,ns10,ns9,ns8,ns7,ns6,ns5,ns4,ns3,ns2,ns1,ns0)=memstubs;

  (memindex,nstubs) = masktmp.test(0) ? (ap_uint<4>(0),ns0) :
     masktmp.test(1) ? (ap_uint<4>(1),ns1) :
     masktmp.test(2) ? (ap_uint<4>(2),ns2) :
     masktmp.test(3) ? (ap_uint<4>(3),ns3) :
     masktmp.test(4) ? (ap_uint<4>(4),ns4) :
     masktmp.test(5) ? (ap_uint<4>(5),ns5) :
     masktmp.test(6) ? (ap_uint<4>(6),ns6) :
     masktmp.test(7) ? (ap_uint<4>(7),ns7) :
     masktmp.test(8) ? (ap_uint<4>(8),ns8) :
     masktmp.test(9) ? (ap_uint<4>(9),ns9) :
     masktmp.test(10) ? (ap_uint<4>(10),ns10) :
     masktmp.test(11) ? (ap_uint<4>(11),ns11) :
     masktmp.test(12) ? (ap_uint<4>(12),ns12) :
     masktmp.test(13) ? (ap_uint<4>(13),ns13) :
     masktmp.test(14) ? (ap_uint<4>(14),ns14) :
     (ap_uint<4>(15),ns15);


  istub_=0;
  istubnext_=1;
  innerstub_=innerstub;
  slot_=slot;
  rzbinfirst_=rzbinfirst;
  //rzbinlast_=rzbinfirst+rzbindiffmax;
  rzbindiffmax_=rzbindiffmax;
}
 

 void reset(int instance) {
   writeindex_ = 0;
   readindex_ = 0;
   idle_ = true;
   good__=0;
   good___=0;
   good____=0;
   instance_=instance;
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
#pragma HLS inline  
  return (writeindex_+1==readindex_);
}

bool nearfull() {
#pragma HLS inline  
  return ((writeindex_+2==readindex_)||(writeindex_+1==readindex_));
}

STUBID read() {
#pragma HLS inline  
  return stubids_[readindex_++];
}

void write(STUBID stubs) {
#pragma HLS inline  
  stubids_[writeindex_++]=stubs;
}

// Commented out since now explicitly inlined
// void step( BXType bxin, 
//		   const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs,
//		   bool nearfull,
//		   ap_uint<1> init,
//		   AllStubInner<BARRELPS>::AllStubInnerData innerstub,
//		   ap_uint<64> memstubs,
//		   ap_uint<16> memmask,
//		   ap_uint<3> slot,
//		   ap_uint<3> rzbinfirst,
//		   ap_uint<3> rzbindiffmax) { }

 //ap_uint<64> memstubs_;
 ap_uint<16> memmask_;
 ap_uint<16> maskmask_;

 ap_uint<3> slot_;
 //ap_uint<4> rzbinlast_;
 ap_uint<3> rzbinfirst_;
 ap_uint<3> rzbindiffmax_;
 ap_uint<3> rzbinfirst__, rzbinfirst___, rzbinfirst____;
 ap_uint<3> rzbindiffmax__, rzbindiffmax___, rzbindiffmax____;

 ap_uint<16> masktmp;
 ap_uint<4> nstubs;
 ap_uint<4> memindex;
 ap_uint<1> next;
 ap_uint<3> ireg;


 AllStubInner<BARRELPS> innerstub_,innerstub__, innerstub___, innerstub____; 
 ap_uint<1> good__, good___, good____;
 ap_uint<1> next__, next___, next____;
 ap_uint<3> ireg__, ireg___, ireg____;

 VMStubTEOuter<VMSTEType> outervmstub__, outervmstub___, outervmstub____;

 ap_uint<4> ns0,ns1,ns2,ns3,ns4,ns5,ns6,ns7,ns8,ns9,ns10,ns11,ns12,ns13,ns14,ns15;

 INDEX writeindex_;
 INDEX readindex_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 NSTUBS istubnext_=1;
 STUBID stubids_[1<<kNBitsBuffer];

 int instance_;

 ap_uint<1> stubptinnerlutnew_[256];    
 ap_uint<1> stubptouterlutnew_[256];


 private:

}; // end class


#endif
