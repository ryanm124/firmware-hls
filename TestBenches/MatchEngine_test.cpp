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

const int nevents = 100;  // number of events to run

int main() {
#ifdef SUPER
	// Error Counter
	int err_count[ME_multiplicity]	= {0};
	
	// Declare input memory arrays to be read from the emulation files as array
	VMStubMEMemory<MODULETYPE> inputvmstubset[ME_multiplicity];
	VMProjectionMemory<PROJECTIONTYPE> inputvmprojset[ME_multiplicity]; 


	// Declare output memory array to be filled by hls simulation as array
	CandidateMatchMemory outputcandmatchset[ME_multiplicity];

	// Open file(s) with the input projections, stubs, and reference results as array
	// Currently only configured for Layer 3 with 8 ME Modules
	ifstream fin_vmprojset[ME_multiplicity];
	ifstream fin_vmstubset[ME_multiplicity];
	ifstream fin_candmatchset[ME_multiplicity];
	bool validvmprojset[ME_multiplicity]	= {false};
	bool validvmstubset[ME_multiplicity]	= {false};
	bool validcandmatchset[ME_multiplicity]	= {false};

#if LAYER == 3
        validvmprojset[0]    = openDataFile(fin_vmprojset[0],"ME/ME_L3PHIC17/VMProjections_VMPROJ_L3PHIC17_04.dat");
        validvmstubset[0]    = openDataFile(fin_vmstubset[0],"ME/ME_L3PHIC17/VMStubs_VMSME_L3PHIC17n1_04.dat");
        validcandmatchset[0] = openDataFile(fin_candmatchset[0],"ME/ME_L3PHIC17/CandidateMatches_CM_L3PHIC17_04.dat");

        validvmprojset[1]    = openDataFile(fin_vmprojset[1],"ME/ME_L3PHIC18/VMProjections_VMPROJ_L3PHIC18_04.dat");
        validvmstubset[1]    = openDataFile(fin_vmstubset[1],"ME/ME_L3PHIC18/VMStubs_VMSME_L3PHIC18n1_04.dat");
        validcandmatchset[1] = openDataFile(fin_candmatchset[1],"ME/ME_L3PHIC18/CandidateMatches_CM_L3PHIC18_04.dat");

        validvmprojset[2]    = openDataFile(fin_vmprojset[2],"ME/ME_L3PHIC19/VMProjections_VMPROJ_L3PHIC19_04.dat");
        validvmstubset[2]    = openDataFile(fin_vmstubset[2],"ME/ME_L3PHIC19/VMStubs_VMSME_L3PHIC19n1_04.dat");
        validcandmatchset[2] = openDataFile(fin_candmatchset[2],"ME/ME_L3PHIC19/CandidateMatches_CM_L3PHIC19_04.dat");

        validvmprojset[3]    = openDataFile(fin_vmprojset[3],"ME/ME_L3PHIC20/VMProjections_VMPROJ_L3PHIC20_04.dat");
        validvmstubset[3]    = openDataFile(fin_vmstubset[3],"ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat");
        validcandmatchset[3] = openDataFile(fin_candmatchset[3],"ME/ME_L3PHIC20/CandidateMatches_CM_L3PHIC20_04.dat");

        validvmprojset[4]    = openDataFile(fin_vmprojset[4],"ME/ME_L3PHIC21/VMProjections_VMPROJ_L3PHIC21_04.dat");
        validvmstubset[4]    = openDataFile(fin_vmstubset[4],"ME/ME_L3PHIC21/VMStubs_VMSME_L3PHIC21n1_04.dat");
        validcandmatchset[4] = openDataFile(fin_candmatchset[4],"ME/ME_L3PHIC21/CandidateMatches_CM_L3PHIC21_04.dat");

        validvmprojset[5]    = openDataFile(fin_vmprojset[5],"ME/ME_L3PHIC22/VMProjections_VMPROJ_L3PHIC22_04.dat");
        validvmstubset[5]    = openDataFile(fin_vmstubset[5],"ME/ME_L3PHIC22/VMStubs_VMSME_L3PHIC22n1_04.dat");
        validcandmatchset[5] = openDataFile(fin_candmatchset[5],"ME/ME_L3PHIC22/CandidateMatches_CM_L3PHIC22_04.dat");

        validvmprojset[6]    = openDataFile(fin_vmprojset[6],"ME/ME_L3PHIC23/VMProjections_VMPROJ_L3PHIC23_04.dat");
        validvmstubset[6]    = openDataFile(fin_vmstubset[6],"ME/ME_L3PHIC23/VMStubs_VMSME_L3PHIC23n1_04.dat");
        validcandmatchset[6] = openDataFile(fin_candmatchset[6],"ME/ME_L3PHIC23/CandidateMatches_CM_L3PHIC23_04.dat");

        validvmprojset[7]    = openDataFile(fin_vmprojset[7],"ME/ME_L3PHIC24/VMProjections_VMPROJ_L3PHIC24_04.dat");
        validvmstubset[7]    = openDataFile(fin_vmstubset[7],"ME/ME_L3PHIC24/VMStubs_VMSME_L3PHIC24n1_04.dat");
        validcandmatchset[7] = openDataFile(fin_candmatchset[7],"ME/ME_L3PHIC24/CandidateMatches_CM_L3PHIC24_04.dat");
#else
	return -4	   
#endif
	for (int i=0;i<ME_multiplicity;i++){
		if (not validvmprojset[i]) return -1;
        	if (not validvmstubset[i]) return -2;
        	if (not validcandmatchset[i]) return -3;
	}	
#else
	// Error counter
	int err_count = 0;

	// Declare input memory arrays to be read from the emulation files
	VMProjectionMemory<PROJECTIONTYPE> inputvmprojs;
	VMStubMEMemory<MODULETYPE> inputvmstubs;

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
#endif
	// Loop over events
	for (int ievt = 0; ievt < nevents; ++ievt) {
		cout << "Event: " << dec << ievt << endl;

	#ifdef SUPER
		// Set bunch crossing as array (FIX if this is unecessary)
		BXType bxset[ME_multiplicity];
		BXType bx_outset[ME_multiplicity];
		
		// Fill stub & projection memories from reference files
		for (int i=0;i<ME_multiplicity;i++) {
			writeMemFromFile<VMProjectionMemory<PROJECTIONTYPE> >(inputvmprojset[i], fin_vmprojset[i], ievt);
			writeMemFromFile<VMStubMEMemory<MODULETYPE> >(inputvmstubset[i], fin_vmstubset[i], ievt);
			bxset[i]=ievt&0x7;;
		}

		// Unit Under Test
		SuperMatchEngineTop(bxset,bx_outset,inputvmstubset,inputvmprojset,outputcandmatchset);

		// Compare each match engine with reference CandidateMatches to confirm correct output
		bool truncation = true;
		for (int i=0;i<ME_multiplicity;i++) {
			//Print the number of projections and stubs
			std::cout << "In MatchEngine "<<i+1<<" #proj ="<<std::hex<<inputvmprojset[i].getEntries(bxset[i])<<" #stubs=";
			for (unsigned int zbin=0;zbin<8;zbin++){
				std::cout <<" "<<inputvmstubset[i].getEntries(bxset[i],zbin);
			}
			std::cout<<std::dec<<std::endl;
		
			if (not outputcandmatchset[i].getEntries(ievt)) {
				std::cout<<"No Matches"<<std::endl;
			}		
	
			err_count[i] += compareMemWithFile<CandidateMatchMemory,16,2>(outputcandmatchset[i], fin_candmatchset[i], ievt, "CandidateMatch", truncation);
		}	
		
	#else
		// Set bunch crossing
		BXType bx=ievt&0x7;
		BXType bx_out;
		
 
		// Fill stub & projection memories from reference files
		writeMemFromFile<VMProjectionMemory<PROJECTIONTYPE> >(inputvmprojs, fin_vmproj, ievt);
		writeMemFromFile<VMStubMEMemory<MODULETYPE> >(inputvmstubs, fin_vmstub, ievt);

		//Print the number of projections and stubs
		std::cout << "In MatchEngine #proj ="<<std::hex<<inputvmprojs.getEntries(bx)<<" #stubs=";
		for (unsigned int zbin=0;zbin<8;zbin++){
			std::cout <<" "<<inputvmstubs.getEntries(bx,zbin);
		}
		std::cout<<std::dec<<std::endl;

		// Unit Under Test
		MatchEngineTop(bx,bx_out,inputvmstubs,inputvmprojs,outputcandmatches);

		// Compare the computed outputs with the expected ones for the candidate matches
		bool truncation = true;
		err_count += compareMemWithFile<CandidateMatchMemory,16,2>(outputcandmatches, fin_candmatch, ievt, "CandidateMatch",truncation);
	#endif
	}  // End of event loop
 
	// Close files and return total error count
	int tot_err_count = 0;
#ifdef SUPER
	for (int i=0;i<ME_multiplicity;i++) {
		fin_vmstubset[i].close();
		fin_vmprojset[i].close();
		fin_candmatchset[i].close();
		tot_err_count += err_count[i];
	}
#else
	fin_vmstub.close();
	fin_vmproj.close();
	fin_candmatch.close();
	tot_err_count = err_count;	
#endif
	return tot_err_count;
}
