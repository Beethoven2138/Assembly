section .text
	global _sort

;void sort(int *num, int len)
;len at EBP + 12
;num at EBP + 8
;off at EBP + 16
_sort:
	PUSH EBP
	MOV EBP, ESP
	PUSH EBX

	PUSH EDI
	PUSH ESI

	SUB DWORD [EBP + 12], 2
	MOV EDX, 0
	MOV EDI, [EBP + 8] 	;mov edi, num

	CMP EDX, [EBP + 12]	;off < len
	JG _exit

_while_loop:
_for_loop:
	MOV ECX, [EBP + 12]	;i = len
	INC ECX			;++i
_for_test:
	CMP ECX, EDX	;i > off
	JLE _while_cmp
_for_body:
	LEA EBX, [EDI + ECX * 4] ;EBX = num + i * 4
	MOV EAX, [EBX]		 ;EAX = num[i]
	CMP EAX, [EBX - 4]	 ;if (num[i] < num[i-1])
	JGE _for_end
	PUSH DWORD [EBX]	;PUSH num[i]
	MOV DWORD EAX, [EBX - 4]
	MOV DWORD [EBX], EAX		;num[i] = num[i-1]
	POP EAX			;EAX = num[i] (old)
	MOV [EBX - 4], EAX	;num[i-1] = num[i]
_for_end:
	DEC ECX			;--i
	JMP _for_test

_while_cmp:
	INC EDX			;++off
	CMP EDX, [EBP + 12]	;off < len
	JLE _while_loop

_exit:
	POP ESI
	POP EDI
	MOV ESP, EBP
	POP EBP
	RET
