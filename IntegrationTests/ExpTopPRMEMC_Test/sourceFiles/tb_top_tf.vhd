--==========================================================================
-- CU Boulder
-------------------------------------------------------------------------------
--! @file
--! @brief Test bench for the track finding top using TextIO. 
--! @author Glein
--! @date 2020-05-18
--! @version v.1.0
--=============================================================================

--! Standard library
library ieee;
--! Standard package
use ieee.std_logic_1164.all;
--! Signed/unsigned calculations
use ieee.numeric_std.all;
--! Math real
use ieee.math_real.all;
--! TextIO
use ieee.std_logic_textio.all;
--! Standard functions
library std;
--! Standard TextIO functions
use std.textio.all;

--! Xilinx library
library unisim;
--! Xilinx package
use unisim.vcomponents.all;

--! User packages
use work.mytypes_pkg.all;



--! @brief TB
entity tb_top_tf is
end tb_top_tf;

--! @brief TB
architecture behavior of tb_top_tf is
	-- ########################### Types ###########################
	type t_str_array_VMSME is array(natural range <>) of string(1 to 79); --! String array
	type t_str_array_TPROJ is array(natural range <>) of string(1 to 103); --! String array
	type t_myarray_1d_1d_int    is array(natural range <>) of t_myarray_1d_int(0 to MAX_EVENTS-1);                      --! 1x1D array of int
	type t_myarray_1d_2d_int    is array(natural range <>) of t_myarray_2d_int(0 to MAX_EVENTS-1,0 to N_MEM_BINS-1);    --! 1x2D array of int
	type t_myarray_1d_2d_slv_2p is array(natural range <>) of t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 2*PAGE_OFFSET-1); --! 1x2D array of slv
	type t_myarray_1d_2d_slv_8p is array(natural range <>) of t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! 1x2D array of slv

	-- ########################### Constant Definitions ###########################
	-- ############ Please change the constants in this section ###################
	constant N_ME_IN_CHAIN : integer := 8; --! Number of match engines in chain 
	constant FILE_IN_TPROJ : t_str_array_TPROJ(0 to N_ME_IN_CHAIN-1) := ("../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L1L2H_L3PHIC_04.dat", --! Input files
                                																			 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L5L6C_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L1L2I_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L5L6B_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L5L6D_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L1L2J_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L1L2G_L3PHIC_04.dat",
											                                								 "../../../../../../../emData/MemPrints/TrackletProjections/TrackletProjections_TPROJ_L1L2F_L3PHIC_04.dat" );
	constant FILE_IN_VMSME : t_str_array_VMSME(0 to N_ME_IN_CHAIN-1) := ("../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC17n1_04.dat", --! Input files
                                																			 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC18n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC19n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC20n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC21n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC22n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC23n1_04.dat",
											                                								 "../../../../../../../emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC24n1_04.dat" );
	constant FILE_IN_AS        : string := "../../../../../../../emData/MemPrints/Stubs/AllStubs_AS_L3PHICn6_04.dat"; --! Input file
	constant FILE_OUT					 : string := "../../../../../output.txt"; --! Output file
	constant N_ADD_WR_LINES 	 : integer := 250;        --! Number of additional lines for the output file 
	                                                    --! incl. number of header and comment lines of the input file
	constant CLK_PERIOD        : time    := 4.16667 ns; --! 240 MHz
	constant DEBUG             : boolean := true;       --! Debug off/on
	constant VMSME_DELAY       : integer := 1-1;        --! Number of BX delays
	constant AS_DELAY          : integer := 2-1;        --! Number of BX delays

	-- ########################### Signals ###########################
	-- ### UUT signals ###
  signal clk     : std_logic := '0';
  signal reset   : std_logic := '1';
  signal en_proc : std_logic := '0';
  signal bx_in_ProjectionRouter : std_logic_vector(2 downto 0) := (others => '0');
  -- For TrackletProjections memories
  signal TPROJ_L3PHIC_dataarray_data_V_wea       : t_myarray8_1b   := (others => '0');
  signal TPROJ_L3PHIC_dataarray_data_V_writeaddr : t_myarray8_8b   := (others => (others => '0'));
  signal TPROJ_L3PHIC_dataarray_data_V_din       : t_myarray8_60b  := (others => (others => '0'));
  signal TPROJ_L3PHIC_nentries_V_we  : t_myarray2_8_1b := (others => (others => '0'));
  signal TPROJ_L3PHIC_nentries_V_din : t_myarray2_8_8b := (others => (others => (others => '0')));
  -- For VMStubME memories
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_wea       : t_myarray8_1b  := (others => '0');
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr : t_myarray8_9b  := (others => (others => '0'));
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_din       : t_myarray8_14b := (others => (others => '0'));
  signal VMSME_L3PHIC17to24n1_nentries_V_we  : t_myarray8_8_8_1b := (others => (others => (others => '0')));
  signal VMSME_L3PHIC17to24n1_nentries_V_din : t_myarray8_8_8_4b := (others => (others => (others => (others => '0'))));
  -- For AllStubs memories
  signal AS_L3PHICn4_dataarray_data_V_wea       : std_logic                     := '0';
  signal AS_L3PHICn4_dataarray_data_V_writeaddr : std_logic_vector(9 downto 0)  := (others => '0');
  signal AS_L3PHICn4_dataarray_data_V_din       : std_logic_vector(35 downto 0) := (others => '0');
  signal AS_L3PHICn4_nentries_V_we  : t_myarray8_1b := (others => '0');
  signal AS_L3PHICn4_nentries_V_din : t_myarray8_8b := (others => (others => '0'));
  -- FullMatches output
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_enb      : std_logic                     := '0'; 
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0)  := (others => '0');
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_dout     : std_logic_vector(44 downto 0);
  signal FM_L1L2XX_L3PHIC_nentries_V_dout : t_myarray2_8b;
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_enb      : std_logic                     := '0';
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0)  := (others => '0');
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_dout     : std_logic_vector(44 downto 0);
  signal FM_L5L6XX_L3PHIC_nentries_V_dout : t_myarray2_8b;
  -- MatchCalculator outputs
  signal bx_out_MatchCalculator     : std_logic_vector(2 downto 0);
  signal bx_out_MatchCalculator_vld : std_logic;
  signal MatchCalculator_done       : std_logic;
  -- ### Other signals ###
  signal TPROJ_L3PHICn4_data_arr            : t_myarray_1d_2d_slv_2p(0 to N_ME_IN_CHAIN-1);
	signal TPROJ_L3PHICn4_n_entries_arr       : t_myarray_1d_1d_int(0 to N_ME_IN_CHAIN-1);
	signal VMSME_L3PHIC17to24n1_data_arr      : t_myarray_1d_2d_slv_8p(0 to N_ME_IN_CHAIN-1);
	signal VMSME_L3PHIC17to24n1_n_entries_arr : t_myarray_1d_2d_int(0 to N_ME_IN_CHAIN-1);
	signal AS_L3PHICn4_data_arr               : t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1);
	signal AS_L3PHICn4_n_entries_arr          : t_myarray_1d_int(0 to MAX_EVENTS-1);
	signal bx_cnt                             : integer := 0; -- BX counter
	signal page_cnt2                          : integer := 0; -- Page counter
	signal page_cnt8                          : integer := 0; -- Page counter

