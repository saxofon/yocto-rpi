# Yocto for RPi
#
# Author : Per Hallsmark <per@hallsmark.se>
#

SHELL		:= /bin/bash
TOP 		:= $(shell pwd)
BDIR            := /build

# Define V=1 to echo everything
V ?= 0
ifneq ($(V),1)
	Q=@
endif

all: help

help:: top-help

# Optional configuration
-include hostconfig-$(HOSTNAME).mk
-include userconfig-$(USER).mk
-include layer-versions.txt

MACHINES += raspberrypi4-64
#MACHINES += raspberrypi0-wifi

IMAGES += core-image-full-cmdline

LAYERS += $(BDIR)/layers/meta-javascripts
LAYERS += $(BDIR)/layers/meta-marine-instruments
LAYERS += $(BDIR)/layers/meta-openembedded/meta-filesystems
LAYERS += $(BDIR)/layers/meta-openembedded/meta-initramfs
LAYERS += $(BDIR)/layers/meta-openembedded/meta-networking
LAYERS += $(BDIR)/layers/meta-openembedded/meta-oe
LAYERS += $(BDIR)/layers/meta-openembedded/meta-perl
LAYERS += $(BDIR)/layers/meta-openembedded/meta-python
LAYERS += $(BDIR)/layers/meta-raspberrypi

LAYERS += $(TOP)/layers/meta-project-setup

# Include any additional Makefile components
-include $(TOP)/lib.mk/*.mk

clean::

distclean:: clean

top-help:
	@echo -e "\n--- top Makefile ---"
#	@echo -e "template-target           : template text"
