/* tasks.s - The User Application */

.syntax unified     /* Use modern Thumb-2 syntax */

// task0
.section .text
    .p2align 1
    .type task0, %function

.global task0
task0:
    add r0, r0, #0x01
    b task0


// task1
.section .text
    .p2align 1
    .type task1, %function

.global task1
task1:
    add r1, r1, #0x01
    b task1


// task2
.section .text
    .p2align 1
    .type task2, %function

.global task2
task2:
    add r2, r2, #0x01
    b task2


// task3
.section .text
    .p2align 1
    .type task3, %function

.global task3
task3:
    add r3, r3, #0x01
    b task3


// Task-stacks

.section .data
    .p2align 3

.global stack0
stack0:
    .word 0x08, 0x09, 0x0a, 0x0b
    .word 0x04, 0x05, 0x06, 0x07
    .word 0x00, 0x01, 0x02, 0x03
    .word 0x0c
    .word 0xaa1          // LR
    .word task0          // PC
    .word 0x01000000     // xPSR
    .zero 100



.section .data
    .p2align 3

.global stack1
stack1:
    .word 0x18
    .word 0x19
    .word 0x1a
    .word 0x1b
    .word 0x14
    .word 0x15
    .word 0x16
    .word 0x17
    .word 0x10
    .word 0x11
    .word 0x12
    .word 0x13
    .word 0x1c
    .word 0xaa1          // LR
    .word task1          // PC
    .word 0x01000000     // xPSR
    .zero 100



.section .data
    .p2align 3

.global stack2
stack2:
    .word 0x28
    .word 0x29
    .word 0x2a
    .word 0x2b
    .word 0x24
    .word 0x25
    .word 0x26
    .word 0x27
    .word 0x20
    .word 0x21
    .word 0x22
    .word 0x23
    .word 0x2c
    .word 0xaa1          // LR
    .word task2          // PC
    .word 0x01000000     // xPSR
    .zero 100



.section .data
    .p2align 3

.global stack3
stack3:
    .word 0x38
    .word 0x39
    .word 0x3a
    .word 0x3b
    .word 0x34
    .word 0x35
    .word 0x36
    .word 0x37
    .word 0x30
    .word 0x31
    .word 0x32
    .word 0x33
    .word 0x3c
    .word 0xaa1          // LR
    .word task3          // PC
    .word 0x01000000     // xPSR
    .zero 100
