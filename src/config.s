	.arch armv8-a
	.text
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
	ldrb	w0, [x19]
	ldrh	w0, [x20, x0, lsl 1]
	tbz	x0, 13, .L2
	.p2align 5,,15
.L3:
	ldrb	w0, [x19, 1]!
	ldrh	w0, [x20, x0, lsl 1]
	tbnz	x0, 13, .L3
.L2:
	mov	x0, x19
	bl	strlen
	add	x1, x19, x0
	cmp	x1, x19
	bhi	.L4
	b	.L5
	.p2align 2,,3
.L6:
	sub	x1, x1, #1
	cmp	x1, x19
	beq	.L5
.L4:
	ldrb	w0, [x1, -1]
	ldrh	w0, [x20, x0, lsl 1]
	tbnz	x0, 13, .L6
.L5:
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
	beq	.L15
	add	x3, sp, 256
	stp	x3, x3, [sp, 48]
	add	x3, sp, 208
	ldr	q31, [sp, 48]
	str	x3, [sp, 64]
	mov	w3, -40
	str	w3, [sp, 72]
	mov	w3, -128
	str	w3, [sp, 76]
	str	q31, [sp, 16]
	add	x3, sp, 16
	ldr	q31, [sp, 64]
	str	q31, [sp, 32]
	bl	vsnprintf
.L15:
	ldp	x29, x30, [sp], 256
	ret
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
	mov	x19, x1
	mov	x20, x0
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L19
	adrp	x1, .LC1
	mov	x0, x20
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbnz	w0, .L40
.L19:
	mov	w0, 1
	str	w0, [x19]
.L21:
	mov	w0, 1
.L18:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L40:
	adrp	x1, .LC2
	mov	x0, x20
	add	x1, x1, :lo12:.LC2
	bl	strcmp
	cbz	w0, .L19
	adrp	x1, .LC3
	mov	x0, x20
	add	x1, x1, :lo12:.LC3
	bl	strcmp
	cbz	w0, .L22
	ldrb	w0, [x20]
	cmp	w0, 110
	bne	.L26
	ldrb	w0, [x20, 1]
	cmp	w0, 111
	bne	.L26
	ldrb	w0, [x20, 2]
	cbz	w0, .L22
	.p2align 5,,15
.L26:
	mov	x0, x20
	adrp	x1, .LC4
	add	x1, x1, :lo12:.LC4
	bl	strcmp
	mov	w1, w0
	mov	w0, 0
	cbnz	w1, .L18
.L22:
	str	wzr, [x19]
	b	.L21
	.section	.rodata.str1.8
	.align	3
.LC5:
	.string	"https://aur.archlinux.org/rpc/v5"
	.align	3
.LC6:
	.string	"native"
	.align	3
.LC8:
	.string	"/usr/local/emerge"
	.align	3
