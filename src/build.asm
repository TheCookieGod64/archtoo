; build.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern add_to_world
extern ask_yes_no
extern chdir
extern close
extern cmd_binary_install
extern dir_exists
extern exit
extern fchdir
extern file_exists
extern fprintf
extern fwrite
extern g_backup
extern g_have_backup
extern g_interrupted
extern g_reused_local_sources
extern g_target
extern get_aur_sync
extern get_editor
extern get_import_keys
extern get_inhibit
extern get_jobs
extern get_opt_level
extern get_resume
extern get_target_arch
extern get_use_binary
extern get_use_pipe
extern have_cmd
extern is_kernel
extern open
extern pipe
extern pkg_ships_kernel
extern printf
extern priv_prefix
extern puts
extern regex_escape
extern rename
extern run_as_user
extern run_cmd
extern run_cmd_quiet
extern run_kernel_hooks
extern set_build_env
extern sigaction
extern sigemptyset
extern stderr
extern unlink
extern use_noconfirm
extern valid_pkgname
extern write
extern write_makepkg_conf
extern xsnprintf
; NASM assembly - converted from C: src/build.c
%use smartalign
section .text
restore_on_signal:
	sub	rsp, 8
	mov	dword [rel g_interrupted], 1
	mov	eax, dword [rel g_have_backup]
	test	eax, eax
	jne	.L8
.L2:
	mov	edi, 130
	call	_exit
.L8:
	mov	edx, 52
	mov	esi, msg.0
	mov	edi, 2
	call	write
	mov	esi, g_target
	mov	edi, g_backup
	call	rename
	xor	eax, eax
	mov	dword [rel g_have_backup], eax
	jmp	.L2
section .rodata
LC0:
	db "\033[1;33m[!] Restoring previous build tree...\n\033[0m", 0
section .rodata
LC1:
	db "rm -rf '%s'", 0
section .rodata
LC2:
	db "cp -a '%s' '%s' && rm -rf '%s'", 0
LC3:
	db "\033[1;32m[+] Previous build tree restored to %s\n\033[0m", 0
restore_backup.part.0:
	push	rbx
	mov	edx, 48
	mov	esi, 1
	mov	edi, LC0
	sub	rsp, 1712
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	esi, 1700
	mov	rdi, rsp
	xor	eax, eax
	mov	ecx, g_target
	mov	edx, LC1
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd_quiet
	mov	esi, g_target
	mov	edi, g_backup
	call	rename
	test	eax, eax
	jne	.L15
.L10:
	mov	rdi, qword [rel stderr]
	mov	edx, g_target
	mov	esi, LC3
	xor	eax, eax
	mov	dword [rel g_have_backup], 0
	call	fprintf
	add	rsp, 1712
	pop	rbx
	ret
.L15:
	mov	r9d, g_backup
	mov	rdi, rsp
	mov	edx, LC2
	xor	eax, eax
	mov	r8d, g_target
	mov	rcx, r9
	mov	esi, 1700
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd_quiet
	jmp	.L10
section .rodata
LC4:
	db "/usr/local/emerge/builds", 0
LC5:
	db "rm -rf '%s/%s'", 0
section .rodata
LC6:
	db "\033[1;32m[+] Build directory cleaned up.\n\033[0m", 0
cleanup_build_dir.part.0:
	push	rbx
	mov	r8, rdi
	mov	ecx, LC4
	mov	edx, LC5
	mov	esi, 600
	xor	eax, eax
	sub	rsp, 608
	mov	rdi, rsp
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd
	mov	edi, LC6
	xor	eax, eax
	call	printf
	add	rsp, 608
	pop	rbx
	ret
section .rodata
LC7:
	db "%s/%s", 0
section .rodata
LC8:
	db "\033[1;31m[-] Cannot change directory to %s\n\033[0m", 0
section .rodata
LC9:
	db "%s/.git", 0
LC10:
	db "%s/.git/config", 0
section .rodata
LC11:
	db "grep -qF 'aur.archlinux.org' '%s'", 0
section .rodata
LC12:
	db "%s/src", 0
section .rodata
LC13:
	db "find '%s' -mindepth 1 -maxdepth 1 -print -quit | grep -q .", 0
LC14:
	db "\033[1;31m[-] Cannot resume %s: its local AUR source tree is missing, and\n    --no-aur-sync forbids retrieving it again.\n\033[0m", 0
LC15:
	db "\033[1;32m[+] Resuming in existing build tree %s\n\033[0m", 0
LC16:
	db "\033[1;33m[!] Not a git checkout; resuming anyway.\n\033[0m", 0
LC17:
	db "\033[1;33m[!] --resume given but no build tree exists for %s; starting fresh.\n\033[0m", 0
LC18:
	db "\033[1;31m[-] Local AUR checkout exists for %s, but its source tree is not reusable;\n    --no-aur-sync forbids downloading or extracting fresh AUR sources.\n\033[0m", 0
