	.file	"main.c"
	.text
.Ltext0:
	.file 0 "/home/bandeira/Documents/GIT/MyKernel" "src/main.c"
	.data
	.align 4
	.type	VGA_WIDTH, @object
	.size	VGA_WIDTH, 4
VGA_WIDTH:
	.long	80
	.align 4
	.type	VGA_HEIGHT, @object
	.size	VGA_HEIGHT, 4
VGA_HEIGHT:
	.long	25
	.local	line
	.comm	line,4,4
	.globl	vga_buffer
	.align 4
	.type	vga_buffer, @object
	.size	vga_buffer, 4
vga_buffer:
	.long	753664
	.text
	.globl	vga_color
	.type	vga_color, @function
vga_color:
.LFB0:
	.file 1 "src/main.c"
	.loc 1 32 60
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movb	%al, -4(%ebp)
	movb	%dl, %al
	movb	%al, -8(%ebp)
	.loc 1 33 28
	movzbl	-4(%ebp), %eax
	salb	$4, %al
	movb	%al, %dl
	movzbl	-8(%ebp), %eax
	orb	%dl, %al
	.loc 1 34 1
	movl	%ebp, %esp
	.cfi_def_cfa_register 4
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE0:
	.size	vga_color, .-vga_color
	.globl	vga_entry
	.type	vga_entry, @function
vga_entry:
.LFB1:
	.loc 1 36 52
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movb	%al, -4(%ebp)
	movb	%dl, %al
	movb	%al, -8(%ebp)
	.loc 1 37 23
	movzbl	-8(%ebp), %eax
	cwtl
	sall	$8, %eax
	movswl	%ax, %edx
	movzbl	-4(%ebp), %eax
	cwtl
	orl	%edx, %eax
	cwtl
	movzwl	%ax, %eax
	.loc 1 38 1
	movl	%ebp, %esp
	.cfi_def_cfa_register 4
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE1:
	.size	vga_entry, .-vga_entry
	.globl	vga_indexing
	.type	vga_indexing, @function
vga_indexing:
.LFB2:
	.loc 1 40 45
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %edx
	movl	12(%ebp), %ecx
	movb	%dl, -4(%ebp)
	movb	%cl, %dl
	movb	%dl, -8(%ebp)
	.loc 1 41 14
	movzbl	-4(%ebp), %edx
	movzwl	%dx, %ecx
	movzbl	-8(%ebp), %edx
	movzwl	%dx, %edx
	movl	VGA_WIDTH@GOTOFF(%eax), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	movzwl	%ax, %eax
	addl	%ecx, %eax
	movzwl	%ax, %eax
	.loc 1 42 1
	movl	%ebp, %esp
	.cfi_def_cfa_register 4
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE2:
	.size	vga_indexing, .-vga_indexing
	.local	text_color
	.comm	text_color,1,1
	.globl	vga_init
	.type	vga_init, @function
vga_init:
.LFB3:
	.loc 1 46 17
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 47 33
	movl	$2, 4(%esp)
	movl	$0, (%esp)
	call	vga_color
	.loc 1 47 18 discriminator 1
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$32, (%esp)
	call	vga_entry
	movzwl	%ax, %eax
	.loc 1 47 16 discriminator 2
	movb	%al, text_color@GOTOFF(%ebx)
.LBB2:
	.loc 1 48 17
	movb	$0, -10(%ebp)
	.loc 1 48 5
	jmp	.L8
.L11:
.LBB3:
	.loc 1 49 21
	movb	$0, -9(%ebp)
	.loc 1 49 9
	jmp	.L9
