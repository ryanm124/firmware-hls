#ifndef TrackletAlgorithm_TEBuffer_h
#define TrackletAlgorithm_TEBuffer_h

#include "Constants.h"
#include "MemoryTemplate.h"
#include "AllStubInnerMemory.h"
#include "TrackletEngineUnit.h"

class TEData {

 public:
  enum BitLocations {
    // The location of the least significant bit (LSB) and most significant bit (MSB) in the ProjectionRouterBufferMemory word for different fields
    kTEDataStubMaskLSB = 0,
    kTEDataStubMaskMSB = kTEDataStubMaskLSB + 2*(1<<TrackletEngineUnit<BARRELPS>::kNBitsPhiBins) - 1,
    kTEDatarzbinfirstLSB = kTEDataStubMaskMSB+1,
    kTEDatarzbinfirstMSB = kTEDatarzbinfirstLSB + TrackletEngineUnit<BARRELPS>::kNBitsRZFine - 1,
    kTEDatastartLSB = kTEDatarzbinfirstMSB + 1,
    kTEDatastartMSB = kTEDatastartLSB + TrackletEngineUnit<BARRELPS>::kNBitsRZBin - 1,
    kTEDatarzdiffmaxLSB = kTEDatastartMSB + 1,
    kTEDatarzdiffmaxMSB = kTEDatarzdiffmaxLSB + TrackletEngineUnit<BARRELPS>::kNBitsRZFine - 1,
    kTEDataAllStubLSB = kTEDatarzdiffmaxMSB + 1,
    kTEDataAllStubMSB = kTEDataAllStubLSB + AllStubInner<BARRELPS>::kAllStubInnerSize - 1
  };

  //typedef ap_uint<3> RZBINFIRST;
  //typedef ap_uint<3> START;
  //typedef ap_uint<3> RZDIFFMAX;
  typedef ap_uint<kTEDataAllStubMSB+1> TEDATA;

 TEData():
  data_(0)
    {}

  AllStubInner<BARRELPS>::AllStubInnerData getAllStub() const {
    return data_.range(kTEDataAllStubMSB,kTEDataAllStubLSB);
  }

  TrackletEngineUnit<BARRELPS>::RZBIN getStart() const {
    return data_.range(kTEDatastartMSB,kTEDatastartLSB);
  }

  TrackletEngineUnit<BARRELPS>::RZFINE getrzbinfirst() const {
    return data_.range(kTEDatarzbinfirstMSB,kTEDatarzbinfirstLSB);
  }

  TrackletEngineUnit<BARRELPS>::RZFINE getrzdiffmax() const {
    return data_.range(kTEDatarzdiffmaxMSB,kTEDatarzdiffmaxLSB);
  }


  ap_uint<16> getStubMask() const {
    return data_.range(kTEDataStubMaskMSB,kTEDataStubMaskLSB);
  }

 TEData(const TEData& tedata):
  data_(tedata.data_)
  {}

 TEData(const TEDATA& tedata):
  data_(tedata)
  {}
  
 TEData( const ap_uint<16> stubmask,
	 const TrackletEngineUnit<BARRELPS>::RZFINE rzbinfirst, 
	 const TrackletEngineUnit<BARRELPS>::RZBIN start, 
	 const TrackletEngineUnit<BARRELPS>::RZFINE rzdiffmax, 
	 const AllStubInner<BARRELPS>::AllStubInnerData stub
	 ):
  data_( (stub, rzdiffmax, start, rzbinfirst, stubmask) )
    {}

  TEDATA raw() const {return data_;}
  
 private:

  TEDATA data_;

};
  

// Data object definition
class TEBuffer {

 public:

  // Constructors
 TEBuffer():
  writeptr_(0), readptr_(0), istub_(0), imem_(0), imembegin_(0), imemend_(0)
    {
#pragma HLS array_partition variable=buffer_ complete dim=0
}

  void setMemBegin(ap_uint<2> begin) {
    imembegin_=begin;
  }
  
  void setMemEnd(ap_uint<2> end) {
    imemend_=end;
  }

  void reset() {
    imem_=imembegin_;
    writeptr_=0;
    readptr_=0;
  }

  ap_uint<2>& getMem() {
    return imem_;
  }

  ap_uint<2> getMemEnd() {
    return imemend_;
  }

  ap_uint<7>& getIStub() {
    return istub_;
  }

  void setIStub(ap_uint<7> istub) {
    istub_=istub;
  }

  void store(const TEData::TEDATA& tedata) {
    auto writeptrtmp=writeptr_;
    buffer_[writeptrtmp]=tedata;
    writeptr_++;
  }

  TEData::TEDATA peek() const {
    return buffer_[readptr_];
  }

  void increment_readptr() {
    readptr_++;
  }

  bool full() const {
    ap_uint<3> writeptrnext=writeptr_+1;
    return ((writeptrnext)&((1<<bufferdepthbits)-1))==readptr_;
  }

  bool empty() const {
    return writeptr_==readptr_;
  }

  ap_uint<3> readptr() const {
    return readptr_;
  }

  ap_uint<3> writeptr() const {
    return writeptr_;
  }

  //should be private
  static constexpr int bufferdepthbits=3;

  ap_uint<bufferdepthbits> writeptr_, readptr_;

  ap_uint<kNBits_MemAddr> istub_;
  ap_uint<2> imem_, imembegin_, imemend_;
  
  TEData::TEDATA buffer_[1<<bufferdepthbits];
  
private:


  
};

// Memory definition
//template<int VMProjType> using ProjectionRouterBufferMemory = MemoryTemplate<ProjectionRouterBuffer<VMProjType>, 1, kNBits_MemAddr>;
// FIXME: double check number of bits for bx and for memory address

#endif
