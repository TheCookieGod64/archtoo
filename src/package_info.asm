; package_info.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern free
extern printf
extern puts
extern run_cmd
extern run_cmd_capture
extern stderr
extern stdout
extern strlen
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/package_info.c
%use smartalign
section .text
section .rodata
LC0:
	db "", 0
LC1:
	db "(orphan)", 0
section .rodata
LC2:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
section .rodata
LC3:
	db "pacman -Si -- %s", 0
LC4:
	db "\033[1;31m[-] %s\n\033[0m", 0
section .rodata
LC5:
	db "\033[1;31m[-] Package '%s' was not found in repositories or the AUR.\n\033[0m", 0
section .rodata
LC6:
	db "Repository      : aur", 0
LC7:
	db "Name            : %s\n", 0
LC8:
	db "Package Base    : %s\n", 0
LC9:
	db "Version         : %s\n", 0
LC10:
	db "Description     : %s\n", 0
LC11:
	db "URL             : %s\n", 0
LC12:
	db "Maintainer      : %s\n", 0
LC13:
	db "Votes           : %ld\n", 0
LC14:
	db "Popularity      : %.2f\n", 0
LC15:
	db "Out Of Date     : %ld\n", 0
LC16:
	db "Depends On      :", 0
LC17:
	db " None", 0
LC18:
	db "Make Deps       :", 0
LC19:
	db " %s", 0
LC20:
	db "Check Deps      :", 0
LC21:
	db "Provides        :", 0
LC22:
	db "Conflicts With  :", 0
global cmd_available_info_v2
cmd_available_info_v2:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 1128
	mov	qword [rsp+8], 0
	call	valid_pkgname
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
.L10:
	xor	eax, eax
.L1:
	add	rsp, 1128
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L2:
	lea	rbp, [rsp+288]
	mov	edx, 320
	mov	rdi, rbx
	mov	rsi, rbp
	call	shell_quote
	test	eax, eax
	je	.L10
	mov	rcx, rbp
	mov	edx, LC3
	mov	esi, 512
	xor	eax, eax
	lea	r12, [rsp+608]
	mov	rdi, r12
	call	xsnprintf
	mov	rdi, r12
	lea	rsi, [rsp+8]
	call	run_cmd_capture
	mov	rdi, qword [rsp+8]
	test	eax, eax
	jne	.L7
	test	rdi, rdi
	je	.L7
	cmp	byte [rdi], 0
	jne	.L59
.L7:
	call	free
	pxor	xmm0, xmm0
	lea	rbp, [rsp+32]
	lea	r15, [rsp+16]
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
	call	config_current
	mov	rcx, rbp
	mov	rdx, r15
	mov	rsi, rbx
	lea	rdi, [rax+20]
	mov	r8d, 256
	call	aur_rpc_info
	test	eax, eax
	je	.L60
	xor	r14d, r14d
	xor	r13d, r13d
	cmp	qword [rsp+24], 0
	mov	r12d, LC0
	je	.L61
.L11:
	mov	rbx, qword [rsp+16]
	mov	edi, LC6
	call	puts
	mov	edi, LC7
	add	rbx, r14
	mov	rsi, qword [rbx]
	test	rsi, rsi
	cmove	rsi, r12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+8]
	mov	edi, LC8
	test	rsi, rsi
	cmove	rsi, r12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+16]
	mov	edi, LC9
	test	rsi, rsi
	cmove	rsi, r12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+24]
	mov	edi, LC10
	test	rsi, rsi
	cmove	rsi, r12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+32]
	mov	edi, LC11
	test	rsi, rsi
	cmove	rsi, r12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+40]
	test	rsi, rsi
	je	.L43
	cmp	byte [rsi], 0
	mov	eax, LC1
	cmove	rsi, rax
.L17:
	mov	edi, LC12
	xor	eax, eax
	call	printf
	mov	rsi, qword [rbx+48]
	mov	edi, LC13
	xor	eax, eax
	call	printf
	movsd	xmm0, qword [rbx+56]
	mov	edi, LC14
	mov	eax, 1
	call	printf
	mov	rsi, qword [rbx+64]
	test	rsi, rsi
	jne	.L62
.L18:
	xor	eax, eax
	mov	edi, LC16
	call	printf
	cmp	qword [rbx+80], 0
	je	.L63
.L19:
	xor	ebp, ebp
.L22:
	mov	rax, qword [rbx+72]
	mov	edi, LC19
	mov	rsi, qword [rax+rbp*8]
	xor	eax, eax
	add	rbp, 1
	call	printf
	cmp	rbp, qword [rbx+80]
	jb	.L22
