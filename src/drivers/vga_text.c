#include "drivers/vga_text.h"

int line = 0;
int vga_i = 0;

uint8_t vga_color(uint8_t background, uint8_t foreground) {
    return background << 4 | foreground;
}

uint16_t vga_entry(uint8_t letter, uint8_t color) {
    return color << 8 | letter;
}

uint16_t vga_indexing(uint8_t x, uint8_t y) {
    return x + VGA_WIDTH * y;
}

void vga_clear(uint8_t color) {
    uint16_t blank = vga_entry(' ', vga_color(color,color));
    for(uint8_t x = 0; x < VGA_WIDTH; x++) {
        for(uint8_t y = 0; y < VGA_HEIGHT; y++) {
            vga_buffer[vga_indexing(x, y)] = blank;
        }
    }
}

void vga_init() {
    text_color = vga_color(VGA_COLOR_BLACK, VGA_COLOR_GREEN);
    vga_clear(VGA_COLOR_BLACK);
}

uint16_t str_len(char *c) {
    uint16_t i = 0;
    while(c[i] != 0)
        i++;
    return i;
}


void vga_str_put_index(char *c, uint16_t index) {
    uint16_t ind = index;
    uint16_t c_len = str_len(c);
    for(int i = 0; i < c_len; i++) {
        if(c[i] == '\n' || ind % VGA_WIDTH == VGA_WIDTH - 1) {
            line++;
            ind = line * VGA_WIDTH;
            continue;
        }
        vga_buffer[ind] = vga_entry(c[i], text_color);
        ind++;
    }
    vga_i += c_len;
}


void vga_str_printl(char *c) {
    uint16_t ind = VGA_WIDTH * line;
    // for(int i = 0; i < )*/2582
    vga_buffer[ind++] = vga_entry(' ', text_color);
    vga_str_put_index(c, ind);
    line++;
}

void vga_str_print(char *c) {
    vga_str_put_index(c, vga_i);
}
