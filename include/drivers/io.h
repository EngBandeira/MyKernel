#ifndef DRIVER_IO
#define DRIVER_IO

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

void cli();
void sti();

uint32_t read_cr2();

void outb(uint8_t value, uint16_t port);

void outl(uint32_t value, uint16_t port);

uint8_t inb(uint16_t port);

void send_error();

#endif
