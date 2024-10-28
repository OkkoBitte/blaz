; Настройка сегментатора
mov ax, 0
mov gs, ax

; Вывод "Hello"
mov ax, 0xb800
mov es, ax

mov al, 'H' 
mov byte [es:0], al
mov word [es:2], 0x07c0
mov al, 'e'
mov byte [es:4], al
mov word [es:6], 0x07c0
mov al, 'l'
mov byte [es:8], al
mov word [es:10], 0x07c0
mov al, 'l'
mov byte [es:12], al
mov word [es:14], 0x07c0
mov al, 'o'
mov byte [es:16], al
mov word [es:18], 0x07c0

; Зацикливание
jmp $ 
