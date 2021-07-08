	.file	"fork.cc"
	.text
.Ltext0:
	.globl	_Z11verify_areaPvi
	.type	_Z11verify_areaPvi, @function
_Z11verify_areaPvi:
.LFB10:
	.file 1 "fork.cc"
	.loc 1 26 0
	.cfi_startproc
.LVL0:
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	16(%esp), %esi
.LVL1:
	.loc 1 30 0
	movl	%esi, %eax
	andl	$4095, %eax
	addl	20(%esp), %eax
.LVL2:
	.loc 1 31 0
	andl	$-4096, %esi
.LVL3:
	.loc 1 32 0
	movl	current@GOT(%ebx), %edx
	movl	(%edx), %ecx
.LVL4:
.LBB10:
.LBB11:
	.file 2 "../include/linux/sched.h"
	.loc 2 273 0
#APP
# 273 "../include/linux/sched.h" 1
	movb 743(%ecx),%dh
	movb 740(%ecx),%dl
	shll $16,%edx
	movw 738(%ecx),%dx
# 0 "" 2
.LVL5:
#NO_APP
.LBE11:
.LBE10:
	.loc 1 32 0
	addl	%edx, %esi
.LVL6:
	.loc 1 33 0
	testl	%eax, %eax
	jle	.L1
	decl	%eax
.LVL7:
	andl	$-4096, %eax
.LVL8:
	leal	4096(%esi,%eax), %edi
.LVL9:
.L3:
	.loc 1 35 0
	subl	$12, %esp
	.cfi_def_cfa_offset 28
	pushl	%esi
	.cfi_def_cfa_offset 32
	call	_Z12write_verifym@PLT
.LVL10:
	.loc 1 36 0
	addl	$4096, %esi
.LVL11:
	.loc 1 33 0
	addl	$16, %esp
	.cfi_def_cfa_offset 16
	cmpl	%edi, %esi
	jne	.L3
.LVL12:
.L1:
	.loc 1 38 0
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
.LVL13:
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
.LFE10:
	.size	_Z11verify_areaPvi, .-_Z11verify_areaPvi
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"We don't support separate I&D"
.LC1:
	.string	"Bad data_limit"
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 4
.LC2:
	.string	"free_page_tables: from copy_mem\n"
	.text
	.globl	_Z8copy_memiP11task_struct
	.type	_Z8copy_memiP11task_struct, @function
_Z8copy_memiP11task_struct:
.LFB11:
	.loc 1 41 0
	.cfi_startproc
.LVL14:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$28, %esp
	.cfi_def_cfa_offset 48
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	52(%esp), %esi
.LBB12:
	.loc 1 45 0
	movl	$15, %edi
#APP
# 45 "fork.cc" 1
	lsll %edi,%edi
	incl %edi
# 0 "" 2
.LVL15:
#NO_APP
.LBE12:
.LBB13:
	.loc 1 46 0
	movl	$23, %ebp
#APP
# 46 "fork.cc" 1
	lsll %ebp,%ebp
	incl %ebp
# 0 "" 2
.LVL16:
#NO_APP
.LBE13:
	.loc 1 47 0
	movl	current@GOT(%ebx), %eax
	movl	(%eax), %eax
.LVL17:
.LBB14:
.LBB15:
	.loc 2 273 0
#APP
# 273 "../include/linux/sched.h" 1
	movb 735(%eax),%dh
	movb 732(%eax),%dl
	shll $16,%edx
	movw 730(%eax),%dx
# 0 "" 2
#NO_APP
	movl	%edx, %ecx
.LVL18:
.LBE15:
.LBE14:
.LBB16:
.LBB17:
#APP
# 273 "../include/linux/sched.h" 1
	movb 743(%eax),%dh
	movb 740(%eax),%dl
	shll $16,%edx
	movw 738(%eax),%dx
# 0 "" 2
#NO_APP
	movl	%edx, 12(%esp)
.LVL19:
.LBE17:
.LBE16:
	.loc 1 49 0
	cmpl	%ecx, %edx
	jne	.L11
.L7:
	.loc 1 51 0
	cmpl	%ebp, %edi
	ja	.L12
.L8:
	.loc 1 53 0
	movl	48(%esp), %edi
.LVL20:
	sall	$26, %edi
.LVL21:
	.loc 1 54 0
	movl	%edi, 536(%esi)
	.loc 1 55 0
	movl	%edi, %edx
#APP
# 55 "fork.cc" 1
	push %edx
	movw %dx,730(%esi)
	rorl $16,%edx
	movb %dl,732(%esi)
	movb %dh,735(%esi)
	pop %edx
# 0 "" 2
	.loc 1 56 0
# 56 "fork.cc" 1
	push %edx
	movw %dx,738(%esi)
	rorl $16,%edx
	movb %dl,740(%esi)
	movb %dh,743(%esi)
	pop %edx
# 0 "" 2
	.loc 1 57 0
#NO_APP
	subl	$4, %esp
	.cfi_def_cfa_offset 52
	pushl	%ebp
	.cfi_def_cfa_offset 56
	pushl	%edi
	.cfi_def_cfa_offset 60
	pushl	24(%esp)
	.cfi_def_cfa_offset 64
	call	_Z16copy_page_tablesmml@PLT
.LVL22:
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	testl	%eax, %eax
	jne	.L13
.LVL23:
.L6:
	.loc 1 63 0
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
.LVL24:
	ret
.LVL25:
.L11:
	.cfi_restore_state
	.loc 1 50 0
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	_Z5panicPKc@PLT
.LVL26:
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	jmp	.L7
.L12:
	.loc 1 52 0
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	_Z5panicPKc@PLT
.LVL27:
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	jmp	.L8
.LVL28:
.L13:
	.loc 1 58 0
	subl	$12, %esp
	.cfi_def_cfa_offset 60
	leal	.LC2@GOTOFF(%ebx), %eax
	pushl	%eax
	.cfi_def_cfa_offset 64
	call	printk@PLT
.LVL29:
	.loc 1 59 0
	addl	$8, %esp
	.cfi_def_cfa_offset 56
	pushl	%ebp
	.cfi_def_cfa_offset 60
	pushl	%edi
	.cfi_def_cfa_offset 64
	call	_Z16free_page_tablesmm@PLT
.LVL30:
	addl	$16, %esp
	.cfi_def_cfa_offset 48
	.loc 1 60 0
	movl	$-12, %eax
.LVL31:
	jmp	.L6
	.cfi_endproc
.LFE11:
	.size	_Z8copy_memiP11task_struct, .-_Z8copy_memiP11task_struct
	.globl	_Z12copy_processillllllllllllllll
	.type	_Z12copy_processillllllllllllllll, @function
_Z12copy_processillllllllllllllll:
.LFB12:
	.loc 1 74 0
	.cfi_startproc
.LVL32:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$12, %esp
	.cfi_def_cfa_offset 32
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	.loc 1 79 0
	call	_Z13get_free_pagev@PLT
.LVL33:
	.loc 1 80 0
	testl	%eax, %eax
	je	.L23
	movl	%eax, %ebp
	.loc 1 82 0
	movl	task@GOT(%ebx), %eax
