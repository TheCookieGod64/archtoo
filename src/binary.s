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
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	stp	xzr, xzr, [sp, 64]
	stp	q31, q31, [sp, 80]
	stp	q31, q31, [sp, 112]
	stp	q31, q31, [sp, 144]
	stp	q31, q31, [sp, 176]
	stp	q31, q31, [sp, 208]
	stp	q31, q31, [sp, 240]
	stp	q31, q31, [sp, 272]
	stp	q31, q31, [sp, 304]
	bl	config_current
	add	x3, sp, 80
	add	x2, sp, 64
	mov	x1, x22
	add	x0, x0, 20
	mov	x4, 256
	bl	aur_rpc_info
	mov	w19, w0
	cbz	w0, .L1
	str	x23, [sp, 48]
	ldr	x23, [sp, 72]
	cbz	x23, .L9
	ldr	x19, [sp, 64]
	mov	x21, 0
	.p2align 5,,15
.L8:
	ldr	x20, [x19]
	cbz	x20, .L5
	mov	x1, x22
	mov	x0, x20
	bl	strcmp
	cbnz	w0, .L5
	ldr	x2, [x19, 16]
	cbz	x2, .L20
.L6:
	ldr	x4, [x19, 24]
	ldr	x3, [x19, 48]
	ldr	d0, [x19, 56]
	cbz	x4, .L21
.L7:
	mov	w19, 1
	mov	x1, x20
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
.L4:
	add	x0, sp, 64
	bl	aur_response_destroy
	ldr	x23, [sp, 48]
.L1:
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 336
	ret
	.p2align 2,,3
.L5:
	add	x21, x21, 1
	add	x19, x19, 152
	cmp	x21, x23
	bne	.L8
.L9:
	mov	w19, 0
	b	.L4
	.p2align 2,,3
.L21:
	adrp	x4, .LC1
	add	x4, x4, :lo12:.LC1
	b	.L7
	.p2align 2,,3
.L20:
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	b	.L6
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
	mov	x12, 5888
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	bl	valid_pkgname
	cbz	w0, .L87
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	stp	x21, x22, [sp, 32]
	bl	printf
	mov	x1, x20
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	str	xzr, [sp, 80]
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x20
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 700
	add	x0, sp, 1408
	bl	xsnprintf
	add	x1, sp, 80
	add	x0, sp, 1408
	bl	run_cmd_capture
	mov	w22, w0
	ldr	x0, [sp, 80]
	cbz	x0, .L27
	ldrb	w1, [x0]
	cbnz	w1, .L88
.L27:
	bl	free
	str	xzr, [sp, 80]
	add	x21, sp, 3840
	adrp	x19, .LC7
	cbnz	w22, .L28
.L80:
	mov	x3, x20
	add	x2, x19, :lo12:.LC7
	mov	x1, 600
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	cbz	w0, .L89
.L28:
	add	x2, x19, :lo12:.LC7
	mov	x3, x20
	mov	x1, 600
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd_quiet
	mov	w19, w0
	cbz	w0, .L90
	mov	x1, x20
	adrp	x0, .LC34
	add	x0, x0, :lo12:.LC34
	stp	x23, x24, [sp, 48]
	bl	printf
	adrp	x0, .LANCHOR0
	add	x23, x0, :lo12:.LANCHOR0
	adrp	x0, .LC35
	add	x24, x0, :lo12:.LC35
	mov	x22, 0
