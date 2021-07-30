--! Standard libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--! User packages
use work.tf_pkg.all;

package memUtil_pkg is

  -- ########################### Types ###########################

  type enum_AS_36 is (L3PHIBn1,L4PHIBn1,L5PHIBn1,L6PHIBn1);

  type enum_TPAR_70 is (L1L2F);

  type enum_AP_60 is (L3PHIB);

  type enum_AP_58 is (L4PHIB,L5PHIB,L6PHIB);

  type enum_CM_14 is (L3PHIB9,L3PHIB10,L3PHIB11,L3PHIB12,L3PHIB13,L3PHIB14,L3PHIB15,L3PHIB16,L4PHIB9,L4PHIB10,L4PHIB11,L4PHIB12,L4PHIB13,L4PHIB14,L4PHIB15,L4PHIB16,L5PHIB9,L5PHIB10,L5PHIB11,L5PHIB12,L5PHIB13,L5PHIB14,L5PHIB15,L5PHIB16,L6PHIB9,L6PHIB10,L6PHIB11,L6PHIB12,L6PHIB13,L6PHIB14,L6PHIB15,L6PHIB16);

  type enum_FM_52 is (L1L2_L3PHIB,L1L2_L4PHIB,L1L2_L5PHIB,L1L2_L6PHIB);

  type enum_BW_46 is (L1L2_L3,L1L2_L4,L1L2_L5,L1L2_L6);

  type enum_TW_84 is (L1L2);

  type t_arr_AS_36_1b is array(enum_AS_36) of std_logic;
  type t_arr_AS_36_ADDR is array(enum_AS_36) of std_logic_vector(9 downto 0);
  type t_arr_AS_36_DATA is array(enum_AS_36) of std_logic_vector(35 downto 0);
  type t_arr_AS_36_NENT is array(enum_AS_36) of t_arr8_7b;
  type t_arr_TPAR_70_1b is array(enum_TPAR_70) of std_logic;
  type t_arr_TPAR_70_ADDR is array(enum_TPAR_70) of std_logic_vector(9 downto 0);
  type t_arr_TPAR_70_DATA is array(enum_TPAR_70) of std_logic_vector(69 downto 0);
  type t_arr_TPAR_70_NENT is array(enum_TPAR_70) of t_arr8_7b;
  type t_arr_AP_60_1b is array(enum_AP_60) of std_logic;
  type t_arr_AP_60_ADDR is array(enum_AP_60) of std_logic_vector(9 downto 0);
  type t_arr_AP_60_DATA is array(enum_AP_60) of std_logic_vector(59 downto 0);
  type t_arr_AP_60_NENT is array(enum_AP_60) of t_arr8_7b;
  type t_arr_AP_58_1b is array(enum_AP_58) of std_logic;
  type t_arr_AP_58_ADDR is array(enum_AP_58) of std_logic_vector(9 downto 0);
  type t_arr_AP_58_DATA is array(enum_AP_58) of std_logic_vector(57 downto 0);
  type t_arr_AP_58_NENT is array(enum_AP_58) of t_arr8_7b;
  type t_arr_CM_14_1b is array(enum_CM_14) of std_logic;
  type t_arr_CM_14_ADDR is array(enum_CM_14) of std_logic_vector(7 downto 0);
  type t_arr_CM_14_DATA is array(enum_CM_14) of std_logic_vector(13 downto 0);
  type t_arr_CM_14_NENT is array(enum_CM_14) of t_arr2_7b;
  type t_arr_FM_52_1b is array(enum_FM_52) of std_logic;
  type t_arr_FM_52_ADDR is array(enum_FM_52) of std_logic_vector(7 downto 0);
  type t_arr_FM_52_DATA is array(enum_FM_52) of std_logic_vector(51 downto 0);
  type t_arr_FM_52_NENT is array(enum_FM_52) of t_arr2_7b;
  type t_arr_BW_46_1b is array(enum_BW_46) of std_logic;
  type t_arr_BW_46_DATA is array(enum_BW_46) of std_logic_vector(45 downto 0);
  type t_arr_TW_84_1b is array(enum_TW_84) of std_logic;
  type t_arr_TW_84_DATA is array(enum_TW_84) of std_logic_vector(83 downto 0);

  -- ########################### Functions ###########################

  -- Following functions are needed because VHDL doesn't preserve case when converting an enum to a string using image
  function memory_enum_to_string(val: enum_AS_36) return string;
  function memory_enum_to_string(val: enum_TPAR_70) return string;
  function memory_enum_to_string(val: enum_AP_60) return string;
  function memory_enum_to_string(val: enum_AP_58) return string;
  function memory_enum_to_string(val: enum_CM_14) return string;
  function memory_enum_to_string(val: enum_FM_52) return string;
  function memory_enum_to_string(val: enum_BW_46) return string;
  function memory_enum_to_string(val: enum_TW_84) return string;