.LVL34:
	movl	32(%esp), %edi
	movl	%ebp, (%eax,%edi,4)
	.loc 1 84 0
	movl	current@GOT(%ebx), %eax
	movl	(%eax), %esi
	movl	$239, %ecx
	movl	%ebp, %edi
	rep movsl
	.loc 1 85 0
	movl	$2, 0(%ebp)
	.loc 1 86 0
	movl	last_pid@GOTOFF(%ebx), %edx
	movl	%edx, 556(%ebp)
	.loc 1 87 0
	movl	(%eax), %edx
	movl	556(%edx), %eax
	movl	%eax, 560(%ebp)
	.loc 1 88 0
	movl	8(%ebp), %eax
	movl	%eax, 4(%ebp)
	.loc 1 89 0
	movl	$0, 12(%ebp)
	.loc 1 90 0
	movl	$0, 588(%ebp)
	.loc 1 91 0
	movl	$0, 572(%ebp)
	.loc 1 92 0
	movl	$0, 596(%ebp)
	movl	$0, 592(%ebp)
	.loc 1 93 0
	movl	$0, 604(%ebp)
	movl	$0, 600(%ebp)
	.loc 1 94 0
	movl	jiffies@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, 608(%ebp)
	.loc 1 95 0
	movl	$0, 744(%ebp)
	.loc 1 96 0
	leal	4096(%ebp), %eax
	movl	%eax, 748(%ebp)
	.loc 1 97 0
	movl	$16, 752(%ebp)
	.loc 1 98 0
	movl	80(%esp), %eax
	movl	%eax, 776(%ebp)
	.loc 1 99 0
	movl	88(%esp), %eax
	movl	%eax, 780(%ebp)
	.loc 1 100 0
	movl	$0, 784(%ebp)
	.loc 1 101 0
	movl	60(%esp), %eax
	movl	%eax, 788(%ebp)
	.loc 1 102 0
	movl	64(%esp), %eax
	movl	%eax, 792(%ebp)
	.loc 1 103 0
	movl	56(%esp), %eax
	movl	%eax, 796(%ebp)
	.loc 1 104 0
	movl	92(%esp), %eax
	movl	%eax, 800(%ebp)
	.loc 1 105 0
	movl	36(%esp), %eax
	movl	%eax, 804(%ebp)
	.loc 1 106 0
	movl	44(%esp), %eax
	movl	%eax, 808(%ebp)
	.loc 1 107 0
	movl	40(%esp), %eax
	movl	%eax, 812(%ebp)
	.loc 1 108 0
	movzwl	72(%esp), %eax
	movl	%eax, 816(%ebp)
	.loc 1 109 0
	movzwl	84(%esp), %eax
	movl	%eax, 820(%ebp)
	.loc 1 110 0
	movzwl	96(%esp), %eax
	movl	%eax, 824(%ebp)
	.loc 1 111 0
	movzwl	76(%esp), %eax
	movl	%eax, 828(%ebp)
	.loc 1 112 0
	movzwl	68(%esp), %eax
	movl	%eax, 832(%ebp)
	.loc 1 113 0
	movzwl	48(%esp), %eax
	movl	%eax, 836(%ebp)
	.loc 1 114 0
	movl	32(%esp), %eax
	sall	$4, %eax
	addl	$40, %eax
	movl	%eax, 840(%ebp)
	.loc 1 115 0
	movl	$-2147483648, 844(%ebp)
	.loc 1 116 0
	movl	last_task_used_math@GOT(%ebx), %eax
	cmpl	(%eax), %edx
	je	.L26
.L16:
	.loc 1 118 0
	subl	$8, %esp
	.cfi_def_cfa_offset 40
	pushl	%ebp
	.cfi_def_cfa_offset 44
	pushl	44(%esp)
	.cfi_def_cfa_offset 48
	call	_Z8copy_memiP11task_struct
.LVL35:
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	testl	%eax, %eax
	jne	.L27
	leal	640(%ebp), %eax
	leal	720(%ebp), %ecx
	jmp	.L19
.L26:
	.loc 1 117 0
#APP
# 117 "fork.cc" 1
	clts ; fnsave 848(%ebp)
# 0 "" 2
#NO_APP
	jmp	.L16
.L27:
	.loc 1 119 0
	movl	task@GOT(%ebx), %eax
	movl	32(%esp), %esi
	movl	$0, (%eax,%esi,4)
	.loc 1 120 0
	subl	$12, %esp
	.cfi_def_cfa_offset 44
	pushl	%ebp
	.cfi_def_cfa_offset 48
	call	_Z9free_pagem@PLT
.LVL36:
	.loc 1 121 0
	addl	$16, %esp
	.cfi_def_cfa_offset 32
	movl	$-11, %eax
	jmp	.L14
.LVL37:
.L18:
	addl	$4, %eax
	.loc 1 123 0 discriminator 2
	cmpl	%ecx, %eax
	je	.L28
.LVL38:
.L19:
	.loc 1 124 0
	movl	(%eax), %edx
.LVL39:
	testl	%edx, %edx
	je	.L18
	.loc 1 125 0
	incw	4(%edx)
	jmp	.L18
.L28:
	.loc 1 128 0
	movl	current@GOT(%ebx), %eax
	movl	(%eax), %eax
	movl	624(%eax), %edx
.LVL40:
	testl	%edx, %edx
	je	.L20
	.loc 1 129 0
	incw	48(%edx)
.L20:
	.loc 1 130 0
	movl	628(%eax), %edx
	testl	%edx, %edx
	je	.L21
	.loc 1 131 0
	incw	48(%edx)
.L21:
	.loc 1 132 0
	movl	632(%eax), %eax
	testl	%eax, %eax
	je	.L22
	.loc 1 133 0
	incw	48(%eax)
.L22:
	.loc 1 134 0
	movl	32(%esp), %eax
	leal	4(%eax,%eax), %edx
	sall	$3, %edx
	leal	744(%ebp), %eax
	movl	gdt@GOT(%ebx), %ecx
#APP
# 134 "fork.cc" 1
	movw $104,(%edx,%ecx)
	movw %ax,2(%edx,%ecx)
	rorl $16,%eax
	movb %al,4(%edx,%ecx)
	movb $0x89,5(%edx,%ecx)
	movb $0x00,6(%edx,%ecx)
	movb %ah,7(%edx,%ecx)
	rorl $16,%eax
# 0 "" 2
	.loc 1 135 0
#NO_APP
	leal	720(%ebp), %eax
#APP
# 135 "fork.cc" 1
	movw $104,8(%edx,%ecx)
	movw %ax,10(%edx,%ecx)
	rorl $16,%eax
	movb %al,12(%edx,%ecx)
	movb $0x82,13(%edx,%ecx)
	movb $0x00,14(%edx,%ecx)
	movb %ah,15(%edx,%ecx)
	rorl $16,%eax
# 0 "" 2
	.loc 1 136 0
#NO_APP
	movl	$0, 0(%ebp)
	.loc 1 137 0
	movl	last_pid@GOTOFF(%ebx), %eax
.LVL41:
.L14:
	.loc 1 138 0
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
.LVL42:
.L23:
	.cfi_restore_state
	.loc 1 81 0
	movl	$-11, %eax
.LVL43:
	jmp	.L14
	.cfi_endproc
.LFE12:
	.size	_Z12copy_processillllllllllllllll, .-_Z12copy_processillllllllllllllll
	.globl	_Z18find_empty_processv
	.type	_Z18find_empty_processv, @function
_Z18find_empty_processv:
.LFB13:
	.loc 1 141 0
	.cfi_startproc
	.loc 1 151 0
	ret
	.cfi_endproc
.LFE13:
	.size	_Z18find_empty_processv, .-_Z18find_empty_processv
	.globl	_Z4testv
	.type	_Z4testv, @function
_Z4testv:
.LFB14:
	.loc 1 154 0
	.cfi_startproc
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
.LVL44:
	.loc 1 156 0
	flds	.LC3@GOTOFF(%eax)
	.loc 1 157 0
	ret
	.cfi_endproc
