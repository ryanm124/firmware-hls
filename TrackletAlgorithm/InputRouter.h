#ifndef TrackletAlgorithm_InputRouter_h
#define TrackletAlgorithm_InputRouter_h


#include <cassert>
#include "Constants.h"
#include "AllStubMemory.h"
#include "DTCStubMemory.h"


// link map
static const int kNBitsLnkDsc = 4; 
static const int kNBitsNLnks = 6; 
static const int kLINKMAPwidth = 20;
static const int kSizeLinkWord = 4; 
static const int kBINMAPwidth = 12; 
static const int kSizeBinWord =  3; 
static const int kNMEMwidth = 5;
#ifndef __SYNTHESIS__
	#include <bitset> 
#endif



// // maximum number of IR memories 
// constexpr unsigned int kNIRMemories = 20;

// mxm number of coarse phi bins 
constexpr int kMaxPhiBnsPrLyr = 8; 

// mxmium number of layers readout by a DTC 
static const int kMaxLyrsPerDTC = 4; 

// Number of MSBs used for r index in phicorr LUTs
static const int kNBitsPhiCorrTableR = 3; // Found hardcoded in VMRouterphicorrtable.h
// size of link LUT 
static const int kSizeLinkTable = 12;
// size of phi correction table 
// for barrel PS
static const int kSizePhiCorrTablePS = 64;
// size of phi correction table 
// for barrel 2S
static const int kSizePhiCorrTable2S = 128;
// number of phi bins IR sorts 
// stubs into for first PS barrel 
static const int kNbitsPhiBinsPSL1 = 3; 
// number of phi bins IR sorts 
// stubs into for all regions of 
// the tracker 
// except for PS L1
static const int kNbitsPhiBinsTkr = 2; 

// typedefs
// encoded DTC layer id 
static const unsigned int kNBitsDTCLyrEnc=3;
typedef ap_uint<kNBitsDTCLyrEnc> EncodedDTCLyrId ;
// raw trakcker layer id 
static const unsigned int kNBitsLyrTk=3; 
typedef ap_uint<kNBitsLyrTk> TkLyrId ;
// barrel bit 
static const unsigned int kNBitsBrlBit=1;
typedef ap_uint<kNBitsBrlBit> BrlBit; 
//
static const unsigned int kNBitsPhi=3; 
typedef ap_uint<kNBitsPhi> LyrPhiBn; 
// link word 
typedef ap_uint<kSizeLinkWord> LnkWrd;

// 
static const int kNBrlLyrs = 3;
static const int kFrstPSBrlLyr = 1; 
static const int kScndPSBrlLyr = 2;
static const int kThrdPSBrlLyr = 3; 
static const int kFrst2SBrlLyr = 4; 
static const int kScnd2SBrlLyr = 5; 
static const int kThrd2SBrlLyr = 6; 
// valid bit in DTC stub 
// these can change when tarball is modified 
static const int kLSBVldBt = 0;//kNBits_DTC-1;//0;
static const int kMSBVldBt = 0;//kNBits_DTC-1;//0; 
// lyr bit in DTC stub 
// these can change when tarball is modified 
static const int kLyBitsSize = 2; 
static const int kLSBLyrBts = 1;//kNBits_DTC - 3;//1; 
static const int kMSBLyrBts = 2;//kNBits_DTC - 2;//2; 

constexpr unsigned int kMaxNmemories = 20;  
#define IR_DEBUG true

