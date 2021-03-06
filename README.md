Project template for STM32F4-Discovery Boards
=============================================

This is a simple bare-metal project template for the STM32F4 Discovery board.
It contains the STM32F4 standard peripherals library and ARMs CMSIS package
as well as some helper routines. It is based on:

* [Template of Florian Zahn](https://github.com/C3MA/stm32f4discovery-template): CMSIS/StdLib, Makefile
* [USART example code of devtrash](https://github.com/devthrash/STM32F4-examples/tree/master/USART)
* [mini-printf code of mludvig](https://github.com/mludvig/mini-printf)

Prerequisites
-------------

* Install [gcc-arm-embedded](https://launchpad.net/gcc-arm-embedded) and
  make sure the arm-none-eabi-*-commands are in your path
* Install [st-link](https://github.com/texane/st-link)

Usage
-----

Do some coding. Then, issue

    $ make

which will produce the files ````main.{elf|bin|hex}````. You can use stlink and gdb to upload the ELF file into the memory of the STM32F4. In one window, start ````st-util````:

	$ sudo st-util
	2014-08-06T18:38:47 INFO src/stlink-common.c: Loading device parameters....
	2014-08-06T18:38:47 INFO src/stlink-common.c: Device connected is: F4 device, id 0x10016413
	2014-08-06T18:38:47 INFO src/stlink-common.c: SRAM size: 0x30000 bytes (192 KiB), Flash: 0x100000 bytes (1024 KiB) in pages of 16384 bytes
	2014-08-06T18:38:47 INFO gdbserver/gdb-server.c: Chip ID is 00000413, Core ID is  2ba01477.
	2014-08-06T18:38:47 INFO gdbserver/gdb-server.c: Target voltage is 2882 mV.
	2014-08-06T18:38:47 INFO gdbserver/gdb-server.c: Listening at *:4242...

Then, use the arm-none-eabi-gdb to load the ELF:

	$ arm-none-eabi-gdb main.elf
	GNU gdb (GNU Tools for ARM Embedded Processors) 7.6.0.20140529-cvs
	[...]
	Reading symbols from /home/md/Projects/stm32f4discovery-template/main.elf...done.
	(gdb) target extended localhost:4242
	Remote debugging using localhost:4242
	0x08001060 in Reset_Handler ()
	(gdb) load
	Loading section .isr_vector, size 0x188 lma 0x8000000
	Loading section .text, size 0xf48 lma 0x8000188
	Loading section .data, size 0x24 lma 0x80010d0
	Start address 0x8001060, load size 4340
	Transfer rate: 3 KB/sec, 1446 bytes/write.
	(gdb) continue
	Continuing.

The template code should now be running. Connect a UART-USB-Adapter to PB6, PB7 and GND. 

	$ screen /dev/ttyUSB0 115200

should show a greeting message:

````
Startup complete.
System Core Clock running at 168MHz
````

USART Port Mappings
-------------------

* USART1: PB6, PB7
* USART6: PC6, PC7 Note: If you use the STM32F4 Expansion board, the
  UART6 should be mapped to the serial port of this board. However, I
  wasn't able to get this running. Attaching an FTDI USB-TTL-Adapter works fine for these pins.

Tested Host Systems
-------------------

The template has been tested on the following host systems:

* Ubuntu Linux 14.04
* Mac OS Mavericks
