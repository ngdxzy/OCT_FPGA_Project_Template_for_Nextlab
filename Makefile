################################################################################
# this file was created by alfred. Do not trust it.
#
# tool chain path
XILINX_VITIS ?= /tools/Xilinx/Vitis/2021.2
XILINX_XRT ?= /opt/xilinx/xrt
XILINX_VIVADO ?= /tools/Xilinx/Vivado/2021.2
XILINX_HLS_INCLUDES ?= /tools/Xilinx/Vitis_HLS/2021.2/include

JOBS ?= 8

# Platform path
VITIS_PLATFORM = xilinx_u280_xdma_201920_3

# Project Name
PRJ_NAME ?= demo
TARGET ?= hw

# Interface
INTERFACE ?= 01

# Host source files
HOST_SRC_DIR ?= host_src
HOST_O_DIR ?= build/host

HOST_COMMON_OBJ += $(HOST_O_DIR)/fileops.o

HOST_HEAD_OBJ += $(HOST_O_DIR)/head.o
HOST_TAIL_OBJ += $(HOST_O_DIR)/tail.o
HOST_NODE_OBJ += $(HOST_O_DIR)/node.o


# Kernel Source Path, do not modify

# Kernel to build
# Automatic deduce that build all kernel_src/*.cpp to *.xo
# Make sure that each cpp file has only one kernel
KERNEL_SRC_DIR := kernel_src
BINARY_CONTAINER := $(patsubst $(KERNEL_SRC_DIR)/%,%,$(wildcard $(KERNEL_SRC_DIR)/bit_container_*))

BINARY_CONTAINER_KERNELS = $(addsuffix .kernels, $(BINARY_CONTAINER))

HOST_HEAD_EXE = build/host/head_bin
HOST_NODE_EXE = build/host/node_bin
HOST_TAIL_EXE = build/host/tail_bin


################################################################################
################# do not modify contents below if not necessary ################
################################################################################

# compiler tools
HOST_CXX ?= g++
RM = rm -f
RMDIR = rm -rf
#
# host complie flags
CXXFLAGS += -std=c++1y -DVITIS_PLATFORM=$(VITIS_PLATFORM) -D__USE_XOPEN2K8 -I$(XILINX_XRT)/include/ -I$(XILINX_HLS_INCLUDES)/ -I$(HOST_SRC_DIR)/ -O2 -g -Wall -c -fmessage-length=0
LDFLAGS += -luuid -lxrt_coreutil -lxilinxopencl -lxrt_core -lpthread -lrt -lstdc++ -L$(XILINX_XRT)/lib/ -Wl,-rpath-link,$(XILINX_XRT)/lib

BUILD_SUBDIRS += build


#
# primary build targets
#

.PHONY: all clean host kernel link run kill network
all: $(BINARY_CONTAINER) $(HOST_HEAD_EXE) $(HOST_HEAD_EXE) network

host: $(HOST_HEAD_EXE) $(HOST_TAIL_EXE) $(HOST_NODE_EXE)


kernel: $(BINARY_CONTAINER_KERNELS)
	$(info Synthesis all required kernels!)

link: $(BINARY_CONTAINER)


clean:
	-$(RM) $(HW_KERNEL_OBJS) $(BINARY_CONTAINER) *.log *.mdb
	-$(RMDIR) $(BUILD_SUBDIRS)
	-$(RMDIR) .Xil
	-$(RM) *.json
	-$(RMDIR) .run
	-$(RMDIR) .ipcache
	-$(RM) *.wdb
	-$(RM) *.wcfg
	-$(RM) *.protoinst
	-$(RM) *.csv
	-$(RM) $(HOST_HEAD_EXE)
	-$(RM) $(HOST_TAIL_EXE)


.PHONY: incremental
incremental: all


# build kernels first, automatic build all kernels
$(KERNEL_O_DIR)/%.xo: $(KERNEL_SRC_DIR)/%.cpp $(HW_KERNEL_HEADERS)
	-@mkdir -p $(@D)
	-@mkdir -p $(LOG_DIR)
	-@mkdir -p $(REPORT_DIR)
	-@$(RM) $@
	$(VPP) $(VPP_OPTS) --compile -I"$(<D)" --kernel $(basename $(@F)) --advanced.misc solution_name=$(basename $(@F)) $(KERNEL_EXT_CONFIG) -o"$@" "$<"

bit_container_%.kernels: $(KERNEL_SRC_DIR)/bit_container_%/Makefile
	$(MAKE) -C $(KERNEL_SRC_DIR)/$(basename $@) kernel TARGET=$(TARGET)

bit_container_%: $(KERNEL_SRC_DIR)/bit_container_%/Makefile
	$(MAKE) -C $(KERNEL_SRC_DIR)/$(basename $@) link TARGET=$(TARGET)

# bulid host finally
$(HOST_HEAD_EXE): $(HOST_HEAD_OBJ) $(HOST_COMMON_OBJ)
	-@mkdir -p $(@D)
	$(HOST_CXX) -o "$@" $(^) $(LDFLAGS)

$(HOST_TAIL_EXE): $(HOST_TAIL_OBJ) $(HOST_COMMON_OBJ)
	-@mkdir -p $(@D)
	$(HOST_CXX) -o "$@" $(^) $(LDFLAGS)

$(HOST_NODE_EXE): $(HOST_NODE_OBJ) $(HOST_COMMON_OBJ)
	-@mkdir -p $(@D)
	$(HOST_CXX) -o "$@" $(^) $(LDFLAGS)

$(HOST_O_DIR)/%.o: $(HOST_SRC_DIR)/%.cpp $(HOST_COMMON_HEADER)
	-@mkdir -p $(@D)
	$(HOST_CXX) $(CXXFLAGS) -o "$@" "$<"


network:
	$(MAKE) -C host_src/networking
