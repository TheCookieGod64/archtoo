	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"dependency cycle detected: %s -> %s"
	.text
	.align	2
	.p2align 5,,15
	.type	visit, %function
visit:
	stp	x29, x30, [sp, -352]!
	mov	x29, sp
	stp	x23, x24, [sp, 48]
	mov	x23, x1
	mov	w1, 1
	stp	x19, x20, [sp, 16]
	mov	x24, x0
	mov	x20, x2
	stp	x21, x22, [sp, 32]
	add	x21, x23, x23, lsl 1
	stp	x25, x26, [sp, 64]
	mov	x25, x4
	str	x27, [sp, 80]
	mov	x27, x3
	strb	w1, [x2, x23]
	ldr	x9, [x0]
	add	x7, x9, x21, lsl 4
	ldr	x0, [x7, 32]
	cbz	x0, .L2
	mov	x22, x5
	mov	x26, x6
	lsl	x21, x21, 4
	mov	x19, 0
	b	.L10
	.p2align 2,,3
.L23:
	add	x7, x9, x21
	add	x19, x19, 1
	ldr	x2, [x7, 32]
	cmp	x2, x19
	bls	.L2
.L10:
	ldr	x8, [x7, 24]
	ldr	x1, [x8, x19, lsl 3]
	ldrb	w8, [x20, x1]
	cmp	w8, 1
	beq	.L22
	cbnz	w8, .L23
	mov	x6, x26
	mov	x5, x22
	mov	x4, x25
	mov	x3, x27
	mov	x2, x20
	mov	x0, x24
	bl	visit
	cbz	w0, .L8
	ldr	x9, [x24]
	add	x19, x19, 1
	add	x7, x9, x21
	ldr	x2, [x7, 32]
	cmp	x2, x19
	bhi	.L10
.L2:
	mov	w0, 2
	strb	w0, [x20, x23]
	mov	w0, 1
	ldr	x1, [x25]
	add	x2, x1, 1
	str	x2, [x25]
	str	x23, [x27, x1, lsl 3]
	ldr	x27, [sp, 80]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 352
	ret
	.p2align 2,,3
.L22:
	cmp	x22, 0
	ccmp	x26, 0, 4, ne
	bne	.L4
.L8:
	mov	w0, 0
.L24:
	ldr	x27, [sp, 80]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 352
	ret
	.p2align 2,,3
.L4:
	add	x1, x1, x1, lsl 1
	add	x20, sp, 96
	ldr	x3, [x7]
	lsl	x4, x1, 4
	adrp	x2, .LC0
	mov	x0, x20
	add	x2, x2, :lo12:.LC0
	mov	x1, 256
	ldr	x4, [x9, x4]
	bl	snprintf
	tbz	w0, #31, .L6
	strb	wzr, [sp, 96]
.L6:
	mov	x0, x20
	bl	strlen
	sub	x2, x26, #1
	cmp	x26, x0
	mov	x19, x0
	mov	x1, x20
	csel	x19, x2, x19, ls
	mov	x0, x22
	mov	x2, x19
	bl	memcpy
	mov	w0, 0
	strb	wzr, [x22, x19]
	b	.L24
	.align	2
	.p2align 5,,15
	.global	graph_create
	.type	graph_create, %function
graph_create:
	mov	x1, 24
	mov	x0, 1
	b	calloc
	.align	2
	.p2align 5,,15
	.global	graph_destroy
	.type	graph_destroy, %function
graph_destroy:
	cbz	x0, .L26
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	ldr	x0, [x0, 8]
	cbz	x0, .L28
	mov	x19, 0
	str	x21, [sp, 32]
	mov	x21, 0
	.p2align 5,,15
.L29:
	ldr	x0, [x20]
	add	x21, x21, 1
	ldr	x0, [x0, x19]
	bl	free
	ldr	x0, [x20]
	add	x0, x0, x19
	ldr	x0, [x0, 8]
	bl	free
	ldr	x0, [x20]
	add	x0, x0, x19
	add	x19, x19, 48
	ldr	x0, [x0, 24]
	bl	free
	ldr	x0, [x20, 8]
	cmp	x0, x21
	bhi	.L29
	ldr	x21, [sp, 32]
.L28:
	ldr	x0, [x20]
	bl	free
	mov	x0, x20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	b	free
	.p2align 2,,3
.L26:
	ret
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	""
	.text
	.align	2
	.p2align 5,,15
	.global	graph_add_package
	.type	graph_add_package, %function
graph_add_package:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	beq	.L78
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x1
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	ldrb	w0, [x1]
	cbnz	w0, .L83
.L39:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L83:
	stp	x23, x24, [sp, 48]
	mov	x24, x2
	stp	x25, x26, [sp, 64]
	mov	w25, w3
	ldp	x26, x23, [x22]
	cbz	x23, .L41
	mov	x21, x26
	mov	x19, 0
	b	.L43
	.p2align 2,,3
.L85:
	add	x19, x19, 1
	add	x21, x21, 48
	cmp	x23, x19
	beq	.L84
