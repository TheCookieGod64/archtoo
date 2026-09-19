; gentoo_chroot.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern file_exists
extern fprintf
extern free
extern fwrite
extern get_jobs
extern getpid
extern printf
extern priv_prefix
extern run_cmd
extern run_cmd_capture
extern run_cmd_quiet
extern sigaction
extern sigemptyset
extern stderr
extern strchr
extern strlen
extern strncmp
extern strstr
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/gentoo_chroot.c
%use smartalign
section .text
chroot_signal_handler:
	mov	dword [rel g_chroot_interrupted], 1
	ret
section .rodata
LC0:
	db "\033[1;34m>>> Mounting chroot...\n\033[0m", 0
section .rodata
LC1:
	db "%s", 0
section .rodata
LC2:
	db "ev/null; mount -t tmpfs tmpfs '%s/tmp' 2>/dev/null; mkdir -p '%s/%s' '%s/%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mkdir -p '%s/%s' && touch '%s/%s' && mount --bind '%s' '%s/%s' 2>/dev/null; true", 0
section .rodata
LC3:
	db "/usr/local/emerge/world", 0
LC4:
	db "/usr/local/emerge/backups", 0
LC5:
	db "/usr/local/emerge/builds", 0
LC6:
	db "/usr/local/emerge", 0
section .rodata
LC7:
	db "\033[1;33m[!] Some mounts failed (maybe already mounted or no permission), continuing\n\033[0m", 0
gentoo_chroot_mount.part.0:
	push	rbp
	xor	eax, eax
	push	rbx
	mov	rbx, rdi
	mov	edi, LC0
	sub	rsp, 4104
	call	printf
	mov	rcx, rbx
	mov	edx, LC1
	xor	eax, eax
	mov	esi, 512
	mov	edi, g_chroot_path_store
	mov	rbp, rsp
	call	xsnprintf
	call	priv_prefix
	sub	rsp, 8
	mov	rdi, rbp
	mov	r9, rbx
	push	LC3
	mov	rcx, rax
	mov	r8, rbx
	xor	eax, eax
	push	rbx
	mov	edx, LC2
	mov	esi, 4096
	push	LC3
	push	LC3
	push	rbx
	push	LC3
	push	rbx
	push	LC4
	push	rbx
	push	LC4
	push	LC5
	push	rbx
	push	LC5
	push	LC6
	push	rbx
	push	LC4
	push	rbx
	push	LC5
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	call	xsnprintf
	mov	rsp, rbp
	mov	rdi, rbp
	call	run_cmd
	test	eax, eax
	jne	.L9
	add	rsp, 4104
	mov	eax, 1
	pop	rbx
	pop	rbp
	ret
.L9:
	mov	edx, 87
	mov	esi, 1
	mov	edi, LC7
	mov	rcx, qword [rel stderr]
	call	fwrite
	add	rsp, 4104
	mov	eax, 1
	pop	rbx
	pop	rbp
	ret
section .rodata
LC8:
	db "%s/etc/gentoo-release", 0
LC9:
	db "%s/etc/os-release", 0
section .rodata
LC10:
	db "grep -q Gentoo '%s' 2>/dev/null", 0
global gentoo_chroot_exists
gentoo_chroot_exists:
	test	rdi, rdi
	je	.L21
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 2184
	cmp	byte [rdi], 0
	jne	.L22
.L13:
	xor	eax, eax
.L10:
	add	rsp, 2184
	pop	rbx
	pop	rbp
	ret
.L22:
	mov	rcx, rdi
	mov	edx, LC8
	mov	esi, 1024
	mov	rdi, rsp
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rsp
	call	file_exists
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	jne	.L10
	mov	rdi, rsp
	xor	eax, eax
	mov	rcx, rbx
	mov	edx, LC9
	mov	esi, 1024
	call	xsnprintf
	mov	rdi, rsp
	call	file_exists
	test	eax, eax
	je	.L13
	mov	rcx, rsp
	mov	edx, LC10
	mov	esi, 1150
	xor	eax, eax
	lea	rbx, [rsp+1024]
	mov	rdi, rbx
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd_quiet
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L10
.L21:
	xor	eax, eax
	ret
