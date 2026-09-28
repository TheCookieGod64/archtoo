	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	add_dep_nodes, %function
add_dep_nodes:
	@ args = 0, pretend = 0, frame = 160
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r3, .L16
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r8, r0
	mov	r9, r1
	sub	sp, sp, #164
	mov	r7, r3
	subs	r6, r2, #4
	movs	r4, #0
	mov	r5, sp
.L7:
	ldr	r0, [r6, #4]!
	movs	r2, #160
	mov	r1, r5
	bl	dep_basename(PLT)
	ldrb	r2, [sp]	@ zero_extendqisi2
	mov	r0, r5
	cbz	r2, .L4
	bl	valid_pkgname(PLT)
	mov	r1, r5
	mov	r3, r0
	mov	r0, r8
	cbz	r3, .L4
	bl	graph_has_package(PLT)
	cbz	r0, .L20
.L6:
	mov	r2, r5
	mov	r1, r9
	mov	r0, r8
	bl	graph_add_dependency(PLT)
.L4:
	adds	r4, r4, #1
	cmp	r7, r4
	bne	.L7
	add	sp, sp, #164
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L20:
	ldr	r2, .L21
	mov	r3, r0
	mov	r1, r5
	mov	r0, r8
.LPIC0:
	add	r2, pc
	bl	graph_add_package(PLT)
	b	.L6
.L16:
	bx	lr
.L22:
	.align	2
.L21:
	.word	.LC0-(.LPIC0+4)
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"repo\000"
	.align	2
.LC2:
	.ascii	"(none)\000"
	.align	2
.LC3:
	.ascii	"pacman -Si -- %s\000"
	.align	2
.LC4:
	.ascii	"Version\000"
	.align	2
.LC5:
	.ascii	"Repository\000"
	.align	2
.LC6:
	.ascii	"Depends On\000"
	.align	2
.LC7:
	.ascii	"Optional Deps\000"
	.align	2
.LC8:
	.ascii	"Make Deps\000"
	.align	2
.LC9:
	.ascii	"Build Deps\000"
	.align	2
.LC10:
	.ascii	"Check Deps\000"
	.align	2
.LC11:
	.ascii	"\033[1;36mPackage: %s %s (%s)\012\033[0m\000"
	.align	2
.LC12:
	.ascii	"None\000"
	.align	2
.LC13:
	.ascii	"Depends:\000"
	.align	2
.LC14:
	.ascii	"  %-14s%s\012\000"
	.align	2
.LC15:
	.ascii	"MakeDepends:\000"
	.align	2
.LC16:
	.ascii	"CheckDepends:\000"
	.align	2
.LC17:
	.ascii	"Optional:\000"
	.align	2
.LC18:
	.ascii	"\033[1;36mInstall order (dependency-first):\012\033"
	.ascii	"[0m\000"
	.align	2
.LC19:
	.ascii	" \011\000"
	.align	2
.LC20:
	.ascii	"  %zu. %s\012\000"
	.align	2
.LC21:
	.ascii	"  1. %s\012\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	plan_from_repo, %function
plan_from_repo:
	@ args = 0, pretend = 0, frame = 1288
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r2, #320
	movs	r3, #0
	subw	sp, sp, #1300
	mov	r4, r0
	add	r5, sp, #464
	add	r10, sp, #32
	mov	r1, r5
	str	r3, [r10]
	bl	shell_quote(PLT)
	cbnz	r0, .L168
.L24:
	movs	r0, #0
	addw	sp, sp, #1300
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L168:
	ldr	r2, .L179
	mov	r3, r5
	add	r5, sp, #784
	mov	r1, #512
.LPIC16:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r1, r10
	mov	r0, r5
	bl	run_cmd_capture(PLT)
	ldr	fp, [r10]
	cmp	r0, #0
	bne	.L25
	cmp	fp, #0
	beq	.L25
	ldrb	r3, [fp]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L25
	ldr	r2, .L179+4
	mov	r5, r0
	ldr	r1, .L179+8
	mov	r6, r0
.LPIC17:
	add	r2, pc
	str	r10, [sp, #28]
.LPIC18:
	add	r1, pc
	str	r1, [sp, #8]
	ldr	r1, .L179+12
	mov	r8, r0
	mov	r10, r0
	mov	r9, r2
.LPIC19:
	add	r1, pc
	str	r0, [sp, #12]
	str	r1, [sp, #16]
	strd	r0, r4, [sp, #20]
.L26:
	movs	r1, #10
	mov	r0, fp
	bl	strchr(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L169
	mov	r3, #0
	movs	r1, #58
	strb	r3, [r0]
	mov	r0, fp
	bl	strchr(PLT)
	mov	r7, r0
	cbz	r0, .L31
.L29:
	mov	r3, #0
	movs	r2, #7
	mov	r1, r9
	mov	r0, fp
	strb	r3, [r7]
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L32
	adds	r5, r7, #1
.L33:
	cbz	r4, .L165
.L31:
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	add	fp, r4, #1
	cmp	r3, #0
	bne	.L26
.L165:
	mov	r3, r10
	ldr	r7, [sp, #12]
	ldrd	r9, r4, [sp, #20]
	ldr	r10, [sp, #28]
	cbz	r5, .L41
	ldrb	r2, [r5]	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	bne	.L41
.L39:
	ldrb	r2, [r5, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L39
.L41:
	cbz	r3, .L42
	ldrb	r2, [r3]	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	bne	.L42
.L44:
	ldrb	r2, [r3, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L44
.L42:
	cmp	r8, #0
	beq	.L45
	ldrb	r2, [r8]	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	bne	.L45
.L47:
	ldrb	r2, [r8, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L47
.L45:
	cbz	r6, .L48
	ldrb	r2, [r6]	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	bne	.L48
.L50:
	ldrb	r2, [r6, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L50
.L48:
	cbz	r7, .L51
	ldrb	r2, [r7]	@ zero_extendqisi2
	cmp	r2, #32
	it	ne
	cmpne	r2, #9
	bne	.L51
.L53:
	ldrb	r2, [r7, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L53
.L51:
	cmp	r9, #0
	beq	.L54
	ldrb	r2, [r9]	@ zero_extendqisi2
	cmp	r2, #32
	it	ne
	cmpne	r2, #9
	bne	.L54
.L56:
	ldrb	r2, [r9, #1]!	@ zero_extendqisi2
	cmp	r2, #9
	it	ne
	cmpne	r2, #32
	beq	.L56
.L54:
	cmp	r5, #0
	beq	.L170
	cmp	r3, #0
	beq	.L77
.L178:
	ldrb	r2, [r3]	@ zero_extendqisi2
	cbnz	r2, .L58
	ldr	r3, .L179+16
.LPIC3:
	add	r3, pc
.L58:
	ldr	r0, .L179+20
	mov	r2, r5
	mov	r1, r4
.LPIC24:
	add	r0, pc
	bl	printf(PLT)
	cmp	r8, #0
	beq	.L78
	ldrb	r3, [r8]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L79
	ldr	r1, .L179+24
	mov	r0, r8
.LPIC25:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r2, r8
	cmp	r0, #0
	beq	.L171
.L59:
	ldr	r1, .L179+28
	ldr	r0, .L179+32
.LPIC26:
	add	r1, pc
.LPIC27:
	add	r0, pc
	bl	printf(PLT)
	cmp	r7, #0
	beq	.L81
	ldrb	r3, [r7]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L82
	ldr	r1, .L179+36
	mov	r0, r7
.LPIC28:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L172
.L60:
	ldr	r1, .L179+40
	mov	r2, r7
	ldr	r0, .L179+44
.LPIC29:
	add	r1, pc
.LPIC30:
	add	r0, pc
	bl	printf(PLT)
	cmp	r9, #0
	beq	.L83
	ldrb	r3, [r9]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L84
	ldr	r1, .L179+48
	mov	r0, r9
.LPIC31:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L173
.L61:
	ldr	r1, .L179+52
	mov	r2, r9
	ldr	r0, .L179+56
.LPIC32:
	add	r1, pc
.LPIC33:
	add	r0, pc
	bl	printf(PLT)
	cmp	r6, #0
	beq	.L85
	ldrb	r3, [r6]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L86
	ldr	r1, .L179+60
	mov	r0, r6
.LPIC34:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L174
.L62:
	ldr	r1, .L179+64
	mov	r2, r6
	ldr	r0, .L179+68
	add	r7, sp, #36
.LPIC35:
	add	r1, pc
	add	r9, sp, #40
.LPIC36:
	add	r0, pc
	add	fp, sp, #208
	bl	printf(PLT)
	ldr	r0, .L179+72
.LPIC37:
	add	r0, pc
	bl	printf(PLT)
	bl	graph_create(PLT)
	mov	r2, #256
	mov	r6, r0
	movs	r1, #0
	mov	r0, fp
	bl	memset(PLT)
	movs	r3, #0
	str	r3, [r7]
	str	r3, [r9]
	cmp	r6, #0
	beq	.L63
	mov	r2, r5
	mov	r1, r4
	mov	r0, r6
	bl	graph_add_package(PLT)
	cmp	r8, #0
	beq	.L64
	ldrb	r2, [r8]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L64
	ldr	r1, .L179+76
	mov	r0, r8
.LPIC38:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L64
	mov	r0, r8
	add	r8, sp, #44
	bl	strdup(PLT)
	movs	r3, #0
	str	r0, [sp, #12]
	str	r3, [r8]
	cmp	r0, #0
	beq	.L64
	ldr	r3, .L179+80
	mov	r2, r8
.LPIC39:
	add	r3, pc
	str	r3, [sp, #8]
	mov	r1, r3
	bl	strtok_r(PLT)
	cmp	r0, #0
	beq	.L71
	str	fp, [sp, #16]
	add	r5, sp, #48
	ldr	fp, [sp, #8]
	b	.L66
.L68:
	mov	r2, r8
	mov	r1, fp
	movs	r0, #0
	bl	strtok_r(PLT)
	cmp	r0, #0
	beq	.L175
.L66:
	movs	r2, #160
	mov	r1, r5
	bl	dep_basename(PLT)
	ldrb	r3, [r5]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L68
	mov	r0, r5
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L68
	mov	r1, r5
	mov	r0, r6
	bl	graph_has_package(PLT)
	cmp	r0, #0
	beq	.L176
.L70:
	mov	r2, r5
	mov	r1, r4
	mov	r0, r6
	bl	graph_add_dependency(PLT)
	b	.L68
.L32:
	ldr	r1, [sp, #8]
	movs	r2, #10
	mov	r0, fp
	bl	strncmp(PLT)
	cbnz	r0, .L34
	add	r10, r7, #1
	b	.L33
.L169:
	movs	r1, #58
	mov	r0, fp
	bl	strchr(PLT)
	mov	r7, r0
	cmp	r0, #0
	bne	.L29
	b	.L165
.L34:
	ldr	r1, [sp, #16]
	movs	r2, #10
	mov	r0, fp
	bl	strncmp(PLT)
	cbz	r0, .L177
	ldr	r1, .L179+84
	movs	r2, #13
	mov	r0, fp
.LPIC20:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L36
	adds	r6, r7, #1
	b	.L33
.L25:
	mov	r0, fp
	bl	free(PLT)
	b	.L24
.L177:
	add	r8, r7, #1
	b	.L33
.L170:
	ldr	r5, .L179+88
.LPIC1:
	add	r5, pc
	cmp	r3, #0
	bne	.L178
.L77:
	ldr	r3, .L179+92
.LPIC2:
	add	r3, pc
	b	.L58
.L175:
	ldr	fp, [sp, #16]
.L71:
	ldr	r0, [sp, #12]
	bl	free(PLT)
.L64:
	mov	r2, #256
	mov	r3, fp
	str	r2, [sp]
	mov	r1, r7
	mov	r2, r9
	mov	r0, r6
	bl	graph_topological_order(PLT)
	cmp	r0, #0
	beq	.L72
	ldr	r3, [r9]
	cbz	r3, .L74
	ldr	r8, .L179+96
	movs	r5, #0
	mov	r4, r5
.LPIC42:
	add	r8, pc
.L73:
	ldr	r3, [r7]
	adds	r4, r4, #1
	mov	r0, r6
	ldr	r1, [r3, r5]
	adds	r5, r5, #4
	bl	graph_package_name(PLT)
	mov	r1, r4
	mov	r2, r0
	mov	r0, r8
	bl	printf(PLT)
	ldr	r3, [r9]
	cmp	r4, r3
	bcc	.L73
.L74:
	ldr	r0, [r7]
	bl	free(PLT)
	mov	r0, r6
	bl	graph_destroy(PLT)
.L63:
	ldr	r0, [r10]
	bl	free(PLT)
	movs	r0, #1
	addw	sp, sp, #1300
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L36:
	ldr	r1, .L179+100
	movs	r2, #9
	mov	r0, fp
.LPIC21:
	add	r1, pc
	bl	strncmp(PLT)
	cbz	r0, .L37
	ldr	r1, .L179+104
	movs	r2, #10
	mov	r0, fp
.LPIC22:
	add	r1, pc
	bl	strncmp(PLT)
	cbz	r0, .L37
	ldr	r1, .L179+108
	mov	r0, fp
	movs	r2, #10
.LPIC23:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L33
	adds	r3, r7, #1
	str	r3, [sp, #20]
	b	.L33
.L37:
	adds	r3, r7, #1
	str	r3, [sp, #12]
	b	.L33
.L86:
	ldr	r6, .L179+112
.LPIC15:
	add	r6, pc
	b	.L62
.L79:
	ldr	r2, .L179+116
.LPIC6:
	add	r2, pc
	b	.L59
.L84:
	ldr	r9, .L179+120
.LPIC12:
	add	r9, pc
	b	.L61
.L82:
	ldr	r7, .L179+124
.LPIC9:
	add	r7, pc
	b	.L60
.L85:
	ldr	r6, .L179+128
.LPIC13:
	add	r6, pc
	b	.L62
.L83:
	ldr	r9, .L179+132
.LPIC10:
	add	r9, pc
	b	.L61
.L81:
	ldr	r7, .L179+136
.LPIC7:
	add	r7, pc
	b	.L60
.L78:
	ldr	r2, .L179+140
.LPIC4:
	add	r2, pc
	b	.L59
.L174:
	ldr	r6, .L179+144
.LPIC14:
	add	r6, pc
	b	.L62
.L172:
	ldr	r7, .L179+148
.LPIC8:
	add	r7, pc
	b	.L60
.L171:
	ldr	r2, .L179+152
.LPIC5:
	add	r2, pc
	b	.L59
.L173:
	ldr	r9, .L179+156
.LPIC11:
	add	r9, pc
	b	.L61
.L72:
	ldr	r0, .L179+160
	mov	r1, r4
.LPIC43:
	add	r0, pc
	bl	printf(PLT)
	b	.L74
.L176:
	ldr	r2, .L179+164
	mov	r3, r0
	mov	r1, r5
	mov	r0, r6
.LPIC40:
	add	r2, pc
	bl	graph_add_package(PLT)
	b	.L70
.L180:
	.align	2
.L179:
	.word	.LC3-(.LPIC16+4)
	.word	.LC4-(.LPIC17+4)
	.word	.LC5-(.LPIC18+4)
	.word	.LC6-(.LPIC19+4)
	.word	.LC1-(.LPIC3+4)
	.word	.LC11-(.LPIC24+4)
	.word	.LC12-(.LPIC25+4)
	.word	.LC13-(.LPIC26+4)
	.word	.LC14-(.LPIC27+4)
	.word	.LC12-(.LPIC28+4)
	.word	.LC15-(.LPIC29+4)
	.word	.LC14-(.LPIC30+4)
	.word	.LC12-(.LPIC31+4)
	.word	.LC16-(.LPIC32+4)
	.word	.LC14-(.LPIC33+4)
	.word	.LC12-(.LPIC34+4)
	.word	.LC17-(.LPIC35+4)
	.word	.LC14-(.LPIC36+4)
	.word	.LC18-(.LPIC37+4)
	.word	.LC12-(.LPIC38+4)
	.word	.LC19-(.LPIC39+4)
	.word	.LC7-(.LPIC20+4)
	.word	.LC0-(.LPIC1+4)
	.word	.LC1-(.LPIC2+4)
	.word	.LC20-(.LPIC42+4)
	.word	.LC8-(.LPIC21+4)
	.word	.LC9-(.LPIC22+4)
	.word	.LC10-(.LPIC23+4)
	.word	.LC2-(.LPIC15+4)
	.word	.LC2-(.LPIC6+4)
	.word	.LC2-(.LPIC12+4)
	.word	.LC2-(.LPIC9+4)
	.word	.LC2-(.LPIC13+4)
	.word	.LC2-(.LPIC10+4)
	.word	.LC2-(.LPIC7+4)
	.word	.LC2-(.LPIC4+4)
	.word	.LC2-(.LPIC14+4)
	.word	.LC2-(.LPIC8+4)
	.word	.LC2-(.LPIC5+4)
	.word	.LC2-(.LPIC11+4)
	.word	.LC21-(.LPIC43+4)
	.word	.LC0-(.LPIC40+4)
	.section	.rodata.str1.4
	.align	2
.LC22:
	.ascii	"  %-14s\000"
	.align	2
.LC23:
	.ascii	"%s%s\000"
	.align	2
.LC24:
	.ascii	"  \000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	print_dep_list, %function
print_dep_list:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r3, r0
	ldr	r0, .L187
	ldr	r7, .L187+4
	mov	r5, r1
.LPIC45:
	add	r0, pc
	mov	r1, r3
	mov	r6, r2
.LPIC49:
	add	r7, pc
	bl	printf(PLT)
	cbz	r6, .L186
	ldr	r1, .L187+8
	subs	r5, r5, #4
	ldr	r9, .L187+12
	movs	r4, #0
	ldr	r8, .L187+16
.LPIC44:
	add	r1, pc
.LPIC47:
	add	r9, pc
.LPIC48:
	add	r8, pc
.L183:
	ldr	r2, [r5, #4]!
	mov	r0, r9
	adds	r4, r4, #1
	bl	printf(PLT)
	mov	r1, r8
	cmp	r6, r4
	bne	.L183
	ldr	r3, .L187+20
	movs	r0, #10
	ldr	r3, [r7, r3]
	ldr	r1, [r3]
	pop	{r3, r4, r5, r6, r7, r8, r9, lr}
	b	putc(PLT)
.L186:
	ldr	r0, .L187+24
	pop	{r3, r4, r5, r6, r7, r8, r9, lr}
.LPIC46:
	add	r0, pc
	b	puts(PLT)
.L188:
	.align	2
.L187:
	.word	.LC22-(.LPIC45+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC49+4)
	.word	.LC0-(.LPIC44+4)
	.word	.LC23-(.LPIC47+4)
	.word	.LC24-(.LPIC48+4)
	.word	stdout(GOT)
	.word	.LC2-(.LPIC46+4)
	.section	.rodata.str1.4
	.align	2
.LC25:
	.ascii	"?\000"
	.align	2
.LC26:
	.ascii	" \000"
	.align	2
.LC27:
	.ascii	"aur\000"
	.align	2
.LC28:
	.ascii	"repo/dep\000"
	.align	2
.LC29:
	.ascii	"\033[1;36mPackage: %s %s (aur)\012\033[0m\000"
	.align	2
.LC30:
	.ascii	"  %zu. %s%s%s  [%s]\012\000"
	.align	2
.LC31:
	.ascii	"\033[1;31m[-] %s\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	plan_from_aur, %function
plan_from_aur:
	@ args = 0, pretend = 0, frame = 296
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	vmov.i32	d16, #0  @ v8qi
	mov	r4, #256
	sub	sp, sp, #308
	mov	r2, r4
	add	r8, sp, #36
	add	r5, sp, #48
	movs	r1, #0
	mov	fp, r0
	ldr	r7, .L223
	mov	r0, r5
	add	r6, sp, #40
	mov	r9, #0
	vstr	d16, [sp, #40]
	bl	memset(PLT)
	add	r3, sp, #32
	str	r9, [sp, #32]
	str	r3, [sp, #16]
.LPIC67:
	add	r7, pc
	str	r9, [r8]
	bl	config_current(PLT)
	mov	r3, r5
	adds	r0, r0, #16
	mov	r2, r6
	mov	r1, fp
	str	r4, [sp]
	bl	aur_rpc_info(PLT)
	cbz	r0, .L190
	ldr	r3, [r6, #4]
	cbnz	r3, .L191
.L190:
	mov	r0, r6
	mov	r9, #0
	bl	aur_response_destroy(PLT)
	mov	r0, r9
	add	sp, sp, #308
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L191:
	bl	graph_create(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L190
	ldr	r3, [r6, #4]
	cmp	r3, #0
	beq	.L193
	ldr	r3, .L223+4
	mov	r10, r9
	ldr	r2, .L223+8
.LPIC50:
	add	r3, pc
	str	r3, [sp, #12]
	ldr	r3, .L223+12
.LPIC60:
	add	r2, pc
	strd	r7, r8, [sp, #20]
.LPIC51:
	add	r3, pc
	str	r2, [sp, #8]
	mov	r8, r3
	str	r5, [sp, #28]
.L197:
	ldr	r2, [r6]
	movs	r3, #1
	ldr	r1, [sp, #12]
	mov	r0, r4
	add	r5, r2, r9
	add	r10, r10, #1
	ldr	r7, [r2, r9]
	add	r9, r9, #88
	ldr	r2, [r5, #8]
	cmp	r7, #0
	it	eq
	moveq	r7, fp
	cmp	r2, #0
	it	eq
	moveq	r2, r1
	mov	r1, r7
	bl	graph_add_package(PLT)
	ldr	r2, [r5, #8]
	mov	r1, r7
	ldr	r0, [sp, #8]
	cmp	r2, #0
	it	eq
	moveq	r2, r8
	bl	printf(PLT)
	ldr	r0, .L223+16
	ldrd	r1, r2, [r5, #44]
.LPIC61:
	add	r0, pc
	bl	print_dep_list(PLT)
	ldr	r0, .L223+20
	ldrd	r1, r2, [r5, #52]
.LPIC62:
	add	r0, pc
	bl	print_dep_list(PLT)
	ldr	r0, .L223+24
	ldrd	r1, r2, [r5, #60]
.LPIC63:
	add	r0, pc
	bl	print_dep_list(PLT)
	mov	r1, r7
	ldrd	r2, r3, [r5, #44]
	mov	r0, r4
	bl	add_dep_nodes(PLT)
	mov	r1, r7
	ldrd	r2, r3, [r5, #52]
	mov	r0, r4
	bl	add_dep_nodes(PLT)
	mov	r1, r7
	ldrd	r2, r3, [r5, #60]
	mov	r0, r4
	bl	add_dep_nodes(PLT)
	ldr	r3, [r6, #4]
	cmp	r3, r10
	bhi	.L197
	ldrd	r7, r8, [sp, #20]
	ldr	r5, [sp, #28]
.L193:
	ldr	r0, .L223+28
.LPIC64:
	add	r0, pc
	bl	printf(PLT)
	mov	r3, #256
	ldr	r1, [sp, #16]
	mov	r2, r8
	str	r3, [sp]
	mov	r0, r4
	mov	r3, r5
	bl	graph_topological_order(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L198
	ldr	r3, [r8]
	cmp	r3, #0
	beq	.L204
	ldr	r3, .L223+32
	movs	r5, #0
	ldr	r10, .L223+36
	ldr	r7, .L223+40
.LPIC52:
	add	r3, pc
	ldr	r9, .L223+44
.LPIC56:
	add	r10, pc
.LPIC53:
	add	r7, pc
	str	r6, [sp, #20]
.LPIC54:
	add	r9, pc
	ldr	r6, [sp, #16]
	mov	fp, r3
	strd	r7, r10, [sp, #8]
	b	.L199
.L209:
	ldr	r1, .L223+48
.LPIC59:
	add	r1, pc
.L203:
	ldr	r0, .L223+52
	mov	r3, ip
	strd	r10, r1, [sp]
	mov	r2, r7
.LPIC65:
	add	r0, pc
	mov	r1, r5
	bl	printf(PLT)
	ldr	r3, [r8]
	cmp	r5, r3
	bcs	.L222
.L199:
	ldr	r3, [r6]
	mov	r0, r4
	ldr	r1, [r3, r5, lsl #2]
	bl	graph_package_name(PLT)
	ldr	r3, [r6]
	mov	r7, r0
	mov	r0, r4
	ldr	r1, [r3, r5, lsl #2]
	bl	graph_package_version(PLT)
	ldr	r1, [r6]
	mov	r10, r0
	mov	r0, r4
	ldr	r1, [r1, r5, lsl #2]
	adds	r5, r5, #1
	bl	graph_package_source(PLT)
	cmp	r7, #0
	it	eq
	moveq	r7, fp
	cmp	r10, #0
	beq	.L207
	ldrb	r1, [r10]	@ zero_extendqisi2
	ldr	ip, [sp, #8]
	cbnz	r1, .L202
	mov	ip, r9
	mov	r10, r9
.L202:
	cmp	r0, #1
	bne	.L209
	ldr	r1, .L223+56
.LPIC58:
	add	r1, pc
	b	.L203
.L207:
	ldr	r10, [sp, #12]
	mov	ip, r10
	b	.L202
.L222:
	ldr	r6, [sp, #20]
.L204:
	mov	r9, #1
.L200:
	ldr	r3, [sp, #16]
	ldr	r0, [r3]
	bl	free(PLT)
	mov	r0, r4
	bl	graph_destroy(PLT)
	mov	r0, r6
	bl	aur_response_destroy(PLT)
	mov	r0, r9
	add	sp, sp, #308
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L198:
	ldr	r3, .L223+60
	mov	r2, r5
	ldr	r1, .L223+64
.LPIC66:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L200
.L224:
	.align	2
.L223:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC67+4)
	.word	.LC0-(.LPIC50+4)
	.word	.LC29-(.LPIC60+4)
	.word	.LC0-(.LPIC51+4)
	.word	.LC13-(.LPIC61+4)
	.word	.LC15-(.LPIC62+4)
	.word	.LC16-(.LPIC63+4)
	.word	.LC18-(.LPIC64+4)
	.word	.LC25-(.LPIC52+4)
	.word	.LC0-(.LPIC56+4)
	.word	.LC26-(.LPIC53+4)
	.word	.LC0-(.LPIC54+4)
	.word	.LC28-(.LPIC59+4)
	.word	.LC30-(.LPIC65+4)
	.word	.LC27-(.LPIC58+4)
	.word	stderr(GOT)
	.word	.LC31-(.LPIC66+4)
	.section	.rodata.str1.4
	.align	2
.LC32:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC33:
	.ascii	"\033[1;31m[-] Could not resolve dependencies for '%"
	.ascii	"s'.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_dependency_plan_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_dependency_plan_v2, %function
cmd_dependency_plan_v2:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r4, r0
	ldr	r5, .L236
.LPIC69:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L226
	ldr	r3, .L236+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	cbz	r4, .L234
.L227:
	ldr	r1, .L236+8
	mov	r2, r4
.LPIC70:
	add	r1, pc
	bl	fprintf(PLT)
.L228:
	movs	r0, #0
	pop	{r3, r4, r5, pc}
.L226:
	mov	r0, r4
	bl	plan_from_repo(PLT)
	cbnz	r0, .L231
	mov	r0, r4
	bl	plan_from_aur(PLT)
	cbz	r0, .L235
.L231:
	movs	r0, #1
	pop	{r3, r4, r5, pc}
.L234:
	ldr	r4, .L236+12
.LPIC68:
	add	r4, pc
	b	.L227
.L235:
	ldr	r3, .L236+4
	mov	r2, r4
	ldr	r1, .L236+16
.LPIC71:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L228
.L237:
	.align	2
.L236:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC69+4)
	.word	stderr(GOT)
	.word	.LC32-(.LPIC70+4)
	.word	.LC0-(.LPIC68+4)
	.word	.LC33-(.LPIC71+4)
	.section	.note.GNU-stack,"",%progbits
