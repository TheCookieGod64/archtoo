	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\000"
	.align	2
.LC1:
	.ascii	"?\000"
	.align	2
.LC2:
	.ascii	"\033[1;31m[-] Invalid search query: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC3:
	.ascii	"\033[1;36m>>> Repositories\012\033[0m\000"
	.align	2
.LC4:
	.ascii	"pacman -Ss -- %s\000"
	.align	2
.LC5:
	.ascii	"    (no repository matches)\000"
	.align	2
.LC6:
	.ascii	"\033[1;36m>>> AUR\012\033[0m\000"
	.align	2
.LC7:
	.ascii	"    (no AUR matches)\000"
	.align	2
.LC8:
	.ascii	"aur/%s %s\000"
	.align	2
.LC9:
	.ascii	" (%ld votes)\000"
	.align	2
.LC10:
	.ascii	"    %s\012\000"
	.align	2
.LC11:
	.ascii	"\033[1;33m[!] AUR RPC: %s\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_search_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_search_v2, %function
cmd_search_v2:
	@ args = 0, pretend = 0, frame = 1104
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r1, #0
	mov	r4, r0
	subw	sp, sp, #1116
	mov	r2, #256
	add	r9, sp, #24
	add	r5, sp, #16
	mov	r0, r9
	ldr	r6, .L43
	str	r1, [sp, #12]
	bl	memset(PLT)
	vmov.i32	d16, #0  @ v8qi
	mov	r0, r4
	add	r7, sp, #12
.LPIC3:
	add	r6, pc
	vstr	d16, [r5]
	bl	valid_search_query(PLT)
	cbnz	r0, .L2
	ldr	r3, .L43+4
	ldr	r3, [r6, r3]
	ldr	r0, [r3]
	cmp	r4, #0
	beq	.L38
.L3:
	ldr	r1, .L43+8
	mov	r2, r4
.LPIC4:
	add	r1, pc
	bl	fprintf(PLT)
.L4:
	movs	r7, #0
	mov	r0, r7
	addw	sp, sp, #1116
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L2:
	add	r8, sp, #280
	mov	r2, #320
	mov	r1, r8
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L4
	ldr	r0, .L43+12
.LPIC5:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L43+16
	mov	r3, r8
	add	r8, sp, #600
	mov	r1, #512
.LPIC6:
	add	r2, pc
	mov	r0, r8
	bl	xsnprintf(PLT)
	mov	r1, r7
	mov	r0, r8
	bl	run_cmd_capture(PLT)
	cbnz	r0, .L7
	ldr	r0, [r7]
	cbz	r0, .L7
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L39
.L7:
	ldr	r0, .L43+20
.LPIC7:
	add	r0, pc
	bl	puts(PLT)
	ldr	r10, [r7]
	movs	r7, #0
.L8:
	mov	r0, r10
	bl	free(PLT)
	ldr	r0, .L43+24
.LPIC8:
	add	r0, pc
	bl	printf(PLT)
	bl	config_current(PLT)
	mov	r3, #256
	mov	r1, r4
	str	r3, [sp]
	adds	r0, r0, #16
	mov	r3, r9
	mov	r2, r5
	bl	aur_rpc_search(PLT)
	cmp	r0, #0
	beq	.L9
	ldr	r3, [r5, #4]
	cmp	r3, #0
	beq	.L40
	ldr	r3, .L43+28
	movs	r4, #0
	ldr	fp, .L43+32
	mov	r7, r4
	ldr	r10, .L43+36
	ldr	r9, .L43+40
.LPIC1:
	add	fp, pc
	ldr	r8, [r6, r3]
.LPIC2:
	add	r10, pc
.LPIC10:
	add	r9, pc
	b	.L10
.L14:
	ldr	r1, [r8]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r1, [r6, #12]
	cbz	r1, .L15
	ldrb	r3, [r1]	@ zero_extendqisi2
	cbnz	r3, .L41
.L15:
	ldr	r3, [r5, #4]
	adds	r7, r7, #1
	adds	r4, r4, #88
	cmp	r3, r7
	bls	.L42
.L10:
	ldr	r3, [r5]
	mov	r0, r9
	adds	r6, r3, r4
	ldr	r1, [r3, r4]
	ldr	r2, [r6, #8]
	cmp	r1, #0
	it	eq
	moveq	r1, fp
	cmp	r2, #0
	it	eq
	moveq	r2, r10
	bl	printf(PLT)
	ldr	r1, [r6, #24]
	cmp	r1, #0
	beq	.L14
	ldr	r0, .L43+44
.LPIC11:
	add	r0, pc
	bl	printf(PLT)
	b	.L14
.L38:
	ldr	r4, .L43+48
.LPIC0:
	add	r4, pc
	b	.L3
.L9:
	ldr	r3, .L43+4
	mov	r2, r9
	ldr	r1, .L43+52
.LPIC13:
	add	r1, pc
	ldr	r3, [r6, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L11:
	mov	r0, r5
	bl	aur_response_destroy(PLT)
	mov	r0, r7
	addw	sp, sp, #1116
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L41:
	ldr	r0, .L43+56
.LPIC12:
	add	r0, pc
	bl	printf(PLT)
	b	.L15
.L42:
	movs	r7, #1
	b	.L11
.L40:
	ldr	r0, .L43+60
.LPIC9:
	add	r0, pc
	bl	puts(PLT)
	b	.L11
.L39:
	ldr	r3, .L43+28
	ldr	r8, [r6, r3]
	ldr	r1, [r8]
	bl	fputs(PLT)
	ldr	r10, [r7]
	mov	r0, r10
	bl	strlen(PLT)
	add	r0, r0, r10
	ldrb	r3, [r0, #-1]	@ zero_extendqisi2
	cmp	r3, #10
	it	eq
	moveq	r7, #1
	beq	.L8
	ldr	r1, [r8]
	movs	r0, #10
	bl	putc(PLT)
	ldr	r10, [r7]
	movs	r7, #1
	b	.L8
.L44:
	.align	2
.L43:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC4+4)
	.word	.LC3-(.LPIC5+4)
	.word	.LC4-(.LPIC6+4)
	.word	.LC5-(.LPIC7+4)
	.word	.LC6-(.LPIC8+4)
	.word	stdout(GOT)
	.word	.LC1-(.LPIC1+4)
	.word	.LC0-(.LPIC2+4)
	.word	.LC8-(.LPIC10+4)
	.word	.LC9-(.LPIC11+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC11-(.LPIC13+4)
	.word	.LC10-(.LPIC12+4)
	.word	.LC7-(.LPIC9+4)
	.section	.note.GNU-stack,"",%progbits
