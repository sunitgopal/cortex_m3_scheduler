/* kernel.s - The OS Data Structures */


.syntax unified
.cpu cortex-m3
.thumb

.section .data
.p2align 2

/* -------------------------------------------------------------------------
   GLOBAL KERNEL POINTER
   ------------------------------------------------------------------------- */
.global current_tcb
current_tcb:
    .word tcb0          // Pointer to the TCB of the running task

/* -------------------------------------------------------------------------
   TASK CONTROL BLOCKS (Linked List)
   Structure:
     Offset 0: SP
     Offset 4: Next TCB
   ------------------------------------------------------------------------- */
.global tcb0
tcb0:
    .word stack0        // Initial SP
    .word tcb1          // Points to Task 1

.global tcb1
tcb1:
    .word stack1
    .word tcb2          // Points to Task 2

.global tcb2
tcb2:
    .word stack2
    .word tcb3          // Points to Task 3

.global tcb3
tcb3:
    .word stack3
    .word tcb0          // Points back to Task 0 (Circular!)
