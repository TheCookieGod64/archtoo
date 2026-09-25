	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%s"
	.align	3
.LC1:
	.string	"XDG_STATE_HOME"
	.align	3
.LC2:
	.string	"%s/archtoo"
	.align	3
.LC3:
	.string	"%s/.local/state/archtoo"
	.align	3
.LC4:
	.string	"%s/command-guide-seen"
	.text
	.align	2
	.p2align 5,,15
	.type	state_paths.constprop.0, %function
state_paths.constprop.0:
	sub	sp, sp, #816
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x20, x1
	bl	build_user
	cbz	x0, .L4
	bl	getpwnam
	cbz	x0, .L4
	ldr	x3, [x0, 32]
	cbz	x3, .L4
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 768
	add	x0, sp, 48
	bl	xsnprintf
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	getenv
	mov	x3, x0
	cbz	x0, .L5
	ldrb	w0, [x0]
	cbnz	w0, .L24
.L5:
	adrp	x2, .LC3
	add	x3, sp, 48
	add	x2, x2, :lo12:.LC3
	mov	x0, x19
	mov	x1, 1024
	bl	xsnprintf
.L6:
	mov	x3, x19
	mov	x0, x20
	mov	x1, 1200
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	bl	xsnprintf
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 816
	ret
	.p2align 2,,3
.L4:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 816
	ret
	.p2align 2,,3
.L24:
	str	x3, [sp, 40]
	bl	geteuid
	ldr	x3, [sp, 40]
	cbz	w0, .L5
	mov	x0, x19
	adrp	x2, .LC2
	mov	x1, 1024
	add	x2, x2, :lo12:.LC2
	bl	xsnprintf
	b	.L6
	.align	2
	.p2align 5,,15
	.type	guide_mark_seen.part.0, %function
guide_mark_seen.part.0:
	sub	sp, sp, #3296
	add	x1, sp, 2096
	add	x0, sp, 48
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	state_paths.constprop.0
	cbnz	w0, .L43
	ldp	x29, x30, [sp]
	add	sp, sp, 3296
	ret
	.p2align 2,,3
.L43:
	add	x3, sp, 48
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 1024
	add	x0, sp, 1072
	bl	xsnprintf
	add	x0, sp, 1072
	mov	w1, 47
	bl	strrchr
	cbz	x0, .L30
	strb	wzr, [x0]
	mov	w1, 448
	add	x0, sp, 1072
	bl	mkdir
	cbnz	w0, .L44
.L30:
	add	x0, sp, 48
	mov	w1, 448
	bl	mkdir
	cbz	w0, .L29
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	beq	.L29
	mov	w0, 0
.L45:
	ldp	x29, x30, [sp]
	add	sp, sp, 3296
	ret
	.p2align 2,,3
.L29:
	add	x0, sp, 2096
	mov	w2, 384
	mov	w1, 32961
	bl	open
	tbz	w0, #31, .L32
	bl	__errno_location
	ldr	w0, [x0]
	ldp	x29, x30, [sp]
	cmp	w0, 17
	cset	w0, eq
	add	sp, sp, 3296
	ret
	.p2align 2,,3
.L44:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	beq	.L30
	mov	w0, 0
	b	.L45
	.p2align 2,,3
.L32:
	adrp	x1, .LANCHOR0
	add	x1, x1, :lo12:.LANCHOR0
	mov	x2, 33
	str	x19, [sp, 16]
	str	w0, [sp, 44]
	bl	write
	mov	x19, x0
	bl	__errno_location
	ldr	w2, [x0]
	mov	x1, x0
	ldr	w0, [sp, 44]
	str	x1, [sp, 32]
	str	w2, [sp, 40]
	bl	close
	ldr	x1, [sp, 32]
	cmp	x19, 33
	ldr	w2, [sp, 40]
	cset	w0, eq
	ldr	x19, [sp, 16]
	str	w2, [x1]
	ldp	x29, x30, [sp]
	add	sp, sp, 3296
	ret
	.align	2
	.p2align 5,,15
	.type	guide_should_show.part.0, %function
guide_should_show.part.0:
	sub	sp, sp, #2240
	add	x1, sp, 1040
	add	x0, sp, 16
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	state_paths.constprop.0
	mov	w1, w0
	mov	w0, 1
	cbz	w1, .L46
	add	x0, sp, 1040
	mov	w1, 0
	bl	access
	cmp	w0, 0
	cset	w0, ne
.L46:
	ldp	x29, x30, [sp]
	add	sp, sp, 2240
	ret
	.section	.rodata.str1.8
	.align	3
.LC5:
	.string	"first-run"
	.align	3
.LC6:
	.string	"always"
	.align	3
.LC7:
	.string	"never"
	.text
	.align	2
	.p2align 5,,15
	.global	guide_policy_parse
	.type	guide_policy_parse, %function
guide_policy_parse:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	beq	.L62
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x1
	mov	x20, x0
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	bl	strcmp
	cbnz	w0, .L55
	str	wzr, [x19]
.L57:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L55:
	adrp	x1, .LC6
	mov	x0, x20
	add	x1, x1, :lo12:.LC6
	bl	strcmp
	cbz	w0, .L63
	adrp	x1, .LC7
	mov	x0, x20
	add	x1, x1, :lo12:.LC7
	bl	strcmp
	cbnz	w0, .L58
	mov	w0, 2
	str	w0, [x19]
	b	.L57
	.p2align 2,,3
.L62:
	mov	w0, 0
	ret
	.p2align 2,,3
.L63:
	mov	w0, 1
	str	w0, [x19]
	b	.L57
	.p2align 2,,3
