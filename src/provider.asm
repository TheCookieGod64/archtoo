; provider.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fprintf
extern free
extern malloc
extern memcpy
extern printf
extern run_cmd_capture
extern stderr
extern strchr
extern strcmp
extern strdup
extern strlen
extern strstr
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/provider.c
%use smartalign
section .text
trim_copy:
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 8
	test	rsi, rsi
	je	.L2
	mov	rbx, rsi
	call	__ctype_b_loc
	mov	rdx, qword [rax]
	jmp	.L3
.L4:
	add	rbp, 1
	sub	rbx, 1
	je	.L2
.L3:
	movzx	eax, byte [rbp+0]
	test	byte [rdx+1+rax*2], 32
	jne	.L4
	jmp	.L6
.L9:
	mov	rbx, rcx
.L6:
	test	rbx, rbx
	je	.L8
	call	__ctype_b_loc
	movzx	edx, byte [rbp-1+rbx]
	lea	rcx, [rbx-1]
	mov	rax, qword [rax]
	test	byte [rax+1+rdx*2], 32
	jne	.L9
	lea	rdi, [rbx+1]
	jmp	.L5
.L2:
	xor	ebx, ebx
	mov	edi, 1
.L5:
	call	malloc
	mov	rcx, rax
	test	rax, rax
	je	.L1
	mov	rdx, rbx
	mov	rsi, rbp
	mov	rdi, rax
	call	memcpy
	mov	byte [rax+rbx], 0
	mov	rcx, rax
.L1:
	add	rsp, 8
	mov	rax, rcx
	pop	rbx
	pop	rbp
	ret
.L8:
	mov	edi, 1
	jmp	.L5
section .rodata
LC0:
	db "(package)", 0
LC1:
	db "(provides)", 0
LC2:
	db "", 0
LC3:
	db "repo", 0
LC4:
	db "pacman -Ssq -- %s", 0
LC5:
	db "\nRepository", 0
LC6:
	db "Repository", 0
LC7:
	db "\nName", 0
LC8:
	db "\nVersion", 0
LC9:
	db "\nProvides", 0
LC10:
	db "None", 0
LC11:
	db " \t", 0
LC12:
	db "%s/%s %s  %s\n", 0
print_repo_providers:
	push	r15
	mov	edx, 320
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 5464
	lea	rbx, [rsp+80]
	mov	qword [rsp+8], rdi
	mov	qword [rsp+56], 0
	mov	rsi, rbx
	mov	qword [rsp+64], 0
	call	shell_quote
	test	eax, eax
	jne	.L198
.L23:
	xor	r13d, r13d
.L21:
	add	rsp, 5464
	mov	eax, r13d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L198:
	mov	rcx, rbx
	mov	edx, LC4
	mov	esi, 4096
	xor	eax, eax
	lea	r13, [rsp+1360]
	mov	rdi, r13
	call	xsnprintf
	lea	rsi, [rsp+56]
	mov	rdi, r13
	call	run_cmd_capture
	mov	r12, qword [rsp+56]
	test	r12, r12
	je	.L23
	xor	ebp, ebp
	cmp	byte [r12], 0
	lea	r14, [rsp+400]
	jne	.L31
	jmp	.L199
.L200:
	mov	r15, rax
	sub	r15, r12
	lea	rax, [r15-1]
	cmp	rax, 158
	jbe	.L27
.L87:
	cmp	byte [rbx+1], 0
	lea	r12, [rbx+1]
	je	.L29
	mov	r15, rbp
.L28:
	mov	rbp, r15
.L31:
	mov	esi, 10
	mov	rdi, r12
	call	strchr
	mov	rbx, rax
	test	rax, rax
	jne	.L200
	mov	rdi, r12
	call	strlen
	mov	rbx, rax
	lea	rax, [rax-1]
	cmp	rax, 158
	jbe	.L201
.L29:
	mov	r15, rbp
.L94:
	mov	rdi, qword [rsp+56]
	call	free
	test	r15, r15
	je	.L23