LC19:
	db "\033[1;33m[!] AUR refresh disabled; using local checkout %s\n\033[0m", 0
section .rodata
LC20:
	db "/usr/local/emerge/backups", 0
LC21:
	db "%s/%s.bak", 0
section .rodata
LC22:
	db "\033[1;33m[!] Existing build tree found for %s.\n\033[0m", 0
LC23:
	db "    Backing it up and removing it so the package is rebuilt from scratch.", 0
LC24:
	db "\033[1;31m[-] Could not move %s aside; refusing to destroy it.\n\033[0m", 0
LC25:
	db "\033[1;32m[+] Backup kept at %s\n\033[0m", 0
LC26:
	db "Searching in official Arch repositories...", 0
LC27:
	db "GIT_TERMINAL_PROMPT=0 pkgctl repo clone --protocol=https '%s' 2>'%s/.archtoo-fetch.log'", 0
section .rodata
LC28:
	db "%s/PKGBUILD", 0
section .rodata
LC29:
	db "\033[1;31m[-] %s is not in the official repos and no reusable local AUR\n    checkout exists; --no-aur-sync forbids cloning it.\n\033[0m", 0
LC30:
	db "\033[1;33m[!] Not found in official repos. Refreshing from AUR...\n\033[0m", 0
LC31:
	db "GIT_TERMINAL_PROMPT=0 git clone 'https://aur.archlinux.org/%s.git' 2>>'%s/.archtoo-fetch.log'", 0
LC32:
	db "\033[1;31m[-] Package '%s' not found in Arch repos or AUR.\n\033[0m", 0
LC33:
	db "\033[1;33m    Details: %s/.archtoo-fetch.log\n\033[0m", 0
global fetch_sources
fetch_sources:
	push	r15
	mov	r8, rdi
	xor	eax, eax
	mov	ecx, LC4
	push	r14
	mov	edx, LC7
	mov	esi, 512
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 3544
	mov	dword [rel g_reused_local_sources], 0
	mov	rdi, rsp
	call	xsnprintf
	mov	edi, LC4
	call	chdir
	test	eax, eax
	jne	.L79
	mov	rbp, rsp
	call	get_resume
	test	eax, eax
	jne	.L80
.L21:
	call	get_aur_sync
	lea	r12, [rsp+1824]
	test	eax, eax
	jne	.L33
	mov	rdi, rbp
	lea	r12, [rsp+1824]
	call	dir_exists
	test	eax, eax
	jne	.L81
.L33:
	mov	r8, rbx
	mov	ecx, LC4
	mov	edx, LC7
	xor	eax, eax
	mov	esi, 768
	mov	edi, g_target
	call	xsnprintf
	mov	edi, g_backup
	xor	eax, eax
	mov	r8, rbx
	mov	ecx, LC20
	mov	edx, LC21
	mov	esi, 768
	call	xsnprintf
	mov	edi, g_target
	call	dir_exists
	test	eax, eax
	je	.L38
	mov	edi, g_backup
	call	dir_exists
	test	eax, eax
	jne	.L82
.L39:
	mov	rsi, rbx
	mov	edi, LC22
	xor	eax, eax
	call	printf
	mov	edi, LC23
	call	puts
	mov	esi, g_backup
	mov	edi, g_target
	call	rename
	test	eax, eax
	jne	.L83
.L40:
	mov	esi, g_backup
	mov	edi, LC25
	xor	eax, eax
	mov	dword [rel g_have_backup], 1
	call	printf
.L38:
	mov	edi, LC26
	call	puts
	mov	esi, 1024
	mov	rdi, r12
	xor	eax, eax
	mov	r8d, LC4
	mov	rcx, rbx
	mov	edx, LC27
	call	xsnprintf
	xor	esi, esi
	mov	rdi, r12
	call	run_as_user
	test	eax, eax
	je	.L41
.L44:
	call	get_aur_sync
	test	eax, eax
	je	.L84
	mov	edi, LC30
	xor	eax, eax
	call	printf
	mov	esi, 1024
	mov	rdi, r12
	xor	eax, eax
	mov	r8d, LC4
	mov	rcx, rbx
	mov	edx, LC31
	call	xsnprintf
	xor	esi, esi
	mov	rdi, r12
	call	run_as_user
	test	eax, eax
	jne	.L49
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC28
	mov	esi, 700
	lea	r13, [rsp+1120]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	jne	.L37
.L49:
	mov	rdi, rbp
	call	dir_exists
	test	eax, eax
	jne	.L85
.L50:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC32
	xor	eax, eax
	call	fprintf
	mov	rdi, qword [rel stderr]
	mov	edx, LC4
	xor	eax, eax
	mov	esi, LC33
	call	fprintf
	jmp	.L20
