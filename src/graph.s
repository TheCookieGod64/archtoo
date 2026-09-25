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
	mov	x20, x2
	stp	x21, x22, [sp, 32]
	add	x22, x23, x23, lsl 1
	stp	x25, x26, [sp, 64]
	mov	x26, x3
	strb	w1, [x2, x23]
	ldr	x9, [x0]
	add	x7, x9, x22, lsl 4
	ldr	x1, [x7, 32]
	cbz	x1, .L2
	mov	x21, x5
	mov	x25, x6
	mov	x24, x0
	mov	x19, 0
	b	.L10
	.p2align 2,,3
.L22:
	add	x7, x9, x22, lsl 4
	add	x19, x19, 1
	ldr	x2, [x7, 32]
	cmp	x2, x19
	bls	.L2
.L10:
	ldr	x8, [x7, 24]
	ldr	x1, [x8, x19, lsl 3]
	ldrb	w8, [x20, x1]
	cmp	w8, 1
	beq	.L21
	cbnz	w8, .L22
	mov	x6, x25
	mov	x5, x21
	mov	x3, x26
	mov	x2, x20
	mov	x0, x24
	str	x4, [sp, 88]
	bl	visit
	cbz	w0, .L1
	ldr	x9, [x24]
	add	x19, x19, 1
	ldr	x4, [sp, 88]
	add	x7, x9, x22, lsl 4
	ldr	x2, [x7, 32]
	cmp	x2, x19
	bhi	.L10
	.p2align 5,,15
.L2:
	mov	w0, 2
	strb	w0, [x20, x23]
	ldr	x0, [x4]
	add	x1, x0, 1
	str	x1, [x4]
	str	x23, [x26, x0, lsl 3]
	mov	w0, 1
.L1:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 352
	ret
	.p2align 2,,3
.L21:
	cmp	x21, 0
	ccmp	x25, 0, 4, ne
	bne	.L4
	mov	w0, 0
.L23:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 352
	ret
	.p2align 2,,3
.L4:
	add	x1, x1, x1, lsl 1
	adrp	x2, .LC0
	ldr	x3, [x7]
	lsl	x0, x1, 4
	add	x2, x2, :lo12:.LC0
	mov	x1, 256
	ldr	x4, [x9, x0]
	add	x0, sp, 96
	bl	snprintf
	tbz	w0, #31, .L6
	strb	wzr, [sp, 96]
.L6:
	add	x0, sp, 96
	sub	x19, x25, #1
	bl	strlen
	cmp	x25, x0
	csel	x19, x19, x0, ls
	add	x1, sp, 96
	mov	x2, x19
	mov	x0, x21
	bl	memcpy
	mov	w0, 0
	strb	wzr, [x21, x19]
	b	.L23
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
	cbz	x0, .L25
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	ldr	x0, [x0, 8]
	cbz	x0, .L27
	mov	x19, 0
	str	x21, [sp, 32]
	mov	x21, 0
	.p2align 5,,15
.L28:
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
	bhi	.L28
	ldr	x21, [sp, 32]
.L27:
	ldr	x0, [x20]
	bl	free
	mov	x0, x20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	b	free
	.p2align 2,,3
.L25:
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
	beq	.L73
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	ldrb	w0, [x1]
	cbnz	w0, .L38
.L37:
	mov	w4, 0
.L36:
	ldp	x21, x22, [sp, 32]
	mov	w0, w4
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L38:
	stp	x19, x20, [sp, 16]
	stp	x23, x24, [sp, 48]
	mov	x23, x2
	mov	w24, w3
	stp	x25, x26, [sp, 64]
	mov	x25, x1
	ldp	x26, x21, [x22]
	cbz	x21, .L40
	mov	x20, x26
	mov	x19, 0
	b	.L42
	.p2align 2,,3
.L79:
	add	x19, x19, 1
	add	x20, x20, 48
	cmp	x21, x19
	beq	.L78
.L42:
	ldr	x0, [x20]
	mov	x1, x25
	bl	strcmp
	mov	w4, w0
	cbnz	w0, .L79
	cbz	x23, .L80
	mov	x0, x23
	str	w4, [sp, 92]
	bl	strlen
	add	x0, x0, 1
	ldr	w4, [sp, 92]
.L52:
	str	w4, [sp, 92]
	bl	malloc
	ldr	w4, [sp, 92]
	mov	x20, x0
	cbz	x0, .L76
	add	x19, x19, x19, lsl 1
	mov	x1, x23
	bl	strcpy
	add	x0, x26, x19, lsl 4
	ldr	x0, [x0, 8]
	bl	free
	ldr	x0, [x22]
	add	x19, x0, x19, lsl 4
	str	x20, [x19, 8]
	str	w24, [x19, 16]
.L50:
	ldp	x19, x20, [sp, 16]
	mov	w4, 1
	ldp	x23, x24, [sp, 48]
	mov	w0, w4
	ldp	x25, x26, [sp, 64]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L73:
	mov	w4, 0
	mov	w0, w4
	ret
	.p2align 2,,3
