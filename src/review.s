	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\033[1;31m[-] Review requires a directory.\012\033["
	.ascii	"0m\000"
	.align	2
.LC1:
	.ascii	"\033[1;31m[-] Directory does not exist: %s\012\033["
	.ascii	"0m\000"
	.align	2
.LC2:
	.ascii	"%s/PKGBUILD\000"
	.align	2
.LC3:
	.ascii	"\033[1;31m[-] No PKGBUILD in %s\012\033[0m\000"
	.align	2
.LC4:
	.ascii	"%s/.git\000"
	.align	2
.LC5:
	.ascii	"\033[1;36m>>> git diff (PKGBUILD / .SRCINFO)\012\033"
	.ascii	"[0m\000"
	.align	2
.LC6:
	.ascii	"git -C %s diff -- PKGBUILD .SRCINFO\000"
	.align	2
.LC7:
	.ascii	"%s/.SRCINFO\000"
	.align	2
.LC8:
	.ascii	"\033[1;36m>>> .SRCINFO\012\033[0m\000"
	.align	2
.LC9:
	.ascii	"sed -n '1,120p' %s/.SRCINFO\000"
	.align	2
.LC10:
	.ascii	"\033[1;36m>>> PKGBUILD\012\033[0m\000"
	.align	2
.LC11:
	.ascii	"sed -n '1,240p' %s/PKGBUILD\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_review_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_review_v2, %function
cmd_review_v2:
	@ args = 0, pretend = 0, frame = 6672
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r5, .L30
	sub	sp, sp, #6656
	sub	sp, sp, #16
.LPIC0:
	add	r5, pc
	cmp	r0, #0
	beq	.L2
	ldrb	r3, [r0]	@ zero_extendqisi2
	mov	r4, r0
	cmp	r3, #0
	beq	.L2
	movs	r1, #10
	bl	strchr(PLT)
	cbz	r0, .L26
.L4:
	movs	r0, #0
.L1:
	add	sp, sp, #6656
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L26:
	movs	r1, #13
	mov	r0, r4
	bl	strchr(PLT)
	cmp	r0, #0
	bne	.L4
	mov	r0, r4
	bl	dir_exists(PLT)
	cmp	r0, #0
	beq	.L27
	ldr	r2, .L30+4
	add	r6, sp, #1024
	mov	r3, r4
	mov	r1, #1200
.LPIC3:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L28
	mov	r2, #1024
	mov	r1, sp
	mov	r0, r4
	mov	r5, sp
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L4
	ldr	r2, .L30+8
	add	r6, sp, #3424
	mov	r3, r4
	mov	r1, #1200
.LPIC5:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	dir_exists(PLT)
	cmp	r0, #0
	bne	.L23
	add	r6, sp, #4608
	adds	r6, r6, #16
.L10:
	ldr	r2, .L30+12
	mov	r3, r4
	add	r4, sp, #2224
	mov	r1, #1200
.LPIC8:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	file_exists(PLT)
	cbnz	r0, .L29
.L11:
	ldr	r0, .L30+16
.LPIC11:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L30+20
	mov	r3, r5
	mov	r1, #2048
.LPIC12:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L1
.L2:
	ldr	r3, .L30+24
	movs	r2, #44
	ldr	r0, .L30+28
	movs	r1, #1
.LPIC1:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L4
.L28:
	ldr	r3, .L30+24
	mov	r2, r4
	ldr	r1, .L30+32
.LPIC4:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L4
.L27:
	ldr	r3, .L30+24
	mov	r2, r4
	ldr	r1, .L30+36
.LPIC2:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L4
.L29:
	ldr	r0, .L30+40
.LPIC9:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L30+44
	mov	r3, r5
	mov	r1, #2048
.LPIC10:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	b	.L11
.L23:
	ldr	r0, .L30+48
	add	r6, sp, #4608
	adds	r6, r6, #16
.LPIC6:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L30+52
	mov	r3, sp
	mov	r1, #2048
.LPIC7:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	b	.L10
.L31:
	.align	2
.L30:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC0+4)
	.word	.LC2-(.LPIC3+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC10-(.LPIC11+4)
	.word	.LC11-(.LPIC12+4)
	.word	stderr(GOT)
	.word	.LC0-(.LPIC1+4)
	.word	.LC3-(.LPIC4+4)
	.word	.LC1-(.LPIC2+4)
	.word	.LC8-(.LPIC9+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.section	.note.GNU-stack,"",%progbits
