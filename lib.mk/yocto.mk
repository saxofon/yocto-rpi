.PHONY: $(BDIR)
$(BDIR):
	$(Q)if [ ! -d $@ ]; then \
		mkdir -p $@/layers ; \
		cd $@ ; \
		$(call gitcache, $(POKY_URL), poky) ; \
		git -C poky checkout $(POKY_REV) ; \
	fi

clean::
	$(RM) -r $(BDIR)
