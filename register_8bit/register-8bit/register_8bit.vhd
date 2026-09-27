
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_8bit is
    Port (
        D    : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(7 downto 0);
        QBAR : out STD_LOGIC_VECTOR(7 downto 0)
    );
end register_8bit;

architecture Structural of register_8bit is

    component register_1bit
        Port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

begin

    REG0: register_1bit
        port map (
            D    => D(0),
            CLK  => CLK,
            Q    => Q(0),
            QBAR => QBAR(0)
        );

    REG1: register_1bit
        port map (
            D    => D(1),
            CLK  => CLK,
            Q    => Q(1),
            QBAR => QBAR(1)
        );

    REG2: register_1bit
        port map (
            D    => D(2),
            CLK  => CLK,
            Q    => Q(2),
            QBAR => QBAR(2)
        );

    REG3: register_1bit
        port map (
            D    => D(3),
            CLK  => CLK,
            Q    => Q(3),
            QBAR => QBAR(3)
        );

    REG4: register_1bit
        port map (
            D    => D(4),
            CLK  => CLK,
            Q    => Q(4),
            QBAR => QBAR(4)
        );

    REG5: register_1bit
        port map (
            D    => D(5),
            CLK  => CLK,
            Q    => Q(5),
            QBAR => QBAR(5)
        );

    REG6: register_1bit
        port map (
            D    => D(6),
            CLK  => CLK,
            Q    => Q(6),
            QBAR => QBAR(6)
        );

    REG7: register_1bit
        port map (
            D    => D(7),
            CLK  => CLK,
            Q    => Q(7),
            QBAR => QBAR(7)
        );

end Structural;
