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
	sub	sp, sp, #1744
	mov	x3, x0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 700
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	add	x19, sp, 40
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	dir_exists
	cbz	w0, .L1
	mov	x3, x19
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	add	x0, sp, 744
	mov	x1, 1000
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd_quiet
	cmp	w0, 0
	cset	w0, eq
.L1:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 1744
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
	sub	sp, sp, #1648
	mov	x3, x0
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 700
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	add	x19, sp, 40
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	file_exists
	cbz	w0, .L8
	mov	x3, x19
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	add	x0, sp, 744
	mov	x1, 900
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd_quiet
	cmp	w0, 0
	cset	w0, eq
.L8:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 1648
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
	sub	sp, sp, #1776
	mov	x2, 48
	mov	x1, 1
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x23, [sp, 48]
	adrp	x23, :got:stderr;ldr	x23, [x23, :got_lo12:stderr]
	stp	x19, x20, [sp, 16]
	adrp	x19, .LANCHOR0
	stp	x21, x22, [sp, 32]
	add	x20, x19, :lo12:.LANCHOR0
	add	x22, x20, 16
	ldr	x3, [x23]
	add	x21, sp, 72
	add	x20, x20, 784
	bl	fwrite
	mov	x3, x22
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1700
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	mov	x0, x20
	mov	x1, x22
	bl	rename
	cbnz	w0, .L27
.L22:
	ldr	x0, [x23]
	add	x19, x19, :lo12:.LANCHOR0
	add	x2, x19, 16
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	str	wzr, [x19, 4]
	bl	fprintf
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 1776
	ret
	.p2align 2,,3
.L27:
	mov	x4, x22
	mov	x5, x20
	mov	x3, x20
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 1700
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
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
	mov	x4, x0
	mov	x1, 512
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	adrp	x22, .LANCHOR0
	add	x5, x22, :lo12:.LANCHOR0
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC8
	add	x21, x23, :lo12:.LC8
	mov	x3, x21
	adrp	x24, .LC9
	add	x2, x24, :lo12:.LC9
	stp	x19, x20, [sp, 16]
	add	x20, sp, 88
	mov	x19, x0
	mov	x0, x20
	str	wzr, [x5, 1552]
	bl	xsnprintf
	mov	x0, x21
	bl	chdir
	cbnz	w0, .L82
	str	x25, [sp, 64]
	bl	get_resume
	cbnz	w0, .L83
.L31:
	bl	get_aur_sync
	cbnz	w0, .L37
	mov	x0, x20
	bl	dir_exists
	cbnz	w0, .L84
.L37:
	add	x21, x22, :lo12:.LANCHOR0
	add	x2, x24, :lo12:.LC9
	add	x24, x21, 16
	mov	x4, x19
	add	x3, x23, :lo12:.LC8
	mov	x1, 768
	mov	x0, x24
	bl	xsnprintf
	mov	x4, x19
	adrp	x3, .LC18
	adrp	x2, .LC19
	add	x3, x3, :lo12:.LC18
	add	x2, x2, :lo12:.LC19
	mov	x1, 768
	add	x21, x21, 784
	add	x25, sp, 1304
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x24
	bl	dir_exists
	cbz	w0, .L40
	mov	x0, x21
	bl	dir_exists
	cbnz	w0, .L85
.L41:
	mov	x1, x19
	add	x21, x22, :lo12:.LANCHOR0
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	add	x24, x21, 784
	adrp	x0, .LC21
	add	x21, x21, 16
	add	x0, x0, :lo12:.LC21
	bl	puts
	mov	x1, x24
	mov	x0, x21
	bl	rename
	cbnz	w0, .L86
.L42:
	add	x2, x22, :lo12:.LANCHOR0
	mov	w3, 1
	adrp	x0, .LC23
	add	x1, x2, 784
	add	x0, x0, :lo12:.LC23
	str	w3, [x2, 4]
	bl	printf
.L40:
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	puts
	add	x4, x23, :lo12:.LC8
	mov	x3, x19
	adrp	x2, .LC25
	add	x2, x2, :lo12:.LC25
	mov	x1, 1024
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x25
	mov	x1, 0
	bl	run_as_user
	cbz	w0, .L43