section .rodata
LC11:
	db "(null)", 0
LC12:
	db "root", 0
section .rodata
LC13:
	db "\033[1;31m[-] Invalid chroot path: %s\n\033[0m", 0
LC14:
	db "\033[1;32m[+] Gentoo chroot already exists at %s (persistent mode)\n\033[0m", 0
LC15:
	db "\033[1;36m>>> Initializing chroot at %s...\n\033[0m", 0
section .rodata
LC16:
	db "%smkdir -p '%s'", 0
section .rodata
LC17:
	db "\033[1;31m[-] Cannot create chroot dir %s\n\033[0m", 0
LC18:
	db "\033[1;34m>>> Fetching latest Gentoo stage3 URL...\n\033[0m", 0
LC19:
	db "curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt 2>/dev/null | grep -E 'stage3-amd64-openrc.*\\.tar\\.xz' | grep -v '^#' | grep -v 'BEGIN' | head -n1 | awk '{print $1}'", 0
section .rodata
LC20:
	db "BEGIN", 0
LC21:
	db ".tar", 0
LC22:
	db "https://", 0
section .rodata
LC23:
	db "https://distfiles.gentoo.org/releases/amd64/autobuilds/%s", 0
LC24:
	db "\033[1;32m[+] Latest stage3: %s\n\033[0m", 0
LC25:
	db "\033[1;33m[!] Could not fetch latest list, using fallback\n\033[0m", 0
LC26:
	db "https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/stage3-amd64-openrc-latest.tar.xz", 0
LC27:
	db "curl -fsI '%s' >/dev/null 2>&1 && echo ok || echo fail", 0
section .rodata
LC28:
	db "ok", 0
section .rodata
LC29:
	db "\033[1;33m[!] Fallback not reachable, trying alt\n\033[0m", 0
LC30:
	db "curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/ 2>/dev/null | grep -oE 'stage3-amd64-openrc-[0-9TZ]+\\.tar\\.xz' | head -n1", 0
section .rodata
LC31:
	db ".tar.xz", 0
section .rodata
LC32:
	db "https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/%s", 0
LC33:
	db "\033[1;32m[+] Alternative stage3: %s\n\033[0m", 0
section .rodata
LC34:
	db "/tmp/gentoo-stage3-%ld.tar.xz", 0
section .rodata
LC35:
	db "\033[1;34m>>> Downloading stage3 (this may take a while)...\n\033[0m", 0
LC36:
	db "curl -fL -o '%s' '%s' || wget -O '%s' '%s'", 0
LC37:
	db "\033[1;31m[-] Failed to download stage3 from %s\n\033[0m", 0
LC38:
	db "\033[1;33m    Try manually: curl -o %s %s\n\033[0m", 0
LC39:
	db "\033[1;34m>>> Extracting stage3 to %s...\n\033[0m", 0
LC40:
	db "%star -xpf '%s' -C '%s' --xattrs-include='*.*' --numeric-owner 2>&1 | head -n 20", 0
section .rodata
LC41:
	db "rm -f '%s'", 0
section .rodata
LC42:
	db "\033[1;31m[-] Failed to extract stage3\n\033[0m", 0
LC43:
	db "\033[1;34m>>> Setting up chroot basics...\n\033[0m", 0
LC44:
	db "%smkdir -p '%s/proc' '%s/sys' '%s/dev' '%s/tmp' '%s/run' '%s/%s' '%s/%s' '%s/var/db/repos/gentoo' && %scp -L /etc/resolv.conf '%s/etc/resolv.conf' 2>/dev/null; %schown -R '%s' '%s' 2>/dev/null; true", 0
LC45:
	db "\033[1;34m>>> Fixing Portage profile and repos...\n\033[0m", 0
