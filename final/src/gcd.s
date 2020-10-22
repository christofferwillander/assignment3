.text
.globl gcd
gcd:				# Pushing registers %r8, %r9 - to preserve values
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
	cmpq 	%r9, %r8	# While %r8 != %r9
	jz	end		
	cmpq	%r9, %r8	# If %r8 <= %r9 - jump to else, otherwise jump to if
	jle	else
	jmp	if

if:
	subq	%r9, %r8	
	jmp	while

else:
	subq	%r8, %r9
	jmp	while

end:
	movq 	%r8, %rax	# Move calculated GCD to return register %rax
	popq	%r8		
	popq	%r9
	ret			# Restoring values in registers %r8, %r9 before returning

isZero:				# If any input parameter is equal to 0
	movq	$0, %r8
	movq	$0, %r9
	jmp 	end

isEqual:			# If input parameters are equal
	jmp	end

op1Neg:				# If first input parameter is negative
	negq	%r8
	cmpq	$0, %r9
	jl	op2Neg
	jmp	while

op2Neg:				# If second input parameter is negative
	negq	%r9
	jmp	while
