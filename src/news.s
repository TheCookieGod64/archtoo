	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"curl\000"
	.align	2
.LC1:
	.ascii	"\033[1;31m[-] curl is required to fetch Arch news.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC2:
	.ascii	"curl -fsSL --max-time 20 -- 'https://archlinux.org/"
	.ascii	"feeds/news/'\000"
	.align	2
.LC3:
	.ascii	"\033[1;31m[-] Could not download Arch news feed.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC4:
	.ascii	"\033[1;36m>>> Recent Arch Linux news\012\033[0m\000"
	.align	2
.LC5:
	.ascii	"<item>\000"
	.align	2
.LC6:
	.ascii	"</item>\000"
	.align	2
.LC7:
	.ascii	"<title>\000"
	.align	2
.LC8:
	.ascii	"<![CDATA[\000"
	.align	2
.LC9:
	.ascii	"</title>\000"
	.align	2
.LC10:
	.ascii	"&amp;\000"
	.align	2
.LC11:
	.ascii	"&lt;\000"
	.align	2
.LC12:
	.ascii	"&gt;\000"
	.align	2
.LC13:
	.ascii	"&quot;\000"
	.align	2
.LC14:
	.ascii	"&apos;\000"
	.align	2
.LC15:
	.ascii	"&#39;\000"
	.align	2
.LC16:
	.ascii	"  %d. %s\012\000"
	.align	2
.LC17:
	.ascii	"\033[1;31m[-] News feed contained no items.\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_news_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_news_v2, %function
cmd_news_v2:
	@ args = 0, pretend = 0, frame = 544
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r3, #0
	ldr	r0, .L49
	sub	sp, sp, #548
	ldr	r5, .L49+4
.LPIC0:
	add	r0, pc
	add	r4, sp, #28
.LPIC1:
	add	r5, pc
	str	r3, [r4]
	bl	have_cmd(PLT)
	cmp	r0, #0
	beq	.L41
	ldr	r0, .L49+8
	mov	r1, r4
.LPIC3:
	add	r0, pc
	bl	run_cmd_capture(PLT)
	mov	r7, r0
	cmp	r0, #0
	bne	.L4
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L4
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L4
	ldr	r0, .L49+12
	ldr	fp, .L49+16
.LPIC5:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, .L49+20
	ldr	r8, [r4]
.LPIC11:
	add	fp, pc