.LFE14:
	.size	_Z4testv, .-_Z4testv
	.globl	last_pid
	.bss
	.align 4
	.type	last_pid, @object
	.size	last_pid, 4
last_pid:
	.zero	4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC3:
	.long	1120403325
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB15:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE15:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB16:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE16:
	.text
.Letext0:
	.file 3 "../include/linux/fs.h"
	.file 4 "../include/errno.h"
	.file 5 "../include/linux/head.h"
	.file 6 "../include/sys/types.h"
	.file 7 "../include/signal.h"
	.file 8 "../include/linux/mm.h"
	.file 9 "../include/linux/kernel.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xcee
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF160
	.byte	0x4
	.long	.LASF161
	.long	.LASF162
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.long	.LASF1
	.uleb128 0x3
	.long	0x2c
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF3
	.uleb128 0x5
	.long	.LASF103
	.byte	0x6
	.byte	0x20
	.long	0x2c
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x6
	.long	.LASF18
	.byte	0x24
	.byte	0x3
	.byte	0x44
	.long	0xfc
	.uleb128 0x7
	.long	.LASF5
	.byte	0x3
	.byte	0x45
	.long	0xfc
	.byte	0
	.uleb128 0x7
	.long	.LASF6
	.byte	0x3
	.byte	0x46
	.long	0x102
	.byte	0x4
	.uleb128 0x7
	.long	.LASF7
	.byte	0x3
	.byte	0x47
	.long	0x3f
	.byte	0x8
	.uleb128 0x7
	.long	.LASF8
	.byte	0x3
	.byte	0x48
	.long	0x46
	.byte	0xa
	.uleb128 0x7
	.long	.LASF9
	.byte	0x3
	.byte	0x49
	.long	0x46
	.byte	0xb
	.uleb128 0x7
	.long	.LASF10
	.byte	0x3
	.byte	0x4a
	.long	0x46
	.byte	0xc
	.uleb128 0x7
	.long	.LASF11
	.byte	0x3
	.byte	0x4b
	.long	0x46
	.byte	0xd
	.uleb128 0x7
	.long	.LASF12
	.byte	0x3
	.byte	0x4c
	.long	0x30d
	.byte	0x10
	.uleb128 0x7
	.long	.LASF13
	.byte	0x3
	.byte	0x4d
	.long	0x313
	.byte	0x14
	.uleb128 0x7
	.long	.LASF14
	.byte	0x3
	.byte	0x4e
	.long	0x313
	.byte	0x18
	.uleb128 0x7
	.long	.LASF15
	.byte	0x3
	.byte	0x4f
	.long	0x313
	.byte	0x1c
	.uleb128 0x7
	.long	.LASF16
	.byte	0x3
	.byte	0x50
	.long	0x313
	.byte	0x20
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x58
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF17
	.uleb128 0x9
	.long	.LASF19
	.value	0x3bc
	.byte	0x2
	.byte	0x50
	.long	0x30d
	.uleb128 0x7
	.long	.LASF20
	.byte	0x2
	.byte	0x52
	.long	0x2c
	.byte	0
	.uleb128 0x7
	.long	.LASF21
	.byte	0x2
	.byte	0x53
	.long	0x2c
	.byte	0x4
	.uleb128 0x7
	.long	.LASF22
	.byte	0x2
	.byte	0x54
	.long	0x2c
	.byte	0x8
	.uleb128 0x7
	.long	.LASF23
	.byte	0x2
	.byte	0x55
	.long	0x2c
	.byte	0xc
	.uleb128 0x7
	.long	.LASF24
	.byte	0x2
	.byte	0x56
	.long	0x871
	.byte	0x10
	.uleb128 0xa
	.long	.LASF25
	.byte	0x2
	.byte	0x57
	.long	0x2c
	.value	0x210
	.uleb128 0xa
	.long	.LASF26
	.byte	0x2
	.byte	0x59
	.long	0x38
	.value	0x214
	.uleb128 0xa
	.long	.LASF27
	.byte	0x2
	.byte	0x5a
	.long	0x102
	.value	0x218
	.uleb128 0xa
	.long	.LASF28
	.byte	0x2
	.byte	0x5a
	.long	0x102
	.value	0x21c
	.uleb128 0xa
	.long	.LASF29
	.byte	0x2
	.byte	0x5a
	.long	0x102
	.value	0x220
	.uleb128 0xb
	.string	"brk"
	.byte	0x2
	.byte	0x5a
	.long	0x102
	.value	0x224
	.uleb128 0xa
	.long	.LASF30
	.byte	0x2
	.byte	0x5a
	.long	0x102
	.value	0x228
	.uleb128 0xb
	.string	"pid"
	.byte	0x2
	.byte	0x5b
	.long	0x2c
	.value	0x22c
	.uleb128 0xa
	.long	.LASF31
	.byte	0x2
	.byte	0x5b
	.long	0x2c
	.value	0x230
	.uleb128 0xa
	.long	.LASF32
	.byte	0x2
	.byte	0x5b
	.long	0x2c
	.value	0x234
	.uleb128 0xa
	.long	.LASF33
	.byte	0x2
	.byte	0x5b
	.long	0x2c
	.value	0x238
	.uleb128 0xa
	.long	.LASF34
	.byte	0x2
	.byte	0x5b
	.long	0x2c
	.value	0x23c
	.uleb128 0xb
	.string	"uid"
	.byte	0x2
	.byte	0x5c
	.long	0x3f
	.value	0x240
	.uleb128 0xa
	.long	.LASF35
	.byte	0x2
	.byte	0x5c
	.long	0x3f
	.value	0x242
	.uleb128 0xa
	.long	.LASF36
	.byte	0x2
	.byte	0x5c
	.long	0x3f
	.value	0x244
	.uleb128 0xb
	.string	"gid"
	.byte	0x2
	.byte	0x5d
	.long	0x3f
	.value	0x246
	.uleb128 0xa
	.long	.LASF37
	.byte	0x2
	.byte	0x5d
	.long	0x3f
	.value	0x248
	.uleb128 0xa
	.long	.LASF38
	.byte	0x2
	.byte	0x5d
	.long	0x3f
	.value	0x24a
	.uleb128 0xa
	.long	.LASF39
	.byte	0x2
	.byte	0x5e
	.long	0x2c
	.value	0x24c
	.uleb128 0xa
	.long	.LASF40
	.byte	0x2
	.byte	0x5f
	.long	0x2c
	.value	0x250
	.uleb128 0xa
	.long	.LASF41
	.byte	0x2
	.byte	0x5f
	.long	0x2c
	.value	0x254
	.uleb128 0xa
	.long	.LASF42
	.byte	0x2
	.byte	0x5f
	.long	0x2c
	.value	0x258
	.uleb128 0xa
	.long	.LASF43
	.byte	0x2
	.byte	0x5f
	.long	0x2c
	.value	0x25c
	.uleb128 0xa
	.long	.LASF44
	.byte	0x2
	.byte	0x5f
	.long	0x2c
	.value	0x260
	.uleb128 0xa
	.long	.LASF45
	.byte	0x2
	.byte	0x60
	.long	0x3f
	.value	0x264
	.uleb128 0xb
	.string	"tty"
	.byte	0x2
	.byte	0x62
	.long	0x38
	.value	0x268
	.uleb128 0xa
	.long	.LASF46
	.byte	0x2
	.byte	0x63
	.long	0x3f
	.value	0x26c
	.uleb128 0xb
	.string	"pwd"
	.byte	0x2
	.byte	0x64
	.long	0x463
	.value	0x270
	.uleb128 0xa
	.long	.LASF47
	.byte	0x2
	.byte	0x65
	.long	0x463
	.value	0x274
	.uleb128 0xa
	.long	.LASF48
	.byte	0x2
	.byte	0x66
	.long	0x463
	.value	0x278
	.uleb128 0xa
	.long	.LASF49
	.byte	0x2
	.byte	0x67
	.long	0x102
	.value	0x27c
	.uleb128 0xa
	.long	.LASF50
	.byte	0x2
	.byte	0x68
	.long	0x881
	.value	0x280
	.uleb128 0xb
	.string	"ldt"
	.byte	0x2
	.byte	0x6a
	.long	0x897
	.value	0x2d0
	.uleb128 0xb
	.string	"tss"
	.byte	0x2
	.byte	0x6c
	.long	0x726
	.value	0x2e8
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x109
	.uleb128 0x8
	.byte	0x4
	.long	0x5f
	.uleb128 0xc
	.long	0x3f
	.long	0x329
	.uleb128 0xd
	.long	0x25
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.long	.LASF51
	.byte	0x38
	.byte	0x3
	.byte	0x5d
	.long	0x41a
	.uleb128 0x7
	.long	.LASF52
	.byte	0x3
	.byte	0x5e
	.long	0x3f
	.byte	0
	.uleb128 0x7
	.long	.LASF53
	.byte	0x3
	.byte	0x5f
	.long	0x3f
	.byte	0x2
	.uleb128 0x7
	.long	.LASF54
	.byte	0x3
	.byte	0x60
	.long	0x102
	.byte	0x4
	.uleb128 0x7
	.long	.LASF55
	.byte	0x3
	.byte	0x61
	.long	0x102
	.byte	0x8
	.uleb128 0x7
	.long	.LASF56
	.byte	0x3
	.byte	0x62
	.long	0x46
	.byte	0xc
	.uleb128 0x7
	.long	.LASF57
	.byte	0x3
	.byte	0x63
	.long	0x46
	.byte	0xd
	.uleb128 0x7
	.long	.LASF58
	.byte	0x3
	.byte	0x64
	.long	0x319
	.byte	0xe
	.uleb128 0x7
	.long	.LASF59
	.byte	0x3
	.byte	0x66
	.long	0x30d
	.byte	0x20
	.uleb128 0x7
	.long	.LASF60
	.byte	0x3
	.byte	0x67
	.long	0x102
	.byte	0x24
	.uleb128 0x7
	.long	.LASF61
	.byte	0x3
	.byte	0x68
	.long	0x102
	.byte	0x28
	.uleb128 0x7
	.long	.LASF62
	.byte	0x3
	.byte	0x69
	.long	0x3f
	.byte	0x2c
	.uleb128 0x7
	.long	.LASF63
	.byte	0x3
	.byte	0x6a
	.long	0x3f
	.byte	0x2e
	.uleb128 0x7
	.long	.LASF64
	.byte	0x3
	.byte	0x6b
	.long	0x3f
	.byte	0x30
	.uleb128 0x7
	.long	.LASF65
	.byte	0x3
	.byte	0x6c
	.long	0x46
	.byte	0x32
	.uleb128 0x7
	.long	.LASF66
	.byte	0x3
	.byte	0x6d
	.long	0x46
	.byte	0x33
	.uleb128 0x7
	.long	.LASF67
	.byte	0x3
	.byte	0x6e
	.long	0x46
	.byte	0x34
	.uleb128 0x7
	.long	.LASF68
	.byte	0x3
	.byte	0x6f
	.long	0x46
	.byte	0x35
	.uleb128 0x7
	.long	.LASF69
	.byte	0x3
	.byte	0x70
	.long	0x46
	.byte	0x36
	.uleb128 0x7
	.long	.LASF70
	.byte	0x3
	.byte	0x71
	.long	0x46
	.byte	0x37
	.byte	0
	.uleb128 0x6
	.long	.LASF71
	.byte	0x10
	.byte	0x3
	.byte	0x74
	.long	0x463
	.uleb128 0x7
	.long	.LASF72
	.byte	0x3
	.byte	0x75
	.long	0x3f
	.byte	0
	.uleb128 0x7
	.long	.LASF73
	.byte	0x3
	.byte	0x76
	.long	0x3f
	.byte	0x2
	.uleb128 0x7
	.long	.LASF74
	.byte	0x3
	.byte	0x77
	.long	0x3f
	.byte	0x4
	.uleb128 0x7
	.long	.LASF75
	.byte	0x3
	.byte	0x78
	.long	0x463
	.byte	0x8
	.uleb128 0x7
	.long	.LASF76
	.byte	0x3
	.byte	0x79
	.long	0x4d
	.byte	0xc
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x329
	.uleb128 0x6
	.long	.LASF77
	.byte	0x6c
	.byte	0x3
	.byte	0x7c
	.long	0x54e
	.uleb128 0x7
	.long	.LASF78
	.byte	0x3
	.byte	0x7d
	.long	0x3f
	.byte	0
	.uleb128 0x7
	.long	.LASF79
	.byte	0x3
	.byte	0x7e
	.long	0x3f
	.byte	0x2
	.uleb128 0x7
	.long	.LASF80
	.byte	0x3
	.byte	0x7f
	.long	0x3f
	.byte	0x4
	.uleb128 0x7
	.long	.LASF81
	.byte	0x3
	.byte	0x80
	.long	0x3f
	.byte	0x6
	.uleb128 0x7
	.long	.LASF82
	.byte	0x3
	.byte	0x81
	.long	0x3f
	.byte	0x8
	.uleb128 0x7
	.long	.LASF83
	.byte	0x3
	.byte	0x82
	.long	0x3f
	.byte	0xa
	.uleb128 0x7
	.long	.LASF84
	.byte	0x3
	.byte	0x83
	.long	0x102
	.byte	0xc
	.uleb128 0x7
	.long	.LASF85
	.byte	0x3
	.byte	0x84
	.long	0x3f
	.byte	0x10
	.uleb128 0x7
	.long	.LASF86
	.byte	0x3
	.byte	0x86
	.long	0x54e
	.byte	0x14
	.uleb128 0x7
	.long	.LASF87
	.byte	0x3
	.byte	0x87
	.long	0x54e
	.byte	0x34
	.uleb128 0x7
	.long	.LASF88
	.byte	0x3
	.byte	0x88
	.long	0x3f
	.byte	0x54
	.uleb128 0x7
	.long	.LASF89
	.byte	0x3
	.byte	0x89
	.long	0x463
	.byte	0x58
	.uleb128 0x7
	.long	.LASF90
	.byte	0x3
	.byte	0x8a
	.long	0x463
	.byte	0x5c
	.uleb128 0x7
	.long	.LASF91
	.byte	0x3
	.byte	0x8b
	.long	0x102
	.byte	0x60
	.uleb128 0x7
	.long	.LASF92
	.byte	0x3
	.byte	0x8c
	.long	0x30d
	.byte	0x64
	.uleb128 0x7
	.long	.LASF93
	.byte	0x3
	.byte	0x8d
	.long	0x46
	.byte	0x68
	.uleb128 0x7
	.long	.LASF94
	.byte	0x3
	.byte	0x8e
	.long	0x46
	.byte	0x69
	.uleb128 0x7
	.long	.LASF95
	.byte	0x3
	.byte	0x8f
	.long	0x46
	.byte	0x6a
	.byte	0
	.uleb128 0xc
	.long	0x313
	.long	0x55e
	.uleb128 0xd
	.long	0x25
	.byte	0x7
	.byte	0
	.uleb128 0xc
	.long	0x329
	.long	0x56e
	.uleb128 0xd
	.long	0x25
	.byte	0x1f
	.byte	0
	.uleb128 0xe
	.long	.LASF96
	.byte	0x3
	.byte	0xa2
	.long	0x55e
	.uleb128 0xc
	.long	0x41a
	.long	0x589
	.uleb128 0xd
	.long	0x25
	.byte	0x3f
	.byte	0
	.uleb128 0xe
	.long	.LASF97
	.byte	0x3
	.byte	0xa3
	.long	0x579
	.uleb128 0xc
	.long	0x469
	.long	0x5a4
	.uleb128 0xd
	.long	0x25
	.byte	0x7
	.byte	0
	.uleb128 0xe
	.long	.LASF77
	.byte	0x3
	.byte	0xa4
	.long	0x594
	.uleb128 0xe
	.long	.LASF98
	.byte	0x3
	.byte	0xa5
	.long	0x313
	.uleb128 0xe
	.long	.LASF99
	.byte	0x3
	.byte	0xa6
	.long	0x38
	.uleb128 0xe
	.long	.LASF100
	.byte	0x3
	.byte	0xc6
	.long	0x38
	.uleb128 0xe
	.long	.LASF101
	.byte	0x4
	.byte	0x11
	.long	0x38
	.uleb128 0x6
	.long	.LASF102
	.byte	0x8
	.byte	0x5
	.byte	0x4
	.long	0x5fc
	.uleb128 0xf
	.string	"a"
	.byte	0x5
	.byte	0x5
	.long	0x102
	.byte	0
	.uleb128 0xf
	.string	"b"
	.byte	0x5
	.byte	0x5
	.long	0x102
	.byte	0x4
	.byte	0
	.uleb128 0x5
	.long	.LASF104
	.byte	0x5
	.byte	0x6
	.long	0x607
	.uleb128 0xc
	.long	0x5db
	.long	0x617
	.uleb128 0xd
	.long	0x25
	.byte	0xff
	.byte	0
	.uleb128 0xc
	.long	0x102
	.long	0x628
	.uleb128 0x10
	.long	0x25
	.value	0x3ff
	.byte	0
	.uleb128 0xe
	.long	.LASF105
	.byte	0x5
	.byte	0x8
	.long	0x617
	.uleb128 0x11
	.string	"idt"
	.byte	0x5
	.byte	0x9
	.long	0x5fc
	.uleb128 0x11
	.string	"gdt"
	.byte	0x5
	.byte	0x9
	.long	0x5fc
	.uleb128 0x5
	.long	.LASF106
	.byte	0x7
	.byte	0x7
	.long	0x25
	.uleb128 0x6
	.long	.LASF24
	.byte	0x10
	.byte	0x7
	.byte	0x30
	.long	0x691
	.uleb128 0x7
	.long	.LASF107
	.byte	0x7
	.byte	0x31
	.long	0x69c
	.byte	0
	.uleb128 0x7
	.long	.LASF108
	.byte	0x7
	.byte	0x32
	.long	0x649
	.byte	0x4
	.uleb128 0x7
	.long	.LASF109
	.byte	0x7
	.byte	0x33
	.long	0x38
	.byte	0x8
	.uleb128 0x7
	.long	.LASF110
	.byte	0x7
	.byte	0x34
	.long	0x6a3
	.byte	0xc
	.byte	0
	.uleb128 0x12
	.long	0x69c
	.uleb128 0x13
	.long	0x38
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x691
	.uleb128 0x14
	.uleb128 0x8
	.byte	0x4
	.long	0x6a2
	.uleb128 0x6
	.long	.LASF111
	.byte	0x6c
	.byte	0x2
	.byte	0x2a
	.long	0x716
	.uleb128 0xf
	.string	"cwd"
	.byte	0x2
	.byte	0x2b
	.long	0x2c
	.byte	0
	.uleb128 0xf
	.string	"swd"
	.byte	0x2
	.byte	0x2c
	.long	0x2c
	.byte	0x4
	.uleb128 0xf
	.string	"twd"
	.byte	0x2
	.byte	0x2d
	.long	0x2c
	.byte	0x8
	.uleb128 0xf
	.string	"fip"
	.byte	0x2
	.byte	0x2e
	.long	0x2c
	.byte	0xc
	.uleb128 0xf
	.string	"fcs"
	.byte	0x2
	.byte	0x2f
	.long	0x2c
	.byte	0x10
	.uleb128 0xf
	.string	"foo"
	.byte	0x2
	.byte	0x30
	.long	0x2c
	.byte	0x14
	.uleb128 0xf
	.string	"fos"
	.byte	0x2
	.byte	0x31
	.long	0x2c
	.byte	0x18
	.uleb128 0x7
	.long	.LASF112
	.byte	0x2
	.byte	0x32
	.long	0x716
	.byte	0x1c
	.byte	0
	.uleb128 0xc
	.long	0x2c
	.long	0x726
	.uleb128 0xd
	.long	0x25
	.byte	0x13
	.byte	0
	.uleb128 0x6
	.long	.LASF113
	.byte	0xd4
	.byte	0x2
	.byte	0x35
	.long	0x871
	.uleb128 0x7
	.long	.LASF114
	.byte	0x2
	.byte	0x36
	.long	0x2c
	.byte	0
	.uleb128 0x7
	.long	.LASF115
	.byte	0x2
	.byte	0x37
	.long	0x2c
	.byte	0x4
	.uleb128 0xf
	.string	"ss0"
	.byte	0x2
	.byte	0x38
	.long	0x2c
	.byte	0x8
	.uleb128 0x7
	.long	.LASF116
	.byte	0x2
	.byte	0x39
	.long	0x2c
	.byte	0xc
	.uleb128 0xf
	.string	"ss1"
	.byte	0x2
	.byte	0x3a
	.long	0x2c
	.byte	0x10
	.uleb128 0x7
	.long	.LASF117
	.byte	0x2
	.byte	0x3b
	.long	0x2c
	.byte	0x14
	.uleb128 0xf
	.string	"ss2"
	.byte	0x2
	.byte	0x3c
	.long	0x2c
	.byte	0x18
	.uleb128 0xf
	.string	"cr3"
	.byte	0x2
	.byte	0x3d
	.long	0x2c
	.byte	0x1c
	.uleb128 0xf
	.string	"eip"
	.byte	0x2
	.byte	0x3e
	.long	0x2c
	.byte	0x20
	.uleb128 0x7
	.long	.LASF118
	.byte	0x2
	.byte	0x3f
	.long	0x2c
	.byte	0x24
	.uleb128 0xf
	.string	"eax"
	.byte	0x2
	.byte	0x40
	.long	0x2c
	.byte	0x28
	.uleb128 0xf
	.string	"ecx"
	.byte	0x2
	.byte	0x40
	.long	0x2c
	.byte	0x2c
	.uleb128 0xf
	.string	"edx"
	.byte	0x2
	.byte	0x40
	.long	0x2c
	.byte	0x30
	.uleb128 0xf
	.string	"ebx"
	.byte	0x2
	.byte	0x40
	.long	0x2c
	.byte	0x34
	.uleb128 0xf
	.string	"esp"
	.byte	0x2
	.byte	0x41
	.long	0x2c
	.byte	0x38
	.uleb128 0xf
	.string	"ebp"
	.byte	0x2
	.byte	0x42
	.long	0x2c
	.byte	0x3c
	.uleb128 0xf
	.string	"esi"
	.byte	0x2
	.byte	0x43
	.long	0x2c
	.byte	0x40
	.uleb128 0xf
	.string	"edi"
	.byte	0x2
	.byte	0x44
	.long	0x2c
	.byte	0x44
	.uleb128 0xf
	.string	"es"
	.byte	0x2
	.byte	0x45
	.long	0x2c
	.byte	0x48
	.uleb128 0xf
	.string	"cs"
	.byte	0x2
	.byte	0x46
	.long	0x2c
	.byte	0x4c
	.uleb128 0xf
	.string	"ss"
	.byte	0x2
	.byte	0x47
	.long	0x2c
	.byte	0x50
	.uleb128 0xf
	.string	"ds"
	.byte	0x2
	.byte	0x48
	.long	0x2c
	.byte	0x54
	.uleb128 0xf
	.string	"fs"
	.byte	0x2
	.byte	0x49
	.long	0x2c
	.byte	0x58
	.uleb128 0xf
	.string	"gs"
	.byte	0x2
	.byte	0x4a
	.long	0x2c
	.byte	0x5c
	.uleb128 0xf
	.string	"ldt"
	.byte	0x2
	.byte	0x4b
	.long	0x2c
	.byte	0x60
	.uleb128 0x7
	.long	.LASF119
	.byte	0x2
	.byte	0x4c
	.long	0x2c
	.byte	0x64
	.uleb128 0x7
	.long	.LASF120
	.byte	0x2
	.byte	0x4d
	.long	0x6a9
	.byte	0x68
	.byte	0
	.uleb128 0xc
	.long	0x654
	.long	0x881
	.uleb128 0xd
	.long	0x25
	.byte	0x1f
	.byte	0
	.uleb128 0xc
	.long	0x891
	.long	0x891
	.uleb128 0xd
	.long	0x25
	.byte	0x13
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.long	0x41a
	.uleb128 0xc
	.long	0x5db
	.long	0x8a7
	.uleb128 0xd
	.long	0x25
	.byte	0x2
	.byte	0
	.uleb128 0xc
	.long	0x30d
	.long	0x8b7
	.uleb128 0xd
	.long	0x25
	.byte	0x3f
	.byte	0
	.uleb128 0xe
	.long	.LASF121
	.byte	0x2
	.byte	0xa6
	.long	0x8a7
	.uleb128 0xe
	.long	.LASF122
	.byte	0x2
	.byte	0xa7
	.long	0x30d
	.uleb128 0xe
	.long	.LASF123
	.byte	0x2
	.byte	0xa8
	.long	0x30d
	.uleb128 0xe
	.long	.LASF124
	.byte	0x2
	.byte	0xa9
	.long	0x33
	.uleb128 0xe
	.long	.LASF125
	.byte	0x2
	.byte	0xaa
	.long	0x2c
	.uleb128 0x15
	.long	.LASF126
	.byte	0x1
	.byte	0x17
	.long	0x2c
	.uleb128 0x5
	.byte	0x3
	.long	last_pid
	.uleb128 0x16
	.long	.LASF128
	.byte	0x1
	.byte	0x99
	.long	.LASF130
	.long	0x92b
	.long	.LFB14
	.long	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x92b
	.uleb128 0x17
	.string	"i"
	.byte	0x1
	.byte	0x9b
	.long	0x92b
	.byte	0x4
	.long	0x42c7ff7d
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.long	.LASF127
	.uleb128 0x16
	.long	.LASF129
	.byte	0x1
	.byte	0x8c
	.long	.LASF131
	.long	0x38
	.long	.LFB13
	.long	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x959
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0x8e
	.long	0x38
	.byte	0
	.uleb128 0x16
	.long	.LASF132
	.byte	0x1
	.byte	0x46
	.long	.LASF133
	.long	0x38
	.long	.LFB12
	.long	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa9d
	.uleb128 0x19
	.string	"nr"
	.byte	0x1
	.byte	0x46
	.long	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.string	"ebp"
	.byte	0x1
	.byte	0x46
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x19
	.string	"edi"
	.byte	0x1
	.byte	0x46
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x19
	.string	"esi"
	.byte	0x1
	.byte	0x46
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 12
	.uleb128 0x19
	.string	"gs"
	.byte	0x1
	.byte	0x46
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 16
	.uleb128 0x1a
	.long	.LASF134
	.byte	0x1
	.byte	0x46
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 20
	.uleb128 0x19
	.string	"ebx"
	.byte	0x1
	.byte	0x47
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x19
	.string	"ecx"
	.byte	0x1
	.byte	0x47
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 28
	.uleb128 0x19
	.string	"edx"
	.byte	0x1
	.byte	0x47
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x19
	.string	"fs"
	.byte	0x1
	.byte	0x48
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 36
	.uleb128 0x19
	.string	"es"
	.byte	0x1
	.byte	0x48
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x19
	.string	"ds"
	.byte	0x1
	.byte	0x48
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 44
	.uleb128 0x19
	.string	"eip"
	.byte	0x1
	.byte	0x49
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 48
	.uleb128 0x19
	.string	"cs"
	.byte	0x1
	.byte	0x49
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 52
	.uleb128 0x1a
	.long	.LASF118
	.byte	0x1
	.byte	0x49
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 56
	.uleb128 0x19
	.string	"esp"
	.byte	0x1
	.byte	0x49
	.long	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 60
	.uleb128 0x19
	.string	"ss"
	.byte	0x1
	.byte	0x49
	.long	0x2c
	.uleb128 0x3
	.byte	0x91
	.sleb128 64
	.uleb128 0x1b
	.string	"p"
	.byte	0x1
	.byte	0x4b
	.long	0x30d
	.long	.LLST11
	.uleb128 0x18
	.string	"i"
	.byte	0x1
	.byte	0x4c
	.long	0x38
	.uleb128 0x1b
	.string	"f"
	.byte	0x1
	.byte	0x4d
	.long	0x891
	.long	.LLST12
	.uleb128 0x1c
	.long	.LVL33
	.long	0xc8c
	.uleb128 0x1c
	.long	.LVL35
	.long	0xa9d
	.uleb128 0x1c
	.long	.LVL36
	.long	0xc9b
	.byte	0
	.uleb128 0x16
	.long	.LASF135
	.byte	0x1
	.byte	0x28
	.long	.LASF136
	.long	0x38
	.long	.LFB11
	.long	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe5
	.uleb128 0x19
	.string	"nr"
	.byte	0x1
	.byte	0x28
	.long	0x38
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x19
	.string	"p"
	.byte	0x1
	.byte	0x28
	.long	0x30d
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x1d
	.long	.LASF137
	.byte	0x1
	.byte	0x2a
	.long	0x102
	.uleb128 0x1e
	.long	.LASF138
	.byte	0x1
	.byte	0x2a
	.long	0x102
	.long	.LLST3
	.uleb128 0x1e
	.long	.LASF139
	.byte	0x1
	.byte	0x2a
	.long	0x102
	.long	.LLST4
	.uleb128 0x1d
	.long	.LASF140
	.byte	0x1
	.byte	0x2b
	.long	0x102
	.uleb128 0x1e
	.long	.LASF141
	.byte	0x1
	.byte	0x2b
	.long	0x102
	.long	.LLST3
	.uleb128 0x1e
	.long	.LASF142
	.byte	0x1
	.byte	0x2b
	.long	0x102
	.long	.LLST6
	.uleb128 0x1f
	.long	.LBB12
	.long	.LBE12-.LBB12
	.long	0xb42
	.uleb128 0x1e
	.long	.LASF143
	.byte	0x1
	.byte	0x2d
	.long	0x102
	.long	.LLST6
	.byte	0
	.uleb128 0x1f
	.long	.LBB13
	.long	.LBE13-.LBB13
	.long	0xb5f
	.uleb128 0x1e
	.long	.LASF143
	.byte	0x1
	.byte	0x2e
	.long	0x102
	.long	.LLST4
	.byte	0
	.uleb128 0x20
	.long	0xc62
	.long	.LBB14
	.long	.LBE14-.LBB14
	.byte	0x1
	.byte	0x2f
	.long	0xb8b
	.uleb128 0x21
	.long	0xc73
	.long	.LLST9
	.uleb128 0x22
	.long	.LBB15
	.long	.LBE15-.LBB15
	.uleb128 0x23
	.long	0xc7f
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	0xc62
	.long	.LBB16
	.long	.LBE16-.LBB16
	.byte	0x1
	.byte	0x30
	.long	0xbb7
	.uleb128 0x21
	.long	0xc73
	.long	.LLST10
	.uleb128 0x22
	.long	.LBB17
	.long	.LBE17-.LBB17
	.uleb128 0x23
	.long	0xc7f
	.byte	0
	.byte	0
	.uleb128 0x1c
	.long	.LVL22
	.long	0xcaa
	.uleb128 0x1c
	.long	.LVL26
	.long	0xcb9
	.uleb128 0x1c
	.long	.LVL27
	.long	0xcb9
	.uleb128 0x1c
	.long	.LVL29
	.long	0xcc8
	.uleb128 0x1c
	.long	.LVL30
	.long	0xcd3
	.byte	0
	.uleb128 0x24
	.long	.LASF163
	.byte	0x1
	.byte	0x19
	.long	.LASF164
	.long	.LFB10
	.long	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xc60
	.uleb128 0x1a
	.long	.LASF144
	.byte	0x1
	.byte	0x19
	.long	0xc60
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x25
	.long	.LASF145
	.byte	0x1
	.byte	0x19
	.long	0x38
	.long	.LLST0
	.uleb128 0x1e
	.long	.LASF146
	.byte	0x1
	.byte	0x1b
	.long	0x102
	.long	.LLST1
	.uleb128 0x20
	.long	0xc62
	.long	.LBB10
	.long	.LBE10-.LBB10
	.byte	0x1
	.byte	0x20
	.long	0xc56
	.uleb128 0x21
	.long	0xc73
	.long	.LLST2
	.uleb128 0x22
	.long	.LBB11
	.long	.LBE11-.LBB11
	.uleb128 0x23
	.long	0xc7f
	.byte	0
	.byte	0
	.uleb128 0x1c
	.long	.LVL10
	.long	0xce2
	.byte	0
	.uleb128 0x26
	.byte	0x4
	.uleb128 0x27
	.long	.LASF165
	.byte	0x2
	.value	0x107
	.long	0x102
	.byte	0x3
	.long	0xc8c
	.uleb128 0x28
	.long	.LASF144
	.byte	0x2
	.value	0x107
	.long	0xfc
	.uleb128 0x29
	.long	.LASF147
	.byte	0x2
	.value	0x109
	.long	0x102
	.byte	0
	.uleb128 0x2a
	.long	.LASF148
	.long	.LASF150
	.byte	0x8
	.byte	0x6
	.long	.LASF148
	.uleb128 0x2a
	.long	.LASF149
	.long	.LASF151
	.byte	0x8
	.byte	0x8
	.long	.LASF149
	.uleb128 0x2a
	.long	.LASF152
	.long	.LASF153
	.byte	0x2
	.byte	0x1d
	.long	.LASF152
	.uleb128 0x2a
	.long	.LASF154
	.long	.LASF155
	.byte	0x9
	.byte	0x5
	.long	.LASF154
	.uleb128 0x2b
	.long	.LASF166
	.long	.LASF166
	.byte	0x9
	.byte	0x7
	.uleb128 0x2a
	.long	.LASF156
	.long	.LASF157
	.byte	0x2
	.byte	0x1e
	.long	.LASF156
	.uleb128 0x2a
	.long	.LASF158
	.long	.LASF159
	.byte	0x1
	.byte	0x15
	.long	.LASF158
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
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
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
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
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x15
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
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
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST11:
	.long	.LVL33-.Ltext0
	.long	.LVL34-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL34-.Ltext0
	.long	.LVL41-.Ltext0
	.value	0x1
	.byte	0x55
	.long	.LVL42-.Ltext0
	.long	.LVL43-.Ltext0
	.value	0x1
	.byte	0x50
	.long	0
	.long	0
