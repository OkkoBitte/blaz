nasm -f bin bootloader.asm -o bootloader.bin
gcc -ffreestanding -c kernel.c -o kernel.o
cat bootloader.bin kernel.o > os-image.bin
dd if=os-image.bin of=blaz.img bs=1 conv=sync
rm  bootloader.bin kernel.o os-image.bin
qemu-system-i386 -drive  file=blaz.img,format=raw -m 128M
rm  blaz.img

