
include $(top_srcdir)/Common.mk

AM_MAKEFLAGS = -j$(MAKE_PROCESS)
AM_CPPFLAGS  = -lpthread

O := $(abs_srcdir)/..

MODULES = usermem
TEST_EXAMPLES = usermem
RUN_LIBRARY =

MOSTLYCLEANFILES = $(TEST_EXAMPLES) $(RUN_LIBRARY_SO)

.PHONY: modules
modules: $(MODULES:=.c) Kbuild
	@ echo " --- building modules ---"; \
	$(_set_export); \
	  $(MAKE) $(AM_MAKEFLAGS) -C ${LINUX_SRCDIR} \
	  CFLAGS="$(LINUX_CFLAGS)" M=$$PWD O=$$O \
	  srcdir=$(srcdir) builddir=$(builddir) modules

clean-local:
	@ echo " --- cleaning modules ---"; \
	$(_set_export); \
	$(MAKE) $(AM_MAKEFLAGS) -C ${LINUX_SRCDIR} \
	     CFLAGS="$(LINUX_CFLAGS)" M=$$PWD O=$$O \
	     srcdir=$(srcdir) builddir=$(builddir) clean

.PHONY: test_examples
test_examples: $(TEST_EXAMPLES)
$(TEST_EXAMPLES):
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(LINUX_CFLAGS) $(srcdir)/$@_test.c -o $@ -lpthread -O2

.PHONY: run_library
run_library: $(RUN_LIBRARY_SO)
RUN_LIBRARY_SO = $(addprefix lib,$(RUN_LIBRARY:=.so))
$(RUN_LIBRARY_SO): lib%.so: %_lib.c
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(LINUX_CFLAGS) $(srcdir)/$< -fPIC -o $@ -O2 -shared

.PHONY: deploy
deploy: $(MODULES:=.ko) $(TEST_EXAMPLES)
if WITH_DEVICE_SSHKEY
	@ echo " --- deploying modules to target device: ${DEVICE_NAME} using key ---";
	scp -i $(DEVICE_SSHKEY) $^ \
	  $(DEVICE_USER)@$(DEVICE_IP):$(DEVICE_MODULES_DIR);
else
if WITH_DEVICE_SSHPASSWD
	@ echo " --- deploying modules to target device: ${DEVICE_NAME} using passwd ---";
	sshpass -p ${DEVICE_PASSWD} scp $^ \
	  $(DEVICE_USER)@$(DEVICE_IP):$(DEVICE_MODULES_DIR);
endif
endif

all: modules test_examples run_library
