	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	trim_copy, %function
trim_copy:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, r0
	mov	r4, r1
	cbz	r1, .L2
	bl	__ctype_b_loc(PLT)
	mov	r3, r5
	ldr	r1, [r0]
	b	.L3
.L4:
	subs	r4, r4, #1
	beq	.L19
.L3:
	mov	r5, r3
	ldrb	r2, [r3], #1	@ zero_extendqisi2
	ldrh	r2, [r1, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L4
.L2:
	adds	r6, r5, r4
.L6:
	cbz	r4, .L8
.L21:
	bl	__ctype_b_loc(PLT)
	ldrb	r2, [r6, #-1]!	@ zero_extendqisi2
	ldr	r3, [r0]
	subs	r1, r4, #1
	ldrh	r3, [r3, r2, lsl #1]
	lsls	r3, r3, #18
	bpl	.L20
	mov	r4, r1
	cmp	r4, #0
	bne	.L21
.L8:
	movs	r0, #1
.L5:
	bl	malloc(PLT)
	mov	r6, r0
	cbz	r0, .L1
	mov	r2, r4
	mov	r1, r5
	bl	memcpy(PLT)
	movs	r3, #0
	strb	r3, [r6, r4]
.L1:
	mov	r0, r6
	pop	{r4, r5, r6, pc}
.L20:
	adds	r0, r4, #1
	b	.L5
.L19:
	mov	r5, r3
	adds	r6, r5, r4
	b	.L6
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"repo\000"
	.align	2
.LC1:
	.ascii	"\000"
	.align	2
.LC2:
	.ascii	"(package)\000"
	.align	2
.LC3:
	.ascii	"(provides)\000"
	.align	2
.LC4:
	.ascii	"pacman -Ssq -- %s\000"
	.align	2
.LC5:
	.ascii	"pacman -Si --\000"
	.align	2
.LC6:
	.ascii	"\012Repository\000"
	.align	2
.LC7:
	.ascii	"Repository\000"
	.align	2
.LC8:
	.ascii	"\012Name\000"
	.align	2
.LC9:
	.ascii	"\012Version\000"
	.align	2
.LC10:
	.ascii	"\012Provides\000"
	.align	2
.LC11:
	.ascii	"None\000"
	.align	2
.LC12:
	.ascii	" \011\000"
	.align	2
.LC13:
	.ascii	"%s/%s %s  %s\012\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	print_repo_providers, %function
print_repo_providers:
	@ args = 0, pretend = 0, frame = 5120
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r5, #0
	mov	r2, #320
	sub	sp, sp, #5120
	sub	sp, sp, #12
	add	fp, sp, #1032
	sub	r3, fp, #968
	sub	r4, fp, #972
	str	r0, [sp, #12]
	str	r5, [r3]
	add	r3, sp, #72
	mov	r1, r3
	mov	r6, r3
	str	r5, [r4]
	str	r3, [sp, #16]
	bl	shell_quote(PLT)
	cbnz	r0, .L154
.L24:
	movs	r4, #0
	mov	r0, r4
	add	sp, sp, #5120
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L154:
	ldr	r2, .L166
	mov	r3, r6
	mov	r1, #4096
	mov	r0, fp
.LPIC21:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r1, r4
	mov	r0, fp
	bl	run_cmd_capture(PLT)
	ldr	r6, [r4]
	cmp	r6, #0
	beq	.L24
	ldrb	r3, [r6]	@ zero_extendqisi2
	add	r7, sp, #712
	mov	r8, r5
	cmp	r3, #0
	beq	.L155
	movs	r1, #10
	mov	r0, r6
	bl	strchr(PLT)
	mov	r4, r0
	cbz	r0, .L27
.L156:
	sub	r9, r0, r6
	add	r3, r9, #-1
	cmp	r3, #158
	bls	.L28
.L85:
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	mov	r9, r5
	adds	r6, r4, #1
	cbz	r3, .L30
.L29:
	movs	r1, #10
	mov	r0, r6
	bl	strchr(PLT)
	mov	r5, r9
	mov	r4, r0
	cmp	r0, #0
	bne	.L156
.L27:
	mov	r0, r6
	bl	strlen(PLT)
	subs	r3, r0, #1
	mov	r7, r0
	cmp	r3, #158
	bls	.L157
.L30:
	mov	r9, r5
.L91:
	sub	r3, fp, #972
	ldr	r0, [r3]
	bl	free(PLT)
	cmp	r9, #0
	beq	.L24
	add	r10, sp, #392
	b	.L89
.L157:
	mov	r1, r6
	add	r6, sp, #712
	mov	r2, r0
	mov	r0, r6
	bl	memcpy(PLT)
	mov	r0, r6
	strb	r4, [r6, r7]
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L30
	mov	r0, r6
	add	r10, sp, #392
	bl	strdup(PLT)
	sub	r2, fp, #972
	mov	r3, r0
	add	r9, r5, #1
	str	r3, [r10, r5, lsl #2]
	ldr	r0, [r2]
	bl	free(PLT)
.L89:
	ldr	r3, .L166+4
	mov	ip, fp
	sub	r10, r10, #4
	movs	r6, #13
.LPIC22:
	add	r3, pc
	add	r8, r10, r9, lsl #2
	mov	r4, r10
	add	r5, sp, #712
	movs	r7, #32
	ldm	r3, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2}
	strh	r3, [ip]	@ movhi
.L41:
	ldr	r0, [r4, #4]!
	mov	r2, #320
	mov	r1, r5
	cbz	r0, .L37
	bl	shell_quote(PLT)
	mov	r3, r0
	mov	r0, r5
	cbz	r3, .L37
	bl	strlen(PLT)
	adds	r3, r6, #1
	add	r9, r0, r3
	mov	r2, r0
	cmp	r9, #4096
	add	r0, fp, r3
	bcs	.L40
	strb	r7, [fp, r6]
	mov	r1, r5
	mov	r6, r9
	bl	memcpy(PLT)
	movs	r3, #0
	strb	r3, [fp, r9]
.L37:
	cmp	r8, r4
	bne	.L41
.L40:
	ldr	r3, [sp, #16]
	mov	r0, fp
	sub	r1, r3, #8
	bl	run_cmd_capture(PLT)
	sub	r3, fp, #968
	mov	r4, r0
	ldr	r5, [r3]
	cbz	r0, .L158
	movs	r4, #0
.L42:
	mov	r0, r5
	bl	free(PLT)
.L81:
	ldr	r0, [r10, #4]!
	bl	free(PLT)
	cmp	r8, r10
	bne	.L81
	mov	r0, r4
	add	sp, sp, #5120
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L28:
	mov	r2, r9
	mov	r1, r6
	mov	r0, r7
	bl	memcpy(PLT)
	mov	r0, r7
	strb	r8, [r7, r9]
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L85
	mov	r0, r7
	add	r10, sp, #392
	bl	strdup(PLT)
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	add	r9, r5, #1
	adds	r6, r4, #1
	str	r0, [r10, r5, lsl #2]
	cmp	r3, #0
	beq	.L91
	cmp	r9, #80
	bne	.L29
	sub	r3, fp, #972
	ldr	r0, [r3]
	bl	free(PLT)
	b	.L89
.L158:
	cmp	r5, #0
	beq	.L42
	ldrb	r3, [r5]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L42
	ldr	r3, .L166+8
	str	r0, [sp, #32]
.LPIC23:
	add	r3, pc
	str	r3, [sp, #20]
	ldr	r3, .L166+12
	strd	r8, r10, [sp, #40]
.LPIC25:
	add	r3, pc
	str	r3, [sp, #24]
	ldr	r3, .L166+16
	str	fp, [sp, #36]
.LPIC26:
	add	r3, pc
	str	r3, [sp, #28]
.L80:
	ldr	r1, [sp, #20]
	mov	r0, r5
	bl	strstr(PLT)
	mov	r4, r0
	cmp	r0, r5
	beq	.L159
.L43:
	mov	r8, r4
	cmp	r4, #0
	beq	.L160
.L44:
	ldr	r1, [sp, #24]
	mov	r0, r5
	bl	strstr(PLT)
	ldr	r1, [sp, #28]
	mov	fp, r0
	mov	r0, r5
	bl	strstr(PLT)
	ldr	r1, .L166+20
	mov	r7, r0
	mov	r0, r5
.LPIC27:
	add	r1, pc
	bl	strstr(PLT)
	ldr	r1, .L166+24
	mov	r10, r0
	mov	r0, r5
.LPIC28:
	add	r1, pc
	bl	strstr(PLT)
	cmp	fp, #0
	it	ne
	cmpne	r8, fp
	mov	r9, r0
	ite	hi
	movhi	r6, #1
	movls	r6, #0
	bls	.L45
	mov	r0, fp
	movs	r1, #58
	bl	strchr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	mov	r5, r0
	ite	hi
	movhi	r6, #1
	movls	r6, #0
	bls	.L45
	movs	r1, #10
	adds	r6, r5, #1
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L46
	subs	r0, r0, r5
	subs	r1, r0, #1
.L47:
	mov	r0, r6
	bl	trim_copy(PLT)
	mov	r6, r0
.L45:
	cmp	r10, #0
	it	ne
	cmpne	r8, r10
	ite	hi
	movhi	r5, #1
	movls	r5, #0
	cmp	r7, #0
	it	ne
	cmpne	r8, r7
	bls	.L151
	mov	r0, r7
	movs	r1, #58
	bl	strchr(PLT)
	mov	r7, r0
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	bls	.L151
	movs	r1, #10
	add	fp, r7, #1
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L52
	subs	r0, r0, r7
	subs	r1, r0, #1
.L53:
	mov	r0, fp
	bl	trim_copy(PLT)
	mov	r7, r0
	cbz	r5, .L54
	mov	r0, r10
	movs	r1, #58
	bl	strchr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	mov	r10, r0
	ite	hi
	movhi	r5, #1
	movls	r5, #0
	bhi	.L83
.L54:
	cmp	r9, #0
	it	ne
	cmpne	r8, r9
	ite	hi
	movhi	r10, #1
	movls	r10, #0
	cmp	r7, #0
	beq	.L50
	ldr	r1, [sp, #12]
	mov	r0, r7
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L60
	cmp	r10, #0
	beq	.L59
	mov	r0, r9
	movs	r1, #58
	bl	strchr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	mov	r10, r0
	it	hi
	movhi	r9, #0
	bls	.L59
.L82:
	movs	r1, #10
	mov	r0, r10
	add	r8, r10, #1
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L67
	sub	r0, r0, r10
	subs	r1, r0, #1
.L68:
	mov	r0, r8
	bl	trim_copy(PLT)
	mov	fp, r0
	cbz	r0, .L69
	ldr	r1, .L166+28
.LPIC29:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L161
.L69:
	mov	r0, fp
	bl	free(PLT)
	cbz	r7, .L59
	cmp	r9, #0
	beq	.L59
.L88:
	cmp	r6, #0
	beq	.L162
	ldrb	r3, [r6]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L76
	cmp	r5, #0
	beq	.L163
	ldr	r1, .L166+32
	mov	r3, r5
.LPIC13:
	add	r1, pc
.L65:
	ldr	r2, .L166+36
.LPIC14:
	add	r2, pc
.L66:
	ldr	r0, .L166+40
	str	r2, [sp]
	mov	r2, r7
.LPIC32:
	add	r0, pc
	bl	printf(PLT)
	movs	r3, #1
	str	r3, [sp, #32]
.L59:
	mov	r0, r7
	bl	free(PLT)
	mov	r0, r5
	bl	free(PLT)
	mov	r0, r6
	bl	free(PLT)
	cbz	r4, .L153
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	adds	r5, r4, #1
	cmp	r3, #0
	bne	.L80
.L153:
	ldr	fp, [sp, #36]
	ldrd	r8, r10, [sp, #40]
	sub	r3, fp, #968
	ldr	r4, [sp, #32]
	ldr	r5, [r3]
	b	.L42
.L151:
	cbnz	r5, .L49
.L50:
	cmp	r9, #0
	it	ne
	cmpne	r8, r9
	ite	hi
	movhi	r7, #1
	movls	r7, #0
	bls	.L59
	mov	r0, r9
	movs	r1, #58
	bl	strchr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	it	ls
	movls	r8, #0
	mov	r10, r0
	ite	hi
	movhi	r8, #1
	movls	r7, r8
	bls	.L59
	mov	r9, #0
	mov	r7, r9
	b	.L82
.L49:
	mov	r0, r10
	movs	r1, #58
	bl	strchr(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r8, r0
	mov	r10, r0
	itet	hi
	movhi	r5, #1
	movls	r5, #0
	movhi	r7, #0
	bls	.L50
.L83:
	movs	r1, #10
	mov	r0, r10
	add	r5, r10, #1
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L55
	sub	r0, r0, r10
	subs	r1, r0, #1
.L56:
	mov	r0, r5
	bl	trim_copy(PLT)
	mov	r5, r0
	b	.L54
.L60:
	cmp	r10, #0
	bne	.L62
	cmp	r6, #0
	beq	.L63
	ldrb	r3, [r6]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L64
	cmp	r5, #0
	beq	.L100
.L152:
	mov	r3, r5
	mov	r1, r6
	b	.L65
.L160:
	mov	r0, r5
	bl	strlen(PLT)
	add	r8, r5, r0
	b	.L44
.L159:
	ldr	r1, [sp, #20]
	adds	r0, r5, #1
	bl	strstr(PLT)
	mov	r4, r0
	b	.L43
.L62:
	mov	r0, r9
	movs	r1, #58
	bl	strchr(PLT)
	mov	r10, r0
	cmp	r0, #0
	it	ne
	cmpne	r0, r8
	bcs	.L88
	mov	r9, #1
	b	.L82
.L76:
	cmp	r5, #0
	bne	.L152
	ldr	r3, .L166+44
	mov	r1, r6
.LPIC8:
	add	r3, pc
	b	.L65
.L67:
	mov	r0, r8
	bl	strlen(PLT)
	mov	r1, r0
	b	.L68
.L52:
	mov	r0, fp
	bl	strlen(PLT)
	mov	r1, r0
	b	.L53
.L46:
	mov	r0, r6
	bl	strlen(PLT)
	mov	r1, r0
	b	.L47
.L55:
	mov	r0, r5
	bl	strlen(PLT)
	mov	r1, r0
	b	.L56
.L162:
	cmp	r5, #0
	beq	.L164
	ldr	r1, .L166+48
	mov	r3, r5
.LPIC10:
	add	r1, pc
	b	.L65
.L64:
	cmp	r5, #0
	beq	.L101
	ldr	r1, .L166+52
	mov	r3, r5
.LPIC9:
	add	r1, pc
	b	.L65
.L155:
	mov	r0, r6
	bl	free(PLT)
	b	.L24
.L161:
	ldr	r3, [sp, #36]
	mov	r0, fp
	ldr	r1, .L166+56
	sub	ip, r3, #964
	ldr	r3, [sp, #16]
.LPIC30:
	add	r1, pc
	sub	r10, r3, #4
	movs	r3, #0
	mov	r2, r10
	str	r3, [ip]
	bl	strtok_r(PLT)
	cmp	r0, #0
	beq	.L69
	ldr	r3, .L166+60
	add	r8, sp, #712
	strd	r4, r5, [sp, #48]
.LPIC31:
	add	r3, pc
	ldr	r4, [sp, #12]
	mov	r5, r3
.L73:
	mov	r1, r8
	mov	r2, #256
	bl	dep_basename(PLT)
	ldrb	r3, [r8]	@ zero_extendqisi2
	mov	r1, r4
	cbz	r3, .L71
	mov	r0, r8
	bl	strcmp(PLT)
	cbnz	r0, .L71
	mov	r0, fp
	ldrd	r4, r5, [sp, #48]
	bl	free(PLT)
	cmp	r7, #0
	beq	.L59
	cmp	r6, #0
	beq	.L106
	ldrb	r3, [r6]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L107
	ldr	r1, .L166+64
.LPIC1:
	add	r1, pc
.L77:
	mov	r3, r5
	cmp	r5, #0
	beq	.L165
.L78:
	ldr	r2, .L166+68
.LPIC15:
	add	r2, pc
	cmp	r9, #0
	beq	.L66
	b	.L65
.L71:
	mov	r2, r10
	mov	r1, r5
	movs	r0, #0
	bl	strtok_r(PLT)
	cmp	r0, #0
	bne	.L73
	ldrd	r4, r5, [sp, #48]
	b	.L69
.L63:
	cbz	r5, .L102
	ldr	r1, .L166+72
	mov	r3, r5
	ldr	r2, .L166+76
.LPIC19:
	add	r1, pc
.LPIC20:
	add	r2, pc
	b	.L66
.L163:
	ldr	r3, .L166+80
	ldr	r1, .L166+84
.LPIC11:
	add	r3, pc
.LPIC12:
	add	r1, pc
	b	.L65
.L164:
	ldr	r3, .L166+88
	ldr	r1, .L166+92
.LPIC5:
	add	r3, pc
.LPIC6:
	add	r1, pc
	b	.L65
.L100:
	ldr	r3, .L166+96
	mov	r1, r6
.LPIC7:
	add	r3, pc
	b	.L65
.L101:
	ldr	r3, .L166+100
	ldr	r1, .L166+104
.LPIC3:
	add	r3, pc
.LPIC4:
	add	r1, pc
	b	.L65
.L102:
	ldr	r3, .L166+108
	ldr	r1, .L166+112
	ldr	r2, .L166+116
.LPIC16:
	add	r3, pc
.LPIC17:
	add	r1, pc
.LPIC18:
	add	r2, pc
	b	.L66
.L106:
	ldr	r1, .L166+120
.LPIC0:
	add	r1, pc
	b	.L77
.L165:
	ldr	r3, .L166+124
.LPIC2:
	add	r3, pc
	b	.L78
.L107:
	mov	r1, r6
	b	.L77
.L167:
	.align	2
.L166:
	.word	.LC4-(.LPIC21+4)
	.word	.LC5-(.LPIC22+4)
	.word	.LC6-(.LPIC23+4)
	.word	.LC7-(.LPIC25+4)
	.word	.LC8-(.LPIC26+4)
	.word	.LC9-(.LPIC27+4)
	.word	.LC10-(.LPIC28+4)
	.word	.LC11-(.LPIC29+4)
	.word	.LC0-(.LPIC13+4)
	.word	.LC2-(.LPIC14+4)
	.word	.LC13-(.LPIC32+4)
	.word	.LC1-(.LPIC8+4)
	.word	.LC0-(.LPIC10+4)
	.word	.LC0-(.LPIC9+4)
	.word	.LC12-(.LPIC30+4)
	.word	.LC12-(.LPIC31+4)
	.word	.LC0-(.LPIC1+4)
	.word	.LC3-(.LPIC15+4)
	.word	.LC0-(.LPIC19+4)
	.word	.LC2-(.LPIC20+4)
	.word	.LC1-(.LPIC11+4)
	.word	.LC0-(.LPIC12+4)
	.word	.LC1-(.LPIC5+4)
	.word	.LC0-(.LPIC6+4)
	.word	.LC1-(.LPIC7+4)
	.word	.LC1-(.LPIC3+4)
	.word	.LC0-(.LPIC4+4)
	.word	.LC1-(.LPIC16+4)
	.word	.LC0-(.LPIC17+4)
	.word	.LC2-(.LPIC18+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC2+4)
	.section	.rodata.str1.4
	.align	2
.LC14:
	.ascii	"?\000"
	.align	2
.LC15:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC16:
	.ascii	"\033[1;36m>>> Providers of %s\012\033[0m\000"
	.align	2
.LC17:
	.ascii	"aur/%s %s  %s\012\000"
	.align	2
.LC18:
	.ascii	"\033[1;33m[!] No providers found for '%s'.\012\033["
	.ascii	"0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_provider_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_provider_v2, %function
cmd_provider_v2:
	@ args = 0, pretend = 0, frame = 544
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vmov.i32	d16, #0  @ v8qi
	mov	r7, r0
	sub	sp, sp, #556
	ldr	r4, .L216
	add	r5, sp, #40
	mov	r2, #256
	movs	r1, #0
	mov	r0, r5
	vstr	d16, [sp, #32]
	bl	memset(PLT)
	mov	r0, r7
.LPIC43:
	add	r4, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L169
	ldr	r3, .L216+4
	ldr	r3, [r4, r3]
	ldr	r0, [r3]
	cmp	r7, #0
	beq	.L208
.L170:
	ldr	r1, .L216+8
	mov	r2, r7
.LPIC44:
	add	r1, pc
	bl	fprintf(PLT)
.L171:
	movs	r3, #0
	str	r3, [sp, #8]
.L168:
	ldr	r0, [sp, #8]
	add	sp, sp, #556
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L169:
	ldr	r0, .L216+12
	mov	r1, r7
	add	r8, sp, #32
.LPIC45:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r7
	bl	print_repo_providers(PLT)
	str	r0, [sp, #8]
	bl	config_current(PLT)
	mov	r3, #256
	adds	r0, r0, #16
	str	r3, [sp]
	mov	r2, r8
	mov	r3, r5
	mov	r1, r7
	bl	aur_rpc_info(PLT)
	cmp	r0, #0
	beq	.L172
	ldr	r3, [r8, #4]
	cmp	r3, #0
	beq	.L172
	ldr	r3, .L216+16
	mov	r9, #0
.LPIC46:
	add	r3, pc
	str	r3, [sp, #16]
	ldr	r3, .L216+20
.LPIC41:
	add	r3, pc
	str	r3, [sp, #20]
	ldr	r3, .L216+24
.LPIC42:
	add	r3, pc
	strd	r3, r4, [sp, #24]
	b	.L187
.L214:
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L177
	ldr	r4, [r10, fp]
	cmp	r4, #0
	beq	.L209
	ldr	r2, [r6, #8]
	cmp	r2, #0
	beq	.L210
.L185:
	ldr	r3, [sp, #12]
	cmp	r3, #0
	beq	.L193
.L184:
	ldr	r3, [sp, #20]
.L186:
	ldr	r0, [sp, #16]
	mov	r1, r4
	bl	printf(PLT)
	movs	r3, #1
	str	r3, [sp, #8]
.L182:
	ldr	r3, [r8, #4]
	add	r9, r9, #1
	cmp	r3, r9
	bls	.L211
.L187:
	mov	fp, #88
	ldr	r10, [r8]
	mul	fp, fp, r9
	add	r6, r10, fp
	ldr	r4, [r10, fp]
	ldr	r5, [r6, #72]
	cmp	r4, #0
	beq	.L212
	mov	r1, r7
	mov	r0, r4
	bl	strcmp(PLT)
	clz	r3, r0
	lsrs	r3, r3, #5
	str	r3, [sp, #12]
	cmp	r5, #0
	beq	.L213
.L174:
	movs	r4, #0
	add	r5, sp, #296
.L180:
	ldr	r3, [r6, #68]
	mov	r1, r5
	mov	r2, #256
	ldr	r0, [r3, r4, lsl #2]
	bl	dep_basename(PLT)
	ldrb	r3, [r5]	@ zero_extendqisi2
	mov	r1, r7
	mov	r0, r5
	cmp	r3, #0
	bne	.L214
.L177:
	ldr	r3, [r6, #72]
	adds	r4, r4, #1
	cmp	r3, r4
	bhi	.L180
	ldr	r3, [sp, #12]
	cmp	r3, #0
	beq	.L182
	ldr	r4, [r10, fp]
	ldr	r2, [r6, #8]
	cmp	r4, #0
	beq	.L215
	cmp	r2, #0
	bne	.L184
	ldr	r2, .L216+28
.LPIC39:
	add	r2, pc
	b	.L184
.L211:
	ldr	r4, [sp, #28]
.L172:
	mov	r0, r8
	bl	aur_response_destroy(PLT)
	ldr	r3, [sp, #8]
	cmp	r3, #0
	bne	.L168
	ldr	r3, .L216+4
	mov	r2, r7
	ldr	r1, .L216+32
.LPIC47:
	add	r1, pc
	ldr	r3, [r4, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L171
.L208:
	ldr	r7, .L216+36
.LPIC33:
	add	r7, pc
	b	.L170
.L209:
	ldr	r2, [r6, #8]
	ldr	r4, .L216+40
.LPIC34:
	add	r4, pc
	cmp	r2, #0
	bne	.L185
.L210:
	ldr	r3, [sp, #12]
	ldr	r2, .L216+44
.LPIC35:
	add	r2, pc
	cmp	r3, #0
	bne	.L184
.L193:
	ldr	r3, [sp, #24]
	b	.L186
.L212:
	cmp	r5, #0
	beq	.L182
	str	r4, [sp, #12]
	b	.L174
.L213:
	cmp	r0, #0
	bne	.L182
	ldr	r2, [r6, #8]
	cmp	r2, #0
	bne	.L184
	ldr	r2, .L216+48
.LPIC36:
	add	r2, pc
	b	.L184
.L215:
	cbz	r2, .L191
	ldr	r4, .L216+52
.LPIC40:
	add	r4, pc
	b	.L184
.L191:
	ldr	r2, .L216+56
	ldr	r4, .L216+60
.LPIC37:
	add	r2, pc
.LPIC38:
	add	r4, pc
	b	.L184
.L217:
	.align	2
.L216:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC43+4)
	.word	stderr(GOT)
	.word	.LC15-(.LPIC44+4)
	.word	.LC16-(.LPIC45+4)
	.word	.LC17-(.LPIC46+4)
	.word	.LC2-(.LPIC41+4)
	.word	.LC3-(.LPIC42+4)
	.word	.LC1-(.LPIC39+4)
	.word	.LC18-(.LPIC47+4)
	.word	.LC1-(.LPIC33+4)
	.word	.LC14-(.LPIC34+4)
	.word	.LC1-(.LPIC35+4)
	.word	.LC1-(.LPIC36+4)
	.word	.LC14-(.LPIC40+4)
	.word	.LC1-(.LPIC37+4)
	.word	.LC14-(.LPIC38+4)
	.section	.note.GNU-stack,"",%progbits
