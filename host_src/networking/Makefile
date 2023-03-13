################################################################################
# this file was created by alfred. Do not trust it.
################################################################################

# tool chain path
XILINX_VITIS ?= /tools/Xilinx/Vitis/2021.2
XILINX_XRT ?= /opt/xilinx/xrt
XILINX_VIVADO ?= /tools/Xilinx/Vivado/2021.2
XILINX_HLS_INCLUDES ?= /tools/Xilinx/Vitis_HLS/2021.2/include


# Interface
INTERFACE ?= 01

# Host source files
HOST_SRC_DIR ?= .
HOST_O_DIR ?= ../../build/host

HOST_COMMON_HEADER += $(HOST_SRC_DIR)/oct_fpga.hpp
HOST_OBJ += $(HOST_O_DIR)/udp_setup.o

HOST_EXE = $(HOST_O_DIR)/udp_setup


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



#
# primary build targets
#

.PHONY: all clean host kernel link run kill
all: host

host: $(HOST_EXE)


clean:
	-@$(RM) $(HOST_EXE)
	-@$(RM) $(HOST_OBJ)

.PHONY: incremental
incremental: all


# build kernels first, automatic build all kernels
$(KERNEL_O_DIR)/%.xo: $(KERNEL_SRC_DIR)/%.cpp $(HW_KERNEL_HEADERS)
	-@mkdir -p $(@D)
	-@mkdir -p $(LOG_DIR)
	-@mkdir -p $(REPORT_DIR)
	-@$(RM) $@
	$(VPP) $(VPP_OPTS) --compile -I"$(<D)" --kernel $(basename $(@F)) --advanced.misc solution_name=$(basename $(@F)) $(KERNEL_EXT_CONFIG) -o"$@" "$<"

# bulid host finally
$(HOST_EXE): $(HOST_OBJ)
	-@mkdir -p $(@D)
	$(HOST_CXX) -o "$@" $(^) $(LDFLAGS)

$(HOST_O_DIR)/%.o: $(HOST_SRC_DIR)/%.cpp $(HOST_COMMON_HEADER)
	-@mkdir -p $(@D)
	$(HOST_CXX) $(CXXFLAGS) -o "$@" "$<"

