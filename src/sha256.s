	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	sha256_transform, %function
sha256_transform:
	ld4	{v28.16b - v31.16b}, [x1]
	sub	sp, sp, #256
	add	x2, sp, 64
	add	x3, sp, 256
	uxtl2	v18.8h, v28.16b
	uxtl2	v17.8h, v29.16b
	shll2	v16.8h, v30.16b, 8
	uxtl2	v7.8h, v31.16b
	uxtl	v28.8h, v28.8b
	uxtl2	v2.4s, v18.8h
	uxtl	v18.4s, v18.4h
	uxtl	v29.8h, v29.8b
	shll2	v1.4s, v17.8h, 16
	shll	v30.8h, v30.8b, 8
	uxtl2	v0.4s, v16.8h
	uxtl	v31.8h, v31.8b
	uxtl2	v20.4s, v7.8h
	uxtl	v19.4s, v28.4h
	shl	v2.4s, v2.4s, 24
	uxtl2	v28.4s, v28.8h
	shl	v18.4s, v18.4s, 24
	shll	v17.4s, v17.4h, 16
	uxtl	v16.4s, v16.4h
	uxtl	v7.4s, v7.4h
	shll	v22.4s, v29.4h, 16
	uxtl	v21.4s, v30.4h
	uxtl	v23.4s, v31.4h
	orr	v1.16b, v2.16b, v1.16b
	orr	v20.16b, v0.16b, v20.16b
	shl	v19.4s, v19.4s, 24
	shl	v28.4s, v28.4s, 24
	shll2	v29.4s, v29.8h, 16
	uxtl2	v30.4s, v30.8h
	uxtl2	v31.4s, v31.8h
	orr	v17.16b, v18.16b, v17.16b
	orr	v7.16b, v16.16b, v7.16b
	orr	v20.16b, v1.16b, v20.16b
	orr	v22.16b, v19.16b, v22.16b
	orr	v29.16b, v28.16b, v29.16b
	orr	v23.16b, v21.16b, v23.16b
	orr	v31.16b, v30.16b, v31.16b
	orr	v7.16b, v17.16b, v7.16b
	orr	v23.16b, v22.16b, v23.16b
	orr	v31.16b, v29.16b, v31.16b
	stp	q7, q20, [sp, 32]
	dup	d20, v20.d[1]
	stp	q23, q31, [sp]
	.p2align 5,,15
.L2:
	ldr	d27, [x2, -60]
	shl	v2.2s, v20.2s, 13
	ushr	v24.2s, v20.2s, 19
	shl	v1.2s, v20.2s, 15
	ushr	v0.2s, v20.2s, 17
	shl	v6.2s, v27.2s, 14
	ushr	v5.2s, v27.2s, 18
	shl	v4.2s, v27.2s, 25
	ushr	v3.2s, v27.2s, 7
	orr	v24.8b, v2.8b, v24.8b
	ushr	v20.2s, v20.2s, 10
	orr	v0.8b, v1.8b, v0.8b
	ushr	v27.2s, v27.2s, 3
	orr	v5.8b, v6.8b, v5.8b
	ldr	d25, [x2, -64]
	orr	v3.8b, v4.8b, v3.8b
	ldr	d26, [x2, -28]
	eor	v0.8b, v24.8b, v0.8b
	add	v25.2s, v26.2s, v25.2s
	eor	v3.8b, v5.8b, v3.8b
	eor	v20.8b, v0.8b, v20.8b
	eor	v27.8b, v3.8b, v27.8b
	add	v20.2s, v27.2s, v20.2s
	add	v20.2s, v20.2s, v25.2s
	str	d20, [x2], 8
	cmp	x2, x3
	bne	.L2
	ldp	q23, q24, [x0, 80]
	adrp	x9, .LANCHOR0
	ldp	w5, w1, [x0, 80]
	fmov	s29, w1
	ldp	w4, w1, [x0, 96]
	add	x9, x9, :lo12:.LANCHOR0
	dup	s25, v23.s[3]
	mov	x10, sp
	dup	s31, v24.s[3]
	ldr	s30, [x0, 88]
	ldr	s28, [x0, 104]
	mov	x6, 1
	fmov	s27, w1
	b	.L3
	.p2align 2,,3
.L4:
	fmov	s28, s27
	fmov	s27, w4
	fmov	w4, s26
	fmov	s30, s29
	fmov	s29, w5
	mov	w5, w1
