library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_tb is
end full_adder_tb;

architecture Behavioral of full_adder_tb is

    -- Component Declaration
    component full_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -- Signals
    signal A    : STD_LOGIC := '0';
    signal B    : STD_LOGIC := '0';
    signal Cin  : STD_LOGIC := '0';
    signal Sum  : STD_LOGIC;
    signal Cout : STD_LOGIC;

begin

    -- Unit Under Test
    UUT: full_adder
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    -- Test Process
    process
    begin

        -- Test 000
        A <= '0';
        B <= '0';
        Cin <= '0';
        wait for 10 ns;

        -- Test 001
        A <= '0';
        B <= '0';
        Cin <= '1';
        wait for 10 ns;

        -- Test 010
        A <= '0';
        B <= '1';
        Cin <= '0';
        wait for 10 ns;

        -- Test 011
        A <= '0';
        B <= '1';
        Cin <= '1';
        wait for 10 ns;

        -- Test 100
        A <= '1';
        B <= '0';
        Cin <= '0';
        wait for 10 ns;

        -- Test 101
        A <= '1';
        B <= '0';
        Cin <= '1';
        wait for 10 ns;

        -- Test 110
        A <= '1';
        B <= '1';
        Cin <= '0';
        wait for 10 ns;

        -- Test 111
        A <= '1';
        B <= '1';
        Cin <= '1';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;