.L78:
	ldr	x0, [x22, 16]
	cmp	x21, x0
	beq	.L81
.L45:
	mov	x0, x25
	bl	strlen
	add	x20, x0, 1
	mov	x0, x20
	bl	malloc
	mov	x19, x0
	cbz	x0, .L46
	mov	x2, x20
	mov	x1, x25
	bl	memcpy
.L46:
	cbz	x23, .L55
	mov	x0, x23
	bl	strlen
	add	x0, x0, 1
.L47:
	bl	malloc
	mov	x20, x0
	cbz	x0, .L48
	mov	x1, x23
	bl	strcpy
	cbz	x19, .L48
	ldp	x2, x0, [x22]
	add	x1, x0, x0, lsl 1
	add	x0, x0, 1
	lsl	x3, x1, 4
	add	x1, x2, x1, lsl 4
	stp	xzr, xzr, [x1, 16]
	stp	xzr, xzr, [x1, 32]
	str	x19, [x2, x3]
	str	x20, [x1, 8]
	str	w24, [x1, 16]
	str	x0, [x22, 8]
	b	.L50
	.p2align 2,,3
.L55:
	adrp	x23, .LC1
	mov	x0, 1
	add	x23, x23, :lo12:.LC1
	b	.L47
	.p2align 2,,3
.L80:
	adrp	x23, .LC1
	mov	x0, 1
	add	x23, x23, :lo12:.LC1
	b	.L52
	.p2align 2,,3
.L81:
	lsl	x19, x21, 1
	add	x21, x21, x21, lsl 1
	lsl	x1, x21, 5
.L44:
	mov	x0, x26
	bl	realloc
	cbz	x0, .L77
	str	x0, [x22]
	str	x19, [x22, 16]
	b	.L45
	.p2align 2,,3
.L48:
	mov	x0, x19
	bl	free
	mov	x0, x20
	bl	free
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L37
.L40:
	ldr	x0, [x22, 16]
	cbnz	x0, .L45
	mov	x1, 768
	mov	x19, 16
	b	.L44
.L76:
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L36
.L77:
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L37
	.align	2
	.p2align 5,,15
	.global	graph_add_dependency
	.type	graph_add_dependency, %function
graph_add_dependency:
	cbz	x0, .L128
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, x1
	stp	x23, x24, [sp, 48]
	mov	x23, x2
	cbz	x1, .L84
	ldr	x21, [x0, 8]
	cbz	x21, .L83
	ldr	x24, [x0]
	mov	x19, 0
	mov	x20, x24
	b	.L88
	.p2align 2,,3
.L132:
	add	x19, x19, 1
	add	x20, x20, 48
	cmp	x21, x19
	beq	.L131
.L88:
	ldr	x0, [x20]
	mov	x1, x22
	bl	strcmp
	cbnz	w0, .L132
	mov	x22, x21
	cbz	x23, .L83
.L99:
	mov	x21, x24
	mov	x20, 0
	b	.L90
	.p2align 2,,3
.L133:
	add	x20, x20, 1
	add	x21, x21, 48
	cmp	x22, x20
	beq	.L83
.L90:
	ldr	x0, [x21]
	mov	x1, x23
	bl	strcmp
	mov	w3, w0
	cbnz	w0, .L133
	cmn	x19, #1
	beq	.L82
	add	x19, x19, x19, lsl 1
	add	x19, x24, x19, lsl 4
	ldp	x0, x4, [x19, 24]
	cbz	x4, .L92
	mov	x1, 0
	b	.L94
	.p2align 2,,3
.L93:
	add	x1, x1, 1
	cmp	x1, x4
	beq	.L134
.L94:
	ldr	x2, [x0, x1, lsl 3]
	cmp	x2, x20
	bne	.L93
	mov	w3, 1
.L136:
	ldp	x19, x20, [sp, 16]
	mov	w0, w3
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L83:
	mov	w3, 0
.L82:
	ldp	x19, x20, [sp, 16]
	mov	w0, w3
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L128:
	mov	w3, 0
	mov	w0, w3
	ret
	.p2align 2,,3
.L131:
	mov	x22, x21
	mov	x19, -1
	cbnz	x23, .L99
	b	.L83
	.p2align 2,,3
.L134:
	ldr	x2, [x19, 40]
	cmp	x2, x1
	beq	.L135
.L98:
	add	x1, x4, 1
	str	x1, [x19, 32]
	mov	w3, 1
	str	x20, [x0, x4, lsl 3]
	b	.L136
	.p2align 2,,3
.L84:
	cbz	x2, .L83
	ldr	x22, [x0, 8]
	cbz	x22, .L83
	ldr	x24, [x0]
	mov	x19, -1
	b	.L99
	.p2align 2,,3
.L135:
	lsl	x21, x1, 1
	lsl	x1, x1, 4
