$(BDIR)/poky:
	$(Q)if [ ! -d $@ ]; then \
		mkdir -p $@ ; \
		$(call gitcache, $(poky_url), $@, $(poky_rev)) ;\
	fi

clean::
	$(RM) -r $(BDIR)
