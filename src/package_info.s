	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	""
	.align	3
.LC1:
	.string	"(orphan)"
	.align	3
.LC2:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC3:
	.string	"pacman -Si -- %s"
	.align	3
.LC4:
	.string	"\033[1;31m[-] %s\n\033[0m"
	.align	3
.LC5:
	.string	"\033[1;31m[-] Package '%s' was not found in repositories or the AUR.\n\033[0m"
	.align	3
.LC6:
	.string	"Repository      : aur"
	.align	3
.LC7:
	.string	"Name            : %s\n"
	.align	3
.LC8:
	.string	"Package Base    : %s\n"
	.align	3
.LC9:
	.string	"Version         : %s\n"
	.align	3
.LC10:
	.string	"Description     : %s\n"
	.align	3
.LC11:
	.string	"URL             : %s\n"
	.align	3
.LC12:
	.string	"Maintainer      : %s\n"
	.align	3
.LC13:
	.string	"Votes           : %ld\n"
	.align	3
.LC14:
	.string	"Popularity      : %.2f\n"
	.align	3
.LC15:
	.string	"Out Of Date     : %ld\n"
	.align	3
.LC16:
	.string	"Depends On      :"
	.align	3
.LC17:
	.string	" None"
	.align	3
.LC18:
	.string	"Make Deps       :"
	.align	3
.LC19:
	.string	" %s"
	.align	3
.LC20:
	.string	"Check Deps      :"
	.align	3
.LC21:
	.string	"Provides        :"
	.align	3
.LC22:
	.string	"Conflicts With  :"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_available_info_v2
	.type	cmd_available_info_v2, %function
cmd_available_info_v2:
	sub	sp, sp, #1248
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	str	xzr, [sp, 136]
	bl	valid_pkgname
	cbnz	w0, .L2
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x19, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	adrp	x1, .LC2
	csel	x2, x2, x19, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L10:
	mov	w0, 0
.L1:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1248
	ret
	.p2align 2,,3
.L2:
	add	x20, sp, 416
	mov	x0, x19
	mov	x1, x20
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L10
	mov	x3, x20
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	add	x0, sp, 736
	mov	x20, x0
	mov	x1, 512
	bl	xsnprintf
	add	x1, sp, 136
	mov	x0, x20
	bl	run_cmd_capture
	mov	w1, w0
	ldr	x0, [sp, 136]
	cbnz	w1, .L7
	cbz	x0, .L7
	ldrb	w1, [x0]
	cbnz	w1, .L64
.L7:
	bl	free
	add	x20, sp, 160
	movi	v31.4s, 0
	stp	xzr, xzr, [sp, 144]
	stp	q31, q31, [x20]
	stp	q31, q31, [x20, 32]
	stp	q31, q31, [x20, 64]
	stp	q31, q31, [x20, 96]
	stp	q31, q31, [x20, 128]
	stp	q31, q31, [x20, 160]
	stp	q31, q31, [x20, 192]
	stp	q31, q31, [x20, 224]
	bl	config_current
	add	x1, sp, 144
	mov	x2, x1
	add	x0, x0, 20
	mov	x3, x20
	mov	x4, 256
	str	x1, [sp, 120]
	mov	x1, x19
	bl	aur_rpc_info
	cbz	w0, .L65
	ldr	x0, [sp, 152]
	cbz	x0, .L66
	adrp	x20, :got:stdout;ldr	x20, [x20, :got_lo12:stdout]
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	stp	x21, x22, [sp, 32]
	adrp	x21, .LC0
	add	x21, x21, :lo12:.LC0
	mov	x22, 0
	stp	x23, x24, [sp, 48]
	mov	x23, 0
	stp	x25, x26, [sp, 64]
	adrp	x26, .LC8
	stp	x27, x28, [sp, 80]
	adrp	x27, .LC7
	adrp	x28, .LC22
	str	x0, [sp, 104]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	str	x0, [sp, 112]
	.p2align 5,,15
.L11:
	ldr	x0, [sp, 104]
	ldr	x19, [sp, 144]
	bl	puts
	add	x25, x19, x23
	add	x0, x27, :lo12:.LC7
	ldr	x1, [x19, x23]
	cmp	x1, 0
	csel	x1, x21, x1, eq
	bl	printf
	ldr	x1, [x25, 8]
	add	x0, x26, :lo12:.LC8
	cmp	x1, 0
	csel	x1, x21, x1, eq
	bl	printf
	ldr	x1, [x25, 16]
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	cmp	x1, 0
	csel	x1, x21, x1, eq
	bl	printf
	ldr	x1, [x25, 24]
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	cmp	x1, 0
	csel	x1, x21, x1, eq
	bl	printf
	ldr	x1, [x25, 32]
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	cmp	x1, 0
	csel	x1, x21, x1, eq
	bl	printf
	ldr	x1, [x25, 40]
	cbz	x1, .L43
	ldrb	w0, [x1]
	cmp	w0, 0
	ldr	x0, [sp, 112]
	csel	x1, x0, x1, eq
