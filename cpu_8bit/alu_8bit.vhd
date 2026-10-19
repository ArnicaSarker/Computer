-- 8-bit ALU for Set 5.
-- ADD uses the 8-bit structural adder, OR uses or_gate, NOT uses not_gate.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);  -- ACC
        B       : in  STD_LOGIC_VECTOR(7 downto 0);  -- operand (immediate)
        ALU_SEL : in  STD_LOGIC_VECTOR(2 downto 0);
        RESULT  : out STD_LOGIC_VECTOR(7 downto 0);
        ZERO    : out STD_LOGIC
    );
end alu_8bit;

architecture Structural of alu_8bit is

    component full_adder_8bit
        Port (
            A    : in  STD_LOGIC_VECTOR(7 downto 0);
            B    : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(7 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    component or_gate
        Port ( A : in STD_LOGIC; B : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    component not_gate
        Port ( A : in STD_LOGIC; Y : out STD_LOGIC );
    end component;

    signal ADD_RES : STD_LOGIC_VECTOR(7 downto 0);
    signal OR_RES  : STD_LOGIC_VECTOR(7 downto 0);
    signal NOT_RES : STD_LOGIC_VECTOR(7 downto 0);
    signal SHR_RES : STD_LOGIC_VECTOR(7 downto 0);
    signal RES     : STD_LOGIC_VECTOR(7 downto 0);
    signal CARRY   : STD_LOGIC;   -- discarded (8-bit modulo add)

begin

    -- ADD : A + B
    ADDER: full_adder_8bit
        port map (
            A    => A,
            B    => B,
            Cin  => '0',
            SUM  => ADD_RES,
            COUT => CARRY
        );

    -- OR and NOT : bitwise
    GEN_BIT: for i in 0 to 7 generate
        ORi : or_gate  port map (A => A(i), B => B(i), Y => OR_RES(i));
        NOTi: not_gate port map (A => A(i), Y => NOT_RES(i));
    end generate;

    -- SHR : shift right by 1, '0' enters MSB
    SHR_RES <= '0' & A(7 downto 1);

    -- Result multiplexer
    with ALU_SEL select
        RES <= B       when "000",   -- LDI
               ADD_RES when "001",   -- ADD
               OR_RES  when "010",   -- OR
               NOT_RES when "011",   -- NOT
               SHR_RES when "100",   -- SHR
               A       when others;  -- not used

    RESULT <= RES;

    -- Zero detect
    ZERO <= '1' when RES = "00000000" else '0';

end Structural;
