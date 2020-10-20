.text
.globl lntwo
lntwo:
    xorq    %r10, %r10
    movq    %rdi, %rax
    cmpq    $0, %rax
    jl      negativeCase
    cmpq    $0, %rax
    jz		notExist
    cmpq    $1, %rax
    jz      zeroExit
    jmp     loop

loop:
    shrq    $1, %rax
    cmpq    $0, %rax
    jle     end
    incq    %r10
    jmp     loop

zeroExit:
    movq    $0, %rax
    jmp     end

notExist:
    movq    $-1, %rbx;
    movq    $0, %rax
    ret

negativeCase:
    movq    $-2, %rbx
    movq    $0, %rax
    ret

end:
    movq    %r10, %rax
    ret
