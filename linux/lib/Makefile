#
# Makefile for some libs needed in the kernel.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .cc file).
#

AR	=ar
AS	=as --32
LD	=ld
LDFLAGS	=-s -x
CC	=g++ -march=i386 -m32
CFLAGS	=-Wall -O -fstrength-reduce -fomit-frame-pointer \
	-finline-functions -nostdinc -I../include -fno-stack-protector -fno-builtin -g
#CPP	=gcc -E -nostdinc -I../include

.cc.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.cc.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS  = ctype.o _exit.o open.o close.o errno.o write.o dup.o setsid.o \
	execve.o wait.o string.o malloc.o

lib.a: $(OBJS)
	$(AR) rcs lib.a $(OBJS)
	sync

clean:
	rm -f core *.o *.a tmp_make
	for i in *.cc;do rm -f `basename $$i .cc`.s;done

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.cc;do echo -n `echo $$i | sed 's,\.cc,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile

### Dependencies:
_exit.s _exit.o : _exit.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
close.s close.o : close.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
ctype.s ctype.o : ctype.cc ../include/ctype.h 
dup.s dup.o : dup.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
errno.s errno.o : errno.cc 
execve.s execve.o : execve.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
malloc.s malloc.o : malloc.cc ../include/linux/kernel.h ../include/linux/mm.h \
  ../include/asm/system.h 
open.s open.o : open.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h ../include/stdarg.h 
setsid.s setsid.o : setsid.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
string.s string.o : string.cc ../include/string.h 
wait.s wait.o : wait.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h ../include/sys/wait.h 
write.s write.o : write.cc ../include/unistd.h ../include/sys/stat.h \
  ../include/sys/types.h ../include/sys/times.h ../include/sys/utsname.h \
  ../include/utime.h 