.L46:
	bl	get_aur_sync
	cbz	w0, .L87
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	printf
	add	x4, x23, :lo12:.LC8
	mov	x3, x19
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	mov	x1, 1024
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x25
	mov	x1, 0
	bl	run_as_user
	cbnz	w0, .L51
	mov	x3, x20
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	add	x21, sp, 600
	mov	x1, 700
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	file_exists
	cbnz	w0, .L39
.L51:
	mov	x0, x20
	bl	dir_exists
	cbnz	w0, .L88
.L52:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC30
	add	x1, x1, :lo12:.LC30
	mov	x19, x0
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [x19]
	add	x2, x23, :lo12:.LC8
	adrp	x1, .LC31
	add	x1, x1, :lo12:.LC31
	bl	fprintf
	ldr	x25, [sp, 64]
	.p2align 5,,15
.L30:
	mov	w21, 0
.L28:
	ldp	x29, x30, [sp]
	mov	w0, w21
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 3008
	ret
	.p2align 2,,3
.L83:
	mov	x3, x20
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	add	x25, sp, 1304
	mov	x1, 600
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x20
	bl	dir_exists
	cbz	w0, .L32
	bl	get_aur_sync
	cbnz	w0, .L33
	mov	x0, x20
	bl	is_aur_checkout
	cbz	w0, .L33
	mov	x0, x20
	bl	has_reusable_source_tree
	mov	w21, w0
	cbz	w0, .L89
.L33:
	mov	x1, x20
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	printf
	mov	x0, x25
	bl	dir_exists
	cbz	w0, .L90
.L39:
	mov	w21, 1
	mov	w0, w21
	ldr	x25, [sp, 64]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 3008
	ret
	.p2align 2,,3
.L82:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC10
	add	x1, x1, :lo12:.LC10
	ldr	x0, [x0]
	bl	fprintf
	b	.L30
	.p2align 2,,3
.L32:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	ldr	x0, [x0]
	bl	fprintf
	b	.L31
	.p2align 2,,3
.L86:
	mov	x4, x24
	mov	x5, x21
	mov	x3, x21
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 1700
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x25
	bl	run_cmd_quiet
	cbz	w0, .L42
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC22
	add	x1, x1, :lo12:.LC22
	ldr	x0, [x0]
	bl	fprintf
	ldr	x25, [sp, 64]
	b	.L30
	.p2align 2,,3
.L43:
	mov	x3, x20
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	add	x21, sp, 600
	mov	x1, 700
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	file_exists
	cbz	w0, .L46
	b	.L39
	.p2align 2,,3
.L84:
	mov	x0, x20
	bl	is_aur_checkout
	cbz	w0, .L37
	mov	x0, x20
	bl	has_reusable_source_tree
	cbnz	w0, .L38
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC16
	add	x1, x1, :lo12:.LC16
	ldr	x0, [x0]
	bl	fprintf
	ldr	x25, [sp, 64]
	b	.L30
	.p2align 2,,3
.L85:
	mov	x3, x21
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1700
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x25
	bl	run_cmd_quiet
	b	.L41
	.p2align 2,,3
.L87:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC27
	add	x1, x1, :lo12:.LC27
	ldr	x0, [x0]
	bl	fprintf
	ldr	x25, [sp, 64]
	b	.L30
	.p2align 2,,3
.L90:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC14
	mov	x2, 52
	mov	x1, 1
	add	x0, x0, :lo12:.LC14
	ldr	x3, [x3]
	bl	fwrite
	b	.L39
	.p2align 2,,3
.L89:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	ldr	x0, [x0]
	bl	fprintf
	ldr	x25, [sp, 64]
	b	.L28
	.p2align 2,,3
.L88:
	mov	x3, x20
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	add	x21, sp, 600
	mov	x1, 700
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	file_exists
	cbnz	w0, .L52
	mov	x3, x20
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 1024
	mov	x0, x25
	bl	xsnprintf
	mov	x0, x25
	bl	run_cmd_quiet
	b	.L52
	.p2align 2,,3
