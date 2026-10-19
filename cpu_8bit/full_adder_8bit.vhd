-- 8-bit ripple-carry adder built from two 4-bit adders (mid-term module)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(7 downto 0);
        B    : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC_VECTOR(7 downto 0);
        COUT : out STD_LOGIC
    );
end full_adder_8bit;

architecture Structural of full_adder_8bit is

    component full_adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    signal C_MID : STD_LOGIC;

begin

    -- Lower nibble
    ADD_LO: full_adder_4bit
        port map (
            A    => A(3 downto 0),
            B    => B(3 downto 0),
            Cin  => Cin,
            SUM  => SUM(3 downto 0),
            COUT => C_MID
        );

    -- Upper nibble
    ADD_HI: full_adder_4bit
        port map (
            A    => A(7 downto 4),
            B    => B(7 downto 4),
            Cin  => C_MID,
            SUM  => SUM(7 downto 4),
            COUT => COUT
        );

end Structural;
