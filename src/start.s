.set ALIGN,    1<<0             /* align loaded modules on page boundaries */
.set MEMINFO,  1<<1             /* provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* this is the Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* 'magic number' lets bootloader find the header */
.set CHECKSUM, -(MAGIC + FLAGS) /* checksum of above, to prove we are multiboot */
.set KEYBOARD_TIMEOUT,   200
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM



.section .data

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

.global _start



_keyboard_int:
    # call keyboard_event
    # movl $0xD0, 0x64
    # movl 60, %eax
    pushl $MESSAGE
    call vga_str_put
    ret



_send_keyboard_command:
    pushl %ebp
    movl %esp, %ebp
    xor %ebx, %ebx
.loopaa:
    cmp $KEYBOARD_TIMEOUT, %ebx
    jg _error
    inc %ebx
    inb $0x64, %al
    and $1<<1, %al
    cmp $0, %al
    jne .loopaa
    movl 8(%ebp), %edx # 8 + %ebp

    movl %edx, %ebx
.loop2:
    movl 8(%ebp, %ebx, 4), %eax # 8 + %ebp + 4*%edx
.loop_resend:
    outl %eax, $0x60

    inb $0x60, %al
    cmpb $0xfe, %al
    je .loop_resend

    decl %ebx
    cmp $0, %ebx
    jne .loop2

    # movl 12(%ebp), %eax
    # movl 16(%ebp), %eax


    nop
    popl %ebp
    ret

_start:
    cli
    movl $stack_top, %esp
    movl _keyboard_int, %eax # Store segment at 0x26
    lidt _IDT
    lgdt _GDT




    movl $0xAA, %eax
    outl %eax, $0x64 #Test
    inb $0x60, %al
    cmpb $0x55, %al
    jne _error

    movl $0xAB, %eax
    outl %eax, $0x64 #Test
    inb $0x60, %al
    cmpb $0x0, %al
    jne _error

    movb $0b00011100, %al #Initialization Command Word 1
    outb %al, $0x20
    outb %al, $0xA0

    movb $0, %al #Initialization Command Word 2
    outb %al, $0x21
    outb %al, $0xA1

    movb $0b00000100, %al #Initialization Command Word Master 3
    outb %al, $0x21
    movb $0b00000100, %al #Initialization Command Word Slave 3
    outb %al, $0xA1

    movb $0, %al #All on in Interupt Mask Reg: OCW1
    outb %al, $0x21
    outb %al, $0xA1

    movb $0b01100111, %al #All on in Interupt Commnad Reg: OCW2
    outb %al, $0x20
    outb %al, $0xA0

    movb $0b00001100, %al #OCW3
    outb %al, $0x20
    outb %al, $0xA0


    movl $0xAD, %eax #Disable First p2 port
    outl %eax, $0x64 #Disable First p2 port

    movl $0xA7, %eax #Disable Second p2 port
    outl %eax, $0x64 #Disable Second p2 port

    inl $0x60, %eax #Flush



    mov $0b01000111, %eax #Set controller conf byte
    outl %eax, $0x60 #Set controller conf byte

    movl $0x60, %eax #Set controller conf byte
    outl %eax, $0x64 #Set controller conf byte





    movl $0xAE, %eax #Enable First p2 port
    outl %eax, $0x64 #Enable First p2 port

    movl $0xA8, %eax #Enable Second p2 port
    outl %eax, $0x64 #Enable Second p2 port

    push $0xF0
    push $0x1
    push $0x2
    call _send_keyboard_command
    addl $12, %esp

    push $0xF4
    push $0x1
    call _send_keyboard_command
    addl $8, %esp

    call kernel_init


    pushl $MESSAGE
    call vga_str_put

    addl $4, %esp


    call kernel_routine

_one:
	jmp _one

_error:
