-- Exhaustive testbench for the 4-bit ripple-carry adder (256 x 2 cases)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_adder4 is
end tb_adder4;

architecture Behavioral of tb_adder4 is

    component full_adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    signal A, B, SUM : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Cin, COUT : STD_LOGIC := '0';

begin

    DUT: full_adder_4bit port map (A => A, B => B, Cin => Cin, SUM => SUM, COUT => COUT);

    process
        variable expected : unsigned(4 downto 0);
        variable errors   : integer := 0;
    begin
        for c in 0 to 1 loop
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                    A <= std_logic_vector(to_unsigned(i, 4));
                    B <= std_logic_vector(to_unsigned(j, 4));
                    if c = 1 then Cin <= '1'; else Cin <= '0'; end if;
                    wait for 10 ns;
                    expected := to_unsigned(i + j + c, 5);
                    if SUM /= std_logic_vector(expected(3 downto 0)) or COUT /= expected(4) then
                        errors := errors + 1;
                        report "Mismatch: " & integer'image(i) & " + " & integer'image(j)
                             & " + " & integer'image(c) severity error;
                    end if;
                end loop;
            end loop;
        end loop;
        report "tb_adder4: test complete, errors = " & integer'image(errors) severity note;
        wait;
    end process;

end Behavioral;
