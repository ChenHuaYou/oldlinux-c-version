/*
 *  linux/kernel/system_call.cc
 *
 *  (C) 2021 chen.hua.you@163.com
 */

/*
 *  system_call.cc  contains the system-call low-level handling routines.
 * This also contains the timer-interrupt handler, as some of the code is
 * the same. The hd- and flopppy-interrupts are also here.
 *
 * NOTE: This code handles signal-recognition, which happens every time
 * after a timer-interrupt and after each system call. Ordinary interrupts
 * don't handle signal-recognition, as that would clutter them up totally
 * unnecessarily.
 *
 * Stack layout in 'ret_from_system_call':
 *
 *	 0(%esp) - %eax
 *	 4(%esp) - %ebx
 *	 8(%esp) - %ecx
 *	 C(%esp) - %edx
 *	10(%esp) - %fs
 *	14(%esp) - %es
 *	18(%esp) - %ds
 *	1C(%esp) - %eip
 *	20(%esp) - %cs
 *	24(%esp) - %eflags
 *	28(%esp) - %oldesp
 *	2C(%esp) - %oldss
 */

#include <linux/sys.h>
extern struct task_struct *current;
extern struct task_struct * task[];

fn_ptr sys_call_table[] = { 
    (fn_ptr)sys_setup,
    (fn_ptr)sys_exit, 
    (fn_ptr)sys_fork, 
    (fn_ptr)sys_read,
    (fn_ptr)sys_write, 
    (fn_ptr)sys_open, 
    (fn_ptr)sys_close, 
    (fn_ptr)sys_waitpid, 
    (fn_ptr)sys_creat, 
    (fn_ptr)sys_link,
    (fn_ptr)sys_unlink, 
    (fn_ptr)sys_execve, 
    (fn_ptr)sys_chdir, 
    (fn_ptr)sys_time, 
    (fn_ptr)sys_mknod, 
    (fn_ptr)sys_chmod,
    (fn_ptr)sys_chown, 
    (fn_ptr)sys_break, 
    (fn_ptr)sys_stat, 
    (fn_ptr)sys_lseek, 
    (fn_ptr)sys_getpid, 
    (fn_ptr)sys_mount,
    (fn_ptr)sys_umount, 
    (fn_ptr)sys_setuid, 
    (fn_ptr)sys_getuid, 
    (fn_ptr)sys_stime, 
    (fn_ptr)sys_ptrace, 
    (fn_ptr)sys_alarm,
    (fn_ptr)sys_fstat, 
    (fn_ptr)sys_pause, 
    (fn_ptr)sys_utime, 
    (fn_ptr)sys_stty, 
    (fn_ptr)sys_gtty, 
    (fn_ptr)sys_access,
    (fn_ptr)sys_nice, 
    (fn_ptr)sys_ftime, 
    (fn_ptr)sys_sync, 
    (fn_ptr)sys_kill, 
    (fn_ptr)sys_rename, 
    (fn_ptr)sys_mkdir,
    (fn_ptr)sys_rmdir, 
    (fn_ptr)sys_dup, 
    (fn_ptr)sys_pipe, 
    (fn_ptr)sys_times, 
    (fn_ptr)sys_prof, 
    (fn_ptr)sys_brk, 
    (fn_ptr)sys_setgid,
    (fn_ptr)sys_getgid, 
    (fn_ptr)sys_signal, 
    (fn_ptr)sys_geteuid, 
    (fn_ptr)sys_getegid, 
    (fn_ptr)sys_acct, 
    (fn_ptr)sys_phys,
    (fn_ptr)sys_lock, 
    (fn_ptr)sys_ioctl, 
    (fn_ptr)sys_fcntl, 
    (fn_ptr)sys_mpx, 
    (fn_ptr)sys_setpgid, 
    (fn_ptr)sys_ulimit,
    (fn_ptr)sys_uname, 
    (fn_ptr)sys_umask, 
    (fn_ptr)sys_chroot, 
    (fn_ptr)sys_ustat, 
    (fn_ptr)sys_dup2, 
    (fn_ptr)sys_getppid,
    (fn_ptr)sys_getpgrp, 
    (fn_ptr)sys_setsid, 
    (fn_ptr)sys_sigaction, 
    (fn_ptr)sys_sgetmask, 
    (fn_ptr)sys_ssetmask,
    (fn_ptr)sys_setreuid,
    (fn_ptr)sys_setregid 
};