.L38:
	mov	x1, x20
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	add	x2, x22, :lo12:.LANCHOR0
	mov	w0, 1
	str	w0, [x2, 1552]
	b	.L39
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
	mov	x12, 14704
	sub	sp, sp, x12
	adrp	x3, .LC8
	adrp	x2, .LC9
	add	x3, x3, :lo12:.LC8
	add	x2, x2, :lo12:.LC9
	stp	x29, x30, [sp]
	mov	x29, sp
	mov	x1, 512
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x4, x19
	add	x20, sp, 368
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	chdir
	cbnz	w0, .L166
	stp	x21, x22, [sp, 32]
	adrp	x21, .LC38
	add	x0, x21, :lo12:.LC38
	bl	file_exists
	cbz	w0, .L167
	adrp	x0, .LC40
	add	x0, x0, :lo12:.LC40
	bl	printf
	adrp	x0, .LC41
	mov	w1, 0
	add	x0, x0, :lo12:.LC41
	bl	ask_yes_no
	cbnz	w0, .L168
.L96:
	bl	get_import_keys
	cbz	w0, .L98
	add	x0, x21, :lo12:.LC38
	bl	file_exists
	cbnz	w0, .L169
.L98:
	adrp	x0, .LC45
	mov	x1, 0
	add	x0, x0, :lo12:.LC45
	bl	run_as_user
	cbnz	w0, .L170
.L100:
	stp	x23, x24, [sp, 48]
	bl	use_noconfirm
	cbnz	w0, .L171
	adrp	x21, .LC33
	add	x23, x21, :lo12:.LC33
.L101:
	bl	use_noconfirm
	add	x24, x21, :lo12:.LC33
	mov	x3, x23
	mov	x4, x24
	adrp	x2, .LC47
	add	x2, x2, :lo12:.LC47
	mov	x1, 4096
	add	x22, sp, 2416
	mov	x0, x22
	bl	xsnprintf
	mov	x0, x22
	bl	run_cmd
	adrp	x1, .LC48
	mov	w23, w0
	add	x0, x1, :lo12:.LC48
	bl	unlink
	cbnz	w23, .L172
	stp	x25, x26, [sp, 64]
	bl	set_build_env
	add	x26, sp, 880
	mov	x0, x26
	mov	x1, 512
	bl	write_makepkg_conf
	cbz	w0, .L161
	adrp	x23, .LANCHOR0
	add	x0, x23, :lo12:.LANCHOR0
	ldr	w0, [x0, 1552]
	str	x27, [sp, 80]
	cbz	w0, .L173
.L103:
	bl	get_resume
	bl	get_use_pipe
	cbz	w0, .L174
	add	x25, sp, 1392
	adrp	x3, .LC36
	mov	x0, x25
	add	x3, x3, :lo12:.LC36
.L165:
	adrp	x27, .LC59
	add	x2, x27, :lo12:.LC59
	mov	x1, 16
	bl	xsnprintf
	adrp	x24, .LC61
	bl	get_target_arch
	mov	x20, x0
	bl	get_opt_level
	mov	x4, x0
	mov	x3, x20
	mov	x5, x25
	add	x2, x24, :lo12:.LC61
	mov	x1, 256
	adrp	x20, .LC34
	add	x20, x20, :lo12:.LC34
	mov	x0, x22
	bl	xsnprintf
	bl	get_jobs
	mov	x2, x0
	mov	x1, x22
	adrp	x3, .LC52
	adrp	x0, .LC51
	add	x3, x3, :lo12:.LC52
	add	x0, x0, :lo12:.LC51
	bl	printf
.L114:
	bl	use_noconfirm
	cmp	w0, 0
	add	x5, x21, :lo12:.LC33
	adrp	x0, .LC35
	add	x0, x0, :lo12:.LC35
	mov	x4, x26
	csel	x5, x5, x0, eq
	mov	x3, x20
	adrp	x2, .LC53
	add	x2, x2, :lo12:.LC53
	mov	x1, 1024
	mov	x0, x25
	bl	xsnprintf
	bl	get_inhibit
	cbz	w0, .L117
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	have_cmd
	cbnz	w0, .L175
