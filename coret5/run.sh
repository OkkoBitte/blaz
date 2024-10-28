nasm -f elf32 boot.asm -o kasm.o
gcc -m32 -c kernel.c -o kc.o
ld -m elf_i386 -T link.ld -o kernel_blaz kasm.o kc.o
rm kasm.o kc.o
clear
qemu-system-i386 -kernel kernel_blaz