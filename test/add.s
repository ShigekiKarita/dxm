.intel_syntax noprefix
    .text
LCO:
    .ascii "hello\12\0"
.globl _main
_main:
    push    rbp
    mov     rbp,    rsp
    sub     rsp,    8
    and     rsp,    -16
    mov     rax,    0
    mov     rax,    [rbp-4]
    call    __alloca
    call    __main
    mov     rsp,    LCO
    call    _printf
    mov     rax,    0
    leave
    ret
