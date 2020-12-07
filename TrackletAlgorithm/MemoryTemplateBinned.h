// Class template for binned memory module
#ifndef TrackletAlgorithm_MemoryTemplateBinned_h
#define TrackletAlgorithm_MemoryTemplateBinned_h

#ifndef __SYNTHESIS__
#include <iostream>
#include <sstream>
#include <vector>
#endif

//Allow to swap between fully partitioned memory and large ap_uint field
//#define USE_APUINT

template<class DataType, unsigned int NBIT_BX, unsigned int NBIT_ADDR,
		 unsigned int NBIT_BIN>
// DataType: type of data object stored in the array
// NBIT_BX: number of bits for BX;
// (1<<NBIT_BIN): number of BXs the memory is keeping track of
// NBIT_ADDR: number of bits for memory address space per BX
// (1<<NBIT_ADDR): depth of the memory for each BX
// NBIT_BIN: number of bits used for binning; (1<<NBIT_BIN): number of bins
class MemoryTemplateBinned{
  typedef ap_uint<NBIT_BX> BunchXingT;
  typedef ap_uint<NBIT_ADDR-NBIT_BIN> NEntryT;
  
protected:
  enum BitWidths {
    kNBxBins = 1<<NBIT_BX,
    kNSlots = 1<<NBIT_BIN,
    kNMemDepth = 1<<NBIT_ADDR
  };

  DataType dataarray_[kNBxBins][kNMemDepth];  // data array
  NEntryT nentries_[kNBxBins][kNSlots];     // number of entries
  ap_uint<1> binmask_[kNBxBins][kNSlots];     // true if nonzero # of hits

#ifdef USE_APUINT
  ap_uint<64+8> binmask16new_;
  ap_uint<256+32> nentries16new_;
#else
  ap_uint<16> binmask16_[8];
  ap_uint<64> nentries16_[8];
#endif

  //ap_uint<16> binmask16_[kNBxBins][8];
  //ap_uint<64> nentries16_[kNBxBins][8];

  
public:

  MemoryTemplateBinned()
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
	clear();
  }
  
  ~MemoryTemplateBinned(){}
  
  void clear()
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
#pragma HLS inline
	
	for (size_t ibx=0; ibx<(kNBxBins); ++ibx) {
#pragma HLS UNROLL
	  clear(ibx);
	}
  }

  void clear(BunchXingT bx)
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
#pragma HLS ARRAY_PARTITION variable=binmask_ complete dim=0
#pragma HLS inline
	
	for (unsigned int ibin = 0; ibin < (kNSlots); ++ibin) {
#pragma HLS UNROLL
	  nentries_[bx][ibin] = 0;
	  binmask_[bx][ibin] = 0;
	}

	for (unsigned int ibin = 0; ibin < 8; ++ibin) {
#pragma HLS UNROLL
#ifdef USE_APUINT
	  binmask16new_  = 0;
#else
	  binmask16_[ibin] = 0;
#endif
	}
  }

  unsigned int getDepth() const {return kNMemDepth;}
  unsigned int getNBX() const {return kNBxBins;}
  unsigned int getNBins() const {return kNSlots;}

  NEntryT getEntries(BunchXingT bx, ap_uint<NBIT_BIN> ibin) const {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
    return nentries_[bx][ibin];
  }

  ap_uint<64> getEntries16(BunchXingT bx, ap_uint<3> ibin) const {

#ifdef USE_APUINT
    //return nentries16new_.range((ap_uint<8>(ibin)<<5)+63,(ap_uint<8>(ibin)<<5));
    return (nentries16new_>>(ap_uint<8>(ibin)<<5))&(ap_int<64>(-1));
#else
    #pragma HLS ARRAY_PARTITION variable=nentries16_ complete dim=0
    return nentries16_[ibin];
#endif
  }

  ap_uint<16> getBinMask16(BunchXingT bx, ap_uint<3> ibin) const {
#ifdef USE_APUINT
    return binmask16new_.range(8*ibin+15,8*ibin);
#else
#pragma HLS ARRAY_PARTITION variable=binmask16_ complete dim=0
    return binmask16_[ibin];
#endif
  }

  NEntryT getEntries(BunchXingT bx) const {
    NEntryT val = 0;
    for ( auto i = 0; i < getDepth(); ++i ) {
      val += getEntries(bx, i);
    }
    return val;
  }


  const DataType (&get_mem() const)[1<<NBIT_BX][1<<NBIT_ADDR] {return dataarray_;}

  DataType read_mem(BunchXingT ibx, ap_uint<NBIT_ADDR> index) const
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
	// TODO: check if valid
	return dataarray_[ibx][index];
  }
  
  DataType read_mem(BunchXingT ibx, ap_uint<NBIT_BIN> slot,
		    ap_uint<NBIT_ADDR> index) const
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
    // TODO: check if valid
    return dataarray_[ibx][(1<<(NBIT_ADDR-NBIT_BIN))*slot+index];
  }

  bool write_mem(BunchXingT ibx, ap_uint<NBIT_BIN> slot, DataType data)
  {
#pragma HLS ARRAY_PARTITION variable=nentries_ complete dim=0
#pragma HLS dependence variable=nentries_ intra WAR true
#pragma HLS inline

	NEntryT nentry_ibx = nentries_[ibx][slot];

	if (nentry_ibx < (1<<(NBIT_ADDR-NBIT_BIN))) {
	  // write address for slot: 1<<(NBIT_ADDR-NBIT_BIN) * slot + nentry_ibx
	  dataarray_[ibx][(1<<(NBIT_ADDR-NBIT_BIN))*slot+nentry_ibx] = data;
	  nentries_[ibx][slot] = nentry_ibx + 1;
	  binmask_[ibx][slot] = 1;
	  
	  ap_uint<3> ibin,ireg;

	  (ibin,ireg)=slot;

	  //std::cout << "slot ibin ireg :"<<slot<<" "<<ibin<<" "<<ireg<<std::endl;

	  //binmask16_[ibx][ibin].set(ireg);
	  //if (ibin!=0) binmask16_[ibx][ibin-1].set(ireg+8);

#ifdef USE_APUINT
	  binmask16new_.set_bit(ibin*8+ireg,true);
#else
	  binmask16_[ibin].set_bit(ireg,true);
	  if (ibin!=0) binmask16_[ibin-1].set_bit(ireg+8,true);
#endif
	  //binmask16_[ibx][ibin].set_bit(ireg,true);
	  //if (ibin!=0) binmask16_[ibx][ibin-1].set_bit(ireg+8,true);


#ifdef USE_APUINT
	  nentries16new_.range(32*ibin+ireg*4+3,32*ibin+ireg*4)=nentries16new_.range(32*ibin+ireg*4+3,32*ibin+ireg*4)+1;
#else
	  nentries16_[ibin].range(ireg*4+3,ireg*4)=nentries16_[ibin].range(ireg*4+3,ireg*4)+1;
	  if ( ibin!=0) nentries16_[ibin-1].range(32+ireg*4+3,32+ireg*4)=nentries16_[ibin-1].range(32+ireg*4+3,32+ireg*4)+1;
#endif
	  //nentries16_[ibx][ibin].range(ireg*4+3,ireg*4)=nentries16_[ibx][ibin].range(ireg*4+3,ireg*4)+1;;
	  //if ( ibin!=0) nentries16_[ibx][ibin-1].range(32+ireg*4+3,32+ireg*4)=nentries16_[ibx][ibin-1].range(32+ireg*4+3,32+ireg*4)+1;

	  return true;
	}
	else {
#ifndef __SYNTHESIS__
	  std::cout << "Warning out of range. nentry_ibx = "<<nentry_ibx<<" NBIT_ADDR-NBIT_BIN = "<<NBIT_ADDR-NBIT_BIN << std::endl;
#endif
	  return false;
	}
  }


  // Methods for C simulation only
