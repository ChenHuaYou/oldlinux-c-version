/*
 *  linux/kernel/printk.c
 *
 *  (C) 1991  Linus Torvalds
 */

/*
 * When in kernel-mode, we cannot use printf, as fs is liable to
 * point to 'interesting' things. Make a printf with fs-saving, and
 * all is well.
 */
#include <stdarg.h>
#include <stddef.h>

#include <linux/kernel.h>


int vsprintf(char * buf, const char * fmt, va_list args);
static char buf[1024];

extern "C" int printk(const char *fmt, ...)
{
	va_list args;
	int i;

	va_start(args, fmt);
	i=vsprintf(buf,fmt,args);
	va_end(args);
	__asm__("push %%fs\n\t"
		"push %%ds\n"
		"pop %%fs\n"
		"pushl %0\n"
		"pushl $buf\n"
		"pushl $0\n"
		"call tty_write\n"
		"addl $8,%%esp\n"
		"popl %0\n"
		"pop %%fs\n"
		::"r" (i):"ax","cx","dx");
	return i;
}
