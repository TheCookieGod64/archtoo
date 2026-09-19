; world.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern exit
extern fprintf
extern free
extern fwrite
extern get_aur_sync
extern open
extern printf
extern priv_prefix
extern puts
extern realloc
extern rename
extern run_cmd
extern stderr
extern strcmp
extern strdup
extern use_noconfirm
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/world.c
%use smartalign
section .text
section .rodata
LC0:
	db "r", 0
LC1:
	db "/usr/local/emerge/world", 0
LC2:
	db "\r\n", 0
global is_in_world
is_in_world:
	push	r12
	mov	esi, LC0
	mov	r12, rdi
	mov	edi, LC1
	push	rbp
	push	rbx
	sub	rsp, 512
	call	fopen_nofollow
	test	rax, rax
	je	.L6
	mov	rbp, rax
	mov	rbx, rsp
	jmp	.L3
.L5:
	mov	esi, LC2
	mov	rdi, rbx
	call	strcspn
	mov	rsi, r12
	mov	rdi, rbx
	mov	byte [rsp+rax], 0
	call	strcmp
	test	eax, eax
	je	.L7
.L3:
	mov	rdx, rbp
	mov	esi, 512
	mov	rdi, rbx
	call	fgets
	test	rax, rax
	jne	.L5
	xor	ebx, ebx
.L4:
	mov	rdi, rbp
	call	fclose
	add	rsp, 512
	mov	eax, ebx
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L7:
	mov	ebx, 1
	jmp	.L4
.L6:
	add	rsp, 512
	xor	ebx, ebx
	mov	eax, ebx
	pop	rbx
	pop	rbp
	pop	r12
	ret
section .rodata
LC3:
	db "a", 0
section .rodata
LC4:
	db "\033[1;31m[-] Could not open world file %s\n\033[0m", 0
section .rodata
LC5:
	db "%s\n", 0
section .rodata
LC6:
	db "\033[1;32m[+] %s registered in %s\n\033[0m", 0
global add_to_world
add_to_world:
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	call	valid_pkgname
	test	eax, eax
	jne	.L16
.L10:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L16:
	mov	rdi, rbx
	call	is_in_world
	test	eax, eax
	jne	.L10
	mov	esi, LC3
	mov	edi, LC1
	call	fopen_nofollow
	mov	rbp, rax
	test	rax, rax
	je	.L17
	mov	rdx, rbx
	mov	esi, LC5
	mov	rdi, rax
	xor	eax, eax
	call	fprintf
	mov	rdi, rbp
	call	fclose
	mov	edi, LC1
	call	fix_owner
	add	rsp, 8
	mov	rsi, rbx
	xor	eax, eax
	pop	rbx
	mov	edx, LC1
	mov	edi, LC6
	pop	rbp
	jmp	printf
.L17:
	mov	rdi, qword [rel stderr]
	add	rsp, 8
	mov	edx, LC1
	mov	esi, LC4
	pop	rbx
	xor	eax, eax
	pop	rbp
	jmp	fprintf
section .rodata
LC7:
	db "%s.tmp", 0
LC8:
	db "w", 0
section .rodata
LC9:
	db "\033[1;31m[-] Could not update world file.\n\033[0m", 0
section .rodata
LC10:
	db "%s", 0
section .rodata
LC11:
	db "\033[1;31m[-] Could not replace world file.\n\033[0m", 0
global remove_from_world
remove_from_world:
	push	r15
	mov	esi, LC0
	push	r14
	push	r13
	mov	r13, rdi
	mov	edi, LC1
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 1544
	call	fopen_nofollow
	test	rax, rax
	je	.L18
	mov	ecx, LC1
	mov	edx, LC7
	mov	rdi, rsp
	mov	r12, rax
	mov	esi, 512
	xor	eax, eax
	mov	r15, rsp
	call	xsnprintf
	mov	esi, LC8
	mov	rdi, rsp
	lea	rbp, [rsp+512]
	call	fopen_nofollow
	lea	rbx, [rsp+1024]
	mov	r14, rax
	test	rax, rax
	je	.L34
.L20:
	mov	rdx, r12
	mov	esi, 512
	mov	rdi, rbp
	call	fgets
	test	rax, rax
	je	.L35
	mov	rcx, rbp
	mov	edx, LC10
	mov	esi, 512
	mov	rdi, rbx
	xor	eax, eax
	call	xsnprintf
	mov	esi, LC2
	mov	rdi, rbx
	call	strcspn
	mov	rsi, r13
	mov	rdi, rbx
	mov	byte [rsp+1024+rax], 0
	call	strcmp
	test	eax, eax
	je	.L20
	mov	rsi, r14
	mov	rdi, rbp
	call	fputs
	jmp	.L20
