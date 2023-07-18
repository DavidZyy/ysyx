.DEFAULT_GOAL = app

# Add necessary options if the target is a shared library
ifeq ($(SHARE),1)
SO = -so
CFLAGS  += -fPIC
LDFLAGS += -rdynamic -shared -fPIC
endif

WORK_DIR  = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build

INC_PATH := $(WORK_DIR)/include $(INC_PATH)
OBJ_DIR  = $(BUILD_DIR)/obj-$(NAME)$(SO)
BINARY   = $(BUILD_DIR)/$(NAME)$(SO)

# Compilation flags
ifeq ($(CC),clang)
CXX := clang++
else
CXX := g++
endif
LD := $(CXX)
INCLUDES = $(addprefix -I, $(INC_PATH))
# add -g
# CFLAGS  := -O2 -MMD -Wall -Werror $(INCLUDES) $(CFLAGS) -g
# not optimized out
CFLAGS  := -O0 -MMD -Wall -Werror $(INCLUDES) $(CFLAGS) -g
LDFLAGS := -O2 $(LDFLAGS)

# $(error $(SRCS))

# find the file which include this .mk(native.mk), and native.mk is included by nemu/Makefile,
# where SRCS is defined.
OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o) $(CXXSRC:%.cc=$(OBJ_DIR)/%.o)


# new added 
PRES = $(SRCS:%.c=$(OBJ_DIR)/%.i)

$(OBJ_DIR)/%.i: %.c
	@$(CC) $(INCLUDES) -E -P $< -o $@

# print OBJS value
# $(error $(OBJS))

# $(error $(OBJ_DIR))

# Compilation patterns
$(OBJ_DIR)/%.o: %.c
	@echo + CC $<
# create directory first
	@mkdir -p $(dir $@)
# create dir/*.o file
	@$(CC) $(CFLAGS) -c -o $@ $<
	$(call call_fixdep, $(@:.o=.d), $@)

$(OBJ_DIR)/%.o: %.cc
	@echo + CXX $<
	@mkdir -p $(dir $@)
	@$(CXX) $(CFLAGS) $(CXXFLAGS) -c -o $@ $<
	$(call call_fixdep, $(@:.o=.d), $@)

# Depencies
-include $(OBJS:.o=.d)

# Some convenient rules

.PHONY: app clean

app: $(BINARY)

# $(error $(BINARY))

$(BINARY): $(OBJS) $(ARCHIVES) $(PRES)
# $(BINARY): $(OBJS) $(ARCHIVES)
	@echo + LD $@
	@$(LD) -o $@ $(OBJS) $(LDFLAGS) $(ARCHIVES) $(LIBS)

clean:
	-rm -rf $(BUILD_DIR)
