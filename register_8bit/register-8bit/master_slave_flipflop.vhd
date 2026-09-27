
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_slave_dff is
    Port (
        D    : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        Q    : out STD_LOGIC;
        QBAR : out STD_LOGIC
    );
end master_slave_dff;

architecture Structural of master_slave_dff is

    component D_latch
        Port (
            D    : in  STD_LOGIC;
            EN   : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal M    : STD_LOGIC;
    signal MBAR : STD_LOGIC;
    signal CLK_N : STD_LOGIC;

begin

    -- Invert clock for slave latch
    CLK_N <= not CLK;

    -- Master latch
    MASTER: D_latch
        port map (
            D    => D,
            EN   => CLK,
            Q    => M,
            QBAR => MBAR
        );

    -- Slave latch
    SLAVE: D_latch
        port map (
            D    => M,
            EN   => CLK_N,
            Q    => Q,
            QBAR => QBAR
        );

end Structural;
