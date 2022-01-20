IMG_raspberrypi0-wifi ?= build/build/tmp/deploy/images/raspberrypi0-wifi/core-image-full-cmdline-raspberrypi0-wifi.rpi-sdimg

qemu-run: qemu-$(word 1,$(MACHINES))

qemu-raspberrypi0-wifi:
	qemu-img resize $(IMG_raspberrypi0-wifi) 512M
	qemu-system-arm -machine raspi0 -nographic \
		-dtb build/build/tmp/deploy/images/raspberrypi0-wifi/bcm2708-rpi-zero-w.dtb \
		-kernel build/build/tmp/deploy/images/raspberrypi0-wifi/uImage -sd $(IMG_raspberrypi0-wifi) \
		-append "printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0 initcall_blacklist=bcm2835_pm_driver_init rootwait root=/dev/mmcblk0p2"
