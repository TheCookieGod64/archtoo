	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"pacman -Qdtq\000"
	.align	2
.LC1:
	.ascii	"No orphaned packages.\000"
	.align	2
.LC2:
	.ascii	"\033[1;31m[-] Could not query orphaned packages.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC3:
	.ascii	"\033[1;36m>>> Orphaned dependencies (installed as d"
	.ascii	"eps, required by none)\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_orphans_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_orphans_v2, %function
cmd_orphans_v2:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r3, #0
	ldr	r0, .L18
	sub	sp, sp, #12
	ldr	r4, .L18+4
.LPIC0:
	add	r0, pc
	add	r1, sp, #4
.LPIC2:
	add	r4, pc
	str	r3, [sp, #4]
	bl	run_cmd_capture(PLT)
	cmp	r0, #1
	bhi	.L2
	ldr	r3, [sp, #4]
	cbz	r3, .L3
	ldrb	r3, [r3]	@ zero_extendqisi2
	cbz	r3, .L3
	cbnz	r0, .L2
	ldr	r0, .L18+8
.LPIC4:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, .L18+12
	ldr	r0, [sp, #4]
	ldr	r5, [r4, r3]
	ldr	r1, [r5]
	bl	fputs(PLT)
	ldr	r4, [sp, #4]
	mov	r0, r4
	bl	strlen(PLT)
	add	r0, r0, r4
	ldrb	r3, [r0, #-1]	@ zero_extendqisi2
	cmp	r3, #10
	bne	.L17
	mov	r0, r4
	bl	free(PLT)
	b	.L5
.L3:
	ldr	r0, .L18+16
.LPIC1:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, [sp, #4]
	bl	free(PLT)
.L5:
	movs	r0, #1
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L2:
	ldr	r3, .L18+20
	movs	r2, #50
	ldr	r0, .L18+24
	movs	r1, #1
.LPIC3:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	ldr	r0, [sp, #4]
	bl	free(PLT)
	movs	r0, #0
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L17:
	ldr	r1, [r5]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r4, [sp, #4]
	mov	r0, r4
	bl	free(PLT)
	b	.L5
.L19:
	.align	2
.L18:
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+4)
	.word	.LC3-(.LPIC4+4)
	.word	stdout(GOT)
	.word	.LC1-(.LPIC1+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC3+4)
	.section	.note.GNU-stack,"",%progbits
