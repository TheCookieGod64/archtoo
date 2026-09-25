	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	sha256_transform, %function
sha256_transform:
	ld4	{v28.16b - v31.16b}, [x1]
	sub	sp, sp, #256
	add	x1, sp, 64
	uxtl2	v6.8h, v28.16b
	uxtl2	v26.8h, v29.16b
	shll2	v5.8h, v30.16b, 8
	uxtl2	v4.8h, v31.16b
	uxtl	v28.8h, v28.8b
	uxtl2	v17.4s, v6.8h
	uxtl	v6.4s, v6.4h
	uxtl	v29.8h, v29.8b
	shll	v30.8h, v30.8b, 8
	uxtl	v31.8h, v31.8b
	shll2	v18.4s, v26.8h, 16
	uxtl2	v16.4s, v5.8h
	uxtl2	v20.4s, v4.8h
	uxtl	v22.4s, v28.4h
	shl	v17.4s, v17.4s, 24
	uxtl2	v28.4s, v28.8h
	shll	v26.4s, v26.4h, 16
	shl	v6.4s, v6.4s, 24
	uxtl	v5.4s, v5.4h
	uxtl	v4.4s, v4.4h
	shll	v7.4s, v29.4h, 16
	uxtl	v21.4s, v30.4h
	uxtl	v23.4s, v31.4h
	orr	v17.16b, v18.16b, v17.16b
	orr	v20.16b, v16.16b, v20.16b
	shl	v22.4s, v22.4s, 24
	shll2	v29.4s, v29.8h, 16
	shl	v28.4s, v28.4s, 24
	uxtl2	v30.4s, v30.8h
	uxtl2	v31.4s, v31.8h
	orr	v6.16b, v26.16b, v6.16b
	orr	v4.16b, v5.16b, v4.16b
	orr	v20.16b, v17.16b, v20.16b
	orr	v22.16b, v7.16b, v22.16b
	orr	v23.16b, v21.16b, v23.16b
	orr	v28.16b, v29.16b, v28.16b
	orr	v31.16b, v30.16b, v31.16b
	orr	v4.16b, v6.16b, v4.16b
	orr	v23.16b, v22.16b, v23.16b
	orr	v31.16b, v28.16b, v31.16b
	stp	q4, q20, [sp, 32]
	dup	d20, v20.d[1]
	stp	q23, q31, [sp]
	.p2align 5,,15
.L2:
	ldr	d0, [x1, -60]
	shl	v3.2s, v20.2s, 13
	shl	v2.2s, v20.2s, 15
	ldr	d27, [x1, -64]
	add	x2, sp, 256
	shl	v25.2s, v0.2s, 14
	shl	v1.2s, v0.2s, 25
	ldr	d24, [x1, -28]
	usra	v3.2s, v20.2s, 19
	usra	v2.2s, v20.2s, 17
	ushr	v20.2s, v20.2s, 10
	usra	v25.2s, v0.2s, 18
	usra	v1.2s, v0.2s, 7
	ushr	v0.2s, v0.2s, 3
	add	v27.2s, v24.2s, v27.2s
	eor	v2.8b, v3.8b, v2.8b
	eor	v1.8b, v25.8b, v1.8b
	eor	v20.8b, v2.8b, v20.8b
	eor	v0.8b, v1.8b, v0.8b
	add	v20.2s, v20.2s, v0.2s
	add	v20.2s, v20.2s, v27.2s
	str	d20, [x1], 8
	cmp	x1, x2
	bne	.L2
	ldp	q23, q24, [x0, 80]
	adrp	x8, .LANCHOR0
	ldp	w4, w1, [x0, 80]
	fmov	s31, w1
	ldp	w3, w1, [x0, 96]
	mov	x9, sp
	dup	s25, v23.s[3]
	add	x8, x8, :lo12:.LANCHOR0
	dup	s26, v24.s[3]
	ldr	s30, [x0, 88]
	ldr	s29, [x0, 104]
	fmov	s28, w1
	mov	x6, 1
	b	.L3
	.p2align 2,,3
.L4:
	fmov	s29, s28
	fmov	s28, w3
	fmov	w3, s27
	fmov	s30, s31
	fmov	s31, w4
	mov	w4, w1
