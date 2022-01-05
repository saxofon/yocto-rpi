define layer-unpack
	$(call gitcache, $(2), $(1))
	git -C $(1) checkout $(3)
endef

layer-revisions:
	$(foreach LAYER,$(LAYERS),git -C $(LAYER) rev-parse HEAD;)

#BASE=honister
BASE=hardknott

POKY_URL = git://git.yoctoproject.org/poky.git
#POKY_URL = https://git.yoctoproject.org/git/poky
#POKY_REV ?= yocto-3.4
POKY_REV ?= $(BASE)

OPENEMBEDDED_URL = https://github.com/openembedded/meta-openembedded.git
OPENEMBEDDED_REV ?= $(BASE)
$(BDIR)/layers/meta-openembedded/meta-filesystems: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-gnome: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-initramfs: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-networking: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-oe: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-perl: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-python: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-webserver: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded:
	$(Q)$(call layer-unpack, $@, $(OPENEMBEDDED_URL), $(OPENEMBEDDED_REV))

PYTHON2_URL = git://git.openembedded.org/meta-python2
PYTHON2_REV ?= $(BASE)
$(BDIR)/layers/meta-python2:
	$(Q)$(call layer-unpack, $@, $(PYTHON2_URL), $(PYTHON2_REV))

SWUPDATE_URL = https://github.com/sbabic/meta-swupdate.git
SWUPDATE_REV ?= $(BASE)
$(BDIR)/layers/meta-swupdate:
	$(Q)$(call layer-unpack, $@, $(SWUPDATE_URL), $(SWUPDATE_REV))

SWUPDATE_BOARDS_URL = https://github.com/sbabic/meta-swupdate-boards.git
SWUPDATE_BOARDS_REV ?= $(BASE)
$(BDIR)/layers/meta-swupdate-boards:
	$(Q)$(call layer-unpack, $@, $(SWUPDATE_BOARDS_URL), $(SWUPDATE_BOARDS_REV))
	sed -i s/honister/honister\ hardknott/g build/layers/meta-swupdate-boards/conf/layer.conf

VIRTUALIZATION_URL = git://git.yoctoproject.org/meta-virtualization.git
VIRTUALIZATION_REV ?= $(BASE)
$(BDIR)/layers/meta-virtualization:
	$(Q)$(call layer-unpack, $@, $(VIRTUALIZATION_URL), $(VIRTUALIZATION_REV))

CLOUDSERVICES_URL = git://git.yoctoproject.org/meta-cloud-services.git
CLOUDSERVICES_REV ?= $(BASE)
$(BDIR)/layers/meta-cloud-services/meta-openstack: $(BDIR)/layers/meta-cloud-services
$(BDIR)/layers/meta-cloud-services:
	$(Q)$(call layer-unpack, $@, $(CLOUDSERVICES_URL), $(CLOUDSERVICES_REV))

ANACONDA_URL = git://git.yoctoproject.org/meta-anaconda
ANACONDA_REV ?= $(BASE)
$(BDIR)/layers/meta-anaconda:
	$(Q)$(call layer-unpack, $@, $(ANACONDA_URL), $(ANACONDA_REV))

INTEL_URL = git://git.yoctoproject.org/meta-intel.git
INTEL_REV ?= $(BASE)
$(BDIR)/layers/meta-intel:
	$(Q)$(call layer-unpack, $@, $(INTEL_URL), $(INTEL_REV))

DPDK_URL = git://git.yoctoproject.org/meta-dpdk.git
DPDK_REV ?= $(BASE)
$(BDIR)/layers/meta-dpdk:
	$(Q)$(call layer-unpack, $@, $(DPDK_URL), $(DPDK_REV))

SECURITY_URL = git://git.yoctoproject.org/meta-security.git
SECURITY_REV ?= $(BASE)
$(BDIR)/layers/meta-security:
	$(Q)$(call layer-unpack, $@, $(SECURITY_URL), $(SECURITY_REV))

SELINUX_URL = git://git.yoctoproject.org/meta-selinux.git
SELINUX_REV ?= $(BASE)
$(BDIR)/layers/meta-selinux:
	$(Q)$(call layer-unpack, $@, $(SELINUX_URL), $(SELINUX_REV))

IOTCLOUD_URL = https://github.com/intel-iot-devkit/meta-iot-cloud.git
IOTCLOUD_REV ?= $(BASE)
$(BDIR)/layers/meta-iot-cloud:
	$(Q)$(call layer-unpack, $@, $(IOTCLOUD_URL), $(IOTCLOUD_REV))

STX_URL = https://opendev.org/starlingx/meta-starlingx.git
STARLINGX_REV ?= $(BASE)
$(BDIR)/layers/meta-starlingx/meta-stx-cloud: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-distro: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-flock: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-integ: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-virt: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx:
	$(Q)$(call layer-unpack, $@, $(STX_URL), $(STARLINGX_REV))

RASPBERRYPI_URL = https://github.com/agherzan/meta-raspberrypi
RASPBERRYPI_REV ?= $(BASE)
$(BDIR)/layers/meta-raspberrypi:
	$(Q)$(call layer-unpack, $@, $(RASPBERRYPI_URL), $(RASPBERRYPI_REV))

QT5_URL = https://github.com/meta-qt5/meta-qt5.git
QT5_REV ?= $(BASE)
$(BDIR)/layers/meta-qt5:
	$(Q)$(call layer-unpack, $@, $(QT5_URL), $(QT5_REV))
