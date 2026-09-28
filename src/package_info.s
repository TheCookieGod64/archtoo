	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\000"
	.align	2
.LC1:
	.ascii	"(orphan)\000"
	.align	2
.LC2:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC3:
	.ascii	"pacman -Si -- %s\000"
	.align	2
.LC4:
	.ascii	"\033[1;31m[-] %s\012\033[0m\000"
	.align	2
.LC5:
	.ascii	"\033[1;31m[-] Package '%s' was not found in reposit"
	.ascii	"ories or the AUR.\012\033[0m\000"
	.align	2
.LC6:
	.ascii	"Repository      : aur\000"
	.align	2
.LC7:
	.ascii	"Name            : %s\012\000"
	.align	2
.LC8:
	.ascii	"Package Base    : %s\012\000"
	.align	2
.LC9:
	.ascii	"Version         : %s\012\000"
	.align	2
.LC10:
	.ascii	"Description     : %s\012\000"
	.align	2
.LC11:
	.ascii	"URL             : %s\012\000"
	.align	2
.LC12:
	.ascii	"Maintainer      : %s\012\000"
	.align	2
.LC13:
	.ascii	"Votes           : %ld\012\000"
	.align	2
.LC14:
	.ascii	"Popularity      : %.2f\012\000"
	.align	2
.LC15:
	.ascii	"Out Of Date     : %ld\012\000"
	.align	2
.LC16:
	.ascii	"Depends On      :\000"
	.align	2
.LC17:
	.ascii	" None\000"
	.align	2
.LC18:
	.ascii	"Make Deps       :\000"
	.align	2
.LC19:
	.ascii	" %s\000"
	.align	2
.LC20:
	.ascii	"Check Deps      :\000"
	.align	2
.LC21:
	.ascii	"Provides        :\000"
	.align	2
.LC22:
	.ascii	"Conflicts With  :\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_available_info_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_available_info_v2, %function
cmd_available_info_v2:
	@ args = 0, pretend = 0, frame = 1112
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r3, #0
	ldr	r5, .L79
	subw	sp, sp, #1124
	mov	r4, r0
	add	r6, sp, #20
.LPIC8:
	add	r5, pc
	str	r3, [r6]
	bl	valid_pkgname(PLT)
	cbnz	r0, .L2
	ldr	r3, .L79+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	cmp	r4, #0
	beq	.L64
.L3:
	ldr	r1, .L79+8
	mov	r2, r4
.LPIC9:
	add	r1, pc
	bl	fprintf(PLT)
.L10:
	movs	r0, #0
.L1:
	addw	sp, sp, #1124
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L2:
	add	r7, sp, #288
	mov	r2, #320
	mov	r1, r7
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L10
	ldr	r2, .L79+12
	mov	r3, r7
	add	r7, sp, #608
	mov	r1, #512
.LPIC10:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r1, r6
	mov	r0, r7
	bl	run_cmd_capture(PLT)
	ldr	r3, [r6]
	cbnz	r0, .L7
	cbz	r3, .L7
	ldrb	r2, [r3]	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L65