.L43:
	ldr	x0, [x21]
	mov	x1, x20
	bl	strcmp
	cbnz	w0, .L85
	cbz	x24, .L86
	mov	x0, x24
	bl	strlen
	add	x0, x0, 1
.L53:
	bl	malloc
	mov	x20, x0
	cbz	x0, .L82
	add	x19, x19, x19, lsl 1
	mov	x1, x24
	bl	strcpy
	add	x26, x26, x19, lsl 4
	lsl	x19, x19, 4
	ldr	x0, [x26, 8]
	bl	free
	ldr	x1, [x22]
	add	x1, x1, x19
	str	x20, [x1, 8]
	str	w25, [x1, 16]
.L45:
	ldp	x23, x24, [sp, 48]
	mov	w0, 1
	ldp	x25, x26, [sp, 64]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L78:
	mov	w0, 0
	ret
	.p2align 2,,3
.L84:
	ldr	x0, [x22, 16]
	cmp	x0, x23
	beq	.L87
.L47:
	mov	x0, x20
	bl	strlen
	add	x21, x0, 1
	mov	x0, x21
	bl	malloc
	mov	x19, x0
	cbz	x0, .L48
	mov	x2, x21
	mov	x1, x20
	bl	memcpy
.L48:
	cbz	x24, .L57
	mov	x0, x24
	bl	strlen
	add	x0, x0, 1
.L49:
	bl	malloc
	mov	x20, x0
	cbz	x0, .L52
	mov	x1, x24
	bl	strcpy
	cbz	x19, .L52
	ldp	x2, x1, [x22]
	add	x3, x1, 1
	add	x1, x1, x1, lsl 1
	add	x0, x2, x1, lsl 4
	lsl	x1, x1, 4
	stp	xzr, xzr, [x0, 16]
	stp	xzr, xzr, [x0, 32]
	str	x19, [x2, x1]
	str	x20, [x0, 8]
	str	w25, [x0, 16]
	str	x3, [x22, 8]
	b	.L45
	.p2align 2,,3
.L57:
	adrp	x2, .LC1
	mov	x0, 1
	add	x24, x2, :lo12:.LC1
	b	.L49
	.p2align 2,,3
.L86:
	adrp	x2, .LC1
	mov	x0, 1
	add	x24, x2, :lo12:.LC1
	b	.L53
	.p2align 2,,3
.L87:
	add	x1, x23, x23, lsl 1
	lsl	x23, x23, 1
	lsl	x1, x1, 5
.L46:
	mov	x0, x26
	bl	realloc
	cbz	x0, .L82
	str	x0, [x22]
	str	x23, [x22, 16]
	b	.L47
	.p2align 2,,3
.L52:
	mov	x0, x19
	bl	free
	mov	x0, x20
	bl	free
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L39
.L41:
	ldr	x0, [x22, 16]
	cbnz	x0, .L47
	mov	x1, 768
	mov	x23, 16
	b	.L46
.L82:
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L39
	.align	2
	.p2align 5,,15
	.global	graph_add_dependency
	.type	graph_add_dependency, %function
graph_add_dependency:
	cbz	x0, .L133
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, x1
	stp	x23, x24, [sp, 48]
	mov	x23, x2
	cbz	x1, .L91
	ldp	x24, x21, [x0]
	cbz	x21, .L92
	mov	x20, x24
	mov	x19, 0
	b	.L94
	.p2align 2,,3
.L135:
	add	x19, x19, 1
	add	x20, x20, 48
	cmp	x21, x19
	beq	.L134
.L94:
	ldr	x0, [x20]
	mov	x1, x22
	bl	strcmp
	cbnz	w0, .L135
	mov	x22, x21
	cbz	x23, .L92
.L102:
	mov	x21, x24
	mov	x20, 0
	b	.L96
	.p2align 2,,3
.L136:
	add	x20, x20, 1
	add	x21, x21, 48
	cmp	x22, x20
	beq	.L92
.L96:
	ldr	x0, [x21]
	mov	x1, x23
	bl	strcmp
	cbnz	w0, .L136
	cmn	x19, #1
	beq	.L92
	add	x19, x19, x19, lsl 1
	add	x19, x24, x19, lsl 4
	ldp	x0, x3, [x19, 24]
	cbz	x3, .L97
	mov	x1, 0
	b	.L99
	.p2align 2,,3
.L138:
	cmp	x1, x3
	beq	.L137
.L99:
	ldr	x2, [x0, x1, lsl 3]
	add	x1, x1, 1
	cmp	x2, x20
	bne	.L138
.L98:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L92:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L134:
	mov	x22, x21
	mov	x19, -1
	cbnz	x23, .L102
	b	.L92
	.p2align 2,,3
.L137:
	ldr	x2, [x19, 40]
	cmp	x2, x1
	beq	.L139
.L100:
	add	x1, x3, 1
	str	x1, [x19, 32]
	str	x20, [x0, x3, lsl 3]
	b	.L98
	.p2align 2,,3
.L133:
	mov	w0, 0
	ret
	.p2align 2,,3
.L91:
	cbz	x2, .L92
	ldp	x24, x22, [x0]
	cbz	x22, .L92
	mov	x19, -1
	b	.L102
	.p2align 2,,3
