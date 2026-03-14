.set ALIGN,    1<<0
.set MEMINFO,  1<<1
.set FLAGS,    ALIGN | MEMINFO
.set MAGIC,    0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)
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

.align(4096)
.global _PG_DIR
_PG_DIR = .
    .skip(4096)
_PG_DIR_e = .



# .=.+4
# .space(4)

MESSAGE:
    .asciz "CARAMBA QUE PINTO ENORME"

.section .bss

stack_bottom:
    .skip(16384)
stack_top:

.section .text


.macro set_irq number
.global _int_handler\number
_int_handler\number:
    pusha
    call _int_callback\number
    popa
    movb $0x20, %al
    outb %al, $0x20
    iret
.endm


.macro set_irq_func number callback
.global _int_handler\number
_int_handler\number:
    pusha
    call \callback
    popa
    movb $0x20, %al
    outb %al, $0x20
    iret
.endm



set_irq 0
set_irq 1
set_irq 2
set_irq 3
set_irq 4
set_irq 5
set_irq 6
set_irq 7
set_irq 8
set_irq 9
set_irq 10
set_irq 11
set_irq 12
set_irq 13
set_irq 14
set_irq 15
set_irq 16
set_irq 17
set_irq 18
set_irq 19
set_irq 20
set_irq 21
set_irq 22
set_irq 23
set_irq 24
set_irq 25
set_irq 26
set_irq 27
set_irq 28
set_irq 29
set_irq 30
set_irq 31

set_irq_func 32 timer_handler
set_irq_func 33 keyboard_handler




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

set_paging:

    movl $_PG_DIR, %eax
    movl %eax, %cr3

    movl %cr0, %eax
    or $1<<31, %eax
    movl %eax, %cr0

    jmp $0x8, $.paging_return
# 0xFFFFFFFF
# 0x400000
# 0x1000000 = 1M
# for 16M need 4096 entries
# 4 tables then 4

.global _start
_start:
    cli
    movl $stack_top, %esp

    call kernel_init

    call flush_gdt

    call flush_idt


    jmp set_paging

.paging_return:


    sti

    movl 0x400000, %eax

    call kernel_routine

_one:
	jmp _one

_error:
