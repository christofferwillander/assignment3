.text
.globl gcd
gcd:
	pushq	%r9
	pushq	%r8
	movq 	%rdi, %r8	# Moving first input parameter into %r8
	movq 	%rsi, %r9	# Moving second input parameter into %r9
	cmpq	$0, %r8		# Checking if any of the input paramets are equal to 0
	jz	isZero
	cmpq	$0, %r9
	jz	isZero
	cmpq	%r8, %r9	# Checking if input parameters are equal
	jz	isEqual
	cmpq	$0, %r8		# Checking if any input parameter is negative
	jl	op1Neg
	cmpq	$0, %r9
	jl	op2Neg

while:
	cmpq 	%r9, %r8	# Checking if %r8, %r9 are equal - then terminate
	jz	end		
	cmpq	%r9, %r8	# Checking if %r8 is greater than %r9 - if so jump to if, otherwise jump to else
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
