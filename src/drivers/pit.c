#include "drivers/pit.h"
#include "drivers/io.h"
#include "drivers/tables.h"
#include "drivers/vga_text.h"
#include "time.h"
#include <stdint.h>


#define RW_PIT_DATA1 0x40
#define W_PIT_COMMAND_REGISTER 0x43

extern void _timer_int(void);

void init_pit() {
    ticks = 0;
    seconds = 0;

    outb(0x36, W_PIT_COMMAND_REGISTER);
    outb(0, RW_PIT_DATA1);
    outb(0, RW_PIT_DATA1);
}


void timer_handler() {
    if(!(ticks % 18))
        seconds++;
    ticks++;
    outb(0x20, 0x20);
}
