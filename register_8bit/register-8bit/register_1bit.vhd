
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1bit is
    Port (
        D    : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        Q    : out STD_LOGIC;
        QBAR : out STD_LOGIC
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

begin

    U1: master_slave_dff
        port map (
            D    => D,
            CLK  => CLK,
            Q    => Q,
            QBAR => QBAR
        );

end Structural;
