library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end full_adder;

architecture Structural of full_adder is

    -- Intermediate signals
    signal X1 : STD_LOGIC;
    signal C1 : STD_LOGIC;
    signal C2 : STD_LOGIC;

begin

    -- First XOR
    XOR1: entity work.xor_gate
        port map (
            A => A,
            B => B,
            Y => X1
        );

    -- Second XOR
    XOR2: entity work.xor_gate
        port map (
            A => X1,
            B => Cin,
            Y => Sum
        );

    -- First AND
    AND1: entity work.and_gate
        port map (
            A => A,
            B => B,
            Y => C1
        );

    -- Second AND
    AND2: entity work.and_gate
        port map (
            A => X1,
            B => Cin,
            Y => C2
        );

    -- OR for Carry-out
    OR1: entity work.or_gate
        port map (
            A => C1,
            B => C2,
            Y => Cout
        );

end Structural;