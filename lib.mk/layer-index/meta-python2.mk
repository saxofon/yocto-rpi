meta-python2_url = git://git.openembedded.org/meta-python2
meta-python2_rev ?= $(BASE)
build/layers/meta-python2:
	$(Q)$(call layer-unpack, $@, $(meta-python2_url), $(meta-python2_rev))
