# Makefile for the simple example kernel.
AS86	=as86 -0 -a
LD86	=ld86 -0
AS	=as --32
LD	=ld
LDFLAGS =-m elf_i386 -Ttext 0 -e startup_32

CC	=gcc -march=i386 -m32
CFLAGS	=-Wall -O0 -fstrength-reduce -fomit-frame-pointer \
	-finline-functions -nostdinc -I./ -fno-stack-protector -fno-builtin -g

.cc.o:
	$(CC) $(CFLAGS) \
	-c -o $*.o $<
.s.o:
	$(AS) -c -o $*.o $<



all:	Image

Image: boot system
	dd bs=32 if=boot of=Image skip=1
	objcopy -O binary system head
	cat head >> Image

system:	head.o kernel.o io.o string.o
	$(LD) $(LDFLAGS) head.o kernel.o io.o string.o -o system > System.map

boot:	boot.s
	$(AS86) -o boot.o boot.s
	$(LD86) -s -o boot boot.o

clean:
	rm -f Image System.map core boot head *.o system
