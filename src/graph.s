	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"dependency cycle detected: %s -> %s\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	visit, %function
visit:
	@ args = 12, pretend = 0, frame = 256
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r6, #24
	mov	fp, r3
	sub	sp, sp, #276
	movs	r3, #1
	strb	r3, [r2, r1]
	mul	r6, r6, r1
	mov	r5, r2
	mov	r7, r0
	ldr	r2, [r0]
	mov	r10, r1
	ldr	r8, [sp, #312]
	adds	r0, r2, r6
	ldr	r9, [sp, #316]
	ldr	r3, [r0, #16]
	cbz	r3, .L2
	movs	r4, #0
	b	.L10
.L23:
	adds	r0, r2, r6
	adds	r4, r4, #1
	ldr	r3, [r0, #16]
	cmp	r3, r4
	bls	.L2
.L10:
	ldr	r3, [r0, #12]
	ldr	r1, [r3, r4, lsl #2]
	ldrb	r3, [r5, r1]	@ zero_extendqisi2
	cmp	r3, #1
	beq	.L22
	cmp	r3, #0
	bne	.L23
	ldr	r3, [sp, #320]
	mov	r2, r5
	strd	r9, r3, [sp, #4]
	mov	r0, r7
	mov	r3, fp
	str	r8, [sp]
	bl	visit(PLT)
	cbz	r0, .L8
	ldr	r2, [r7]
	adds	r4, r4, #1
	adds	r0, r2, r6
	ldr	r3, [r0, #16]
	cmp	r3, r4
	bhi	.L10
.L2:
	movs	r3, #2
	strb	r3, [r5, r10]
	movs	r0, #1
	ldr	r3, [r8]
	adds	r2, r3, #1
	str	r2, [r8]
	str	r10, [fp, r3, lsl #2]
	add	sp, sp, #276
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L22:
	ldr	r3, [sp, #320]
	cmp	r9, #0
	it	ne
	cmpne	r3, #0
	bne	.L4
.L8:
	movs	r0, #0
	add	sp, sp, #276
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L4:
	ldr	r3, [r0]
	movs	r0, #24
	add	r5, sp, #16
	mul	r1, r0, r1
	mov	r0, r5
	ldr	r1, [r2, r1]
	ldr	r2, .L24
	str	r1, [sp]
	mov	r1, #256
.LPIC0:
	add	r2, pc
	bl	snprintf(PLT)
	cmp	r0, #0
	mov	r0, r5
	itt	lt
	movlt	r3, #0
	strblt	r3, [r5]
	bl	strlen(PLT)
	ldr	r3, [sp, #320]
	mov	r4, r0
	mov	r1, r5
	cmp	r3, r0
	mov	r0, r9
	it	ls
	addls	r4, r3, #-1
	mov	r2, r4
	bl	memcpy(PLT)
	movs	r3, #0
	strb	r3, [r9, r4]
	b	.L8
.L25:
	.align	2
.L24:
	.word	.LC0-(.LPIC0+4)
	.align	1
	.p2align 2,,3
	.global	graph_create
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_create, %function
graph_create:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r1, #12
	movs	r0, #1
	b	calloc(PLT)
	.align	1
	.p2align 2,,3
	.global	graph_destroy
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_destroy, %function
graph_destroy:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L27
	ldr	r3, [r0, #4]
	push	{r4, r5, r6, lr}
	mov	r5, r0
	cbz	r3, .L29
	movs	r4, #0
	mov	r6, r4
.L30:
	ldr	r3, [r5]
	adds	r6, r6, #1
	ldr	r0, [r3, r4]
	bl	free(PLT)
	ldr	r3, [r5]
	add	r3, r3, r4
	ldr	r0, [r3, #4]
	bl	free(PLT)
	ldr	r3, [r5]
	add	r3, r3, r4
	adds	r4, r4, #24
	ldr	r0, [r3, #12]
	bl	free(PLT)
	ldr	r3, [r5, #4]
	cmp	r3, r6
	bhi	.L30
.L29:
	ldr	r0, [r5]
	bl	free(PLT)
	mov	r0, r5
	pop	{r4, r5, r6, lr}
	b	free(PLT)
.L27:
	bx	lr
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"\000"
	.text
	.align	1
	.p2align 2,,3
	.global	graph_add_package
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_add_package, %function
graph_add_package:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ite	eq
	moveq	r5, #1
	movne	r5, #0
	beq	.L40
	mov	r9, r3
	ldrb	r3, [r1]	@ zero_extendqisi2
	mov	r4, r1
	cbnz	r3, .L79
.L40:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L79:
	ldrd	fp, r10, [r0]
	mov	r7, r0
	mov	r8, r2
	cmp	r10, #0
	beq	.L42
	mov	r6, fp
	b	.L44
.L81:
	adds	r5, r5, #1
	adds	r6, r6, #24
	cmp	r10, r5
	beq	.L80
.L44:
	ldr	r0, [r6]
	mov	r1, r4
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L81
	cmp	r8, #0
	beq	.L82
	mov	r0, r8
	bl	strlen(PLT)
	adds	r0, r0, #1
.L54:
	bl	malloc(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L40
	mov	r1, r8
	bl	strcpy(PLT)
	movs	r3, #24
	mul	r5, r3, r5
	add	fp, fp, r5
	ldr	r0, [fp, #4]
	bl	free(PLT)
	ldr	r3, [r7]
	add	r3, r3, r5
	strd	r4, r9, [r3, #4]
.L46:
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L80:
	ldr	r3, [r7, #8]
	cmp	r3, r10
	beq	.L83
.L48:
	mov	r0, r4
	bl	strlen(PLT)
	adds	r6, r0, #1
	mov	r0, r6
	bl	malloc(PLT)
	mov	r5, r0
	cbz	r0, .L49
	mov	r2, r6
	mov	r1, r4
	bl	memcpy(PLT)
.L49:
	cmp	r8, #0
	beq	.L58
	mov	r0, r8
	bl	strlen(PLT)
	adds	r0, r0, #1
.L50:
	bl	malloc(PLT)
	mov	r4, r0
	cbz	r0, .L53
	mov	r1, r8
	bl	strcpy(PLT)
	cbz	r5, .L53
	ldr	r3, [r7, #4]
	movs	r1, #24
	vmov.i32	q8, #0  @ v16qi
	ldr	r0, [r7]
	mul	r1, r3, r1
	adds	r3, r3, #1
	adds	r2, r0, r1
	vst1.8	{q8}, [r2]
	vstr	d16, [r2, #16]
	str	r5, [r0, r1]
	strd	r4, r9, [r2, #4]
	str	r3, [r7, #4]
	b	.L46
.L58:
	ldr	r8, .L84
	movs	r0, #1
.LPIC2:
	add	r8, pc
	b	.L50
.L82:
	ldr	r8, .L84+4
	movs	r0, #1
.LPIC1:
	add	r8, pc
	b	.L54
.L83:
	movs	r1, #48
	lsl	r5, r10, #1
	mul	r1, r1, r10
.L47:
	mov	r0, fp
	bl	realloc(PLT)
	cmp	r0, #0
	beq	.L40
	str	r0, [r7]
	str	r5, [r7, #8]
	b	.L48
.L53:
	mov	r0, r5
	bl	free(PLT)
	mov	r0, r4
	bl	free(PLT)
	b	.L40
.L42:
	ldr	r3, [r0, #8]
	mov	r1, #384
	movs	r5, #16
	cmp	r3, #0
	beq	.L47
	b	.L48
.L85:
	.align	2
.L84:
	.word	.LC1-(.LPIC2+4)
	.word	.LC1-(.LPIC1+4)
	.align	1
	.p2align 2,,3
	.global	graph_add_dependency
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_add_dependency, %function
graph_add_dependency:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	beq	.L131
	push	{r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r6, r1
	mov	r7, r2
	cmp	r1, #0
	beq	.L89
	ldrd	r9, r8, [r0]
	cmp	r8, #0
	beq	.L90
	mov	r4, r9
	movs	r5, #0
	b	.L92
.L133:
	adds	r5, r5, #1
	adds	r4, r4, #24
	cmp	r8, r5
	beq	.L132
.L92:
	ldr	r0, [r4]
	mov	r1, r6
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L133
	cbz	r7, .L90
.L100:
	mov	r6, r9
	movs	r4, #0
	b	.L94
.L134:
	adds	r4, r4, #1
	adds	r6, r6, #24
	cmp	r8, r4
	beq	.L90
.L94:
	ldr	r0, [r6]
	mov	r1, r7
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L134
	adds	r3, r5, #1
	beq	.L90
	movs	r3, #24
	mla	r5, r3, r5, r9
	ldrd	r6, r1, [r5, #12]
	cbz	r1, .L95
	subs	r3, r6, #4
	b	.L97
.L136:
	cmp	r0, r1
	beq	.L135
.L97:
	ldr	r2, [r3, #4]!
	adds	r0, r0, #1
	cmp	r2, r4
	bne	.L136
.L96:
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L90:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L132:
	mov	r5, #-1
	cmp	r7, #0
	bne	.L100
	b	.L90
.L135:
	ldr	r3, [r5, #20]
	cmp	r3, r0
	itt	eq
	lsleq	r7, r0, #1
	lsleq	r1, r0, #3
	beq	.L99
.L98:
	adds	r3, r1, #1
	str	r3, [r5, #16]
	str	r4, [r6, r1, lsl #2]
	b	.L96
.L95:
	ldr	r3, [r5, #20]
	cmp	r3, #0
	bne	.L98
	movs	r1, #32
	movs	r7, #8
.L99:
	mov	r0, r6
	bl	realloc(PLT)
	mov	r6, r0
	cmp	r0, #0
	beq	.L90
	ldr	r1, [r5, #16]
	str	r0, [r5, #12]
	str	r7, [r5, #20]
	b	.L98
.L131:
	movs	r0, #0
	bx	lr
.L89:
	cmp	r2, #0
	beq	.L90
	ldrd	r9, r8, [r0]
	cmp	r8, #0
	beq	.L90
	mov	r5, #-1
	b	.L100
	.align	1
	.p2align 2,,3
	.global	graph_has_package
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_has_package, %function
graph_has_package:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	push	{r3, r4, r5, r6, r7, lr}
	ite	eq
	moveq	r4, #1
	movne	r4, #0
	beq	.L140
	ldrd	r5, r7, [r0]
	mov	r6, r1
	cbnz	r7, .L139
	b	.L140
.L145:
	adds	r5, r5, #24
	cmp	r7, r4
	beq	.L140
.L139:
	ldr	r0, [r5]
	mov	r1, r6
	adds	r4, r4, #1
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L145
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, pc}
.L140:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, pc}
	.align	1
	.p2align 2,,3
	.global	graph_package_count
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_package_count, %function
graph_package_count:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L146
	ldr	r0, [r0, #4]
.L146:
	bx	lr
	.align	1
	.p2align 2,,3
	.global	graph_package_name
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_package_name, %function
graph_package_name:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L149
	ldr	r3, [r0, #4]
	cmp	r3, r1
	bls	.L152
	movs	r2, #24
	ldr	r3, [r0]
	mul	r1, r2, r1
	ldr	r0, [r3, r1]
	bx	lr
.L152:
	movs	r0, #0
.L149:
	bx	lr
	.align	1
	.p2align 2,,3
	.global	graph_package_version
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_package_version, %function
graph_package_version:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L153
	ldr	r3, [r0, #4]
	cmp	r3, r1
	bls	.L156
	ldr	r3, [r0]
	movs	r2, #24
	mla	r3, r2, r1, r3
	ldr	r0, [r3, #4]
	bx	lr
.L156:
	movs	r0, #0
.L153:
	bx	lr
	.align	1
	.p2align 2,,3
	.global	graph_package_source
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_package_source, %function
graph_package_source:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L160
	ldr	r3, [r0, #4]
	cmp	r3, r1
	bls	.L160
	ldr	r3, [r0]
	movs	r2, #24
	mla	r3, r2, r1, r3
	ldr	r0, [r3, #8]
	bx	lr
.L160:
	movs	r0, #2
	bx	lr
	.align	1
	.p2align 2,,3
	.global	graph_topological_order
	.syntax unified
	.thumb
	.thumb_func
	.type	graph_topological_order, %function
graph_topological_order:
	@ args = 4, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	cmp	r2, #0
	it	ne
	cmpne	r1, #0
	mov	r6, r3
	sub	sp, sp, #36
	ite	eq
	moveq	r3, #1
	movne	r3, #0
	mov	r8, r2
	cmp	r0, #0
	it	eq
	orreq	r3, r3, #1
	movs	r2, #0
	str	r2, [sp, #28]
	cbz	r3, .L172
.L162:
	movs	r0, #0
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L172:
	str	r3, [r1]
	mov	r7, r1
	str	r3, [r8]
	movs	r1, #1
	mov	r5, r0
	ldr	fp, [r0, #4]
	cmp	fp, r1
	mov	r0, fp
	it	cc
	movcc	r0, r1
	bl	calloc(PLT)
	clz	r4, r0
	mov	r10, r0
	lsrs	r4, r4, #5
	cmp	fp, #0
	beq	.L163
	lsl	r0, fp, #2
	bl	malloc(PLT)
	mov	r9, r0
	cmp	r0, #0
	it	eq
	orreq	r4, r4, #1
	cmp	r4, #0
	bne	.L167
	mov	r3, r8
	str	r7, [sp, #20]
	mov	r8, r10
	ldr	r7, [sp, #72]
	add	fp, sp, #28
	mov	r10, r3
	b	.L164
.L166:
	ldr	r3, [r5, #4]
	adds	r4, r4, #1
	cmp	r3, r4
	bls	.L173
.L164:
	ldrb	r3, [r8, r4]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L166
	mov	r3, r9
	mov	r2, r8
	mov	r1, r4
	mov	r0, r5
	strd	r6, r7, [sp, #4]
	str	fp, [sp]
	bl	visit(PLT)
	cmp	r0, #0
	bne	.L166
	mov	r0, r8
	bl	free(PLT)
	mov	r0, r9
	bl	free(PLT)
	b	.L162
.L173:
	mov	r3, r10
	ldr	r7, [sp, #20]
	ldr	fp, [sp, #28]
	mov	r10, r8
	mov	r8, r3
.L168:
	mov	r0, r10
	bl	free(PLT)
	movs	r0, #1
	str	r9, [r7]
	str	fp, [r8]
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L163:
	movs	r0, #4
	bl	malloc(PLT)
	mov	r9, r0
	cmp	r0, #0
	it	eq
	orreq	r4, r4, #1
	cmp	r4, #0
	beq	.L168
.L167:
	mov	r0, r10
	bl	free(PLT)
	mov	r0, r9
	bl	free(PLT)
	b	.L162
	.section	.note.GNU-stack,"",%progbits
