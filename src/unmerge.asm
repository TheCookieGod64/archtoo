; unmerge.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern is_kernel
extern printf
extern priv_prefix
extern regex_escape
extern run_cmd
extern run_cmd_quiet
extern stderr
extern use_noconfirm
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/unmerge.c
%use smartalign
section .text
section .rodata
LC0:
	db "%ssed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{s/[[:space:]]+%s([[:space:]]|$)/\\1/g;s/=[[:space:]]*%s([[:space:]]|$)/= /g;s/[[:space:]]+$//;s/=[[:space:]]+/= /g}' '%s'", 0
section .rodata
LC1:
	db "/etc/pacman.conf", 0
global unlock_pacman_pkg
unlock_pacman_pkg:
	push	rbp
	mov	edx, 320
	push	rbx
	sub	rsp, 2376
	mov	rsi, rsp
	call	regex_escape
	test	eax, eax
	je	.L1
	call	priv_prefix
	mov	rbx, rsp
	mov	edx, LC0
	lea	rbp, [rsp+320]
	sub	rsp, 8
	mov	rcx, rax
	mov	r9, rbx
	mov	r8, rbx
	push	LC1
	mov	esi, 2048
	mov	rdi, rbp
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	rsp, rbx
.L1:
	add	rsp, 2376
	pop	rbx
	pop	rbp
	ret
section .rodata
LC2:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC3:
	db "\033[1;33m[!] %s is not in the world set; unlocking anyway.\n\033[0m", 0
LC4:
	db "\033[1;34m>>> [1/2] Unlocking %s in pacman.conf...\n\033[0m", 0
section .rodata
LC5:
	db "%s-headers", 0
section .rodata
LC6:
	db "\033[1;34m>>> [2/2] Removing %s from the world set...\n\033[0m", 0
LC7:
	db "\033[1;32m[+] %s deselected. It stays installed, and pacman will\n    manage it again from the official repositories.\n\033[0m", 0
global cmd_deselect
cmd_deselect:
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 2624
	call	valid_pkgname
	test	eax, eax
	je	.L25
	mov	rdi, rbx
	call	is_in_world
	test	eax, eax
	je	.L26
.L11:
	mov	rsi, rbx
	mov	edi, LC4
	xor	eax, eax
	call	printf
	lea	rbp, [rsp+256]
	mov	edx, 320
	mov	rdi, rbx
	mov	rsi, rbp
	call	regex_escape
	test	eax, eax
	jne	.L27
	mov	rdi, rbx
	call	is_kernel
	test	eax, eax
	jne	.L28
.L13:
	mov	rsi, rbx
	mov	edi, LC6
	xor	eax, eax
	mov	ebp, 1
	call	printf
	mov	rdi, rbx
	call	remove_from_world
	mov	rsi, rbx
	mov	edi, LC7
	xor	eax, eax
	call	printf
	add	rsp, 2624
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L27:
	call	priv_prefix
	mov	esi, 2048
	mov	r9, rbp
	mov	r8, rbp
	lea	r12, [rsp+576]
	sub	rsp, 8
	mov	rcx, rax
	mov	edx, LC0
	push	LC1
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	pop	rcx
	mov	rdi, rbx
	pop	rsi
	call	is_kernel
	test	eax, eax
	je	.L13
	jmp	.L28
.L26:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC3
	call	fprintf
	jmp	.L11
.L28:
	mov	edx, LC5
	mov	esi, 256
	mov	rdi, rsp
	xor	eax, eax
	mov	rcx, rbx
	call	xsnprintf
	mov	edx, 320
	mov	rsi, rbp
	mov	rdi, rsp
	call	regex_escape
	test	eax, eax
	je	.L13
	call	priv_prefix
	mov	edx, LC0
	mov	r9, rbp
	mov	r8, rbp
	lea	r12, [rsp+576]
	sub	rsp, 8
	mov	rcx, rax
	mov	esi, 2048
	push	LC1
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	pop	rax
	pop	rdx
	jmp	.L13
.L25:
	mov	rdi, qword [rel stderr]
	mov	ebp, eax
	mov	rdx, rbx
	mov	esi, LC2
	xor	eax, eax
	call	fprintf
	add	rsp, 2624
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	ret
section .rodata
LC8:
	db " --noconfirm", 0
LC9:
	db "", 0
section .rodata
LC10:
	db "\033[1;34m>>> [1/3] Unmerging %s via pacman...\n\033[0m", 0
section .rodata
LC11:
	db "%s-debug", 0
