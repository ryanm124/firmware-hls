# Simulate, synthesize, and export current version of PR, ME, MC
cd ../../project
vivado_hls -f script_PR.tcl
vivado_hls -f script_ME.tcl
vivado_hls -f script_MC.tcl

# Download needed data files to populate initial memories and compare final memories
cd ../IntegrationTests/ExpTopPRMEMC_Test/emData
. download.sh

# Open the Vivado GUI and initialize the project
cd ../
vivado -mode tcl -source generate_project.tcl
