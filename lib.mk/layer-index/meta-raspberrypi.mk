meta-raspberrypi_url = https://github.com/agherzan/meta-raspberrypi
meta-raspberrypi_rev ?= $(BASE)
$(BDIR)/layers/meta-raspberrypi:
	$(Q)$(call gitcache, $(meta-raspberrypi_url), $@, $(meta-raspberrypi_rev))
