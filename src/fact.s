.text
.globl fact
fact:
	movq 	%rdi, %r9
	cmpq	$0, %r9
	jz	zeroend
	cmp	$1, %r9
	jz	zeroend
    movq $1, %r8
	jmp	notzero

notzero:
	imulq	%r9, %r8
	subq	$1, %r9
	cmpq	$0, %r9
	jz	end
	jmp	notzero

zeroend:
	movq	$1, %r8
end:
	movq	%r8, %rax
    ret
