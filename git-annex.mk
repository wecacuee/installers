CO?=$(HOME)/co/

$(HOME)/.local/bin/git-annex: $(CO)/git-annex/Setup.hs /usr/local/bin/stack
	cd $(<D) && stack setup
	cd $(<D) && stack install

$(CO)/git-annex/Setup.hs:
	cd $(CO)
	git clone git://git-annex.branchable.com/ git-annex
	touch $@

/usr/local/bin/stack:
	wget -qO- https://get.haskellstack.org/ | sh
