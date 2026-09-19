; guide.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern close
extern fwrite
extern open
extern printf
extern puts
extern stderr
extern strcmp
extern strrchr
extern write
extern xsnprintf
; NASM assembly - converted from C: src/guide.c
%use smartalign
section .text
section .rodata
LC0:
	db "first-run", 0
LC1:
	db "always", 0
LC2:
	db "never", 0
global guide_policy_parse
guide_policy_parse:
	test	rdi, rdi
	je	.L9
	push	rbp
	mov	rbp, rsi
	push	rbx
	sub	rsp, 8
	test	rsi, rsi
	je	.L6
	mov	esi, LC0
	mov	rbx, rdi
	call	strcmp
	test	eax, eax
	jne	.L3
	mov	dword [rbp+0], 0
.L4:
	mov	eax, 1
.L1:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L3:
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L14
	mov	esi, LC2
	mov	rdi, rbx
	call	strcmp
	mov	edx, eax
	xor	eax, eax
	test	edx, edx
	jne	.L1
	mov	dword [rbp+0], 2
	jmp	.L4
.L6:
	add	rsp, 8
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
.L14:
	mov	dword [rbp+0], 1
	jmp	.L4
.L9:
	xor	eax, eax
	ret
global guide_policy_name
guide_policy_name:
	mov	eax, LC1
	cmp	edi, 1
	je	.L15
	cmp	edi, 2
	mov	eax, LC2
	mov	edx, LC0
	cmovne	rax, rdx
.L15:
	ret
global guide_set_policy
guide_set_policy:
	mov	dword [rel g_policy], edi
	ret
global guide_get_policy
guide_get_policy:
	mov	eax, dword [rel g_policy]
	ret
global guide_request_explicit
guide_request_explicit:
	mov	dword [rel g_explicit], 1
	ret
section .rodata
LC3:
	db "%s", 0
LC4:
	db "XDG_STATE_HOME", 0
LC5:
	db "%s/archtoo", 0
LC6:
	db "%s/.local/state/archtoo", 0
LC7:
	db "%s/command-guide-seen", 0
global guide_should_show
guide_should_show:
	mov	eax, dword [rel g_explicit]
	test	eax, eax
	jne	.L50
	mov	edx, dword [rel g_policy]
	cmp	edx, 1
	je	.L50
	cmp	edx, 2
	je	.L51
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 2992
	call	build_user
	mov	rdi, rax
	test	rax, rax
	je	.L24
	call	getpwnam
	test	rax, rax
	je	.L24
	mov	rcx, qword [rax+32]
	test	rcx, rcx
	je	.L24
	mov	edx, LC3
	mov	esi, 768
	mov	rdi, rsp
	xor	eax, eax
	call	xsnprintf
	mov	edi, LC4
	mov	r12, rsp
	call	getenv
	mov	rbx, rax
	test	rax, rax
	je	.L28
	cmp	byte [rax], 0
	jne	.L54
.L28:
	mov	rcx, r12
	mov	edx, LC6
	mov	esi, 1024
	xor	eax, eax
	lea	rbp, [rsp+768]
	mov	rdi, rbp
	call	xsnprintf
.L29:
	mov	rcx, rbp
	mov	edx, LC7
	mov	esi, 1200
	xor	eax, eax
	lea	rbx, [rsp+1792]
	mov	rdi, rbx
	call	xsnprintf
	xor	esi, esi
	mov	rdi, rbx
	call	access
	test	eax, eax
	setne	al
	add	rsp, 2992
	pop	rbx
	movzx	eax, al
	pop	rbp
	pop	r12
	ret
.L51:
	ret
.L24:
	add	rsp, 2992
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L50:
	mov	eax, 1
	ret
.L54:
	call	geteuid
	test	eax, eax
	je	.L28
	mov	rcx, rbx
	mov	edx, LC5
	mov	esi, 1024
	xor	eax, eax
	lea	rbp, [rsp+768]
	mov	rdi, rbp
	call	xsnprintf
	jmp	.L29
section .rodata
LC8:
	db "\033[1;36m\nWelcome to Archtoo.\n\n\033[0m", 0
LC9:
	db "Archtoo uses its own command interface. It does not copy pacman's", 0
LC10:
	db "option meanings and never invokes an external AUR helper.\n", 0
section .rodata
LC11:
	db "Common commands:\n", 0
section .rodata
LC12:
	db "  emerge -S query          Search repositories and the AUR", 0
LC13:
	db "  emerge -I package        Install a package", 0
LC14:
	db "  emerge -U                Upgrade repository and AUR packages", 0
LC15:
	db "  emerge -Q package        Query an installed package", 0
LC16:
	db "  emerge -A package        Show available package information", 0
LC17:
	db "  emerge -C package        Remove a package", 0
LC18:
	db "  emerge -G package        Download its PKGBUILD", 0
