meta-cloud-services_url = git://git.yoctoproject.org/meta-cloud-services.git
meta-cloud-services_rev ?= $(BASE)
build/layers/meta-cloud-services/meta-openstack: build/layers/meta-cloud-services
build/layers/meta-cloud-services:
	$(Q)$(call gitcache, $(meta-cloud-services_url), $@, $(meta-cloud-services_rev))