.L3:
	fmov	w2, s28
	ror	w1, w3, 11
	eor	w1, w1, w3, ror 6
	eor	v27.8b, v31.8b, v30.8b
	eor	w1, w1, w3, ror 25
	and	w5, w3, w2
	fmov	w2, s29
	bic	w2, w2, w3
	eor	w2, w2, w5
	add	x5, x9, x6, lsl 2
	add	w1, w1, w2
	add	x2, x8, x6, lsl 2
	add	x6, x6, 1
	ldr	w5, [x5, -4]
	ldr	w2, [x2, -4]
	add	w2, w2, w5
	fmov	w5, s27
	and	v27.8b, v31.8b, v30.8b
	add	w1, w1, w2
	fmov	w2, s26
	fmov	s26, s29
	and	w5, w5, w4
	fmov	w7, s27
	add	w1, w1, w2
	ror	w2, w4, 13
	eor	w2, w2, w4, ror 2
	fmov	s27, w1
	eor	w2, w2, w4, ror 22
	eor	w5, w5, w7
	add	v27.2s, v27.2s, v25.2s
	add	w2, w2, w5
	fmov	s25, s30
	add	w1, w1, w2
	cmp	x6, 65
	bne	.L4
	fmov	s26, w1
	uzp1	v27.2s, v27.2s, v28.2s
	uzp1	v31.2s, v26.2s, v31.2s
	fmov	s26, w4
	uzp1	v30.2s, v26.2s, v30.2s
	zip1	v31.4s, v31.4s, v30.4s
	fmov	s30, w3
	uzp1	v30.2s, v30.2s, v29.2s
	add	v31.4s, v31.4s, v23.4s
	zip1	v30.4s, v27.4s, v30.4s
	add	v30.4s, v30.4s, v24.4s
	stp	q31, q30, [x0, 80]
	add	sp, sp, 256
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_init
	.type	sha256_init, %function
sha256_init:
	adrp	x1, .LANCHOR0
	add	x1, x1, :lo12:.LANCHOR0
	str	wzr, [x0, 64]
	str	xzr, [x0, 72]
	ldp	q31, q30, [x1, 256]
	stp	q31, q30, [x0, 80]
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_update
	.type	sha256_update, %function
sha256_update:
	cbz	x2, .L18
	mov	x10, x1
	add	x11, x1, x2
	b	.L19
	.p2align 2,,3
.L25:
	add	x10, x10, 1
	cmp	x10, x11
	beq	.L24
.L19:
	ldr	w2, [x0, 64]
	ldrb	w1, [x10]
	strb	w1, [x0, w2, uxtw]
	add	w2, w2, 1
	str	w2, [x0, 64]
	cmp	w2, 64
	bne	.L25
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
.L20:
	mov	x1, x0
	bl	sha256_transform
	ldr	x1, [x0, 72]
	add	x10, x10, 1
	str	wzr, [x0, 64]
	add	x1, x1, 512
	str	x1, [x0, 72]
	cmp	x10, x11
	beq	.L26
.L12:
	ldr	w2, [x0, 64]
	ldrb	w1, [x10]
	strb	w1, [x0, w2, uxtw]
	add	w2, w2, 1
	str	w2, [x0, 64]
	cmp	w2, 64
	beq	.L20
	add	x10, x10, 1
	cmp	x10, x11
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
	beq	.L29
	mov	w2, 55
	add	x0, x19, w0, uxtw
	sub	w2, w2, w21
	mov	w1, 0
	bl	memset
.L29:
	ldr	x0, [x19, 72]
	lsl	w21, w21, 3
	mov	x1, x19
	add	x21, x21, x0
	str	x21, [x19, 72]
	rev	x21, x21
	str	x21, [x19, 56]
	mov	x0, x19
	bl	sha256_transform
	mov	w0, 24
	mov	x1, x20
.L31:
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
	bne	.L31
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L28:
	cmp	w0, 63
	bhi	.L30
	mov	w2, 63
	add	x0, x19, w0, uxtw
	sub	w2, w2, w21
	mov	w1, 0
	bl	memset
.L30:
	mov	x1, x19
	mov	x0, x19
	bl	sha256_transform
	str	xzr, [x19, 48]
	movi	v31.4s, 0
	stp	q31, q31, [x19]
	str	q31, [x19, 32]
	b	.L29
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
	.type	sha256_file.part.0, %function
