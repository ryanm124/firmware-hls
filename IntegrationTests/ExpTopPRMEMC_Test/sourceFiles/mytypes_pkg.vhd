--! Standard library
library ieee;
--! Standard package
use ieee.std_logic_1164.all;

--! @brief Package.
package mytypes_pkg is

	-- ########################### Constants ###########################

	-- ########################### Types ###########################
	-- 2D
	type t_myarray2_1b  is array (1 downto 0) of std_logic;
	type t_myarray2_8b  is array (1 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_1b  is array (7 downto 0) of std_logic;
  type t_myarray8_3b  is array (7 downto 0) of std_logic_vector(2 downto 0);
  type t_myarray8_4b  is array (7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray8_5b  is array (7 downto 0) of std_logic_vector(4 downto 0);
  type t_myarray8_8b  is array (7 downto 0) of std_logic_vector(7 downto 0);
  type t_myarray8_9b  is array (7 downto 0) of std_logic_vector(8 downto 0);
  type t_myarray8_14b is array (7 downto 0) of std_logic_vector(13 downto 0);
  type t_myarray8_21b is array (7 downto 0) of std_logic_vector(20 downto 0);
  type t_myarray8_60b is array (7 downto 0) of std_logic_vector(59 downto 0);
  -- 3D
  type t_myarray2_8_1b is array(0 to 1, 7 downto 0) of std_logic;
  type t_myarray2_8_8b is array(0 to 1, 7 downto 0) of std_logic_vector(7 downto 0);
  -- 4D
  type t_myarray2_8_8_1b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic;
  type t_myarray2_8_8_4b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic_vector(3 downto 0);
  type t_myarray2_8_8_5b is array(0 to 1, 0 to 7, 7 downto 0) of std_logic_vector(4 downto 0);

end mytypes_pkg;
