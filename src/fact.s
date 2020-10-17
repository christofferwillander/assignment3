.text
.globl fact
fact:
	xorq	%r10, %r10
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
	movq	$1, %r8

end:
	cmpq	$1, %r10
	jz	negativeend
    	ret

negative:
	movq	$1, %r10
	negq	%rax
	movq	%rax, %r8
	subq	$1, %r8	
	jmp	notzero

negativeend:
	negq	%rax
	ret

