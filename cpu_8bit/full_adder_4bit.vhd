library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);
        B    : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC_VECTOR(3 downto 0);
        COUT : out STD_LOGIC
    );
end full_adder_4bit;

architecture Structural of full_adder_4bit is

    component full_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal C : STD_LOGIC_VECTOR(4 downto 0);

begin

    C(0) <= Cin;

    FA0: full_adder port map (A => A(0), B => B(0), Cin => C(0), SUM => SUM(0), COUT => C(1));
    FA1: full_adder port map (A => A(1), B => B(1), Cin => C(1), SUM => SUM(1), COUT => C(2));
    FA2: full_adder port map (A => A(2), B => B(2), Cin => C(2), SUM => SUM(2), COUT => C(3));
    FA3: full_adder port map (A => A(3), B => B(3), Cin => C(3), SUM => SUM(3), COUT => C(4));

    COUT <= C(4);

end Structural;
