#  head.s contains the 32-bit startup code.
#  Two L3 task multitasking. The code of tasks are in kernel area, 
#  just like the Linux. The kernel code is located at 0x10000. 
SCRN_SEL	= 0x18
TSS0_SEL	= 0x20
LDT0_SEL	= 0x28
TSS1_SEL	= 0X30
LDT1_SEL	= 0x38
.global startup_32,task0,task1,ignore_int,timer_interrupt,system_interrupt,init_stack
.text

.org 0x0
pg_dir:
    jmp startup_32
.org 0x1000
pg0:

.org 0x2000
pg1:

.org 0x3000
pg2:

.org 0x4000
pg3:

.org 0x5000

startup_32:
# setup up timer 8253 chip.
	movb $0x36, %al
	movl $0x43, %edx
	outb %al, %dx
	movl $11930, %eax        # timer frequency 100 HZ 
	movl $0x40, %edx
	outb %al, %dx
	movb %ah, %al
	outb %al, %dx

	movl $0x10,%eax
	mov %ax,%ds
	mov %ax,%es
	lss init_stack,%esp
    jmp kmain


.fill 128,4,0
init_stack:                          # Will be used as user stack for task0.
	.long init_stack
	.word 0x10