.L80:
	xor	eax, eax
	mov	rcx, rsp
	mov	edx, LC9
	mov	esi, 600
	lea	r13, [rsp+512]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, rsp
	call	dir_exists
	test	eax, eax
	je	.L22
	call	get_aur_sync
	test	eax, eax
	jne	.L25
	lea	r14, [rsp+1120]
	mov	rcx, rsp
	mov	edx, LC10
	mov	esi, 700
	mov	rdi, r14
	call	xsnprintf
	mov	rdi, r14
	call	file_exists
	test	eax, eax
	je	.L25
	mov	rcx, r14
	mov	edx, LC11
	mov	esi, 900
	xor	eax, eax
	lea	r15, [rsp+1824]
	mov	rdi, r15
	call	xsnprintf
	mov	rdi, r15
	call	run_cmd_quiet
	mov	r12d, eax
	test	eax, eax
	jne	.L25
	mov	rdi, r14
	xor	eax, eax
	mov	rcx, rsp
	mov	edx, LC12
	mov	esi, 700
	call	xsnprintf
	mov	rdi, r14
	call	dir_exists
	test	eax, eax
	jne	.L86
.L27:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC14
	xor	eax, eax
	call	fprintf
	jmp	.L18
.L79:
	mov	rdi, qword [rel stderr]
	mov	edx, LC4
	mov	esi, LC8
	xor	eax, eax
	call	fprintf
.L20:
	xor	r12d, r12d
.L18:
	add	rsp, 3544
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L22:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC17
	xor	eax, eax
	call	fprintf
	jmp	.L21
.L83:
	mov	r9d, g_target
	mov	rdi, r12
	xor	eax, eax
	mov	edx, LC2
	mov	r8d, g_backup
	mov	rcx, r9
	mov	esi, 1700
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	test	eax, eax
	je	.L40
	mov	rdi, qword [rel stderr]
	mov	edx, g_target
	mov	esi, LC24
	xor	eax, eax
	call	fprintf
	jmp	.L20
.L41:
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC28
	mov	esi, 700
	lea	r13, [rsp+1120]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	je	.L44
.L37:
	mov	r12d, 1
	jmp	.L18
.L81:
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC10
	mov	esi, 700
	lea	r13, [rsp+1120]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	je	.L33
	mov	rdi, r12
	xor	eax, eax
	mov	rcx, r13
	mov	edx, LC11
	mov	esi, 900
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	test	eax, eax
	jne	.L33
	mov	rdi, r13
	mov	rcx, rbp
	mov	edx, LC12
	mov	esi, 700
	call	xsnprintf
	mov	rdi, r13
	call	dir_exists
	test	eax, eax
	je	.L35
	mov	rdi, r12
	xor	eax, eax
	mov	rcx, r13
	mov	edx, LC13
	mov	esi, 1000
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	test	eax, eax
	jne	.L35
	mov	rsi, rbp
	mov	edi, LC19
	xor	eax, eax
	call	printf
	mov	dword [rel g_reused_local_sources], 1
	jmp	.L37
.L82:
	mov	rdi, r12
	mov	ecx, g_backup
	mov	edx, LC1
	xor	eax, eax
	mov	esi, 1700
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	jmp	.L39
.L86:
	mov	rdi, r15
	xor	eax, eax
	mov	rcx, r14
	mov	edx, LC13
	mov	esi, 1000
	call	xsnprintf
	mov	rdi, r15
	call	run_cmd_quiet
	test	eax, eax
	jne	.L27
.L25:
	mov	edi, LC15
	xor	eax, eax
	mov	rsi, rbp
	call	printf
	mov	rdi, r13
	call	dir_exists
	test	eax, eax
	jne	.L37
	mov	edx, 52
	mov	esi, 1
	mov	edi, LC16
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L37
.L84:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC29
	xor	eax, eax
	call	fprintf
	jmp	.L20
.L85:
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC28
	mov	esi, 700
	lea	r13, [rsp+1120]
	mov	rdi, r13
	call	xsnprintf
	mov	rdi, r13
	call	file_exists
	test	eax, eax
	jne	.L50
	mov	rdi, r12
	mov	rcx, rbp
	mov	edx, LC1
	mov	esi, 1024
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	jmp	.L50
.L35:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC18
	xor	eax, eax
	call	fprintf
	jmp	.L20
section .rodata
LC34:
	db " --noconfirm --ask=6", 0
LC35:
	db "", 0
LC36:
	db " --noconfirm", 0
LC37:
	db "e", 0
LC38:
	db " -pipe", 0
section .rodata
LC39:
	db "\033[1;31m[-] Cannot enter %s\n\033[0m", 0
section .rodata
LC40:
	db "PKGBUILD", 0
section .rodata
LC41:
	db "\033[1;31m[-] No PKGBUILD in %s\n\033[0m", 0
LC42:
	db "\033[1;34m>>> Edit PKGBUILD for custom flags?\n\033[0m", 0
