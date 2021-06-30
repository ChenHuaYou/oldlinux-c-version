	.file	"system_call.cc"
	.text
#APP
	SIG_CHLD=17
	EAX=0x00
	EBX=0x04
	ECX=0x08
	EDX=0x0C
	FS=0x10
	ES=0x14
	DS=0x18
	EIP=0x1C
	CS=0x20
	EFLAGS=0x24
	OLDESP=0x28
	OLDSS=0x2C
	state=99 #these are offsets into the task-struct.
	counter=4
	priority=8
	signal=12
	sigaction=16#MUST be 16 (=len of sigaction)
	blocked= (33*16)
	#offsets within sigaction
	sa_handler= 0
	sa_mask= 4
	sa_flags= 8
	sa_restorer= 12
	nr_system_calls= 72
	
	bad_sys_call:
	movl $-1,%eax
	iret
	
	reschedule:
	pushl $ret_from_sys_call
	jmp schedule
	
#NO_APP
	.globl	_Z10sys_execvev
	.type	_Z10sys_execvev, @function
_Z10sys_execvev:
.LFB4:
	.cfi_startproc
#APP
# 293 "system_call.cc" 1
	lea EIP(%esp),%eax
	pushl %eax
	call do_execve
	addl $4,%esp
	ret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE4:
	.size	_Z10sys_execvev, .-_Z10sys_execvev
	.globl	_Z8sys_forkv
	.type	_Z8sys_forkv, @function
_Z8sys_forkv:
.LFB5:
	.cfi_startproc
#APP
# 309 "system_call.cc" 1
	call find_empty_process
	testl %eax,%eax
	js 1f
	push %gs
	pushl %esi
	pushl %edi
	pushl %ebp
	pushl %eax
	call copy_process
	addl $20,%esp
	1:	ret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE5:
	.size	_Z8sys_forkv, .-_Z8sys_forkv
	.globl	_Z11system_callv
	.type	_Z11system_callv, @function
_Z11system_callv:
.LFB0:
	.cfi_startproc
#APP
# 207 "system_call.cc" 1
	cmpl $nr_system_calls-1,%eax
	ja bad_sys_call
	push %ds
	push %es
	push %fs
	pushl %edx
	pushl %ecx # push %ebx,%ecx,%edx as parameters
	pushl %ebx # to the system call
	movl $0x10,%edx # set up ds,es to kernel space
	mov %dx,%ds
	mov %dx,%es
	movl $0x17,%edx # fs points to local data space
	mov %dx,%fs
	call *sys_call_table(,%eax,4)
	pushl %eax
	movl current,%eax
	cmpl $0,state(%eax) # state
	jne reschedule
	cmpl $0,counter(%eax) # counter
	je reschedule
	ret_from_sys_call:
	movl current,%eax # task[0] cannot have signals
	cmpl task,%eax
	je 3f
	cmpw $0x0f,CS(%esp) # was old code segment supervisor ?
	jne 3f
	cmpw $0x17,OLDSS(%esp) # was stack segment = 0x17 ?
	jne 3f
	movl signal(%eax),%ebx
	movl blocked(%eax),%ecx
	notl %ecx
	andl %ebx,%ecx
	bsfl %ecx,%ecx
	je 3f
	btrl %ecx,%ebx
	movl %ebx,signal(%eax)
	incl %ecx
	pushl %ecx
	call do_signal
	popl %eax
	3:popl %eax
	popl %ebx
	popl %ecx
	popl %edx
	pop %fs
	pop %es
	pop %ds
	iret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE0:
	.size	_Z11system_callv, .-_Z11system_callv
	.globl	_Z17coprocessor_errorv
	.type	_Z17coprocessor_errorv, @function
_Z17coprocessor_errorv:
.LFB1:
	.cfi_startproc
