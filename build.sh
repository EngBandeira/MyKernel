rm -f build/*.o
rm -f kernel.iso
rm -f iso/boot/kernel
./build.pl &&
cp ./build/final iso/boot/kernel
if not grub-file --is-x86-multiboot iso/boot/kernel; then
    echo -e "\e[31m                  ERROR: NOT MULTIBOOT\e[0m"
    exit 1
fi
grub-mkrescue ./iso -o kernel.iso
