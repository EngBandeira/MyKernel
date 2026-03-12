#ifndef DRIVER_MEMORY
#define DRIVER_MEMORY

#include <stdint.h>

char *v_addr_to_real(char *v_address, uint32_t *pg_dir);
// extern char _heap_start;

// char *_heap_end;

// void mmap(uint32_t size);
// void brk(uint32_t size);
// void sbrk(uint32_t size);

#endif
