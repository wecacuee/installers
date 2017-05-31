#######################
# Whole number library
# Each number is represented by the number of space separated dots
#######################
m.0:=
m.1:=.
m.2:=. .
m.3:=. . .
m.4:=. . . .
m.5:=. . . . .

m.2x=$1 $1
m.3x=$1 $1 $1
m.4x=$1 $1 $1 $1
m.10x=$1 $1 $1 $1 $1 $1 $1 $1 $1 $1
m.add=$1 $2

m.10:=$(call m.2x,$(m.5))
m.50=$(call m.add,$(call m.4x,$(m.10)), $(m.10))

# increment
m.inc=$(call m.add,$1,$(m.1))

# decrement
m.dec=$(wordlist 2,$(words $1),$1)

# from internal number representation to decimal
m.tonumeral=$(words $1)

# sequence
m.seq=$(if $1,$(call m.seq,$(call m.dec, $1)) $(words $1),)

# reverse head
m.rhead=$(lastword $1)

# reverse tail
m.rtail=$(wordlist 1,$(words $(call m.dec,$1)),$1)

# is the argument less than or equal to a single word (no space)
_issingleword=$(filter-out $(firstword $1),$(lastword $1))

# internal representation from a single decimal digit
m.from_digit=$(wordlist 1,$1,$(m.10))

m._from_digit_rhead=$(call m.from_digit, $(call m.rhead,$1))

# Convert a space separated decimal to the internal representation
m.from_spaced_decimal=$(if  \
	 $(call _issingleword, $1) \
	, $(call m.add \
		, $(call m.10x \
			, $(call m.from_spaced_decimal, $(call m.rtail, $1))) \
		, $(call m._from_digit_rhead, $1)) \
	, $(call m.from_digit,$1))

#######################
# Unit Test Cases
#######################

test.m.rhead:=$(if \
	$(filter-out,2,$(call m.rhead,1 0 0 0 2)) \
	, $(error "Got:" $(call m.rhead,1 0 0 0 2)) \
	,pass)

test.m.rtail:=$(if \
	$(filter-out,1 0 0 0,$(call m.rtail,1 0 0 0 2)) \
	, $(error "Got:" $(call m.rtail,1 0 0 0 2)) \
	,pass)

test._issingleword:=$(if $(call _issingleword,1 0),pass, $(error "error"))

m.100=$(call m.10x,$(m.10))
test.m.from_spaced_decimal:=$(if \
	$(filter-out $(m.100) \
		, $(call m.from_spaced_decimal,1 0 0)) \
	, $(error "Got:" $(call m.from_spaced_decimal,1 0 0)) \
	, pass)

test.m.from_digit:=$(if \
	$(filter-out $(call m.add,$(m.5),$(m.4)), $(call m.from_digit,9)) \
	, $(error "Got: " $(call m.from_digit,9)) \
	, pass)

test.m._from_digit_rhead:=$(if \
	$(filter-out $(call m.add,$(m.5),$(m.4)), $(call m.from_digit,9)) \
	, $(error "Got: " $(call m.from_digit,9)) \
	, pass)

# test case
test.m.dec:= $(if $(filter-out . . .,$(call m.dec,. . . .)), \
	$(error "Expected '. . .', Got " $(cal m.dec,. . . .)), \
	)

# test seqeunce function
m.12:=$(call m.add,$(m.10),$(m.2))
testtwelveseq:=$(call m.seq,$(m.12))
test.m.seq:=$(if $(filter-out 1 2 3 4 5 6 7 8 9 10 11 12,$(testtwelveseq)), \
	$(error "Got " $(testtwelveseq)), \
	pass)

%/.mkdir:
	mkdir -p $(@D)
	touch $@

# Print any variable
.PHONY: print-%
print-%: 
	@echo $* = $($*)
