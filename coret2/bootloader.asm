bits 16
org 0x7C00

start:
    ; Настройка стека
    cli                     ; Отключаем прерывания
    mov ax, 0x9000          ; Устанавливаем стек выше загрузочного сектора
    mov ss, ax
    mov sp, 0xFFFF
    sti                     ; Включаем прерывания обратно

    ; Вывод "Hello"
    mov ah, 0x0e
    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'o'
    int 0x10

    ; Переход к 32-битному режиму
    cli                     ; Отключаем прерывания
    lgdt [gdt_descriptor]   ; Загружаем GDT
    mov eax, cr0
    or al, 1                ; Включаем бит PE для перехода в защищённый режим
    mov cr0, eax
    jmp CODE_SEG:protected_mode ; Длинный прыжок для сброса процессора

gdt_start:
    dq 0                    ; Нулевой дескриптор
gdt_code:
    dw 0xFFFF               ; Лимиты (0-15)
    dw 0                    ; Базовый адрес (16-31)
    db 0                    ; Базовый адрес (32-39)
    db 10011010b            ; Доступ (41-47)
    db 11001111b            ; Граничные флаги (48-55)
    db 0                    ; Базовый адрес (56-63)
gdt_data:
    dw 0xFFFF               ; Лимиты (0-15)
    dw 0                    ; Базовый адрес (16-31)
    db 0                    ; Базовый адрес (32-39)
    db 10010010b            ; Доступ (41-47)
    db 11001111b            ; Граничные флаги (48-55)
    db 0                    ; Базовый адрес (56-63)
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
    call main32

    cli
    hlt

main32:
    ; Здесь будет ваше 32-битное ядро
    ret

times 510 - ($ - $$) db 0
dw 0xAA55