.L97:
	str	w3, [sp, 76]
	bl	realloc
	ldr	w3, [sp, 76]
	cbz	x0, .L82
	ldr	x4, [x19, 32]
	str	x0, [x19, 24]
	str	x21, [x19, 40]
	b	.L98
.L92:
	ldr	x1, [x19, 40]
	cbnz	x1, .L98
	mov	x1, 64
	mov	x21, 8
	b	.L97
	.align	2
	.p2align 5,,15
	.global	graph_has_package
	.type	graph_has_package, %function
graph_has_package:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	beq	.L145
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	ldr	x22, [x0, 8]
	cbz	x22, .L138
	stp	x19, x20, [sp, 16]
	mov	x21, x1
	mov	x20, 0
	ldr	x19, [x0]
	b	.L141
	.p2align 2,,3
.L149:
	add	x20, x20, 1
	add	x19, x19, 48
	cmp	x22, x20
	beq	.L148
.L141:
	ldr	x0, [x19]
	mov	x1, x21
	bl	strcmp
	cbnz	w0, .L149
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L148:
	ldp	x19, x20, [sp, 16]
.L138:
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L145:
	mov	w0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_count
	.type	graph_package_count, %function
graph_package_count:
	cbz	x0, .L150
	ldr	x0, [x0, 8]
.L150:
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_name
	.type	graph_package_name, %function
graph_package_name:
	cbz	x0, .L155
	ldr	x3, [x0, 8]
	mov	x2, 0
	cmp	x3, x1
	bls	.L153
	add	x1, x1, x1, lsl 1
	ldr	x0, [x0]
	lsl	x1, x1, 4
	ldr	x2, [x0, x1]
.L153:
	mov	x0, x2
	ret
	.p2align 2,,3
.L155:
	mov	x2, 0
	mov	x0, x2
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_version
	.type	graph_package_version, %function
graph_package_version:
	cbz	x0, .L159
	ldr	x3, [x0, 8]
	mov	x2, 0
	cmp	x3, x1
	bls	.L157
	ldr	x0, [x0]
	add	x1, x1, x1, lsl 1
	add	x1, x0, x1, lsl 4
	ldr	x2, [x1, 8]
.L157:
	mov	x0, x2
	ret
	.p2align 2,,3
.L159:
	mov	x2, 0
	mov	x0, x2
	ret
	.align	2
	.p2align 5,,15
	.global	graph_package_source
	.type	graph_package_source, %function
graph_package_source:
	cbz	x0, .L164
	ldr	x2, [x0, 8]
	cmp	x2, x1
	bls	.L164
	ldr	x0, [x0]
	add	x1, x1, x1, lsl 1
	add	x1, x0, x1, lsl 4
	ldr	w0, [x1, 16]
	ret
	.p2align 2,,3
.L164:
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
	bne	.L177
.L166:
	mov	w7, 0
	mov	w0, w7
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L177:
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	mov	x22, x2
	stp	x19, x20, [sp, 16]
	mov	x1, 1
	mov	x20, x0
	stp	x23, x24, [sp, 48]
	mov	x24, x4
	mov	x23, x3
	stp	x25, x26, [sp, 64]
	str	xzr, [x21]
	str	xzr, [x2]
	ldr	x19, [x0, 8]
	cmp	x19, 0
	csel	x0, x19, x1, ne
	bl	calloc
	cmp	x0, 0
	cset	w1, eq
	str	w1, [sp, 92]
	mov	x26, x0
	cbz	x19, .L167
	lsl	x0, x19, 3
	bl	malloc
	ldr	w1, [sp, 92]
	cmp	x0, 0
	mov	x25, x0
	mov	x19, 0
	ccmp	w1, 0, 0, ne
	beq	.L168
	b	.L171
	.p2align 2,,3
.L170:
	ldr	x7, [x20, 8]
	add	x19, x19, 1
	cmp	x7, x19
	bls	.L178
.L168:
	ldrb	w7, [x26, x19]
	cbnz	w7, .L170
	mov	x6, x24
	mov	x5, x23
	add	x4, sp, 104
	mov	x3, x25
	mov	x2, x26
	mov	x1, x19
	mov	x0, x20
	bl	visit
	mov	w7, w0
	cbnz	w0, .L170
	mov	x0, x26
	str	w7, [sp, 92]
	bl	free
	mov	x0, x25
	bl	free
	ldr	w7, [sp, 92]
	ldp	x19, x20, [sp, 16]
	mov	w0, w7
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L178:
	ldr	x19, [sp, 104]
.L172:
	mov	x0, x26
	bl	free
	str	x25, [x21]
	str	x19, [x22]
	mov	w7, 1
	mov	w0, w7
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L167:
	mov	x0, 8
	bl	malloc
	ldr	w1, [sp, 92]
	cmp	x0, 0
	mov	x25, x0
	ccmp	w1, 0, 0, ne
	beq	.L172
.L171:
	mov	x0, x26
	bl	free
	mov	x0, x25
	bl	free
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L166
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
