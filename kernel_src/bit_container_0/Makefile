################################################################################
# this file was created by alfred. Do not trust it.
#
# tool chain path
XILINX_VITIS ?= /tools/Xilinx/Vitis/2021.2
XILINX_XRT ?= /opt/xilinx/xrt
XILINX_VIVADO ?= /tools/Xilinx/Vivado/2021.2
XILINX_HLS_INCLUDES ?= /tools/Xilinx/Vitis_HLS/2021.2/include

CONTAINER_ID = $(patsubst bit_container_%,%,$(shell basename $(CURDIR)))

# Platform path
VITIS_PLATFORM = xilinx_u280_xdma_201920_3

# Project Name
TARGET ?= hw

# Interface
INTERFACE ?= 01

BUILD_DIR := ../../build/bit_container_$(CONTAINER_ID)

# Kernel Source Path, do not modify
KERNEL_O_DIR ?= $(BUILD_DIR)/vitis_hls/bit_container_$(CONTAINER_ID)

# Kernel to build
# Automatic deduce that build all kernel_src/*.cpp to *.xo
# Make sure that each cpp file has only one kernel
BINARY_CONTAINER := $(BUILD_DIR)/bit_container_$(CONTAINER_ID).xclbin 

HW_KERNEL_SRCS := $(wildcard *.cpp)
HW_KERNEL_OBJS := $(patsubst %.cpp,$(KERNEL_O_DIR)/%.xo,$(HW_KERNEL_SRCS))
HW_KERNEL_HEADERS := $(wildcard *.hpp)

HW_COMMON_KERNELS += ../Base_IPs/networklayer.xo
ifeq ($(INTERFACE), 01)
	HW_COMMON_KERNELS += ../Base_IPs/cmac_0.xo
endif

ifeq ($(INTERFACE), 10)
	HW_COMMON_KERNELS += ../Base_IPs/cmac_1.xo
endif

ifeq ($(INTERFACE), 11)
	HW_COMMON_KERNELS += ../Base_IPs/cmac_0.xo
	HW_COMMON_KERNELS += ../Base_IPs/cmac_1.xo
endif


# set kernel frequency if necessary
KERNEL_EXT_CONFIG += --kernel_frequency
KERNEL_EXT_CONFIG += 300

# Bit Container Linker Configuration, edit independently
BC_CONFIG = linker.cfg


################################################################################
################# do not modify contents below if not necessary ################
################################################################################
VPP_OPTS = --target $(TARGET)

# compiler tools
VPP_LINKER ?= ${XILINX_VITIS}/bin/v++
VPP ?= ${XILINX_VITIS}/bin/v++
RM = rm -f
RMDIR = rm -rf
#
# host complie flags



LOG_DIR ?= $(BUILD_DIR)/logs
REPORT_DIR ?= $(BUILD_DIR)/reports

KERNEL_EXT_CONFIG += --platform
KERNEL_EXT_CONFIG += $(VITIS_PLATFORM)
KERNEL_EXT_CONFIG += --temp_dir
KERNEL_EXT_CONFIG += $(BUILD_DIR)/vitis_hls
KERNEL_EXT_CONFIG += --log_dir
KERNEL_EXT_CONFIG += $(LOG_DIR)
KERNEL_EXT_CONFIG += --report_dir
KERNEL_EXT_CONFIG += $(REPORT_DIR)
KERNEL_EXT_CONFIG += -s
BC_EXT_CONFIG += -s

# If it is hardware emulation, the debug hardware should be added. If not, it will not be added to reduce the overhead.
ifneq ($(TARGET), hw)
	BC_EXT_CONFIG += -g
	KERNEL_EXT_CONFIG += -g
endif

HLS_IP_FOLDER  = $(shell readlink -f ../Base_IPs/synthesis_results_HBM)
BC_EXT_CONFIG += --user_ip_repo_paths
BC_EXT_CONFIG += $(HLS_IP_FOLDER)

LINK_EXT_CONFIG += --temp_dir
LINK_EXT_CONFIG += $(BUILD_DIR)/vivado

#
# primary build targets
#

.PHONY: all clean kernel link 
all: $(HW_KERNEL_OBJS) $(BINARY_CONTAINER) 


kernel: $(HW_KERNEL_OBJS)


link: $(BINARY_CONTAINER)



.PHONY: incremental
incremental: all

clean:
	-@rm -rf $(BUILD_DIR)

# build kernels first, automatic build all kernels
$(KERNEL_O_DIR)/%.xo: %.cpp $(HW_KERNEL_HEADERS)
	-@mkdir -p $(@D)
	-@mkdir -p $(LOG_DIR)
	-@mkdir -p $(REPORT_DIR)
	-@$(RM) $@
	$(VPP) $(VPP_OPTS) --compile -I"$(<D)" --kernel $(basename $(@F)) --advanced.misc solution_name=$(basename $(@F)) $(KERNEL_EXT_CONFIG) -o"$@" "$<"


# link project secondly
$(BINARY_CONTAINER): $(HW_KERNEL_OBJS) $(HW_COMMON_KERNELS) $(BC_CONFIG)
	-@mkdir -p $(@D)
	$(VPP_LINKER) $(VPP_OPTS) --link --platform $(VITIS_PLATFORM) --config $(BC_CONFIG) $(BC_EXT_CONFIG) $(LINK_EXT_CONFIG) --log_dir $(LOG_DIR) --report_dir $(REPORT_DIR) -R2 -o"$@" $(HW_KERNEL_OBJS) $(HW_COMMON_KERNELS)
