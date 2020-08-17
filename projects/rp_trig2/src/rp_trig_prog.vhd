library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rp_trig_prog is
    generic (
      ADDR_WIDTH  : integer := 16;
      DATA_WIDTH  : integer := 64;
      TIME_WIDTH  : integer := 40;
      HEAD_COUNT  : integer := 7;
      DATA_COUNT  : integer := 7
    );
    port (
       clk_in     : in  STD_LOGIC;
       trg_in     : in  STD_LOGIC;
       on_in      : in  STD_LOGIC;
       armed_in   : in  STD_LOGIC;
       clear_in   : in  STD_LOGIC;
       gate_in    : in  STD_LOGIC_VECTOR(7 downto 0);
       invert_in  : in  STD_LOGIC_VECTOR(7 downto 0);
       head_in    : in  STD_LOGIC_VECTOR(HEAD_COUNT*DATA_WIDTH-1 downto 0);
       time_in    : in  UNSIGNED(TIME_WIDTH-1 downto 0);
       mask_in    : in  STD_LOGIC_VECTOR(7 downto 0);
       idle_out   : out STD_LOGIC;
       armed_out  : out STD_LOGIC;
       active_out : out STD_LOGIC;
       index_out  : out UNSIGNED(ADDR_WIDTH-1 downto 0);
       state_out  : out STD_LOGIC_VECTOR(DATA_COUNT*DATA_WIDTH-1 downto 0);
       signal_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end;

architecture Behavioral of rp_trig_prog is
    -- int types
    subtype UINTADDR is UNSIGNED(ADDR_WIDTH-1 downto 0);
    subtype UINTTIME is UNSIGNED(TIME_WIDTH-1 downto 0);

    constant zeroaddr   : UINTADDR  := to_unsigned(0, ADDR_WIDTH);
    constant zerotime   : UINTTIME  := to_unsigned(0, TIME_WIDTH);
    constant oneaddr    : UINTADDR  := to_unsigned(1, ADDR_WIDTH);
    constant onetime    : UINTTIME  := to_unsigned(1, TIME_WIDTH);

    -- states
    type G_STATE_T  is (G_IDLE, G_ARMED, G_WAIT, G_ACTIVE);
    type S_STATE_T  is (S_NEXT, S_HIGH, S_LOW);

    -- channel data
    type STATE_ARR  is array(0 to 7) of S_STATE_T;
    type TIME_ARR   is array(0 to 7) of UINTTIME;

    constant STATE_IDX : integer := 1*DATA_WIDTH;
    constant STATE_SMP : integer := 2*DATA_WIDTH;
    constant STATE_MSK : integer := STATE_SMP+TIME_WIDTH;
    constant STATE_CYC : integer := 3*DATA_WIDTH;
    constant STATE_SEQ : integer := 4*DATA_WIDTH;
    constant STATE_BST : integer := 5*DATA_WIDTH;
    constant STATE_RPT : integer := 6*DATA_WIDTH;
    constant STATE_BIT : integer := 7*DATA_WIDTH;
        
    -- signals
    signal gstate       : G_STATE_T := G_IDLE;

    alias index    is index_out;
    alias sample   is time_in;
    alias mask     is mask_in;

    alias dsignal0  is state_out(0);
    alias dsignal1  is state_out(1);
    alias dsignal2  is state_out(2);
    alias dsignal3  is state_out(3);
    alias didle     is state_out(4);
    alias darmed    is state_out(5);
    alias dactive   is state_out(6);
    alias dclk      is state_out(7);
    
    alias dindex    is state_out(STATE_IDX+ADDR_WIDTH-1 downto STATE_IDX);
    alias dsample   is state_out(STATE_SMP+TIME_WIDTH-1 downto STATE_SMP);
    alias dmask     is state_out(STATE_MSK+7            downto STATE_MSK);
    alias dcycle    is state_out(STATE_CYC+TIME_WIDTH-1 downto STATE_CYC);
    alias dseq      is state_out(STATE_SEQ+TIME_WIDTH-1 downto STATE_SEQ);
    alias dburst    is state_out(STATE_BST+TIME_WIDTH-1 downto STATE_BST);
    alias drepeat   is state_out(STATE_RPT+TIME_WIDTH-1 downto STATE_RPT);
    
    alias dgstate       is state_out(STATE_BIT+ 2-1 downto STATE_BIT);
    alias dwait_for     is state_out(STATE_BIT+ 2);
    alias dclear        is state_out(STATE_BIT+ 3);
    alias dincaddr      is state_out(STATE_BIT+ 4);
    alias drestart      is state_out(STATE_BIT+ 5);
    alias dcheck        is state_out(STATE_BIT+ 6);
    alias derror        is state_out(STATE_BIT+ 7);
    
    alias don           is state_out(STATE_BIT+ 8);
    alias dchecktrigger is state_out(STATE_BIT+ 9);
    alias dwaiting      is state_out(STATE_BIT+10);
    alias drunprogram   is state_out(STATE_BIT+11);
    alias drunprogram1  is state_out(STATE_BIT+12);
    alias drunsequence  is state_out(STATE_BIT+13);
    alias drearm        is state_out(STATE_BIT+14);
    alias dincrement    is state_out(STATE_BIT+15);
    alias dsignals      is state_out(STATE_BIT+DATA_WIDTH-1 downto STATE_BIT+DATA_WIDTH-8);
        
begin
    -- set output
    
    dclk <= clk_in;

    process(clk_in, on_in, armed_in, trg_in, clear_in,
        head_in, time_in, mask_in, gate_in, invert_in,
        gstate)
    is
        type W_WAITFOR_T is (W_CYCLE, W_DELAY);
        constant W_NULL         : W_WAITFOR_T := W_CYCLE;
        variable idl_arm_act    : std_logic_vector(0 to 2);
        variable armed          : std_logic;
        variable active         : std_logic;
             
        variable next_index     : UINTADDR;
        variable invert         : STD_LOGIC_VECTOR(7 downto 0);
        variable gate           : STD_LOGIC_VECTOR(7 downto 0);
        variable signals        : STD_LOGIC_VECTOR(7 downto 0);

        variable delay_total    : UINTTIME;
        variable width_total    : UINTTIME;
        variable period_total   : UINTTIME;
        variable burst_total    : UINTTIME;
        variable cycle_total    : UINTTIME;
        variable repeat_total   : UINTTIME;
        variable index_max      : UINTADDR;

        variable error          : std_logic := '0';
        variable output         : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
        variable seq_count      : UINTTIME := zerotime;
        variable wait_for       : W_WAITFOR_T := W_NULL;
        variable cycle_count    : UINTTIME := zerotime;
        variable period_count   : TIME_ARR := (others => zerotime);
        variable repeat_count   : UINTTIME := zerotime;
        variable burst_count    : UINTTIME := zerotime;
        variable restart        : std_logic := '0';
        variable check          : std_logic;

        procedure rearm
        is
        begin
            drearm <= '1';
            if armed_in = '1'
            then
                next_index := zeroaddr;
                gstate <= G_ARMED;
            else
                gstate <= G_IDLE;
            end if;
        end procedure;
      
        procedure increment(incaddr : boolean)
        is
        begin
            if incaddr
            then
                dincrement <= '1';
                next_index := next_index + 1;
                if next_index >= index_max
                then
                    next_index := zeroaddr;
                    restart := '1';
                end if;
            end if;
            seq_count := seq_count + 1;
            for i in 0 to 7
            loop period_count(i) := period_count(i) + 1;
            end loop;
            cycle_count := cycle_count + 1;
        end procedure;

        procedure run_sequence
        is
        begin
            drunsequence <= '1';
            for i in 0 to 7
            loop
                if gate(i) = '0' and period_count(i) = width_total
                then output(i) := '0';
                end if;
            end loop;
            if restart = '1'
            then increment(false);
            elsif seq_count < sample
            then increment(false);
            elsif seq_count = sample
            then
                for i in 0 to 7
                loop
                    if mask(i) = '1'
                    then
                        output(i) := not gate(i) or not output(i);
                        period_count(i) := zerotime;
                    end if;
                end loop;
                increment(true);
            else error:= '1';
            end if;
        end procedure;

        procedure waiting
        is  variable waitfor : UINTTIME;
        begin
            dwaiting <= '1';
            case wait_for is
                when W_CYCLE =>
                    waitfor := cycle_total;
                when W_DELAY =>
                    waitfor := delay_total;
            end case;
            if cycle_count < waitfor
            then
                gstate <= G_WAIT;
                increment(false);
            else
                burst_count := onetime;
                cycle_count := zerotime;
                seq_count := zerotime;
                restart := '0';
                gstate <= G_ACTIVE;
                run_sequence;
            end if;
        end procedure;
    
        procedure run_program
        is
        begin
            check := restart;
            drunprogram <= '1';
            for i in 0 to 7
            loop
                if gate(i) = '0' and period_count(i) < period_total
                then check := '0';
                end if;
            end loop;
            if check = '1'
            then
                drunprogram1 <= '1';
                restart := '0';
                seq_count := zerotime;
                if burst_count < burst_total
                then
                    burst_count := burst_count + 1;
                    run_sequence;
                elsif repeat_count < repeat_total
                then
                    repeat_count := repeat_count + 1;
                    wait_for := W_CYCLE;
                    waiting;
                else
                    rearm;
                end if;
            else
                run_sequence;
            end if;
        end procedure;
        
        procedure check_trigger
        is
        begin
            dchecktrigger <= '1';
            if trg_in = '1'
            then
                period_count := (others => zerotime);
                repeat_count := onetime;
                cycle_count := zerotime;
                wait_for := W_DELAY;
                waiting;
            end if;
        end procedure;

    begin
        clock : if rising_edge(clk_in)
        then
            if clear_in = '1'
            then
                error := '0';
            end if;
            if error = '0'
            then
                check       := restart;
                invert      := invert_in;
                gate        := gate_in;
                delay_total := unsigned(head_in(0*DATA_WIDTH+TIME_WIDTH-1 downto 0*DATA_WIDTH));
                width_total := unsigned(head_in(1*DATA_WIDTH+TIME_WIDTH-1 downto 1*DATA_WIDTH));
                period_total:= unsigned(head_in(2*DATA_WIDTH+TIME_WIDTH-1 downto 2*DATA_WIDTH));
                burst_total := unsigned(head_in(3*DATA_WIDTH+TIME_WIDTH-1 downto 3*DATA_WIDTH));
                cycle_total := unsigned(head_in(4*DATA_WIDTH+TIME_WIDTH-1 downto 4*DATA_WIDTH));
                repeat_total:= unsigned(head_in(5*DATA_WIDTH+TIME_WIDTH-1 downto 5*DATA_WIDTH));
                index_max   := unsigned(head_in(6*DATA_WIDTH+ADDR_WIDTH-1 downto 6*DATA_WIDTH));
                state_out(STATE_BIT+DATA_WIDTH-1 downto STATE_BIT) <= (others => '0');
                if on_in = '0' or clear_in = '1'
                then
                    next_index := zeroaddr;
                    output := (others => '0');
                    seq_count := zerotime;
                    wait_for := W_NULL;
                    cycle_count := zerotime;
                    period_count := (others => zerotime);
                    repeat_count := zerotime;
                    burst_count := zerotime;
                    restart := '0';
                    gstate <= G_IDLE;
                else
                    don <= '1';
                    case gstate
                    is
                        when G_IDLE     => output := (others => '0'); rearm;
                        when G_ARMED    => output := (others => '0'); check_trigger;
                        when G_WAIT     => waiting;
                        when G_ACTIVE   => run_program;
                    end case;
                end if;
            end if;
            case gstate
            is
                when G_IDLE   => idl_arm_act := "100";
                when G_ARMED  => idl_arm_act := "010";
                when G_WAIT   => idl_arm_act := "000";
                when G_ACTIVE => idl_arm_act := "001";
            end case;
            index   <= next_index;
            didle   <= idl_arm_act(0);
            darmed  <= idl_arm_act(1);
            dactive <= idl_arm_act(2);
            dclear <= clear_in;
            drestart <= restart;
            dcheck <= check;
            derror  <= error;
            dindex  <= STD_LOGIC_VECTOR(next_index);
            dsample <= STD_LOGIC_VECTOR(sample);
            dmask   <= STD_LOGIC_VECTOR(mask);
            dcycle  <= STD_LOGIC_VECTOR(cycle_count);
            dseq    <= STD_LOGIC_VECTOR(seq_count);
            dburst  <= STD_LOGIC_VECTOR(burst_count);
            drepeat <= STD_LOGIC_VECTOR(repeat_count);
            idle_out   <= idl_arm_act(0);
            armed_out  <= idl_arm_act(1);
            active_out <= idl_arm_act(2);
            case wait_for
            is
                when W_DELAY => dwait_for <= '1';
                when W_CYCLE => dwait_for <= '0';
            end case;
            case gstate is
                when G_IDLE     => dgstate <= "00";
                when G_ARMED    => dgstate <= "01";
                when G_WAIT     => dgstate <= "10";
                when G_ACTIVE   => dgstate <= "11";
            end case;
            for i in 0 to 7
            loop signals(i) := output(i) xor invert(i);
            end loop;
            signal_out  <= signals;
            dsignal0    <= signals(0);
            dsignal1    <= signals(1);
            dsignal2    <= signals(2);
            dsignal3    <= signals(3);
            dsignals    <= signals;
        end if clock;
    end process;

end Behavioral;