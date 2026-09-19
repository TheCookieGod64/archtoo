; review.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern file_exists
extern fprintf
extern fwrite
extern printf
extern run_cmd
extern stderr
extern strchr
extern xsnprintf
; NASM assembly - converted from C: src/review.c
%use smartalign
section .text
section .rodata
LC0:
	db "\033[1;31m[-] Review requires a directory.\n\033[0m", 0
LC1:
	db "\033[1;31m[-] Directory does not exist: %s\n\033[0m", 0
section .rodata
LC2:
	db "%s/PKGBUILD", 0
section .rodata
LC3:
	db "\033[1;31m[-] No PKGBUILD in %s\n\033[0m", 0
section .rodata
LC4:
	db "%s/.git", 0
section .rodata
LC5:
	db "\033[1;36m>>> git diff (PKGBUILD / .SRCINFO)\n\033[0m", 0
LC6:
	db "git -C %s diff -- PKGBUILD .SRCINFO", 0
section .rodata
LC7:
	db "%s/.SRCINFO", 0
LC8:
	db "\033[1;36m>>> .SRCINFO\n\033[0m", 0
LC9:
	db "sed -n '1,120p' %s/.SRCINFO", 0
LC10:
	db "\033[1;36m>>> PKGBUILD\n\033[0m", 0
LC11:
	db "sed -n '1,240p' %s/PKGBUILD", 0
global cmd_review_v2
cmd_review_v2:
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 6680
	test	rdi, rdi
	je	.L2
	cmp	byte [rdi], 0
	mov	rbx, rdi
	je	.L2
	mov	esi, 10
	call	strchr
	test	rax, rax
	je	.L26
.L4:
	xor	eax, eax
.L1:
	add	rsp, 6680
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L26:
	mov	esi, 13
	mov	rdi, rbx
	call	strchr
	test	rax, rax
	jne	.L4
	mov	rdi, rbx
	call	dir_exists
	test	eax, eax
	je	.L27
	xor	eax, eax
	mov	rcx, rbx
	mov	edx, LC2
	mov	esi, 1200
	lea	rbp, [rsp+1024]
	mov	rdi, rbp
	call	xsnprintf
	mov	rdi, rbp
	call	file_exists
	test	eax, eax
	je	.L28
	mov	edx, 1024
	mov	rsi, rsp
	mov	rdi, rbx
	mov	rbp, rsp
	call	shell_quote
	test	eax, eax
	je	.L4
	mov	rcx, rbx
	mov	edx, LC4
	mov	esi, 1200
	xor	eax, eax
	lea	r12, [rsp+3424]
	mov	rdi, r12
	call	xsnprintf
	mov	rdi, r12
	lea	r12, [rsp+4624]
	call	dir_exists
	test	eax, eax
	jne	.L29
.L10:
	xor	eax, eax
	mov	rcx, rbx
	mov	edx, LC7
	mov	esi, 1200
	lea	r13, [rsp+2224]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	jne	.L30
.L11:
	mov	edi, LC10
	xor	eax, eax
	call	printf
	mov	rcx, rbp
	mov	edx, LC11
	mov	rdi, r12
	mov	esi, 2048
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L1
.L2:
	mov	edx, 44
	mov	esi, 1
	mov	edi, LC0
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L4
.L28:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC3
	call	fprintf
	jmp	.L4
.L27:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC1
	call	fprintf
	jmp	.L4
.L30:
	mov	edi, LC8
	xor	eax, eax
	call	printf
	mov	rdi, r12
	mov	rcx, rbp
	mov	edx, LC9
	mov	esi, 2048
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	jmp	.L11
.L29:
	mov	edi, LC5
	xor	eax, eax
	call	printf
	mov	rdi, r12
	mov	rcx, rsp
	mov	edx, LC6
	mov	esi, 2048
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	jmp	.L10
