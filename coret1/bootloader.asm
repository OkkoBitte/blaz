org 0x7c00

; Настройка стека
mov sp, 0x7c00

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
jmp main32

main32:
; Здесь будет ваше 32-битное ядро 

times 510 - ($ - $$) db 0
dw 0xaa55

