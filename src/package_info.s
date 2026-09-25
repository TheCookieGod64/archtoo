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
	.string	" %s"
	.align	3
.LC19:
	.string	"Make Deps       :"
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
	sub	sp, sp, #1200
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	str	xzr, [sp, 88]
	bl	valid_pkgname
	cbnz	w0, .L2
	mov	w19, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x20, .L74
.L3:
	adrp	x1, .LC2
	mov	x2, x20
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L1:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1200
	ret
	.p2align 2,,3
.L2:
	add	x1, sp, 368
	mov	x0, x20
	mov	x2, 320
	bl	shell_quote
	mov	w19, w0
	cbz	w0, .L1
	add	x3, sp, 368
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	mov	x1, 512
	add	x0, sp, 688
	bl	xsnprintf
	add	x1, sp, 88
	add	x0, sp, 688
	bl	run_cmd_capture
	mov	w1, w0
	ldr	x0, [sp, 88]
	cbnz	w1, .L5
	cbz	x0, .L5
	ldrb	w1, [x0]
	cbnz	w1, .L75
.L5:
	bl	free
	stp	xzr, xzr, [sp, 96]
	movi	v31.4s, 0
	stp	q31, q31, [sp, 112]
	stp	q31, q31, [sp, 144]
	stp	q31, q31, [sp, 176]
	stp	q31, q31, [sp, 208]
	stp	q31, q31, [sp, 240]
	stp	q31, q31, [sp, 272]
	stp	q31, q31, [sp, 304]
	stp	q31, q31, [sp, 336]
	bl	config_current
	add	x3, sp, 112
	add	x2, sp, 96
	mov	x1, x20
	add	x0, x0, 20
	mov	x4, 256
	bl	aur_rpc_info
	mov	w19, w0
	cbz	w0, .L76
	ldr	x0, [sp, 104]
	cbz	x0, .L77
	adrp	x20, :got:stdout
	ldr	x20, [x20, :got_lo12:stdout]
	stp	x21, x22, [sp, 32]
	mov	x22, 0
	adrp	x21, .LC0
	stp	x23, x24, [sp, 48]
	mov	x23, 0
	adrp	x24, .LC10
	stp	x25, x26, [sp, 64]
	.p2align 5,,15
.L9:
	adrp	x0, .LC6
	ldr	x19, [sp, 96]
	add	x0, x0, :lo12:.LC6
	bl	puts
	add	x25, x19, x23
	add	x0, x21, :lo12:.LC0
	ldr	x1, [x19, x23]
	cmp	x1, 0
	csel	x1, x0, x1, eq
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	printf
	ldr	x1, [x25, 8]
	add	x0, x21, :lo12:.LC0
	cmp	x1, 0
	csel	x1, x0, x1, eq
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	ldr	x1, [x25, 16]
	add	x0, x21, :lo12:.LC0
	cmp	x1, 0
	csel	x1, x0, x1, eq
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	printf
	ldr	x1, [x25, 24]
	add	x0, x21, :lo12:.LC0
	cmp	x1, 0
	csel	x1, x0, x1, eq
	add	x0, x24, :lo12:.LC10
	bl	printf
	ldr	x1, [x25, 32]
	add	x0, x21, :lo12:.LC0
	cmp	x1, 0
	csel	x1, x0, x1, eq
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	printf
	ldr	x1, [x25, 40]
	cbz	x1, .L35
	ldrb	w2, [x1]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	cmp	w2, 0
	csel	x1, x0, x1, eq
.L15:
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
	cbnz	x1, .L78
.L16:
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	ldr	x0, [x25, 80]
	cbz	x0, .L79
.L17:
	adrp	x19, .LC18
	add	x19, x19, :lo12:.LC18
	mov	x26, 0
	.p2align 5,,15
.L19:
	ldr	x0, [x25, 72]
	ldr	x1, [x0, x26, lsl 3]
	mov	x0, x19
	add	x26, x26, 1
	bl	printf
	ldr	x0, [x25, 80]
	cmp	x26, x0
	bcc	.L19
.L18:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	bl	printf
	ldr	x0, [x25, 96]
	cbz	x0, .L80
.L20:
	adrp	x19, .LC18
	add	x19, x19, :lo12:.LC18
	mov	x26, 0
	.p2align 5,,15
.L22:
	ldr	x0, [x25, 88]
	ldr	x1, [x0, x26, lsl 3]
	mov	x0, x19
	add	x26, x26, 1
	bl	printf
	ldr	x0, [x25, 96]
	cmp	x26, x0
	bcc	.L22
.L21:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldr	x0, [x25, 112]
	cbz	x0, .L81
