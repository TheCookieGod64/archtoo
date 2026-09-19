; cli.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fprintf
extern fwrite
extern get_jobs
extern get_opt_level
extern get_resume
extern get_target_arch
extern get_use_binary
extern get_use_pipe
extern pipe
extern printf
extern puts
extern stderr
extern strcmp
extern strlen
extern strncmp
extern strtol
extern valid_pkgname
; NASM assembly - converted from C: src/cli.c
%use smartalign
section .text
section .rodata
LC0:
	db "3.0.0", 0
LC1:
	db "Archtoo Emerge Engine", 0
LC2:
	db "\033[1;36m%s v%s\n\033[0m", 0
LC3:
	db "Usage:", 0
section .rodata
LC4:
	db "  emerge <package>...    Build and install packages (-I alias)", 0
LC5:
	db "  emerge -S <query>       Search repositories and AUR", 0
LC6:
	db "  emerge -I <package>...  Install packages", 0
LC7:
	db "  emerge -Q <package>...  Query installed packages", 0
LC8:
	db "  emerge -A <package>...  Show repository/AUR information", 0
LC9:
	db "  emerge -G <package>...  Download AUR PKGBUILDs", 0
LC10:
	db "  emerge -B <directory>   Build a local PKGBUILD", 0
LC11:
	db "  emerge -C <package>... Unmerge and remove packages", 0
LC12:
	db "  emerge --orphans        List orphaned dependencies", 0
LC13:
	db "  emerge --clean          Clean package caches", 0
LC14:
	db "  emerge --stats          Show package statistics", 0
LC15:
	db "  emerge --news           Show recent Arch news", 0
LC16:
	db "  emerge --providers <n>  Packages that provide <n> (exact/Provides)", 0
LC17:
	db "  emerge --deps <n>       Dependency plan (repo or AUR, graph order)", 0
LC18:
	db "  emerge --devel          List installed VCS packages (-git/-hg/...)", 0
LC19:
	db "  emerge --review <dir>   Show PKGBUILD / .SRCINFO for review", 0
LC20:
	db "  emerge --complete       Print CLI flags and repo package names", 0
LC21:
	db "  emerge -U              World update: pacman -Syu, then rebuild ", 0
LC22:
	db "  emerge -D <package>... Deselect: unlock and drop from ,", 0
LC23:
	db "                         but keep the package installed", 0
LC24:
	db "  emerge -v              Show version information", 0
section .rodata
LC25:
	db "\nOptions:", 0
section .rodata
LC26:
	db "  --noconfirm            Never prompt; use safe defaults", 0
LC27:
	db "  -i, --interactive      Enable pacman confirmation prompts", 0
LC28:
	db "  --prompt-timeout SEC   Archtoo prompt timeout (0 waits forever)", 0
LC29:
	db "  -j, --jobs N           Parallel build jobs (default: all cores)", 0
LC30:
	db "  --target ARCH          Custom -march target (default: native)", 0
LC31:
	db "                         e.g. skylake, znver3, x86-64-v3, native", 0
LC32:
	db "  --target=ARCH          Same as --target ARCH", 0
LC33:
	db "  --march=ARCH           Alias for --target=ARCH", 0
LC34:
	db "  --opt-level LEVEL      Optimization: 0,1,2,3,s,fast,g,z (default: 3)", 0
LC35:
	db "                         e.g. -O2, 2, s, fast", 0
LC36:
	db "  --opt=LEVEL            Alias for --opt-level", 0
LC37:
	db "  -O0,-O1,-O2,-O3,-Os,-Ofast,-Og,-Oz  Short forms", 0
LC38:
	db "  --pipe                 Enable -pipe (default)", 0
LC39:
	db "  --no-pipe              Disable -pipe", 0
LC40:
	db "  --gentoo-chroot        Enable SUPER HARD Portage imitation via Gentoo chroot", 0
LC41:
	db "  --imitation            Alias for --gentoo-chroot", 0
LC42:
	db "  --no-gentoo-chroot     Disable chroot imitation", 0
LC43:
	db "  --chroot-path PATH     Custom chroot path (default: /usr/local/emerge/gentoo-chroot)", 0
LC44:
	db "  --binary               Download binary without compiling (against Gentoo principles, like yay)", 0
LC45:
	db "                         Long flag only, no short form", 0
LC46:
	db "  --use-binary           Alias for --binary", 0
LC47:
	db "  --no-binary            Disable binary mode", 0
LC48:
	db "  -r, --resume           Reuse the existing build tree and continue", 0
LC49:
	db "                         an interrupted compile", 0
LC50:
	db "  --no-keys              Do not import missing PGP signing keys", 0
LC51:
	db "  --no-inhibit           Allow the machine to suspend while building", 0
LC52:
	db "  --no-sync              Skip pacman -Syu during a world update", 0
LC53:
	db "  --no-aur-sync          Reuse local AUR  sources; do not refresh", 0
LC54:
	db "  --command-guide        Display the command guide now", 0
LC55:
	db "  --command-guide=MODE   Set guide mode: first-run, always, never", 0
