#include "kernel.h"

DTR idtr;
DTR gdtr;

void IDT::init(){
    DT *p = (DT*)Memory::get_free_page();
    idtr = {256*sizeof(DT),(u32)p};
    for(int i=0; i<256; i++){
        p[i].w0 = (u32)ignore_int & 0x0000FFFF;
        p[i].w1 = 0x0008;
        p[i].w2 = 0x8E00;
        p[i].w3 = 0x0;
    }
    // setup timer & system call interrupt descriptors.
    p[0x8].w0 = (u32)timer_interrupt;
    p[0x80].w0 = (u32)system_interrupt;
    p[0x80].w2 = 0xEF00;
    __asm__ __volatile__ ("lidt %[idtr]"::[idtr]"a"(&idtr));
}

void GDT::init(){
    DT *p = (DT*)Memory::get_free_page();

//    task[0]=
//    {
//        {
//            0,/* back link */
//            (long)(&task[0].kstack+sizeof(task[0].kstack)), 0x10,		/* esp0, ss0 */
//            0, 0, 0, 0, 0,		/* esp1, ss1, esp2, ss2, cr3 */
//            0, 0, 0, 0, 0,		/* eip, eflags, eax, ecx, edx */
//            0, 0, 0, 0, 0,		/* ebx esp, ebp, esi, edi */
//            0, 0, 0, 0, 0, 0, 		/* es, cs, ss, ds, fs, gs */
//            LDT0_SEL, 0x8000000/* ldt, trace bitmap */
//        },	    
//    };
//    task[1]={
//        {
//            {0x0000,0x0000,0x0000,0x0000},
//            {0x03ff,0x0000,0xfa00,0x00c0},
//            {0x03ff,0x0000,0xf200,0x00c0},
//        },
//        {
//            0,/* back link */
//            (long)(&task[1].kstack+sizeof(task[1].kstack)), 0x10,		/* esp0, ss0 */
//            0, 0, 0, 0, 0,		/* esp1, ss1, esp2, ss2, cr3 */
//            (long)task1, 0x200, 0, 0, 0,		/* eip, eflags, eax, ecx, edx */
//            0, (long)(&task[1].ustack+sizeof(task[1].ustack)), 0, 0, 0,		/* ebx esp, ebp, esi, edi */
//            0x17, 0x0f, 0x17, 0x17, 0x17, 0x17, 		/* es, cs, ss, ds, fs, gs */
//            LDT1_SEL, 0x8000000/* ldt, trace bitmap */
//        },	    
//    };
//
    p[0] = {0x0000,0x0000,0x0000,0x0000};/* NULL descriptor */

    p[1] = {0x07ff,0x0000,0x9a00,0x00c0};/* 8Mb 0x08 = 1*8+0, base = 0x00000 */
    p[2] = {0x07ff,0x0000,0x9200,0x00c0};/* 8Mb 0x10 = 2*8+0 */

    p[3] = {0x0002,0x8000,0x920b,0x00c0};/* screen 0x18 = 3*8+0 for display */

    p[4] = {0x03ff,0x0000,0xfa00,0x00c0}; /* user code 4*8+3 = 0x23 */
    p[5] = {0x03ff,0x0000,0xf200,0x00c0};/* user data 5*8+3 = 0x2b */

    //gdt[6] = {sizeof(task[0].tss), (u16)(long)(&task[0].tss), 0xe900, 0x0000};/* TSS0 descr 6*8+0=0x30 */
    //gdt[7] = {sizeof(task[1].tss), (u16)(long)(&task[1].tss), 0xe900, 0x0000};/* TSS1 descr 7*8+0=0x38 */

    gdtr = {256*sizeof(DT),(u32)p};
    __asm__ __volatile__ ("lgdt %[gdtr]"::[gdtr]"a"(gdtr));

    count = 6;
}


extern "C"
void setup_paging(const u32 *pg_dir, u16 pg_num){
    u32 *p = (u32 *)pg_dir;
    // set 1(dir table)+4(page table) to 0
    for(int i=0; i<1024*(1+pg_num); i++){
        *(p+i) = 0;
    }
    // setup directory table
    for(int i=0;i<pg_num;i++){
        *(p+i) = (i+1) * 0x1000+0x7; 
    }
    // setup page table
    for(int i=0; i<pg_num*1024; i++){
        *(p+1024+i) = 0x0 + i*0x1000 + 0x7;
        //*(p+i) = 0x0 + i*0x1000 + 0x7;
    }
    __asm__ __volatile__(
            "movl %[pg_dir],%%cr3\n\t"
            "movl %%cr0,%%eax\n\t"
            "orl $0x80000000,%%eax\n\t"
            "movl %%eax,%%cr0\n\t"
            ::[pg_dir]"a"(pg_dir)
            );
}

u8 Schedule::fork(){


}


extern "C"
void kmain(void){
    Memory::init();
    IDT::init();
    GDT::init();
    move_to_user_mode();
}
