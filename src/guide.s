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
	mov	x20, x1
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	bl	build_user
	cbz	x0, .L4
	bl	getpwnam
	cbz	x0, .L4
	ldr	x3, [x0, 32]
	cbz	x3, .L4
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 768
	add	x22, sp, 48
	mov	x0, x22
	bl	xsnprintf
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	getenv
	mov	x19, x0
	cbz	x0, .L5
	ldrb	w0, [x0]
	cbnz	w0, .L24
.L5:
	adrp	x2, .LC3
	mov	x3, x22
	add	x2, x2, :lo12:.LC3
	mov	x0, x21
	mov	x1, 1024
	bl	xsnprintf
.L6:
	mov	x3, x21
	mov	x0, x20
	mov	x1, 1200
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	bl	xsnprintf
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 816
	ret
	.p2align 2,,3
.L4:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 816
	ret
	.p2align 2,,3
.L24:
	bl	geteuid
	cbz	w0, .L5
	mov	x3, x19
	mov	x0, x21
	adrp	x2, .LC2
	mov	x1, 1024
	add	x2, x2, :lo12:.LC2
	bl	xsnprintf
	b	.L6
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
	beq	.L30
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x1
	mov	x20, x0
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	bl	strcmp
	cbnz	w0, .L27
	str	wzr, [x19]
.L28:
	mov	w0, 1
.L25:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L27:
	adrp	x1, .LC6
	mov	x0, x20
	add	x1, x1, :lo12:.LC6
	bl	strcmp
	cbz	w0, .L36
	mov	x0, x20
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	bl	strcmp
	mov	w1, w0
	mov	w0, 0
	cbnz	w1, .L25
	mov	w0, 2
	str	w0, [x19]
	b	.L28
	.p2align 2,,3
.L30:
	mov	w0, 0
	ret
	.p2align 2,,3
.L36:
	mov	w0, 1
	str	w0, [x19]
	b	.L28
	.align	2
	.p2align 5,,15
	.global	guide_policy_name
	.type	guide_policy_name, %function
guide_policy_name:
	cmp	w0, 1
	beq	.L39
	cmp	w0, 2
	adrp	x1, .LC5
	adrp	x0, .LC7
	add	x1, x1, :lo12:.LC5
	add	x0, x0, :lo12:.LC7
	csel	x0, x0, x1, eq
	ret
	.p2align 2,,3
.L39:
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	ret
	.align	2
	.p2align 5,,15
	.global	guide_set_policy
	.type	guide_set_policy, %function
guide_set_policy:
	adrp	x1, .LANCHOR0
	str	w0, [x1, #:lo12:.LANCHOR0]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_get_policy
	.type	guide_get_policy, %function
guide_get_policy:
	adrp	x0, .LANCHOR0
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_request_explicit
	.type	guide_request_explicit, %function
guide_request_explicit:
	adrp	x0, .LANCHOR0+4
	mov	w1, 1
	str	w1, [x0, #:lo12:.LANCHOR0+4]
	ret
	.align	2
	.p2align 5,,15
	.global	guide_should_show
	.type	guide_should_show, %function
guide_should_show:
	adrp	x1, .LANCHOR0
	add	x0, x1, :lo12:.LANCHOR0
	ldr	w0, [x0, 4]
	cbnz	w0, .L58
	ldr	w1, [x1, #:lo12:.LANCHOR0]
	cmp	w1, 1
	beq	.L58
	cmp	w1, 2
	beq	.L59
	sub	sp, sp, #2256
	add	x0, sp, 32
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	add	x19, sp, 1056
	mov	x1, x19
	bl	state_paths.constprop.0
	cbnz	w0, .L62
	ldr	x19, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp]
	add	sp, sp, 2256
	ret
	.p2align 2,,3
.L58:
	mov	w0, 1
.L59:
	ret
	.p2align 2,,3
.L62:
	mov	x0, x19
	mov	w1, 0
	bl	access
	cmp	w0, 0
	ldr	x19, [sp, 16]
	cset	w0, ne
	ldp	x29, x30, [sp]
	add	sp, sp, 2256
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
	adrp	x0, .LANCHOR0
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	cmp	w0, 1
	beq	.L65
	cmp	w0, 2
	adrp	x1, .LC7
	adrp	x0, .LC5
	add	x1, x1, :lo12:.LC7
	add	x0, x0, :lo12:.LC5
	csel	x1, x1, x0, eq
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	b	puts
	.p2align 2,,3
.L65:
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
	sub	sp, sp, #3296
	adrp	x0, .LANCHOR0
	add	x1, x0, :lo12:.LANCHOR0
	stp	x29, x30, [sp]
	mov	x29, sp
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	stp	x19, x20, [sp, 16]
	ldr	w19, [x1, 4]
	orr	w19, w19, w0
	cbz	w19, .L85
	mov	w19, 1
.L68:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 3296
	ret
	.p2align 2,,3
.L85:
	add	x20, sp, 48
	stp	x21, x22, [sp, 32]
	add	x21, sp, 2096
	mov	x1, x21
	mov	x0, x20
	bl	state_paths.constprop.0
	cbnz	w0, .L86
.L84:
	ldp	x21, x22, [sp, 32]
	mov	w0, w19
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 3296
	ret
	.p2align 2,,3
.L86:
	mov	x3, x20
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	add	x22, sp, 1072
	mov	x1, 1024
	mov	x0, x22
	bl	xsnprintf
	mov	x0, x22
	mov	w1, 47
	bl	strrchr
	cbz	x0, .L74
	strb	wzr, [x0]
	mov	w1, 448
	mov	x0, x22
	bl	mkdir
	cbz	w0, .L74
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	bne	.L84
.L74:
	mov	x0, x20
	mov	w1, 448
	bl	mkdir
	cbz	w0, .L73
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	bne	.L84
.L73:
	mov	x0, x21
	mov	w2, 384
	mov	w1, 32961
	bl	open
	mov	w19, w0
	tbz	w0, #31, .L76
	bl	__errno_location
	ldr	w0, [x0]
	ldp	x21, x22, [sp, 32]
	cmp	w0, 17
	cset	w19, eq
	b	.L68
	.p2align 2,,3
.L76:
	adrp	x1, .LANCHOR1
	add	x1, x1, :lo12:.LANCHOR1
	mov	x2, 33
	bl	write
	mov	x20, x0
	bl	__errno_location
	mov	x1, x0
	mov	w0, w19
	mov	x19, x1
	ldr	w21, [x1]
	bl	close
	str	w21, [x19]
	cmp	x20, 33
	cset	w19, eq
	ldp	x21, x22, [sp, 32]
	b	.L68
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
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	bl	guide_should_show
	cbnz	w0, .L92
.L89:
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L92:
	bl	guide_print
	bl	guide_mark_seen
	cbnz	w0, .L89
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 74
	mov	x1, 1
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata
	.align	4
	.set	.LANCHOR1,. + 0
	.type	text.0, %object
text.0:
	.string	"Archtoo command guide displayed.\n"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	g_policy, %object
g_policy:
	.zero	4
	.type	g_explicit, %object
g_explicit:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