print_usage:
	sub	rsp, 8
	mov	edx, LC0
	mov	esi, LC1
	xor	eax, eax
	mov	edi, LC2
	call	printf
	mov	edi, LC3
	call	puts
	mov	edi, LC4
	call	puts
	mov	edi, LC5
	call	puts
	mov	edi, LC6
	call	puts
	mov	edi, LC7
	call	puts
	mov	edi, LC8
	call	puts
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
	mov	edi, LC20
	call	puts
	mov	edi, LC21
	call	puts
	mov	edi, LC22
	call	puts
	mov	edi, LC23
	call	puts
	mov	edi, LC24
	call	puts
	mov	edi, LC25
	call	puts
	mov	edi, LC26
	call	puts
	mov	edi, LC27
	call	puts
	mov	edi, LC28
	call	puts
	mov	edi, LC29
	call	puts
	mov	edi, LC30
	call	puts
	mov	edi, LC31
	call	puts
	mov	edi, LC32
	call	puts
	mov	edi, LC33
	call	puts
	mov	edi, LC34
	call	puts
	mov	edi, LC35
	call	puts
	mov	edi, LC36
	call	puts
	mov	edi, LC37
	call	puts
	mov	edi, LC38
	call	puts
	mov	edi, LC39
	call	puts
	mov	edi, LC40
	call	puts
	mov	edi, LC41
	call	puts
	mov	edi, LC42
	call	puts
	mov	edi, LC43
	call	puts
	mov	edi, LC44
	call	puts
	mov	edi, LC45
	call	puts
	mov	edi, LC46
	call	puts
	mov	edi, LC47
	call	puts
	mov	edi, LC48
	call	puts
	mov	edi, LC49
	call	puts
	mov	edi, LC50
	call	puts
	mov	edi, LC51
	call	puts
	mov	edi, LC52
	call	puts
	mov	edi, LC53
	call	puts
	mov	edi, LC54
	call	puts
	mov	edi, LC55
	add	rsp, 8
	jmp	puts
section .rodata
LC56:
	db "on", 0
LC57:
	db "off", 0
LC58:
	db "yes", 0
LC59:
	db "no", 0
LC60:
	db "SUDO_USER", 0
section .rodata
LC61:
	db "\033[1;31m[-] Running as a root login is not supported.\n    makepkg refuses to build as root, and there is no SUDO_USER\n    to drop back to. Use 'sudo emerge <package>' from your\n    normal account instead.\n\033[0m", 0
section .rodata
LC62:
	db "native", 0
section .rodata
LC63:
	db "\033[1;36mCurrent config: target=%s opt=-O%s pipe=%s chroot=%s binary=%s path=%s\n\033[0m", 0
section .rodata
LC64:
	db "--version", 0
section .rodata
LC65:
	db "%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n", 0
LC66:
	db "Copyright (C) 2026 TheCookieGod64", 0
LC67:
	db "License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>", 0
section .rodata
LC68:
	db "--help", 0
section .rodata
LC69:
	db "\033[1;36m\nActive config: target=%s opt=-O%s pipe=%s\n\033[0m", 0
section .rodata
LC70:
	db "--noconfirm", 0
LC71:
	db "--command-guide", 0
LC72:
	db "--command-guide=", 0
section .rodata
LC73:
	db "\033[1;31m[-] Invalid command-guide mode (use first-run, always, or never).\n\033[0m", 0
section .rodata
LC74:
	db "--interactive", 0
LC75:
	db "--prompt-timeout", 0
section .rodata
LC76:
	db "\033[1;31m[-] --prompt-timeout needs seconds.\n\033[0m", 0
LC77:
	db "\033[1;31m[-] Invalid timeout (expected 0-86400).\n\033[0m", 0
section .rodata
LC78:
	db "--resume", 0
LC79:
	db "--no-keys", 0
LC80:
	db "--no-inhibit", 0
LC81:
	db "--no-sync", 0
LC82:
	db "--no-aur-sync", 0
LC83:
	db "--pipe", 0
LC84:
	db "--no-pipe", 0
LC85:
	db "--jobs", 0
section .rodata
LC86:
	db "\033[1;31m[-] %s needs a number.\n\033[0m", 0
LC87:
	db "\033[1;31m[-] Invalid job count '%s' (expected 1-1024).\n\033[0m", 0
section .rodata
LC88:
	db "--jobs=", 0
section .rodata
LC89:
	db "\033[1;31m[-] Invalid job count.\n\033[0m", 0
section .rodata
LC90:
	db "--target", 0
LC91:
	db "--march", 0
LC92:
	db "--cpu", 0
section .rodata
LC93:
	db "\033[1;31m[-] %s needs an architecture name.\n\033[0m", 0
section .rodata
LC94:
	db "help", 0
LC95:
	db "list", 0
section .rodata
LC96:
	db "\033[1;31m[-] Invalid target '%s'. Use --target help.\n\033[0m", 0
section .rodata
LC97:
	db "--target=", 0
section .rodata
LC98:
	db "\033[1;31m[-] --target= needs a value.\n\033[0m", 0
section .rodata
LC99:
	db "--march=", 0
section .rodata
LC100:
	db "\033[1;31m[-] --march= needs a value.\n\033[0m", 0
LC101:
	db "\033[1;31m[-] Invalid march '%s'.\n\033[0m", 0
section .rodata
LC102:
	db "--cpu=", 0
section .rodata
LC103:
	db "\033[1;31m[-] --cpu= needs a value.\n\033[0m", 0
LC104:
	db "\033[1;31m[-] Invalid cpu '%s'.\n\033[0m", 0
section .rodata
LC105:
	db "--opt-level", 0
LC106:
	db "--opt", 0
LC107:
	db "--optimization", 0
LC108:
	db "-O", 0
section .rodata
LC109:
	db "\033[1;31m[-] %s needs a level (0,1,2,3,s,fast,g,z).\n\033[0m", 0
LC110:
	db "\033[1;31m[-] Invalid opt level '%s'. Use --opt-level help.\n\033[0m", 0
section .rodata
LC111:
	db "--opt-level=", 0
section .rodata
LC112:
	db "\033[1;31m[-] --opt-level= needs a value.\n\033[0m", 0
LC113:
	db "\033[1;31m[-] Invalid opt level '%s'.\n\033[0m", 0
section .rodata
LC114:
	db "--opt=", 0
