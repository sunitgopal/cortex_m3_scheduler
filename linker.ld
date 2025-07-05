MEMORY
{
    FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 128K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}


SECTIONS
{
    .text :
    {
        *(.vectors*)
        *(.text*)
    } > FLASH

    /* ENTRY(rEsEt_HanDler)     /* used by debuggers and some loaders to know where program execution begins  */
}