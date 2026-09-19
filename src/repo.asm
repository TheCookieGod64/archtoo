; repo.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern printf
extern priv_prefix
extern run_cmd
extern stderr
extern use_noconfirm
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/repo.c
%use smartalign
section .text
section .rodata
LC0:
	db "", 0
LC1:
	db " --noconfirm --ask=6", 0
section .rodata
LC2:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC3:
	db "\033[1;34m>>> Installing repository package %s\n\033[0m", 0
section .rodata
LC4:
	db "%spacman -S --needed%s -- %s", 0
section .rodata
LC5:
	db "\033[1;31m[-] Could not install '%s' from repositories.\n\033[0m", 0
global cmd_repo_install_v2
cmd_repo_install_v2:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 968
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
.L4:
	xor	eax, eax
.L1:
	add	rsp, 968
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L2:
	mov	edx, 320
	mov	rsi, rsp
	mov	rdi, rbx
	call	shell_quote
	test	eax, eax
	je	.L4
	mov	rsi, rbx
	mov	edi, LC3
	xor	eax, eax
	mov	r12d, LC0
	call	printf
	lea	r13, [rsp+320]
	call	use_noconfirm
	test	eax, eax
	mov	eax, LC1
	cmovne	r12, rax
	call	priv_prefix
	mov	edx, LC4
	mov	r9, rsp
	mov	rdi, r13
	mov	rcx, rax
	mov	r8, r12
	mov	esi, 640
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	call	run_cmd
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	je	.L1
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC5
	xor	eax, eax
	call	fprintf
	jmp	.L4
