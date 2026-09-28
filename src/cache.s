	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	" --noconfirm\000"
	.align	2
.LC1:
	.ascii	"\000"
	.align	2
.LC2:
	.ascii	"\033[1;34m>>> Removing leftover pacman download fra"
	.ascii	"gments...\012\033[0m\000"
	.align	2
.LC3:
	.ascii	"find /var/cache/pacman/pkg -maxdepth 1 \\( -type f "
	.ascii	"-o -type d \\) -name 'download-*' -exec rm -rf {} +"
	.ascii	" 2>/dev/null || true\000"
	.align	2
.LC4:
	.ascii	"\033[1;34m>>> Cleaning uninstalled package cache..."
	.ascii	"\012\033[0m\000"
	.align	2
.LC5:
	.ascii	"%spacman -Sc%s\000"
	.align	2
.LC6:
	.ascii	"\033[1;31m[-] pacman cache clean failed (exit %d).\012"
	.ascii	"\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_clean_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_clean_v2, %function
cmd_clean_v2:
	@ args = 0, pretend = 0, frame = 512
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	ldr	r0, .L9
	sub	sp, sp, #524
	ldr	r5, .L9+4
.LPIC2:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L9+8
.LPIC7:
	add	r5, pc
.LPIC3:
	add	r0, pc
	bl	run_cmd(PLT)
	ldr	r0, .L9+12
.LPIC4:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	mov	r4, r0
	bl	use_noconfirm(PLT)
	cbz	r0, .L4
	ldr	r1, .L9+16
.LPIC0:
	add	r1, pc
.L2:
	ldr	r2, .L9+20
	mov	r3, r4
	add	r4, sp, #8
	str	r1, [sp]
.LPIC5:
	add	r2, pc
	mov	r1, #512
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	cbnz	r0, .L8
	movs	r0, #1
	add	sp, sp, #524
	@ sp needed
	pop	{r4, r5, pc}
.L4:
	ldr	r1, .L9+24
.LPIC1:
	add	r1, pc
	b	.L2
.L8:
	ldr	r3, .L9+28
	mov	r2, r0
	ldr	r1, .L9+32
.LPIC6:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	movs	r0, #0
	add	sp, sp, #524
	@ sp needed
	pop	{r4, r5, pc}
.L10:
	.align	2
.L9:
	.word	.LC2-(.LPIC2+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC7+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC5-(.LPIC5+4)
	.word	.LC1-(.LPIC1+4)
	.word	stderr(GOT)
	.word	.LC6-(.LPIC6+4)
	.section	.note.GNU-stack,"",%progbits