section .rodata
LC115:
	db "\033[1;31m[-] Invalid opt '%s'.\n\033[0m", 0
section .rodata
LC116:
	db "--optimization=", 0
section .rodata
LC117:
	db "\033[1;31m[-] Invalid optimization '%s'.\n\033[0m", 0
section .rodata
LC118:
	db "-O0", 0
LC119:
	db "-O1", 0
LC120:
	db "-O2", 0
LC121:
	db "-O3", 0
LC122:
	db "-Os", 0
LC123:
	db "-Oz", 0
LC124:
	db "-Og", 0
LC125:
	db "-Ofast", 0
LC126:
	db "fast", 0
LC127:
	db "--gentoo-chroot", 0
LC128:
	db "--imitation", 0
LC129:
	db "--portage-imitation", 0
LC130:
	db "--gentoo-imitation", 0
LC131:
	db "--no-gentoo-chroot", 0
LC132:
	db "--no-imitation", 0
LC133:
	db "--chroot-path=", 0
section .rodata
LC134:
	db "\033[1;31m[-] Invalid chroot path '%s'\n\033[0m", 0
section .rodata
LC135:
	db "--chroot-path", 0
section .rodata
LC136:
	db "\033[1;31m[-] --chroot-path needs a path\n\033[0m", 0
section .rodata
LC137:
	db "--binary", 0
LC138:
	db "--use-binary", 0
LC139:
	db "--use-bin", 0
LC140:
	db "--bin", 0
LC141:
	db "--prebuilt", 0
LC142:
	db "--use-prebuilt", 0
LC143:
	db "--no-build", 0
LC144:
	db "--no-compile", 0
LC145:
	db "--no-binary", 0
LC146:
	db "--no-use-binary", 0
LC147:
	db "--no-bin", 0
LC148:
	db "--no-prebuilt", 0
section .rodata
LC149:
	db "\033[1;36mCurrent: target=%s opt=-O%s pipe=%s chroot=%s binary=%s jobs=%ld path=%s\n\033[0m", 0
LC150:
	db "\033[1;31m[-] Search requires exactly one query.\n\033[0m", 0
section .rodata
LC151:
	db "-A", 0
section .rodata
LC152:
	db "\033[1;31m[-] This operation requires a package.\n\033[0m", 0
section .rodata
LC153:
	db "--orphans", 0
LC154:
	db "--stats", 0
LC155:
	db "--news", 0
LC156:
	db "--complete", 0
LC157:
	db "--devel", 0
LC158:
	db "--providers", 0
LC159:
	db "--deps", 0
LC160:
	db "--review", 0
section .rodata
LC161:
	db "\033[1;31m[-] --review requires a directory.\n\033[0m", 0
section .rodata
LC162:
	db "-I", 0
LC163:
	db "-G", 0
LC164:
	db "-B", 0
LC165:
	db "--clean", 0
LC166:
	db "-U", 0
LC167:
	db "--update", 0
LC168:
	db "-D", 0
LC169:
	db "--deselect", 0
section .rodata
LC170:
	db "\033[1;31m[-] Error: specify a package to deselect.\n\033[0m", 0
section .rodata
LC171:
	db "-C", 0
LC172:
	db "--unmerge", 0
section .rodata
LC173:
	db "\033[1;31m[-] Error: specify a package name to unmerge.\n\033[0m", 0
LC174:
	db "\033[1;31m[-] Unknown option: %s\n\033[0m", 0
LC175:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC176:
	db "\033[1;35m\n>>> [%d/%d] %s (binary mode)\n\033[0m", 0
LC177:
	db "\033[1;31m\n[-] %d package(s) failed in binary mode.\n\033[0m", 0
LC178:
	db "\033[1;35m\n>>> [%d/%d] %s (Gentoo chroot imitation)\n\033[0m", 0
LC179:
	db "\033[1;31m\n[-] %d package(s) failed in Gentoo chroot mode.\n\033[0m", 0
section .rodata
LC180:
	db "\033[1;35m\n>>> [%d/%d] %s\n\033[0m", 0
section .rodata
LC181:
	db "\033[1;31m\n[-] %d package(s) failed.\n\033[0m", 0
LC182:
	db "\033[1;33m    Tip: 'emerge --resume %s' continues from the existing\n    build tree instead of starting over.\n\033[0m", 0
section .rodata
LC183:
	db "-Q", 0
global archtoo_cli_main
archtoo_cli_main:
	push	r15
	push	r14
	push	r13
	push	r12
	mov	r12d, edi
	push	rbp
	mov	rbp, rsi
	push	rbx
	sub	rsp, 2088
	call	geteuid
	test	eax, eax
	jne	.L5
	mov	edi, LC60
	call	getenv
	test	rax, rax
	je	.L468
.L5:
	call	load_user_config
	cmp	r12d, 1
	jle	.L469
	mov	rbx, qword [rbp+8]
	movzx	r13d, byte [rbx]
	cmp	r13d, 45
	jne	.L226
	cmp	byte [rbx+1], 118
	jne	.L226
	cmp	byte [rbx+2], 0
	jne	.L226
.L17:
	call	get_use_binary
	mov	ebx, LC56
	mov	r13d, LC57
	mov	r12d, LC59
	test	eax, eax
	cmovne	r13, rbx
	call	get_gentoo_chroot
	test	eax, eax
	mov	eax, LC57
	cmove	rbx, rax
	call	get_use_pipe
	test	eax, eax
	mov	eax, LC58
	cmovne	r12, rax
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	push	r13
	mov	r9, r12
	mov	r8, rbp
	push	rbx
	mov	rcx, rax
	mov	edx, LC0
	mov	esi, LC1
	mov	edi, LC65
	xor	eax, eax
	call	printf
	mov	edi, LC66
	call	puts
	mov	edi, LC67
	call	puts
	pop	r9
	pop	r10
