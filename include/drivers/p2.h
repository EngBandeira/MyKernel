#ifndef DRIVER_KEYBOARD
#define DRIVER_KEYBOARD

#include "drivers/io.h"

static char scan_codes[0x4E] = {
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

void p2_command(uint8_t command);
void p2_command_wdata(uint8_t command, uint8_t data);
uint8_t p2_read();
void init_p2();

void p2_keyboard_init(void (*press_callback_)(char key));
void set_callback(void (*press_callback_)(char key));

void keyboard_handler();


#endif