.L58:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.align	2
	.p2align 5,,15
	.global	guide_policy_name
	.type	guide_policy_name, %function
guide_policy_name:
	cmp	w0, 1
	beq	.L66
	cmp	w0, 2
	beq	.L67
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	ret
	.p2align 2,,3
.L67:
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	ret
	.p2align 2,,3
.L66:
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	ret
	.align	2
	.p2align 5,,15
	.global	guide_set_policy
	.type	guide_set_policy, %function
guide_set_policy:
	adrp	x1, .LANCHOR1
	str	w0, [x1, #:lo12:.LANCHOR1]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_get_policy
	.type	guide_get_policy, %function
guide_get_policy:
	adrp	x0, .LANCHOR1
	ldr	w0, [x0, #:lo12:.LANCHOR1]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_request_explicit
	.type	guide_request_explicit, %function
guide_request_explicit:
	adrp	x0, .LANCHOR1+4
	mov	w1, 1
	str	w1, [x0, #:lo12:.LANCHOR1+4]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_should_show
	.type	guide_should_show, %function
guide_should_show:
	adrp	x1, .LANCHOR1
	add	x0, x1, :lo12:.LANCHOR1
	ldr	w0, [x0, 4]
	cbnz	w0, .L74
	ldr	w1, [x1, #:lo12:.LANCHOR1]
	cmp	w1, 1
	beq	.L74
	cmp	w1, 2
	beq	.L71
	b	guide_should_show.part.0
	.p2align 2,,3
.L74:
	mov	w0, 1
.L71:
	ret
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"\033[1;36m\nWelcome to Archtoo.\n\n\033[0m"
	.align	3
.LC9:
	.string	"Archtoo uses its own command interface. It does not copy pacman's"
	.align	3
.LC10:
	.string	"option meanings and never invokes an external AUR helper.\n"
	.align	3
.LC11:
	.string	"Common commands:\n"
	.align	3
.LC12:
	.string	"  emerge -S query          Search repositories and the AUR"
	.align	3
.LC13:
	.string	"  emerge -I package        Install a package"
	.align	3
.LC14:
	.string	"  emerge -U                Upgrade repository and AUR packages"
	.align	3
.LC15:
	.string	"  emerge -Q package        Query an installed package"
	.align	3
.LC16:
	.string	"  emerge -A package        Show available package information"
	.align	3
.LC17:
	.string	"  emerge -C package        Remove a package"
	.align	3
.LC18:
	.string	"  emerge -G package        Download its PKGBUILD"
	.align	3
.LC19:
	.string	"  emerge --help            Show every command\n"
	.align	3
.LC20:
	.string	"This guide follows the '%s' display policy. Run\n"
	.align	3
.LC21:
	.string	"'emerge --command-guide' to display it explicitly.\n"
	.text
	.align	2
	.p2align 5,,15
	.global	guide_print
	.type	guide_print, %function
guide_print:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	mov	x29, sp
	bl	printf
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	puts
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	puts
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	puts
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	puts
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	puts
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	puts
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	puts
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	puts
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	puts
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	puts
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	bl	puts
	adrp	x0, .LANCHOR1
	ldr	w0, [x0, #:lo12:.LANCHOR1]
	cmp	w0, 1
	beq	.L83
	cmp	w0, 2
	bne	.L86
	adrp	x1, .LC7
	adrp	x0, .LC20
	add	x1, x1, :lo12:.LC7
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	b	puts
	.p2align 2,,3
.L86:
	adrp	x1, .LC5
	adrp	x0, .LC20
	add	x1, x1, :lo12:.LC5
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	b	puts
	.p2align 2,,3
.L83:
	adrp	x1, .LC6
	adrp	x0, .LC20
	add	x1, x1, :lo12:.LC6
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	b	puts
	.align	2
	.p2align 5,,15
	.global	guide_mark_seen
	.type	guide_mark_seen, %function
guide_mark_seen:
	adrp	x1, .LANCHOR1
	add	x0, x1, :lo12:.LANCHOR1
	ldr	w1, [x1, #:lo12:.LANCHOR1]
	ldr	w0, [x0, 4]
	orr	w0, w0, w1
	cbz	w0, .L89
	mov	w0, 1
	ret
	.p2align 2,,3
.L89:
	b	guide_mark_seen.part.0
	.section	.rodata.str1.8
	.align	3
.LC22:
	.string	"\033[1;33m[!] Could not record command-guide state; it may appear again.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	guide_maybe_show
	.type	guide_maybe_show, %function
guide_maybe_show:
	adrp	x1, .LANCHOR1
	add	x0, x1, :lo12:.LANCHOR1
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	ldr	w0, [x0, 4]
	cbnz	w0, .L94
	ldr	w0, [x1, #:lo12:.LANCHOR1]
	cmp	w0, 1
	beq	.L94
	cmp	w0, 2
	beq	.L92
	bl	guide_should_show.part.0
	cbnz	w0, .L94
.L92:
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L94:
	bl	guide_print
	adrp	x1, .LANCHOR1
	add	x0, x1, :lo12:.LANCHOR1
	ldr	w1, [x1, #:lo12:.LANCHOR1]
	ldr	w0, [x0, 4]
	orr	w0, w0, w1
	cbnz	w0, .L92
	bl	guide_mark_seen.part.0
	cbnz	w0, .L92
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 74
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	fwrite
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata
	.align	4
	.set	.LANCHOR0,. + 0
	.type	text.0, %object
text.0:
	.string	"Archtoo command guide displayed.\n"
	.bss
	.align	2
	.set	.LANCHOR1,. + 0
	.type	g_policy, %object
g_policy:
	.zero	4
	.type	g_explicit, %object
g_explicit:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
