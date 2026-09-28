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
	cbz	x3, .L16
	stp	x29, x30, [sp, -224]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x20, sp, 64
	mov	x19, 0
	stp	x21, x22, [sp, 32]
	mov	x22, x2
	mov	x21, x3
	stp	x23, x24, [sp, 48]
	mov	x23, x0
	mov	x24, x1
	.p2align 5,,15
.L7:
	ldr	x0, [x22, x19, lsl 3]
	mov	x1, x20
	mov	x2, 160
	bl	dep_basename
	ldrb	w4, [sp, 64]
	mov	x0, x20
	cbz	w4, .L4
	bl	valid_pkgname
	cbz	w0, .L4
	mov	x1, x20
	mov	x0, x23
	bl	graph_has_package
	cbz	w0, .L20
.L6:
	mov	x2, x20
	mov	x1, x24
	mov	x0, x23
	bl	graph_add_dependency
.L4:
	add	x19, x19, 1
	cmp	x21, x19
	bne	.L7
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 224
	ret
	.p2align 2,,3
.L20:
	mov	x1, x20
	mov	x0, x23
	adrp	x2, .LC0
	mov	w3, 0
	add	x2, x2, :lo12:.LC0
	bl	graph_add_package
	b	.L6
	.p2align 2,,3
.L16:
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
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 576
	mov	x1, x19
	str	x0, [sp, 104]
	str	xzr, [sp, 128]
	bl	shell_quote
	cbnz	w0, .L166
.L22:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1408
	ret
	.p2align 2,,3
.L166:
	mov	x3, x19
	adrp	x2, .LC3
	add	x2, x2, :lo12:.LC3
	add	x0, sp, 896
	mov	x19, x0
	mov	x1, 512
	bl	xsnprintf
	mov	x0, x19
	add	x1, sp, 128
	bl	run_cmd_capture
	ldr	x19, [sp, 128]
	cbnz	w0, .L23
	cbz	x19, .L23
	ldrb	w0, [x19]
	cbz	w0, .L23
	stp	x27, x28, [sp, 80]
	adrp	x27, .LC4
	adrp	x28, .LC5
	add	x27, x27, :lo12:.LC4
	add	x0, x28, :lo12:.LC5
	mov	x20, 0
	stp	x21, x22, [sp, 32]
	mov	x21, 0
	mov	x22, 0
	stp	x23, x24, [sp, 48]
	mov	x24, 0
	mov	x23, 0
	stp	x25, x26, [sp, 64]
	mov	x25, 0
	str	x0, [sp, 112]
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	str	x0, [sp, 120]
	.p2align 5,,15
.L24:
	mov	x0, x19
	mov	w1, 10
	bl	strchr
	mov	x28, x0
	cbz	x0, .L167
	strb	wzr, [x0]
	mov	w1, 58
	mov	x0, x19
	bl	strchr
	mov	x26, x0
	cbz	x0, .L29
.L27:
	strb	wzr, [x26]
	mov	x1, x27
	mov	x0, x19
	mov	x2, 7
	bl	strncmp
	cbnz	w0, .L30
	add	x20, x26, 1
.L31:
	cbz	x28, .L28
.L29:
	ldrb	w0, [x28, 1]
	add	x19, x28, 1
	cbnz	w0, .L24
.L28:
	cbz	x20, .L39
	ldrb	w0, [x20]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L39
	.p2align 5,,15
