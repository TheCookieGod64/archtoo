	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"?"
	.align	3
.LC1:
	.string	""
	.align	3
.LC2:
	.string	"\033[1;32m    aur/%s  %s  (\342\227\206%ld %.2f) %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	aur_has_exact, %function
aur_has_exact:
	movi	v31.4s, 0
	stp	x29, x30, [sp, -336]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 80
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	stp	x23, x24, [sp, 48]
	add	x23, sp, 64
	stp	xzr, xzr, [sp, 64]
	stp	q31, q31, [x19]
	stp	q31, q31, [x19, 32]
	stp	q31, q31, [x19, 64]
	stp	q31, q31, [x19, 96]
	stp	q31, q31, [x19, 128]
	stp	q31, q31, [x19, 160]
	stp	q31, q31, [x19, 192]
	stp	q31, q31, [x19, 224]
	bl	config_current
	mov	x3, x19
	add	x0, x0, 20
	mov	x2, x23
	mov	x1, x22
	mov	x4, 256
	bl	aur_rpc_info
	mov	w19, w0
	cbz	w0, .L1
	ldr	x24, [sp, 72]
	cbz	x24, .L8
	ldr	x19, [sp, 64]
	mov	x21, 0
	.p2align 5,,15
.L7:
	ldr	x20, [x19]
	mov	x1, x22
	mov	x0, x20
	cbz	x20, .L4
	bl	strcmp
	cbnz	w0, .L4
	ldp	x2, x4, [x19, 16]
	adrp	x0, .LC0
	ldr	x3, [x19, 48]
	add	x0, x0, :lo12:.LC0
	ldr	d0, [x19, 56]
	mov	w19, 1
	mov	x1, x20
	cmp	x2, 0
	csel	x2, x0, x2, eq
	cmp	x4, 0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	csel	x4, x0, x4, eq
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
.L3:
	mov	x0, x23
	bl	aur_response_destroy
.L1:
	ldp	x21, x22, [sp, 32]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 336
	ret
	.p2align 2,,3
.L4:
	add	x21, x21, 1
	add	x19, x19, 152
	cmp	x21, x24
	bne	.L7
.L8:
	mov	w19, 0
	b	.L3
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC4:
	.string	"\033[1;33m>>> Binary mode: repo first, then yay-style AUR binary search (long flag only)\n\033[0m"
	.align	3
.LC5:
	.string	"\033[1;34m>>> [1/2] Trying official repo binary via pacman -S --needed %s...\n\033[0m"
	.align	3
.LC6:
	.string	"%spacman -S --needed --noconfirm '%s' 2>&1"
	.align	3
.LC7:
	.string	"pacman -Si '%s' >/dev/null 2>&1"
	.align	3
.LC8:
	.string	"\033[1;32m[+] %s installed from the official repo (pacman -S). No world/lock needed: pacman owns it.\n\033[0m"
	.align	3
.LC9:
	.string	"\033[1;33m[!] Against Gentoo principles, but boring-fast like yay\n\033[0m"
	.align	3
.LC10:
	.string	"\033[1;33m[!] %s is in the repos but pacman -S failed (rc=%d); trying manual download route...\n\033[0m"
	.align	3
.LC11:
	.string	"pacman -Sp --noconfirm '%s' 2>/dev/null | head -n1"
	.align	3
.LC12:
	.string	"\033[1;31m[-] Could not get binary URL for %s\n\033[0m"
	.align	3
.LC13:
	.string	"http"
	.align	3
.LC14:
	.string	"\033[1;31m[-] Invalid URL: '%s'\n\033[0m"
	.align	3
.LC15:
	.string	"\033[1;32m[+] Binary URL: %s\n\033[0m"
	.align	3
.LC16:
	.string	"/tmp/archtoo-bin-%s-%ld.pkg.tar.zst"
	.align	3
.LC17:
	.string	"curl -fL -o '%s' '%s' 2>&1 || wget -O '%s' '%s' 2>&1"
	.align	3
.LC18:
	.string	"\033[1;34m>>> Downloading binary package...\n\033[0m"
	.align	3
