-- 4-bit Program Counter: PC <- PC + 1 every clock, synchronous active-high reset
-- PC + 1 is generated with the mid-term 4-bit full adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
    Port (
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        PC_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end program_counter;

architecture Structural of program_counter is

    component full_adder_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    signal PC_REG  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal PC_NEXT : STD_LOGIC_VECTOR(3 downto 0);
    signal C_OUT   : STD_LOGIC;

begin

    -- PC + 1
    INC: full_adder_4bit
        port map (
            A    => PC_REG,
            B    => "0001",
            Cin  => '0',
            SUM  => PC_NEXT,
            COUT => C_OUT
        );

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                PC_REG <= "0000";
            else
                PC_REG <= PC_NEXT;
            end if;
        end if;
    end process;

    PC_OUT <= PC_REG;

end Structural;
