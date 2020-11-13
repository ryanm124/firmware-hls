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

 TrackletEngineUnit() {
    idle_ = true;
  }


 inline void init(BXType bxin, 
		  AllStubInner<BARRELPS>::AllStubInnerData innerstub,
		  ap_uint<64> memstubs,
		  ap_uint<16> memmask,
		  ap_uint<3> slot,
		  ap_uint<3> rzbinfirst,
		  ap_uint<3> rzbindiffmax
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

 inline void step( BXType bxin, 
		   const VMStubTEOuterMemoryCM<VMSTEType> &outervmstubs,
		   const ap_uint<1> ptinnerLUT[256], 
		   const ap_uint<1> ptouterLUT[256],
		   bool nearfull,
		   ap_uint<1> init,
		   AllStubInner<BARRELPS>::AllStubInnerData innerstub,
		   ap_uint<64> memstubs,
		   ap_uint<16> memmask,
		   ap_uint<3> slot,
		   ap_uint<3> rzbinfirst,
		   ap_uint<3> rzbindiffmax) {
#pragma HLS inline
#pragma HLS PIPELINE II=1
#pragma HLS dependence variable=istub_ intra WAR true   
#pragma HLS dependence variable=next intra WAR true   
#pragma HLS dependence variable=next__ intra WAR true   

   //second step

   const auto& finephi = outervmstub__.getFinePhi();
   const auto& rzbin = (next__, outervmstub__.getFineZ()); 

   ap_uint<2> iAllstub=1; //FIXME need to be template parameter
   ap_uint<8> outerfinephi = (iAllstub, ireg__, finephi);
   
   ap_uint<5> idphi;
   ap_uint<3> overflow;
   (overflow,idphi) =  outerfinephi - AllStubInner<BARRELPS>(innerstub_).getFinePhi();

   bool inrange = overflow==0||overflow==7;

   bool rzcut=!(rzbin<rzbinfirst__ || rzbin > rzbinfirst__+rzbindiffmax__);

   const auto& outerbend = outervmstub__.getBend();
   const auto& innerbend = innerstub__.getBend();
     
   auto ptinnerindex = (idphi, innerbend);
   auto ptouterindex = (idphi, outerbend);
   
   ap_uint<1> savestub = good__&&inrange && ptinnerLUT[ptinnerindex] && ptouterLUT[ptouterindex] && rzcut;

   stubids_[writeindex_] = (outervmstub__.getIndex(), innerstub__.raw());
   writeindex_=writeindex_+savestub;

   //first step

   //if (init) {
   //  std::cout << "Initialize TEU:"<<instance_<<std::endl;
   //}     

   bx_=bxin;
   innerstub_ = init?innerstub:innerstub_;
   //istub_=init?ap_uint<4>(0):istub_;
   slot_=init?slot:slot_;
   rzbinfirst_=init?rzbinfirst:rzbinfirst_;
   rzbindiffmax_=init?rzbindiffmax:rzbindiffmax_;
   idle_ = init ? false : idle_;
   memmask_ = init?memmask:memmask_;
   maskmask_ = init?ap_uint<16>(0xFFFF):maskmask_;
   masktmp = init?memmask:masktmp;

   (ns15,ns14,ns13,ns12,ns11,ns10,ns9,ns8,ns7,ns6,ns5,ns4,ns3,ns2,ns1,ns0) = 
     init?memstubs:(ns15,ns14,ns13,ns12,ns11,ns10,ns9,ns8,ns7,ns6,ns5,ns4,ns3,ns2,ns1,ns0);

 
   //bool good=!(idle()||nearfull);
   bool good=(!nearfull)&&(!init);

   
   ap_uint<3> ibin(slot_+next);
   ap_uint<12> stubadd( (ibin, ireg, istub_) );

#ifndef __SYNTHESIS__
   if (good) {
     assert(nstubs!=0);
     assert(nstubs==outervmstubs.getEntries(bx_,(ibin, ireg)));
   }
#endif
   
   NSTUBS zero(0);
   NSTUBS istubtmp=istub_+1;
   ap_uint<5> xorstubs=(istubtmp^nstubs, ap_uint<1>(nearfull));
   //ap_uint<5> xorstubs=(istubtmp^nstubs, ap_uint<1>(!good));

   //ap_uint<1> notallstubs=istubtmp!=nstubs||(!good);
   ap_uint<1> notallstubs=xorstubs.or_reduce();
   istub_=init?zero:good?(notallstubs?istubtmp:zero):istub_;
   //ap_uint<1> notallstubs=istubtmp!=nstubs;
   //istub_=notallstubs?istubtmp:zero;
   maskmask_.range(memindex,memindex)=notallstubs;

   masktmp=memmask_&maskmask_;

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

   next__=next;
   ireg__=ireg;

   (next, ireg)=memindex;

   idle_=idle_||(!masktmp.or_reduce());

   const auto& outervmstub = outervmstubs.read_mem(bx_,stubadd);

   outervmstub__=outervmstub;
   rzbinfirst__=rzbinfirst_;
   rzbindiffmax__=rzbindiffmax_;
   innerstub__=innerstub_;
   good__=good;

   return;

} // end step
 

 //ap_uint<64> memstubs_;
 ap_uint<16> memmask_;
 ap_uint<16> maskmask_;

 ap_uint<3> slot_;
 //ap_uint<4> rzbinlast_;
 ap_uint<3> rzbinfirst_;
 ap_uint<3> rzbindiffmax_;
 ap_uint<3> rzbinfirst__;
 ap_uint<3> rzbindiffmax__;

 ap_uint<16> masktmp;
 ap_uint<4> nstubs;
 ap_uint<4> memindex;
 ap_uint<1> next;
 ap_uint<3> ireg;


 AllStubInner<BARRELPS> innerstub_,innerstub__; 
 ap_uint<1> good__;
 ap_uint<1> next__;
 ap_uint<3> ireg__;

 VMStubTEOuter<VMSTEType> outervmstub__;

 ap_uint<4> ns0,ns1,ns2,ns3,ns4,ns5,ns6,ns7,ns8,ns9,ns10,ns11,ns12,ns13,ns14,ns15;

 INDEX writeindex_;
 INDEX readindex_;
 bool idle_;
 BXType bx_;
 
 NSTUBS istub_=0;
 STUBID stubids_[1<<TrackletEngineUnitBase::kNBitsBuffer];

 int instance_;

 private:

}; // end class


#endif