section .rodata
LC43:
	db "Open in editor", 0
LC44:
	db "%s PKGBUILD", 0
section .rodata
LC45:
	db 'lready have $k";   else     echo "    importing $k";     gpg --keyserver keyserver.ubuntu.com --recv-keys "$k" >/dev/null 2>&1       || gpg --keyserver keys.openpgp.org --recv-keys "$k" >/dev/null 2>&1       || echo "    [!] could not fetch $k";   fi; done', 0
LC46:
	db "\033[1;34m>>> Checking PGP signing keys...\n\033[0m", 0
LC47:
	db "makepkg --printsrcinfo > .archtoo-srcinfo", 0
LC48:
	db "\033[1;31m[-] Could not inspect PKGBUILD dependencies.\n\033[0m", 0
LC49:
	db 'srcinfo | sed ''s/[<>=].*$//'' | sort -u); missing=; if [ -n "$deps" ]; then missing=$(pacman -T $deps 2>/dev/null || true); fi; if [ -n "$missing" ]; then echo ''>>> Installing missing repository build dependencies...''; pacman -S --needed%s%s -- $missing; fi', 0
section .rodata
LC50:
	db ".archtoo-srcinfo", 0
section .rodata
LC51:
	db "\033[1;31m[-] Could not install required repository build dependencies (exit %d).\n\033[0m", 0
LC52:
	db "\033[1;33m[!] Existing checkout has no reusable source tree; makepkg will fetch and extract it again.\n\033[0m", 0
section .rodata
LC53:
	db "%s", 0
LC54:
	db "-march=%s -O%s%s", 0
LC55:
	db "makepkg -f%s --config '%s'%s", 0
LC56:
	db "systemd-inhibit", 0
section .rodata
LC57:
	db "systemd-inhibit --what=idle --who=archtoo --why=probe true", 0
LC58:
	db "\033[1;34m>>> Suspend and idle inhibited for the duration of the build.\n\033[0m", 0
LC59:
	db "systemd-inhibit --what=sleep:idle:handle-lid-switch --who=archtoo --why='Compiling %s' --mode=block -- %s", 0
LC60:
	db "\033[1;33m[!] systemd-inhibit is present but not usable here (no logind session?);\n    building without suspend inhibition.\n\033[0m", 0
LC61:
	db "\033[1;33m[!] systemd-inhibit not found; the machine may suspend mid-build.\n\033[0m", 0
LC62:
	db "export KCFLAGS='%s'\nexport KCPPFLAGS='%s'\nexport MAKEFLAGS='-j%ld'\n", 0
LC63:
	db "\033[1;31m\n[-] Build interrupted by user.\n\033[0m", 0
LC64:
	db "\033[1;31m[-] Compilation failed (exit %d).\n\033[0m", 0
LC65:
	db 've_debug " in *" $owner "*) ;; *) remove_debug="$remove_debug $owner";; esac; done < <(bsdtar -tf "$archive"); done; if [ -n "$remove_debug" ]; then echo ">>> Removing conflicting debug package(s):$remove_debug"; pacman -R%s -- $remove_debug || exit $?; fi', 0
LC66:
	db "\033[1;31m[-] Could not remove conflicting debug package(s).\n\033[0m", 0
LC67:
	db "\033[1;34m>>> Installing built package(s) with pacman...\n\033[0m", 0
LC68:
	db "find . -maxdepth 1 -type f -name '*.pkg.tar.*' ! -name '*.sig' -exec pacman -U%s -- {} +", 0
LC69:
	db "\033[1;31m[-] Package installation failed (exit %d).\n\033[0m", 0
section .rodata
LC70:
	db " [reusing sources]", 0
section .rodata
LC71:
	db "\033[1;34m>>> Compiling with makepkg (%s, -j%ld)%s...\n\033[0m", 0
global compile_package
compile_package:
	push	r15
	mov	r8, rdi
	xor	eax, eax
	mov	ecx, LC4
	push	r14
	mov	edx, LC7
	mov	esi, 512
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 14616
	lea	rbp, [rsp+272]
	mov	rdi, rbp
	call	xsnprintf
	mov	rdi, rbp
	call	chdir
	test	eax, eax
	jne	.L159
	mov	edi, LC40
	call	file_exists
	test	eax, eax
	je	.L160
	mov	edi, LC42
	xor	eax, eax
	call	printf
	xor	esi, esi
	mov	edi, LC43
	call	ask_yes_no
	test	eax, eax
	jne	.L161
.L92:
	call	get_import_keys
	test	eax, eax
	je	.L94
	mov	edi, LC40
	call	file_exists
	test	eax, eax
	jne	.L162
.L94:
	xor	esi, esi
	mov	edi, LC47
	call	run_as_user
	test	eax, eax
	jne	.L163
