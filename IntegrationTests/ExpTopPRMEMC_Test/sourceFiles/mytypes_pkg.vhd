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
  constant MAX_EVENTS             : integer := 100;   -- Max. number of BX events
  constant MAX_ENTRIES            : integer := 108;   -- Max. number of entries: 108 = BX period with 240 MHz
  constant EMDATA_WIDTH           : integer := 68;    -- Max. bit width of emData
  constant N_MEM_BINS             : integer := 8;     -- Number of memory bins
  constant N_ENTRIES_PER_MEM_BINS : integer := 16;    -- Number of entries per memory bin
  constant PAGE_OFFSET            : integer := 128;   -- Page offset for all memories

  -- ########################### Types ###########################
  -- 2D
  type t_myarray2_1b  is array(1 downto 0) of std_logic;
  type t_myarray2_8b  is array(1 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_1b  is array(7 downto 0) of std_logic;
  type t_myarray8_2b  is array(7 downto 0) of std_logic_vector(1 downto 0);
  type t_myarray8_3b  is array(7 downto 0) of std_logic_vector(2 downto 0);
  type t_myarray8_4b  is array(7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray8_5b  is array(7 downto 0) of std_logic_vector(4 downto 0);
  type t_myarray8_8b  is array(7 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_9b  is array(7 downto 0) of std_logic_vector(8 downto 0);
  type t_myarray8_10b is array(7 downto 0) of std_logic_vector(9 downto 0);
  type t_myarray8_14b is array(7 downto 0) of std_logic_vector(13 downto 0);
  type t_myarray8_21b is array(7 downto 0) of std_logic_vector(20 downto 0);
  type t_myarray8_60b is array(7 downto 0) of std_logic_vector(59 downto 0);
  -- 3D
  --type t_myarray2_8_1b is array(0 to 1, 7 downto 0) of std_logic;
  type t_myarray2_8_1b is array(0 to 1) of t_myarray8_1b;
  --type t_myarray2_8_8b is array(0 to 1, 7 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray2_8_8b is array(0 to 1) of t_myarray8_8b;
  type t_myarray8_8_1b is array(0 to 7) of t_myarray8_1b;
  type t_myarray8_8_4b is array(0 to 7) of t_myarray8_4b;
  type t_myarray8_8_5b is array(0 to 7) of t_myarray8_5b;
  -- 4D
  --type t_myarray8_8_8_1b is array(0 to 7, 0 to 7, 7 downto 0) of std_logic;
  type t_myarray8_8_8_1b is array(0 to 7) of t_myarray8_8_1b;
  --type t_myarray8_8_8_4b is array(0 to 7, 0 to 7, 7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray8_8_8_4b is array(0 to 7) of t_myarray8_8_4b;
  --type t_myarray8_8_8_5b is array(0 to 7, 0 to 7, 7 downto 0) of std_logic_vector(4 downto 0);
  type t_myarray8_8_8_5b is array(0 to 7) of t_myarray8_8_5b;
  -- Others
   type t_myarray_1d_int is array(natural range <>) of integer;                  --! 1D array of int
   type t_myarray_2d_int is array(natural range <>,natural range <>) of integer; --! 2D array of int
  --type t_myarray_1d_slv is array(natural range <>) of std_logic_vector(integer(ceil(log2(real(MAX_ENTRIES)))) downto 0); --! 1D array of slv
  type t_myarray_2d_slv is array(natural range <>, natural range <>) of std_logic_vector(EMDATA_WIDTH-1 downto 0); --! 2D array of slv

  -- ########################### Procedures #######################
  procedure char2int (
    char : in  character;            --! Input charater 0...9, a...f, and A...F
    int  : out natural range 0 to 15 --! Output interger 0...15
  );
  procedure read_emData_2p (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 2*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
  );
  procedure read_emData_8p (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
  );
  procedure read_emData_2p_bin (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 2*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_2d_int(0 to MAX_EVENTS-1,0 to N_MEM_BINS-1)     --! Number of entries per event
  );
  procedure read_emData_8p_bin (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_2d_int(0 to MAX_EVENTS-1,0 to N_MEM_BINS-1)     --! Number of entries per event
  );
  procedure write_emData_2p (
    file_path       : in string;           --! File path as string
    mem_read_delay  : in integer;          --! Number of memory read delay
    signal_name     : in string;           --! Signal name that will be printed in output file
    mem_data        : in std_logic_vector; --! Data write values
    mem_enb_d       : in std_logic;        --! DELAYED enable of data
    mem_addr        : in std_logic_vector; --! Memory address
    n_entries_p0    : in std_logic_vector; --! Number of entries page 0
    n_entries_p1    : in std_logic_vector; --! Number of entries page 1
    bx_cnt          : in integer;          --! BX counter
    reset           : in std_logic;        --! HDL reset
    done            : in std_logic;        --! HLS module done
    bx_out_vld      : in std_logic;        --! HLS module BX counter valid
    bx_out          : in std_logic_vector  --! HLS module BX counter
  );

end package mytypes_pkg;


package body mytypes_pkg is

  -- ########################### Procedures ################################################################

  --! @brief Convert character to integer
  procedure char2int (
    char : in  character;            --! Input charater 0...9, a...f, and A...F
    int  : out natural range 0 to 15 --! Output interger 0...15
  ) is
  begin
    if    (char = 'a') or (char = 'A') then
      int := 10;
    elsif (char = 'b') or (char = 'B') then
      int := 11;
    elsif (char = 'c') or (char = 'C') then
      int := 12;
    elsif (char = 'd') or (char = 'D') then
      int := 13;
    elsif (char = 'e') or (char = 'E') then
      int := 14;
    elsif (char = 'f') or (char = 'F') then
      int := 15;
    else
      int := character'pos(char)-48;
    end if;
  end char2int;

  --! @brief TextIO procedure to read emData for non-binned memories all at once
  --! Assuming normal memory format with the first column as entries counter per BX
  --! N_PAGES=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
  procedure read_emData_2p (
    file_path     : in    string;  --! File path as string 
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 2*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
  ) is
  constant N_PAGES         : integer :=2;                        --! Number of pages
  constant N_X_CHAR        : integer :=2;                        --! Count of 'x' characters before actual value to read
  file     file_in         : text open READ_MODE is file_path;   -- Text - a file of character strings
  variable line_in         : line;                               -- Line - one string from a text file
  variable line_tmp        : line;                               -- Line - one string from a text file
  variable bx_cnt          : integer;                            -- BX counter
  variable i_bx_row        : integer;                            -- Read row index
  variable i_rd_col        : integer;                            -- Read column index
  variable cnt_x_char      : integer;                            -- Count of 'x' characters
  variable char            : character;                          -- Character
  variable addr_mult       : integer;                            -- Address multiplier
  begin
    data_arr      := (others => (others => (others => '0'))); -- Init
    n_entries_arr := (others => 0);                           -- Init
    bx_cnt        := -1;                                      -- Init
    l_rd_row : while not endfile(file_in) loop -- Read until EoF
    --l_rd_row : for i in 0 to 5 loop -- Debug
      readline (file_in, line_in);
      if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
        i_bx_row := 0;       -- Init
        bx_cnt   := bx_cnt +1;
        --if DEBUG=true then writeline(output, line_in); end if;
      else
        i_rd_col := 0;   -- Init
        cnt_x_char := 0; -- Init
        l_rd_col : while line_in'length>0 loop -- Loop over the columns 
          read(line_in, char);                 -- Read chars ...
          if (char='x') then                   -- ... until the next x
            if (cnt_x_char >= N_X_CHAR-1) then -- Number of 'x' chars reached
              addr_mult := bx_cnt mod N_PAGES;
              hread(line_in, data_arr(bx_cnt,i_bx_row+addr_mult*PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
            end if;
            cnt_x_char := cnt_x_char +1;
          end if; 
        i_rd_col := i_rd_col +1;
        end loop l_rd_col;
        n_entries_arr(bx_cnt) := n_entries_arr(bx_cnt) +1;
        i_bx_row := i_bx_row +1;
      end if;
    end loop l_rd_row;
    file_close(file_in);
  end read_emData_2p;

  --! @brief TextIO procedure to read emData for non-binned memories all at once
  --! Assuming normal memory format with the first column as entries counter per BX
  --! N_PAGES=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
  procedure read_emData_8p (
    file_path     : in    string;  --! File path as string 
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_1d_int(0 to MAX_EVENTS-1)                       --! Number of entries per event
  ) is
  constant N_PAGES         : integer :=8;                        --! Number of pages
  constant N_X_CHAR        : integer :=2;                        --! Count of 'x' characters before actual value to read
  file     file_in         : text open READ_MODE is file_path;   -- Text - a file of character strings
  variable line_in         : line;                               -- Line - one string from a text file
  variable line_tmp        : line;                               -- Line - one string from a text file
  variable bx_cnt          : integer;                            -- BX counter
  variable i_bx_row        : integer;                            -- Read row index
  variable i_rd_col        : integer;                            -- Read column index
  variable cnt_x_char      : integer;                            -- Count of 'x' characters
  variable char            : character;                          -- Character
  variable addr_mult       : integer;                            -- Address multiplier
  begin
    data_arr      := (others => (others => (others => '0'))); -- Init
    n_entries_arr := (others => 0);                           -- Init
    bx_cnt        := -1;                                      -- Init
    l_rd_row : while not endfile(file_in) loop -- Read until EoF
    --l_rd_row : for i in 0 to 5 loop -- Debug
      readline (file_in, line_in);
      if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
        i_bx_row := 0;       -- Init
        bx_cnt   := bx_cnt +1;
        --if DEBUG=true then writeline(output, line_in); end if;
      else
        i_rd_col := 0;   -- Init
        cnt_x_char := 0; -- Init
        l_rd_col : while line_in'length>0 loop -- Loop over the columns 
          read(line_in, char);                 -- Read chars ...
          if (char='x') then                   -- ... until the next x
            if (cnt_x_char >= N_X_CHAR-1) then -- Number of 'x' chars reached
              addr_mult := bx_cnt mod N_PAGES;
              hread(line_in, data_arr(bx_cnt,i_bx_row+addr_mult*PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
            end if;
            cnt_x_char := cnt_x_char +1;
          end if; 
        i_rd_col := i_rd_col +1;
        end loop l_rd_col;
        n_entries_arr(bx_cnt) := n_entries_arr(bx_cnt) +1;
        i_bx_row := i_bx_row +1;
      end if;
    end loop l_rd_row;
    file_close(file_in);
  end read_emData_8p;

  --! @brief TextIO procedure to read emData for binned memories all at once
  --! Assuming binned memory format with the first column as bin address (0...7, address_offset=16) ...
  --! ...and the second column as bin entry address (0...F) 
  --! N_PAGES=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
  --BX = 000 Event : 1      // page 0/0   (emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC17n1_04.dat)
  --1 0 0111111|011|101 0x0FDD // addr 16
  --2 0 1000001|011|001 0x1059 // addr 32
  --3 0 0101101|100|010 0x0B62 // addr 48
  --3 1 0101110|110|010 0x0BB2 // addr 49
  --...
  --BX = 001 Event : 2      // page 1/1
  --0 0 1001011|000|011 0x12C3 // addr 128
  --...
  --BX = 010 Event : 3      // page 0/2
  --1 0 0110000|010|001 0x0C11 // addr 128*2+16
  --...
  --BX = 111 Event : 8      // page 1/7
  --3 0 0101000|011|000 0x0A18 // addr 128*7+48
  --3 1 0101001|110|100 0x0A74 // addr 128*7+49
  --...
  --BX = 000 Event : 9      // page 0/0
  --1 0 0101101|001|001 0x0B49 // addr 16
  --1 1 0101110|101|001 0x0BA9 // addr 17
  --...
  procedure read_emData_2p_bin (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 2*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_2d_int(0 to MAX_EVENTS-1,0 to N_MEM_BINS-1)     --! Number of entries per event per bin
  ) is
  constant N_PAGES         : integer :=2;                        --! Number of pages
  constant N_X_CHAR        : integer :=1;                        --! Count of 'x' characters before actual value to read
  file     file_in         : text open READ_MODE is file_path;   -- Text - a file of character strings
  variable line_in         : line;                               -- Line - one string from a text file
  variable line_tmp        : line;                               -- Line - one string from a text file
  variable bx_cnt          : integer;                            -- BX counter
  variable i_bx_row        : integer;                            -- Read row index
  variable i_rd_col        : integer;                            -- Read column index
  variable cnt_x_char      : integer;                            -- Count of 'x' characters
  variable char            : character;                          -- Character
  variable mem_bin         : integer;                            -- Bin number of memory
  variable n_entry_mem_bin : integer;                            -- Entry number of memory bin
  variable addr_mult       : integer;                            -- Address multiplier
  begin
    data_arr      := (others => (others => (others => '0'))); -- Init
    n_entries_arr := (others => (others => 0));               -- Init
    bx_cnt        := -1;                                      -- Init
    l_rd_row : while not endfile(file_in) loop -- Read until EoF
    --l_rd_row : for i in 0 to 5 loop -- Debug
      readline (file_in, line_in);
      if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
        i_bx_row := 0;       -- Init
        bx_cnt   := bx_cnt +1;
        --if DEBUG=true then writeline(output, line_in); end if;
      else
        i_rd_col := 0;   -- Init
        cnt_x_char := 0; -- Init
        l_rd_col : while line_in'length>0 loop  -- Loop over the columns 
          read(line_in, char);                  -- Read chars ...
            if (i_rd_col=0) then
              char2int(char, mem_bin);
            end if;
            if (i_rd_col=2) then
              char2int(char, n_entry_mem_bin);
              --if DEBUG=true then write(line_tmp, string'("mem_bin: ")); write(line_tmp, mem_bin); write(line_tmp, string'(";   n_entry_mem_bin: ")); write(line_tmp, n_entry_mem_bin); writeline(output, line_tmp); end if;
            end if;
            if (char='x') then                   -- ... until the next x
              cnt_x_char := cnt_x_char +1;
              if (cnt_x_char >= N_X_CHAR) then -- Number of 'x' chars reached
                addr_mult := bx_cnt mod N_PAGES;
                hread(line_in, data_arr(bx_cnt,mem_bin*N_ENTRIES_PER_MEM_BINS+n_entry_mem_bin+addr_mult*PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
              end if;
              n_entries_arr(bx_cnt,mem_bin) := n_entries_arr(bx_cnt,mem_bin) +1;
            end if; 
        i_rd_col := i_rd_col +1;
        end loop l_rd_col;
        i_bx_row := i_bx_row +1;
      end if;
    end loop l_rd_row;
    file_close(file_in);
  end read_emData_2p_bin;

  --! @brief TextIO procedure to read emData for binned memories all at once
  --! Assuming binned memory format with the first column as bin address (0...7, address_offset=16) ...
  --! ...and the second column as bin entry address (0...F) 
  --! N_PAGES=2/8: BX = 000 (even) Event : 1 is page 0/0 and BX = 001 (odd) Event : 2 is page 1/1 ...
  --!          ... BX = 010 (even) Event : 3 is page 0/2 ... BX = 111 (odd) Event : 8 is page 1/7
  --BX = 000 Event : 1      // page 0/0   (emData/MemPrints/VMStubsME/VMStubs_VMSME_L3PHIC17n1_04.dat)
  --1 0 0111111|011|101 0x0FDD // addr 16
  --2 0 1000001|011|001 0x1059 // addr 32
  --3 0 0101101|100|010 0x0B62 // addr 48
  --3 1 0101110|110|010 0x0BB2 // addr 49
  --...
  --BX = 001 Event : 2      // page 1/1
  --0 0 1001011|000|011 0x12C3 // addr 128
  --...
  --BX = 010 Event : 3      // page 0/2
  --1 0 0110000|010|001 0x0C11 // addr 128*2+16
  --...
  --BX = 111 Event : 8      // page 1/7
  --3 0 0101000|011|000 0x0A18 // addr 128*7+48
  --3 1 0101001|110|100 0x0A74 // addr 128*7+49
  --...
  --BX = 000 Event : 9      // page 0/0
  --1 0 0101101|001|001 0x0B49 // addr 16
  --1 1 0101110|101|001 0x0BA9 // addr 17
  --...
  procedure read_emData_8p_bin (
    file_path     : in    string;  --! File path as string
    data_arr      : out   t_myarray_2d_slv(0 to MAX_EVENTS-1,0 to 8*PAGE_OFFSET-1); --! Dataarray with read values
    n_entries_arr : inout t_myarray_2d_int(0 to MAX_EVENTS-1,0 to N_MEM_BINS-1)     --! Number of entries per event per bin
  ) is
  constant N_PAGES         : integer :=8;                        --! Number of pages
  constant N_X_CHAR        : integer :=1;                        --! Count of 'x' characters before actual value to read
  file     file_in         : text open READ_MODE is file_path;   -- Text - a file of character strings
  variable line_in         : line;                               -- Line - one string from a text file
  variable line_tmp        : line;                               -- Line - one string from a text file
  variable bx_cnt          : integer;                            -- BX counter
  variable i_bx_row        : integer;                            -- Read row index
  variable i_rd_col        : integer;                            -- Read column index
  variable cnt_x_char      : integer;                            -- Count of 'x' characters
  variable char            : character;                          -- Character
  variable mem_bin         : integer;                            -- Bin number of memory
  variable n_entry_mem_bin : integer;                            -- Entry number of memory bin
  variable addr_mult       : integer;                            -- Address multiplier
  begin
    data_arr      := (others => (others => (others => '0'))); -- Init
    n_entries_arr := (others => (others => 0));               -- Init
    bx_cnt        := -1;                                      -- Init
    l_rd_row : while not endfile(file_in) loop -- Read until EoF
    --l_rd_row : for i in 0 to 5 loop -- Debug
      readline (file_in, line_in);
      if (line_in.all(1 to 2) = "BX" or line_in.all = "") then -- Identify a header line or empty line
        i_bx_row := 0;       -- Init
        bx_cnt   := bx_cnt +1;
        --if DEBUG=true then writeline(output, line_in); end if;
      else
        i_rd_col := 0;   -- Init
        cnt_x_char := 0; -- Init
        l_rd_col : while line_in'length>0 loop  -- Loop over the columns 
          read(line_in, char);                  -- Read chars ...
            if (i_rd_col=0) then
              char2int(char, mem_bin);
            end if;
            if (i_rd_col=2) then
              char2int(char, n_entry_mem_bin);           
              --if DEBUG=true then write(line_tmp, string'("mem_bin: ")); write(line_tmp, mem_bin); write(line_tmp, string'(";   n_entry_mem_bin: ")); write(line_tmp, n_entry_mem_bin); writeline(output, line_tmp); end if;  
            end if;
            if (char='x') then                   -- ... until the next x
              cnt_x_char := cnt_x_char +1;
              if (cnt_x_char >= N_X_CHAR) then -- Number of 'x' chars reached
                addr_mult := bx_cnt mod N_PAGES;
                hread(line_in, data_arr(bx_cnt,mem_bin*N_ENTRIES_PER_MEM_BINS+n_entry_mem_bin+addr_mult*PAGE_OFFSET)(line_in'length*4-1 downto 0)); -- Read value as hex slv (line_in'length in hex)
              end if;
              n_entries_arr(bx_cnt,mem_bin) := n_entries_arr(bx_cnt,mem_bin) +1;
            end if; 
        i_rd_col := i_rd_col +1;
        end loop l_rd_col;
        i_bx_row := i_bx_row +1;
      end if;
    end loop l_rd_row;
    file_close(file_in);
  end read_emData_8p_bin;

  --! @brief TextIO procedure to write emData for non-binned memories one line per clock cycle
  procedure write_emData_2p (
    file_path       : in string;           --! File path as string
    mem_read_delay  : in integer;          --! Number of memory read delay
    signal_name     : in string;           --! Signal name that will be printed in output file
    mem_data        : in std_logic_vector; --! Data write values
    mem_enb_d       : in std_logic;        --! DELAYED enable of data
    mem_addr        : in std_logic_vector; --! Memory address
    n_entries_p0    : in std_logic_vector; --! Number of entries page 0
    n_entries_p1    : in std_logic_vector; --! Number of entries page 1
    bx_cnt          : in integer;          --! BX counter
    reset           : in std_logic;        --! HDL reset
    done            : in std_logic;        --! HLS module done
    bx_out_vld      : in std_logic;        --! HLS module BX counter valid
    bx_out          : in std_logic_vector  --! HLS module BX counter
--i_bx_row        : inout integer             --! Write row index (as port to be non-volatile)
  ) is
--signal FM_L1L2XX_L3PHIC_dataarray_data_V_enb      : std_logic                     := '0'; 
--signal FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0)  := (others => '0');
--signal FM_L1L2XX_L3PHIC_dataarray_data_V_dout     : std_logic_vector(44 downto 0);
--signal FM_L1L2XX_L3PHIC_nentries_V_dout : t_myarray2_8b;
  constant N_PAGES         : integer :=2;       --! Number of pages
  file     file_out        : text is file_path; -- Text - a file of character strings
  variable line_out        : line;              -- Line - one string from a text file
--variable line_tmp        : line;              -- Line - one string from a text file
  variable i_wr_col        : integer;           -- Write column index
  variable v_zero          : std_logic_vector(mem_data'length-1 downto 0) := (others => '0');  -- Zero vector
  begin
    if (bx_cnt = 0) and (unsigned(mem_addr)=0) then -- (Over)write file header only once
      file_open(file_out, file_path, WRITE_MODE);
      write(line_out, string'("time"), right, 12); write(line_out, string'("BX#"), right, 4);
      write(line_out, string'("reset"), right, 6);
      write(line_out, string'("n_ent_p0"), right, 9); write(line_out, string'("n_ent_p1"), right, 9); write(line_out, string'("enb"), right, 4);
      write(line_out, string'("mem_addr"), right, 9);  write(line_out, signal_name, right, signal_name'length+1); 
      write(line_out, string'("done"), right, 5);  write(line_out, string'("bx_out_vld"), right, 11); write(line_out, string'("bx_out"), right, 7);
      writeline (file_out, line_out); -- Write line
      file_close(file_out);
    end if;
    -- Append one new line each call (clock cycle)
    if (to_integer(unsigned(mem_addr)) >= mem_read_delay) then -- Take read dealy into account
      file_open(file_out, file_path, APPEND_MODE);
      write(line_out, NOW, right, 12); write(line_out, bx_cnt, right, 4);
      write(line_out, string'("0b"), right, 5);   write(line_out, reset, right, 1);
      write(line_out, string'("0x"), right, 7);  hwrite(line_out, n_entries_p0, right, 2);
      write(line_out, string'("0x"), right, 7);  hwrite(line_out, n_entries_p1, right, 2);
      write(line_out, string'("0b"), right, 3);   write(line_out, mem_enb_d, right, 1);
      write(line_out, string'("0x"), right, 7);  hwrite(line_out, std_logic_vector(unsigned(mem_addr)-to_unsigned(mem_read_delay,mem_addr'length)), right, 2);
      if (mem_enb_d='1') then -- Only write if enable (delayed): Switch off in complete read out mode
        write(line_out, string'("0x"), right, signal_name'length+1-(mem_data'length+3)/4); hwrite(line_out, mem_data, right, (mem_data'length+3)/4);
      else
        write(line_out, string'("0x"), right, signal_name'length+1-(mem_data'length+3)/4); hwrite(line_out, v_zero,   right, (mem_data'length+3)/4);
      end if;
      write(line_out, string'("0b"), right, 4);   write(line_out, done,       right, 1);
      write(line_out, string'("0b"), right, 10);  write(line_out, bx_out_vld, right, 1);
      write(line_out, string'("0x"), right, 6);  hwrite(line_out, bx_out,     right, (bx_out'length+3)/4);
      writeline (file_out, line_out); -- Write line
      file_close(file_out);
    end if;

--    wait until rising_edge(MC_done); -- Wait for first result
--    l_BX : for v_bx_cnt in 0 to MAX_EVENTS-1 loop -- 0 to 99
--      l_addr : for addr in 0 to MAX_ENTRIES-1+mem_read_delay loop -- 0 to 109
--        if (addr <= MAX_ENTRIES-1) then -- w/o mem_read_delay
---- todo: write all 256 addr to file; pause playback and en_proc (wait for readout done)
--          if (v_bx_cnt mod 2)=0 then -- 1. page
--            if (addr < (to_integer(unsigned(FM_L1L2XX_L3PHIC_nentries_V_dout(0))))) then -- Only read number of entries: Switch off in complete read out mode
--              FM_L1L2XX_L3PHIC_dataarray_data_V_enb <= '1';
--            else
--              FM_L1L2XX_L3PHIC_dataarray_data_V_enb <= '0';
--            end if;
--          else                       -- 2. page
--            if (addr < (to_integer(unsigned(FM_L1L2XX_L3PHIC_nentries_V_dout(1))))) then -- Only read number of entries: Switch off in complete read out mode
--              FM_L1L2XX_L3PHIC_dataarray_data_V_enb <= '1';
--            else
--              FM_L1L2XX_L3PHIC_dataarray_data_V_enb <= '0';
--            end if;
--          end if;
--        end if;
--        FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr <= std_logic_vector(to_unsigned(addr+(PAGE_OFFSET*(v_bx_cnt mod 2)),FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr'length));
--        wait for 0 ns; -- Update signals
--        -- Other writes ---------------------------------------
--        if (addr >= mem_read_delay) then -- Take read dealy into account
--          write(line_out, NOW, right, 12); -- NOW = current simulation time
--          write(line_out, v_bx_cnt, right, 4);
--          --write(line_out, string'("0x"), right, 4); hwrite(line_out, std_logic_vector(to_unsigned(addr,10)), right, 3);
--          write(line_out, string'("0b"), right, 5);   write(line_out, reset, right, 1);
--          write(line_out, string'("0x"), right, 7);  hwrite(line_out, FM_L1L2XX_L3PHIC_nentries_V_dout(0), right, 2);
--          write(line_out, string'("0x"), right, 7);  hwrite(line_out, FM_L1L2XX_L3PHIC_nentries_V_dout(1), right, 2);
--          write(line_out, string'("0b"), right, 3);   write(line_out, v_FM_L1L2XX_L3PHIC_dataarray_data_V_enb_d(mem_read_delay-1), right, 1);
--          write(line_out, string'("0x"), right, 7);  hwrite(line_out, std_logic_vector(unsigned(FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr)-to_unsigned(mem_read_delay,FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr'length)), right, 2);
--          if (v_FM_L1L2XX_L3PHIC_dataarray_data_V_enb_d(mem_read_delay-1)='1') then -- Only write if enable (delayed): Switch off in complete read out mode
--            write(line_out, string'("0x"), right, 12); hwrite(line_out, FM_L1L2XX_L3PHIC_dataarray_data_V_dout, right, 12);
--          else
--            write(line_out, string'("0x"), right, 12);  write(line_out, string'("000000000000"), right, 12);
--          end if;
--          write(line_out, string'("0b"), right, 8);   write(line_out, MC_done, right, 1);
--          write(line_out, string'("0b"), right, 3);   write(line_out, MC_bx_out_vld, right, 1);
--          write(line_out, string'("0x"), right, 9);  hwrite(line_out, MC_bx_out, right, 1);
--          writeline (file_out, line_out); -- Write line
--        end if;
--        v_FM_L1L2XX_L3PHIC_dataarray_data_V_enb_d :=  v_FM_L1L2XX_L3PHIC_dataarray_data_V_enb_d(mem_read_delay-2 downto 0) & FM_L1L2XX_L3PHIC_dataarray_data_V_enb; -- Required delay
--        if (DEBUG=true and v_bx_cnt<=5 and addr<=10) then write(line_out, string'("v_bx_cnt: ")); write(line_out, v_bx_cnt); write(line_out, string'("   FM_L1L2XX_L3PHIC readaddr: ")); hwrite(line_out, FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr); write(line_out, string'(", dout: ")); hwrite(line_out, FM_L1L2XX_L3PHIC_dataarray_data_V_dout); writeline(output, line_out); end if;
--        wait for CLK_PERIOD; -- Main time control
--      end loop l_addr;
--    end loop l_BX;
--    file_close(file_out);
--    assert false report "Simulation finished!" severity FAILURE;
--  end process write_result;

  end write_emData_2p;

end package body mytypes_pkg;
