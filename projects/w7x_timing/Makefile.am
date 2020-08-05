include $(top_srcdir)/Common.mk
include $(top_srcdir)/fpga/Common.mk

FPGA_REPO_DIR += $(top_builddir)/fpga/lib/red-pitaya-notes

## CORES ##
VENDOR = w7x
LIBRARY = ip
vivado_CORES = timing_1.0
timing_SOURCES = \
	src/w7x_timing_v1_0_S00_AXI.vhd \
	src/w7x_timing_v1_0.vhd \
	src/w7x_timing.vhd \
	src/w7x_timing.xdc
timing_IPCFG = src/w7x_timing_setup.tcl

## PROJECTS ##
vivado_PROJECTS = timing_brd
timing_brd_VERSION = 1.0
timing_brd_IP_SOURCES = timing_1.0
timing_brd_SOURCES = \
	prj_src/system.bd \
	prj_src/hdl/system_wrapper.v \
	prj_src/redpitaya.xdc
timing_brd_PRJCFG = prj_src/w7x_timing_brd_setup.tcl

.PHONY: linux
linux:
	$(MAKE) $(AM_MAKEFLAGS) -C linux all


clean-local::
	$(RM) -rf ip prj edit

mostly-clean::
	@$(RM) *_jou.tcl *.backup.tcl\
	;$(RM) -rf $(addprefix prj_src/,hw_handoff ip ipshared ui system.bxml system_ooc.xdc)

clean::
	@$(MAKE) $(AM_MAKEFLAGS) -C linux clean

all: linux cores projects bitstream
