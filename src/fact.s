.text
.globl fact
fact:
	movq 	%rdi, %r9
	cmp	$0, %r9
	jz	zeroend
	cmp	$1, %r9
	jz	zeroend
	jmp	notzero

notzero:
	addq	%r9, %r8
	subq	$1, %r9
	cmp	$0, %r9
	jz	end
	jmp	notzero

zeroend:
	movq	$1, %r8
end:
	movq	%r8, %rax
