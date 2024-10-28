[BITS 32]
main32:
    ; Настройка сегментаторов
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Вывод "Hello"
    mov edx, 0xb8000
    mov word [edx], 'H' | (0x07 << 8)
    mov word [edx + 2], 'e' | (0x07 << 8)
    mov word [edx + 4], 'l' | (0x07 << 8)
    mov word [edx + 6], 'l' | (0x07 << 8)
    mov word [edx + 8], 'o' | (0x07 << 8)

    ; Бесконечное ожидание
    cli
    hlt
