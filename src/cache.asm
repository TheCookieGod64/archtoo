; cache.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fprintf
extern printf
extern priv_prefix
extern run_cmd
extern stderr
extern use_noconfirm
extern xsnprintf
; NASM assembly - converted from C: src/cache.c
%use smartalign
section .text
section .rodata
LC0:
	db " --noconfirm", 0
LC1:
	db "", 0
section .rodata
LC2:
	db "\033[1;34m>>> Removing leftover pacman download fragments...\n\033[0m", 0
LC3:
	db "find /var/cache/pacman/pkg -maxdepth 1 \\( -type f -o -type d \\) -name 'download-*' -exec rm -rf {} + 2>/dev/null || true", 0
LC4:
	db "\033[1;34m>>> Cleaning uninstalled package cache...\n\033[0m", 0
section .rodata
LC5:
	db "%spacman -Sc%s", 0
section .rodata
LC6:
	db "\033[1;31m[-] pacman cache clean failed (exit %d).\n\033[0m", 0
global cmd_clean_v2
cmd_clean_v2:
	push	rbp
	mov	edi, LC2
	xor	eax, eax
	push	rbx
	mov	ebx, LC1
	sub	rsp, 520
	call	printf
	mov	edi, LC3
	call	run_cmd
	mov	edi, LC4
	xor	eax, eax
	call	printf
	call	use_noconfirm
	test	eax, eax
	mov	eax, LC0
	cmovne	rbx, rax
	call	priv_prefix
	mov	edx, LC5
	mov	esi, 512
	mov	rdi, rsp
	mov	rcx, rax
	mov	r8, rbx
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	jne	.L10
	add	rsp, 520
	pop	rbx
	pop	rbp
	ret
.L10:
	mov	rdi, qword [rel stderr]
	mov	esi, LC6
	xor	eax, eax
	call	fprintf
	add	rsp, 520
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
