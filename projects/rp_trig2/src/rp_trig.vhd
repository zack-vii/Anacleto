library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rp_trig is
    generic (
        BRAM_SIZE   : integer := 45000;
        BRAM_WIDTH  : integer := 48;
        DATA_WIDTH  : integer := 64;
        ADDR_WIDTH  : integer := 16;
        INT_CLK_EXP : integer := 0  -- clk_int_in = (1<<INT_CLK_EXP) * 10MHz
    );
    port (
        clk_axi_in  : in  STD_LOGIC;
        clk_int_in  : in  STD_LOGIC;
        clk_ext_in  : in  STD_LOGIC;
        trg_in      : in  STD_LOGIC;
        trg_out     : out STD_LOGIC;
        clk_int_out : out STD_LOGIC;
        clk_out     : out STD_LOGIC;
        run_out     : out STD_LOGIC;
        state_out   : out STD_LOGIC_VECTOR (7 downto 0);
        signal_out  : out STD_LOGIC_VECTOR (7 downto 0);
        power_down  : out STD_LOGIC;
        -- PortA of blk_mem_gen
        brama_clk   : out  STD_LOGIC;
        brama_rst   : out  STD_LOGIC;
        brama_en    : out  STD_LOGIC;
        brama_addr  : out  STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        brama_dout  : in   STD_LOGIC_VECTOR(BRAM_WIDTH-1 downto 0);
        brama_we    : out  STD_LOGIC;
        brama_din   : out  STD_LOGIC_VECTOR(BRAM_WIDTH-1 downto 0);
        -- PortB of blk_mem_gen
        bramb_clk   : out  STD_LOGIC;
        bramb_rst   : out  STD_LOGIC;
        bramb_en    : out  STD_LOGIC;
        bramb_addr  : out  STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
        bramb_dout  : in   STD_LOGIC_VECTOR(BRAM_WIDTH-1 downto 0);
        -- Ports of Axi Slave Bus Interface S00_AXI
        s00_axi_resetn  : in  std_logic;
        s00_axi_awaddr  : in  std_logic_vector(ADDR_WIDTH+DATA_WIDTH/32 downto 0);
        s00_axi_awprot  : in  std_logic_vector(2 downto 0);
        s00_axi_awvalid : in  std_logic;
        s00_axi_awready : out std_logic;
        s00_axi_wdata   : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        s00_axi_wstrb   : in  std_logic_vector((DATA_WIDTH/8)-1 downto 0);
        s00_axi_wvalid  : in  std_logic;
        s00_axi_wready  : out std_logic;
        s00_axi_bresp   : out std_logic_vector(1 downto 0);
        s00_axi_bvalid  : out std_logic;
        s00_axi_bready  : in  std_logic;
        s00_axi_araddr  : in  std_logic_vector(ADDR_WIDTH+DATA_WIDTH/32 downto 0);
        s00_axi_arprot  : in  std_logic_vector(2 downto 0);
        s00_axi_arvalid : in  std_logic;
        s00_axi_arready : out std_logic;
        s00_axi_rdata   : out std_logic_vector(DATA_WIDTH-1 downto 0);
        s00_axi_rresp   : out std_logic_vector(1 downto 0);
        s00_axi_rvalid  : out std_logic;
        s00_axi_rready  : in  std_logic
    );
end;

