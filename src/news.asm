; news.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern have_cmd
extern printf
extern run_cmd_capture
extern stderr
extern strncmp
extern strstr
; NASM assembly - converted from C: src/news.c
%use smartalign
section .text
section .rodata
LC0:
	db "curl", 0
section .rodata
LC1:
	db "\033[1;31m[-] curl is required to fetch Arch news.\n\033[0m", 0
LC2:
	db "curl -fsSL --max-time 20 -- 'https://archlinux.org/feeds/news/'", 0
LC3:
	db "\033[1;31m[-] Could not download Arch news feed.\n\033[0m", 0
LC4:
	db "\033[1;36m>>> Recent Arch Linux news\n\033[0m", 0
section .rodata
LC5:
	db "<item>", 0
LC6:
	db "</item>", 0
LC7:
	db "<title>", 0
LC8:
	db "<![CDATA[", 0
LC9:
	db "</title>", 0
LC10:
	db "&amp;", 0
LC11:
	db "&lt;", 0
LC12:
	db "&gt;", 0
LC13:
	db "&quot;", 0
LC14:
	db "&apos;", 0
LC15:
	db "&#39;", 0
LC16:
	db "  %d. %s\n", 0
section .rodata
LC17:
	db "\033[1;31m[-] News feed contained no items.\n\033[0m", 0
global cmd_news_v2
cmd_news_v2:
	push	r15
	mov	edi, LC0
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 536
	mov	qword [rsp+8], 0
	call	have_cmd
	test	eax, eax
	je	.L54
	lea	rsi, [rsp+8]
	mov	edi, LC2
	call	run_cmd_capture
	mov	r13d, eax
	test	eax, eax
	jne	.L4
	mov	rax, qword [rsp+8]
	test	rax, rax
	je	.L4
	cmp	byte [rax], 0
	je	.L4
	mov	edi, LC4
	xor	eax, eax
	lea	r14, [rsp+16]
	call	printf
	mov	r15, qword [rsp+8]
.L29:
	mov	esi, LC5
	mov	rdi, r15
	call	strstr
	mov	rbx, rax
	test	rax, rax
	je	.L7
	mov	esi, LC6
	mov	rdi, rax
	call	strstr
	mov	rbp, rax
	test	rax, rax
	je	.L7
	mov	rdi, rbx
	mov	esi, LC7
	lea	r15, [rbp+7]
	call	strstr
	mov	rbx, rax
	test	rax, rax
	je	.L29
	cmp	rbp, rax
	jb	.L29
	lea	r12, [rax+7]
	mov	esi, LC8
	mov	edx, 9
	add	rbx, 16
	mov	rdi, r12
	call	strncmp
	mov	esi, LC9
	test	eax, eax
	cmove	r12, rbx
	mov	rdi, r12
	call	strstr
	test	rax, rax
	je	.L29
	cmp	rbp, rax
	jb	.L29
	lea	rdx, [r12+3]
	cmp	rax, rdx
	jb	.L10
	cmp	byte [rax-3], 93
	lea	rdx, [rax-3]
	je	.L55
.L10:
	sub	rax, r12
	mov	edx, 511
	mov	rdi, r14
	cmp	rax, rdx
	cmova	rax, rdx
	mov	r8d, eax
	cmp	eax, 8
	jb	.L12
	mov	ecx, eax
	mov	rsi, r12
	shr	ecx, 3
	rep movsq
	mov	r12, rsi
.L12:
	xor	edx, edx
	test	r8b, 4
	je	.L13
	mov	edx, dword [r12]
	mov	dword [rdi], edx
	mov	edx, 4
.L13:
	test	r8b, 2
	je	.L14
	movzx	ecx, word [r12+rdx]
	mov	word [rdi+rdx], cx
	add	rdx, 2
.L14:
	and	r8d, 1
	je	.L15
	movzx	ecx, byte [r12+rdx]
	mov	byte [rdi+rdx], cl
.L15:
	mov	byte [rsp+16+rax], 0
	movzx	ebx, byte [rsp+16]
	mov	r12, r14
	test	bl, bl
	je	.L16
	mov	rbp, r14
	jmp	.L24
.L17:
	add	rbp, 1
.L19:
	mov	byte [r12-1], bl
	movzx	ebx, byte [rbp+0]
	test	bl, bl
	je	.L16
.L24:
	add	r12, 1
	cmp	bl, 38
	jne	.L17
	mov	edx, 5
	mov	esi, LC10
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	je	.L56
	mov	edx, 4
	mov	esi, LC11
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	je	.L57
	mov	edx, 4
	mov	esi, LC12
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	je	.L58
	mov	edx, 6
	mov	esi, LC13
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	je	.L59
	mov	edx, 6
	mov	esi, LC14
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	je	.L60
	mov	edx, 5
	mov	esi, LC15
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L17
	add	rbp, 5
	mov	ebx, 39
	jmp	.L19
.L4:
	mov	edi, LC3
	mov	edx, 50
	mov	esi, 1
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	rdi, qword [rsp+8]
	call	free
.L3:
	xor	eax, eax
.L1:
	add	rsp, 536
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L16:
	mov	byte [r12], 0
	add	r13d, 1
	xor	eax, eax
	mov	rdx, r14
	mov	esi, r13d
	mov	edi, LC16
	call	printf
	cmp	r13d, 10
	jne	.L29
	mov	rdi, qword [rsp+8]
	call	free
.L28:
	mov	eax, 1
	jmp	.L1
.L56:
	add	rbp, 5
	jmp	.L19
.L57:
	add	rbp, 4
	mov	ebx, 60
	jmp	.L19
.L54:
	mov	edx, 52
	mov	esi, 1
	mov	edi, LC1
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L3
.L58:
	add	rbp, 4
	mov	ebx, 62
	jmp	.L19
.L59:
	add	rbp, 6
	mov	ebx, 34
	jmp	.L19
.L55:
	cmp	byte [rax-2], 93
	jne	.L10
	cmp	byte [rax-1], 62
	cmove	rax, rdx
	jmp	.L10
.L60:
	add	rbp, 6
	mov	ebx, 39
	jmp	.L19
.L7:
	mov	rdi, qword [rsp+8]
	call	free
	test	r13d, r13d
	jne	.L28
	mov	edx, 45
	mov	esi, 1
	mov	edi, LC17
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L3
