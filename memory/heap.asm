;Describes a free block of memory. Linked list. container_of() == list-1
STRUC block
	.addr: RESQ 1
	.list: RESQ 2
	.size: RESD 1
ENDSTRUC

;Describes a memory block size. Holds linked list of free blocks. sizeof() == 
STRUC block_list
	.head: RESQ 1
	.tail: RESQ 1
	.size: RESD 1
ENDSTRUC

section .text
	global init_heap
	global free_heap
	global inc_heap
	global malloc
	global free

BLOCK_TYPES:	EQU 14
BLOCK_SIZE:	EQU 28		;in bytes

section .data
	blocks DQ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ;should be 35 here
	block_region_addr DQ 0
	block_region_size DQ 0x1000	;number of blocks it can hold
	block_count DQ 0
	heap_start DQ 0
	heap_size DQ 0

;block* alloc_block(void);returns address of block
alloc_block:
	MOV RAX, [block_count]
	CMP RAX, [block_region_size]
	JGE _exit_fail
	ADD QWORD [block_count], 1
	MOV RCX, BLOCK_SIZE
	MUL RCX
	ADD RAX, [block_region_addr]
	RET
_exit_fail:
	XOR RAX, RAX
	RET

;void free_block(block *addr)
free_block:
	SUB RDI, [block_region_addr]
	MOV RAX, RDI
	PUSH RDX
	MOV R15, BLOCK_SIZE
	DIV R15
	POP RDX
	DEC RAX
	CMP RAX, [block_count]
	JE _normal

_normal:
	SUB QWORD [block_count], 1
	XOR RAX, RAX
	RET

;int init_heap(void)
;returns -1 on failure, size of heap on success
;start with one block of size 2^14. Reserve region for allocating more blocks
init_heap:
	;sys_brk
	MOV RAX, 12
	XOR RDI, RDI
	SYSCALL
	CMP RAX, 0
	JL _INIT_HEAP_EXIT
	MOV [heap_start], RAX
_INIT_HEAP_EXIT:
	RET

free_heap:
	MOV RAX, 12
	XOR RDI, RDI
	SYSCALL
	RET

;int inc_heap(unsigned int amount);
inc_heap:
	PUSH RBP
	MOV RBP, RSP
	;; sys_brk
	MOV RDI, [heap_start]
	ADD RDI, [heap_size]
	ADD RDI, [RBP + 16]
	MOV RAX, 12
	SYSCALL
	CMP RAX, 0
	JL _INC_HEAP_EXIT
	MOV [heap_size], RDI
_INC_HEAP_EXIT:
	MOV RSP, RBP
	POP RBP
	RET