.L22:
	xor	eax, eax
.L4:
	add	rsp, 2088
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L226:
	mov	esi, LC64
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L17
	cmp	r13d, 45
	jne	.L227
	cmp	byte [rbx+1], 104
	je	.L470
.L227:
	mov	esi, LC68
	mov	rdi, rbx
	mov	r14d, 1
	call	strcmp
	mov	dword [rsp+8], 0
	test	eax, eax
	je	.L24
.L25:
	movsx	r13, r14d
	mov	esi, LC70
	sal	r13, 3
	lea	r15, [rbp+0+r13]
	mov	rbx, qword [r15]
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L471
	mov	esi, LC71
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L472
	mov	edx, 16
	mov	esi, LC72
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L473
	movzx	eax, byte [rbx]
	mov	dword [rsp+12], eax
	cmp	eax, 45
	jne	.L228
	cmp	byte [rbx+1], 105
	je	.L474
.L228:
	mov	esi, LC74
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L37
	mov	esi, LC75
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	jne	.L39
	add	r14d, 1
	cmp	r14d, r12d
	jge	.L475
	mov	rdi, qword [rbp+8+r13]
	lea	rsi, [rsp+24]
	mov	edx, 10
	mov	qword [rsp+24], 0
	call	strtol
	mov	rdi, rax
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L42
	cmp	byte [rax], 0
	jne	.L42
	cmp	rdi, 86400
	jbe	.L43
.L42:
	mov	edx, 51
	mov	esi, 1
	mov	edi, LC77
	mov	rcx, qword [rel stderr]
	call	fwrite
.L6:
	mov	eax, 1
	jmp	.L4
.L473:
	lea	rsi, [rsp+24]
	lea	rdi, [rbx+16]
	call	guide_policy_parse
	test	eax, eax
	jne	.L35
	mov	edx, 77
	mov	esi, 1
	mov	edi, LC73
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L470:
	cmp	byte [rbx+2], 0
	jne	.L227
.L24:
	call	print_usage
	call	get_target_arch
	mov	esi, LC62
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	jne	.L29
	call	get_opt_level
	cmp	byte [rax], 51
	jne	.L29
	cmp	byte [rax+1], 0
	je	.L22
.L29:
	call	get_use_pipe
	mov	ebp, LC59
	test	eax, eax
	mov	eax, LC58
	cmovne	rbp, rax
	call	get_opt_level
	mov	rbx, rax
	call	get_target_arch
	mov	rcx, rbp
	mov	rdx, rbx
	mov	edi, LC69
	mov	rsi, rax
	xor	eax, eax
	call	printf
	jmp	.L22
.L474:
	cmp	byte [rbx+2], 0
	jne	.L228
.L37:
	mov	edi, 1
	call	set_interactive
.L33:
	add	r14d, 1
	cmp	r12d, r14d
	jle	.L225
	cmp	dword [rsp+8], 255
	jne	.L25
.L225:
	movsx	rax, dword [rsp+8]
	mov	qword [rsp+32+rax*8], 0
	mov	rbx, rax
	call	guide_maybe_show
	cmp	ebx, 1
	je	.L476
	mov	ecx, dword [rsp+8]
	test	ecx, ecx
	je	.L477
	mov	r13, qword [rsp+32]
	movzx	eax, byte [r13+0]
	cmp	eax, 45
	je	.L478
.L140:
	mov	esi, LC153
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L479
	mov	esi, LC154
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L480
	mov	esi, LC155
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L481
	mov	esi, LC156
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L482
	mov	esi, LC157
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L483
	mov	esi, LC158
	mov	rdi, r13
	call	strcmp
	cmp	dword [rsp+8], 2
	sete	bl
	test	eax, eax
	jne	.L150
	test	bl, bl
	jne	.L484
.L150:
	mov	esi, LC159
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L151
	test	bl, bl
	jne	.L485
.L151:
	mov	esi, LC160
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L152
	cmp	dword [rsp+8], 2
	je	.L153
	mov	edx, 46
	mov	esi, 1
	mov	edi, LC161
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L39:
	cmp	dword [rsp+12], 45
	jne	.L229
	cmp	byte [rbx+1], 114
	je	.L486
.L229:
	mov	esi, LC78
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L45
	mov	esi, LC79
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L487
	mov	esi, LC80
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L488
	mov	esi, LC81
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L489
	mov	esi, LC82
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L490
	mov	esi, LC83
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L491
	mov	esi, LC84
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L492
	cmp	dword [rsp+12], 45
	jne	.L230
	cmp	byte [rbx+1], 106
	jne	.L230
	cmp	byte [rbx+2], 0
	jne	.L230
.L54:
	add	r14d, 1
	cmp	r14d, r12d
	jge	.L493
	lea	rbx, [rbp+8+r13]
	lea	rsi, [rsp+24]
	mov	edx, 10
	mov	qword [rsp+24], 0
	mov	rdi, qword [rbx]
	call	strtol
	mov	rdi, rax
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L58
	cmp	byte [rax], 0
	jne	.L58
	lea	rax, [rdi-1]
	cmp	rax, 1023
	jbe	.L66
.L58:
	mov	rdx, qword [rbx]
	mov	rdi, qword [rel stderr]
	mov	esi, LC87
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L35:
	mov	edi, dword [rsp+24]
	call	guide_set_policy
	jmp	.L33
.L471:
	mov	edi, 1
	call	set_noconfirm
	jmp	.L33
.L472:
	call	guide_request_explicit
	jmp	.L33
