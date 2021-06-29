#
# Makefile for the FREAX-kernel character device drivers.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .cc file).
#

AR	=ar
AS	=as --32
#LD	=ld
LDFLAGS	=-s -x
CC	=g++ -march=i386 -m32
CFLAGS	=-Wall -fstrength-reduce -fomit-frame-pointer \
	-finline-functions -nostdinc -I../../include -fno-stack-protector -g
CPP	=g++ -E -nostdinc -I../../include

#.cc.s:
#	$(CC) $(CFLAGS) \
#	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.cc.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS  = tty_io.o console.o keyb.o keyboard.o serial.o rs_io.o \
	tty_ioctl.o

chr_drv.a: $(OBJS)
	$(AR) rcs chr_drv.a $(OBJS)
	sync

keyboard.s: keyboard.S ../../include/linux/config.h
	$(CPP) -traditional keyboard.S -o keyboard.s

clean:
	rm -f core *.o *.a tmp_make keyboard.s
	#for i in *.cc;do rm -f `basename $$i .cc`.s;done

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in *.cc;do echo -n `echo $$i | sed 's,\.cc,\.s,'`" "; \
		$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile

### Dependencies:
console.s console.o: console.cc ../../include/linux/sched.h \
  ../../include/linux/head.h ../../include/linux/fs.h \
  ../../include/sys/types.h ../../include/linux/mm.h \
  ../../include/signal.h ../../include/linux/tty.h \
  ../../include/termios.h ../../include/asm/io.h \
  ../../include/asm/system.h
serial.s serial.o: serial.cc ../../include/linux/tty.h ../../include/termios.h \
  ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/sys/types.h \
  ../../include/linux/mm.h ../../include/signal.h \
  ../../include/asm/system.h ../../include/asm/io.h
tty_io.s tty_io.o: tty_io.cc ../../include/ctype.h ../../include/errno.h \
  ../../include/signal.h ../../include/sys/types.h \
  ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/linux/mm.h \
  ../../include/linux/tty.h ../../include/termios.h \
  ../../include/asm/segment.h ../../include/asm/system.h
tty_ioctl.s tty_ioctl.o: tty_ioctl.cc ../../include/errno.h ../../include/termios.h \
  ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/sys/types.h \
  ../../include/linux/mm.h ../../include/signal.h \
  ../../include/linux/kernel.h ../../include/linux/tty.h \
  ../../include/asm/io.h ../../include/asm/segment.h \
  ../../include/asm/system.h
