/* kernel.s - The OS Data Structures */

.syntax unified     /* Use modern Thumb-2 syntax */
.cpu cortex-m3
.thumb


.section .data
    .p2align 2

/* ---------
 KERNEL VARIABLES ((The "State" of the OS))
   ---------
*/


.global current_task
current_task:       /* The idx of the currently running task (0-3) */
    .word 0         /* Start with Task 0 */

.p2align 2
.global task_sps
task_sps:           /* Array of initial-SPs for each Task */
    .word stack0, stack1, stack2, stack3
