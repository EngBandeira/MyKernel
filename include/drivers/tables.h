#ifndef DRIVERS_TABLE
#define DRIVERS_TABLE

#include "drivers/io.h"

void init_gdt();
void init_idt();
void set_gdt_entry(uint16_t index, uint32_t limit , uint32_t base, uint8_t access,  uint8_t flags);
void set_handler(uint16_t index, uint32_t interrupt);
void set_idt_entry(uint16_t index, uint32_t offset, uint16_t seg_selector, uint8_t gate_type, uint8_t DPL);

#endif