.L117:
	mov	x3, x25
	add	x2, x27, :lo12:.LC59
	mov	x0, 6512
	mov	x1, 8192
	add	x20, sp, x0
	mov	x0, x20
	bl	xsnprintf
	bl	get_inhibit
	cbnz	w0, .L176
.L120:
	bl	get_use_pipe
	add	x21, x21, :lo12:.LC33
	cmp	w0, 0
	adrp	x3, .LC36
	add	x3, x3, :lo12:.LC36
	add	x2, x27, :lo12:.LC59
	csel	x3, x21, x3, eq
	mov	x1, 16
	add	x25, sp, 96
	add	x19, sp, 112
	mov	x0, x25
	bl	xsnprintf
	bl	get_target_arch
	mov	x26, x0
	bl	get_opt_level
	mov	x4, x0
	mov	x5, x25
	mov	x3, x26
	add	x2, x24, :lo12:.LC61
	mov	x1, 256
	mov	x0, x19
	bl	xsnprintf
	bl	get_jobs
	mov	x5, x0
	mov	x4, x19
	mov	x3, x19
	adrp	x2, .LC62
	add	x2, x2, :lo12:.LC62
	mov	x1, 1024
	mov	x0, x22
	bl	xsnprintf
	mov	x1, x22
	mov	x0, x20
	bl	run_as_user
	cmp	w0, 143
	mov	w2, w0
	sub	w0, w0, #129
	ccmp	w0, 2, 0, ne
	bls	.L177
	cbnz	w2, .L178
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x3, .LC35
	add	x3, x3, :lo12:.LC35
	csel	x3, x21, x3, eq
	adrp	x2, .LC65
	add	x2, x2, :lo12:.LC65
	mov	x1, 8192
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbnz	w0, .L179
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	printf
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x3, .LC32
	add	x3, x3, :lo12:.LC32
	csel	x3, x21, x3, eq
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
	mov	x1, 8192
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	w2, w0
	mov	w0, 1
	cbnz	w2, .L180
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L91
	.p2align 2,,3
.L167:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC39
	add	x1, x1, :lo12:.LC39
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
.L93:
	mov	w0, 0
.L91:
	ldp	x29, x30, [sp]
	mov	x12, 14704
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L166:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC37
	add	x1, x1, :lo12:.LC37
	ldr	x0, [x0]
	bl	fprintf
	b	.L93
	.p2align 2,,3
.L171:
	adrp	x23, .LC32
	adrp	x21, .LC33
	add	x23, x23, :lo12:.LC32
	b	.L101
	.p2align 2,,3
.L169:
	adrp	x2, .LC43
	add	x2, x2, :lo12:.LC43
	mov	x1, 2048
	add	x21, sp, 2416
	mov	x0, x21
	bl	xsnprintf
	adrp	x0, .LC44
	add	x0, x0, :lo12:.LC44
	bl	printf
	mov	x1, 0
	mov	x0, x21
	bl	run_as_user
	adrp	x0, .LC45
	mov	x1, 0
	add	x0, x0, :lo12:.LC45
	bl	run_as_user
	cbz	w0, .L100
.L170:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC46
	mov	x2, 56
	add	x0, x0, :lo12:.LC46
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x21, x22, [sp, 32]
	b	.L93
	.p2align 2,,3
.L168:
	bl	get_editor
	mov	x3, x0
	mov	x2, 6512
	add	x22, sp, x2
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x0, x22
	mov	x1, 8192
	bl	xsnprintf
	mov	x0, x22
	mov	x1, 0
	bl	run_as_user
	b	.L96
	.p2align 2,,3
.L161:
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L93
	.p2align 2,,3
.L172:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w23
	adrp	x1, .LC49
	add	x1, x1, :lo12:.LC49
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L93
	.p2align 2,,3
.L175:
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	run_cmd_quiet
	cbnz	w0, .L119
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	bl	printf
	mov	x1, 6512
	add	x20, sp, x1
	mov	x4, x25
	mov	x3, x19
	mov	x0, x20
	adrp	x2, .LC57
	mov	x1, 8192
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	b	.L120
	.p2align 2,,3
.L180:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC69
	add	x1, x1, :lo12:.LC69