.L54:
	ldr	x4, [x23, x22, lsl 3]
	mov	x3, x20
	mov	x2, x24
	mov	x1, 300
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	aur_has_exact
	mov	w19, w0
	cbnz	w0, .L91
	add	x22, x22, 1
	cmp	x22, 4
	bne	.L54
	mov	x0, x20
	bl	aur_has_exact
	mov	x1, x20
	cbz	w0, .L55
	adrp	x0, .LC38
	add	x0, x0, :lo12:.LC38
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	mov	x12, 5888
	ldp	x23, x24, [sp, 48]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L90:
	mov	w2, w22
	mov	x1, x20
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	str	xzr, [sp, 88]
	mov	x3, x20
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	mov	x1, 700
	add	x0, sp, 2112
	bl	xsnprintf
	add	x1, sp, 88
	add	x0, sp, 2112
	bl	run_cmd_capture
	cbnz	w0, .L30
	ldr	x6, [sp, 88]
	cbz	x6, .L30
	ldrb	w22, [x6]
	cbz	w22, .L30
	mov	x0, x6
	mov	w1, 10
	str	x6, [sp, 72]
	bl	strchr
	ldr	x6, [sp, 72]
	cbz	x0, .L33
	strb	wzr, [x0]
	ldr	x6, [sp, 88]
	ldrb	w22, [x6]
.L33:
	mov	x1, 9728
	movk	x1, 0x1, lsl 32
	b	.L34
	.p2align 2,,3
.L38:
	ldrb	w22, [x6, 1]!
.L34:
	cmp	w22, 32
	bhi	.L92
	lsr	x0, x1, x22
	tbnz	x0, 0, .L38
	mov	x0, x6
	str	x6, [sp, 72]
	bl	strlen
	ldr	x6, [sp, 72]
	cbz	x0, .L39
.L36:
	mov	x2, 9728
	movk	x2, 0x1, lsl 32
	.p2align 5,,15
.L40:
	sub	x0, x0, #1
	ldrb	w1, [x6, x0]
	cmp	w1, 32
	bhi	.L41
	lsr	x1, x2, x1
	tbz	x1, 0, .L41
	strb	wzr, [x6, x0]
	cbnz	x0, .L40
.L41:
	ldrb	w22, [x6]
.L39:
	cbz	w22, .L43
.L37:
	mov	x0, x6
	mov	x2, 4
	adrp	x1, .LC13
	add	x1, x1, :lo12:.LC13
	str	x6, [sp, 72]
	bl	strncmp
	ldr	x6, [sp, 72]
	mov	w19, w0
	cbz	w0, .L44
.L43:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x6
	adrp	x1, .LC14
	add	x1, x1, :lo12:.LC14
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 88]
	bl	free
	ldp	x21, x22, [sp, 32]
	b	.L22
	.p2align 2,,3
.L87:
	mov	w19, w0
	adrp	x1, .LC3
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	add	x1, x1, :lo12:.LC3
	ldr	x0, [x0]
	bl	fprintf
.L22:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 5888
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L88:
	adrp	x1, :got:stdout
	ldr	x1, [x1, :got_lo12:stdout]
	add	x21, sp, 3840
	adrp	x19, .LC7
	ldr	x1, [x1]
	bl	fputs
	ldr	x0, [sp, 80]
	bl	free
	str	xzr, [sp, 80]
	cbz	w22, .L80
	b	.L28
	.p2align 2,,3
.L55:
	adrp	x0, .LC39
	add	x0, x0, :lo12:.LC39
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	mov	x12, 5888
	ldp	x23, x24, [sp, 48]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L89:
	mov	x1, x20
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	adrp	x0, .LC9
	mov	w19, 1
	add	x0, x0, :lo12:.LC9
	bl	printf
	ldp	x21, x22, [sp, 32]
	b	.L22
	.p2align 2,,3
.L30:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 88]
	bl	free
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	mov	x12, 5888
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L92:
	mov	x0, x6
	str	x6, [sp, 72]
	bl	strlen
	ldr	x6, [sp, 72]
	cbnz	x0, .L36
	b	.L37
	.p2align 2,,3
.L91:
	mov	x1, x21
	adrp	x0, .LC36
	add	x0, x0, :lo12:.LC36
	bl	printf
	mov	x1, x21
	mov	x2, x20
	adrp	x0, .LC37
	mov	w19, 0
	add	x0, x0, :lo12:.LC37
	bl	printf
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L22
	.p2align 2,,3
