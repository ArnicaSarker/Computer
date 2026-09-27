
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_latch_tb is
end D_latch_tb;

architecture Behavioral of D_latch_tb is

    component D_latch
        Port (
            D    : in  STD_LOGIC;
            EN   : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal D    : STD_LOGIC := '0';
    signal EN   : STD_LOGIC := '0';
    signal Q    : STD_LOGIC;
    signal QBAR : STD_LOGIC;

begin

    UUT: D_latch
        port map (
            D    => D,
            EN   => EN,
            Q    => Q,
            QBAR => QBAR
        );

    stimulus: process
    begin

        -- EN = 0, D = 0
        -- HOLD
        D  <= '0';
        EN <= '0';
        wait for 10 ns;

        -- EN = 1, D = 1
        -- SET Q = 1
        D  <= '1';
        EN <= '1';
        wait for 10 ns;

        -- EN = 0, D = 0
        -- HOLD Q = 1
        D  <= '0';
        EN <= '0';
        wait for 10 ns;

        -- EN = 1, D = 0
        -- RESET Q = 0
        D  <= '0';
        EN <= '1';
        wait for 10 ns;

        -- EN = 0, D = 1
        -- HOLD Q = 0
        D  <= '1';
        EN <= '0';
        wait for 10 ns;

        -- EN = 1, D = 1
        -- SET Q = 1
        D  <= '1';
        EN <= '1';
        wait for 10 ns;

        -- EN = 1, D = 0
        -- RESET Q = 0
        D  <= '0';
        EN <= '1';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
