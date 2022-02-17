meta-intel_url = git://git.yoctoproject.org/meta-intel.git
meta-intel_rev ?= $(BASE)
build/layers/meta-intel:
	$(Q)$(call layer-unpack, $@, $(meta-intel_url), $(meta-intel_rev))