.L92:
	lea	rbx, [rsp+720]
	lea	r14, [rsp+400]
	movabs	rax, 3251720295687610736
	mov	qword [rsp+1360], rax
	lea	rbp, [rbx+r15*8]
	mov	r12, rbx
	movabs	rax, 12715991181241632
	mov	qword [rsp+1366], rax
	mov	r15d, 13
	jmp	.L44
.L204:
	test	al, 4
	jne	.L202
	test	eax, eax
	je	.L40
	movzx	esi, byte [r14]
	mov	byte [rcx], sil
	test	al, 2
	jne	.L203
.L40:
	mov	byte [rsp+1360+rdx], 0
	mov	r15, rdx
.L36:
	add	r12, 8
	cmp	rbp, r12
	je	.L43
.L44:
	mov	rdi, qword [r12]
	test	rdi, rdi
	je	.L36
	mov	edx, 320
	mov	rsi, r14
	call	shell_quote
	test	eax, eax
	je	.L36
	mov	rdi, r14
	call	strlen
	lea	rcx, [r15+1]
	lea	rdx, [rax+rcx]
	cmp	rdx, 4095
	ja	.L43
	mov	byte [rsp+1360+r15], 32
	add	rcx, r13
	cmp	eax, 8
	jb	.L204
	mov	rsi, qword [r14]
	mov	qword [rcx], rsi
	mov	esi, eax
	mov	rdi, qword [r14-8+rsi]
	mov	qword [rcx-8+rsi], rdi
	lea	rdi, [rcx+8]
	mov	rsi, r14
	and	rdi, -8
	sub	rcx, rdi
	sub	rsi, rcx
	add	ecx, eax
	mov	eax, ecx
	shr	eax, 3
	mov	ecx, eax
	rep movsq
	jmp	.L40
.L27:
	mov	rdi, r14
	mov	rdx, r15
	mov	rsi, r12
	call	memcpy
	mov	rdi, r14
	mov	byte [rsp+400+r15], 0
	call	valid_pkgname
	test	eax, eax
	je	.L87
	mov	rdi, r14
	lea	r15, [rbp+1]
	lea	r12, [rbx+1]
	call	strdup
	cmp	byte [rbx+1], 0
	mov	qword [rsp+720+rbp*8], rax
	je	.L94
	cmp	r15, 80
	jne	.L28
.L195:
	mov	rdi, qword [rsp+56]
	call	free
	jmp	.L92
.L201:
	lea	rax, [rsp+400]
	mov	rdx, rbx
	mov	rsi, r12
	mov	rdi, rax
	mov	r14, rax
	mov	qword [rsp+24], rax
	call	memcpy
	mov	byte [rsp+400+rbx], 0
	mov	rdi, r14
	call	valid_pkgname
	test	eax, eax
	je	.L29
	mov	rdi, qword [rsp+24]
	lea	r15, [rbp+1]
	call	strdup
	mov	qword [rsp+720+rbp*8], rax
	jmp	.L195
.L43:
	mov	rdi, r13
	lea	rsi, [rsp+64]
	call	run_cmd_capture
	mov	r14, qword [rsp+64]
	mov	r13d, eax
	test	eax, eax
	je	.L205
	xor	r13d, r13d
.L45:
	mov	rdi, r14
	call	free
.L81:
	mov	rdi, qword [rbx]
	add	rbx, 8
	call	free
	cmp	rbp, rbx
	jne	.L81
	jmp	.L21
.L205:
	test	r14, r14
	je	.L45
	cmp	byte [r14], 0
	je	.L45
	mov	dword [rsp+44], 0
	jmp	.L80
.L209:
	test	r12b, r12b
	je	.L65
	mov	rdi, qword [rsp+24]
	mov	esi, 58
	call	strchr
	mov	rdx, rax
	cmp	rax, r15
	jnb	.L65
	mov	dword [rsp+40], 0
	test	rax, rax
	je	.L65
