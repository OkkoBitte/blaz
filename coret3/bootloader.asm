bits 16
org 0x7C00

start:
    ; Настройка стека
    cli
    mov ax, 0x9000
    mov ss, ax
    mov sp, 0xFFFF
    sti

    ; Вывод "Booting..."
    mov si, msg_boot
    call print_string

    ; Переход в защищённый режим
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp CODE_SEG:protected_mode

msg_boot db "Booting...", 0

print_string:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .loop
.done:
    ret

gdt_start:
    dq 0
gdt_code:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0
gdt_data:
    dw 0xFFFF
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

[BITS 32]
protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x90000
    mov esp, ebp

    ; Вызываем 32-битное ядро
    call 0x1000:0x0000

    cli
    hlt

times 510 - ($ - $$) db 0
dw 0xAA55
