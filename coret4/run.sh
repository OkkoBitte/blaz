nasm -f bin -o boot.bin boot.asm
dd if=boot.bin of=/dev/fd
dd if=/dev/zero of=disk.img bs=1024 count=1440
dd if=boot.bin of=disk.img conv=notrunc
qemu-system-i386 disk.img