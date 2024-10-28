nasm bootloader.asm -o bootloader.bin
nasm kernel.asm -o kernel.bin
dd if=/dev/zero of=blaz.img bs=1M count=1
dd if=bootloader.bin of=blaz.img bs=1 conv=sync
dd if=kernel.bin of=blaz.img bs=1 seek=$(stat -c%s bootloader.bin) conv=notrunc
qemu-system-i386 -drive file=blaz.img,format=raw,index=0 -boot d -m 512M