
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_latch is
    Port (
        D     : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        Q     : out STD_LOGIC;
        QBAR  : out STD_LOGIC
    );
end D_latch;

architecture Structural of D_latch is

    component SR_latch
        Port (
            S    : in  STD_LOGIC;
            R    : in  STD_LOGIC;
            Q    : out STD_LOGIC;
            QBAR : out STD_LOGIC
        );
    end component;

    signal S_int : STD_LOGIC;
    signal R_int : STD_LOGIC;

begin

    -- Generate S and R inputs from D and Enable
    S_int <= D and EN;
    R_int <= (not D) and EN;

    -- Instantiate SR latch
    U1: SR_latch
        port map (
            S    => S_int,
            R    => R_int,
            Q    => Q,
            QBAR => QBAR
        );

end Structural;
