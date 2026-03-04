#include "drivers/io.h"

void send_error(){
    // vga_
    while(1);
}

void cli() {
    asm("cli");
}

void sti() {
    asm("sti");
}

void outb(uint8_t value, uint16_t port) {
    asm("movb %0, %%al\n\t"
        "movw %1, %%dx\n\t"
        "outb %%al, %%dx"
        :
        : "r" (value), "r" (port));
}

void outl(uint32_t value, uint16_t port) {
    asm("movl %0, %%eax\n\t"
        "movw %1, %%dx\n\t"
        "outl %%eax, %%dx"
        :
        : "r" (value), "r" (port));
}

uint8_t inb(uint16_t port) {
    uint8_t rt;
    asm("movw %1, %%dx\n\t"
        "inb %%dx, %%al\n\t"
        "movb %%al, %0"
        : "=r" (rt)
        : "r" (port));
    return rt;
}
