include $(top_srcdir)/Common.mk

OUT = $(DTS) $(DTB)

DTC ?= dtc
DTS = devicetree.dts
DTB = devicetree.dtb
DTSI = dts/user512.dtsi
DTRAW = dts/dtraw.dts

$(DTS):	$(DTRAW)
	@(cat $(DTRAW);echo '/include/ "$(DTSI)"') | $(DTC) -I dts -O dts -o $@ -

$(DTB):	$(DTS)
	@$(DTC) -I dts -O dtb -o $@ $< 


.PHONY: linux dts dtb
dts: $(DTS)
	@
dtb: $(DTB)
	@
linux:
	$(MAKE) $(AM_MAKEFLAGS) -C linux clean all

clean::
	@$(RM) $(OUT);$(MAKE) -C linux clean

all: dtb linux