.LLST12:
	.long	.LVL37-.Ltext0
	.long	.LVL38-.Ltext0
	.value	0x1
	.byte	0x52
	.long	.LVL39-.Ltext0
	.long	.LVL40-.Ltext0
	.value	0x1
	.byte	0x52
	.long	0
	.long	0
.LLST3:
	.long	.LVL21-.Ltext0
	.long	.LVL23-.Ltext0
	.value	0x1
	.byte	0x57
	.long	.LVL28-.Ltext0
	.long	.LVL31-.Ltext0
	.value	0x1
	.byte	0x57
	.long	0
	.long	0
.LLST4:
	.long	.LVL16-.Ltext0
	.long	.LVL24-.Ltext0
	.value	0x1
	.byte	0x55
	.long	.LVL25-.Ltext0
	.long	.LFE11-.Ltext0
	.value	0x1
	.byte	0x55
	.long	0
	.long	0
.LLST6:
	.long	.LVL15-.Ltext0
	.long	.LVL20-.Ltext0
	.value	0x1
	.byte	0x57
	.long	.LVL25-.Ltext0
	.long	.LVL28-.Ltext0
	.value	0x1
	.byte	0x57
	.long	0
	.long	0
.LLST9:
	.long	.LVL17-.Ltext0
	.long	.LVL18-.Ltext0
	.value	0x4
	.byte	0x70
	.sleb128 728
	.byte	0x9f
	.long	0
	.long	0
