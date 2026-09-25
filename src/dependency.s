	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	""
	.text
	.align	2
	.p2align 5,,15
	.type	add_dep_nodes, %function
add_dep_nodes:
	cbz	x3, .L17
	stp	x29, x30, [sp, -224]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x3
	mov	x19, 0
	stp	x21, x22, [sp, 32]
	mov	x21, x2
	mov	x22, x0
	str	x23, [sp, 48]
	mov	x23, x1
	.p2align 5,,15
.L5:
	ldr	x0, [x21, x19, lsl 3]
	add	x1, sp, 64
	mov	x2, 160
	bl	dep_basename
	ldrb	w4, [sp, 64]
	cbz	w4, .L3
	add	x0, sp, 64
	bl	valid_pkgname
	cbz	w0, .L3
	add	x1, sp, 64
	mov	x0, x22
	bl	graph_has_package
	cbz	w0, .L21
.L4:
	add	x2, sp, 64
	mov	x1, x23
	mov	x0, x22
	bl	graph_add_dependency
.L3:
	add	x19, x19, 1
	cmp	x20, x19
	bne	.L5
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 224
	ret
	.p2align 2,,3
.L21:
	add	x1, sp, 64
	mov	x0, x22
	mov	w3, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	bl	graph_add_package
	b	.L4
	.p2align 2,,3
.L17:
	ret
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"repo"
	.align	3
.LC2:
	.string	"(none)"
	.align	3
.LC3:
	.string	"pacman -Si -- %s"
	.align	3
.LC4:
	.string	"Version"
	.align	3
.LC5:
	.string	"Repository"
	.align	3
.LC6:
	.string	"Depends On"
	.align	3
.LC7:
	.string	"Optional Deps"
	.align	3
.LC8:
	.string	"Make Deps"
	.align	3
.LC9:
	.string	"Build Deps"
	.align	3
.LC10:
	.string	"Check Deps"
	.align	3
.LC11:
	.string	"\033[1;36mPackage: %s %s (%s)\n\033[0m"
	.align	3
.LC12:
	.string	"None"
	.align	3
.LC13:
	.string	"Depends:"
	.align	3
.LC14:
	.string	"  %-14s%s\n"
	.align	3
.LC15:
	.string	"MakeDepends:"
	.align	3
.LC16:
	.string	"CheckDepends:"
	.align	3
.LC17:
	.string	"Optional:"
	.align	3
.LC18:
	.string	"\033[1;36mInstall order (dependency-first):\n\033[0m"
	.align	3
.LC19:
	.string	" \t"
	.align	3
.LC20:
	.string	"  %zu. %s\n"
	.align	3
.LC21:
	.string	"  1. %s\n"
	.text
	.align	2
	.p2align 5,,15
	.type	plan_from_repo, %function
plan_from_repo:
	sub	sp, sp, #1408
	mov	x2, 320
	add	x1, sp, 576
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x0, [sp, 104]
	str	xzr, [sp, 128]
	bl	shell_quote
	cbnz	w0, .L172
	ldp	x29, x30, [sp]
	add	sp, sp, 1408
	ret
	.p2align 2,,3
.L172:
	add	x3, sp, 576
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	mov	x1, 512
	add	x0, sp, 896
	stp	x19, x20, [sp, 16]
	bl	xsnprintf
	add	x1, sp, 128
	add	x0, sp, 896
	bl	run_cmd_capture
	ldr	x19, [sp, 128]
	cbnz	w0, .L24
	cbz	x19, .L24
	ldrb	w0, [x19]
	cbz	w0, .L24
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	stp	x25, x26, [sp, 64]
	adrp	x26, .LC4
	add	x26, x26, :lo12:.LC4
	mov	x20, 0
	mov	x25, 0
	stp	x21, x22, [sp, 32]
	mov	x21, 0
	mov	x22, 0
	stp	x23, x24, [sp, 48]
	mov	x24, 0
	mov	x23, 0
	stp	x27, x28, [sp, 80]
	str	x0, [sp, 112]
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	str	x0, [sp, 120]
	.p2align 5,,15
.L25:
	mov	x0, x19
	mov	w1, 10
	bl	strchr
	mov	x27, x0
	cbz	x0, .L173
	strb	wzr, [x0]
	mov	w1, 58
	mov	x0, x19
	bl	strchr
	mov	x28, x0
	cbz	x0, .L29
