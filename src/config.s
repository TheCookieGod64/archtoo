	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"true"
	.align	3
.LC1:
	.string	"yes"
	.align	3
.LC2:
	.string	"enabled"
	.align	3
.LC3:
	.string	"false"
	.align	3
.LC4:
	.string	"disabled"
	.text
	.align	2
	.p2align 5,,15
	.type	parse_switch, %function
parse_switch:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x1
	mov	x19, x0
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L2
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbnz	w0, .L24
.L2:
	mov	w0, 1
	str	w0, [x20]
.L7:
	mov	w0, 1
.L1:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L24:
	adrp	x1, .LC2
	mov	x0, x19
	add	x1, x1, :lo12:.LC2
	bl	strcmp
	cbz	w0, .L2
	adrp	x1, .LC3
	mov	x0, x19
	add	x1, x1, :lo12:.LC3
	bl	strcmp
	cbz	w0, .L5
	ldrb	w0, [x19]
	cmp	w0, 110
	bne	.L9
	ldrb	w0, [x19, 1]
	cmp	w0, 111
	bne	.L9
	ldrb	w0, [x19, 2]
	cbz	w0, .L5
	.p2align 5,,15
.L9:
	mov	x0, x19
	adrp	x1, .LC4
	add	x1, x1, :lo12:.LC4
	bl	strcmp
	mov	w1, w0
	mov	w0, 0
	cbnz	w1, .L1
.L5:
	str	wzr, [x20]
	b	.L7
	.align	2
	.p2align 5,,15
	.type	trim, %function
trim:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	__ctype_b_loc
	ldr	x20, [x0]
	ldrb	w1, [x19]
	ldrh	w0, [x20, x1, lsl 1]
	tbz	x0, 13, .L26
	.p2align 5,,15
.L27:
	ldrb	w0, [x19, 1]!
	ldrh	w0, [x20, x0, lsl 1]
	tbnz	x0, 13, .L27
.L26:
	mov	x0, x19
	bl	strlen
	add	x1, x19, x0
	cmp	x1, x19
	bhi	.L28
	b	.L29
	.p2align 2,,3
.L30:
	sub	x1, x1, #1
	cmp	x1, x19
	beq	.L29
.L28:
	ldrb	w0, [x1, -1]
	ldrh	w0, [x20, x0, lsl 1]
	tbnz	x0, 13, .L30
.L29:
	strb	wzr, [x1]
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.align	2
	.p2align 5,,15
	.type	error_format, %function
error_format:
	stp	x29, x30, [sp, -256]!
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	mov	x29, sp
	stp	x3, x4, [sp, 216]
	stp	x5, x6, [sp, 232]
	str	x7, [sp, 248]
	stp	q0, q1, [sp, 80]
	stp	q2, q3, [sp, 112]
	stp	q4, q5, [sp, 144]
	stp	q6, q7, [sp, 176]
	beq	.L38
	add	x3, sp, 256
	add	x6, sp, 208
	mov	w5, -40
	mov	w4, -128
	stp	x3, x3, [sp, 48]
	add	x3, sp, 16
	str	x6, [sp, 64]
	stp	w5, w4, [sp, 72]
	ldp	q30, q31, [sp, 48]
	str	q30, [sp, 16]
	str	q31, [x3, 16]
	bl	vsnprintf
.L38:
	ldp	x29, x30, [sp], 256
	ret
	.section	.rodata.str1.8
	.align	3
.LC5:
	.string	"https://aur.archlinux.org/rpc/v5"
	.align	3
.LC6:
	.string	"native"
	.align	3
.LC7:
	.string	"/usr/local/emerge"
	.align	3
.LC8:
	.string	"%s/gentoo-chroot"
	.text
	.align	2
	.p2align 5,,15
	.type	config_defaults.part.0, %function
