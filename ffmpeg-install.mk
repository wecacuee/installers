TMPDIR:=$(HOME)/co/
SHELL:=/bin/bash
FFMPEG_INSDIR:=/z/sw/packages/ffmpeg/2.2.3
.ONESHELL:
$(FFMPEG_INSDIR)/bin/ffmpeg: $(TMPDIR)/ffmpeg-2.2.3/configure
	cd $(TMPDIR)/ffmpeg-2.2.3
	./configure --enable-gpl --prefix=$(FFMPEG_INSDIR) --enable-shared
	$(MAKE)
	$(MAKE) install

$(TMPDIR)/ffmpeg-2.2.3/configure: $(TMPDIR)/ffmpeg-2.2.3.tar.gz
	cd $(TMPDIR)/
	tar -zxvf ffmpeg-2.2.3.tar.gz
	touch $@

$(TMPDIR)/ffmpeg-2.2.3.tar.gz:
	cd $(TMPDIR)
	wget http://www.ffmpeg.org/releases/ffmpeg-2.2.3.tar.gz -O $@
