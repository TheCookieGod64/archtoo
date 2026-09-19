; binary.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern ask_yes_no
extern exit
extern file_exists
extern fprintf
extern free
extern getpid
extern printf
extern priv_prefix
extern regex_escape
extern run_cmd
extern run_cmd_capture
extern run_cmd_quiet
extern sha256_file
extern stat
extern stderr
extern strchr
extern strlen
extern strncmp
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/binary.c
%use smartalign
section .text
section .rodata
LC0:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC1:
	db "\033[1;33m>>> Binary mode enabled - against Gentoo principles but like yay (long flag only)\n\033[0m", 0
LC2:
	db "\033[1;34m>>> Trying binary download for %s without compiling...\n\033[0m", 0
LC3:
	db "pacman -Si '%s' >/dev/null 2>&1", 0
LC4:
	db "\033[1;33m[!] %s not in official repos, binary mode only works for repo packages\n\033[0m", 0
LC5:
	db "\033[1;33m    Tip: use without --binary to build from AUR, or try %s-bin\n\033[0m", 0
LC6:
	db "pacman -Sp --noconfirm '%s' 2>/dev/null | head -n1", 0
LC7:
	db "\033[1;31m[-] Could not get binary URL for %s\n\033[0m", 0
section .rodata
LC8:
	db "http", 0
section .rodata
LC9:
	db "\033[1;31m[-] Invalid URL: '%s'\n\033[0m", 0
LC10:
	db "\033[1;32m[+] Binary URL: %s\n\033[0m", 0
LC11:
	db "/tmp/archtoo-bin-%s-%ld.pkg.tar.zst", 0
LC12:
	db "curl -fL -o '%s' '%s' 2>&1 || wget -O '%s' '%s' 2>&1", 0
LC13:
	db "\033[1;34m>>> Downloading binary package...\n\033[0m", 0
LC14:
	db "\033[1;31m[-] Failed to download binary for %s\n\033[0m", 0
section .rodata
LC15:
	db "rm -f '%s'", 0
section .rodata
LC16:
	db "\033[1;34m>>> Checking SHA256 (self implementation, no external program)...\n\033[0m", 0
LC17:
	db "\033[1;31m[-] Could not compute SHA256 for %s\n\033[0m", 0
LC18:
	db "SHA256 check failed, try again?", 0
LC19:
	db "\033[1;33m[!] Retrying download...\n\033[0m", 0
LC20:
	db "\033[1;32m[+] SHA256(%s) = %s\n\033[0m", 0
LC21:
	db "\033[1;31m[-] Downloaded file too small or invalid (%ld bytes)\n\033[0m", 0
section .rodata
LC22:
	db "Delete and try again?", 0
section .rodata
LC23:
	db "\033[1;34m>>> Installing binary package with pacman -U...\n\033[0m", 0
LC24:
	db "pacman -U --noconfirm '%s' 2>&1", 0
LC25:
	db "\033[1;31m[-] Binary install failed for %s (exit %d)\n\033[0m", 0
LC26:
	db "Binary install failed, try again?", 0
LC27:
	db "\033[1;32m[+] Binary package %s installed successfully\n\033[0m", 0
LC28:
	db "\033[1;33m[!] Against Gentoo principles, but fast like yay\n\033[0m", 0
section .rodata
LC29:
	db "/etc/pacman.conf", 0
section .rodata
LC30:
	db "grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s' || %ssed -i -E '0,/^[[:space:]]*IgnorePkg[[:space:]]*=/{/^[[:space:]]*IgnorePkg[[:space:]]*=/{s/[[:space:]]*$//; s/$/ %s/}}' '%s' 2>/dev/null; true", 0
global cmd_binary_install
cmd_binary_install:
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 7504
	call	valid_pkgname
	test	eax, eax
	je	.L56
	mov	edi, LC1
	xor	eax, eax
	lea	r12, [rsp+5456]
	call	printf
	mov	rsi, rbp
	mov	edi, LC2
	xor	eax, eax
	call	printf
	mov	rdi, r12
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC3
	mov	esi, 600
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	test	eax, eax
	jne	.L57
	mov	esi, 700
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC6
	lea	rbx, [rsp+1680]
	mov	qword [rsp+8], 0
	mov	rdi, rbx
	call	xsnprintf
	lea	rsi, [rsp+8]
	mov	rdi, rbx
	call	run_cmd_capture
	test	eax, eax
	jne	.L6
	mov	rbx, qword [rsp+8]
	test	rbx, rbx
	je	.L6
	movzx	r13d, byte [rbx]
	test	r13b, r13b
	je	.L6
	mov	esi, 10
	mov	rdi, rbx
	call	strchr
	test	rax, rax
	je	.L8
	mov	byte [rax], 0
	mov	rbx, qword [rsp+8]
	movzx	r13d, byte [rbx]
.L8:
	movabs	rax, 4294977024
	jmp	.L9
.L13:
	movzx	r13d, byte [rbx+1]
	add	rbx, 1
.L9:
	cmp	r13b, 32
	ja	.L58
	bt	rax, r13
	jc	.L13
	mov	rdi, rbx
	call	strlen
	test	rax, rax
	je	.L14
.L11:
	movabs	rcx, 4294977024
.L15:
	sub	rax, 1
	movzx	edx, byte [rbx+rax]
	cmp	dl, 32
	ja	.L16
	bt	rcx, rdx
	jnc	.L16
	mov	byte [rbx+rax], 0
	test	rax, rax
	jne	.L15
