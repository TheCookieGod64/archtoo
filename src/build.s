	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%s/src"
	.align	3
.LC1:
	.string	"find '%s' -mindepth 1 -maxdepth 1 -print -quit | grep -q ."
	.text
	.align	2
	.p2align 5,,15
	.type	has_reusable_source_tree, %function
has_reusable_source_tree:
	sub	sp, sp, #1728
	mov	x3, x0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 700
	add	x0, sp, 24
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	xsnprintf
	add	x0, sp, 24
	bl	dir_exists
	cbz	w0, .L1
	add	x3, sp, 24
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	mov	x1, 1000
	add	x0, sp, 728
	bl	xsnprintf
	add	x0, sp, 728
	bl	run_cmd_quiet
	cmp	w0, 0
	cset	w0, eq
.L1:
	ldp	x29, x30, [sp]
	add	sp, sp, 1728
	ret
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"%s/.git/config"
	.align	3
.LC3:
	.string	"grep -qF 'aur.archlinux.org' '%s'"
	.text
	.align	2
	.p2align 5,,15
	.type	is_aur_checkout, %function
is_aur_checkout:
	sub	sp, sp, #1632
	mov	x3, x0
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 700
	add	x0, sp, 24
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	xsnprintf
	add	x0, sp, 24
	bl	file_exists
	cbz	w0, .L8
	add	x3, sp, 24
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	mov	x1, 900
	add	x0, sp, 728
	bl	xsnprintf
	add	x0, sp, 728
	bl	run_cmd_quiet
	cmp	w0, 0
	cset	w0, eq
.L8:
	ldp	x29, x30, [sp]
	add	sp, sp, 1632
	ret
	.align	2
	.p2align 5,,15
	.type	restore_on_signal, %function
