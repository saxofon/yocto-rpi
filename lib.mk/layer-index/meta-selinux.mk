meta-selinux_url = git://git.yoctoproject.org/meta-selinux.git
meta-selinux_rev ?= $(BASE)
build/layers/meta-selinux:
	$(Q)$(call layer-unpack, $@, $(meta-selinux_url), $(meta-selinux_rev))
