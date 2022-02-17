meta-openembedded_url = https://github.com/openembedded/meta-openembedded.git
meta-openembedded_rev ?= $(BASE)
build/layers/meta-openembedded/meta-filesystems: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-gnome: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-initramfs: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-networking: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-oe: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-perl: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-python: build/layers/meta-openembedded
build/layers/meta-openembedded/meta-webserver: build/layers/meta-openembedded
build/layers/meta-openembedded:
	$(Q)$(call layer-unpack, $@, $(meta-openembedded_url), $(meta-openembedded_rev))
