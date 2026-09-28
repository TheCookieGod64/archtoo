	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\000"
	.align	2
.LC1:
	.ascii	" --noconfirm --ask=6\000"
	.align	2
.LC2:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC3:
	.ascii	"\033[1;34m>>> Installing repository package %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC4:
	.ascii	"%spacman -S --needed%s -- %s\000"
	.align	2
.LC5:
	.ascii	"\033[1;31m[-] Could not install '%s' from repositor"
	.ascii	"ies.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_repo_install_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_repo_install_v2, %function
cmd_repo_install_v2:
	@ args = 0, pretend = 0, frame = 960
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r4, r0
	ldr	r5, .L16
	sub	sp, sp, #972
.LPIC3:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L2
	ldr	r3, .L16+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	cbz	r4, .L13
.L3:
	ldr	r1, .L16+8
	mov	r2, r4
.LPIC4:
	add	r1, pc
	bl	fprintf(PLT)
.L4:
	movs	r0, #0
	add	sp, sp, #972
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L2:
	add	r6, sp, #8
	mov	r2, #320
	mov	r1, r6
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L4
	ldr	r0, .L16+12
	mov	r1, r4
.LPIC5:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	mov	r7, r0
	bl	use_noconfirm(PLT)
	cbnz	r0, .L14
	ldr	r1, .L16+16
.LPIC2:
	add	r1, pc
.L7:
	ldr	r2, .L16+20
	mov	r3, r7
	str	r6, [sp, #4]
	add	r6, sp, #328
	str	r1, [sp]
.LPIC6:
	add	r2, pc
	mov	r1, #640
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	cbnz	r0, .L15
	movs	r0, #1
	add	sp, sp, #972
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L13:
	ldr	r4, .L16+24
.LPIC0:
	add	r4, pc
	b	.L3
.L14:
	ldr	r1, .L16+28
.LPIC1:
	add	r1, pc
	b	.L7
.L15:
	ldr	r3, .L16+4
	mov	r2, r4
	ldr	r1, .L16+32
.LPIC7:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L4
.L17:
	.align	2
.L16:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC4+4)
	.word	.LC3-(.LPIC5+4)
	.word	.LC0-(.LPIC2+4)
	.word	.LC4-(.LPIC6+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC5-(.LPIC7+4)
	.section	.note.GNU-stack,"",%progbits
