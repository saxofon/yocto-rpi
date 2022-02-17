meta-virtualization_url = git://git.yoctoproject.org/meta-virtualization.git
meta-virtualization_rev ?= $(BASE)
build/layers/meta-virtualization:
	$(Q)$(call layer-unpack, $@, $(meta-virtualization_url), $(meta-virtualization_rev))