.L10:
	.loc 1 50 44
	movzbl	text_color@GOTOFF(%ebx), %eax
	movb	%al, -25(%ebp)
	.loc 1 50 23
	movl	vga_buffer@GOTOFF(%ebx), %esi
	.loc 1 50 24
	movzbl	-9(%ebp), %edx
	movzbl	-10(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	vga_indexing
	movzwl	%ax, %eax
	.loc 1 50 23 discriminator 1
	addl	%eax, %eax
	addl	%esi, %eax
	.loc 1 50 44 discriminator 1
	movzbl	-25(%ebp), %edx
	movzwl	%dx, %edx
	movw	%dx, (%eax)
	.loc 1 49 45 discriminator 3
	movzbl	-9(%ebp), %eax
	incb	%al
	movb	%al, -9(%ebp)
.L9:
	.loc 1 49 30 discriminator 1
	movzbl	-9(%ebp), %edx
	movl	VGA_HEIGHT@GOTOFF(%ebx), %eax
	cmpl	%eax, %edx
	jl	.L10
.LBE3:
	.loc 1 48 40 discriminator 2
	movzbl	-10(%ebp), %eax
	incb	%al
	movb	%al, -10(%ebp)
.L8:
	.loc 1 48 26 discriminator 1
	movzbl	-10(%ebp), %edx
	movl	VGA_WIDTH@GOTOFF(%ebx), %eax
	cmpl	%eax, %edx
	jl	.L11
.LBE2:
	.loc 1 53 1
	nop
	nop
	addl	$28, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE3:
	.size	vga_init, .-vga_init
	.globl	str_len
	.type	str_len, @function
str_len:
.LFB4:
	.loc 1 55 27
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	.loc 1 56 14
	movw	$0, -2(%ebp)
	.loc 1 57 10
	jmp	.L13
.L14:
	.loc 1 58 10
	movzwl	-2(%ebp), %eax
	incl	%eax
	movw	%ax, -2(%ebp)
.L13:
	.loc 1 57 12
	movzwl	-2(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	.loc 1 57 16
	testb	%al, %al
	jne	.L14
	.loc 1 59 12
	movzwl	-2(%ebp), %eax
	.loc 1 60 1
	movl	%ebp, %esp
	.cfi_def_cfa_register 4
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE4:
	.size	str_len, .-str_len
	.globl	vga_str_put_index
	.type	vga_str_put_index, @function
vga_str_put_index:
.LFB5:
	.loc 1 63 49
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	12(%ebp), %eax
	movw	%ax, -28(%ebp)
	.loc 1 64 14
	movl	-28(%ebp), %eax
	movw	%ax, -16(%ebp)
	.loc 1 65 22
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	str_len
	movw	%ax, -14(%ebp)
.LBB4:
	.loc 1 66 13
	movl	$0, -12(%ebp)
	.loc 1 66 5
	jmp	.L17
.L21:
	.loc 1 67 13
	movl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	.loc 1 67 11
	cmpb	$10, %al
	je	.L18
	.loc 1 67 32 discriminator 2
	movzwl	-16(%ebp), %eax
	movl	VGA_WIDTH@GOTOFF(%ebx), %ecx
	cltd
	idivl	%ecx
	.loc 1 67 57 discriminator 2
	movl	VGA_WIDTH@GOTOFF(%ebx), %eax
	decl	%eax
	.loc 1 67 25 discriminator 2
	cmpl	%eax, %edx
	jne	.L19
.L18:
	.loc 1 68 17
	movl	line@GOTOFF(%ebx), %eax
	incl	%eax
	movl	%eax, line@GOTOFF(%ebx)
	.loc 1 69 17
	movl	line@GOTOFF(%ebx), %eax
	movzwl	%ax, %edx
	movl	VGA_WIDTH@GOTOFF(%ebx), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	movw	%ax, -16(%ebp)
	.loc 1 70 13
	jmp	.L20
.L19:
	.loc 1 72 27
	movzbl	text_color@GOTOFF(%ebx), %eax
	movzbl	%al, %edx
	.loc 1 72 38
	movl	-12(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	.loc 1 72 27
	movzbl	%al, %eax
	.loc 1 72 19
	movl	vga_buffer@GOTOFF(%ebx), %ecx
	movzwl	-16(%ebp), %esi
	addl	%esi, %esi
	addl	%ecx, %esi
	.loc 1 72 27
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	vga_entry
	movzwl	%ax, %eax
	.loc 1 72 25 discriminator 1
	movw	%ax, (%esi)
	.loc 1 73 12
	movzwl	-16(%ebp), %eax
	incl	%eax
	movw	%ax, -16(%ebp)
.L20:
	.loc 1 66 32 discriminator 2
	incl	-12(%ebp)
.L17:
	.loc 1 66 22 discriminator 1
	movzwl	-14(%ebp), %eax
	cmpl	%eax, -12(%ebp)
	jl	.L21
.LBE4:
	.loc 1 75 1
	nop
	nop
	addl	$28, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE5:
	.size	vga_str_put_index, .-vga_str_put_index
	.globl	vga_str_put
	.type	vga_str_put, @function
vga_str_put:
.LFB6:
	.loc 1 78 27
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%esi
	pushl	%ebx
	subl	$24, %esp
	.cfi_offset 6, -12
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 79 14
	movl	VGA_WIDTH@GOTOFF(%ebx), %eax
	movzwl	%ax, %edx
	movl	line@GOTOFF(%ebx), %eax
	movzwl	%ax, %eax
	imull	%edx, %eax
	movw	%ax, -10(%ebp)
	.loc 1 81 25
	movzbl	text_color@GOTOFF(%ebx), %eax
	movzbl	%al, %edx
	.loc 1 81 15
	movl	vga_buffer@GOTOFF(%ebx), %ecx
	.loc 1 81 19
	movzwl	-10(%ebp), %eax
	leal	1(%eax), %esi
	movw	%si, -10(%ebp)
	.loc 1 81 15
	addl	%eax, %eax
	leal	(%ecx,%eax), %esi
	.loc 1 81 25
	movl	%edx, 4(%esp)
	movl	$32, (%esp)
	call	vga_entry
	movzwl	%ax, %eax
	.loc 1 81 23 discriminator 1
	movw	%ax, (%esi)
	.loc 1 82 25
	movzbl	text_color@GOTOFF(%ebx), %eax
	movzbl	%al, %edx
	.loc 1 82 15
	movl	vga_buffer@GOTOFF(%ebx), %ecx
	.loc 1 82 19
	movzwl	-10(%ebp), %eax
	leal	1(%eax), %esi
	movw	%si, -10(%ebp)
	.loc 1 82 15
	addl	%eax, %eax
	leal	(%ecx,%eax), %esi
	.loc 1 82 25
	movl	%edx, 4(%esp)
	movl	$32, (%esp)
	call	vga_entry
	movzwl	%ax, %eax
	.loc 1 82 23 discriminator 1
	movw	%ax, (%esi)
	.loc 1 83 5
	movzwl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	vga_str_put_index
	.loc 1 84 9
	movl	line@GOTOFF(%ebx), %eax
	incl	%eax
	movl	%eax, line@GOTOFF(%ebx)
	.loc 1 85 1
	nop
	addl	$24, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	vga_str_put, .-vga_str_put
	.section	.rodata
	.align 4
.LC0:
	.string	"seu preto kkkaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	.text
	.globl	kernel_init
	.type	kernel_init, @function
kernel_init:
.LFB7:
	.loc 1 88 20
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 88 20
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	.loc 1 89 5
	call	vga_init
	.loc 1 90 10
	leal	-125(%ebp), %eax
	leal	.LC0@GOTOFF(%ebx), %edx
	movl	$97, %ebx
	movl	%eax, %ecx
	andl	$1, %ecx
	testl	%ecx, %ecx
	je	.L24
	movzbl	(%edx), %ecx
	movb	%cl, (%eax)
	leal	1(%eax), %eax
	leal	1(%edx), %edx
	decl	%ebx
.L24:
	movl	%eax, %ecx
	andl	$2, %ecx
	testl	%ecx, %ecx
	je	.L25
	movzwl	(%edx), %ecx
	movw	%cx, (%eax)
	leal	2(%eax), %eax
	leal	2(%edx), %edx
	subl	$2, %ebx
.L25:
	movl	%ebx, %edi
	andl	$-4, %edi
	movl	$0, %ecx
.L26:
	movl	(%edx,%ecx), %esi
	movl	%esi, (%eax,%ecx)
	addl	$4, %ecx
	cmpl	%edi, %ecx
	jb	.L26
	addl	%ecx, %eax
	addl	%ecx, %edx
	movl	$0, %ecx
	movl	%ebx, %esi
	andl	$2, %esi
	testl	%esi, %esi
	je	.L28
	movzwl	(%edx,%ecx), %esi
	movw	%si, (%eax,%ecx)
	addl	$2, %ecx
.L28:
	andl	$1, %ebx
	testl	%ebx, %ebx
	je	.L29
	movzbl	(%edx,%ecx), %edx
	movb	%dl, (%eax,%ecx)
.L29:
	.loc 1 91 5
	leal	-125(%ebp), %eax
	movl	%eax, (%esp)
	call	vga_str_put
	.loc 1 94 1
	nop
	movl	-28(%ebp), %eax
	subl	%gs:20, %eax
	je	.L30
	call	__stack_chk_fail_local
.L30:
	addl	$140, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%esi
	.cfi_restore 6
	popl	%edi
	.cfi_restore 7
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	kernel_init, .-kernel_init
	.globl	keyboard_event
	.type	keyboard_event, @function
keyboard_event:
.LFB8:
	.loc 1 96 23
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	.loc 1 96 24
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	keyboard_event, .-keyboard_event
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB9:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE9:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB10:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE10:
	.text
.Letext0:
	.file 2 "/usr/include/bits/types.h"
	.file 3 "/usr/include/bits/stdint-uintn.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x368
	.value	0x5
	.byte	0x1
	.byte	0x4
	.long	.Ldebug_abbrev0
	.uleb128 0xc
	.long	.LASF52
	.byte	0x1d
	.byte	0x3
	.long	0x31647
	.long	.LASF0
	.long	.LASF1
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0xd
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.long	.LASF3
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF4
	.uleb128 0x2
	.byte	0xc
	.byte	0x4
	.long	.LASF5
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.long	.LASF6
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF7
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF8
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF9
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF10
	.uleb128 0x7
	.long	.LASF12
	.byte	0x2
	.byte	0x26
	.byte	0x17
	.long	0x55
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF11
	.uleb128 0x7
	.long	.LASF13
	.byte	0x2
	.byte	0x28
	.byte	0x1c
	.long	0x5c
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF14
	.uleb128 0xb
	.long	0x9c
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF15
	.uleb128 0x7
	.long	.LASF16
	.byte	0x3
	.byte	0x18
	.byte	0x13
	.long	0x71
	.uleb128 0x7
	.long	.LASF17
	.byte	0x3
	.byte	0x19
	.byte	0x14
	.long	0x84
	.uleb128 0x4
	.long	.LASF18
	.byte	0x5
	.byte	0xc
	.long	0x2b
	.uleb128 0x5
	.byte	0x3
	.long	VGA_WIDTH
	.uleb128 0x4
	.long	.LASF19
	.byte	0x6
	.byte	0xc
	.long	0x2b
	.uleb128 0x5
	.byte	0x3
	.long	VGA_HEIGHT
	.uleb128 0x4
	.long	.LASF20
	.byte	0x9
	.byte	0xc
	.long	0x2b
	.uleb128 0x5
	.byte	0x3
	.long	line
	.uleb128 0xe
	.long	.LASF49
	.byte	0x7
	.byte	0x4
	.long	0x32
	.byte	0x1
	.byte	0xb
	.byte	0x6
	.long	0x161
	.uleb128 0x1
	.long	.LASF21
	.byte	0
	.uleb128 0x1
	.long	.LASF22
	.byte	0x1
	.uleb128 0x1
	.long	.LASF23
	.byte	0x2
	.uleb128 0x1
	.long	.LASF24
	.byte	0x3
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.uleb128 0x1
	.long	.LASF26
	.byte	0x5
	.uleb128 0x1
	.long	.LASF27
	.byte	0x6
	.uleb128 0x1
	.long	.LASF28
	.byte	0x7
	.uleb128 0x1
	.long	.LASF29
	.byte	0x8
	.uleb128 0x1
	.long	.LASF30
	.byte	0x9
	.uleb128 0x1
	.long	.LASF31
	.byte	0xa
	.uleb128 0x1
	.long	.LASF32
	.byte	0xb
	.uleb128 0x1
	.long	.LASF33
	.byte	0xc
	.uleb128 0x1
	.long	.LASF34
	.byte	0xd
	.uleb128 0x1
	.long	.LASF35
	.byte	0xe
	.uleb128 0x1
	.long	.LASF36
	.byte	0xf
	.byte	0
	.uleb128 0xf
	.long	.LASF53
	.byte	0x1
	.byte	0x1e
	.byte	0xb
	.long	0x173
	.uleb128 0x5
	.byte	0x3
	.long	vga_buffer
	.uleb128 0xb
	.long	0xaf
	.uleb128 0x4
	.long	.LASF37
	.byte	0x2c
	.byte	0x10
	.long	0xa3
	.uleb128 0x5
	.byte	0x3
	.long	text_color
	.uleb128 0x10
	.long	.LASF54
	.byte	0x1
	.byte	0x60
	.byte	0x6
	.long	.LFB8
	.long	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x8
	.long	.LASF38
	.byte	0x58
	.long	.LFB7
	.long	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x1bd
	.uleb128 0x3
	.string	"c"
	.byte	0x5a
	.byte	0xa
	.long	0x1bd
	.uleb128 0x3
	.byte	0x91
	.sleb128 -133
	.byte	0
	.uleb128 0x11
	.long	0x9c
	.long	0x1cd
	.uleb128 0x12
	.long	0x32
	.byte	0x60
	.byte	0
	.uleb128 0x8
	.long	.LASF39
	.byte	0x4e
	.long	.LFB6
	.long	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.long	0x1fc
	.uleb128 0x5
	.string	"c"
	.byte	0x4e
	.byte	0x18
	.long	0x97
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x3
	.string	"ind"
	.byte	0x4f
	.byte	0xe
	.long	0xaf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.uleb128 0x8
	.long	.LASF40
	.byte	0x3f
	.long	.LFB5
	.long	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.long	0x25d
	.uleb128 0x5
	.string	"c"
	.byte	0x3f
	.byte	0x1e
	.long	0x97
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x6
	.long	.LASF41
	.byte	0x3f
	.byte	0x2a
	.long	0xaf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x3
	.string	"ind"
	.byte	0x40
	.byte	0xe
	.long	0xaf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x4
	.long	.LASF42
	.byte	0x41
	.byte	0xe
	.long	0xaf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x9
	.long	.LBB4
	.long	.LBE4-.LBB4
	.uleb128 0x3
	.string	"i"
	.byte	0x42
	.byte	0xd
	.long	0x2b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.uleb128 0xa
	.long	.LASF44
	.byte	0x37
	.byte	0xa
	.long	0xaf
	.long	.LFB4
	.long	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x28f
	.uleb128 0x5
	.string	"c"
	.byte	0x37
	.byte	0x18
	.long	0x97
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x3
	.string	"i"
	.byte	0x38
	.byte	0xe
	.long	0xaf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x8
	.long	.LASF43
	.byte	0x2e
	.long	.LFB3
	.long	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x2d0
	.uleb128 0x9
	.long	.LBB2
	.long	.LBE2-.LBB2
	.uleb128 0x3
	.string	"x"
	.byte	0x30
	.byte	0x11
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x9
	.long	.LBB3
	.long	.LBE3-.LBB3
	.uleb128 0x3
	.string	"y"
	.byte	0x31
	.byte	0x15
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xa
	.long	.LASF45
	.byte	0x28
	.byte	0xa
	.long	0xaf
	.long	.LFB2
	.long	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x302
	.uleb128 0x5
	.string	"x"
	.byte	0x28
	.byte	0x1f
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x5
	.string	"y"
	.byte	0x28
	.byte	0x2a
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0xa
	.long	.LASF46
	.byte	0x24
	.byte	0xb
	.long	0xaf
	.long	.LFB1
	.long	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x338
	.uleb128 0x6
	.long	.LASF47
	.byte	0x24
	.byte	0x1d
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x6
	.long	.LASF48
	.byte	0x24
	.byte	0x2d
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x13
	.long	.LASF49
	.byte	0x1
	.byte	0x20
	.byte	0xa
	.long	0xa3
	.long	.LFB0
	.long	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x6
	.long	.LASF50
	.byte	0x20
	.byte	0x1c
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x6
	.long	.LASF51
	.byte	0x20
	.byte	0x30
	.long	0xa3
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x90
	.uleb128 0xb
	.uleb128 0x91
	.uleb128 0x6
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF48:
	.string	"color"
.LASF52:
	.string	"GNU C23 15.2.1 20260103 -m32 -march=i686 -g -ggdb"
.LASF32:
	.string	"VGA_COLOR_LIGHT_CYAN"
.LASF40:
	.string	"vga_str_put_index"
.LASF37:
	.string	"text_color"
.LASF41:
	.string	"index"
.LASF11:
	.string	"short int"
.LASF53:
	.string	"vga_buffer"
.LASF54:
	.string	"keyboard_event"
.LASF44:
	.string	"str_len"
.LASF34:
	.string	"VGA_COLOR_LIGHT_MAGENTA"
.LASF46:
	.string	"vga_entry"
.LASF19:
	.string	"VGA_HEIGHT"
.LASF13:
	.string	"__uint16_t"
.LASF31:
	.string	"VGA_COLOR_LIGHT_GREEN"
.LASF27:
	.string	"VGA_COLOR_BROWN"
.LASF16:
	.string	"uint8_t"
.LASF29:
	.string	"VGA_COLOR_DARK_GREY"
.LASF20:
	.string	"line"
.LASF42:
	.string	"c_len"
.LASF24:
	.string	"VGA_COLOR_CYAN"
.LASF4:
	.string	"long long int"
.LASF23:
	.string	"VGA_COLOR_GREEN"
.LASF3:
	.string	"long int"
.LASF12:
	.string	"__uint8_t"
.LASF51:
	.string	"foreground"
.LASF45:
	.string	"vga_indexing"
.LASF5:
	.string	"long double"
.LASF7:
	.string	"unsigned char"
.LASF18:
	.string	"VGA_WIDTH"
.LASF10:
	.string	"signed char"
.LASF14:
	.string	"long long unsigned int"
.LASF2:
	.string	"unsigned int"
.LASF47:
	.string	"letter"
.LASF17:
	.string	"uint16_t"
.LASF30:
	.string	"VGA_COLOR_LIGHT_BLUE"
.LASF43:
	.string	"vga_init"
.LASF33:
	.string	"VGA_COLOR_LIGHT_RED"
.LASF8:
	.string	"short unsigned int"
.LASF15:
	.string	"char"
.LASF39:
	.string	"vga_str_put"
.LASF25:
	.string	"VGA_COLOR_RED"
.LASF9:
	.string	"long unsigned int"
.LASF49:
	.string	"vga_color"
.LASF22:
	.string	"VGA_COLOR_BLUE"
.LASF36:
	.string	"VGA_COLOR_WHITE"
.LASF6:
	.string	"_Float128"
.LASF26:
	.string	"VGA_COLOR_MAGENTA"
.LASF35:
	.string	"VGA_COLOR_LIGHT_BROWN"
.LASF50:
	.string	"background"
.LASF21:
	.string	"VGA_COLOR_BLACK"
.LASF38:
	.string	"kernel_init"
.LASF28:
	.string	"VGA_COLOR_LIGHT_GREY"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/bandeira/Documents/GIT/MyKernel"
.LASF0:
	.string	"src/main.c"
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (GNU) 15.2.1 20260103"
	.section	.note.GNU-stack,"",@progbits