.LC19:
	.string	"\033[1;31m[-] Failed to download binary for %s\n\033[0m"
	.align	3
.LC20:
	.string	"rm -f '%s'"
	.align	3
.LC21:
	.string	"\033[1;34m>>> Checking SHA256 (self implementation, no external program)...\n\033[0m"
	.align	3
.LC22:
	.string	"\033[1;31m[-] Could not compute SHA256 for %s\n\033[0m"
	.align	3
.LC23:
	.string	"SHA256 check failed, try again?"
	.align	3
.LC24:
	.string	"\033[1;33m[!] Retrying download...\n\033[0m"
	.align	3
.LC25:
	.string	"\033[1;32m[+] SHA256(%s) = %s\n\033[0m"
	.align	3
.LC26:
	.string	"\033[1;31m[-] Downloaded file too small or invalid (%ld bytes)\n\033[0m"
	.align	3
.LC27:
	.string	"Delete and try again?"
	.align	3
.LC28:
	.string	"\033[1;34m>>> Installing binary package with pacman -U...\n\033[0m"
	.align	3
.LC29:
	.string	"pacman -U --noconfirm '%s' 2>&1"
	.align	3
.LC30:
	.string	"\033[1;31m[-] Binary install failed for %s (exit %d)\n\033[0m"
	.align	3
.LC31:
	.string	"Binary install failed, try again?"
	.align	3
.LC32:
	.string	"\033[1;32m[+] Binary package %s installed successfully\n\033[0m"
	.align	3
.LC33:
	.string	"\033[1;33m[!] Against Gentoo principles, but fast like yay\n\033[0m"
	.align	3
.LC34:
	.string	"\033[1;33m[!] %s not in official repos \342\206\222 searching AUR for a prebuilt binary (like yay)...\n\033[0m"
	.align	3
.LC35:
	.string	"%s%s"
	.align	3
.LC36:
	.string	"\033[1;32m[+] Prebuilt AUR variant found: %s (upstream binary, makepkg only repackages it - no compiling)\n\033[0m"
	.align	3
.LC37:
	.string	"\033[1;34m>>> Tip: 'emerge --binary %s' targets it directly; continuing with %s's source build as requested\n\033[0m"
	.align	3
.LC38:
	.string	"\033[1;33m[!] %s exists in AUR but only as a source build; no -bin variant found (yay would compile it)\n\033[0m"
	.align	3
.LC39:
	.string	"\033[1;31m[-] %s: not in official repos and nothing in AUR either - no binary to find\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_binary_install
	.type	cmd_binary_install, %function
cmd_binary_install:
	mov	x12, 5872
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	stp	x21, x22, [sp, 32]
	bl	valid_pkgname
	cbz	w0, .L91
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	str	x23, [sp, 48]
	bl	printf
	mov	x1, x19
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	str	xzr, [sp, 64]
	add	x20, sp, 1392
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 700
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	add	x1, sp, 64
	bl	run_cmd_capture
	mov	w23, w0
	ldr	x0, [sp, 64]
	cbz	x0, .L22
	ldrb	w1, [x0]
	cbnz	w1, .L92
.L22:
	bl	free
	str	xzr, [sp, 64]
	cbz	w23, .L83
.L95:
	add	x21, sp, 3824
	adrp	x20, .LC7
.L23:
	add	x2, x20, :lo12:.LC7
	mov	x3, x19
	mov	x1, 600
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	mov	w22, w0
	cbnz	w0, .L25
	mov	w2, w23
	mov	x1, x19
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	add	x20, sp, 2096
	mov	x3, x19
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	mov	x1, 700
	mov	x0, x20
	str	xzr, [sp, 72]
	bl	xsnprintf
	mov	x0, x20
	add	x1, sp, 72
	bl	run_cmd_capture
	cbnz	w0, .L26
	ldr	x20, [sp, 72]
	cbz	x20, .L26
	ldrb	w23, [x20]
	cbz	w23, .L26
	mov	x0, x20
	mov	w1, 10
	bl	strchr
	cbz	x0, .L29
	strb	wzr, [x0]
	ldr	x20, [sp, 72]
	ldrb	w23, [x20]