.L3:
	add	x2, x10, x6, lsl 2
	add	x3, x9, x6, lsl 2
	eor	v26.8b, v29.8b, v30.8b
	ror	w1, w4, 11
	eor	w1, w1, w4, ror 6
	add	x6, x6, 1
	ldr	w8, [x2, -4]
	fmov	w2, s28
	ldr	w7, [x3, -4]
	eor	w1, w1, w4, ror 25
	add	w7, w7, w8
	bic	w3, w2, w4
	fmov	w2, s27
	and	w2, w4, w2
	eor	w3, w3, w2
	ror	w2, w5, 13
	add	w1, w1, w3
	fmov	w3, s26
	and	v26.8b, v29.8b, v30.8b
	add	w1, w1, w7
	eor	w2, w2, w5, ror 2
	eor	w2, w2, w5, ror 22
	and	w3, w3, w5
	fmov	w7, s26
	eor	w3, w3, w7
	fmov	w7, s31
	add	w2, w2, w3
	add	w1, w1, w7
	fmov	s31, w1
	add	w1, w1, w2
	add	v26.2s, v31.2s, v25.2s
	fmov	s25, s30
	fmov	s31, s28
	cmp	x6, 65
	bne	.L4
	fmov	s31, w1
	ins	v26.s[1], v27.s[0]
	ins	v31.s[1], v29.s[0]
	fmov	s29, w5
	ins	v29.s[1], v30.s[0]
	fmov	s30, w4
	ins	v30.s[1], v28.s[0]
	zip1	v31.4s, v31.4s, v29.4s
	zip1	v30.4s, v26.4s, v30.4s
	add	v31.4s, v31.4s, v23.4s
	add	v30.4s, v30.4s, v24.4s
	stp	q31, q30, [x0, 80]
	add	sp, sp, 256
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_init
	.type	sha256_init, %function