architecture arch_imp of rp_trig is
 -- component declaration
    component rp_trig_axi
        generic (
            DATA_WIDTH     : integer;
            ADDR_WIDTH     : integer;
            AXI_ADDR_WIDTH : integer
        );
        port(
            ADDR_OUT      : out UNSIGNED(ADDR_WIDTH-1 downto 0);
            DATA_IN       : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
            DATA_OUT      : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
            STRB_OUT      : out STD_LOGIC_VECTOR((DATA_WIDTH/8)-1 downto 0);
            EN_OUT        : out STD_LOGIC;
            WE_OUT        : out STD_LOGIC;
            -- AXI ports
            S_AXI_CLK     : in  std_logic;
            S_AXI_RESETN  : in  std_logic;
            S_AXI_AWADDR  : in  std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_AWPROT  : in  std_logic_vector(2 downto 0);
            S_AXI_AWVALID : in  std_logic;
            S_AXI_AWREADY : out std_logic;
            S_AXI_WDATA   : in  std_logic_vector(DATA_WIDTH-1 downto 0);
            S_AXI_WSTRB   : in  std_logic_vector((DATA_WIDTH/8)-1 downto 0);
            S_AXI_WVALID  : in  std_logic;
            S_AXI_WREADY  : out std_logic;
            S_AXI_BRESP   : out std_logic_vector(1 downto 0);
            S_AXI_BVALID  : out std_logic;
            S_AXI_BREADY  : in  std_logic;
            S_AXI_ARADDR  : in  std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_ARPROT  : in  std_logic_vector(2 downto 0);
            S_AXI_ARVALID : in  std_logic;
            S_AXI_ARREADY : out std_logic;
            S_AXI_RDATA   : out std_logic_vector(DATA_WIDTH-1 downto 0);
            S_AXI_RRESP   : out std_logic_vector(1 downto 0);
            S_AXI_RVALID  : out std_logic;
            S_AXI_RREADY  : in  std_logic
        );
    end component;

    component rp_trig_prog
        generic(
            ADDR_WIDTH  : integer;
            DATA_WIDTH  : integer;
            TIME_WIDTH  : integer;
            HEAD_COUNT  : integer;
            DATA_COUNT  : integer
        );
        port(
            clk_axi_in  : in    STD_LOGIC;
            clk_in      : in    STD_LOGIC;
            trg_in      : in    STD_LOGIC;
            time_in     : in    UNSIGNED(TIME_WIDTH-1 downto 0);
            mask_in     : in    STD_LOGIC_VECTOR(7 downto 0);
            ctrl_in     : in    STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
            head_in     : in    STD_LOGIC_VECTOR(HEAD_COUNT*DATA_WIDTH-1 downto 0);
            idl_out     : out   STD_LOGIC;
            arm_out     : out   STD_LOGIC;
            run_out     : out   STD_LOGIC;
            index_out   : out   UNSIGNED(ADDR_WIDTH-1 downto 0);
            state_out   : out   STD_LOGIC_VECTOR(DATA_COUNT*DATA_WIDTH-1 downto 0);
            signal_out  : out   STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    constant STAT_COUNT: integer := 8;
    constant CTRL_COUNT: integer := 1;
    constant HEAD_COUNT: integer := 7;
    constant STAT_MIN  : integer := 0;
    constant STAT_MAX  : integer := STAT_COUNT;
    constant CTRL_MIN  : integer := STAT_MAX;
    constant CTRL_MAX  : integer := CTRL_MIN+CTRL_COUNT;
    constant HEAD_MIN  : integer := CTRL_MAX;
    constant HEAD_MAX  : integer := HEAD_MIN+HEAD_COUNT;

    constant STAT_BASE : integer := STAT_MIN*DATA_WIDTH;
    constant STAT_HEAD : integer := STAT_MAX*DATA_WIDTH-1;
    constant CTRL_BASE : integer := CTRL_MIN*DATA_WIDTH;
    constant CTRL_HEAD : integer := CTRL_MAX*DATA_WIDTH-1;
    constant HEAD_BASE : integer := HEAD_MIN*DATA_WIDTH;
    constant HEAD_HEAD : integer := HEAD_MAX*DATA_WIDTH-1;
    constant offset    : unsigned(ADDR_WIDTH-1 downto 0) := to_unsigned(HEAD_MAX, ADDR_WIDTH);

    function addr2base(addr : unsigned) return integer
    is begin return to_integer(addr)*DATA_WIDTH;
    end addr2base;

    signal m_addr   : unsigned(ADDR_WIDTH-1 downto 0);
    signal m_rdata  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal m_wdata  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal m_strb   : std_logic_vector((DATA_WIDTH/8)-1 downto 0);
    signal s_addr   : unsigned(ADDR_WIDTH-1 downto 0);

    signal time_buf : unsigned(BRAM_WIDTH-9 downto 0);
    signal mask_buf : std_logic_vector(7 downto 0);

    signal signals  : std_logic_vector(7 downto 0);
    signal state    : std_logic_vector(STAT_COUNT*DATA_WIDTH-1 downto 0);
    signal head_save: std_logic_vector(HEAD_COUNT*DATA_WIDTH-1 downto 0) := (others => '0');

    signal clkbuf   : std_logic_vector(-INT_CLK_EXP to 31) := (others => '0');

    signal clk_div  : integer range 0 to 31;
    signal clk_sel  : boolean;
    signal clk      : std_logic;
    signal trg      : std_logic;

    signal data_buf : std_logic_vector(HEAD_HEAD               downto 0) := (others => '0');
    alias  state_buf: std_logic_vector(STAT_COUNT*DATA_WIDTH-1 downto 0) is data_buf(STAT_HEAD downto STAT_BASE);
    alias  ctrl_buf : std_logic_vector(CTRL_COUNT*DATA_WIDTH-1 downto 0) is data_buf(CTRL_HEAD downto CTRL_BASE);
    alias  head_buf : std_logic_vector(HEAD_COUNT*DATA_WIDTH-1 downto 0) is data_buf(HEAD_HEAD downto HEAD_BASE);
    signal brama_dout_buf : std_logic_vector(BRAM_WIDTH-1 downto 0);
    signal idl      : std_logic;
    signal arm      : std_logic;
    signal run      : std_logic;
    
    alias  cc_init  : std_logic_vector(7 downto 0) is ctrl_buf(0*8+7 downto 0*8);
    alias  cc_trig  : std_logic_vector(7 downto 0) is ctrl_buf(1*8+7 downto 1*8);
    alias  cc_clear : std_logic_vector(7 downto 0) is ctrl_buf(2*8+7 downto 2*8);
    alias  cc_save  : std_logic_vector(7 downto 0) is ctrl_buf(3*8+7 downto 3*8);
    alias  cc_clksrc: std_logic_vector(7 downto 0) is ctrl_buf(4*8+7 downto 4*8);
    alias  cc_invert: std_logic_vector(7 downto 0) is ctrl_buf(5*8+7 downto 5*8);
    alias  cc_gate  : std_logic_vector(7 downto 0) is ctrl_buf(6*8+7 downto 6*8);
    alias  cc_debug : std_logic_vector(7 downto 0) is ctrl_buf(7*8+7 downto 7*8);
    alias  c_on     : std_logic is cc_init(0);
    alias  c_arm    : std_logic is cc_init(1);
    alias  c_rearm  : std_logic is cc_init(2);
    alias  c_reinit : std_logic is cc_init(3);
    alias  c_trig   : std_logic is cc_trig(0);
    alias  c_clear  : std_logic is cc_clear(0);
    alias  c_save   : std_logic is cc_save(0);
    alias  c_extclk : std_logic is cc_clksrc(0);
    alias  c_trgsync: std_logic is cc_clksrc(1);
    alias  c_intclk : std_logic is cc_clksrc(2);
begin
    clock_divider : for i in -INT_CLK_EXP to 30
    generate
        process(clkbuf)
        begin
            if rising_edge(clkbuf(i))
            then clkbuf(i+1) <= not clkbuf(i+1);
            end if;
        end process;
    end generate;
    clkbuf(-INT_CLK_EXP) <= clk_int_in;

    clock : process(clk_axi_in, clk_ext_in, c_extclk, clk_int_in)
        variable clock : std_logic;
    begin
        if rising_edge(clk_axi_in)
        then
            if c_extclk = '1'
            then clk <= clk_ext_in;
            else clk <= clkbuf(to_integer(unsigned(cc_debug)));
            end if;
        end if;
    end process;

    trg <= c_trig or trg_in;

    clk_int_out <= clkbuf(0);
    clk_out <= state(7);
    trg_out <= trg; --state(6);
    run_out <= run;
    state_out <= state(7 downto 0);
    signal_out <= signals;

    power_down <= c_extclk and not c_intclk;
    ---- BRAM
    brama_clk <= clk_axi_in;
    brama_rst <= '0';
--  brama_we <= axi_s00::WE;
    brama_addr <= std_logic_vector(m_addr-offset);

    bram_update : process(clk_axi_in, m_strb, m_wdata, brama_dout)
    begin
        if rising_edge(clk_axi_in)
        then
            brama_dout_buf <= brama_dout;
            for i in 0 to BRAM_WIDTH/8-1
            loop
                if m_strb(i) = '1'
                then brama_din(i*8+7 downto i*8) <= m_wdata(i*8+7 downto i*8);
                else brama_din(i*8+7 downto i*8) <= brama_dout_buf(i*8+7 downto i*8);
                end if;
            end loop;
        end if;
    end process;

    process(m_addr, brama_dout, data_buf)
    begin
        if m_addr < offset
        then
            m_rdata <= data_buf(addr2base(m_addr)+DATA_WIDTH-1 downto addr2base(m_addr));
        else
            m_rdata(BRAM_WIDTH-1 downto 0         ) <=  brama_dout;
            m_rdata(DATA_WIDTH-1 downto BRAM_WIDTH) <= (others => '0');
        end if;
    end process;
    -- b channel
    bramb_clk <= clk_axi_in;
    bramb_rst <= '0';
    bramb_en <= '1';
    bramb_addr <= std_logic_vector(s_addr);
    
    process(clk_axi_in, m_addr, m_strb, m_wdata, head_save, data_buf, state)
    begin
        if rising_edge(clk_axi_in)
        then
            if m_addr < offset
            then
                for i in 0 to DATA_WIDTH/8-1
                loop
                    if m_strb(i) = '1' then
                        data_buf(addr2base(m_addr)+i*8+7 downto addr2base(m_addr)+i*8) <= m_wdata(i*8+7 downto i*8);
                    end if;
                end loop;
            end if;
            state_buf <= state;
            if arm = '0'
            then
                if trg = '1' and c_rearm ='0'
                then c_arm <= '0';
                end if;
                cc_trig <= (others => '0');
                if c_arm = '0' and idl = '1'
                then c_on <= '0';
                end if;
            elsif c_reinit = '1'
            then head_buf <= head_save;
            end if;
            if idl = '1'
            then cc_clear <= (others => '0');
            end if;
            if c_save = '1'
            then
                head_save <= head_buf;
                cc_save <= (others => '0');
            end if;
        end if;
    end process;

    time_buf <= unsigned(bramb_dout(BRAM_WIDTH-8-1 downto 0));
    mask_buf <= bramb_dout(BRAM_WIDTH-1 downto BRAM_WIDTH-8);

---- Instantiation of Axi Bus Interface S00_AXI
    axi : rp_trig_axi
        generic map (
            DATA_WIDTH     => DATA_WIDTH,
            ADDR_WIDTH     => ADDR_WIDTH,
            AXI_ADDR_WIDTH => ADDR_WIDTH+DATA_WIDTH/32+1
        )
        port map (
            ADDR_OUT      => m_addr,
            DATA_IN       => m_rdata,
            DATA_OUT      => m_wdata,
            STRB_OUT      => m_strb,
            WE_OUT        => brama_we,
            EN_OUT        => brama_en,
            S_AXI_CLK     => clk_axi_in,
            S_AXI_RESETN  => s00_axi_resetn,
            S_AXI_AWADDR  => s00_axi_awaddr,
            S_AXI_AWPROT  => s00_axi_awprot,
            S_AXI_AWVALID => s00_axi_awvalid,
            S_AXI_AWREADY => s00_axi_awready,
            S_AXI_WDATA   => s00_axi_wdata,
            S_AXI_WSTRB   => s00_axi_wstrb,
            S_AXI_WVALID  => s00_axi_wvalid,
            S_AXI_WREADY  => s00_axi_wready,
            S_AXI_BRESP   => s00_axi_bresp,
            S_AXI_BVALID  => s00_axi_bvalid,
            S_AXI_BREADY  => s00_axi_bready,
            S_AXI_ARADDR  => s00_axi_araddr,
            S_AXI_ARPROT  => s00_axi_arprot,
            S_AXI_ARVALID => s00_axi_arvalid,
            S_AXI_ARREADY => s00_axi_arready,
            S_AXI_RDATA   => s00_axi_rdata,
            S_AXI_RRESP   => s00_axi_rresp,
            S_AXI_RVALID  => s00_axi_rvalid,
            S_AXI_RREADY  => s00_axi_rready
        );

---- Instantiation of main program
    prog : rp_trig_prog
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            TIME_WIDTH => BRAM_WIDTH-8,
            ADDR_WIDTH => ADDR_WIDTH,
            HEAD_COUNT => HEAD_COUNT,
            DATA_COUNT => STAT_COUNT
        )
        port map (
            clk_axi_in  => clk_axi_in,
            clk_in      => clk,
            trg_in      => trg,
            time_in     => time_buf,
            mask_in     => mask_buf,
            ctrl_in     => ctrl_buf,
            head_in     => head_buf,
            idl_out     => idl,
            arm_out     => arm,
            run_out     => run,
            index_out   => s_addr,
            state_out   => state,
            signal_out  => signals
        );
end arch_imp;