sha256_file.part.0:
	mov	x12, 8400
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	bl	fopen
	cbz	x0, .L45
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x19, sp, 208
	str	wzr, [sp, 160]
	str	xzr, [sp, 168]
	ldp	q30, q31, [x0, 256]
	stp	q30, q31, [sp, 176]
	.p2align 5,,15
.L40:
	mov	x3, x20
	mov	x0, x19
	mov	x2, 8192
	mov	x1, 1
	bl	fread
	cbz	x0, .L50
	mov	x10, x19
	add	x11, x19, x0
	b	.L42
	.p2align 2,,3
.L41:
	add	x10, x10, 1
	cmp	x10, x11
	beq	.L40
.L42:
	ldr	w2, [sp, 160]
	add	x0, sp, 96
	ldrb	w3, [x10]
	strb	w3, [x0, w2, uxtw]
	add	w2, w2, 1
	str	w2, [sp, 160]
	cmp	w2, 64
	bne	.L41
	mov	x1, x0
	bl	sha256_transform
	ldr	x0, [sp, 168]
	str	wzr, [sp, 160]
	add	x0, x0, 512
	str	x0, [sp, 168]
	b	.L41
	.p2align 2,,3
.L50:
	mov	x0, x20
	bl	ferror
	cbnz	w0, .L51
	add	x19, sp, 64
	mov	x0, x20
	adrp	x22, .LC3
	mov	x20, x21
	add	x22, x22, :lo12:.LC3
	str	x23, [sp, 48]
	add	x23, x19, 32
	bl	fclose
	add	x1, sp, 64
	add	x0, sp, 96
	bl	sha256_final
	.p2align 5,,15
.L46:
	ldrb	w2, [x19], 1
	mov	x0, x20
	mov	x1, x22
	add	x20, x20, 2
	bl	sprintf
	cmp	x19, x23
	bne	.L46
	strb	wzr, [x21, 64]
	mov	w0, 1
	mov	x12, 8400
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
.L51:
	mov	x0, x20
	bl	fclose
	ldp	x19, x20, [sp, 16]
.L45:
	mov	w0, 0
	ldp	x29, x30, [sp]
	mov	x12, 8400
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.align	2
	.p2align 5,,15
	.global	sha256_file
	.type	sha256_file, %function
sha256_file:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	bne	.L54
	mov	w0, 0
	ret
	.p2align 2,,3
.L54:
	b	sha256_file.part.0
	.align	2
	.p2align 5,,15
	.global	sha256_verify_file
	.type	sha256_verify_file, %function
sha256_verify_file:
	cbnz	x0, .L56
	mov	w0, 0
	ret
	.p2align 2,,3
.L56:
	stp	x29, x30, [sp, -112]!
	mov	x5, x1
	mov	x29, sp
	add	x1, sp, 40
	str	x5, [sp, 24]
	bl	sha256_file.part.0
	ldr	x5, [sp, 24]
	eor	w0, w0, 1
	and	w0, w0, 1
	cmp	x5, 0
	cset	w2, eq
	orr	w2, w2, w0
	cbnz	w2, .L58
	sub	x5, x5, #1
	add	x1, sp, 40
	mov	x3, 1
	b	.L61
	.p2align 2,,3
.L67:
	add	x3, x3, 1
	cmp	x3, 65
	beq	.L66
.L61:
	add	x0, x1, x3
	ldrb	w2, [x0, -1]
	ldrb	w0, [x5, x3]
	sub	w4, w2, #65
	and	w4, w4, 255
	cmp	w4, 5
	add	w4, w2, 32
	and	w4, w4, 255
	csel	w2, w2, w4, hi
	sub	w4, w0, #65
	and	w4, w4, 255
	cmp	w4, 5
	add	w4, w0, 32
	and	w4, w4, 255
	csel	w0, w0, w4, hi
	cmp	w2, w0
	beq	.L67
.L58:
	mov	w0, 0
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L66:
	mov	w0, 1
	ldp	x29, x30, [sp], 112
	ret
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
.LC0:
	.word	1779033703
	.word	-1150833019
	.word	1013904242
	.word	-1521486534
.LC1:
	.word	1359893119
	.word	-1694144372
	.word	528734635
	.word	1541459225
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
