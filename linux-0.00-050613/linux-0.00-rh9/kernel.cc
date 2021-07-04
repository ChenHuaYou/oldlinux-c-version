#include "kernel.h"

Task task[256];
DT idt[256]={0};
DT gdt[256];
DTR idtr;
DTR gdtr;

extern "C"
void setup_idt(){
    idtr = {256*sizeof(DT),(u32)idt};
    for(int i=0; i<256; i++){
        idt[i].w0 = (u32)ignore_int & 0x0000FFFF;
        idt[i].w1 = 0x0008;
        idt[i].w2 = 0x8E00;
        idt[i].w3 = 0x0;
    }
    // setup timer & system call interrupt descriptors.
    idt[0x8].w0 = (u32)timer_interrupt;
    idt[0x80].w0 = (u32)system_interrupt;
    idt[0x80].w2 = 0xEF00;
    __asm__ __volatile__ ("lidt idtr");
}

extern "C"
void setup_gdt(){

    task[0]=
    {
        {
            {0x0000,0x0000,0x0000,0x0000},
            {0x03ff,0x0000,0xfa00,0x00c0},
            {0x03ff,0x0000,0xf200,0x00c0},
        },
        {
            0,/* back link */
            (long)(&task[0].kstack+sizeof(task[0].kstack)), 0x10,		/* esp0, ss0 */
            0, 0, 0, 0, 0,		/* esp1, ss1, esp2, ss2, cr3 */
            (long)task0, 0, 0, 0, 0,		/* eip, eflags, eax, ecx, edx */
            0, 0, 0, 0, 0,		/* ebx esp, ebp, esi, edi */
            0, 0, 0, 0, 0, 0, 		/* es, cs, ss, ds, fs, gs */
            LDT0_SEL, 0x8000000/* ldt, trace bitmap */
        },	    
    };
    task[1]={
        {
            {0x0000,0x0000,0x0000,0x0000},
            {0x03ff,0x0000,0xfa00,0x00c0},
            {0x03ff,0x0000,0xf200,0x00c0},
        },
        {
            0,/* back link */
            (long)(&task[1].kstack+sizeof(task[1].kstack)), 0x10,		/* esp0, ss0 */
            0, 0, 0, 0, 0,		/* esp1, ss1, esp2, ss2, cr3 */
            (long)task1, 0, 0, 0, 0,		/* eip, eflags, eax, ecx, edx */
            0, (long)(&task[1].ustack+sizeof(task[1].ustack)), 0, 0, 0,		/* ebx esp, ebp, esi, edi */
            0x17, 0x0f, 0x17, 0x17, 0x17, 0x17, 		/* es, cs, ss, ds, fs, gs */
            LDT0_SEL, 0x8000000/* ldt, trace bitmap */
        },	    
    };

    gdt[0] = {0x0000,0x0000,0x0000,0x0000};/* NULL descriptor */
    gdt[1] = {0x07ff,0x0000,0x9a00,0x00c0};/* 8Mb 0x08, base = 0x00000 */
    gdt[2] = {0x07ff,0x0000,0x9200,0x00c0};/* 8Mb 0x10 */
    gdt[3] = {0x0002,0x8000,0x920b,0x00c0};/* screen 0x18 - for display */
    gdt[4] = {sizeof(task[0].tss), (u16)(long)(&task[0].tss), 0xe900, 0x0000};/* TSS0 descr 0x20 */
    gdt[5] = {sizeof(task[0].ldt), (u16)(long)(&task[0].ldt), 0xe200, 0x0000};/* LDT0 descr 0x28 */
    gdt[6] = {sizeof(task[1].tss), (u16)(long)(&task[1].tss), 0xe900, 0x0000};/* TSS1 descr 0x30 */
    gdt[7] = {sizeof(task[1].ldt), (u16)(long)(&task[1].ldt), 0xe200, 0x0000};/*LDT1 descr 0x38 */

    gdtr = {256*sizeof(DT),(u32)gdt};
    __asm__ __volatile__ ("lgdt gdtr");
}

