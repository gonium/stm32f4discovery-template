##########################################################################
#                    STM32F4 Project Template Makefile                   #
##########################################################################

TARGET:=main
TOOLCHAIN_PREFIX:=arm-none-eabi
OPTLVL:=1 # Optimization level, can be [0, 1, 2, 3, s].

PROJECT_NAME:=$(notdir $(lastword $(CURDIR)))



LINKER_SCRIPT=stm32_flash.ld


INCLUDE=-I$(CURDIR)/inc
INCLUDE+=-I$(CURDIR)/lib/inc
INCLUDE+=-I$(CURDIR)/lib/cmsis



# vpath is used so object files are written to the current directory instead
# of the same directory as their source files
vpath %.c $(CURDIR)/lib/src
vpath %.s $(STARTUP)

ASRC=src/startup_stm32f4xx.s

# Project Source Files
SRC+=$(wildcard $(CURDIR)/*.c)

# Standard Peripheral Source Files
SRC+=$(wildcard $(CURDIR)/lib/src/*.c)

# Application files
SRC+=$(wildcard $(CURDIR)/src/*.c)

CDEFS=-DSTM32F4XX
CDEFS+=-DUSE_STDPERIPH_DRIVER

MCUFLAGS=-mcpu=cortex-m4 -mthumb -std=c99
#MCUFLAGS=-mcpu=cortex-m4 -mthumb -mlittle-endian -mfpu=fpa -mfloat-abi=hard -mthumb-interwork
#MCUFLAGS=-mcpu=cortex-m4 -mfpu=vfpv4-sp-d16 -mfloat-abi=hard
COMMONFLAGS=-O$(OPTLVL) -g -Wall 
CFLAGS=$(COMMONFLAGS) $(MCUFLAGS) $(INCLUDE) $(CDEFS)

LDLIBS=
LDFLAGS=$(COMMONFLAGS) -fno-exceptions -ffunction-sections -fdata-sections \
        -nostartfiles -Wl,--gc-sections,-T$(LINKER_SCRIPT)

#####
#####

OBJ = $(SRC:%.c=%.o) $(ASRC:%.s=%.o)

CC=$(TOOLCHAIN_PREFIX)-gcc
LD=$(TOOLCHAIN_PREFIX)-gcc
OBJCOPY=$(TOOLCHAIN_PREFIX)-objcopy
AS=$(TOOLCHAIN_PREFIX)-as
AR=$(TOOLCHAIN_PREFIX)-ar
GDB=$(TOOLCHAIN_PREFIX)-gdb


bin: $(OBJ)
	$(CC) -o $(TARGET).elf $(OBJ) $(LDFLAGS) $(LDLIBS)
	$(OBJCOPY) -O ihex   $(TARGET).elf $(TARGET).hex
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin


flash: bin
	st-flash write $(TARGET).bin 0x08000000

.PHONY: clean

clean:
	rm -f $(OBJ)
	rm -f $(TARGET).elf
	rm -f $(TARGET).hex
	rm -f $(TARGET).bin
