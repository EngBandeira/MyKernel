#include "drivers/pic.h"

void init_pic() {
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
