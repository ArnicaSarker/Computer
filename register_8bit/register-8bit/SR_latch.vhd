
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_latch is
    Port (
        S    : in  STD_LOGIC;
        R    : in  STD_LOGIC;
        Q    : out STD_LOGIC;
        QBAR : out STD_LOGIC
    );
end SR_latch;

architecture Dataflow of SR_latch is

    signal q_int    : STD_LOGIC;
    signal qbar_int : STD_LOGIC;

begin

    q_int    <= R nor qbar_int;
    qbar_int <= S nor q_int;

    Q    <= q_int;
    QBAR <= qbar_int;

end Dataflow;