.L96:
	call	use_noconfirm
	lea	r12, [rsp+2320]
	call	use_noconfirm
	mov	ecx, LC35
	mov	r8d, LC35
	mov	rdi, r12
	test	eax, eax
	mov	eax, LC34
	mov	edx, LC49
	mov	esi, 4096
	cmovne	rcx, rax
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd
	mov	edi, LC50
	mov	r13d, eax
	call	unlink
	test	r13d, r13d
	jne	.L164
	call	set_build_env
	lea	r14, [rsp+784]
	mov	esi, 512
	mov	rdi, r14
	call	write_makepkg_conf
	test	eax, eax
	je	.L89
	mov	eax, dword [rel g_reused_local_sources]
	lea	r13, [rsp+1296]
	test	eax, eax
	je	.L165
.L99:
	call	get_resume
	mov	ebp, 1
	call	get_use_pipe
	test	eax, eax
	je	.L106
	mov	ecx, LC38
	mov	edx, LC53
	mov	rdi, r13
	xor	eax, eax
	mov	esi, 16
	call	xsnprintf
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	mov	r9, r13
	mov	r8, rbp
	mov	edx, LC54
	mov	rcx, rax
	mov	esi, 256
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
.L108:
	call	get_jobs
	mov	ecx, LC70
	mov	rsi, r12
	mov	edi, LC71
	mov	rdx, rax
	xor	eax, eax
	call	printf
	call	use_noconfirm
	mov	r9d, LC35
	mov	ecx, LC37
	test	eax, eax
	mov	eax, LC36
	cmovne	r9, rax
.L125:
	mov	r8, r14
	mov	edx, LC55
	mov	esi, 1024
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	call	get_inhibit
	test	eax, eax
	je	.L111
	mov	edi, LC56
	call	have_cmd
	test	eax, eax
	jne	.L166
.L111:
	mov	rcx, r13
	mov	edx, LC53
	mov	esi, 8192
	xor	eax, eax
	lea	rbp, [rsp+6416]
	mov	rdi, rbp
	call	xsnprintf
	call	get_inhibit
	test	eax, eax
	jne	.L167
.L114:
	call	get_use_pipe
	mov	r13d, LC35
	mov	ecx, LC38
	mov	rdi, rsp
	test	eax, eax
	mov	edx, LC53
	mov	esi, 16
	cmove	rcx, r13
	xor	eax, eax
	lea	rbx, [rsp+16]
	call	xsnprintf
	call	get_opt_level
	mov	r14, rax
	call	get_target_arch
	mov	r9, rsp
	mov	r8, r14
	mov	edx, LC54
	mov	rcx, rax
	mov	esi, 256
	mov	rdi, rbx
	xor	eax, eax
	call	xsnprintf
	call	get_jobs
	mov	edx, LC62
	mov	r8, rbx
	mov	rcx, rbx
	mov	r9, rax
	mov	esi, 1024
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	mov	rsi, r12
	mov	rdi, rbp
	call	run_as_user
	mov	edx, eax
	lea	eax, [rax-129]
	cmp	eax, 2
	jbe	.L134
	cmp	edx, 143
	je	.L134
	test	edx, edx
	jne	.L168
	call	use_noconfirm
	mov	ecx, LC36
	mov	rdi, rbp
	mov	edx, LC65
	test	eax, eax
	mov	esi, 8192
	cmove	rcx, r13
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	test	eax, eax
	jne	.L169
	mov	edi, LC67
	xor	eax, eax
	call	printf
	call	use_noconfirm
	mov	edx, LC68
	mov	esi, 8192
	mov	rdi, rbp
	test	eax, eax
	mov	eax, LC34
	cmove	rax, r13
	mov	rcx, rax
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	je	.L87
	mov	rdi, qword [rel stderr]
	mov	esi, LC69
	xor	eax, eax
	call	fprintf
.L89:
	xor	eax, eax
.L87:
	add	rsp, 14616
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L160:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC41
	call	fprintf
	jmp	.L89
.L159:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbp
	mov	esi, LC39
	xor	eax, eax
	call	fprintf
	jmp	.L89
.L162:
	lea	r12, [rsp+2320]
	mov	edx, LC45
	mov	esi, 2048
	xor	eax, eax
	mov	rdi, r12
	call	xsnprintf
	mov	edi, LC46
	xor	eax, eax
	call	printf
	xor	esi, esi
	mov	rdi, r12
	call	run_as_user
	xor	esi, esi
	mov	edi, LC47
	call	run_as_user
	test	eax, eax
	je	.L96
.L163:
	mov	edx, 56
	mov	esi, 1
	mov	edi, LC48
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L89
.L161:
	call	get_editor
	mov	edx, LC44
	mov	esi, 8192
	lea	r12, [rsp+6416]
	mov	rcx, rax
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	xor	esi, esi
	mov	rdi, r12
	call	run_as_user
	jmp	.L92