.L469:
	call	get_target_arch
	mov	esi, LC62
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	jne	.L11
	call	get_opt_level
	cmp	byte [rax], 51
	jne	.L11
	cmp	byte [rax+1], 0
	jne	.L11
	call	get_use_pipe
	test	eax, eax
	je	.L11
	call	get_gentoo_chroot
	test	eax, eax
	je	.L12
.L11:
	call	get_gentoo_chroot_path
	mov	ebx, LC56
	mov	r13d, LC57
	mov	r12d, LC59
	mov	r14, rax
	call	get_use_binary
	test	eax, eax
	cmovne	r13, rbx
	call	get_gentoo_chroot
	test	eax, eax
	mov	eax, LC57
	cmove	rbx, rax
	call	get_use_pipe
	test	eax, eax
	mov	eax, LC58
	cmovne	r12, rax
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	sub	rsp, 8
	mov	r8, rbx
	mov	r9, r13
	push	r14
	mov	rsi, rax
	mov	rcx, r12
	mov	rdx, rbp
	mov	edi, LC63
	xor	eax, eax
	call	printf
	pop	r11
	pop	rbx
.L12:
	call	print_usage
	jmp	.L6
.L486:
	cmp	byte [rbx+2], 0
	jne	.L229
.L45:
	mov	edi, 1
	call	set_resume
	jmp	.L33
.L468:
	mov	edx, 208
	mov	esi, 1
	mov	edi, LC61
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L488:
	xor	edi, edi
	call	set_inhibit
	jmp	.L33
.L43:
	call	set_prompt_timeout
	jmp	.L33
.L487:
	xor	edi, edi
	call	set_import_keys
	jmp	.L33
.L230:
	mov	esi, LC85
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L54
	cmp	byte [rbx], 45
	jne	.L61
	cmp	byte [rbx+1], 106
	jne	.L61
	call	__ctype_b_loc
	movzx	edx, byte [rbx+2]
	mov	rax, qword [rax]
	test	byte [rax+1+rdx*2], 8
	jne	.L494
.L61:
	mov	edx, 7
	mov	esi, LC88
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L495
	mov	esi, LC90
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L67
	mov	esi, LC91
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L67
	mov	esi, LC92
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L67
	mov	edx, 9
	mov	esi, LC97
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L73
	cmp	byte [rbx+9], 0
	lea	r13, [rbx+9]
	je	.L496
	mov	esi, LC94
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L70
	mov	esi, LC95
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L70
	mov	rdi, r13
	call	valid_target_arch
	test	eax, eax
	jne	.L81
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC96
	call	fprintf
	jmp	.L6
.L489:
	xor	edi, edi
	call	set_sync
	jmp	.L33
.L476:
	mov	r13, qword [rsp+32]
	movzx	ebx, byte [r13+0]
	cmp	ebx, 45
	jne	.L231
	cmp	byte [r13+1], 118
	jne	.L231
	cmp	byte [r13+2], 0
	jne	.L231
.L119:
	call	get_use_binary
	mov	ebx, LC56
	mov	r13d, LC57
	mov	r12d, LC59
	test	eax, eax
	cmovne	r13, rbx
	call	get_gentoo_chroot
	test	eax, eax
	mov	eax, LC57
	cmove	rbx, rax
	call	get_use_pipe
	test	eax, eax
	mov	eax, LC58
	cmovne	r12, rax
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	push	r13
	mov	esi, LC1
	mov	r9, r12
	push	rbx
	mov	rcx, rax
	mov	r8, rbp
	mov	edx, LC0
	mov	edi, LC65
	xor	eax, eax
	call	printf
	mov	edi, LC66
	call	puts
	pop	rsi
	pop	rdi
	jmp	.L22
.L490:
	xor	edi, edi
	call	set_aur_sync
	jmp	.L33
.L231:
	mov	esi, LC64
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L119
	cmp	ebx, 45
	jne	.L232
	cmp	byte [r13+1], 104
	jne	.L232
	cmp	byte [r13+2], 0
	jne	.L232
.L125:
	call	print_usage
	jmp	.L22
.L478:
	cmp	byte [r13+1], 83
	je	.L497
.L136:
	cmp	eax, 45
	jne	.L140
	cmp	byte [r13+1], 81
	jne	.L234
	movzx	r14d, byte [r13+2]
	test	r14d, r14d
	jne	.L234
	mov	ebx, 1
.L139:
	lea	rbp, [rsp+32]
	jmp	.L144
.L141:
	call	cmd_available_info_v2
.L142:
	cmp	eax, 1
	adc	r14d, 0
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jle	.L498
.L144:
	cmp	byte [r13+1], 81
	mov	rdi, qword [rbp+0+rbx*8]
	jne	.L141
	call	cmd_query_v2
	jmp	.L142
.L491:
	mov	edi, 1
	call	set_use_pipe
	jmp	.L33
.L66:
	call	set_jobs
	jmp	.L33
.L492:
	xor	edi, edi
	call	set_use_pipe
	jmp	.L33
.L498:
	xor	eax, eax
	test	r14d, r14d
	setne	al
	jmp	.L4
.L477:
	call	get_target_arch
	mov	esi, LC62
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	jne	.L131
	call	get_opt_level
	cmp	byte [rax], 51
	jne	.L131
	cmp	byte [rax+1], 0
	jne	.L131
	call	get_use_pipe
	test	eax, eax
	jne	.L499
