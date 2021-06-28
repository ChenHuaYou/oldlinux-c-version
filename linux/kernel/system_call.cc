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

#define SIG_CHLD	17

#define EAX		0x00
#define EBX		0x04
#define ECX		0x08
#define EDX		0x0C
#define FS		0x10
#define ES		0x14
#define DS		0x18
#define EIP		0x1C
#define CS		0x20
#define EFLAGS		0x24
#define OLDESP		0x28
#define OLDSS		0x2C
#define state	0		//these are offsets into the task-struct.
#define counter	4
#define priority 8
#define signal	12
#define sigaction 16		//MUST be 16 (=len of sigaction)
#define blocked (33*16)

//offsets within sigaction
#define sa_handler 0
#define sa_mask 4
#define sa_flags 8
#define sa_restorer 12
#define nr_system_calls 72

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

void system_call(){
    __asm__(
            "cmpl %0,%%eax\n\t"
            "ja bad_sys_call\n\t"
            "push %%ds\n\t"
            "push %%es\n\t"
            "push %%fs\n\t"
            "pushl %%edx\n\t"
            "pushl %%ecx		# push %%ebx,%%ecx,%%edx as parameters\n\t"
            "pushl %%ebx		# to the system call\n\t"
            "movl $0x10,%%edx		# set up ds,es to kernel space\n\t"
            "mov %%dx,%%ds\n\t"
            "mov %%dx,%%es\n\t"
            "movl $0x17,%%edx		# fs points to local data space\n\t"
            "mov %%dx,%%fs\n\t"
            "call *sys_call_table(,%%eax,4)\n\t"
            "pushl %%eax\n\t"
            "movl current,%%eax\n\t"
            "cmpl $0,%1(%%eax)		# state\n\t"
            "jne reschedule\n\t"
            "cmpl $0,counter(%%eax)		# counter\n\t"
            "je reschedule\n\t"
            "ret_from_sys_call:\n\t"
            "movl current,%%eax		# task[0] cannot have signals\n\t"
            "cmpl task,%%eax\n\t"
            "je 3f\n\t"
            "cmpw $0x0f,CS(%%esp)		# was old code segment supervisor ?\n\t"
            "jne 3f\n\t"
            "cmpw $0x17,OLDSS(%%esp)		# was stack segment = 0x17 ?\n\t"
            "jne 3f\n\t"
            "movl signal(%%eax),%%ebx\n\t"
            "movl blocked(%%eax),%%ecx\n\t"
            "notl %%ecx\n\t"
            "andl %%ebx,%%ecx\n\t"
            "bsfl %%ecx,%%ecx\n\t"
            "je 3f\n\t"
            "btrl %%ecx,%%ebx\n\t"
            "movl %%ebx,signal(%%eax)\n\t"
            "incl %%ecx\n\t"
            "pushl %%ecx\n\t"
            "call do_signal\n\t"
            "popl %%eax\n\t"
            "3:popl %%eax\n\t"
            "popl %%ebx\n\t"
            "popl %%ecx\n\t"
            "popl %%edx\n\t"
            "pop %%fs\n\t"
            "pop %%es\n\t"
            "pop %%ds\n\t"
            "iret\n\t"
            ::"r"(nr_system_calls-1),"r"(state)
            );
}

void coprocessor_error(){
    __asm__(
            "push %%ds \n\t"
            "push %%es \n\t"
            "push %%fs \n\t"
            "pushl %%edx \n\t"
            "pushl %%ecx \n\t"
            "pushl %%ebx \n\t"
            "pushl %%eax \n\t"
            "movl $0x10,%%eax \n\t"
            "mov %%ax,%%ds \n\t"
            "mov %%ax,%%es \n\t"
            "movl $0x17,%%eax \n\t"
            "mov %%ax,%%fs \n\t"
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


void sys_execve(){
    __asm__(
            "lea EIP(%esp),%eax\n\t"
            "pushl %eax\n\t"
            "call do_execve\n\t"
            "addl $4,%esp\n\t"
            "ret\n\t"
           );
}

void sys_fork(){
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
