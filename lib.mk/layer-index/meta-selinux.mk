meta-selinux_url = git://git.yoctoproject.org/meta-selinux.git
meta-selinux_rev ?= $(BASE)
$(BDIR)/layers/meta-selinux:
	$(Q)$(call gitcache, $(meta-selinux_url), $@, $(meta-selinux_rev))
