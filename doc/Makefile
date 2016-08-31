include math.mk
DDIR?=$(HOME)/co/doc

all: $(DDIR)/make.html $(DDIR)/latex.pdf

$(DDIR)/make.html: $(DDIR)/.mkdir
	wget https://www.gnu.org/software/make/manual/make.html -O $@
	touch $@

$(DDIR)/latex.pdf: $(DDIR)/.mkdir
	wget "http://users.softlab.ntua.gr/~sivann/books/LaTeX%20-%20User's%20Guide%20and%20Reference%20Manual-lamport94.pdf" -O $@
	touch $@

twelve:=$(call m.add,$(m.ten),$(call m.double,$(m.one)))
rangetwelve:=$(call seq,$(twelve))
.PHONY: funcanalysis
funcanalysis: $(DDIR)/funcanalysis/ch13.pdf
$(DDIR)/funcanalysis/ch13.pdf: $(foreach i , $(rangetwelve) , $(DDIR)/funcanalysis/ch$(i).pdf)

$(DDIR)/funcanalysis/%.pdf: $(DDIR)/funcanalysis/.mkdir
	wget https://www.math.ucdavis.edu/~hunter/book/$*.pdf -O $@
	touch $@

