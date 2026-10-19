-- Program ROM: 16 x 12-bit, combinational read. Set 5 program (Appendix B)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    Port (
        ADDR  : in  STD_LOGIC_VECTOR(3 downto 0);
        INSTR : out STD_LOGIC_VECTOR(11 downto 0)
    );
end program_rom;

architecture Behavioral of program_rom is

    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR(11 downto 0);

    constant ROM : rom_type := (
        0  => x"10F",   -- LDI 0x0F
        1  => x"5A0",   -- OR  0xA0
        2  => x"700",   -- NOT
        3  => x"900",   -- SHR
        4  => x"2D8",   -- ADD 0xD8
        5  => x"581",   -- OR  0x81
        6  => x"900",   -- SHR
        others => x"000" -- NOP
    );

begin

    INSTR <= ROM(to_integer(unsigned(ADDR)));

end Behavioral;
