meta-cloud-services_url = git://git.yoctoproject.org/meta-cloud-services.git
meta-cloud-services_rev ?= $(BASE)
$(BDIR)/layers/meta-cloud-services/meta-openstack: $(BDIR)/layers/meta-cloud-services
$(BDIR)/layers/meta-cloud-services:
	$(Q)$(call gitcache, $(meta-cloud-services_url), $@, $(meta-cloud-services_rev))
