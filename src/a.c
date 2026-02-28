
int main() {
    short port = 0x60;
    char rt;
    asm("movw %1, %%dx\n\t"
        "inb %%dx, %%al\n\t"
        "movb %%al, %0"
        : "=r" (rt)
        : "r" (port));
}