#APP
# 226 "system_call.cc" 1
	push %ds 
	push %es 
	push %fs 
	pushl %edx 
	pushl %ecx 
	pushl %ebx 
	pushl %eax 
	movl $0x10,%eax 
	mov %ax,%ds 
	mov %ax,%es 
	movl $0x17,%eax 
	mov %ax,%fs 
	pushl $ret_from_sys_call
	jmp math_error
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE1:
	.size	_Z17coprocessor_errorv, .-_Z17coprocessor_errorv
	.globl	_Z20device_not_availablev
	.type	_Z20device_not_availablev, @function
_Z20device_not_availablev:
.LFB2:
	.cfi_startproc
#APP
# 256 "system_call.cc" 1
	push %ds
	push %es
	push %fs
	pushl %edx
	pushl %ecx
	pushl %ebx
	pushl %eax
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	movl $0x17,%eax
	mov %ax,%fs
	pushl $ret_from_sys_call
	clts				# clear TS so that we can use math
	movl %cr0,%eax
	testl $0x4,%eax			# EM (math emulation bit)
	je math_state_restore
	pushl %ebp
	pushl %esi
	pushl %edi
	call math_emulate
	popl %edi
	popl %esi
	popl %ebp
	ret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE2:
	.size	_Z20device_not_availablev, .-_Z20device_not_availablev
	.globl	_Z15timer_interruptv
	.type	_Z15timer_interruptv, @function
_Z15timer_interruptv:
.LFB3:
	.cfi_startproc
#APP
# 282 "system_call.cc" 1
	push %ds		# save ds,es and put kernel data space
	push %es		# into them. %fs is used by _system_call
	push %fs
	pushl %edx		# we save %eax,%ecx,%edx as gcc doesn't
	pushl %ecx		# save those across function calls. %ebx
	pushl %ebx		# is saved as we use that in ret_sys_call
	pushl %eax
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	movl $0x17,%eax
	mov %ax,%fs
	incl jiffies
	movb $0x20,%al		# EOI to interrupt controller #1
	outb %al,$0x20
	movl CS(%esp),%eax
	andl $3,%eax		# %eax is CPL (0 or 3, 0=supervisor)
	pushl %eax
	call do_timer		# 'do_timer(long CPL)' does everything from
	addl $4,%esp		# task switching to accounting ...
	jmp ret_from_sys_call
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE3:
	.size	_Z15timer_interruptv, .-_Z15timer_interruptv
	.globl	_Z12hd_interruptv
	.type	_Z12hd_interruptv, @function
_Z12hd_interruptv:
.LFB6:
	.cfi_startproc
#APP
# 343 "system_call.cc" 1
	pushl %eax
	pushl %ecx
	pushl %edx
	push %ds
	push %es
	push %fs
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	movl $0x17,%eax
	mov %ax,%fs
	movb $0x20,%al
	outb %al,$0xA0		# EOI to interrupt controller #1
	jmp 1f			# give port chance to breathe
	1:	jmp 1f
	1:	xorl %edx,%edx
	xchgl do_hd,%edx
	testl %edx,%edx
	jne 1f
	movl $unexpected_hd_interrupt,%edx
	1:	outb %al,$0x20
	call *%edx		#interesting way of handling intr.
	pop %fs
	pop %es
	pop %ds
	popl %edx
	popl %ecx
	popl %eax
	iret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE6:
	.size	_Z12hd_interruptv, .-_Z12hd_interruptv
	.globl	_Z16floppy_interruptv
	.type	_Z16floppy_interruptv, @function
_Z16floppy_interruptv:
.LFB7:
	.cfi_startproc
#APP
# 374 "system_call.cc" 1
	pushl %eax
	pushl %ecx
	pushl %edx
	push %ds
	push %es
	push %fs
	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	movl $0x17,%eax
	mov %ax,%fs
	movb $0x20,%al
	outb %al,$0x20		# EOI to interrupt controller #1
	xorl %eax,%eax
	xchgl do_floppy,%eax
	testl %eax,%eax
	jne 1f
	movl $unexpected_floppy_interrupt,%eax
	1:	call *%eax		# interesting way of handling intr.
	pop %fs
	pop %es
	pop %ds
	popl %edx
	popl %ecx
	popl %eax
	iret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE7:
	.size	_Z16floppy_interruptv, .-_Z16floppy_interruptv
	.globl	_Z18parallel_interruptv
	.type	_Z18parallel_interruptv, @function
