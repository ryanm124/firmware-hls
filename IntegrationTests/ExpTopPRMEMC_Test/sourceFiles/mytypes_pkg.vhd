--==========================================================================
-- CU Boulder
-------------------------------------------------------------------------------
--! @file
--! @brief Package for the track finding top and test bench using TextIO. 
--! @author Glein
--! @date 2020-05-28
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


--! @brief Package.
package mytypes_pkg is

	-- ########################### Constants #######################
	constant DEBUG                  : boolean := true; --! Debug off/on
	constant MAX_EVENTS             :integer := 100;   -- Max. number of BX events
	constant MAX_ENTRIES            :integer := 108;   -- Max. number of entries: 108 = BX period with 240 MHz
	constant EMDATA_WIDTH           :integer := 68;    -- Max. bit width of emData
	constant N_MEM_BINS             :integer := 8;     -- Number of memory bins
	constant N_ENTRIES_PER_MEM_BINS :integer := 16;    -- Number of entries per memory bin
	constant PAGE_OFFSET            :integer := 128;   -- Page offset for all memories

	-- ########################### Types ###########################
	-- 2D
	type t_myarray2_1b  is array(1 downto 0) of std_logic;
	type t_myarray2_8b  is array(1 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_1b  is array(7 downto 0) of std_logic;
  type t_myarray8_3b  is array(7 downto 0) of std_logic_vector(2 downto 0);
  type t_myarray8_4b  is array(7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray8_5b  is array(7 downto 0) of std_logic_vector(4 downto 0);
  type t_myarray8_8b  is array(7 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_9b  is array(7 downto 0) of std_logic_vector(8 downto 0);
  type t_myarray8_14b is array(7 downto 0) of std_logic_vector(13 downto 0);
  type t_myarray8_21b is array(7 downto 0) of std_logic_vector(20 downto 0);
  type t_myarray8_60b is array(7 downto 0) of std_logic_vector(59 downto 0);
  -- 3D
  type t_myarray2_8_1b is array(0 to 1, 7 downto 0) of std_logic;
  type t_myarray2_8_8b is array(0 to 1, 7 downto 0) of std_logic_vector(7 downto 0);
  -- 4D
  type t_myarray2_8_8_1b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic;
  type t_myarray2_8_8_4b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray2_8_8_5b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic_vector(4 downto 0);
  -- Others
 	type t_myarray_1d_int is array(natural range <>) of integer; --! 1D array of int
	--type t_myarray_1d_slv is array(natural range <>) of std_logic_vector(integer(ceil(log2(real(MAX_ENTRIES)))) downto 0); --! 1D array of slv
  type t_myarray_2d_slv is array(natural range <>, natural range <>) of std_logic_vector(EMDATA_WIDTH-1 downto 0); --! 2D array of slv

  -- ########################### Procedures #######################
  procedure read_emData (
		file_path     : in    string;  --! File path as string
		n_pages       : in    integer; --! Number of pages (2 for direct connection memories and 8 for others) 
		data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
		n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
	);

end package mytypes_pkg;


package body mytypes_pkg is

  -- ########################### Procedures ################################################################
  --! @brief TextIO procedure to read emData for non-binned memories
  --! Assuming normal memory format with the first column as entries counter per BX
  --! n_pages=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
  procedure read_emData (
		file_path     : in    string;  --! File path as string
		n_pages       : in    integer; --! Number of pages (2 for direct connection memories and 8 for others) 
		data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
--data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to n_pages*PAGE_OFFSET-1); --! Dataarray with read values
-- Maybe call another procedure first???
		n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
	) is
	constant N_X_CHAR        : integer :=2; 											 -- Count of 'x' characters before actual value to read
	file     file_in 	       : text open READ_MODE is file_path; 	 -- Text - a file of character strings
	variable line_in 	       : line;    													 -- Line - one string from a text file
	variable line_tmp	       : line;    													 -- Line - one string from a text file
	variable n_bx            : integer; 													 -- BX number
  variable rtn             : integer; 													 -- Return value
	variable i_bx_row        : integer;                            -- Read row index
	variable i_rd_col        : integer;                            -- Read column index
	variable cnt_x_char      : integer; 													 -- Count of 'x' characters
	variable char            : character;                          -- Character
	variable mem_bin         : integer; 													 -- Bin number of memory
	variable n_entry_mem_bin : integer; 													 -- Entry number of memory bin
	variable addr_mult       : integer; 													 -- Address multiplier
	begin
		assert (n_pages=2 or n_pages=8) report "Not supported n_pages=" & integer'image(n_pages) severity error; -- Only supported values
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
				l_rd_col : while line_in'length>0 loop -- Loop over the columns 
					read(line_in, char);                 -- Read chars ...
					if (char='x') then                   -- ... until the next x
						if (cnt_x_char >= N_X_CHAR-1) then -- Number of 'x' chars reached
							addr_mult := n_bx mod n_pages;
							hread(line_in, data_arr(n_bx,i_bx_row+addr_mult*PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
						end if;
						cnt_x_char := cnt_x_char +1;
					end if; 
				i_rd_col := i_rd_col +1;
				end loop l_rd_col;
				n_entries_arr(n_bx) := n_entries_arr(n_bx) +1;
				i_bx_row := i_bx_row +1;
	    end if;
		end loop l_rd_row;
		file_close(file_in);
	end read_emData;

	--! @brief TextIO procedure to read emData for binned memories
	--! Assuming binned memory format with the first column as bin address (0...7, address_offset=16) ...
	--! ...and the second column as bin entry address (0...15) 
  --! n_pages=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
	--BX = 000 Event : 1			// page 0/0   (emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC17n1_04.dat)
	--1 0 0111111|011|101 0x0FDD // addr 16
	--2 0 1000001|011|001 0x1059 // addr 32
	--3 0 0101101|100|010 0x0B62 // addr 48
	--3 1 0101110|110|010 0x0BB2 // addr 49
	--...
	--BX = 001 Event : 2			// page 1/1
	--0 0 1001011|000|011 0x12C3 // addr 128
	--...
	--BX = 010 Event : 3			// page 0/2
	--1 0 0110000|010|001 0x0C11 // addr 128*2+16
	--...
	--BX = 111 Event : 8			// page 1/7
	--3 0 0101000|011|000 0x0A18 // addr 128*7+48
	--3 1 0101001|110|100 0x0A74 // addr 128*7+49
	--...
	--BX = 000 Event : 9			// page 0/0
	--1 0 0101101|001|001 0x0B49 // addr 16
	--1 1 0101110|101|001 0x0BA9 // addr 17
	--...
--  procedure read_emData_binned (
--		file_path     : in    string;  --! File path as string
--		n_pages       : in    integer; --! Number of pages (2 for direct connection memories and 8 for others) 
--		data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to n_pages*PAGE_OFFSET-1); --! Dataarray with read values
--		n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1) --! Number of entries per event
--	) is
--	file     file_in 	       : text open READ_MODE is file_path; 	 -- Text - a file of character strings
--	variable line_in 	       : line;    													 -- Line - one string from a text file
--	variable line_tmp	       : line;    													 -- Line - one string from a text file
--	variable n_bx            : integer; 													 -- BX number
--  variable rtn             : integer; 													 -- Return value
--  --variable addr            : t_myarray_1d_slv(0 to MAX_ENTRIES-1); -- Read address
--	variable i_bx_row        : integer;                            -- Read row index
--	variable i_rd_col        : integer;                            -- Read column index
--	variable cnt_x_char      : integer; 													 -- Count of 'x' characters
--	variable char            : character;                          -- Character
--	variable mem_bin         : integer; 													 -- Bin number of memory
--	variable n_entry_mem_bin : integer; 													 -- Entry number of memory bin
--	begin
--		assert (n_pages=2 or n_pages=8) report "Not supported n_pages=" & integer'image(n_pages) severity error; -- Only supported values
--		data_arr      := (others => (others => (others => '0'))); -- Init
--		n_entries_arr := (others => 0);                           -- Init
--		n_bx          := -1; 																		  -- Init
--		l_rd_row : while not endfile(file_in) loop -- Read until EoF
--		--l_rd_row : for i in 0 to 5 loop -- Debug
--			readline (file_in, line_in);
--	    if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
--	    	i_bx_row := 0;       -- Init
--	      n_bx     := n_bx +1;
--				--if DEBUG=true then writeline(output, line_in); end if;
--	    else
--	    	i_rd_col := 0;   -- Init
--	    	cnt_x_char := 0; -- Init
--				l_rd_col : while line_in'length>0 loop  -- Loop over the columns 
--					read(line_in, char);                  -- Read chars ...
----					if (n_x_char=1) then -- Binned memory ------------>
------todo: nentries for bin not for pages
----						if (i_rd_col=0) then
----							mem_bin := character'pos(char)-48; -- Char to int
----						end if;
----						if (i_rd_col=2) then
----							n_entry_mem_bin := character'pos(char)-48; -- Char to int
----							--if DEBUG=true then write(line_tmp, string'("mem_bin: ")); write(line_tmp, mem_bin); write(line_tmp, string'(";   n_entry_mem_bin: ")); write(line_tmp, n_entry_mem_bin); writeline(output, line_tmp); end if;
----						end if;
----						if (i_rd_col=3 and char/=' ') then -- Second digit
----							n_entry_mem_bin := n_entry_mem_bin*10 + character'pos(char)-48; -- Char to int
----							--if DEBUG=true then write(line_tmp, string'("mem_bin: ")); write(line_tmp, mem_bin); write(line_tmp, string'(";   n_entry_mem_bin: ")); write(line_tmp, n_entry_mem_bin); writeline(output, line_tmp); end if;
----						end if; 
----						if (char='x') then                   -- ... until the next x
----							cnt_x_char := cnt_x_char +1;
----							if (cnt_x_char >= n_x_char) then -- Number of 'x' chars reached
----								if (n_bx mod 2 = 0) then -- Even
----									hread(line_in, data_arr(n_bx,mem_bin*N_ENTRIES_PER_MEM_BINS+n_entry_mem_bin)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
----								else -- Odd
----									hread(line_in, data_arr(n_bx,mem_bin*N_ENTRIES_PER_MEM_BINS+n_entry_mem_bin+PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
----								end if;
----							end if;
----						end if; 
----							-- Binned memory ------------<
----					elsif (char='x') then                   -- ... until the next x
----						cnt_x_char := cnt_x_char +1;
----						if (cnt_x_char >= n_x_char) then    -- Number of 'x' chars reached
----							hread(line_in, data_arr(n_bx,i_bx_row)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
----						end if;
----					end if; 
--				i_rd_col := i_rd_col +1;
--				end loop l_rd_col;
--				n_entries_arr(n_bx) := n_entries_arr(n_bx) +1;
--				i_bx_row := i_bx_row +1;
--	    end if;
--		end loop l_rd_row;
--		file_close(file_in);
--	end read_emData_binned;

end package body mytypes_pkg;
