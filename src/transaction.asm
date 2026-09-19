; transaction.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern printf
extern stderr
; NASM assembly - converted from C: src/transaction.c
%use smartalign
section .text
section .rodata
LC0:
	db "/var/lib/pacman/db.lck", 0
section .rodata
LC1:
	db "\033[1;31m[-] pacman database is locked (/var/lib/pacman/db.lck).\n    Another pacman/emerge transaction is running, or a previous\n    one was interrupted. Remove the lock only if you are sure\n    nothing else is using pacman.\n\033[0m", 0
LC2:
	db "\033[1;32m[+] pacman database is not locked.\n\033[0m", 0
global cmd_transaction_check_v2
cmd_transaction_check_v2:
	sub	rsp, 8
	mov	edi, LC0
	call	file_exists
	test	eax, eax
	jne	.L6
	mov	edi, LC2
	xor	eax, eax
	call	printf
	mov	eax, 1
	add	rsp, 8
	ret
.L6:
	mov	edx, 227
	mov	esi, 1
	mov	edi, LC1
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	add	rsp, 8
	ret