#ifndef __SYNTHESIS__
  
  ///////////////////////////////////
  std::vector<std::string> split(const std::string& s, char delimiter)
  {
    std::vector<std::string> tokens;
    std::string token;
    std::istringstream sstream(s);
    while (getline(sstream, token, delimiter))
      {
	tokens.push_back(token);
      }
    return tokens;
  }

  // write memory from text file
  bool write_mem(BunchXingT bx, const std::string& line, int base=16)
  {

    std::string datastr = split(line, ' ').back();

    int slot = (int)strtol(split(line, ' ').front().c_str(), nullptr, base); // Convert string (in hexadecimal) to int
    // Originally: atoi(split(line, ' ').front().c_str()); but that didn't work for disks with 16 bins

    //change order HACK...
    ap_uint<3> ireg,bin;
    (ireg,bin)=ap_uint<6>(slot);
    int newslot=(bin,ireg);

    DataType data(datastr.c_str(), base);
    return write_mem(bx, newslot, data);
  }


  // print memory contents
  void print_data(const DataType data) const
  {
	std::cout << std::hex << data.raw() << std::endl;
	// TODO: overload '<<' in data class
  }

  void print_entry(BunchXingT bx, ap_uint<NBIT_ADDR> index) const
  {
	print_data(dataarray_[bx][index]);
  }

  void print_mem(BunchXingT bx) const
  {
	for(int slot=0;slot<(kNSlots);slot++) {
      //std::cout << "slot "<<slot<<" entries "
      //		<<nentries_[bx%NBX].range((slot+1)*4-1,slot*4)<<endl;
      for (int i = 0; i < nentries_[bx][slot]; ++i) {
		std::cout << bx << " " << i << " ";
		print_entry(bx, i + slot*(1<<(NBIT_ADDR-NBIT_BIN)) );
      }
    }
  }

  void print_mem() const
  {
	for (int ibx = 0; ibx < (kNBxBins); ++ibx) {
	  for (int i = 0; i < nentries_[ibx]; ++i) {
		std::cout << ibx << " " << i << " ";
		print_entry(ibx,i);
	  }
	}
  }

  static constexpr int getWidth() {return DataType::getWidth();}
  
#endif
  
};

#endif
