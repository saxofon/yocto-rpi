meta-raspberrypi_url = https://github.com/agherzan/meta-raspberrypi
meta-raspberrypi_rev ?= $(BASE)
build/layers/meta-raspberrypi:
	$(Q)$(call layer-unpack, $@, $(meta-raspberrypi_url), $(meta-raspberrypi_rev))
