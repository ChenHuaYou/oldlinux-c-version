	.file	"keyb.cc"
	.text
	.globl	_Z18keyboard_interruptv
	.type	_Z18keyboard_interruptv, @function
_Z18keyboard_interruptv:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 68 "keyb.cc" 1
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	push %ds
	push %es
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	xor %al,%al		/* %eax is scan code */
	inb $0x60,%al
	cmpb $0xe0,%al
	je set_e0
	cmpb $0xe1,%al
	je set_e1
	call *key_table(,%eax,4)
	movb $0,e0
	e0_e1:	inb $0x61,%al
	jmp 1f
	1:	jmp 1f
	1:	orb $0x80,%al
	jmp 1f
	1:	jmp 1f
	1:	outb %al,$0x61
	jmp 1f
	1:	jmp 1f
	1:	andb $0x7F,%al
	outb %al,$0x61
	movb $0x20,%al
	outb %al,$0x20
	pushl $0
	call do_tty_interrupt
	addl $4,%esp
	pop %es
	pop %ds
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	iret
	set_e0:	movb $1,e0
	jmp e0_e1
	set_e1:	movb $2,e0
	jmp e0_e1
	
# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	_Z18keyboard_interruptv, .-_Z18keyboard_interruptv
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
