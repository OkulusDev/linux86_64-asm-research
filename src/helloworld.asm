;; 64-битная программа для вывода строки на ассемблере
;; 64 битный режим - Long mode. Ко всем регистрам добавляется r, например
;; rax вместо ax, rdi вместо rdi.
;; Но в коде ниже можно встретить eax, edi, edx (буква e - для 32 битных
;; регистров, 32 битный режим - protected mode). Но в 64 битном режиме
;; все равно можно использовать 32 или 16 битные регистры для обозначения
;; младших 32 или 16 битов. Это сделано для обратной совместимости и для
;; удобства переноса 32 битного кода на 64 битный код
format ELF64    ; Указываем формат и режим программы (ELF 64bit)

section ".data" writeable   ; Секция инициализации данных и консант
    message db "Hello, World!"
    message_length = $ - message

section ".text" executable  ; Секция кода
    public _start

; Стартовая метка
_start:
    ;; Вызываем системный вызов write для вывода строки на экран.
    ;; В Linux системный вызов write имеет номер 1.
    mov eax, 1 ; номер системного вызова (1 - write)

    ;; Первый аргумент системного вызова write - это файловый дескриптор.
    ;; Дескриптор 1 - это стандартный вывод (stdout).
    mov edi, 1 ; файловый дескриптор (1 - stdout)

    ;; Второй аргумент системного вызова write - это адрес строки, которую мы хотим вывести.
    lea rsi, [message] ; адрес строки

    ;; Третий аргумент системного вызова write - это длина строки.
    mov edx, message_length ; длина строки

    ;; Вызываем системный вызов.
    syscall

    ;; Вызываем системный вызов exit для завершения программы.
    ;; В Linux системный вызов exit имеет номер 60.
    mov eax, 60 ; номер системного вызова (60 - exit)

    ;; Аргумент системного вызова exit - это код возврата программы.
    ;; Мы устанавливаем его равным 0, что означает успешное завершение программы.
    xor edi, edi ; код возврата (0)

    ;; Вызываем системный вызов.
    syscall