.L7:
	mov	r0, r3
	add	r7, sp, #24
	bl	free(PLT)
	vmov.i32	d16, #0  @ v8qi
	add	r6, sp, #32
	mov	r8, #256
	mov	r2, r8
	movs	r1, #0
	mov	r0, r6
	vstr	d16, [r7]
	bl	memset(PLT)
	bl	config_current(PLT)
	mov	r3, r6
	adds	r0, r0, #16
	mov	r2, r7
	mov	r1, r4
	str	r8, [sp]
	bl	aur_rpc_info(PLT)
	cmp	r0, #0
	beq	.L66
	ldr	r3, [r7, #4]
	cmp	r3, #0
	beq	.L67
	ldr	r3, .L79+16
	mov	r9, #0
	ldr	r10, .L79+20
	mov	r8, r9
.LPIC1:
	add	r10, pc
	ldr	r6, [r5, r3]
	ldr	r3, .L79+24
.LPIC13:
	add	r3, pc
	str	r3, [sp, #12]
.L11:
	ldr	r5, [r7]
	ldr	r0, [sp, #12]
	bl	puts(PLT)
	add	r4, r5, r9
	ldr	r1, [r5, r9]
	ldr	r0, .L79+28
	cmp	r1, #0
	it	eq
	moveq	r1, r10
.LPIC14:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #4]
	cmp	r1, #0
	beq	.L68
.L13:
	ldr	r0, .L79+32
.LPIC15:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #8]
	cmp	r1, #0
	beq	.L69
.L14:
	ldr	r0, .L79+36
.LPIC16:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #12]
	cmp	r1, #0
	beq	.L70
.L15:
	ldr	r0, .L79+40
.LPIC17:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #16]
	cmp	r1, #0
	beq	.L71
.L16:
	ldr	r0, .L79+44
.LPIC18:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #20]
	cmp	r1, #0
	beq	.L43
	ldrb	r3, [r1]	@ zero_extendqisi2
	cbnz	r3, .L17
	ldr	r1, .L79+48
.LPIC7:
	add	r1, pc
.L17:
	ldr	r0, .L79+52
.LPIC19:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L79+56
	ldr	r1, [r4, #24]
.LPIC20:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L79+60
	ldrd	r2, [r4, #32]
.LPIC21:
	add	r0, pc
	bl	printf(PLT)
	ldr	r1, [r4, #40]
	cmp	r1, #0
	bne	.L72
.L18:
	ldr	r0, .L79+64
.LPIC23:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #48]
	cmp	r3, #0
	beq	.L73
.L19:
	ldr	r5, .L79+68
	mov	fp, #0
.LPIC26:
	add	r5, pc
.L22:
	ldr	r2, [r4, #44]
	mov	r0, r5
	ldr	r1, [r2, fp, lsl #2]
	add	fp, fp, #1
	bl	printf(PLT)
	ldr	r2, [r4, #48]
	cmp	fp, r2
	bcc	.L22
.L23:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r0, .L79+72
.LPIC25:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #56]
	cmp	r3, #0
	beq	.L74
.L21:
	ldr	r5, .L79+76
	mov	fp, #0
.LPIC29:
	add	r5, pc
.L26:
	ldr	r2, [r4, #52]
	mov	r0, r5
	ldr	r1, [r2, fp, lsl #2]
	add	fp, fp, #1
	bl	printf(PLT)
	ldr	r2, [r4, #56]
	cmp	fp, r2
	bcc	.L26
.L27:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r0, .L79+80
.LPIC28:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #64]
	cmp	r3, #0
	beq	.L75
.L25:
	ldr	r5, .L79+84
	mov	fp, #0
.LPIC32:
	add	r5, pc
.L30:
	ldr	r2, [r4, #60]
	mov	r0, r5
	ldr	r1, [r2, fp, lsl #2]
	add	fp, fp, #1
	bl	printf(PLT)
	ldr	r2, [r4, #64]
	cmp	fp, r2
	bcc	.L30
.L31:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r0, .L79+88
.LPIC31:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #72]
	cmp	r3, #0
	beq	.L76
.L29:
	ldr	r5, .L79+92
	mov	fp, #0
.LPIC35:
	add	r5, pc
.L34:
	ldr	r2, [r4, #68]
	mov	r0, r5
	ldr	r1, [r2, fp, lsl #2]
	add	fp, fp, #1
	bl	printf(PLT)
	ldr	r2, [r4, #72]
	cmp	fp, r2
	bcc	.L34
.L35:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r0, .L79+96
.LPIC34:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #80]
	cbz	r3, .L77
.L33:
	ldr	r5, .L79+100
	mov	fp, #0
.LPIC37:
	add	r5, pc
.L38:
	ldr	r2, [r4, #76]
	mov	r0, r5
	ldr	r1, [r2, fp, lsl #2]
	add	fp, fp, #1
	bl	printf(PLT)
	ldr	r2, [r4, #80]
	cmp	fp, r2
	bcc	.L38
.L39:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r3, [r7, #4]
	add	r8, r8, #1
	cmp	r8, r3
	bcc	.L78
.L37:
	mov	r0, r7
	bl	aur_response_destroy(PLT)
	movs	r0, #1
	addw	sp, sp, #1124
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L64:
	ldr	r4, .L79+104
.LPIC0:
	add	r4, pc
	b	.L3
.L78:
	ldr	r1, [r6]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r3, [r7, #4]
	add	r9, r9, #88
	cmp	r8, r3
	bcc	.L11
	b	.L37
.L77:
	ldr	r0, .L79+108
.LPIC36:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #80]
	cmp	r3, #0
	bne	.L33
	b	.L39
.L76:
	ldr	r0, .L79+112
.LPIC33:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #72]
	cmp	r3, #0
	bne	.L29
	b	.L35
.L75:
	ldr	r0, .L79+116
.LPIC30:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #64]
	cmp	r3, #0
	bne	.L25
	b	.L31
.L74:
	ldr	r0, .L79+120
.LPIC27:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #56]
	cmp	r3, #0
	bne	.L21
	b	.L27
.L73:
	ldr	r0, .L79+124
.LPIC24:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r4, #48]
	cmp	r3, #0
	bne	.L19
	b	.L23
.L72:
	ldr	r0, .L79+128
.LPIC22:
	add	r0, pc
	bl	printf(PLT)
	b	.L18
.L68:
	ldr	r1, .L79+132
.LPIC2:
	add	r1, pc
	b	.L13
.L43:
	ldr	r1, .L79+136
.LPIC6:
	add	r1, pc
	b	.L17
.L71:
	ldr	r1, .L79+140
.LPIC5:
	add	r1, pc
	b	.L16
.L70:
	ldr	r1, .L79+144
.LPIC4:
	add	r1, pc
	b	.L15
.L69:
	ldr	r1, .L79+148
.LPIC3:
	add	r1, pc
	b	.L14
.L66:
	ldr	r3, .L79+4
	mov	r2, r6
	ldr	r1, .L79+152
.LPIC11:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L10
.L65:
	ldr	r2, .L79+16
	mov	r0, r3
	ldr	r5, [r5, r2]
	ldr	r1, [r5]
	bl	fputs(PLT)
	ldr	r4, [r6]
	mov	r0, r4
	bl	strlen(PLT)
	adds	r3, r4, r0
	ldrb	r3, [r3, #-1]	@ zero_extendqisi2
	cmp	r3, #10
	beq	.L8
	ldr	r1, [r5]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r4, [r6]
.L8:
	mov	r0, r4
	bl	free(PLT)
	movs	r0, #1
	b	.L1
.L67:
	ldr	r3, .L79+4
	mov	r2, r4
	ldr	r1, .L79+156
.LPIC12:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r7
	bl	aur_response_destroy(PLT)
	b	.L10
.L80:
	.align	2
.L79:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC8+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC9+4)
	.word	.LC3-(.LPIC10+4)
	.word	stdout(GOT)
	.word	.LC0-(.LPIC1+4)
	.word	.LC6-(.LPIC13+4)
	.word	.LC7-(.LPIC14+4)
	.word	.LC8-(.LPIC15+4)
	.word	.LC9-(.LPIC16+4)
	.word	.LC10-(.LPIC17+4)
	.word	.LC11-(.LPIC18+4)
	.word	.LC1-(.LPIC7+4)
	.word	.LC12-(.LPIC19+4)
	.word	.LC13-(.LPIC20+4)
	.word	.LC14-(.LPIC21+4)
	.word	.LC16-(.LPIC23+4)
	.word	.LC19-(.LPIC26+4)
	.word	.LC18-(.LPIC25+4)
	.word	.LC19-(.LPIC29+4)
	.word	.LC20-(.LPIC28+4)
	.word	.LC19-(.LPIC32+4)
	.word	.LC21-(.LPIC31+4)
	.word	.LC19-(.LPIC35+4)
	.word	.LC22-(.LPIC34+4)
	.word	.LC19-(.LPIC37+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC17-(.LPIC36+4)
	.word	.LC17-(.LPIC33+4)
	.word	.LC17-(.LPIC30+4)
	.word	.LC17-(.LPIC27+4)
	.word	.LC17-(.LPIC24+4)
	.word	.LC15-(.LPIC22+4)
	.word	.LC0-(.LPIC2+4)
	.word	.LC1-(.LPIC6+4)
	.word	.LC0-(.LPIC5+4)
	.word	.LC0-(.LPIC4+4)
	.word	.LC0-(.LPIC3+4)
	.word	.LC4-(.LPIC11+4)
	.word	.LC5-(.LPIC12+4)
	.section	.rodata.str1.4
	.align	2
.LC23:
	.ascii	"pacman -Qi -- %s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_query_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_query_v2, %function
cmd_query_v2:
	@ args = 0, pretend = 0, frame = 832
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	ldr	r5, .L90
	sub	sp, sp, #836
.LPIC39:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L82
	ldr	r3, .L90+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	cbz	r4, .L89
.L83:
	ldr	r1, .L90+8
	mov	r2, r4
.LPIC40:
	add	r1, pc
	bl	fprintf(PLT)
.L84:
	movs	r0, #0
	add	sp, sp, #836
	@ sp needed
	pop	{r4, r5, pc}
.L82:
	mov	r2, #320
	mov	r1, sp
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L84
	ldr	r2, .L90+12
	add	r4, sp, #320
	mov	r3, sp
	mov	r1, #512
.LPIC41:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	add	sp, sp, #836
	@ sp needed
	pop	{r4, r5, pc}
.L89:
	ldr	r4, .L90+16
.LPIC38:
	add	r4, pc
	b	.L83
.L91:
	.align	2
.L90:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC39+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC40+4)
	.word	.LC23-(.LPIC41+4)
	.word	.LC0-(.LPIC38+4)
	.section	.note.GNU-stack,"",%progbits
