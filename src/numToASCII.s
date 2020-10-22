.text
.globl numToASCII
numToASCII:                     # Pushing register %r8 through %r11 - to preserve values
        pushq   %r11
        pushq   %r10
        pushq   %r9
        pushq   %r8
        cmpq    $0, %rbx
        jl      terminateEarly
        movq    %rdi, %rax      # Moving integer to be divided into %rax
        movq    $0, %r9         # Initializing counter to 0
        movq    $10, %r8        # Moving divisor into %r8
        cqto                    # Converting quad word in %rax into octoword        
        cmpq    $0, %rax        # Checking for a negative number (to insert '-' sign)
        jl      isNegative
        movq    $0, %r11        # Setting string length increment to 0 (no additional '-' sign inserted)

divisionLoop:
        xorq    %rdx, %rdx      # Zeroing out register for remainder
        idivq    %r8             # Dividing %rax by %r8
        pushq   %rdx            # Pushing remainder to stack
        incq    %r9             # Incrementing string length counter
        cmpq    $0, %rax        # Checking if %rax is yet 0 - if so, we are done - otherwise repeat
        jne     divisionLoop
        movq    $0, %r10        # Initalizing 'popping' counter to 0

popReverse:
        pop     %rax            # Popping integer from stack into rax
        addq    $'0', %rax      # Adding '0' (hex 48) to get corresponding ASCII character
        movq    %rax, (%rsi)    # Moving into outputString
        incq    %rsi            # Incrementing outputString pointer
        incq    %r10            # Incrementing 'popping' counter
        cmpq    %r9, %r10       # Checking if all elements have been popped - otherwise repeat
        jz      finished
        jmp     popReverse


finished:
        movq    $'\n', (%rsi)   # Adding '\n' to string
        incq    %rsi
        movq    $0, (%rsi)      # Adding NULL termination ('\0') to end of string
        addq    $2, %r9         # Increment string length by 2 to accomodate new symbols
        addq    %r11, %r9       # Adding length for additional '-' sign (if present)
        movq    %r9, %rax       # Moving string length to return register %rax
        popq    %r8             
        popq    %r9
        popq    %r10
        popq    %r11
        ret                     # Restoring values in registers %r8 through %r11 before returning

isNegative:
        negq    %rax            # Negate %rax (to work with a positive value)
        movq    $1, %r11        # Move additional length for '-' sign to %r11
        movq    $'-', (%rsi)    # Insert '-' sign into outputString
        incq    %rsi            # Increment outputString pointer
        jmp     divisionLoop    # Start division

terminateEarly:                 # Function for generating 'ERROR' string - used for errors in lntwo function (negative & zero input values)
        movq    $7, %rax
        movq    $'E', (%rsi)
        incq    %rsi
        movq    $'R', (%rsi)
        incq    %rsi
        movq    $'R', (%rsi)
        incq    %rsi
        movq    $'O', (%rsi)
        incq    %rsi
        movq    $'R', (%rsi)
        incq    %rsi
        movq    $'\n', (%rsi)
        incq    %rsi
        movq    $0, (%rsi)
        movq    $0, %rbx
        popq    %r8             
        popq    %r9
        popq    %r10
        popq    %r11
        ret                     # Restoring values in registers %r8 through %r11 before returning
