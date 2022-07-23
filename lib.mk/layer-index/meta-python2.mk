meta-python2_url = git://git.openembedded.org/meta-python2
meta-python2_rev ?= $(BASE)
$(BDIR)/layers/meta-python2:
	$(Q)$(call gitcache, $(meta-python2_url), $@, $(meta-python2_rev))