.L131:
	call	get_gentoo_chroot_path
	mov	ebx, LC56
	mov	r14d, LC57
	mov	r12d, LC59
	mov	r15, rax
	call	get_jobs
	mov	r13, rax
	call	get_use_binary
	test	eax, eax
	cmovne	r14, rbx
	call	get_gentoo_chroot
	test	eax, eax
	mov	eax, LC57
	cmove	rbx, rax
	call	get_use_pipe
	test	eax, eax
	mov	eax, LC58
	cmovne	r12, rax
	call	get_opt_level
	mov	rbp, rax
	call	get_target_arch
	push	r15
	mov	rdx, rbp
	mov	r9, r14
	push	r13
	mov	rsi, rax
	mov	r8, rbx
	mov	rcx, r12
	mov	edi, LC149
	xor	eax, eax
	call	printf
	pop	rax
	pop	rdx
	jmp	.L22
.L232:
	mov	esi, LC68
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L125
	cmp	ebx, 45
	jne	.L233
	cmp	byte [r13+1], 83
	jne	.L233
	cmp	byte [r13+2], 0
	jne	.L233
.L201:
	mov	edx, 50
	mov	esi, 1
	mov	edi, LC150
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L497:
	cmp	byte [r13+2], 0
	jne	.L136
	cmp	dword [rsp+8], 2
	jne	.L201
	mov	rdi, qword [rsp+40]
	call	cmd_search_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L475:
	mov	edx, 47
	mov	esi, 1
	mov	edi, LC76
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L67:
	add	r14d, 1
	cmp	r14d, r12d
	jge	.L500
	mov	rbx, qword [rbp+8+r13]
	mov	esi, LC94
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L70
	mov	esi, LC95
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L70
	mov	rdi, rbx
	call	valid_target_arch
	test	eax, eax
	jne	.L72
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC96
	call	fprintf
	jmp	.L6
.L234:
	cmp	eax, 45
	jne	.L140
	cmp	byte [r13+1], 65
	jne	.L140
	movzx	r14d, byte [r13+2]
	mov	ebx, 1
	test	r14d, r14d
	je	.L139
	jmp	.L140
.L495:
	lea	rdi, [rbx+7]
	lea	rsi, [rsp+24]
	mov	edx, 10
	mov	qword [rsp+24], 0
	call	strtol
	mov	rdi, rax
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L65
	cmp	byte [rax], 0
	jne	.L65
	lea	rax, [rdi-1]
	cmp	rax, 1023
	jbe	.L66
.L65:
	mov	edx, 34
	mov	esi, 1
	mov	edi, LC89
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L233:
	mov	esi, LC183
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L202
	mov	esi, LC151
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	jne	.L140
.L202:
	mov	edx, 50
	mov	esi, 1
	mov	edi, LC152
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L72:
	mov	rdi, rbx
	call	set_target_arch
	jmp	.L33
.L494:
	xor	r8d, r8d
	lea	rdi, [rbx+2]
	lea	rsi, [rsp+24]
	mov	edx, 10
	mov	qword [rsp+24], r8
	call	strtol
	mov	rdi, rax
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L62
	cmp	byte [rax], 0
	jne	.L62
	lea	rax, [rdi-1]
	cmp	rax, 1023
	jbe	.L66
.L62:
	mov	rdx, qword [r15]
	mov	rdi, qword [rel stderr]
	mov	esi, LC87
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L493:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC86
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L479:
	call	cmd_orphans_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L482:
	call	cmd_completion_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L481:
	call	cmd_news_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L480:
	call	cmd_stats_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L499:
	call	get_gentoo_chroot
	test	eax, eax
	jne	.L131
	jmp	.L22
.L483:
	call	cmd_devel_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L153:
	mov	rdi, qword [rsp+40]
	call	cmd_review_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L152:
	mov	rsi, rbp
	mov	edi, r12d
	call	acquire_sudo
	test	eax, eax
	je	.L6
	mov	esi, LC162
	mov	rdi, r13
	call	strcmp
	mov	ebx, eax
	test	eax, eax
	jne	.L155
	cmp	dword [rsp+8], 1
	je	.L6
	call	init_system
	test	eax, eax
	je	.L6
	call	get_use_binary
	test	eax, eax
	je	.L157
	mov	r12d, 1
	lea	rbp, [rsp+32]
.L159:
	mov	rdi, qword [rbp+0+r12*8]
	call	cmd_build
	cmp	eax, 1
	adc	ebx, 0
	add	r12, 1
	cmp	dword [rsp+8], r12d
	jg	.L159
.L467:
	xor	eax, eax
	test	ebx, ebx
	setne	al
	jmp	.L4
.L73:
	mov	edx, 8
	mov	esi, LC99
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L76
	cmp	byte [rbx+8], 0
	lea	r13, [rbx+8]
	je	.L501
	mov	esi, LC94
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L70
	mov	esi, LC95
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L70
	mov	rdi, r13
	call	valid_target_arch
	test	eax, eax
	jne	.L81
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC101
	call	fprintf
	jmp	.L6
.L81:
	mov	rdi, r13
	call	set_target_arch
	jmp	.L33
.L70:
	call	print_known_targets
	jmp	.L22
.L76:
	mov	edx, 6
	mov	esi, LC102
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L79
	cmp	byte [rbx+6], 0
	lea	r13, [rbx+6]
	je	.L502
	mov	rdi, r13
	call	valid_target_arch
	test	eax, eax
	jne	.L81
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC104
	call	fprintf
	jmp	.L6
.L484:
	mov	rdi, qword [rsp+40]
	call	cmd_provider_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L501:
	mov	edx, 39
	mov	esi, 1
	mov	edi, LC100
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L496:
	mov	edx, 40
	mov	esi, 1
	mov	edi, LC98
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L157:
	call	get_gentoo_chroot
	mov	ebx, eax
	test	eax, eax
	je	.L221
	xor	ebx, ebx
	mov	r12d, 1
	lea	rbp, [rsp+32]
