
/nfs/opt/Xilinx/Vivado/2019.2/bin/xelab xil_defaultlib.apatb_TrackletProcessor_L2L3C_top glbl -prj TrackletProcessor_L2L3C.prj -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_12 -L axi_protocol_checker_v1_1_13 -L axis_protocol_checker_v1_1_11 -L axis_protocol_checker_v1_1_12 -L xil_defaultlib -L unisims_ver -L xpm --initfile "/nfs/opt/Xilinx/Vivado/2019.2/data/xsim/ip/xsim_ip.ini" --lib "ieee_proposed=./ieee_proposed" -s TrackletProcessor_L2L3C 
/nfs/opt/Xilinx/Vivado/2019.2/bin/xsim --noieeewarnings TrackletProcessor_L2L3C -tclbatch TrackletProcessor_L2L3C.tcl

