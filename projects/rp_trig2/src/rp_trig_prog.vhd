library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rp_trig_prog is
    generic (
      ADDR_WIDTH  : integer := 16;
      DATA_WIDTH  : integer := 64;
      TIME_WIDTH  : integer := 40;
      HEAD_COUNT  : integer := 7;
      DATA_COUNT  : integer := 8
    );
    port (
       clk_axi_in : in      STD_LOGIC;
       clk_in     : in      STD_LOGIC;
       trg_in     : in      STD_LOGIC;
       time_in    : in      UNSIGNED(TIME_WIDTH-1 downto 0);
       mask_in    : in      STD_LOGIC_VECTOR(7 downto 0);
       ctrl_in    : in      STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
       head_in    : in      STD_LOGIC_VECTOR(HEAD_COUNT*DATA_WIDTH-1 downto 0);
       idl_out    : out     STD_LOGIC;
       arm_out    : out     STD_LOGIC;
       run_out    : out     STD_LOGIC;
       index_out  : out     UNSIGNED(ADDR_WIDTH-1 downto 0);
       state_out  : out     STD_LOGIC_VECTOR(DATA_COUNT*DATA_WIDTH-1 downto 0);
       signal_out : out     STD_LOGIC_VECTOR(7 downto 0)
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
    constant G_IDL      : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant G_ARM      : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant G_WAI      : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant G_RUN      : STD_LOGIC_VECTOR(1 downto 0) := "11";
    -- states
    
    type S_STATE_T  is (S_NEXT, S_HIGH, S_LOW);

    -- channel data
    type STATE_ARR  is array(0 to 7) of S_STATE_T;
    type TIME_ARR   is array(0 to 7) of UINTTIME;

    constant STATE_IDX : integer := 1*DATA_WIDTH;
    constant STATE_SMP : integer := 2*DATA_WIDTH;
    constant STATE_MSK : integer := STATE_SMP+TIME_WIDTH;
    constant STATE_CYC : integer := 3*DATA_WIDTH;
    constant STATE_SEQ : integer := 4*DATA_WIDTH;
    constant STATE_BST  : integer := 5*DATA_WIDTH;
    constant STATE_RPT  : integer := 6*DATA_WIDTH;
    constant STATE_BIT  : integer := 7*DATA_WIDTH;

    -- signals
    signal index_buf    : UINTADDR;
    signal time_buf     : UINTTIME;
    signal mask_buf     : STD_LOGIC_VECTOR(7 downto 0);

    signal delay_total  : UINTTIME;
    signal width_total  : UINTTIME;
    signal period_total : UINTTIME;
    signal burst_total  : UINTTIME;
    signal cycle_total  : UINTTIME;
    signal repeat_total : UINTTIME;
    signal index_max    : UINTADDR;

    --signal ctrl_buf     : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal head_buf     : STD_LOGIC_VECTOR(HEAD_COUNT*DATA_WIDTH-1 downto 0);
    signal gstate       : STD_LOGIC_VECTOR(1 downto 0) := G_IDL;
    
    alias index         is index_buf;
    alias sample        is time_buf;
    alias mask          is mask_buf;

    alias  cc_init      : std_logic_vector(7 downto 0) is ctrl_in(0*8+7 downto 0*8);
    alias  cc_trig      : std_logic_vector(7 downto 0) is ctrl_in(1*8+7 downto 1*8);
    alias  cc_clear     : std_logic_vector(7 downto 0) is ctrl_in(2*8+7 downto 2*8);
    alias  cc_save      : std_logic_vector(7 downto 0) is ctrl_in(3*8+7 downto 3*8);
    alias  cc_clksrc    : std_logic_vector(7 downto 0) is ctrl_in(4*8+7 downto 4*8);
    alias  cc_invert    : std_logic_vector(7 downto 0) is ctrl_in(5*8+7 downto 5*8);
    alias  cc_gate      : std_logic_vector(7 downto 0) is ctrl_in(6*8+7 downto 6*8);
    alias  cc_debug     : std_logic_vector(7 downto 0) is ctrl_in(7*8+7 downto 7*8);
    alias  c_on         : std_logic is cc_init(0);
    alias  c_arm        : std_logic is cc_init(1);
    alias  c_rearm      : std_logic is cc_init(2);
    alias  c_reinit     : std_logic is cc_init(3);
    alias  c_trig       : std_logic is cc_trig(0);
    alias  c_clear      : std_logic is cc_clear(0);
    alias  c_save       : std_logic is cc_save(0);
    alias  c_extclk     : std_logic is cc_clksrc(0);
    alias  c_trgsync    : std_logic is cc_clksrc(1);
    
    signal clk          : std_logic := '0';
    signal clk_s        : std_logic := '0';
    signal clk_r        : std_logic := '0';
begin

      
    process(clk_axi_in, clk_in, trg_in)
    is
        variable delay      : unsigned(22 downto 0) := (others => '0');
        variable high       : unsigned(22 downto 0) := (others => '0');
        variable width      : unsigned(22 downto 0) := (others => '0');
        variable clk_buf    : std_logic := '0';
        variable trg_buf    : std_logic := '0';
    begin
        if rising_edge(clk_axi_in)
        then
            if (clk_in and not clk_buf) = '1'
            then
                if high < delay + width
                then delay := (others => '0');
                end if;
                high := (others => '0');
            else
                high := high + 1;
                if (not clk_in and clk_buf) = '1'
                then width := high;
                end if;
            end if;
            if trg_in = '1' and gstate = G_ARM
            then
                if clk_in = '1'
                then delay := high;
                else delay := high - width;
                end if;
                clk_s <= '1';
            else
                if (high = delay) or (high = delay + width)
                then
                    clk_s <= not clk_s;
                else
                    clk_s <= clk_s;
                end if;
            end if;
            trg_buf := trg_in;
            clk_buf := clk_in;
        end if;
    end process;
    clk <= clk_s when c_trgsync = '1' else clk_in;

    process(clk_axi_in)
    is
    begin
        if rising_edge(clk_axi_in)
        then
            index_out   <= index_buf;
            head_buf    <= head_in;
            time_buf    <= time_in;
            mask_buf    <= mask_in;
            delay_total <= unsigned(head_buf(0*DATA_WIDTH+TIME_WIDTH-1 downto 0*DATA_WIDTH));
            width_total <= unsigned(head_buf(1*DATA_WIDTH+TIME_WIDTH-1 downto 1*DATA_WIDTH));
            period_total<= unsigned(head_buf(2*DATA_WIDTH+TIME_WIDTH-1 downto 2*DATA_WIDTH));
            burst_total <= unsigned(head_buf(3*DATA_WIDTH+TIME_WIDTH-1 downto 3*DATA_WIDTH));
            cycle_total <= unsigned(head_buf(4*DATA_WIDTH+TIME_WIDTH-1 downto 4*DATA_WIDTH));
            repeat_total<= unsigned(head_buf(5*DATA_WIDTH+TIME_WIDTH-1 downto 5*DATA_WIDTH));
            index_max   <= unsigned(head_buf(6*DATA_WIDTH+ADDR_WIDTH-1 downto 6*DATA_WIDTH));
        end if;
    end process;

    process(clk_axi_in, clk, trg_in)
    is
        type W_WAITFOR_T is (W_CYCLE, W_DELAY);
        constant W_NULL         : W_WAITFOR_T := W_CYCLE;
        variable idl_arm_run    : std_logic_vector(0 to 2);

        variable next_index     : UINTADDR;
        variable invert         : STD_LOGIC_VECTOR(7 downto 0);
        variable gate           : STD_LOGIC_VECTOR(7 downto 0);
        variable signals        : STD_LOGIC_VECTOR(7 downto 0);

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

        variable state          : STD_LOGIC_VECTOR(DATA_COUNT*DATA_WIDTH-1 downto 0);

        alias dsignal0      is state(0);
        alias dsignal1      is state(1);
        alias dsignal2      is state(2);
        alias didl          is state(3);
        alias darm          is state(4);
        alias drun          is state(5);
        alias dtrg          is state(6);
        alias dclk          is state(7);
    
        alias dindex        is state(STATE_IDX+ADDR_WIDTH-1 downto STATE_IDX);
        alias dsample       is state(STATE_SMP+TIME_WIDTH-1 downto STATE_SMP);
        alias dmask         is state(STATE_MSK+7            downto STATE_MSK);
        alias dcycle        is state(STATE_CYC+TIME_WIDTH-1 downto STATE_CYC);
        alias dseq          is state(STATE_SEQ+TIME_WIDTH-1 downto STATE_SEQ);
        alias dburst        is state(STATE_BST+TIME_WIDTH-1 downto STATE_BST);
        alias drepeat       is state(STATE_RPT+TIME_WIDTH-1 downto STATE_RPT);
    
        alias dgstate       is state(STATE_BIT+ 2-1 downto STATE_BIT);
        alias dwait_for     is state(STATE_BIT+ 2);
        alias dclear        is state(STATE_BIT+ 3);
        alias dincaddr      is state(STATE_BIT+ 4);
        alias drestart      is state(STATE_BIT+ 5);
        alias dcheck        is state(STATE_BIT+ 6);
        alias derror        is state(STATE_BIT+ 7);
    
        alias don           is state(STATE_BIT+ 8);
        alias dchecktrigger is state(STATE_BIT+ 9);
        alias dwaiting      is state(STATE_BIT+10);
        alias drunprogram   is state(STATE_BIT+11);
        alias drunprogram1  is state(STATE_BIT+12);
        alias drunsequence  is state(STATE_BIT+13);
        alias drearm        is state(STATE_BIT+14);
        alias dincrement    is state(STATE_BIT+15);
        alias dsignals      is state(STATE_BIT+DATA_WIDTH-1 downto STATE_BIT+DATA_WIDTH-8);

        procedure rearm
        is
        begin
            next_index := zeroaddr;
            if c_arm = '1'
            then gstate <= G_ARM;
            else gstate <= G_IDL;
            end if;
        end procedure;

        procedure increment(incaddr : boolean)
        is
        begin
            if incaddr
            then
                dincrement := '1';
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
            drunsequence := '1';
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
            dwaiting := '1';
            case wait_for is
                when W_CYCLE =>
                    waitfor := cycle_total;
                when W_DELAY =>
                    waitfor := delay_total;
            end case;
            if cycle_count < waitfor
            then
                gstate <= G_WAI;
                increment(false);
            else
                burst_count := onetime;
                cycle_count := zerotime;
                seq_count := zerotime;
                restart := '0';
                gstate <= G_RUN;
                run_sequence;
            end if;
        end procedure;

        procedure run_program
        is
        begin
            check := restart;
            drunprogram := '1';
            for i in 0 to 7
            loop
                if gate(i) = '0' and period_count(i) < period_total
                then check := '0';
                end if;
            end loop;
            if check = '1'
            then
                drunprogram1 := '1';
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
                    drearm := '1';
                    rearm;
                end if;
            else
                run_sequence;
            end if;
        end procedure;

        procedure check_trigger
        is
        begin
            dchecktrigger := '1';
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
        if rising_edge(clk_axi_in)
        then
            if c_clear = '1'
            then error := '0';
            end if;
            if error = '0'
            then
                check  := restart;
                invert := cc_invert;
                gate   := cc_gate;
                if (not c_on or c_clear) = '1'
                then
                    next_index  := zeroaddr;
                    output      := (others => '0');
                    seq_count   := zerotime;
                    wait_for    := W_NULL;
                    cycle_count := zerotime;
                    period_count:= (others => zerotime);
                    repeat_count:= zerotime;
                    burst_count := zerotime;
                    restart     := '0';
                    gstate      <= G_IDL;
                end if;
               
                if ((clk and not clk_r) or (not gstate(1) and trg_in)) = '1'
                then
                    clk_r <= '1';
                    state(STATE_BIT+DATA_WIDTH-1 downto STATE_BIT) := (others => '0');
                    don := '1';
                    if gstate(1) = '0'
                    then output := (others => '0');
                    end if;
                    case gstate
                    is
                    when G_IDL  =>  rearm;
                    when G_ARM  =>  check_trigger;
                    when G_WAI  =>  waiting;
                    when G_RUN  =>  run_program;
                    end case;
                else
                    clk_r <= clk;
                end if;
                for i in 0 to 7
                loop signals(i) := output(i) xor invert(i);
                end loop;
                case gstate
                is
                    when G_IDL  => idl_arm_run := "100";
                    when G_ARM  => idl_arm_run := "010";
                    when G_WAI  => idl_arm_run := "000";
                    when G_RUN  => idl_arm_run := "001";
                end case;
                case wait_for
                is
                    when W_DELAY    => dwait_for := '1';
                    when W_CYCLE    => dwait_for := '0';
                end case;
                dgstate     := gstate;
                didl        := idl_arm_run(0);
                darm        := idl_arm_run(1);
                drun        := idl_arm_run(2);
                dclear      := c_clear;
                drestart    := restart;
                dcheck      := check;
                derror      := error;
                dindex      := STD_LOGIC_VECTOR(next_index);
                dsample     := STD_LOGIC_VECTOR(sample);
                dmask       := STD_LOGIC_VECTOR(mask);
                dcycle      := STD_LOGIC_VECTOR(cycle_count);
                dseq        := STD_LOGIC_VECTOR(seq_count);
                dburst      := STD_LOGIC_VECTOR(burst_count);
                drepeat     := STD_LOGIC_VECTOR(repeat_count);
                dsignal0    := signals(0);
                dsignal1    := signals(1);
                dsignal2    := signals(2);
                dsignals    := signals;
            end if;
            dtrg        := trg_in;
            dclk        := clk;
            index       <= next_index;
            idl_out     <= idl_arm_run(0);
            arm_out     <= idl_arm_run(1);
            run_out     <= idl_arm_run(2);
            state_out   <= state;
            signal_out  <= signals;
        end if;
    end process;

end Behavioral;