__asm__(
        "SIG_CHLD=17\n\t"
        "EAX=0x00\n\t"
        "EBX=0x04\n\t"
        "ECX=0x08\n\t"
        "EDX=0x0C\n\t"
        "FS=0x10\n\t"
        "ES=0x14\n\t"
        "DS=0x18\n\t"
        "EIP=0x1C\n\t"
        "CS=0x20\n\t"
        "EFLAGS=0x24\n\t"
        "OLDESP=0x28\n\t"
        "OLDSS=0x2C\n\t"
        "state=99 #these are offsets into the task-struct.\n\t"
        "counter=4\n\t"
        "priority=8\n\t"
        "signal=12\n\t"
        "sigaction=16#MUST be 16 (=len of sigaction)\n\t"
        "blocked= (33*16)\n\t"
        "#offsets within sigaction\n\t"
        "sa_handler= 0\n\t"
        "sa_mask= 4\n\t"
        "sa_flags= 8\n\t"
        "sa_restorer= 12\n\t"
        "nr_system_calls= 72\n\t"
        );

/*
 * Ok, I get parallel printer interrupts while using the floppy for some
 * strange reason. Urgel. Now I just ignore them.
 */

__asm__(
        "bad_sys_call:\n\t"
        "movl $-1,%eax\n\t"
        "iret\n\t"
       );

__asm__(
        "reschedule:\n\t"
        "pushl $ret_from_sys_call\n\t"
        "jmp schedule\n\t"
       );

__attribute__((fastcall)) void system_call(void){
    __asm__ __volatile__(
            "cmpl $nr_system_calls-1,%eax\n\t"
            "ja bad_sys_call\n\t"
            "push %ds\n\t"
            "push %es\n\t"
            "push %fs\n\t"
            "pushl %edx\n\t"
            "pushl %ecx # push %ebx,%ecx,%edx as parameters\n\t"
            "pushl %ebx # to the system call\n\t"
            "movl $0x10,%edx # set up ds,es to kernel space\n\t"
            "mov %dx,%ds\n\t"
            "mov %dx,%es\n\t"
            "movl $0x17,%edx # fs points to local data space\n\t"
            "mov %dx,%fs\n\t"
            "call *sys_call_table(,%eax,4)\n\t"
            "pushl %eax\n\t"
            "movl current,%eax\n\t"
            "cmpl $0,state(%eax) # state\n\t"
            "jne reschedule\n\t"
            "cmpl $0,counter(%eax) # counter\n\t"
            "je reschedule\n\t"
            "ret_from_sys_call:\n\t"
            "movl current,%eax # task[0] cannot have signals\n\t"
            "cmpl task,%eax\n\t"
            "je 3f\n\t"
            "cmpw $0x0f,CS(%esp) # was old code segment supervisor ?\n\t"
            "jne 3f\n\t"
            "cmpw $0x17,OLDSS(%esp) # was stack segment = 0x17 ?\n\t"
            "jne 3f\n\t"
            "movl signal(%eax),%ebx\n\t"
            "movl blocked(%eax),%ecx\n\t"
            "notl %ecx\n\t"
            "andl %ebx,%ecx\n\t"
            "bsfl %ecx,%ecx\n\t"
            "je 3f\n\t"
            "btrl %ecx,%ebx\n\t"
            "movl %ebx,signal(%eax)\n\t"
            "incl %ecx\n\t"
            "pushl %ecx\n\t"
            "call do_signal\n\t"
            "popl %eax\n\t"
            "3:popl %eax\n\t"
            "popl %ebx\n\t"
            "popl %ecx\n\t"
            "popl %edx\n\t"
            "pop %fs\n\t"
            "pop %es\n\t"
            "pop %ds\n\t"
            "iret\n\t"
            );
}

void coprocessor_error(){
    __asm__(
            "push %ds \n\t"
            "push %es \n\t"
            "push %fs \n\t"
            "pushl %edx \n\t"
            "pushl %ecx \n\t"
            "pushl %ebx \n\t"
            "pushl %eax \n\t"
            "movl $0x10,%eax \n\t"
            "mov %ax,%ds \n\t"
            "mov %ax,%es \n\t"
            "movl $0x17,%eax \n\t"
            "mov %ax,%fs \n\t"
            "pushl $ret_from_sys_call\n\t"
            "jmp math_error\n\t"
           );
}

void device_not_available(){
    __asm__(
	"push %ds\n\t"
	"push %es\n\t"
	"push %fs\n\t"
	"pushl %edx\n\t"
	"pushl %ecx\n\t"
	"pushl %ebx\n\t"
	"pushl %eax\n\t"
	"movl $0x10,%eax\n\t"
	"mov %ax,%ds\n\t"
	"mov %ax,%es\n\t"
	"movl $0x17,%eax\n\t"
	"mov %ax,%fs\n\t"
	"pushl $ret_from_sys_call\n\t"
	"clts				# clear TS so that we can use math\n\t"
	"movl %cr0,%eax\n\t"
	"testl $0x4,%eax			# EM (math emulation bit)\n\t"
	"je math_state_restore\n\t"
	"pushl %ebp\n\t"
	"pushl %esi\n\t"
	"pushl %edi\n\t"
	"call math_emulate\n\t"
	"popl %edi\n\t"
	"popl %esi\n\t"
	"popl %ebp\n\t"
	"ret\n\t"
    );
}

