section .data
	text db "Hello World",10
	else db "Innequality",10
section .text
	global _start
_start:
	mov rax, 5
	mov rbx, 4
	add rbx, 2

	;; comparison
	cmp rax, rbx
	je _print
	
	call _else

	mov rax, 60
	mov rdi, 0
	syscall

_print:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 12
	syscall

	mov rax, 60
	mov rdi, 0
	syscall

_else:
	mov rax, 1
	mov rdi, 1
	mov rsi, else
	mov rdx, 12
	syscall
	ret
