library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SectorProcessor is
  port(
    clk        : in std_logic;
    reset      : in std_logic;
    en_proc    : in str_logic;
    bx_in_ProjectionRouter : in std_logic_vector(2 downto 0);
    bx_out_MatchCalculator : out std_logic_vector(2 downto 0);
    bx_out_MatchCalculator_vld : out std_logic;
    MatchCalculator_done   : out std_logic;
    TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L1L2XXG_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L1L2XXG_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXG_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L1L2XXG_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC18n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC18n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC18n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC18n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC18n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L1L2XXH_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L1L2XXH_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXH_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L1L2XXH_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC19n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC19n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC19n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC19n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC19n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L1L2XXI_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L1L2XXI_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXI_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L1L2XXI_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC20n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC20n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC20n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC20n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC20n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC21n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC21n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC21n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC21n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC21n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L5L6XXC_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L5L6XXC_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXC_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L5L6XXC_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L5L6XXB_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L5L6XXB_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXB_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L5L6XXB_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC22n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC22n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC22n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC22n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC22n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC23n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC23n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC23n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC23n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC23n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC24n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC24n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC24n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC24n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC24n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_dataarray_data_V_wea       : in std_logic;
    VMSME_L3PHIC17n1_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    VMSME_L3PHIC17n1_dataarray_data_V_din       : in std_logic_vector(13 downto 0);
    VMSME_L3PHIC17n1_nentries_0_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_0_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_1_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_1_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_2_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_2_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_3_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_3_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_4_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_4_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_5_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_5_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_6_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_6_V_din : in std_logic_vector(7 downto 0);
    VMSME_L3PHIC17n1_nentries_7_V_we  : in std_logic;
    VMSME_L3PHIC17n1_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L5L6XXD_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L5L6XXD_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L5L6XXD_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L5L6XXD_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_dataarray_data_V_wea       : in std_logic;
    AS_L3PHICn6_dataarray_data_V_writeaddr : in std_logic_vector(9 downto 0);
    AS_L3PHICn6_dataarray_data_V_din       : in std_logic_vector(35 downto 0);
    AS_L3PHICn6_nentries_0_V_we  : in std_logic;
    AS_L3PHICn6_nentries_0_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_1_V_we  : in std_logic;
    AS_L3PHICn6_nentries_1_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_2_V_we  : in std_logic;
    AS_L3PHICn6_nentries_2_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_3_V_we  : in std_logic;
    AS_L3PHICn6_nentries_3_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_4_V_we  : in std_logic;
    AS_L3PHICn6_nentries_4_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_5_V_we  : in std_logic;
    AS_L3PHICn6_nentries_5_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_6_V_we  : in std_logic;
    AS_L3PHICn6_nentries_6_V_din : in std_logic_vector(7 downto 0);
    AS_L3PHICn6_nentries_7_V_we  : in std_logic;
    AS_L3PHICn6_nentries_7_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_wea       : in std_logic;
    TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_writeaddr : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_din       : in std_logic_vector(59 downto 0);
    TPROJ_L1L2XXF_L3PHIC_nentries_0_V_we  : in std_logic;
    TPROJ_L1L2XXF_L3PHIC_nentries_0_V_din : in std_logic_vector(7 downto 0);
    TPROJ_L1L2XXF_L3PHIC_nentries_1_V_we  : in std_logic;
    TPROJ_L1L2XXF_L3PHIC_nentries_1_V_din : in std_logic_vector(7 downto 0);
    FM_L5L6XX_L3PHIC_dataarray_data_V_enb      : in std_logic;
)    FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr : in std_logic_vector(7 downto 0);
    FM_L5L6XX_L3PHIC_dataarray_data_V_dout     : out std_logic_vector(44 downto 0);
    FM_L5L6XX_L3PHIC_nentries_0_V_dout : out std_logic_vector(7 downto 0);
    FM_L5L6XX_L3PHIC_nentries_1_V_dout : out std_logic_vector(7 downto 0);
    FM_L1L2XX_L3PHIC_dataarray_data_V_enb      : in std_logic;
)    FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr : in std_logic_vector(7 downto 0);
    FM_L1L2XX_L3PHIC_dataarray_data_V_dout     : out std_logic_vector(44 downto 0);
    FM_L1L2XX_L3PHIC_nentries_0_V_dout : out std_logic_vector(7 downto 0);
    FM_L1L2XX_L3PHIC_nentries_1_V_dout : out std_logic_vector(7 downto 0);
);



end SectorProcessor;

architecture rtl of SectorProcessor is

function clogb2 (bit_depth : integer) return integer is
  variable depth : integer := bit_depth;
  variable count : integer := 1;
begin
  for clogb2 in 1 to bit_depth loop     -- Works for up to 32 bit integers
    if (bit_depth <= 2) then
      count := 1;
    else
      if(depth <= 1) then
        count := count;
      else
        depth := depth / 2;
        count := count + 1;
      end if;
    end if;
  end loop;
  return(count-1);
end;

COMPONENT myMemory
GENERIC (
  RAM_WIDTH       : integer := 18;                  -- Specify RAM data width
  RAM_DEPTH       : integer := 1024;                -- Specify RAM depth (number of entries)
  INIT_FILE       : string  := "";                  -- Specify name/location of RAM initialization file if using one (leave blank if not)
  RAM_PERFORMANCE : string  := "HIGH_PERFORMANCE";  -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY"
  HEX             : integer := 1 
  );
PORT (
  addra    : in std_logic_vector(clogb2(RAM_DEPTH) - 1 downto 0);  -- Write address bus, width determined from RAM_DEPTH
  addrb    : in std_logic_vector(clogb2(RAM_DEPTH) - 1 downto 0);  -- Read address bus, width determined from RAM_DEPTH
  dina     : in std_logic_vector(RAM_WIDTH - 1 downto 0);          -- RAM input data
  clka     : in std_logic;                                         -- Write clock
  clkb     : in std_logic;                                         -- Read clock
  wea      : in std_logic;                                         -- Write enable
  enb      : in std_logic;                                         -- Read Enable, for additional power savings, disable when not in use
  rstb     : in std_logic;                                         -- Output reset (does not affect memory contents)
  regceb   : in std_logic;                                         -- Output register enable
  nent_i0  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we0 : in std_logic;                                         -- Write enable
  nent_o0  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i1  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we1 : in std_logic;                                         -- Write enable
  nent_o1  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i2  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we2 : in std_logic;                                         -- Write enable
  nent_o2  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i3  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we3 : in std_logic;                                         -- Write enable
  nent_o3  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i4  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we4 : in std_logic;                                         -- Write enable
  nent_o4  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i5  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we5 : in std_logic;                                         -- Write enable
  nent_o5  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i6  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we6 : in std_logic;                                         -- Write enable
  nent_o6  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  nent_i7  : in std_logic_vector(7 downto 0);                      -- Num entries received
  nent_we7 : in std_logic;                                         -- Write enable
  nent_o7  : out std_logic_vector(7 downto 0);                     -- Num entries per page [4 bits each]
  doutb    : out std_logic_vector(RAM_WIDTH-1 downto 0)            -- RAM output data
  );
END COMPONENT;

COMPONENT myMemoryBinned
GENERIC (
  RAM_WIDTH       : integer := 14;                  -- Specify RAM data width, VM Stub: 14 for Barral LPS, 15 for Barral L2S/DISK
  RAM_DEPTH       : integer := 512;                 -- Specify RAM depth (number of entries) 512 is for 4 pages
  INIT_FILE       : string  := "";                  -- Specify name/location of RAM initialization file if using one (leave blank if not)
  RAM_PERFORMANCE : string  := "HIGH_PERFORMANCE";  -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY"
  HEX             : integer := 1 
  );