.L82:
	mov	rdi, rdx
	mov	esi, 10
	mov	qword [rsp+24], rdx
	call	strchr
	mov	rdx, qword [rsp+24]
	lea	r15, [rdx+1]
	test	rax, rax
	je	.L70
	sub	rax, rdx
	lea	rsi, [rax-1]
.L71:
	mov	rdi, r15
	call	trim_copy
	mov	r12, rax
	test	rax, rax
	je	.L72
	mov	esi, LC10
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	jne	.L206
.L72:
	mov	rdi, r12
	call	free
	test	r14, r14
	je	.L65
	mov	eax, dword [rsp+40]
	test	eax, eax
	je	.L65
.L116:
	mov	r8d, LC0
.L69:
	mov	rax, qword [rsp+16]
	mov	ecx, LC2
	mov	esi, LC3
	test	rax, rax
	cmovne	rcx, rax
	mov	rax, qword [rsp+32]
	test	rax, rax
	je	.L78
	cmp	byte [rax], 0
	cmovne	rsi, rax
.L78:
	mov	rdx, r14
	mov	edi, LC12
	xor	eax, eax
	call	printf
	mov	dword [rsp+44], 1
.L65:
	mov	rdi, r14
	call	free
	mov	rdi, qword [rsp+16]
	call	free
	mov	rdi, qword [rsp+32]
	call	free
	test	r13, r13
	je	.L197
	cmp	byte [r13+1], 0
	lea	r14, [r13+1]
	je	.L197
.L80:
	mov	esi, LC5
	mov	rdi, r14
	call	strstr
	mov	r13, rax
	cmp	rax, r14
	je	.L207
	mov	r15, r13
	test	r13, r13
	je	.L208
.L47:
	mov	esi, LC6
	mov	rdi, r14
	call	strstr
	mov	esi, LC7
	mov	rdi, r14
	mov	qword [rsp+32], rax
	call	strstr
	mov	esi, LC8
	mov	rdi, r14
	mov	qword [rsp+16], rax
	call	strstr
	mov	esi, LC9
	mov	rdi, r14
	mov	r12, rax
	call	strstr
	mov	rdx, qword [rsp+32]
	mov	qword [rsp+24], rax
	test	rdx, rdx
	je	.L100
	cmp	rdx, r15
	jnb	.L100
	mov	esi, 58
	mov	rdi, rdx
	call	strchr
	mov	r14, rax
	test	rax, rax
	je	.L100
	cmp	rax, r15
	jnb	.L100
	mov	rdi, rax
	mov	esi, 10
	call	strchr
	lea	rdi, [r14+1]
	test	rax, rax
	je	.L49
	sub	rax, r14
	lea	rsi, [rax-1]
.L50:
	call	trim_copy
	mov	qword [rsp+32], rax
.L48:
	test	r12, r12
	setne	dl
	cmp	r12, r15
	setb	al
	and	edx, eax
	mov	rax, qword [rsp+16]
	mov	byte [rsp+40], dl
	test	rax, rax
	je	.L112
	cmp	rax, r15
	jnb	.L112
	mov	rdi, rax
	mov	esi, 58
	call	strchr
	mov	r14, rax
	test	rax, rax
	je	.L112
	cmp	rax, r15
	jnb	.L112
	mov	rdi, rax
	mov	esi, 10
	call	strchr
	lea	rdi, [r14+1]
	test	rax, rax
	je	.L57
	sub	rax, r14
	lea	rsi, [rax-1]
.L58:
	call	trim_copy
	cmp	byte [rsp+40], 0
	mov	qword [rsp+16], 0
	mov	r14, rax
	je	.L59
	mov	esi, 58
	mov	rdi, r12
	call	strchr
	mov	rdx, rax
	test	rax, rax
	je	.L102
	cmp	rax, r15
	jb	.L84
.L102:
	mov	qword [rsp+16], 0