.L163:
	ldr	x0, [x0]
	bl	fprintf
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L93
	.p2align 2,,3
.L178:
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	b	.L163
	.p2align 2,,3
.L174:
	add	x25, sp, 1392
	mov	x3, x24
	mov	x0, x25
	b	.L165
	.p2align 2,,3
.L173:
	bl	get_resume
	cbnz	w0, .L181
.L104:
	bl	get_resume
	cbnz	w0, .L106
	bl	get_use_pipe
	cbz	w0, .L159
.L112:
	add	x25, sp, 1392
	adrp	x3, .LC36
	adrp	x27, .LC59
	mov	x0, x25
	add	x3, x3, :lo12:.LC36
	add	x2, x27, :lo12:.LC59
	mov	x1, 16
.L164:
	bl	xsnprintf
	adrp	x24, .LC61
	bl	get_target_arch
	mov	x20, x0
	bl	get_opt_level
	mov	x4, x0
	mov	x3, x20
	add	x2, x24, :lo12:.LC61
	mov	x5, x25
	mov	x1, 256
	mov	x0, x22
	bl	xsnprintf
	add	x20, x21, :lo12:.LC33
	bl	get_jobs
	mov	x2, x0
	mov	x3, x20
	mov	x1, x22
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	bl	printf
	b	.L114
	.p2align 2,,3
.L176:
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	have_cmd
	cbnz	w0, .L120
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC60
	mov	x2, 77
	mov	x1, 1
	add	x0, x0, :lo12:.LC60
	ldr	x3, [x3]
	bl	fwrite
	b	.L120
	.p2align 2,,3
.L179:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC66
	mov	x2, 62
	add	x0, x0, :lo12:.LC66
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L93
	.p2align 2,,3
.L106:
	adrp	x0, .LC50
	add	x0, x0, :lo12:.LC50
	bl	printf
	bl	get_use_pipe
	cbnz	w0, .L112
.L159:
	add	x25, sp, 1392
	adrp	x27, .LC59
	mov	x0, x25
	add	x2, x27, :lo12:.LC59
	add	x3, x21, :lo12:.LC33
	mov	x1, 16
	b	.L164
	.p2align 2,,3
.L181:
	mov	x0, x20
	bl	has_reusable_source_tree
	cbnz	w0, .L103
	b	.L104
.L119:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC58
	mov	x2, 125
	mov	x1, 1
	add	x0, x0, :lo12:.LC58
	ldr	x3, [x3]
	bl	fwrite
	b	.L117
.L177:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x23, x23, :lo12:.LANCHOR0
	adrp	x0, .LC63
	mov	x2, 43
	add	x0, x0, :lo12:.LC63
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldr	w0, [x23, 4]
	cbz	w0, .L125
	bl	restore_backup.part.0
.L125:
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
	sub	sp, sp, #2496
	mov	x2, 320
	stp	x29, x30, [sp, 48]
	add	x29, sp, 48
	stp	x23, x24, [sp, 96]
	add	x23, sp, 128
	mov	x1, x23
	stp	x19, x20, [sp, 64]
	mov	x20, x0
	bl	regex_escape
	cbnz	w0, .L192
.L183:
	ldp	x29, x30, [sp, 48]
	mov	w0, 0
	ldp	x19, x20, [sp, 64]
	ldp	x23, x24, [sp, 96]
	add	sp, sp, 2496
	ret
	.p2align 2,,3
.L192:
	adrp	x19, .LC70
	add	x19, x19, :lo12:.LC70
	stp	x21, x22, [sp, 80]
	adrp	x22, .LC71
	add	x22, x22, :lo12:.LC71
	mov	x4, x19
	mov	x2, x22
	mov	x3, x23
	add	x21, sp, 448
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	cbz	w0, .L193
	str	x25, [sp, 112]
	bl	priv_prefix
	mov	x5, x19
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC73
	add	x2, x2, :lo12:.LC73
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	bl	priv_prefix
	mov	x24, x0
	bl	priv_prefix
	mov	x25, x0
	bl	priv_prefix
	stp	x25, x20, [sp]
	mov	x4, x24
	mov	x7, x19
	mov	x6, x19
	mov	x5, x20
	mov	x3, x19
	adrp	x2, .LC74
	add	x2, x2, :lo12:.LC74
	stp	x19, x0, [sp, 16]
	mov	x1, 2048
	mov	x0, x21
	stp	x20, x19, [sp, 32]
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	mov	x4, x19
	mov	x3, x23
	mov	x2, x22
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	cbnz	w0, .L194
	mov	x1, x20
	adrp	x0, .LC76
	add	x0, x0, :lo12:.LC76
	bl	printf
	ldr	x25, [sp, 112]
