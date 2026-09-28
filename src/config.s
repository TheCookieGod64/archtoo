	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"true\000"
	.align	2
.LC1:
	.ascii	"yes\000"
	.align	2
.LC2:
	.ascii	"enabled\000"
	.align	2
.LC3:
	.ascii	"false\000"
	.align	2
.LC4:
	.ascii	"disabled\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	parse_switch, %function
parse_switch:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r5, r1
	ldr	r1, .L25
	mov	r4, r0
.LPIC0:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L2
	ldr	r1, .L25+4
	mov	r0, r4
.LPIC1:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L24
.L2:
	movs	r3, #1
	str	r3, [r5]
.L7:
	movs	r0, #1
	pop	{r3, r4, r5, pc}
.L24:
	ldr	r1, .L25+8
	mov	r0, r4
.LPIC2:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L2
	ldr	r1, .L25+12
	mov	r0, r4
.LPIC3:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L5
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #110
	bne	.L9
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #111
	bne	.L9
	ldrb	r3, [r4, #2]	@ zero_extendqisi2
	cbz	r3, .L5
.L9:
	ldr	r1, .L25+16
	mov	r0, r4
.LPIC4:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L5
	movs	r0, #0
	pop	{r3, r4, r5, pc}
.L5:
	movs	r3, #0
	str	r3, [r5]
	b	.L7
.L26:
	.align	2
.L25:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	trim, %function
trim:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r4, r0
	bl	__ctype_b_loc(PLT)
	ldr	r5, [r0]
	ldrb	r3, [r4]	@ zero_extendqisi2
	ldrh	r3, [r5, r3, lsl #1]
	lsls	r0, r3, #18
	bpl	.L28
.L29:
	ldrb	r3, [r4, #1]!	@ zero_extendqisi2
	ldrh	r3, [r5, r3, lsl #1]
	lsls	r1, r3, #18
	bmi	.L29
.L28:
	mov	r0, r4
	bl	strlen(PLT)
	adds	r3, r4, r0
	cmp	r3, r4
	bhi	.L31
	b	.L30
.L32:
	cmp	r4, r3
	beq	.L30
.L31:
	mov	r1, r3
	ldrb	r2, [r3, #-1]!	@ zero_extendqisi2
	ldrh	r2, [r5, r2, lsl #1]
	lsls	r2, r2, #18
	bmi	.L32
	mov	r3, r1
.L30:
	movs	r2, #0
	strb	r2, [r3]
	mov	r0, r4
	pop	{r3, r4, r5, pc}
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	error_format, %function
error_format:
	@ args = 4, pretend = 8, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 1
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	bne	.L45
	bx	lr
.L45:
	push	{r2, r3}
	push	{lr}
	sub	sp, sp, #12
	add	r3, sp, #20
	ldr	r2, [sp, #16]
	str	r3, [sp, #4]
	bl	vsnprintf(PLT)
	add	sp, sp, #12
	@ sp needed
	ldr	lr, [sp], #4
	add	sp, sp, #8
	bx	lr
	.section	.rodata.str1.4
	.align	2
.LC5:
	.ascii	"https://aur.archlinux.org/rpc/v5\000"
	.align	2
.LC6:
	.ascii	"native\000"
	.align	2
.LC7:
	.ascii	"3\000"
	.align	2
.LC8:
	.ascii	"/usr/local/emerge\000"
	.align	2
.LC9:
	.ascii	"%s/gentoo-chroot\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	config_defaults.part.0, %function
config_defaults.part.0:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, r0
	ldr	r5, .L50+16
	mov	r2, #952
	movs	r1, #0
.LPIC5:
	add	r5, pc
	bl	memset(PLT)
	add	r6, r5, #32
	add	lr, r4, #16
	movs	r3, #1
	mov	r2, #300
	str	r3, [r4]
	str	r2, [r4, #8]
.L47:
	mov	ip, r5
	add	lr, lr, #16
	adds	r5, r5, #16
	ldmia	ip!, {r0, r1, r2, r3}
	str	r0, [lr, #-16]	@ unaligned
	str	r1, [lr, #-12]	@ unaligned
	str	r2, [lr, #-8]	@ unaligned
	str	r3, [lr, #-4]	@ unaligned
	cmp	ip, r6
	bne	.L47
	ldr	r3, .L50+20
	add	r6, r4, #416
	ldr	r1, .L50+24
.LPIC6:
	add	r3, pc
	ldrb	r2, [r5]	@ zero_extendqisi2
	vldr	d16, .L50
	vldr	d17, .L50+8
.LPIC7:
	add	r1, pc
	strb	r2, [lr]
	ldr	r0, [r3]
	ldrh	r2, [r3, #4]	@ unaligned
	ldrb	r3, [r3, #6]	@ zero_extendqisi2
	strh	r2, [r4, #276]	@ unaligned
	strb	r3, [r4, #278]
	ldr	r2, .L50+28
	ldr	r3, .L50+32
	ldrh	r1, [r1]	@ unaligned
.LPIC9:
	add	r2, pc
	str	r0, [r4, #272]	@ unaligned
.LPIC8:
	add	r3, pc
	strh	r1, [r4, #400]	@ unaligned
	add	r0, r4, #432
	vst1.32	{q8}, [r6]
	mov	r1, #512
	bl	snprintf(PLT)
	vmov.i32	d16, #0  @ v2si
	add	r4, r4, #944
	vst1.32	{d16}, [r4]
	pop	{r4, r5, r6, pc}
.L51:
	.align	3
.L50:
	.word	1
	.word	0
	.word	0
	.word	0
	.word	.LC5-(.LPIC5+4)
	.word	.LC6-(.LPIC6+4)
	.word	.LC7-(.LPIC7+4)
	.word	.LC9-(.LPIC9+4)
	.word	.LC8-(.LPIC8+4)
	.align	1
	.p2align 2,,3
	.global	config_defaults
	.syntax unified
	.thumb
	.thumb_func
	.type	config_defaults, %function
config_defaults:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L52
	b	config_defaults.part.0(PLT)
.L52:
	bx	lr
	.section	.rodata.str1.4
	.align	2
.LC10:
	.ascii	"XDG_CONFIG_HOME\000"
	.align	2
.LC11:
	.ascii	"%s/archtoo/config\000"
	.align	2
.LC12:
	.ascii	"%s/.config/archtoo/config\000"
	.align	2
.LC13:
	.ascii	"cannot determine invoking user's config path\000"
	.align	2
.LC14:
	.ascii	"r\000"
	.align	2
.LC15:
	.ascii	"cannot open config: %s\000"
	.align	2
.LC16:
	.ascii	"config line %lu has no '='\000"
	.align	2
.LC17:
	.ascii	"emerge_confirm\000"
	.align	2
.LC18:
	.ascii	"pacman_confirm\000"
	.align	2
.LC19:
	.ascii	"prompt_timeout\000"
	.align	2
.LC20:
	.ascii	"welcome_policy\000"
	.align	2
.LC21:
	.ascii	"command_guide\000"
	.align	2
.LC22:
	.ascii	"aur_rpc_url\000"
	.align	2
.LC23:
	.ascii	"https://\000"
	.align	2
.LC24:
	.ascii	"%s\000"
	.align	2
.LC25:
	.ascii	"target_arch\000"
	.align	2
.LC26:
	.ascii	"target\000"
	.align	2
.LC27:
	.ascii	"march\000"
	.align	2
.LC28:
	.ascii	"cpu\000"
	.align	2
.LC29:
	.ascii	"raw\000"
	.align	2
.LC30:
	.ascii	"raw_flags\000"
	.align	2
.LC31:
	.ascii	"makepkg_raw\000"
	.align	2
.LC32:
	.ascii	"makepkg_flags\000"
	.align	2
.LC33:
	.ascii	"opt_level\000"
	.align	2
.LC34:
	.ascii	"opt\000"
	.align	2
.LC35:
	.ascii	"optimization\000"
	.align	2
.LC36:
	.ascii	"o\000"
	.align	2
.LC37:
	.ascii	"pipe\000"
	.align	2
.LC38:
	.ascii	"use_pipe\000"
	.align	2
.LC39:
	.ascii	"gentoo_chroot\000"
	.align	2
.LC40:
	.ascii	"portage_chroot\000"
	.align	2
.LC41:
	.ascii	"imitation\000"
	.align	2
.LC42:
	.ascii	"portage_imitation\000"
	.align	2
.LC43:
	.ascii	"gentoo_imitation\000"
	.align	2
.LC44:
	.ascii	"gentoo_chroot_path\000"
	.align	2
.LC45:
	.ascii	"chroot_path\000"
	.align	2
.LC46:
	.ascii	"binary\000"
	.align	2
.LC47:
	.ascii	"use_binary\000"
	.align	2
.LC48:
	.ascii	"use_bin\000"
	.align	2
.LC49:
	.ascii	"bin\000"
	.align	2
.LC50:
	.ascii	"prebuilt\000"
	.align	2
.LC51:
	.ascii	"use_prebuilt\000"
	.align	2
.LC52:
	.ascii	"no_build\000"
	.align	2
.LC53:
	.ascii	"no-build\000"
	.align	2
.LC54:
	.ascii	"unknown config key on line %lu: %s\000"
	.align	2
.LC55:
	.ascii	"invalid value for %s on line %lu: %s\000"
	.align	2
.LC56:
	.ascii	"error reading config: %s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	config_load
	.syntax unified
	.thumb
	.thumb_func
	.type	config_load, %function
config_load:
	@ args = 0, pretend = 0, frame = 2072
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	subw	sp, sp, #2084
	str	r1, [sp, #8]
	cmp	r0, #0
	beq	.L55
	mov	r8, r2
	mov	r6, r0
	bl	config_defaults.part.0(PLT)
	bl	build_user(PLT)
	cmp	r0, #0
	beq	.L214
	bl	getpwnam(PLT)
	mov	r4, r0
	ldr	r0, .L224
.LPIC11:
	add	r0, pc
	bl	getenv(PLT)
	mov	r5, r0
	cmp	r4, #0
	beq	.L57
	ldr	r3, [r4, #20]
	cmp	r3, #0
	beq	.L57
	cbz	r0, .L58
	ldrb	r2, [r0]	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L215
.L58:
	ldr	r2, .L224+4
	add	r4, sp, #32
	mov	r1, #1024
	mov	r0, r4
.LPIC13:
	add	r2, pc
	bl	snprintf(PLT)
.L60:
	ldr	r1, .L224+8
	mov	r0, r4
.LPIC15:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L216
	ldr	r3, .L224+12
	mov	r10, #0
	add	fp, sp, #1056
.LPIC18:
	add	r3, pc
	str	r3, [sp, #12]
	ldr	r3, .L224+16
.LPIC19:
	add	r3, pc
	str	r3, [sp, #16]
.L62:
	mov	r2, r9
	mov	r1, #1024
	mov	r0, fp
	bl	fgets(PLT)
	cmp	r0, #0
	beq	.L217
	mov	r0, fp
	add	r10, r10, #1
	bl	trim(PLT)
	ldrb	r4, [r0]	@ zero_extendqisi2
	mov	r5, r0
	cmp	r4, #35
	it	ne
	cmpne	r4, #0
	ite	eq
	moveq	r4, #1
	movne	r4, #0
	beq	.L62
	movs	r1, #61
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L218
	strb	r4, [r0], #1
	bl	trim(PLT)
	mov	r7, r0
	mov	r0, r5
	bl	trim(PLT)
	movs	r1, #35
	mov	r5, r0
	mov	r0, r7
	bl	strchr(PLT)
	cbz	r0, .L67
	strb	r4, [r0]
	mov	r0, r7
	bl	trim(PLT)
	mov	r7, r0
.L67:
	ldr	r1, [sp, #12]
	mov	r0, r5
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L219
	ldr	r1, [sp, #16]
	mov	r0, r5
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L220
	ldr	r1, .L224+20
	mov	r0, r5
.LPIC20:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L221
	ldr	r1, .L224+24
	mov	r0, r5
.LPIC21:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L73
	ldr	r1, .L224+28
	mov	r0, r5
.LPIC22:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L73
	ldr	r1, .L224+32
	mov	r0, r5
.LPIC23:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L222
	ldr	r1, .L224+36
	mov	r0, r5
.LPIC26:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L224+40
	mov	r0, r5
.LPIC27:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L224+44
	mov	r0, r5
.LPIC28:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L224+48
	mov	r0, r5
.LPIC29:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L224+52
	mov	r0, r5
.LPIC31:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L78
	ldr	r1, .L224+56
	mov	r0, r5
.LPIC32:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L78
	ldr	r1, .L224+60
	mov	r0, r5
.LPIC33:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L80
	ldr	r1, .L224+64
	mov	r0, r5
.LPIC34:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L80
	ldr	r1, .L224+68
	mov	r0, r5
.LPIC35:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L82
	ldr	r1, .L224+72
	mov	r0, r5
.LPIC36:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L82
	ldr	r1, .L224+76
	mov	r0, r5
.LPIC37:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L82
	ldr	r1, .L224+80
	mov	r0, r5
.LPIC38:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L82
	ldr	r1, .L224+84
	mov	r0, r5
.LPIC40:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L86
	ldr	r1, .L224+88
	mov	r0, r5
.LPIC41:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L86
	ldr	r1, .L224+92
	mov	r0, r5
.LPIC42:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L90
	ldr	r1, .L224+96
	mov	r0, r5
.LPIC43:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L90
	ldr	r1, .L224+100
	mov	r0, r5
.LPIC44:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L90
	ldr	r1, .L224+104
	mov	r0, r5
.LPIC45:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L90
	ldr	r1, .L224+108
	mov	r0, r5
.LPIC46:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L90
	ldr	r1, .L224+112
	mov	r0, r5
.LPIC47:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L93
	ldr	r1, .L224+116
	mov	r0, r5
.LPIC48:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L93
	ldr	r1, .L224+120
	mov	r0, r5
.LPIC50:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+124
	mov	r0, r5
.LPIC51:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+128
	mov	r0, r5
.LPIC52:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+132
	mov	r0, r5
.LPIC53:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+136
	mov	r0, r5
.LPIC54:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+140
	mov	r0, r5
.LPIC55:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+144
	mov	r0, r5
.LPIC56:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L95
	ldr	r1, .L224+148
	mov	r0, r5
.LPIC57:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L96
.L95:
	add	r4, sp, #28
	mov	r0, r7
	mov	r1, r4
	bl	parse_switch(PLT)
	cbz	r0, .L89
	ldr	r3, [sp, #28]
	str	r3, [r6, #944]
	movs	r3, #1
	str	r3, [r6, #948]
	b	.L62
.L219:
	mov	r1, r6
	mov	r0, r7
	bl	parse_switch(PLT)
	cmp	r0, #0
	bne	.L62
.L89:
	ldr	r2, .L224+152
	mov	r3, r5
	ldr	r0, [sp, #8]
	mov	r1, r8
.LPIC59:
	add	r2, pc
	str	r7, [sp, #4]
	str	r10, [sp]
	bl	error_format(PLT)
	mov	r0, r9
	bl	fclose(PLT)
.L55:
	movs	r0, #0
.L54:
	addw	sp, sp, #2084
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L214:
	ldr	r0, .L224+156
.LPIC10:
	add	r0, pc
	bl	getenv(PLT)
.L57:
	ldr	r2, .L224+160
	mov	r1, r8
	ldr	r0, [sp, #8]
.LPIC14:
	add	r2, pc
	bl	error_format(PLT)
	b	.L55
.L73:
	add	r1, r6, #12
	mov	r0, r7
	bl	guide_policy_parse(PLT)
	cmp	r0, #0
	beq	.L89
	b	.L62
.L220:
	adds	r1, r6, #4
	mov	r0, r7
	bl	parse_switch(PLT)
	cmp	r0, #0
	beq	.L89
	b	.L62
.L215:
	bl	geteuid(PLT)
	cmp	r0, #0
	bne	.L59
	ldr	r3, [r4, #20]
	b	.L58
.L221:
	bl	__errno_location(PLT)
	str	r4, [r0]
	add	r4, sp, #28
	str	r0, [sp, #20]
	movs	r2, #10
	mov	r1, r4
	mov	r0, r7
	bl	strtol(PLT)
	ldr	r3, [sp, #20]
	ldr	r3, [r3]
	cmp	r3, #0
	bne	.L89
	ldr	r3, [sp, #28]
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L89
	mov	r3, #20864
	movt	r3, 1
	cmp	r0, r3
	bhi	.L89
	str	r0, [r6, #8]
	b	.L62
.L222:
	ldr	r1, .L224+164
	movs	r2, #8
	mov	r0, r7
.LPIC24:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L89
	mov	r0, r7
	bl	strlen(PLT)
	cmp	r0, #255
	bhi	.L89
	ldr	r2, .L224+168
	mov	r3, r7
	mov	r1, #256
	add	r0, r6, #16
.LPIC25:
	add	r2, pc
	bl	snprintf(PLT)
	b	.L62
.L59:
	ldr	r2, .L224+172
	add	r4, sp, #32
	mov	r3, r5
	mov	r1, #1024
.LPIC12:
	add	r2, pc
	mov	r0, r4
	bl	snprintf(PLT)
	b	.L60
.L76:
	mov	r0, r7
	bl	valid_target_arch(PLT)
	cmp	r0, #0
	beq	.L89
	mov	r0, r7
	bl	strlen(PLT)
	cmp	r0, #127
	bhi	.L89
	ldr	r2, .L224+176
	mov	r3, r7
	movs	r1, #128
	add	r0, r6, #272
.LPIC30:
	add	r2, pc
	bl	snprintf(PLT)
	b	.L62
.L217:
	mov	r0, r9
	bl	ferror(PLT)
	cbnz	r0, .L223
	mov	r0, r9
	bl	fclose(PLT)
.L63:
	movs	r0, #1
	b	.L54
.L218:
	ldr	r2, .L224+180
	mov	r3, r10
.LPIC17:
	add	r2, pc
.L213:
	ldr	r0, [sp, #8]
	mov	r1, r8
	bl	error_format(PLT)
	mov	r0, r9
	bl	fclose(PLT)
	b	.L55
.L223:
	bl	__errno_location(PLT)
	ldr	r0, [r0]
	bl	strerror(PLT)
	ldr	r2, .L224+184
	mov	r3, r0
.LPIC60:
	add	r2, pc
	b	.L213
.L78:
	mov	r0, r7
	bl	valid_raw_flags(PLT)
	cmp	r0, #0
	beq	.L89
	mov	r0, r7
	bl	set_raw_flags(PLT)
	b	.L62
.L80:
	mov	r0, r7
	bl	valid_raw_flags(PLT)
	cmp	r0, #0
	beq	.L89
	mov	r0, r7
	bl	set_makepkg_raw(PLT)
	b	.L62
.L82:
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	beq	.L89
	mov	r0, r7
	bl	strlen(PLT)
	cmp	r0, #16
	bhi	.L89
	ldrb	r3, [r7]	@ zero_extendqisi2
	movs	r1, #16
	ldr	r2, .L224+188
	add	r0, r6, #400
	cmp	r3, #45
	it	eq
	addeq	r7, r7, #1
.LPIC39:
	add	r2, pc
	ldrb	r3, [r7]	@ zero_extendqisi2
	and	r3, r3, #223
	cmp	r3, #79
	it	eq
	addeq	r7, r7, #1
	mov	r3, r7
	bl	snprintf(PLT)
	b	.L62
.L216:
	bl	__errno_location(PLT)
	ldr	r0, [r0]
	cmp	r0, #2
	beq	.L63
	bl	strerror(PLT)
	ldr	r2, .L224+192
	mov	r3, r0
	mov	r1, r8
	ldr	r0, [sp, #8]
.LPIC16:
	add	r2, pc
	bl	error_format(PLT)
	b	.L55
.L93:
	mov	r0, r7
	bl	valid_gentoo_chroot_path(PLT)
	cmp	r0, #0
	beq	.L89
	ldr	r2, .L224+196
	mov	r3, r7
	mov	r1, #512
	add	r0, r6, #432
.LPIC49:
	add	r2, pc
	bl	snprintf(PLT)
	b	.L62
.L96:
	ldr	r2, .L224+200
	mov	r3, r10
	ldr	r0, [sp, #8]
	mov	r1, r8
.LPIC58:
	add	r2, pc
	str	r5, [sp]
	bl	error_format(PLT)
	mov	r0, r9
	bl	fclose(PLT)
	b	.L55
.L90:
	add	r4, sp, #28
	mov	r0, r7
	mov	r1, r4
	bl	parse_switch(PLT)
	cmp	r0, #0
	beq	.L89
	vld1.32	{d16[]}, [r4]
	add	r3, r6, #424
	vst1.32	{d16}, [r3]
	b	.L62
.L86:
	add	r4, sp, #28
	mov	r0, r7
	mov	r1, r4
	bl	parse_switch(PLT)
	cmp	r0, #0
	beq	.L89
	ldr	r3, [sp, #28]
	str	r3, [r6, #416]
	movs	r3, #1
	str	r3, [r6, #420]
	b	.L62
.L225:
	.align	2
.L224:
	.word	.LC10-(.LPIC11+4)
	.word	.LC12-(.LPIC13+4)
	.word	.LC14-(.LPIC15+4)
	.word	.LC17-(.LPIC18+4)
	.word	.LC18-(.LPIC19+4)
	.word	.LC19-(.LPIC20+4)
	.word	.LC20-(.LPIC21+4)
	.word	.LC21-(.LPIC22+4)
	.word	.LC22-(.LPIC23+4)
	.word	.LC25-(.LPIC26+4)
	.word	.LC26-(.LPIC27+4)
	.word	.LC27-(.LPIC28+4)
	.word	.LC28-(.LPIC29+4)
	.word	.LC29-(.LPIC31+4)
	.word	.LC30-(.LPIC32+4)
	.word	.LC31-(.LPIC33+4)
	.word	.LC32-(.LPIC34+4)
	.word	.LC33-(.LPIC35+4)
	.word	.LC34-(.LPIC36+4)
	.word	.LC35-(.LPIC37+4)
	.word	.LC36-(.LPIC38+4)
	.word	.LC37-(.LPIC40+4)
	.word	.LC38-(.LPIC41+4)
	.word	.LC39-(.LPIC42+4)
	.word	.LC40-(.LPIC43+4)
	.word	.LC41-(.LPIC44+4)
	.word	.LC42-(.LPIC45+4)
	.word	.LC43-(.LPIC46+4)
	.word	.LC44-(.LPIC47+4)
	.word	.LC45-(.LPIC48+4)
	.word	.LC46-(.LPIC50+4)
	.word	.LC47-(.LPIC51+4)
	.word	.LC48-(.LPIC52+4)
	.word	.LC49-(.LPIC53+4)
	.word	.LC50-(.LPIC54+4)
	.word	.LC51-(.LPIC55+4)
	.word	.LC52-(.LPIC56+4)
	.word	.LC53-(.LPIC57+4)
	.word	.LC55-(.LPIC59+4)
	.word	.LC10-(.LPIC10+4)
	.word	.LC13-(.LPIC14+4)
	.word	.LC23-(.LPIC24+4)
	.word	.LC24-(.LPIC25+4)
	.word	.LC11-(.LPIC12+4)
	.word	.LC24-(.LPIC30+4)
	.word	.LC16-(.LPIC17+4)
	.word	.LC56-(.LPIC60+4)
	.word	.LC24-(.LPIC39+4)
	.word	.LC15-(.LPIC16+4)
	.word	.LC24-(.LPIC49+4)
	.word	.LC54-(.LPIC58+4)
	.align	1
	.p2align 2,,3
	.global	config_apply
	.syntax unified
	.thumb
	.thumb_func
	.type	config_apply, %function
config_apply:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	beq	.L254
	ldr	r3, .L263
	mov	r1, r0
	push	{r4, lr}
	mov	r2, #952
.LPIC61:
	add	r3, pc
	mov	r4, r0
	mov	r0, r3
	bl	memcpy(PLT)
	mov	r3, r0
	movs	r2, #1
	ldr	r0, [r4, #4]
	str	r2, [r3, #952]
	bl	set_interactive(PLT)
	ldr	r0, [r4, #8]
	bl	set_prompt_timeout(PLT)
	ldr	r0, [r4]
	bl	set_emerge_confirm(PLT)
	ldr	r0, [r4, #12]
	bl	guide_set_policy(PLT)
	ldrb	r3, [r4, #272]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L257
	ldrb	r3, [r4, #400]	@ zero_extendqisi2
	cbnz	r3, .L258
.L230:
	ldr	r3, [r4, #420]
	cbnz	r3, .L259
.L231:
	ldr	r0, [r4, #424]
	cbnz	r0, .L260
.L232:
	ldrb	r3, [r4, #432]	@ zero_extendqisi2
	cbnz	r3, .L261
.L233:
	ldr	r3, [r4, #948]
	cbnz	r3, .L262
.L226:
	pop	{r4, pc}
.L262:
	ldr	r0, [r4, #944]
	pop	{r4, lr}
	b	set_use_binary(PLT)
.L261:
	add	r0, r4, #432
	bl	set_gentoo_chroot_path(PLT)
	ldr	r3, [r4, #948]
	cmp	r3, #0
	beq	.L226
	b	.L262
.L260:
	bl	set_gentoo_chroot(PLT)
	ldr	r0, [r4, #428]
	bl	set_portage_imitation(PLT)
	ldrb	r3, [r4, #432]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L233
	b	.L261
.L259:
	ldr	r0, [r4, #416]
	bl	set_use_pipe(PLT)
	ldr	r0, [r4, #424]
	cmp	r0, #0
	beq	.L232
	b	.L260
.L258:
	add	r0, r4, #400
	bl	set_opt_level(PLT)
	ldr	r3, [r4, #420]
	cmp	r3, #0
	beq	.L231
	b	.L259
.L257:
	add	r0, r4, #272
	bl	set_target_arch(PLT)
	ldrb	r3, [r4, #400]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L230
	b	.L258
.L254:
	bx	lr
.L264:
	.align	2
.L263:
	.word	.LANCHOR0-(.LPIC61+4)
	.align	1
	.p2align 2,,3
	.global	config_current
	.syntax unified
	.thumb
	.thumb_func
	.type	config_current, %function
config_current:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r4, .L269
.LPIC63:
	add	r4, pc
	ldr	r3, [r4, #952]
	cbz	r3, .L268
.L266:
	ldr	r0, .L269+4
.LPIC66:
	add	r0, pc
	pop	{r4, pc}
.L268:
	mov	r0, r4
	bl	config_defaults.part.0(PLT)
	movs	r3, #1
	str	r3, [r4, #952]
	b	.L266
.L270:
	.align	2
.L269:
	.word	.LANCHOR0-(.LPIC63+4)
	.word	.LANCHOR0-(.LPIC66+4)
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_config, %object
g_config:
	.space	952
	.type	g_initialized, %object
g_initialized:
	.space	4
	.section	.note.GNU-stack,"",%progbits