.L59:
	mov	rax, qword [rsp+24]
	test	rax, rax
	setne	dl
	cmp	rax, r15
	setb	al
	and	edx, eax
	mov	r12d, edx
	test	r14, r14
	je	.L54
	mov	rsi, qword [rsp+8]
	mov	rdi, r14
	call	strcmp
	test	eax, eax
	jne	.L209
	test	r12b, r12b
	je	.L116
	mov	rdi, qword [rsp+24]
	mov	esi, 58
	call	strchr
	mov	rdx, rax
	test	rax, rax
	je	.L116
	mov	dword [rsp+40], 1
	cmp	rax, r15
	jb	.L82
	jmp	.L116
.L202:
	mov	esi, dword [r14]
	mov	eax, eax
	mov	dword [rcx], esi
	mov	esi, dword [r14-4+rax]
	mov	dword [rcx-4+rax], esi
	jmp	.L40
.L112:
	cmp	byte [rsp+40], 0
	je	.L115
	mov	esi, 58
	mov	rdi, r12
	call	strchr
	mov	rdx, rax
	test	rax, rax
	je	.L115
	cmp	rax, r15
	jnb	.L115
	xor	r14d, r14d
.L84:
	mov	rdi, rdx
	mov	esi, 10
	mov	qword [rsp+16], rdx
	call	strchr
	mov	rdx, qword [rsp+16]
	lea	r12, [rdx+1]
	test	rax, rax
	je	.L60
	sub	rax, rdx
	lea	rsi, [rax-1]
.L61:
	mov	rdi, r12
	call	trim_copy
	mov	qword [rsp+16], rax
	jmp	.L59
.L100:
	mov	qword [rsp+32], 0
	jmp	.L48
.L115:
	mov	qword [rsp+16], 0
.L54:
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L114
	cmp	rax, r15
	jnb	.L114
	mov	rdi, rax
	mov	esi, 58
	call	strchr
	mov	rdx, rax
	test	rax, rax
	je	.L114
	mov	dword [rsp+40], 0
	xor	r14d, r14d
	cmp	rax, r15
	jb	.L82
.L114:
	xor	r14d, r14d
	jmp	.L65
.L207:
	lea	rdi, [r14+1]
	mov	esi, LC5
	call	strstr
	mov	r13, rax
	mov	r15, r13
	test	r13, r13
	jne	.L47
.L208:
	mov	rdi, r14
	call	strlen
	lea	r15, [r14+rax]
	jmp	.L47
.L197:
	mov	r14, qword [rsp+64]
	mov	r13d, dword [rsp+44]
	jmp	.L45
.L203:
	mov	eax, eax
	movzx	esi, word [r14-2+rax]
	mov	word [rcx-2+rax], si
	jmp	.L40
.L70:
	mov	rdi, r15
	call	strlen
	mov	rsi, rax
	jmp	.L71
.L49:
	mov	qword [rsp+32], rdi
	call	strlen
	mov	rdi, qword [rsp+32]
	mov	rsi, rax
	jmp	.L50
.L60:
	mov	rdi, r12
	call	strlen
	mov	rsi, rax
	jmp	.L61
.L57:
	mov	qword [rsp+16], rdi
	call	strlen
	mov	rdi, qword [rsp+16]
	mov	rsi, rax
	jmp	.L58
.L199:
	mov	rdi, r12
	call	free
	jmp	.L23
.L206:
	lea	r15, [rsp+72]
	mov	rdi, r12
	mov	esi, LC11
	mov	qword [rsp+72], 0
	mov	rdx, r15
	call	strtok_r
	mov	rdi, rax
	test	rax, rax
	je	.L72
	lea	rax, [rsp+400]
	mov	qword [rsp+24], rax
.L76:
	mov	rsi, qword [rsp+24]
	mov	edx, 256
	call	dep_basename
	cmp	byte [rsp+400], 0
	je	.L74
	mov	rsi, qword [rsp+8]
	mov	rdi, qword [rsp+24]
	call	strcmp
	test	eax, eax
	jne	.L74
	mov	rdi, r12
	call	free
	test	r14, r14
	je	.L65
	mov	edx, dword [rsp+40]
	test	edx, edx
	jne	.L116
	mov	r8d, LC1
	jmp	.L69