LC46:
	db 'ile;   else     prof=$(ls -d /var/db/repos/gentoo/profiles/default/linux/amd64/* 2>/dev/null | head -n1);     if [ -n "$prof" ]; then ln -sf $prof /etc/portage/make.profile; fi;   fi; fi; ls -l /etc/portage/make.profile 2>/dev/null; true'' 2>&1 | head -n 20', 0
LC47:
	db "\033[1;34m>>> Syncing Gentoo repos inside chroot (emerge-webrsync fallback)...\n\033[0m", 0
LC48:
	db "f [ ! -L /etc/portage/make.profile ]; then   eselect profile set 1 2>/dev/null || eselect profile set default/linux/amd64/23.0 2>/dev/null || true; fi; '; umount -l '%s/proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; true", 0
LC49:
	db "\033[1;33m[!] Chroot init finished but gentoo-release not found, may still work\n\033[0m", 0
LC50:
	db "\033[1;32m[+] Gentoo chroot initialized at %s\n\033[0m", 0
LC51:
	db "\033[1;33m[!] If repo still fails, run manually: sudo chroot %s emerge --sync\n\033[0m", 0
global gentoo_chroot_init
gentoo_chroot_init:
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 6368
	test	rdi, rdi
	je	.L55
	mov	rbx, rdi
	call	valid_gentoo_chroot_path
	test	eax, eax
	jne	.L86
.L24:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC13
	xor	eax, eax
	call	fprintf
.L26:
	add	rsp, 6368
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L86:
	mov	rdi, rbx
	call	gentoo_chroot_exists
	mov	rsi, rbx
	test	eax, eax
	jne	.L87
	mov	edi, LC15
	xor	eax, eax
	lea	rbp, [rsp+2272]
	call	printf
	call	priv_prefix
	mov	rdi, rbp
	mov	r8, rbx
	mov	edx, LC16
	mov	rcx, rax
	mov	esi, 4096
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	test	eax, eax
	jne	.L88
	mov	edi, LC18
	xor	eax, eax
	lea	r13, [rsp+48]
	call	printf
	mov	edi, LC19
	lea	rsi, [rsp+24]
	mov	qword [rsp+24], 0
	call	run_cmd_capture
	mov	ecx, 128
	mov	rdi, r13
	mov	r12, qword [rsp+24]
	mov	edx, eax
	xor	eax, eax
	rep stosq
	test	edx, edx
	jne	.L84
	test	r12, r12
	je	.L32
	movabs	rdx, 4294977024
	movzx	eax, byte [r12]
	test	al, al
	je	.L84
.L33:
	cmp	al, 32
	ja	.L34
	bt	rdx, rax
	jnc	.L34
	movzx	eax, byte [r12+1]
	add	r12, 1
	test	al, al
	jne	.L33
.L34:
	mov	rdi, r12
	call	strlen
	movabs	rcx, 4294977024
	test	rax, rax
	je	.L37
.L36:
	sub	rax, 1
	movzx	edx, byte [r12+rax]
	cmp	dl, 32
	ja	.L37
	bt	rcx, rdx
	jnc	.L37
	mov	byte [r12+rax], 0
	test	rax, rax
	jne	.L36
.L37:
	mov	esi, LC20
	mov	rdi, r12
	call	strstr
	test	rax, rax
	je	.L40
.L41:
	mov	rdi, qword [rsp+24]
	call	free
	mov	qword [rsp+24], 0
	jmp	.L32
.L88:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC17
	xor	eax, eax
	call	fprintf
	jmp	.L26
.L84:
	mov	rdi, r12
	call	free
	mov	qword [rsp+24], 0
.L32:
	mov	edi, LC25
	xor	eax, eax
	lea	r12, [rsp+1072]
	call	printf
	mov	edx, LC26
	mov	rdi, r13
	xor	eax, eax
	mov	esi, 1024
	call	xsnprintf
	mov	rcx, r13
	mov	edx, LC27
	mov	rdi, r12
	mov	esi, 1200
	xor	eax, eax
	call	xsnprintf
	lea	rsi, [rsp+32]
	mov	rdi, r12
	mov	qword [rsp+32], 0
	call	run_cmd_capture
	mov	r14, qword [rsp+32]
	test	eax, eax
	je	.L89
