.text
.globl gcd
gcd:
	pushq	%r9
	pushq	%r8
	movq 	%rdi, %r8
	movq 	%rsi, %r9
	cmpq	$0, %r8
	jz	isZero
	cmpq	$0, %r9
	jz	isZero
	cmpq	%r8, %r9
	jz	isEqual
	cmpq	$0, %r8
	jl	op1Neg
	cmpq	$0, %r9
	jl	op2Neg

while:
	cmpq 	%r9, %r8
	jz	end
	cmpq	%r9, %r8
	jle	else
	jmp	if

if:
	subq	%r9, %r8
	jmp	while

else:
	subq	%r8, %r9
	jmp	while

end:
	movq 	%r8, %rax
	popq	%r8
	popq	%r9
	ret

isZero:
	movq	$0, %r8
	movq	$0, %r9
	jmp 	end

isEqual:
	jmp	end

op1Neg:
	negq	%r8
	cmpq	$0, %r9
	jl	op2Neg
	jmp	while

op2Neg:
	negq	%r9
	jmp	while