.LLST10:
	.long	.LVL18-.Ltext0
	.long	.LVL19-.Ltext0
	.value	0x4
	.byte	0x70
	.sleb128 736
	.byte	0x9f
	.long	0
	.long	0
.LLST0:
	.long	.LVL0-.Ltext0
	.long	.LVL2-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 4
	.long	.LVL2-.Ltext0
	.long	.LVL7-.Ltext0
	.value	0x1
	.byte	0x50
	.long	.LVL7-.Ltext0
	.long	.LVL8-.Ltext0
	.value	0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.long	.LVL8-.Ltext0
	.long	.LVL9-.Ltext0
	.value	0xc
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0xa
	.value	0xfff
	.byte	0x1a
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x22
	.byte	0x9f
	.long	.LVL9-.Ltext0
	.long	.LVL12-.Ltext0
	.value	0x10
	.byte	0x91
	.sleb128 0
	.byte	0x6
	.byte	0xa
	.value	0xfff
	.byte	0x1a
	.byte	0x91
	.sleb128 4
	.byte	0x6
	.byte	0x22
	.byte	0xa
	.value	0x1000
	.byte	0x1c
	.byte	0x9f
	.long	0
	.long	0
.LLST1:
	.long	.LVL1-.Ltext0
	.long	.LVL3-.Ltext0
	.value	0x2
	.byte	0x91
	.sleb128 0
	.long	.LVL3-.Ltext0
	.long	.LVL13-.Ltext0
	.value	0x1
	.byte	0x56
	.long	0
	.long	0