.L74:
	xor	edi, edi
	mov	rdx, r15
	mov	esi, LC11
	call	strtok_r
	mov	rdi, rax
	test	rax, rax
	jne	.L76
	jmp	.L72
section .rodata
LC13:
	db "?", 0
section .rodata
LC14:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC15:
	db "\033[1;36m>>> Providers of %s\n\033[0m", 0
section .rodata
LC16:
	db "aur/%s %s  %s\n", 0
section .rodata
LC17:
	db "\033[1;33m[!] No providers found for '%s'.\n\033[0m", 0
global cmd_provider_v2
cmd_provider_v2:
	push	r15
	pxor	xmm0, xmm0
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 552
	movaps	oword [rsp+16], xmm0
	movaps	oword [rsp+32], xmm0
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
	call	valid_pkgname
	test	eax, eax
	jne	.L211
	test	rbp, rbp
	mov	eax, LC2
	mov	esi, LC14
	mov	rdi, qword [rel stderr]
	cmove	rbp, rax
	xor	eax, eax
	mov	rdx, rbp
	call	fprintf
.L213:
	mov	dword [rsp+12], 0
.L210:
	mov	eax, dword [rsp+12]
	add	rsp, 552
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L211:
	mov	rsi, rbp
	mov	edi, LC15
	xor	eax, eax
	call	printf
	mov	rdi, rbp
	call	print_repo_providers
	mov	dword [rsp+12], eax
	call	config_current
	lea	rcx, [rsp+32]
	lea	rdx, [rsp+16]
	mov	rsi, rbp
	lea	rdi, [rax+20]
	mov	r8d, 256
	call	aur_rpc_info
	test	eax, eax
	je	.L214
	mov	rcx, qword [rsp+24]
	test	rcx, rcx
	je	.L214
	xor	r12d, r12d
	jmp	.L225
.L244:
	mov	rsi, rbp
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	jne	.L219
	mov	ecx, LC1
	test	r14d, r14d
	jne	.L222
.L220:
	mov	rdx, qword [r15+16]
	mov	rsi, qword [r15]
	mov	eax, LC2
	mov	edi, LC16
	test	rdx, rdx
	cmove	rdx, rax
	test	rsi, rsi
	mov	eax, LC13
	cmove	rsi, rax
	xor	eax, eax
	call	printf
	mov	dword [rsp+12], 1
	mov	rcx, qword [rsp+24]
.L217:
	add	r12, 1
	cmp	r12, rcx
	jnb	.L214
.L225:
	lea	rax, [r12+r12*8]
	lea	rdx, [r12+rax*2]
	mov	rax, qword [rsp+16]
	lea	r15, [rax+rdx*8]
	mov	rdi, qword [r15]
	mov	rbx, qword [r15+128]
	test	rdi, rdi
	je	.L243
	mov	rsi, rbp
	xor	r14d, r14d
	call	strcmp
	test	eax, eax
	sete	r14b
	test	rbx, rbx
	je	.L218
.L216:
	xor	r13d, r13d
	lea	rbx, [rsp+288]
.L221:
	mov	rax, qword [r15+120]
	mov	edx, 256
	mov	rsi, rbx
	mov	rdi, qword [rax+r13*8]
	call	dep_basename
	cmp	byte [rsp+288], 0
	jne	.L244
.L219:
	add	r13, 1
	cmp	r13, qword [r15+128]
	jb	.L221
.L218:
	test	r14d, r14d
	jne	.L222
	mov	rcx, qword [rsp+24]
	jmp	.L217
.L214:
	lea	rdi, [rsp+16]
	call	aur_response_destroy
	mov	eax, dword [rsp+12]
	test	eax, eax
	jne	.L210
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC17
	xor	eax, eax
	call	fprintf
	jmp	.L213
.L222:
	mov	ecx, LC0
	jmp	.L220
.L243:
	xor	r14d, r14d
	test	rbx, rbx
	jne	.L216
	jmp	.L217
