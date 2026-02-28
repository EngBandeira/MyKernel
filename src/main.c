#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#define GDT_ENTRY_SIZE 8
#define IDT_ENTRY_SIZE 8


static int VGA_WIDTH =  80;
static int VGA_HEIGHT =  25;
#define VGA_MEMORY  0xB8000

extern void _GDT;
extern void _IDT;
extern uint16_t GDT_size;
extern uint16_t IDT_size;
extern void _keyboard_int(void);
static int line = 0;
static int pinto = 0;
static int vga_i = 0;

char key_state[0x4E];

char scan_codes[0x4E] = {
    [0x1A] = 'Z',
    [0x1B] = 'S',
    [0x1C] = 'A',
    [0x1D] = 'W',
    [0x1E] = '\0',
    [0x1F] = '\0',
    [0x20] = '\0',
    [0x21] = 'C',
    [0x22] = 'X',
    [0x23] = 'D',
    [0x24] = 'E',
    [0x25] = '\0',
    [0x26] = '\0',
    [0x27] = '\0',
    [0x28] = '\0',
    [0x29] = ' ',
    [0x2A] = 'V',
    [0x2B] = 'F',
    [0x2C] = 'T',
    [0x2D] = 'R',
    [0x2E] = '\0',
    [0x2F] = '\0',
    [0x30] = '\0',
    [0x31] = 'N',
    [0x32] = 'B',
    [0x33] = 'H',
    [0x34] = 'G',
    [0x35] = 'Y',
    [0x36] = '\0',
    [0x37] = '\0',
    [0x38] = '\0',
    [0x39] = '\0',
    [0x3A] = 'M',
    [0x3B] = 'J',
    [0x3C] = 'U',
    [0x3D] = '\0',
    [0x3E] = '\0',
    [0x3F] = '\0',
    [0x40] = '\0',
    [0x41] = '\0',
    [0x42] = 'K',
    [0x43] = 'I',
    [0x44] = 'O',
    [0x45] = '\0',
    [0x46] = '\0',
    [0x47] = '\0',
    [0x48] = '\0',
    [0x49] = '\0',
    [0x4A] = '\0',
    [0x4B] = 'L',
    [0x4C] = '\0',
    [0x4D] = 'P'
};

#define R_PIC_M_STATUS_REGISTER 0x20
#define W_PIC_M_COMMAND_REGISTER 0x20

#define RW_PIC_M_DATA_REGISTER 0x21
#define RW_PIC_M_INT_MASK_REGISTER 0x21

#define R_PIC_SL_STATUS_REGISTER 0xA0
#define W_PIC_SL_COMMAND_REGISTER 0xA0

#define RW_PIC_SL_DATA_REGISTER 0xA1
#define RW_PIC_SL_INT_MASK_REGISTER 0xA1

#define RW_P2_DATA_PORT  0x60
#define R_STATUS_REGISTER   0x64
#define W_COMMAND_REGISTER  0x64
#define ACK_KEYBOARD   0xFA
#define RESEND_KEYBOARD   0xFE

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
    // for(int i = 0; i < )*/2582
    // vga_buffer[vga_i++] = vga_entry(' ', text_color);
    vga_str_put_index(c, vga_i+1);
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

void _8042_command(uint8_t command) {
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(command, W_COMMAND_REGISTER);
}
void _8042_command_wdata(uint8_t command, uint8_t data) {
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(command, W_COMMAND_REGISTER);
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(data, RW_P2_DATA_PORT);
}
void _keyboard_command(uint8_t command) {
    while((inb(R_STATUS_REGISTER) & 0b10));

    while(1) {
        outl(command, RW_P2_DATA_PORT);

        if(inb(RW_P2_DATA_PORT) != RESEND_KEYBOARD)
            break;
    }
}

void _keyboard_command_wdata(uint8_t command, uint8_t data) {
    while((inb(R_STATUS_REGISTER) & 0b10));
    while(1) {
        outl(command, RW_P2_DATA_PORT);

        if(inb(RW_P2_DATA_PORT) == ACK_KEYBOARD)
            break;
    }

    while(1) {
        outl(data, RW_P2_DATA_PORT);

        if(inb(RW_P2_DATA_PORT) == ACK_KEYBOARD)
            break;
    }
}


