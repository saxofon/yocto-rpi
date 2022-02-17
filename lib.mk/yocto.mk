build/poky:
	$(Q)if [ ! -d $@ ]; then \
		mkdir -p build/layers ; \
		$(call gitcache, $(poky_url), $@, $(poky_rev)) ;\
	fi

clean::
	$(RM) -r $(BDIR)
