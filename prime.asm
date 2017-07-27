section .data
	text db "Is prime", 10
section .bss
	primes RESW 1000
	last_prime RESB 8
	digit_space resb 100
	digit_pos resb 8

section .text
	global _start

_start:
	MOV RAX, 2
	MOV [primes], RAX
	MOV RAX, primes
	MOV [last_prime], RAX

	XOR RCX, RCX
	MOV RAX, 2
loop:
	INC RAX
	PUSH RAX
	PUSH RCX
	CALL is_prime
	POP RCX
	CMP RAX, 1
	POP RAX
	JNE loop
	INC RCX
	CMP RCX, 90
	JNE loop

	CALL print_int

	MOV RAX, 60
	XOR RDI, RDI
	SYSCALL

is_prime:
	MOV RCX, primes
prime_loop:
	CMP RCX, [last_prime]
	JG prime
	MOV RDX, 0
	PUSH RAX
	MOV RBX, [RCX]
	DIV RBX
	POP RAX
	ADD RCX, 8		;used to be INC RCX
	CMP RDX, 0
	JE not_prime
	JMP prime_loop
prime:
	MOV [RCX], RAX
	PUSH RAX
	PUSH RCX
	MOV RAX, RCX
	CALL print_int
	POP RCX
	POP RAX
	MOV [last_prime], RCX
	MOV RAX, 1
	RET
not_prime:
	CALL print
	XOR RAX, RAX
	RET

print:
	MOV RAX, 1
	MOV RDI, 1
	MOV RSI, text
	MOV RDX, 9
	SYSCALL
	RET

print_int:
	MOV RCX, digit_space
	MOV RBX, 10
	MOV [RCX], RBX
	inc RCX
	MOV [digit_pos], RCX
print_int_loop:
	MOV RDX, 0
	DIV RBX
	ADD RDX, 48
	MOV RCX, [digit_pos]
	MOV [RCX], DL
	INC RCX
	MOV [digit_pos], RCX
	CMP RAX, 0
	JNE print_int_loop
print_string:
	MOV RCX, [digit_pos]
	MOV RAX, 1
	MOV RDI, 1
	MOV RSI, RCX
	MOV RDX, 1
	SYSCALL
	MOV RCX, [digit_pos]
	DEC RCX
	MOV [digit_pos], RCX
	CMP RCX, digit_space
	JGE print_string
	ret
