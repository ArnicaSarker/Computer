-- 4-bit accumulator: 4-bit adder feeding a 4-bit register
-- On each rising CLK edge: Q <= A + B (mod 16); RESET = '1' gives Q <= 0000.
-- COUT is the adder's combinational carry-out for the current A, B.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_4bit is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0);
        COUT  : out STD_LOGIC
    );
end accumulator_4bit;

architecture Structural of accumulator_4bit is

    component full_adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    component register_4bit
        Port (
            D     : in  STD_LOGIC_VECTOR(3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal SUM_VALUE : STD_LOGIC_VECTOR(3 downto 0);
    signal CARRY     : STD_LOGIC;

begin

    -- Adder portion: A + B
    ADDER: full_adder_4bit
        port map (
            A    => A,
            B    => B,
            Cin  => '0',
            SUM  => SUM_VALUE,
            COUT => CARRY
        );

    -- Register portion: store sum on rising edge
    REG: register_4bit
        port map (
            D     => SUM_VALUE,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    COUT <= CARRY;

end Structural;