.L185:
	mov	w0, 1
	ldp	x21, x22, [sp, 80]
	ldp	x29, x30, [sp, 48]
	ldp	x19, x20, [sp, 64]
	ldp	x23, x24, [sp, 96]
	add	sp, sp, 2496
	ret
	.p2align 2,,3
.L193:
	mov	x1, x20
	adrp	x0, .LC72
	add	x0, x0, :lo12:.LC72
	bl	printf
	b	.L185
	.p2align 2,,3
.L194:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x3, x19
	mov	x2, x20
	adrp	x1, .LC75
	add	x1, x1, :lo12:.LC75
	ldr	x0, [x0]
	bl	fprintf
	ldr	x25, [sp, 112]
	ldp	x21, x22, [sp, 80]
	b	.L183
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
	sub	sp, sp, #640
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	get_resume
	cbnz	w0, .L202
	adrp	x0, .LC78
	add	x0, x0, :lo12:.LC78
	bl	printf
	adrp	x0, .LC79
	mov	w1, 0
	add	x0, x0, :lo12:.LC79
	bl	ask_yes_no
	cbz	w0, .L203
	adrp	x20, .LC8
	add	x20, x20, :lo12:.LC8
	mov	x0, x20
	bl	chdir
	cbnz	w0, .L195
	mov	x4, x19
	mov	x3, x20
	adrp	x2, .LC81
	add	x2, x2, :lo12:.LC81
	add	x0, sp, 40
	mov	x1, 600
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	adrp	x0, .LC82
	add	x0, x0, :lo12:.LC82
	bl	printf
.L195:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L203:
	ldp	x29, x30, [sp]
	mov	x2, x19
	ldp	x19, x20, [sp, 16]
	adrp	x1, .LC8
	add	sp, sp, 640
	add	x1, x1, :lo12:.LC8
	adrp	x0, .LC80
	add	x0, x0, :lo12:.LC80
	b	printf
	.p2align 2,,3
.L202:
	ldp	x29, x30, [sp]
	mov	x2, x19
	ldp	x19, x20, [sp, 16]
	adrp	x1, .LC8
	add	sp, sp, 640
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
	.string	"."
	.align	3
.LC85:
	.string	"\033[1;33m[!] Binary install failed for %s, falling back to source build\n\033[0m"
	.align	3
.LC86:
	.string	"Continue with source build?"
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
	sub	sp, sp, #992
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbz	w0, .L233
	bl	get_use_binary
	cbnz	w0, .L207
