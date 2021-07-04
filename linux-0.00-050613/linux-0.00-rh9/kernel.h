typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned long u32;
typedef unsigned long long u64;
#define LDT0_SEL 0x28
#define LDT1_SEL 0x38

//descriptor table register
struct DTR{
    u16 limit;
    u32 base;
}__attribute__ ((packed));

struct DT{
    u16 w0;
    u16 w1;
    u16 w2;
    u16 w3;
}__attribute__((packed));

struct TSS {
	long	back_link;	/* 16 high bits zero */
	long	esp0;
	long	ss0;		/* 16 high bits zero */
	long	esp1;
	long	ss1;		/* 16 high bits zero */
	long	esp2;
	long	ss2;		/* 16 high bits zero */
	long	cr3;
	long	eip;
	long	eflags;
	long	eax,ecx,edx,ebx;
	long	esp;
	long	ebp;
	long	esi;
	long	edi;
	long	es;		/* 16 high bits zero */
	long	cs;		/* 16 high bits zero */
	long	ss;		/* 16 high bits zero */
	long	ds;		/* 16 high bits zero */
	long	fs;		/* 16 high bits zero */
	long	gs;		/* 16 high bits zero */
	long	ldt;		/* 16 high bits zero */
	long	trace_bitmap;	/* bits: trace 0, bitmap 16-31 */
}__attribute__((packed));


struct Task{
    DT ldt[3];
    TSS tss;
    char kstack[128];
    char ustack[128];
};


extern "C" void ignore_int(void);
extern "C" void timer_interrupt(void);
extern "C" void system_interrupt(void);
extern "C" void task1(void);
extern "C" void task0(void);
extern "C" u32 init_stack;
