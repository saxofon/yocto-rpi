.PHONY: $(BDIR)
$(BDIR):
	$(Q)if [ ! -d $@ ]; then \
		mkdir -p $@/layers ; \
		cd $@ ; \
		$(call gitcache, $(poky_url), poky) ; \
		git -C poky checkout $(poky_rev) ; \
	fi

clean::
	$(RM) -r $(BDIR)