.L106:
	mov	ecx, LC35
	mov	edx, LC53
	mov	rdi, r13
	xor	eax, eax
	mov	esi, 16
	call	xsnprintf
	call	get_opt_level
	mov	r15, rax
	call	get_target_arch
	mov	r9, r13
	mov	r8, r15
	mov	edx, LC54
	mov	rcx, rax
	mov	esi, 256
	xor	eax, eax
	mov	rdi, r12
	call	xsnprintf
	test	ebp, ebp
	jne	.L108
.L109:
	call	get_jobs
	mov	ecx, LC35
	mov	rsi, r12
	mov	edi, LC71
	mov	rdx, rax
	xor	eax, eax
	call	printf
	call	use_noconfirm
	mov	r9d, LC35
	mov	ecx, LC35
	test	eax, eax
	mov	eax, LC36
	cmovne	r9, rax
	jmp	.L125
.L164:
	mov	rdi, qword [rel stderr]
	mov	edx, r13d
	mov	esi, LC51
	xor	eax, eax
	call	fprintf
	jmp	.L89
.L166:
	mov	edi, LC57
	call	run_cmd_quiet
	test	eax, eax
	jne	.L113
	mov	edi, LC58
	lea	rbp, [rsp+6416]
	call	printf
	mov	r8, r13
	mov	rcx, rbx
	mov	edx, LC59
	mov	esi, 8192
	mov	rdi, rbp
	xor	eax, eax
	call	xsnprintf
	jmp	.L114
.L168:
	mov	rdi, qword [rel stderr]
	mov	esi, LC64
	xor	eax, eax
	call	fprintf
	jmp	.L89
.L165:
	call	get_resume
	test	eax, eax
	jne	.L170
.L100:
	call	get_resume
	test	eax, eax
	je	.L104
	mov	edi, LC52
	xor	eax, eax
	call	printf
.L104:
	call	get_use_pipe
	mov	ebp, eax
	test	eax, eax
	je	.L106
	mov	rdi, r13
	mov	ecx, LC38
	mov	edx, LC53
	xor	eax, eax
	mov	esi, 16
	call	xsnprintf
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	mov	r9, r13
	mov	r8, rbp
	mov	edx, LC54
	mov	rcx, rax
	mov	esi, 256
	mov	rdi, r12
	xor	eax, eax
	call	xsnprintf
	jmp	.L109
.L167:
	mov	edi, LC56
	call	have_cmd
	test	eax, eax
	jne	.L114
	mov	edx, 77
	mov	esi, 1
	mov	edi, LC61
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L114
.L169:
	mov	edx, 62
	mov	esi, 1
	mov	edi, LC66
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L89
.L170:
	mov	rdi, r13
	xor	eax, eax
	mov	rcx, rbp
	mov	edx, LC12
	mov	esi, 700
	call	xsnprintf
	mov	rdi, r13
	call	dir_exists
	test	eax, eax
	je	.L100
	mov	rdi, r12
	xor	eax, eax
	mov	rcx, r13
	mov	edx, LC13
	mov	esi, 1000
	call	xsnprintf
	mov	rdi, r12
	call	run_cmd_quiet
	test	eax, eax
	je	.L99
	jmp	.L100
.L113:
	mov	edx, 125
	mov	esi, 1
	mov	edi, LC60
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L111
.L134:
	mov	edx, 43
	mov	esi, 1
	mov	edi, LC63
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	eax, dword [rel g_have_backup]
	test	eax, eax
	je	.L120
	call	restore_backup.part.0
.L120:
	mov	edi, 130
	call	exit
section .rodata
LC72:
	db "/etc/pacman.conf", 0
section .rodata
LC73:
	db "grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'", 0
LC74:
	db "\033[1;32m[+] %s is already locked in IgnorePkg\n\033[0m", 0
section .rodata
LC75:
	db "%scp -n '%s' '%s.archtoo.bak'", 0
section .rodata
LC76:
	db "'%s'; then %ssed -i -E '0,/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ /^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ s/^[[:space:]]*#[[:space:]]*//; s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; else %ssed -i '/^\\[options\\]/a IgnorePkg = %s' '%s'; fi", 0
LC77:
	db "\033[1;31m[-] Failed to lock %s in %s -- check the file by hand.\n\033[0m", 0
LC78:
	db "\033[1;32m[+] %s locked in pacman.conf\n\033[0m", 0
global lock_pacman_pkg
lock_pacman_pkg:
	push	r14
	mov	edx, 320
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 2368
	mov	rsi, rsp
	call	regex_escape
	test	eax, eax
	jne	.L181
