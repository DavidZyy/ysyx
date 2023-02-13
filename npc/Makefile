TOPNAME = top
NXDC_FILES = constr/top.nxdc
INC_PATH ?=

INCLUDE = $(abspath ./vsrc/include)

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert -I$(INCLUDE)

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_pin_bind.cpp)

$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
# CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS = $(abspath ./csrc/main.cpp)
CSRCS += $(SRC_AUTO_BIND)

# $(error $(CSRCS))

# NVBOARD_HOME : environment variable .
include $(NVBOARD_HOME)/scripts/nvboard.mk


# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	verilator --top-module $(TOPNAME) --trace --cc --exe --build -Wall $(abspath ./csrc/sim_main.cpp) $(VSRCS)
	obj_dir/Vtop
	gtkwave dump.vcd

include ../Makefile

# run:
# 	verilator --trace --cc --exe --build -Wall sim_main.cpp top.v
# 	./obj_dir/Vtop


# compile all things into one (compile into "build/top")

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all: default

# @build/top
run: $(BIN)
	@$<

clean:
	rm -rf logs obj_dir $(BUILD_DIR) *.vcd

.PHONY: default all clean run