.L139:
	lsl	x21, x1, 1
	lsl	x1, x1, 4
.L101:
	bl	realloc
	cbz	x0, .L92
	ldr	x3, [x19, 32]
	str	x0, [x19, 24]
	str	x21, [x19, 40]
	b	.L100
.L97:
	ldr	x1, [x19, 40]
	cbnz	x1, .L100
	mov	x1, 64
	mov	x21, 8
	b	.L101
	.align	2
	.p2align 5,,15
	.global	graph_has_package
	.type	graph_has_package, %function
graph_has_package:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	beq	.L143
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	ldp	x19, x22, [x0]
	cbz	x22, .L144
	mov	x21, x1
	mov	x20, 0
	b	.L142
	.p2align 2,,3
.L151:
	add	x19, x19, 48
	cmp	x22, x20
	beq	.L144
.L142:
	ldr	x0, [x19]
	mov	x1, x21
	add	x20, x20, 1
	bl	strcmp
	cbnz	w0, .L151
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L144:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L143:
	mov	w0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_count
	.type	graph_package_count, %function
graph_package_count:
	cbz	x0, .L154
	ldr	x0, [x0, 8]
	ret
	.p2align 2,,3
.L154:
	mov	x0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_name
	.type	graph_package_name, %function
graph_package_name:
	mov	x2, x0
	cbz	x0, .L157
	ldr	x3, [x2, 8]
	mov	x0, 0
	cmp	x3, x1
	bls	.L155
	add	x1, x1, x1, lsl 1
	ldr	x0, [x2]
	lsl	x1, x1, 4
	ldr	x0, [x0, x1]
.L155:
	ret
	.p2align 2,,3
.L157:
	mov	x0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_version
	.type	graph_package_version, %function
graph_package_version:
	mov	x2, x0
	cbz	x0, .L161
	ldr	x3, [x2, 8]
	mov	x0, 0
	cmp	x3, x1
	bls	.L159
	ldr	x0, [x2]
	add	x1, x1, x1, lsl 1
	add	x1, x0, x1, lsl 4
	ldr	x0, [x1, 8]
.L159:
	ret
	.p2align 2,,3
.L161:
	mov	x0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_source
	.type	graph_package_source, %function
graph_package_source:
	mov	x2, x0
	cbz	x0, .L165
	ldr	x3, [x2, 8]
	mov	w0, 2
	cmp	x3, x1
	bls	.L163
	ldr	x0, [x2]
	add	x1, x1, x1, lsl 1
	add	x1, x0, x1, lsl 4
	ldr	w0, [x1, 16]
.L163:
	ret
	.p2align 2,,3
.L165:
	mov	w0, 2
	ret
	.align	2
	.p2align 5,,15
	.global	graph_topological_order
	.type	graph_topological_order, %function
graph_topological_order:
	stp	x29, x30, [sp, -112]!
	cmp	x1, 0
	ccmp	x2, 0, 4, ne
	mov	x29, sp
	ccmp	x0, 0, 4, ne
	str	xzr, [sp, 104]
	bne	.L180
.L168:
	mov	w0, 0
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L180:
	stp	x23, x24, [sp, 48]
	mov	x23, x1
	mov	x24, x2
	stp	x19, x20, [sp, 16]
	mov	x1, 1
	mov	x20, x0
	stp	x21, x22, [sp, 32]
	mov	x21, x3
	mov	x22, x4
	stp	x25, x26, [sp, 64]
	stp	x27, x28, [sp, 80]
	str	xzr, [x23]
	str	xzr, [x2]
	ldr	x19, [x0, 8]
	cmp	x19, 0
	csel	x0, x19, x1, ne
	bl	calloc
	cmp	x0, 0
	mov	x27, x0
	cset	w28, eq
	cbz	x19, .L169
	lsl	x0, x19, 3
	bl	malloc
	cmp	x0, 0
	add	x26, sp, 104
	mov	x25, x0
	ccmp	w28, 0, 0, ne
	mov	x19, 0
	beq	.L170
	b	.L173
	.p2align 2,,3
.L172:
	ldr	x7, [x20, 8]
	add	x19, x19, 1
	cmp	x7, x19
	bls	.L181
.L170:
	ldrb	w7, [x27, x19]
	cbnz	w7, .L172
	mov	x6, x22
	mov	x5, x21
	mov	x4, x26
	mov	x3, x25
	mov	x2, x27
	mov	x1, x19
	mov	x0, x20
	bl	visit
	cbz	w0, .L173
	ldr	x7, [x20, 8]
	add	x19, x19, 1
	cmp	x7, x19
	bhi	.L170
.L181:
	ldr	x19, [sp, 104]
.L174:
	mov	x0, x27
	bl	free
	str	x25, [x23]
	str	x19, [x24]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L169:
	mov	x0, 8
	bl	malloc
	cmp	x0, 0
	mov	x25, x0
	ccmp	w28, 0, 0, ne
	beq	.L174
.L173:
	mov	x0, x27
	bl	free
	mov	x0, x25
	bl	free
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L168
	.section	.note.GNU-stack,"",@progbits
