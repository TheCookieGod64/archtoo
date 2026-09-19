; orphans.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern printf
extern puts
extern run_cmd_capture
extern stderr
extern stdout
extern strlen
; NASM assembly - converted from C: src/orphans.c
%use smartalign
section .text
section .rodata
LC0:
	db "pacman -Qdtq", 0
LC1:
	db "No orphaned packages.", 0
section .rodata
LC2:
	db "\033[1;31m[-] Could not query orphaned packages.\n\033[0m", 0
LC3:
	db "\033[1;36m>>> Orphaned dependencies (installed as deps, required by none)\n\033[0m", 0
global cmd_orphans_v2
cmd_orphans_v2:
	push	rbx
	mov	edi, LC0
	sub	rsp, 16
	mov	qword [rsp+8], 0
	lea	rsi, [rsp+8]
	call	run_cmd_capture
	cmp	eax, 1
	ja	.L2
	mov	rdx, qword [rsp+8]
	test	rdx, rdx
	je	.L3
	cmp	byte [rdx], 0
	je	.L3
	test	eax, eax
	jne	.L2
	mov	edi, LC3
	xor	eax, eax
	call	printf
	mov	rsi, qword [rel stdout]
	mov	rdi, qword [rsp+8]
	call	fputs
	mov	rbx, qword [rsp+8]
	mov	rdi, rbx
	call	strlen
	cmp	byte [rbx-1+rax], 10
	jne	.L14
	mov	rdi, rbx
	call	free
	jmp	.L5
.L3:
	mov	edi, LC1
	call	puts
	mov	rdi, qword [rsp+8]
	call	free
.L5:
	add	rsp, 16
	mov	eax, 1
	pop	rbx
	ret
.L2:
	mov	edx, 50
	mov	esi, 1
	mov	edi, LC2
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	rdi, qword [rsp+8]
	call	free
	add	rsp, 16
	xor	eax, eax
	pop	rbx
	ret
.L14:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	mov	rbx, qword [rsp+8]
	mov	rdi, rbx
	call	free
	jmp	.L5