.LPIC6:
	add	r3, pc
	str	r3, [sp, #4]
	ldr	r3, .L49+24
.LPIC7:
	add	r3, pc
	str	r3, [sp, #8]
	ldr	r3, .L49+28
.LPIC12:
	add	r3, pc
	str	r3, [sp, #16]
.L25:
	mov	r0, r8
	ldr	r1, [sp, #4]
	bl	strstr(PLT)
	mov	r8, r0
	cmp	r0, #0
	beq	.L7
	ldr	r1, [sp, #8]
	bl	strstr(PLT)
	mov	r6, r0
	cmp	r0, #0
	beq	.L7
	ldr	r1, .L49+32
	mov	r0, r8
	add	r8, r6, #7
.LPIC8:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r6, r0
	ite	cs
	movcs	r3, #0
	movcc	r3, #1
	mov	r10, r0
	cmp	r0, #0
	it	eq
	orreq	r3, r3, #1
	cmp	r3, #0
	bne	.L25
	ldr	r1, .L49+36
	add	r9, r0, #7
	movs	r2, #9
	mov	r0, r9
.LPIC9:
	add	r1, pc
	bl	strncmp(PLT)
	cbnz	r0, .L9
	add	r9, r10, #16
.L9:
	ldr	r1, .L49+40
	mov	r0, r9
.LPIC10:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r6, r0
	ite	cs
	movcs	r6, #0
	movcc	r6, #1
	cmp	r0, #0
	it	eq
	orreq	r6, r6, #1
	cmp	r6, #0
	bne	.L25
	add	r3, r9, #3
	cmp	r0, r3
	bcc	.L10
	ldrb	r3, [r0, #-3]	@ zero_extendqisi2
	subs	r2, r0, #3
	cmp	r3, #93
	beq	.L42
.L10:
	sub	r6, r0, r9
	movw	r2, #511
	cmp	r6, r2
	add	r3, sp, #32
	it	cs
	movcs	r6, r2
	mov	r0, r3
	mov	r2, r6
	mov	r1, r9
	bl	memcpy(PLT)
	movs	r2, #0
	strb	r2, [r0, r6]
	mov	r3, r0
	ldrb	r6, [r0]	@ zero_extendqisi2
	cmp	r6, #0
	beq	.L27
	ldr	r2, .L49+44
	mov	r10, r0
	str	r4, [sp, #20]
	mov	r9, r0
.LPIC13:
	add	r2, pc
	mov	r4, r0
	str	r2, [sp, #12]
	b	.L20
.L13:
	add	r9, r9, #1
.L15:
	strb	r6, [r4, #-1]
	ldrb	r6, [r9]	@ zero_extendqisi2
	cmp	r6, #0
	beq	.L43
.L20:
	adds	r4, r4, #1
	cmp	r6, #38
	bne	.L13
	movs	r2, #5
	mov	r1, fp
	mov	r0, r9
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L44
	ldr	r1, [sp, #16]
	movs	r2, #4
	mov	r0, r9
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L45
	ldr	r1, [sp, #12]
	movs	r2, #4
	mov	r0, r9
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L46
	ldr	r1, .L49+48
	movs	r2, #6
	mov	r0, r9
.LPIC14:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L47
	ldr	r1, .L49+52
	movs	r2, #6
	mov	r0, r9
.LPIC15:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L48
	ldr	r1, .L49+56
	movs	r2, #5
	mov	r0, r9
.LPIC16:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L13
	add	r9, r9, #5
	movs	r6, #39
	b	.L15
.L4:
	ldr	r3, .L49+60
	movs	r2, #50
	ldr	r0, .L49+64
	movs	r1, #1
.LPIC4:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	ldr	r0, [r4]
	bl	free(PLT)
.L3:
	movs	r0, #0
.L1:
	add	sp, sp, #548
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L44:
	add	r9, r9, #5
	strb	r6, [r4, #-1]
	ldrb	r6, [r9]	@ zero_extendqisi2
	cmp	r6, #0
	bne	.L20
.L43:
	mov	r3, r10
	mov	r10, r4
	ldr	r4, [sp, #20]
.L12:
	ldr	r0, .L49+68
	adds	r7, r7, #1
	mov	r2, r3
	mov	r1, r7
	movs	r3, #0
.LPIC17:
	add	r0, pc
	strb	r3, [r10]
	bl	printf(PLT)
	cmp	r7, #10
	bne	.L25
	ldr	r0, [r4]
	bl	free(PLT)
.L24:
	movs	r0, #1
	b	.L1
.L45:
	add	r9, r9, #4
	movs	r6, #60
	b	.L15
.L41:
	ldr	r3, .L49+60
	movs	r2, #52
	ldr	r0, .L49+72
	movs	r1, #1
.LPIC2:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L3
.L46:
	add	r9, r9, #4
	movs	r6, #62
	b	.L15
.L47:
	add	r9, r9, #6
	movs	r6, #34
	b	.L15
.L42:
	ldrb	r3, [r0, #-2]	@ zero_extendqisi2
	cmp	r3, #93
	bne	.L10
	ldrb	r3, [r0, #-1]	@ zero_extendqisi2
	cmp	r3, #62
	it	eq
	moveq	r0, r2
	b	.L10
.L48:
	add	r9, r9, #6
	movs	r6, #39
	b	.L15
.L7:
	ldr	r0, [r4]
	bl	free(PLT)
	cmp	r7, #0
	bne	.L24
	ldr	r3, .L49+60
	movs	r2, #45
	ldr	r0, .L49+76
	movs	r1, #1
.LPIC18:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L3
.L27:
	mov	r10, r0
	b	.L12
.L50:
	.align	2
.L49:
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	.LC2-(.LPIC3+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC10-(.LPIC11+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC11-(.LPIC12+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC8-(.LPIC9+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC12-(.LPIC13+4)
	.word	.LC13-(.LPIC14+4)
	.word	.LC14-(.LPIC15+4)
	.word	.LC15-(.LPIC16+4)
	.word	stderr(GOT)
	.word	.LC3-(.LPIC4+4)
	.word	.LC16-(.LPIC17+4)
	.word	.LC1-(.LPIC2+4)
	.word	.LC17-(.LPIC18+4)
	.section	.note.GNU-stack,"",%progbits