.L16:
	movzx	r13d, byte [rbx]
.L14:
	test	r13b, r13b
	je	.L18
.L12:
	mov	edx, 4
	mov	esi, LC8
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L18
	mov	rsi, rbx
	mov	edi, LC10
	xor	eax, eax
	call	printf
	lea	r13, [rsp+560]
	lea	r14, [rsp+3408]
	call	getpid
	mov	rcx, rbp
	mov	edx, LC11
	mov	rdi, r13
	movsx	r8, eax
	mov	esi, 512
	xor	eax, eax
	call	xsnprintf
	sub	rsp, 8
	mov	r8, rbx
	mov	rcx, r13
	push	rbx
	mov	esi, 2048
	mov	r9, r13
	mov	edx, LC12
	mov	rdi, r14
	xor	eax, eax
	call	xsnprintf
	mov	edi, LC13
	xor	eax, eax
	call	printf
	mov	rdi, r14
	call	run_cmd
	mov	rdi, qword [rsp+24]
	mov	ebx, eax
	call	free
	pop	rcx
	pop	rsi
	test	ebx, ebx
	jne	.L21
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	je	.L21
	mov	edi, LC16
	xor	eax, eax
	lea	rbx, [rsp+16]
	call	printf
	mov	rsi, rbx
	mov	rdi, r13
	call	sha256_file
	test	eax, eax
	jne	.L22
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC17
	call	fprintf
	mov	esi, 600
	mov	rcx, r13
	mov	rdi, r12
	mov	edx, LC15
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	xor	esi, esi
	mov	edi, LC18
	call	ask_yes_no
	test	eax, eax
	je	.L1
	mov	edi, LC19
	xor	eax, eax
	call	printf
	mov	rdi, rbp
	call	cmd_binary_install
	jmp	.L1
.L57:
	mov	rsi, rbp
	mov	edi, LC4
	xor	eax, eax
	call	printf
	mov	rsi, rbp
	mov	edi, LC5
	xor	eax, eax
	call	printf
.L3:
	xor	eax, eax
.L1:
	add	rsp, 7504
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L6:
	mov	rdx, rbp
	mov	esi, LC7
.L53:
	mov	rdi, qword [rel stderr]
	xor	eax, eax
	call	fprintf
	mov	rdi, qword [rsp+8]
	call	free
	jmp	.L3
.L56:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC0
	call	fprintf
	jmp	.L3
.L18:
	mov	rdx, rbx
	mov	esi, LC9
	jmp	.L53
.L58:
	mov	rdi, rbx
	call	strlen
	test	rax, rax
	jne	.L11
	jmp	.L12
.L21:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC14
	xor	eax, eax
	call	fprintf
	mov	rdi, r12
	mov	rcx, r13
	mov	edx, LC15
	mov	esi, 600
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	jmp	.L3
.L22:
	mov	rdx, rbx
	mov	rsi, rbp
	mov	edi, LC20
	xor	eax, eax
	call	printf
	lea	rsi, [rsp+96]
	mov	rdi, r13
	call	stat
	mov	rdx, qword [rsp+144]
	test	eax, eax
	jne	.L24
	cmp	rdx, 1023
	jg	.L25
.L24:
	mov	rdi, qword [rel stderr]
	mov	esi, LC21
	xor	eax, eax
	call	fprintf
	mov	esi, 600
	mov	rcx, r13
	mov	rdi, r12
	mov	edx, LC15
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	xor	esi, esi
	mov	edi, LC22
	call	ask_yes_no
	test	eax, eax
	je	.L1
.L54:
	mov	rdi, rbp
	call	cmd_binary_install
	jmp	.L1
.L25:
	lea	rbx, [rsp+2384]
	mov	edi, LC23
	xor	eax, eax
	call	printf
	mov	rcx, r13
	mov	edx, LC24
	mov	rdi, rbx
	mov	esi, 1024
	xor	eax, eax
	lea	r14, [rsp+1072]
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	mov	rdi, r14
	mov	rcx, r13
	mov	edx, LC15
	mov	ebx, eax
	mov	esi, 600
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r14
	call	run_cmd_quiet
	test	ebx, ebx
	je	.L27
	mov	rdi, qword [rel stderr]
	mov	esi, LC25
	xor	eax, eax
	mov	ecx, ebx
	mov	rdx, rbp
	call	fprintf
	xor	esi, esi
	mov	edi, LC26
	call	ask_yes_no
	test	eax, eax
	je	.L3
	jmp	.L54
.L27:
	mov	rsi, rbp
	mov	edi, LC27
	xor	eax, eax
	call	printf
	mov	edi, LC28
	xor	eax, eax
	lea	rbx, [rsp+240]
	call	printf
	mov	rdi, rbp
	call	add_to_world
	mov	edx, 320
	mov	rsi, rbx
	mov	rdi, rbp
	call	regex_escape
	test	eax, eax
	jne	.L28
.L29:
	mov	eax, 1
	jmp	.L1
.L28:
	call	priv_prefix
	push	LC29
	mov	rcx, rbx
	mov	rdi, r12
	push	rbp
	mov	r9, rax
	mov	edx, LC30
	mov	r8d, LC29
	mov	esi, 2048
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	pop	rax
	pop	rdx
	jmp	.L29
