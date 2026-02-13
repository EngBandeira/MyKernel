rm build/*.o &&
as --32 -march=i686 src/start.s -o build/start.o &&
gcc -Wall -Wextra -c -m32 -march=i686 src/main.c -o build/main.o &&
ld -melf_i386 -T linker.ld build/main.o build/start.o -o ./build/final &&
cp ./build/final iso/boot/kernel &&
if not grub-file --is-x86-multiboot iso/boot/kernel; then
    echo -e "\e[31m                  ERROR: NOT MULTIBOOT\e[0m"
    exit 1
fi
grub-mkrescue ./iso -o kernel.iso
