#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

static int VGA_WIDTH =  80;
static int VGA_HEIGHT =  25;
#define VGA_MEMORY  0xB8000

extern void _GDT;
extern void _IDT;
extern uint16_t GDT_size;
extern uint16_t IDT_size;
extern void _keyboard_int(void);
static int line = 0;

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

 uint8_t vga_color(uint8_t background, uint8_t foreground) {
    return background << 4 | foreground;
}

 uint16_t vga_entry(uint8_t letter, uint8_t color) {
    return color << 8 | letter;
}

uint16_t vga_indexing(uint8_t x, uint8_t y) {
    return x + VGA_WIDTH * y;
}

static uint8_t text_color;

void vga_init() {
    text_color = vga_color(VGA_COLOR_BLACK, VGA_COLOR_GREEN);
    uint8_t blank = vga_entry(' ', text_color);
    for(uint8_t x = 0; x < VGA_WIDTH; x++) {
        for(uint8_t y = 0; y < VGA_HEIGHT; y++) {
            vga_buffer[vga_indexing(x, y)] = blank;
        }
    }
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
}


void vga_str_put(char *c) {
    uint16_t ind = VGA_WIDTH * line;
    // for(int i = 0; i < )*/2582
    vga_buffer[ind++] = vga_entry(' ', text_color);
    vga_str_put_index(c, ind);
    line++;
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

#define GDT_ENTRY_SIZE 8
#define IDT_ENTRY_SIZE 8



void kernel_init() {
    vga_init();

    set_gdt_entry(0, 0 ,0, 0, 0);

    set_gdt_entry(1, 0xFFFFF, 0x0, 0x9A, 0xC);
    set_gdt_entry(2, 0xFFFFF, 0x0, 0x92, 0xC);
    GDT_size = GDT_ENTRY_SIZE * 3 - 1;


    set_idt_entry(3, (uint32_t)&_keyboard_int, 8, 0xE, 0);
    // IDT_size = IDT_ENTRY_SIZE * 3 - 1;

    // set_gdt_entry(3, sizeof(TSS) - 1, &TSS, 0x89, 0);
}

void kernel_routine() {

}

void keyboard_event() {}
