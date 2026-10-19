-- 1-bit Zero flag, synchronous active-high reset sets Z = 1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z_flag is
    Port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        Z     : out STD_LOGIC
    );
end z_flag;

architecture Behavioral of z_flag is

    signal Z_REG : STD_LOGIC := '1';

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                Z_REG <= '1';
            elsif EN = '1' then
                Z_REG <= D;
            end if;
        end if;
    end process;

    Z <= Z_REG;

end Behavioral;