.LLST2:
	.long	.LVL4-.Ltext0
	.long	.LVL5-.Ltext0
	.value	0x4
	.byte	0x71
	.sleb128 736
	.byte	0x9f
	.long	0
	.long	0
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
.LASF153:
	.string	"copy_page_tables"
.LASF79:
	.string	"s_nzones"
.LASF166:
	.string	"printk"
.LASF86:
	.string	"s_imap"
.LASF161:
	.string	"fork.cc"
.LASF30:
	.string	"start_stack"
.LASF7:
	.string	"b_dev"
.LASF5:
	.string	"b_data"
.LASF104:
	.string	"desc_table"
.LASF102:
	.string	"desc_struct"
.LASF125:
	.string	"startup_time"
.LASF29:
	.string	"end_data"
.LASF141:
	.string	"new_code_base"
.LASF109:
	.string	"sa_flags"
.LASF134:
	.string	"none"
.LASF57:
	.string	"i_nlinks"
.LASF60:
	.string	"i_atime"
.LASF40:
	.string	"utime"
.LASF98:
	.string	"start_buffer"
.LASF117:
	.string	"esp2"
.LASF46:
	.string	"umask"
.LASF128:
	.string	"test"
.LASF31:
	.string	"father"
.LASF45:
	.string	"used_math"