.L163:
	mov	rdi, qword [rbp+0+r12*8]
	call	cmd_gentoo_imitation_build
	cmp	eax, 1
	adc	ebx, 0
	add	r12, 1
	cmp	dword [rsp+8], r12d
	jg	.L163
	jmp	.L467
.L155:
	mov	esi, LC163
	mov	rdi, r13
	call	strcmp
	mov	ebx, eax
	test	eax, eax
	jne	.L165
	cmp	dword [rsp+8], 1
	je	.L6
	mov	r12d, 1
	lea	rbp, [rsp+32]
.L167:
	mov	rdi, qword [rbp+0+r12*8]
	call	cmd_get_pkgbuild_v2
	cmp	eax, 1
	adc	ebx, 0
	add	r12, 1
	cmp	dword [rsp+8], r12d
	jg	.L167
	jmp	.L467
.L221:
	mov	r12d, 1
	lea	rbp, [rsp+32]
.L161:
	mov	rdi, qword [rbp+0+r12*8]
	call	cmd_build
	cmp	eax, 1
	adc	ebx, 0
	add	r12, 1
	cmp	dword [rsp+8], r12d
	jg	.L161
	jmp	.L467
.L165:
	mov	esi, LC164
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L503
	mov	esi, LC165
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L504
	mov	esi, LC166
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L170
	mov	esi, LC167
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L170
	mov	esi, LC168
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L172
	mov	esi, LC169
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L172
	mov	esi, LC171
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L177
	mov	esi, LC172
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L177
	xor	ebx, ebx
	cmp	byte [r13+0], 45
	lea	rbp, [rsp+32]
	je	.L505
.L182:
	mov	r12, qword [rbp+0+rbx*8]
	mov	rdi, r12
	call	valid_pkgname
	test	eax, eax
	je	.L506
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jg	.L182
	call	init_system
	test	eax, eax
	je	.L6
	call	get_use_binary
	mov	r12d, eax
	test	eax, eax
	je	.L184
	xor	ebx, ebx
	xor	r12d, r12d
	jmp	.L187
.L507:
	mov	edi, LC176
	xor	eax, eax
	lea	esi, [rbx+1]
	mov	rcx, r13
	call	printf
	mov	rdi, r13
	call	cmd_build
	test	eax, eax
	je	.L194
.L186:
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jle	.L195
.L187:
	mov	edx, dword [rsp+8]
	mov	r13, qword [rbp+0+rbx*8]
	cmp	edx, 1
	jne	.L507
	mov	rdi, r13
	call	cmd_build
	test	eax, eax
	jne	.L195
.L194:
	add	r12d, 1
	jmp	.L186
.L500:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC93
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L485:
	mov	rdi, qword [rsp+40]
	call	cmd_dependency_plan_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L502:
	mov	edx, 37
	mov	esi, 1
	mov	edi, LC103
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L79:
	mov	esi, LC105
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L82
	mov	esi, LC106
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L82
	mov	esi, LC107
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L82
	mov	esi, LC108
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L82
	mov	edx, 12
	mov	esi, LC111
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L88
	cmp	byte [rbx+12], 0
	lea	r13, [rbx+12]
	je	.L508
	mov	esi, LC94
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L85
	mov	esi, LC95
	mov	rdi, r13
	call	strcmp
	test	eax, eax
	je	.L85
	mov	rdi, r13
	call	valid_opt_level
	test	eax, eax
	jne	.L90
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC113
	call	fprintf
	jmp	.L6
.L172:
	cmp	dword [rsp+8], 1
	je	.L509
	call	init_system
	test	eax, eax
	je	.L6
	mov	ebx, 1
	xor	r12d, r12d
	lea	rbp, [rsp+32]
.L176:
	mov	rdi, qword [rbp+0+rbx*8]
	call	cmd_deselect
	cmp	eax, 1
	adc	r12d, 0
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jg	.L176
.L466:
	xor	eax, eax
	test	r12d, r12d
	setne	al
	jmp	.L4
.L170:
	call	init_system
	test	eax, eax
	je	.L6
	call	cmd_world_update
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L509:
	mov	edx, 53
	mov	esi, 1
	mov	edi, LC170
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L504:
	call	cmd_clean_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L503:
	cmp	dword [rsp+8], 2
	jne	.L6
	mov	rdi, qword [rsp+40]
	call	cmd_local_build_v2
	test	eax, eax
	sete	al
	movzx	eax, al
	jmp	.L4
.L195:
	test	r12d, r12d
	je	.L22
	mov	rdi, qword [rel stderr]
	mov	edx, r12d
	mov	esi, LC177
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L184:
	call	get_gentoo_chroot
	mov	ebx, eax
	test	eax, eax
	je	.L223
	xor	ebx, ebx
	jmp	.L191
.L510:
	mov	edi, LC178
	xor	eax, eax
	lea	esi, [rbx+1]
	mov	rcx, r13
	call	printf
	mov	rdi, r13
	call	cmd_gentoo_imitation_build
	test	eax, eax
	je	.L196
.L190:
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jle	.L197
.L191:
	mov	edx, dword [rsp+8]
	mov	r13, qword [rbp+0+rbx*8]
	cmp	edx, 1
	jne	.L510
	mov	rdi, r13
	call	cmd_gentoo_imitation_build
	test	eax, eax
	jne	.L197
.L196:
	add	r12d, 1
	jmp	.L190
.L505:
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC174
	xor	eax, eax
	call	fprintf
	call	print_usage
	jmp	.L6
.L177:
	cmp	dword [rsp+8], 1
	je	.L511
	call	init_system
	test	eax, eax
	je	.L6
	mov	ebx, 1
	xor	r12d, r12d
	lea	rbp, [rsp+32]
