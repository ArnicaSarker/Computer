-- Master-slave D flip-flop made from two D latches.
-- Master is open while CLK = 0, slave is open while CLK = 1,
-- so Q changes only at the RISING edge of CLK.
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

    signal M     : STD_LOGIC;
    signal MBAR  : STD_LOGIC;
    signal CLK_N : STD_LOGIC;

begin

    -- Inverted clock for the master latch
    CLK_N <= not CLK;

    -- Master latch: takes D while CLK = 0
    MASTER: D_latch
        port map (
            D    => D,
            EN   => CLK_N,
            Q    => M,
            QBAR => MBAR
        );

    -- Slave latch: passes M to Q while CLK = 1
    SLAVE: D_latch
        port map (
            D    => M,
            EN   => CLK,
            Q    => Q,
            QBAR => QBAR
        );

end Structural;