.L29:
	mov	x1, 9728
	movk	x1, 0x1, lsl 32
	b	.L30
	.p2align 2,,3
.L34:
	ldrb	w23, [x20, 1]!
.L30:
	cmp	w23, 32
	bhi	.L93
	lsr	x0, x1, x23
	tbnz	x0, 0, .L34
	mov	x0, x20
	bl	strlen
	mov	x1, x0
	cbz	x0, .L35
.L32:
	mov	x0, 9728
	movk	x0, 0x1, lsl 32
	.p2align 5,,15
.L36:
	sub	x1, x1, #1
	ldrb	w2, [x20, x1]
	cmp	w2, 32
	bhi	.L37
	lsr	x2, x0, x2
	tbz	x2, 0, .L37
	strb	wzr, [x20, x1]
	cbnz	x1, .L36
.L37:
	ldrb	w23, [x20]
.L35:
	cbz	w23, .L39
.L33:
	adrp	x1, .LC13
	mov	x0, x20
	add	x1, x1, :lo12:.LC13
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L40
.L39:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC14
	mov	x2, x20
	add	x1, x1, :lo12:.LC14
.L88:
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 72]
	bl	free
	ldr	x23, [sp, 48]
	mov	w0, w22
	ldp	x29, x30, [sp]
	mov	x12, 5872
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L83:
	mov	x3, x19
	adrp	x20, .LC7
	add	x2, x20, :lo12:.LC7
	add	x21, sp, 3824
	mov	x1, 600
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	cbnz	w0, .L23
	mov	x1, x19
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	adrp	x0, .LC9
	mov	w22, 1
	add	x0, x0, :lo12:.LC9
	bl	printf
	ldr	x23, [sp, 48]
	b	.L19
	.p2align 2,,3
.L91:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC3
	mov	x2, x19
	add	x1, x1, :lo12:.LC3
	ldr	x0, [x0]
	bl	fprintf
.L21:
	mov	w22, 0
.L19:
	ldp	x29, x30, [sp]
	mov	w0, w22
	ldp	x19, x20, [sp, 16]
	mov	x12, 5872
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L25:
	adrp	x23, .LANCHOR0
	adrp	x22, .LC35
	add	x23, x23, :lo12:.LANCHOR0
	add	x22, x22, :lo12:.LC35
	mov	x20, 0
	mov	x1, x19
	adrp	x0, .LC34
	add	x0, x0, :lo12:.LC34
	bl	printf
.L51:
	ldr	x4, [x23, x20, lsl 3]
	mov	x3, x19
	mov	x2, x22
	mov	x1, 300
	mov	x0, x21
	add	x20, x20, 1
	bl	xsnprintf
	mov	x0, x21
	bl	aur_has_exact
	cbnz	w0, .L94
	cmp	x20, 4
	bne	.L51
	mov	x0, x19
	bl	aur_has_exact
	mov	x1, x19
	cbz	w0, .L52
	adrp	x0, .LC38
	add	x0, x0, :lo12:.LC38
	bl	printf
	ldr	x23, [sp, 48]
	b	.L21
	.p2align 2,,3
.L92:
	adrp	x1, :got:stdout;ldr	x1, [x1, :got_lo12:stdout]
	ldr	x1, [x1]
	bl	fputs
	ldr	x0, [sp, 64]
	bl	free
	str	xzr, [sp, 64]
	cbz	w23, .L83
	b	.L95
	.p2align 2,,3
.L52:
	adrp	x0, .LC39
	add	x0, x0, :lo12:.LC39
	bl	printf
	ldr	x23, [sp, 48]
	b	.L21
	.p2align 2,,3
.L26:
	adrp	x1, .LC12
	mov	x2, x19
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC12
	b	.L88
	.p2align 2,,3
.L93:
	mov	x0, x20
	bl	strlen
	mov	x1, x0
	cbnz	x0, .L32
	b	.L33
	.p2align 2,,3
.L94:
	mov	x1, x21
	adrp	x0, .LC36
	add	x0, x0, :lo12:.LC36
	bl	printf
	mov	x2, x19
	mov	x1, x21
	adrp	x0, .LC37
	add	x0, x0, :lo12:.LC37
	bl	printf
	ldr	x23, [sp, 48]
	b	.L21
	.p2align 2,,3
