.text
.globl lntwo
lntwo:
    xorq    %r10, %r10          # zero out r10
    movq    %rdi, %rax          # move the input value to rax
    cmpq    $0, %rax
    jl      negativeCase
    cmpq    $0, %rax
    jz		notExist
    cmpq    $1, %rax
    jz      zeroExit
    jmp     loop

loop:                           # loop function to calculate the binary logarithm
    shrq    $1, %rax            # shift rax to the right to divide by 2
    cmpq    $0, %rax
    jle     end
    incq    %r10                # r10 is used as a counter
    jmp     loop

zeroExit:                       # if the input value is 1
    movq    $0, %rax
    jmp     end

notExist:                       # if the input value is 0
    movq    $-1, %rbx;          # check value for numToASCII library
    movq    $0, %rax
    ret

negativeCase:                   # if the input value is negative
    movq    $-2, %rbx           # check value for numToASCII library
    movq    $0, %rax
    ret

end:                            # move the result to %rax and return
    movq    %r10, %rax
    ret
