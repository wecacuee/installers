include math.mk
DDIR?=$(HOME)/co/doc

all: $(DDIR)/make.html $(DDIR)/latex.pdf funcanalysis \
	$(DDIR)/reinforcement-learning-sutton-and-barto-2015.pdf

$(DDIR)/make.html: $(DDIR)/.mkdir
	wget https://www.gnu.org/software/make/manual/make.html -O $@
	touch $@

$(DDIR)/latex.pdf: $(DDIR)/.mkdir
	wget "http://users.softlab.ntua.gr/~sivann/books/LaTeX%20-%20User's%20Guide%20and%20Reference%20Manual-lamport94.pdf" -O $@
	touch $@

rangetwelve:=$(call m.seq,$(m.12))
.PHONY: funcanalysis
funcanalysis: $(DDIR)/funcanalysis/ch13.pdf
$(DDIR)/funcanalysis/ch13.pdf: $(foreach i , $(rangetwelve) , $(DDIR)/funcanalysis/ch$(i).pdf)

$(DDIR)/funcanalysis/%.pdf: $(DDIR)/funcanalysis/.mkdir
	wget https://www.math.ucdavis.edu/~hunter/book/$*.pdf -O $@
	touch $@

$(DDIR)/reinforcement-learning-sutton-and-barto-2015.pdf: $(DDIR)/.mkdir
	wget https://www.dropbox.com/s/b3psxv2r0ccmf80/book2015oct.pdf?dl=1 -O $@
	touch $@