sha256_init:
	adrp	x1, .LC0
	str	wzr, [x0, 64]
	str	xzr, [x0, 72]
	ldr	q31, [x1, #:lo12:.LC0]
	adrp	x1, .LC1
	ldr	q30, [x1, #:lo12:.LC1]
	stp	q31, q30, [x0, 80]
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_update
	.type	sha256_update, %function
sha256_update:
	cbz	x2, .L18
	mov	x11, x1
	add	x12, x1, x2
	b	.L19
	.p2align 2,,3
.L25:
	add	x11, x11, 1
	cmp	x11, x12
	beq	.L24
.L19:
	ldr	w2, [x0, 64]
	ldrb	w3, [x11]
	add	w1, w2, 1
	strb	w3, [x0, w2, uxtw]
	str	w1, [x0, 64]
	cmp	w1, 64
	bne	.L25
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
.L20:
	mov	x1, x0
	bl	sha256_transform
	ldr	x1, [x0, 72]
	add	x11, x11, 1
	str	wzr, [x0, 64]
	add	x1, x1, 512
	str	x1, [x0, 72]
	cmp	x11, x12
	beq	.L26
.L12:
	ldr	w2, [x0, 64]
	ldrb	w3, [x11]
	add	w1, w2, 1
	strb	w3, [x0, w2, uxtw]
	str	w1, [x0, 64]
	cmp	w1, 64
	beq	.L20
	add	x11, x11, 1
	cmp	x11, x12
	bne	.L12
.L26:
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L18:
	ret
	.p2align 2,,3
.L24:
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_final
	.type	sha256_final, %function
sha256_final:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x20, x1
	str	x21, [sp, 32]
	mov	w1, -128
	ldr	w21, [x0, 64]
	add	w0, w21, 1
	strb	w1, [x19, w21, uxtw]
	cmp	w21, 55
	bhi	.L28
	cmp	w0, 56
	beq	.L30
	mov	w2, 55
	add	x0, x19, w0, uxtw
	sub	w2, w2, w21
	mov	w1, 0
	bl	memset
.L30:
	ldr	x2, [x19, 72]
	lsl	w21, w21, 3
	mov	x1, x19
	mov	x0, x19
	add	x21, x21, x2
	str	x21, [x19, 72]
	rev	x21, x21
	str	x21, [x19, 56]
	bl	sha256_transform
	mov	w0, 24
	mov	x1, x20
.L34:
	ldr	w2, [x19, 80]
	add	x1, x1, 1
	lsr	w2, w2, w0
	strb	w2, [x1, -1]
	ldr	w2, [x19, 84]
	lsr	w2, w2, w0
	strb	w2, [x1, 3]
	ldr	w2, [x19, 88]
	lsr	w2, w2, w0
	strb	w2, [x1, 7]
	ldr	w2, [x19, 92]
	lsr	w2, w2, w0
	strb	w2, [x1, 11]
	ldr	w2, [x19, 96]
	lsr	w2, w2, w0
	strb	w2, [x1, 15]
	ldr	w2, [x19, 100]
	lsr	w2, w2, w0
	strb	w2, [x1, 19]
	ldr	w2, [x19, 104]
	lsr	w2, w2, w0
	strb	w2, [x1, 23]
	ldr	w2, [x19, 108]
	lsr	w2, w2, w0
	sub	w0, w0, #8
	strb	w2, [x1, 27]
	cmn	w0, #8
	bne	.L34
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L28:
	cmp	w0, 63
	bhi	.L33
	mov	w2, 63
	add	x0, x19, w0, uxtw
	sub	w2, w2, w21
	mov	w1, 0
	bl	memset
.L33:
	mov	x1, x19
	mov	x0, x19
	bl	sha256_transform
	str	xzr, [x19, 48]
	movi	v31.4s, 0
	stp	q31, q31, [x19]
	str	q31, [x19, 32]
	b	.L30
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC2:
	.string	"rb"
	.align	3
.LC3:
	.string	"%02x"
	.text
	.align	2
	.p2align 5,,15
	.global	sha256_file
	.type	sha256_file, %function
sha256_file:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	bne	.L57
	mov	w0, 0
	ret
	.p2align 2,,3
.L57:
	mov	x12, 8400
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	bl	fopen
	mov	x20, x0
	cbz	x0, .L39
	adrp	x0, .LC0
	add	x19, sp, 208
	add	x22, sp, 96
	str	wzr, [sp, 160]
	ldr	q30, [x0, #:lo12:.LC0]
	adrp	x0, .LC1
	str	xzr, [sp, 168]
	ldr	q31, [x0, #:lo12:.LC1]
	stp	q30, q31, [sp, 176]
	.p2align 5,,15
.L41:
	mov	x3, x20
	mov	x0, x19
	mov	x2, 8192
	mov	x1, 1
	bl	fread
	cbz	x0, .L58
	add	x12, x19, x0
	mov	x11, x19
	b	.L43
	.p2align 2,,3
.L42:
	add	x11, x11, 1
	cmp	x11, x12
	beq	.L41
.L43:
	ldr	w3, [sp, 160]
	ldrb	w4, [x11]
	add	w2, w3, 1
	str	w2, [sp, 160]
	strb	w4, [x22, w3, uxtw]
	cmp	w2, 64
	bne	.L42
	mov	x0, x22
	mov	x1, x22
	bl	sha256_transform
	str	wzr, [sp, 160]
	ldr	x0, [sp, 168]
	add	x0, x0, 512
	str	x0, [sp, 168]
	b	.L42
	.p2align 2,,3
.L58:
	mov	x0, x20
	bl	ferror
	cbnz	w0, .L59
	add	x19, sp, 64
	mov	x0, x20
	adrp	x22, .LC3
	mov	x20, x21
	add	x22, x22, :lo12:.LC3
	str	x23, [sp, 48]
	add	x23, x19, 32
	bl	fclose
	add	x0, sp, 96
	mov	x1, x19
	bl	sha256_final
	.p2align 5,,15
.L47:
	ldrb	w2, [x19], 1
	mov	x0, x20
	mov	x1, x22
	add	x20, x20, 2
	bl	sprintf
	cmp	x23, x19
	bne	.L47
	strb	wzr, [x21, 64]
	mov	w0, 1
	mov	x12, 8400
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
.L59:
	mov	x0, x20
	bl	fclose
.L39:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	mov	x12, 8400
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_verify_file
	.type	sha256_verify_file, %function
sha256_verify_file:
	stp	x29, x30, [sp, -112]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x20, sp, 40
	mov	x19, x1
	mov	x1, x20
	bl	sha256_file
	cmp	x19, 0
	eor	w0, w0, 1
	and	w0, w0, 1
	cset	w1, eq
	orr	w0, w1, w0
	cbnz	w0, .L66
	sub	x8, x19, #1
	mov	x3, 1
	b	.L64
	.p2align 2,,3
.L70:
	cmp	x3, 65
	beq	.L69
.L64:
	add	x2, x20, x3
	ldrb	w0, [x8, x3]
	add	x3, x3, 1
	sub	w5, w0, #65
	add	w4, w0, 32
	ldrb	w2, [x2, -1]
	and	w5, w5, 255
	and	w4, w4, 255
	sub	w7, w2, #65
	add	w6, w2, 32
	and	w7, w7, 255
	and	w6, w6, 255
	cmp	w7, 6
	csel	w2, w6, w2, cc
	cmp	w5, 6
	csel	w0, w4, w0, cc
	cmp	w2, w0
	beq	.L70
.L66:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L69:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 112
	ret
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC0:
	.word	1779033703
	.word	-1150833019
	.word	1013904242
	.word	-1521486534
	.align	4
.LC1:
	.word	1359893119
	.word	-1694144372
	.word	528734635
	.word	1541459225
	.section	.rodata
	.align	4
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
	.section	.note.GNU-stack,"",@progbits
