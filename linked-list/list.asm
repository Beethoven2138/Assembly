STRUC list_head
	.next: RESQ 1
	.prev: RESQ 1
	.size:
ENDSTRUC

section .text
	global init_list
	global list_add
	global list_del

;void init_list(struct *list_head)
init_list:
	PUSH RBP
	MOV RBP, RSP

	MOV QWORD [RDI + list_head.next], 0
	MOV QWORD [RDI + list_head.prev], 0

	MOV RSP, RBP
	POP RBP
	RET

;void list_add(struct list_head *new, struct list_head *head)
;RDI: new, RSI: head
list_add:
	PUSH RBP
	MOV RBP, RSP

	MOV RAX, [RSI + list_head.next] ;list_head *RAX = head->next
	MOV [RDI + list_head.next], RAX ;new->next = head->next
	MOV [RDI + list_head.prev], RSI ;new->prev = head
	CMP RAX, 0
	JE _skip
	MOV [RAX + list_head.prev], RDI ;head->next->prev = new
_skip:	
	MOV [RSI + list_head.next], RDI

	MOV RSP, RBP
	POP RBP
	RET

;static void __list_del(struct list_head *prev, struct list_head *next);
;RAX = prev, RBX = 
__list_del:
	
	RET

;void list_del(struct list_head *entry)
;RDI: entry
list_del:
	MOV RAX, [RDI + list_head.prev]
	MOV RCX, [RDI + list_head.next]
	CMP RCX, 0
	JE _next
	MOV [RCX + list_head.prev], RAX
_next:	
	CMP RAX, 0
	JE _exit
	MOV [RAX + list_head.next], RCX
_exit:	
	RET
