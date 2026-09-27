
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit_tb is
end register_1bit_tb;

architecture Behavioral of register_1bit_tb is

    component register_1bit
        Port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal D    : STD_LOGIC := '0';
    signal CLK  : STD_LOGIC := '0';
    signal Q    : STD_LOGIC;
    signal QBAR : STD_LOGIC;

begin

    UUT: register_1bit
        port map (
            D    => D,
            CLK  => CLK,
            Q    => Q,
            QBAR => QBAR
        );

    stimulus: process
    begin

        -- Initial condition
        D <= '0';
        CLK <= '0';
        wait for 10 ns;

        -- Store 1
        D <= '1';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 1
        CLK <= '0';
        wait for 10 ns;

        -- Prepare 0
        D <= '0';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 0
        CLK <= '0';
        wait for 10 ns;

        -- Store 1 again
        D <= '1';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 1
        CLK <= '0';
        wait for 10 ns;

        -- Prepare 0
        D <= '0';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 0
        CLK <= '0';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
