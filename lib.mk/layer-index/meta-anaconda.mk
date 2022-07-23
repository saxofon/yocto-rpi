meta-anaconda_url = git://git.yoctoproject.org/meta-anaconda
meta-anaconda_rev ?= $(BASE)
$(BDIR)/layers/meta-anaconda:
	$(Q)$(call gitcache, $(meta-anaconda_url), $@, $(meta-anaconda_rev))
