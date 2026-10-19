-- Top level: Mini 8-bit Accumulator CPU, Set 5 (LDI, ADD, OR, NOT, SHR)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_8bit is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(7 downto 0);  -- ACC
        Z     : out STD_LOGIC;
        PC    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end cpu_8bit;

architecture Structural of cpu_8bit is

    component program_counter
        Port (
            CLK    : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            PC_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component program_rom
        Port (
            ADDR  : in  STD_LOGIC_VECTOR(3 downto 0);
            INSTR : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component control_unit
        Port (
            OPCODE  : in  STD_LOGIC_VECTOR(3 downto 0);
            ALU_SEL : out STD_LOGIC_VECTOR(2 downto 0);
            ACC_WE  : out STD_LOGIC;
            Z_WE    : out STD_LOGIC
        );
    end component;

    component alu_8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            ALU_SEL : in  STD_LOGIC_VECTOR(2 downto 0);
            RESULT  : out STD_LOGIC_VECTOR(7 downto 0);
            ZERO    : out STD_LOGIC
        );
    end component;

    component register_8bit
        Port (
            D     : in  STD_LOGIC_VECTOR(7 downto 0);
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            EN    : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component z_flag
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            EN    : in  STD_LOGIC;
            Z     : out STD_LOGIC
        );
    end component;

    -- Internal signals
    signal PC_SIG     : STD_LOGIC_VECTOR(3 downto 0);
    signal INSTR      : STD_LOGIC_VECTOR(11 downto 0);
    signal OPCODE     : STD_LOGIC_VECTOR(3 downto 0);
    signal OPERAND    : STD_LOGIC_VECTOR(7 downto 0);
    signal ALU_SEL    : STD_LOGIC_VECTOR(2 downto 0);
    signal ACC_WE     : STD_LOGIC;
    signal Z_WE       : STD_LOGIC;
    signal ALU_RESULT : STD_LOGIC_VECTOR(7 downto 0);
    signal ALU_ZERO   : STD_LOGIC;
    signal ACC_VAL    : STD_LOGIC_VECTOR(7 downto 0);
    signal Z_VAL      : STD_LOGIC;

begin

    -- Program Counter
    U_PC: program_counter
        port map (CLK => CLK, RESET => RESET, PC_OUT => PC_SIG);

    -- Program ROM
    U_ROM: program_rom
        port map (ADDR => PC_SIG, INSTR => INSTR);

    -- Instruction fields
    OPCODE  <= INSTR(11 downto 8);
    OPERAND <= INSTR(7 downto 0);

    -- Control Unit
    U_CU: control_unit
        port map (
            OPCODE  => OPCODE,
            ALU_SEL => ALU_SEL,
            ACC_WE  => ACC_WE,
            Z_WE    => Z_WE
        );

    -- ALU
    U_ALU: alu_8bit
        port map (
            A       => ACC_VAL,
            B       => OPERAND,
            ALU_SEL => ALU_SEL,
            RESULT  => ALU_RESULT,
            ZERO    => ALU_ZERO
        );

    -- Accumulator
    U_ACC: register_8bit
        port map (D => ALU_RESULT, CLK => CLK, RESET => RESET, EN => ACC_WE, Q => ACC_VAL);

    -- Zero flag
    U_Z: z_flag
        port map (D => ALU_ZERO, CLK => CLK, RESET => RESET, EN => Z_WE, Z => Z_VAL);

    -- Outputs
    Q  <= ACC_VAL;
    Z  <= Z_VAL;
    PC <= PC_SIG;

end Structural;