void timer_interrupt(){
    __asm__(
            "push %ds		# save ds,es and put kernel data space\n\t"
            "push %es		# into them. %fs is used by _system_call\n\t"
            "push %fs\n\t"
            "pushl %edx		# we save %eax,%ecx,%edx as gcc doesn't\n\t"
            "pushl %ecx		# save those across function calls. %ebx\n\t"
            "pushl %ebx		# is saved as we use that in ret_sys_call\n\t"
            "pushl %eax\n\t"
            "movl $0x10,%eax\n\t"
            "mov %ax,%ds\n\t"
            "mov %ax,%es\n\t"
            "movl $0x17,%eax\n\t"
            "mov %ax,%fs\n\t"
            "incl jiffies\n\t"
            "movb $0x20,%al		# EOI to interrupt controller #1\n\t"
            "outb %al,$0x20\n\t"
            "movl CS(%esp),%eax\n\t"
            "andl $3,%eax		# %eax is CPL (0 or 3, 0=supervisor)\n\t"
            "pushl %eax\n\t"
            "call do_timer		# 'do_timer(long CPL)' does everything from\n\t"
            "addl $4,%esp		# task switching to accounting ...\n\t"
            "jmp ret_from_sys_call\n\t"
            );
}


int sys_execve(){
    __asm__(
            "lea EIP(%esp),%eax\n\t"
            "pushl %eax\n\t"
            "call do_execve\n\t"
            "addl $4,%esp\n\t"
            "ret\n\t"
           );
}

int sys_fork(){
    __asm__(
            "call find_empty_process\n\t"
            "testl %eax,%eax\n\t"
            "js 1f\n\t"
            "push %gs\n\t"
            "pushl %esi\n\t"
            "pushl %edi\n\t"
            "pushl %ebp\n\t"
            "pushl %eax\n\t"
            "call copy_process\n\t"
            "addl $20,%esp\n\t"
            "1:	ret\n\t"
           );
}

void hd_interrupt(){
    __asm__(
            "pushl %eax\n\t"
            "pushl %ecx\n\t"
            "pushl %edx\n\t"
            "push %ds\n\t"
            "push %es\n\t"
            "push %fs\n\t"
            "movl $0x10,%eax\n\t"
            "mov %ax,%ds\n\t"
            "mov %ax,%es\n\t"
            "movl $0x17,%eax\n\t"
            "mov %ax,%fs\n\t"
            "movb $0x20,%al\n\t"
            "outb %al,$0xA0		# EOI to interrupt controller #1\n\t"
            "jmp 1f			# give port chance to breathe\n\t"
            "1:	jmp 1f\n\t"
            "1:	xorl %edx,%edx\n\t"
            "xchgl do_hd,%edx\n\t"
            "testl %edx,%edx\n\t"
            "jne 1f\n\t"
            "movl $unexpected_hd_interrupt,%edx\n\t"
            "1:	outb %al,$0x20\n\t"
            "call *%edx		#interesting way of handling intr.\n\t"
            "pop %fs\n\t"
            "pop %es\n\t"
            "pop %ds\n\t"
            "popl %edx\n\t"
            "popl %ecx\n\t"
            "popl %eax\n\t"
            "iret\n\t"
            );
}

void floppy_interrupt(){
    __asm__(
	"pushl %eax\n\t"
	"pushl %ecx\n\t"
	"pushl %edx\n\t"
	"push %ds\n\t"
	"push %es\n\t"
	"push %fs\n\t"
	"movl $0x10,%eax\n\t"
	"mov %ax,%ds\n\t"
	"mov %ax,%es\n\t"
	"movl $0x17,%eax\n\t"
	"mov %ax,%fs\n\t"
	"movb $0x20,%al\n\t"
	"outb %al,$0x20		# EOI to interrupt controller #1\n\t"
	"xorl %eax,%eax\n\t"
	"xchgl do_floppy,%eax\n\t"
	"testl %eax,%eax\n\t"
	"jne 1f\n\t"
	"movl $unexpected_floppy_interrupt,%eax\n\t"
    "1:	call *%eax		# interesting way of handling intr.\n\t"
	"pop %fs\n\t"
	"pop %es\n\t"
	"pop %ds\n\t"
	"popl %edx\n\t"
	"popl %ecx\n\t"
	"popl %eax\n\t"
	"iret\n\t"
    );
}


void parallel_interrupt(){
    __asm__(
	"pushl %eax\n\t"
	"movb $0x20,%al\n\t"
	"outb %al,$0x20\n\t"
	"popl %eax\n\t"
	"iret\n\t"
    );
}
