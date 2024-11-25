help:: sstate-help

sstate-help:
	$(Q)echo -e "\n--- sstate ---"

sstate-export:
	#docker run --rm -v sstate-cache.tar.gz:/" -v "$directory:/dest" alpine:latest tar cvaf "/dest/$filename" -C /source .

sstate-import:
	#docker run --rm -v "$3:/dest" -v "$directory:/source" alpine:latest tar xvf "/source/$filename" -C /dest

distclean::