.L40:
	mov	x1, x20
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	add	x23, sp, 280
	bl	getpid
	sxtw	x4, w0
	mov	x3, x19
	mov	x1, 512
	mov	x0, x23
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	xsnprintf
	mov	x6, x20
	mov	x4, x20
	mov	x5, x23
	mov	x3, x23
	adrp	x2, .LC17
	add	x2, x2, :lo12:.LC17
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	mov	x0, x21
	bl	run_cmd
	mov	w20, w0
	ldr	x0, [sp, 72]
	bl	free
	cbnz	w20, .L43
	mov	x0, x23
	bl	file_exists
	cbz	w0, .L43
	add	x20, sp, 80
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	mov	x1, x20
	mov	x0, x23
	bl	sha256_file
	cbnz	w0, .L44
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x23
	adrp	x1, .LC22
	add	x1, x1, :lo12:.LC22
	add	x20, sp, 2800
	ldr	x0, [x0]
	bl	fprintf
	mov	x3, x23
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	adrp	x0, .LC23
	mov	w1, 0
	add	x0, x0, :lo12:.LC23
	bl	ask_yes_no
	mov	w22, w0
	cbnz	w0, .L96
.L87:
	ldr	x23, [sp, 48]
	b	.L19
.L96:
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	printf
	mov	x0, x19
	bl	cmd_binary_install
	ldr	x23, [sp, 48]
	mov	w22, w0
	b	.L19
	.p2align 2,,3
.L43:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC19
	add	x1, x1, :lo12:.LC19
	add	x19, sp, 2800
	ldr	x0, [x0]
	bl	fprintf
	mov	x3, x23
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd_quiet
	ldr	x23, [sp, 48]
	b	.L19
.L44:
	mov	x2, x20
	mov	x1, x19
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	printf
	add	x1, sp, 152
	mov	x0, x23
	bl	stat
	ldr	x2, [sp, 200]
	cbnz	w0, .L46
	cmp	x2, 1023
	bgt	.L47
.L46:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC26
	add	x1, x1, :lo12:.LC26
	add	x20, sp, 2800
	ldr	x0, [x0]
	bl	fprintf
	mov	x3, x23
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	adrp	x0, .LC27
	mov	w1, 0
	add	x0, x0, :lo12:.LC27
	bl	ask_yes_no
	mov	w22, w0
	cbz	w0, .L87
.L89:
	mov	x0, x19
	bl	cmd_binary_install
	ldr	x23, [sp, 48]
	mov	w22, w0
	b	.L19
.L47:
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	printf
	add	x20, sp, 2800
	mov	x3, x23
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	add	x21, sp, 792
	bl	run_cmd
	mov	w20, w0
	mov	x3, x23
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	cbz	w20, .L49
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	w3, w20
	mov	x2, x19
	adrp	x1, .LC30
	add	x1, x1, :lo12:.LC30
	ldr	x0, [x0]
	bl	fprintf
	adrp	x0, .LC31
	mov	w1, 0
	add	x0, x0, :lo12:.LC31
	bl	ask_yes_no
	cbnz	w0, .L89
	ldr	x23, [sp, 48]
	b	.L19
.L49:
	mov	x1, x19
	adrp	x0, .LC32
	add	x0, x0, :lo12:.LC32
	bl	printf
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	printf
	mov	w22, 1
	mov	x0, x19
	bl	add_to_world
	ldr	x23, [sp, 48]
	b	.L19
	.section	.rodata.str1.8
	.align	3
.LC40:
	.string	"-bin"
	.align	3
.LC41:
	.string	"-binary"
	.align	3
.LC42:
	.string	"-prebuilt"
	.align	3
.LC43:
	.string	"-release"
	.section	.data.rel.ro.local,"aw"
	.align	4
	.set	.LANCHOR0,. + 0
	.type	sfx.0, %object
sfx.0:
	.xword	.LC40
	.xword	.LC41
	.xword	.LC42
	.xword	.LC43
	.section	.note.GNU-stack,"",@progbits
