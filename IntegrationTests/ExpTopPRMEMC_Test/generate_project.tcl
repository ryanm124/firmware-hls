# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Set the project name
set _xil_proj_name_ "ExpTopPRMEMC_Test"

# Create project
create_project -force ${_xil_proj_name_} ./${_xil_proj_name_} -part xcvu7p-flvb2104-1-e

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$origin_dir/../../project/"]" $obj


# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/../../TrackletAlgorithm/Memory.v"] \
 [file normalize "${origin_dir}/../../TrackletAlgorithm/MemoryBinned.v"] \
 [file normalize "${origin_dir}/sourceFiles/mytypes_pkg.vhd"] \
 [file normalize "${origin_dir}/sourceFiles/top_tf.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
	       [file normalize "${origin_dir}/sourceFiles/tb_top_tf.vhd"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2F_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2G_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2H_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2I_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2J_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6B_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6C_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6D_L3PHIC_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/ME/ME_L3PHIC20/VMStubs_VMSME_L3PHIC20n1_04.dat"] \
	       [file normalize "${origin_dir}/../../emData/MC/MC_L3PHIC/AllStubs_AS_L3PHICn6_04.dat"] \

]
add_files -norecurse -fileset $obj $files

# Create .xci file
create_ip -name MatchCalculatorTop -vendor xilinx.com -library hls -version 1.0 -module_name MC_L3PHIC
create_ip -name MatchEngineTop -vendor xilinx.com -library hls -version 1.0 -module_name MatchEngineTopL3_0
create_ip -name ProjectionRouterTop -vendor xilinx.com -library hls -version 1.0 -module_name PR_L3PHIC

# Make sourcefiles
set file "${origin_dir}/sourceFiles/top_tf.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "${origin_dir}/sourceFiles/tb_top_tf.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "tb_top_tf" -objects $obj
set_property -name "xsim.simulate.runtime" -value "6000ns" -objects $obj

puts "INFO: Project created:${_xil_proj_name_}"

# Launch Simulation
launch_simulation


exit
