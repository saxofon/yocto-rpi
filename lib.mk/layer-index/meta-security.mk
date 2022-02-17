meta-security_url = git://git.yoctoproject.org/meta-security.git
meta-security_rev ?= $(BASE)
build/layers/meta-security:
	$(Q)$(call gitcache, $(meta-security_url), $@, $(meta-security_rev))