.L45:
	mov	rdi, r14
	call	free
	mov	edi, LC29
	xor	eax, eax
	call	printf
	mov	edi, LC30
	lea	rsi, [rsp+40]
	mov	qword [rsp+40], 0
	call	run_cmd_capture
	mov	r14, qword [rsp+40]
	mov	rdi, r14
	test	eax, eax
	jne	.L48
	test	r14, r14
	je	.L48
	cmp	byte [r14], 0
	je	.L48
	mov	esi, 10
	call	strchr
	test	rax, rax
	je	.L50
	mov	byte [rax], 0
	mov	r14, qword [rsp+40]
.L50:
	mov	rdi, r14
	mov	esi, LC31
	mov	qword [rsp+8], r14
	call	strstr
	mov	rdi, r14
	test	rax, rax
	je	.L48
	mov	rcx, r14
	mov	edx, LC32
	mov	esi, 1024
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	mov	edi, LC33
	mov	rsi, r13
	xor	eax, eax
	call	printf
	mov	rdi, qword [rsp+40]
.L48:
	call	free
.L44:
	call	getpid
	mov	edx, LC34
	mov	esi, 512
	mov	rdi, r12
	movsx	rcx, eax
	xor	eax, eax
	call	xsnprintf
	mov	edi, LC35
	xor	eax, eax
	call	printf
	sub	rsp, 8
	mov	rcx, r12
	mov	r9, r12
	push	r13
	mov	edx, LC36
	mov	r8, r13
	mov	esi, 4096
	mov	rdi, rbp
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	pop	rdx
	pop	rcx
	test	eax, eax
	jne	.L90
	mov	rsi, rbx
	mov	edi, LC39
	xor	eax, eax
	call	printf
	call	priv_prefix
	mov	r9, rbx
	mov	r8, r12
	mov	edx, LC40
	mov	rcx, rax
	mov	esi, 4096
	mov	rdi, rbp
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	rdi, rbp
	mov	rcx, r12
	mov	edx, LC41
	mov	r13d, eax
	mov	esi, 4096
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd_quiet
	test	r13d, r13d
	jne	.L91
	mov	edi, LC43
	xor	eax, eax
	mov	r14d, LC12
	call	printf
	call	build_user
	test	rax, rax
	je	.L53
	call	build_user
	mov	r14, rax
.L53:
	call	priv_prefix
	mov	r13, rax
	call	priv_prefix
	mov	r12, rax
	call	priv_prefix
	sub	rsp, 8
	mov	r9, rbx
	mov	r8, rbx
	push	rbx
	mov	rcx, rax
	mov	edx, LC44
	mov	esi, 4096
	push	r14
	mov	rdi, rbp
	xor	eax, eax
	push	r13
	push	rbx
	push	r12
	push	rbx
	push	LC4
	push	rbx
	push	LC5
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	call	xsnprintf
	add	rsp, 112
	mov	rdi, rbp
	call	run_cmd
	mov	edi, LC45
	xor	eax, eax
	call	printf
	call	priv_prefix
	mov	r8, rbx
	mov	edx, LC46
	mov	rdi, rbp
	mov	rcx, rax
	mov	esi, 4096
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	edi, LC47
	xor	eax, eax
	call	printf
	call	priv_prefix
	sub	rsp, 8
	mov	r9, rbx
	mov	r8, rbx
	push	rbx
	mov	rcx, rax
	mov	edx, LC48
	mov	esi, 4096
	push	rbx
	mov	rdi, rbp
	xor	eax, eax
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	call	xsnprintf
	add	rsp, 64
	mov	rdi, rbp
	call	run_cmd
	mov	rdi, rbx
	call	gentoo_chroot_exists
	test	eax, eax
	je	.L92
