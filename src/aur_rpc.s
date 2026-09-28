	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	package_destroy, %function
package_destroy:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r7, r0
	ldr	r0, [r0]
	sub	sp, sp, #68
	bl	free(PLT)
	ldr	r0, [r7, #4]
	bl	free(PLT)
	ldr	r0, [r7, #8]
	bl	free(PLT)
	ldr	r0, [r7, #12]
	bl	free(PLT)
	ldr	r0, [r7, #16]
	bl	free(PLT)
	ldr	r0, [r7, #20]
	bl	free(PLT)
	add	r2, r7, #60
	vldr	d16, [r7, #48]
	vldr	d17, [r7, #56]
	add	r3, r7, #68
	vldr	d18, [r7, #64]
	vldr	d19, [r7, #72]
	add	r0, r7, #44
	strd	r2, r3, [sp, #8]
	add	r1, r7, #52
	strd	r0, r1, [sp]
	add	r8, sp, #40
	vuzp.32	q8, q9
	add	r5, sp, #16
	vld1.64	{d18-d19}, [sp:64]
	add	r9, sp, #60
	ldr	r3, [r7, #80]
	add	r2, r7, #76
	str	r3, [sp, #56]
	str	r2, [sp, #32]
	vstr	d16, [sp, #40]
	vstr	d17, [sp, #48]
	vstr	d18, [sp, #16]
	vstr	d19, [sp, #24]
.L2:
	ldr	r6, [r8], #4
	movs	r4, #0
	cbz	r6, .L5
.L3:
	ldr	r3, [r5]
	ldr	r3, [r3]
	ldr	r0, [r3, r4, lsl #2]
	adds	r4, r4, #1
	bl	free(PLT)
	cmp	r4, r6
	bne	.L3
.L5:
	ldr	r3, [r5], #4
	ldr	r0, [r3]
	bl	free(PLT)
	cmp	r8, r9
	bne	.L2
	movs	r2, #88
	movs	r1, #0
	mov	r0, r7
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, lr}
	b	memset(PLT)
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	parse_json_string, %function
parse_json_string:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r4, [r0]
	sub	sp, sp, #12
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #34
	bne	.L13
	mov	fp, r0
	mov	r0, r4
	bl	strlen(PLT)
	add	r10, r0, #1
	mov	r0, r10
	bl	malloc(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L13
	adds	r6, r4, #1
	ldrb	r4, [r4, #1]	@ zero_extendqisi2
	cmp	r4, #0
	it	ne
	cmpne	r4, #34
	it	eq
	moveq	r2, r0
	beq	.L15
	movs	r5, #0
	b	.L14
.L16:
	mov	r5, r3
	mov	r6, r7
	strb	r4, [r8]
.L26:
	ldrb	r4, [r6]	@ zero_extendqisi2
	cmp	r4, #0
	it	ne
	cmpne	r4, #34
	beq	.L36
.L14:
	add	r2, r9, r5
	add	r3, r5, #8
	mov	r8, r2
	cmp	r3, r10
	bcs	.L37
	adds	r7, r6, #1
	adds	r3, r5, #1
	cmp	r4, #92
	bne	.L16
	ldrb	r4, [r6, #1]	@ zero_extendqisi2
	cmp	r4, #0
	beq	.L38
	sub	r2, r4, #98
	adds	r7, r6, #2
	cmp	r2, #19
	bhi	.L16
	adr	r1, .L21
	ldr	r2, [r1, r2, lsl #2]
	add	r1, r1, r2
	bx	r1
	.p2align 2
.L21:
	.word	.L25+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L24+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L29+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L16+1-.L21
	.word	.L23+1-.L21
	.word	.L16+1-.L21
	.word	.L22+1-.L21
	.word	.L20+1-.L21
	.p2align 1
.L20:
	mov	r0, r7
	str	r3, [sp, #4]
	bl	strlen(PLT)
	ldr	r3, [sp, #4]
	cmp	r0, #3
	bls	.L16
	adds	r6, r6, #6
	movw	r3, #30044
	strh	r3, [r8]	@ unaligned
	adds	r5, r5, #6
	ldr	r3, [r6, #-4]	@ unaligned
	str	r3, [r8, #2]	@ unaligned
	b	.L26
.L22:
	movs	r4, #9
	b	.L16
.L23:
	movs	r4, #13
	b	.L16
.L24:
	movs	r4, #12
	b	.L16
.L25:
	movs	r4, #8
	b	.L16
.L37:
	ldrb	r4, [r6]	@ zero_extendqisi2
.L15:
	cmp	r4, #34
	it	eq
	addeq	r6, r6, #1
.L18:
	movs	r3, #0
	mov	r0, r9
	strb	r3, [r2]
	str	r6, [fp]
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L13:
	mov	r9, #0
	mov	r0, r9
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L36:
	add	r2, r9, r5
	b	.L15
.L29:
	movs	r4, #10
	b	.L16
.L38:
	movs	r1, #92
	mov	r6, r7
	strb	r1, [r2]
	add	r2, r9, r3
	b	.L18
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\"%s\"\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	find_key, %function
find_key:
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r3, r2
	ldr	r2, .L51
	sub	sp, sp, #100
	mov	r7, r0
	mov	r5, r1
.LPIC0:
	add	r2, pc
	movs	r1, #96
	mov	r0, sp
	mov	r6, sp
	bl	snprintf(PLT)
.L40:
	mov	r0, r7
	mov	r1, r6
	bl	strstr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r0, r5
	mov	r7, r0
	ite	cc
	movcc	r4, #1
	movcs	r4, #0
	bcs	.L49
	mov	r0, r6
	bl	strlen(PLT)
	add	r7, r7, r0
	cmp	r5, r7
	bls	.L40
	bl	__ctype_b_loc(PLT)
	mov	r3, r7
	ldr	r1, [r0]
	b	.L42
.L44:
	cmp	r5, r3
	beq	.L50
.L42:
	mov	r7, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	ldrh	r2, [r1, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L44
.L43:
	cmp	r5, r7
	bls	.L40
	ldrb	r3, [r7]	@ zero_extendqisi2
	cmp	r3, #58
	bne	.L40
	adds	r0, r7, #1
	add	sp, sp, #100
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L50:
	mov	r7, r5
	b	.L43
.L49:
	mov	r0, r4
	add	sp, sp, #100
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L52:
	.align	2
.L51:
	.word	.LC0-(.LPIC0+4)
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	object_array, %function
object_array:
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r6, r3
	mov	r8, r1
	sub	sp, sp, #8
	ldr	r5, [sp, #40]
	bl	find_key(PLT)
	movs	r3, #0
	str	r3, [r6]
	str	r3, [r5]
	cbz	r0, .L63
	cmp	r0, r8
	mov	r9, r0
	it	cs
	ldrbcs	r2, [r0]	@ zero_extendqisi2
	bcs	.L57
	bl	__ctype_b_loc(PLT)
	mov	r3, r9
	ldr	r0, [r0]
	b	.L58
.L59:
	cmp	r8, r3
	beq	.L79
.L58:
	ldrb	r2, [r3]	@ zero_extendqisi2
	mov	r9, r3
	adds	r3, r3, #1
	ldrh	r1, [r0, r2, lsl #1]
	lsls	r1, r1, #18
	bmi	.L59
.L57:
	cmp	r2, #91
	bne	.L63
.L82:
	add	r9, r9, #1
	str	r9, [sp, #4]
	cmp	r9, r8
	bcs	.L62
	add	r7, sp, #4
.L61:
	bl	__ctype_b_loc(PLT)
	ldr	ip, [r0]
	mov	r3, r9
	movs	r2, #0
.L68:
	ldrb	r1, [r3], #1	@ zero_extendqisi2
	mov	r0, r2
	add	r2, ip, r1, lsl #1
	ldrb	r2, [r2, #1]	@ zero_extendqisi2
	ubfx	r2, r2, #5, #1
	cmp	r1, #44
	it	eq
	orreq	r2, r2, #1
	ands	r2, r2, #255
	beq	.L80
	mov	r4, r3
	cmp	r8, r3
	bne	.L68
.L63:
	movs	r0, #1
.L53:
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L80:
	cbz	r0, .L65
	str	r4, [sp, #4]
.L65:
	cmp	r1, #93
	beq	.L63
	cmp	r1, #34
	bne	.L62
	mov	r0, r7
	bl	parse_json_string(PLT)
	ldr	r1, [r5]
	mov	r10, r0
	ldr	r0, [r6]
	adds	r1, r1, #1
	lsls	r1, r1, #2
	bl	realloc(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r10, #0
	beq	.L81
	ldr	r3, [r5]
	ldr	r9, [sp, #4]
	str	r0, [r6]
	adds	r2, r3, #1
	cmp	r9, r8
	str	r2, [r5]
	str	r10, [r0, r3, lsl #2]
	bcc	.L61
.L62:
	movs	r0, #0
	b	.L53
.L79:
	ldrb	r2, [r9, #1]	@ zero_extendqisi2
	mov	r9, r8
	cmp	r2, #91
	bne	.L63
	b	.L82
.L81:
	mov	r0, r10
	bl	free(PLT)
	b	.L62
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"\000"
	.align	2
.LC2:
	.ascii	"null\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	object_string, %function
object_string:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r1
	sub	sp, sp, #12
	bl	find_key(PLT)
	str	r0, [sp, #4]
	cbz	r0, .L84
	mov	r4, r0
	cmp	r0, r6
	bcs	.L85
	bl	__ctype_b_loc(PLT)
	movs	r5, #0
	ldr	r0, [r0]
	mov	r3, r4
	b	.L86
.L88:
	mov	r7, r3
	movs	r5, #1
	cmp	r6, r3
	beq	.L97
.L86:
	mov	r4, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	ldrh	r2, [r0, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L88
	cbz	r5, .L87
	str	r7, [sp, #4]
.L87:
	subs	r1, r6, r4
	cmp	r1, #3
	ble	.L85
	ldr	r1, .L99
	movs	r2, #4
	mov	r0, r4
.LPIC2:
	add	r1, pc
	bl	strncmp(PLT)
	cbz	r0, .L98
.L85:
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #34
	beq	.L90
	ldr	r0, .L99+4
.LPIC4:
	add	r0, pc
.L96:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, lr}
	b	strdup(PLT)
.L90:
	add	r0, sp, #4
	bl	parse_json_string(PLT)
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L97:
	mov	r4, r6
	str	r6, [sp, #4]
	b	.L87
.L98:
	ldr	r0, .L99+8
.LPIC3:
	add	r0, pc
	b	.L96
.L84:
	ldr	r0, .L99+12
.LPIC1:
	add	r0, pc
	b	.L96
.L100:
	.align	2
.L99:
	.word	.LC2-(.LPIC2+4)
	.word	.LC1-(.LPIC4+4)
	.word	.LC1-(.LPIC3+4)
	.word	.LC1-(.LPIC1+4)
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	object_long, %function
object_long:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r5, r1
	bl	find_key(PLT)
	cbz	r0, .L102
	mov	r4, r0
	cmp	r5, r0
	bls	.L103
	bl	__ctype_b_loc(PLT)
	mov	r3, r4
	ldr	r1, [r0]
	b	.L104
.L105:
	cmp	r5, r3
	beq	.L108
.L104:
	mov	r4, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	ldrh	r2, [r1, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L105
.L103:
	mov	r0, r4
	movs	r2, #10
	pop	{r3, r4, r5, lr}
	movs	r1, #0
	b	strtol(PLT)
.L108:
	mov	r4, r5
	b	.L103
.L102:
	pop	{r3, r4, r5, pc}
	.section	.rodata.str1.4
	.align	2
.LC3:
	.ascii	"unknown error\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	set_error, %function
set_error:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	beq	.L115
	push	{r3, r4, r5, r6, r7, lr}
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	cbz	r2, .L113
	mov	r0, r2
	bl	strlen(PLT)
	mov	r7, r0
.L111:
	cmp	r5, r7
	mov	r1, r6
	it	ls
	addls	r7, r5, #-1
	mov	r0, r4
	mov	r2, r7
	bl	memcpy(PLT)
	movs	r3, #0
	strb	r3, [r4, r7]
	pop	{r3, r4, r5, r6, r7, pc}
.L115:
	bx	lr
.L113:
	ldr	r6, .L118
	movs	r7, #13
.LPIC5:
	add	r6, pc
	b	.L111
.L119:
	.align	2
.L118:
	.word	.LC3-(.LPIC5+4)
	.section	.rodata.str1.4
	.align	2
.LC4:
	.ascii	"--silent\000"
	.align	2
.LC5:
	.ascii	"--fail\000"
	.align	2
.LC6:
	.ascii	"curl\000"
	.align	2
.LC7:
	.ascii	"60\000"
	.align	2
.LC8:
	.ascii	"--max-time\000"
	.align	2
.LC9:
	.ascii	"15\000"
	.align	2
.LC10:
	.ascii	"--connect-timeout\000"
	.align	2
.LC11:
	.ascii	"--location\000"
	.align	2
.LC12:
	.ascii	"--show-error\000"
	.align	2
.LC13:
	.ascii	"out of memory\000"
	.align	2
.LC14:
	.ascii	"AUR RPC HTTP request failed\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	curl_get.constprop.0, %function
curl_get.constprop.0:
	@ args = 0, pretend = 0, frame = 8224
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r7, r1
	mov	r5, r0
	sub	sp, sp, #8256
	movs	r1, #0
	sub	sp, sp, #4
	str	r1, [r7]
	add	r6, sp, #64
	sub	r0, r6, #8
	str	r2, [sp, #36]
	str	r3, [sp, #40]
	bl	pipe(PLT)
	cmp	r0, #0
	bne	.L147
	mov	r4, r0
	bl	fork(PLT)
	subs	r9, r0, #0
	blt	.L149
	beq	.L150
	mov	r8, r4
	mov	fp, r4
	ldr	r0, [r6, #-4]
	bl	close(PLT)
.L127:
	ldr	r0, [r6, #-8]
	mov	r2, #8192
	mov	r1, r6
	bl	read(PLT)
	subs	r5, r0, #0
	ble	.L151
	add	r10, r5, r8
	add	r2, r10, #1
	cmp	r2, r4
	it	ls
	ldrls	r2, [r7]
	bls	.L129
	cbnz	r4, .L131
	mov	r4, #8192
	cmp	r2, #8192
	bls	.L132
.L131:
	lsls	r4, r4, #1
	cmp	r2, r4
	bhi	.L131
.L132:
	ldr	r0, [r7]
	mov	r1, r4
	bl	realloc(PLT)
	mov	r2, r0
	cmp	r0, #0
	beq	.L152
	str	r0, [r7]
.L129:
	add	r0, r2, r8
	mov	r1, r6
	mov	r2, r5
	mov	r8, r10
	bl	memcpy(PLT)
	ldr	r2, [r7]
	strb	fp, [r2, r10]
	b	.L127
.L150:
	ldr	r0, [r6, #-8]
	bl	close(PLT)
	ldr	r0, [r6, #-4]
	movs	r1, #1
	bl	dup2(PLT)
	cmp	r0, #0
	blt	.L148
	ldr	r0, [r6, #-4]
	bl	close(PLT)
	ldr	r4, .L156
	ldr	r0, .L156+4
	ldr	r2, .L156+8
.LPIC10:
	add	r4, pc
	ldr	r3, .L156+12
.LPIC11:
	add	r0, pc
	ldr	r1, .L156+16
.LPIC12:
	add	r2, pc
.LPIC13:
	add	r3, pc
	strd	r0, r4, [sp, #16]
	strd	r3, r2, [sp, #8]
.LPIC8:
	add	r1, pc
	ldr	r4, .L156+20
	ldr	r0, .L156+24
	ldr	r3, .L156+28
.LPIC14:
	add	r4, pc
	ldr	r2, .L156+32
.LPIC15:
	add	r0, pc
.LPIC6:
	add	r3, pc
	strd	r0, r4, [sp]
.LPIC7:
	add	r2, pc
	mov	r0, r1
	strd	r5, r9, [sp, #24]
	bl	execlp(PLT)
.L148:
	movs	r0, #127
	bl	_exit(PLT)
.L149:
	ldr	r0, [r6, #-8]
	bl	close(PLT)
	ldr	r0, [r6, #-4]
	bl	close(PLT)
.L147:
	bl	__errno_location(PLT)
	ldr	r0, [r0]
	bl	strerror(PLT)
	mov	r2, r0
	ldrd	r0, r1, [sp, #36]
	bl	set_error(PLT)
.L122:
	movs	r0, #0
	add	sp, sp, #8256
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L151:
	ldr	r0, [r6, #-8]
	add	r4, sp, #52
	bl	close(PLT)
	b	.L138
.L153:
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #4
	bne	.L137
.L138:
	movs	r2, #0
	mov	r1, r4
	mov	r0, r9
	bl	waitpid(PLT)
	cmp	r0, #0
	blt	.L153
.L137:
	ldr	r3, [r6, #-12]
	movw	r2, #65407
	ldr	r0, [r7]
	tst	r2, r3
	bne	.L154
	cmp	r0, #0
	beq	.L155
.L141:
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
	add	sp, sp, #8256
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L152:
	str	r0, [sp, #44]
	ldr	r0, [r6, #-8]
	bl	close(PLT)
	movs	r1, #15
	mov	r0, r9
	bl	kill(PLT)
	ldr	r2, [sp, #44]
	mov	r0, r9
	mov	r1, r2
	bl	waitpid(PLT)
	ldr	r0, [r7]
	bl	free(PLT)
	ldr	r2, [sp, #44]
	str	r2, [r7]
	ldrd	r3, r2, [sp, #36]
	cmp	r2, #0
	it	ne
	cmpne	r3, #0
	ite	eq
	moveq	r5, #1
	movne	r5, #0
	beq	.L122
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #36]
	cmp	r4, #14
	ldr	r1, .L156+36
	it	cs
	movcs	r4, #14
	mov	r0, r6
	subs	r4, r4, #1
.LPIC16:
	add	r1, pc
	mov	r2, r4
	bl	memcpy(PLT)
	strb	r5, [r6, r4]
	b	.L122
.L154:
	bl	free(PLT)
	movs	r3, #0
	ldr	r6, [sp, #36]
	str	r3, [r7]
	ldr	r3, [sp, #40]
	cmp	r3, #0
	it	ne
	cmpne	r6, #0
	ite	eq
	moveq	r5, #1
	movne	r5, #0
	beq	.L122
	cmp	r3, #28
	ldr	r1, .L156+40
	it	cs
	movcs	r3, #28
	mov	r0, r6
	subs	r4, r3, #1
.LPIC17:
	add	r1, pc
	mov	r2, r4
	bl	memcpy(PLT)
	strb	r5, [r6, r4]
	b	.L122
.L155:
	ldr	r0, .L156+44
.LPIC18:
	add	r0, pc
	bl	strdup(PLT)
	str	r0, [r7]
	b	.L141
.L157:
	.align	2
.L156:
	.word	.LC7-(.LPIC10+4)
	.word	.LC8-(.LPIC11+4)
	.word	.LC9-(.LPIC12+4)
	.word	.LC10-(.LPIC13+4)
	.word	.LC6-(.LPIC8+4)
	.word	.LC11-(.LPIC14+4)
	.word	.LC12-(.LPIC15+4)
	.word	.LC4-(.LPIC6+4)
	.word	.LC5-(.LPIC7+4)
	.word	.LC13-(.LPIC16+4)
	.word	.LC14-(.LPIC17+4)
	.word	.LC1-(.LPIC18+4)
	.section	.rodata.str1.4
	.align	2
.LC15:
	.ascii	"search\000"
	.align	2
.LC16:
	.ascii	"%s/search/%s?by=name-desc\000"
	.align	2
.LC17:
	.ascii	"%s/info?arg[]=%s\000"
	.align	2
.LC18:
	.ascii	"\"results\"\000"
	.align	2
.LC19:
	.ascii	"invalid AUR RPC response\000"
	.align	2
.LC20:
	.ascii	"truncated AUR RPC object\000"
	.align	2
.LC21:
	.ascii	"Name\000"
	.align	2
.LC22:
	.ascii	"PackageBase\000"
	.align	2
.LC23:
	.ascii	"Version\000"
	.align	2
.LC24:
	.ascii	"Description\000"
	.align	2
.LC25:
	.ascii	"URL\000"
	.align	2
.LC26:
	.ascii	"Maintainer\000"
	.align	2
.LC27:
	.ascii	"NumVotes\000"
	.align	2
.LC28:
	.ascii	"Popularity\000"
	.align	2
.LC29:
	.ascii	"OutOfDate\000"
	.align	2
.LC30:
	.ascii	"Depends\000"
	.align	2
.LC31:
	.ascii	"MakeDepends\000"
	.align	2
.LC32:
	.ascii	"CheckDepends\000"
	.align	2
.LC33:
	.ascii	"Provides\000"
	.align	2
.LC34:
	.ascii	"Conflicts\000"
	.align	2
.LC35:
	.ascii	"cannot parse AUR package metadata\000"
	.align	2
.LC36:
	.ascii	"truncated AUR RPC results\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	request, %function
request:
	@ args = 8, pretend = 0, frame = 104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r10, r0
	mov	r0, r2
	sub	sp, sp, #116
	mov	r9, r2
	mov	r6, r1
	mov	r4, r3
	bl	strlen(PLT)
	mov	r7, r0
	add	r0, r0, r0, lsl #1
	ldr	r8, [sp, #152]
	adds	r0, r0, #1
	bl	malloc(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L159
	mov	ip, r0
	cbz	r7, .L161
	ldr	fp, .L286
	bl	__ctype_b_loc(PLT)
	add	lr, r9, #-1
	mov	ip, #0
	add	r1, lr, r7
.LPIC19:
	add	fp, pc
	ldr	r7, [r0]
	strd	r10, r6, [sp, #8]
	b	.L167
.L276:
	cmp	r3, #95
	it	ne
	cmpne	r9, #1
	bls	.L164
	lsr	r10, r3, #4
	add	r6, ip, #2
	cmp	r3, #126
	and	r9, r3, #15
	beq	.L164
	mov	r3, #37
	strb	r3, [r5, ip]
	ldrb	r3, [fp, r10]	@ zero_extendqisi2
	add	ip, ip, #3
	strb	r3, [r5, r2]
	cmp	r1, lr
	ldrb	r3, [fp, r9]	@ zero_extendqisi2
	strb	r3, [r5, r6]
	beq	.L275
.L167:
	ldrb	r3, [lr, #1]!	@ zero_extendqisi2
	add	r2, ip, #1
	add	r0, r5, ip
	sub	r9, r3, #45
	ldrh	r6, [r7, r3, lsl #1]
	lsls	r6, r6, #28
	bpl	.L276
.L164:
	mov	ip, r2
	cmp	r1, lr
	strb	r3, [r0]
	bne	.L167
.L275:
	ldrd	r10, r6, [sp, #8]
	add	ip, ip, r5
.L161:
	vmov.i32	d16, #0  @ v8qi
	movs	r3, #0
	mov	r0, r10
	strb	r3, [ip]
	str	r3, [sp, #20]
	vst1.8	{d16}, [r4]
	bl	strlen(PLT)
	mov	r7, r0
	mov	r0, r6
	bl	strlen(PLT)
	mov	r9, r0
	add	r7, r7, r9
	mov	r0, r5
	adds	r7, r7, #32
	bl	strlen(PLT)
	add	r7, r7, r0
	mov	r0, r7
	bl	malloc(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L277
	ldr	r1, .L286+4
	mov	r0, r6
.LPIC23:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r3, r10
	mov	r1, r7
	str	r5, [sp]
	cmp	r0, #0
	beq	.L278
	ldr	r2, .L286+8
	mov	r0, r9
.LPIC25:
	add	r2, pc
	bl	snprintf(PLT)
.L172:
	mov	r0, r5
	bl	free(PLT)
	ldr	r3, [sp, #156]
	mov	r2, r8
	add	r1, sp, #20
	mov	r0, r9
	bl	curl_get.constprop.0(PLT)
	ldr	r3, [sp, #20]
	mov	r10, r0
	str	r3, [sp, #8]
	cmp	r0, #0
	beq	.L176
	ldr	r1, .L286+12
	mov	r0, r3
.LPIC26:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	beq	.L174
	movs	r1, #91
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L174
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	adds	r5, r0, #1
	cmp	r3, #0
	beq	.L178
.L177:
	mov	r6, r5
	cmp	r3, #123
	bne	.L203
	b	.L202
.L180:
	ldrb	r3, [r6, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	it	ne
	cmpne	r3, #123
	beq	.L179
.L203:
	cmp	r3, #93
	bne	.L180
.L181:
	mov	r0, r9
	bl	free(PLT)
	ldr	r0, [sp, #8]
	bl	free(PLT)
	mov	r0, r10
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L278:
	ldr	r2, .L286+16
	mov	r0, r9
.LPIC24:
	add	r2, pc
	bl	snprintf(PLT)
	b	.L172
.L179:
	cmp	r3, #0
	beq	.L279
.L202:
	mov	r5, r6
	movs	r0, #0
	movs	r3, #123
.L191:
	adds	r2, r5, #1
	cmp	r3, #34
	beq	.L280
	cmp	r3, #123
	it	eq
	addeq	r0, r0, #1
	beq	.L190
	cmp	r3, #125
	beq	.L281
.L190:
	mov	r5, r2
.L187:
	ldrb	r3, [r5]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L191
.L206:
	cmp	r0, #0
	bne	.L282
.L182:
	add	r7, sp, #24
	movs	r2, #88
	movs	r1, #0
	mov	r0, r7
	bl	memset(PLT)
	ldr	r2, .L286+20
	mov	r1, r5
	mov	r0, r6
.LPIC29:
	add	r2, pc
	bl	object_string(PLT)
	ldr	r2, .L286+24
	mov	r1, r5
	str	r0, [sp, #24]
.LPIC30:
	add	r2, pc
	mov	r0, r6
	bl	object_string(PLT)
	ldr	r2, .L286+28
	mov	r1, r5
	str	r0, [sp, #28]
.LPIC31:
	add	r2, pc
	mov	r0, r6
	bl	object_string(PLT)
	ldr	r2, .L286+32
	mov	r1, r5
	str	r0, [sp, #32]
.LPIC32:
	add	r2, pc
	mov	r0, r6
	bl	object_string(PLT)
	ldr	r2, .L286+36
	mov	r1, r5
	str	r0, [sp, #36]
.LPIC33:
	add	r2, pc
	mov	r0, r6
	bl	object_string(PLT)
	ldr	r2, .L286+40
	mov	r1, r5
	str	r0, [sp, #40]
.LPIC34:
	add	r2, pc
	mov	r0, r6
	bl	object_string(PLT)
	ldr	r2, .L286+44
	mov	r1, r5
	str	r0, [sp, #44]
.LPIC35:
	add	r2, pc
	mov	r0, r6
	bl	object_long(PLT)
	ldr	r2, .L286+48
	str	r0, [sp, #48]
	mov	r1, r5
.LPIC36:
	add	r2, pc
	mov	r0, r6
	bl	find_key(PLT)
	mov	fp, r0
	cmp	r0, #0
	beq	.L210
	cmp	r5, r0
	bls	.L193
	bl	__ctype_b_loc(PLT)
	mov	r3, fp
	ldr	r0, [r0]
	b	.L194
.L195:
	cmp	r3, r5
	beq	.L283
.L194:
	mov	fp, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	ldrh	r2, [r0, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L195
.L193:
	mov	r0, fp
	movs	r1, #0
	bl	strtod(PLT)
.L192:
	ldr	r2, .L286+52
	mov	r1, r5
	mov	r0, r6
	vstr.64	d0, [sp, #56]
.LPIC37:
	add	r2, pc
	bl	object_long(PLT)
	ldr	r3, [sp, #24]
	str	r0, [sp, #64]
	cbz	r3, .L197
	ldr	r3, [sp, #28]
	cbz	r3, .L197
	ldr	r3, [sp, #32]
	cbz	r3, .L197
	ldr	r3, [sp, #36]
	cbz	r3, .L197
	ldr	r3, [sp, #40]
	cbz	r3, .L197
	ldr	r3, [sp, #44]
	cbz	r3, .L197
	ldr	r2, .L286+56
	add	r3, sp, #72
	mov	r1, r5
	str	r3, [sp]
.LPIC38:
	add	r2, pc
	add	r3, sp, #68
	mov	r0, r6
	bl	object_array(PLT)
	cbz	r0, .L197
	ldr	r2, .L286+60
	add	r3, sp, #80
	mov	r1, r5
	str	r3, [sp]
.LPIC39:
	add	r2, pc
	add	r3, sp, #76
	mov	r0, r6
	bl	object_array(PLT)
	cmp	r0, #0
	bne	.L284
.L197:
	mov	r0, r7
	bl	package_destroy(PLT)
	ldr	r3, [sp, #156]
	cmp	r3, #0
	it	ne
	cmpne	r8, #0
	ite	eq
	moveq	r5, #1
	movne	r5, #0
	beq	.L176
	ldr	r6, [sp, #156]
	mov	r0, r8
	ldr	r1, .L286+64
	cmp	r6, #34
	it	cs
	movcs	r6, #34
.LPIC43:
	add	r1, pc
	subs	r6, r6, #1
	mov	r2, r6
	bl	memcpy(PLT)
	strb	r5, [r8, r6]
.L176:
	ldr	r3, [r4, #4]
	movs	r5, #0
	mov	r6, r5
	cbz	r3, .L205
.L204:
	ldr	r0, [r4]
	adds	r6, r6, #1
	add	r0, r0, r5
	adds	r5, r5, #88
	bl	package_destroy(PLT)
	ldr	r3, [r4, #4]
	cmp	r6, r3
	bcc	.L204
.L205:
	ldr	r0, [r4]
	bl	free(PLT)
	movs	r3, #0
	mov	r10, r3
	strd	r3, r3, [r4]
	b	.L181
.L281:
	subs	r0, r0, #1
	bne	.L190
	mov	r5, r2
	b	.L182
.L280:
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L208
.L188:
	adds	r1, r2, #1
	cmp	r3, #92
	mov	r5, r1
	beq	.L285
	ldrb	r2, [r2, #1]	@ zero_extendqisi2
	cmp	r3, #34
	beq	.L187
	mov	r3, r2
.L186:
	mov	r2, r1
	cmp	r3, #0
	bne	.L188
	mov	r5, r1
	b	.L206
.L285:
	ldrb	r3, [r2, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L206
	ldrb	r3, [r2, #2]	@ zero_extendqisi2
	adds	r1, r1, #1
	b	.L186
.L283:
	mov	fp, r5
	b	.L193
.L210:
	vmov.i64	d0, #0	@ float
	b	.L192
.L284:
	ldr	r2, .L286+68
	add	r3, sp, #88
	mov	r1, r5
	str	r3, [sp]
.LPIC40:
	add	r2, pc
	add	r3, sp, #84
	mov	r0, r6
	bl	object_array(PLT)
	cmp	r0, #0
	beq	.L197
	ldr	r2, .L286+72
	add	r3, sp, #96
	mov	r1, r5
	str	r3, [sp]
.LPIC41:
	add	r2, pc
	add	r3, sp, #92
	mov	r0, r6
	bl	object_array(PLT)
	cmp	r0, #0
	beq	.L197
	ldr	r2, .L286+76
	add	r3, sp, #104
	mov	r0, r6
	str	r3, [sp]
.LPIC42:
	add	r2, pc
	add	r3, sp, #100
	mov	r1, r5
	bl	object_array(PLT)
	cmp	r0, #0
	beq	.L197
	ldr	r1, [r4, #4]
	movs	r2, #88
	ldr	r0, [r4]
	mla	r1, r1, r2, r2
	bl	realloc(PLT)
	cmp	r0, #0
	beq	.L197
	ldr	r3, [r4, #4]
	movs	r2, #88
	str	r0, [r4]
	mov	r1, r7
	mla	r0, r2, r3, r0
	adds	r3, r3, #1
	str	r3, [r4, #4]
	bl	memcpy(PLT)
	ldrb	r3, [r5]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L177
.L178:
	ldr	r3, [sp, #156]
	cmp	r3, #0
	it	ne
	cmpne	r8, #0
	ite	eq
	moveq	r6, #1
	movne	r6, #0
	beq	.L176
	cmp	r3, #26
	mov	r5, r3
	it	cs
	movcs	r5, #26
	ldr	r1, .L286+80
	subs	r5, r5, #1
	mov	r0, r8
.LPIC44:
	add	r1, pc
	mov	r2, r5
	bl	memcpy(PLT)
	strb	r6, [r8, r5]
	b	.L176
.L279:
	mov	r5, r6
	b	.L182
.L159:
	vmov.i32	d16, #0  @ v8qi
	ldr	r3, [sp, #156]
	str	r0, [sp, #20]
	cmp	r3, #0
	it	ne
	cmpne	r8, #0
	ite	eq
	moveq	r5, #1
	movne	r5, #0
	vst1.8	{d16}, [r4]
	beq	.L162
	ldr	r4, [sp, #156]
	mov	r0, r8
	ldr	r1, .L286+84
	cmp	r4, #14
	it	cs
	movcs	r4, #14
.LPIC21:
	add	r1, pc
	subs	r4, r4, #1
	mov	r2, r4
	bl	memcpy(PLT)
	strb	r5, [r8, r4]
.L162:
	mov	r10, #0
	mov	r0, r10
	add	sp, sp, #116
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L208:
	mov	r5, r2
	b	.L206
.L174:
	ldr	r3, [sp, #156]
	cmp	r3, #0
	it	ne
	cmpne	r8, #0
	ite	eq
	moveq	r6, #1
	movne	r6, #0
	beq	.L176
	cmp	r3, #25
	mov	r5, r3
	it	cs
	movcs	r5, #25
	ldr	r1, .L286+88
	subs	r5, r5, #1
	mov	r0, r8
.LPIC27:
	add	r1, pc
	mov	r2, r5
	bl	memcpy(PLT)
	strb	r6, [r8, r5]
	b	.L176
.L282:
	ldr	r3, [sp, #156]
	cmp	r3, #0
	it	ne
	cmpne	r8, #0
	ite	eq
	moveq	r6, #1
	movne	r6, #0
	beq	.L176
	cmp	r3, #25
	mov	r5, r3
	it	cs
	movcs	r5, #25
	ldr	r1, .L286+92
	subs	r5, r5, #1
	mov	r0, r8
.LPIC28:
	add	r1, pc
	mov	r2, r5
	bl	memcpy(PLT)
	strb	r6, [r8, r5]
	b	.L176
.L277:
	mov	r0, r5
	bl	free(PLT)
	ldr	r2, .L286+96
	ldr	r1, [sp, #156]
	mov	r0, r8
.LPIC22:
	add	r2, pc
	bl	set_error(PLT)
	b	.L162
.L287:
	.align	2
.L286:
	.word	.LANCHOR0-(.LPIC19+4)
	.word	.LC15-(.LPIC23+4)
	.word	.LC17-(.LPIC25+4)
	.word	.LC18-(.LPIC26+4)
	.word	.LC16-(.LPIC24+4)
	.word	.LC21-(.LPIC29+4)
	.word	.LC22-(.LPIC30+4)
	.word	.LC23-(.LPIC31+4)
	.word	.LC24-(.LPIC32+4)
	.word	.LC25-(.LPIC33+4)
	.word	.LC26-(.LPIC34+4)
	.word	.LC27-(.LPIC35+4)
	.word	.LC28-(.LPIC36+4)
	.word	.LC29-(.LPIC37+4)
	.word	.LC30-(.LPIC38+4)
	.word	.LC31-(.LPIC39+4)
	.word	.LC35-(.LPIC43+4)
	.word	.LC32-(.LPIC40+4)
	.word	.LC33-(.LPIC41+4)
	.word	.LC34-(.LPIC42+4)
	.word	.LC36-(.LPIC44+4)
	.word	.LC13-(.LPIC21+4)
	.word	.LC19-(.LPIC27+4)
	.word	.LC20-(.LPIC28+4)
	.word	.LC13-(.LPIC22+4)
	.align	1
	.p2align 2,,3
	.global	aur_response_destroy
	.syntax unified
	.thumb
	.thumb_func
	.type	aur_response_destroy, %function
aur_response_destroy:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L300
	ldr	r3, [r0, #4]
	push	{r4, r5, r6, lr}
	mov	r6, r0
	cbz	r3, .L290
	movs	r4, #0
	mov	r5, r4
.L291:
	ldr	r0, [r6]
	adds	r5, r5, #1
	add	r0, r0, r4
	adds	r4, r4, #88
	bl	package_destroy(PLT)
	ldr	r3, [r6, #4]
	cmp	r5, r3
	bcc	.L291
.L290:
	ldr	r0, [r6]
	bl	free(PLT)
	movs	r3, #0
	strd	r3, r3, [r6]
	pop	{r4, r5, r6, pc}
.L300:
	bx	lr
	.section	.rodata.str1.4
	.align	2
.LC37:
	.ascii	"https://aur.archlinux.org/rpc/v5\000"
	.text
	.align	1
	.p2align 2,,3
	.global	aur_rpc_search
	.syntax unified
	.thumb
	.thumb_func
	.type	aur_rpc_search, %function
aur_rpc_search:
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r4, r3
	mov	r3, r2
	sub	sp, sp, #8
	cbz	r0, .L307
.L304:
	mov	r2, r1
	ldr	r1, [sp, #16]
	str	r1, [sp, #4]
	ldr	r1, .L308
	str	r4, [sp]
.LPIC46:
	add	r1, pc
	bl	request(PLT)
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L307:
	ldr	r0, .L308+4
.LPIC45:
	add	r0, pc
	b	.L304
.L309:
	.align	2
.L308:
	.word	.LC15-(.LPIC46+4)
	.word	.LC37-(.LPIC45+4)
	.section	.rodata.str1.4
	.align	2
.LC38:
	.ascii	"info\000"
	.text
	.align	1
	.p2align 2,,3
	.global	aur_rpc_info
	.syntax unified
	.thumb
	.thumb_func
	.type	aur_rpc_info, %function
aur_rpc_info:
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r4, r3
	mov	r3, r2
	sub	sp, sp, #8
	cbz	r0, .L314
.L311:
	mov	r2, r1
	ldr	r1, [sp, #16]
	str	r1, [sp, #4]
	ldr	r1, .L315
	str	r4, [sp]
.LPIC48:
	add	r1, pc
	bl	request(PLT)
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L314:
	ldr	r0, .L315+4
.LPIC47:
	add	r0, pc
	b	.L311
.L316:
	.align	2
.L315:
	.word	.LC38-(.LPIC48+4)
	.word	.LC37-(.LPIC47+4)
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	hex.0, %object
hex.0:
	.ascii	"0123456789ABCDEF\000"
	.section	.note.GNU-stack,"",%progbits
