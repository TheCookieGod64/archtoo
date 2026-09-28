	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"pacman -Qmq\000"
	.align	2
.LC1:
	.ascii	"\033[1;31m[-] Could not list foreign packages.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC2:
	.ascii	"\033[1;36m>>> Development / VCS packages (-git/-hg/"
	.ascii	"-svn/-bzr/-cvs)\012\033[0m\000"
	.align	2
.LC3:
	.ascii	"-git\000"
	.align	2
.LC4:
	.ascii	"-hg\000"
	.align	2
.LC5:
	.ascii	"-svn\000"
	.align	2
.LC6:
	.ascii	"-bzr\000"
	.align	2
.LC7:
	.ascii	"-cvs\000"
	.align	2
.LC8:
	.ascii	"No development packages installed.\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_devel_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_devel_v2, %function
cmd_devel_v2:
	@ args = 0, pretend = 0, frame = 168
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	movs	r7, #0
	ldr	r0, .L36
	sub	sp, sp, #168
	ldr	r4, .L36+4
.LPIC0:
	add	r0, pc
	add	r1, sp, #4
.LPIC1:
	add	r4, pc
	str	r7, [sp, #4]
	bl	run_cmd_capture(PLT)
	cmp	r0, #1
	bhi	.L32
	ldr	r0, .L36+8
.LPIC3:
	add	r0, pc
	bl	printf(PLT)
	ldr	r6, [sp, #4]
	cmp	r6, #0
	beq	.L4
	ldrb	r3, [r6]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L4
	ldr	r8, .L36+12
	ldr	r9, .L36+16
.LPIC4:
	add	r8, pc
.LPIC5:
	add	r9, pc
	b	.L5
.L33:
	subs	r5, r0, r6
	subs	r3, r5, #1
	cmp	r3, #158
	bls	.L8
.L9:
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	adds	r6, r4, #1
	cbz	r3, .L13
.L5:
	movs	r1, #10
	mov	r0, r6
	bl	strchr(PLT)
	mov	r4, r0
	cmp	r0, #0
	bne	.L33
	mov	r0, r6
	bl	strlen(PLT)
	subs	r3, r0, #1
	mov	r5, r0
	cmp	r3, #158
	bls	.L8
.L13:
	ldr	r0, [sp, #4]
	bl	free(PLT)
	cmp	r7, #0
	beq	.L6
	movs	r0, #1
.L35:
	add	sp, sp, #168
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L8:
	add	r10, sp, #8
	mov	r2, r5
	add	r5, sp, r5
	mov	r1, r6
	mov	r0, r10
	bl	memcpy(PLT)
	mov	r1, r8
	mov	r0, r10
	movs	r3, #0
	strb	r3, [r5, #8]
	bl	strstr(PLT)
	cbz	r0, .L34
.L11:
	mov	r0, r10
	movs	r7, #1
	bl	puts(PLT)
	cmp	r4, #0
	bne	.L9
	b	.L13
.L34:
	mov	r1, r9
	mov	r0, r10
	bl	strstr(PLT)
	cmp	r0, #0
	bne	.L11
	ldr	r1, .L36+20
	mov	r0, r10
.LPIC6:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	bne	.L11
	ldr	r1, .L36+24
	mov	r0, r10
.LPIC7:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	bne	.L11
	ldr	r1, .L36+28
	mov	r0, r10
.LPIC8:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	bne	.L11
	cmp	r4, #0
	bne	.L9
	b	.L13
.L32:
	ldr	r3, .L36+32
	movs	r2, #48
	ldr	r0, .L36+36
	movs	r1, #1
.LPIC2:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	ldr	r0, [sp, #4]
	bl	free(PLT)
	mov	r0, r7
	add	sp, sp, #168
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L4:
	mov	r0, r6
	bl	free(PLT)
.L6:
	ldr	r0, .L36+40
.LPIC9:
	add	r0, pc
	bl	puts(PLT)
	movs	r0, #1
	b	.L35
.L37:
	.align	2
.L36:
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	.LC2-(.LPIC3+4)
	.word	.LC3-(.LPIC4+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC7-(.LPIC8+4)
	.word	stderr(GOT)
	.word	.LC1-(.LPIC2+4)
	.word	.LC8-(.LPIC9+4)
	.section	.note.GNU-stack,"",%progbits
