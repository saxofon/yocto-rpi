meta-anaconda_url = git://git.yoctoproject.org/meta-anaconda
meta-anaconda_rev ?= $(BASE)
build/layers/meta-anaconda:
	$(Q)$(call layer-unpack, $@, $(meta-anaconda_url), $(meta-anaconda_rev))