_Z18parallel_interruptv:
.LFB8:
	.cfi_startproc
#APP
# 385 "system_call.cc" 1
	pushl %eax
	movb $0x20,%al
	outb %al,$0x20
	popl %eax
	iret
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE8:
	.size	_Z18parallel_interruptv, .-_Z18parallel_interruptv
	.globl	sys_call_table
	.section	.data.rel,"aw",@progbits
	.align 32
	.type	sys_call_table, @object
	.size	sys_call_table, 288
sys_call_table:
	.long	_Z9sys_setupPv
	.long	_Z8sys_exiti
	.long	_Z8sys_forkv
	.long	_Z8sys_readjPci
	.long	_Z9sys_writejPci
	.long	_Z8sys_openPKcii
	.long	_Z9sys_closej
	.long	_Z11sys_waitpidiPmi
	.long	_Z9sys_creatPKci
	.long	_Z8sys_linkPKcS0_
	.long	_Z10sys_unlinkPKc
	.long	_Z10sys_execvev
	.long	_Z9sys_chdirPKc
	.long	_Z8sys_timePl
	.long	_Z9sys_mknodPKcii
	.long	_Z9sys_chmodPKci
	.long	_Z9sys_chownPKcii
	.long	_Z9sys_breakv
	.long	_Z8sys_statPcP4stat
	.long	_Z9sys_lseekjli
	.long	_Z10sys_getpidv
	.long	_Z9sys_mountPcS_i
	.long	_Z10sys_umountPc
	.long	_Z10sys_setuidi
	.long	_Z10sys_getuidv
	.long	_Z9sys_stimePl
	.long	_Z10sys_ptracev
	.long	_Z9sys_alarml
	.long	_Z9sys_fstatjP4stat
	.long	_Z9sys_pausev
	.long	_Z9sys_utimePcP7utimbuf
	.long	_Z8sys_sttyv
	.long	_Z8sys_gttyv
	.long	_Z10sys_accessPKci
	.long	_Z8sys_nicel
	.long	_Z9sys_ftimev
	.long	_Z8sys_syncv
	.long	_Z8sys_killii
	.long	_Z10sys_renamev
	.long	_Z9sys_mkdirPKci
	.long	_Z9sys_rmdirPKc
	.long	_Z7sys_dupj
	.long	_Z8sys_pipePm
	.long	_Z9sys_timesP3tms
	.long	_Z8sys_profv
	.long	_Z7sys_brkm
	.long	_Z10sys_setgidi
	.long	_Z10sys_getgidv
	.long	_Z10sys_signalill
	.long	_Z11sys_geteuidv
	.long	_Z11sys_getegidv
	.long	_Z8sys_acctv
	.long	_Z8sys_physv
	.long	_Z8sys_lockv
	.long	_Z9sys_ioctljjm
	.long	_Z9sys_fcntljjm
	.long	_Z7sys_mpxv
	.long	_Z11sys_setpgidii
	.long	_Z10sys_ulimitv
	.long	_Z9sys_unameP7utsname
	.long	_Z9sys_umaski
	.long	_Z10sys_chrootPKc
	.long	_Z9sys_ustatiP5ustat
	.long	_Z8sys_dup2jj
	.long	_Z11sys_getppidv
	.long	_Z11sys_getpgrpv
	.long	_Z10sys_setsidv
	.long	_Z13sys_sigactioniPK9sigactionPS_
	.long	_Z12sys_sgetmaskv
	.long	_Z12sys_ssetmaski
	.long	_Z12sys_setreuidii
	.long	_Z12sys_setregidii
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