.L54:
	mov	rsi, rbx
	mov	edi, LC50
	xor	eax, eax
	call	printf
	mov	rsi, rbx
	mov	edi, LC51
	xor	eax, eax
	call	printf
	jmp	.L28
.L55:
	mov	ebx, LC11
	jmp	.L24
.L87:
	mov	edi, LC14
	xor	eax, eax
	call	printf
.L28:
	add	rsp, 6368
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L89:
	test	r14, r14
	je	.L45
	mov	esi, LC28
	mov	rdi, r14
	call	strstr
	test	rax, rax
	je	.L45
	mov	rdi, r14
	call	free
	jmp	.L44
.L90:
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC37
	xor	eax, eax
	call	fprintf
	mov	rcx, r13
	mov	rdx, r12
	mov	esi, LC38
	mov	rdi, qword [rel stderr]
	xor	eax, eax
	call	fprintf
	jmp	.L26
.L91:
	mov	edx, 40
	mov	esi, 1
	mov	edi, LC42
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L26
.L92:
	mov	edx, 81
	mov	esi, 1
	mov	edi, LC49
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L54
.L40:
	mov	esi, LC21
	mov	rdi, r12
	call	strstr
	test	rax, rax
	je	.L41
	mov	rdi, r12
	call	strlen
	cmp	rax, 10
	jbe	.L41
	mov	edx, 8
	mov	esi, LC22
	mov	rdi, r12
	call	strncmp
	mov	rcx, r12
	test	eax, eax
	jne	.L42
	mov	edx, LC1
	mov	esi, 1024
	mov	rdi, r13
	call	xsnprintf
.L43:
	mov	rsi, r13
	mov	edi, LC24
	xor	eax, eax
	call	printf
	mov	rdi, qword [rsp+24]
	lea	r12, [rsp+1072]
	call	free
	mov	qword [rsp+24], 0
	jmp	.L44
.L42:
	mov	edx, LC23
	mov	esi, 1024
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	jmp	.L43
global gentoo_chroot_mount
gentoo_chroot_mount:
	test	rdi, rdi
	je	.L97
	sub	rsp, 8
	call	gentoo_chroot_mount.part.0
	mov	eax, 1
	add	rsp, 8
	ret
.L97:
	xor	eax, eax
	ret
section .rodata
LC52:
	db "\033[1;34m>>> Unmounting...\n\033[0m", 0
section .rodata
LC53:
	db "ount -l '%s/%s' 2>/dev/null; umount -l '%s/%s' 2>/dev/null; umount -l '%s/%s' 2>/dev/null; umount -l '%s/tmp' 2>/dev/null; umount -l '%s/run' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/proc' 2>/dev/null; true", 0
LC54:
	db "%sgrep '%s' /proc/mounts | cut -d' ' -f2 | sort -r | xargs -r umount -l 2>/dev/null; true", 0
section .rodata
LC55:
	db "\033[1;32m[+] Unmounted\n\033[0m", 0
global gentoo_chroot_unmount
gentoo_chroot_unmount:
	test	rdi, rdi
	je	.L105
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 4104
	cmp	byte [rdi], 0
	jne	.L104
	xor	eax, eax
	cmp	byte [rel g_chroot_path_store], 0
	je	.L102
	mov	ebx, g_chroot_path_store
.L104:
	mov	edi, LC52
	xor	eax, eax
	mov	rbp, rsp
	call	printf
	call	priv_prefix
	sub	rsp, 8
	mov	r8, rbx
	mov	rdi, rbp
	push	rbx
	mov	r9d, LC3
	mov	rcx, rax
	mov	edx, LC53
	push	rbx
	mov	esi, 4096
	xor	eax, eax
	push	rbx
	push	rbx
	push	rbx
	push	LC5
	push	rbx
	push	LC4
	push	rbx
	call	xsnprintf
	mov	rsp, rbp
	mov	rdi, rbp
	call	run_cmd
	call	priv_prefix
	mov	r8, rbx
	mov	edx, LC54
	mov	rdi, rbp
	mov	rcx, rax
	mov	esi, 4096
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	edi, LC55
	xor	eax, eax
	call	printf
	mov	eax, 1
