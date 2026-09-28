	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_transform, %function
sha256_transform:
	@ args = 0, pretend = 0, frame = 304
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	fp, r0
	vpush.64	{d8, d9}
	sub	sp, sp, #308
	vld4.8	{d24, d26, d28, d30}, [r1]!
	add	r0, sp, #48
	add	r6, sp, #240
	vld4.8	{d25, d27, d29, d31}, [r1]
	vshll.u8 q0, d29, #8
	vmovl.u8 q8, d31
	vmovl.u8 q2, d25
	vmovl.u8 q1, d24
	vmovl.u8 q9, d30
	vshll.u8 q3, d28, #8
	vmovl.u16 q12, d1
	vmovl.u16 q14, d17
	vmovl.u16 q10, d5
	vmovl.u16 q4, d18
	vmovl.u16 q15, d2
	vmovl.u16 q9, d19
	vorr	q14, q14, q12
	vmovl.u16 q12, d7
	vmovl.u8 q11, d27
	vmovl.u16 q2, d4
	vmovl.u16 q3, d6
	vmovl.u16 q8, d16
	vmovl.u8 q13, d26
	vorr	q9, q9, q12
	vshl.i32	q10, q10, #24
	vmovl.u16 q12, d0
	vorr	q3, q4, q3
	vmovl.u16 q1, d3
	vshl.i32	q15, q15, #24
	vorr	q8, q8, q12
	vorr	q10, q14, q10
	vshl.i32	q12, q2, #24
	vshll.u16 q2, d23, #16
	vshll.u16 q0, d26, #16
	vshl.i32	q1, q1, #24
	vorr	q3, q3, q15
	vorr	q10, q10, q2
	vshll.u16 q13, d27, #16
	vshll.u16 q11, d22, #16
	vorr	q3, q3, q0
	vmov.32	r3, d21[1]
	vmov.32	r4, d21[0]
	vorr	q9, q9, q1
	vstr	d20, [sp, #96]
	vstr	d21, [sp, #104]
	vorr	q8, q8, q12
	vstr	d6, [sp, #48]
	vstr	d7, [sp, #56]
	vmov	r1, s12	@ int
	vorr	q9, q9, q13
	mov	r2, r3
	vorr	q8, q8, q11
	vstr	d18, [sp, #64]
	vstr	d19, [sp, #72]
	vstr	d16, [sp, #80]
	vstr	d17, [sp, #88]
.L2:
	ldr	r7, [r0, #36]
	mov	r5, r1
	ldr	r1, [r0, #4]!
	ror	r3, r4, #19
	eor	r3, r3, r4, ror #17
	cmp	r0, r6
	eor	r3, r3, r4, lsr #10
	mov	r4, r2
	ror	r2, r1, #18
	add	r3, r3, r7
	eor	r2, r2, r1, ror #7
	eor	r2, r2, r1, lsr #3
	add	r3, r3, r2
	add	r2, r5, r3
	str	r2, [r0, #60]
	bne	.L2
	vldr	d20, [fp, #80]
	vldr	d21, [fp, #88]
	add	r1, sp, #44
	vldr	d18, [fp, #96]
	vldr	d19, [fp, #104]
	strd	fp, r1, [sp, #8]
	ldr	r3, .L8
	vmov.32	r9, d21[1]
	ldrd	r4, r6, [fp, #80]
.LPIC0:
	add	r3, pc
	sub	ip, r3, #4
	vmov.32	r8, d19[1]
	adds	r3, r3, #252
	ldr	r5, [fp, #88]
	ldr	r0, [fp, #96]
	ldrd	lr, r7, [fp, #100]
	strd	r1, r3, [sp]
	b	.L3
.L4:
	mov	r7, lr
	mov	r5, r6
	mov	lr, r0
	mov	r6, r4
	mov	r0, r10
	mov	r4, r3
.L3:
	ldr	r3, [sp]
	ror	r10, r0, #11
	ldr	r2, [ip, #4]!
	and	fp, r6, r5
	ldr	r1, [r3, #4]!
	str	r3, [sp]
	eor	r3, r10, r0, ror #6
	add	r2, r2, r1
	eor	r3, r3, r0, ror #25
	add	r3, r3, r2
	bic	r10, r7, r0
	and	r2, r0, lr
	eor	r1, r6, r5
	eor	r10, r10, r2
	ror	r2, r4, #13
	ands	r1, r1, r4
	eor	r2, r2, r4, ror #2
	add	r3, r3, r10
	eor	r2, r2, r4, ror #22
	eor	r1, r1, fp
	add	r3, r3, r8
	add	r2, r2, r1
	add	r10, r3, r9
	add	r3, r3, r2
	ldr	r2, [sp, #4]
	mov	r8, r7
	mov	r9, r5
	cmp	r2, ip
	bne	.L4
	ldrd	fp, r1, [sp, #8]
	str	r5, [r1]
	str	r3, [sp, #32]
	str	r4, [sp, #36]
	str	r6, [sp, #40]
	vldr	d16, [sp, #32]
	vldr	d17, [sp, #40]
	vadd.i32	q8, q8, q10
	vstr	d16, [fp, #80]
	vstr	d17, [fp, #88]
	str	r10, [sp, #16]
	str	r0, [sp, #20]
	str	lr, [sp, #24]
	str	r7, [sp, #28]
	vldr	d16, [sp, #16]
	vldr	d17, [sp, #24]
	vadd.i32	q8, q8, q9
	vstr	d16, [fp, #96]
	vstr	d17, [fp, #104]
	add	sp, sp, #308
	@ sp needed
	vldm	sp!, {d8-d9}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L9:
	.align	2
.L8:
	.word	.LANCHOR0-(.LPIC0+4)
	.align	1
	.p2align 2,,3
	.global	sha256_init
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_init, %function
sha256_init:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov.i32	d20, #0  @ di
	movs	r3, #0
	vldr	d18, .L11
	vldr	d19, .L11+8
	str	r3, [r0, #64]
	vldr	d16, .L11+16
	vldr	d17, .L11+24
	vstr.64	d20, [r0, #72]	@ int
	vstr	d18, [r0, #80]
	vstr	d19, [r0, #88]
	vstr	d16, [r0, #96]
	vstr	d17, [r0, #104]
	bx	lr
.L12:
	.align	3
.L11:
	.word	1779033703
	.word	-1150833019
	.word	1013904242
	.word	-1521486534
	.word	1359893119
	.word	-1694144372
	.word	528734635
	.word	1541459225
	.align	1
	.p2align 2,,3
	.global	sha256_update
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_update, %function
sha256_update:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r2, .L22
	add	r2, r2, r1
	push	{r3, r4, r5, r6, r7, lr}
	mov	r4, r0
	subs	r5, r1, #1
	subs	r6, r2, #1
	movs	r7, #0
	b	.L16
.L15:
	cmp	r5, r6
	beq	.L25
.L16:
	ldr	r2, [r4, #64]
	ldrb	r1, [r5, #1]!	@ zero_extendqisi2
	adds	r3, r2, #1
	strb	r1, [r4, r2]
	cmp	r3, #64
	str	r3, [r4, #64]
	bne	.L15
	mov	r1, r4
	mov	r0, r4
	bl	sha256_transform(PLT)
	str	r7, [r4, #64]
	ldrd	r3, r2, [r4, #72]
	adds	r3, r3, #512
	str	r3, [r4, #72]
	adc	r2, r2, #0
	cmp	r5, r6
	str	r2, [r4, #76]
	bne	.L16
.L25:
	pop	{r3, r4, r5, r6, r7, pc}
.L22:
	bx	lr
	.align	1
	.p2align 2,,3
	.global	sha256_final
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_final, %function
sha256_final:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, r0
	ldr	r5, [r0, #64]
	movs	r3, #128
	mov	r6, r1
	adds	r0, r5, #1
	cmp	r5, #55
	strb	r3, [r4, r5]
	bhi	.L27
	cmp	r0, #56
	beq	.L29
	rsb	r2, r5, #55
	add	r0, r0, r4
	movs	r1, #0
	bl	memset(PLT)
.L29:
	ldrd	r2, r3, [r4, #72]
	lsls	r5, r5, #3
	adds	r5, r5, r2
	str	r5, [r4, #72]
	adc	r3, r3, #0
	rev	r1, r5
	rev	r0, r3
	str	r3, [r4, #76]
	add	r3, r4, #56
	strd	r0, [r3]
	mov	r1, r4
	mov	r0, r4
	bl	sha256_transform(PLT)
	movs	r3, #24
	subs	r1, r6, #1
.L33:
	ldr	r2, [r4, #80]
	lsrs	r2, r2, r3
	strb	r2, [r1, #1]!
	ldr	r2, [r4, #84]
	lsrs	r2, r2, r3
	strb	r2, [r1, #4]
	ldr	r2, [r4, #88]
	lsrs	r2, r2, r3
	strb	r2, [r1, #8]
	ldr	r2, [r4, #92]
	lsrs	r2, r2, r3
	strb	r2, [r1, #12]
	ldr	r2, [r4, #96]
	lsrs	r2, r2, r3
	strb	r2, [r1, #16]
	ldr	r2, [r4, #100]
	lsrs	r2, r2, r3
	strb	r2, [r1, #20]
	ldr	r2, [r4, #104]
	lsrs	r2, r2, r3
	strb	r2, [r1, #24]
	ldr	r2, [r4, #108]
	lsrs	r2, r2, r3
	subs	r3, r3, #8
	cmn	r3, #8
	strb	r2, [r1, #28]
	bne	.L33
	pop	{r4, r5, r6, pc}
.L27:
	cmp	r0, #63
	bhi	.L32
	rsb	r2, r5, #63
	add	r0, r0, r4
	movs	r1, #0
	bl	memset(PLT)
.L32:
	mov	r1, r4
	mov	r0, r4
	bl	sha256_transform(PLT)
	mov	r3, r4
	vmov.i32	q8, #0  @ v16qi
	vst1.8	{q8}, [r3]!
	vst1.8	{q8}, [r3]!
	vst1.8	{q8}, [r3]!
	vst1.8	{d16}, [r3]
	b	.L29
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"rb\000"
	.align	2
.LC1:
	.ascii	"%02x\000"
	.text
	.align	1
	.p2align 2,,3
	.global	sha256_file
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_file, %function
sha256_file:
	@ args = 0, pretend = 0, frame = 8336
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	it	eq
	moveq	r5, #1
	sub	sp, sp, #8320
	it	ne
	movne	r5, #0
	sub	sp, sp, #16
	bne	.L53
.L38:
	movs	r0, #0
	add	sp, sp, #8320
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L53:
	mov	r9, r1
	ldr	r1, .L56+32
.LPIC2:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r8, r0
	cmp	r0, #0
	beq	.L38
	vmov.i32	d20, #0  @ di
	add	r4, sp, #144
	vldr	d18, .L56
	vldr	d19, .L56+8
	add	r6, sp, #32
	vldr	d16, .L56+16
	vldr	d17, .L56+24
	str	r5, [r4, #-48]
	vstr	d18, [r4, #-32]
	vstr	d19, [r4, #-24]
	vstr	d16, [r4, #-16]
	vstr	d17, [r4, #-8]
	vstr.64	d20, [r4, #-40]	@ int
.L40:
	mov	r3, r8
	mov	r2, #8192
	movs	r1, #1
	mov	r0, r4
	bl	fread(PLT)
	cbz	r0, .L54
	mov	r5, r4
	add	r10, r4, r0
	movs	r7, #0
	b	.L42
.L41:
	cmp	r5, r10
	beq	.L40
.L42:
	ldr	r2, [r4, #-48]
	ldrb	r1, [r5], #1	@ zero_extendqisi2
	adds	r3, r4, r2
	adds	r2, r2, #1
	cmp	r2, #64
	str	r2, [r4, #-48]
	strb	r1, [r3, #-112]
	bne	.L41
	mov	r1, r6
	mov	r0, r6
	bl	sha256_transform(PLT)
	str	r7, [r4, #-48]
	ldrd	r3, r2, [r4, #-40]
	adds	r3, r3, #512
	str	r3, [r4, #-40]
	adc	r2, r2, #0
	str	r2, [r4, #-36]
	b	.L41
.L54:
	mov	r0, r8
	bl	ferror(PLT)
	cbnz	r0, .L55
	ldr	r7, .L56+36
	add	r5, sp, #-1
	mov	r4, r9
	add	r6, sp, #31
.LPIC3:
	add	r7, pc
	mov	r0, r8
	bl	fclose(PLT)
	mov	r1, sp
	add	r0, sp, #32
	bl	sha256_final(PLT)
.L46:
	ldrb	r2, [r5, #1]!	@ zero_extendqisi2
	mov	r0, r4
	mov	r1, r7
	adds	r4, r4, #2
	bl	sprintf(PLT)
	cmp	r5, r6
	bne	.L46
	movs	r0, #1
	movs	r3, #0
	strb	r3, [r9, #64]
	add	sp, sp, #8320
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L55:
	mov	r0, r8
	bl	fclose(PLT)
	b	.L38
.L57:
	.align	3
.L56:
	.word	1779033703
	.word	-1150833019
	.word	1013904242
	.word	-1521486534
	.word	1359893119
	.word	-1694144372
	.word	528734635
	.word	1541459225
	.word	.LC0-(.LPIC2+4)
	.word	.LC1-(.LPIC3+4)
	.align	1
	.p2align 2,,3
	.global	sha256_verify_file
	.syntax unified
	.thumb
	.thumb_func
	.type	sha256_verify_file, %function
sha256_verify_file:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, r1
	sub	sp, sp, #72
	add	r1, sp, #4
	bl	sha256_file(PLT)
	eor	r0, r0, #1
	and	r0, r0, #1
	cmp	r4, #0
	it	eq
	orreq	r0, r0, #1
	cbnz	r0, .L64
	subs	r0, r4, #1
	add	ip, sp, #3
	adds	r4, r4, #63
	b	.L62
.L68:
	cmp	r0, r4
	beq	.L67
.L62:
	ldrb	r2, [ip, #1]!	@ zero_extendqisi2
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	sub	r1, r2, #65
	add	r6, r2, #32
	sub	lr, r3, #65
	cmp	r1, #5
	add	r5, r3, #32
	it	ls
	uxtbls	r2, r6
	cmp	lr, #5
	it	ls
	uxtbls	r3, r5
	cmp	r2, r3
	beq	.L68
.L64:
	movs	r0, #0
	add	sp, sp, #72
	@ sp needed
	pop	{r4, r5, r6, pc}
.L67:
	movs	r0, #1
	add	sp, sp, #72
	@ sp needed
	pop	{r4, r5, r6, pc}
	.section	.rodata
	.align	3
	.set	.LANCHOR0,. + 0
	.type	k, %object
k:
	.word	1116352408
	.word	1899447441
	.word	-1245643825
	.word	-373957723
	.word	961987163
	.word	1508970993
	.word	-1841331548
	.word	-1424204075
	.word	-670586216
	.word	310598401
	.word	607225278
	.word	1426881987
	.word	1925078388
	.word	-2132889090
	.word	-1680079193
	.word	-1046744716
	.word	-459576895
	.word	-272742522
	.word	264347078
	.word	604807628
	.word	770255983
	.word	1249150122
	.word	1555081692
	.word	1996064986
	.word	-1740746414
	.word	-1473132947
	.word	-1341970488
	.word	-1084653625
	.word	-958395405
	.word	-710438585
	.word	113926993
	.word	338241895
	.word	666307205
	.word	773529912
	.word	1294757372
	.word	1396182291
	.word	1695183700
	.word	1986661051
	.word	-2117940946
	.word	-1838011259
	.word	-1564481375
	.word	-1474664885
	.word	-1035236496
	.word	-949202525
	.word	-778901479
	.word	-694614492
	.word	-200395387
	.word	275423344
	.word	430227734
	.word	506948616
	.word	659060556
	.word	883997877
	.word	958139571
	.word	1322822218
	.word	1537002063
	.word	1747873779
	.word	1955562222
	.word	2024104815
	.word	-2067236844
	.word	-1933114872
	.word	-1866530822
	.word	-1538233109
	.word	-1090935817
	.word	-965641998
	.section	.note.GNU-stack,"",%progbits
