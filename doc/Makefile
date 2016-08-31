DDIR?=$(HOME)/co/doc

all: $(DDIR)/make.html $(DDIR)/latex.pdf

$(DDIR)/make.html: $(DDIR)/.mkdir
	wget https://www.gnu.org/software/make/manual/make.html -O $@
	touch $@

$(DDIR)/latex.pdf: $(DDIR)/.mkdir
	wget "http://users.softlab.ntua.gr/~sivann/books/LaTeX%20-%20User's%20Guide%20and%20Reference%20Manual-lamport94.pdf" -O $@
	touch $@

%/.mkdir:
	mkdir -p $(@D)