config_defaults.part.0:
	stp	x29, x30, [sp, -32]!
	mov	x2, 960
	mov	w1, 0
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	memset
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	adrp	x1, .LC6
	add	x1, x1, :lo12:.LC6
	mov	x3, 300
	adrp	x2, .LC9
	ldp	q30, q31, [x0]
	str	x3, [x19, 8]
	add	x3, x19, 276
	ldr	w6, [x1]
	ldrb	w0, [x0, 32]
	mov	w4, 1
	ldr	w1, [x1, 3]
	mov	w5, 51
	str	w4, [x19]
	add	x4, x19, 512
	str	q30, [x19, 20]
	str	q31, [x19, 36]
	ldr	q31, [x2, #:lo12:.LC9]
	strb	w0, [x19, 52]
	str	w6, [x19, 276]
	add	x0, x19, 436
	str	w1, [x3, 3]
	adrp	x2, .LC8
	strh	w5, [x19, 404]
	add	x19, x19, 1024
	add	x2, x2, :lo12:.LC8
	mov	x1, 512
	adrp	x3, .LC7
	add	x3, x3, :lo12:.LC7
	str	q31, [x4, -92]
	bl	snprintf
	str	xzr, [x19, -76]
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.align	2
	.p2align 5,,15
	.global	config_defaults
	.type	config_defaults, %function
config_defaults:
	cbz	x0, .L43
	b	config_defaults.part.0
	.p2align 2,,3
.L43:
	ret
	.section	.rodata.str1.8
	.align	3
.LC10:
	.string	"XDG_CONFIG_HOME"
	.align	3
.LC11:
	.string	"%s/archtoo/config"
	.align	3
.LC12:
	.string	"%s/.config/archtoo/config"
	.align	3
.LC13:
	.string	"cannot determine invoking user's config path"
	.align	3
.LC14:
	.string	"r"
	.align	3
.LC15:
	.string	"cannot open config: %s"
	.align	3
.LC16:
	.string	"config line %lu has no '='"
	.align	3
.LC17:
	.string	"emerge_confirm"
	.align	3
.LC18:
	.string	"pacman_confirm"
	.align	3
.LC19:
	.string	"prompt_timeout"
	.align	3
.LC20:
	.string	"welcome_policy"
	.align	3
.LC21:
	.string	"command_guide"
	.align	3
.LC22:
	.string	"aur_rpc_url"
	.align	3
.LC23:
	.string	"https://"
	.align	3
.LC24:
	.string	"%s"
	.align	3
.LC25:
	.string	"target_arch"
	.align	3
.LC26:
	.string	"target"
	.align	3
.LC27:
	.string	"march"
	.align	3
.LC28:
	.string	"cpu"
	.align	3
.LC29:
	.string	"opt_level"
	.align	3
.LC30:
	.string	"opt"
	.align	3
.LC31:
	.string	"optimization"
	.align	3
.LC32:
	.string	"o"
	.align	3
.LC33:
	.string	"pipe"
	.align	3
.LC34:
	.string	"use_pipe"
	.align	3
.LC35:
	.string	"gentoo_chroot"
	.align	3
.LC36:
	.string	"portage_chroot"
	.align	3
.LC37:
	.string	"imitation"
	.align	3
.LC38:
	.string	"portage_imitation"
	.align	3
.LC39:
	.string	"gentoo_imitation"
	.align	3
.LC40:
	.string	"gentoo_chroot_path"
	.align	3
.LC41:
	.string	"chroot_path"
	.align	3
.LC42:
	.string	"binary"
	.align	3
.LC43:
	.string	"use_binary"
	.align	3
.LC44:
	.string	"use_bin"
	.align	3
.LC45:
	.string	"bin"
	.align	3
.LC46:
	.string	"prebuilt"
	.align	3
.LC47:
	.string	"use_prebuilt"
	.align	3
.LC48:
	.string	"no_build"
	.align	3
.LC49:
	.string	"no-build"
	.align	3
.LC50:
	.string	"unknown config key on line %lu: %s"
	.align	3
.LC51:
	.string	"invalid value for %s on line %lu: %s"
	.align	3
.LC52:
	.string	"error reading config: %s"
	.text
	.align	2
	.p2align 5,,15
	.global	config_load
	.type	config_load, %function
config_load:
	cbz	x0, .L188
	sub	sp, sp, #2176
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x1
	mov	x19, x0
	stp	x21, x22, [sp, 32]
	mov	x21, x2
	bl	config_defaults.part.0
	bl	build_user
	cbz	x0, .L195
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	bl	getpwnam
	mov	x22, x0
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	getenv
	mov	x23, x0
	cbz	x22, .L192
	ldr	x3, [x22, 32]
	cbz	x3, .L192
	cbz	x0, .L49
	ldrb	w0, [x0]
	cbnz	w0, .L196
.L49:
	add	x22, sp, 128
	adrp	x2, .LC12
	mov	x0, x22
	add	x2, x2, :lo12:.LC12
	mov	x1, 1024
	bl	snprintf
.L51:
	mov	x0, x22
	adrp	x1, .LC14
	add	x1, x1, :lo12:.LC14
	bl	fopen
	mov	x22, x0
	cbz	x0, .L197
	adrp	x25, .LC17
	adrp	x26, .LC18
	add	x25, x25, :lo12:.LC17
	add	x26, x26, :lo12:.LC18
	add	x24, sp, 1152
	mov	x23, 0
.L53:
	mov	x2, x22
	mov	x0, x24
	mov	w1, 1024
	bl	fgets
	cbz	x0, .L198
	mov	x0, x24
	bl	trim
	ldrb	w1, [x0]
	add	x23, x23, 1
	mov	x28, x0
	cmp	w1, 35
	ccmp	w1, 0, 4, ne
	beq	.L53
	mov	w1, 61
	bl	strchr
	cbz	x0, .L199
	strb	wzr, [x0], 1
	bl	trim
	mov	x27, x0
	mov	x0, x28
	bl	trim
	mov	w1, 35
	mov	x28, x0
	mov	x0, x27
	bl	strchr
	cbz	x0, .L58
	strb	wzr, [x0]
	mov	x0, x27
	bl	trim
	mov	x27, x0
.L58:
	mov	x1, x25
	mov	x0, x28
	bl	strcmp
	cbz	w0, .L200
	mov	x1, x26
	mov	x0, x28
	bl	strcmp
	cbz	w0, .L201
	adrp	x1, .LC19
	mov	x0, x28
	add	x1, x1, :lo12:.LC19
	bl	strcmp
	cbz	w0, .L202
	adrp	x1, .LC20
	mov	x0, x28
	add	x1, x1, :lo12:.LC20
	bl	strcmp
	cbz	w0, .L64
	adrp	x1, .LC21
	mov	x0, x28
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L64
	adrp	x1, .LC22
	mov	x0, x28
	add	x1, x1, :lo12:.LC22
	bl	strcmp
	cbz	w0, .L203
	adrp	x1, .LC25
	mov	x0, x28
	add	x1, x1, :lo12:.LC25
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC26
	mov	x0, x28
	add	x1, x1, :lo12:.LC26
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC27
	mov	x0, x28
	add	x1, x1, :lo12:.LC27
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC28
	mov	x0, x28
	add	x1, x1, :lo12:.LC28
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC29
	mov	x0, x28
	add	x1, x1, :lo12:.LC29
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC30
	mov	x0, x28
	add	x1, x1, :lo12:.LC30
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC31
	mov	x0, x28
	add	x1, x1, :lo12:.LC31
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC32
	mov	x0, x28
	add	x1, x1, :lo12:.LC32
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC33
	mov	x0, x28
	add	x1, x1, :lo12:.LC33
	bl	strcmp
	cbz	w0, .L73
	adrp	x1, .LC34
	mov	x0, x28
	add	x1, x1, :lo12:.LC34
	bl	strcmp
	cbz	w0, .L73
	adrp	x1, .LC35
	mov	x0, x28
	add	x1, x1, :lo12:.LC35
	bl	strcmp
	cbz	w0, .L77
	adrp	x1, .LC36
	mov	x0, x28
	add	x1, x1, :lo12:.LC36
	bl	strcmp
	cbz	w0, .L77
	adrp	x1, .LC37
	mov	x0, x28
	add	x1, x1, :lo12:.LC37
	bl	strcmp
	cbz	w0, .L77
	adrp	x1, .LC38
	mov	x0, x28
	add	x1, x1, :lo12:.LC38
	bl	strcmp
	cbz	w0, .L77
	adrp	x1, .LC39
	mov	x0, x28
	add	x1, x1, :lo12:.LC39
	bl	strcmp
	cbz	w0, .L77
	adrp	x1, .LC40
	mov	x0, x28
	add	x1, x1, :lo12:.LC40
	bl	strcmp
	cbz	w0, .L80
	adrp	x1, .LC41
	mov	x0, x28
	add	x1, x1, :lo12:.LC41
	bl	strcmp
	cbz	w0, .L80
	adrp	x1, .LC42
	mov	x0, x28
	add	x1, x1, :lo12:.LC42
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC43
	mov	x0, x28
	add	x1, x1, :lo12:.LC43
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC44
	mov	x0, x28
	add	x1, x1, :lo12:.LC44
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC45
	mov	x0, x28
	add	x1, x1, :lo12:.LC45
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC46
	mov	x0, x28
	add	x1, x1, :lo12:.LC46
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC47
	mov	x0, x28
	add	x1, x1, :lo12:.LC47
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC48
	mov	x0, x28
	add	x1, x1, :lo12:.LC48
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC49
	mov	x0, x28
	add	x1, x1, :lo12:.LC49
	bl	strcmp
	cbnz	w0, .L83
.L82:
	add	x1, sp, 120
	mov	x0, x27
	bl	parse_switch
	cbz	w0, .L76
	ldr	w1, [sp, 120]
	mov	w0, 1
	str	w1, [x19, 948]
	str	w0, [x19, 952]
	b	.L53
	.p2align 2,,3
.L195:
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	getenv
.L48:
	adrp	x2, .LC13
	mov	x1, x21
	mov	x0, x20
	add	x2, x2, :lo12:.LC13
	bl	error_format
.L46:
	mov	w0, 0
.L45:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L200:
	mov	x1, x19
	mov	x0, x27
	bl	parse_switch
	cbnz	w0, .L53
.L76:
	adrp	x2, .LC51
	mov	x5, x27
	mov	x4, x23
	mov	x3, x28
	mov	x1, x21
	mov	x0, x20
	add	x2, x2, :lo12:.LC51
	bl	error_format
.L193:
	mov	x0, x22
	bl	fclose
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L46
	.p2align 2,,3
.L188:
	mov	w0, 0
	ret
	.p2align 2,,3
.L64:
	add	x1, x19, 16
	mov	x0, x27
	bl	guide_policy_parse
	cbz	w0, .L76
	b	.L53
	.p2align 2,,3
.L201:
	add	x1, x19, 4
	mov	x0, x27
	bl	parse_switch
	cbz	w0, .L76
	b	.L53
	.p2align 2,,3
.L196:
	bl	geteuid
	cbnz	w0, .L50
	ldr	x3, [x22, 32]
	b	.L49
	.p2align 2,,3
.L192:
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L48
	.p2align 2,,3
.L202:
	bl	__errno_location
	mov	x3, x0
	add	x1, sp, 120
	mov	x0, x27
	mov	w2, 10
	str	x3, [sp, 104]
	str	wzr, [x3]
	bl	strtol
	ldr	x3, [sp, 104]
	ldr	w1, [x3]
	cbnz	w1, .L76
	ldr	x1, [sp, 120]
	ldrb	w1, [x1]
	cbnz	w1, .L76
	mov	x1, 20864
	movk	x1, 0x1, lsl 16
	cmp	x0, x1
	bhi	.L76
	str	x0, [x19, 8]
	b	.L53
	.p2align 2,,3
.L203:
	adrp	x1, .LC23
	mov	x0, x27
	add	x1, x1, :lo12:.LC23
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L76
	mov	x0, x27
	bl	strlen
	cmp	x0, 255
	bhi	.L76
	mov	x3, x27
	add	x0, x19, 20
	adrp	x2, .LC24
	mov	x1, 256
	add	x2, x2, :lo12:.LC24
	bl	snprintf
	b	.L53
	.p2align 2,,3
.L50:
	add	x22, sp, 128
	mov	x3, x23
	mov	x0, x22
	adrp	x2, .LC11
	mov	x1, 1024
	add	x2, x2, :lo12:.LC11
	bl	snprintf
	b	.L51
	.p2align 2,,3
.L67:
	mov	x0, x27
	bl	valid_target_arch
	cbz	w0, .L76
	mov	x0, x27
	bl	strlen
	cmp	x0, 127
	bhi	.L76
	mov	x3, x27
	add	x0, x19, 276
	adrp	x2, .LC24
	mov	x1, 128
	add	x2, x2, :lo12:.LC24
	bl	snprintf
	b	.L53
	.p2align 2,,3
.L198:
	mov	x0, x22
	bl	ferror
	cbnz	w0, .L204
	mov	x0, x22
	bl	fclose
.L54:
	ldp	x23, x24, [sp, 48]
	mov	w0, 1
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L45
	.p2align 2,,3
.L199:
	mov	x3, x23
	mov	x1, x21
	mov	x0, x20
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	error_format
	b	.L193
.L204:
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x3, x0
	mov	x1, x21
	mov	x0, x20
	adrp	x2, .LC52
	add	x2, x2, :lo12:.LC52
	bl	error_format
	b	.L193
.L69:
	mov	x0, x27
	bl	valid_opt_level
	cbz	w0, .L76
	mov	x0, x27
	bl	strlen
	cmp	x0, 16
	bhi	.L76
	ldrb	w0, [x27]
	cmp	w0, 45
	bne	.L71
	ldrb	w0, [x27, 1]
	add	x27, x27, 1
.L71:
	and	w0, w0, -33
	adrp	x2, .LC24
	and	w0, w0, 255
	add	x2, x2, :lo12:.LC24
	cmp	w0, 79
	mov	x1, 16
	cinc	x3, x27, eq
	add	x0, x19, 404
	bl	snprintf
	b	.L53
.L73:
	add	x1, sp, 120
	mov	x0, x27
	bl	parse_switch
	cbz	w0, .L76
	ldr	w1, [sp, 120]
	mov	w0, 1
	str	w1, [x19, 420]
	str	w0, [x19, 424]
	b	.L53
.L197:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 2
	beq	.L54
	bl	strerror
	mov	x3, x0
	mov	x1, x21
	mov	x0, x20
	adrp	x2, .LC15
	add	x2, x2, :lo12:.LC15
	bl	error_format
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L46
.L77:
	add	x1, sp, 120
	mov	x0, x27
	bl	parse_switch
	cbz	w0, .L76
	ldr	w0, [sp, 120]
	str	w0, [x19, 428]
	str	w0, [x19, 432]
	b	.L53
.L80:
	mov	x0, x27
	bl	valid_gentoo_chroot_path
	cbz	w0, .L76
	mov	x3, x27
	add	x0, x19, 436
	adrp	x2, .LC24
	mov	x1, 512
	add	x2, x2, :lo12:.LC24
	bl	snprintf
	b	.L53
.L83:
	mov	x4, x28
	mov	x3, x23
	mov	x1, x21
	mov	x0, x20
	adrp	x2, .LC50
	add	x2, x2, :lo12:.LC50
	bl	error_format
	b	.L193
	.align	2
	.p2align 5,,15
	.global	config_apply
	.type	config_apply, %function
config_apply:
	cbz	x0, .L233
	stp	x29, x30, [sp, -32]!
	adrp	x3, .LANCHOR0
	add	x3, x3, :lo12:.LANCHOR0
	mov	x29, sp
	mov	x2, 960
	str	x19, [sp, 16]
	mov	x19, x0
	mov	x1, x19
	mov	x0, x3
	bl	memcpy
	mov	x3, x0
	ldr	w0, [x19, 4]
	mov	w1, 1
	str	w1, [x3, 960]
	bl	set_interactive
	ldr	x0, [x19, 8]
	bl	set_prompt_timeout
	ldr	w0, [x19]
	bl	set_emerge_confirm
	ldr	w0, [x19, 16]
	bl	guide_set_policy
	ldrb	w0, [x19, 276]
	cbnz	w0, .L236
	ldrb	w0, [x19, 404]
	cbnz	w0, .L237
.L209:
	ldr	w0, [x19, 424]
	cbnz	w0, .L238
.L210:
	ldr	w0, [x19, 428]
	cbnz	w0, .L239
.L211:
	ldrb	w0, [x19, 436]
	cbnz	w0, .L240
.L212:
	ldr	w0, [x19, 952]
	cbnz	w0, .L241
.L205:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L241:
	ldr	w0, [x19, 948]
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	b	set_use_binary
	.p2align 2,,3
.L240:
	add	x0, x19, 436
	bl	set_gentoo_chroot_path
	ldr	w0, [x19, 952]
	cbz	w0, .L205
	b	.L241
	.p2align 2,,3
.L239:
	bl	set_gentoo_chroot
	ldr	w0, [x19, 432]
	bl	set_portage_imitation
	ldrb	w0, [x19, 436]
	cbz	w0, .L212
	b	.L240
	.p2align 2,,3
.L238:
	ldr	w0, [x19, 420]
	bl	set_use_pipe
	ldr	w0, [x19, 428]
	cbz	w0, .L211
	b	.L239
	.p2align 2,,3
.L237:
	add	x0, x19, 404
	bl	set_opt_level
	ldr	w0, [x19, 424]
	cbz	w0, .L210
	b	.L238
	.p2align 2,,3
.L236:
	add	x0, x19, 276
	bl	set_target_arch
	ldrb	w0, [x19, 404]
	cbz	w0, .L209
	b	.L237
	.p2align 2,,3
.L233:
	ret
	.align	2
	.p2align 5,,15
	.global	config_current
	.type	config_current, %function
config_current:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	adrp	x19, .LANCHOR0
	add	x20, x19, :lo12:.LANCHOR0
	ldr	w0, [x20, 960]
	cbz	w0, .L245
	add	x0, x19, :lo12:.LANCHOR0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L245:
	mov	x0, x20
	bl	config_defaults.part.0
	mov	w0, 1
	str	w0, [x20, 960]
	add	x0, x19, :lo12:.LANCHOR0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC9:
	.word	1
	.word	0
	.word	0
	.word	0
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_config, %object
g_config:
	.zero	960
	.type	g_initialized, %object
g_initialized:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
