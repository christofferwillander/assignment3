.text
.globl fact
fact:
	pushq	%r9
	pushq	%r8
	xorq	%r9, %r9
	movq 	%rdi, %rax
	cqto
	cmpq	$0, %rax
	jz	zeroend
	cmpq	$1, %rax
	jz	zeroend
	cmpq	$0, %rax
	jl	negative
    	movq 	%rax, %r8
	subq	$1, %r8
	jmp	notzero

notzero:
	mulq	%r8
	subq	$1, %r8
	cmpq	$0, %r8
	jz	end
	jmp	notzero

zeroend:
	movq	$1, %rax

end:
	cmpq	$1, %r9
	jz	negativeend
	popq	%r8
	popq	%r9
    	ret

negative:
	movq	$1, %r9
	negq	%rax
	movq	%rax, %r8
	subq	$1, %r8	
	jmp	notzero

negativeend:
	negq	%rax
	popq	%r8
	popq	%r9
	ret

