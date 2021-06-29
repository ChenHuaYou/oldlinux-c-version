/*
 *  linux/kernel/keyboard.S
 *
 *  (C) 1991  Linus Torvalds
 */

/*
 *	Thanks to Alfred Leung for US keyboard patches
 *		Wolfgang Thiel for German keyboard patches
 *		Marc Corsini for the French keyboard
 */

#include <linux/config.h>


/*
 *  con_int is the real interrupt routine that reads the
 *  keyboard scan-code and converts it into the appropriate
 *  ascii character(s).
 */

void show_stat(void);
extern "C" void do_tty_interrupt(int tty);
void keyboard_interrupt(){
    __asm__(
            "pushl %%eax\n\t"
            "pushl %%ebx\n\t"
            "pushl %%ecx\n\t"
            "pushl %%edx\n\t"
            "push %%ds\n\t"
            "push %%es\n\t"
            "movl $0x10,%%eax\n\t"
            "mov %%ax,%%ds\n\t"
            "mov %%ax,%%es\n\t"
            "xor %%al,%%al		/* %%eax is scan code */\n\t"
            "inb $0x60,%%al\n\t"
            "cmpb $0xe0,%%al\n\t"
            "je set_e0\n\t"
            "cmpb $0xe1,%%al\n\t"
            "je set_e1\n\t"
            "call *key_table(,%%eax,4)\n\t"
            "movb $0,e0\n\t"
            "e0_e1:	inb $0x61,%%al\n\t"
            "jmp 1f\n\t"
            "1:	jmp 1f\n\t"
            "1:	orb $0x80,%%al\n\t"
            "jmp 1f\n\t"
            "1:	jmp 1f\n\t"
            "1:	outb %%al,$0x61\n\t"
            "jmp 1f\n\t"
            "1:	jmp 1f\n\t"
            "1:	andb $0x7F,%%al\n\t"
            "outb %%al,$0x61\n\t"
            "movb $0x20,%%al\n\t"
            "outb %%al,$0x20\n\t"
            "pushl $0\n\t"
            "call *%0\n\t"
            "addl $4,%%esp\n\t"
            "pop %%es\n\t"
            "pop %%ds\n\t"
            "popl %%edx\n\t"
            "popl %%ecx\n\t"
            "popl %%ebx\n\t"
            "popl %%eax\n\t"
            "iret\n\t"
            "set_e0:	movb $1,e0\n\t"
            "jmp e0_e1\n\t"
            "set_e1:	movb $2,e0\n\t"
            "jmp e0_e1\n\t"
            ::"r"(do_tty_interrupt)
            );
}

/*
 * this routine handles function keys
 */

extern "C" void func(){
    __asm__(
            "pushl %%eax\n\t"
            "pushl %%ecx\n\t"
            "pushl %%edx\n\t"
            "call *%0\n\t"
            "popl %%edx\n\t"
            "popl %%ecx\n\t"
            "popl %%eax\n\t"
            "subb $0x3B,%%al\n\t"
            "jb end_func\n\t"
            "cmpb $9,%%al\n\t"
            "jbe ok_func\n\t"
            "subb $18,%%al\n\t"
            "cmpb $10,%%al\n\t"
            "jb end_func\n\t"
            "cmpb $11,%%al\n\t"
            "ja end_func\n\t"
            "ok_func:\n\t"
            "cmpl $4,%%ecx		/* check that there is enough room */\n\t"
            "jl end_func\n\t"
            "movl func_table(,%%eax,4),%%eax\n\t"
            "xorl %%ebx,%%ebx\n\t"
            "jmp put_queue\n\t"
            "end_func:\n\t"
            "ret\n\t"
            ::"r"(show_stat)
            );

}