.LASF156:
	.string	"_Z16free_page_tablesmm"
.LASF138:
	.string	"new_data_base"
.LASF69:
	.string	"i_seek"
.LASF68:
	.string	"i_mount"
.LASF120:
	.string	"i387"
.LASF144:
	.string	"addr"
.LASF122:
	.string	"last_task_used_math"
.LASF126:
	.string	"last_pid"
.LASF54:
	.string	"i_size"
.LASF20:
	.string	"state"
.LASF1:
	.string	"long int"
.LASF72:
	.string	"f_mode"
.LASF67:
	.string	"i_pipe"
.LASF10:
	.string	"b_count"
.LASF35:
	.string	"euid"
.LASF84:
	.string	"s_max_size"
.LASF154:
	.string	"_Z5panicPKc"
.LASF77:
	.string	"super_block"
.LASF148:
	.string	"_Z13get_free_pagev"
.LASF90:
	.string	"s_imount"
.LASF73:
	.string	"f_flags"
.LASF151:
	.string	"free_page"
.LASF111:
	.string	"i387_struct"
.LASF62:
	.string	"i_dev"
.LASF119:
	.string	"trace_bitmap"
.LASF16:
	.string	"b_next_free"
.LASF103:
	.string	"off_t"
.LASF106:
	.string	"sigset_t"