.L210:
	mov	w1, 524288
	adrp	x0, .LC84
	add	x0, x0, :lo12:.LC84
	stp	x21, x22, [sp, 32]
	adrp	x21, .LANCHOR0
	stp	x23, x24, [sp, 48]
	add	x23, sp, 88
	str	x25, [sp, 64]
	bl	open
	movi	v31.4s, 0
	add	x1, sp, 96
	adrp	x2, restore_on_signal
	mov	w22, w0
	mov	x0, x1
	add	x1, x2, :lo12:restore_on_signal
	str	x1, [sp, 88]
	str	q31, [sp, 96]
	stp	q31, q31, [x0, 16]
	stp	q31, q31, [x0, 48]
	stp	q31, q31, [x0, 80]
	stp	q31, q31, [x0, 112]
	bl	sigemptyset
	mov	x1, x23
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	mov	x1, x23
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	mov	x2, 0
	mov	x1, x23
	mov	w0, 1
	bl	sigaction
	add	x1, x21, :lo12:.LANCHOR0
	mov	x0, x19
	str	wzr, [x1, 4]
	bl	is_kernel
	mov	w24, w0
	mov	x3, x19
	cmp	w24, 0
	mov	w1, 1
	cset	w2, ne
	adrp	x0, .LC87
	add	w25, w2, 4
	add	x0, x0, :lo12:.LC87
	mov	w2, w25
	bl	printf
	mov	x0, x19
	bl	fetch_sources
	cbz	w0, .L211
	mov	w2, w25
	mov	w1, 2
	adrp	x0, .LC88
	add	x0, x0, :lo12:.LC88
	bl	printf
	mov	x0, x19
	bl	compile_package
	mov	w20, w0
	cbz	w0, .L211
	cbnz	w24, .L234
	mov	w2, w25
	mov	w1, 3
	adrp	x0, .LC91
	add	x0, x0, :lo12:.LC91
	bl	printf
	mov	x0, x19
	bl	lock_pacman_pkg
	mov	x0, x19
	bl	add_to_world
	mov	w2, w25
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
.L214:
	add	x21, x21, :lo12:.LANCHOR0
	ldr	w0, [x21, 4]
	cbz	w0, .L218
	add	x3, x21, 784
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 900
	mov	x0, x23
	bl	xsnprintf
	mov	x0, x23
	bl	run_cmd_quiet
	str	wzr, [x21, 4]
.L218:
	tbz	w22, #31, .L235
.L232:
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldr	x25, [sp, 64]
.L204:
	mov	w0, w20
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 992
	ret
	.p2align 2,,3
.L207:
	mov	x0, x19
	mov	w20, 1
	bl	cmd_binary_install
	cbnz	w0, .L204
	mov	x1, x19
	adrp	x0, .LC85
	add	x0, x0, :lo12:.LC85
	bl	printf
	adrp	x0, .LC86
	mov	w1, 0
	add	x0, x0, :lo12:.LC86
	bl	ask_yes_no
	cbnz	w0, .L210
	mov	w20, 0
.L236:
	ldp	x29, x30, [sp]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 992
	ret
	.p2align 2,,3
.L211:
	add	x21, x21, :lo12:.LANCHOR0
	ldr	w0, [x21, 4]
	cbnz	w0, .L217
	mov	w20, 0
	.p2align 5,,15
.L237:
	tbnz	w22, #31, .L232
.L235:
	mov	w0, w22
	bl	fchdir
	mov	w0, w22
	bl	close
	ldr	x25, [sp, 64]
	mov	w0, w20
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 992
	ret
	.p2align 2,,3
.L233:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC83
	mov	w20, 0
	add	x1, x1, :lo12:.LC83
	ldr	x0, [x0]
	bl	fprintf
	b	.L236
	.p2align 2,,3
.L217:
	mov	w20, 0
	bl	restore_backup.part.0
	b	.L237
	.p2align 2,,3
.L234:
	mov	x0, x19
	bl	pkg_ships_kernel
	cbnz	w0, .L238
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC95
	add	x1, x1, :lo12:.LC95
	ldr	x0, [x0]
	bl	fprintf
	mov	w2, w25
	mov	w1, 3
	adrp	x0, .LC91
	add	x0, x0, :lo12:.LC91
	bl	printf
	mov	x0, x19
	bl	lock_pacman_pkg
	mov	x0, x19
	bl	add_to_world
	mov	w2, w25
	mov	w1, 4
	adrp	x0, .LC92
	add	x0, x0, :lo12:.LC92
	bl	printf
	mov	x0, x19
	bl	cleanup_build_dir
	mov	x1, x19
	adrp	x0, .LC93
	add	x0, x0, :lo12:.LC93
	bl	printf
	b	.L214
	.p2align 2,,3
.L238:
	mov	w2, w25
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
	mov	x0, x23
	bl	xsnprintf
	mov	x0, x23
	bl	lock_pacman_pkg
	mov	w2, w25
	mov	w1, 4
	adrp	x0, .LC91
	add	x0, x0, :lo12:.LC91
	bl	printf
	mov	x0, x19
	bl	lock_pacman_pkg
	mov	x0, x19
	bl	add_to_world
	mov	w2, w25
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
	b	.L214
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
