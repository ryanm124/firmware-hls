#ifndef TRACKLETENGINEUNIT_H
#define TRACKLETENGINEUNIT_H

#include "Constants.h"
#include "VMStubTEOuterMemoryCM.h"

template<int VMSTEType>
class TrackletEngineUnit {

 public:
  enum BitWidths{
    kNBitsBuffer=3,
    kNBitsRZBin=3,
    kNBitsRZFine=3,
    kNBitsPhiBins=3,
    kNBitsPTLut=256
  };

  typedef ap_uint<VMStubTEOuter<VMSTEType>::kVMSTEOIDSize+AllStubInner<BARRELPS>::kAllStubInnerSize> STUBID;
  typedef ap_uint<kNBits_MemAddrBinned> NSTUBS;
  typedef ap_uint<kNBitsBuffer> INDEX;
  typedef ap_uint<kNBitsRZBin> RZBIN;
  typedef ap_uint<kNBitsRZFine> RZFINE;
  typedef ap_uint<kNBitsPhiBins> PHIBIN;
  typedef ap_uint<kNBitsPhiBins+1> MEMINDEX;  //Index into MEMMASK and MEMSTUBS
  typedef ap_uint<2*(1<<kNBitsPhiBins)> MEMMASK;  //Bit mask for used bins for two RZbins
  typedef ap_uint<2*(1<<kNBitsPhiBins)*4> MEMSTUBS; //Number of stubs in bins for two RZbins //FIXME for 4


 TrackletEngineUnit() {

#pragma HLS ARRAY_PARTITION variable=stubptinnerlutnew_ complete dim=1
#pragma HLS ARRAY_PARTITION variable=stubptouterlutnew_ complete dim=1


    idle_ = true;

    ap_uint<1> stubptinnertmp[kNBitsPTLut] =
#include "../emData/TP/tables/TP_L1L2D_stubptinnercut.tab"
    
    ap_uint<1> stubptoutertmp[kNBitsPTLut] =
#include "../emData/TP/tables/TP_L1L2D_stubptoutercut.tab"

 for(unsigned int i=0;i<kNBitsPTLut;i++) {
   stubptinnerlutnew_[i] = stubptinnertmp[i];
   stubptouterlutnew_[i] = stubptoutertmp[i];
 }

  }


 MEMSTUBS nstub16() const {
#pragma HLS array_partition variable=ns complete dim=1
   return (ns[15],ns[14],ns[13],ns[12],ns[11],ns[10],ns[9],ns[8],ns[7],ns[6],ns[5],ns[4],ns[3],ns[2],ns[1],ns[0]);
 }

 void setnstub16(MEMSTUBS nstubs) {
#pragma HLS array_partition variable=ns complete dim=1
   (ns[15],ns[14],ns[13],ns[12],ns[11],ns[10],ns[9],ns[8],ns[7],ns[6],ns[5],ns[4],ns[3],ns[2],ns[1],ns[0]) = nstubs;
 }

 void setnstub2(MEMINDEX index) {
#pragma HLS array_partition variable=ns complete dim=1

   nstubs = ns[index];
 }

 void setnstub(MEMMASK masktmp) {
#pragma HLS array_partition variable=ns complete dim=1

   nstubs = masktmp.test(0) ? ns[0] :
     masktmp.test(1) ? ns[1] :
     masktmp.test(2) ? ns[2] :
     masktmp.test(3) ? ns[3] :
     masktmp.test(4) ? ns[4] :
     masktmp.test(5) ? ns[5] :
     masktmp.test(6) ? ns[6] :
     masktmp.test(7) ? ns[7] :
     masktmp.test(8) ? ns[8] :
     masktmp.test(9) ? ns[9] :
     masktmp.test(10) ? ns[10] :
     masktmp.test(11) ? ns[11] :
     masktmp.test(12) ? ns[12] :
     masktmp.test(13) ? ns[13] :
     masktmp.test(14) ? ns[14] : ns[15];
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

 MEMMASK memmask_;

 RZBIN slot_;
 RZFINE rzbinfirst_;
 RZFINE rzbindiffmax_;
 RZFINE rzbinfirst__, rzbinfirst___, rzbinfirst____;
 RZFINE rzbindiffmax__, rzbindiffmax___, rzbindiffmax____;

 NSTUBS nstubs;
 MEMINDEX memindex;
 ap_uint<1> next;
 PHIBIN ireg;


 AllStubInner<BARRELPS> innerstub_,innerstub__, innerstub___, innerstub____; 
 ap_uint<1> good__, good___, good____;
 ap_uint<1> next__, next___, next____;
 PHIBIN ireg__, ireg___, ireg____;

 VMStubTEOuter<VMSTEType> outervmstub__, outervmstub___, outervmstub____;

 //NSTUBS ns0,ns1,ns2,ns3,ns4,ns5,ns6,ns7,ns8,ns9,ns10,ns11,ns12,ns13,ns14,ns15;
 NSTUBS ns[16];

 INDEX writeindex_;
 INDEX readindex_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 NSTUBS istubnext_=1;
 STUBID stubids_[1<<kNBitsBuffer];

 int instance_;

 ap_uint<1> stubptinnerlutnew_[kNBitsPTLut];    
 ap_uint<1> stubptouterlutnew_[kNBitsPTLut];


 private:

}; // end class


#endif
