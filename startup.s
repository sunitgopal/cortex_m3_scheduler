// SysTick registers
    .equ CSR,     0xE000E010
    .equ RVR,     0xE000E014
    .equ CVR,     0xE000E018
    .equ CALIB,   0xE000E01C      // unused currently

// Num of counts to downcount before interrupt
    .equ timeout, 0x00FFFFFF

.section .vectors
vEcTor_taBle:             // a label in memory
    .word 0x20002000      // RAM starts @0x20000000 and is of length 0x2000 (8KB)
    .word rEsEt_HanDler
    .org 0x3C             // Sets the assembler’s location counter to 0x3C within the current section, so subsequent code/data is placed at that address
    .word systick_Handler
    .zero 336             // 336 Bytes of 0, since idk what to put in the vector_table just yet, and dont want it to be overwritten


.section .text
    .align 1              // align next label (rEsEt_HanDler) to 2-byte boundary for correct instruction fetch
    .type rEsEt_HanDler, %function   // tells the assembler to treat this as a function

rEsEt_HanDler:           // a label in memory
// load Systick reg addresses
    ldr r0, =CSR
    ldr r1, =RVR
    ldr r2, =CVR
    ldr r3, =timeout

// store/write to Systick regs
    str r3, [r1]      // store [desired] timeout value to RVR
    str r3, [r2]      // to ensure CVR starts at 0; Any write sets it to 0, and clears CSR COUNTFLAG bit
    mov r3, #0x07
    str r3, [r0]      // Processor clock; Enable Systick Exception; Enable counter

    mov r4, #0x0      // using r4 BCZ it isn't touched during exception entry, exit; increment it inside systick_Handler
    b .               // no need to save to Link Register, hence got rid of bl


.section .text
    .align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
    .type systick_Handler, %function   // tells the assembler to treat this as a function

systick_Handler:       // a label in memory
// just some code to confirm that control is here now
    add r4, r4, #0x1  // serves as a count of systick expiry
    bx lr             // standard instruction that triggers HW exception-return sequence on ARM M processors


// from the Assembler's pov, it now needs instructions on where to put these things in memory - ENTER linker.ld