#include "kernel.h"

Io io;
Memory memory;
IDT idt;
GDT gdt;
Scheduler sched;


void Scheduler::init(void){
    Task *p = (Task *)memory.get_free_page();
    task[0] = p;

    p->ldt[0] = {0x0000,0x0000,0x0000,0x0000};
    p->ldt[1]={0x0fff,0x0000,0xfa00,0x00c0};
    p->ldt[2]={0x0fff,0x0000,0xf200,0x00c0};

    p->tss.back_link = 0;
    p->tss.esp0 = (u32)((char*)p + 4096);
    p->tss.ss0 = 0x10;
    p->tss.esp1 = 0;
    p->tss.ss1 = 0;
    p->tss.esp2 = 0;
    p->tss.ss2 = 0;
    p->tss.cr3 = 0x0;
    p->tss.eip = 0;
    p->tss.eflags = 0;
    p->tss.eax = 0;
    p->tss.ecx = 0;
    p->tss.edx = 0;
    p->tss.ebx = 0;
    p->tss.esp = 0;
    p->tss.esi = 0;
    p->tss.edi = 0;
    p->tss.es = 0;
    p->tss.cs = 0;
    p->tss.ss = 0;
    p->tss.ds = 0;
    p->tss.fs = 0;
    p->tss.gs = 0;
    p->tss.ldt = 32;
    p->tss.trace_bitmap = 0x8000000;

    amount ++;

    gdt.addDescription(sizeof(TSS), (u32)&p->tss & 0xffff, 0xe900 + (((u32)&p->tss >> 16) & 0xff), (u32)&p->tss >> 24); // TSS 3*8=24
    gdt.addDescription(3*sizeof(DT), (u32)&p->ldt & 0xffff, 0xe200 + (((u32)&p->ldt >> 16) & 0xff), (u32)&p->ldt >> 24); //LDT 4*8=32

    asmv(
            "pushfl\n\t"
            "andl $0xffffbfff,(%%esp)\n\t"
            "popfl\n\t"
            "movl $24, %%eax\n\t"
            "ltr %%ax\n\t"
            "movl $32, %%eax\n\t"
            "lldt %%ax\n\t"
            "movl %%esp,%%eax\n\t"
            "sti\n\t"
            "pushl $0x17\n\t"
            "pushl %%eax\n\t"
            "pushfl\n\t"
            "pushl $0x0f\n\t"
            "pushl $1f\n\t"
            "iret\n\t"
            "1: movl $0x17,%%eax\n\t"
            "movw %%ax,%%ds\n\t"
            "movw %%ax,%%es\n\t"
            "movw %%ax,%%fs\n\t"
            "movw %%ax,%%gs\n\t"
            ::
            :"ax"
        );
}

u8 Scheduler::fork(void){
    int i;
    for(i=0;i<256; i++){
        if(task[i]==0) {
            break;
        }
    }
    if(i==256) return -1;
    Task *p = (Task *)memory.get_free_page();
    task[i] = p;

    string.memcpy((char *)p, (char *)task[current], sizeof(Task));

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

void IDT::timer_interrupt(interrupt_frame *frame) {
    asmv(
            "movb $0x20, %%al\n\t"
            "outb %%al,$0x20\n\t"
            :::"ax"
        );
    io.putc('c',0x4);
    //asmv("iret");
}

void IDT::system_interrupt(void){
    asmv("iret");
}


void GDT::init(){
    base = (DT*)memory.get_free_page();

    addDescription(0x0000,0x0000,0x0000,0x0000);/* NULL descriptor */

    addDescription(0x0fff,0x0000,0x9a00,0x00c0);/* 16Mb 0x08 = 1*8+0, base = 0x00000 */
    addDescription(0x0fff,0x0000,0x9200,0x00c0);/* 16Mb 0x10 = 2*8+0 */


    gdtr = {256*sizeof(DT),(u32)base};
    asmv(
            "lgdt (%[gdtr])\n\t"
            ::[gdtr]"a"(&gdtr)
        );
    asmv(
            "movl $0x10,%eax\n\t"
            "mov %ax,%ds\n\t"
            "mov %ax,%es\n\t"
            "mov %ax,%fs\n\t"
            "mov %ax,%gs\n\t"
            "ljmp $0x08, $next\n\t"
            "next: \n\t"
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
    sched.init();
    while(1) {
        io.putc('A',0x7);
    }
}
