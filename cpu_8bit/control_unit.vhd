-- Control Unit: decodes opcode for Set 5 (LDI, ADD, OR, NOT, SHR)
-- ALU_SEL: 000 = pass operand (LDI), 001 = ADD, 010 = OR, 011 = NOT, 100 = SHR
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
        OPCODE  : in  STD_LOGIC_VECTOR(3 downto 0);
        ALU_SEL : out STD_LOGIC_VECTOR(2 downto 0);
        ACC_WE  : out STD_LOGIC;
        Z_WE    : out STD_LOGIC
    );
end control_unit;

architecture Behavioral of control_unit is
begin

    process(OPCODE)
    begin
        -- Default: NOP (only PC increments)
        ALU_SEL <= "000";
        ACC_WE  <= '0';
        Z_WE    <= '0';

        case OPCODE is
            when "0001" =>              -- LDI imm : ACC <- imm
                ALU_SEL <= "000";
                ACC_WE  <= '1';
                Z_WE    <= '1';

            when "0010" =>              -- ADD imm : ACC <- ACC + imm
                ALU_SEL <= "001";
                ACC_WE  <= '1';
                Z_WE    <= '1';

            when "0101" =>              -- OR imm  : ACC <- ACC OR imm
                ALU_SEL <= "010";
                ACC_WE  <= '1';
                Z_WE    <= '1';

            when "0111" =>              -- NOT     : ACC <- NOT ACC
                ALU_SEL <= "011";
                ACC_WE  <= '1';
                Z_WE    <= '1';

            when "1001" =>              -- SHR     : ACC <- '0' & ACC(7 downto 1)
                ALU_SEL <= "100";
                ACC_WE  <= '1';
                Z_WE    <= '1';

            when others =>              -- NOP
                null;
        end case;
    end process;

end Behavioral;
