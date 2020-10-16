.text

.globl gcd
gcd:
.globl main
main:
	movq 	%rdi, %r8
	movq 	%rsi, %r9

while:
	cmp 	%r9, %r8
	jz	end
	cmp	%r9, %r8
	jle	else
	jmp	if

if:
	sub	%r9, %r8
	jmp	while

else:
	sub	%r8, %r9
	jmp	while

end:
	movq 	%r8, %rax
	ret
