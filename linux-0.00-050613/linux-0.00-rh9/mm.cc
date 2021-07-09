#include "kernel.h"

#define LOW_MEM 0x100000 // 1M
#define MAX_MEM 0x1000000 // 16M
#define PAGING_PAGES ((MAX_MEM-LOW_MEM)/(0x1000))
#define BUF_PAGES 896

u8 mm_map[PAGING_PAGES] = {0};

void memory::init(void){
    for(int i=0;i<BUF_PAGES;i++){
        mm_map[i] = 1;
    }
    for(int i=BUF_PAGES;i<PAGING_PAGES;i++){
        mm_map[i] = 0;
    }
}
u32 memory::get_free_page(void){
    for(int i=BUF_PAGES; i<PAGING_PAGES;i++){
        if(mm_map[i]==0){
            mm_map[i] = 1;
            return i;
        }
    }
    return 0;
}
