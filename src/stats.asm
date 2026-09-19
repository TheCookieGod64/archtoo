; stats.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern printf
extern run_cmd_capture
extern stderr
extern strchr
extern strlen
; NASM assembly - converted from C: src/stats.c
%use smartalign
section .text
count_cmd_lines:
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24
	mov	qword [rsp+8], 0
	lea	rsi, [rsp+8]
	call	run_cmd_capture
	mov	r12, qword [rsp+8]
	cmp	eax, 1
	ja	.L30
	xor	ebp, ebp
	test	r12, r12
	je	.L4
	cmp	byte [r12], 0
	je	.L4
	mov	rbx, r12
.L11:
	mov	esi, 10
	mov	rdi, rbx
	call	strchr
	mov	r13, rax
	test	rax, rax
	je	.L5
	sub	rax, rbx
	je	.L7
.L6:
	mov	rdx, rbx
	add	rax, rbx
.L10:
	movzx	ecx, byte [rdx]
	mov	esi, ecx
	and	esi, -5
	cmp	sil, 9
	je	.L15
	cmp	cl, 32
	jne	.L8
.L15:
	add	rdx, 1
	cmp	rax, rdx
	jne	.L10
.L12:
	test	r13, r13
	je	.L4
.L7:
	cmp	byte [r13+1], 0
	lea	rbx, [r13+1]
	jne	.L11
.L4:
	mov	rdi, r12
	call	free
.L1:
	add	rsp, 24
	mov	rax, rbp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L8:
	add	rbp, 1
	jmp	.L12
.L5:
	mov	rdi, rbx
	call	strlen
	test	rax, rax
	jne	.L6
	jmp	.L4
.L30:
	mov	rdi, r12
	mov	rbp, -1
	call	free
	jmp	.L1
section .rodata
LC0:
	db "pacman -Qq", 0
LC1:
	db "pacman -Qmq", 0
LC2:
	db "pacman -Qeq", 0
LC3:
	db "pacman -Qdtq", 0
section .rodata
LC4:
	db "\033[1;31m[-] Could not query pacman package lists.\n\033[0m", 0
section .rodata
LC5:
	db "r", 0
LC6:
	db "/usr/local/emerge/world", 0
LC7:
	db "3.0.0", 0
LC8:
	db "Archtoo Emerge Engine", 0
LC9:
	db "\033[1;36m%s v%s\n\033[0m", 0
LC10:
	db "Installed packages : %ld\n", 0
LC11:
	db "Explicit packages  : %ld\n", 0
LC12:
	db "Foreign packages   : %ld\n", 0
LC13:
	db "Orphaned packages  : %ld\n", 0
LC14:
	db " entries     : %ld\n", 0
global cmd_stats_v2
cmd_stats_v2:
	push	r15
	mov	edi, LC0
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 280
	call	count_cmd_lines
	mov	edi, LC1
	mov	r15, rax
	call	count_cmd_lines
	mov	edi, LC2
	mov	r14, rax
	call	count_cmd_lines
	mov	edi, LC3
	mov	qword [rsp], rax
	mov	rbx, rax
	call	count_cmd_lines
	cmp	r15, -1
	sete	dl
	cmp	r14, -1
	sete	cl
	or	dl, cl
	jne	.L44
	cmp	rbx, -1
	je	.L44
	xor	edx, edx
	test	rax, rax
	mov	esi, LC5
	mov	edi, LC6
	cmovns	rdx, rax
	xor	ebx, ebx
	mov	qword [rsp+8], rdx
	call	fopen
	mov	r12, rax
	test	rax, rax
	je	.L36
	movabs	r13, -34359739394
	lea	rbp, [rsp+16]
.L35:
	mov	rdx, r12
	mov	esi, 256
	mov	rdi, rbp
	call	fgets
	test	rax, rax
	je	.L39
	movzx	ecx, byte [rsp+16]
	cmp	cl, 32
	je	.L43
	cmp	cl, 9
	jne	.L40
.L43:
	mov	rax, rbp
.L45:
	movzx	ecx, byte [rax+1]
	add	rax, 1
	cmp	cl, 32
	je	.L45
	cmp	cl, 9
	je	.L45
.L40:
	mov	rax, r13
	mov	edx, 1
	sar	rax, cl
	and	eax, 1
	cmp	cl, 36
	cmovnb	rax, rdx
	add	rbx, rax
	jmp	.L35
.L39:
	mov	rdi, r12
	call	fclose
.L36:
	mov	edx, LC7
	mov	esi, LC8
	mov	edi, LC9
	xor	eax, eax
	call	printf
	mov	rsi, r15
	mov	edi, LC10
	xor	eax, eax
	call	printf
	mov	rsi, qword [rsp]
	mov	edi, LC11
	xor	eax, eax
	call	printf
	mov	rsi, r14
	mov	edi, LC12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rsp+8]
	mov	edi, LC13
	xor	eax, eax
	call	printf
	mov	rsi, rbx
	mov	edi, LC14
	xor	eax, eax
	call	printf
	mov	eax, 1
.L31:
	add	rsp, 280
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L44:
	mov	edx, 53
	mov	esi, 1
	mov	edi, LC4
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	jmp	.L31
