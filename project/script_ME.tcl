# Script to generate project for ME
#   vivado_hls -f script_ME.tcl
#   vivado_hls -p matchengine
# WARNING: this will wipe out the original project by the same name

# create new project (deleting any existing one of same name)
#open_project -reset matchengine_x1_L1Test
open_project -reset supermatchengine_meta_x1_L1Test

# source files
# Optional Flags: -DDEBUG -DSUPER
set CFLAGS {-std=c++11 -I../TrackletAlgorithm -DSUPER}
#set_top MatchEngineTop
set_top SuperMatchEngineTop
add_files ../TrackletAlgorithm/MatchEngine.cc -cflags "$CFLAGS"
add_files -tb ../TestBenches/MatchEngine_test.cpp -cflags "$CFLAGS"

open_solution "solution1"

# Define FPGA, clock frequency & common HLS settings.
source settings_hls.tcl

# data files
add_files -tb ../emData/ME/

set t0 [clock clicks -millisec]
csim_design -compiler gcc -mflags "-j8"
puts stderr "CSIM Finished After [expr {([clock clicks -millisec]-$t0)/1000.}] sec" ;# RS
# csynth_design
# puts stderr "CSYNTH Finished After [expr {([clock clicks -millisec]-$t0)/1000.}] sec" ;# RS
# cosim_design -trace_level all -rtl verilog -verbose
# puts stderr "COSIM Finished After [expr {([clock clicks -millisec]-$t0)/1000.}] sec" ;# RS
#export_design -format ip_catalog

# Adding "-flow impl" runs full Vivado implementation, providing accurate resource use numbers (very slow).

# export_design -rtl verilog -format ip_catalog -flow impl
# puts stderr "EXPORT Finished After [expr {([clock clicks -millisec]-$t0)/1000.}] sec" ;# RS


exit
