#ifndef KERNEL_H
#define KERNEL_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned long u32;
typedef unsigned long long u64;
typedef char *va_list;
#define LDT0_SEL 0x28
#define LDT1_SEL 0x38
#define asmv __asm__ __volatile__
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


class Task{
    public:
        void switch_to_next(void);
        u8 fork(void);
        void init(void);
    private:
        TSS *tss[256];
        u8 current=0;
};
extern Task task;

class Memory{
    public:
        void init(void);
        u32 get_free_page(void);
    private:
        void setup_paging(const u32 *pg_dir, u16 pg_num);
};
extern Memory memory;

class GDT{
    u8 count;
    DTR gdtr;
    public:
        void init(void);
        void addDescription(u16 w0, u16 w1, u16 w2, u16 w3);
};
extern GDT gdt;

class IDT{
    DTR idtr;
    public:
        void init(void);
        void addDescription(u16 w0, u16 w1, u16 w2, u16 w3);
        static void ignore_int(void);
        static void timer_interrupt(void);
        static void system_interrupt(void);
};
extern IDT idt;


#define RAMSCREEN 0xB8000	/* debut de la memoire video */
#define SIZESCREEN 0xFA0	/* 4000, nombres d'octets d'une page texte */
#define SCREENLIM 0xB8FA0

/** Input/output class **/
class Io
{
	public:
	
		Io();
		Io(u32 flag);
		
		/** standart io color **/
		enum Colour
		  {
			Black       =0,
			Blue        =1,
			Green       =2,
			Cyan        =3,
			Red         =4,
			Magenta     =5,
			Orange      =6,
			LightGrey   =7,
			DarkGrey    =8,
			LightBlue   =9,
			LightGreen  =10,
			LightCyan   =11,
			LightRed    =12,
			LightMagenta=13,
			Yellow      =14,
			White       =15
		  };

		/** io class functions **/
		void	outb(u32 ad,u8 v);		/* output byte */
		void	outw(u32 ad,u16 v);		/* output word */
		void	outl(u32 ad,u32 v);		/* output word */
		
		u8		inb(u32 ad);			/* input byte */
		u16		inw(u32 ad);			/* input word */
		u32		inl(u32 ad);			/* input word */
		
		void	putctty(char c);		/* put a byte on the console */
		
		u32 	read(char* buf,u32 count);	/* read a string in the console */
		void	putc(char c);				/* put a byte on screen */
		void	setColor(char fcol,char bcol);	/* change colors */
		void	setXY(char xc,char yc);			/* change cursor position */
		void	clear();				/* clear screen */
		void	print(const char *s, ...);	/* put a string in screen */
		
		u32		getX();
		u32		getY();
		
		
		void	switchtty();		/* change the io interface */	
		
		/** x86 functions **/
		void	scrollup(unsigned int n);
		void	save_screen();
		void	load_screen();
		
		enum ConsoleType {
			BUFFERED,
			GETCHAR
		};
		
		static Io*	current_io;
		static Io*	last_io;
		
	private:
	
		/** x86 private attributes **/
		char*	real_screen;
		char	screen[SIZESCREEN];
		
		char	inbuf[512];		/* console buffer */
		int		keypos;			/* console read position */
		int		inlock;			/* console state */
		int		keystate;		/* console type keyboard */
		
		
		char 	fcolor;			/* console foreground color */
		char	bcolor;			/* console background color */
		char	x;				/* console x position */
		char	y;				/* console y position */
		char kattr;				/* console attribut */
		static char*	vidmem;	/* screen video memory */
		
};

/** standart starting io interface **/
extern Io io;


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
extern String string;

#endif
