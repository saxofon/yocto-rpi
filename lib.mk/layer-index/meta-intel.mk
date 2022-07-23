meta-intel_url = git://git.yoctoproject.org/meta-intel.git
meta-intel_rev ?= $(BASE)
$(BDIR)/layers/meta-intel:
	$(Q)$(call gitcache, $(meta-intel_url), $@, $(meta-intel_rev))
