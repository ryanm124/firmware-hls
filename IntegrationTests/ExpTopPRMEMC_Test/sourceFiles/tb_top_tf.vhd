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
	type t_str_array_32 is array(natural range <>) of string(1 to 32); --! String array
	type t_str_array_86 is array(natural range <>) of string(1 to 86); --! String array

	-- ########################### Constant Definitions ###########################
	-- ############ Please change the constants in this section ###################
	constant N_ME_IN_CHAIN : integer := 8; --! Number of match engines in chain 
	constant FILE_IN_TPROJ : t_str_array_86(0 to N_ME_IN_CHAIN-1) := ("../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2H_L3PHIC_04.dat", --! Input files
                                																		"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6C_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2I_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6B_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L5L6D_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2J_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2G_L3PHIC_04.dat",
											                                							"../../../../../../../emData/PR/PR_L3PHIC/TrackletProjections_TPROJ_L1L2F_L3PHIC_04.dat" );
	constant FILE_IN_VMSME : t_str_array_32(0 to N_ME_IN_CHAIN-1) := ("VMStubs_VMSME_L3PHIC17n1_04D.dat", --! Input files
                                																		"VMStubs_VMSME_L3PHIC18n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC19n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC20n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC21n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC22n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC23n1_04D.dat",
											                                							"VMStubs_VMSME_L3PHIC24n1_04D.dat" );
	constant FILE_IN_AS        : string := "../../../../../../../emData/MC/MC_L3PHIC/AllStubs_AS_L3PHICn6_04.dat"; --! Input file
	constant FILE_OUT					 : string := "../../../../../output.txt"; --! Output file
	constant N_ADD_WR_LINES 	 : integer := 250;                  --! Number of additional lines for the output file 
	                                                              --! incl. number of header and comment lines of the input file
	constant CLK_PERIOD        : time    := 4 ns;             		--! 250 MHz
	constant DEBUG             : boolean := true;                 --! Debug off/on

	-- ########################### Signals ###########################
	-- ### UUT signals ###
  signal clk     : std_logic := '0';
  signal reset   : std_logic := '1';
  signal en_proc : std_logic := '0';
  signal bx_in_ProjectionRouter : std_logic_vector(2 downto 0);
  -- For TrackletProjections memories
  signal TPROJ_L3PHIC_dataarray_data_V_wea       : t_myarray8_1b;
  signal TPROJ_L3PHIC_dataarray_data_V_writeaddr : t_myarray8_8b;
  signal TPROJ_L3PHIC_dataarray_data_V_din       : t_myarray8_60b;
  signal TPROJ_L3PHIC_nentries_V_we  : t_myarray2_8_1b;
  signal TPROJ_L3PHIC_nentries_V_din : t_myarray2_8_8b;
  -- For VMStubME memories
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_wea       : t_myarray8_1b;
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_writeaddr : t_myarray8_9b;
  signal VMSME_L3PHIC17to24n1_dataarray_data_V_din       : t_myarray8_14b;
  signal VMSME_L3PHIC17to24n1_nentries_V_we  : t_myarray2_8_8_1b;
  signal VMSME_L3PHIC17to24n1_nentries_V_din : t_myarray2_8_8_4b;
  -- For AllStubs memories
  signal AS_L3PHICn4_dataarray_data_V_wea       : std_logic;
  signal AS_L3PHICn4_dataarray_data_V_writeaddr : std_logic_vector(9 downto 0);
  signal AS_L3PHICn4_dataarray_data_V_din       : std_logic_vector(35 downto 0);
  signal AS_L3PHICn4_nentries_V_we  : t_myarray2_1b;
  signal AS_L3PHICn4_nentries_V_din : t_myarray2_8b;
  -- FullMatches output
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_enb      : std_logic; 
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_dout     : std_logic_vector(44 downto 0);
  signal FM_L1L2XX_L3PHIC_nentries_V_dout : t_myarray2_8b;
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_dout     : std_logic_vector(44 downto 0);
  signal FM_L5L6XX_L3PHIC_nentries_V_dout : t_myarray2_8b;
  -- MatchCalculator outputs
  signal bx_out_MatchCalculator     : std_logic_vector(2 downto 0);
  signal bx_out_MatchCalculator_vld : std_logic;
  signal MatchCalculator_done       : std_logic;
  -- ### Other signals ###



  -- Procedure constants and types
  constant EVENTS         :integer := 100; 	 -- BX events
	constant N_ENTRIES      :integer := 108; 	 -- Number of entries: 108 = BX period with 240 MHz
	constant EMDATA_WIDTH   :integer := 68;  	 -- Max. bit width of emData
	constant MAX_STR_LENGTH :integer := 2000;  -- Max. characters per line
	type t_myarray_1d_int is array(natural range <>) of integer; --! 1D array of int
	type t_myarray_1d_slv is array(natural range <>) of std_logic_vector(integer(ceil(log2(real(N_ENTRIES)))) downto 0); --! 1D array of slv
  type t_myarray_2d_slv is array(natural range <>, natural range <>) of std_logic_vector(EMDATA_WIDTH-1 downto 0); --! 2D array of slv
  -- Procedure
  --! @brief TextIO procedure to read emData
  procedure read_emData (
		file_path      : in  string;  --! File path as string
		n_x_char       : in  integer; --! Number of 'x' characters before the final value 
		data_arr       : out t_myarray_2d_slv(0 to EVENTS-1,0 to N_ENTRIES-1); --! Dataarray with read values
		n_entries_arr  : inout t_myarray_1d_int(0 to EVENTS-1) --! Number of entries per event; used only as out
	) is
	file     file_in 	  : text open READ_MODE is file_path; 	 	-- Text - a file of character strings
	variable line_in 	  : line;    														 	-- Line - one string from a text file
	variable n_bx       : integer; 														 	-- BX number
  variable rtn        : integer; 														 	-- Return value
  variable addr       : t_myarray_1d_slv(0 to N_ENTRIES-1); -- Read address
	variable i_bx_row   : integer;                              -- Read row index
	variable i_rd_col   : integer;                           		-- Read column index
	variable cnt_x_char : integer; 															-- Count of 'x' characters
	variable char       : character;                         		-- Character
	begin
		data_arr      := (others => (others => (others => '0'))); -- Init
		n_entries_arr := (others => 0);                           -- Init
		n_bx          := -1; 																		  -- Init
		l_rd_row : while not endfile(file_in) loop -- Read until EoF
		--l_rd_row : for i in 0 to 5 loop -- Debug
			readline (file_in, line_in);
	    if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
	    	i_bx_row := 0;       -- Init
	      n_bx     := n_bx +1;
	      --if DEBUG=true then writeline(output, line_in); end if;
	    else
	    	i_rd_col := 0;   -- Init
	    	cnt_x_char := 0; -- Init
				l_rd_col : while line_in'length>0 loop  -- Loop over the columns 
					read(line_in, char);                  -- Read dummy chars ...
					if char='x' then                      -- ... until the next x
						cnt_x_char := cnt_x_char +1;
						if (cnt_x_char >= n_x_char) then -- Number of 'x' chars reached
							hread(line_in, data_arr(n_bx,i_bx_row)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
						end if;
					end if; 
				i_rd_col := i_rd_col +1;
				end loop l_rd_col;
				n_entries_arr(n_bx) := n_entries_arr(n_bx) +1;
				i_bx_row := i_bx_row +1;
	    end if;
		end loop l_rd_row;

--// todo: description
--// todo: n_head_col page

		file_close(file_in);
	end read_emData;


begin

	process
		type t_myarray_1d_1d_int is array(natural range <>) of t_myarray_1d_int(0 to EVENTS-1); --! 1x1D array of int
  	type t_myarray_1d_2d_slv is array(natural range <>) of t_myarray_2d_slv(0 to EVENTS-1,0 to N_ENTRIES-1); --! 1x2D array of slv
		variable TPROJ_n_entries_arr : t_myarray_1d_1d_int(0 to N_ME_IN_CHAIN-1);
		variable TPROJ_L3PHICn4_data_arr : t_myarray_1d_2d_slv(0 to N_ME_IN_CHAIN-1);
		variable AS_n_entries_arr : t_myarray_1d_int(0 to EVENTS-1);
		variable AS_L3PHICn4_data_arr : t_myarray_2d_slv(0 to EVENTS-1,0 to N_ENTRIES-1);
		variable line_in : line; -- Line for debug
	begin
		read_emData (FILE_IN_AS, 2, AS_L3PHICn4_data_arr, AS_n_entries_arr);
    if DEBUG=true then write(line_in, string'("AS_L3PHICn4_data_arr(0,0): ")); hwrite(line_in, AS_L3PHICn4_data_arr(0,0)); writeline(output, line_in); end if;
    if DEBUG=true then write(line_in, string'("AS_L3PHICn4_data_arr(0,1): ")); hwrite(line_in, AS_L3PHICn4_data_arr(0,1)); writeline(output, line_in); end if;
    if DEBUG=true then write(line_in, string'("AS_n_entries_arr(0): ")); write(line_in, AS_n_entries_arr(0)); writeline(output, line_in); end if;
		if DEBUG=true then write(line_in, string'("AS_L3PHICn4_data_arr(99,0): ")); hwrite(line_in, AS_L3PHICn4_data_arr(99,0)); writeline(output, line_in); end if;
		if DEBUG=true then write(line_in, string'("AS_n_entries_arr(99): ")); write(line_in, AS_n_entries_arr(99)); writeline(output, line_in); end if;
		l_TPROJ_read : for i in 0 to N_ME_IN_CHAIN-1 loop
			read_emData (FILE_IN_TPROJ(i), 2, TPROJ_L3PHICn4_data_arr(i), TPROJ_n_entries_arr(i));
			if DEBUG=true then write(line_in, string'("TPROJ_i: ")); write(line_in, i); write(line_in, string'(";   TPROJ_L3PHICn4_data_arr(i)(0,0): ")); hwrite(line_in, TPROJ_L3PHICn4_data_arr(i)(0,0)); writeline(output, line_in); end if;
    	if DEBUG=true then write(line_in, string'("TPROJ_i: ")); write(line_in, i); write(line_in, string'(";   TPROJ_n_entries_arr(i)(0): ")); write(line_in, TPROJ_n_entries_arr(i)(0)); writeline(output, line_in); end if;
		end loop l_TPROJ_read;
		

		wait for CLK_PERIOD;
		assert false report "Simulation finished!" severity FAILURE;
	end process;



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
