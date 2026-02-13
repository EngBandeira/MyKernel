#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define VGA_WIDTH   80
#define VGA_HEIGHT  25
#define VGA_MEMORY  0xB8000

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

uint16_t* vga_buffer = (uint16_t*)VGA_MEMORY;

inline uint8_t vga_color(uint8_t background, uint8_t foreground) {
    return background << 4 | foreground;
}

inline uint16_t vga_entry(uint8_t letter, uint8_t color) {
    return color << 8 | letter;
}

inline uint8_t vga_indexing(uint8_t x, uint8_t y) {
    return x * VGA_HEIGHT + y;
}

void vga_init() {
    uint16_t ent = vga_entry(' ', vga_color(VGA_COLOR_GREEN, VGA_COLOR_WHITE));
    for(int x = 0; x < VGA_WIDTH; x++) {
        for(int y = 0; y < VGA_HEIGHT; y++) {
            vga_buffer[vga_indexing(x, y)] = ent;
        }
    }
}

uint16_t str_len(char *c) {
    uint16_t i = 0;
    while(c[i] != 0)
        i++;
    return i;
}


void vga_str_put(char *c, uint16_t index) {
    uint16_t c_len = 16;
    for(int i = 0; i < c_len; i++) {
        vga_buffer[index + i] = vga_entry(c[i], vga_color(VGA_COLOR_BROWN, VGA_COLOR_WHITE));
    }
}

void kernel_init() {
    // vga_init();
    char c[] = "seu preto kkk\0";
    vga_str_put(c, 0);
    while(1);
}
