ADIR ?= $(TOP)/artifacts

artifacts-store:
	for a in $(ARTIFACTS); do \
		rsync --copy-links $$a $(ADIR) ; \
	done
