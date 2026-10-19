-- 8-bit register with load enable, synchronous active-high reset (used for ACC and R)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit is
    Port (
        D     : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end register_8bit;

architecture Behavioral of register_8bit is

    signal Q_REG : STD_LOGIC_VECTOR(7 downto 0) := "00000000";

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                Q_REG <= "00000000";
            elsif EN = '1' then
                Q_REG <= D;
            end if;
        end if;
    end process;

    Q <= Q_REG;

end Behavioral;