.LASF48:
	.string	"executable"
.LASF155:
	.string	"panic"
.LASF114:
	.string	"back_link"
.LASF135:
	.string	"copy_mem"
.LASF112:
	.string	"st_space"
.LASF0:
	.string	"unsigned int"
.LASF74:
	.string	"f_count"
.LASF61:
	.string	"i_ctime"
.LASF6:
	.string	"b_blocknr"
.LASF83:
	.string	"s_log_zone_size"
.LASF99:
	.string	"nr_buffers"
.LASF17:
	.string	"long unsigned int"
.LASF9:
	.string	"b_dirt"
.LASF94:
	.string	"s_rd_only"
.LASF56:
	.string	"i_gid"
.LASF145:
	.string	"size"
.LASF2:
	.string	"short unsigned int"
.LASF15:
	.string	"b_prev_free"
.LASF115:
	.string	"esp0"
.LASF116:
	.string	"esp1"
.LASF11:
	.string	"b_lock"
.LASF70:
	.string	"i_update"
.LASF101:
	.string	"errno"
.LASF27:
	.string	"start_code"
.LASF22:
	.string	"priority"
.LASF160:
	.string	"GNU C++14 7.5.0 -march=i386 -m32 -g -O1 -fomit-frame-pointer -finline-functions -fno-stack-protector -fno-builtin"
.LASF147:
	.string	"__base"
.LASF129:
	.string	"find_empty_process"
.LASF97:
	.string	"file_table"
.LASF130:
	.string	"_Z4testv"
.LASF49:
	.string	"close_on_exec"
.LASF26:
	.string	"exit_code"
.LASF91:
	.string	"s_time"
.LASF142:
	.string	"code_limit"
.LASF38:
	.string	"sgid"
.LASF18:
	.string	"buffer_head"
.LASF25:
	.string	"blocked"
.LASF12:
	.string	"b_wait"
.LASF140:
	.string	"old_code_base"
.LASF58:
	.string	"i_zone"
.LASF28:
	.string	"end_code"
.LASF118:
	.string	"eflags"
.LASF24:
	.string	"sigaction"
.LASF87:
	.string	"s_zmap"
.LASF78:
	.string	"s_ninodes"
.LASF52:
	.string	"i_mode"
.LASF105:
	.string	"pg_dir"
.LASF33:
	.string	"session"
.LASF123:
	.string	"current"
.LASF127:
	.string	"float"
.LASF113:
	.string	"tss_struct"
.LASF43:
	.string	"cstime"
.LASF92:
	.string	"s_wait"
.LASF55:
	.string	"i_mtime"
.LASF100:
	.string	"ROOT_DEV"
.LASF163:
	.string	"verify_area"
.LASF39:
	.string	"alarm"
.LASF3:
	.string	"unsigned char"
.LASF96:
	.string	"inode_table"
.LASF162:
	.string	"/home/mc/erp/data/oldlinux-cpp-version/linux/kernel"
.LASF158:
	.string	"_Z12write_verifym"
.LASF81:
	.string	"s_zmap_blocks"
.LASF21:
	.string	"counter"
.LASF71:
	.string	"file"
.LASF124:
	.string	"jiffies"
.LASF76:
	.string	"f_pos"
.LASF85:
	.string	"s_magic"
.LASF50:
	.string	"filp"
.LASF13:
	.string	"b_prev"
.LASF63:
	.string	"i_num"
.LASF137:
	.string	"old_data_base"
.LASF131:
	.string	"_Z18find_empty_processv"
.LASF23:
	.string	"signal"
.LASF32:
	.string	"pgrp"
.LASF37:
	.string	"egid"
.LASF80:
	.string	"s_imap_blocks"
.LASF4:
	.string	"char"
.LASF14:
	.string	"b_next"
.LASF34:
	.string	"leader"
.LASF159:
	.string	"write_verify"
.LASF139:
	.string	"data_limit"
.LASF152:
	.string	"_Z16copy_page_tablesmml"
.LASF121:
	.string	"task"
.LASF66:
	.string	"i_dirt"
.LASF44:
	.string	"start_time"
.LASF41:
	.string	"stime"
.LASF108:
	.string	"sa_mask"
.LASF143:
	.string	"__limit"
.LASF53:
	.string	"i_uid"
.LASF65:
	.string	"i_lock"
.LASF51:
	.string	"m_inode"
.LASF42:
	.string	"cutime"
.LASF157:
	.string	"free_page_tables"
.LASF64:
	.string	"i_count"
.LASF19:
	.string	"task_struct"
.LASF164:
	.string	"_Z11verify_areaPvi"
.LASF136:
	.string	"_Z8copy_memiP11task_struct"
.LASF149:
	.string	"_Z9free_pagem"
.LASF165:
	.string	"_get_base"
.LASF133:
	.string	"_Z12copy_processillllllllllllllll"
.LASF107:
	.string	"sa_handler"
.LASF8:
	.string	"b_uptodate"
.LASF110:
	.string	"sa_restorer"
.LASF95:
	.string	"s_dirt"
.LASF132:
	.string	"copy_process"
.LASF75:
	.string	"f_inode"
.LASF146:
	.string	"start"
.LASF88:
	.string	"s_dev"
.LASF150:
	.string	"get_free_page"
.LASF82:
	.string	"s_firstdatazone"
.LASF89:
	.string	"s_isup"
.LASF36:
	.string	"suid"
.LASF93:
	.string	"s_lock"
.LASF59:
	.string	"i_wait"
.LASF47:
	.string	"root"
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
