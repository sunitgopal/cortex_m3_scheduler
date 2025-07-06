.section .text
    .align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
    .type systick_Handler, %function   // tells the assembler to treat this as a function

.global systick_Handler

systick_Handler:      
    add r4, r4, #0x1  // serves as a count of systick expiry
    bx lr             // standard instruction that triggers HW exception-return sequence on ARM M processors