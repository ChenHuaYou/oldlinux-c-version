#include "kernel.h"

#define value 0x9a00

int main(){
    unsigned short test_ushort = value;
    bool aaaa = test_ushort == 0x9a00;
    unsigned long test_ulong = value;
}
