#ifndef TrackletAlgorithm_TEBuffer_h
#define TrackletAlgorithm_TEBuffer_h

#include "Constants.h"
#include "MemoryTemplate.h"
#include "AllStubInnerMemory.h"

class TEData {

 public:
  enum BitLocations {
    // The location of the least significant bit (LSB) and most significant bit (MSB) in the ProjectionRouterBufferMemory word for different fields
    kTEDataNStubLSB = 0,
    kTEDataNStubMSB = kTEDataNStubLSB + 64 - 1,
    kTEDatarzbinfirstLSB = kTEDataNStubMSB+1,
    kTEDatarzbinfirstMSB = kTEDatarzbinfirstLSB + 3 - 1,
    kTEDatastartLSB = kTEDatarzbinfirstMSB + 1,
    kTEDatastartMSB = kTEDatastartLSB + 3 - 1,
    kTEDatarzdiffmaxLSB = kTEDatastartMSB + 1,
    kTEDatarzdiffmaxMSB = kTEDatarzdiffmaxLSB + 3 - 1,
    kTEDataAllStubLSB = kTEDatarzdiffmaxMSB + 1,
    kTEDataAllStubMSB = kTEDataAllStubLSB + AllStubInner<BARRELPS>::kAllStubInnerSize - 1
  };

  typedef ap_uint<3> RZBINFIRST;
  typedef ap_uint<3> START;
  typedef ap_uint<3> RZDIFFMAX;
  typedef ap_uint<kTEDataAllStubMSB+1> TEDATA;

 TEData():
  data_(0)
    {}

  AllStubInner<BARRELPS>::AllStubInnerData getAllStub() const {
    return data_.range(kTEDataAllStubMSB,kTEDataAllStubLSB);
  }

  START getStart() const {
    return data_.range(kTEDatastartMSB,kTEDatastartLSB);
  }

  RZBINFIRST getrzbinfirst() const {
    return data_.range(kTEDatarzbinfirstMSB,kTEDatarzbinfirstLSB);
  }

  RZDIFFMAX getrzdiffmax() const {
    return data_.range(kTEDatarzdiffmaxMSB,kTEDatarzdiffmaxLSB);
  }

  ap_uint<64> getNStub() const {
    return data_.range(kTEDataNStubMSB,kTEDataNStubLSB);
  }

 TEData(const TEData& tedata):
  data_(tedata.data_)
  {}

 TEData(const TEDATA& tedata):
  data_(tedata)
  {}
  
 TEData( const ap_uint<64> nstub, 
	 const RZBINFIRST rzbinfirst, 
	 const START start, 
	 const RZDIFFMAX rzdiffmax, 
	 const AllStubInner<BARRELPS>::AllStubInnerData stub
	 ):
  data_( (stub, rzdiffmax, start, rzbinfirst, nstub) )
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
    {}

  void setMemBegin(ap_uint<2> begin) {
    imembegin_=begin;
  }
  
  void setMemEnd(ap_uint<2> end) {
    imemend_=end;
  }

  void reset() {
    imem_=imembegin_;
    istub_=0;
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

  void setIStub(ap_uint<7>& istub) {
    istub_=istub;
  }

  void store(const TEData::TEDATA& tedata) {
    buffer_[writeptr_++]=tedata;
  }

  TEData::TEDATA read() {
    return buffer_[readptr_++];
  }

  bool full() const {
    return ((writeptr_+1)&((1<<bufferdepthbits)-1))==readptr_;
  }

  bool empty() const {
    return writeptr_==readptr_;
  }

  
private:

  static constexpr int bufferdepthbits=5;

  ap_uint<bufferdepthbits> writeptr_, readptr_;
  ap_uint<7> istub_;
  ap_uint<2> imem_, imembegin_, imemend_;
  
  TEData::TEDATA buffer_[1<<bufferdepthbits];
  
};

// Memory definition
//template<int VMProjType> using ProjectionRouterBufferMemory = MemoryTemplate<ProjectionRouterBuffer<VMProjType>, 1, kNBits_MemAddr>;
// FIXME: double check number of bits for bx and for memory address

#endif
