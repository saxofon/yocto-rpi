#BASE=honister
BASE=hardknott

define layer-rev
	case $$(grep -w $$(basename $(1) .git) lib.mk/layer-index/*.mk | wc -l) in \
	  0) echo "# $$(basename $(1) .git) is a local project layer" ;;  \
	  1) master_layer="$$(grep -w $$(basename $(1) .git) lib.mk/layer-index/*.mk | cut -d: -f3 | sed s#\$$\(BDIR\)#$(BDIR)#g)"; \
	     echo "# $$(basename $(1) .git) is an embedded layer in $$(basename $$master_layer)"; \
	     echo -n "$$(basename $$master_layer .git)_rev := "; \
	     echo $$(git -C $$master_layer rev-parse HEAD) ;; \
	  *) echo -n "$$(basename $(1) .git)_rev := "; \
	     echo $$(git -C $(1) rev-parse HEAD) ;; \
	esac
endef

layer-revisions:
	$(Q)echo "poky_rev := $(shell git -C $(BDIR)/poky rev-parse HEAD)"
	$(Q)$(foreach LAYER, $(LAYERS), $(call layer-rev, $(LAYER));)

update-layer-lock:
	$(Q)make layer-revisions | grep -v ^make | sort | uniq > $(TOP)/layer-versions.txt
	$(Q)if git diff --quiet layer-versions.txt; then \
		echo "layer-versions.txt changed, please commit updates" ;\
	fi

-include lib.mk/layer-index/*.mk
