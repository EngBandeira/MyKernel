#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "drivers/pit.h"
#include "drivers/tables.h"
#include "drivers/vga_text.h"
#include "drivers/p2.h"
#include "drivers/io.h"
#include "drivers/pic.h"
#include "drivers/tables.h"
#include "drivers/memory.h"
#include "time.h"
#include "snake.h"
#include "wait.h"

extern char _text_i;
extern char _text_e;
extern char _data_bss_i;
extern char _data_bss_e;
extern char _heap_start;
static char* _heap_end = & _heap_start;
extern void _PG_DIR;

// extern char _heap_start;


void kernel_routine() {
    init_game();
    vga_clear(VGA_COLOR_BLACK);
    vga_str_put_index("PERDEU KKKK", vga_indexing(VGA_WIDTH/2 - 6, VGA_HEIGHT/2));
    while(1);
}

void pritata(char b) {
    char c[2] = {b, 0};
    vga_str_print(c);
}

void kernel_init() {
    init_gdt();
    init_idt();
    init_pic();
    init_p2();
    init_pit();
    vga_init();
    p2_keyboard_init(pritata);
    // set_pg_dir_entry(0, , uint8_t flags)
    for( int i = 0; i < 1024; i++ ) {
        set_page_table_entry(((uint32_t*)&_heap_start) + i, (char*)(4096 * i), PAGE_TABLE_GLOBAL | PAGE_TABLE_PRESENT | PAGE_TABLE_READ_WRITE);
    }
    _heap_end += 4096;
    set_pg_dir_entry(0, &_heap_start , PAGE_DIR_PRESENT | PAGE_DIR_READ_WRITE | PAGE_DIR_USER);
}