.L44:
	mov	x1, x6
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	str	x6, [sp, 72]
	bl	printf
	bl	getpid
	sxtw	x4, w0
	mov	x3, x20
	mov	x1, 512
	add	x0, sp, 296
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	xsnprintf
	ldr	x6, [sp, 72]
	add	x5, sp, 296
	mov	x3, x5
	adrp	x2, .LC17
	mov	x4, x6
	add	x2, x2, :lo12:.LC17
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	mov	x0, x21
	bl	run_cmd
	mov	w21, w0
	ldr	x0, [sp, 88]
	bl	free
	cbnz	w21, .L45
	add	x0, sp, 296
	bl	file_exists
	cbz	w0, .L45
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	add	x1, sp, 96
	add	x0, sp, 296
	bl	sha256_file
	cbnz	w0, .L47
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 296
	adrp	x1, .LC22
	add	x1, x1, :lo12:.LC22
	ldr	x0, [x0]
	bl	fprintf
	add	x3, sp, 296
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	add	x0, sp, 2816
	bl	xsnprintf
	add	x0, sp, 2816
	bl	run_cmd_quiet
	mov	w1, 0
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	ask_yes_no
	mov	w19, w0
	cbnz	w0, .L93
.L84:
	ldp	x21, x22, [sp, 32]
	b	.L22
.L93:
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	printf
	mov	x0, x20
	bl	cmd_binary_install
	ldp	x21, x22, [sp, 32]
	mov	w19, w0
	b	.L22
	.p2align 2,,3
.L45:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC19
	add	x1, x1, :lo12:.LC19
	ldr	x0, [x0]
	bl	fprintf
	add	x3, sp, 296
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	add	x0, sp, 2816
	bl	xsnprintf
	add	x0, sp, 2816
	bl	run_cmd_quiet
	ldp	x21, x22, [sp, 32]
	b	.L22
.L47:
	add	x2, sp, 96
	mov	x1, x20
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	printf
	add	x1, sp, 168
	add	x0, sp, 296
	bl	stat
	ldr	x2, [sp, 216]
	cbnz	w0, .L49
	cmp	x2, 1023
	bgt	.L50
.L49:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC26
	add	x1, x1, :lo12:.LC26
	ldr	x0, [x0]
	bl	fprintf
	add	x3, sp, 296
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	add	x0, sp, 2816
	bl	xsnprintf
	add	x0, sp, 2816
	bl	run_cmd_quiet
	mov	w1, 0
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	ask_yes_no
	mov	w19, w0
	cbz	w0, .L84
.L85:
	mov	x0, x20
	bl	cmd_binary_install
	ldp	x21, x22, [sp, 32]
	mov	w19, w0
	b	.L22
.L50:
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	printf
	add	x3, sp, 296
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	mov	x1, 1024
	add	x0, sp, 2816
	bl	xsnprintf
	add	x0, sp, 2816
	bl	run_cmd
	mov	w19, w0
	add	x3, sp, 296
	adrp	x2, .LC20
	add	x2, x2, :lo12:.LC20
	mov	x1, 600
	add	x0, sp, 808
	bl	xsnprintf
	add	x0, sp, 808
	bl	run_cmd_quiet
	cbz	w19, .L52
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w3, w19
	mov	x2, x20
	adrp	x1, .LC30
	add	x1, x1, :lo12:.LC30
	ldr	x0, [x0]
	bl	fprintf
	mov	w1, 0
	adrp	x0, .LC31
	add	x0, x0, :lo12:.LC31
	bl	ask_yes_no
	mov	w19, w0
	cbnz	w0, .L85
	ldp	x21, x22, [sp, 32]
	b	.L22
.L52:
	mov	x1, x20
	adrp	x0, .LC32
	add	x0, x0, :lo12:.LC32
	bl	printf
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	printf
	mov	w19, 1
	mov	x0, x20
	bl	add_to_world
	ldp	x21, x22, [sp, 32]
	b	.L22
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
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
