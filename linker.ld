ENTRY(_start)
OUTPUT_FORMAT(elf32-i386)

SECTIONS {

    . = 2M;
    .text BLOCK(4k) :  ALIGN(4k)
    {
        _text_i = .;
        KEEP(*(.multiboot))
        *(.text)
        _text_e = .;
    }
    _data_bss_i = .;
    .bss BLOCK(4k) : ALIGN(4k)
    {
        *(.bss)
    }

    .data BLOCK(4k) : ALIGN(4k)
    {
        *(.data)
    }
    _data_bss_e = .;
    . = ALIGN(4k);
    _heap_start = .;
    /DISCARD/ : { *(.comment*) *(.note*) }
}
