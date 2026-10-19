-- 4-bit register, rising-edge triggered, SYNCHRONOUS active-high reset
-- RESET is checked only inside the rising_edge branch, so it takes
-- effect on a clock edge and has priority over loading D.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_4bit is
    Port (
        D     : in  STD_LOGIC_VECTOR(3 downto 0);
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end register_4bit;

architecture Behavioral of register_4bit is
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                Q <= "0000";
            else
                Q <= D;
            end if;
        end if;
    end process;

end Behavioral;