.L37:
	ldrb	w0, [x20, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L37
.L39:
	cbz	x21, .L40
	ldrb	w0, [x21]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L40
	.p2align 5,,15
.L42:
	ldrb	w0, [x21, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L42
.L40:
	cbz	x25, .L43
	ldrb	w0, [x25]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L43
	.p2align 5,,15
.L45:
	ldrb	w0, [x25, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L45
.L43:
	cbz	x22, .L46
	ldrb	w0, [x22]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L46
	.p2align 5,,15
.L48:
	ldrb	w0, [x22, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L48
.L46:
	cbz	x23, .L49
	ldrb	w0, [x23]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L49
	.p2align 5,,15
.L51:
	ldrb	w0, [x23, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L51
.L49:
	cbz	x24, .L52
	ldrb	w0, [x24]
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L52
	.p2align 5,,15
.L54:
	ldrb	w0, [x24, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L54
.L52:
	cmp	x20, 0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	csel	x20, x0, x20, eq
	cbz	x21, .L75
	ldrb	w1, [x21]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	cmp	w1, 0
	csel	x21, x0, x21, eq
.L56:
	ldr	x1, [sp, 104]
	adrp	x0, .LC11
	mov	x3, x21
	mov	x2, x20
	add	x0, x0, :lo12:.LC11
	bl	printf
	cbz	x25, .L77
	ldrb	w0, [x25]
	cbz	w0, .L77
	mov	x0, x25
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	adrp	x2, .LC2
	cmp	w0, 0
	add	x2, x2, :lo12:.LC2
	csel	x2, x2, x25, eq
.L57:
	adrp	x1, .LC13
	adrp	x19, .LC14
	add	x1, x1, :lo12:.LC13
	add	x0, x19, :lo12:.LC14
	bl	printf
	cbz	x23, .L80
	ldrb	w0, [x23]
	cbz	w0, .L80
	mov	x0, x23
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	adrp	x1, .LC2
	cmp	w0, 0
	add	x1, x1, :lo12:.LC2
	csel	x23, x1, x23, eq
.L58:
	adrp	x1, .LC15
	mov	x2, x23
	add	x0, x19, :lo12:.LC14
	add	x1, x1, :lo12:.LC15
	bl	printf
	cbz	x24, .L82
	ldrb	w0, [x24]
	cbz	w0, .L82
	mov	x0, x24
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	adrp	x1, .LC2
	cmp	w0, 0
	add	x1, x1, :lo12:.LC2
	csel	x24, x1, x24, eq
.L59:
	adrp	x1, .LC16
	mov	x2, x24
	add	x0, x19, :lo12:.LC14
	add	x1, x1, :lo12:.LC16
	bl	printf
	cbz	x22, .L84
	ldrb	w0, [x22]
	cbz	w0, .L84
	mov	x0, x22
	adrp	x1, .LC12
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	adrp	x1, .LC2
	cmp	w0, 0
	add	x1, x1, :lo12:.LC2
	csel	x22, x1, x22, eq
.L60:
	mov	x2, x22
	adrp	x1, .LC17
	add	x1, x1, :lo12:.LC17
	add	x0, x19, :lo12:.LC14
	bl	printf
	add	x19, sp, 320
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	bl	graph_create
	stp	xzr, xzr, [sp, 136]
	mov	x21, x0
	movi	v31.4s, 0
	stp	q31, q31, [x19]
	stp	q31, q31, [x19, 32]
	stp	q31, q31, [x19, 64]
	stp	q31, q31, [x19, 96]
	stp	q31, q31, [x19, 128]
	stp	q31, q31, [x19, 160]
	stp	q31, q31, [x19, 192]
	stp	q31, q31, [x19, 224]
	cbz	x0, .L61
	ldr	x1, [sp, 104]
	mov	x2, x20
	mov	w3, 0
	bl	graph_add_package
	cbz	x25, .L62
	ldrb	w0, [x25]
	cbz	w0, .L62
	adrp	x1, .LC12
	mov	x0, x25
	add	x1, x1, :lo12:.LC12
	bl	strcmp
	cbz	w0, .L62
	mov	x0, x25
	bl	strdup
	str	xzr, [sp, 152]
	mov	x24, x0
	cbz	x0, .L62
	add	x23, sp, 152
	adrp	x22, .LC19
	add	x22, x22, :lo12:.LC19
	mov	x2, x23
	mov	x1, x22
	add	x20, sp, 160
	bl	strtok_r
	cbnz	x0, .L64
	b	.L69
	.p2align 2,,3
.L66:
	mov	x2, x23
	mov	x1, x22
	mov	x0, 0
	bl	strtok_r
	cbz	x0, .L69
.L64:
	mov	x1, x20
	mov	x2, 160
	bl	dep_basename
	ldrb	w0, [sp, 160]
	cbz	w0, .L66
	mov	x0, x20
	bl	valid_pkgname
	cbz	w0, .L66
	mov	x1, x20
	mov	x0, x21
	bl	graph_has_package
	cbz	w0, .L168
.L68:
	ldr	x1, [sp, 104]
	mov	x2, x20
	mov	x0, x21
	bl	graph_add_dependency
	b	.L66
	.p2align 2,,3
.L30:
	ldr	x1, [sp, 112]
	mov	x0, x19
	mov	x2, 10
	bl	strncmp
	cbnz	w0, .L32
	add	x21, x26, 1
	b	.L31
	.p2align 2,,3
.L167:
	mov	x0, x19
	mov	w1, 58
	bl	strchr
	mov	x26, x0
	cbnz	x0, .L27
	b	.L28
	.p2align 2,,3
.L32:
	ldr	x1, [sp, 120]
	mov	x0, x19
	mov	x2, 10
	bl	strncmp
	cbz	w0, .L169
	adrp	x1, .LC7
	mov	x0, x19
	add	x1, x1, :lo12:.LC7
	mov	x2, 13
	bl	strncmp
	cbnz	w0, .L34
	add	x22, x26, 1
	b	.L31
	.p2align 2,,3
.L23:
	mov	x0, x19
	bl	free
	b	.L22
	.p2align 2,,3
.L169:
	add	x25, x26, 1
	b	.L31
.L69:
	mov	x0, x24
	bl	free
	.p2align 5,,15
.L62:
	mov	x3, x19
	add	x2, sp, 144
	add	x1, sp, 136
	mov	x0, x21
	mov	x4, 256
	bl	graph_topological_order
	cbz	w0, .L70
	ldr	x0, [sp, 144]
	adrp	x22, .LC20
	mov	x20, 0
	add	x22, x22, :lo12:.LC20
	mov	x19, 0
	cbz	x0, .L72
	.p2align 5,,15
.L71:
	ldr	x1, [sp, 136]
	add	x19, x19, 1
	mov	x0, x21
	ldr	x1, [x1, x20]
	add	x20, x20, 8
	bl	graph_package_name
	mov	x2, x0
	mov	x1, x19
	mov	x0, x22
	bl	printf
	ldr	x0, [sp, 144]
	cmp	x19, x0
	bcc	.L71
.L72:
	ldr	x0, [sp, 136]
	bl	free
	mov	x0, x21
	bl	graph_destroy
.L61:
	ldr	x0, [sp, 128]
	bl	free
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1408
	ret
	.p2align 2,,3
.L84:
	adrp	x22, .LC2
	add	x22, x22, :lo12:.LC2
	b	.L60
	.p2align 2,,3
.L82:
	adrp	x24, .LC2
	add	x24, x24, :lo12:.LC2
	b	.L59
	.p2align 2,,3
.L80:
	adrp	x23, .LC2
	add	x23, x23, :lo12:.LC2
	b	.L58
	.p2align 2,,3
.L77:
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	b	.L57
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
	adrp	x1, .LC10
	mov	x2, 10
	add	x1, x1, :lo12:.LC10
	bl	strncmp
	cmp	w0, 0
	csinc	x24, x24, x26, ne
	b	.L31
	.p2align 2,,3
.L35:
	add	x23, x26, 1
	b	.L31
	.p2align 2,,3
.L75:
	adrp	x21, .LC1
	add	x21, x21, :lo12:.LC1
	b	.L56
	.p2align 2,,3
.L70:
	ldr	x1, [sp, 104]
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	b	.L72
.L168:
	mov	x1, x20
	mov	x0, x21
	adrp	x2, .LC0
	mov	w3, 0
	add	x2, x2, :lo12:.LC0
	bl	graph_add_package
	b	.L68
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
	stp	x19, x20, [sp, 16]
	mov	x20, x2
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	mov	x1, x0
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	cbz	x20, .L175
	adrp	x3, .LC0
	adrp	x22, .LC24
	add	x1, x3, :lo12:.LC0
	add	x22, x22, :lo12:.LC24
	str	x23, [sp, 48]
	adrp	x23, .LC23
	add	x23, x23, :lo12:.LC23
	mov	x19, 0
	.p2align 5,,15
.L171:
	ldr	x2, [x21, x19, lsl 3]
	mov	x0, x23
	add	x19, x19, 1
	bl	printf
	mov	x1, x22
	cmp	x20, x19
	bne	.L171
	adrp	x1, :got:stdout;ldr	x1, [x1, :got_lo12:stdout]
	mov	w0, 10
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ldr	x1, [x1]
	b	putc
	.p2align 2,,3
.L175:
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC2
	ldp	x21, x22, [sp, 32]
	add	x0, x0, :lo12:.LC2
	ldp	x29, x30, [sp], 64
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
	stp	x29, x30, [sp, -416]!
	mov	x29, sp
	stp	x23, x24, [sp, 48]
	add	x24, sp, 160
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	stp	xzr, xzr, [sp, 128]
	stp	xzr, xzr, [sp, 144]
	stp	q31, q31, [x24]
	stp	q31, q31, [x24, 32]
	stp	q31, q31, [x24, 64]
	stp	q31, q31, [x24, 96]
	stp	q31, q31, [x24, 128]
	stp	q31, q31, [x24, 160]
	stp	q31, q31, [x24, 192]
	stp	q31, q31, [x24, 224]
	bl	config_current
	add	x1, sp, 144
	mov	x2, x1
	add	x0, x0, 20
	mov	x3, x24
	mov	x4, 256
	str	x1, [sp, 120]
	mov	x1, x22
	bl	aur_rpc_info
	cbz	w0, .L177
	ldr	x0, [sp, 152]
	cbnz	x0, .L178
.L177:
	ldr	x0, [sp, 120]
	mov	w19, 0
	bl	aur_response_destroy
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 416
	ret
	.p2align 2,,3
.L178:
	bl	graph_create
	mov	x21, x0
	cbz	x0, .L177
	ldr	x0, [sp, 152]
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	cbz	x0, .L180
	adrp	x27, .LC29
	adrp	x0, .LC13
	adrp	x23, .LC0
	add	x0, x0, :lo12:.LC13
	add	x27, x27, :lo12:.LC29
	add	x23, x23, :lo12:.LC0
	mov	x26, 0
	mov	x25, 0
	adrp	x28, .LC16
	str	x0, [sp, 104]
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	str	x0, [sp, 112]
	.p2align 5,,15
.L184:
	ldr	x1, [sp, 144]
	mov	w3, 1
	mov	x0, x21
	add	x25, x25, 1
	add	x19, x1, x26
	ldr	x20, [x1, x26]
	add	x26, x26, 152
	ldr	x2, [x19, 16]
	cmp	x20, 0
	csel	x20, x20, x22, ne
	cmp	x2, 0
	mov	x1, x20
	csel	x2, x23, x2, eq
	bl	graph_add_package
	ldr	x2, [x19, 16]
	mov	x1, x20
	mov	x0, x27
	cmp	x2, 0
	csel	x2, x23, x2, eq
	bl	printf
	ldp	x1, x2, [x19, 72]
	ldr	x0, [sp, 104]
	bl	print_dep_list
	ldp	x1, x2, [x19, 88]
	ldr	x0, [sp, 112]
	bl	print_dep_list
	ldp	x1, x2, [x19, 104]
	add	x0, x28, :lo12:.LC16
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
	ldr	x0, [sp, 152]
	cmp	x0, x25
	bhi	.L184
.L180:
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	mov	x3, x24
	add	x2, sp, 136
	add	x1, sp, 128
	mov	x0, x21
	mov	x4, 256
	bl	graph_topological_order
	mov	w19, w0
	cbz	w0, .L185
	ldr	x0, [sp, 136]
	mov	x27, 0
	adrp	x26, .LC30
	cbz	x0, .L191
	adrp	x25, .LC25
	adrp	x22, .LC0
	adrp	x23, .LC27
	add	x25, x25, :lo12:.LC25
	add	x22, x22, :lo12:.LC0
	add	x23, x23, :lo12:.LC27
	b	.L186
	.p2align 2,,3
.L210:
	ldrb	w1, [x20]
	adrp	x3, .LC26
	add	x3, x3, :lo12:.LC26
	cbnz	w1, .L189
	mov	x20, x22
	mov	x3, x22
.L189:
	cmp	w0, 1
	adrp	x5, .LC28
	add	x5, x5, :lo12:.LC28
	mov	x4, x20
	mov	x2, x19
	csel	x5, x5, x23, ne
	mov	x1, x27
	add	x0, x26, :lo12:.LC30
	bl	printf
	ldr	x0, [sp, 136]
	cmp	x27, x0
	bcs	.L191
.L186:
	ldr	x1, [sp, 128]
	lsl	x28, x27, 3
	mov	x0, x21
	add	x27, x27, 1
	ldr	x1, [x1, x28]
	bl	graph_package_name
	mov	x19, x0
	ldr	x1, [sp, 128]
	mov	x0, x21
	ldr	x1, [x1, x28]
	bl	graph_package_version
	mov	x20, x0
	ldr	x1, [sp, 128]
	mov	x0, x21
	ldr	x1, [x1, x28]
	bl	graph_package_source
	cmp	x19, 0
	csel	x19, x25, x19, eq
	cbnz	x20, .L210
	mov	x3, x22
	mov	x20, x22
	b	.L189
	.p2align 2,,3
.L191:
	mov	w19, 1
.L187:
	ldr	x0, [sp, 128]
	bl	free
	mov	x0, x21
	bl	graph_destroy
	ldr	x0, [sp, 120]
	bl	aur_response_destroy
	mov	w0, w19
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 416
	ret
	.p2align 2,,3
.L185:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x24
	adrp	x1, .LC31
	add	x1, x1, :lo12:.LC31
	ldr	x0, [x0]
	bl	fprintf
	b	.L187
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
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L212
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x19, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	adrp	x1, .LC32
	csel	x2, x2, x19, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC32
	bl	fprintf
.L214:
	ldr	x19, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L212:
	mov	x0, x19
	bl	plan_from_repo
	cbnz	w0, .L217
	mov	x0, x19
	bl	plan_from_aur
	cbz	w0, .L220
.L217:
	ldr	x19, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L220:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC33
	add	x1, x1, :lo12:.LC33
	ldr	x0, [x0]
	bl	fprintf
	b	.L214
	.section	.note.GNU-stack,"",@progbits