.L35:
	mov	rdi, r12
	call	fclose
	mov	rdi, r14
	call	fclose
	mov	esi, LC1
	mov	rdi, r15
	call	rename
	test	eax, eax
	jne	.L36
	mov	edi, LC1
	call	fix_owner
.L18:
	add	rsp, 1544
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L36:
	mov	rdi, r15
	call	remove
	mov	edx, 45
	mov	esi, 1
	mov	rcx, qword [rel stderr]
	mov	edi, LC11
	call	fwrite
	jmp	.L18
.L34:
	mov	rdi, r12
	call	fclose
	mov	edx, 44
	mov	esi, 1
	mov	rcx, qword [rel stderr]
	mov	edi, LC9
	call	fwrite
	jmp	.L18
section .rodata
LC12:
	db " --noconfirm", 0
LC13:
	db "", 0
section .rodata
LC14:
	db "\033[1;35m\n==========================================================", 0
section .rodata
LC15:
	db "3.0.0", 0
LC16:
	db "   ARCHTOO WORLD UPDATE v%s\n", 0
section .rodata
LC17:
	db "==========================================================\n\033[0m", 0
LC18:
	db "\033[1;34m\n>>> [SYSTEM] Upgrading binary packages (pacman -Syu)...\n\033[0m", 0
section .rodata
LC19:
	db "%spacman -Syu%s", 0
section .rodata
LC20:
	db "\033[1;31m[-] pacman -Syu failed (exit %d). Not rebuilding the world set on\n    top of a half-updated system. Fix the upgrade, then retry.\n\033[0m", 0
LC21:
	db "\033[1;32m[+] Binary packages up to date.\n\033[0m", 0
LC22:
	db "\033[1;34m>>> [AUR] Refresh enabled for AUR-backed  packages.\n\033[0m", 0
LC23:
	db "\033[1;33m>>> [AUR] Refresh disabled; reusing local AUR checkouts.\n\033[0m", 0
LC24:
	db "\033[1;33m[-] No world file found.\n\033[0m", 0
LC25:
	db "\033[1;31m[-] Skipping invalid entry in world file: '%s'\n\033[0m", 0
LC26:
	db "\033[1;31m[-] Out of memory.\n\033[0m", 0
LC27:
	db "\033[1;33m[-] World file is empty.\n\033[0m", 0
LC28:
	db "\033[1;33m\n>>> [WORLD %zu/%zu] Rebuilding: %s\n\033[0m", 0
LC29:
	db "\033[1;32m>>> WORLD UPDATE COMPLETED (%zu packages)\n\033[0m", 0
section .rodata
LC30:
	db " %s", 0
section .rodata
LC31:
	db "\033[1;33m>>> WORLD UPDATE FINISHED: %zu succeeded, %zu FAILED\n\033[0m", 0
LC32:
	db "\033[1;35m\n==========================================================\n\033[0m", 0
section .rodata
LC33:
	db "\033[1;31m    Failed:\033[0m", 0
global cmd_world_update
cmd_world_update:
	push	r15
	mov	edi, LC14
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 536
	call	puts
	mov	esi, LC15
	mov	edi, LC16
	xor	eax, eax
	call	printf
	mov	edi, LC17
	xor	eax, eax
	call	printf
	call	get_sync
	test	eax, eax
	je	.L38
	mov	edi, LC18
	xor	eax, eax
	mov	ebp, LC13
	call	printf
	lea	rbx, [rsp+16]
	call	use_noconfirm
	test	eax, eax
	mov	eax, LC12
	cmovne	rbp, rax
	call	priv_prefix
	mov	rdi, rbx
	mov	edx, LC19
	mov	esi, 256
	mov	rcx, rax
	mov	r8, rbp
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	test	eax, eax
	jne	.L95
	mov	edi, LC21
	xor	eax, eax
	call	printf
.L38:
	call	get_aur_sync
	test	eax, eax
	jne	.L96
	mov	edi, LC23
	xor	eax, eax
	call	printf
.L43:
	mov	esi, LC0
	mov	edi, LC1
	call	fopen_nofollow
	mov	r12, rax
	test	rax, rax
	je	.L97
	xor	r14d, r14d
	xor	ebp, ebp
	lea	rbx, [rsp+16]
	xor	r13d, r13d
.L86:
	mov	rdx, r12
	mov	esi, 512
	mov	rdi, rbx
	call	fgets
	test	rax, rax
	je	.L51
	mov	esi, LC2
	mov	rdi, rbx
	call	strcspn
	mov	byte [rsp+16+rax], 0
	movzx	eax, byte [rsp+16]
	test	al, al
	je	.L86
	cmp	al, 35
	je	.L86
	mov	rdi, rbx
	call	valid_pkgname
	test	eax, eax
	je	.L98
	cmp	r14, rbp
	jne	.L72
	test	r14, r14
	je	.L73
	mov	rsi, r14
	add	r14, r14
	sal	rsi, 4
