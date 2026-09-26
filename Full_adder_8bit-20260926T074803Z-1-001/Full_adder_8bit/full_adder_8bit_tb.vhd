library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit_tb is
end full_adder_8bit_tb;

architecture Behavioral of full_adder_8bit_tb is

    -- Component Declaration
    component full_adder_8bit
        Port (
            A    : in  STD_LOGIC_VECTOR(7 downto 0);
            B    : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR(7 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    -- Signals
    signal A    : STD_LOGIC_VECTOR(7 downto 0);
    signal B    : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin  : STD_LOGIC;
    signal Sum  : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout : STD_LOGIC;

begin

    -- Unit Under Test
    UUT: full_adder_8bit
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

        -- Test 1: 5 + 3 = 8
        A <= "00000101";
        B <= "00000011";
        Cin <= '0';
        wait for 10 ns;

        -- Test 2: 10 + 5 = 15
        A <= "00001010";
        B <= "00000101";
        Cin <= '0';
        wait for 10 ns;

        -- Test 3: 15 + 1 = 16
        A <= "00001111";
        B <= "00000001";
        Cin <= '0';
        wait for 10 ns;

        -- Test 4: 100 + 50 = 150
        A <= "01100100";
        B <= "00110010";
        Cin <= '0';
        wait for 10 ns;

        -- Test 5: 255 + 1 = 256
        A <= "11111111";
        B <= "00000001";
        Cin <= '0';
        wait for 10 ns;

        -- Test 6: 10 + 20 + Cin = 31
        A <= "00001010";
        B <= "00010100";
        Cin <= '1';
        wait for 10 ns;

        wait;

    end process;

end Behavioral;