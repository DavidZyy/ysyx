all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	# @echo "Write this Makefile by your self."
	verilator --trace --cc --exe --build -Wall sim_main.cpp top.v
	./obj_dir/Vtop


include ../Makefile
