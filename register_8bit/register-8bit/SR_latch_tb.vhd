
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_latch_tb is
end SR_latch_tb;

architecture Behavioral of SR_latch_tb is

    component SR_latch
        Port (
            S    : in  STD_LOGIC;
            R    : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal S    : STD_LOGIC := '0';
    signal R    : STD_LOGIC := '0';
    signal Q    : STD_LOGIC;
    signal QBAR : STD_LOGIC;

begin

    UUT: SR_latch
        port map (
            S    => S,
            R    => R,
            Q    => Q,
            QBAR => QBAR
        );

    stimulus: process
    begin

        -- HOLD
        S <= '0';
        R <= '0';
        wait for 10 ns;

        -- SET
        S <= '1';
        R <= '0';
        wait for 10 ns;

        -- HOLD
        S <= '0';
        R <= '0';
        wait for 10 ns;

        -- RESET
        S <= '0';
        R <= '1';
        wait for 10 ns;

        -- HOLD
        S <= '0';
        R <= '0';
        wait for 10 ns;

        -- INVALID
        S <= '1';
        R <= '1';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
