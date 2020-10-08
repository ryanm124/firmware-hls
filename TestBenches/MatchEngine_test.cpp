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
#include <sstream>

using namespace std;

const int nevents = 100;  // number of events to run

std::string get_vm(int module_number) {
	#if LAYER==1
		if      (module_number <= 4)  return "A";
		else if (module_number <= 8) return "B";
		else if (module_number <= 12) return "C";
		else if (module_number <= 16) return "D";
		else if (module_number <= 20) return "E";
		else if (module_number <= 24) return "F";
		else if (module_number <= 28) return "G";
		else if (module_number <= 32) return "H";
		else {
			std:cout << "You suck at this!" << std::endl;
			exit(0);
		}
	#elif LAYER==2
		if      (module_number <= 8)  return "A";
		else if (module_number <= 16) return "B";
		else if (module_number <= 24) return "C";
		else if (module_number <= 32) return "D";
		else {
			std:cout << "You suck at this!" << std::endl;
			exit(0);
		}
	#elif LAYER==3
		if      (module_number <= 8)  return "A";
		else if (module_number <= 16) return "B";
		else if (module_number <= 24) return "C";
		else if (module_number <= 32) return "D";
		else {
			std:cout << "Check Layer Modules" << std::endl;
			exit(0);
		}
	#elif LAYER==4
		if      (module_number <= 8)  return "A";
		else if (module_number <= 16) return "B";
		else if (module_number <= 24) return "C";
		else if (module_number <= 32) return "D";
		else {
			std:cout << "Check Layer Modules" << std::endl;
			exit(0);
		}
	#elif LAYER==5
		if      (module_number <= 8)  return "A";
		else if (module_number <= 16) return "B";
		else if (module_number <= 24) return "C";
		else if (module_number <= 32) return "D";
		else {
			std:cout << "Check Layer Modules" << std::endl;
			exit(0);
		}
	#elif LAYER==6
		if      (module_number <= 8)  return "A";
		else if (module_number <= 16) return "B";
		else if (module_number <= 24) return "C";
		else if (module_number <= 32) return "D";
		else {
			std:cout << "Check Layer Modules" << std::endl;
			exit(0);
		}
	#else
		std:cout << "Check Layer Selection" << std::endl;
		exit(0);
	#endif
}

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
	// Currently only configured for Layer 3 
	ifstream fin_vmprojset[ME_multiplicity];
	ifstream fin_vmstubset[ME_multiplicity];
	ifstream fin_candmatchset[ME_multiplicity];
	bool validvmprojset[ME_multiplicity]	= {false};
	bool validvmstubset[ME_multiplicity]	= {false};
	bool validcandmatchset[ME_multiplicity]	= {false};

#if LAYER == 1
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L1PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L1PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L1PHI" << get_vm(i) << i << "/VMStubs_VMSME_L1PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L1PHI" << get_vm(i) << i << "/CandidateMatches_CM_L1PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
#elif LAYER == 2
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L2PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L2PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L2PHI" << get_vm(i) << i << "/VMStubs_VMSME_L2PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L2PHI" << get_vm(i) << i << "/CandidateMatches_CM_L2PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
#elif LAYER == 3
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L3PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L3PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L3PHI" << get_vm(i) << i << "/VMStubs_VMSME_L3PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L3PHI" << get_vm(i) << i << "/CandidateMatches_CM_L3PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
#elif LAYER == 4
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L4PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L4PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L4PHI" << get_vm(i) << i << "/VMStubs_VMSME_L4PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L4PHI" << get_vm(i) << i << "/CandidateMatches_CM_L4PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
#elif LAYER == 5
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L5PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L5PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L5PHI" << get_vm(i) << i << "/VMStubs_VMSME_L5PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L5PHI" << get_vm(i) << i << "/CandidateMatches_CM_L5PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
#elif LAYER == 6
	for (int i=stopME; i <= startME; i++) {
		int idx = i-stopME;
		stringstream ss; ss << "ME/ME_L6PHI" << get_vm(i) << i << "/VMProjections_VMPROJ_L6PHI" << get_vm(i) << i << "_04.dat";
		validvmprojset[idx] =  openDataFile(fin_vmprojset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L6PHI" << get_vm(i) << i << "/VMStubs_VMSME_L6PHI" << get_vm(i) << i << "n1_04.dat";
		validvmstubset[idx] = openDataFile(fin_vmstubset[idx],ss.str());
		ss.str(""); ss << "ME/ME_L6PHI" << get_vm(i) << i << "/CandidateMatches_CM_L6PHI" << get_vm(i) << i << "_04.dat";
		validcandmatchset[idx] = openDataFile(fin_candmatchset[idx],ss.str());
	}
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
	// validvmproj    = openDataFile(fin_vmproj,"ME/ME_L1PHIE20/VMProjections_VMPROJ_L1PHIE20_04.dat");
	// validvmstub    = openDataFile(fin_vmstub,"ME/ME_L1PHIE20/VMStubs_VMSME_L1PHIE20n1_04.dat");
	// validcandmatch = openDataFile(fin_candmatch,"ME/ME_L1PHIE20/CandidateMatches_CM_L1PHIE20_04.dat");
	validvmproj    = openDataFile(fin_vmproj,"ME/ME_L1PHIB6/VMProjections_VMPROJ_L1PHIB6_04.dat");
	validvmstub    = openDataFile(fin_vmstub,"ME/ME_L1PHIB6/VMStubs_VMSME_L1PHIB6n1_04.dat");
	validcandmatch = openDataFile(fin_candmatch,"ME/ME_L1PHIB6/CandidateMatches_CM_L1PHIB6_04.dat");
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

	std::cout << "In layer " << LAYER << ":" << std::endl; 
	std::cout << "Running from module " << stopME << " to " << startME << std::endl; 

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
