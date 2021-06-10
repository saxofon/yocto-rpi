help:: sdk-help

sdk-help:
	$(Q)echo -e "\n--- sdk ---"
	$(Q)echo -e "sdk                       : builds a sdk"
	$(Q)echo -e "esdk                      : builds a esdk"
	$(Q)echo -e "sdk-install               : installs the sdk"
	$(Q)echo -e "sdk-clean                 : removes any installed sdk"

SDK_FILE=$(BDIR)/build/tmp-glibc/deploy/sdk/*-sdk.sh
SDK_ENV=$(BDIR)/sdk/environment-setup-*

sdk: $(BDIR)/build
	$(call bitbake-task, $(IMAGE), populate_sdk)

esdk: $(BDIR)/build
	$(call bitbake-task, $(IMAGE), populate_sdk_ext)

sdk-install:
	$(SDK_FILE) -y -d $(BDIR)/sdk
	$(MAKE) -C $(BDIR)/sdk/sysroots/*-wrs-linux/usr/src/kernel scripts

sdk-clean:
	$(Q)$(RM) -r $(BDIR)/sdk