.L17:
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	printf
	ldr	x1, [x25, 48]
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	printf
	ldr	d0, [x25, 56]
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	printf
	ldr	x1, [x25, 64]
	cbnz	x1, .L67
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	ldr	x0, [x25, 80]
	cbz	x0, .L68
.L19:
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	mov	x24, 0
	.p2align 5,,15
.L22:
	ldr	x1, [x25, 72]
	mov	x0, x19
	ldr	x1, [x1, x24, lsl 3]
	add	x24, x24, 1
	bl	printf
	ldr	x0, [x25, 80]
	cmp	x24, x0
	bcc	.L22
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	ldr	x0, [x25, 96]
	cbz	x0, .L69
.L21:
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	mov	x24, 0
	.p2align 5,,15
.L26:
	ldr	x1, [x25, 88]
	mov	x0, x19
	ldr	x1, [x1, x24, lsl 3]
	add	x24, x24, 1
	bl	printf
	ldr	x0, [x25, 96]
	cmp	x24, x0
	bcc	.L26
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldr	x0, [x25, 112]
	cbz	x0, .L70
.L25:
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	mov	x24, 0
	.p2align 5,,15
.L30:
	ldr	x1, [x25, 104]
	mov	x0, x19
	ldr	x1, [x1, x24, lsl 3]
	add	x24, x24, 1
	bl	printf
	ldr	x0, [x25, 112]
	cmp	x24, x0
	bcc	.L30
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	ldr	x0, [x25, 128]
	cbz	x0, .L71
.L29:
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	mov	x24, 0
	.p2align 5,,15
.L34:
	ldr	x1, [x25, 120]
	mov	x0, x19
	ldr	x1, [x1, x24, lsl 3]
	add	x24, x24, 1
	bl	printf
	ldr	x0, [x25, 128]
	cmp	x24, x0
	bcc	.L34
.L35:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	add	x0, x28, :lo12:.LC22
	bl	printf
	ldr	x0, [x25, 144]
	cbz	x0, .L72
.L33:
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	mov	x24, 0
	.p2align 5,,15
.L38:
	ldr	x1, [x25, 136]
	mov	x0, x19
	ldr	x1, [x1, x24, lsl 3]
	add	x24, x24, 1
	bl	printf
	ldr	x0, [x25, 144]
	cmp	x24, x0
	bcc	.L38
.L39:
	ldr	x1, [x20]
	mov	w0, 10
	add	x22, x22, 1
	bl	putc
	ldr	x0, [sp, 152]
	cmp	x22, x0
	bcc	.L73
.L37:
	ldr	x0, [sp, 120]
	bl	aur_response_destroy
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1248
	ret
	.p2align 2,,3
.L73:
	ldr	x1, [x20]
	mov	w0, 10
	add	x23, x23, 152
	bl	putc
	ldr	x0, [sp, 152]
	cmp	x22, x0
	bcc	.L11
	b	.L37
	.p2align 2,,3
.L72:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 144]
	cbnz	x0, .L33
	b	.L39
	.p2align 2,,3
.L67:
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	ldr	x0, [x25, 80]
	cbnz	x0, .L19
.L68:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 80]
	cbnz	x0, .L19
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	ldr	x0, [x25, 96]
	cbnz	x0, .L21
	.p2align 5,,15
.L69:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 96]
	cbnz	x0, .L21
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldr	x0, [x25, 112]
	cbnz	x0, .L25
	.p2align 5,,15
.L70:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 112]
	cbnz	x0, .L25
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	ldr	x0, [x25, 128]
	cbnz	x0, .L29
	.p2align 5,,15
.L71:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 128]
	cbnz	x0, .L29
	b	.L35
	.p2align 2,,3
.L43:
	ldr	x1, [sp, 112]
	b	.L17
.L65:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC4
	add	x1, x1, :lo12:.LC4
	ldr	x0, [x0]
	bl	fprintf
	b	.L10
.L64:
	adrp	x20, :got:stdout;ldr	x20, [x20, :got_lo12:stdout]
	ldr	x1, [x20]
	bl	fputs
	ldr	x19, [sp, 136]
	mov	x0, x19
	bl	strlen
	add	x0, x19, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	beq	.L8
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	ldr	x19, [sp, 136]
.L8:
	mov	x0, x19
	bl	free
	mov	w0, 1
	b	.L1
.L66:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 120]
	bl	aur_response_destroy
	b	.L10
	.section	.rodata.str1.8
	.align	3
.LC23:
	.string	"pacman -Qi -- %s"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_query_v2
	.type	cmd_query_v2, %function
cmd_query_v2:
	sub	sp, sp, #864
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L75
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x19, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	adrp	x1, .LC2
	csel	x2, x2, x19, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L77:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 864
	ret
	.p2align 2,,3
.L75:
	add	x20, sp, 32
	mov	x0, x19
	mov	x1, x20
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L77
	mov	x3, x20
	adrp	x2, .LC23
	add	x2, x2, :lo12:.LC23
	add	x19, sp, 352
	mov	x1, 512
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	cmp	w0, 0
	ldp	x29, x30, [sp]
	cset	w0, eq
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 864
	ret
	.section	.note.GNU-stack,"",@progbits
