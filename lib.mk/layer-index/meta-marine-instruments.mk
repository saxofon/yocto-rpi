meta-marine-instruments_url = https://gitlab.com/saxofon/meta-marine-instruments.git
meta-marine-instruments_rev ?= master
$(BDIR)/layers/meta-marine-instruments:
	$(Q)$(call gitcache, $(meta-marine-instruments_url), $@, $(meta-marine-instruments_rev))
