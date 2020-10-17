.text
.globl gcd
gcd:
	movq 	%rdi, %r8
	movq 	%rsi, %r9

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
	ret
