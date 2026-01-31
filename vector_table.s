.section .vectors
vector_table:                 // Vector table base (goes at start of FLASH)
    .word 0x20002000          // Initial MSP: top of 8 KB SRAM at 0x20000000
    .word reset_Handler       // Reset vector (entry point)

    .org 0x3C                 // Offset to SysTick vector slot (0x3C from table base)
    .word systick_Handler     // SysTick ISR entry

    .zero 336                 // Reserve space for remaining vectors (kept zero for now)