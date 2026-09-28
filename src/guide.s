	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s\000"
	.align	2
.LC1:
	.ascii	"XDG_STATE_HOME\000"
	.align	2
.LC2:
	.ascii	"%s/archtoo\000"
	.align	2
.LC3:
	.ascii	"%s/.local/state/archtoo\000"
	.align	2
.LC4:
	.ascii	"%s/command-guide-seen\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	state_paths.constprop.0, %function
state_paths.constprop.0:
	@ args = 0, pretend = 0, frame = 768
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r6, r0
	mov	r5, r1
	sub	sp, sp, #772
	bl	build_user(PLT)
	cbz	r0, .L4
	bl	getpwnam(PLT)
	cbz	r0, .L4
	ldr	r3, [r0, #20]
	cbz	r3, .L4
	ldr	r2, .L25
	mov	r1, #768
	mov	r0, sp
	mov	r7, sp
.LPIC0:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r0, .L25+4
.LPIC1:
	add	r0, pc
	bl	getenv(PLT)
	mov	r4, r0
	cbz	r0, .L5
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L24
.L5:
	ldr	r2, .L25+8
	mov	r3, r7
	mov	r1, #1024
	mov	r0, r6
.LPIC3:
	add	r2, pc
	bl	xsnprintf(PLT)
.L6:
	ldr	r2, .L25+12
	mov	r3, r6
	mov	r1, #1200
	mov	r0, r5
.LPIC4:
	add	r2, pc
	bl	xsnprintf(PLT)
	movs	r0, #1
	add	sp, sp, #772
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L4:
	movs	r0, #0
	add	sp, sp, #772
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L24:
	bl	geteuid(PLT)
	cmp	r0, #0
	beq	.L5
	ldr	r2, .L25+16
	mov	r3, r4
	mov	r1, #1024
	mov	r0, r6
.LPIC2:
	add	r2, pc
	bl	xsnprintf(PLT)
	b	.L6
.L26:
	.align	2
.L25:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.word	.LC2-(.LPIC2+4)
	.section	.rodata.str1.4
	.align	2
.LC5:
	.ascii	"first-run\000"
	.align	2
.LC6:
	.ascii	"always\000"
	.align	2
.LC7:
	.ascii	"never\000"
	.text
	.align	1
	.p2align 2,,3
	.global	guide_policy_parse
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_policy_parse, %function
guide_policy_parse:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	push	{r4, r5, r6, lr}
	itte	eq
	moveq	r0, #0
	moveq	r6, #1
	movne	r6, #0
	beq	.L27
	mov	r4, r1
	ldr	r1, .L36
	mov	r5, r0
.LPIC5:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L29
	str	r0, [r4]
.L30:
	movs	r0, #1
.L27:
	pop	{r4, r5, r6, pc}
.L29:
	ldr	r1, .L36+4
	mov	r0, r5
.LPIC6:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L35
	ldr	r1, .L36+8
	mov	r0, r5
.LPIC7:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L33
	movs	r3, #2
	str	r3, [r4]
	b	.L30
.L35:
	movs	r3, #1
	str	r3, [r4]
	b	.L30
.L33:
	mov	r0, r6
	pop	{r4, r5, r6, pc}
.L37:
	.align	2
.L36:
	.word	.LC5-(.LPIC5+4)
	.word	.LC6-(.LPIC6+4)
	.word	.LC7-(.LPIC7+4)
	.align	1
	.p2align 2,,3
	.global	guide_policy_name
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_policy_name, %function
guide_policy_name:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #1
	beq	.L40
	cmp	r0, #2
	beq	.L41
	ldr	r0, .L42
.LPIC8:
	add	r0, pc
	bx	lr
.L41:
	ldr	r0, .L42+4
.LPIC10:
	add	r0, pc
	bx	lr
.L40:
	ldr	r0, .L42+8
.LPIC9:
	add	r0, pc
	bx	lr
.L43:
	.align	2
.L42:
	.word	.LC5-(.LPIC8+4)
	.word	.LC7-(.LPIC10+4)
	.word	.LC6-(.LPIC9+4)
	.align	1
	.p2align 2,,3
	.global	guide_set_policy
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_set_policy, %function
guide_set_policy:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L45
.LPIC11:
	add	r3, pc
	str	r0, [r3]
	bx	lr
.L46:
	.align	2
.L45:
	.word	.LANCHOR0-(.LPIC11+4)
	.align	1
	.p2align 2,,3
	.global	guide_get_policy
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_get_policy, %function
guide_get_policy:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L48
.LPIC12:
	add	r3, pc
	ldr	r0, [r3]
	bx	lr
.L49:
	.align	2
.L48:
	.word	.LANCHOR0-(.LPIC12+4)
	.align	1
	.p2align 2,,3
	.global	guide_request_explicit
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_request_explicit, %function
guide_request_explicit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L51
	movs	r2, #1
.LPIC13:
	add	r3, pc
	str	r2, [r3, #4]
	bx	lr
.L52:
	.align	2
.L51:
	.word	.LANCHOR0-(.LPIC13+4)
	.align	1
	.p2align 2,,3
	.global	guide_should_show
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_should_show, %function
guide_should_show:
	@ args = 0, pretend = 0, frame = 2224
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L68
	push	{r4, r5, lr}
.LPIC14:
	add	r3, pc
	subw	sp, sp, #2228
	ldr	r4, [r3, #4]
	cbnz	r4, .L56
	ldr	r3, [r3]
	cmp	r3, #1
	beq	.L56
	cmp	r3, #2
	beq	.L53
	add	r5, sp, #1024
	mov	r0, sp
	mov	r1, r5
	bl	state_paths.constprop.0(PLT)
	cbnz	r0, .L67
.L56:
	movs	r4, #1
.L53:
	mov	r0, r4
	addw	sp, sp, #2228
	@ sp needed
	pop	{r4, r5, pc}
.L67:
	mov	r1, r4
	mov	r0, r5
	bl	access(PLT)
	subs	r4, r0, #0
	it	ne
	movne	r4, #1
	mov	r0, r4
	addw	sp, sp, #2228
	@ sp needed
	pop	{r4, r5, pc}
.L69:
	.align	2
.L68:
	.word	.LANCHOR0-(.LPIC14+4)
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	"\033[1;36m\012Welcome to Archtoo.\012\012\033[0m\000"
	.align	2
.LC9:
	.ascii	"Archtoo uses its own command interface. It does not"
	.ascii	" copy pacman's\000"
	.align	2
.LC10:
	.ascii	"option meanings and never invokes an external AUR h"
	.ascii	"elper.\012\000"
	.align	2
.LC11:
	.ascii	"Common commands:\012\000"
	.align	2
.LC12:
	.ascii	"  emerge -S query          Search repositories and "
	.ascii	"the AUR\000"
	.align	2
.LC13:
	.ascii	"  emerge -I package        Install a package\000"
	.align	2
.LC14:
	.ascii	"  emerge -U                Upgrade repository and A"
	.ascii	"UR packages\000"
	.align	2
.LC15:
	.ascii	"  emerge -Q package        Query an installed packa"
	.ascii	"ge\000"
	.align	2
.LC16:
	.ascii	"  emerge -A package        Show available package i"
	.ascii	"nformation\000"
	.align	2
.LC17:
	.ascii	"  emerge -C package        Remove a package\000"
	.align	2
.LC18:
	.ascii	"  emerge -G package        Download its PKGBUILD\000"
	.align	2
.LC19:
	.ascii	"  emerge --help            Show every command\012\000"
	.align	2
.LC20:
	.ascii	"This guide follows the '%s' display policy. Run\012"
	.ascii	"\000"
	.align	2
.LC21:
	.ascii	"'emerge --command-guide' to display it explicitly.\012"
	.ascii	"\000"
	.text
	.align	1
	.p2align 2,,3
	.global	guide_print
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_print, %function
guide_print:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L76
	push	{r3, lr}
.LPIC19:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L76+4
.LPIC20:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+8
.LPIC21:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+12
.LPIC22:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+16
.LPIC23:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+20
.LPIC24:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+24
.LPIC25:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+28
.LPIC26:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+32
.LPIC27:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+36
.LPIC28:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+40
.LPIC29:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L76+44
.LPIC30:
	add	r0, pc
	bl	puts(PLT)
	ldr	r3, .L76+48
.LPIC31:
	add	r3, pc
	ldr	r3, [r3]
	cmp	r3, #1
	beq	.L72
	cmp	r3, #2
	bne	.L75
	ldr	r1, .L76+52
.LPIC18:
	add	r1, pc
.L71:
	ldr	r0, .L76+56
.LPIC32:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L76+60
	pop	{r3, lr}
.LPIC33:
	add	r0, pc
	b	puts(PLT)
.L75:
	ldr	r1, .L76+64
.LPIC16:
	add	r1, pc
	b	.L71
.L72:
	ldr	r1, .L76+68
.LPIC17:
	add	r1, pc
	b	.L71
.L77:
	.align	2
.L76:
	.word	.LC8-(.LPIC19+4)
	.word	.LC9-(.LPIC20+4)
	.word	.LC10-(.LPIC21+4)
	.word	.LC11-(.LPIC22+4)
	.word	.LC12-(.LPIC23+4)
	.word	.LC13-(.LPIC24+4)
	.word	.LC14-(.LPIC25+4)
	.word	.LC15-(.LPIC26+4)
	.word	.LC16-(.LPIC27+4)
	.word	.LC17-(.LPIC28+4)
	.word	.LC18-(.LPIC29+4)
	.word	.LC19-(.LPIC30+4)
	.word	.LANCHOR0-(.LPIC31+4)
	.word	.LC7-(.LPIC18+4)
	.word	.LC20-(.LPIC32+4)
	.word	.LC21-(.LPIC33+4)
	.word	.LC5-(.LPIC16+4)
	.word	.LC6-(.LPIC17+4)
	.align	1
	.p2align 2,,3
	.global	guide_mark_seen
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_mark_seen, %function
guide_mark_seen:
	@ args = 0, pretend = 0, frame = 3248
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L93
	push	{r4, r5, r6, r7, lr}
.LPIC34:
	add	r3, pc
	subw	sp, sp, #3252
	ldrd	r4, r0, [r3]
	orrs	r4, r4, r0
	it	ne
	movne	r4, #1
	beq	.L92
.L78:
	mov	r0, r4
	addw	sp, sp, #3252
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L92:
	add	r6, sp, #2048
	mov	r0, sp
	mov	r1, r6
	mov	r5, sp
	bl	state_paths.constprop.0(PLT)
	cmp	r0, #0
	beq	.L78
	ldr	r2, .L93+4
	add	r7, sp, #1024
	mov	r3, sp
	mov	r1, #1024
.LPIC36:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	movs	r1, #47
	mov	r0, r7
	bl	strrchr(PLT)
	mov	r3, r0
	cbz	r0, .L84
	mov	r0, r7
	mov	r1, #448
	strb	r4, [r3]
	bl	mkdir(PLT)
	cbz	r0, .L84
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #17
	bne	.L78
.L84:
	mov	r1, #448
	mov	r0, r5
	bl	mkdir(PLT)
	cbz	r0, .L83
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #17
	bne	.L78
.L83:
	mov	r2, #384
	mov	r0, r6
	movw	r1, #32961
	bl	open64(PLT)
	subs	r5, r0, #0
	bge	.L86
	bl	__errno_location(PLT)
	ldr	r4, [r0]
	sub	r4, #17
	clz	r4, r4
	lsrs	r4, r4, #5
	b	.L78
.L86:
	ldr	r1, .L93+8
	movs	r2, #33
.LPIC37:
	add	r1, pc
	bl	write(PLT)
	mov	r4, r0
	bl	__errno_location(PLT)
	mov	r3, r0
	sub	r4, #33
	mov	r0, r5
	mov	r5, r3
	clz	r4, r4
	ldr	r6, [r3]
	bl	close(PLT)
	lsrs	r4, r4, #5
	str	r6, [r5]
	b	.L78
.L94:
	.align	2
.L93:
	.word	.LANCHOR0-(.LPIC34+4)
	.word	.LC0-(.LPIC36+4)
	.word	.LANCHOR1-(.LPIC37+4)
	.section	.rodata.str1.4
	.align	2
.LC22:
	.ascii	"\033[1;33m[!] Could not record command-guide state;"
	.ascii	" it may appear again.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	guide_maybe_show
	.syntax unified
	.thumb
	.thumb_func
	.type	guide_maybe_show, %function
guide_maybe_show:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r4, .L101
.LPIC38:
	add	r4, pc
	bl	guide_should_show(PLT)
	cbnz	r0, .L100
.L97:
	movs	r0, #1
	pop	{r4, pc}
.L100:
	bl	guide_print(PLT)
	bl	guide_mark_seen(PLT)
	cmp	r0, #0
	bne	.L97
	ldr	r3, .L101+4
	movs	r2, #74
	ldr	r0, .L101+8
	movs	r1, #1
.LPIC39:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	movs	r0, #1
	pop	{r4, pc}
.L102:
	.align	2
.L101:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC38+4)
	.word	stderr(GOT)
	.word	.LC22-(.LPIC39+4)
	.section	.rodata
	.align	3
	.set	.LANCHOR1,. + 0
	.type	text.0, %object
text.0:
	.ascii	"Archtoo command guide displayed.\012\000"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	g_policy, %object
g_policy:
	.space	4
	.type	g_explicit, %object
g_explicit:
	.space	4
	.section	.note.GNU-stack,"",%progbits
