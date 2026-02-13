ENTRY(_start)
OUTPUT_FORMAT(elf32-i386)

SECTIONS {
    . = 2M;
    .text BLOCK(4k) :  ALIGN(4k)
    {
        KEEP(*(.multiboot))
        *(.text)
    }

    .bss BLOCK(4k) : ALIGN(4k)
    {
        *(.bss)
    }

    .data BLOCK(4k) : ALIGN(4k)
    {
        *(.data)
    }
    /DISCARD/ : { *(.comment*) *(.note*) }
}
