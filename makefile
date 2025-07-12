PROJECT = scheduler
CPU := cortex-m3
BOARD := stm32vldiscovery

OBJS = startup.o systick_handler.o tasks.o

qemu:
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -ggdb -c startup.s -o startup.o
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -ggdb -c systick_handler.s -o systick_handler.o
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -ggdb -c tasks.s -o tasks.o
	arm-none-eabi-ld -Tlinker.ld $(OBJS) -o scheduler.elf
	arm-none-eabi-objdump -D -S scheduler.elf > scheduler.elf.lst
	arm-none-eabi-readelf -a scheduler.elf > scheduler.elf.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJECT).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.out *.elf .gdb_history *.lst *.debug *.o