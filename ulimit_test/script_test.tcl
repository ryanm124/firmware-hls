# Script to generate test project
#   vivado_hls -f script_test.tcl
#   vivado_hls -p test
# WARNING: this will wipe out the original project by the same name

# create new project (deleting any existing one of same name)
open_project -reset test

# source files
set CFLAGS {-std=c++11}
set_top testFunction
add_files ./test.cc -cflags "$CFLAGS"
add_files -tb ./testbench.cpp -cflags "$CFLAGS"

open_solution "solution1"

# Set FPGA
set_part {xcvu7p-flvb2104-1-e} -tool vivado

# Set clock frequency
create_clock -period 250MHz -name default

# Allow HLS to use longer (easier to understand) names in resource/latency usage profiles.
config_compile -name_max_length 100

csim_design -compiler gcc -mflags "-j8"
csynth_design
cosim_design
#export_design -format ip_catalog

exit
