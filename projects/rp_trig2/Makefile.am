include $(top_srcdir)/Common.mk
include $(top_srcdir)/fpga/Common.mk

FPGA_REPO_DIR += $(top_builddir)/fpga/lib/red-pitaya-notes

maxThreads = 8

## CORES ##
VENDOR = rp
LIBRARY = ip
vivado_CORES = trig_1.0
#trig_VERSION = 1.0
trig_SOURCES = \
	src/rp_trig.vhd \
	src/rp_trig_axi.vhd \
	src/rp_trig_prog.vhd \
	src/rp_trig.xdc \
	src/rp_trig.mdd
trig_IPCFG = src/rp_trig_setup.tcl

## PROJECTS ##
vivado_PROJECTS = trig_brd
trig_brd_VERSION = 1.0
trig_brd_IP_SOURCES = trig_1.0
trig_brd_SOURCES = \
	src_prj/system.bd \
	src_prj/hdl/system_wrapper.v \
	src_prj/redpitaya.xdc
trig_brd_PRJCFG = src_prj/rp_trig_brd_setup.tcl

.PHONY: linux usermem
usermem:
	$(MAKE) $(AM_MAKEFLAGS) -C ../usermem all

linux: usermem
	$(MAKE) $(AM_MAKEFLAGS) -C linux clean all

mostly-clean::
	@$(RM) *_jou.tcl *.backup.tcl\
	;$(RM) -rf $(addprefix src_prj/,hw_handoff ip ipshared ui system.bxml system_ooc.xdc)

clean:: mostly-clean
	@$(MAKE) $(AM_MAKEFLAGS) -C linux clean

clean-local:: clean
	@$(RM) -rf ip prj edit

all: linux cores projects bitstream


cores:
	@rm -rf ip/vivado/rp_trig_1.0/src \
	&& ln -sfT  ../../../src  ip/vivado/rp_trig_1.0/src
