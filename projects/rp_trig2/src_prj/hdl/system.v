//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
//Date        : Thu Aug 20 13:56:35 2020
//Host        : mds-data-2 running 64-bit unknown
//Command     : generate_target system.bd
//Design      : system
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module s00_couplers_imp_1XH0AG
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wid,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [63:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [63:0]M_AXI_wdata;
  input M_AXI_wready;
  output [7:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [11:0]S_AXI_arid;
  input [3:0]S_AXI_arlen;
  input [1:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [11:0]S_AXI_awid;
  input [3:0]S_AXI_awlen;
  input [1:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [11:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output [11:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input [11:0]S_AXI_wid;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire M_ARESETN_1;
  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [31:0]auto_pc_to_auto_rs_ARADDR;
  wire [2:0]auto_pc_to_auto_rs_ARPROT;
  wire auto_pc_to_auto_rs_ARREADY;
  wire auto_pc_to_auto_rs_ARVALID;
  wire [31:0]auto_pc_to_auto_rs_AWADDR;
  wire [2:0]auto_pc_to_auto_rs_AWPROT;
  wire auto_pc_to_auto_rs_AWREADY;
  wire auto_pc_to_auto_rs_AWVALID;
  wire auto_pc_to_auto_rs_BREADY;
  wire [1:0]auto_pc_to_auto_rs_BRESP;
  wire auto_pc_to_auto_rs_BVALID;
  wire [31:0]auto_pc_to_auto_rs_RDATA;
  wire auto_pc_to_auto_rs_RREADY;
  wire [1:0]auto_pc_to_auto_rs_RRESP;
  wire auto_pc_to_auto_rs_RVALID;
  wire [31:0]auto_pc_to_auto_rs_WDATA;
  wire auto_pc_to_auto_rs_WREADY;
  wire [3:0]auto_pc_to_auto_rs_WSTRB;
  wire auto_pc_to_auto_rs_WVALID;
  wire [31:0]auto_rs_to_auto_us_ARADDR;
  wire [2:0]auto_rs_to_auto_us_ARPROT;
  wire auto_rs_to_auto_us_ARREADY;
  wire auto_rs_to_auto_us_ARVALID;
  wire [31:0]auto_rs_to_auto_us_AWADDR;
  wire [2:0]auto_rs_to_auto_us_AWPROT;
  wire auto_rs_to_auto_us_AWREADY;
  wire auto_rs_to_auto_us_AWVALID;
  wire auto_rs_to_auto_us_BREADY;
  wire [1:0]auto_rs_to_auto_us_BRESP;
  wire auto_rs_to_auto_us_BVALID;
  wire [31:0]auto_rs_to_auto_us_RDATA;
  wire auto_rs_to_auto_us_RREADY;
  wire [1:0]auto_rs_to_auto_us_RRESP;
  wire auto_rs_to_auto_us_RVALID;
  wire [31:0]auto_rs_to_auto_us_WDATA;
  wire auto_rs_to_auto_us_WREADY;
  wire [3:0]auto_rs_to_auto_us_WSTRB;
  wire auto_rs_to_auto_us_WVALID;
  wire [31:0]auto_us_to_s00_data_fifo_ARADDR;
  wire [2:0]auto_us_to_s00_data_fifo_ARPROT;
  wire auto_us_to_s00_data_fifo_ARREADY;
  wire auto_us_to_s00_data_fifo_ARVALID;
  wire [31:0]auto_us_to_s00_data_fifo_AWADDR;
  wire [2:0]auto_us_to_s00_data_fifo_AWPROT;
  wire auto_us_to_s00_data_fifo_AWREADY;
  wire auto_us_to_s00_data_fifo_AWVALID;
  wire auto_us_to_s00_data_fifo_BREADY;
  wire [1:0]auto_us_to_s00_data_fifo_BRESP;
  wire auto_us_to_s00_data_fifo_BVALID;
  wire [63:0]auto_us_to_s00_data_fifo_RDATA;
  wire auto_us_to_s00_data_fifo_RREADY;
  wire [1:0]auto_us_to_s00_data_fifo_RRESP;
  wire auto_us_to_s00_data_fifo_RVALID;
  wire [63:0]auto_us_to_s00_data_fifo_WDATA;
  wire auto_us_to_s00_data_fifo_WREADY;
  wire [7:0]auto_us_to_s00_data_fifo_WSTRB;
  wire auto_us_to_s00_data_fifo_WVALID;
  wire [31:0]s00_couplers_to_auto_pc_ARADDR;
  wire [1:0]s00_couplers_to_auto_pc_ARBURST;
  wire [3:0]s00_couplers_to_auto_pc_ARCACHE;
  wire [11:0]s00_couplers_to_auto_pc_ARID;
  wire [3:0]s00_couplers_to_auto_pc_ARLEN;
  wire [1:0]s00_couplers_to_auto_pc_ARLOCK;
  wire [2:0]s00_couplers_to_auto_pc_ARPROT;
  wire [3:0]s00_couplers_to_auto_pc_ARQOS;
  wire s00_couplers_to_auto_pc_ARREADY;
  wire [2:0]s00_couplers_to_auto_pc_ARSIZE;
  wire s00_couplers_to_auto_pc_ARVALID;
  wire [31:0]s00_couplers_to_auto_pc_AWADDR;
  wire [1:0]s00_couplers_to_auto_pc_AWBURST;
  wire [3:0]s00_couplers_to_auto_pc_AWCACHE;
  wire [11:0]s00_couplers_to_auto_pc_AWID;
  wire [3:0]s00_couplers_to_auto_pc_AWLEN;
  wire [1:0]s00_couplers_to_auto_pc_AWLOCK;
  wire [2:0]s00_couplers_to_auto_pc_AWPROT;
  wire [3:0]s00_couplers_to_auto_pc_AWQOS;
  wire s00_couplers_to_auto_pc_AWREADY;
  wire [2:0]s00_couplers_to_auto_pc_AWSIZE;
  wire s00_couplers_to_auto_pc_AWVALID;
  wire [11:0]s00_couplers_to_auto_pc_BID;
  wire s00_couplers_to_auto_pc_BREADY;
  wire [1:0]s00_couplers_to_auto_pc_BRESP;
  wire s00_couplers_to_auto_pc_BVALID;
  wire [31:0]s00_couplers_to_auto_pc_RDATA;
  wire [11:0]s00_couplers_to_auto_pc_RID;
  wire s00_couplers_to_auto_pc_RLAST;
  wire s00_couplers_to_auto_pc_RREADY;
  wire [1:0]s00_couplers_to_auto_pc_RRESP;
  wire s00_couplers_to_auto_pc_RVALID;
  wire [31:0]s00_couplers_to_auto_pc_WDATA;
  wire [11:0]s00_couplers_to_auto_pc_WID;
  wire s00_couplers_to_auto_pc_WLAST;
  wire s00_couplers_to_auto_pc_WREADY;
  wire [3:0]s00_couplers_to_auto_pc_WSTRB;
  wire s00_couplers_to_auto_pc_WVALID;
  wire [31:0]s00_data_fifo_to_s00_couplers_ARADDR;
  wire [2:0]s00_data_fifo_to_s00_couplers_ARPROT;
  wire s00_data_fifo_to_s00_couplers_ARREADY;
  wire s00_data_fifo_to_s00_couplers_ARVALID;
  wire [31:0]s00_data_fifo_to_s00_couplers_AWADDR;
  wire [2:0]s00_data_fifo_to_s00_couplers_AWPROT;
  wire s00_data_fifo_to_s00_couplers_AWREADY;
  wire s00_data_fifo_to_s00_couplers_AWVALID;
  wire s00_data_fifo_to_s00_couplers_BREADY;
  wire [1:0]s00_data_fifo_to_s00_couplers_BRESP;
  wire s00_data_fifo_to_s00_couplers_BVALID;
  wire [63:0]s00_data_fifo_to_s00_couplers_RDATA;
  wire s00_data_fifo_to_s00_couplers_RREADY;
  wire [1:0]s00_data_fifo_to_s00_couplers_RRESP;
  wire s00_data_fifo_to_s00_couplers_RVALID;
  wire [63:0]s00_data_fifo_to_s00_couplers_WDATA;
  wire s00_data_fifo_to_s00_couplers_WREADY;
  wire [7:0]s00_data_fifo_to_s00_couplers_WSTRB;
  wire s00_data_fifo_to_s00_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN;
  assign M_AXI_araddr[31:0] = s00_data_fifo_to_s00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = s00_data_fifo_to_s00_couplers_ARPROT;
  assign M_AXI_arvalid = s00_data_fifo_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s00_data_fifo_to_s00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = s00_data_fifo_to_s00_couplers_AWPROT;
  assign M_AXI_awvalid = s00_data_fifo_to_s00_couplers_AWVALID;
  assign M_AXI_bready = s00_data_fifo_to_s00_couplers_BREADY;
  assign M_AXI_rready = s00_data_fifo_to_s00_couplers_RREADY;
  assign M_AXI_wdata[63:0] = s00_data_fifo_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[7:0] = s00_data_fifo_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = s00_data_fifo_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s00_couplers_to_auto_pc_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_pc_AWREADY;
  assign S_AXI_bid[11:0] = s00_couplers_to_auto_pc_BID;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_pc_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_pc_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_auto_pc_RDATA;
  assign S_AXI_rid[11:0] = s00_couplers_to_auto_pc_RID;
  assign S_AXI_rlast = s00_couplers_to_auto_pc_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_pc_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_pc_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_pc_WREADY;
  assign s00_couplers_to_auto_pc_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_auto_pc_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_auto_pc_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_auto_pc_ARID = S_AXI_arid[11:0];
  assign s00_couplers_to_auto_pc_ARLEN = S_AXI_arlen[3:0];
  assign s00_couplers_to_auto_pc_ARLOCK = S_AXI_arlock[1:0];
  assign s00_couplers_to_auto_pc_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_pc_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_auto_pc_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_auto_pc_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_pc_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_auto_pc_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_auto_pc_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_auto_pc_AWID = S_AXI_awid[11:0];
  assign s00_couplers_to_auto_pc_AWLEN = S_AXI_awlen[3:0];
  assign s00_couplers_to_auto_pc_AWLOCK = S_AXI_awlock[1:0];
  assign s00_couplers_to_auto_pc_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_pc_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_auto_pc_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_auto_pc_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_pc_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_pc_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_pc_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_auto_pc_WID = S_AXI_wid[11:0];
  assign s00_couplers_to_auto_pc_WLAST = S_AXI_wlast;
  assign s00_couplers_to_auto_pc_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_auto_pc_WVALID = S_AXI_wvalid;
  assign s00_data_fifo_to_s00_couplers_ARREADY = M_AXI_arready;
  assign s00_data_fifo_to_s00_couplers_AWREADY = M_AXI_awready;
  assign s00_data_fifo_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign s00_data_fifo_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign s00_data_fifo_to_s00_couplers_RDATA = M_AXI_rdata[63:0];
  assign s00_data_fifo_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_data_fifo_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign s00_data_fifo_to_s00_couplers_WREADY = M_AXI_wready;
  system_auto_pc_0 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_auto_rs_ARADDR),
        .m_axi_arprot(auto_pc_to_auto_rs_ARPROT),
        .m_axi_arready(auto_pc_to_auto_rs_ARREADY),
        .m_axi_arvalid(auto_pc_to_auto_rs_ARVALID),
        .m_axi_awaddr(auto_pc_to_auto_rs_AWADDR),
        .m_axi_awprot(auto_pc_to_auto_rs_AWPROT),
        .m_axi_awready(auto_pc_to_auto_rs_AWREADY),
        .m_axi_awvalid(auto_pc_to_auto_rs_AWVALID),
        .m_axi_bready(auto_pc_to_auto_rs_BREADY),
        .m_axi_bresp(auto_pc_to_auto_rs_BRESP),
        .m_axi_bvalid(auto_pc_to_auto_rs_BVALID),
        .m_axi_rdata(auto_pc_to_auto_rs_RDATA),
        .m_axi_rready(auto_pc_to_auto_rs_RREADY),
        .m_axi_rresp(auto_pc_to_auto_rs_RRESP),
        .m_axi_rvalid(auto_pc_to_auto_rs_RVALID),
        .m_axi_wdata(auto_pc_to_auto_rs_WDATA),
        .m_axi_wready(auto_pc_to_auto_rs_WREADY),
        .m_axi_wstrb(auto_pc_to_auto_rs_WSTRB),
        .m_axi_wvalid(auto_pc_to_auto_rs_WVALID),
        .s_axi_araddr(s00_couplers_to_auto_pc_ARADDR),
        .s_axi_arburst(s00_couplers_to_auto_pc_ARBURST),
        .s_axi_arcache(s00_couplers_to_auto_pc_ARCACHE),
        .s_axi_arid(s00_couplers_to_auto_pc_ARID),
        .s_axi_arlen(s00_couplers_to_auto_pc_ARLEN),
        .s_axi_arlock(s00_couplers_to_auto_pc_ARLOCK),
        .s_axi_arprot(s00_couplers_to_auto_pc_ARPROT),
        .s_axi_arqos(s00_couplers_to_auto_pc_ARQOS),
        .s_axi_arready(s00_couplers_to_auto_pc_ARREADY),
        .s_axi_arsize(s00_couplers_to_auto_pc_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_auto_pc_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_pc_AWADDR),
        .s_axi_awburst(s00_couplers_to_auto_pc_AWBURST),
        .s_axi_awcache(s00_couplers_to_auto_pc_AWCACHE),
        .s_axi_awid(s00_couplers_to_auto_pc_AWID),
        .s_axi_awlen(s00_couplers_to_auto_pc_AWLEN),
        .s_axi_awlock(s00_couplers_to_auto_pc_AWLOCK),
        .s_axi_awprot(s00_couplers_to_auto_pc_AWPROT),
        .s_axi_awqos(s00_couplers_to_auto_pc_AWQOS),
        .s_axi_awready(s00_couplers_to_auto_pc_AWREADY),
        .s_axi_awsize(s00_couplers_to_auto_pc_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_auto_pc_AWVALID),
        .s_axi_bid(s00_couplers_to_auto_pc_BID),
        .s_axi_bready(s00_couplers_to_auto_pc_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_pc_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_pc_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_pc_RDATA),
        .s_axi_rid(s00_couplers_to_auto_pc_RID),
        .s_axi_rlast(s00_couplers_to_auto_pc_RLAST),
        .s_axi_rready(s00_couplers_to_auto_pc_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_pc_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_pc_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_pc_WDATA),
        .s_axi_wid(s00_couplers_to_auto_pc_WID),
        .s_axi_wlast(s00_couplers_to_auto_pc_WLAST),
        .s_axi_wready(s00_couplers_to_auto_pc_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_pc_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_pc_WVALID));
  system_auto_rs_0 auto_rs
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_rs_to_auto_us_ARADDR),
        .m_axi_arprot(auto_rs_to_auto_us_ARPROT),
        .m_axi_arready(auto_rs_to_auto_us_ARREADY),
        .m_axi_arvalid(auto_rs_to_auto_us_ARVALID),
        .m_axi_awaddr(auto_rs_to_auto_us_AWADDR),
        .m_axi_awprot(auto_rs_to_auto_us_AWPROT),
        .m_axi_awready(auto_rs_to_auto_us_AWREADY),
        .m_axi_awvalid(auto_rs_to_auto_us_AWVALID),
        .m_axi_bready(auto_rs_to_auto_us_BREADY),
        .m_axi_bresp(auto_rs_to_auto_us_BRESP),
        .m_axi_bvalid(auto_rs_to_auto_us_BVALID),
        .m_axi_rdata(auto_rs_to_auto_us_RDATA),
        .m_axi_rready(auto_rs_to_auto_us_RREADY),
        .m_axi_rresp(auto_rs_to_auto_us_RRESP),
        .m_axi_rvalid(auto_rs_to_auto_us_RVALID),
        .m_axi_wdata(auto_rs_to_auto_us_WDATA),
        .m_axi_wready(auto_rs_to_auto_us_WREADY),
        .m_axi_wstrb(auto_rs_to_auto_us_WSTRB),
        .m_axi_wvalid(auto_rs_to_auto_us_WVALID),
        .s_axi_araddr(auto_pc_to_auto_rs_ARADDR),
        .s_axi_arprot(auto_pc_to_auto_rs_ARPROT),
        .s_axi_arready(auto_pc_to_auto_rs_ARREADY),
        .s_axi_arvalid(auto_pc_to_auto_rs_ARVALID),
        .s_axi_awaddr(auto_pc_to_auto_rs_AWADDR),
        .s_axi_awprot(auto_pc_to_auto_rs_AWPROT),
        .s_axi_awready(auto_pc_to_auto_rs_AWREADY),
        .s_axi_awvalid(auto_pc_to_auto_rs_AWVALID),
        .s_axi_bready(auto_pc_to_auto_rs_BREADY),
        .s_axi_bresp(auto_pc_to_auto_rs_BRESP),
        .s_axi_bvalid(auto_pc_to_auto_rs_BVALID),
        .s_axi_rdata(auto_pc_to_auto_rs_RDATA),
        .s_axi_rready(auto_pc_to_auto_rs_RREADY),
        .s_axi_rresp(auto_pc_to_auto_rs_RRESP),
        .s_axi_rvalid(auto_pc_to_auto_rs_RVALID),
        .s_axi_wdata(auto_pc_to_auto_rs_WDATA),
        .s_axi_wready(auto_pc_to_auto_rs_WREADY),
        .s_axi_wstrb(auto_pc_to_auto_rs_WSTRB),
        .s_axi_wvalid(auto_pc_to_auto_rs_WVALID));
  system_auto_us_0 auto_us
       (.m_axi_araddr(auto_us_to_s00_data_fifo_ARADDR),
        .m_axi_arprot(auto_us_to_s00_data_fifo_ARPROT),
        .m_axi_arready(auto_us_to_s00_data_fifo_ARREADY),
        .m_axi_arvalid(auto_us_to_s00_data_fifo_ARVALID),
        .m_axi_awaddr(auto_us_to_s00_data_fifo_AWADDR),
        .m_axi_awprot(auto_us_to_s00_data_fifo_AWPROT),
        .m_axi_awready(auto_us_to_s00_data_fifo_AWREADY),
        .m_axi_awvalid(auto_us_to_s00_data_fifo_AWVALID),
        .m_axi_bready(auto_us_to_s00_data_fifo_BREADY),
        .m_axi_bresp(auto_us_to_s00_data_fifo_BRESP),
        .m_axi_bvalid(auto_us_to_s00_data_fifo_BVALID),
        .m_axi_rdata(auto_us_to_s00_data_fifo_RDATA),
        .m_axi_rready(auto_us_to_s00_data_fifo_RREADY),
        .m_axi_rresp(auto_us_to_s00_data_fifo_RRESP),
        .m_axi_rvalid(auto_us_to_s00_data_fifo_RVALID),
        .m_axi_wdata(auto_us_to_s00_data_fifo_WDATA),
        .m_axi_wready(auto_us_to_s00_data_fifo_WREADY),
        .m_axi_wstrb(auto_us_to_s00_data_fifo_WSTRB),
        .m_axi_wvalid(auto_us_to_s00_data_fifo_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(auto_rs_to_auto_us_ARADDR),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arprot(auto_rs_to_auto_us_ARPROT),
        .s_axi_arready(auto_rs_to_auto_us_ARREADY),
        .s_axi_arvalid(auto_rs_to_auto_us_ARVALID),
        .s_axi_awaddr(auto_rs_to_auto_us_AWADDR),
        .s_axi_awprot(auto_rs_to_auto_us_AWPROT),
        .s_axi_awready(auto_rs_to_auto_us_AWREADY),
        .s_axi_awvalid(auto_rs_to_auto_us_AWVALID),
        .s_axi_bready(auto_rs_to_auto_us_BREADY),
        .s_axi_bresp(auto_rs_to_auto_us_BRESP),
        .s_axi_bvalid(auto_rs_to_auto_us_BVALID),
        .s_axi_rdata(auto_rs_to_auto_us_RDATA),
        .s_axi_rready(auto_rs_to_auto_us_RREADY),
        .s_axi_rresp(auto_rs_to_auto_us_RRESP),
        .s_axi_rvalid(auto_rs_to_auto_us_RVALID),
        .s_axi_wdata(auto_rs_to_auto_us_WDATA),
        .s_axi_wready(auto_rs_to_auto_us_WREADY),
        .s_axi_wstrb(auto_rs_to_auto_us_WSTRB),
        .s_axi_wvalid(auto_rs_to_auto_us_WVALID));
  system_s00_data_fifo_0 s00_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(s00_data_fifo_to_s00_couplers_ARADDR),
        .m_axi_arprot(s00_data_fifo_to_s00_couplers_ARPROT),
        .m_axi_arready(s00_data_fifo_to_s00_couplers_ARREADY),
        .m_axi_arvalid(s00_data_fifo_to_s00_couplers_ARVALID),
        .m_axi_awaddr(s00_data_fifo_to_s00_couplers_AWADDR),
        .m_axi_awprot(s00_data_fifo_to_s00_couplers_AWPROT),
        .m_axi_awready(s00_data_fifo_to_s00_couplers_AWREADY),
        .m_axi_awvalid(s00_data_fifo_to_s00_couplers_AWVALID),
        .m_axi_bready(s00_data_fifo_to_s00_couplers_BREADY),
        .m_axi_bresp(s00_data_fifo_to_s00_couplers_BRESP),
        .m_axi_bvalid(s00_data_fifo_to_s00_couplers_BVALID),
        .m_axi_rdata(s00_data_fifo_to_s00_couplers_RDATA),
        .m_axi_rready(s00_data_fifo_to_s00_couplers_RREADY),
        .m_axi_rresp(s00_data_fifo_to_s00_couplers_RRESP),
        .m_axi_rvalid(s00_data_fifo_to_s00_couplers_RVALID),
        .m_axi_wdata(s00_data_fifo_to_s00_couplers_WDATA),
        .m_axi_wready(s00_data_fifo_to_s00_couplers_WREADY),
        .m_axi_wstrb(s00_data_fifo_to_s00_couplers_WSTRB),
        .m_axi_wvalid(s00_data_fifo_to_s00_couplers_WVALID),
        .s_axi_araddr(auto_us_to_s00_data_fifo_ARADDR),
        .s_axi_arprot(auto_us_to_s00_data_fifo_ARPROT),
        .s_axi_arready(auto_us_to_s00_data_fifo_ARREADY),
        .s_axi_arvalid(auto_us_to_s00_data_fifo_ARVALID),
        .s_axi_awaddr(auto_us_to_s00_data_fifo_AWADDR),
        .s_axi_awprot(auto_us_to_s00_data_fifo_AWPROT),
        .s_axi_awready(auto_us_to_s00_data_fifo_AWREADY),
        .s_axi_awvalid(auto_us_to_s00_data_fifo_AWVALID),
        .s_axi_bready(auto_us_to_s00_data_fifo_BREADY),
        .s_axi_bresp(auto_us_to_s00_data_fifo_BRESP),
        .s_axi_bvalid(auto_us_to_s00_data_fifo_BVALID),
        .s_axi_rdata(auto_us_to_s00_data_fifo_RDATA),
        .s_axi_rready(auto_us_to_s00_data_fifo_RREADY),
        .s_axi_rresp(auto_us_to_s00_data_fifo_RRESP),
        .s_axi_rvalid(auto_us_to_s00_data_fifo_RVALID),
        .s_axi_wdata(auto_us_to_s00_data_fifo_WDATA),
        .s_axi_wready(auto_us_to_s00_data_fifo_WREADY),
        .s_axi_wstrb(auto_us_to_s00_data_fifo_WSTRB),
        .s_axi_wvalid(auto_us_to_s00_data_fifo_WVALID));
endmodule

(* CORE_GENERATION_INFO = "system,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=system,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=11,numReposBlks=9,numNonXlnxBlks=1,numHierBlks=2,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "system.hwdef" *) 
module system
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    clk_in,
    clk_int_out,
    clk_out,
    run_out,
    state0,
    state_leds,
    trg_in,
    trg_out);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input clk_in;
  output clk_int_out;
  output clk_out;
  output run_out;
  output [7:0]state0;
  output [7:0]state_leds;
  input trg_in;
  output trg_out;

  wire clk_1;
  wire clk_wiz_0_clk_out1;
  wire [14:0]proc_sys7_DDR_ADDR;
  wire [2:0]proc_sys7_DDR_BA;
  wire proc_sys7_DDR_CAS_N;
  wire proc_sys7_DDR_CKE;
  wire proc_sys7_DDR_CK_N;
  wire proc_sys7_DDR_CK_P;
  wire proc_sys7_DDR_CS_N;
  wire [3:0]proc_sys7_DDR_DM;
  wire [31:0]proc_sys7_DDR_DQ;
  wire [3:0]proc_sys7_DDR_DQS_N;
  wire [3:0]proc_sys7_DDR_DQS_P;
  wire proc_sys7_DDR_ODT;
  wire proc_sys7_DDR_RAS_N;
  wire proc_sys7_DDR_RESET_N;
  wire proc_sys7_DDR_WE_N;
  wire proc_sys7_FCLK_CLK0;
  wire proc_sys7_FCLK_RESET0_N;
  wire proc_sys7_FIXED_IO_DDR_VRN;
  wire proc_sys7_FIXED_IO_DDR_VRP;
  wire [53:0]proc_sys7_FIXED_IO_MIO;
  wire proc_sys7_FIXED_IO_PS_CLK;
  wire proc_sys7_FIXED_IO_PS_PORB;
  wire proc_sys7_FIXED_IO_PS_SRSTB;
  wire [31:0]proc_sys7_M_AXI_GP0_ARADDR;
  wire [1:0]proc_sys7_M_AXI_GP0_ARBURST;
  wire [3:0]proc_sys7_M_AXI_GP0_ARCACHE;
  wire [11:0]proc_sys7_M_AXI_GP0_ARID;
  wire [3:0]proc_sys7_M_AXI_GP0_ARLEN;
  wire [1:0]proc_sys7_M_AXI_GP0_ARLOCK;
  wire [2:0]proc_sys7_M_AXI_GP0_ARPROT;
  wire [3:0]proc_sys7_M_AXI_GP0_ARQOS;
  wire proc_sys7_M_AXI_GP0_ARREADY;
  wire [2:0]proc_sys7_M_AXI_GP0_ARSIZE;
  wire proc_sys7_M_AXI_GP0_ARVALID;
  wire [31:0]proc_sys7_M_AXI_GP0_AWADDR;
  wire [1:0]proc_sys7_M_AXI_GP0_AWBURST;
  wire [3:0]proc_sys7_M_AXI_GP0_AWCACHE;
  wire [11:0]proc_sys7_M_AXI_GP0_AWID;
  wire [3:0]proc_sys7_M_AXI_GP0_AWLEN;
  wire [1:0]proc_sys7_M_AXI_GP0_AWLOCK;
  wire [2:0]proc_sys7_M_AXI_GP0_AWPROT;
  wire [3:0]proc_sys7_M_AXI_GP0_AWQOS;
  wire proc_sys7_M_AXI_GP0_AWREADY;
  wire [2:0]proc_sys7_M_AXI_GP0_AWSIZE;
  wire proc_sys7_M_AXI_GP0_AWVALID;
  wire [11:0]proc_sys7_M_AXI_GP0_BID;
  wire proc_sys7_M_AXI_GP0_BREADY;
  wire [1:0]proc_sys7_M_AXI_GP0_BRESP;
  wire proc_sys7_M_AXI_GP0_BVALID;
  wire [31:0]proc_sys7_M_AXI_GP0_RDATA;
  wire [11:0]proc_sys7_M_AXI_GP0_RID;
  wire proc_sys7_M_AXI_GP0_RLAST;
  wire proc_sys7_M_AXI_GP0_RREADY;
  wire [1:0]proc_sys7_M_AXI_GP0_RRESP;
  wire proc_sys7_M_AXI_GP0_RVALID;
  wire [31:0]proc_sys7_M_AXI_GP0_WDATA;
  wire [11:0]proc_sys7_M_AXI_GP0_WID;
  wire proc_sys7_M_AXI_GP0_WLAST;
  wire proc_sys7_M_AXI_GP0_WREADY;
  wire [3:0]proc_sys7_M_AXI_GP0_WSTRB;
  wire proc_sys7_M_AXI_GP0_WVALID;
  wire [31:0]proc_sys7_axi_periph_M00_AXI_ARADDR;
  wire [2:0]proc_sys7_axi_periph_M00_AXI_ARPROT;
  wire proc_sys7_axi_periph_M00_AXI_ARREADY;
  wire proc_sys7_axi_periph_M00_AXI_ARVALID;
  wire [31:0]proc_sys7_axi_periph_M00_AXI_AWADDR;
  wire [2:0]proc_sys7_axi_periph_M00_AXI_AWPROT;
  wire proc_sys7_axi_periph_M00_AXI_AWREADY;
  wire proc_sys7_axi_periph_M00_AXI_AWVALID;
  wire proc_sys7_axi_periph_M00_AXI_BREADY;
  wire [1:0]proc_sys7_axi_periph_M00_AXI_BRESP;
  wire proc_sys7_axi_periph_M00_AXI_BVALID;
  wire [63:0]proc_sys7_axi_periph_M00_AXI_RDATA;
  wire proc_sys7_axi_periph_M00_AXI_RREADY;
  wire [1:0]proc_sys7_axi_periph_M00_AXI_RRESP;
  wire proc_sys7_axi_periph_M00_AXI_RVALID;
  wire [63:0]proc_sys7_axi_periph_M00_AXI_WDATA;
  wire proc_sys7_axi_periph_M00_AXI_WREADY;
  wire [7:0]proc_sys7_axi_periph_M00_AXI_WSTRB;
  wire proc_sys7_axi_periph_M00_AXI_WVALID;
  wire [0:0]proc_sys_reset_interconnect_aresetn;
  wire [0:0]proc_sys_reset_peripheral_aresetn;
  wire [15:0]rp_trig_0_BRAM_PORTA_ADDR;
  wire rp_trig_0_BRAM_PORTA_CLK;
  wire [47:0]rp_trig_0_BRAM_PORTA_DIN;
  wire [47:0]rp_trig_0_BRAM_PORTA_DOUT;
  wire rp_trig_0_BRAM_PORTA_EN;
  wire rp_trig_0_BRAM_PORTA_WE;
  wire [15:0]rp_trig_0_BRAM_PORTB_ADDR;
  wire rp_trig_0_BRAM_PORTB_CLK;
  wire [47:0]rp_trig_0_BRAM_PORTB_DOUT;
  wire rp_trig_0_BRAM_PORTB_WE;
  wire trg_in_1;
  wire trig_clk_int_out;
  wire trig_clk_out;
  wire trig_gate_out;
  wire trig_power_down;
  wire [7:0]trig_signal_out;
  wire [7:0]trig_state_out;
  wire trig_trg_out;

  assign clk_1 = clk_in;
  assign clk_int_out = trig_clk_int_out;
  assign clk_out = trig_clk_out;
  assign run_out = trig_gate_out;
  assign state0[7:0] = trig_signal_out;
  assign state_leds[7:0] = trig_state_out;
  assign trg_in_1 = trg_in;
  assign trg_out = trig_trg_out;
  system_axi_intercon_0 axi_intercon
       (.ACLK(proc_sys7_FCLK_CLK0),
        .ARESETN(proc_sys_reset_interconnect_aresetn),
        .M00_ACLK(proc_sys7_FCLK_CLK0),
        .M00_ARESETN(proc_sys_reset_peripheral_aresetn),
        .M00_AXI_araddr(proc_sys7_axi_periph_M00_AXI_ARADDR),
        .M00_AXI_arprot(proc_sys7_axi_periph_M00_AXI_ARPROT),
        .M00_AXI_arready(proc_sys7_axi_periph_M00_AXI_ARREADY),
        .M00_AXI_arvalid(proc_sys7_axi_periph_M00_AXI_ARVALID),
        .M00_AXI_awaddr(proc_sys7_axi_periph_M00_AXI_AWADDR),
        .M00_AXI_awprot(proc_sys7_axi_periph_M00_AXI_AWPROT),
        .M00_AXI_awready(proc_sys7_axi_periph_M00_AXI_AWREADY),
        .M00_AXI_awvalid(proc_sys7_axi_periph_M00_AXI_AWVALID),
        .M00_AXI_bready(proc_sys7_axi_periph_M00_AXI_BREADY),
        .M00_AXI_bresp(proc_sys7_axi_periph_M00_AXI_BRESP),
        .M00_AXI_bvalid(proc_sys7_axi_periph_M00_AXI_BVALID),
        .M00_AXI_rdata(proc_sys7_axi_periph_M00_AXI_RDATA),
        .M00_AXI_rready(proc_sys7_axi_periph_M00_AXI_RREADY),
        .M00_AXI_rresp(proc_sys7_axi_periph_M00_AXI_RRESP),
        .M00_AXI_rvalid(proc_sys7_axi_periph_M00_AXI_RVALID),
        .M00_AXI_wdata(proc_sys7_axi_periph_M00_AXI_WDATA),
        .M00_AXI_wready(proc_sys7_axi_periph_M00_AXI_WREADY),
        .M00_AXI_wstrb(proc_sys7_axi_periph_M00_AXI_WSTRB),
        .M00_AXI_wvalid(proc_sys7_axi_periph_M00_AXI_WVALID),
        .S00_ACLK(proc_sys7_FCLK_CLK0),
        .S00_ARESETN(proc_sys_reset_peripheral_aresetn),
        .S00_AXI_araddr(proc_sys7_M_AXI_GP0_ARADDR),
        .S00_AXI_arburst(proc_sys7_M_AXI_GP0_ARBURST),
        .S00_AXI_arcache(proc_sys7_M_AXI_GP0_ARCACHE),
        .S00_AXI_arid(proc_sys7_M_AXI_GP0_ARID),
        .S00_AXI_arlen(proc_sys7_M_AXI_GP0_ARLEN),
        .S00_AXI_arlock(proc_sys7_M_AXI_GP0_ARLOCK),
        .S00_AXI_arprot(proc_sys7_M_AXI_GP0_ARPROT),
        .S00_AXI_arqos(proc_sys7_M_AXI_GP0_ARQOS),
        .S00_AXI_arready(proc_sys7_M_AXI_GP0_ARREADY),
        .S00_AXI_arsize(proc_sys7_M_AXI_GP0_ARSIZE),
        .S00_AXI_arvalid(proc_sys7_M_AXI_GP0_ARVALID),
        .S00_AXI_awaddr(proc_sys7_M_AXI_GP0_AWADDR),
        .S00_AXI_awburst(proc_sys7_M_AXI_GP0_AWBURST),
        .S00_AXI_awcache(proc_sys7_M_AXI_GP0_AWCACHE),
        .S00_AXI_awid(proc_sys7_M_AXI_GP0_AWID),
        .S00_AXI_awlen(proc_sys7_M_AXI_GP0_AWLEN),
        .S00_AXI_awlock(proc_sys7_M_AXI_GP0_AWLOCK),
        .S00_AXI_awprot(proc_sys7_M_AXI_GP0_AWPROT),
        .S00_AXI_awqos(proc_sys7_M_AXI_GP0_AWQOS),
        .S00_AXI_awready(proc_sys7_M_AXI_GP0_AWREADY),
        .S00_AXI_awsize(proc_sys7_M_AXI_GP0_AWSIZE),
        .S00_AXI_awvalid(proc_sys7_M_AXI_GP0_AWVALID),
        .S00_AXI_bid(proc_sys7_M_AXI_GP0_BID),
        .S00_AXI_bready(proc_sys7_M_AXI_GP0_BREADY),
        .S00_AXI_bresp(proc_sys7_M_AXI_GP0_BRESP),
        .S00_AXI_bvalid(proc_sys7_M_AXI_GP0_BVALID),
        .S00_AXI_rdata(proc_sys7_M_AXI_GP0_RDATA),
        .S00_AXI_rid(proc_sys7_M_AXI_GP0_RID),
        .S00_AXI_rlast(proc_sys7_M_AXI_GP0_RLAST),
        .S00_AXI_rready(proc_sys7_M_AXI_GP0_RREADY),
        .S00_AXI_rresp(proc_sys7_M_AXI_GP0_RRESP),
        .S00_AXI_rvalid(proc_sys7_M_AXI_GP0_RVALID),
        .S00_AXI_wdata(proc_sys7_M_AXI_GP0_WDATA),
        .S00_AXI_wid(proc_sys7_M_AXI_GP0_WID),
        .S00_AXI_wlast(proc_sys7_M_AXI_GP0_WLAST),
        .S00_AXI_wready(proc_sys7_M_AXI_GP0_WREADY),
        .S00_AXI_wstrb(proc_sys7_M_AXI_GP0_WSTRB),
        .S00_AXI_wvalid(proc_sys7_M_AXI_GP0_WVALID));
  system_bram_0 bram
       (.addra(rp_trig_0_BRAM_PORTA_ADDR),
        .addrb(rp_trig_0_BRAM_PORTB_ADDR),
        .clka(rp_trig_0_BRAM_PORTA_CLK),
        .clkb(rp_trig_0_BRAM_PORTB_CLK),
        .dina(rp_trig_0_BRAM_PORTA_DIN),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(rp_trig_0_BRAM_PORTA_DOUT),
        .doutb(rp_trig_0_BRAM_PORTB_DOUT),
        .ena(rp_trig_0_BRAM_PORTA_EN),
        .wea(rp_trig_0_BRAM_PORTA_WE),
        .web(rp_trig_0_BRAM_PORTB_WE));
  system_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(proc_sys7_FCLK_CLK0),
        .clk_out1(clk_wiz_0_clk_out1),
        .power_down(trig_power_down),
        .resetn(proc_sys_reset_peripheral_aresetn));
  system_proc_sys7_0 proc_sys7
       (.CAN0_PHY_RX(1'b0),
        .DDR_Addr(DDR_addr[14:0]),
        .DDR_BankAddr(DDR_ba[2:0]),
        .DDR_CAS_n(DDR_cas_n),
        .DDR_CKE(DDR_cke),
        .DDR_CS_n(DDR_cs_n),
        .DDR_Clk(DDR_ck_p),
        .DDR_Clk_n(DDR_ck_n),
        .DDR_DM(DDR_dm[3:0]),
        .DDR_DQ(DDR_dq[31:0]),
        .DDR_DQS(DDR_dqs_p[3:0]),
        .DDR_DQS_n(DDR_dqs_n[3:0]),
        .DDR_DRSTB(DDR_reset_n),
        .DDR_ODT(DDR_odt),
        .DDR_RAS_n(DDR_ras_n),
        .DDR_VRN(FIXED_IO_ddr_vrn),
        .DDR_VRP(FIXED_IO_ddr_vrp),
        .DDR_WEB(DDR_we_n),
        .FCLK_CLK0(proc_sys7_FCLK_CLK0),
        .FCLK_RESET0_N(proc_sys7_FCLK_RESET0_N),
        .GPIO_I({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MIO(FIXED_IO_mio[53:0]),
        .M_AXI_GP0_ACLK(proc_sys7_FCLK_CLK0),
        .M_AXI_GP0_ARADDR(proc_sys7_M_AXI_GP0_ARADDR),
        .M_AXI_GP0_ARBURST(proc_sys7_M_AXI_GP0_ARBURST),
        .M_AXI_GP0_ARCACHE(proc_sys7_M_AXI_GP0_ARCACHE),
        .M_AXI_GP0_ARID(proc_sys7_M_AXI_GP0_ARID),
        .M_AXI_GP0_ARLEN(proc_sys7_M_AXI_GP0_ARLEN),
        .M_AXI_GP0_ARLOCK(proc_sys7_M_AXI_GP0_ARLOCK),
        .M_AXI_GP0_ARPROT(proc_sys7_M_AXI_GP0_ARPROT),
        .M_AXI_GP0_ARQOS(proc_sys7_M_AXI_GP0_ARQOS),
        .M_AXI_GP0_ARREADY(proc_sys7_M_AXI_GP0_ARREADY),
        .M_AXI_GP0_ARSIZE(proc_sys7_M_AXI_GP0_ARSIZE),
        .M_AXI_GP0_ARVALID(proc_sys7_M_AXI_GP0_ARVALID),
        .M_AXI_GP0_AWADDR(proc_sys7_M_AXI_GP0_AWADDR),
        .M_AXI_GP0_AWBURST(proc_sys7_M_AXI_GP0_AWBURST),
        .M_AXI_GP0_AWCACHE(proc_sys7_M_AXI_GP0_AWCACHE),
        .M_AXI_GP0_AWID(proc_sys7_M_AXI_GP0_AWID),
        .M_AXI_GP0_AWLEN(proc_sys7_M_AXI_GP0_AWLEN),
        .M_AXI_GP0_AWLOCK(proc_sys7_M_AXI_GP0_AWLOCK),
        .M_AXI_GP0_AWPROT(proc_sys7_M_AXI_GP0_AWPROT),
        .M_AXI_GP0_AWQOS(proc_sys7_M_AXI_GP0_AWQOS),
        .M_AXI_GP0_AWREADY(proc_sys7_M_AXI_GP0_AWREADY),
        .M_AXI_GP0_AWSIZE(proc_sys7_M_AXI_GP0_AWSIZE),
        .M_AXI_GP0_AWVALID(proc_sys7_M_AXI_GP0_AWVALID),
        .M_AXI_GP0_BID(proc_sys7_M_AXI_GP0_BID),
        .M_AXI_GP0_BREADY(proc_sys7_M_AXI_GP0_BREADY),
        .M_AXI_GP0_BRESP(proc_sys7_M_AXI_GP0_BRESP),
        .M_AXI_GP0_BVALID(proc_sys7_M_AXI_GP0_BVALID),
        .M_AXI_GP0_RDATA(proc_sys7_M_AXI_GP0_RDATA),
        .M_AXI_GP0_RID(proc_sys7_M_AXI_GP0_RID),
        .M_AXI_GP0_RLAST(proc_sys7_M_AXI_GP0_RLAST),
        .M_AXI_GP0_RREADY(proc_sys7_M_AXI_GP0_RREADY),
        .M_AXI_GP0_RRESP(proc_sys7_M_AXI_GP0_RRESP),
        .M_AXI_GP0_RVALID(proc_sys7_M_AXI_GP0_RVALID),
        .M_AXI_GP0_WDATA(proc_sys7_M_AXI_GP0_WDATA),
        .M_AXI_GP0_WID(proc_sys7_M_AXI_GP0_WID),
        .M_AXI_GP0_WLAST(proc_sys7_M_AXI_GP0_WLAST),
        .M_AXI_GP0_WREADY(proc_sys7_M_AXI_GP0_WREADY),
        .M_AXI_GP0_WSTRB(proc_sys7_M_AXI_GP0_WSTRB),
        .M_AXI_GP0_WVALID(proc_sys7_M_AXI_GP0_WVALID),
        .PS_CLK(FIXED_IO_ps_clk),
        .PS_PORB(FIXED_IO_ps_porb),
        .PS_SRSTB(FIXED_IO_ps_srstb),
        .SPI0_MISO_I(1'b0),
        .SPI0_MOSI_I(1'b0),
        .SPI0_SCLK_I(1'b0),
        .SPI0_SS_I(1'b0),
        .USB0_VBUS_PWRFAULT(1'b0));
  system_proc_sys_reset_0 proc_sys_reset
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(proc_sys7_FCLK_RESET0_N),
        .interconnect_aresetn(proc_sys_reset_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_peripheral_aresetn),
        .slowest_sync_clk(proc_sys7_FCLK_CLK0));
  system_trig_0 trig
       (.bram_addra(rp_trig_0_BRAM_PORTA_ADDR),
        .bram_addrb(rp_trig_0_BRAM_PORTB_ADDR),
        .bram_clka(rp_trig_0_BRAM_PORTA_CLK),
        .bram_clkb(rp_trig_0_BRAM_PORTB_CLK),
        .bram_dina(rp_trig_0_BRAM_PORTA_DIN),
        .bram_douta(rp_trig_0_BRAM_PORTA_DOUT),
        .bram_doutb(rp_trig_0_BRAM_PORTB_DOUT),
        .bram_ena(rp_trig_0_BRAM_PORTA_EN),
        .bram_wea(rp_trig_0_BRAM_PORTA_WE),
        .bram_web(rp_trig_0_BRAM_PORTB_WE),
        .clk_axi_in(proc_sys7_FCLK_CLK0),
        .clk_ext_in(clk_1),
        .clk_int_in(clk_wiz_0_clk_out1),
        .clk_int_out(trig_clk_int_out),
        .clk_out(trig_clk_out),
        .power_down(trig_power_down),
        .run_out(trig_gate_out),
        .s00_axi_araddr(proc_sys7_axi_periph_M00_AXI_ARADDR[18:0]),
        .s00_axi_arprot(proc_sys7_axi_periph_M00_AXI_ARPROT),
        .s00_axi_arready(proc_sys7_axi_periph_M00_AXI_ARREADY),
        .s00_axi_arvalid(proc_sys7_axi_periph_M00_AXI_ARVALID),
        .s00_axi_awaddr(proc_sys7_axi_periph_M00_AXI_AWADDR[18:0]),
        .s00_axi_awprot(proc_sys7_axi_periph_M00_AXI_AWPROT),
        .s00_axi_awready(proc_sys7_axi_periph_M00_AXI_AWREADY),
        .s00_axi_awvalid(proc_sys7_axi_periph_M00_AXI_AWVALID),
        .s00_axi_bready(proc_sys7_axi_periph_M00_AXI_BREADY),
        .s00_axi_bresp(proc_sys7_axi_periph_M00_AXI_BRESP),
        .s00_axi_bvalid(proc_sys7_axi_periph_M00_AXI_BVALID),
        .s00_axi_rdata(proc_sys7_axi_periph_M00_AXI_RDATA),
        .s00_axi_resetn(proc_sys_reset_peripheral_aresetn),
        .s00_axi_rready(proc_sys7_axi_periph_M00_AXI_RREADY),
        .s00_axi_rresp(proc_sys7_axi_periph_M00_AXI_RRESP),
        .s00_axi_rvalid(proc_sys7_axi_periph_M00_AXI_RVALID),
        .s00_axi_wdata(proc_sys7_axi_periph_M00_AXI_WDATA),
        .s00_axi_wready(proc_sys7_axi_periph_M00_AXI_WREADY),
        .s00_axi_wstrb(proc_sys7_axi_periph_M00_AXI_WSTRB),
        .s00_axi_wvalid(proc_sys7_axi_periph_M00_AXI_WVALID),
        .signal_out(trig_signal_out),
        .state_out(trig_state_out),
        .trg_in(trg_in_1),
        .trg_out(trig_trg_out));
endmodule

module system_axi_intercon_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wid,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input [0:0]ARESETN;
  input M00_ACLK;
  input [0:0]M00_ARESETN;
  output [31:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input M00_AXI_arready;
  output M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input M00_AXI_awready;
  output M00_AXI_awvalid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [63:0]M00_AXI_rdata;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [63:0]M00_AXI_wdata;
  input M00_AXI_wready;
  output [7:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input S00_ACLK;
  input [0:0]S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [11:0]S00_AXI_arid;
  input [3:0]S00_AXI_arlen;
  input [1:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [11:0]S00_AXI_awid;
  input [3:0]S00_AXI_awlen;
  input [1:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  output [11:0]S00_AXI_bid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output [11:0]S00_AXI_rid;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input [11:0]S00_AXI_wid;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;

  wire S00_ACLK_1;
  wire [0:0]S00_ARESETN_1;
  wire axi_intercon_ACLK_net;
  wire [0:0]axi_intercon_ARESETN_net;
  wire [31:0]axi_intercon_to_s00_couplers_ARADDR;
  wire [1:0]axi_intercon_to_s00_couplers_ARBURST;
  wire [3:0]axi_intercon_to_s00_couplers_ARCACHE;
  wire [11:0]axi_intercon_to_s00_couplers_ARID;
  wire [3:0]axi_intercon_to_s00_couplers_ARLEN;
  wire [1:0]axi_intercon_to_s00_couplers_ARLOCK;
  wire [2:0]axi_intercon_to_s00_couplers_ARPROT;
  wire [3:0]axi_intercon_to_s00_couplers_ARQOS;
  wire axi_intercon_to_s00_couplers_ARREADY;
  wire [2:0]axi_intercon_to_s00_couplers_ARSIZE;
  wire axi_intercon_to_s00_couplers_ARVALID;
  wire [31:0]axi_intercon_to_s00_couplers_AWADDR;
  wire [1:0]axi_intercon_to_s00_couplers_AWBURST;
  wire [3:0]axi_intercon_to_s00_couplers_AWCACHE;
  wire [11:0]axi_intercon_to_s00_couplers_AWID;
  wire [3:0]axi_intercon_to_s00_couplers_AWLEN;
  wire [1:0]axi_intercon_to_s00_couplers_AWLOCK;
  wire [2:0]axi_intercon_to_s00_couplers_AWPROT;
  wire [3:0]axi_intercon_to_s00_couplers_AWQOS;
  wire axi_intercon_to_s00_couplers_AWREADY;
  wire [2:0]axi_intercon_to_s00_couplers_AWSIZE;
  wire axi_intercon_to_s00_couplers_AWVALID;
  wire [11:0]axi_intercon_to_s00_couplers_BID;
  wire axi_intercon_to_s00_couplers_BREADY;
  wire [1:0]axi_intercon_to_s00_couplers_BRESP;
  wire axi_intercon_to_s00_couplers_BVALID;
  wire [31:0]axi_intercon_to_s00_couplers_RDATA;
  wire [11:0]axi_intercon_to_s00_couplers_RID;
  wire axi_intercon_to_s00_couplers_RLAST;
  wire axi_intercon_to_s00_couplers_RREADY;
  wire [1:0]axi_intercon_to_s00_couplers_RRESP;
  wire axi_intercon_to_s00_couplers_RVALID;
  wire [31:0]axi_intercon_to_s00_couplers_WDATA;
  wire [11:0]axi_intercon_to_s00_couplers_WID;
  wire axi_intercon_to_s00_couplers_WLAST;
  wire axi_intercon_to_s00_couplers_WREADY;
  wire [3:0]axi_intercon_to_s00_couplers_WSTRB;
  wire axi_intercon_to_s00_couplers_WVALID;
  wire [31:0]s00_couplers_to_axi_intercon_ARADDR;
  wire [2:0]s00_couplers_to_axi_intercon_ARPROT;
  wire s00_couplers_to_axi_intercon_ARREADY;
  wire s00_couplers_to_axi_intercon_ARVALID;
  wire [31:0]s00_couplers_to_axi_intercon_AWADDR;
  wire [2:0]s00_couplers_to_axi_intercon_AWPROT;
  wire s00_couplers_to_axi_intercon_AWREADY;
  wire s00_couplers_to_axi_intercon_AWVALID;
  wire s00_couplers_to_axi_intercon_BREADY;
  wire [1:0]s00_couplers_to_axi_intercon_BRESP;
  wire s00_couplers_to_axi_intercon_BVALID;
  wire [63:0]s00_couplers_to_axi_intercon_RDATA;
  wire s00_couplers_to_axi_intercon_RREADY;
  wire [1:0]s00_couplers_to_axi_intercon_RRESP;
  wire s00_couplers_to_axi_intercon_RVALID;
  wire [63:0]s00_couplers_to_axi_intercon_WDATA;
  wire s00_couplers_to_axi_intercon_WREADY;
  wire [7:0]s00_couplers_to_axi_intercon_WSTRB;
  wire s00_couplers_to_axi_intercon_WVALID;

  assign M00_AXI_araddr[31:0] = s00_couplers_to_axi_intercon_ARADDR;
  assign M00_AXI_arprot[2:0] = s00_couplers_to_axi_intercon_ARPROT;
  assign M00_AXI_arvalid = s00_couplers_to_axi_intercon_ARVALID;
  assign M00_AXI_awaddr[31:0] = s00_couplers_to_axi_intercon_AWADDR;
  assign M00_AXI_awprot[2:0] = s00_couplers_to_axi_intercon_AWPROT;
  assign M00_AXI_awvalid = s00_couplers_to_axi_intercon_AWVALID;
  assign M00_AXI_bready = s00_couplers_to_axi_intercon_BREADY;
  assign M00_AXI_rready = s00_couplers_to_axi_intercon_RREADY;
  assign M00_AXI_wdata[63:0] = s00_couplers_to_axi_intercon_WDATA;
  assign M00_AXI_wstrb[7:0] = s00_couplers_to_axi_intercon_WSTRB;
  assign M00_AXI_wvalid = s00_couplers_to_axi_intercon_WVALID;
  assign S00_ACLK_1 = S00_ACLK;
  assign S00_ARESETN_1 = S00_ARESETN[0];
  assign S00_AXI_arready = axi_intercon_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_intercon_to_s00_couplers_AWREADY;
  assign S00_AXI_bid[11:0] = axi_intercon_to_s00_couplers_BID;
  assign S00_AXI_bresp[1:0] = axi_intercon_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_intercon_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_intercon_to_s00_couplers_RDATA;
  assign S00_AXI_rid[11:0] = axi_intercon_to_s00_couplers_RID;
  assign S00_AXI_rlast = axi_intercon_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = axi_intercon_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_intercon_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_intercon_to_s00_couplers_WREADY;
  assign axi_intercon_ACLK_net = M00_ACLK;
  assign axi_intercon_ARESETN_net = M00_ARESETN[0];
  assign axi_intercon_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_intercon_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign axi_intercon_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign axi_intercon_to_s00_couplers_ARID = S00_AXI_arid[11:0];
  assign axi_intercon_to_s00_couplers_ARLEN = S00_AXI_arlen[3:0];
  assign axi_intercon_to_s00_couplers_ARLOCK = S00_AXI_arlock[1:0];
  assign axi_intercon_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_intercon_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign axi_intercon_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign axi_intercon_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_intercon_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_intercon_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign axi_intercon_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign axi_intercon_to_s00_couplers_AWID = S00_AXI_awid[11:0];
  assign axi_intercon_to_s00_couplers_AWLEN = S00_AXI_awlen[3:0];
  assign axi_intercon_to_s00_couplers_AWLOCK = S00_AXI_awlock[1:0];
  assign axi_intercon_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_intercon_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign axi_intercon_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign axi_intercon_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_intercon_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_intercon_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_intercon_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_intercon_to_s00_couplers_WID = S00_AXI_wid[11:0];
  assign axi_intercon_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign axi_intercon_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_intercon_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign s00_couplers_to_axi_intercon_ARREADY = M00_AXI_arready;
  assign s00_couplers_to_axi_intercon_AWREADY = M00_AXI_awready;
  assign s00_couplers_to_axi_intercon_BRESP = M00_AXI_bresp[1:0];
  assign s00_couplers_to_axi_intercon_BVALID = M00_AXI_bvalid;
  assign s00_couplers_to_axi_intercon_RDATA = M00_AXI_rdata[63:0];
  assign s00_couplers_to_axi_intercon_RRESP = M00_AXI_rresp[1:0];
  assign s00_couplers_to_axi_intercon_RVALID = M00_AXI_rvalid;
  assign s00_couplers_to_axi_intercon_WREADY = M00_AXI_wready;
  s00_couplers_imp_1XH0AG s00_couplers
       (.M_ACLK(axi_intercon_ACLK_net),
        .M_ARESETN(axi_intercon_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_axi_intercon_ARADDR),
        .M_AXI_arprot(s00_couplers_to_axi_intercon_ARPROT),
        .M_AXI_arready(s00_couplers_to_axi_intercon_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_axi_intercon_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_axi_intercon_AWADDR),
        .M_AXI_awprot(s00_couplers_to_axi_intercon_AWPROT),
        .M_AXI_awready(s00_couplers_to_axi_intercon_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_axi_intercon_AWVALID),
        .M_AXI_bready(s00_couplers_to_axi_intercon_BREADY),
        .M_AXI_bresp(s00_couplers_to_axi_intercon_BRESP),
        .M_AXI_bvalid(s00_couplers_to_axi_intercon_BVALID),
        .M_AXI_rdata(s00_couplers_to_axi_intercon_RDATA),
        .M_AXI_rready(s00_couplers_to_axi_intercon_RREADY),
        .M_AXI_rresp(s00_couplers_to_axi_intercon_RRESP),
        .M_AXI_rvalid(s00_couplers_to_axi_intercon_RVALID),
        .M_AXI_wdata(s00_couplers_to_axi_intercon_WDATA),
        .M_AXI_wready(s00_couplers_to_axi_intercon_WREADY),
        .M_AXI_wstrb(s00_couplers_to_axi_intercon_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_axi_intercon_WVALID),
        .S_ACLK(S00_ACLK_1),
        .S_ARESETN(S00_ARESETN_1),
        .S_AXI_araddr(axi_intercon_to_s00_couplers_ARADDR),
        .S_AXI_arburst(axi_intercon_to_s00_couplers_ARBURST),
        .S_AXI_arcache(axi_intercon_to_s00_couplers_ARCACHE),
        .S_AXI_arid(axi_intercon_to_s00_couplers_ARID),
        .S_AXI_arlen(axi_intercon_to_s00_couplers_ARLEN),
        .S_AXI_arlock(axi_intercon_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(axi_intercon_to_s00_couplers_ARPROT),
        .S_AXI_arqos(axi_intercon_to_s00_couplers_ARQOS),
        .S_AXI_arready(axi_intercon_to_s00_couplers_ARREADY),
        .S_AXI_arsize(axi_intercon_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(axi_intercon_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_intercon_to_s00_couplers_AWADDR),
        .S_AXI_awburst(axi_intercon_to_s00_couplers_AWBURST),
        .S_AXI_awcache(axi_intercon_to_s00_couplers_AWCACHE),
        .S_AXI_awid(axi_intercon_to_s00_couplers_AWID),
        .S_AXI_awlen(axi_intercon_to_s00_couplers_AWLEN),
        .S_AXI_awlock(axi_intercon_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(axi_intercon_to_s00_couplers_AWPROT),
        .S_AXI_awqos(axi_intercon_to_s00_couplers_AWQOS),
        .S_AXI_awready(axi_intercon_to_s00_couplers_AWREADY),
        .S_AXI_awsize(axi_intercon_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(axi_intercon_to_s00_couplers_AWVALID),
        .S_AXI_bid(axi_intercon_to_s00_couplers_BID),
        .S_AXI_bready(axi_intercon_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_intercon_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_intercon_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_intercon_to_s00_couplers_RDATA),
        .S_AXI_rid(axi_intercon_to_s00_couplers_RID),
        .S_AXI_rlast(axi_intercon_to_s00_couplers_RLAST),
        .S_AXI_rready(axi_intercon_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_intercon_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_intercon_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_intercon_to_s00_couplers_WDATA),
        .S_AXI_wid(axi_intercon_to_s00_couplers_WID),
        .S_AXI_wlast(axi_intercon_to_s00_couplers_WLAST),
        .S_AXI_wready(axi_intercon_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_intercon_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_intercon_to_s00_couplers_WVALID));
endmodule