.L172:
	add	rsp, 2368
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L181:
	lea	rbp, [rsp+320]
	xor	eax, eax
	mov	rcx, rsp
	mov	r12, rsp
	mov	rdi, rbp
	mov	r8d, LC72
	mov	edx, LC73
	mov	esi, 2048
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd_quiet
	test	eax, eax
	je	.L182
	call	priv_prefix
	mov	r9d, LC72
	mov	edx, LC75
	mov	rdi, rbp
	mov	rcx, rax
	mov	r8, r9
	mov	esi, 2048
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd_quiet
	call	priv_prefix
	mov	r14, rax
	call	priv_prefix
	mov	r13, rax
	call	priv_prefix
	push	LC72
	mov	r9, rbx
	mov	rdi, rbp
	push	rbx
	mov	r8, rax
	mov	ecx, LC72
	mov	edx, LC76
	push	r14
	mov	esi, 2048
	xor	eax, eax
	push	LC72
	push	rbx
	push	r13
	push	LC72
	push	LC72
	call	xsnprintf
	add	rsp, 64
	mov	rdi, rbp
	call	run_cmd
	mov	rdi, rbp
	xor	eax, eax
	mov	r8d, LC72
	mov	rcx, r12
	mov	edx, LC73
	mov	esi, 2048
	call	xsnprintf
	mov	rdi, rbp
	call	run_cmd_quiet
	test	eax, eax
	jne	.L183
	mov	rsi, rbx
	mov	edi, LC78
	xor	eax, eax
	call	printf
.L174:
	add	rsp, 2368
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L182:
	mov	rsi, rbx
	mov	edi, LC74
	call	printf
	jmp	.L174
.L183:
	mov	ecx, LC72
	mov	rdx, rbx
	mov	esi, LC77
	xor	eax, eax
	mov	rdi, qword [rel stderr]
	call	fprintf
	jmp	.L172
section .rodata
LC79:
	db "\033[1;33m[-] Build directory kept (--resume): %s/%s\n\033[0m", 0
LC80:
	db "\033[1;34m>>> Clean up build directory?\n\033[0m", 0
section .rodata
LC81:
	db "Remove directory", 0
section .rodata
LC82:
	db "\033[1;33m[-] Build directory preserved in %s/%s\n\033[0m", 0
global cleanup_build_dir
cleanup_build_dir:
	push	rbx
	mov	rbx, rdi
	call	get_resume
	test	eax, eax
	jne	.L189
	mov	edi, LC80
	xor	eax, eax
	call	printf
	xor	esi, esi
	mov	edi, LC81
	call	ask_yes_no
	test	eax, eax
	je	.L190
	mov	edi, LC4
	call	chdir
	test	eax, eax
	jne	.L184
	mov	rdi, rbx
	pop	rbx
	jmp	cleanup_build_dir.part.0
.L190:
	mov	rdx, rbx
	mov	esi, LC4
	mov	edi, LC82
	pop	rbx
	jmp	printf
.L189:
	mov	rdx, rbx
	mov	esi, LC4
	mov	edi, LC79
	xor	eax, eax
	pop	rbx
	jmp	printf
.L184:
	pop	rbx
	ret
section .rodata
LC83:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
section .rodata
LC84:
	db ".", 0
section .rodata
LC85:
	db "\033[1;33m[!] Binary install failed for %s, falling back to source build\n\033[0m", 0
section .rodata
LC86:
	db "Continue with source build?", 0
section .rodata
LC87:
	db "\033[1;34m>>> [%d/%d] Fetching sources for %s...\n\033[0m", 0
LC88:
	db "\033[1;34m>>> [%d/%d] Compiling package...\n\033[0m", 0
LC89:
	db "\033[1;34m>>> [%d/%d] Running kernel hooks...\n\033[0m", 0
section .rodata
LC90:
	db "%s-headers", 0
section .rodata
LC91:
	db "\033[1;33m[!] %s is named like a kernel, but the built package contains no\n    usr/lib/modules/<kver>/vmlinuz; skipping kernel hooks and the -headers lock.\n\033[0m", 0
LC92:
	db "\033[1;34m>>> [%d/%d] Locking in pacman.conf...\n\033[0m", 0
LC93:
	db "\033[1;34m>>> [%d/%d] Cleaning up...\n\033[0m", 0
LC94:
	db "\033[1;32m\n>>> DONE! %s is custom built and installed.\n\033[0m", 0
LC95:
	db "\033[1;33m[!] Reboot to load your new kernel.\n\033[0m", 0
global cmd_build
cmd_build:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 936
	call	valid_pkgname
	test	eax, eax
	je	.L228
	call	get_use_binary
	test	eax, eax
	jne	.L194
