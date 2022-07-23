meta-openembedded_url = https://github.com/openembedded/meta-openembedded.git
meta-openembedded_rev ?= $(BASE)
$(BDIR)/layers/meta-openembedded/meta-filesystems: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-gnome: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-initramfs: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-networking: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-oe: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-perl: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-python: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded/meta-webserver: $(BDIR)/layers/meta-openembedded
$(BDIR)/layers/meta-openembedded:
	$(Q)$(call gitcache, $(meta-openembedded_url), $@, $(meta-openembedded_rev))