PORT (
  addra      : in std_logic_vector(clogb2(RAM_DEPTH) - 1 downto 0);  -- Write address bus, width determined from RAM_DEPTH
  addrb      : in std_logic_vector(clogb2(RAM_DEPTH) - 1 downto 0);  -- Read address bus, width determined from RAM_DEPTH
  dina       : in std_logic_vector(RAM_WIDTH - 1 downto 0);          -- RAM input data
  clka       : in std_logic;                                         -- Write clock
  clkb       : in std_logic;                                         -- Read clock
  wea        : in std_logic;                                         -- Write enable
  enb        : in std_logic;                                         -- Read Enable, for additional power savings, disable when not in use
  rstb       : in std_logic;                                         -- Output reset (does not affect memory contents)
  regceb     : in std_logic;                                         -- Output register enable
  nent_0_i0  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we0 : in std_logic;                                         -- Write enable
  nent_0_o0  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i1  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we1 : in std_logic;                                         -- Write enable
  nent_0_o1  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i2  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we2 : in std_logic;                                         -- Write enable
  nent_0_o2  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i3  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we3 : in std_logic;                                         -- Write enable
  nent_0_o3  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i4  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we4 : in std_logic;                                         -- Write enable
  nent_0_o4  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i5  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we5 : in std_logic;                                         -- Write enable
  nent_0_o5  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i6  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we6 : in std_logic;                                         -- Write enable
  nent_0_o6  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_0_i7  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_0_we7 : in std_logic;                                         -- Write enable
  nent_0_o7  : out std_logic_vector(3 downto 0);                     -- Num entries for page 0 [4 bits each]
  nent_1_i0  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we0 : in std_logic;                                         -- Write enable
  nent_1_o0  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i1  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we1 : in std_logic;                                         -- Write enable
  nent_1_o1  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i2  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we2 : in std_logic;                                         -- Write enable
  nent_1_o2  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i3  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we3 : in std_logic;                                         -- Write enable
  nent_1_o3  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i4  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we4 : in std_logic;                                         -- Write enable
  nent_1_o4  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i5  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we5 : in std_logic;                                         -- Write enable
  nent_1_o5  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i6  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we6 : in std_logic;                                         -- Write enable
  nent_1_o6  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_1_i7  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_1_we7 : in std_logic;                                         -- Write enable
  nent_1_o7  : out std_logic_vector(3 downto 0);                     -- Num entries for page 1 [4 bits each]
  nent_2_i0  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we0 : in std_logic;                                         -- Write enable
  nent_2_o0  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i1  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we1 : in std_logic;                                         -- Write enable
  nent_2_o1  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i2  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we2 : in std_logic;                                         -- Write enable
  nent_2_o2  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i3  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we3 : in std_logic;                                         -- Write enable
  nent_2_o3  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i4  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we4 : in std_logic;                                         -- Write enable
  nent_2_o4  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i5  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we5 : in std_logic;                                         -- Write enable
  nent_2_o5  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i6  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we6 : in std_logic;                                         -- Write enable
  nent_2_o6  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_2_i7  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_2_we7 : in std_logic;                                         -- Write enable
  nent_2_o7  : out std_logic_vector(3 downto 0);                     -- Num entries for page 2 [4 bits each]
  nent_3_i0  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we0 : in std_logic;                                         -- Write enable
  nent_3_o0  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i1  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we1 : in std_logic;                                         -- Write enable
  nent_3_o1  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i2  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we2 : in std_logic;                                         -- Write enable
  nent_3_o2  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i3  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we3 : in std_logic;                                         -- Write enable
  nent_3_o3  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i4  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we4 : in std_logic;                                         -- Write enable
  nent_3_o4  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i5  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we5 : in std_logic;                                         -- Write enable
  nent_3_o5  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i6  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we6 : in std_logic;                                         -- Write enable
  nent_3_o6  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  nent_3_i7  : in std_logic_vector(3 downto 0);                      -- Num entries received
  nent_3_we7 : in std_logic;                                         -- Write enable
  nent_3_o7  : out std_logic_vector(3 downto 0);                     -- Num entries for page 3 [4 bits each]
  doutb      : out std_logic_vector(RAM_WIDTH-1 downto 0)            -- RAM output data
  );
END COMPONENT;

  signal TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L1L2XXF_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXF_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L1L2XXG_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXG_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L1L2XXH_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXH_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L1L2XXI_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXI_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L5L6XXB_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXB_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L5L6XXC_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXC_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal TPROJ_L5L6XXD_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal TPROJ_L5L6XXD_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC17n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC17n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC17n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC17n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC17n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC18n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC18n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC18n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC18n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC18n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC19n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC19n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC19n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC19n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC19n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC20n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC20n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC20n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC20n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC20n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC21n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC21n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC21n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC21n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC21n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC22n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC22n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC22n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC22n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC22n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC23n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC23n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC23n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC23n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC23n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMSME_L3PHIC24n1_dataarray_data_V_enb      : std_logic;
  signal VMSME_L3PHIC24n1_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal VMSME_L3PHIC24n1_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal VMSME_L3PHIC24n1_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal VMSME_L3PHIC24n1_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal AS_L3PHICn6_dataarray_data_V_enb      : std_logic;
  signal AS_L3PHICn6_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal AS_L3PHICn6_dataarray_data_V_dout     : std_logic_vector(35 downto 0);
  signal AS_L3PHICn6_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal AS_L3PHICn6_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC17_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC17_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC17_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC17_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC17_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC17_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC17_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC17_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC17_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC17_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC17_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC17_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC18_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC18_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC18_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC18_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC18_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC18_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC18_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC18_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC18_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC18_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC18_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC18_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC19_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC19_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC19_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC19_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC19_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC19_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC19_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC19_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC19_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC19_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC19_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC19_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC20_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC20_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC20_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC20_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC20_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC20_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC20_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC20_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC20_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC20_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC20_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC20_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC21_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC21_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC21_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC21_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC21_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC21_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC21_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC21_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC21_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC21_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC21_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC21_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC22_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC22_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC22_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC22_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC22_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC22_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC22_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC22_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC22_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC22_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC22_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC22_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC23_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC23_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC23_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC23_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC23_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC23_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC23_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC23_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC23_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC23_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC23_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC23_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal VMPROJ_L3PHIC24_dataarray_data_V_wea       : std_logic;
  signal VMPROJ_L3PHIC24_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC24_dataarray_data_V_din       : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC24_nentries_0_V_we  : std_logic;
  signal VMPROJ_L3PHIC24_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC24_nentries_1_V_we  : std_logic;
  signal VMPROJ_L3PHIC24_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC24_dataarray_data_V_enb      : std_logic;
  signal VMPROJ_L3PHIC24_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC24_dataarray_data_V_dout     : std_logic_vector(20 downto 0);
  signal VMPROJ_L3PHIC24_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal VMPROJ_L3PHIC24_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC17_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC17_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC17_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC17_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC17_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC17_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC17_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC17_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC17_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC17_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC17_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC17_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC18_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC18_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC18_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC18_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC18_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC18_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC18_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC18_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC18_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC18_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC18_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC18_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC19_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC19_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC19_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC19_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC19_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC19_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC19_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC19_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC19_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC19_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC19_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC19_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC20_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC20_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC20_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC20_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC20_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC20_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC20_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC20_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC20_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC20_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC20_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC20_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC21_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC21_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC21_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC21_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC21_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC21_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC21_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC21_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC21_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC21_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC21_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC21_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC22_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC22_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC22_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC22_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC22_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC22_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC22_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC22_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC22_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC22_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC22_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC22_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC23_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC23_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC23_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC23_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC23_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC23_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC23_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC23_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC23_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC23_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC23_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC23_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal CM_L3PHIC24_dataarray_data_V_wea       : std_logic;
  signal CM_L3PHIC24_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC24_dataarray_data_V_din       : std_logic_vector(13 downto 0);
  signal CM_L3PHIC24_nentries_0_V_we  : std_logic;
  signal CM_L3PHIC24_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC24_nentries_1_V_we  : std_logic;
  signal CM_L3PHIC24_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal CM_L3PHIC24_dataarray_data_V_enb      : std_logic;
  signal CM_L3PHIC24_dataarray_data_V_readaddr : std_logic_vector(7 downto 0);
  signal CM_L3PHIC24_dataarray_data_V_dout     : std_logic_vector(13 downto 0);
  signal CM_L3PHIC24_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal CM_L3PHIC24_nentries_1_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal AP_L3PHIC_dataarray_data_V_wea       : std_logic;
  signal AP_L3PHIC_dataarray_data_V_writeaddr : std_logic_vector(9 downto 0);
  signal AP_L3PHIC_dataarray_data_V_din       : std_logic_vector(59 downto 0);
  signal AP_L3PHIC_nentries_0_V_we  : std_logic;
  signal AP_L3PHIC_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_1_V_we  : std_logic;
  signal AP_L3PHIC_nentries_1_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_2_V_we  : std_logic;
  signal AP_L3PHIC_nentries_2_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_3_V_we  : std_logic;
  signal AP_L3PHIC_nentries_3_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_4_V_we  : std_logic;
  signal AP_L3PHIC_nentries_4_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_5_V_we  : std_logic;
  signal AP_L3PHIC_nentries_5_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_6_V_we  : std_logic;
  signal AP_L3PHIC_nentries_6_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_7_V_we  : std_logic;
  signal AP_L3PHIC_nentries_7_V_din : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_dataarray_data_V_enb      : std_logic;
  signal AP_L3PHIC_dataarray_data_V_readaddr : std_logic_vector(9 downto 0);
  signal AP_L3PHIC_dataarray_data_V_dout     : std_logic_vector(59 downto 0);
  signal AP_L3PHIC_nentries_0_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_1_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_2_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_3_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_4_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_5_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_6_V_dout : std_logic_vector(7 downto 0);
  signal AP_L3PHIC_nentries_7_V_dout : std_logic_vector(7 downto 0);


TEST1

  signal FM_L1L2XX_L3PHIC_dataarray_data_V_wea       : std_logic;
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal FM_L1L2XX_L3PHIC_dataarray_data_V_din       : std_logic_vector(44 downto 0);
  signal FM_L1L2XX_L3PHIC_nentries_0_V_we  : std_logic;
  signal FM_L1L2XX_L3PHIC_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal FM_L1L2XX_L3PHIC_nentries_1_V_we  : std_logic;
  signal FM_L1L2XX_L3PHIC_nentries_1_V_din : std_logic_vector(7 downto 0);


