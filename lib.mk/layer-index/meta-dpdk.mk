meta-dpdk_url = git://git.yoctoproject.org/meta-dpdk.git
meta-dpdk_rev ?= $(BASE)
$(BDIR)/layers/meta-dpdk:
	$(Q)$(call gitcache, $(meta-dpdk_url), $@, $(meta-dpdk_rev))