end package memUtil_pkg;

package body memUtil_pkg is

  -- ########################### Functions ###########################

  function memory_enum_to_string(val: enum_AS_36) return string is
  begin
    case val is
       when L3PHIBn1 => return "L3PHIBn1";
       when L4PHIBn1 => return "L4PHIBn1";
       when L5PHIBn1 => return "L5PHIBn1";
       when L6PHIBn1 => return "L6PHIBn1";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_TPAR_70) return string is
  begin
    case val is
       when L1L2F => return "L1L2F";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_AP_60) return string is
  begin
    case val is
       when L3PHIB => return "L3PHIB";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_AP_58) return string is
  begin
    case val is
       when L4PHIB => return "L4PHIB";
       when L5PHIB => return "L5PHIB";
       when L6PHIB => return "L6PHIB";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_CM_14) return string is
  begin
    case val is
       when L3PHIB9 => return "L3PHIB9";
       when L3PHIB10 => return "L3PHIB10";
       when L3PHIB11 => return "L3PHIB11";
       when L3PHIB12 => return "L3PHIB12";
       when L3PHIB13 => return "L3PHIB13";
       when L3PHIB14 => return "L3PHIB14";
       when L3PHIB15 => return "L3PHIB15";
       when L3PHIB16 => return "L3PHIB16";
       when L4PHIB9 => return "L4PHIB9";
       when L4PHIB10 => return "L4PHIB10";
       when L4PHIB11 => return "L4PHIB11";
       when L4PHIB12 => return "L4PHIB12";
       when L4PHIB13 => return "L4PHIB13";
       when L4PHIB14 => return "L4PHIB14";
       when L4PHIB15 => return "L4PHIB15";
       when L4PHIB16 => return "L4PHIB16";
       when L5PHIB9 => return "L5PHIB9";
       when L5PHIB10 => return "L5PHIB10";
       when L5PHIB11 => return "L5PHIB11";
       when L5PHIB12 => return "L5PHIB12";
       when L5PHIB13 => return "L5PHIB13";
       when L5PHIB14 => return "L5PHIB14";
       when L5PHIB15 => return "L5PHIB15";
       when L5PHIB16 => return "L5PHIB16";
       when L6PHIB9 => return "L6PHIB9";
       when L6PHIB10 => return "L6PHIB10";
       when L6PHIB11 => return "L6PHIB11";
       when L6PHIB12 => return "L6PHIB12";
       when L6PHIB13 => return "L6PHIB13";
       when L6PHIB14 => return "L6PHIB14";
       when L6PHIB15 => return "L6PHIB15";
       when L6PHIB16 => return "L6PHIB16";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_FM_52) return string is
  begin
    case val is
       when L1L2_L3PHIB => return "L1L2_L3PHIB";
       when L1L2_L4PHIB => return "L1L2_L4PHIB";
       when L1L2_L5PHIB => return "L1L2_L5PHIB";
       when L1L2_L6PHIB => return "L1L2_L6PHIB";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_BW_46) return string is
  begin
    case val is
       when L1L2_L3 => return "L1L2_L3";
       when L1L2_L4 => return "L1L2_L4";
       when L1L2_L5 => return "L1L2_L5";
       when L1L2_L6 => return "L1L2_L6";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

  function memory_enum_to_string(val: enum_TW_84) return string is
  begin
    case val is
       when L1L2 => return "L1L2";
    end case;
    return "No conversion found.";
  end memory_enum_to_string;

end package body memUtil_pkg;
