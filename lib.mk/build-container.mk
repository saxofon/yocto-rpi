BUILD_CONTAINER_IMAGE ?= docker.io/saxofon/yocto-builder:0.8
BUILD_CONTAINER ?= yocto-builder

help:: build-container-help

build-container-help:
	@echo -e "\n--- build container ---"
	@echo -e " build-container-image          : build container image"
	@echo -e " build-container-start          : start container"
	@echo -e " build-container-shell          : gives a bash shell running inside build container"
	@echo -e " build-container-stop           : stops the build container"
	

build-container-image:
	docker build --no-cache -f dockerfiles/yocto-builder -t $(BUILD_CONTAINER_IMAGE) dockerfiles

#		-v $(DOWNLOADS_CACHE):/cache/downloads:shared,Z \
#		-v $(SSTATE_MIRROR):/cache/sstate-mirror:shared \
#
build-container-start:
	$(Q)docker run --rm -d --name $(BUILD_CONTAINER) -u builder \
		-v $(PWD):/src:Z \
		--mount type=volume,src=yocto-rpi-build,target=/src/build \
		--mount type=volume,src=yocto-rpi-cache,target=/cache \
		-it $(BUILD_CONTAINER_IMAGE) /bin/bash

build-container-shell:
	$(Q)docker exec -u builder -w /src -e LANG=en_US.UTF-8 -it $(BUILD_CONTAINER) /bin/bash

build-container-root-shell:
	$(Q)docker exec -u 0:0 -w /root -e LANG=en_US.UTF-8 -it $(BUILD_CONTAINER) /bin/bash

build-container-exec:
	$(Q)docker exec -u builder -w /src -e LANG=en_US.UTF-8 -it $(BUILD_CONTAINER) $(CMD)

build-container-stop:
	$(Q)docker stop $(BUILD_CONTAINER)