.L197:
	mov	esi, 524288
	mov	edi, LC84
	xor	eax, eax
	mov	ebp, 4
	call	open
	lea	rdx, [rsp+24]
	mov	ecx, 18
	lea	r14, [rsp+16]
	mov	rdi, rdx
	mov	r13d, eax
	xor	eax, eax
	rep stosq
	mov	rdi, rdx
	mov	qword [rsp+16], restore_on_signal
	call	sigemptyset
	xor	edx, edx
	mov	rsi, r14
	mov	edi, 2
	call	sigaction
	xor	edx, edx
	mov	rsi, r14
	mov	edi, 15
	call	sigaction
	xor	edx, edx
	mov	rsi, r14
	mov	edi, 1
	call	sigaction
	mov	rdi, rbx
	mov	dword [rel g_have_backup], 0
	call	is_kernel
	mov	edi, LC87
	mov	rcx, rbx
	mov	esi, 1
	cmp	eax, 1
	mov	r12d, eax
	sbb	ebp, -1
	xor	eax, eax
	mov	edx, ebp
	call	printf
	mov	rdi, rbx
	call	fetch_sources
	test	eax, eax
	je	.L198
	mov	edx, ebp
	mov	esi, 2
	mov	edi, LC88
	xor	eax, eax
	call	printf
	mov	rdi, rbx
	call	compile_package
	mov	r15d, eax
	test	eax, eax
	je	.L198
	mov	dword [rsp+8], 4
	mov	ecx, 3
	test	r12d, r12d
	jne	.L229
.L199:
	mov	esi, ecx
	mov	edx, ebp
	mov	edi, LC92
	xor	eax, eax
	call	printf
	mov	rdi, rbx
	call	lock_pacman_pkg
	mov	rdi, rbx
	call	add_to_world
	mov	esi, dword [rsp+8]
	mov	edx, ebp
	mov	edi, LC93
	xor	eax, eax
	call	printf
	call	get_resume
	test	eax, eax
	jne	.L230
	mov	edi, LC80
	xor	eax, eax
	call	printf
	xor	esi, esi
	mov	edi, LC81
	call	ask_yes_no
	test	eax, eax
	je	.L231
	mov	edi, LC4
	call	chdir
	test	eax, eax
	je	.L232
.L203:
	xor	eax, eax
	mov	rsi, rbx
	mov	edi, LC94
	call	printf
	test	r12d, r12d
	jne	.L233
.L205:
	mov	eax, dword [rel g_have_backup]
	test	eax, eax
	je	.L209
	mov	ecx, g_backup
	mov	edx, LC1
	mov	rdi, r14
	xor	eax, eax
	mov	esi, 900
	call	xsnprintf
	mov	rdi, r14
	call	run_cmd_quiet
	mov	dword [rel g_have_backup], 0
	jmp	.L209
.L194:
	mov	rdi, rbx
	mov	r15d, 1
	call	cmd_binary_install
	test	eax, eax
	je	.L234
.L191:
	add	rsp, 936
	mov	eax, r15d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L198:
	mov	eax, dword [rel g_have_backup]
	test	eax, eax
	jne	.L208
.L210:
	xor	r15d, r15d
.L209:
	test	r13d, r13d
	js	.L191
	mov	edi, r13d
	call	fchdir
	mov	edi, r13d
	call	close
	jmp	.L191
.L228:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC83
	call	fprintf
.L193:
	xor	r15d, r15d
	jmp	.L191
.L234:
	mov	rsi, rbx
	mov	edi, LC85
	call	printf
	xor	esi, esi
	mov	edi, LC86
	call	ask_yes_no
	test	eax, eax
	jne	.L197
	jmp	.L193
.L208:
	call	restore_backup.part.0
	jmp	.L210
.L232:
	mov	r8, rbx
	mov	ecx, LC4
	mov	edx, LC5
	mov	rdi, r14
	mov	esi, 600
	call	xsnprintf
	mov	rdi, r14
	call	run_cmd
	mov	edi, LC6
	xor	eax, eax
	call	printf
	jmp	.L203
.L230:
	mov	rdx, rbx
	mov	esi, LC4
	mov	edi, LC79
	xor	eax, eax
	call	printf
	jmp	.L203
.L229:
	mov	rdi, rbx
	mov	dword [rsp+12], ecx
	call	pkg_ships_kernel
	mov	ecx, dword [rsp+12]
	test	eax, eax
	mov	r12d, eax
	je	.L200
	mov	edx, ebp
	mov	esi, 3
	mov	edi, LC89
	xor	eax, eax
	call	printf
	mov	rdi, rbx
	call	run_kernel_hooks
	mov	rcx, rbx
	mov	edx, LC90
	mov	rdi, r14
	mov	esi, 256
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r14
	call	lock_pacman_pkg
	mov	dword [rsp+8], 5
	mov	ecx, 4
	jmp	.L199
.L233:
	mov	edi, LC95
	xor	eax, eax
	call	printf
	jmp	.L205
.L231:
	mov	rdx, rbx
	mov	esi, LC4
	mov	edi, LC82
	call	printf
	jmp	.L203
.L200:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	xor	eax, eax
	mov	dword [rsp+12], ecx
	mov	esi, LC91
	call	fprintf
	mov	ecx, dword [rsp+12]
	jmp	.L199
section .rodata
msg.0:
	db "\n[!] Interrupted - restoring previous build tree...\n", 0
