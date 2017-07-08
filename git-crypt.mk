IN:=$(HOME)/.local
CO:=$(HOME)/co

$(IN)/bin/git-crypt: $(CO)/git-crypt-0.5.0/Makefile
	cd $(<D) && \
	CPLUS_INCLUDE_PATH=$(IN)/include:$$CPLUS_INCLUDE_PATH LIBRARY_PATH=$(IN)/lib:$$LIBRARY_PATH make install PREFIX=$(IN)

$(CO)/git-crypt-0.5.0/Makefile:
	wget https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.5.0.tar.gz -O $$(dirname $(@D))/git-crypt-0.5.0.tar.gz
	cd $$(dirname $(@D)) && tar xvzf git-crypt-0.5.0.tar.gz
	touch $@

