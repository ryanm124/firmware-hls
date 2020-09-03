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
        validvmprojset[0]    = openDataFile(fin_vmprojset[0],"ME/ME_L3PHIA1/VMProjections_VMPROJ_L3PHIA1_04.dat");
        validvmstubset[0]    = openDataFile(fin_vmstubset[0],"ME/ME_L3PHIA1/VMStubs_VMSME_L3PHIA1n1_04.dat");
        validcandmatchset[0] = openDataFile(fin_candmatchset[0],"ME/ME_L3PHIA1/CandidateMatches_CM_L3PHIA1_04.dat");

        validvmprojset[1]    = openDataFile(fin_vmprojset[1],"ME/ME_L3PHIA2/VMProjections_VMPROJ_L3PHIA2_04.dat");
        validvmstubset[1]    = openDataFile(fin_vmstubset[1],"ME/ME_L3PHIA2/VMStubs_VMSME_L3PHIA2n1_04.dat");
        validcandmatchset[1] = openDataFile(fin_candmatchset[1],"ME/ME_L3PHIA2/CandidateMatches_CM_L3PHIA2_04.dat");

        validvmprojset[2]    = openDataFile(fin_vmprojset[2],"ME/ME_L3PHIA3/VMProjections_VMPROJ_L3PHIA3_04.dat");
        validvmstubset[2]    = openDataFile(fin_vmstubset[2],"ME/ME_L3PHIA3/VMStubs_VMSME_L3PHIA3n1_04.dat");
        validcandmatchset[2] = openDataFile(fin_candmatchset[2],"ME/ME_L3PHIA3/CandidateMatches_CM_L3PHIA3_04.dat");

        validvmprojset[3]    = openDataFile(fin_vmprojset[3],"ME/ME_L3PHIA4/VMProjections_VMPROJ_L3PHIA4_04.dat");
        validvmstubset[3]    = openDataFile(fin_vmstubset[3],"ME/ME_L3PHIA4/VMStubs_VMSME_L3PHIA4n1_04.dat");
        validcandmatchset[3] = openDataFile(fin_candmatchset[3],"ME/ME_L3PHIA4/CandidateMatches_CM_L3PHIA4_04.dat");

        validvmprojset[4]    = openDataFile(fin_vmprojset[4],"ME/ME_L3PHIA5/VMProjections_VMPROJ_L3PHIA5_04.dat");
        validvmstubset[4]    = openDataFile(fin_vmstubset[4],"ME/ME_L3PHIA5/VMStubs_VMSME_L3PHIA5n1_04.dat");
        validcandmatchset[4] = openDataFile(fin_candmatchset[4],"ME/ME_L3PHIA5/CandidateMatches_CM_L3PHIA5_04.dat");

        validvmprojset[5]    = openDataFile(fin_vmprojset[5],"ME/ME_L3PHIA6/VMProjections_VMPROJ_L3PHIA6_04.dat");
        validvmstubset[5]    = openDataFile(fin_vmstubset[5],"ME/ME_L3PHIA6/VMStubs_VMSME_L3PHIA6n1_04.dat");
        validcandmatchset[5] = openDataFile(fin_candmatchset[5],"ME/ME_L3PHIA6/CandidateMatches_CM_L3PHIA6_04.dat");

        validvmprojset[6]    = openDataFile(fin_vmprojset[6],"ME/ME_L3PHIA7/VMProjections_VMPROJ_L3PHIA7_04.dat");
        validvmstubset[6]    = openDataFile(fin_vmstubset[6],"ME/ME_L3PHIA7/VMStubs_VMSME_L3PHIA7n1_04.dat");
        validcandmatchset[6] = openDataFile(fin_candmatchset[6],"ME/ME_L3PHIA7/CandidateMatches_CM_L3PHIA7_04.dat");

        validvmprojset[7]    = openDataFile(fin_vmprojset[7],"ME/ME_L3PHIA8/VMProjections_VMPROJ_L3PHIA8_04.dat");
        validvmstubset[7]    = openDataFile(fin_vmstubset[7],"ME/ME_L3PHIA8/VMStubs_VMSME_L3PHIA8n1_04.dat");
        validcandmatchset[7] = openDataFile(fin_candmatchset[7],"ME/ME_L3PHIA8/CandidateMatches_CM_L3PHIA8_04.dat");

        validvmprojset[8]    = openDataFile(fin_vmprojset[8],"ME/ME_L3PHIB9/VMProjections_VMPROJ_L3PHIB9_04.dat");
        validvmstubset[8]    = openDataFile(fin_vmstubset[8],"ME/ME_L3PHIB9/VMStubs_VMSME_L3PHIB9n1_04.dat");
        validcandmatchset[8] = openDataFile(fin_candmatchset[8],"ME/ME_L3PHIB9/CandidateMatches_CM_L3PHIB9_04.dat");

        validvmprojset[9]    = openDataFile(fin_vmprojset[9],"ME/ME_L3PHIB10/VMProjections_VMPROJ_L3PHIB10_04.dat");
        validvmstubset[9]    = openDataFile(fin_vmstubset[9],"ME/ME_L3PHIB10/VMStubs_VMSME_L3PHIB10n1_04.dat");
        validcandmatchset[9] = openDataFile(fin_candmatchset[9],"ME/ME_L3PHIB10/CandidateMatches_CM_L3PHIB10_04.dat");

        validvmprojset[10]    = openDataFile(fin_vmprojset[10],"ME/ME_L3PHIB11/VMProjections_VMPROJ_L3PHIB11_04.dat");
        validvmstubset[10]    = openDataFile(fin_vmstubset[10],"ME/ME_L3PHIB11/VMStubs_VMSME_L3PHIB11n1_04.dat");
        validcandmatchset[10] = openDataFile(fin_candmatchset[10],"ME/ME_L3PHIB11/CandidateMatches_CM_L3PHIB11_04.dat");

        validvmprojset[11]    = openDataFile(fin_vmprojset[11],"ME/ME_L3PHIB12/VMProjections_VMPROJ_L3PHIB12_04.dat");
        validvmstubset[11]    = openDataFile(fin_vmstubset[11],"ME/ME_L3PHIB12/VMStubs_VMSME_L3PHIB12n1_04.dat");
        validcandmatchset[11] = openDataFile(fin_candmatchset[11],"ME/ME_L3PHIB12/CandidateMatches_CM_L3PHIB12_04.dat");

        validvmprojset[12]    = openDataFile(fin_vmprojset[12],"ME/ME_L3PHIB13/VMProjections_VMPROJ_L3PHIB13_04.dat");
        validvmstubset[12]    = openDataFile(fin_vmstubset[12],"ME/ME_L3PHIB13/VMStubs_VMSME_L3PHIB13n1_04.dat");
        validcandmatchset[12] = openDataFile(fin_candmatchset[12],"ME/ME_L3PHIB13/CandidateMatches_CM_L3PHIB13_04.dat");

        validvmprojset[13]    = openDataFile(fin_vmprojset[13],"ME/ME_L3PHIB14/VMProjections_VMPROJ_L3PHIB14_04.dat");
        validvmstubset[13]    = openDataFile(fin_vmstubset[13],"ME/ME_L3PHIB14/VMStubs_VMSME_L3PHIB14n1_04.dat");
        validcandmatchset[13] = openDataFile(fin_candmatchset[13],"ME/ME_L3PHIB14/CandidateMatches_CM_L3PHIB14_04.dat");

        validvmprojset[14]    = openDataFile(fin_vmprojset[14],"ME/ME_L3PHIB15/VMProjections_VMPROJ_L3PHIB15_04.dat");
        validvmstubset[14]    = openDataFile(fin_vmstubset[14],"ME/ME_L3PHIB15/VMStubs_VMSME_L3PHIB15n1_04.dat");
        validcandmatchset[14] = openDataFile(fin_candmatchset[14],"ME/ME_L3PHIB15/CandidateMatches_CM_L3PHIB15_04.dat");

        validvmprojset[15]    = openDataFile(fin_vmprojset[15],"ME/ME_L3PHIB16/VMProjections_VMPROJ_L3PHIB16_04.dat");
        validvmstubset[15]    = openDataFile(fin_vmstubset[15],"ME/ME_L3PHIB16/VMStubs_VMSME_L3PHIB16n1_04.dat");
        validcandmatchset[15] = openDataFile(fin_candmatchset[15],"ME/ME_L3PHIB16/CandidateMatches_CM_L3PHIB16_04.dat");

        validvmprojset[16]    = openDataFile(fin_vmprojset[16],"ME/ME_L3PHIC17/VMProjections_VMPROJ_L3PHIC17_04.dat");
        validvmstubset[16]    = openDataFile(fin_vmstubset[16],"ME/ME_L3PHIC17/VMStubs_VMSME_L3PHIC17n1_04.dat");
        validcandmatchset[16] = openDataFile(fin_candmatchset[16],"ME/ME_L3PHIC17/CandidateMatches_CM_L3PHIC17_04.dat");

        validvmprojset[17]    = openDataFile(fin_vmprojset[17],"ME/ME_L3PHIC18/VMProjections_VMPROJ_L3PHIC18_04.dat");
        validvmstubset[17]    = openDataFile(fin_vmstubset[17],"ME/ME_L3PHIC18/VMStubs_VMSME_L3PHIC18n1_04.dat");
        validcandmatchset[17] = openDataFile(fin_candmatchset[17],"ME/ME_L3PHIC18/CandidateMatches_CM_L3PHIC18_04.dat");

        validvmprojset[18]    = openDataFile(fin_vmprojset[18],"ME/ME_L3PHIC19/VMProjections_VMPROJ_L3PHIC19_04.dat");
        validvmstubset[18]    = openDataFile(fin_vmstubset[18],"ME/ME_L3PHIC19/VMStubs_VMSME_L3PHIC19n1_04.dat");
        validcandmatchset[18] = openDataFile(fin_candmatchset[18],"ME/ME_L3PHIC19/CandidateMatches_CM_L3PHIC19_04.dat");

        validvmprojset[19]    = openDataFile(fin_vmprojset[19],"ME/ME_L3PHIC20/VMProjections_VMPROJ_L3PHIC20_04.dat");
        validvmstubset[19]    = openDataFile(fin_vmstubset[19],"ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat");
        validcandmatchset[19] = openDataFile(fin_candmatchset[19],"ME/ME_L3PHIC20/CandidateMatches_CM_L3PHIC20_04.dat");

        validvmprojset[20]    = openDataFile(fin_vmprojset[20],"ME/ME_L3PHIC21/VMProjections_VMPROJ_L3PHIC21_04.dat");
        validvmstubset[20]    = openDataFile(fin_vmstubset[20],"ME/ME_L3PHIC21/VMStubs_VMSME_L3PHIC21n1_04.dat");
        validcandmatchset[20] = openDataFile(fin_candmatchset[20],"ME/ME_L3PHIC21/CandidateMatches_CM_L3PHIC21_04.dat");

        validvmprojset[21]    = openDataFile(fin_vmprojset[21],"ME/ME_L3PHIC22/VMProjections_VMPROJ_L3PHIC22_04.dat");
        validvmstubset[21]    = openDataFile(fin_vmstubset[21],"ME/ME_L3PHIC22/VMStubs_VMSME_L3PHIC22n1_04.dat");
        validcandmatchset[21] = openDataFile(fin_candmatchset[21],"ME/ME_L3PHIC22/CandidateMatches_CM_L3PHIC22_04.dat");

        validvmprojset[22]    = openDataFile(fin_vmprojset[22],"ME/ME_L3PHIC23/VMProjections_VMPROJ_L3PHIC23_04.dat");
        validvmstubset[22]    = openDataFile(fin_vmstubset[22],"ME/ME_L3PHIC23/VMStubs_VMSME_L3PHIC23n1_04.dat");
        validcandmatchset[22] = openDataFile(fin_candmatchset[22],"ME/ME_L3PHIC23/CandidateMatches_CM_L3PHIC23_04.dat");

        validvmprojset[23]    = openDataFile(fin_vmprojset[23],"ME/ME_L3PHIC24/VMProjections_VMPROJ_L3PHIC24_04.dat");
        validvmstubset[23]    = openDataFile(fin_vmstubset[23],"ME/ME_L3PHIC24/VMStubs_VMSME_L3PHIC24n1_04.dat");
        validcandmatchset[23] = openDataFile(fin_candmatchset[23],"ME/ME_L3PHIC24/CandidateMatches_CM_L3PHIC24_04.dat");

        validvmprojset[24]    = openDataFile(fin_vmprojset[24],"ME/ME_L3PHID25/VMProjections_VMPROJ_L3PHID25_04.dat");
        validvmstubset[24]    = openDataFile(fin_vmstubset[24],"ME/ME_L3PHID25/VMStubs_VMSME_L3PHID25n1_04.dat");
        validcandmatchset[24] = openDataFile(fin_candmatchset[24],"ME/ME_L3PHID25/CandidateMatches_CM_L3PHID25_04.dat");

        validvmprojset[25]    = openDataFile(fin_vmprojset[25],"ME/ME_L3PHID26/VMProjections_VMPROJ_L3PHID26_04.dat");
        validvmstubset[25]    = openDataFile(fin_vmstubset[25],"ME/ME_L3PHID26/VMStubs_VMSME_L3PHID26n1_04.dat");
        validcandmatchset[25] = openDataFile(fin_candmatchset[25],"ME/ME_L3PHID26/CandidateMatches_CM_L3PHID26_04.dat");

        validvmprojset[26]    = openDataFile(fin_vmprojset[26],"ME/ME_L3PHID27/VMProjections_VMPROJ_L3PHID27_04.dat");
        validvmstubset[26]    = openDataFile(fin_vmstubset[26],"ME/ME_L3PHID27/VMStubs_VMSME_L3PHID27n1_04.dat");
        validcandmatchset[26] = openDataFile(fin_candmatchset[26],"ME/ME_L3PHID27/CandidateMatches_CM_L3PHID27_04.dat");

        validvmprojset[27]    = openDataFile(fin_vmprojset[27],"ME/ME_L3PHID28/VMProjections_VMPROJ_L3PHID28_04.dat");
        validvmstubset[27]    = openDataFile(fin_vmstubset[27],"ME/ME_L3PHID28/VMStubs_VMSME_L3PHID28n1_04.dat");
        validcandmatchset[27] = openDataFile(fin_candmatchset[27],"ME/ME_L3PHID28/CandidateMatches_CM_L3PHID28_04.dat");

        validvmprojset[28]    = openDataFile(fin_vmprojset[28],"ME/ME_L3PHID29/VMProjections_VMPROJ_L3PHID29_04.dat");
        validvmstubset[28]    = openDataFile(fin_vmstubset[28],"ME/ME_L3PHID29/VMStubs_VMSME_L3PHID29n1_04.dat");
        validcandmatchset[28] = openDataFile(fin_candmatchset[28],"ME/ME_L3PHID29/CandidateMatches_CM_L3PHID29_04.dat");

        validvmprojset[29]    = openDataFile(fin_vmprojset[29],"ME/ME_L3PHID30/VMProjections_VMPROJ_L3PHID30_04.dat");
        validvmstubset[29]    = openDataFile(fin_vmstubset[29],"ME/ME_L3PHID30/VMStubs_VMSME_L3PHID30n1_04.dat");
        validcandmatchset[29] = openDataFile(fin_candmatchset[29],"ME/ME_L3PHID30/CandidateMatches_CM_L3PHID30_04.dat");

        validvmprojset[30]    = openDataFile(fin_vmprojset[30],"ME/ME_L3PHID31/VMProjections_VMPROJ_L3PHID31_04.dat");
        validvmstubset[30]    = openDataFile(fin_vmstubset[30],"ME/ME_L3PHID31/VMStubs_VMSME_L3PHID31n1_04.dat");
        validcandmatchset[30] = openDataFile(fin_candmatchset[30],"ME/ME_L3PHID31/CandidateMatches_CM_L3PHID31_04.dat");

        validvmprojset[31]    = openDataFile(fin_vmprojset[31],"ME/ME_L3PHID32/VMProjections_VMPROJ_L3PHID32_04.dat");
        validvmstubset[31]    = openDataFile(fin_vmstubset[31],"ME/ME_L3PHID32/VMStubs_VMSME_L3PHID32n1_04.dat");
        validcandmatchset[31] = openDataFile(fin_candmatchset[31],"ME/ME_L3PHID32/CandidateMatches_CM_L3PHID32_04.dat");

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
