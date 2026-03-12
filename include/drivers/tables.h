#ifndef DRIVERS_TABLE
#define DRIVERS_TABLE

#include "drivers/io.h"

#define PAGE_TABLE_PRESENT    1
#define PAGE_TABLE_READ_WRITE 1 << 1
#define PAGE_TABLE_READ_ONLY  0
#define PAGE_TABLE_USER       1 << 2
#define PAGE_TABLE_SUPER      0
#define PAGE_TABLE_WRT_THR    1 << 3
#define PAGE_TABLE_CHC_DIS    1 << 4
#define PAGE_TABLE_ACCESSED     1 << 5
#define PAGE_TABLE_DIRTY      1 << 6
#define PAGE_TABLE_ATR_TABLE  1 << 7
#define PAGE_TABLE_GLOBAL 1 << 8

#define PAGE_DIR_PRESENT    1
#define PAGE_DIR_READ_WRITE 1 << 1
#define PAGE_DIR_READ_ONLY  0
#define PAGE_DIR_USER       1 << 2
#define PAGE_DIR_SUPER      0
#define PAGE_DIR_WRT_THR    1 << 3
#define PAGE_DIR_CHC_DIS    1 << 4
#define PAGE_DIR_ACCESSED     1 << 5

void init_gdt();
void init_idt();
void set_gdt_entry(uint16_t index, uint32_t limit , uint32_t base, uint8_t access,  uint8_t flags);
void set_int_handler(uint16_t interruption, void (*callback)(void));
void set_idt_entry(uint16_t index, uint32_t offset, uint16_t seg_selector, uint8_t gate_type, uint8_t DPL);
void set_page_table_entry(uint32_t *entry_addr, char *pg_address,  uint16_t flags);
void set_pg_dir_entry(uint16_t index, void *pg_table_address, uint8_t flags);

#endif
