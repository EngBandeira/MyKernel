#include "drivers/tables.h"
#include <stdint.h>

#define GDT_ENTRY_SIZE 8
#define IDT_ENTRY_SIZE 8

extern void _GDT;
extern void _IDT;
extern void _PG_DIR;
extern uint16_t GDT_size;
extern uint16_t IDT_size;
extern void _int_handler0(void);
extern void _int_handler1(void);

void init_gdt() {
    set_gdt_entry(0, 0 ,0, 0, 0);

    set_gdt_entry(1, 0xFFFFF, 0x0, 0x9A, 0xC);
    set_gdt_entry(2, 0xFFFFF, 0x0, 0x92, 0xC);
    GDT_size = GDT_ENTRY_SIZE * 3 - 1;
}

void init_idt() {
    uint8_t sys_handler_l = &_int_handler1 - &_int_handler0;
    for(int i = 0; i < 34; i++) {
        set_int_handler(i, _int_handler0 + sys_handler_l*i);
    }
}

void set_gdt_entry(uint16_t index, uint32_t limit , uint32_t base, uint8_t access,  uint8_t flags) {
    uint8_t *ptr = (uint8_t *)&_GDT + 8 * index;

    ptr[0] = ((uint8_t)limit);
    ptr[1] = ((uint8_t*)&limit)[1];
    ptr[2] = (uint8_t)base;
    ptr[3] = ((uint8_t*)&base)[1];

    ptr[4] = ((uint8_t*)&base)[2];
    ptr[5] = access;
    ptr[6] = (((uint8_t*)&limit)[2] & 0b1111) |  (flags & 0b1111) << 4;
    ptr[7] = ((uint8_t*)&base)[3];

}

void set_int_handler(uint16_t interruption, void (*callback)(void)) {
    set_idt_entry(interruption, (uint32_t)callback, 8, 0xE, 0);
}

void set_idt_entry(uint16_t index, uint32_t offset, uint16_t seg_selector, uint8_t gate_type, uint8_t DPL) {
    uint8_t *ptr = (uint8_t *)&_IDT + 8 * index;

    ptr[0] = ((uint8_t)offset);
    ptr[1] = ((uint8_t*)&offset)[1];
    ptr[2] = (uint8_t)seg_selector;
    ptr[3] = ((uint8_t*)&seg_selector)[1];

    ptr[4] = 0;
    ptr[5] = 1<<7;
    ptr[5] |= gate_type & 0b1111;
    ptr[5] |= (DPL & 0b11) << 5;

    ptr[6] = ((uint8_t*)&offset)[2];
    ptr[7] = ((uint8_t*)&offset)[3];
}


void set_pg_dir_entry(uint16_t index, void *address, uint8_t flags) {
    uint8_t *ptr8 = (uint8_t *)&_PG_DIR + 4 * index;
    uint32_t *ptr = (uint32_t *)&_PG_DIR + index;

    *ptr = (uint32_t)address >> 12;
    *ptr8 = flags;
}