LC12:
	db "pacman -Qq '%s'", 0
LC13:
	db "%spacman -Rns '%s' '%s'%s", 0
LC14:
	db "%spacman -Rns '%s'%s", 0
section .rodata
LC15:
	db "\033[1;31m[-] Unmerge failed.\n\033[0m", 0
LC16:
	db "\033[1;34m>>> [2/3] Unlocking %s in pacman.conf...\n\033[0m", 0
LC17:
	db "\033[1;34m>>> [3/3] Cleaning up world file and build directory...\n\033[0m", 0
section .rodata
LC18:
	db "/usr/local/emerge/builds", 0
LC19:
	db "rm -rf '%s/%s'", 0
section .rodata
LC20:
	db "\033[1;32m[+] %s successfully unmerged.\n\033[0m", 0
global cmd_unmerge
cmd_unmerge:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 4424
	call	valid_pkgname
	test	eax, eax
	je	.L53
	mov	rsi, rbx
	mov	edi, LC10
	xor	eax, eax
	mov	r12, rsp
	call	printf
	mov	rcx, rbx
	mov	edx, LC11
	mov	rdi, rsp
	mov	esi, 256
	xor	eax, eax
	lea	rbp, [rsp+832]
	call	xsnprintf
	mov	rdi, rbp
	xor	eax, eax
	mov	rcx, rsp
	mov	edx, LC12
	mov	esi, 512
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd_quiet
	test	eax, eax
	je	.L54
	call	use_noconfirm
	mov	r12d, LC9
	lea	rbp, [rsp+1344]
	test	eax, eax
	mov	eax, LC8
	cmovne	r12, rax
	call	priv_prefix
	mov	rdi, rbp
	mov	r8, rbx
	mov	edx, LC14
	mov	rcx, rax
	mov	r9, r12
	xor	eax, eax
	mov	esi, 1024
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	test	eax, eax
	jne	.L55
.L36:
	mov	rsi, rbx
	mov	edi, LC16
	xor	eax, eax
	call	printf
	lea	r12, [rsp+512]
	mov	edx, 320
	mov	rdi, rbx
	mov	rsi, r12
	call	regex_escape
	test	eax, eax
	je	.L38
	call	priv_prefix
	mov	esi, 2048
	mov	r9, r12
	mov	r8, r12
	lea	r13, [rsp+2368]
	sub	rsp, 8
	mov	rcx, rax
	mov	edx, LC0
	push	LC1
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	call	run_cmd
	pop	rcx
	pop	rsi
.L38:
	mov	rdi, rbx
	call	is_kernel
	test	eax, eax
	jne	.L56
.L39:
	mov	edi, LC17
	xor	eax, eax
	call	printf
	mov	rdi, rbx
	call	remove_from_world
	mov	r8, rbx
	mov	ecx, LC18
	mov	rdi, rbp
	mov	edx, LC19
	mov	esi, 1024
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	rsi, rbx
	mov	edi, LC20
	xor	eax, eax
	call	printf
	add	rsp, 4424
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L54:
	call	use_noconfirm
	mov	r13d, LC9
	lea	rbp, [rsp+1344]
	test	eax, eax
	mov	eax, LC8
	cmovne	r13, rax
	call	priv_prefix
	sub	rsp, 8
	mov	rdi, rbp
	mov	r9, r12
	push	r13
	mov	rcx, rax
	mov	r8, rbx
	xor	eax, eax
	mov	edx, LC13
	mov	esi, 1024
	call	xsnprintf
	mov	rsp, r12
	mov	rdi, rbp
	call	run_cmd
	test	eax, eax
	je	.L36
.L55:
	mov	edx, 31
	mov	esi, 1
	mov	edi, LC15
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
.L57:
	add	rsp, 4424
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L53:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC2
	call	fprintf
	xor	eax, eax
	jmp	.L57
.L56:
	mov	edx, LC5
	mov	esi, 256
	xor	eax, eax
	mov	rcx, rbx
	lea	r13, [rsp+256]
	mov	rdi, r13
	call	xsnprintf
	mov	edx, 320
	mov	rsi, r12
	mov	rdi, r13
	call	regex_escape
	test	eax, eax
	je	.L39
	call	priv_prefix
	mov	edx, LC0
	mov	r9, r12
	mov	r8, r12
	lea	r13, [rsp+2368]
	sub	rsp, 8
	mov	rcx, rax
	mov	esi, 2048
	push	LC1
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	call	run_cmd
	pop	rax
	pop	rdx
	jmp	.L39
