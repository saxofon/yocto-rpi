meta-qt5_url = https://github.com/meta-qt5/meta-qt5.git
meta-qt5_rev ?= $(BASE)
build/layers/meta-qt5:
	$(Q)$(call gitcache, $(meta-qt5_url), $@, $(meta-qt5_rev))
