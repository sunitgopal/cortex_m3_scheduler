.syntax unified     /* Use modern Thumb-2 syntax */

.section .text
    .align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
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
        2. STORE CURRENT SP
            /* task_sps[current_task] = SP
       --------------------------------------------------------- */

    ldr r0, =task_sps       /* R0 = Base addr of task_sps Array */
    ldr r1, =current_task   /* R1 = Addr of current_task variable */
    ldr r2, [r1]            /* R2 = Val. of current_task variable i.e., index */

        /* Calculate addr of where current-SP must be stored in task_sps Array*/
    lsl r3, r2, #2          /* R3 = index*4   */
    str sp, [r0, r3]        /* Store current-SP into task_sps */


/* ---------------------------------------------------------
        3. CHOOSE NEXT TASK (Round-Robin)
        Increment current_task to Choose next task
        /* current_task = (current_task + 1 ) & 3
       --------------------------------------------------------- */

    add r2, r2, #1          /* Increment curr-index */
    and r2, r2, #3          /* Wrap around */
    str r2, [r1]            /* Update current_task variable in Memory */


/* ---------------------------------------------------------
        4. LOAD NEXT SP
        /* SP = task_sps[current_task]
       --------------------------------------------------------- */

    lsl r3, r2, #2          /* R3 = new curr-index * 4 */
    ldr sp, [r0, r3]        /* Load next task's SP into SP*/


/* ---------------------------------------------------------
       5. RESTORE CONTEXT (The "Pop" Logic)
       --------------------------------------------------------- */

    ldmia sp!, {r4-r11}     /* Restore R4-R11 from the new stack (increment SP)  */


    bx lr             // triggers Caller-saved regs to be restored from the stack by the HW