// Get the corrected phi, i.e. phi at the average radius of the barrel
// Corrected phi is used by ME and TE memories in the barrel
template<regionType InType>
inline typename AllStub<InType>::ASPHI getPhiCorr(
		const typename AllStub<InType>::ASPHI phi,
		const typename AllStub<InType>::ASR r,
		const typename AllStub<InType>::ASBEND bend, const int phicorrtable[]) 
{
	
	#pragma HLS array_partition variable = phicorrtable complete
	constexpr auto rbins = 1 << kNBitsPhiCorrTableR; // The number of bins for r

	ap_uint<kNBitsPhiCorrTableR> rbin = (r + (1 << (r.length() - 1)))
			>> (r.length() - kNBitsPhiCorrTableR); // Which bin r belongs to. Note r = 0 is mid radius
	auto index = bend * rbins + rbin; // Index for where we find our correction value
	auto corrval = phicorrtable[index]; // The amount we need to correct our phi

	// make phi un-signed 
	auto cPhi = phi + (1 << (AllStub<InType>::kASPhiSize- 1));//phi
	#ifndef __SYNTHESIS__
	  	std::cout << "\t\t.. phi is " << phi << " which when un-signed is " << cPhi << "\n";
	#endif
	auto phicorr = cPhi- corrval; // the corrected phi

	// Check for overflow
	if (phicorr < 0)
		phicorr = 0; // can't be less than 0
	if (phicorr >= 1 << phi.length())
		phicorr = (1 << phi.length()) - 1;  // can't be more than the max value

	return phicorr;

	// auto rbins = 1 << kNBitsPhiCorrTableR; // The number of bins for r
	// auto rbin = (r + (1 << (r.length() - 1))) >> (r.length() - kNBitsPhiCorrTableR); // Which bin r belongs to. Note r = 0 is mid radius
	// auto index = bend * rbins + rbin; // Index for where we find our correction value
	// auto corrval = phicorrtable[index]; // The amount we need to correct our phi
	// auto phicorr = ((phi) - corrval); // the corrected phi
	
	// // Check for overflow
	// if (phicorr < 0)
	// 	phicorr = 0; // can't be less than 0
	// if (phicorr >= 1 << phi.length())
	// 	phicorr = (1 << phi.length()) - 1;  // can't be more than the max value

	// return phicorr;
}

template<unsigned int nEntriesSize>
void ClearCounters(unsigned int nMemories
	, ap_uint<kNBits_MemAddr> nEntries[nEntriesSize]) 
{
  #pragma HLS inline
  #pragma HLS array_partition variable = nEntries complete
  LOOP_ClearCounters:
	for (int cIndx = 0; cIndx < nEntriesSize ; cIndx++) 
  {
    #pragma HLS unroll
    nEntries[cIndx]=0; 
  }
}

template<unsigned int nLyrs>
void CountMemories(const ap_uint<kBINMAPwidth> hPhBnWord 
	, unsigned int &nMems
	, unsigned int nMemsPerLyr[nLyrs]) 
{
  #pragma HLS inline
  #pragma HLS array_partition variable = nMemsPerLyr complete
  int cPrevSize=0; 
  LOOP_CountOutputMemories:
  for (int cLyr = 0; cLyr < nLyrs ; cLyr++) 
  {
     #pragma HLS unroll
     auto hBnWrd = hPhBnWord.range(kSizeBinWord * cLyr + (kSizeBinWord-1), kSizeBinWord * cLyr);
     nMemsPerLyr[cLyr] = (1+(int)(hBnWrd)); 
     nMems = cPrevSize +  (1+(int)(hBnWrd)); 
     cPrevSize = nMems;
  }
}

template<unsigned int nLyrs>
void GetMemoryIndex(unsigned int nMemsPerLyr[nLyrs]
	, ap_uint<kLyBitsSize> hEncLyr 
	, unsigned int &hIndx ) 
{
  #pragma HLS inline
  #pragma HLS array_partition variable = nMemsPerLyr complete
	// update index
	int cPrevIndx=0; 
	LOOP_UpdateMemIndx:
	for (int cLyr = 0; cLyr < nLyrs; cLyr++) 
	{
	#pragma HLS unroll
		int cUpdate = (cLyr < hEncLyr) ? nMemsPerLyr[cLyr] : 0; 
		hIndx = cPrevIndx + cUpdate; 
		cPrevIndx = hIndx;
	}
}

