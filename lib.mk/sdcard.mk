SDCARD_IMAGE ?= $(BDIR)/build/tmp/deploy/images/$(word 1,$(MACHINES))/$(word 1,$(IMAGES))-$(word 1,$(MACHINES)).rpi-sdimg
SDCARD_DEV ?= /dev/mmcblk0

sdcard-deploy:
	$(Q)for m in $$(lsblk -no mountpoints $(SDCARD_DEV)); do \
		umount $$m ; \
	done
	dd if=$(SDCARD_IMAGE) of=$(SDCARD_DEV) status=progress
