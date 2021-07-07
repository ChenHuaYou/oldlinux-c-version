!	boot.s
!
! It then loads the system at 0x10000, using BIOS interrupts. Thereafter
! it disables all interrupts, changes to protected mode, and calls the 

BOOTSEG = 0x07c0
BOOTSEG2 = 0x9000
SYSSEG  = 0x1000			! system loaded at 0x10000 (65536).
SYSLEN  = 60				! sectors occupied.

entry start
start:
	jmpi	go,#BOOTSEG
go:	mov	ax,cs
	mov	ds,ax
	mov	ss,ax
	mov	sp,#0x400		! arbitrary value >>512

! move it self to BOOTSEG2
	mov	ax, #BOOTSEG
	mov	ds, ax
	mov	ax, #BOOTSEG2
	mov	es, ax
	mov	cx, #0x200 ! copy one sector
	sub	si,si
	sub	di,di
	rep
	movw ! ds:si -> es:di
    jmpi load_system,#BOOTSEG2

load_system:
	mov	dx,#0x0000
	mov	cx,#0x0002
	mov	ax,#SYSSEG
	mov	es,ax
	xor	bx,bx
	mov	ax,#0x200+SYSLEN
	int 	0x13
	jnc	ok_load
die:	jmp	die

ok_load:
    cli
	mov	ax, #SYSSEG
	mov	ds, ax
	mov	ax, #0x0
	mov	es, ax
	mov	cx, #0x8000 ! copy 64k
	sub	si,si
	sub	di,di
	rep
	movw ! ds:si -> es:di

load_gdt_idt:
	mov	ax, #BOOTSEG2
	mov	ds, ax
	lidt	idt_48		! load idt with 0,0
	lgdt	gdt_48		! load gdt with whatever appropriate

! absolute address 0x00000, in 32-bit protected mode.
	mov	ax,#0x0001	! protected mode (PE) bit
	lmsw	ax		! This is it!
	jmpi	#0x0,8		! jmp offset 0 of segment 8 (cs)

gdt:	.word	0,0,0,0		! dummy

	.word	0x07FF		! 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		! base address=0x00000
	.word	0x9A00		! code read/exec
	.word	0x00C0		! granularity=4096, 386

	.word	0x07FF		! 8Mb - limit=2047 (2048*4096=8Mb)
	.word	0x0000		! base address=0x00000
	.word	0x9200		! data read/write
	.word	0x00C0		! granularity=4096, 386

idt_48: .word	0		! idt limit=0
	.word	0,0		! idt base=0L
gdt_48: .word	0x7ff		! gdt limit=2048, 256 GDT entries
	.word	0x0000+gdt,0x9	! gdt base = 0x90000
.org 510
	.word   0xAA55

