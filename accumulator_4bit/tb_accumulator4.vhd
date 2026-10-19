-- Testbench for the 4-bit accumulator: required 5-step sequence
-- Expected Q is checked 1 ns after each rising clock edge.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_4bit_tb is
end accumulator_4bit_tb;

architecture Behavioral of accumulator_4bit_tb is

    component accumulator_4bit
        Port (
            A     : in  STD_LOGIC_VECTOR(3 downto 0);
            B     : in  STD_LOGIC_VECTOR(3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0);
            COUT  : out STD_LOGIC
        );
    end component;

    constant CLK_PERIOD : time := 10 ns;

    signal A        : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal B        : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal CLK      : STD_LOGIC := '0';
    signal RESET    : STD_LOGIC := '0';
    signal Q        : STD_LOGIC_VECTOR(3 downto 0);
    signal COUT     : STD_LOGIC;
    signal sim_done : boolean := false;

begin

    DUT: accumulator_4bit
        port map (
            A     => A,
            B     => B,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q,
            COUT  => COUT
        );

    -- Clock generation: 10 ns period, stops after the test
    clk_proc: process
    begin
        while not sim_done loop
            CLK <= '0'; wait for CLK_PERIOD / 2;
            CLK <= '1'; wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        -- Step 1: Reset -> Q = 0000
        RESET <= '1'; A <= "0000"; B <= "0000";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0000" report "Step 1 failed: expected 0000" severity error;

        -- Step 2: 3 + 5 = 8 -> Q = 1000
        RESET <= '0'; A <= "0011"; B <= "0101";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "1000" report "Step 2 failed: expected 1000" severity error;

        -- Step 3: 2 + 1 = 3 -> Q = 0011
        A <= "0010"; B <= "0001";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0011" report "Step 3 failed: expected 0011" severity error;

        -- Step 4: 15 + 1 = 16 -> Q = 0000 (overflow), COUT = 1
        A <= "1111"; B <= "0001";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0000" report "Step 4 failed: expected 0000" severity error;
        assert COUT = '1' report "Step 4 failed: expected COUT = 1" severity error;

        -- Step 5: 10 + 5 = 15 -> Q = 1111
        A <= "1010"; B <= "0101";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "1111" report "Step 5 failed: expected 1111" severity error;
        assert COUT = '0' report "Step 5 failed: expected COUT = 0" severity error;

        report "accumulator_4bit_tb: all 5 steps complete" severity note;
        sim_done <= true;
        wait;
    end process;

end Behavioral;
