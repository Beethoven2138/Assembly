STD_IN equ 0
STD_OUT equ 1
STD_ERR equ 2

SYS_IN equ 0
SYS_OUT equ 1
SYS_EXIT equ 60

section .data

  text db "Live Long And Prosper",10
  
section .text

  global _start
  
_start:
  mov rax, SYS_IN
  mov rdi, STD_OUT
  mov rsi, text
  mov rdx, 22
  syscall
  
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