.L23:
	adrp	x19, .LC18
	add	x19, x19, :lo12:.LC18
	mov	x26, 0
	.p2align 5,,15
.L25:
	ldr	x0, [x25, 104]
	ldr	x1, [x0, x26, lsl 3]
	mov	x0, x19
	add	x26, x26, 1
	bl	printf
	ldr	x0, [x25, 112]
	cmp	x26, x0
	bcc	.L25
.L24:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	ldr	x0, [x25, 128]
	cbz	x0, .L82
.L26:
	adrp	x19, .LC18
	add	x19, x19, :lo12:.LC18
	mov	x26, 0
	.p2align 5,,15
.L28:
	ldr	x0, [x25, 120]
	ldr	x1, [x0, x26, lsl 3]
	mov	x0, x19
	add	x26, x26, 1
	bl	printf
	ldr	x0, [x25, 128]
	cmp	x26, x0
	bcc	.L28
.L27:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	ldr	x0, [x25, 144]
	cbz	x0, .L83
.L29:
	adrp	x19, .LC18
	add	x19, x19, :lo12:.LC18
	mov	x26, 0
	.p2align 5,,15
.L31:
	ldr	x0, [x25, 136]
	ldr	x1, [x0, x26, lsl 3]
	mov	x0, x19
	add	x26, x26, 1
	bl	printf
	ldr	x0, [x25, 144]
	cmp	x26, x0
	bcc	.L31
.L30:
	ldr	x1, [x20]
	mov	w0, 10
	add	x22, x22, 1
	bl	putc
	ldr	x0, [sp, 104]
	cmp	x22, x0
	bcc	.L84
.L32:
	add	x0, sp, 96
	mov	w19, 1
	bl	aur_response_destroy
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1200
	ret
	.p2align 2,,3
.L74:
	adrp	x20, .LC0
	add	x20, x20, :lo12:.LC0
	b	.L3
	.p2align 2,,3
.L84:
	ldr	x1, [x20]
	mov	w0, 10
	add	x23, x23, 152
	bl	putc
	ldr	x0, [sp, 104]
	cmp	x22, x0
	bcc	.L9
	b	.L32
	.p2align 2,,3
.L83:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 144]
	cbnz	x0, .L29
	b	.L30
	.p2align 2,,3
.L82:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 128]
	cbnz	x0, .L26
	b	.L27
	.p2align 2,,3
.L81:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 112]
	cbnz	x0, .L23
	b	.L24
	.p2align 2,,3
.L80:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 96]
	cbnz	x0, .L20
	b	.L21
	.p2align 2,,3
.L79:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	ldr	x0, [x25, 80]
	cbnz	x0, .L17
	b	.L18
	.p2align 2,,3
.L78:
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	b	.L16
	.p2align 2,,3
.L35:
	adrp	x0, .LC1
	add	x1, x0, :lo12:.LC1
	b	.L15
.L76:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 112
	adrp	x1, .LC4
	add	x1, x1, :lo12:.LC4
	ldr	x0, [x0]
	bl	fprintf
	b	.L1
.L75:
	adrp	x20, :got:stdout
	ldr	x20, [x20, :got_lo12:stdout]
	ldr	x1, [x20]
	bl	fputs
	ldr	x19, [sp, 88]
	mov	x0, x19
	bl	strlen
	add	x0, x19, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	beq	.L6
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	ldr	x19, [sp, 88]
.L6:
	mov	x0, x19
	mov	w19, 1
	bl	free
	b	.L1
.L77:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
	add	x0, sp, 96
	bl	aur_response_destroy
	b	.L1
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
	sub	sp, sp, #880
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L86
	mov	w3, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x19, .L94
.L87:
	mov	x2, x19
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	str	w3, [sp, 44]
	bl	fprintf
	ldr	w3, [sp, 44]
.L85:
	ldr	x19, [sp, 16]
	mov	w0, w3
	ldp	x29, x30, [sp]
	add	sp, sp, 880
	ret
	.p2align 2,,3
.L86:
	add	x1, sp, 48
	mov	x0, x19
	mov	x2, 320
	bl	shell_quote
	mov	w3, w0
	cbz	w0, .L85
	add	x3, sp, 48
	adrp	x2, .LC23
	add	x2, x2, :lo12:.LC23
	mov	x1, 512
	add	x0, sp, 368
	bl	xsnprintf
	add	x0, sp, 368
	bl	run_cmd
	cmp	w0, 0
	cset	w3, eq
	ldr	x19, [sp, 16]
	mov	w0, w3
	ldp	x29, x30, [sp]
	add	sp, sp, 880
	ret
	.p2align 2,,3
.L94:
	adrp	x19, .LC0
	add	x19, x19, :lo12:.LC0
	b	.L87
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
