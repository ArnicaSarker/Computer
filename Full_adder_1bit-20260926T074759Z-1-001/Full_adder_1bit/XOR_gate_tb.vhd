library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate_tb is
end xor_gate_tb;

architecture Behavioral of xor_gate_tb is

    -- Component Declaration
    component xor_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    -- Signals
    signal A : STD_LOGIC := '0';
    signal B : STD_LOGIC := '0';
    signal Y : STD_LOGIC;

begin

    -- Unit Under Test
    UUT: xor_gate
        port map (
            A => A,
            B => B,
            Y => Y
        );

    -- Test Process
    process
    begin

        -- Test 00
        A <= '0';
        B <= '0';
        wait for 10 ns;

        -- Test 01
        A <= '0';
        B <= '1';
        wait for 10 ns;

        -- Test 10
        A <= '1';
        B <= '0';
        wait for 10 ns;

        -- Test 11
        A <= '1';
        B <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;