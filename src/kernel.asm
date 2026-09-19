; kernel.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern exit
extern file_exists
extern fwrite
extern have_cmd
extern printf
extern priv_prefix
extern run_cmd
extern run_cmd_quiet
extern stderr
extern strcmp
extern strlen
extern strncmp
extern xsnprintf
; NASM assembly - converted from C: src/kernel.c
%use smartalign
section .text
section .rodata
LC0:
	db "%s%s", 0
run_priv_cmd:
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 520
	call	priv_prefix
	mov	r8, rbx
	mov	rdi, rsp
	mov	edx, LC0
	mov	rcx, rax
	mov	esi, 512
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd
	add	rsp, 520
	pop	rbx
	pop	rbp
	ret
section .rodata
LC1:
	db "linux", 0
LC2:
	db "linux-", 0
LC3:
	db "firmware", 0
LC4:
	db "api-headers", 0
LC5:
	db "tools", 0
LC6:
	db "docs", 0
LC7:
	db "wifi", 0
LC8:
	db "-headers", 0
LC9:
	db "-docs", 0
LC10:
	db "-firmware", 0
LC11:
	db "-whence", 0
global is_kernel
is_kernel:
	push	rbp
	mov	esi, LC1
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	call	strcmp
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	je	.L4
	mov	edx, 6
	mov	esi, LC2
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L19
	cmp	byte [rbx+6], 0
	je	.L4
	lea	rbp, [rbx+6]
	mov	edx, 8
	mov	esi, LC3
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L6
	movzx	edx, byte [rbx+14]
	cmp	dl, 45
	je	.L4
	test	dl, dl
	je	.L4
.L6:
	mov	edx, 11
	mov	esi, LC4
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L7
	movzx	edx, byte [rbx+17]
	test	dl, dl
	je	.L4
	cmp	dl, 45
	je	.L4
.L7:
	mov	edx, 5
	mov	esi, LC5
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L8
	movzx	edx, byte [rbx+11]
	test	dl, dl
	je	.L4
	cmp	dl, 45
	je	.L4
.L8:
	mov	edx, 4
	mov	esi, LC6
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L9
.L41:
	movzx	edx, byte [rbx+10]
	test	dl, dl
	je	.L4
	cmp	dl, 45
	je	.L4
.L10:
	cmp	byte [rbx+6], 97
	jne	.L12
	cmp	byte [rbp+1], 116
	jne	.L12
	movzx	eax, byte [rbp+2]
	sub	eax, 109
	jne	.L12
	movzx	edx, byte [rbx+9]
	test	dl, dl
	je	.L4
	cmp	dl, 45
	je	.L4
.L12:
	mov	rdi, rbx
	call	strlen
	mov	rbp, rax
	cmp	rax, 8
	jbe	.L13
	lea	rdi, [rbx-8+rax]
	mov	esi, LC8
	call	strcmp
	test	eax, eax
	je	.L4
	lea	rdi, [rbx-5+rbp]
	mov	esi, LC9
	call	strcmp
	test	eax, eax
	je	.L4
	cmp	rbp, 9
	jne	.L42
.L16:
	lea	rdi, [rbx-7+rbp]
	mov	esi, LC11
	call	strcmp
	test	eax, eax
	setne	al
	movzx	eax, al
.L4:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L19:
	add	rsp, 8
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
.L9:
	mov	edx, 4
	mov	esi, LC7
	mov	rdi, rbp
	call	strncmp
	test	eax, eax
	jne	.L10
	jmp	.L41
.L13:
	cmp	rax, 5
	ja	.L15
.L20:
	mov	eax, 1
	jmp	.L4
.L42:
	lea	rdi, [rbx-9+rbp]
	mov	esi, LC10
	call	strcmp
	test	eax, eax
	je	.L4
	jmp	.L16
.L15:
	lea	rdi, [rbx-5+rax]
	mov	esi, LC9
	call	strcmp
	test	eax, eax
	je	.L4
	cmp	rbp, 8
	jne	.L20
	jmp	.L16
section .rodata
LC12:
	db "/usr/local/emerge/builds", 0
section .rodata
LC13:
	db 'for f in ''%s/%s''/*.pkg.tar.*; do [ -e "$f" ] || continue; tar -tf "$f" 2>/dev/null | grep -q ''^[./]*usr/lib/modules/.*/vmlinuz'' && exit 0; done; exit 1', 0
global pkg_ships_kernel
pkg_ships_kernel:
	push	rbx
	mov	r8, rdi
	mov	ecx, LC12
	mov	edx, LC13
	mov	esi, 1024
	xor	eax, eax
	sub	rsp, 1024
	mov	rdi, rsp
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd_quiet
	test	eax, eax
	sete	al
	add	rsp, 1024
	movzx	eax, al
	pop	rbx
	ret
section .rodata
LC14:
	db "\033[1;35m>>> [KERNEL HOOK] Kernel detected: %s\n\033[0m", 0
section .rodata
LC15:
	db "mkinitcpio", 0
section .rodata
LC16:
	db "\033[1;34m>>> [KERNEL HOOK] Generating initramfs (mkinitcpio -P)...\n\033[0m", 0
section .rodata
LC17:
	db "mkinitcpio -P", 0
