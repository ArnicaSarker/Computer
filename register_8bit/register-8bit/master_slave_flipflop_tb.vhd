
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_slave_dff_tb is
end master_slave_dff_tb;

architecture Behavioral of master_slave_dff_tb is

    component master_slave_dff
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

    UUT: master_slave_dff
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

        -- D = 1
        -- Rising edge: master captures D
        D <= '1';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: slave captures master
        CLK <= '0';
        wait for 10 ns;

        -- D = 0
        -- Rising edge
        D <= '0';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 0
        CLK <= '0';
        wait for 10 ns;

        -- D = 1
        -- Rising edge
        D <= '1';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 1
        CLK <= '0';
        wait for 10 ns;

        -- D = 0
        -- Rising edge
        D <= '0';
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: Q becomes 0
        CLK <= '0';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
