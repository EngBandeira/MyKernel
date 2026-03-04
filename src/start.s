.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */
.set KEYBOARD_TIMEOUT,   200
.set RW_P2_DATA_PORT,   0x60
.set R_STATUS_REGISTER,   0x64
.set W_COMMAND_REGISTER,   0x64
.set ACK_KEYBOARD,   0xFA
.set RESEND_KEYBOARD,   0xFE
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


.section .data

.global GDT_size
.global IDT_size
GDT_size:  .2byte 4
IDT_size:  .2byte 2047

.align(8)
.global _GDT
_GDT:
    .skip(800)
_GDT_e:

.align(8)
.global _IDT
_IDT = .
    .skip(800)
_IDT_e = .


# .=.+4
# .space(4)

MESSAGE:
    .asciz "CARAMBA QUE PINTO ENORME"

.section .bss

stack_bottom:
    .skip(16384)
stack_top:

.section .text



.global _timer_int
_timer_int:
    pusha

    call timer_handler
    # movb $0x20, %al
    # outb %al, $0x20
    popa
    iret


.global _keyboard_int
_keyboard_int:
    pusha

    call keyboard_handler
    # movb $0x20, %al
    # outb %al, $0x20
    popa
    iret




flush_gdt:
    pushl %ebp
    movl %esp, %ebp

    sub $6, %esp

    movw GDT_size, %ax
    movw %ax, (%esp)
    movl $_GDT, 2(%esp)
    lgdt (%esp)

    add $6, %esp

    mov $0x10, %ax      # data selector (GDT entry 2 -> 2*8 = 0x10)
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    jmp $0x8, $.L1  # far jump to reload CS
.L1:

    popl %ebp
    ret

flush_idt:
    pushl %ebp
    movl %esp, %ebp

    sub $6, %esp

    movw IDT_size, %ax
    movw %ax, (%esp)
    movl $_IDT, 2(%esp)
    lidt (%esp)

    add $6, %esp

    popl %ebp
    ret



.global _start
_start:
    cli
    movl $stack_top, %esp

    call kernel_init

    call flush_gdt

    call flush_idt

    sti

    call kernel_routine

_one:
	jmp _one

_error:
