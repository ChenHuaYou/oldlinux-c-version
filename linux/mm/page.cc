/*
 *  linux/mm/page.cc
 *
 *  (C) 2021 陈华友
 */

/*
 * page.cc contains the low-level page-exception code.
 * the real work is done in mm.c
 */


void do_no_page(unsigned long error_code,unsigned long address);
void do_wp_page(unsigned long error_code,unsigned long address);


void page_fault(){
    __asm__(
	"xchgl %%eax,(%%esp)\n\t"
	"pushl %%ecx\n\t"
	"pushl %%edx\n\t"
	"push %%ds\n\t"
	"push %%es\n\t"
	"push %%fs\n\t"
	"movl $0x10,%%edx\n\t"
	"mov %%dx,%%ds\n\t"
	"mov %%dx,%%es\n\t"
	"mov %%dx,%%fs\n\t"
	"movl %%cr2,%%edx\n\t"
	"pushl %%edx\n\t"
	"pushl %%eax\n\t"
	"testl $1,%%eax\n\t"
	"jne 1f\n\t"
	"call *%0\n\t"
	"jmp 2f\n\t"
    "1:	call *%1\n\t"
    "2:	addl $8,%%esp\n\t"
	"pop %%fs\n\t"
	"pop %%es\n\t"
	"pop %%ds\n\t"
	"popl %%edx\n\t"
	"popl %%ecx\n\t"
	"popl %%eax\n\t"
	"iret\n\t"
    ::"r"(do_no_page),"r"(do_wp_page)
    );
}
