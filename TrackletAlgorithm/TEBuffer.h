#ifndef TrackletAlgorithm_TEBuffer_h
#define TrackletAlgorithm_TEBuffer_h

#include "Constants.h"
#include "MemoryTemplate.h"
#include "AllStubMemory.h"

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
    kTEDatainnerfinephiLSB = kTEDatastartMSB + 1,
    kTEDatainnerfinephiMSB = kTEDatainnerfinephiLSB + 3 - 1,
    kTEDatarzdiffmaxLSB = kTEDatainnerfinephiMSB + 1,
    kTEDatarzdiffmaxMSB = kTEDatarzdiffmaxLSB + 3 - 1,
    kTEDatainnerbendLSB = kTEDatarzdiffmaxMSB + 1,
    kTEDatainnerbendMSB = kTEDatainnerbendLSB + 3 - 1,
    kTEDataAllStubLSB = kTEDatainnerbendMSB + 1,
    kTEDataAllStubMSB = kTEDataAllStubLSB + AllStub<BARRELPS>::kAllStubSize - 1,
    kTEDatafinephiLSB = kTEDataAllStubMSB + 1,
    kTEDatafinephiMSB = kTEDatafinephiLSB + 8 - 1
  };

  typedef ap_uint<3> RZBINFIRST;
  typedef ap_uint<3> START;
  typedef ap_uint<3> INNERFINEPHI;
  typedef ap_uint<3> RZDIFFMAX;
  typedef ap_uint<3> INNERBEND;
  typedef ap_uint<8> FINEPHI;
  typedef ap_uint<kTEDatafinephiMSB+1> TEDATA;

 TEData():
  data_(0)
    {}

  AllStub<BARRELPS>::AllStubData getAllStub() const {
    return data_.range(kTEDataAllStubMSB,kTEDataAllStubLSB);
  }

  START getStart() const {
    return data_.range(kTEDatastartMSB,kTEDatastartLSB);
  }

  FINEPHI getfinephi() const {
    return data_.range(kTEDatafinephiMSB,kTEDatafinephiLSB);
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
	 const INNERFINEPHI innerfinephi, 
	 const RZDIFFMAX rzdiffmax, 
	 const INNERBEND innerbend, 
	 const AllStub<BARRELPS>::AllStubData stub,
	 const FINEPHI finephi):
  data_( (((((((finephi,stub),innerbend),rzdiffmax),innerfinephi),start),rzbinfirst),nstub) )
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
