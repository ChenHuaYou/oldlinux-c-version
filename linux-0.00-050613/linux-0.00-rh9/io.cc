#include "kernel.h"
#include "stdarg.h"


Io::Io(){
}

/* put a byte on screen */
void Io::putc(char c, u8 color){
    screen = (char *) RAMSCREEN;
    *(screen + 2 * scr_loc) = c;
    *(screen + 2 * scr_loc + 1) = color;
    scr_loc++;
    if(scr_loc>2000) scr_loc = 0;
}


