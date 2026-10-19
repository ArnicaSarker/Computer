-- Testbench for the 4-bit register with synchronous active-high reset
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_register4 is
end tb_register4;

architecture Behavioral of tb_register4 is

    component register_4bit
        Port (
            D     : in  STD_LOGIC_VECTOR(3 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    constant CLK_PERIOD : time := 10 ns;

    signal D, Q     : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal CLK      : STD_LOGIC := '0';
    signal RESET    : STD_LOGIC := '0';
    signal sim_done : boolean   := false;

begin

    DUT: register_4bit port map (D => D, CLK => CLK, RESET => RESET, Q => Q);

    -- Clock generator (stops when sim_done is set)
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
        -- Synchronous reset
        RESET <= '1'; D <= "1010";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0000" report "Reset failed" severity error;

        -- Load 1010
        RESET <= '0'; D <= "1010";
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "1010" report "Load 1010 failed" severity error;

        -- D changes between edges: Q must hold until next edge
        D <= "0101";
        wait for 2 ns;
        assert Q = "1010" report "Q changed without a clock edge" severity error;
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0101" report "Load 0101 failed" severity error;

        -- Reset asserted mid-cycle must NOT clear Q until the next edge (synchronous)
        wait until falling_edge(CLK);
        RESET <= '1';
        wait for 1 ns;
        assert Q = "0101" report "Reset acted asynchronously" severity error;
        wait until rising_edge(CLK); wait for 1 ns;
        assert Q = "0000" report "Synchronous reset failed" severity error;

        report "tb_register4: test complete" severity note;
        sim_done <= true;
        wait;
    end process;

end Behavioral;
