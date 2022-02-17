MAKE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))

#BASE=honister
BASE=hardknott

define layer-unpack
	$(call gitcache, $(2), $(1))
	git -C $(1) checkout $(3)
endef

define layer-rev
	case $$(grep -w $$(basename $(1) .git) $(MAKE_PATH) | wc -l) in \
	  0) echo "# $$(basename $(1) .git) is a local project layer" ;;  \
	  1) master_layer="$$(grep -w $$(basename $(1) .git) $(MAKE_PATH) | cut -d: -f2)"; \
	     echo "# $$(basename $(1) .git) is an embedded layer in $$master_layer"; \
	     echo -n "$$(basename $$master_layer .git)_rev := "; \
	     echo $$(git -C $$master_layer rev-parse HEAD) ;; \
	  *) echo -n "$$(basename $(1) .git)_rev := "; \
	     echo $$(git -C $(1) rev-parse HEAD) ;; \
	esac
endef

layer-revisions:
	$(Q)$(foreach LAYER, build/poky $(LAYERS), $(call layer-rev, $(LAYER));)

update-layer-lock:
	$(Q)make layer-revisions | grep -v ^make | sort | uniq > $(TOP)/layer-versions.txt
	$(Q)if git diff --quiet layer-versions.txt; then \
		echo "layer-versions.txt changed, please commit updates" ;\
	fi

-include layer-index/*.mk