section .rodata
LC18:
	db "\033[1;31m[-] mkinitcpio failed -- do NOT reboot yet.\n\033[0m", 0
section .rodata
LC19:
	db "dracut", 0
section .rodata
LC20:
	db "\033[1;34m>>> [KERNEL HOOK] Generating initramfs (dracut)...\n\033[0m", 0
LC21:
	db "dracut --regenerate-all --force", 0
LC22:
	db "\033[1;31m[-] dracut failed -- do NOT reboot yet.\n\033[0m", 0
section .rodata
LC23:
	db "grub-mkconfig", 0
LC24:
	db "/boot/grub", 0
section .rodata
LC25:
	db "\033[1;34m>>> [KERNEL HOOK] Updating GRUB...\n\033[0m", 0
LC26:
	db "grub-mkconfig -o /boot/grub/grub.cfg", 0
LC27:
	db "\033[1;31m[-] grub-mkconfig failed.\n\033[0m", 0
section .rodata
LC28:
	db "/boot/loader/entries", 0
LC29:
	db "bootctl", 0
section .rodata
LC30:
	db "\033[1;34m>>> [KERNEL HOOK] systemd-boot detected.\n\033[0m", 0
section .rodata
LC31:
	db "bootctl update || true", 0
LC32:
	db "/boot/refind_linux.conf", 0
section .rodata
LC33:
	db "\033[1;33m[!] rEFInd detected -- verify /boot/refind_linux.conf.\n\033[0m", 0
section .rodata
LC34:
	db "/boot/EFI/refind", 0
LC35:
	db "/boot/limine.conf", 0
section .rodata
LC36:
	db "\033[1;33m[!] Limine detected -- verify your limine config.\n\033[0m", 0
section .rodata
LC37:
	db "/boot/limine.cfg", 0
section .rodata
LC38:
	db "\033[1;33m[!] No known bootloader found. Update your boot entries manually.\n\033[0m", 0
section .rodata
LC39:
	db "sbctl", 0
section .rodata
LC40:
	db "\033[1;33m[!] sbctl present: re-sign the new kernel if Secure Boot is on.\n\033[0m", 0
LC41:
	db "\033[1;32m[+] Kernel hooks processed.\n\033[0m", 0
global run_kernel_hooks
run_kernel_hooks:
	push	rbx
	mov	rsi, rdi
	xor	eax, eax
	mov	edi, LC14
	call	printf
	mov	edi, LC15
	call	have_cmd
	test	eax, eax
	je	.L46
	mov	edi, LC16
	xor	eax, eax
	call	printf
	mov	edi, LC17
	call	run_priv_cmd
	test	eax, eax
	jne	.L81
.L48:
	mov	edi, LC23
	call	have_cmd
	test	eax, eax
	jne	.L50
.L52:
	xor	ebx, ebx
.L51:
	mov	edi, LC28
	call	dir_exists
	test	eax, eax
	jne	.L82
.L57:
	mov	edi, LC32
	call	file_exists
	test	eax, eax
	jne	.L60
	mov	edi, LC34
	call	dir_exists
	test	eax, eax
	jne	.L60
.L59:
	mov	edi, LC35
	call	file_exists
	test	eax, eax
	jne	.L63
	mov	edi, LC37
	call	file_exists
	test	eax, eax
	je	.L83
.L63:
	mov	edi, LC36
	xor	eax, eax
	call	printf
.L62:
	mov	edi, LC39
	call	have_cmd
	test	eax, eax
	jne	.L84
	mov	edi, LC41
	xor	eax, eax
	pop	rbx
	jmp	printf
.L60:
	mov	edi, LC33
	xor	eax, eax
	mov	ebx, 1
	call	printf
	jmp	.L59
.L46:
	mov	edi, LC19
	call	have_cmd
	test	eax, eax
	je	.L48
	mov	edi, LC20
	xor	eax, eax
	call	printf
	mov	edi, LC21
	call	run_priv_cmd
	test	eax, eax
	je	.L48
	mov	edx, 51
	mov	esi, 1
	mov	edi, LC22
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L48
.L50:
	mov	edi, LC24
	call	dir_exists
	test	eax, eax
	je	.L52
	mov	edi, LC25
	xor	eax, eax
	call	printf
	mov	edi, LC26
	call	run_priv_cmd
	test	eax, eax
	jne	.L53
.L54:
	mov	ebx, 1
	jmp	.L51
.L83:
	test	ebx, ebx
	jne	.L62
	mov	edx, 77
	mov	esi, 1
	mov	edi, LC38
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L62
.L82:
	mov	edi, LC29
	call	have_cmd
	test	eax, eax
	je	.L57
	mov	edi, LC30
	xor	eax, eax
	mov	ebx, 1
	call	printf
	mov	edi, LC31
	call	run_priv_cmd
	jmp	.L57
.L84:
	mov	edi, LC40
	xor	eax, eax
	call	printf
	mov	edi, LC41
	xor	eax, eax
	pop	rbx
	jmp	printf
.L81:
	mov	edi, LC18
	mov	edx, 55
	mov	esi, 1
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	edi, LC23
	call	have_cmd
	test	eax, eax
	je	.L52
	jmp	.L50
.L53:
	mov	edx, 37
	mov	esi, 1
	mov	edi, LC27
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L54
