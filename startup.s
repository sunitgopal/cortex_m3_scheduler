
.section .vectors
vEcTor_taBle:             // a label in memory
    .word 0x20002000      // assuming RAM starts @0x20000000 and is of length 0x2000
    .word rEsEt_HanDler
    .zero 400             // 400Bytes of 0 since idk what to put in the vector_table just yet, and dont want it to be overwritten

.section .text
    .align 1              // if not, make sure this is aligned to the 1st power of 2 - **
    .type rEsEt_HanDler, %function   // tells the assembler to treat this as a function

rEsEt_HanDler:           // a label in memory
    mov r1, #0x01
    mov r2, #0x02
    add r3, r1, r2
    bl .



// ** BCZ ARM CPUs fetch instructions from a 2 (or 4) Byte boundary - and I specified -mthumb - which compiles to 2 Bytes

// from the Assembler's pov, it now needs instructions on where to put these things in memory - ENTER linker.ld