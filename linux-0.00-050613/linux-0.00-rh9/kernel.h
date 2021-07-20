#ifndef KERNEL_H
#define KERNEL_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned long u32;
typedef unsigned long long u64;
typedef char *va_list;
#define LDT0_SEL 0x28
#define LDT1_SEL 0x38
#define asmv 		__asm__ __volatile__
#define NULL 0


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
    //DT ldt[3];
    TSS tss;
    //char kstack[128];
    //char ustack[128];
};


extern "C" void ignore_int(void);
extern "C" void timer_interrupt(void);
extern "C" void system_interrupt(void);
extern "C" void task1(void);
extern "C" void task0(void);
extern "C" u32 init_stack;
void move_to_user_mode();

class Memory{
    public:
        static void init(void);
        static u32 get_free_page(void);
};

class GDT{
    u8 count;
    DTR gdtr;
    public:
        void init(void);
        void addDescription(u16 w0, u16 w1, u16 w2, u16 w3);
};
extern GDT gdt;

class IDT{
    static DTR idtr;
    public:
        static void init(void);
        static void addDescription(u16 w0, u16 w1, u16 w2, u16 w3);
};

class Schedule{
    public:
        static u8 fork(void);
};

class IO{
    public:
        static void write_char(char c);
};

class String{

    public:
        static void *memcpy(char *dst, char *src, int n);
        static void *memset(char *dst,char src, int n);
        static int strlen(char *s);
        static char *strncpy(char *destString, const char *sourceString,int maxLength);
        static int strcmp(const char *dst, char *src);
        static int strcpy(char *dst,const char *src);
        static void strcat(void *dest,const void *src);
        static int strncmp( const char* s1, const char* s2, int c );
        static void itoa(char *buf, unsigned long int n, int base);
};

#endif
