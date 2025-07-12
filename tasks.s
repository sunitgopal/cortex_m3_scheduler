// task0
.section .text
    .align 1
    .type task0, %function

.global task0

task0:
    add r0, r0, #0x01
    b task0


// task1
.section .text
    .align 1
    .type task1, %function

.global task1

task1:
    add r1, r1, #0x01
    b task1


// task2
.section .text
    .align 1
    .type task2, %function

.global task2

task2:
    add r2, r2, #0x01
    b task2


// stacks

.section .data
    .align 2

stack0:
    .word 0x08
    .word 0x09
    .word 0x0a
    .word 0x0b
    .word 0x04
    .word 0x05
    .word 0x06
    .word 0x07
    .word 0x00
    .word 0x01
    .word 0x02
    .word 0x03
    .word 0x0c
    .word 0xaa1          // LR
    .word task0          // PC
    .word 0x01000000     // xPSR
    .zero 100



.section .data
    .align 2

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
    .align 2

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