LC19:
	db "  emerge --help            Show every command\n", 0
LC20:
	db "This guide follows the '%s' display policy. Run\n", 0
LC21:
	db "'emerge --command-guide' to display it explicitly.\n", 0
global guide_print
guide_print:
	sub	rsp, 8
	mov	edi, LC8
	xor	eax, eax
	call	printf
	mov	edi, LC9
	call	puts
	mov	edi, LC10
	call	puts
	mov	edi, LC11
	call	puts
	mov	edi, LC12
	call	puts
	mov	edi, LC13
	call	puts
	mov	edi, LC14
	call	puts
	mov	edi, LC15
	call	puts
	mov	edi, LC16
	call	puts
	mov	edi, LC17
	call	puts
	mov	edi, LC18
	call	puts
	mov	edi, LC19
	call	puts
	mov	eax, dword [rel g_policy]
	mov	esi, LC1
	cmp	eax, 1
	je	.L56
	cmp	eax, 2
	mov	esi, LC2
	mov	eax, LC0
	cmovne	rsi, rax
.L56:
	mov	edi, LC20
	xor	eax, eax
	call	printf
	mov	edi, LC21
	add	rsp, 8
	jmp	puts
global guide_mark_seen
guide_mark_seen:
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	ebx, 1
	sub	rsp, 3256
	mov	eax, dword [rel g_explicit]
	or	eax, dword [rel g_policy]
	je	.L93
.L62:
	add	rsp, 3256
	mov	eax, ebx
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L93:
	mov	ebx, eax
	call	build_user
	mov	rdi, rax
	test	rax, rax
	je	.L62
	call	getpwnam
	test	rax, rax
	je	.L62
	mov	rcx, qword [rax+32]
	test	rcx, rcx
	je	.L62
	lea	rbp, [rsp+1024]
	mov	edx, LC3
	mov	esi, 768
	xor	eax, eax
	mov	rdi, rbp
	call	xsnprintf
	mov	edi, LC4
	call	getenv
	mov	r12, rax
	test	rax, rax
	je	.L67
	cmp	byte [rax], 0
	jne	.L94
.L67:
	mov	rcx, rbp
	mov	edx, LC6
	mov	esi, 1024
	mov	rdi, rsp
	xor	eax, eax
	mov	r13, rsp
	call	xsnprintf
.L68:
	mov	rcx, r13
	mov	edx, LC7
	mov	esi, 1200
	xor	eax, eax
	lea	r12, [rsp+2048]
	mov	rdi, r12
	call	xsnprintf
	mov	esi, 1024
	mov	rdi, rbp
	xor	eax, eax
	mov	rcx, r13
	mov	edx, LC3
	call	xsnprintf
	mov	esi, 47
	mov	rdi, rbp
	call	strrchr
	test	rax, rax
	je	.L73
	mov	byte [rax], 0
	mov	esi, 448
	mov	rdi, rbp
	call	mkdir
	test	eax, eax
	je	.L73
	call	__errno_location
	cmp	dword [rax], 17
	jne	.L62
.L73:
	mov	esi, 448
	mov	rdi, r13
	call	mkdir
	test	eax, eax
	je	.L71
	call	__errno_location
	cmp	dword [rax], 17
	jne	.L62
.L71:
	mov	edx, 384
	mov	esi, 131265
	mov	rdi, r12
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	jns	.L75
	call	__errno_location
	xor	ebx, ebx
	cmp	dword [rax], 17
	sete	bl
	jmp	.L62
.L94:
	call	geteuid
	test	eax, eax
	je	.L67
	mov	rcx, r12
	mov	edx, LC5
	mov	esi, 1024
	mov	rdi, rsp
	xor	eax, eax
	mov	r13, rsp
	call	xsnprintf
	jmp	.L68
.L75:
	mov	edx, 33
	mov	esi, text.0
	mov	edi, eax
	call	write
	mov	r12, rax
	call	__errno_location
	mov	edi, ebx
	xor	ebx, ebx
	mov	r13d, dword [rax]
	mov	rbp, rax
	call	close
	cmp	r12, 33
	mov	dword [rbp+0], r13d
	sete	bl
	jmp	.L62
section .rodata
LC22:
	db "\033[1;33m[!] Could not record command-guide state; it may appear again.\n\033[0m", 0
global guide_maybe_show
guide_maybe_show:
	sub	rsp, 8
	call	guide_should_show
	test	eax, eax
	jne	.L100
.L97:
	mov	eax, 1
	add	rsp, 8
	ret
.L100:
	call	guide_print
	call	guide_mark_seen
	test	eax, eax
	jne	.L97
	mov	edx, 74
	mov	esi, 1
	mov	edi, LC22
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	eax, 1
	add	rsp, 8
	ret
section .rodata
text.0:
	db "Archtoo command guide displayed.\n", 0
