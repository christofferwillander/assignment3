.text
.globl numToASCII
numToASCII:
        pushq   %r11
        pushq   %r10
        pushq   %r9
        pushq   %r8
        movq    %rdi, %rax
        movq    $0, %r9
        movq    $10, %r8
        cqto
        cmpq    $0, %rax
        jl      isNegative
        movq    $0, %r11

divisionLoop:
        xorq    %rdx, %rdx
        divq    %r8
        pushq   %rdx
        incq    %r9
        cmpq    $0, %rax
        jne     divisionLoop
        movq    $0, %r10

popReverse:
        pop     %rax
        addq    $'0', %rax
        movq    %rax, (%rsi)
        incq    %rsi
        incq    %r10
        cmpq    %r9, %r10
        jz      finished
        jmp     popReverse


finished:
        movq    $'\n', (%rsi)
        incq    %rsi
        movq    $0, (%rsi)
        addq    $2, %r9
        addq    %r11, %r9
        movq    %r9, %rax
        popq    %r8
        popq    %r9
        popq    %r10
        popq    %r11
        ret

isNegative:
        negq    %rax
        movq    $1, %r11
        movq    $'-', (%rsi)
        incq    %rsi
        jmp     divisionLoop

