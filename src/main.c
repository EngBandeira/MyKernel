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
#include "time.h"
#include "snake.h"
#include "wait.h"



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

    for(int pg_dir = 0; pg_dir < 1024; pg_dir++) {
        set_pg_dir_entry(pg_dir, (void*)(4096*4096*pg_dir), PAGE_DIR_PRESENT | PAGE_DIR_READ_WRITE | PAGE_DIR_USER );
    }
}
