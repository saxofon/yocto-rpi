meta-dpdk_url = git://git.yoctoproject.org/meta-dpdk.git
meta-dpdk_rev ?= $(BASE)
build/layers/meta-dpdk:
	$(Q)$(call layer-unpack, $@, $(meta-dpdk_url), $(meta-dpdk_rev))
