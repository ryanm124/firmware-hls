# Script to generate project for PR
#   vivado_hls -f script_PR.tcl
#   vivado_hls -p match_processor
# WARNING: this will wipe out the original project by the same name

# get some information about the executable and environment
source env_hls.tcl

# create new project (deleting any existing one of same name)
open_project -reset match_processor

# source files
set CFLAGS {-std=c++11 -I../TrackletAlgorithm}
set_top MatchProcessor_L3PHIC
add_files ../TrackletAlgorithm/MatchProcessorTop.cc -cflags "$CFLAGS"
add_files -tb ../TestBenches/MatchProcessor_test.cpp -cflags "$CFLAGS"

open_solution "solution1"

# Define FPGA, clock frequency & common HLS settings.
source settings_hls.tcl

# data files
add_files -tb ../emData/MP/

csim_design -mflags "-j8"
csynth_design
cosim_design 
export_design -format ip_catalog
# Adding "-flow impl" runs full Vivado implementation, providing accurate resource use numbers (very slow).
#export_design -format ip_catalog -flow impl

exit
