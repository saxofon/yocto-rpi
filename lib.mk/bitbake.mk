help:: bitbake.help

bitbake.help:
	$(Q)echo -e "\n--- bitbake ---"
	$(Q)echo -e "images                    : build all images for all machines"
	$(Q)echo -e "containers                : build all containers for all machines"
	$(Q)echo -e "bbs                       : start a bitbake shell to testdrive things manually"

define bitbake
	export MACHINE=$(1) ; \
	if [ -d $(BDIR) ]; then \
		cd $(BDIR) ; \
		source poky/oe-init-build-env ; \
	fi ; \
	bitbake $(2)
endef

define bitbake-task
	export MACHINE=$(1) ; \
	if [ -d $(BDIR) ]; then \
		cd $(BDIR) ; \
		source poky/oe-init-build-env ; \
	fi ; \
	bitbake $(2) -c $(3)
endef

define bitbake-layers
	export MACHINE=$(1) ; \
	if [ -d $(BDIR) ]; then \
		cd $(BDIR) ; \
		source poky/oe-init-build-env ; \
	fi ; \
	bitbake-layers $(2)
endef

bitbake-debug:
	echo $(LAYERS)

.PHONY: $(BDIR)/build
$(BDIR)/build: $(BDIR) $(LAYERS)
	$(Q)if [ ! -d $@ ]; then \
		layers="$(realpath $(LAYERS))" ; \
		cd $(BDIR) ; \
		source poky/oe-init-build-env ; \
		bitbake-layers add-layer -F $$layers ; \
		sed -i /^MACHINE/d conf/local.conf ; \
		sed -i /^DISTRO/d conf/local.conf ; \
		echo "DL_DIR = \"$(DOWNLOADS_CACHE)\"">> conf/local.conf ; \
		if [ $(SSTATE_MIRROR) ]; then \
			echo "SSTATE_MIRRORS = \"file://.* file://$(SSTATE_MIRROR)/PATH\"" >> conf/local.conf ; \
		fi ; \
	fi

images: $(BDIR)/build
ifneq ($(IMAGES),)
	$(Q)$(foreach MACHINE,$(MACHINES),$(call bitbake,$(MACHINE),$(IMAGES));)
endif

containers: $(BDIR)/build
ifneq ($(CONTAINERS),)
	$(Q)$(foreach MACHINE,$(MACHINES),$(call bitbake,$(MACHINE),$(CONTAINERS));)
endif

# When entering bitbake shell, default MACHINE to the first in list
bbs: $(BDIR)/build
	$(Q)cd $(BDIR) ; \
	export MACHINE=$(word 1,$(MACHINES)) ; \
	source poky/oe-init-build-env ; \
	bash || true

clean::
	$(RM) -r $(BDIR)/build
