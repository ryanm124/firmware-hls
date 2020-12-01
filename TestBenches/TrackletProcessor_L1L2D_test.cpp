// Test bench for TrackletProcessor
#include "TrackletProcessor.h"

#include <algorithm>
#include <iterator>
#include <cstring>

#include "FileReadUtility.h"
#include "Constants.h"

const int nevents = 1;  //number of events to run

using namespace std;

int main()
{
  // error counts
  int err = 0;

  ap_uint<10> innervmtable[2048] =
#include "../emData/TP/tables/TP_L1.tab"

  ap_uint<8> useregion[2048] =
#include "../emData/TP/tables/TP_L1L2D_usereg.tab"

  ///////////////////////////
  // input memories
  static AllStubInnerMemory<BARRELPS> innerStubs[2];
  static AllStubMemory<BARRELPS> outerStubs;
  static VMStubTEOuterMemoryCM<BARRELPS> outervmStubs[2];


  // output memories
  static TrackletParameterMemory tpar;
  static TrackletProjectionMemory<BARRELPS> tproj_barrel_ps[TC::N_PROJOUT_BARRELPS];
  static TrackletProjectionMemory<BARREL2S> tproj_barrel_2s[TC::N_PROJOUT_BARREL2S];
  static TrackletProjectionMemory<DISK> tproj_disk[TC::N_PROJOUT_DISK];

  ///////////////////////////
  // open input files
  cout << "Open files..." << endl;

  const string dir = "TP_L1L2D";

  ifstream fin_innerStubs0;
  if (not openDataFile(fin_innerStubs0, dir + "/AllStubs_AS_L1PHIBn4_04.dat")) return -1;

  ifstream fin_innerStubs1;
  if (not openDataFile(fin_innerStubs1, dir + "/AllStubs_AS_L1PHICn3_04.dat")) return -1;

  ifstream fin_outerStubs;
  if (not openDataFile(fin_outerStubs, dir + "/AllStubs_AS_L2PHIBn2_04.dat")) return -1;

  ifstream fin_outervmstubs0;
  if (not openDataFile(fin_outervmstubs0, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ifstream fin_outervmstubs1;
  if (not openDataFile(fin_outervmstubs1, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ifstream fin_outervmstubs2;
  if (not openDataFile(fin_outervmstubs2, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ifstream fin_outervmstubs3;
  if (not openDataFile(fin_outervmstubs3, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ifstream fin_outervmstubs4;
  if (not openDataFile(fin_outervmstubs4, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ifstream fin_outervmstubs5;
  if (not openDataFile(fin_outervmstubs5, dir + "/VMStubs_VMSTE_L2PHIBn1_04.dat")) return -1;

  ///////////////////////////
  // open output files
  ifstream fout_tpar;
  if (not openDataFile(fout_tpar, dir + "/TrackletParameters_TPAR_L1L2D_04.dat")) return -1;

  ifstream fout_tproj0;
  if (not openDataFile(fout_tproj0, dir + "/TrackletProjections_TPROJ_L1L2D_D1PHIA_04.dat")) return -1;

  ifstream fout_tproj1;
  if (not openDataFile(fout_tproj1, dir + "/TrackletProjections_TPROJ_L1L2D_D1PHIB_04.dat")) return -1;

  ifstream fout_tproj2;
  if (not openDataFile(fout_tproj2, dir + "/TrackletProjections_TPROJ_L1L2D_D1PHIC_04.dat")) return -1;

  ifstream fout_tproj3;
  if (not openDataFile(fout_tproj3, dir + "/TrackletProjections_TPROJ_L1L2D_D2PHIA_04.dat")) return -1;

  ifstream fout_tproj4;
  if (not openDataFile(fout_tproj4, dir + "/TrackletProjections_TPROJ_L1L2D_D2PHIB_04.dat")) return -1;

  ifstream fout_tproj5;
  if (not openDataFile(fout_tproj5, dir + "/TrackletProjections_TPROJ_L1L2D_D2PHIC_04.dat")) return -1;

  ifstream fout_tproj6;
  if (not openDataFile(fout_tproj6, dir + "/TrackletProjections_TPROJ_L1L2D_D3PHIA_04.dat")) return -1;

  ifstream fout_tproj7;
  if (not openDataFile(fout_tproj7, dir + "/TrackletProjections_TPROJ_L1L2D_D3PHIB_04.dat")) return -1;

  ifstream fout_tproj8;
  if (not openDataFile(fout_tproj8, dir + "/TrackletProjections_TPROJ_L1L2D_D3PHIC_04.dat")) return -1;

  ifstream fout_tproj9;
  if (not openDataFile(fout_tproj9, dir + "/TrackletProjections_TPROJ_L1L2D_D4PHIA_04.dat")) return -1;

  ifstream fout_tproj10;
  if (not openDataFile(fout_tproj10, dir + "/TrackletProjections_TPROJ_L1L2D_D4PHIB_04.dat")) return -1;

  ifstream fout_tproj11;
  if (not openDataFile(fout_tproj11, dir + "/TrackletProjections_TPROJ_L1L2D_D4PHIC_04.dat")) return -1;

  ifstream fout_tproj12;
  if (not openDataFile(fout_tproj12, dir + "/TrackletProjections_TPROJ_L1L2D_L3PHIA_04.dat")) return -1;

  ifstream fout_tproj13;
  if (not openDataFile(fout_tproj13, dir + "/TrackletProjections_TPROJ_L1L2D_L3PHIB_04.dat")) return -1;

  ifstream fout_tproj14;
  if (not openDataFile(fout_tproj14, dir + "/TrackletProjections_TPROJ_L1L2D_L4PHIA_04.dat")) return -1;

  ifstream fout_tproj15;
  if (not openDataFile(fout_tproj15, dir + "/TrackletProjections_TPROJ_L1L2D_L4PHIB_04.dat")) return -1;

  ifstream fout_tproj16;
  if (not openDataFile(fout_tproj16, dir + "/TrackletProjections_TPROJ_L1L2D_L5PHIA_04.dat")) return -1;

  ifstream fout_tproj17;
  if (not openDataFile(fout_tproj17, dir + "/TrackletProjections_TPROJ_L1L2D_L5PHIB_04.dat")) return -1;

  ifstream fout_tproj18;
  if (not openDataFile(fout_tproj18, dir + "/TrackletProjections_TPROJ_L1L2D_L5PHIC_04.dat")) return -1;

  ifstream fout_tproj19;
  if (not openDataFile(fout_tproj19, dir + "/TrackletProjections_TPROJ_L1L2D_L6PHIA_04.dat")) return -1;

  ifstream fout_tproj20;
  if (not openDataFile(fout_tproj20, dir + "/TrackletProjections_TPROJ_L1L2D_L6PHIB_04.dat")) return -1;

  ifstream fout_tproj21;
  if (not openDataFile(fout_tproj21, dir + "/TrackletProjections_TPROJ_L1L2D_L6PHIC_04.dat")) return -1;

  ///////////////////////////
  // loop over events
  cout << "Start event loop ..." << endl;
  for (unsigned int ievt = 0; ievt < nevents; ++ievt) {
    cout << "Event: " << dec << ievt << endl;

    // read event and write to memories
    writeMemFromFile<AllStubInnerMemory<BARRELPS> >(innerStubs[0], fin_innerStubs0, ievt);
    writeMemFromFile<AllStubInnerMemory<BARRELPS> >(innerStubs[1], fin_innerStubs1, ievt);
    writeMemFromFile<AllStubMemory<BARRELPS> >(outerStubs, fin_outerStubs, ievt);
    cout << "Will read vmstubs"<<endl;
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[0], fin_outervmstubs0, ievt);
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[1], fin_outervmstubs1, ievt);
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[2], fin_outervmstubs2, ievt);
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[3], fin_outervmstubs3, ievt);
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[4], fin_outervmstubs4, ievt);
    writeMemFromFile<VMStubTEOuterMemoryCM<BARRELPS> >(outervmStubs[5], fin_outervmstubs5, ievt);

    // bx
    BXType bx = ievt;

    // Unit Under Test
    TrackletProcessor_L1L2D(bx, 
			    innervmtable, 
			    useregion, 
			    innerStubs, 
			    &outerStubs, 
			    outervmStubs,
			    &tpar,
			    tproj_barrel_ps,
			    tproj_barrel_2s,
			    tproj_disk
			    );

    bool truncate;

    cout << "Start compare" << endl;

    // compare the computed outputs with the expected ones
    err += compareMemWithFile<TrackletParameterMemory>(tpar, fout_tpar, ievt,
                                                   "\nTrackletParameter", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D1PHIA], fout_tproj0, ievt,
                                                   "\nTrackletProjection (D1PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D1PHIB], fout_tproj1, ievt,
                                                   "\nTrackletProjection (D1PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D1PHIC], fout_tproj2, ievt,
                                                   "\nTrackletProjection (D1PHIC)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D2PHIA], fout_tproj3, ievt,
                                                   "\nTrackletProjection (D2PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D2PHIB], fout_tproj4, ievt,
                                                   "\nTrackletProjection (D2PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D2PHIC], fout_tproj5, ievt,
                                                   "\nTrackletProjection (D2PHIC)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D3PHIA], fout_tproj6, ievt,
                                                   "\nTrackletProjection (D3PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D3PHIB], fout_tproj7, ievt,
                                                   "\nTrackletProjection (D3PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D3PHIC], fout_tproj8, ievt,
                                                   "\nTrackletProjection (D3PHIC)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D4PHIA], fout_tproj9, ievt,
                                                   "\nTrackletProjection (D4PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D4PHIB], fout_tproj10, ievt,
                                                   "\nTrackletProjection (D4PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<DISK> >(tproj_disk[TC::D4PHIC], fout_tproj11, ievt,
                                                   "\nTrackletProjection (D4PHIC)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARRELPS> >(tproj_barrel_ps[TC::L3PHIA], fout_tproj12, ievt,
                                                   "\nTrackletProjection (L3PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARRELPS> >(tproj_barrel_ps[TC::L3PHIB], fout_tproj13, ievt,
                                                   "\nTrackletProjection (L3PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L4PHIA], fout_tproj14, ievt,
                                                   "\nTrackletProjection (L4PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L4PHIB], fout_tproj15, ievt,
                                                   "\nTrackletProjection (L4PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L5PHIA], fout_tproj16, ievt,
                                                   "\nTrackletProjection (L5PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L5PHIB], fout_tproj17, ievt,
                                                   "\nTrackletProjection (L5PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L5PHIC], fout_tproj18, ievt,
                                                   "\nTrackletProjection (L5PHIC)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L6PHIA], fout_tproj19, ievt,
                                                   "\nTrackletProjection (L6PHIA)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L6PHIB], fout_tproj20, ievt,
                                                   "\nTrackletProjection (L6PHIB)", truncate);
    err += compareMemWithFile<TrackletProjectionMemory<BARREL2S> >(tproj_barrel_2s[TC::L6PHIC], fout_tproj21, ievt,
                                                   "\nTrackletProjection (L6PHIC)", truncate);
    cout << endl;

  } // end of event loop

  cout << "Number of errors : "<<err<<endl;
  //return err;
  return 0;

}
