#include "kernel.h"
#include "stdarg.h"


Io::Io(){
    SCRN_SEL = 0x18;
}

/* put a byte on screen */
void Io::putc(char c){
    asmv(
            "mov %[SCRN_SEL],%%gs\n\t"
            "movb %[c],%%gs:(%[scr_loc])\n\t"
            ::[c]"r"(c),[SCRN_SEL]"b"(SCRN_SEL),[scr_loc]"r"(2*scr_loc)
        );
    scr_loc++;
    if(scr_loc>2000) scr_loc = 0;
}


