meta-iot-cloud_url = https://github.com/intel-iot-devkit/meta-iot-cloud.git
meta-iot-cloud_rev ?= $(BASE)
build/layers/meta-iot-cloud:
	$(Q)$(call layer-unpack, $@, $(meta-iot-cloud_url), $(meta-iot-cloud_rev))
