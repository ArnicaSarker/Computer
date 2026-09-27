
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit_tb is
end register_8bit_tb;

architecture Behavioral of register_8bit_tb is

    component register_8bit
        Port (
            D    : in  STD_LOGIC_VECTOR(7 downto 0);
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC_VECTOR(7 downto 0);
            QBAR : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal D    : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal CLK  : STD_LOGIC := '0';
    signal Q    : STD_LOGIC_VECTOR(7 downto 0);
    signal QBAR : STD_LOGIC_VECTOR(7 downto 0);

begin

    UUT: register_8bit
        port map (
            D    => D,
            CLK  => CLK,
            Q    => Q,
            QBAR => QBAR
        );

    stimulus: process
    begin

        -- Initial value
        D <= "00000000";
        CLK <= '0';
        wait for 10 ns;

        -- Store 10101010
        D <= "10101010";
        CLK <= '1';
        wait for 10 ns;

        -- Falling edge: store data
        CLK <= '0';
        wait for 10 ns;

        -- Change D, but Q should remain unchanged
        D <= "11001100";
        wait for 10 ns;

        -- Falling edge: store 11001100
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;

        -- Store 11110000
        D <= "11110000";
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;

        -- Store 00001111
        D <= "00001111";
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;

        -- Store 11111111
        D <= "11111111";
        CLK <= '1';
        wait for 10 ns;
        CLK <= '0';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
