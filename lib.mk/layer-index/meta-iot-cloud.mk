meta-iot-cloud_url = https://github.com/intel-iot-devkit/meta-iot-cloud.git
meta-iot-cloud_rev ?= $(BASE)
$(BDIR)/layers/meta-iot-cloud:
	$(Q)$(call gitcache, $(meta-iot-cloud_url), $@, $(meta-iot-cloud_rev))
