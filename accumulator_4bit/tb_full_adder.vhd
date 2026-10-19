-- Exhaustive testbench for the 1-bit full adder (all 8 input combinations)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_full_adder is
end tb_full_adder;

architecture Behavioral of tb_full_adder is

    component full_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal A, B, Cin, SUM, COUT : STD_LOGIC := '0';

begin

    DUT: full_adder port map (A => A, B => B, Cin => Cin, SUM => SUM, COUT => COUT);

    process
        variable v   : unsigned(2 downto 0);
        variable cnt : integer;
    begin
        for i in 0 to 7 loop
            v   := to_unsigned(i, 3);
            A   <= v(2);
            B   <= v(1);
            Cin <= v(0);
            wait for 10 ns;
            cnt := 0;
            if v(2) = '1' then cnt := cnt + 1; end if;
            if v(1) = '1' then cnt := cnt + 1; end if;
            if v(0) = '1' then cnt := cnt + 1; end if;
            assert (SUM = '1') = (cnt mod 2 = 1)
                report "SUM error at input " & integer'image(i) severity error;
            assert (COUT = '1') = (cnt >= 2)
                report "COUT error at input " & integer'image(i) severity error;
        end loop;
        report "tb_full_adder: test complete" severity note;
        wait;
    end process;

end Behavioral;
