#include "drivers/p2.h"
#include "drivers/io.h"
#include "drivers/vga_text.h"
#include "drivers/tables.h"

#define RW_P2_DATA_PORT  0x60
#define R_STATUS_REGISTER   0x64
#define W_COMMAND_REGISTER  0x64
#define ACK_KEYBOARD   0xFA
#define RESEND_KEYBOARD   0xFE

extern void _keyboard_int(void);
void (*press_callback)(char key);

void init_p2() {
    p2_command(0xAA);
    if(p2_read() != 0x55)
        send_error();


    p2_command(0xAB);
    if(p2_read() != 0x0)
        send_error();


    p2_command(0xA9);
    if(p2_read() != 0x0)
        send_error();

    p2_command(0xAD); //Disable First p2 port
    p2_command(0xA7); //Disable Second p2 port

    p2_read();  //Flush


    p2_command_wdata(0x60, 0x1);     //Set controller conf byte

    p2_command(0xAE); //Enable First p2 port
    p2_command(0xA8); //Enable Second p2 port

}

void p2_command(uint8_t command) {
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(command, W_COMMAND_REGISTER);
}

void p2_command_wdata(uint8_t command, uint8_t data) {
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(command, W_COMMAND_REGISTER);
    while((inb(R_STATUS_REGISTER) & 0b10));
    outl(data, RW_P2_DATA_PORT);
}

uint8_t p2_read() {
    // while(!(inb(R_STATUS_REGISTER) & 1));pooo
    return inb(RW_P2_DATA_PORT);
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

void p2_keyboard_init(void (*press_callback_)(char key)) {
    set_handler(0x21, (uint32_t)&_keyboard_int);
    _keyboard_command(0xFF);
    while(inb(RW_P2_DATA_PORT) != ACK_KEYBOARD);

    _keyboard_command_wdata(0xF0,1);
    _keyboard_command(0xF4);
    _keyboard_command(0xF8);
    press_callback = press_callback_;
}

void set_callback(void (*press_callback_)(char key)) {
    press_callback = press_callback_;
}

void keyboard_handler() {
    if(!(inb(0x64) & 1)) {
        outb(0x20, 0x20);
        return;
    }

    while(!(inb(R_STATUS_REGISTER) & 0b1));

    uint8_t scan_c = inb(0x60);
    inb(0x60);

    if(scan_c > 0x80){
        outb(0x20, 0x20);
        return;
    }

    outb(0x20, 0x20);


    press_callback(scan_codes[scan_c]);

}