.LC9:
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
	mov	w0, 1
	add	x1, x19, 276
	str	w0, [x19]
	mov	x0, 300
	str	x0, [x19, 8]
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	adrp	x3, .LC8
	add	x3, x3, :lo12:.LC8
	ldp	q30, q31, [x0]
	ldrb	w0, [x0, 32]
	strb	w0, [x19, 52]
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	str	q30, [x19, 20]
	ldr	w2, [x0]
	ldr	w0, [x0, 3]
	str	q31, [x19, 36]
	str	w2, [x19, 276]
	adrp	x2, .LC9
	str	w0, [x1, 3]
	adrp	x1, .LANCHOR0
	mov	w0, 51
	strh	w0, [x19, 404]
	ldr	q31, [x1, #:lo12:.LANCHOR0]
	add	x0, x19, 512
	add	x2, x2, :lo12:.LC9
	mov	x1, 512
	str	q31, [x0, -92]
	add	x0, x19, 436
	add	x19, x19, 1024
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
.LC11:
	.string	"XDG_CONFIG_HOME"
	.align	3
.LC12:
	.string	"%s/archtoo/config"
	.align	3
.LC13:
	.string	"%s/.config/archtoo/config"
	.align	3
.LC14:
	.string	"cannot determine invoking user's config path"
	.align	3
.LC15:
	.string	"r"
	.align	3
.LC16:
	.string	"cannot open config: %s"
	.align	3
.LC17:
	.string	"config line %lu has no '='"
	.align	3
.LC18:
	.string	"emerge_confirm"
	.align	3
.LC19:
	.string	"pacman_confirm"
	.align	3
.LC20:
	.string	"prompt_timeout"
	.align	3
.LC21:
	.string	"welcome_policy"
	.align	3
.LC22:
	.string	"command_guide"
	.align	3
.LC23:
	.string	"aur_rpc_url"
	.align	3
.LC24:
	.string	"https://"
	.align	3
.LC25:
	.string	"%s"
	.align	3
.LC26:
	.string	"target_arch"
	.align	3
.LC27:
	.string	"target"
	.align	3
.LC28:
	.string	"march"
	.align	3
.LC29:
	.string	"cpu"
	.align	3
.LC30:
	.string	"opt_level"
	.align	3
.LC31:
	.string	"opt"
	.align	3
.LC32:
	.string	"optimization"
	.align	3
.LC33:
	.string	"o"
	.align	3
.LC34:
	.string	"pipe"
	.align	3
.LC35:
	.string	"use_pipe"
	.align	3
.LC36:
	.string	"gentoo_chroot"
	.align	3
.LC37:
	.string	"portage_chroot"
	.align	3
.LC38:
	.string	"imitation"
	.align	3
.LC39:
	.string	"portage_imitation"
	.align	3
.LC40:
	.string	"gentoo_imitation"
	.align	3
.LC41:
	.string	"gentoo_chroot_path"
	.align	3
.LC42:
	.string	"chroot_path"
	.align	3
.LC43:
	.string	"binary"
	.align	3
.LC44:
	.string	"use_binary"
	.align	3
.LC45:
	.string	"use_bin"
	.align	3
.LC46:
	.string	"bin"
	.align	3
.LC47:
	.string	"prebuilt"
	.align	3
.LC48:
	.string	"use_prebuilt"
	.align	3
.LC49:
	.string	"no_build"
	.align	3
.LC50:
	.string	"no-build"
	.align	3
.LC51:
	.string	"unknown config key on line %lu: %s"
	.align	3
.LC52:
	.string	"invalid value for %s on line %lu: %s"
	.align	3
.LC53:
	.string	"error reading config: %s"
	.text
	.align	2
	.p2align 5,,15
	.global	config_load
	.type	config_load, %function
config_load:
	cbz	x0, .L187
	sub	sp, sp, #2176
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	stp	x25, x26, [sp, 64]
	mov	x26, x2
	mov	x25, x1
	bl	config_defaults.part.0
	bl	build_user
	cbz	x0, .L194
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	str	x27, [sp, 80]
	bl	getpwnam
	mov	x19, x0
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	getenv
	mov	x21, x0
	cbz	x19, .L191
	ldr	x3, [x19, 32]
	cbz	x3, .L191
	cbz	x0, .L51
	ldrb	w0, [x0]
	cbnz	w0, .L195
.L51:
	add	x19, sp, 128
	adrp	x2, .LC13
	mov	x0, x19
	add	x2, x2, :lo12:.LC13
	mov	x1, 1024
	bl	snprintf
.L52:
	mov	x0, x19
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	bl	fopen
	mov	x23, x0
	cbz	x0, .L196
	adrp	x24, .LC18
	adrp	x0, .LC19
	add	x24, x24, :lo12:.LC18
	add	x27, x0, :lo12:.LC19
	mov	x21, 0
.L54:
	mov	x2, x23
	add	x0, sp, 1152
	mov	w1, 1024
	bl	fgets
	cbz	x0, .L197
	add	x0, sp, 1152
	bl	trim
	ldrb	w1, [x0]
	add	x21, x21, 1
	mov	x22, x0
	cmp	w1, 35
	ccmp	w1, 0, 4, ne
	beq	.L54
	mov	w1, 61
	bl	strchr
	cbz	x0, .L198
	strb	wzr, [x0], 1
	bl	trim
	mov	x19, x0
	mov	x0, x22
	bl	trim
	mov	w1, 35
	mov	x22, x0
	mov	x0, x19
	bl	strchr
	cbz	x0, .L59
	strb	wzr, [x0]
	mov	x0, x19
	bl	trim
	mov	x19, x0
.L59:
	mov	x1, x24
	mov	x0, x22
	bl	strcmp
	cbz	w0, .L199
	mov	x1, x27
	mov	x0, x22
	bl	strcmp
	cbz	w0, .L200
	adrp	x1, .LC20
	mov	x0, x22
	add	x1, x1, :lo12:.LC20
	bl	strcmp
	cbz	w0, .L201
	adrp	x1, .LC21
	mov	x0, x22
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L64
	adrp	x1, .LC22
	mov	x0, x22
	add	x1, x1, :lo12:.LC22
	bl	strcmp
	cbz	w0, .L64
	adrp	x1, .LC23
	mov	x0, x22
	add	x1, x1, :lo12:.LC23
	bl	strcmp
	cbz	w0, .L202
	adrp	x1, .LC26
	mov	x0, x22
	add	x1, x1, :lo12:.LC26
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC27
	mov	x0, x22
	add	x1, x1, :lo12:.LC27
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC28
	mov	x0, x22
	add	x1, x1, :lo12:.LC28
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC29
	mov	x0, x22
	add	x1, x1, :lo12:.LC29
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC30
	mov	x0, x22
	add	x1, x1, :lo12:.LC30
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC31
	mov	x0, x22
	add	x1, x1, :lo12:.LC31
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC32
	mov	x0, x22
	add	x1, x1, :lo12:.LC32
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC33
	mov	x0, x22
	add	x1, x1, :lo12:.LC33
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC34
	mov	x0, x22
	add	x1, x1, :lo12:.LC34
	bl	strcmp
	cbz	w0, .L73
	adrp	x1, .LC35
	mov	x0, x22
	add	x1, x1, :lo12:.LC35
	bl	strcmp
	cbz	w0, .L73
	adrp	x1, .LC36
	mov	x0, x22
	add	x1, x1, :lo12:.LC36
	bl	strcmp
	cbz	w0, .L76
	adrp	x1, .LC37
	mov	x0, x22
	add	x1, x1, :lo12:.LC37
	bl	strcmp
	cbz	w0, .L76
	adrp	x1, .LC38
	mov	x0, x22
	add	x1, x1, :lo12:.LC38
	bl	strcmp
	cbz	w0, .L76
	adrp	x1, .LC39
	mov	x0, x22
	add	x1, x1, :lo12:.LC39
	bl	strcmp
	cbz	w0, .L76
	adrp	x1, .LC40
	mov	x0, x22
	add	x1, x1, :lo12:.LC40
	bl	strcmp
	cbz	w0, .L76
	adrp	x1, .LC41
	mov	x0, x22
	add	x1, x1, :lo12:.LC41
	bl	strcmp
	cbz	w0, .L79
	adrp	x1, .LC42
	mov	x0, x22
	add	x1, x1, :lo12:.LC42
	bl	strcmp
	cbz	w0, .L79
	adrp	x1, .LC43
	mov	x0, x22
	add	x1, x1, :lo12:.LC43
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC44
	mov	x0, x22
	add	x1, x1, :lo12:.LC44
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC45
	mov	x0, x22
	add	x1, x1, :lo12:.LC45
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC46
	mov	x0, x22
	add	x1, x1, :lo12:.LC46
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC47
	mov	x0, x22
	add	x1, x1, :lo12:.LC47
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC48
	mov	x0, x22
	add	x1, x1, :lo12:.LC48
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC49
	mov	x0, x22
	add	x1, x1, :lo12:.LC49
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC50
	mov	x0, x22
	add	x1, x1, :lo12:.LC50
	bl	strcmp
	cbnz	w0, .L82
.L81:
	add	x1, sp, 120
	mov	x0, x19
	bl	parse_switch
	cbz	w0, .L61
	ldr	w0, [sp, 120]
	str	w0, [x20, 948]
	mov	w0, 1
	str	w0, [x20, 952]
	b	.L54
	.p2align 2,,3
.L194:
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	getenv
.L48:
	adrp	x2, .LC14
	mov	x1, x26
	add	x2, x2, :lo12:.LC14
	mov	x0, x25
	bl	error_format
.L46:
	mov	w0, 0
.L45:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L187:
	mov	w0, 0
	ret
	.p2align 2,,3
.L199:
	mov	x1, x20
	mov	x0, x19
	bl	parse_switch
	cbnz	w0, .L54
.L61:
	adrp	x2, .LC52
	mov	x5, x19
	mov	x4, x21
	mov	x3, x22
	add	x2, x2, :lo12:.LC52
	mov	x1, x26
	mov	x0, x25
	bl	error_format
.L192:
	mov	x0, x23
	bl	fclose
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L46
	.p2align 2,,3
.L64:
	add	x1, x20, 16
	mov	x0, x19
	bl	guide_policy_parse
	cbz	w0, .L61
	b	.L54
	.p2align 2,,3
.L200:
	add	x1, x20, 4
	mov	x0, x19
	bl	parse_switch
	cbz	w0, .L61
	b	.L54
	.p2align 2,,3
.L195:
	bl	geteuid
	cbnz	w0, .L50
	ldr	x3, [x19, 32]
	b	.L51
	.p2align 2,,3
.L191:
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L48
	.p2align 2,,3
.L201:
	bl	__errno_location
	mov	x3, x0
	add	x1, sp, 120
	mov	x0, x19
	mov	w2, 10
	str	x3, [sp, 104]
	str	wzr, [x3]
	bl	strtol
	ldr	x3, [sp, 104]
	ldr	w1, [x3]
	cbnz	w1, .L61
	ldr	x1, [sp, 120]
	ldrb	w1, [x1]
	cbnz	w1, .L61
	mov	x1, 20864
	movk	x1, 0x1, lsl 16
	cmp	x0, x1
	bhi	.L61
	str	x0, [x20, 8]
	b	.L54
	.p2align 2,,3
.L202:
	adrp	x1, .LC24
	mov	x0, x19
	add	x1, x1, :lo12:.LC24
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L61
	mov	x0, x19
	bl	strlen
	cmp	x0, 255
	bhi	.L61
	mov	x3, x19
	add	x0, x20, 20
	adrp	x2, .LC25
	mov	x1, 256
	add	x2, x2, :lo12:.LC25
	bl	snprintf
	b	.L54
	.p2align 2,,3
.L50:
	add	x19, sp, 128
	mov	x3, x21
	mov	x0, x19
	adrp	x2, .LC12
	mov	x1, 1024
	add	x2, x2, :lo12:.LC12
	bl	snprintf
	b	.L52
	.p2align 2,,3
.L67:
	mov	x0, x19
	bl	valid_target_arch
	cbz	w0, .L61
	mov	x0, x19
	bl	strlen
	cmp	x0, 127
	bhi	.L61
	mov	x3, x19
	add	x0, x20, 276
	adrp	x2, .LC25
	mov	x1, 128
	add	x2, x2, :lo12:.LC25
	bl	snprintf
	b	.L54
	.p2align 2,,3
.L197:
	mov	x0, x23
	bl	ferror
	cbnz	w0, .L203
	mov	x0, x23
	bl	fclose
.L55:
	ldr	x27, [sp, 80]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L45
	.p2align 2,,3
.L198:
	adrp	x2, .LC17
	mov	x3, x21
	add	x2, x2, :lo12:.LC17
.L193:
	mov	x1, x26
	mov	x0, x25
	bl	error_format
	b	.L192
.L203:
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x3, x0
	adrp	x2, .LC53
	add	x2, x2, :lo12:.LC53
	b	.L193
.L69:
	mov	x0, x19
	bl	valid_opt_level
	cbz	w0, .L61
	mov	x0, x19
	bl	strlen
	cmp	x0, 16
	bhi	.L61
	ldrb	w0, [x19]
	cmp	w0, 45
	bne	.L71
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
.L71:
	and	w0, w0, -33
	adrp	x2, .LC25
	and	w0, w0, 255
	add	x2, x2, :lo12:.LC25
	cmp	w0, 79
	mov	x1, 16
	cinc	x3, x19, eq
	add	x0, x20, 404
	bl	snprintf
	b	.L54
.L73:
	add	x1, sp, 120
	mov	x0, x19
	bl	parse_switch
	cbz	w0, .L61
	ldr	w0, [sp, 120]
	str	w0, [x20, 420]
	mov	w0, 1
	str	w0, [x20, 424]
	b	.L54
.L196:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 2
	beq	.L55
	bl	strerror
	mov	x3, x0
	mov	x1, x26
	mov	x0, x25
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	error_format
	ldr	x27, [sp, 80]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	b	.L46
.L76:
	add	x1, sp, 120
	mov	x0, x19
	bl	parse_switch
	cbz	w0, .L61
	ldr	w0, [sp, 120]
	str	w0, [x20, 428]
	str	w0, [x20, 432]
	b	.L54
.L79:
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbz	w0, .L61
	mov	x3, x19
	add	x0, x20, 436
	adrp	x2, .LC25
	mov	x1, 512
	add	x2, x2, :lo12:.LC25
	bl	snprintf
	b	.L54
.L82:
	mov	x4, x22
	mov	x3, x21
	mov	x1, x26
	mov	x0, x25
	adrp	x2, .LC51
	add	x2, x2, :lo12:.LC51
	bl	error_format
	b	.L192
	.align	2
	.p2align 5,,15
	.global	config_apply
	.type	config_apply, %function
config_apply:
	cbz	x0, .L233
	stp	x29, x30, [sp, -32]!
	adrp	x3, .LANCHOR1
	mov	x1, x0
	mov	x29, sp
	mov	x2, 960
	str	x19, [sp, 16]
	mov	x19, x0
	add	x0, x3, :lo12:.LANCHOR1
	bl	memcpy
	mov	x3, x0
	mov	w0, 1
	str	w0, [x3, 960]
	ldr	w0, [x19, 4]
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
.L207:
	ldr	w0, [x19, 424]
	cbnz	w0, .L238
.L208:
	ldr	w0, [x19, 428]
	cbnz	w0, .L239
.L209:
	ldrb	w0, [x19, 436]
	cbnz	w0, .L240
.L210:
	ldr	w0, [x19, 952]
	cbnz	w0, .L241
.L204:
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
	cbz	w0, .L204
	b	.L241
	.p2align 2,,3
.L239:
	bl	set_gentoo_chroot
	ldr	w0, [x19, 432]
	bl	set_portage_imitation
	ldrb	w0, [x19, 436]
	cbz	w0, .L210
	b	.L240
	.p2align 2,,3
.L238:
	ldr	w0, [x19, 420]
	bl	set_use_pipe
	ldr	w0, [x19, 428]
	cbz	w0, .L209
	b	.L239
	.p2align 2,,3
.L237:
	add	x0, x19, 404
	bl	set_opt_level
	ldr	w0, [x19, 424]
	cbz	w0, .L208
	b	.L238
	.p2align 2,,3
.L236:
	add	x0, x19, 276
	bl	set_target_arch
	ldrb	w0, [x19, 404]
	cbz	w0, .L207
	b	.L237
	.p2align 2,,3
.L233:
	ret
	.align	2
	.p2align 5,,15
	.global	config_current
	.type	config_current, %function
config_current:
	adrp	x1, .LANCHOR1
	add	x0, x1, :lo12:.LANCHOR1
	ldr	w2, [x0, 960]
	cbz	w2, .L248
	add	x0, x1, :lo12:.LANCHOR1
	ret
	.p2align 2,,3
.L248:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x0, [sp, 24]
	bl	config_defaults.part.0
	ldr	x0, [sp, 24]
	mov	w2, 1
	adrp	x1, .LANCHOR1
	str	w2, [x0, 960]
	add	x0, x1, :lo12:.LANCHOR1
	ldp	x29, x30, [sp], 32
	ret
	.section	.rodata
	.align	4
	.set	.LANCHOR0,. + 0
.LC7:
	.word	1
	.word	0
	.word	0
	.word	0
	.bss
	.align	3
	.set	.LANCHOR1,. + 0
	.type	g_config, %object
g_config:
	.zero	960
	.type	g_initialized, %object
g_initialized:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
