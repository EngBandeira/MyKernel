#ifndef DRIVER_MEMORY
#define DRIVER_MEMORY

#include <stdint.h>

extern char _heap_start;
extern char* _heap_end;

void *malloc(uint32_t size);
void free(uint32_t size);

char *v_addr_to_real(char *v_address, uint32_t *pg_dir);

void v_addr_get_is(char *v_address, uint32_t *pg_dir_i, uint32_t *pg_tbl_i, uint32_t *offset);
// extern char _heap_start;

// char *_heap_end;

// void mmap(uint32_t size);
// void brk(uint32_t size);
// void sbrk(uint32_t size);

#endif
