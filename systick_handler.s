.section .text
    .align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
    .type systick_Handler, %function   // tells the assembler to treat this as a function

.global systick_Handler

systick_Handler:

// at this point, regs r0-r3, r12, lr, pc, and xPSR AKA Caller-saved regs will already be saved to the stack by the HW

// manual save of the remainings CPU regs (AKA Callee-saved regs):
    push {r4-r7}

    mov r0, r8
    mov r1, r9
    mov r2, r10
    mov r3, r11
    push {r0-r3}      // bc push/pop do not support high regs

manual_restore:
    pop {r0-r3}
    mov r8, r0
    mov r9, r1
    mov r10, r2
    mov r11, r3

    pop {r4-r7}


    bx lr             // triggers Caller-saved regs to be restored from the stack by the HW