.L102:
	add	rsp, 4104
	pop	rbx
	pop	rbp
	ret
.L105:
	xor	eax, eax
	ret
section .rodata
LC56:
	db "\033[1;32m>>> Emerging (1 of 1) %s::gentoo\n\033[0m", 0
LC57:
	db "\033[1;34m>>> Jobs: %d  Chroot: %s\n\033[0m", 0
LC58:
	db "'%s/dev' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/null;   chroot '%s' /bin/bash -c 'source /etc/profile; emerge-webrsync 2>&1 | tail -n 20';   umount -l '%s/proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; fi; true", 0
LC59:
	db 'chroot ''%s'' /bin/bash -c "source /etc/profile; if [ ! -L /etc/portage/make.profile ]; then eselect profile set 1 2>/dev/null || true; fi; emerge --ask n --jobs=%d --load-average=%d ''%s'' 2>&1"', 0
LC60:
	db "\033[1;31m\n[!] Interrupted (Ctrl+C) - cleaning up chroot mounts...\n\033[0m", 0
LC61:
	db "\033[1;31m[-] Portage inside chroot failed (exit %d)\n\033[0m", 0
LC62:
	db "\033[1;32m[+] Portage inside chroot finished successfully\n\033[0m", 0
gentoo_chroot_run_portage.part.0:
	push	r13
	xor	eax, eax
	mov	r13, rsi
	push	r12
	push	rbp
	mov	ebp, edx
	push	rbx
	mov	rbx, rdi
	mov	edi, LC56
	sub	rsp, 8200
	call	printf
	mov	esi, ebp
	mov	rdx, rbx
	mov	edi, LC57
	xor	eax, eax
	lea	r12, [rsp+4096]
	call	printf
	lea	rdx, [rsp+4104]
	xor	eax, eax
	mov	ecx, 18
	mov	rdi, rdx
	rep stosq
	mov	rdi, rdx
	mov	qword [rsp+4096], chroot_signal_handler
	call	sigemptyset
	mov	rsi, r12
	xor	edx, edx
	mov	edi, 2
	call	sigaction
	mov	rsi, r12
	xor	edx, edx
	mov	edi, 15
	call	sigaction
	mov	rsi, r12
	xor	edx, edx
	mov	edi, 1
	call	sigaction
	mov	dword [rel g_chroot_interrupted], 0
	call	priv_prefix
	push	rbx
	mov	r9, rbx
	mov	r8, rbx
	push	rbx
	mov	rcx, rax
	mov	edx, LC58
	mov	esi, 4096
	push	rbx
	mov	rdi, r12
	xor	eax, eax
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	push	rbx
	call	xsnprintf
	add	rsp, 64
	mov	rdi, r12
	call	run_cmd
	mov	r12, rsp
	sub	rsp, 8
	mov	r9d, ebp
	push	r13
	mov	r8d, ebp
	mov	rcx, rbx
	mov	edx, LC59
	mov	esi, 4096
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	mov	rsp, r12
	mov	ebp, eax
	mov	eax, dword [rel g_chroot_interrupted]
	test	eax, eax
	jne	.L116
	test	ebp, ebp
	jne	.L117
	mov	edi, LC62
	xor	eax, eax
	call	printf
	add	rsp, 8200
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L117:
	mov	rdi, qword [rel stderr]
	mov	edx, ebp
	mov	esi, LC61
	xor	eax, eax
	call	fprintf
	add	rsp, 8200
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L116:
	mov	edi, LC60
	xor	eax, eax
	mov	ebp, 130
	call	printf
	mov	rdi, rbx
	call	gentoo_chroot_unmount
	add	rsp, 8200
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
global gentoo_chroot_run_portage
gentoo_chroot_run_portage:
	test	rdi, rdi
	je	.L119
	test	rsi, rsi
	je	.L119
	jmp	gentoo_chroot_run_portage.part.0
