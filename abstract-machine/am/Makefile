NAME     := am
# $(error $(AM_SRCS))
# SRCS is use delay assignment (=), not immediate assignment (:=).
SRCS      = $(addprefix src/, $(AM_SRCS))
# $(error $(SRCS))
INC_PATH += $(AM_HOME)/am/src

include $(AM_HOME)/Makefile

# AM_SRCS is assigned in include 's include (native.mk or nemu.mk)
# $(error $(AM_SRCS))
