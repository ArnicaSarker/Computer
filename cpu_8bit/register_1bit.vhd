-- 1-bit register: master-slave D flip-flop with load enable and
-- synchronous active-high reset (reset value 0).
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit is
    Port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        Q     : out STD_LOGIC;
        QBAR  : out STD_LOGIC
    );
end register_1bit;

architecture Structural of register_1bit is

    component master_slave_dff
        Port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal D_IN  : STD_LOGIC;
    signal Q_INT : STD_LOGIC;

begin

    -- Input select: RESET -> 0, EN = 1 -> new D, EN = 0 -> keep old Q
    D_IN <= '0'   when RESET = '1' else
            D     when EN = '1'    else
            Q_INT;

    U1: master_slave_dff
        port map (
            D    => D_IN,
            CLK  => CLK,
            Q    => Q_INT,
            QBAR => QBAR
        );

    Q <= Q_INT;

end Structural;
