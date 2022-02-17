meta-starlingx_url = https://opendev.org/starlingx/meta-starlingx.git
meta-starlingx_rev ?= $(BASE)
build/layers/meta-starlingx/meta-stx-cloud: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-distro: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-flock: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-integ: build/layers/meta-starlingx
build/layers/meta-starlingx/meta-stx-virt: build/layers/meta-starlingx
build/layers/meta-starlingx:
	$(Q)$(call gitcache, $(meta-starlingx_url), $@, $(meta-starlingx_rev))
