.syntax unified     /* Use modern Thumb-2 syntax */

.section .text
    .align 1              // align next label (systick_Handler) to 2-byte boundary for correct instruction fetch
    .type systick_Handler, %function   // tells the assembler to treat this as a function

.global systick_Handler

systick_Handler:

// at this point, regs r0-r3, r12, lr, pc, and xPSR (AKA Caller-saved regs) will already be saved to the stack by the HW

// manual save of the remainings CPU regs (AKA Callee-saved regs):
    push {r4-r7}

    mov r0, r8
    mov r1, r9
    mov r2, r10
    mov r3, r11
    push {r0-r3}      // bc push/pop do not support high regs

    /*** Store current-SP ***/
        /* task_sps[current_task] = SP */

    ldr r0, =task_sps       /* R0 = Base addr of task_sps Array */
    ldr r1, =current_task   /* R1 = Addr of current_task variable */
    ldr r2, [r1]            /* R2 = Val. of current_task variable i.e., curr-index */

        /* Calculate addr of where current-SP must be stored in task_sps Array*/
    lsl r3, r2, #2          /* R3 = curr-index * 4 */
    str sp, [r0, r3]        /* Store current-SP into task_sps */


    /*** Incrememnt current_task to Choose next task ***/
        /* current_task = (current_task + 1 ) & 3 */
    add r2, r2, #1          /* Increment curr-index */
    and r2, r2, #3          /* Wrap around */
    str r2, [r1]            /* Update current_task variable in Memory */


    /*** Load next-SP ***/
        /* SP = task_sps[current_task] */
    lsl r3, r2, #2          /* R3 = new curr-index * 4 */
    ldr sp, [r0, r3]        /* Load next task's SP into SP*/


    pop {r0-r3}
    mov r8, r0
    mov r9, r1
    mov r10, r2
    mov r11, r3

    pop {r4-r7}


    bx lr             // triggers Caller-saved regs to be restored from the stack by the HW