uint8_t _8042_read() {
    // while(!(inb(R_STATUS_REGISTER) & 1));pooo
    return inb(RW_P2_DATA_PORT);
}

void send_error(){
    // vga_
    while(1);
}

void init_8042() {
    _8042_command(0xAA);
    if(_8042_read() != 0x55)
        send_error();


    _8042_command(0xAB);
    if(_8042_read() != 0x0)
        send_error();


    _8042_command(0xA9);
    if(_8042_read() != 0x0)
        send_error();

    _8042_command(0xAD); //Disable First p2 port
    _8042_command(0xA7); //Disable Second p2 port

    _8042_read();  //Flush


    _8042_command_wdata(0x60, 0x1);     //Set controller conf byte

    _8042_command(0xAE); //Enable First p2 port
    _8042_command(0xA8); //Enable Second p2 port

}

void init_8259() {
    outb(0b11111101, RW_PIC_M_INT_MASK_REGISTER);


    outb(0x11, W_PIC_M_COMMAND_REGISTER);
    outb(0x11, W_PIC_SL_COMMAND_REGISTER);
    // movb $0b00011100, %al #Initialization Command Word 1
    // outb %al, $0x20
    // outb %al, $0xA0

    outb(0x20, RW_PIC_M_DATA_REGISTER);
    outb(0x28, RW_PIC_SL_DATA_REGISTER);
    // movb $0, %al #Initialization Command Word 2
    // outb %al, $0x21
    // outb %al, $0xA1

    outb(0x4, RW_PIC_M_DATA_REGISTER);
    outb(0x2, RW_PIC_SL_DATA_REGISTER);


    outb(0x1, RW_PIC_M_DATA_REGISTER);
    outb(0x1, RW_PIC_SL_DATA_REGISTER);
    // movb $0b00000100, %al #Initialization Command Word Master 3
    // outb %al, $0x21
    // movb $0b00000100, %al #Initialization Command Word Slave 3
    // outb %al, $0xA1
}

void p2_keyboard_init() {
    _keyboard_command(0xFF);
    while(inb(RW_P2_DATA_PORT) != ACK_KEYBOARD);

    _keyboard_command_wdata(0xF0,3);
    _keyboard_command(0xF4);
    _keyboard_command(0xF8);

}


void keyboard_handler() {
    if(!(inb(0x64) & 1)) {
        outb(0x20, 0x20);
        return;
    }

    while(!(inb(R_STATUS_REGISTER) & 0b1));

    uint8_t scan_c = inb(0x60);
    uint8_t scan_b = inb(0x60);

    if(scan_b > 0x80){
        outb(0x20, 0x20);
        return;
    }

    char c[2] = {scan_codes[scan_c], 0};
    vga_str_print(c);
    pinto++;
    outb(0x20, 0x20);
}

void kernel_init() {
    init_8259();
    init_8042();
    vga_init();

    p2_keyboard_init();

    set_gdt_entry(0, 0 ,0, 0, 0);

    set_gdt_entry(1, 0xFFFFF, 0x0, 0x9A, 0xC);
    set_gdt_entry(2, 0xFFFFF, 0x0, 0x92, 0xC);
    GDT_size = GDT_ENTRY_SIZE * 3 - 1;

    for(int i = 0; i < 50; i++) {
        set_idt_entry(i, (uint32_t)&_keyboard_int, 8, 0xE, 0);

    }
    // movl $0xAA, %eax
    // outl %eax, $0x64 #Test
    // inb $RW_P2_DATA_PORT, %al
    // cmpb $0x55, %al
    // jne _error
    // outl(0xAA, 0x64);
    // uint8_t jkkk = inb(RW_P2_DATA_PORT);
    // _send_keyboard_command(0xf0, 1);
    // IDT_size = IDT_ENTRY_SIZE * 3 - 1;

    // set_gdt_entry(3, sizeof(TSS) - 1, &TSS, 0x89, 0);
}

void kernel_routine() {

}

void keyboard_event() {}
