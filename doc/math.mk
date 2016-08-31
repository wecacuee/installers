#######################
# Whole number library
# Each number is represented by the number of space separated dots
#######################
m.zero:=
m.one:=.
m.two:=. .
m.five:=. . . . .

m.double=$1 $1
m.treble=$1 $1 $1
m.quadruple=$1 $1 $1 $1
m.add=$1 $2

m.ten=$(call m.double,$(m.five))
m.fifty=$(call m.add,$(call m.quadruple,$(m.ten)), $(m.ten))

m.numeral=$(words $1)

# increment
m.++=$(call m.add,$1,$(m.one))

# decrement
m.--=$(wordlist 2,$(words $1),$1)

# test case
test.m.--:= $(if $(filter-out . . .,$(call m.--,. . . .)), \
	$(error "Expected '. . .', Got " $(cal m.--,. . . .)), \
	)

# m.decrement
m.--=$(wordlist 2,$(words $1),$1)


# sequence
seq=$(if $1,$(call seq,$(call m.--, $1)) $(words $1),)

# test seqeunce function
test.m.seq:=$(if $(filter-out 1 2 3 4 5 6 7 8 9 10 11 12,$(testtwelveseq)), \
	$(error "Got " $(testtwelveseq)), \
	)

%/.mkdir:
	mkdir -p $(@D)

# Print any variable
print-%: 
	@echo $* = $($*)