begin

	--! @brief Read emData process
	read_data : process
		variable v_TPROJ_L3PHICn4_data_arr            : t_myarray_1d_2d_slv_2p(0 to N_ME_IN_CHAIN-1);
		variable v_TPROJ_L3PHICn4_n_entries_arr       : t_myarray_1d_1d_int(0 to N_ME_IN_CHAIN-1);
		variable v_VMSME_L3PHIC17to24n1_data_arr      : t_myarray_1d_2d_slv_8p(0 to N_ME_IN_CHAIN-1);
		variable v_VMSME_L3PHIC17to24n1_n_entries_arr : t_myarray_1d_2d_int(0 to N_ME_IN_CHAIN-1);
		variable v_AS_L3PHICn4_data_arr               : t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to N_ME_IN_CHAIN*PAGE_OFFSET-1);
		variable v_AS_L3PHICn4_n_entries_arr          : t_myarray_1d_int(0 to MAX_EVENTS-1);
		variable v_line_in : line; -- Line for debug
	begin
		-- TPROJ
		l_TPROJ_read : for i in 0 to N_ME_IN_CHAIN-1 loop
			read_emData_2p (FILE_IN_TPROJ(i), v_TPROJ_L3PHICn4_data_arr(i), v_TPROJ_L3PHICn4_n_entries_arr(i));
			if DEBUG=true then write(v_line_in, string'("TPROJ_i: ")); write(v_line_in, i); write(v_line_in, string'(";   v_TPROJ_L3PHICn4_data_arr(i)(0,0): ")); hwrite(v_line_in, v_TPROJ_L3PHICn4_data_arr(i)(0,0)); writeline(output, v_line_in); end if;
    	if DEBUG=true then write(v_line_in, string'("TPROJ_i: ")); write(v_line_in, i); write(v_line_in, string'(";   v_TPROJ_L3PHICn4_n_entries_arr(i)(0): ")); write(v_line_in, v_TPROJ_L3PHICn4_n_entries_arr(i)(0)); writeline(output, v_line_in); end if;
		end loop l_TPROJ_read;
		if DEBUG=true then write(v_line_in, string'("v_TPROJ_L3PHICn4_data_arr(0)(99,0+128): ")); hwrite(v_line_in, v_TPROJ_L3PHICn4_data_arr(0)(99,0+128)); writeline(output, v_line_in); end if;
		if DEBUG=true then write(v_line_in, string'("v_TPROJ_L3PHICn4_data_arr(0)(99,3+128): ")); hwrite(v_line_in, v_TPROJ_L3PHICn4_data_arr(0)(99,3+128)); writeline(output, v_line_in); end if;
		if DEBUG=true then write(v_line_in, string'("v_TPROJ_L3PHICn4_n_entries_arr(0)(99): "));   write(v_line_in, v_TPROJ_L3PHICn4_n_entries_arr(0)(99)); writeline(output, v_line_in); end if;
		-- VMSME
		l_VMSME_read : for i in 0 to N_ME_IN_CHAIN-1 loop
			read_emData_8p_bin (FILE_IN_VMSME(i), v_VMSME_L3PHIC17to24n1_data_arr(i), v_VMSME_L3PHIC17to24n1_n_entries_arr(i));
			if DEBUG=true then write(v_line_in, string'("VMSME_i: ")); write(v_line_in, i); write(v_line_in, string'(";   v_VMSME_L3PHIC17to24n1_data_arr(i)(0,0): ")); hwrite(v_line_in, v_VMSME_L3PHIC17to24n1_data_arr(i)(0,0)); writeline(output, v_line_in); end if;
    	if DEBUG=true then write(v_line_in, string'("VMSME_i: ")); write(v_line_in, i); write(v_line_in, string'(";   v_VMSME_L3PHIC17to24n1_n_entries_arr(i)(0,0): ")); write(v_line_in, v_VMSME_L3PHIC17to24n1_n_entries_arr(i)(0,0)); writeline(output, v_line_in); end if;
		end loop l_VMSME_read;
		if DEBUG=true then write(v_line_in, string'("v_VMSME_L3PHIC17to24n1_data_arr(0)(99,3*PAGE_OFFSET+7*N_ENTRIES_PER_MEM_BINS): ")); hwrite(v_line_in, v_VMSME_L3PHIC17to24n1_data_arr(0)(99,3*PAGE_OFFSET+7*N_ENTRIES_PER_MEM_BINS)); writeline(output, v_line_in); end if;
    	if DEBUG=true then write(v_line_in, string'("v_VMSME_L3PHIC17to24n1_n_entries_arr(0)(99,7): ")); write(v_line_in, v_VMSME_L3PHIC17to24n1_n_entries_arr(0)(99,7)); writeline(output, v_line_in); end if;
		l_VMSME_debug0 : for i in 0 to 64 loop
    	if DEBUG=true then write(v_line_in, string'("addr: ")); write(v_line_in, i); write(v_line_in, string'(";   v_VMSME_L3PHIC17to24n1_data_arr(0)(0,addr): ")); hwrite(v_line_in, v_VMSME_L3PHIC17to24n1_data_arr(0)(0,i)); writeline(output, v_line_in); end if;
		end loop l_VMSME_debug0;
		l_VMSME_debug99 : for i in 3*PAGE_OFFSET to 3*PAGE_OFFSET+112 loop
    	if DEBUG=true then write(v_line_in, string'("addr: ")); write(v_line_in, i); write(v_line_in, string'(";   v_VMSME_L3PHIC17to24n1_data_arr(0)(99,addr): ")); hwrite(v_line_in, v_VMSME_L3PHIC17to24n1_data_arr(0)(99,i)); writeline(output, v_line_in); end if;
		end loop l_VMSME_debug99;
		-- AS
		read_emData_8p (FILE_IN_AS, v_AS_L3PHICn4_data_arr, v_AS_L3PHICn4_n_entries_arr);
    if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_data_arr(0,0): "));         hwrite(v_line_in, v_AS_L3PHICn4_data_arr(0,0)); writeline(output, v_line_in); end if;
    if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_data_arr(0,71): "));        hwrite(v_line_in, v_AS_L3PHICn4_data_arr(0,71)); writeline(output, v_line_in); end if;
    if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_n_entries_arr(0): "));       write(v_line_in, v_AS_L3PHICn4_n_entries_arr(0)); writeline(output, v_line_in); end if;
		if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_data_arr(99,0+128*3): "));  hwrite(v_line_in, v_AS_L3PHICn4_data_arr(99,0+128*3)); writeline(output, v_line_in); end if;
		if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_data_arr(99,35+128*3): ")); hwrite(v_line_in, v_AS_L3PHICn4_data_arr(99,35+128*3)); writeline(output, v_line_in); end if;
		if DEBUG=true then write(v_line_in, string'("v_AS_L3PHICn4_n_entries_arr(99): "));      write(v_line_in, v_AS_L3PHICn4_n_entries_arr(99)); writeline(output, v_line_in); end if;
    -- Map variables to signals
    TPROJ_L3PHICn4_data_arr            <= v_TPROJ_L3PHICn4_data_arr;
    TPROJ_L3PHICn4_n_entries_arr       <= v_TPROJ_L3PHICn4_n_entries_arr;
    VMSME_L3PHIC17to24n1_data_arr      <= v_VMSME_L3PHIC17to24n1_data_arr;
    VMSME_L3PHIC17to24n1_n_entries_arr <= v_VMSME_L3PHIC17to24n1_n_entries_arr;
    AS_L3PHICn4_data_arr               <= v_AS_L3PHICn4_data_arr;
    AS_L3PHICn4_n_entries_arr          <= v_AS_L3PHICn4_n_entries_arr;
    wait;
	end process read_data;

  --! @brief Playback process
  --! @BoBX0: en_proc=0, 	w TPROJ p1,
	--! @BoBX1: en_proc=1, 	w TPROJ p2,	w VMSME p1
	--! @BoBX2: en_proc=1, 	w TPROJ p1,	w VMSME p2, w AS p1
	--! @BoBX3: en_proc=1, 	w TPROJ p2,	w VMSME p3, w AS p2
	--! @BoBX3: en_proc=1, 	w TPROJ p1,	w VMSME p4, w AS p3
	--! ...
	playback : process
		variable v_page_cnt2_d0            : integer := 0; -- Page counter 
		variable v_page_cnt2_d1            : integer := 0; -- Page counter delayed by one
		variable v_page_cnt8               : integer := 0; -- Page counter
		variable v_VMSME_n_entries_bin     : t_myarray_1d_int(0 to N_ENTRIES_PER_MEM_BINS-1) := (others => 0); -- Number of VMSME entries per bin
		variable v_VMSME_n_entries_bin_cnt : t_myarray_1d_int(0 to N_ENTRIES_PER_MEM_BINS-1) := (others => 0); -- Counter of VMSME entries per bin
		variable v_bin_cnt                 : t_myarray_1d_int(0 to N_ME_IN_CHAIN-1) := (others => 0); -- Bin counter
		variable v_last_bin                : boolean := false; -- Last bin tag
	begin
		wait for CLK_PERIOD; -- Let the read process finish
		reset <= '0';        -- Relase reset
		l_BX : for v_bx_cnt in -1 to MAX_EVENTS+1 loop -- -1 (to write the first memories before starting) to 101
		  bx_cnt         <= v_bx_cnt; -- Update the signal
		  v_page_cnt2_d0 := v_bx_cnt mod 2; -- mod 2
		  v_page_cnt2_d1 := (v_bx_cnt+1) mod 2; -- mod 2
		  v_page_cnt8    := v_bx_cnt mod N_MEM_BINS; -- mod 8
		  page_cnt2      <= v_page_cnt2_d0; -- Update the signal
		  page_cnt8      <= v_page_cnt8;    -- Update the signal
		  v_bin_cnt      := (others => 0);
		  v_VMSME_n_entries_bin_cnt := (others => 0);
			l_addr : for addr in 0 to MAX_ENTRIES-1 loop -- 0 to 107
				l_copies : for cp in 0 to N_ME_IN_CHAIN-1 loop -- 0 to 7 -- Unable to assign arrays directly
					v_last_bin := false; -- Default assigment
				  -- TPROJ
				  if (v_bx_cnt<MAX_EVENTS-1) then -- Start and stop early
				    TPROJ_L3PHIC_dataarray_data_V_wea <= (others => '1');             
			      TPROJ_L3PHIC_nentries_V_we        <= (others => (others => '1'));
						TPROJ_L3PHIC_dataarray_data_V_writeaddr(cp) <= std_logic_vector(to_unsigned(addr+PAGE_OFFSET*v_page_cnt2_d1, TPROJ_L3PHIC_dataarray_data_V_writeaddr(0)'length));
						TPROJ_L3PHIC_dataarray_data_V_din(cp)       <= TPROJ_L3PHICn4_data_arr(cp)(v_bx_cnt+1,addr+PAGE_OFFSET*v_page_cnt2_d1) (TPROJ_L3PHIC_dataarray_data_V_din(0)'length-1 downto 0);
					  TPROJ_L3PHIC_nentries_V_din(v_page_cnt2_d1,cp) <= std_logic_vector(to_unsigned(TPROJ_L3PHICn4_n_entries_arr(cp)(v_bx_cnt+1), TPROJ_L3PHIC_nentries_V_din(0,0)'length));
					end if;
					-- VMSME
					if (v_bx_cnt>=VMSME_DELAY and v_bx_cnt<MAX_EVENTS) then -- Start after delay of BXs
						en_proc <= '1'; -- Start the chain
						VMSME_L3PHIC17to24n1_dataarray_data_V_wea(cp) <= '1';                                     -- Default assigment
				    VMSME_L3PHIC17to24n1_nentries_V_we            <= (others => (others => (others => '1'))); -- Default assigment
						if v_bin_cnt(cp)<=N_MEM_BINS-1 then -- Valid bin
							v_VMSME_n_entries_bin(cp) := VMSME_L3PHIC17to24n1_n_entries_arr(cp)(v_bx_cnt-VMSME_DELAY,v_bin_cnt(cp));
							VMSME_L3PHIC17to24n1_nentries_V_din(((v_page_cnt8-VMSME_DELAY) mod N_MEM_BINS),cp,v_bin_cnt(cp)) <= std_logic_vector(to_unsigned(v_VMSME_n_entries_bin(cp), VMSME_L3PHIC17to24n1_nentries_V_din(0,0,0)'length));
						end if;
					  l_bin_empty : while (v_VMSME_n_entries_bin(cp)<=0) loop -- Bin empty
					  	v_bin_cnt(cp)             := v_bin_cnt(cp) +1;
					  	if v_bin_cnt(cp)<=N_MEM_BINS-1 then -- Valid bin
					  		v_VMSME_n_entries_bin(cp) := VMSME_L3PHIC17to24n1_n_entries_arr(cp)(v_bx_cnt-VMSME_DELAY,v_bin_cnt(cp));
					  	else
					  		v_bin_cnt(cp) := N_MEM_BINS;
								exit;
							end if;
					  end loop l_bin_empty;
						if v_bin_cnt(cp)<=N_MEM_BINS-1 then -- Valid bin
							VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr(cp) <= std_logic_vector(to_unsigned((v_bin_cnt(cp)*N_ENTRIES_PER_MEM_BINS+v_VMSME_n_entries_bin_cnt(cp)) + (PAGE_OFFSET*((v_page_cnt8-VMSME_DELAY) mod N_MEM_BINS)), VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr(0)'length));
							VMSME_L3PHIC17to24n1_dataarray_data_V_din(cp)       <= VMSME_L3PHIC17to24n1_data_arr(cp)(v_bx_cnt-VMSME_DELAY, (v_bin_cnt(cp)*N_ENTRIES_PER_MEM_BINS+v_VMSME_n_entries_bin_cnt(cp)) + (PAGE_OFFSET*((v_page_cnt8-VMSME_DELAY) mod N_MEM_BINS))) (VMSME_L3PHIC17to24n1_dataarray_data_V_din(0)'length-1 downto 0);
						end if;
						--if DEBUG=true then assert (addr>1 or v_bx_cnt>0) report "addr = " & integer'image(addr) & ";   cp = " & integer'image(addr) & ";   v_bin_cnt(0) = " & integer'image(v_bin_cnt(0)) & ";   v_VMSME_n_entries_bin_cnt(cp) = " & integer'image(v_VMSME_n_entries_bin_cnt(cp)) & ";   waddr = " & integer'image((v_bin_cnt(0)*N_ENTRIES_PER_MEM_BINS+v_VMSME_n_entries_bin_cnt(cp)) + (PAGE_OFFSET*((v_page_cnt8-VMSME_DELAY) mod N_MEM_BINS))) severity note; end if;
						if v_VMSME_n_entries_bin_cnt(cp)>=v_VMSME_n_entries_bin(cp)-1 then -- End of bin entries
							if (v_bin_cnt(cp)=N_MEM_BINS-1) then -- Last bin
								v_last_bin := true;
							end if;
							v_bin_cnt(cp)                 := v_bin_cnt(cp) +1;
							v_VMSME_n_entries_bin_cnt(cp) := 0;
							if (v_bin_cnt(cp)>=N_MEM_BINS) then
								v_bin_cnt(cp)               := N_MEM_BINS; -- End of write for this addr
							end if;
						else
							v_VMSME_n_entries_bin_cnt(cp) := v_VMSME_n_entries_bin_cnt(cp) +1;
						end if;
						if v_bin_cnt(cp)>N_MEM_BINS-1 then -- Invalid bin
							v_bin_cnt(cp) := N_MEM_BINS; 
							if v_last_bin=false then
								VMSME_L3PHIC17to24n1_dataarray_data_V_wea(cp) <= '0';
								VMSME_L3PHIC17to24n1_nentries_V_we            <= (others => (others => (others => '0')));
							end if;
						end if;
					end if;
					-- AS
					if (v_bx_cnt>=AS_DELAY and v_bx_cnt<MAX_EVENTS+1) then -- Start after delay of BXs
					  AS_L3PHICn4_dataarray_data_V_wea <= '1';
				    AS_L3PHICn4_nentries_V_we        <= (others => '1');
	          AS_L3PHICn4_dataarray_data_V_writeaddr  <= std_logic_vector(to_unsigned(addr+(PAGE_OFFSET*((v_page_cnt8-AS_DELAY) mod N_MEM_BINS)),AS_L3PHICn4_dataarray_data_V_writeaddr'length));
	          AS_L3PHICn4_dataarray_data_V_din        <= AS_L3PHICn4_data_arr(v_bx_cnt-AS_DELAY,addr+(PAGE_OFFSET*((v_page_cnt8-AS_DELAY) mod N_MEM_BINS))) (AS_L3PHICn4_dataarray_data_V_din'length-1 downto 0); 
	          AS_L3PHICn4_nentries_V_din((v_page_cnt8-AS_DELAY) mod N_MEM_BINS) <= std_logic_vector(to_unsigned(AS_L3PHICn4_n_entries_arr(v_bx_cnt-AS_DELAY), AS_L3PHICn4_nentries_V_din(0)'length));
          end if;
			  end loop l_copies;
	      wait for CLK_PERIOD; -- Main time control
				--if DEBUG=true then assert (v_bx_cnt>0) report "addr = " & integer'image(addr) & ";   VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr(0) = " & integer'image(to_integer(unsigned(VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr(0)))) severity note; end if;
			end loop l_addr;
		end loop l_BX;
		wait for CLK_PERIOD;
assert false report "Simulation finished!" severity FAILURE;
	end process playback;

	--! @brief TextIO process for writting the output
	write_result : process
		file     file_out : text open WRITE_MODE is FILE_OUT; -- Text - a file of character strings
    variable v_line   : line;                             -- Line - one string from a text
	begin
		-- Write file header
		write(v_line, string'("time"), right, 12); write(v_line, string'("BX#"), right, 4); --write(v_line, string'("addr"), right, 7);
    write(v_line, string'("reset"), right, 6);
		write(v_line, string'("nentries"), right, 14); write(v_line, string'("enb"), right, 4);  
		write(v_line, string'("readaddr"), right, 9);  write(v_line, string'("FM_L1L2XX_L3PHIC_*_dout"), right, 24); 
		write(v_line, string'("nentries"), right, 14); write(v_line, string'("enb"), right, 4);  
		write(v_line, string'("readaddr"), right, 9);  write(v_line, string'("FM_L5L6XX_L3PHIC_*_dout"), right, 24);
		write(v_line, string'("done"), right, 9);  write(v_line, string'("vld"), right, 4); write(v_line, string'("bx_out_MatchCalculator"), right, 23);
		writeline (file_out, v_line); -- Write line
		wait until rising_edge(MatchCalculator_done); -- Wait for first result
		l_BX : for v_bx_cnt in 0 to MAX_EVENTS-1 loop -- 0 to 99
			l_addr : for addr in 0 to MAX_ENTRIES-1 loop -- 0 to 107
-- todo: write all 256 addr to file; pause playback and en_proc (wait for readout done)
				FM_L1L2XX_L3PHIC_dataarray_data_V_enb <= '1';
				FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr <= std_logic_vector(to_unsigned(addr,FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr'length));
				FM_L5L6XX_L3PHIC_dataarray_data_V_enb <= '1';
FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr <= std_logic_vector(to_unsigned(addr+128,FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr'length));
				wait for CLK_PERIOD; -- Main time control
				-- Other writes ---------------------------------------
        write(v_line, NOW, right, 12); -- NOW = current simulation time
        write(v_line, v_bx_cnt, right, 4);
        --write(v_line, string'("0x"), right, 4); hwrite(v_line, std_logic_vector(to_unsigned(addr,10)), right, 3);
        write(v_line, string'("0b"), right, 5); write(v_line, reset, right, 1);
        write(v_line, string'("0x"), right, 7);  hwrite(v_line, FM_L1L2XX_L3PHIC_nentries_V_dout(0), right, 2);
        write(v_line, string'("0x"), right, 3);  hwrite(v_line, FM_L1L2XX_L3PHIC_nentries_V_dout(1), right, 2);
        write(v_line, string'("0b"), right, 3);   write(v_line, FM_L1L2XX_L3PHIC_dataarray_data_V_enb, right, 1);
        write(v_line, string'("0x"), right, 7);  hwrite(v_line, FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr, right, 2);
        write(v_line, string'("0x"), right, 12); hwrite(v_line, FM_L1L2XX_L3PHIC_dataarray_data_V_dout, right, 12);
        write(v_line, string'("0x"), right, 7);  hwrite(v_line, FM_L5L6XX_L3PHIC_nentries_V_dout(0), right, 2);
        write(v_line, string'("0x"), right, 3);  hwrite(v_line, FM_L5L6XX_L3PHIC_nentries_V_dout(1), right, 2);
        write(v_line, string'("0b"), right, 3);   write(v_line, FM_L5L6XX_L3PHIC_dataarray_data_V_enb, right, 1);
        write(v_line, string'("0x"), right, 7);  hwrite(v_line, FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr, right, 2);
        write(v_line, string'("0x"), right, 12); hwrite(v_line, FM_L5L6XX_L3PHIC_dataarray_data_V_dout, right, 12);
        write(v_line, string'("0b"), right, 8);   write(v_line, MatchCalculator_done, right, 1);
        write(v_line, string'("0b"), right, 3);   write(v_line, bx_out_MatchCalculator_vld, right, 1);
        write(v_line, string'("0x"), right, 22); hwrite(v_line, bx_out_MatchCalculator, right, 1);
        writeline (file_out, v_line); -- Write line

        
			end loop l_addr;
		end loop l_BX;



		----l_rd_row : for i in 0 to 1 loop -- Debug
		--l_rd_row : loop
		--	ILine_length := ILine'length;                                              -- Needed for access after read()
		--	assert ILine_length < s'length report "s'length too small" severity error; -- Make sure s is big enough
		--	-- Write file ------------------------------------------------------------------
		--	write(OLine, string'("0x")); hwrite(OLine, std_logic_vector(to_unsigned(i_wr_row,line_cnt'length))); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoRst); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoStart); write(OLine, string'("      "));
		--	write(OLine, string'("0b")); write(OLine, algoDone); write(OLine, string'("      "));
		--	write(OLine, string'("0b")); write(OLine, algoIdle); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoReady); write(OLine, string'("  "));
		--	l_wr_col : for i_wr_col_loop in 0 to N_OUTPUT_STREAMS-1 loop
		--		-- Compose sideband: Rsv & [FFO_Lock Link_Lock CHKSM_Err FFO SOF] & tLast & tVaild
		--		v_axiStreamOut_SB := '0' & axiStreamOut(i_wr_col_loop).tUser(4 downto 0) & axiStreamOut(i_wr_col_loop).tLast & axiStreamOut(i_wr_col_loop).tValid;
		--		write(OLine, string'("0x")); hwrite(OLine, v_axiStreamOut_SB); write(OLine, string'(" "));
		--		write(OLine, string'("0x")); hwrite(OLine, axiStreamOut(i_wr_col_loop).tData(63 downto 0)); write(OLine, string'("  "));
		--	end loop l_wr_col;
		--	writeline (OutF, OLine); -- write all output variables to line
		--	i_wr_row := i_wr_row+1;
		--	i_rd_row := i_rd_row+1;
		--end loop l_rd_row;
		---- Additional lines for the output file -----------------------------------------
		--l_wr_add_row : for i_wr_add_row in 1 to N_ADD_WR_LINES loop
		--	wait for CLK_PERIOD;
		--	write(OLine, string'("0x")); hwrite(OLine, std_logic_vector(to_unsigned(i_wr_row,line_cnt'length))); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoRst); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoStart); write(OLine, string'("      "));
		--	write(OLine, string'("0b")); write(OLine, algoDone); write(OLine, string'("      "));
		--	write(OLine, string'("0b")); write(OLine, algoIdle); write(OLine, string'("       "));
		--	write(OLine, string'("0b")); write(OLine, algoReady); write(OLine, string'("  "));
		--	l_wr_col_add : for i_wr_col_loop in 0 to N_OUTPUT_STREAMS-1 loop
		--		-- Compose sideband: Rsv & [FFO_Lock Link_Lock CHKSM_Err FFO SOF] & tLast & tVaild
		--		v_axiStreamOut_SB := '0' & axiStreamOut(i_wr_col_loop).tUser(4 downto 0) & axiStreamOut(i_wr_col_loop).tLast & axiStreamOut(i_wr_col_loop).tValid;
		--		write(OLine, string'("0x")); hwrite(OLine, v_axiStreamOut_SB); write(OLine, string'(" "));
		--		write(OLine, string'("0x")); hwrite(OLine, axiStreamOut(i_wr_col_loop).tData(63 downto 0)); write(OLine, string'("  "));
		--	end loop l_wr_col_add;
		--	writeline (OutF, OLine); -- write all output variables to line
		--	i_wr_row := i_wr_row+1;
		--end loop l_wr_add_row;
		---- Report stats -----------------------------------------------------------------
		--assert false report "Read " & integer'image(i_rd_row) & " rows (incl. header and comments) for " & integer'image(i_rd_col) & " links " severity note;
		--assert false report "Wrote " & integer'image(i_wr_row) & " rows (incl. header) for " & integer'image(N_OUTPUT_STREAMS-1) & " links " severity note;
		--wait for CLK_PERIOD;
		--file_close(InF);
		--file_close(OutF);
		--assert false report "Simulation finished!" severity FAILURE;
	end process write_result;



	-- ########################### Assertion ###########################

	-- ########################### Instantiation ###########################
	-- Instantiate the Unit Under Test (UUT)
	uut : entity work.top_tf
		port map(
	    clk     => clk,
	    reset   => reset,
    	en_proc => en_proc,
	    bx_in_ProjectionRouter => bx_in_ProjectionRouter,
	    -- For TrackletProjections memories
	    TPROJ_L3PHIC_dataarray_data_V_wea       => TPROJ_L3PHIC_dataarray_data_V_wea,
	    TPROJ_L3PHIC_dataarray_data_V_writeaddr => TPROJ_L3PHIC_dataarray_data_V_writeaddr,
	    TPROJ_L3PHIC_dataarray_data_V_din       => TPROJ_L3PHIC_dataarray_data_V_din,
	    TPROJ_L3PHIC_nentries_V_we  => TPROJ_L3PHIC_nentries_V_we,
	    TPROJ_L3PHIC_nentries_V_din => TPROJ_L3PHIC_nentries_V_din,
	    -- For VMStubME memories
	    VMSME_L3PHIC17to24n1_dataarray_data_V_wea       => VMSME_L3PHIC17to24n1_dataarray_data_V_wea,
	    VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr => VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr,
	    VMSME_L3PHIC17to24n1_dataarray_data_V_din       => VMSME_L3PHIC17to24n1_dataarray_data_V_din,
	    VMSME_L3PHIC17to24n1_nentries_V_we  => VMSME_L3PHIC17to24n1_nentries_V_we,
	    VMSME_L3PHIC17to24n1_nentries_V_din => VMSME_L3PHIC17to24n1_nentries_V_din,
	    -- For AllStubs memories
	    AS_L3PHICn4_dataarray_data_V_wea       => AS_L3PHICn4_dataarray_data_V_wea,
	    AS_L3PHICn4_dataarray_data_V_writeaddr => AS_L3PHICn4_dataarray_data_V_writeaddr,
	    AS_L3PHICn4_dataarray_data_V_din       => AS_L3PHICn4_dataarray_data_V_din,
	    AS_L3PHICn4_nentries_V_we  => AS_L3PHICn4_nentries_V_we,
	    AS_L3PHICn4_nentries_V_din => AS_L3PHICn4_nentries_V_din,
	    -- FullMatches output
	    FM_L1L2XX_L3PHIC_dataarray_data_V_enb      => FM_L1L2XX_L3PHIC_dataarray_data_V_enb, 
	    FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr => FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr,
	    FM_L1L2XX_L3PHIC_dataarray_data_V_dout     => FM_L1L2XX_L3PHIC_dataarray_data_V_dout,
	    FM_L1L2XX_L3PHIC_nentries_V_dout 					 => FM_L1L2XX_L3PHIC_nentries_V_dout,
	    FM_L5L6XX_L3PHIC_dataarray_data_V_enb      => FM_L5L6XX_L3PHIC_dataarray_data_V_enb,
	    FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr => FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr,
	    FM_L5L6XX_L3PHIC_dataarray_data_V_dout     => FM_L5L6XX_L3PHIC_dataarray_data_V_dout,
	    FM_L5L6XX_L3PHIC_nentries_V_dout 					 => FM_L5L6XX_L3PHIC_nentries_V_dout,
	    -- MatchCalculator outputs
	    bx_out_MatchCalculator     => bx_out_MatchCalculator,
	    bx_out_MatchCalculator_vld => bx_out_MatchCalculator_vld,
	    MatchCalculator_done       => MatchCalculator_done );

	-- ########################### Port Map ##########################

	-- ########################### Processes ###########################
	--! @brief Clock process ---------------------------------------
	CLK_process : process
	begin
		clk <= '0';
		wait for CLK_PERIOD/2;
		clk <= '1';
		wait for CLK_PERIOD/2;
	end process CLK_process;



--	--! @brief TextIO process ---------------------------------------
--	text_proc : process
--		-- Files
--		file InF  : text open READ_MODE is INPUT_FILE;             -- text - a file of character strings
--		file OutF : text open WRITE_MODE is OUTPUT_FILE;           -- text - a file of character strings
--		-- TextIO
--		variable ILine        : line;                              -- line - one string from a text file
--		variable ILine_length : integer;                           -- Length of ILine
--		variable OLine        : line;                              -- line - one string from a text 
--		variable s            : string(1 to 2000);                 -- String for parsing, >= max characters per line
--		variable mode         : integer;                           -- Mode: 0-Sideband OFF, 1-Sideband ON
--		variable LinkSeq_arr  : t_int_array(0 to N_INPUT_STREAMS-1); -- Array of link sequence delay
--		variable line_cnt     : std_logic_vector(15 downto 0);     -- Line counter
--		variable c            : character;                         -- Character
--		variable i_rd_row     : integer;                           -- Read row index
--		variable i_rd_col     : integer;                           -- Read column index
--		variable i_wr_row     : integer;                           -- Write row index
--		variable i_wr_col     : integer;                           -- Write column index
--		-- AXI-Stream In/Out Ports
--		variable v_axiStreamIn        : AxiStreamMasterArray(0 to N_INPUT_STREAMS-1) := (others => AXI_STREAM_MASTER_INIT_C);        -- Streams read from file
--		variable v_axiStreamIn_arr    : t_arr_axiStream(0 to MAX_LIMKSEQ_DELAY) := (others => (others => AXI_STREAM_MASTER_INIT_C)); -- Delayed array of streams
--		variable v_axiStreamIn_SB     : std_logic_vector(7 downto 0); -- Sideband vector
--		variable v_axiStreamOut_SB    : std_logic_vector(7 downto 0); -- Sideband vector
--	begin
--		wait for (SIG_RST_HOLD+SIG_START_D)*CLK_PERIOD; -- Wait for start-up
--		-- Read file header --------------------------------------------------------------
--		readline (InF, ILine);                                                       -- Read 1. line from input file
--		i_rd_row := 1;                                                               -- Init row index
--		i_wr_row := 0;                                                               -- Init row index
--		l_header : while ILine.all(1)='#' loop                                       -- Read the header to determine the mode and link sequence
--			ILine_length := ILine'length;                                              -- Needed for access after read()
--			assert ILine_length < s'length report "s'length too small" severity error; -- Make sure s is big enough
--			read(ILine, s(1 to ILine'length));                                         -- Read line as string
--			if s(1 to ILine_length)="#Sideband ON" then                                -- Mode1: Sideband ON
--				mode := 1;
--				if DEBUG=true then assert false report "Mode: " & integer'image(mode) severity note; end if;
--			elsif s(1 to ILine_length)="#Sideband OFF" then -- Mode0: Sideband OFF
--				mode := 0;
--				if DEBUG=true then assert false report "Mode: " & integer'image(mode) severity note; end if;
--			end if;
--			if s(1 to LIMKSEQ_OFFSET)="#LinkSeq" then -- Read in LinkSeq
--				if DEBUG=true then assert false report "" & s(1 to ILine_length) severity note; end if;
--				write(ILine, s(1 to ILine_length)); -- Write to tmp line buffer, which is easier to read than the string
--				read(ILine, s(1 to LIMKSEQ_OFFSET)); -- Dummy read header
--				l_LinkSeq : for i_LinkNum in 0 to N_INPUT_STREAMS-1 loop -- Get delays for links
--					read(ILine, LinkSeq_arr(i_LinkNum)); -- Read delay
--					if DEBUG=true then assert false report "LinkNum = " & integer'image(i_LinkNum) & " with LinkSeq = " & integer'image(LinkSeq_arr(i_LinkNum)) severity note; end if;
--					-- Make sure the delay is big enough
--					assert LinkSeq_arr(i_LinkNum) < MAX_LIMKSEQ_DELAY report "MAX_LIMKSEQ_DELAY is smaller than read link delay, which is " & integer'image(LinkSeq_arr(i_LinkNum)) severity error;
--				end loop l_LinkSeq;
--			else
--				LinkSeq_arr := (others => 0); -- No link delay
--			end if;
--			readline (InF, ILine); -- Read individual lines from input file
--			i_rd_row := i_rd_row+1;
--		end loop l_header;
--		-- Write file header --------------------------------------------------------------
--		write(OLine, string'("#Counter")); write(OLine, string'(" "));
--		write(OLine, string'("algoRst")); write(OLine, string'(" "));
--		write(OLine, string'("algoStart")); write(OLine, string'(" "));
--		write(OLine, string'("algoDone")); write(OLine, string'(" "));
--		write(OLine, string'("algoIdle")); write(OLine, string'(" "));
--		write(OLine, string'("algoReady")); write(OLine, string'("                  "));
--		l_wr_header : for i_wr_col in 0 to N_OUTPUT_STREAMS-1 loop -- Write link labels
--			if i_wr_col < 10 then
--				write(OLine, string'("Link_0")); write(OLine, i_wr_col); write(OLine, string'("                  "));
--			else
--				write(OLine, string'("Link_")); write(OLine, i_wr_col); write(OLine, string'("                  "));
--			end if;
--		end loop l_wr_header;
--		writeline (OutF, OLine); -- Write line
--		-- All other reads, assigments, and writes ---------------------------------------
--		--l_rd_row : for i in 0 to 1 loop -- Debug
--		l_rd_row : loop
--			ILine_length := ILine'length;                                              -- Needed for access after read()
--			assert ILine_length < s'length report "s'length too small" severity error; -- Make sure s is big enough
--			s := (others => ' ');                                                      -- Make sure that the previous line is overwritten
--			if ILine_length > 0 then                                                   -- Check that the Iline is not empty
--				if ILine.all(1)='#' then                                                 -- Check if the line starts with a #
--					read(ILine, s(1 to ILine'length));                                     -- Read line as string
--				else
--					read(ILine, c); -- Read dummy char
--					if DEBUG=true then assert false report "c0: " & c severity note; end if;
--					read(ILine, c); -- Read dummy char
--					if DEBUG=true then assert false report "c1: " & c severity note; end if;
--					hread(ILine, line_cnt); -- Read value as hex slv
--					if DEBUG=true then assert false report "line_cnt in decimal = " & integer'image(to_integer(unsigned(line_cnt))) severity note; end if;
--					i_rd_col := 0;                        -- Init column index
--					l_rd_col : while ILine'length>0 loop  -- Loop over the columns 
--						read(ILine, c);                     -- Read dummy chars ...
--						if c='x' then                       -- ... until the next x
--							if (mode=1) then                  --Sideband ON
--								hread(ILine, v_axiStreamIn_SB); -- Read value as hex slv
--								read(ILine, c);                 -- Read dummy char
--								while (not (c='x')) loop        -- Read dummy chars until the next x
--									read(ILine, c);
--								end loop;
--							end if;
--							hread(ILine, v_axiStreamIn(i_rd_col).tData(63 downto 0)); -- Read value as hex slv
--							v_axiStreamIn_arr(LinkSeq_arr(i_rd_col))(i_rd_col) := v_axiStreamIn(i_rd_col); -- Assign according to delay
--							if (mode=0) then                  -- Sideband OFF
--								v_axiStreamIn_arr(LinkSeq_arr(i_rd_col))(i_rd_col).tValid := '1';
--							-- Add more sideband information if needed
--							elsif (mode=1) then               --Sideband ON
--								v_axiStreamIn_arr(LinkSeq_arr(i_rd_col))(i_rd_col).tValid            := v_axiStreamIn_SB(0);
--								v_axiStreamIn_arr(LinkSeq_arr(i_rd_col))(i_rd_col).tLast             := v_axiStreamIn_SB(1);
--								v_axiStreamIn_arr(LinkSeq_arr(i_rd_col))(i_rd_col).tUser(4 downto 0) := v_axiStreamIn_SB(6 downto 2);
--								--Rsv <= v_axiStreamIn_SB(7);
--								if DEBUG=true then if (i_rd_col=0) then assert false report "v_axiStreamIn_SB (of i_rd_col=" & integer'image(i_rd_col) & ") in decimal at accoring delay vaule = " & integer'image(to_integer(unsigned(v_axiStreamIn_SB))) severity note; end if; end if;
--							end if;
--							if DEBUG=true then if (i_rd_col=0) then assert false report "v_axiStreamIn_arr(0))(" & integer'image(i_rd_col) & ").tData(63 downto 0) in decimal = " & integer'image(to_integer(unsigned(v_axiStreamIn_arr(0)(i_rd_col).tData(63 downto 0)))) severity note; end if; end if;
--							i_rd_col := i_rd_col+1;
--						end if;
--					end loop l_rd_col;
--				end if;
--			end if;
--			-- Assign variable to signal each line -----------------------------------------
--			axiStreamIn   <= v_axiStreamIn_arr(0);
--			v_axiStreamIn := (others => AXI_STREAM_MASTER_INIT_C);
--			if s(1) /= '#' then -- Check if this is a comment line
--				v_axiStreamIn_arr(0 to MAX_LIMKSEQ_DELAY-1) := v_axiStreamIn_arr(1 to MAX_LIMKSEQ_DELAY); -- Update array
--				wait for CLK_PERIOD;
--			end if;
--			-- Write file ------------------------------------------------------------------
--			write(OLine, string'("0x")); hwrite(OLine, std_logic_vector(to_unsigned(i_wr_row,line_cnt'length))); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoRst); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoStart); write(OLine, string'("      "));
--			write(OLine, string'("0b")); write(OLine, algoDone); write(OLine, string'("      "));
--			write(OLine, string'("0b")); write(OLine, algoIdle); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoReady); write(OLine, string'("  "));
--			l_wr_col : for i_wr_col_loop in 0 to N_OUTPUT_STREAMS-1 loop
--				-- Compose sideband: Rsv & [FFO_Lock Link_Lock CHKSM_Err FFO SOF] & tLast & tVaild
--				v_axiStreamOut_SB := '0' & axiStreamOut(i_wr_col_loop).tUser(4 downto 0) & axiStreamOut(i_wr_col_loop).tLast & axiStreamOut(i_wr_col_loop).tValid;
--				write(OLine, string'("0x")); hwrite(OLine, v_axiStreamOut_SB); write(OLine, string'(" "));
--				write(OLine, string'("0x")); hwrite(OLine, axiStreamOut(i_wr_col_loop).tData(63 downto 0)); write(OLine, string'("  "));
--			end loop l_wr_col;
--			writeline (OutF, OLine); -- write all output variables to line
--			i_wr_row := i_wr_row+1;
--			-- Check EOF (input) ----------------------------------------------------------
--			if endfile(InF) then
--				assert false report "End of file encountered; exiting." severity NOTE;
--				exit;
--			end if;
--			readline (InF, ILine); -- Read individual lines from input file
--			i_rd_row := i_rd_row+1;
--		end loop l_rd_row;
--		-- Additional lines for the output file -----------------------------------------
--		l_wr_add_row : for i_wr_add_row in 1 to N_ADD_WR_LINES loop
--			wait for CLK_PERIOD;
--			write(OLine, string'("0x")); hwrite(OLine, std_logic_vector(to_unsigned(i_wr_row,line_cnt'length))); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoRst); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoStart); write(OLine, string'("      "));
--			write(OLine, string'("0b")); write(OLine, algoDone); write(OLine, string'("      "));
--			write(OLine, string'("0b")); write(OLine, algoIdle); write(OLine, string'("       "));
--			write(OLine, string'("0b")); write(OLine, algoReady); write(OLine, string'("  "));
--			l_wr_col_add : for i_wr_col_loop in 0 to N_OUTPUT_STREAMS-1 loop
--				-- Compose sideband: Rsv & [FFO_Lock Link_Lock CHKSM_Err FFO SOF] & tLast & tVaild
--				v_axiStreamOut_SB := '0' & axiStreamOut(i_wr_col_loop).tUser(4 downto 0) & axiStreamOut(i_wr_col_loop).tLast & axiStreamOut(i_wr_col_loop).tValid;
--				write(OLine, string'("0x")); hwrite(OLine, v_axiStreamOut_SB); write(OLine, string'(" "));
--				write(OLine, string'("0x")); hwrite(OLine, axiStreamOut(i_wr_col_loop).tData(63 downto 0)); write(OLine, string'("  "));
--			end loop l_wr_col_add;
--			writeline (OutF, OLine); -- write all output variables to line
--			i_wr_row := i_wr_row+1;
--		end loop l_wr_add_row;
--		-- Report stats -----------------------------------------------------------------
--		assert false report "Read " & integer'image(i_rd_row) & " rows (incl. header and comments) for " & integer'image(i_rd_col) & " links " severity note;
--		assert false report "Wrote " & integer'image(i_wr_row) & " rows (incl. header) for " & integer'image(N_OUTPUT_STREAMS-1) & " links " severity note;

--		wait for CLK_PERIOD;
--		file_close(InF);
--		file_close(OutF);
--		assert false report "Simulation finished!" severity FAILURE;
--	end process text_proc;
end behavior;
