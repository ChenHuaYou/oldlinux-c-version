
void do_divide_error(long esp, long error_code);
void do_nmi(long esp, long error_code);
void do_debug(long esp, long error_code);
void do_overflow(long esp, long error_code);
void do_bounds(long esp, long error_code);
void do_invalid_op(long esp, long error_code);
void do_device_not_available(long esp, long error_code);
void do_coprocessor_segment_overrun(long esp, long error_code);
void do_invalid_TSS(long esp,long error_code);
void do_segment_not_present(long esp,long error_code);
void do_stack_segment(long esp,long error_code);
void do_coprocessor_error(long esp, long error_code);
void do_reserved(long esp, long error_code);
void do_double_fault(long esp, long error_code);
void do_general_protection(long esp, long error_code);
void do_divide_error(long esp, long error_code);
void do_int3(long * esp, long error_code,
		long fs,long es,long ds,
		long ebp,long esi,long edi,
		long edx,long ecx,long ebx,long eax);



asm(
        "no_error_code:\n\t"
        "xchgl %eax,(%esp)\n\t"
        "pushl %ebx\n\t"
        "pushl %ecx\n\t"
        "pushl %edx\n\t"
        "pushl %edi\n\t"
        "pushl %esi\n\t"
        "pushl %ebp\n\t"
        "push %ds\n\t"
        "push %es\n\t"
        "push %fs\n\t"
        "pushl $0\n\t"
        "lea 44(%esp),%edx\n\t"
        "pushl %edx\n\t"
        "movl $0x10,%edx\n\t"
        "mov %dx,%ds\n\t"
        "mov %dx,%es\n\t"
        "mov %dx,%fs\n\t"
        "call *%eax\n\t"
        "addl $8,%esp\n\t"
        "pop %fs\n\t"
        "pop %es\n\t"
        "pop %ds\n\t"
        "popl %ebp\n\t"
        "popl %esi\n\t"
        "popl %edi\n\t"
        "popl %edx\n\t"
        "popl %ecx\n\t"
        "popl %ebx\n\t"
        "popl %eax\n\t"
        "iret\n\t"
);


void divide_error(void){
    __asm__(
            "pushl %0\n\t"
            "jmp no_error_code\n\t"
            ::"r"(do_divide_error)
           );
}

void debug(void){
    __asm__(    
            "pushl %0\n\t"
            "jmp no_error_code\n\t"
            ::"r"(do_int3)
            );
}

void nmi(void){
    __asm__(
            "pushl %0\n\t"
            "jmp no_error_code\n\t"
            ::"r"(do_nmi)
           );
}

void int3(void){
    __asm__(
            "pushl $do_int3\n\t"
            "jmp no_error_code\n\t"
           );
}

void overflow(void){
    __asm__(
            "pushl $do_overflow\n\t"
            "jmp no_error_code\n\t"
           );
}

void bounds(void){
    __asm__(
            "pushl $do_bounds\n\t"
            "jmp no_error_code\n\t"
           );
}

void invalid_op(void){
    __asm__(
            "pushl $do_invalid_op\n\t"
            "jmp no_error_code\n\t"
           );
}

void coprocessor_segment_overrun(void){
    __asm__(
            "pushl $do_coprocessor_segment_overrun\n\t"
            "jmp no_error_code\n\t"
           );
}

void reserved(void){
    __asm__(
            "pushl $do_reserved\n\t"
            "jmp no_error_code\n\t"
           );
}

void irq13(void){
    __asm__(
	"pushl %eax\n\t"
	"xorb %al,%al\n\t"
	"outb %al,$0xF0\n\t"
	"movb $0x20,%al\n\t"
	"outb %al,$0x20\n\t"
	"jmp 1f\n\t"
    "1:	jmp 1f\n\t"
    "1:	outb %al,$0xA0\n\t"
	"popl %eax\n\t"
	"jmp coprocessor_error\n\t"
    );
}


void double_fault(void){
    __asm__(
            "pushl $do_double_fault\n\t"
            "jmp error_code\n\t"
           );
}

__asm__(
        "error_code:\n\t"
        "xchgl %eax,4(%esp)\n\t"
        "xchgl %ebx,(%esp)\n\t"
        "pushl %ecx\n\t"
        "pushl %edx\n\t"
        "pushl %edi\n\t"
        "pushl %esi\n\t"
        "pushl %ebp\n\t"
        "push %ds\n\t"
        "push %es\n\t"
        "push %fs\n\t"
        "pushl %eax\n\t"
        "lea 44(%esp),%eax\n\t"
        "pushl %eax\n\t"
        "movl $0x10,%eax\n\t"
        "mov %ax,%ds\n\t"
        "mov %ax,%es\n\t"
        "mov %ax,%fs\n\t"
        "call *%ebx\n\t"
        "addl $8,%esp\n\t"
        "pop %fs\n\t"
        "pop %es\n\t"
        "pop %ds\n\t"
        "popl %ebp\n\t"
        "popl %esi\n\t"
        "popl %edi\n\t"
        "popl %edx\n\t"
        "popl %ecx\n\t"
        "popl %ebx\n\t"
        "popl %eax\n\t"
        "iret\n\t"
);


void invalid_TSS(void){
    __asm__(
            "pushl $do_invalid_TSS\n\t"
            "jmp error_code\n\t"
           );
}

void segment_not_present(void){
    __asm__(
            "pushl $do_segment_not_present\n\t"
            "jmp error_code\n\t"
           );
}

void stack_segment(void){
    __asm__(
            "pushl $do_stack_segment\n\t"
            "jmp error_code\n\t"
           );
}

void general_protection(void){
    __asm__(
            "pushl $do_general_protection\n\t"
            "jmp error_code\n\t"
           );
}

