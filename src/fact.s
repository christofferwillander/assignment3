.text
.globl fact
fact:						# pushing registers %r8, %r9 - to preserve values
	pushq	%r9
	pushq	%r8
	xorq	%r9, %r9			# zeroing %r9
	movq 	%rdi, %rax
	cqto					# expanding %rax registry
	cmpq	$0, %rax
	jz	zeroend
	cmpq	$1, %rax
	jz	zeroend
	cmpq	$0, %rax
	jl	negative
    	movq 	%rax, %r8
	subq	$1, %r8				# r8 is one less than rax
	jmp	notzero

notzero:					# calculate the factorial of the input values stored in %rax
	mulq	%r8				# multtply %rax with %r8 and store the result in %rax
	subq	$1, %r8
	cmpq	$0, %r8				# if %r8 is zero we have reached the end
	jz	end
	jmp	notzero

zeroend:					# if the input value is 1 or 0 it returns 1
	movq	$1, %rax

end:
	cmpq	$1, %r9				# if the input value was negative
	jz	negativeend
	popq	%r8
	popq	%r9
    	ret

negative:					# if the input values are negative, we calculate the fact of the positive value and then convert to negative -(n!)
	movq	$1, %r9
	negq	%rax
	movq	%rax, %r8
	subq	$1, %r8	
	jmp	notzero

negativeend:
	negq	%rax				# negating return value
	popq	%r8
	popq	%r9
	ret

