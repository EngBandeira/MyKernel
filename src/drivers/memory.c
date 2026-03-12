// #include "drivers/memory.h"

// char *_heap_end = &_heap_start;
#include <stdint.h>
char *v_addr_to_real(char *v_address, uint32_t *pg_dir) {
    uint32_t pg_dir_index = (uint32_t)v_address  >> 22 & 0x3FF ;
    uint32_t pg_table_index = (uint32_t)v_address  >> 12 & 0x3FF;
    uint32_t offset = (uint32_t)v_address & 0xFFF;

    uint32_t *pg_table = (uint32_t*)(pg_dir[pg_dir_index] & (~0xFFF));
    char *page = (char*)(pg_table[pg_table_index] & (~0xFFF));
    return page + offset;
}
 // 100101000110
// 1100101000110