.L119:
	mov	eax, 1
	ret
section .rodata
LC63:
	db "/usr/local/emerge/gentoo-chroot", 0
LC64:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
section .rodata
LC65:
	db "\033[1;32m>>> Emerging %s\n\033[0m", 0
section .rodata
LC66:
	db "\033[1;31m[-] Failed to init Gentoo chroot\n\033[0m", 0
LC67:
	db "\033[1;34m>>> Copying artifacts...\n\033[0m", 0
LC68:
	db "%sls '%s/%s/' 2>/dev/null; echo '>>> Binary backup currently at %s/%s'; mkdir -p '%s/var/cache/binpkgs' 2>/dev/null; cp -a '%s/%s/'*.pkg.tar.* '%s/var/cache/binpkgs/' 2>/dev/null; echo '>>> Copied Arch binaries into Gentoo chroot binpkgs (imitation)'; true", 0
section .rodata
LC69:
	db "\033[1;32m\n>>> Completed %s\n\033[0m", 0
section .rodata
LC70:
	db "\033[1;33m[!] Build interrupted, chroot cleaned up\n\033[0m", 0
LC71:
	db "\033[1;31m[-] Imitation build failed\n\033[0m", 0
LC72:
	db "\033[1;33m    Tip: try manual fix: sudo chroot %s emerge --sync && sudo chroot %s eselect profile set 1\n\033[0m", 0
global cmd_gentoo_imitation_build
cmd_gentoo_imitation_build:
	push	r13
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 2056
	call	valid_pkgname
	test	eax, eax
	je	.L133
	call	get_gentoo_chroot_path
	mov	rbx, rax
	test	rax, rax
	je	.L130
	cmp	byte [rax], 0
	mov	eax, LC63
	cmove	rbx, rax
.L123:
	mov	rsi, rbp
	mov	edi, LC65
	xor	eax, eax
	call	printf
	mov	rdi, rbx
	call	gentoo_chroot_init
	mov	r12d, eax
	test	eax, eax
	je	.L134
	mov	rdi, rbx
	call	gentoo_chroot_mount.part.0
	call	get_jobs
	test	rbp, rbp
	jne	.L126
	mov	rdi, rbx
	call	gentoo_chroot_unmount
.L127:
	mov	edx, 38
	mov	esi, 1
	mov	edi, LC71
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	rcx, rbx
	mov	rdx, rbx
	mov	esi, LC72
	mov	rdi, qword [rel stderr]
	xor	eax, eax
	call	fprintf
.L122:
	xor	r12d, r12d
.L120:
	add	rsp, 2056
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L133:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC64
	call	fprintf
	jmp	.L122
.L134:
	mov	edx, 44
	mov	esi, 1
	mov	edi, LC66
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L122
.L130:
	mov	ebx, LC63
	jmp	.L123
.L126:
	mov	edx, eax
	mov	rsi, rbp
	mov	rdi, rbx
	call	gentoo_chroot_run_portage.part.0
	mov	r13d, eax
	test	eax, eax
	je	.L128
	mov	rdi, rbx
	call	gentoo_chroot_unmount
	cmp	r13d, 130
	jne	.L127
	mov	edi, LC70
	xor	eax, eax
	call	printf
	jmp	.L122
.L128:
	mov	edi, LC67
	xor	eax, eax
	mov	r13, rsp
	call	printf
	call	priv_prefix
	push	rbx
	mov	r9, rbp
	mov	r8d, LC5
	push	rbp
	mov	rcx, rax
	mov	edx, LC68
	mov	esi, 2048
	push	LC5
	mov	rdi, r13
	xor	eax, eax
	push	rbx
	push	rbp
	push	LC5
	call	xsnprintf
	mov	rsp, r13
	mov	rdi, r13
	call	run_cmd
	mov	rdi, rbx
	call	gentoo_chroot_unmount
	mov	rsi, rbp
	mov	edi, LC69
	xor	eax, eax
	call	printf
	jmp	.L120
