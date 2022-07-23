meta-starlingx_url = https://opendev.org/starlingx/meta-starlingx.git
meta-starlingx_rev ?= $(BASE)
$(BDIR)/layers/meta-starlingx/meta-stx-cloud: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-distro: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-flock: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-integ: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx/meta-stx-virt: $(BDIR)/layers/meta-starlingx
$(BDIR)/layers/meta-starlingx:
	$(Q)$(call gitcache, $(meta-starlingx_url), $@, $(meta-starlingx_rev))
