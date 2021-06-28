#
# Makefile for the FREAX-kernel character device drivers.
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
	-finline-functions -nostdinc -I../../include -fno-stack-protector -g
#CPP	=gcc -E -nostdinc -I../../include

.cc.s:
	$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	$(AS) -c -o $*.o $<
.cc.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<

OBJS  = math_emulate.o

math.a: $(OBJS)
	$(AR) rcs math.a $(OBJS)
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
