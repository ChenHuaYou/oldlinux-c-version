#
# Makefile for the FREAX-kernel block device drivers.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .cc file).
#

AR	=ar
AS	=as --32
LD	=ld -m elf_i386
LDFLAGS	=-s -x
CC	=g++ -march=i386 -m32
CFLAGS	=-Wall -fstrength-reduce -fomit-frame-pointer  \
	-finline-functions -nostdinc -I../../include -fno-stack-protector -fno-builtin -g
CPP	=gcc -E -nostdinc -I../../include

.cc.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.cc.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS  = ll_rw_blk.o floppy.o hd.o ramdisk.o

blk_drv.a: $(OBJS)
	$(AR) rcs blk_drv.a $(OBJS)
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
floppy.s floppy.o: floppy.cc ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/sys/types.h \
  ../../include/linux/mm.h ../../include/signal.h \
  ../../include/linux/kernel.h ../../include/linux/fdreg.h \
  ../../include/asm/system.h ../../include/asm/io.h \
  ../../include/asm/segment.h blk.h
hd.s hd.o: hd.cc ../../include/linux/config.h ../../include/linux/sched.h \
  ../../include/linux/head.h ../../include/linux/fs.h \
  ../../include/sys/types.h ../../include/linux/mm.h \
  ../../include/signal.h ../../include/linux/kernel.h \
  ../../include/linux/hdreg.h ../../include/asm/system.h \
  ../../include/asm/io.h ../../include/asm/segment.h blk.h
ll_rw_blk.s ll_rw_blk.o: ll_rw_blk.cc ../../include/errno.h \
  ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/sys/types.h \
  ../../include/linux/mm.h ../../include/signal.h \
  ../../include/linux/kernel.h ../../include/asm/system.h blk.h
ramdisk.s ramdisk.o: ramdisk.cc ../../include/string.h ../../include/linux/config.h \
  ../../include/linux/sched.h ../../include/linux/head.h \
  ../../include/linux/fs.h ../../include/sys/types.h \
  ../../include/linux/mm.h ../../include/signal.h \
  ../../include/linux/kernel.h ../../include/asm/system.h \
  ../../include/asm/segment.h ../../include/asm/memory.h blk.h
