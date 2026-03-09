tui enable
target remote localhost:1234
symbol-file iso/boot/kernel
b _start
b kernel_init
b _keyboard_int
c
tui focus cmd
