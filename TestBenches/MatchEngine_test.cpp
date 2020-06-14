// ProjectionRouter test bench

// cms-tracklet/firmware-hls Headers
#include "MatchEngine.h"
#include "CandidateMatchMemory.h"
#include "VMProjectionMemory.h"
#include "VMStubMEMemory.h"
#include "FileReadUtility.h"

// HLS Headers
#include "hls_math.h"

// STL Headers
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <iterator>

using namespace std;

// Use 8x Match Engine?
bool super_module = true;

const int nevents = 100;  // number of events to run

int main() {
	// Error counter
	int err_count = 0;

	// Declare input memory arrays to be read from the emulation files
	VMProjectionMemory<PROJECTIONTYPE> inputvmprojs;
	VMStubMEMemory<MODULETYPE> inputvmstubs;
	//CandidateMatchMemory inputcandmatches;

	// Declare output memory array to be filled by hls simulation
	CandidateMatchMemory outputcandmatches;

	// Open file(s) with the input projections, stubs, and reference results
	ifstream fin_vmproj;
	ifstream fin_vmstub;
	ifstream fin_candmatch;
	bool validvmproj    = false;
	bool validvmstub    = false;
	bool validcandmatch = false;
#if LAYER == 1
	validvmproj    = openDataFile(fin_vmproj,"ME/ME_L1PHIE20/VMProjections_VMPROJ_L1PHIE20_04.dat");
	validvmstub    = openDataFile(fin_vmstub,"ME/ME_L1PHIE20/VMStubs_VMSME_L1PHIE20n1_04.dat");
	validcandmatch = openDataFile(fin_candmatch,"ME/ME_L1PHIE20/CandidateMatches_CM_L1PHIE20_04.dat");
#elif LAYER == 2
	validvmproj    = false;
	validvmstub    = false;
	validcandmatch = false;
#elif LAYER == 3
	validvmproj    = openDataFile(fin_vmproj,"ME/ME_L3PHIC20/VMProjections_VMPROJ_L3PHIC20_04.dat");
	validvmstub    = openDataFile(fin_vmstub,"ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat");
	validcandmatch = openDataFile(fin_candmatch,"ME/ME_L3PHIC20/CandidateMatches_CM_L3PHIC20_04.dat");
#elif LAYER == 4
	validvmproj    = openDataFile(fin_vmproj,"ME/ME_L4PHIB12/VMProjections_VMPROJ_L4PHIB12_04.dat");
	validvmstub    = openDataFile(fin_vmstub,"ME/ME_L4PHIB12/VMStubs_VMSME_L4PHIB12n1_04.dat");
	validcandmatch = openDataFile(fin_candmatch,"ME/ME_L4PHIB12/CandidateMatches_CM_L4PHIB12_04.dat");
#elif LAYER == 5
	validvmproj    = false;
	validvmstub    = false;
	validcandmatch = false;
#elif LAYER == 6
	validvmproj    = false;
	validvmstub    = false;
	validcandmatch = false;
#endif
	if (not validvmproj) return -1;
	if (not validvmstub) return -2;
	if (not validcandmatch) return -3;

	// Loop over events
	for (int ievt = 0; ievt < nevents; ++ievt) {
		cout << "Event: " << dec << ievt << endl;

		writeMemFromFile<VMProjectionMemory<PROJECTIONTYPE> >(inputvmprojs, fin_vmproj, ievt);
		writeMemFromFile<VMStubMEMemory<MODULETYPE> >(inputvmstubs, fin_vmstub, ievt);

		//Set bunch crossing
		BXType bx=ievt&0x7;
		BXType bx_out;

		//Print the number of projections and stubs
		std::cout << "In MatchEngine #proj ="<<std::hex<<inputvmprojs.getEntries(bx)<<" #stubs=";
		for (unsigned int zbin=0;zbin<8;zbin++){
			std::cout <<" "<<inputvmstubs.getEntries(bx,zbin);
		}
		std::cout<<std::dec<<std::endl;

	#ifdef SUPER

		// Duplicate input stubs, projections, and output memory
		VMStubMEMemory<MODULETYPE> inputvmstubsset[ME_multiplicity];
		VMProjectionMemory<PROJECTIONTYPE> inputvmprojsset[ME_multiplicity]; 
		CandidateMatchMemory outputcandmatchesset[ME_multiplicity];
		BXType bxset[ME_multiplicity];
		BXType bx_outset[ME_multiplicity];

		for (int i=0;i<ME_multiplicity;i++) {
			inputvmstubsset[i]=inputvmstubs;
			inputvmprojsset[i]=inputvmprojs;
			outputcandmatchesset[i]=outputcandmatches;
			bxset[i]=bx;
			bx_outset[i]=bx_out;
		}

		// Unit Under Test
		SuperMatchEngineTop(bxset,bx_outset,inputvmstubsset,inputvmprojsset,outputcandmatchesset);

		// Compare the computed output of random ME in module with the expected ones for the candidate matches
		bool truncation = true;
		int rand_engine = rand() % ME_multiplicity;
		err_count += compareMemWithFile<CandidateMatchMemory,16,2>(outputcandmatchesset[rand_engine], fin_candmatch, ievt, "CandidateMatch",truncation);
		
		// Check that all MEs in module agree
		bool engine_agreement = true;
		for (int i=0;i<ME_multiplicity;i++) {
			for (int ievt = 0; ievt < nevents; ++ievt) {
				for (int j=0;j<outputcandmatchesset[i].getEntries(ievt);j++) {						
					if (outputcandmatchesset[i].read_mem(ievt,j).raw() == outputcandmatchesset[rand_engine].read_mem(ievt,j).raw()) {
						continue;
					} else {
						engine_agreement = false;
					}
					
				}
			}
		}

		if (engine_agreement) {
			std::cout<<"Match Engines Agree"<<std::endl;
		} else {
			std::cout<<"Match Engine Inconsistency!"<<std::endl;
		}
	#else
		// Unit Under Test
		MatchEngineTop(bx,bx_out,inputvmstubs,inputvmprojs,outputcandmatches);

		// Compare the computed outputs with the expected ones for the candidate matches
		bool truncation = true;
		err_count += compareMemWithFile<CandidateMatchMemory,16,2>(outputcandmatches, fin_candmatch, ievt, "CandidateMatch",truncation);
	#endif
	}  // End of event loop
  
	// Close files
	fin_vmstub.close();
	fin_vmproj.close();
	fin_candmatch.close();

	return err_count;
}
