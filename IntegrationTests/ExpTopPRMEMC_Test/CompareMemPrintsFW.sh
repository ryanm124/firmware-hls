#!/bin/bash
# Run the CompareMemPrintsFW.py

set -o pipefail # keep exit status

N_ERR=0 # Error counter

if test -f ./TextIO/AP_L3PHIC.txt; then
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/TrackletProjections/AllProj_AP_L3PHIC_04.dat -c TextIO/AP_L3PHIC.txt |tee TextIO/AP_L3PHIC_cmp.txt
  N_ERR=$(($N_ERR + $?))
fi

if test -f ./TextIO/VMPROJ_L3PHIC17.txt; then
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC17_04.dat -c TextIO/VMPROJ_L3PHIC17.txt |tee TextIO/VMPROJ_L3PHIC17_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC18_04.dat -c TextIO/VMPROJ_L3PHIC18.txt |tee TextIO/VMPROJ_L3PHIC18_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC19_04.dat -c TextIO/VMPROJ_L3PHIC19.txt |tee TextIO/VMPROJ_L3PHIC19_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC20_04.dat -c TextIO/VMPROJ_L3PHIC20.txt |tee TextIO/VMPROJ_L3PHIC20_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC21_04.dat -c TextIO/VMPROJ_L3PHIC21.txt |tee TextIO/VMPROJ_L3PHIC21_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC22_04.dat -c TextIO/VMPROJ_L3PHIC22.txt |tee TextIO/VMPROJ_L3PHIC22_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC23_04.dat -c TextIO/VMPROJ_L3PHIC23.txt |tee TextIO/VMPROJ_L3PHIC23_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/VMProjections/VMProjections_VMPROJ_L3PHIC24_04.dat -c TextIO/VMPROJ_L3PHIC24.txt |tee TextIO/VMPROJ_L3PHIC24_cmp.txt
  N_ERR=$(($N_ERR + $?))
fi

if test -f ./TextIO/CM_L3PHIC17.txt; then
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC17_04.dat -c TextIO/CM_L3PHIC17.txt |tee TextIO/CM_L3PHIC17_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC18_04.dat -c TextIO/CM_L3PHIC18.txt |tee TextIO/CM_L3PHIC18_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC19_04.dat -c TextIO/CM_L3PHIC19.txt |tee TextIO/CM_L3PHIC19_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC20_04.dat -c TextIO/CM_L3PHIC20.txt |tee TextIO/CM_L3PHIC20_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC21_04.dat -c TextIO/CM_L3PHIC21.txt |tee TextIO/CM_L3PHIC21_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC22_04.dat -c TextIO/CM_L3PHIC22.txt |tee TextIO/CM_L3PHIC22_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC23_04.dat -c TextIO/CM_L3PHIC23.txt |tee TextIO/CM_L3PHIC23_cmp.txt
  N_ERR=$(($N_ERR + $?))
  python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/CandidateMatches_CM_L3PHIC24_04.dat -c TextIO/CM_L3PHIC24.txt |tee TextIO/CM_L3PHIC24_cmp.txt
  N_ERR=$(($N_ERR + $?))
fi

python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/FullMatches_FM_L1L2_L3PHIC_04.dat -c TextIO/FM_L1L2XX_L3PHIC.txt |tee TextIO/FM_L1L2XX_L3PHIC_cmp.txt
N_ERR=$(($N_ERR + $?))
python3 CompareMemPrintsFW.py -r ../../emData/MemPrints/Matches/FullMatches_FM_L5L6_L3PHIC_04.dat -c TextIO/FM_L5L6XX_L3PHIC.txt |tee TextIO/FM_L5L6XX_L3PHIC_cmp.txt
N_ERR=$(($N_ERR + $?))

echo "Accumulated number of errors =" $N_ERR

set +o pipefail

exit $N_ERR