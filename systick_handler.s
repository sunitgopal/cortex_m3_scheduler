.syntax unified     /* Use modern Thumb-2 syntax */
.cpu cortex-m3
.thumb

.section .text
.p2align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
.type systick_Handler, %function   // tells the assembler to treat this as a function

.global systick_Handler
systick_Handler:

/* ---------------------------------------------------------
       1. SAVE CONTEXT (The "Push" Logic)
       HW has already pushed: xPSR, PC, LR, R12, R0-R3  (Caller-saved regs)
       We must push: R4-R11                             (Callee-saved regs)
       --------------------------------------------------------- */
    stmdb sp!, {r4-r11}   // Save R4-R11 to the current stack (decrement SP)

/* ---------------------------------------------------------
       2. SAVE CURRENT SP to TCB
       old_tcb->sp = SP
       --------------------------------------------------------- */
    ldr r0, =current_tcb    // R0 = &current_tcb
    ldr r1, [r0]            // R1 = current_tcb (Pointer to struct)
    str sp, [r1]            // Store SP at [R1 + 0] (Offset 0 is SP)

    /* ---------------------------------------------------------
       3. CHOOSE NEXT TASK (Linked List Traversal)
       current_tcb = current_tcb->next
       --------------------------------------------------------- */
    ldr r2, [r1, #4]        // R2 = Load [R1 + 4] (The 'next' pointer)
    str r2, [r0]            // Update global 'current_tcb' to point to new task

    /* ---------------------------------------------------------
       4. LOAD NEXT SP from TCB
       SP = new_tcb->sp
       --------------------------------------------------------- */
    ldr sp, [r2]            // Load SP from [R2 + 0]


/* ---------------------------------------------------------
       5. RESTORE CONTEXT (The "Pop" Logic)
       --------------------------------------------------------- */

    ldmia sp!, {r4-r11}     /* Restore R4-R11 from the new stack (increment SP)  */


    bx lr             // triggers Caller-saved regs to be restored from the stack by the HW