.L27:
	strb	wzr, [x28]
	mov	x1, x26
	mov	x0, x19
	mov	x2, 7
	bl	strncmp
	cbnz	w0, .L30
	add	x20, x28, 1
.L31:
	cbz	x27, .L28
.L29:
	ldrb	w0, [x27, 1]
	add	x19, x27, 1
	cbnz	w0, .L25
.L28:
	cbz	x20, .L38
	ldrb	w0, [x20]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L38
	.p2align 5,,15
.L37:
	ldrb	w0, [x20, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L37
.L38:
	cbz	x21, .L42
	ldrb	w0, [x21]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L42
	.p2align 5,,15
.L44:
	ldrb	w0, [x21, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L44
.L42:
	cbz	x25, .L46
	ldrb	w0, [x25]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L46
	.p2align 5,,15
.L48:
	ldrb	w0, [x25, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L48
.L46:
	cbz	x22, .L50
	ldrb	w0, [x22]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L50
	.p2align 5,,15
.L52:
	ldrb	w0, [x22, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L52
.L50:
	cbz	x23, .L54
	ldrb	w0, [x23]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L54
	.p2align 5,,15
.L56:
	ldrb	w0, [x23, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L56
.L54:
	cbz	x24, .L58
	ldrb	w0, [x24]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L58
	.p2align 5,,15
.L60:
	ldrb	w0, [x24, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L60
.L58:
	cbz	x20, .L174
.L61:
	cbz	x21, .L86
	ldrb	w0, [x21]
	cbnz	w0, .L62
.L86:
	adrp	x21, .LC1
	add	x21, x21, :lo12:.LC1
.L62:
	ldr	x1, [sp, 104]
	adrp	x0, .LC11
	mov	x3, x21
	mov	x2, x20
	add	x0, x0, :lo12:.LC11
	bl	printf
	cbz	x25, .L168
	ldrb	w0, [x25]
	cbz	w0, .L168
	mov	x0, x25
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	mov	x2, x25
	cbz	w0, .L168
	.p2align 5,,15
.L64:
	adrp	x19, .LC14
	adrp	x1, .LC13
	add	x0, x19, :lo12:.LC14
	add	x1, x1, :lo12:.LC13
	bl	printf
	cbz	x23, .L169
	ldrb	w0, [x23]
	cbz	w0, .L169
	adrp	x1, .LC12
	mov	x0, x23
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	cbz	w0, .L169
	.p2align 5,,15
.L67:
	adrp	x1, .LC15
	mov	x2, x23
	add	x1, x1, :lo12:.LC15
	add	x0, x19, :lo12:.LC14
	bl	printf
	cbz	x24, .L170
	ldrb	w0, [x24]
	cbz	w0, .L170
	adrp	x1, .LC12
	mov	x0, x24
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	cbz	w0, .L170
	.p2align 5,,15
.L70:
	adrp	x1, .LC16
	mov	x2, x24
	add	x1, x1, :lo12:.LC16
	add	x0, x19, :lo12:.LC14
	bl	printf
	cbz	x22, .L171
	ldrb	w0, [x22]
	cbz	w0, .L171
	adrp	x1, .LC12
	mov	x0, x22
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	cbz	w0, .L171
	.p2align 5,,15
.L73:
	mov	x2, x22
	adrp	x1, .LC17
	add	x1, x1, :lo12:.LC17
	add	x0, x19, :lo12:.LC14
	bl	printf
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	bl	graph_create
	stp	xzr, xzr, [sp, 136]
	mov	x21, x0
	movi	v31.4s, 0
	stp	q31, q31, [sp, 320]
	stp	q31, q31, [sp, 352]
	stp	q31, q31, [sp, 384]
	stp	q31, q31, [sp, 416]
	stp	q31, q31, [sp, 448]
	stp	q31, q31, [sp, 480]
	stp	q31, q31, [sp, 512]
	stp	q31, q31, [sp, 544]
	cbz	x0, .L75
	ldr	x1, [sp, 104]
	mov	x2, x20
	mov	w3, 0
	bl	graph_add_package
	cbz	x25, .L76
	ldrb	w0, [x25]
	cbz	w0, .L76
	adrp	x1, .LC12
	mov	x0, x25
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	cbz	w0, .L76
	mov	x0, x25
	bl	strdup
	str	xzr, [sp, 152]
	mov	x20, x0
	cbz	x0, .L76
	adrp	x19, .LC19
	add	x19, x19, :lo12:.LC19
	add	x2, sp, 152
	mov	x1, x19
	bl	strtok_r
	cbnz	x0, .L81
	b	.L78
	.p2align 2,,3
.L79:
	add	x2, sp, 152
	mov	x1, x19
	mov	x0, 0
	bl	strtok_r
	cbz	x0, .L78
.L81:
	mov	x2, 160
	add	x1, sp, x2
	bl	dep_basename
	ldrb	w0, [sp, 160]
	cbz	w0, .L79
	add	x0, sp, 160
	bl	valid_pkgname
	cbz	w0, .L79
	add	x1, sp, 160
	mov	x0, x21
	bl	graph_has_package
	cbz	w0, .L175
.L80:
	ldr	x1, [sp, 104]
	add	x2, sp, 160
	mov	x0, x21
	bl	graph_add_dependency
	b	.L79
	.p2align 2,,3
.L30:
	ldr	x1, [sp, 112]
	mov	x0, x19
	mov	x2, 10
	bl	strncmp
	cbnz	w0, .L32
	add	x21, x28, 1
	b	.L31
	.p2align 2,,3
.L173:
	mov	x0, x19
	mov	w1, 58
	bl	strchr
	mov	x28, x0
	cbnz	x0, .L27
	b	.L28
	.p2align 2,,3
.L32:
	ldr	x1, [sp, 120]
	mov	x0, x19
	mov	x2, 10
	bl	strncmp
	cbz	w0, .L176
	adrp	x1, .LC7
	mov	x0, x19
	add	x1, x1, :lo12:.LC7
	mov	x2, 13
	bl	strncmp
	cbnz	w0, .L34
	add	x22, x28, 1
	b	.L31
	.p2align 2,,3
.L24:
	mov	x0, x19
	bl	free
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1408
	ret
	.p2align 2,,3
.L176:
	add	x25, x28, 1
	b	.L31
	.p2align 2,,3
.L174:
	adrp	x20, .LC0
	add	x20, x20, :lo12:.LC0
	b	.L61
.L78:
	mov	x0, x20
	bl	free
	.p2align 5,,15
.L76:
	add	x3, sp, 320
	add	x2, sp, 144
	add	x1, sp, 136
	mov	x0, x21
	mov	x4, 256
	bl	graph_topological_order
	cbz	w0, .L82
	ldr	x0, [sp, 144]
	cbz	x0, .L83
	adrp	x22, .LC20
	add	x22, x22, :lo12:.LC20
	mov	x20, 0
	mov	x19, 0
	.p2align 5,,15
.L84:
	ldr	x0, [sp, 136]
	add	x19, x19, 1
	ldr	x1, [x0, x20]
	mov	x0, x21
	add	x20, x20, 8
	bl	graph_package_name
	mov	x2, x0
	mov	x1, x19
	mov	x0, x22
	bl	printf
	ldr	x0, [sp, 144]
	cmp	x19, x0
	bcc	.L84
.L83:
	ldr	x0, [sp, 136]
	bl	free
	mov	x0, x21
	bl	graph_destroy
.L75:
	ldr	x0, [sp, 128]
	bl	free
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, 1408
	ret
	.p2align 2,,3
.L171:
	adrp	x22, .LC2
	add	x22, x22, :lo12:.LC2
	b	.L73
	.p2align 2,,3
.L170:
	adrp	x24, .LC2
	add	x24, x24, :lo12:.LC2
	b	.L70
	.p2align 2,,3
.L169:
	adrp	x23, .LC2
	add	x23, x23, :lo12:.LC2
	b	.L67
	.p2align 2,,3
.L168:
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	b	.L64
	.p2align 2,,3
.L34:
	adrp	x1, .LC8
	mov	x0, x19
	add	x1, x1, :lo12:.LC8
	mov	x2, 9
	bl	strncmp
	cbz	w0, .L35
	adrp	x1, .LC9
	mov	x0, x19
	add	x1, x1, :lo12:.LC9
	mov	x2, 10
	bl	strncmp
	cbz	w0, .L35
	mov	x0, x19
	mov	x2, 10
	adrp	x1, .LC10
	add	x1, x1, :lo12:.LC10
	bl	strncmp
	cmp	w0, 0
	csinc	x24, x24, x28, ne
	b	.L31
	.p2align 2,,3
.L35:
	add	x23, x28, 1
	b	.L31
	.p2align 2,,3
.L82:
	ldr	x1, [sp, 104]
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	b	.L83
.L175:
	add	x1, sp, 160
	mov	x0, x21
	mov	w3, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	bl	graph_add_package
	b	.L80
	.section	.rodata.str1.8
	.align	3
.LC22:
	.string	"  %-14s"
	.align	3
.LC23:
	.string	"%s%s"
	.align	3
.LC24:
	.string	"  "
	.text
	.align	2
	.p2align 5,,15
	.type	print_dep_list, %function
print_dep_list:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x22, x1
	mov	x21, x2
	mov	x1, x0
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	cbz	x21, .L182
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	stp	x19, x20, [sp, 16]
	adrp	x20, .LC23
	add	x20, x20, :lo12:.LC23
	mov	x19, 0
	str	x23, [sp, 48]
	adrp	x23, .LC24
	.p2align 5,,15
.L178:
	ldr	x2, [x22, x19, lsl 3]
	mov	x0, x20
	add	x19, x19, 1
	bl	printf
	add	x1, x23, :lo12:.LC24
	cmp	x21, x19
	bne	.L178
	adrp	x0, :got:stdout
	ldr	x0, [x0, :got_lo12:stdout]
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ldr	x1, [x0]
	mov	w0, 10
	b	putc
	.p2align 2,,3
.L182:
	ldp	x21, x22, [sp, 32]
	adrp	x0, .LC2
	ldp	x29, x30, [sp], 64
	add	x0, x0, :lo12:.LC2
	b	puts
	.section	.rodata.str1.8
	.align	3
.LC25:
	.string	"?"
	.align	3
.LC26:
	.string	" "
	.align	3
.LC27:
	.string	"aur"
	.align	3
.LC28:
	.string	"repo/dep"
	.align	3
.LC29:
	.string	"\033[1;36mPackage: %s %s (aur)\n\033[0m"
	.align	3
.LC30:
	.string	"  %zu. %s%s%s  [%s]\n"
	.align	3
.LC31:
	.string	"\033[1;31m[-] %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	plan_from_aur, %function
plan_from_aur:
	movi	v31.4s, 0
	stp	x29, x30, [sp, -400]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x23, x24, [sp, 48]
	mov	x23, x0
	stp	xzr, xzr, [sp, 112]
	stp	xzr, xzr, [sp, 128]
	stp	q31, q31, [sp, 144]
	stp	q31, q31, [sp, 176]
	stp	q31, q31, [sp, 208]
	stp	q31, q31, [sp, 240]
	stp	q31, q31, [sp, 272]
	stp	q31, q31, [sp, 304]
	stp	q31, q31, [sp, 336]
	stp	q31, q31, [sp, 368]
	bl	config_current
	add	x3, sp, 144
	add	x2, sp, 128
	mov	x1, x23
	add	x0, x0, 20
	mov	x4, 256
	bl	aur_rpc_info
	cbz	w0, .L184
	ldr	x0, [sp, 136]
	cbnz	x0, .L185
.L184:
	add	x0, sp, 128
	mov	w19, 0
	bl	aur_response_destroy
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 400
	ret
	.p2align 2,,3
.L185:
	stp	x21, x22, [sp, 32]
	bl	graph_create
	mov	x21, x0
	cbz	x0, .L217
	ldr	x0, [sp, 136]
	stp	x25, x26, [sp, 64]
	cbz	x0, .L187
	adrp	x25, .LC29
	add	x25, x25, :lo12:.LC29
	adrp	x0, .LC13
	mov	x24, 0
	add	x0, x0, :lo12:.LC13
	adrp	x26, .LC16
	adrp	x22, .LC0
	stp	x27, x28, [sp, 80]
	mov	x28, 0
	adrp	x27, .LC15
	str	x0, [sp, 104]
	.p2align 5,,15
.L191:
	ldr	x0, [sp, 128]
	mov	w3, 1
	add	x24, x24, 1
	add	x19, x0, x28
	ldr	x20, [x0, x28]
	add	x0, x22, :lo12:.LC0
	ldr	x2, [x19, 16]
	cmp	x20, 0
	csel	x20, x20, x23, ne
	add	x28, x28, 152
	cmp	x2, 0
	mov	x1, x20
	csel	x2, x0, x2, eq
	mov	x0, x21
	bl	graph_add_package
	ldr	x2, [x19, 16]
	add	x0, x22, :lo12:.LC0
	mov	x1, x20
	cmp	x2, 0
	csel	x2, x0, x2, eq
	mov	x0, x25
	bl	printf
	ldp	x1, x2, [x19, 72]
	ldr	x0, [sp, 104]
	bl	print_dep_list
	ldp	x1, x2, [x19, 88]
	add	x0, x27, :lo12:.LC15
	bl	print_dep_list
	ldp	x1, x2, [x19, 104]
	add	x0, x26, :lo12:.LC16
	bl	print_dep_list
	ldp	x2, x3, [x19, 72]
	mov	x1, x20
	mov	x0, x21
	bl	add_dep_nodes
	ldp	x2, x3, [x19, 88]
	mov	x1, x20
	mov	x0, x21
	bl	add_dep_nodes
	ldp	x2, x3, [x19, 104]
	mov	x0, x21
	mov	x1, x20
	bl	add_dep_nodes
	ldr	x0, [sp, 136]
	cmp	x0, x24
	bhi	.L191
	ldp	x27, x28, [sp, 80]
.L187:
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	add	x3, sp, 144
	add	x2, sp, 120
	add	x1, sp, 112
	mov	x0, x21
	mov	x4, 256
	bl	graph_topological_order
	mov	w19, w0
	cbz	w0, .L192
	ldr	x0, [sp, 120]
	mov	x22, 0
	adrp	x25, .LC30
	adrp	x24, .LC25
	adrp	x23, .LC0
	cbnz	x0, .L193
	b	.L198
	.p2align 2,,3
.L202:
	adrp	x3, .LC26
	add	x3, x3, :lo12:.LC26
.L196:
	adrp	x5, .LC28
	add	x5, x5, :lo12:.LC28
	cmp	w0, 1
	bne	.L197
	adrp	x5, .LC27
	add	x5, x5, :lo12:.LC27
.L197:
	mov	x4, x20
	mov	x2, x19
	mov	x1, x22
	add	x0, x25, :lo12:.LC30
	bl	printf
	ldr	x0, [sp, 120]
	cmp	x22, x0
	bcs	.L198
.L193:
	ldr	x0, [sp, 112]
	ldr	x1, [x0, x22, lsl 3]
	mov	x0, x21
	bl	graph_package_name
	mov	x19, x0
	ldr	x0, [sp, 112]
	ldr	x1, [x0, x22, lsl 3]
	mov	x0, x21
	bl	graph_package_version
	mov	x20, x0
	ldr	x0, [sp, 112]
	ldr	x1, [x0, x22, lsl 3]
	mov	x0, x21
	add	x22, x22, 1
	bl	graph_package_source
	add	x1, x24, :lo12:.LC25
	cmp	x19, 0
	csel	x19, x1, x19, eq
	cbz	x20, .L201
	ldrb	w1, [x20]
	cbnz	w1, .L202
.L201:
	add	x3, x23, :lo12:.LC0
	mov	x20, x3
	b	.L196
	.p2align 2,,3
.L198:
	mov	w19, 1
.L194:
	ldr	x0, [sp, 112]
	bl	free
	mov	x0, x21
	bl	graph_destroy
	add	x0, sp, 128
	bl	aur_response_destroy
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 400
	ret
	.p2align 2,,3
.L192:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 144
	adrp	x1, .LC31
	add	x1, x1, :lo12:.LC31
	ldr	x0, [x0]
	bl	fprintf
	b	.L194
	.p2align 2,,3
.L217:
	ldp	x21, x22, [sp, 32]
	b	.L184
	.section	.rodata.str1.8
	.align	3
.LC32:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC33:
	.string	"\033[1;31m[-] Could not resolve dependencies for '%s'.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_dependency_plan_v2
	.type	cmd_dependency_plan_v2, %function
cmd_dependency_plan_v2:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L219
	mov	w3, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x19, .L225
.L220:
	mov	x2, x19
	adrp	x1, .LC32
	add	x1, x1, :lo12:.LC32
	str	w3, [sp, 44]
	bl	fprintf
	ldr	w3, [sp, 44]
.L218:
	ldr	x19, [sp, 16]
	mov	w0, w3
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L219:
	mov	x0, x19
	bl	plan_from_repo
	mov	w3, w0
	cbnz	w0, .L218
	mov	x0, x19
	bl	plan_from_aur
	mov	w3, w0
	cbnz	w0, .L218
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC33
	add	x1, x1, :lo12:.LC33
	str	w3, [sp, 44]
	ldr	x0, [x0]
	bl	fprintf
	ldr	w3, [sp, 44]
	ldr	x19, [sp, 16]
	mov	w0, w3
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L225:
	adrp	x19, .LC0
	add	x19, x19, :lo12:.LC0
	b	.L220
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
