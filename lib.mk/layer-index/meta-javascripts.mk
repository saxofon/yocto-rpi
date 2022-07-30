meta-javascripts_url = https://gitlab.com/saxofon/meta-javascripts.git
meta-javascripts_rev ?= $(BASE)
$(BDIR)/layers/meta-javascripts:
	$(Q)$(call gitcache, $(meta-javascripts_url), $@, $(meta-javascripts_rev))
