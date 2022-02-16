MAKE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))

#BASE=honister
BASE=hardknott

define layer-unpack
	$(call gitcache, $(2), $(1))
	git -C $(1) checkout $(3)
endef

define layer-rev
	case $$(grep -w $$(basename $(1) .git) $(MAKE_PATH) | wc -l) in \
	  0) echo "# $$(basename $(1) .git) is a local project layer" ;;  \
	  1) master_layer="$$(grep -w $$(basename $(1) .git) $(MAKE_PATH) | cut -d: -f2)"; \
	     echo "# $$(basename $(1) .git) is an embedded layer in $$master_layer"; \
	     echo -n "$$(basename $$master_layer .git)_rev := "; \
	     echo $$(git -C $$master_layer rev-parse HEAD) ;; \
	  *) echo -n "$$(basename $(1) .git)_rev := "; \
	     echo $$(git -C $(1) rev-parse HEAD) ;; \
	esac
endef

layer-revisions:
	$(Q)$(foreach LAYER, build/poky $(LAYERS), $(call layer-rev, $(LAYER));)

update-layer-lock:
	$(Q)make layer-revisions | grep -v ^make | sort | uniq > $(TOP)/layer-versions.txt
	$(Q)if git diff --quiet layer-versions.txt; then \
		echo "layer-versions.txt changed, please commit updates" ;\
	fi

poky_url = git://git.yoctoproject.org/poky.git
poky_rev ?= $(BASE)

meta-openembedded_url = https://github.com/openembedded/meta-openembedded.git
meta-openembedded_rev ?= $(BASE)
build/layers/meta-openembedded/meta-filesystems: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-gnome: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-initramfs: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-networking: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-oe: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-perl: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-python: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-webserver: build/layers/meta-openembedded
build/layers/meta-openembedded:
	$(Q)$(call layer-unpack, $@, $(meta-openembedded_url), $(meta-openembedded_rev))

meta-python2_url = git://git.openembedded.org/meta-python2
meta-python2_rev ?= $(BASE)
build/layers/meta-python2:
	$(Q)$(call layer-unpack, $@, $(meta-python2_url), $(meta-python2_rev))

meta-virtualization_url = git://git.yoctoproject.org/meta-virtualization.git
meta-virtualization_rev ?= $(BASE)
build/layers/meta-virtualization:
	$(Q)$(call layer-unpack, $@, $(meta-virtualization_url), $(meta-virtualization_rev))

meta-cloud-services_url = git://git.yoctoproject.org/meta-cloud-services.git
meta-cloud-services_rev ?= $(BASE)
build/layers/meta-cloud-services/meta-openstack: build/layers/meta-cloud-services
build/layers/meta-cloud-services:
	$(Q)$(call layer-unpack, $@, $(meta-cloud-services_url), $(meta-cloud-services_rev))

meta-anaconda_url = git://git.yoctoproject.org/meta-anaconda
meta-anaconda_rev ?= $(BASE)
build/layers/meta-anaconda:
	$(Q)$(call layer-unpack, $@, $(meta-anaconda_url), $(meta-anaconda_rev))

meta-intel_url = git://git.yoctoproject.org/meta-intel.git
meta-intel_rev ?= $(BASE)
build/layers/meta-intel:
	$(Q)$(call layer-unpack, $@, $(meta-intel_url), $(meta-intel_rev))

meta-dpdk_url = git://git.yoctoproject.org/meta-dpdk.git
meta-dpdk_rev ?= $(BASE)
build/layers/meta-dpdk:
	$(Q)$(call layer-unpack, $@, $(meta-dpdk_url), $(meta-dpdk_rev))

meta-security_url = git://git.yoctoproject.org/meta-security.git
meta-security_rev ?= $(BASE)
build/layers/meta-security:
	$(Q)$(call layer-unpack, $@, $(meta-security_url), $(meta-security_rev))

meta-selinux_url = git://git.yoctoproject.org/meta-selinux.git
meta-selinux_rev ?= $(BASE)
build/layers/meta-selinux:
	$(Q)$(call layer-unpack, $@, $(meta-selinux_url), $(meta-selinux_rev))

meta-iot-cloud_url = https://github.com/intel-iot-devkit/meta-iot-cloud.git
meta-iot-cloud_rev ?= $(BASE)
build/layers/meta-iot-cloud:
	$(Q)$(call layer-unpack, $@, $(meta-iot-cloud_url), $(meta-iot-cloud_rev))

meta-starlingx_url = https://opendev.org/starlingx/meta-starlingx.git
meta-starlingx_rev ?= $(BASE)
build/layers/meta-starlingx/meta-stx-cloud: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-distro: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-flock: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-integ: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-virt: build/layers/meta-starlingx
build/layers/meta-starlingx:
	$(Q)$(call layer-unpack, $@, $(meta-starlingx_url), $(meta-starlingx_rev))

meta-raspberrypi_url = https://github.com/agherzan/meta-raspberrypi
meta-raspberrypi_rev ?= $(BASE)
build/layers/meta-raspberrypi:
	$(Q)$(call layer-unpack, $@, $(meta-raspberrypi_url), $(meta-raspberrypi_rev))

meta-rauc_url = https://github.com/rauc/meta-rauc
meta-rauc_rev ?= $(BASE)
build/layers/meta-rauc:
	$(Q)$(call layer-unpack, $@, $(meta-rauc_url), $(meta-rauc_rev))

meta-qt5_url = https://github.com/meta-qt5/meta-qt5.git
meta-qt5_rev ?= $(BASE)
build/layers/meta-qt5:
	$(Q)$(call layer-unpack, $@, $(meta-qt5_url), $(meta-qt5_rev))
