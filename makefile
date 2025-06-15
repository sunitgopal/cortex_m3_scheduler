PROJECT = startup
CPU := cortex-m3
BOARD := stm32vldiscovery

qemu:
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -ggdb -c startup.s -o startup.o
	arm-none-eabi-ld -Tlinker.ld startup.o -o startup.elf
	arm-none-eabi-objdump -D -S startup.elf > startup.elf.lst
	arm-none-eabi-readelf -a startup.elf > startup.elf.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJECT).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.out *.elf .gdb_history *.lst *.debug *.o