.L50:
	mov	rdi, r13
	call	realloc
	mov	r15, rax
	test	rax, rax
	je	.L99
.L49:
	mov	rdi, rbx
	call	strdup
	mov	qword [r15+rbp*8], rax
	test	rax, rax
	je	.L74
	add	rbp, 1
	mov	r13, r15
	jmp	.L86
.L96:
	mov	edi, LC22
	xor	eax, eax
	call	printf
	jmp	.L43
.L72:
	mov	r15, r13
	jmp	.L49
.L73:
	mov	esi, 128
	mov	r14d, 16
	jmp	.L50
.L98:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC25
	call	fprintf
	jmp	.L86
.L74:
	mov	r13, r15
.L51:
	mov	rdi, r12
	call	fclose
	test	rbp, rbp
	je	.L100
	mov	esi, 1
	mov	rdi, rbp
	xor	ebx, ebx
	xor	r14d, r14d
	call	calloc
	mov	qword [rsp+8], 0
	mov	r12, rax
	test	rax, rax
	jne	.L55
	jmp	.L58
.L102:
	add	qword [rsp+8], 1
	cmp	rbx, rbp
	je	.L101
.L55:
	mov	r15, qword [r13+0+rbx*8]
	add	rbx, 1
	mov	rdx, rbp
	xor	eax, eax
	mov	rsi, rbx
	mov	edi, LC28
	mov	rcx, r15
	call	printf
	mov	rdi, r15
	call	cmd_build
	mov	byte [r12-1+rbx], al
	test	eax, eax
	jne	.L102
	add	r14, 1
	cmp	rbx, rbp
	jne	.L55
.L101:
	xor	eax, eax
	mov	edi, LC32
	call	printf
	test	r14, r14
	jne	.L103
.L67:
	mov	rsi, qword [rsp+8]
	mov	edi, LC29
	xor	eax, eax
	xor	r14d, r14d
	call	printf
.L63:
	mov	rdi, r12
	mov	rbx, r13
	lea	rbp, [r13+0+rbp*8]
	call	free
.L66:
	mov	rdi, qword [rbx]
	add	rbx, 8
	call	free
	cmp	rbx, rbp
	jne	.L66
	mov	rdi, r13
	call	free
	xor	eax, eax
	test	r14, r14
	sete	al
.L37:
	add	rsp, 536
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L100:
	mov	edi, LC27
	xor	eax, eax
	call	printf
	mov	rdi, r13
	call	free
	xor	eax, eax
	jmp	.L37
.L103:
	mov	rsi, qword [rsp+8]
	mov	rdx, r14
	mov	edi, LC31
	xor	eax, eax
	xor	ebx, ebx
	call	printf
	mov	edi, LC33
	xor	eax, eax
	call	printf
	jmp	.L65
.L64:
	add	rbx, 1
	cmp	rbp, rbx
	je	.L104
.L65:
	cmp	byte [r12+rbx], 0
	jne	.L64
	mov	rsi, qword [r13+0+rbx*8]
	mov	edi, LC30
	xor	eax, eax
	add	rbx, 1
	call	printf
	cmp	rbp, rbx
	jne	.L65
.L104:
	mov	edi, 10
	call	putchar
	jmp	.L63
.L95:
	mov	rdi, qword [rel stderr]
	mov	edx, eax
	mov	esi, LC20
	xor	eax, eax
	call	fprintf
	xor	eax, eax
	jmp	.L37
.L97:
	mov	edx, 36
	mov	esi, 1
	mov	edi, LC24
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	jmp	.L37
.L106:
	add	r14, 1
.L57:
	cmp	rbp, rbx
	je	.L105
.L58:
	mov	r15, qword [r13+0+rbx*8]
	add	rbx, 1
	mov	edi, LC28
	xor	eax, eax
	mov	rdx, rbp
	mov	rsi, rbx
	mov	rcx, r15
	call	printf
	mov	rdi, r15
	call	cmd_build
	test	eax, eax
	je	.L106
	add	qword [rsp+8], 1
	jmp	.L57
.L99:
	mov	edx, 30
	mov	esi, 1
	mov	edi, LC26
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L51
.L105:
	xor	eax, eax
	mov	edi, LC32
	call	printf
	test	r14, r14
	je	.L67
	mov	rsi, qword [rsp+8]
	mov	rdx, r14
	mov	edi, LC31
	xor	eax, eax
	call	printf
	jmp	.L63