.L23:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	xor	eax, eax
	mov	edi, LC18
	call	printf
	cmp	qword [rbx+96], 0
	je	.L64
.L21:
	xor	ebp, ebp
.L26:
	mov	rax, qword [rbx+88]
	mov	edi, LC19
	mov	rsi, qword [rax+rbp*8]
	xor	eax, eax
	add	rbp, 1
	call	printf
	cmp	rbp, qword [rbx+96]
	jb	.L26
.L27:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	xor	eax, eax
	mov	edi, LC20
	call	printf
	cmp	qword [rbx+112], 0
	je	.L65
.L25:
	xor	ebp, ebp
.L30:
	mov	rax, qword [rbx+104]
	mov	edi, LC19
	mov	rsi, qword [rax+rbp*8]
	xor	eax, eax
	add	rbp, 1
	call	printf
	cmp	rbp, qword [rbx+112]
	jb	.L30
.L31:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	xor	eax, eax
	mov	edi, LC21
	call	printf
	cmp	qword [rbx+128], 0
	je	.L66
.L29:
	xor	ebp, ebp
.L34:
	mov	rax, qword [rbx+120]
	mov	edi, LC19
	mov	rsi, qword [rax+rbp*8]
	xor	eax, eax
	add	rbp, 1
	call	printf
	cmp	rbp, qword [rbx+128]
	jb	.L34
.L35:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	xor	eax, eax
	mov	edi, LC22
	call	printf
	cmp	qword [rbx+144], 0
	je	.L67
.L33:
	xor	ebp, ebp
.L38:
	mov	rax, qword [rbx+136]
	mov	edi, LC19
	mov	rsi, qword [rax+rbp*8]
	xor	eax, eax
	add	rbp, 1
	call	printf
	cmp	rbp, qword [rbx+144]
	jb	.L38
.L39:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	add	r13, 1
	call	putc
	cmp	r13, qword [rsp+24]
	jb	.L68
.L37:
	mov	rdi, r15
	call	aur_response_destroy
	mov	eax, 1
	jmp	.L1
.L67:
	xor	eax, eax
	mov	edi, LC17
	call	printf
	cmp	qword [rbx+144], 0
	jne	.L33
	jmp	.L39
.L66:
	xor	eax, eax
	mov	edi, LC17
	call	printf
	cmp	qword [rbx+128], 0
	jne	.L29
	jmp	.L35
.L65:
	xor	eax, eax
	mov	edi, LC17
	call	printf
	cmp	qword [rbx+112], 0
	jne	.L25
	jmp	.L31
.L64:
	xor	eax, eax
	mov	edi, LC17
	call	printf
	cmp	qword [rbx+96], 0
	jne	.L21
	jmp	.L27
.L63:
	xor	eax, eax
	mov	edi, LC17
	call	printf
	cmp	qword [rbx+80], 0
	jne	.L19
	jmp	.L23
.L68:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	add	r14, 152
	call	putc
	cmp	r13, qword [rsp+24]
	jb	.L11
	jmp	.L37
.L62:
	mov	edi, LC15
	xor	eax, eax
	call	printf
	jmp	.L18
.L43:
	mov	esi, LC1
	jmp	.L17
.L60:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC4
	call	fprintf
	jmp	.L10
.L59:
	mov	rsi, qword [rel stdout]
	call	fputs
	mov	rbx, qword [rsp+8]
	mov	rdi, rbx
	call	strlen
	cmp	byte [rbx-1+rax], 10
	je	.L8
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
	mov	rbx, qword [rsp+8]
.L8:
	mov	rdi, rbx
	call	free
	mov	eax, 1
	jmp	.L1
.L61:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC5
	xor	eax, eax
	call	fprintf
	mov	rdi, r15
	call	aur_response_destroy
	jmp	.L10
section .rodata
LC23:
	db "pacman -Qi -- %s", 0
global cmd_query_v2
cmd_query_v2:
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 840
	call	valid_pkgname
	test	eax, eax
	jne	.L70
	test	rbx, rbx
	mov	eax, LC0
	mov	esi, LC2
	mov	rdi, qword [rel stderr]
	cmove	rbx, rax
	xor	eax, eax
	mov	rdx, rbx
	call	fprintf
.L72:
	add	rsp, 840
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
.L70:
	mov	edx, 320
	mov	rsi, rsp
	mov	rdi, rbx
	call	shell_quote
	test	eax, eax
	je	.L72
	mov	rcx, rsp
	mov	edx, LC23
	mov	esi, 512
	xor	eax, eax
	lea	rbx, [rsp+320]
	mov	rdi, rbx
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	test	eax, eax
	sete	al
	add	rsp, 840
	movzx	eax, al
	pop	rbx
	pop	rbp
	ret