template<unsigned int nOMems, unsigned int nLUTEntries>
void InputRouter( const BXType hBx
	, const ap_uint<kLINKMAPwidth> hLinkWord
	, const ap_uint<kBINMAPwidth> hPhBnWord 
	, const int hPhiCorrtable_L1[nLUTEntries]
	, const int hPhiCorrtable_L2[nLUTEntries]
	, const int hPhiCorrtable_L3[nLUTEntries]
	, ap_uint<kNBits_DTC>* hInputStubs
	, DTCStubMemory hOutputStubs[nOMems])
{
	
	#pragma HLS inline
	#pragma HLS interface ap_memory port = hPhiCorrtable_L1
  	#pragma HLS interface ap_memory port = hPhiCorrtable_L2
  	#pragma HLS interface ap_memory port = hPhiCorrtable_L3
  
  	ap_uint<1> hIs2S= hLinkWord.range(kLINKMAPwidth-4,kLINKMAPwidth-4);

	// count memories 
	unsigned int nMems=0;
	unsigned int nMemsPerLyr[kMaxLyrsPerDTC]; 
	CountMemories<kMaxLyrsPerDTC>(hPhBnWord, nMems, nMemsPerLyr);
	// clear stub counters
	ap_uint<kNBits_MemAddr> hNStubs[nOMems];
	ClearCounters<nOMems>(nMems,  hNStubs);

	LOOP_ProcessIR:
	for (int cStubCounter = 0; cStubCounter < kMaxStubsFromLink; cStubCounter++) 
	{
	#pragma HLS pipeline II = 1
	//#pragma HLS PIPELINE rewind
	  // decode stub
	  // check which memory
	  auto hStub = hInputStubs[cStubCounter];
	  // add check of valid bit here 
	  if (hStub == 0)   continue;
	  // check valid bit
	  auto hVldBt = hStub.range( kMSBVldBt ,  kLSBVldBt);
	  if( hVldBt == 0 ) continue;
	  // encoded layer 
	  auto hEncLyr = hStub.range(kMSBLyrBts, kLSBLyrBts);
	  // get memory word
	  auto hStbWrd = ap_uint<kBRAMwidth>(hStub.range(kBRAMwidth - 1, 0));
	  DTCStub hMemWord(hStbWrd);
	    
	  // decode link wrd for this layer
	  auto hIsBrl= hLinkWord.range((kNBitsBrlBit-1) + kSizeLinkWord * hEncLyr, kSizeLinkWord * hEncLyr);
	  auto hLyrId= hLinkWord.range((kNBitsLyrTk-1) + kSizeLinkWord * hEncLyr + kNBitsBrlBit, kNBitsBrlBit + kSizeLinkWord * hEncLyr);
	  
	  // point to the correct 
	  // LUT with the phi 
	  // corrections 
	  static const int* cLUT; 
	  if( hLyrId == kFrstPSBrlLyr || hLyrId == kFrst2SBrlLyr ) 
	  	cLUT = hPhiCorrtable_L1;
	  else if( hLyrId == kScndPSBrlLyr || hLyrId == kScnd2SBrlLyr ) 
	  	cLUT = hPhiCorrtable_L2;
	  else if( hLyrId == kThrdPSBrlLyr || hLyrId == kThrd2SBrlLyr )
	  	cLUT = hPhiCorrtable_L3;
	  
	  // update index
	  unsigned int cIndx = 0;
	  GetMemoryIndex<kMaxLyrsPerDTC>( nMemsPerLyr, hEncLyr, cIndx);
	  // get phi bin
	  int cIndxThisBn = 0;
	  if( hIsBrl == 1 && hIs2S == 0 )
	  {
	  	auto cOffset = (hLyrId == kFrstPSBrlLyr) ? kNbitsPhiBinsPSL1 : kNbitsPhiBinsTkr; 
	  	AllStub<BARRELPS> hAStub(hStub.range(kNBits_DTC-1,0));
		auto hPhiCorrected = getPhiCorr<BARRELPS>(hAStub.getPhi(), hAStub.getR(), hAStub.getBend(), cLUT); 
		auto hPhiBn = hPhiCorrected.range(hPhiCorrected.length()-1, hPhiCorrected.length()-cOffset);
	  	cIndxThisBn =  hPhiBn;
	  }
	  else if( hIsBrl == 0 && hIs2S == 0 )
	  {
	  	auto hPhiMSB = AllStub<DISKPS>::kASPhiMSB;
		auto hPhiLSB = AllStub<DISKPS>::kASPhiMSB-(kNbitsPhiBinsTkr-1);
	    auto  hPhiBn = hStub.range(hPhiMSB,hPhiLSB) ;
		cIndxThisBn = hPhiBn;
	  }
	  else if( hIsBrl == 1)
	  {
	  	AllStub<BARREL2S> hAStub(hStub.range(kNBits_DTC-1,0));
	  	auto hPhiCorrected = getPhiCorr<BARREL2S>(hAStub.getPhi(), hAStub.getR(), hAStub.getBend(), cLUT); 
		auto hPhiBn = hPhiCorrected.range(hPhiCorrected.length()-1, hPhiCorrected.length()-kNbitsPhiBinsTkr);
	  	cIndxThisBn = hPhiBn;
	  }
	  else if(  hIsBrl == 0)
	  {
	  	auto hPhiMSB = AllStub<DISK2S>::kASPhiMSB;
		auto hPhiLSB = AllStub<DISK2S>::kASPhiMSB-(kNbitsPhiBinsTkr-1);
	    auto hPhiBn = hStub.range(hPhiMSB,hPhiLSB);
	    cIndxThisBn =  hPhiBn;
	  }
	  // assign memory index
	  auto cMemIndx = cIndx+cIndxThisBn;
	  //assert(cMemIndx < nMems);
	  #ifndef __SYNTHESIS__
	   std::cout << "\t.. Stub : " << std::hex << hStbWrd << std::dec
		            << " [ EncLyrId " << hEncLyr << " ] "
					<< "[ LyrId " << hLyrId << " ] "
		            << "[ IsBrl " << +hIsBrl << " ] "
					<< " [ Nmemories " << nMems << " ] "
		            << " [ IndxThisBn " << cIndxThisBn << " ] "
		            << " [ Indx " << cIndx << " ] "
		            << " [ memIndx " << cMemIndx << " ] "
		            << "\n";
	  #endif
	  
	  // #ifndef __SYNTHESIS__
	  // if( IR_DEBUG )
	  // {
	  // 	if( hEncLyr == 0 && hIsBrl ==1 )
	  // 	{
		 //  std::cout << "\t.. Stub : " << std::hex << hStbWrd << std::dec
		 //            << " [ EncLyrId " << hEncLyr << " ] "
		 //            << "[ LyrId " << hLyrId << " ] "
		 //            << "[ IsBrl " << +hIsBrl << " ] "
		 //            << "[ PhiBn " << (int)cIndxThisBn << " ] "
		 //            << " Mem#" << cMemIndx
		 //            << " [ nOMems " << +nOMems << " ] " 
 		//             << " Current number of entries " << +hEntries << "\n";
	  // 	}
	  // }
	  // #endif
	  // auto hEntries = hNStubs[0];
	  // (&hOutputStubs[0])->write_mem(hBx, hMemWord, hEntries);
	  // hNStubs[0] = hEntries + 1;
	  // update  counters 
	  auto hEntries = hNStubs[cMemIndx];
	  hNStubs[cMemIndx] = hEntries + 1;
	  // fill memory 
	  (&hOutputStubs[cMemIndx])->write_mem(hBx, hMemWord, hEntries);
	}
}


#endif


