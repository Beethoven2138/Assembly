section .data
	text1 db "What is your name? "
	text2 db "Hello "

section .bss
	name resb 16
	
section .text	
	global _start

_start:
	call _showtext1

	call _getname

	call _showtext2

	call _showname

	mov rax, 60
	mov rdi, 0
	syscall

_showtext1:
	mov rax, 1
	mov rdi, 1
	mov rsi, text1
	mov rdx, 19
	syscall
	ret


_showtext2:
	mov rax, 1
	mov rdi, 1
	mov rsi, text2
	mov rdx, 6
	syscall
	ret

_getname:
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 16
	syscall
	ret

_showname:
	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 16
	syscall
	ret
