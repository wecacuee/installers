# Is the host a flux machine?
isflux:=$(findstring arc-ts,$(shell hostname))

print-%: 
	@echo $* = $($*)
