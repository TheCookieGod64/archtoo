; pkgbuild.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern file_exists
extern fprintf
extern fwrite
extern printf
extern run_as_user
extern stderr
extern strchr
extern use_noconfirm
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/pkgbuild.c
%use smartalign
section .text
section .rodata
LC0:
	db "", 0
section .rodata
LC1:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
section .rodata
LC2:
	db "%s/PKGBUILD", 0
section .rodata
LC3:
	db "\033[1;34m>>> Updating existing checkout %s\n\033[0m", 0
LC4:
	db "GIT_TERMINAL_PROMPT=0 git -C %s pull --ff-only", 0
LC5:
	db "\033[1;34m>>> Cloning https://aur.archlinux.org/%s.git\n\033[0m", 0
LC6:
	db "GIT_TERMINAL_PROMPT=0 git clone -- 'https://aur.archlinux.org/%s.git' %s", 0
LC7:
	db "\033[1;31m[-] Could not fetch PKGBUILD for '%s'.\n\033[0m", 0
LC8:
	db "\033[1;31m[-] Clone succeeded but %s is missing.\n\033[0m", 0
LC9:
	db "\033[1;32m[+] PKGBUILD is at %s\n\033[0m", 0
global cmd_get_pkgbuild_v2
cmd_get_pkgbuild_v2:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 1864
	call	valid_pkgname
	test	eax, eax
	jne	.L2
	test	rbx, rbx
	mov	eax, LC0
	mov	esi, LC1
	mov	rdi, qword [rel stderr]
	cmove	rbx, rax
	xor	eax, eax
	mov	rdx, rbx
	call	fprintf
.L4:
	add	rsp, 1864
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L2:
	mov	edx, 320
	mov	rsi, rsp
	mov	rdi, rbx
	mov	rbp, rsp
	call	shell_quote
	test	eax, eax
	je	.L4
	xor	eax, eax
	mov	rcx, rbx
	mov	edx, LC2
	mov	esi, 512
	lea	r12, [rsp+320]
	mov	rdi, r12
	call	xsnprintf
	mov	rdi, rbx
	call	dir_exists
	test	eax, eax
	jne	.L20
.L7:
	mov	rsi, rbx
	mov	edi, LC5
	xor	eax, eax
	call	printf
	mov	r8, rbp
	mov	rcx, rbx
	mov	edx, LC6
	lea	r13, [rsp+832]
	mov	esi, 1024
	xor	eax, eax
	mov	rdi, r13
	call	xsnprintf
.L8:
	xor	esi, esi
	mov	rdi, r13
	call	run_as_user
	test	eax, eax
	jne	.L21
	mov	rdi, r12
	call	file_exists
	test	eax, eax
	je	.L22
	mov	rsi, r12
	mov	edi, LC9
	xor	eax, eax
	call	printf
	add	rsp, 1864
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L20:
	mov	rdi, r12
	call	file_exists
	test	eax, eax
	je	.L7
	mov	rsi, rbx
	mov	edi, LC3
	xor	eax, eax
	call	printf
	mov	rcx, rsp
	mov	edx, LC4
	xor	eax, eax
	lea	r13, [rsp+832]
	mov	esi, 1024
	mov	rdi, r13
	call	xsnprintf
	jmp	.L8
.L21:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC7
	xor	eax, eax
	call	fprintf
	jmp	.L4
.L22:
	mov	rdi, qword [rel stderr]
	mov	rdx, r12
	mov	esi, LC8
	call	fprintf
	jmp	.L4
section .rodata
LC10:
	db " --noconfirm", 0
section .rodata
LC11:
	db "\033[1;31m[-] Local build requires a directory.\n\033[0m", 0
LC12:
	db "\033[1;31m[-] Invalid build directory.\n\033[0m", 0
LC13:
	db "\033[1;31m[-] Directory does not exist: %s\n\033[0m", 0
LC14:
	db "\033[1;31m[-] No PKGBUILD in %s\n\033[0m", 0
LC15:
	db "\033[1;34m>>> Building local PKGBUILD in %s\n\033[0m", 0
section .rodata
LC16:
	db "cd %s && makepkg -f%s", 0
section .rodata
LC17:
	db "\033[1;31m[-] Local build failed.\n\033[0m", 0
global cmd_local_build_v2
cmd_local_build_v2:
	push	rbp
	push	rbx
	sub	rsp, 4280
	test	rdi, rdi
	je	.L24
	cmp	byte [rdi], 0
	mov	rbx, rdi
	je	.L24
	mov	esi, 10
	call	strchr
	test	rax, rax
	jne	.L27
	mov	esi, 13
	mov	rdi, rbx
	call	strchr
	test	rax, rax
	je	.L28
.L27:
	mov	edx, 40
	mov	esi, 1
	mov	edi, LC12
	mov	rcx, qword [rel stderr]
	call	fwrite
.L26:
	xor	eax, eax
.L23:
	add	rsp, 4280
	pop	rbx
	pop	rbp
	ret
.L24:
	mov	edx, 49
	mov	esi, 1
	mov	edi, LC11
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L26
.L28:
	mov	rdi, rbx
	call	dir_exists
	test	eax, eax
	je	.L43
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
	je	.L44
	mov	edx, 1024
	mov	rsi, rsp
	mov	rdi, rbx
	call	shell_quote
	test	eax, eax
	je	.L26
	mov	rsi, rbx
	mov	edi, LC15
	xor	eax, eax
	call	printf
	lea	rbx, [rsp+2224]
	call	use_noconfirm
	mov	edx, LC16
	mov	rcx, rsp
	mov	rdi, rbx
	test	eax, eax
	mov	r8d, LC0
	mov	eax, LC10
	mov	esi, 2048
	cmovne	r8, rax
	xor	eax, eax
	call	xsnprintf
	xor	esi, esi
	mov	rdi, rbx
	call	run_as_user
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	je	.L23
	mov	edx, 35
	mov	esi, 1
	mov	edi, LC17
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L26
.L44:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC14
	call	fprintf
	jmp	.L26
.L43:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC13
	call	fprintf
	jmp	.L26
