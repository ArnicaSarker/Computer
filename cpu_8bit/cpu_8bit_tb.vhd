-- Testbench for Mini 8-bit Accumulator CPU, Set 5 (Appendix B program)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_8bit_tb is
end cpu_8bit_tb;

architecture Behavioral of cpu_8bit_tb is

    component cpu_8bit
        Port (
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0);
            Z     : out STD_LOGIC;
            PC    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Q     : STD_LOGIC_VECTOR(7 downto 0);
    signal Z     : STD_LOGIC;
    signal PC    : STD_LOGIC_VECTOR(3 downto 0);

    signal SIM_DONE : boolean := false;

    -- Expected values after each rising edge (Cycle 0 = reset, Cycles 1..7 = program)
    type byte_arr is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    type nib_arr  is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    type bit_arr  is array (0 to 7) of STD_LOGIC;

    constant EXP_ACC : byte_arr := (x"00", x"0F", x"AF", x"50", x"28", x"00", x"81", x"40");
    constant EXP_Z   : bit_arr  := ('1', '0', '0', '0', '0', '1', '0', '0');
    constant EXP_PC  : nib_arr  := (x"0", x"1", x"2", x"3", x"4", x"5", x"6", x"7");

begin

    DUT: cpu_8bit
        port map (
            CLK   => CLK,
            RESET => RESET,
            Q     => Q,
            Z     => Z,
            PC    => PC
        );

    -- Clock generation: 10 ns period
    CLK <= not CLK after 5 ns when not SIM_DONE else '0';

    process
    begin

        -- Cycle 0: RESET for one rising edge
        RESET <= '1';
        wait until rising_edge(CLK);
        wait for 1 ns;
        RESET <= '0';

        assert (Q = EXP_ACC(0) and Z = EXP_Z(0) and PC = EXP_PC(0))
            report "Cycle 0 (RESET) mismatch" severity error;

        -- Cycles 1 to 7: one instruction per clock
        for i in 1 to 7 loop
            wait until rising_edge(CLK);
            wait for 1 ns;
            assert (Q = EXP_ACC(i) and Z = EXP_Z(i) and PC = EXP_PC(i))
                report "Cycle " & integer'image(i) & " mismatch" severity error;
        end loop;

        report "Simulation finished: all cycles checked" severity note;
        SIM_DONE <= true;
        wait;

    end process;

end Behavioral;