TEST1

  signal FM_L5L6XX_L3PHIC_dataarray_data_V_wea       : std_logic;
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_writeaddr : std_logic_vector(7 downto 0);
  signal FM_L5L6XX_L3PHIC_dataarray_data_V_din       : std_logic_vector(44 downto 0);
  signal FM_L5L6XX_L3PHIC_nentries_0_V_we  : std_logic;
  signal FM_L5L6XX_L3PHIC_nentries_0_V_din : std_logic_vector(7 downto 0);
  signal FM_L5L6XX_L3PHIC_nentries_1_V_we  : std_logic;
  signal FM_L5L6XX_L3PHIC_nentries_1_V_din : std_logic_vector(7 downto 0);


TEST1

  signal ProjectionRouter_done : std_logic := '0';
  signal MatchEngine_start : std_logic := '0';
  signal bx_out_ProjectionRouter : std_logic_vector(2 downto 0);
  signal bx_out_ProjectionRouter_vld : std_logic;

  signal MatchEngine_done : std_logic := '0';
  signal MatchCalculator_start : std_logic := '0';
  signal bx_out_MatchEngine : std_logic_vector(2 downto 0);
  signal bx_out_MatchEngine_vld : std_logic;










  TPROJ_L1L2XXF_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L1L2XXF_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L1L2XXF_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L1L2XXF_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L1L2XXF_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L1L2XXF_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L1L2XXF_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L1L2XXG_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L1L2XXG_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L1L2XXG_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L1L2XXG_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L1L2XXG_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L1L2XXG_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L1L2XXG_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L1L2XXH_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L1L2XXH_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L1L2XXH_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L1L2XXH_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L1L2XXH_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L1L2XXH_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L1L2XXH_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L1L2XXI_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L1L2XXI_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L1L2XXI_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L1L2XXI_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L1L2XXI_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L1L2XXI_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L1L2XXI_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L1L2XXJ_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L1L2XXJ_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L1L2XXJ_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L5L6XXB_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L5L6XXB_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L5L6XXB_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L5L6XXB_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L5L6XXB_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L5L6XXB_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L5L6XXB_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L5L6XXC_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L5L6XXC_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L5L6XXC_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L5L6XXC_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L5L6XXC_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L5L6XXC_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L5L6XXC_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  TPROJ_L5L6XXD_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_wea,
      addra     => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_writeaddr,
      dina      => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_enb,
      addrb     => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_readaddr,
      doutb     => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_dout,
      nent_we0 => TPROJ_L5L6XXD_L3PHIC_nentries_0_V_we,
      nent_i0  => TPROJ_L5L6XXD_L3PHIC_nentries_0_V_din,
      nent_we1 => TPROJ_L5L6XXD_L3PHIC_nentries_1_V_we,
      nent_i1  => TPROJ_L5L6XXD_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => TPROJ_L5L6XXD_L3PHICnentries_0_V_dout,
      nent_o1  => TPROJ_L5L6XXD_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMSME_L3PHIC17n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC17n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC17n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC17n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC17n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC17n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC17n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC17n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC17n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC17n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC17n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC17n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC17n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC17n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC17n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC17n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC17n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC17n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC17n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC17n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC17n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC17n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC17n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC17n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC17n1nentries_0_V_dout
  );


  VMSME_L3PHIC18n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC18n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC18n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC18n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC18n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC18n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC18n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC18n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC18n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC18n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC18n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC18n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC18n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC18n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC18n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC18n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC18n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC18n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC18n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC18n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC18n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC18n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC18n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC18n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC18n1nentries_0_V_dout
  );


  VMSME_L3PHIC19n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC19n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC19n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC19n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC19n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC19n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC19n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC19n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC19n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC19n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC19n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC19n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC19n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC19n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC19n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC19n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC19n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC19n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC19n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC19n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC19n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC19n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC19n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC19n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC19n1nentries_0_V_dout
  );


  VMSME_L3PHIC20n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC20n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC20n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC20n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC20n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC20n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC20n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC20n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC20n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC20n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC20n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC20n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC20n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC20n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC20n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC20n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC20n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC20n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC20n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC20n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC20n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC20n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC20n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC20n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC20n1nentries_0_V_dout
  );


  VMSME_L3PHIC21n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC21n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC21n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC21n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC21n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC21n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC21n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC21n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC21n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC21n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC21n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC21n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC21n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC21n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC21n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC21n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC21n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC21n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC21n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC21n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC21n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC21n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC21n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC21n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC21n1nentries_0_V_dout
  );


  VMSME_L3PHIC22n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC22n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC22n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC22n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC22n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC22n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC22n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC22n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC22n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC22n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC22n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC22n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC22n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC22n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC22n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC22n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC22n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC22n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC22n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC22n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC22n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC22n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC22n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC22n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC22n1nentries_0_V_dout
  );


  VMSME_L3PHIC23n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC23n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC23n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC23n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC23n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC23n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC23n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC23n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC23n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC23n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC23n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC23n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC23n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC23n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC23n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC23n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC23n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC23n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC23n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC23n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC23n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC23n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC23n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC23n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC23n1nentries_0_V_dout
  );


  VMSME_L3PHIC24n1 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMSME_L3PHIC24n1_dataarray_data_V_wea,
      addra     => VMSME_L3PHIC24n1_dataarray_data_V_writeaddr,
      dina      => VMSME_L3PHIC24n1_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMSME_L3PHIC24n1_dataarray_data_V_enb,
      addrb     => VMSME_L3PHIC24n1_dataarray_data_V_readaddr,
      doutb     => VMSME_L3PHIC24n1_dataarray_data_V_dout,
      nent_we0 => VMSME_L3PHIC24n1_nentries_0_V_we,
      nent_i0  => VMSME_L3PHIC24n1_nentries_0_V_din,
      nent_we1 => VMSME_L3PHIC24n1_nentries_1_V_we,
      nent_i1  => VMSME_L3PHIC24n1_nentries_1_V_din,
      nent_we2 => VMSME_L3PHIC24n1_nentries_2_V_we,
      nent_i2  => VMSME_L3PHIC24n1_nentries_2_V_din,
      nent_we3 => VMSME_L3PHIC24n1_nentries_3_V_we,
      nent_i3  => VMSME_L3PHIC24n1_nentries_3_V_din,
      nent_we4 => VMSME_L3PHIC24n1_nentries_4_V_we,
      nent_i4  => VMSME_L3PHIC24n1_nentries_4_V_din,
      nent_we5 => VMSME_L3PHIC24n1_nentries_5_V_we,
      nent_i5  => VMSME_L3PHIC24n1_nentries_5_V_din,
      nent_we6 => VMSME_L3PHIC24n1_nentries_6_V_we,
      nent_i6  => VMSME_L3PHIC24n1_nentries_6_V_din,
      nent_we7 => VMSME_L3PHIC24n1_nentries_7_V_we,
      nent_i7  => VMSME_L3PHIC24n1_nentries_7_V_din,
      nent_o0  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o1  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o2  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o3  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o4  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o5  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o6  => VMSME_L3PHIC24n1nentries_0_V_dout,
      nent_o7  => VMSME_L3PHIC24n1nentries_0_V_dout
  );


  AS_L3PHICn6 : myMemory
    generic map (
      RAM_WIDTH       => 36,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => AS_L3PHICn6_dataarray_data_V_wea,
      addra     => AS_L3PHICn6_dataarray_data_V_writeaddr,
      dina      => AS_L3PHICn6_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => AS_L3PHICn6_dataarray_data_V_enb,
      addrb     => AS_L3PHICn6_dataarray_data_V_readaddr,
      doutb     => AS_L3PHICn6_dataarray_data_V_dout,
      nent_we0 => AS_L3PHICn6_nentries_0_V_we,
      nent_i0  => AS_L3PHICn6_nentries_0_V_din,
      nent_we1 => AS_L3PHICn6_nentries_1_V_we,
      nent_i1  => AS_L3PHICn6_nentries_1_V_din,
      nent_we2 => AS_L3PHICn6_nentries_2_V_we,
      nent_i2  => AS_L3PHICn6_nentries_2_V_din,
      nent_we3 => AS_L3PHICn6_nentries_3_V_we,
      nent_i3  => AS_L3PHICn6_nentries_3_V_din,
      nent_we4 => AS_L3PHICn6_nentries_4_V_we,
      nent_i4  => AS_L3PHICn6_nentries_4_V_din,
      nent_we5 => AS_L3PHICn6_nentries_5_V_we,
      nent_i5  => AS_L3PHICn6_nentries_5_V_din,
      nent_we6 => AS_L3PHICn6_nentries_6_V_we,
      nent_i6  => AS_L3PHICn6_nentries_6_V_din,
      nent_we7 => AS_L3PHICn6_nentries_7_V_we,
      nent_i7  => AS_L3PHICn6_nentries_7_V_din,
      nent_o0  => AS_L3PHICn6nentries_0_V_dout,
      nent_o1  => AS_L3PHICn6nentries_0_V_dout,
      nent_o2  => AS_L3PHICn6nentries_0_V_dout,
      nent_o3  => AS_L3PHICn6nentries_0_V_dout,
      nent_o4  => AS_L3PHICn6nentries_0_V_dout,
      nent_o5  => AS_L3PHICn6nentries_0_V_dout,
      nent_o6  => AS_L3PHICn6nentries_0_V_dout,
      nent_o7  => AS_L3PHICn6nentries_0_V_dout
  );


  VMPROJ_L3PHIC17 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC17_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC17_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC17_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC17_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC17_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC17_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC17_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC17_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC17_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC17_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC17nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC17nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC18 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC18_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC18_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC18_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC18_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC18_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC18_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC18_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC18_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC18_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC18_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC18nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC18nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC19 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC19_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC19_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC19_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC19_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC19_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC19_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC19_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC19_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC19_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC19_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC19nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC19nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC20 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC20_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC20_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC20_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC20_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC20_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC20_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC20_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC20_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC20_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC20_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC20nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC20nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC21 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC21_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC21_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC21_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC21_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC21_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC21_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC21_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC21_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC21_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC21_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC21nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC21nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC22 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC22_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC22_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC22_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC22_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC22_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC22_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC22_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC22_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC22_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC22_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC22nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC22nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC23 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC23_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC23_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC23_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC23_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC23_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC23_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC23_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC23_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC23_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC23_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC23nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC23nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  VMPROJ_L3PHIC24 : myMemory
    generic map (
      RAM_WIDTH       => 21,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => VMPROJ_L3PHIC24_dataarray_data_V_wea,
      addra     => VMPROJ_L3PHIC24_dataarray_data_V_writeaddr,
      dina      => VMPROJ_L3PHIC24_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => VMPROJ_L3PHIC24_dataarray_data_V_enb,
      addrb     => VMPROJ_L3PHIC24_dataarray_data_V_readaddr,
      doutb     => VMPROJ_L3PHIC24_dataarray_data_V_dout,
      nent_we0 => VMPROJ_L3PHIC24_nentries_0_V_we,
      nent_i0  => VMPROJ_L3PHIC24_nentries_0_V_din,
      nent_we1 => VMPROJ_L3PHIC24_nentries_1_V_we,
      nent_i1  => VMPROJ_L3PHIC24_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => VMPROJ_L3PHIC24nentries_0_V_dout,
      nent_o1  => VMPROJ_L3PHIC24nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC17 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC17_dataarray_data_V_wea,
      addra     => CM_L3PHIC17_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC17_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC17_dataarray_data_V_enb,
      addrb     => CM_L3PHIC17_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC17_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC17_nentries_0_V_we,
      nent_i0  => CM_L3PHIC17_nentries_0_V_din,
      nent_we1 => CM_L3PHIC17_nentries_1_V_we,
      nent_i1  => CM_L3PHIC17_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC17nentries_0_V_dout,
      nent_o1  => CM_L3PHIC17nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC18 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC18_dataarray_data_V_wea,
      addra     => CM_L3PHIC18_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC18_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC18_dataarray_data_V_enb,
      addrb     => CM_L3PHIC18_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC18_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC18_nentries_0_V_we,
      nent_i0  => CM_L3PHIC18_nentries_0_V_din,
      nent_we1 => CM_L3PHIC18_nentries_1_V_we,
      nent_i1  => CM_L3PHIC18_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC18nentries_0_V_dout,
      nent_o1  => CM_L3PHIC18nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC19 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC19_dataarray_data_V_wea,
      addra     => CM_L3PHIC19_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC19_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC19_dataarray_data_V_enb,
      addrb     => CM_L3PHIC19_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC19_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC19_nentries_0_V_we,
      nent_i0  => CM_L3PHIC19_nentries_0_V_din,
      nent_we1 => CM_L3PHIC19_nentries_1_V_we,
      nent_i1  => CM_L3PHIC19_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC19nentries_0_V_dout,
      nent_o1  => CM_L3PHIC19nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC20 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC20_dataarray_data_V_wea,
      addra     => CM_L3PHIC20_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC20_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC20_dataarray_data_V_enb,
      addrb     => CM_L3PHIC20_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC20_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC20_nentries_0_V_we,
      nent_i0  => CM_L3PHIC20_nentries_0_V_din,
      nent_we1 => CM_L3PHIC20_nentries_1_V_we,
      nent_i1  => CM_L3PHIC20_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC20nentries_0_V_dout,
      nent_o1  => CM_L3PHIC20nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC21 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC21_dataarray_data_V_wea,
      addra     => CM_L3PHIC21_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC21_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC21_dataarray_data_V_enb,
      addrb     => CM_L3PHIC21_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC21_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC21_nentries_0_V_we,
      nent_i0  => CM_L3PHIC21_nentries_0_V_din,
      nent_we1 => CM_L3PHIC21_nentries_1_V_we,
      nent_i1  => CM_L3PHIC21_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC21nentries_0_V_dout,
      nent_o1  => CM_L3PHIC21nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC22 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC22_dataarray_data_V_wea,
      addra     => CM_L3PHIC22_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC22_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC22_dataarray_data_V_enb,
      addrb     => CM_L3PHIC22_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC22_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC22_nentries_0_V_we,
      nent_i0  => CM_L3PHIC22_nentries_0_V_din,
      nent_we1 => CM_L3PHIC22_nentries_1_V_we,
      nent_i1  => CM_L3PHIC22_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC22nentries_0_V_dout,
      nent_o1  => CM_L3PHIC22nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC23 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC23_dataarray_data_V_wea,
      addra     => CM_L3PHIC23_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC23_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC23_dataarray_data_V_enb,
      addrb     => CM_L3PHIC23_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC23_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC23_nentries_0_V_we,
      nent_i0  => CM_L3PHIC23_nentries_0_V_din,
      nent_we1 => CM_L3PHIC23_nentries_1_V_we,
      nent_i1  => CM_L3PHIC23_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC23nentries_0_V_dout,
      nent_o1  => CM_L3PHIC23nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  CM_L3PHIC24 : myMemory
    generic map (
      RAM_WIDTH       => 14,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => CM_L3PHIC24_dataarray_data_V_wea,
      addra     => CM_L3PHIC24_dataarray_data_V_writeaddr,
      dina      => CM_L3PHIC24_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => CM_L3PHIC24_dataarray_data_V_enb,
      addrb     => CM_L3PHIC24_dataarray_data_V_readaddr,
      doutb     => CM_L3PHIC24_dataarray_data_V_dout,
      nent_we0 => CM_L3PHIC24_nentries_0_V_we,
      nent_i0  => CM_L3PHIC24_nentries_0_V_din,
      nent_we1 => CM_L3PHIC24_nentries_1_V_we,
      nent_i1  => CM_L3PHIC24_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => CM_L3PHIC24nentries_0_V_dout,
      nent_o1  => CM_L3PHIC24nentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  AP_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 60,
      RAM_DEPTH       => 1024,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => AP_L3PHIC_dataarray_data_V_wea,
      addra     => AP_L3PHIC_dataarray_data_V_writeaddr,
      dina      => AP_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => AP_L3PHIC_dataarray_data_V_enb,
      addrb     => AP_L3PHIC_dataarray_data_V_readaddr,
      doutb     => AP_L3PHIC_dataarray_data_V_dout,
      nent_we0 => AP_L3PHIC_nentries_0_V_we,
      nent_i0  => AP_L3PHIC_nentries_0_V_din,
      nent_we1 => AP_L3PHIC_nentries_1_V_we,
      nent_i1  => AP_L3PHIC_nentries_1_V_din,
      nent_we2 => AP_L3PHIC_nentries_2_V_we,
      nent_i2  => AP_L3PHIC_nentries_2_V_din,
      nent_we3 => AP_L3PHIC_nentries_3_V_we,
      nent_i3  => AP_L3PHIC_nentries_3_V_din,
      nent_we4 => AP_L3PHIC_nentries_4_V_we,
      nent_i4  => AP_L3PHIC_nentries_4_V_din,
      nent_we5 => AP_L3PHIC_nentries_5_V_we,
      nent_i5  => AP_L3PHIC_nentries_5_V_din,
      nent_we6 => AP_L3PHIC_nentries_6_V_we,
      nent_i6  => AP_L3PHIC_nentries_6_V_din,
      nent_we7 => AP_L3PHIC_nentries_7_V_we,
      nent_i7  => AP_L3PHIC_nentries_7_V_din,
      nent_o0  => AP_L3PHICnentries_0_V_dout,
      nent_o1  => AP_L3PHICnentries_0_V_dout,
      nent_o2  => AP_L3PHICnentries_0_V_dout,
      nent_o3  => AP_L3PHICnentries_0_V_dout,
      nent_o4  => AP_L3PHICnentries_0_V_dout,
      nent_o5  => AP_L3PHICnentries_0_V_dout,
      nent_o6  => AP_L3PHICnentries_0_V_dout,
      nent_o7  => AP_L3PHICnentries_0_V_dout
  );


  FM_L1L2XX_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 45,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => FM_L1L2XX_L3PHIC_dataarray_data_V_wea,
      addra     => FM_L1L2XX_L3PHIC_dataarray_data_V_writeaddr,
      dina      => FM_L1L2XX_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => FM_L1L2XX_L3PHIC_dataarray_data_V_enb,
      addrb     => FM_L1L2XX_L3PHIC_dataarray_data_V_readaddr,
      doutb     => FM_L1L2XX_L3PHIC_dataarray_data_V_dout,
      nent_we0 => FM_L1L2XX_L3PHIC_nentries_0_V_we,
      nent_i0  => FM_L1L2XX_L3PHIC_nentries_0_V_din,
      nent_we1 => FM_L1L2XX_L3PHIC_nentries_1_V_we,
      nent_i1  => FM_L1L2XX_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => FM_L1L2XX_L3PHICnentries_0_V_dout,
      nent_o1  => FM_L1L2XX_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );


  FM_L5L6XX_L3PHIC : myMemory
    generic map (
      RAM_WIDTH       => 45,
      RAM_DEPTH       => 256,
      INIT_FILE       => "",
      RAM_PERFORMANCE => "HIGH_PERFORMANCE",
      HEX             => 0
    )
    port map (
      clka      => clk,
      wea       => FM_L5L6XX_L3PHIC_dataarray_data_V_wea,
      addra     => FM_L5L6XX_L3PHIC_dataarray_data_V_writeaddr,
      dina      => FM_L5L6XX_L3PHIC_dataarray_data_V_din,
      clkb      => clk,
      rstb      => '0',
      regceb    => '1',
      enb       => FM_L5L6XX_L3PHIC_dataarray_data_V_enb,
      addrb     => FM_L5L6XX_L3PHIC_dataarray_data_V_readaddr,
      doutb     => FM_L5L6XX_L3PHIC_dataarray_data_V_dout,
      nent_we0 => FM_L5L6XX_L3PHIC_nentries_0_V_we,
      nent_i0  => FM_L5L6XX_L3PHIC_nentries_0_V_din,
      nent_we1 => FM_L5L6XX_L3PHIC_nentries_1_V_we,
      nent_i1  => FM_L5L6XX_L3PHIC_nentries_1_V_din,
      nent_we2 => '0',
      nent_i2  => (others=>'0'),
      nent_we3 => '0',
      nent_i3  => (others=>'0'),
      nent_we4 => '0',
      nent_i4  => (others=>'0'),
      nent_we5 => '0',
      nent_i5  => (others=>'0'),
      nent_we6 => '0',
      nent_i6  => (others=>'0'),
      nent_we7 => '0',
      nent_i7  => (others=>'0'),
      nent_o0  => FM_L5L6XX_L3PHICnentries_0_V_dout,
      nent_o1  => FM_L5L6XX_L3PHICnentries_0_V_dout,
      nent_o2  => open,
      nent_o3  => open,
      nent_o4  => open,
      nent_o5  => open,
      nent_o6  => open,
      nent_o7  => open
  );

  process(ProjectionRouter_done)
  begin
    if ProjectionRouter_done = '1' then MatchEngine_start <= '1'; end if;
  end process;

  PR_L3PHIC : entity work.ProjectionRouter
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => en_proc,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => ProjectionRouter_done,
      bx_V          => bx_in_ProjectionRouter,
      bx_o_V        => bx_out_ProjectionRouter,
      bx_o_V_ap_vld => bx_out_ProjectionRouter_vld,
      proj1in_dataarray_data_V_ce0         => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_enb,
      proj1in_dataarray_data_V_address0     => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_readaddr,
      proj1in_dataarray_data_q0            => TPROJ_L1L2XXF_L3PHIC_dataarray_data_V_dout,
      proj1in_nentries_0_V        => TPROJ_L1L2XXF_L3PHIC_nentries_0_V_dout,
      proj1in_nentries_1_V        => TPROJ_L1L2XXF_L3PHIC_nentries_1_V_dout,
      proj2in_dataarray_data_V_ce0         => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_enb,
      proj2in_dataarray_data_V_address0     => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_readaddr,
      proj2in_dataarray_data_q0            => TPROJ_L1L2XXG_L3PHIC_dataarray_data_V_dout,
      proj2in_nentries_0_V        => TPROJ_L1L2XXG_L3PHIC_nentries_0_V_dout,
      proj2in_nentries_1_V        => TPROJ_L1L2XXG_L3PHIC_nentries_1_V_dout,
      proj3in_dataarray_data_V_ce0         => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_enb,
      proj3in_dataarray_data_V_address0     => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_readaddr,
      proj3in_dataarray_data_q0            => TPROJ_L1L2XXH_L3PHIC_dataarray_data_V_dout,
      proj3in_nentries_0_V        => TPROJ_L1L2XXH_L3PHIC_nentries_0_V_dout,
      proj3in_nentries_1_V        => TPROJ_L1L2XXH_L3PHIC_nentries_1_V_dout,
      proj4in_dataarray_data_V_ce0         => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_enb,
      proj4in_dataarray_data_V_address0     => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_readaddr,
      proj4in_dataarray_data_q0            => TPROJ_L1L2XXI_L3PHIC_dataarray_data_V_dout,
      proj4in_nentries_0_V        => TPROJ_L1L2XXI_L3PHIC_nentries_0_V_dout,
      proj4in_nentries_1_V        => TPROJ_L1L2XXI_L3PHIC_nentries_1_V_dout,
      proj5in_dataarray_data_V_ce0         => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_enb,
      proj5in_dataarray_data_V_address0     => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_readaddr,
      proj5in_dataarray_data_q0            => TPROJ_L1L2XXJ_L3PHIC_dataarray_data_V_dout,
      proj5in_nentries_0_V        => TPROJ_L1L2XXJ_L3PHIC_nentries_0_V_dout,
      proj5in_nentries_1_V        => TPROJ_L1L2XXJ_L3PHIC_nentries_1_V_dout,
      proj6in_dataarray_data_V_ce0         => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_enb,
      proj6in_dataarray_data_V_address0     => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_readaddr,
      proj6in_dataarray_data_q0            => TPROJ_L5L6XXB_L3PHIC_dataarray_data_V_dout,
      proj6in_nentries_0_V        => TPROJ_L5L6XXB_L3PHIC_nentries_0_V_dout,
      proj6in_nentries_1_V        => TPROJ_L5L6XXB_L3PHIC_nentries_1_V_dout,
      proj7in_dataarray_data_V_ce0         => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_enb,
      proj7in_dataarray_data_V_address0     => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_readaddr,
      proj7in_dataarray_data_q0            => TPROJ_L5L6XXC_L3PHIC_dataarray_data_V_dout,
      proj7in_nentries_0_V        => TPROJ_L5L6XXC_L3PHIC_nentries_0_V_dout,
      proj7in_nentries_1_V        => TPROJ_L5L6XXC_L3PHIC_nentries_1_V_dout,
      proj8in_dataarray_data_V_ce0         => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_enb,
      proj8in_dataarray_data_V_address0     => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_readaddr,
      proj8in_dataarray_data_q0            => TPROJ_L5L6XXD_L3PHIC_dataarray_data_V_dout,
      proj8in_nentries_0_V        => TPROJ_L5L6XXD_L3PHIC_nentries_0_V_dout,
      proj8in_nentries_1_V        => TPROJ_L5L6XXD_L3PHIC_nentries_1_V_dout,
      allprojout_dataarray_data_V_ce0         => open,
      allprojout_dataarray_data_V_we0         => AP_L3PHIC_dataarray_data_V_wea,
      allprojout_dataarray_data_V_address0    => AP_L3PHIC_dataarray_data_V_writeaddr,
      allprojout_dataarray_data_V_d0          => AP_L3PHIC_dataarray_data_V_din,
      allprojout_nentries_0_V_ap_vld => AP_L3PHIC_nentries_0_V_we,
      allprojout_nentries_0_V        => AP_L3PHIC_nentries_0_V_din,
      allprojout_nentries_1_V_ap_vld => AP_L3PHIC_nentries_1_V_we,
      allprojout_nentries_1_V        => AP_L3PHIC_nentries_1_V_din,
      allprojout_nentries_2_V_ap_vld => AP_L3PHIC_nentries_2_V_we,
      allprojout_nentries_2_V        => AP_L3PHIC_nentries_2_V_din,
      allprojout_nentries_3_V_ap_vld => AP_L3PHIC_nentries_3_V_we,
      allprojout_nentries_3_V        => AP_L3PHIC_nentries_3_V_din,
      allprojout_nentries_4_V_ap_vld => AP_L3PHIC_nentries_4_V_we,
      allprojout_nentries_4_V        => AP_L3PHIC_nentries_4_V_din,
      allprojout_nentries_5_V_ap_vld => AP_L3PHIC_nentries_5_V_we,
      allprojout_nentries_5_V        => AP_L3PHIC_nentries_5_V_din,
      allprojout_nentries_6_V_ap_vld => AP_L3PHIC_nentries_6_V_we,
      allprojout_nentries_6_V        => AP_L3PHIC_nentries_6_V_din,
      allprojout_nentries_7_V_ap_vld => AP_L3PHIC_nentries_7_V_we,
      allprojout_nentries_7_V        => AP_L3PHIC_nentries_7_V_din,
      vmprojout1_dataarray_data_V_ce0         => open,
      vmprojout1_dataarray_data_V_we0         => VMPROJ_L3PHIC17_dataarray_data_V_wea,
      vmprojout1_dataarray_data_V_address0    => VMPROJ_L3PHIC17_dataarray_data_V_writeaddr,
      vmprojout1_dataarray_data_V_d0          => VMPROJ_L3PHIC17_dataarray_data_V_din,
      vmprojout1_nentries_0_V_ap_vld => VMPROJ_L3PHIC17_nentries_0_V_we,
      vmprojout1_nentries_0_V        => VMPROJ_L3PHIC17_nentries_0_V_din,
      vmprojout1_nentries_1_V_ap_vld => VMPROJ_L3PHIC17_nentries_1_V_we,
      vmprojout1_nentries_1_V        => VMPROJ_L3PHIC17_nentries_1_V_din,
      vmprojout1_nentries_2_V_ap_vld => open,
      vmprojout1_nentries_2_V        => open,
      vmprojout1_nentries_3_V_ap_vld => open,
      vmprojout1_nentries_3_V        => open,
      vmprojout1_nentries_4_V_ap_vld => open,
      vmprojout1_nentries_4_V        => open,
      vmprojout1_nentries_5_V_ap_vld => open,
      vmprojout1_nentries_5_V        => open,
      vmprojout1_nentries_6_V_ap_vld => open,
      vmprojout1_nentries_6_V        => open,
      vmprojout1_nentries_7_V_ap_vld => open,
      vmprojout1_nentries_7_V        => open,
      vmprojout2_dataarray_data_V_ce0         => open,
      vmprojout2_dataarray_data_V_we0         => VMPROJ_L3PHIC18_dataarray_data_V_wea,
      vmprojout2_dataarray_data_V_address0    => VMPROJ_L3PHIC18_dataarray_data_V_writeaddr,
      vmprojout2_dataarray_data_V_d0          => VMPROJ_L3PHIC18_dataarray_data_V_din,
      vmprojout2_nentries_0_V_ap_vld => VMPROJ_L3PHIC18_nentries_0_V_we,
      vmprojout2_nentries_0_V        => VMPROJ_L3PHIC18_nentries_0_V_din,
      vmprojout2_nentries_1_V_ap_vld => VMPROJ_L3PHIC18_nentries_1_V_we,
      vmprojout2_nentries_1_V        => VMPROJ_L3PHIC18_nentries_1_V_din,
      vmprojout2_nentries_2_V_ap_vld => open,
      vmprojout2_nentries_2_V        => open,
      vmprojout2_nentries_3_V_ap_vld => open,
      vmprojout2_nentries_3_V        => open,
      vmprojout2_nentries_4_V_ap_vld => open,
      vmprojout2_nentries_4_V        => open,
      vmprojout2_nentries_5_V_ap_vld => open,
      vmprojout2_nentries_5_V        => open,
      vmprojout2_nentries_6_V_ap_vld => open,
      vmprojout2_nentries_6_V        => open,
      vmprojout2_nentries_7_V_ap_vld => open,
      vmprojout2_nentries_7_V        => open,
      vmprojout3_dataarray_data_V_ce0         => open,
      vmprojout3_dataarray_data_V_we0         => VMPROJ_L3PHIC19_dataarray_data_V_wea,
      vmprojout3_dataarray_data_V_address0    => VMPROJ_L3PHIC19_dataarray_data_V_writeaddr,
      vmprojout3_dataarray_data_V_d0          => VMPROJ_L3PHIC19_dataarray_data_V_din,
      vmprojout3_nentries_0_V_ap_vld => VMPROJ_L3PHIC19_nentries_0_V_we,
      vmprojout3_nentries_0_V        => VMPROJ_L3PHIC19_nentries_0_V_din,
      vmprojout3_nentries_1_V_ap_vld => VMPROJ_L3PHIC19_nentries_1_V_we,
      vmprojout3_nentries_1_V        => VMPROJ_L3PHIC19_nentries_1_V_din,
      vmprojout3_nentries_2_V_ap_vld => open,
      vmprojout3_nentries_2_V        => open,
      vmprojout3_nentries_3_V_ap_vld => open,
      vmprojout3_nentries_3_V        => open,
      vmprojout3_nentries_4_V_ap_vld => open,
      vmprojout3_nentries_4_V        => open,
      vmprojout3_nentries_5_V_ap_vld => open,
      vmprojout3_nentries_5_V        => open,
      vmprojout3_nentries_6_V_ap_vld => open,
      vmprojout3_nentries_6_V        => open,
      vmprojout3_nentries_7_V_ap_vld => open,
      vmprojout3_nentries_7_V        => open,
      vmprojout4_dataarray_data_V_ce0         => open,
      vmprojout4_dataarray_data_V_we0         => VMPROJ_L3PHIC20_dataarray_data_V_wea,
      vmprojout4_dataarray_data_V_address0    => VMPROJ_L3PHIC20_dataarray_data_V_writeaddr,
      vmprojout4_dataarray_data_V_d0          => VMPROJ_L3PHIC20_dataarray_data_V_din,
      vmprojout4_nentries_0_V_ap_vld => VMPROJ_L3PHIC20_nentries_0_V_we,
      vmprojout4_nentries_0_V        => VMPROJ_L3PHIC20_nentries_0_V_din,
      vmprojout4_nentries_1_V_ap_vld => VMPROJ_L3PHIC20_nentries_1_V_we,
      vmprojout4_nentries_1_V        => VMPROJ_L3PHIC20_nentries_1_V_din,
      vmprojout4_nentries_2_V_ap_vld => open,
      vmprojout4_nentries_2_V        => open,
      vmprojout4_nentries_3_V_ap_vld => open,
      vmprojout4_nentries_3_V        => open,
      vmprojout4_nentries_4_V_ap_vld => open,
      vmprojout4_nentries_4_V        => open,
      vmprojout4_nentries_5_V_ap_vld => open,
      vmprojout4_nentries_5_V        => open,
      vmprojout4_nentries_6_V_ap_vld => open,
      vmprojout4_nentries_6_V        => open,
      vmprojout4_nentries_7_V_ap_vld => open,
      vmprojout4_nentries_7_V        => open,
      vmprojout5_dataarray_data_V_ce0         => open,
      vmprojout5_dataarray_data_V_we0         => VMPROJ_L3PHIC21_dataarray_data_V_wea,
      vmprojout5_dataarray_data_V_address0    => VMPROJ_L3PHIC21_dataarray_data_V_writeaddr,
      vmprojout5_dataarray_data_V_d0          => VMPROJ_L3PHIC21_dataarray_data_V_din,
      vmprojout5_nentries_0_V_ap_vld => VMPROJ_L3PHIC21_nentries_0_V_we,
      vmprojout5_nentries_0_V        => VMPROJ_L3PHIC21_nentries_0_V_din,
      vmprojout5_nentries_1_V_ap_vld => VMPROJ_L3PHIC21_nentries_1_V_we,
      vmprojout5_nentries_1_V        => VMPROJ_L3PHIC21_nentries_1_V_din,
      vmprojout5_nentries_2_V_ap_vld => open,
      vmprojout5_nentries_2_V        => open,
      vmprojout5_nentries_3_V_ap_vld => open,
      vmprojout5_nentries_3_V        => open,
      vmprojout5_nentries_4_V_ap_vld => open,
      vmprojout5_nentries_4_V        => open,
      vmprojout5_nentries_5_V_ap_vld => open,
      vmprojout5_nentries_5_V        => open,
      vmprojout5_nentries_6_V_ap_vld => open,
      vmprojout5_nentries_6_V        => open,
      vmprojout5_nentries_7_V_ap_vld => open,
      vmprojout5_nentries_7_V        => open,
      vmprojout6_dataarray_data_V_ce0         => open,
      vmprojout6_dataarray_data_V_we0         => VMPROJ_L3PHIC22_dataarray_data_V_wea,
      vmprojout6_dataarray_data_V_address0    => VMPROJ_L3PHIC22_dataarray_data_V_writeaddr,
      vmprojout6_dataarray_data_V_d0          => VMPROJ_L3PHIC22_dataarray_data_V_din,
      vmprojout6_nentries_0_V_ap_vld => VMPROJ_L3PHIC22_nentries_0_V_we,
      vmprojout6_nentries_0_V        => VMPROJ_L3PHIC22_nentries_0_V_din,
      vmprojout6_nentries_1_V_ap_vld => VMPROJ_L3PHIC22_nentries_1_V_we,
      vmprojout6_nentries_1_V        => VMPROJ_L3PHIC22_nentries_1_V_din,
      vmprojout6_nentries_2_V_ap_vld => open,
      vmprojout6_nentries_2_V        => open,
      vmprojout6_nentries_3_V_ap_vld => open,
      vmprojout6_nentries_3_V        => open,
      vmprojout6_nentries_4_V_ap_vld => open,
      vmprojout6_nentries_4_V        => open,
      vmprojout6_nentries_5_V_ap_vld => open,
      vmprojout6_nentries_5_V        => open,
      vmprojout6_nentries_6_V_ap_vld => open,
      vmprojout6_nentries_6_V        => open,
      vmprojout6_nentries_7_V_ap_vld => open,
      vmprojout6_nentries_7_V        => open,
      vmprojout7_dataarray_data_V_ce0         => open,
      vmprojout7_dataarray_data_V_we0         => VMPROJ_L3PHIC23_dataarray_data_V_wea,
      vmprojout7_dataarray_data_V_address0    => VMPROJ_L3PHIC23_dataarray_data_V_writeaddr,
      vmprojout7_dataarray_data_V_d0          => VMPROJ_L3PHIC23_dataarray_data_V_din,
      vmprojout7_nentries_0_V_ap_vld => VMPROJ_L3PHIC23_nentries_0_V_we,
      vmprojout7_nentries_0_V        => VMPROJ_L3PHIC23_nentries_0_V_din,
      vmprojout7_nentries_1_V_ap_vld => VMPROJ_L3PHIC23_nentries_1_V_we,
      vmprojout7_nentries_1_V        => VMPROJ_L3PHIC23_nentries_1_V_din,
      vmprojout7_nentries_2_V_ap_vld => open,
      vmprojout7_nentries_2_V        => open,
      vmprojout7_nentries_3_V_ap_vld => open,
      vmprojout7_nentries_3_V        => open,
      vmprojout7_nentries_4_V_ap_vld => open,
      vmprojout7_nentries_4_V        => open,
      vmprojout7_nentries_5_V_ap_vld => open,
      vmprojout7_nentries_5_V        => open,
      vmprojout7_nentries_6_V_ap_vld => open,
      vmprojout7_nentries_6_V        => open,
      vmprojout7_nentries_7_V_ap_vld => open,
      vmprojout7_nentries_7_V        => open,
      vmprojout8_dataarray_data_V_ce0         => open,
      vmprojout8_dataarray_data_V_we0         => VMPROJ_L3PHIC24_dataarray_data_V_wea,
      vmprojout8_dataarray_data_V_address0    => VMPROJ_L3PHIC24_dataarray_data_V_writeaddr,
      vmprojout8_dataarray_data_V_d0          => VMPROJ_L3PHIC24_dataarray_data_V_din,
      vmprojout8_nentries_0_V_ap_vld => VMPROJ_L3PHIC24_nentries_0_V_we,
      vmprojout8_nentries_0_V        => VMPROJ_L3PHIC24_nentries_0_V_din,
      vmprojout8_nentries_1_V_ap_vld => VMPROJ_L3PHIC24_nentries_1_V_we,
      vmprojout8_nentries_1_V        => VMPROJ_L3PHIC24_nentries_1_V_din,
      vmprojout8_nentries_2_V_ap_vld => open,
      vmprojout8_nentries_2_V        => open,
      vmprojout8_nentries_3_V_ap_vld => open,
      vmprojout8_nentries_3_V        => open,
      vmprojout8_nentries_4_V_ap_vld => open,
      vmprojout8_nentries_4_V        => open,
      vmprojout8_nentries_5_V_ap_vld => open,
      vmprojout8_nentries_5_V        => open,
      vmprojout8_nentries_6_V_ap_vld => open,
      vmprojout8_nentries_6_V        => open,
      vmprojout8_nentries_7_V_ap_vld => open,
      vmprojout8_nentries_7_V        => open,

);

  process(MatchEngine_done)
  begin
    if MatchEngine_done = '1' then MatchCalculator_start <= '1'; end if;
  end process;

  ME_L3PHIC17 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => MatchEngine_done,
      bx_V          => bx_out_ProjectionRouter,
      bx_o_V        => bx_out_MatchEngine,
      bx_o_V_ap_vld => bx_out_MatchEngine_vld,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC17n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC17n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC17n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC17n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC17n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC17n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC17n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC17n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC17n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC17n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC17n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC17_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC17_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC17_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC17_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC17_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC17_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC17_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC17_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC17_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC17_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC17_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC17_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC18 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC18n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC18n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC18n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC18n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC18n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC18n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC18n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC18n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC18n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC18n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC18n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC18_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC18_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC18_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC18_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC18_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC18_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC18_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC18_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC18_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC18_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC18_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC18_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC19 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC19n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC19n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC19n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC19n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC19n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC19n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC19n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC19n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC19n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC19n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC19n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC19_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC19_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC19_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC19_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC19_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC19_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC19_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC19_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC19_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC19_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC19_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC19_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC20 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC20n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC20n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC20n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC20n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC20n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC20n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC20n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC20n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC20n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC20n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC20n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC20_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC20_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC20_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC20_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC20_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC20_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC20_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC20_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC20_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC20_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC20_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC20_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC21 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC21n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC21n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC21n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC21n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC21n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC21n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC21n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC21n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC21n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC21n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC21n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC21_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC21_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC21_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC21_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC21_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC21_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC21_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC21_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC21_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC21_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC21_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC21_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC22 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC22n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC22n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC22n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC22n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC22n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC22n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC22n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC22n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC22n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC22n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC22n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC22_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC22_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC22_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC22_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC22_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC22_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC22_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC22_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC22_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC22_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC22_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC22_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC23 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC23n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC23n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC23n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC23n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC23n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC23n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC23n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC23n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC23n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC23n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC23n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC23_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC23_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC23_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC23_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC23_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC23_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC23_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC23_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC23_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC23_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC23_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC23_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  ME_L3PHIC24 : entity work.MatchEngine
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchEngine_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => open,
      bx_V          => bx_out_ProjectionRouter,
      inputStubData_dataarray_data_V_ce0         => VMSME_L3PHIC24n1_dataarray_data_V_enb,
      inputStubData_dataarray_data_V_address0     => VMSME_L3PHIC24n1_dataarray_data_V_readaddr,
      inputStubData_dataarray_data_q0            => VMSME_L3PHIC24n1_dataarray_data_V_dout,
      inputStubData_nentries_0_V        => VMSME_L3PHIC24n1_nentries_0_V_dout,
      inputStubData_nentries_1_V        => VMSME_L3PHIC24n1_nentries_1_V_dout,
      inputStubData_nentries_2_V        => VMSME_L3PHIC24n1_nentries_2_V_dout,
      inputStubData_nentries_3_V        => VMSME_L3PHIC24n1_nentries_3_V_dout,
      inputStubData_nentries_4_V        => VMSME_L3PHIC24n1_nentries_4_V_dout,
      inputStubData_nentries_5_V        => VMSME_L3PHIC24n1_nentries_5_V_dout,
      inputStubData_nentries_6_V        => VMSME_L3PHIC24n1_nentries_6_V_dout,
      inputStubData_nentries_7_V        => VMSME_L3PHIC24n1_nentries_7_V_dout,
      inputProjectionData_dataarray_data_V_ce0         => VMPROJ_L3PHIC24_dataarray_data_V_enb,
      inputProjectionData_dataarray_data_V_address0     => VMPROJ_L3PHIC24_dataarray_data_V_readaddr,
      inputProjectionData_dataarray_data_q0            => VMPROJ_L3PHIC24_dataarray_data_V_dout,
      inputProjectionData_nentries_0_V        => VMPROJ_L3PHIC24_nentries_0_V_dout,
      inputProjectionData_nentries_1_V        => VMPROJ_L3PHIC24_nentries_1_V_dout,
      outputCandidateMatch_dataarray_data_V_ce0         => open,
      outputCandidateMatch_dataarray_data_V_we0         => CM_L3PHIC24_dataarray_data_V_wea,
      outputCandidateMatch_dataarray_data_V_address0    => CM_L3PHIC24_dataarray_data_V_writeaddr,
      outputCandidateMatch_dataarray_data_V_d0          => CM_L3PHIC24_dataarray_data_V_din,
      outputCandidateMatch_nentries_0_V_ap_vld => CM_L3PHIC24_nentries_0_V_we,
      outputCandidateMatch_nentries_0_V        => CM_L3PHIC24_nentries_0_V_din,
      outputCandidateMatch_nentries_1_V_ap_vld => CM_L3PHIC24_nentries_1_V_we,
      outputCandidateMatch_nentries_1_V        => CM_L3PHIC24_nentries_1_V_din,
      outputCandidateMatch_nentries_2_V_ap_vld => open,
      outputCandidateMatch_nentries_2_V        => open,
      outputCandidateMatch_nentries_3_V_ap_vld => open,
      outputCandidateMatch_nentries_3_V        => open,
      outputCandidateMatch_nentries_4_V_ap_vld => open,
      outputCandidateMatch_nentries_4_V        => open,
      outputCandidateMatch_nentries_5_V_ap_vld => open,
      outputCandidateMatch_nentries_5_V        => open,
      outputCandidateMatch_nentries_6_V_ap_vld => open,
      outputCandidateMatch_nentries_6_V        => open,
      outputCandidateMatch_nentries_7_V_ap_vld => open,
      outputCandidateMatch_nentries_7_V        => open,

);

  MC_L3PHIC : entity work.MatchCalculator
    port map (
      ap_clk   => clk,
      ap_rst   => reset,
      ap_start => MatchCalculator_start,
      ap_idle  => open,
      ap_ready => open,
      ap_done  => MatchCalculator_done,
      bx_V          => bx_out_MatchEngine,
      bx_o_V        => bx_out_MatchCalculator,
      bx_o_V_ap_vld => bx_out_MatchCalculator_vld,
      match1_dataarray_data_V_ce0         => CM_L3PHIC17_dataarray_data_V_enb,
      match1_dataarray_data_V_address0     => CM_L3PHIC17_dataarray_data_V_readaddr,
      match1_dataarray_data_q0            => CM_L3PHIC17_dataarray_data_V_dout,
      match1_nentries_0_V        => CM_L3PHIC17_nentries_0_V_dout,
      match1_nentries_1_V        => CM_L3PHIC17_nentries_1_V_dout,
      match2_dataarray_data_V_ce0         => CM_L3PHIC18_dataarray_data_V_enb,
      match2_dataarray_data_V_address0     => CM_L3PHIC18_dataarray_data_V_readaddr,
      match2_dataarray_data_q0            => CM_L3PHIC18_dataarray_data_V_dout,
      match2_nentries_0_V        => CM_L3PHIC18_nentries_0_V_dout,
      match2_nentries_1_V        => CM_L3PHIC18_nentries_1_V_dout,
      match3_dataarray_data_V_ce0         => CM_L3PHIC19_dataarray_data_V_enb,
      match3_dataarray_data_V_address0     => CM_L3PHIC19_dataarray_data_V_readaddr,
      match3_dataarray_data_q0            => CM_L3PHIC19_dataarray_data_V_dout,
      match3_nentries_0_V        => CM_L3PHIC19_nentries_0_V_dout,
      match3_nentries_1_V        => CM_L3PHIC19_nentries_1_V_dout,
      match4_dataarray_data_V_ce0         => CM_L3PHIC20_dataarray_data_V_enb,
      match4_dataarray_data_V_address0     => CM_L3PHIC20_dataarray_data_V_readaddr,
      match4_dataarray_data_q0            => CM_L3PHIC20_dataarray_data_V_dout,
      match4_nentries_0_V        => CM_L3PHIC20_nentries_0_V_dout,
      match4_nentries_1_V        => CM_L3PHIC20_nentries_1_V_dout,
      match5_dataarray_data_V_ce0         => CM_L3PHIC21_dataarray_data_V_enb,
      match5_dataarray_data_V_address0     => CM_L3PHIC21_dataarray_data_V_readaddr,
      match5_dataarray_data_q0            => CM_L3PHIC21_dataarray_data_V_dout,
      match5_nentries_0_V        => CM_L3PHIC21_nentries_0_V_dout,
      match5_nentries_1_V        => CM_L3PHIC21_nentries_1_V_dout,
      match6_dataarray_data_V_ce0         => CM_L3PHIC22_dataarray_data_V_enb,
      match6_dataarray_data_V_address0     => CM_L3PHIC22_dataarray_data_V_readaddr,
      match6_dataarray_data_q0            => CM_L3PHIC22_dataarray_data_V_dout,
      match6_nentries_0_V        => CM_L3PHIC22_nentries_0_V_dout,
      match6_nentries_1_V        => CM_L3PHIC22_nentries_1_V_dout,
      match7_dataarray_data_V_ce0         => CM_L3PHIC23_dataarray_data_V_enb,
      match7_dataarray_data_V_address0     => CM_L3PHIC23_dataarray_data_V_readaddr,
      match7_dataarray_data_q0            => CM_L3PHIC23_dataarray_data_V_dout,
      match7_nentries_0_V        => CM_L3PHIC23_nentries_0_V_dout,
      match7_nentries_1_V        => CM_L3PHIC23_nentries_1_V_dout,
      match8_dataarray_data_V_ce0         => CM_L3PHIC24_dataarray_data_V_enb,
      match8_dataarray_data_V_address0     => CM_L3PHIC24_dataarray_data_V_readaddr,
      match8_dataarray_data_q0            => CM_L3PHIC24_dataarray_data_V_dout,
      match8_nentries_0_V        => CM_L3PHIC24_nentries_0_V_dout,
      match8_nentries_1_V        => CM_L3PHIC24_nentries_1_V_dout,
      allstub_dataarray_data_V_ce0         => AS_L3PHICn6_dataarray_data_V_enb,
      allstub_dataarray_data_V_address0     => AS_L3PHICn6_dataarray_data_V_readaddr,
      allstub_dataarray_data_q0            => AS_L3PHICn6_dataarray_data_V_dout,
      allstub_nentries_0_V        => AS_L3PHICn6_nentries_0_V_dout,
      allstub_nentries_1_V        => AS_L3PHICn6_nentries_1_V_dout,
      allstub_nentries_2_V        => AS_L3PHICn6_nentries_2_V_dout,
      allstub_nentries_3_V        => AS_L3PHICn6_nentries_3_V_dout,
      allstub_nentries_4_V        => AS_L3PHICn6_nentries_4_V_dout,
      allstub_nentries_5_V        => AS_L3PHICn6_nentries_5_V_dout,
      allstub_nentries_6_V        => AS_L3PHICn6_nentries_6_V_dout,
      allstub_nentries_7_V        => AS_L3PHICn6_nentries_7_V_dout,
      allproj_dataarray_data_V_ce0         => AP_L3PHIC_dataarray_data_V_enb,
      allproj_dataarray_data_V_address0     => AP_L3PHIC_dataarray_data_V_readaddr,
      allproj_dataarray_data_q0            => AP_L3PHIC_dataarray_data_V_dout,
      allproj_nentries_0_V        => AP_L3PHIC_nentries_0_V_dout,
      allproj_nentries_1_V        => AP_L3PHIC_nentries_1_V_dout,
      allproj_nentries_2_V        => AP_L3PHIC_nentries_2_V_dout,
      allproj_nentries_3_V        => AP_L3PHIC_nentries_3_V_dout,
      allproj_nentries_4_V        => AP_L3PHIC_nentries_4_V_dout,
      allproj_nentries_5_V        => AP_L3PHIC_nentries_5_V_dout,
      allproj_nentries_6_V        => AP_L3PHIC_nentries_6_V_dout,
      allproj_nentries_7_V        => AP_L3PHIC_nentries_7_V_dout,
      fullmatch1_dataarray_data_V_ce0         => open,
      fullmatch1_dataarray_data_V_we0         => FM_L1L2XX_L3PHIC_dataarray_data_V_wea,
      fullmatch1_dataarray_data_V_address0    => FM_L1L2XX_L3PHIC_dataarray_data_V_writeaddr,
      fullmatch1_dataarray_data_V_d0          => FM_L1L2XX_L3PHIC_dataarray_data_V_din,
      fullmatch1_nentries_0_V_ap_vld => FM_L1L2XX_L3PHIC_nentries_0_V_we,
      fullmatch1_nentries_0_V        => FM_L1L2XX_L3PHIC_nentries_0_V_din,
      fullmatch1_nentries_1_V_ap_vld => FM_L1L2XX_L3PHIC_nentries_1_V_we,
      fullmatch1_nentries_1_V        => FM_L1L2XX_L3PHIC_nentries_1_V_din,
      fullmatch1_nentries_2_V_ap_vld => open,
      fullmatch1_nentries_2_V        => open,
      fullmatch1_nentries_3_V_ap_vld => open,
      fullmatch1_nentries_3_V        => open,
      fullmatch1_nentries_4_V_ap_vld => open,
      fullmatch1_nentries_4_V        => open,
      fullmatch1_nentries_5_V_ap_vld => open,
      fullmatch1_nentries_5_V        => open,
      fullmatch1_nentries_6_V_ap_vld => open,
      fullmatch1_nentries_6_V        => open,
      fullmatch1_nentries_7_V_ap_vld => open,
      fullmatch1_nentries_7_V        => open,
      fullmatch2_dataarray_data_V_ce0         => open,
      fullmatch2_dataarray_data_V_we0         => FM_L5L6XX_L3PHIC_dataarray_data_V_wea,
      fullmatch2_dataarray_data_V_address0    => FM_L5L6XX_L3PHIC_dataarray_data_V_writeaddr,
      fullmatch2_dataarray_data_V_d0          => FM_L5L6XX_L3PHIC_dataarray_data_V_din,
      fullmatch2_nentries_0_V_ap_vld => FM_L5L6XX_L3PHIC_nentries_0_V_we,
      fullmatch2_nentries_0_V        => FM_L5L6XX_L3PHIC_nentries_0_V_din,
      fullmatch2_nentries_1_V_ap_vld => FM_L5L6XX_L3PHIC_nentries_1_V_we,
      fullmatch2_nentries_1_V        => FM_L5L6XX_L3PHIC_nentries_1_V_din,
      fullmatch2_nentries_2_V_ap_vld => open,
      fullmatch2_nentries_2_V        => open,
      fullmatch2_nentries_3_V_ap_vld => open,
      fullmatch2_nentries_3_V        => open,
      fullmatch2_nentries_4_V_ap_vld => open,
      fullmatch2_nentries_4_V        => open,
      fullmatch2_nentries_5_V_ap_vld => open,
      fullmatch2_nentries_5_V        => open,
      fullmatch2_nentries_6_V_ap_vld => open,
      fullmatch2_nentries_6_V        => open,
      fullmatch2_nentries_7_V_ap_vld => open,
      fullmatch2_nentries_7_V        => open,

);



end rtl;