restore_on_signal:
	stp	x29, x30, [sp, -32]!
	adrp	x0, .LANCHOR0
	mov	w1, 1
	mov	x29, sp
	str	x19, [sp, 16]
	add	x19, x0, :lo12:.LANCHOR0
	str	w1, [x0, #:lo12:.LANCHOR0]
	ldr	w0, [x19, 4]
	cbnz	w0, .L20
.L15:
	mov	w0, 130
	bl	_exit
.L20:
	mov	x2, 52
	adrp	x1, .LANCHOR1
	mov	w0, 2
	add	x1, x1, :lo12:.LANCHOR1
	bl	write
	add	x1, x19, 16
	add	x0, x19, 784
	bl	rename
	str	wzr, [x19, 4]
	b	.L15
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"\033[1;33m[!] Restoring previous build tree...\n\033[0m"
	.align	3
.LC5:
	.string	"rm -rf '%s'"
	.align	3
.LC6:
	.string	"cp -a '%s' '%s' && rm -rf '%s'"
	.align	3
.LC7:
	.string	"\033[1;32m[+] Previous build tree restored to %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	restore_backup.part.0, %function
restore_backup.part.0:
	sub	sp, sp, #1760
	mov	x2, 48
	mov	x1, 1
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	adrp	x22, :got:stderr
	ldr	x22, [x22, :got_lo12:stderr]
	stp	x19, x20, [sp, 16]
	adrp	x19, .LANCHOR0
	add	x20, x19, :lo12:.LANCHOR0
	ldr	x3, [x22]
	add	x21, x20, 16
	bl	fwrite
	mov	x3, x21
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1700
	add	x0, sp, 56
	bl	xsnprintf
	add	x0, sp, 56
	bl	run_cmd_quiet
	mov	x1, x21
	add	x0, x20, 784
	bl	rename
	cbnz	w0, .L27
.L22:
	ldr	x0, [x22]
	add	x2, x19, :lo12:.LANCHOR0
	add	x2, x2, 16
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	str	wzr, [x2, -12]
	bl	fprintf
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 1760
	ret
	.p2align 2,,3
.L27:
	add	x5, x20, 784
	mov	x4, x21
	mov	x3, x5
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 1700
	add	x0, sp, 56
	bl	xsnprintf
	add	x0, sp, 56
	bl	run_cmd_quiet
	b	.L22
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC9:
	.string	"%s/%s"
	.align	3
.LC10:
	.string	"\033[1;31m[-] Cannot change directory to %s\n\033[0m"
	.align	3
.LC11:
	.string	"%s/.git"
	.align	3
.LC12:
	.string	"\033[1;31m[-] Cannot resume %s: its local AUR source tree is missing, and\n    --no-aur-sync forbids retrieving it again.\n\033[0m"
	.align	3
.LC13:
	.string	"\033[1;32m[+] Resuming in existing build tree %s\n\033[0m"
	.align	3
.LC14:
	.string	"\033[1;33m[!] Not a git checkout; resuming anyway.\n\033[0m"
	.align	3
.LC15:
	.string	"\033[1;33m[!] --resume given but no build tree exists for %s; starting fresh.\n\033[0m"
	.align	3
.LC16:
	.string	"\033[1;31m[-] Local AUR checkout exists for %s, but its source tree is not reusable;\n    --no-aur-sync forbids downloading or extracting fresh AUR sources.\n\033[0m"
	.align	3
.LC17:
	.string	"\033[1;33m[!] AUR refresh disabled; using local checkout %s\n\033[0m"
	.align	3
.LC18:
	.string	"/usr/local/emerge/backups"
	.align	3
.LC19:
	.string	"%s/%s.bak"
	.align	3
.LC20:
	.string	"\033[1;33m[!] Existing build tree found for %s.\n\033[0m"
	.align	3
.LC21:
	.string	"    Backing it up and removing it so the package is rebuilt from scratch."
	.align	3
.LC22:
	.string	"\033[1;31m[-] Could not move %s aside; refusing to destroy it.\n\033[0m"
	.align	3
.LC23:
	.string	"\033[1;32m[+] Backup kept at %s\n\033[0m"
	.align	3
.LC24:
	.string	"Searching in official Arch repositories..."
	.align	3
.LC25:
	.string	"GIT_TERMINAL_PROMPT=0 pkgctl repo clone --protocol=https '%s' 2>'%s/.archtoo-fetch.log'"
	.align	3
.LC26:
	.string	"%s/PKGBUILD"
	.align	3
.LC27:
	.string	"\033[1;31m[-] %s is not in the official repos and no reusable local AUR\n    checkout exists; --no-aur-sync forbids cloning it.\n\033[0m"
	.align	3
.LC28:
	.string	"\033[1;33m[!] Not found in official repos. Refreshing from AUR...\n\033[0m"
	.align	3
.LC29:
	.string	"GIT_TERMINAL_PROMPT=0 git clone 'https://aur.archlinux.org/%s.git' 2>>'%s/.archtoo-fetch.log'"
	.align	3
.LC30:
	.string	"\033[1;31m[-] Package '%s' not found in Arch repos or AUR.\n\033[0m"
	.align	3
.LC31:
	.string	"\033[1;33m    Details: %s/.archtoo-fetch.log\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	fetch_sources
	.type	fetch_sources, %function
fetch_sources:
	sub	sp, sp, #3008
	mov	x1, 512
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	adrp	x22, .LANCHOR0
	add	x0, x22, :lo12:.LANCHOR0
	mov	x4, x21
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC8
	add	x3, x23, :lo12:.LC8
	str	x25, [sp, 64]
	adrp	x25, .LC9
	add	x2, x25, :lo12:.LC9
	stp	x19, x20, [sp, 16]
	str	wzr, [x0, 1552]
	add	x0, sp, 88
	bl	xsnprintf
	add	x0, x23, :lo12:.LC8
	bl	chdir
	cbnz	w0, .L77
	mov	w19, w0
	bl	get_resume
	cbnz	w0, .L78
.L31:
	bl	get_aur_sync
	cbnz	w0, .L36
	add	x0, sp, 88
	bl	dir_exists
	cbnz	w0, .L79
.L36:
	add	x24, x22, :lo12:.LANCHOR0
	mov	x4, x21
	add	x20, x24, 16
	add	x3, x23, :lo12:.LC8
	add	x2, x25, :lo12:.LC9
	mov	x0, x20
	mov	x1, 768
	bl	xsnprintf
	mov	x4, x21
	adrp	x3, .LC18
	adrp	x2, .LC19
	add	x3, x3, :lo12:.LC18
	add	x2, x2, :lo12:.LC19
	mov	x1, 768
	add	x0, x24, 784
	bl	xsnprintf
	mov	x0, x20
	add	x20, sp, 1304
	bl	dir_exists
	cbz	w0, .L39
	add	x0, x24, 784
	bl	dir_exists
	cbnz	w0, .L80
.L40:
	mov	x1, x21
	add	x24, x22, :lo12:.LANCHOR0
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	add	x25, x24, 784
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	puts
	mov	x1, x25
	add	x0, x24, 16
	bl	rename
	cbnz	w0, .L81
.L41:
	add	x1, x22, :lo12:.LANCHOR0
	mov	w0, 1
	str	w0, [x1, 4]
	adrp	x0, .LC23
	add	x1, x1, 784
	add	x0, x0, :lo12:.LC23
	bl	printf
.L39:
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	puts
	add	x4, x23, :lo12:.LC8
	mov	x3, x21
	adrp	x2, .LC25
	add	x2, x2, :lo12:.LC25
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	mov	x1, 0
	bl	run_as_user
	cbz	w0, .L82
.L42:
	bl	get_aur_sync
	cbz	w0, .L83
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	printf
	add	x4, x23, :lo12:.LC8
	mov	x3, x21
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	mov	x1, 0
	bl	run_as_user
	cbnz	w0, .L45
	add	x3, sp, 88
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	mov	x1, 700
	add	x0, sp, 600
	bl	xsnprintf
	add	x0, sp, 600
	bl	file_exists
	cbnz	w0, .L43
.L45:
	add	x0, sp, 88
	bl	dir_exists
	cbnz	w0, .L84
.L46:
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC30
	add	x1, x1, :lo12:.LC30
	ldr	x0, [x20]
	bl	fprintf
	ldr	x0, [x20]
	add	x2, x23, :lo12:.LC8
	adrp	x1, .LC31
	add	x1, x1, :lo12:.LC31
	bl	fprintf
	ldr	x25, [sp, 64]
	mov	w0, w19
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 3008
	ret
	.p2align 2,,3
.L78:
	add	x3, sp, 88
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	mov	x1, 600
	add	x0, sp, 1304
	bl	xsnprintf
	add	x0, sp, 88
	bl	dir_exists
	cbz	w0, .L32
	bl	get_aur_sync
	cbnz	w0, .L33
	add	x0, sp, 88
	bl	is_aur_checkout
	cbz	w0, .L33
	add	x0, sp, 88
	bl	has_reusable_source_tree
	mov	w19, w0
	cbz	w0, .L85
.L33:
	add	x1, sp, 88
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	printf
	add	x0, sp, 1304
	bl	dir_exists
	cbz	w0, .L86
.L43:
	mov	w19, 1
.L87:
	ldr	x25, [sp, 64]
	mov	w0, w19
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 3008
	ret
	.p2align 2,,3
.L77:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC10
	add	x2, x23, :lo12:.LC8
	add	x1, x1, :lo12:.LC10
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
.L28:
	ldr	x25, [sp, 64]
	mov	w0, w19
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 3008
	ret
	.p2align 2,,3
.L32:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	ldr	x0, [x0]
	bl	fprintf
	b	.L31
	.p2align 2,,3
.L81:
	add	x5, x24, 16
	mov	x4, x25
	add	x3, x24, 16
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 1700
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	cbz	w0, .L41
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, x24, 16
	adrp	x1, .LC22
	add	x1, x1, :lo12:.LC22
	ldr	x0, [x0]
	bl	fprintf
	b	.L28
	.p2align 2,,3
.L82:
	add	x3, sp, 88
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	mov	x1, 700
	add	x0, sp, 600
	bl	xsnprintf
	add	x0, sp, 600
	bl	file_exists
	cbz	w0, .L42
	mov	w19, 1
	b	.L87
	.p2align 2,,3
.L79:
	add	x0, sp, 88
	bl	is_aur_checkout
	cbz	w0, .L36
	add	x0, sp, 88
	bl	has_reusable_source_tree
	mov	w19, w0
	cbnz	w0, .L37
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC16
	add	x1, x1, :lo12:.LC16
	ldr	x0, [x0]
	bl	fprintf
	b	.L28
	.p2align 2,,3
.L80:
	add	x3, x24, 784
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1700
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	b	.L40
	.p2align 2,,3
.L83:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC27
	mov	w19, 0
	add	x1, x1, :lo12:.LC27
	ldr	x0, [x0]
	bl	fprintf
	b	.L28
	.p2align 2,,3
.L86:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 52
	mov	x1, 1
	mov	w19, 1
	ldr	x3, [x0]
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	fwrite
	b	.L87
	.p2align 2,,3
.L85:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	ldr	x0, [x0]
	bl	fprintf
	b	.L28
	.p2align 2,,3
.L84:
	add	x3, sp, 88
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	mov	x1, 700
	add	x0, sp, 600
	bl	xsnprintf
	add	x0, sp, 600
	bl	file_exists
	cbnz	w0, .L46
	add	x3, sp, 88
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	b	.L46
	.p2align 2,,3
.L37:
	add	x1, sp, 88
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	add	x1, x22, :lo12:.LANCHOR0
	mov	w0, 1
	str	w0, [x1, 1552]
	b	.L28
	.section	.rodata.str1.8
	.align	3
.LC32:
	.string	" --noconfirm --ask=6"
	.align	3
.LC33:
	.string	""
	.align	3
.LC34:
	.string	"e"
	.align	3
.LC35:
	.string	" --noconfirm"
	.align	3
.LC36:
	.string	" -pipe"
	.align	3
.LC37:
	.string	"\033[1;31m[-] Cannot enter %s\n\033[0m"
	.align	3
.LC38:
	.string	"PKGBUILD"
	.align	3
.LC39:
	.string	"\033[1;31m[-] No PKGBUILD in %s\n\033[0m"
	.align	3
.LC40:
	.string	"\033[1;34m>>> Edit PKGBUILD for custom flags?\n\033[0m"
	.align	3
.LC41:
	.string	"Open in editor"
	.align	3
.LC42:
	.string	"%s PKGBUILD"
	.align	3
.LC43:
	.ascii	"keys=$(awk '/^[[:space:]]*validpgpkeys=\\(/,/\\)/' PKGBUILD "
	.ascii	"| grep -oE '[0-9A-Fa-f]{40}|[0-9A-Fa-f]{16}' | sort -u); [ -"
	.ascii	"z \"$keys\" ] && exit 0; for k in $keys; do   if gpg --list-"
	.ascii	"keys \"$k\" >/dev/null 2>&1; then     echo \"    a"
	.string	"lready have $k\";   else     echo \"    importing $k\";     gpg --keyserver keyserver.ubuntu.com --recv-keys \"$k\" >/dev/null 2>&1       || gpg --keyserver keys.openpgp.org --recv-keys \"$k\" >/dev/null 2>&1       || echo \"    [!] could not fetch $k\";   fi; done"
	.align	3
.LC44:
	.string	"\033[1;34m>>> Checking PGP signing keys...\n\033[0m"
	.align	3
.LC45:
	.string	"makepkg --printsrcinfo > .archtoo-srcinfo"
	.align	3
.LC46:
	.string	"\033[1;31m[-] Could not inspect PKGBUILD dependencies.\n\033[0m"
	.align	3
.LC47:
	.ascii	"deps=$(awk '$1 ~ /^(depends|makedepends|checkdepends)(_[A-Za"
	.ascii	"-z0-9_]+)?$/ { print $3 }' .archtoo-"
	.string	"srcinfo | sed 's/[<>=].*$//' | sort -u); missing=; if [ -n \"$deps\" ]; then missing=$(pacman -T $deps 2>/dev/null || true); fi; if [ -n \"$missing\" ]; then echo '>>> Installing missing repository build dependencies...'; pacman -S --needed%s%s -- $missing; fi"
	.align	3
.LC48:
	.string	".archtoo-srcinfo"
	.align	3
.LC49:
	.string	"\033[1;31m[-] Could not install required repository build dependencies (exit %d).\n\033[0m"
	.align	3
.LC50:
	.string	"\033[1;33m[!] Existing checkout has no reusable source tree; makepkg will fetch and extract it again.\n\033[0m"
	.align	3
.LC51:
	.string	"\033[1;34m>>> Compiling with makepkg (%s, -j%ld)%s...\n\033[0m"
	.align	3
.LC52:
	.string	" [reusing sources]"
	.align	3
.LC53:
	.string	"makepkg -f%s --config '%s'%s"
	.align	3
.LC54:
	.string	"systemd-inhibit"
	.align	3
.LC55:
	.string	"systemd-inhibit --what=idle --who=archtoo --why=probe true"
	.align	3
.LC56:
	.string	"\033[1;34m>>> Suspend and idle inhibited for the duration of the build.\n\033[0m"
	.align	3
.LC57:
	.string	"systemd-inhibit --what=sleep:idle:handle-lid-switch --who=archtoo --why='Compiling %s' --mode=block -- %s"
	.align	3
.LC58:
	.string	"\033[1;33m[!] systemd-inhibit is present but not usable here (no logind session?);\n    building without suspend inhibition.\n\033[0m"
	.align	3
.LC59:
	.string	"%s"
	.align	3
.LC60:
	.string	"\033[1;33m[!] systemd-inhibit not found; the machine may suspend mid-build.\n\033[0m"
	.align	3
.LC61:
	.string	"-march=%s -O%s%s"
	.align	3
.LC62:
	.string	"export KCFLAGS='%s'\nexport KCPPFLAGS='%s'\nexport MAKEFLAGS='-j%ld'\n"
	.align	3
.LC63:
	.string	"\033[1;31m\n[-] Build interrupted by user.\n\033[0m"
	.align	3
.LC64:
	.string	"\033[1;31m[-] Compilation failed (exit %d).\n\033[0m"
	.align	3
.LC65:
	.ascii	"remove_debug=; for archive in ./*.pkg.tar.*; do [ -f \"$arch"
	.ascii	"ive\" ] || continue; case $archive in *.sig) continue;; esac"
	.ascii	"; pkgname=$(bsdtar -xOf \"$archive\" .PKGINFO 2>/dev/null | "
	.ascii	"sed -n 's/^pkgname = //p' | head -n1); case $pkgname in *-de"
	.ascii	"bug) ;; *) continue;; esac; while IFS= read -r entry; do cas"
	.ascii	"e $entry in */|'') continue;; esac; entry=${entry#./}; owner"
	.ascii	"=$(pacman -Qoq \"/$entry\" 2>/dev/null | head -n1); case $ow"
	.ascii	"ner in *-debug) ;; *) continue;; esac; [ \"$owner\" = \"$pkg"
	.ascii	"name\" ] && continue; case \" $remo"
	.string	"ve_debug \" in *\" $owner \"*) ;; *) remove_debug=\"$remove_debug $owner\";; esac; done < <(bsdtar -tf \"$archive\"); done; if [ -n \"$remove_debug\" ]; then echo \">>> Removing conflicting debug package(s):$remove_debug\"; pacman -R%s -- $remove_debug || exit $?; fi"
	.align	3
.LC66:
	.string	"\033[1;31m[-] Could not remove conflicting debug package(s).\n\033[0m"
	.align	3
.LC67:
	.string	"\033[1;34m>>> Installing built package(s) with pacman...\n\033[0m"
	.align	3
.LC68:
	.string	"find . -maxdepth 1 -type f -name '*.pkg.tar.*' ! -name '*.sig' -exec pacman -U%s -- {} +"
	.align	3
.LC69:
	.string	"\033[1;31m[-] Package installation failed (exit %d).\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	compile_package
	.type	compile_package, %function
compile_package:
	mov	x12, 14688
	sub	sp, sp, x12
	mov	x4, x0
	adrp	x3, .LC8
	adrp	x2, .LC9
	add	x3, x3, :lo12:.LC8
	stp	x29, x30, [sp]
	add	x2, x2, :lo12:.LC9
	mov	x29, sp
	mov	x1, 512
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	add	x0, sp, 352
	bl	xsnprintf
	add	x0, sp, 352
	bl	chdir
	cbnz	w0, .L163
	adrp	x20, .LC38
	add	x0, x20, :lo12:.LC38
	bl	file_exists
	mov	w19, w0
	cbz	w0, .L164
	adrp	x0, .LC40
	add	x0, x0, :lo12:.LC40
	bl	printf
	adrp	x0, .LC41
	mov	w1, 0
	add	x0, x0, :lo12:.LC41
	bl	ask_yes_no
	cbnz	w0, .L165
.L92:
	bl	get_import_keys
	cbz	w0, .L93
	add	x0, x20, :lo12:.LC38
	bl	file_exists
	cbnz	w0, .L166
.L93:
	mov	x1, 0
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	run_as_user
	mov	w19, w0
	cbnz	w0, .L167
.L94:
	stp	x23, x24, [sp, 48]
	bl	use_noconfirm
	cbnz	w0, .L168
	adrp	x20, .LC33
	add	x3, x20, :lo12:.LC33
.L95:
	str	x3, [sp, 72]
	bl	use_noconfirm
	ldr	x3, [sp, 72]
	add	x4, x20, :lo12:.LC33
	adrp	x2, .LC47
	add	x2, x2, :lo12:.LC47
	mov	x1, 4096
	add	x0, sp, 2400
	bl	xsnprintf
	add	x24, x20, :lo12:.LC33
	add	x0, sp, 2400
	bl	run_cmd
	mov	w2, w0
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	str	w2, [sp, 72]
	bl	unlink
	ldr	w2, [sp, 72]
	cbnz	w2, .L169
	bl	set_build_env
	add	x0, sp, 864
	mov	x1, 512
	bl	write_makepkg_conf
	mov	w19, w0
	cbz	w0, .L159
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldr	w0, [x0, 1552]
	cbz	w0, .L170
	bl	get_resume
	bl	get_use_pipe
	cbnz	w0, .L123
	add	x23, sp, 1376
	mov	x3, x24
	adrp	x19, .LC59
.L161:
	add	x2, x19, :lo12:.LC59
	mov	x1, 16
	add	x0, sp, 1376
	bl	xsnprintf
	bl	get_target_arch
	str	x0, [sp, 72]
	bl	get_opt_level
	mov	x4, x0
	ldr	x3, [sp, 72]
	add	x5, sp, 1376
	adrp	x1, .LC61
	add	x2, x1, :lo12:.LC61
	mov	x24, x1
	mov	x1, 256
	add	x0, sp, 2400
	bl	xsnprintf
	bl	get_jobs
	mov	x2, x0
	add	x1, sp, 2400
	adrp	x3, .LC52
	adrp	x0, .LC51
	add	x3, x3, :lo12:.LC52
	add	x0, x0, :lo12:.LC51
	bl	printf
	adrp	x3, .LC34
	add	x3, x3, :lo12:.LC34
.L107:
	str	x3, [sp, 72]
	bl	use_noconfirm
	ldr	x3, [sp, 72]
	cmp	w0, 0
	add	x5, x20, :lo12:.LC33
	adrp	x1, .LC35
	add	x1, x1, :lo12:.LC35
	add	x4, sp, 864
	csel	x5, x5, x1, eq
	adrp	x2, .LC53
	add	x2, x2, :lo12:.LC53
	mov	x1, 1024
	mov	x0, x23
	bl	xsnprintf
	bl	get_inhibit
	cbz	w0, .L109
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	have_cmd
	cbnz	w0, .L171
.L109:
	mov	x3, x23
	add	x2, x19, :lo12:.LC59
	mov	x0, 6496
	mov	x1, 8192
	add	x0, sp, x0
	mov	x21, x0
	bl	xsnprintf
	bl	get_inhibit
	cbnz	w0, .L172
.L111:
	bl	get_use_pipe
	add	x20, x20, :lo12:.LC33
	cmp	w0, 0
	adrp	x3, .LC36
	add	x3, x3, :lo12:.LC36
	add	x2, x19, :lo12:.LC59
	csel	x3, x20, x3, eq
	mov	x1, 16
	add	x0, sp, 80
	bl	xsnprintf
	bl	get_target_arch
	mov	x19, x0
	bl	get_opt_level
	mov	x4, x0
	mov	x3, x19
	add	x5, sp, 80
	add	x2, x24, :lo12:.LC61
	mov	x1, 256
	add	x0, sp, 96
	bl	xsnprintf
	bl	get_jobs
	mov	x5, x0
	add	x4, sp, 96
	adrp	x2, .LC62
	mov	x3, x4
	add	x2, x2, :lo12:.LC62
	mov	x1, 1024
	add	x0, sp, 2400
	bl	xsnprintf
	add	x1, sp, 2400
	mov	x0, x21
	bl	run_as_user
	mov	w19, w0
	cmp	w19, 143
	sub	w0, w0, #129
	ccmp	w0, 2, 0, ne
	bls	.L173
	cbnz	w19, .L174
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x3, .LC35
	add	x3, x3, :lo12:.LC35
	csel	x3, x20, x3, eq
	adrp	x2, .LC65
	add	x2, x2, :lo12:.LC65
	mov	x1, 8192
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	cbnz	w0, .L175
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	printf
	mov	w19, 1
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x3, .LC32
	add	x3, x3, :lo12:.LC32
	csel	x3, x20, x3, eq
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
	mov	x1, 8192
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	cbz	w0, .L159
	adrp	x1, .LC69
	mov	w2, w0
	add	x1, x1, :lo12:.LC69
.L162:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
	ldp	x23, x24, [sp, 48]
	b	.L88
	.p2align 2,,3
.L164:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC39
	add	x2, sp, 352
	add	x1, x1, :lo12:.LC39
	ldr	x0, [x0]
	bl	fprintf
.L88:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 14688
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L163:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 352
	mov	w19, 0
	adrp	x1, .LC37
	add	x1, x1, :lo12:.LC37
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 14688
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L168:
	adrp	x3, .LC32
	adrp	x20, .LC33
	add	x3, x3, :lo12:.LC32
	b	.L95
	.p2align 2,,3
.L166:
	adrp	x2, .LC43
	add	x2, x2, :lo12:.LC43
	mov	x1, 2048
	add	x0, sp, 2400
	bl	xsnprintf
	adrp	x0, .LC44
	add	x0, x0, :lo12:.LC44
	bl	printf
	mov	x1, 0
	add	x0, sp, 2400
	bl	run_as_user
	mov	x1, 0
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	run_as_user
	mov	w19, w0
	cbz	w0, .L94
.L167:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 56
	mov	x1, 1
	mov	w19, 0
	ldr	x3, [x0]
	adrp	x0, .LC46
	add	x0, x0, :lo12:.LC46
	bl	fwrite
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 14688
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L165:
	bl	get_editor
	mov	x3, x0
	mov	x4, 6496
	mov	x1, 8192
	add	x0, sp, x4
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	bl	xsnprintf
	mov	x5, 6496
	mov	x1, 0
	add	x0, sp, x5
	bl	run_as_user
	b	.L92
	.p2align 2,,3
.L159:
	ldp	x23, x24, [sp, 48]
	mov	w0, w19
	ldp	x29, x30, [sp]
	mov	x12, 14688
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L169:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC49
	add	x1, x1, :lo12:.LC49
	ldr	x0, [x0]
	bl	fprintf
	ldp	x23, x24, [sp, 48]
	b	.L88
	.p2align 2,,3
.L123:
	adrp	x3, .LC36
	add	x3, x3, :lo12:.LC36
.L101:
	add	x23, sp, 1376
	adrp	x19, .LC59
	b	.L161
	.p2align 2,,3
.L174:
	adrp	x1, .LC64
	mov	w2, w19
	add	x1, x1, :lo12:.LC64
	b	.L162
	.p2align 2,,3
.L170:
	bl	get_resume
	cbnz	w0, .L176
.L98:
	bl	get_resume
	cbnz	w0, .L102
	bl	get_use_pipe
	add	x3, x20, :lo12:.LC33
	cbz	w0, .L105
	adrp	x3, .LC36
	add	x23, sp, 1376
	add	x3, x3, :lo12:.LC36
	adrp	x19, .LC59
.L160:
	add	x2, x19, :lo12:.LC59
	mov	x1, 16
	add	x0, sp, 1376
	bl	xsnprintf
	bl	get_target_arch
	str	x0, [sp, 72]
	bl	get_opt_level
	mov	x4, x0
	ldr	x3, [sp, 72]
	add	x5, sp, 1376
	adrp	x1, .LC61
	add	x2, x1, :lo12:.LC61
	mov	x24, x1
	mov	x1, 256
	add	x0, sp, 2400
	bl	xsnprintf
	bl	get_jobs
	mov	x2, x0
	add	x3, x20, :lo12:.LC33
	add	x1, sp, 2400
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	str	x3, [sp, 72]
	bl	printf
	ldr	x3, [sp, 72]
	b	.L107
	.p2align 2,,3
.L172:
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	have_cmd
	cbnz	w0, .L111
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 77
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC60
	add	x0, x0, :lo12:.LC60
	bl	fwrite
	b	.L111
	.p2align 2,,3
.L175:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 62
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	fwrite
	ldp	x23, x24, [sp, 48]
	b	.L88
	.p2align 2,,3
.L171:
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	run_cmd_quiet
	cbnz	w0, .L110
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	bl	printf
	mov	x1, 6496
	add	x0, sp, x1
	mov	x21, x0
	mov	x4, x23
	mov	x3, x22
	adrp	x2, .LC57
	mov	x1, 8192
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	b	.L111
	.p2align 2,,3
.L102:
	adrp	x0, .LC50
	add	x0, x0, :lo12:.LC50
	bl	printf
	bl	get_use_pipe
	cbnz	w0, .L177
	add	x23, sp, 1376
	add	x3, x20, :lo12:.LC33
	adrp	x19, .LC59
	b	.L160
	.p2align 2,,3
.L176:
	add	x0, sp, 352
	bl	has_reusable_source_tree
	cbz	w0, .L98
	bl	get_resume
	bl	get_use_pipe
	mov	x3, x24
	cbz	w0, .L101
	adrp	x3, .LC36
	add	x23, sp, 1376
	add	x3, x3, :lo12:.LC36
	adrp	x19, .LC59
	b	.L161
.L110:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 125
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC58
	add	x0, x0, :lo12:.LC58
	bl	fwrite
	b	.L109
.L177:
	adrp	x3, .LC36
	add	x3, x3, :lo12:.LC36
.L105:
	add	x23, sp, 1376
	adrp	x19, .LC59
	b	.L160
.L173:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 43
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC63
	add	x0, x0, :lo12:.LC63
	bl	fwrite
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldr	w0, [x0, 4]
	cbz	w0, .L114
	bl	restore_backup.part.0
.L114:
	mov	w0, 130
	bl	exit
	.section	.rodata.str1.8
	.align	3
.LC70:
	.string	"/etc/pacman.conf"
	.align	3
.LC71:
	.string	"grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'"
	.align	3
.LC72:
	.string	"\033[1;32m[+] %s is already locked in IgnorePkg\n\033[0m"
	.align	3
.LC73:
	.string	"%scp -n '%s' '%s.archtoo.bak'"
	.align	3
.LC74:
	.ascii	"if grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then"
	.ascii	" %ssed -i -E '0,/^[[:space:]]*IgnorePkg[[:space:]]*=/{ /^[[:"
	.ascii	"space:]]*IgnorePkg[[:space:]]*=/{ s/[[:space:]]*$//; s/$/ %s"
	.ascii	"/ } }' '%s'; elif grep -qE '^[[:space:]]*#[[:space:]]*Ignore"
	.ascii	"Pkg[[:space:]]*=' "
	.string	"'%s'; then %ssed -i -E '0,/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ /^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ s/^[[:space:]]*#[[:space:]]*//; s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; else %ssed -i '/^\\[options\\]/a IgnorePkg = %s' '%s'; fi"
	.align	3
.LC75:
	.string	"\033[1;31m[-] Failed to lock %s in %s -- check the file by hand.\n\033[0m"
	.align	3
.LC76:
	.string	"\033[1;32m[+] %s locked in pacman.conf\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	lock_pacman_pkg
	.type	lock_pacman_pkg, %function
lock_pacman_pkg:
	sub	sp, sp, #2480
	mov	x2, 320
	add	x1, sp, 112
	stp	x29, x30, [sp, 48]
	add	x29, sp, 48
	stp	x19, x20, [sp, 64]
	mov	x20, x0
	bl	regex_escape
	cbnz	w0, .L187
	ldp	x29, x30, [sp, 48]
	ldp	x19, x20, [sp, 64]
	add	sp, sp, 2480
	ret
	.p2align 2,,3
.L187:
	adrp	x19, .LC70
	add	x19, x19, :lo12:.LC70
	adrp	x0, .LC71
	mov	x4, x19
	add	x2, x0, :lo12:.LC71
	add	x3, sp, 112
	mov	x1, 2048
	str	x21, [sp, 80]
	add	x21, x0, :lo12:.LC71
	add	x0, sp, 432
	bl	xsnprintf
	add	x0, sp, 432
	bl	run_cmd_quiet
	cbz	w0, .L188
	bl	priv_prefix
	mov	x3, x0
	mov	x5, x19
	mov	x4, x19
	adrp	x2, .LC73
	add	x2, x2, :lo12:.LC73
	mov	x1, 2048
	add	x0, sp, 432
	bl	xsnprintf
	add	x0, sp, 432
	bl	run_cmd_quiet
	bl	priv_prefix
	str	x0, [sp, 104]
	bl	priv_prefix
	str	x0, [sp, 96]
	bl	priv_prefix
	stp	x19, x0, [sp, 16]
	mov	x7, x19
	ldp	x1, x4, [sp, 96]
	mov	x6, x19
	mov	x5, x20
	mov	x3, x19
	adrp	x2, .LC74
	add	x2, x2, :lo12:.LC74
	stp	x1, x20, [sp]
	mov	x1, 2048
	add	x0, sp, 432
	stp	x20, x19, [sp, 32]
	bl	xsnprintf
	add	x0, sp, 432
	bl	run_cmd
	mov	x4, x19
	add	x3, sp, 112
	mov	x2, x21
	mov	x1, 2048
	add	x0, sp, 432
	bl	xsnprintf
	add	x0, sp, 432
	bl	run_cmd_quiet
	cbnz	w0, .L189
	adrp	x0, .LC76
	mov	x1, x20
	add	x0, x0, :lo12:.LC76
	bl	printf
.L182:
	ldr	x21, [sp, 80]
	mov	w0, 1
	ldp	x29, x30, [sp, 48]
	ldp	x19, x20, [sp, 64]
	add	sp, sp, 2480
	ret
	.p2align 2,,3
.L188:
	mov	x1, x20
	adrp	x0, .LC72
	add	x0, x0, :lo12:.LC72
	bl	printf
	b	.L182
	.p2align 2,,3
.L189:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x3, x19
	mov	x2, x20
	adrp	x1, .LC75
	add	x1, x1, :lo12:.LC75
	ldr	x0, [x0]
	bl	fprintf
	ldr	x21, [sp, 80]
	mov	w0, 0
	ldp	x29, x30, [sp, 48]
	ldp	x19, x20, [sp, 64]
	add	sp, sp, 2480
	ret
	.section	.rodata.str1.8
	.align	3
.LC77:
	.string	"\033[1;33m[-] Build directory kept (--resume): %s/%s\n\033[0m"
	.align	3
.LC78:
	.string	"\033[1;34m>>> Clean up build directory?\n\033[0m"
	.align	3
.LC79:
	.string	"Remove directory"
	.align	3
.LC80:
	.string	"\033[1;33m[-] Build directory preserved in %s/%s\n\033[0m"
	.align	3
.LC81:
	.string	"rm -rf '%s/%s'"
	.align	3
.LC82:
	.string	"\033[1;32m[+] Build directory cleaned up.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cleanup_build_dir
	.type	cleanup_build_dir, %function
cleanup_build_dir:
	sub	sp, sp, #656
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	get_resume
	cbnz	w0, .L196
	adrp	x0, .LC78
	add	x0, x0, :lo12:.LC78
	bl	printf
	adrp	x0, .LC79
	mov	w1, 0
	add	x0, x0, :lo12:.LC79
	bl	ask_yes_no
	cbz	w0, .L197
	adrp	x3, .LC8
	add	x3, x3, :lo12:.LC8
	mov	x0, x3
	str	x3, [sp, 40]
	bl	chdir
	cbnz	w0, .L190
	ldr	x3, [sp, 40]
	mov	x4, x19
	adrp	x2, .LC81
	add	x2, x2, :lo12:.LC81
	mov	x1, 600
	add	x0, sp, 56
	bl	xsnprintf
	add	x0, sp, 56
	bl	run_cmd
	adrp	x0, .LC82
	add	x0, x0, :lo12:.LC82
	bl	printf
.L190:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 656
	ret
	.p2align 2,,3
.L197:
	ldp	x29, x30, [sp]
	mov	x2, x19
	ldr	x19, [sp, 16]
	adrp	x1, .LC8
	add	sp, sp, 656
	add	x1, x1, :lo12:.LC8
	adrp	x0, .LC80
	add	x0, x0, :lo12:.LC80
	b	printf
	.p2align 2,,3
.L196:
	ldp	x29, x30, [sp]
	mov	x2, x19
	ldr	x19, [sp, 16]
	adrp	x1, .LC8
	add	sp, sp, 656
	add	x1, x1, :lo12:.LC8
	adrp	x0, .LC77
	add	x0, x0, :lo12:.LC77
	b	printf
	.section	.rodata.str1.8
	.align	3
.LC83:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC84:
	.string	"\033[1;33m[!] Binary install failed for %s, falling back to source build\n\033[0m"
	.align	3
.LC85:
	.string	"Continue with source build?"
	.align	3
.LC86:
	.string	"."
	.align	3
.LC87:
	.string	"\033[1;34m>>> [%d/%d] Fetching sources for %s...\n\033[0m"
	.align	3
.LC88:
	.string	"\033[1;34m>>> [%d/%d] Compiling package...\n\033[0m"
	.align	3
.LC89:
	.string	"\033[1;34m>>> [%d/%d] Running kernel hooks...\n\033[0m"
	.align	3
.LC90:
	.string	"%s-headers"
	.align	3
.LC91:
	.string	"\033[1;34m>>> [%d/%d] Locking in pacman.conf...\n\033[0m"
	.align	3
.LC92:
	.string	"\033[1;34m>>> [%d/%d] Cleaning up...\n\033[0m"
	.align	3
.LC93:
	.string	"\033[1;32m\n>>> DONE! %s is custom built and installed.\n\033[0m"
	.align	3
.LC94:
	.string	"\033[1;33m[!] Reboot to load your new kernel.\n\033[0m"
	.align	3
.LC95:
	.string	"\033[1;33m[!] %s is named like a kernel, but the built package contains no\n    usr/lib/modules/<kver>/vmlinuz; skipping kernel hooks and the -headers lock.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_build
	.type	cmd_build, %function
cmd_build:
	sub	sp, sp, #976
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbz	w0, .L233
	bl	get_use_binary
	cbnz	w0, .L234
.L201:
	mov	w1, 524288
	adrp	x0, .LC86
	add	x0, x0, :lo12:.LC86
	stp	x21, x22, [sp, 32]
	str	x23, [sp, 48]
	bl	open
	movi	v31.4s, 0
	mov	w22, w0
	adrp	x0, restore_on_signal
	add	x0, x0, :lo12:restore_on_signal
	str	x0, [sp, 72]
	add	x0, sp, 80
	str	q31, [sp, 80]
	stp	q31, q31, [sp, 96]
	stp	q31, q31, [sp, 128]
	stp	q31, q31, [sp, 160]
	stp	q31, q31, [sp, 192]
	bl	sigemptyset
	add	x1, sp, 72
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	add	x1, sp, 72
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	add	x1, sp, 72
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	str	wzr, [x0, 4]
	mov	x0, x19
	bl	is_kernel
	cmp	w0, 0
	cset	w2, ne
	mov	x3, x19
	add	w20, w2, 4
	mov	w1, 1
	mov	w2, w20
	mov	w21, w0
	adrp	x0, .LC87
	add	x0, x0, :lo12:.LC87
	bl	printf
	mov	w23, w20
	mov	x0, x19
	bl	fetch_sources
	cbz	w0, .L203
	mov	w2, w20
	mov	w1, 2
	adrp	x0, .LC88
	add	x0, x0, :lo12:.LC88
	bl	printf
	mov	x0, x19
	bl	compile_package
	mov	w20, w0
	cbz	w0, .L203
	cbnz	w21, .L235
.L232:
	mov	w2, w23
	mov	w1, 3
	adrp	x0, .LC91
	add	x0, x0, :lo12:.LC91
	bl	printf
	mov	x0, x19
	bl	lock_pacman_pkg
	mov	x0, x19
	bl	add_to_world
	mov	w2, w23
	mov	w1, 4
	adrp	x0, .LC92
	add	x0, x0, :lo12:.LC92
	bl	printf
	mov	x0, x19
	bl	cleanup_build_dir
	adrp	x0, .LC93
	mov	x1, x19
	add	x0, x0, :lo12:.LC93
	bl	printf
.L206:
	adrp	x0, .LANCHOR0
	add	x19, x0, :lo12:.LANCHOR0
	ldr	w0, [x19, 4]
	cbz	w0, .L208
	add	x3, x19, 784
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 900
	add	x0, sp, 72
	bl	xsnprintf
	add	x0, sp, 72
	bl	run_cmd_quiet
	str	wzr, [x19, 4]
.L208:
	mov	w0, w22
	tbz	w22, #31, .L236
.L231:
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
.L198:
	mov	w0, w20
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 976
	ret
	.p2align 2,,3
.L234:
	mov	x0, x19
	mov	w20, 1
	bl	cmd_binary_install
	cbnz	w0, .L198
	mov	x1, x19
	adrp	x0, .LC84
	add	x0, x0, :lo12:.LC84
	bl	printf
	mov	w1, 0
	adrp	x0, .LC85
	add	x0, x0, :lo12:.LC85
	bl	ask_yes_no
	mov	w20, w0
	cbnz	w0, .L201
	b	.L198
	.p2align 2,,3
.L203:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldr	w20, [x0, 4]
	cbz	w20, .L208
	bl	restore_backup.part.0
	mov	w20, 0
	mov	w0, w22
	tbnz	w22, #31, .L231
.L236:
	bl	fchdir
	mov	w0, w22
	bl	close
	ldr	x23, [sp, 48]
	mov	w0, w20
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 976
	ret
	.p2align 2,,3
.L233:
	mov	w20, w0
	mov	x2, x19
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC83
	add	x1, x1, :lo12:.LC83
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 976
	ret
	.p2align 2,,3
.L235:
	mov	x0, x19
	bl	pkg_ships_kernel
	cbnz	w0, .L237
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC95
	add	x1, x1, :lo12:.LC95
	ldr	x0, [x0]
	bl	fprintf
	b	.L232
	.p2align 2,,3
.L237:
	mov	w2, w23
	mov	w1, 3
	adrp	x0, .LC89
	add	x0, x0, :lo12:.LC89
	bl	printf
	mov	x0, x19
	bl	run_kernel_hooks
	mov	x3, x19
	adrp	x2, .LC90
	add	x2, x2, :lo12:.LC90
	mov	x1, 256
	add	x0, sp, 72
	bl	xsnprintf
	add	x0, sp, 72
	bl	lock_pacman_pkg
	mov	w2, w23
	mov	w1, 4
	adrp	x0, .LC91
	add	x0, x0, :lo12:.LC91
	bl	printf
	mov	x0, x19
	bl	lock_pacman_pkg
	mov	x0, x19
	bl	add_to_world
	mov	w2, w23
	mov	w1, 5
	adrp	x0, .LC92
	add	x0, x0, :lo12:.LC92
	bl	printf
	mov	x0, x19
	bl	cleanup_build_dir
	mov	x1, x19
	adrp	x0, .LC93
	add	x0, x0, :lo12:.LC93
	bl	printf
	adrp	x0, .LC94
	add	x0, x0, :lo12:.LC94
	bl	printf
	b	.L206
	.section	.rodata
	.align	4
	.set	.LANCHOR1,. + 0
	.type	msg.0, %object
msg.0:
	.string	"\n[!] Interrupted - restoring previous build tree...\n"
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	g_interrupted, %object
g_interrupted:
	.zero	4
	.type	g_have_backup, %object
g_have_backup:
	.zero	4
	.zero	8
	.type	g_target, %object
g_target:
	.zero	768
	.type	g_backup, %object
g_backup:
	.zero	768
	.type	g_reused_local_sources, %object
g_reused_local_sources:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