.L181:
	mov	rdi, qword [rbp+0+rbx*8]
	call	cmd_unmerge
	cmp	eax, 1
	adc	r12d, 0
	add	rbx, 1
	cmp	dword [rsp+8], ebx
	jg	.L181
	jmp	.L466
.L506:
	mov	rdi, qword [rel stderr]
	mov	rdx, r12
	mov	esi, LC175
	call	fprintf
	jmp	.L6
.L90:
	mov	rdi, r13
	call	set_opt_level
	jmp	.L33
.L511:
	mov	edx, 57
	mov	esi, 1
	mov	edi, LC173
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L85:
	call	print_known_opt_levels
	jmp	.L22
.L508:
	mov	edx, 43
	mov	esi, 1
	mov	edi, LC112
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L88:
	mov	edx, 6
	mov	esi, LC114
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L512
	mov	edx, 15
	mov	esi, LC116
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L513
	mov	esi, LC118
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC119
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC120
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC121
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC122
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC123
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC124
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L462
	mov	esi, LC125
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L514
	mov	edx, 2
	mov	esi, LC108
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L99
	mov	rdi, rbx
	call	strlen
	cmp	rax, 7
	ja	.L99
	cmp	byte [rbx+2], 61
	je	.L100
	add	rbx, 2
.L101:
	mov	rdi, rbx
	call	valid_opt_level
	test	eax, eax
	jne	.L462
	mov	rbx, qword [r15]
.L99:
	mov	esi, LC127
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L102
	mov	esi, LC128
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L102
	mov	esi, LC129
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L102
	mov	esi, LC130
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L102
	mov	esi, LC131
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L104
	mov	esi, LC132
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L104
	mov	edx, 14
	mov	esi, LC133
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L515
	mov	esi, LC135
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	jne	.L108
	add	r14d, 1
	cmp	r12d, r14d
	jle	.L516
	mov	rbx, qword [rbp+8+r13]
	mov	rdi, rbx
	call	valid_gentoo_chroot_path
	test	eax, eax
	jne	.L110
.L465:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC134
	call	fprintf
	jmp	.L6
.L514:
	mov	edi, LC126
	call	set_opt_level
	jmp	.L33
.L462:
	mov	rdi, rbx
	call	set_opt_level
	jmp	.L33
.L515:
	add	rbx, 14
	mov	rdi, rbx
	call	valid_gentoo_chroot_path
	test	eax, eax
	je	.L465
.L110:
	mov	rdi, rbx
	call	set_gentoo_chroot_path
	jmp	.L33
.L516:
	mov	edx, 42
	mov	esi, 1
	mov	edi, LC136
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L6
.L108:
	mov	esi, LC137
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC138
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC139
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC140
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC141
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC142
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC143
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC144
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L111
	mov	esi, LC145
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L114
	mov	esi, LC146
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L114
	mov	esi, LC147
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L114
	mov	esi, LC148
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L114
	movsx	rax, dword [rsp+8]
	mov	qword [rsp+32+rax*8], rbx
	lea	eax, [rax+1]
	mov	dword [rsp+8], eax
	jmp	.L33
.L114:
	xor	edi, edi
	call	set_use_binary
	jmp	.L33
.L111:
	mov	edi, 1
	call	set_use_binary
	jmp	.L33
.L104:
	xor	edi, edi
	call	set_gentoo_chroot
	xor	edi, edi
	call	set_portage_imitation
	jmp	.L33
.L102:
	mov	edi, 1
	call	set_gentoo_chroot
	mov	edi, 1
	call	set_portage_imitation
	jmp	.L33
.L513:
	add	rbx, 15
	mov	rdi, rbx
	call	valid_opt_level
	test	eax, eax
	jne	.L462
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC117
	call	fprintf
	jmp	.L6
.L512:
	add	rbx, 6
	mov	rdi, rbx
	call	valid_opt_level
	test	eax, eax
	jne	.L462
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC115
	call	fprintf
	jmp	.L6
.L82:
	add	r14d, 1
	cmp	r14d, r12d
	jge	.L517
	mov	rbx, qword [rbp+8+r13]
	mov	esi, LC94
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L85
	mov	esi, LC95
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L85
	mov	rdi, rbx
	call	valid_opt_level
	test	eax, eax
	jne	.L462
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC110
	call	fprintf
	jmp	.L6
.L100:
	add	rbx, 3
	jmp	.L101
.L517:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC109
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L197:
	test	r12d, r12d
	je	.L22
	mov	rdi, qword [rel stderr]
	mov	edx, r12d
	mov	esi, LC179
	xor	eax, eax
	call	fprintf
	jmp	.L6
.L223:
	xor	r12d, r12d
	jmp	.L188
.L518:
	mov	edi, LC180
	xor	eax, eax
	lea	esi, [r12+1]
	mov	rcx, r14
	call	printf
	mov	rdi, r14
	call	cmd_build
	test	eax, eax
	je	.L198
.L193:
	add	r12, 1
	cmp	dword [rsp+8], r12d
	jle	.L199
.L188:
	mov	edx, dword [rsp+8]
	mov	r14, qword [rbp+0+r12*8]
	cmp	edx, 1
	jne	.L518
	mov	rdi, r14
	call	cmd_build
	test	eax, eax
	jne	.L199
.L198:
	add	ebx, 1
	jmp	.L193
.L199:
	test	ebx, ebx
	je	.L22
	mov	rdi, qword [rel stderr]
	mov	edx, ebx
	mov	esi, LC181
	xor	eax, eax
	call	fprintf
	call	get_resume
	test	eax, eax
	jne	.L6
	mov	rdi, qword [rel stderr]
	mov	rdx, r13
	mov	esi, LC182
	call	fprintf
	jmp	.L6
