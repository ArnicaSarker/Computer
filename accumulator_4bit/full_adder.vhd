-- 1-bit full adder built from AND / OR / XOR gates
-- SUM  = A xor B xor Cin
-- COUT = (A and B) or ((A xor B) and Cin)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        COUT : out STD_LOGIC
    );
end full_adder;

architecture Structural of full_adder is

    component xor_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component and_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal X  : STD_LOGIC;   -- A xor B
    signal C1 : STD_LOGIC;   -- A and B
    signal C2 : STD_LOGIC;   -- (A xor B) and Cin

begin

    XOR1: xor_gate port map (A => A,  B => B,   Y => X);
    XOR2: xor_gate port map (A => X,  B => Cin, Y => SUM);
    AND1: and_gate port map (A => A,  B => B,   Y => C1);
    AND2: and_gate port map (A => X,  B => Cin, Y => C2);
    OR1 : or_gate  port map (A => C1, B => C2,  Y => COUT);

end Structural;
