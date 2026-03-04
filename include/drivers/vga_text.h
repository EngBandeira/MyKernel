#ifndef DRIVER_VGA_TEXT
#define DRIVER_VGA_TEXT

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

static int VGA_WIDTH =  80;
static int VGA_HEIGHT =  25;
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

static uint8_t text_color;
static uint16_t* vga_buffer = (uint16_t*)VGA_MEMORY;

uint8_t vga_color(uint8_t background, uint8_t foreground);

uint16_t vga_entry(uint8_t letter, uint8_t color);

uint16_t vga_indexing(uint8_t x, uint8_t y);

void vga_clear(uint8_t color);

void vga_init();

uint16_t str_len(char *c);

void vga_str_put_index(char *c, uint16_t index);

void vga_str_printl(char *c);

void vga_str_print(char *c);

#endif
