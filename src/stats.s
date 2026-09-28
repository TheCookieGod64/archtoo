	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	count_cmd_lines, %function
count_cmd_lines:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r5, #0
	sub	sp, sp, #12
	add	r1, sp, #4
	str	r5, [sp, #4]
	bl	run_cmd_capture(PLT)
	ldr	r6, [sp, #4]
	cmp	r0, #1
	bhi	.L24
	cbz	r6, .L12
	ldrb	r3, [r6]	@ zero_extendqisi2
	cbz	r3, .L13
	mov	r4, r6
.L10:
	movs	r1, #10
	mov	r0, r4
	bl	strchr(PLT)
	mov	r7, r0
	cbz	r0, .L5
	subs	r2, r0, r4
	beq	.L7
.L6:
	subs	r3, r4, #1
	adds	r4, r3, r2
.L9:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	and	r1, r2, #251
	cmp	r1, #9
	it	ne
	cmpne	r2, #32
	bne	.L8
	cmp	r4, r3
	bne	.L9
.L11:
	cbz	r7, .L4
.L7:
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	adds	r4, r7, #1
	cmp	r3, #0
	bne	.L10
.L4:
	mov	r0, r6
	bl	free(PLT)
.L1:
	mov	r0, r5
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L8:
	adds	r5, r5, #1
	b	.L11
.L5:
	mov	r0, r4
	bl	strlen(PLT)
	mov	r2, r0
	cmp	r0, #0
	bne	.L6
	b	.L4
.L12:
	mov	r5, r6
	b	.L4
.L24:
	mov	r0, r6
	mov	r5, #-1
	bl	free(PLT)
	b	.L1
.L13:
	mov	r5, r3
	b	.L4
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"pacman -Qq\000"
	.align	2
.LC1:
	.ascii	"pacman -Qmq\000"
	.align	2
.LC2:
	.ascii	"pacman -Qeq\000"
	.align	2
.LC3:
	.ascii	"pacman -Qdtq\000"
	.align	2
.LC4:
	.ascii	"\033[1;31m[-] Could not query pacman package lists."
	.ascii	"\012\033[0m\000"
	.align	2
.LC5:
	.ascii	"r\000"
	.align	2
.LC6:
	.ascii	"/usr/local/emerge/world\000"
	.align	2
.LC7:
	.ascii	"1.0.0\000"
	.align	2
.LC8:
	.ascii	"Archtoo Emerge Engine\000"
	.align	2
.LC9:
	.ascii	"\033[1;36m%s v%s\012\033[0m\000"
	.align	2
.LC10:
	.ascii	"Installed packages : %ld\012\000"
	.align	2
.LC11:
	.ascii	"Explicit packages  : %ld\012\000"
	.align	2
.LC12:
	.ascii	"Foreign packages   : %ld\012\000"
	.align	2
.LC13:
	.ascii	"Orphaned packages  : %ld\012\000"
	.align	2
.LC14:
	.ascii	"@world entries     : %ld\012\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_stats_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_stats_v2, %function
cmd_stats_v2:
	@ args = 0, pretend = 0, frame = 256
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	ldr	r0, .L40
	sub	sp, sp, #256
	ldr	r5, .L40+4
.LPIC0:
	add	r0, pc
	bl	count_cmd_lines(PLT)
	mov	r9, r0
	ldr	r0, .L40+8
.LPIC4:
	add	r5, pc
.LPIC1:
	add	r0, pc
	bl	count_cmd_lines(PLT)
	mov	r7, r0
	ldr	r0, .L40+12
.LPIC2:
	add	r0, pc
	bl	count_cmd_lines(PLT)
	mov	r8, r0
	ldr	r0, .L40+16
.LPIC3:
	add	r0, pc
	bl	count_cmd_lines(PLT)
	cmp	r7, #-1
	it	ne
	cmpne	r9, #-1
	ite	eq
	moveq	r4, #1
	movne	r4, #0
	cmp	r8, #-1
	it	eq
	orreq	r4, r4, #1
	cmp	r4, #0
	bne	.L37
	ldr	r1, .L40+20
	bic	r6, r0, r0, asr #31
	ldr	r0, .L40+24
	mov	r10, sp
.LPIC6:
	add	r1, pc
.LPIC7:
	add	r0, pc
	bl	fopen64(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L38
	mov	r2, r5
	mov	r1, #256
	mov	r0, r10
	bl	fgets(PLT)
	cbz	r0, .L31
.L39:
	ldrb	r3, [r10]	@ zero_extendqisi2
	cmp	r3, #9
	it	ne
	cmpne	r3, #32
	it	eq
	moveq	ip, r10
	bne	.L32
.L30:
	ldrb	r3, [ip, #1]!	@ zero_extendqisi2
	cmp	r3, #9
	it	ne
	cmpne	r3, #32
	beq	.L30
.L32:
	cmp	r3, #0
	it	ne
	cmpne	r3, #35
	mov	r1, #256
	ite	ne
	movne	r2, #1
	moveq	r2, #0
	cmp	r3, #10
	ite	eq
	moveq	r2, #0
	andne	r2, r2, #1
	mov	r0, r10
	add	r4, r4, r2
	mov	r2, r5
	bl	fgets(PLT)
	cmp	r0, #0
	bne	.L39
.L31:
	mov	r0, r5
	bl	fclose(PLT)
.L29:
	ldr	r2, .L40+28
	ldr	r1, .L40+32
	ldr	r0, .L40+36
.LPIC8:
	add	r2, pc
.LPIC9:
	add	r1, pc
.LPIC10:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L40+40
	mov	r1, r9
.LPIC11:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L40+44
	mov	r1, r8
.LPIC12:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L40+48
	mov	r1, r7
.LPIC13:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L40+52
	mov	r1, r6
.LPIC14:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L40+56
	mov	r1, r4
.LPIC15:
	add	r0, pc
	bl	printf(PLT)
	movs	r0, #1
	add	sp, sp, #256
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L37:
	ldr	r3, .L40+60
	movs	r2, #53
	ldr	r0, .L40+64
	movs	r1, #1
.LPIC5:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	movs	r0, #0
	add	sp, sp, #256
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L38:
	mov	r4, r0
	b	.L29
.L41:
	.align	2
.L40:
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC4+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC8-(.LPIC9+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC10-(.LPIC11+4)
	.word	.LC11-(.LPIC12+4)
	.word	.LC12-(.LPIC13+4)
	.word	.LC13-(.LPIC14+4)
	.word	.LC14-(.LPIC15+4)
	.word	stderr(GOT)
	.word	.LC4-(.LPIC5+4)
	.section	.note.GNU-stack,"",%progbits
