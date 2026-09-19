; search.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern free
extern printf
extern puts
extern run_cmd_capture
extern stderr
extern stdout
extern strlen
extern xsnprintf
; NASM assembly - converted from C: src/search.c
%use smartalign
section .text
section .rodata
LC0:
	db "", 0
LC1:
	db "?", 0
section .rodata
LC2:
	db "\033[1;31m[-] Invalid search query: '%s'\n\033[0m", 0
section .rodata
LC3:
	db "\033[1;36m>>> Repositories\n\033[0m", 0
LC4:
	db "pacman -Ss -- %s", 0
LC5:
	db "    (no repository matches)", 0
LC6:
	db "\033[1;36m>>> AUR\n\033[0m", 0
LC7:
	db "    (no AUR matches)", 0
LC8:
	db "aur/%s %s", 0
LC9:
	db " (%ld votes)", 0
LC10:
	db "    %s\n", 0
LC11:
	db "\033[1;33m[!] AUR RPC: %s\n\033[0m", 0
global cmd_search_v2
cmd_search_v2:
	push	r15
	pxor	xmm0, xmm0
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 1144
	mov	qword [rsp+24], 0
	movaps	oword [rsp+48], xmm0
	movaps	oword [rsp+64], xmm0
	movaps	oword [rsp+80], xmm0
	movaps	oword [rsp+96], xmm0
	movaps	oword [rsp+112], xmm0
	movaps	oword [rsp+128], xmm0
	movaps	oword [rsp+144], xmm0
	movaps	oword [rsp+160], xmm0
	movaps	oword [rsp+176], xmm0
	movaps	oword [rsp+192], xmm0
	movaps	oword [rsp+208], xmm0
	movaps	oword [rsp+224], xmm0
	movaps	oword [rsp+240], xmm0
	movaps	oword [rsp+256], xmm0
	movaps	oword [rsp+272], xmm0
	movaps	oword [rsp+288], xmm0
	movaps	oword [rsp+32], xmm0
	call	valid_search_query
	test	eax, eax
	jne	.L2
	test	rbx, rbx
	mov	eax, LC0
	mov	esi, LC2
	mov	rdi, qword [rel stderr]
	cmove	rbx, rax
	xor	eax, eax
	mov	rdx, rbx
	call	fprintf
.L4:
	xor	r15d, r15d
.L1:
	add	rsp, 1144
	mov	eax, r15d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L2:
	lea	rbp, [rsp+304]
	mov	edx, 320
	mov	rdi, rbx
	mov	rsi, rbp
	call	shell_quote
	test	eax, eax
	je	.L4
	mov	edi, LC3
	xor	eax, eax
	lea	r12, [rsp+624]
	call	printf
	mov	esi, 512
	mov	rdi, r12
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC4
	call	xsnprintf
	lea	rsi, [rsp+24]
	mov	rdi, r12
	call	run_cmd_capture
	test	eax, eax
	jne	.L7
	mov	rdi, qword [rsp+24]
	test	rdi, rdi
	je	.L7
	cmp	byte [rdi], 0
	jne	.L33
.L7:
	mov	edi, LC5
	xor	r15d, r15d
	call	puts
	mov	rdi, qword [rsp+24]
.L8:
	call	free
	mov	edi, LC6
	xor	eax, eax
	lea	rbp, [rsp+48]
	call	printf
	lea	r13, [rsp+32]
	call	config_current
	mov	rcx, rbp
	mov	rdx, r13
	mov	rsi, rbx
	lea	rdi, [rax+20]
	mov	r8d, 256
	call	aur_rpc_search
	test	eax, eax
	je	.L9
	xor	r12d, r12d
	xor	ebp, ebp
	cmp	qword [rsp+40], 0
	mov	r14d, LC0
	jne	.L10
	jmp	.L34
.L14:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	mov	rsi, qword [rbx+24]
	test	rsi, rsi
	je	.L15
	cmp	byte [rsi], 0
	jne	.L35
.L15:
	add	rbp, 1
	add	r12, 152
	cmp	rbp, qword [rsp+40]
	jnb	.L36
.L10:
	mov	rbx, qword [rsp+32]
	mov	eax, LC1
	mov	edi, LC8
	add	rbx, r12
	mov	rdx, qword [rbx+16]
	mov	rsi, qword [rbx]
	test	rdx, rdx
	cmove	rdx, r14
	test	rsi, rsi
	cmove	rsi, rax
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+48]
	test	rsi, rsi
	je	.L14
	mov	edi, LC9
	xor	eax, eax
	call	printf
	jmp	.L14
.L9:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC11
	xor	eax, eax
	call	fprintf
.L11:
	mov	rdi, r13
	call	aur_response_destroy
	jmp	.L1
.L35:
	mov	edi, LC10
	xor	eax, eax
	call	printf
	jmp	.L15
.L36:
	mov	r15d, 1
	jmp	.L11
.L34:
	mov	edi, LC7
	call	puts
	jmp	.L11
.L33:
	mov	rsi, qword [rel stdout]
	mov	r15d, 1
	call	fputs
	mov	rdi, qword [rsp+24]
	mov	qword [rsp+8], rdi
	call	strlen
	mov	rdi, qword [rsp+8]
	cmp	byte [rdi-1+rax], 10
	je	.L8
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	mov	rdi, qword [rsp+24]
	jmp	.L8
