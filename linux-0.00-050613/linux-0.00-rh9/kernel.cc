#include "kernel.h"

Io io;
Memory memory;
IDT idt;
GDT gdt;
Task task;


void Task::init(void){
    TSS *p = (TSS*)memory.get_free_page();
    p->back_link = 0;
    p->esp0 = (u32)((char*)p + 4096);
    p->ss0 = 0x10;
    p->cr3 = 0x0;
    p->es = 0x2b;
    p->cs = 0x23;
    p->ss = 0x2b;
    p->ds = 0x2b;
    p->fs = 0x2b;
    p->gs = 0x2b;
    p->trace_bitmap = 0x8000000;
    tss[0] = p;

    gdt.addDescription(sizeof(TSS), (u32)p, 0xe900, 0x0);

    asmv(
            "ltr (%[tss0_sel])\n\t"
            "sti\n\t"
            "iret\n\t"
            ::[tss0_sel]"a"(0x30)
        );
}

u8 Task::fork(void){
    TSS *p = (TSS*)memory.get_free_page();
    return 1;
}

void IDT::ignore_int(void){
    //io.putc('c');
    asmv("iret");
}

void IDT::init(){
    DT *p = (DT*)memory.get_free_page();
    idtr = {256*sizeof(DT),(u32)p};
    for(int i=0; i<256; i++){
        p[i].w0 = (u32)(ignore_int) & 0x0000FFFF;
        p[i].w1 = 0x0008;
        p[i].w2 = 0x8E00;
        p[i].w3 = 0x0;
    }
    // setup timer & system call interrupt descriptors.
    p[0x8].w0 = (u32)timer_interrupt;
    p[0x80].w0 = (u32)system_interrupt;
    p[0x80].w2 = 0xEF00;
    asmv ("lidt (%[idtr])"::[idtr]"a"(&idtr));
}

void IDT::timer_interrupt(void){
    //io.putc('a');
    asmv("iret");
}

void IDT::system_interrupt(void){
    asmv("iret");
}


void GDT::init(){
    base = (DT*)memory.get_free_page();

    addDescription(0x0000,0x0000,0x0000,0x0000);/* NULL descriptor */

    addDescription(0x0fff,0x0000,0x9a00,0x00c0);/* 16Mb 0x08 = 1*8+0, base = 0x00000 */
    addDescription(0x0fff,0x0000,0x9200,0x00c0);/* 16Mb 0x10 = 2*8+0 */

    addDescription(0x03ff,0x0000,0xfa00,0x00c0); /* user code 3*8+3 = 0x1b */
    addDescription(0x03ff,0x0000,0xf200,0x00c0);/* user data 4*8+3 = 0x2b */

    gdtr = {256*sizeof(DT),(u32)base};
    __asm__ __volatile__ (
            "lgdt (%[gdtr])\n\t"
            ::[gdtr]"a"(&gdtr)
            );
}

void GDT::addDescription(u16 w0, u16 w1, u16 w2, u16 w3){
    base[count++] = {w0, w1, w2, w3};
}

void Memory::init(void){
    for(int i=0;i<BUF_PAGES;i++){
        mm_map[i] = 1;
    }
    for(int i=BUF_PAGES;i<PAGING_PAGES;i++){
        mm_map[i] = 0;
    }
    setup_paging(0, 4);
}

u32 Memory::get_free_page(void){
    for(int i=BUF_PAGES; i<PAGING_PAGES;i++){
        if(mm_map[i]==0){
            mm_map[i] = 1;
            return LOW_MEM + i * 4096;
        }
    }
    return 0;
}

void Memory::setup_paging(const u32 *pg_dir, u16 pg_num){
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
    asmv(
            "movl %[pg_dir],%%cr3\n\t"
            "movl %%cr0,%%eax\n\t"
            "orl $0x80000000,%%eax\n\t"
            "movl %%eax,%%cr0\n\t"
            ::[pg_dir]"a"(pg_dir)
        );
}


extern "C"
void kmain(void){
    memory.init();
    idt.init();
    gdt.init();
    asmv(
            "movl $0x10,%eax\n\t"
            "mov %ax,%ds\n\t"
            "mov %ax,%es\n\t"
            "mov %ax,%fs\n\t"
            "mov %ax,%gs\n\t"
            "ljmp $0x08, $next\n\t"
            "next: \n\t"
        );
    while(1) io.putc('A');
}
