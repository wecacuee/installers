IP=/z/sw/packages/miniconda3/4.5.1
URL=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
PKG=Miniconda3-latest-Linux-x86_64

$(IP)/bin/conda:
	chmod +x /tmp/$(PKG).sh
	/tmp/$(PKG).sh -b -s -p $(IP) -f

/tmp/$(PKG).sh:
	wget $(URL) -O $@
