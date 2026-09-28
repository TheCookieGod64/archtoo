	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.global	set_noconfirm
	.syntax unified
	.thumb
	.thumb_func
	.type	set_noconfirm, %function
set_noconfirm:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
.LPIC0:
	add	r3, pc
	str	r0, [r3]
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LANCHOR0-(.LPIC0+4)
	.align	1
	.p2align 2,,3
	.global	get_noconfirm
	.syntax unified
	.thumb
	.thumb_func
	.type	get_noconfirm, %function
get_noconfirm:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L6
.LPIC1:
	add	r3, pc
	ldr	r0, [r3]
	bx	lr
.L7:
	.align	2
.L6:
	.word	.LANCHOR0-(.LPIC1+4)
	.align	1
	.p2align 2,,3
	.global	set_emerge_confirm
	.syntax unified
	.thumb
	.thumb_func
	.type	set_emerge_confirm, %function
set_emerge_confirm:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L9
.LPIC2:
	add	r3, pc
	str	r0, [r3]
	bx	lr
.L10:
	.align	2
.L9:
	.word	.LANCHOR1-(.LPIC2+4)
	.align	1
	.p2align 2,,3
	.global	get_emerge_confirm
	.syntax unified
	.thumb
	.thumb_func
	.type	get_emerge_confirm, %function
get_emerge_confirm:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L12
.LPIC3:
	add	r3, pc
	ldr	r0, [r3]
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LANCHOR1-(.LPIC3+4)
	.align	1
	.p2align 2,,3
	.global	set_interactive
	.syntax unified
	.thumb
	.thumb_func
	.type	set_interactive, %function
set_interactive:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L15
.LPIC4:
	add	r3, pc
	str	r0, [r3, #4]
	bx	lr
.L16:
	.align	2
.L15:
	.word	.LANCHOR0-(.LPIC4+4)
	.align	1
	.p2align 2,,3
	.global	get_interactive
	.syntax unified
	.thumb
	.thumb_func
	.type	get_interactive, %function
get_interactive:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L18
.LPIC5:
	add	r3, pc
	ldr	r0, [r3, #4]
	bx	lr
.L19:
	.align	2
.L18:
	.word	.LANCHOR0-(.LPIC5+4)
	.align	1
	.p2align 2,,3
	.global	use_noconfirm
	.syntax unified
	.thumb
	.thumb_func
	.type	use_noconfirm, %function
use_noconfirm:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L23
.LPIC6:
	add	r3, pc
	ldr	r2, [r3]
	cbnz	r2, .L22
	ldr	r0, [r3, #4]
	clz	r0, r0
	lsrs	r0, r0, #5
	bx	lr
.L22:
	movs	r0, #1
	bx	lr
.L24:
	.align	2
.L23:
	.word	.LANCHOR0-(.LPIC6+4)
	.align	1
	.p2align 2,,3
	.global	set_prompt_timeout
	.syntax unified
	.thumb
	.thumb_func
	.type	set_prompt_timeout, %function
set_prompt_timeout:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L26
.LPIC8:
	add	r3, pc
	str	r0, [r3, #4]
	bx	lr
.L27:
	.align	2
.L26:
	.word	.LANCHOR1-(.LPIC8+4)
	.align	1
	.p2align 2,,3
	.global	get_prompt_timeout
	.syntax unified
	.thumb
	.thumb_func
	.type	get_prompt_timeout, %function
get_prompt_timeout:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L29
.LPIC9:
	add	r3, pc
	ldr	r0, [r3, #4]
	bx	lr
.L30:
	.align	2
.L29:
	.word	.LANCHOR1-(.LPIC9+4)
	.align	1
	.p2align 2,,3
	.global	set_resume
	.syntax unified
	.thumb
	.thumb_func
	.type	set_resume, %function
set_resume:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L32
.LPIC10:
	add	r3, pc
	str	r0, [r3, #8]
	bx	lr
.L33:
	.align	2
.L32:
	.word	.LANCHOR0-(.LPIC10+4)
	.align	1
	.p2align 2,,3
	.global	get_resume
	.syntax unified
	.thumb
	.thumb_func
	.type	get_resume, %function
get_resume:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L35
.LPIC11:
	add	r3, pc
	ldr	r0, [r3, #8]
	bx	lr
.L36:
	.align	2
.L35:
	.word	.LANCHOR0-(.LPIC11+4)
	.align	1
	.p2align 2,,3
	.global	set_import_keys
	.syntax unified
	.thumb
	.thumb_func
	.type	set_import_keys, %function
set_import_keys:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L38
.LPIC12:
	add	r3, pc
	str	r0, [r3, #8]
	bx	lr
.L39:
	.align	2
.L38:
	.word	.LANCHOR1-(.LPIC12+4)
	.align	1
	.p2align 2,,3
	.global	get_import_keys
	.syntax unified
	.thumb
	.thumb_func
	.type	get_import_keys, %function
get_import_keys:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L41
.LPIC13:
	add	r3, pc
	ldr	r0, [r3, #8]
	bx	lr
.L42:
	.align	2
.L41:
	.word	.LANCHOR1-(.LPIC13+4)
	.align	1
	.p2align 2,,3
	.global	set_inhibit
	.syntax unified
	.thumb
	.thumb_func
	.type	set_inhibit, %function
set_inhibit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L44
.LPIC14:
	add	r3, pc
	str	r0, [r3, #12]
	bx	lr
.L45:
	.align	2
.L44:
	.word	.LANCHOR1-(.LPIC14+4)
	.align	1
	.p2align 2,,3
	.global	get_inhibit
	.syntax unified
	.thumb
	.thumb_func
	.type	get_inhibit, %function
get_inhibit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L47
.LPIC15:
	add	r3, pc
	ldr	r0, [r3, #12]
	bx	lr
.L48:
	.align	2
.L47:
	.word	.LANCHOR1-(.LPIC15+4)
	.align	1
	.p2align 2,,3
	.global	set_sync
	.syntax unified
	.thumb
	.thumb_func
	.type	set_sync, %function
set_sync:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L50
.LPIC16:
	add	r3, pc
	str	r0, [r3, #16]
	bx	lr
.L51:
	.align	2
.L50:
	.word	.LANCHOR1-(.LPIC16+4)
	.align	1
	.p2align 2,,3
	.global	get_sync
	.syntax unified
	.thumb
	.thumb_func
	.type	get_sync, %function
get_sync:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L53
.LPIC17:
	add	r3, pc
	ldr	r0, [r3, #16]
	bx	lr
.L54:
	.align	2
.L53:
	.word	.LANCHOR1-(.LPIC17+4)
	.align	1
	.p2align 2,,3
	.global	set_aur_sync
	.syntax unified
	.thumb
	.thumb_func
	.type	set_aur_sync, %function
set_aur_sync:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L56
.LPIC18:
	add	r3, pc
	str	r0, [r3, #20]
	bx	lr
.L57:
	.align	2
.L56:
	.word	.LANCHOR1-(.LPIC18+4)
	.align	1
	.p2align 2,,3
	.global	get_aur_sync
	.syntax unified
	.thumb
	.thumb_func
	.type	get_aur_sync, %function
get_aur_sync:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L59
.LPIC19:
	add	r3, pc
	ldr	r0, [r3, #20]
	bx	lr
.L60:
	.align	2
.L59:
	.word	.LANCHOR1-(.LPIC19+4)
	.align	1
	.p2align 2,,3
	.global	set_jobs
	.syntax unified
	.thumb
	.thumb_func
	.type	set_jobs, %function
set_jobs:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L62
.LPIC20:
	add	r3, pc
	str	r0, [r3, #12]
	bx	lr
.L63:
	.align	2
.L62:
	.word	.LANCHOR0-(.LPIC20+4)
	.align	1
	.p2align 2,,3
	.global	get_jobs
	.syntax unified
	.thumb
	.thumb_func
	.type	get_jobs, %function
get_jobs:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
	ldr	r3, .L68
.LPIC21:
	add	r3, pc
	ldr	r0, [r3, #12]
	cmp	r0, #0
	ble	.L67
	pop	{r3, pc}
.L67:
	movs	r0, #84
	bl	sysconf(PLT)
	cmp	r0, #1
	it	lt
	movlt	r0, #1
	pop	{r3, pc}
.L69:
	.align	2
.L68:
	.word	.LANCHOR0-(.LPIC21+4)
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"help\000"
	.align	2
.LC1:
	.ascii	"list\000"
	.text
	.align	1
	.p2align 2,,3
	.global	valid_target_arch
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_target_arch, %function
valid_target_arch:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r5, r0
	cbz	r0, .L76
	ldrb	r4, [r0]	@ zero_extendqisi2
	cbz	r4, .L76
	bl	strlen(PLT)
	subs	r0, r0, #1
	cmp	r0, #63
	bhi	.L76
	ldr	r1, .L84
	mov	r0, r5
.LPIC22:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L81
	ldr	r1, .L84+4
	mov	r0, r5
.LPIC23:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L81
	bl	__ctype_b_loc(PLT)
	ldr	r1, [r0]
	ldrh	r3, [r1, r4, lsl #1]
	ands	r3, r3, #8
	bne	.L73
	b	.L76
.L83:
	ldrh	r3, [r1, r4, lsl #1]
	and	r3, r3, #8
.L73:
	sub	r2, r4, #45
	cbnz	r3, .L72
	cmp	r4, #95
	it	ne
	cmpne	r2, #1
	bhi	.L76
.L72:
	ldrb	r4, [r5, #1]!	@ zero_extendqisi2
	cmp	r4, #0
	bne	.L83
.L81:
	movs	r0, #1
	pop	{r3, r4, r5, pc}
.L76:
	movs	r0, #0
	pop	{r3, r4, r5, pc}
.L85:
	.align	2
.L84:
	.word	.LC0-(.LPIC22+4)
	.word	.LC1-(.LPIC23+4)
	.align	1
	.p2align 2,,3
	.global	get_target_arch
	.syntax unified
	.thumb
	.thumb_func
	.type	get_target_arch, %function
get_target_arch:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L87
.LPIC24:
	add	r0, pc
	adds	r0, r0, #24
	bx	lr
.L88:
	.align	2
.L87:
	.word	.LANCHOR1-(.LPIC24+4)
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"\033[1;36mKnown --target values (common x86-64 -mar"
	.ascii	"ch):\012\033[0m\000"
	.align	2
.LC3:
	.ascii	"  native (default, detects host CPU)\000"
	.align	2
.LC4:
	.ascii	"  x86-64, x86-64-v2, x86-64-v3, x86-64-v4, generic\000"
	.align	2
.LC5:
	.ascii	"\012\033[1;36mIntel:\012\033[0m\000"
	.align	2
.LC6:
	.ascii	"  bonnell, atom, silvermont, goldmont, goldmont-plu"
	.ascii	"s, tremont\000"
	.align	2
.LC7:
	.ascii	"  core2, nehalem, westmere, sandybridge, ivybridge\000"
	.align	2
.LC8:
	.ascii	"  haswell, broadwell, skylake, skylake-avx512, cann"
	.ascii	"onlake\000"
	.align	2
.LC9:
	.ascii	"  icelake-client, icelake-server, cascadelake, tige"
	.ascii	"rlake\000"
	.align	2
.LC10:
	.ascii	"  sapphirerapids, alderlake, raptorlake, meteorlake"
	.ascii	", arrowlake\000"
	.align	2
.LC11:
	.ascii	"  lunarlake, emeraldrapids, graniterapids\000"
	.align	2
.LC12:
	.ascii	"\012\033[1;36mAMD:\012\033[0m\000"
	.align	2
.LC13:
	.ascii	"  k8, athlon64, amdfam10, bdver1, bdver2, bdver3, b"
	.ascii	"dver4\000"
	.align	2
.LC14:
	.ascii	"  znver1, znver2, znver3, znver4, znver5\000"
	.align	2
.LC15:
	.ascii	"  btver1, btver2\000"
	.align	2
.LC16:
	.ascii	"\012Examples:\000"
	.align	2
.LC17:
	.ascii	"  emerge --target=skylake htop\000"
	.align	2
.LC18:
	.ascii	"  emerge --target=znver3 firefox\000"
	.align	2
.LC19:
	.ascii	"  emerge --target=x86-64-v3 --jobs 4 linux-zen\000"
	.align	2
.LC20:
	.ascii	"  emerge --target=native -U   (explicit default)\000"
	.text
	.align	1
	.p2align 2,,3
	.global	print_known_targets
	.syntax unified
	.thumb
	.thumb_func
	.type	print_known_targets, %function
print_known_targets:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L91
	push	{r3, lr}
.LPIC25:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L91+4
.LPIC26:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+8
.LPIC27:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+12
.LPIC28:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L91+16
.LPIC29:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+20
.LPIC30:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+24
.LPIC31:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+28
.LPIC32:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+32
.LPIC33:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+36
.LPIC34:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+40
.LPIC35:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L91+44
.LPIC36:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+48
.LPIC37:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+52
.LPIC38:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+56
.LPIC39:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+60
.LPIC40:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+64
.LPIC41:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+68
.LPIC42:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L91+72
	pop	{r3, lr}
.LPIC43:
	add	r0, pc
	b	puts(PLT)
.L92:
	.align	2
.L91:
	.word	.LC2-(.LPIC25+4)
	.word	.LC3-(.LPIC26+4)
	.word	.LC4-(.LPIC27+4)
	.word	.LC5-(.LPIC28+4)
	.word	.LC6-(.LPIC29+4)
	.word	.LC7-(.LPIC30+4)
	.word	.LC8-(.LPIC31+4)
	.word	.LC9-(.LPIC32+4)
	.word	.LC10-(.LPIC33+4)
	.word	.LC11-(.LPIC34+4)
	.word	.LC12-(.LPIC35+4)
	.word	.LC13-(.LPIC36+4)
	.word	.LC14-(.LPIC37+4)
	.word	.LC15-(.LPIC38+4)
	.word	.LC16-(.LPIC39+4)
	.word	.LC17-(.LPIC40+4)
	.word	.LC18-(.LPIC41+4)
	.word	.LC19-(.LPIC42+4)
	.word	.LC20-(.LPIC43+4)
	.section	.rodata.str1.4
	.align	2
.LC21:
	.ascii	"fast\000"
	.text
	.align	1
	.p2align 2,,3
	.global	valid_opt_level
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_opt_level, %function
valid_opt_level:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r4, r0
	cbz	r0, .L93
	ldrb	r5, [r0]	@ zero_extendqisi2
	cbz	r5, .L107
	ldr	r1, .L131
.LPIC44:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L118
	ldr	r1, .L131+4
	mov	r0, r4
.LPIC45:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L118
	cmp	r5, #45
	beq	.L129
	and	r5, r5, #223
	cmp	r5, #79
	bne	.L105
.L104:
	ldrb	r0, [r4, #1]	@ zero_extendqisi2
	adds	r4, r4, #1
.L96:
	cbz	r0, .L93
.L105:
	ldrb	r5, [r4]	@ zero_extendqisi2
	cmp	r5, #48
	bne	.L119
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cbnz	r3, .L119
.L118:
	movs	r0, #1
.L93:
	pop	{r3, r4, r5, pc}
.L107:
	mov	r0, r5
	pop	{r3, r4, r5, pc}
.L129:
	ldrb	r0, [r4, #1]	@ zero_extendqisi2
	adds	r4, r4, #1
	and	r3, r0, #223
	cmp	r3, #79
	beq	.L104
	b	.L96
.L119:
	cmp	r5, #49
	bne	.L120
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L118
.L120:
	cmp	r5, #50
	beq	.L130
.L121:
	cmp	r5, #51
	bne	.L122
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L118
.L122:
	cmp	r5, #115
	bne	.L123
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L118
.L123:
	ldr	r1, .L131+8
	mov	r0, r4
.LPIC46:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L118
	cmp	r5, #103
	bne	.L124
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L118
.L124:
	subs	r5, r5, #122
	it	eq
	ldrbeq	r5, [r4, #1]	@ zero_extendqisi2
	clz	r0, r5
	lsrs	r0, r0, #5
	pop	{r3, r4, r5, pc}
.L130:
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L118
	b	.L121
.L132:
	.align	2
.L131:
	.word	.LC0-(.LPIC44+4)
	.word	.LC1-(.LPIC45+4)
	.word	.LC21-(.LPIC46+4)
	.align	1
	.p2align 2,,3
	.global	get_opt_level
	.syntax unified
	.thumb
	.thumb_func
	.type	get_opt_level, %function
get_opt_level:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L134
.LPIC47:
	add	r0, pc
	adds	r0, r0, #152
	bx	lr
.L135:
	.align	2
.L134:
	.word	.LANCHOR1-(.LPIC47+4)
	.align	1
	.p2align 2,,3
	.global	valid_raw_flags
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_raw_flags, %function
valid_raw_flags:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, r0
	cbz	r0, .L151
	ldrb	r4, [r0]	@ zero_extendqisi2
	cbz	r4, .L151
	bl	strlen(PLT)
	mov	r6, r0
	cmp	r0, #192
	bhi	.L151
	cmp	r4, #32
	bne	.L150
	mov	r2, r5
.L139:
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #32
	beq	.L139
.L138:
	cmp	r3, #45
	bne	.L151
	bl	__ctype_b_loc(PLT)
	ldr	r1, [r0]
	mov	r2, r5
.L146:
	ldrh	r3, [r1, r4, lsl #1]
	ands	r3, r3, #8
	bne	.L145
	cmp	r4, #64
	bhi	.L142
	cmp	r4, #42
	bhi	.L143
	cmp	r4, #32
	bne	.L153
	ldrb	r4, [r2, #1]	@ zero_extendqisi2
	cmp	r4, #32
	beq	.L153
.L141:
	adds	r2, r2, #1
	cmp	r4, #0
	bne	.L146
	add	r6, r6, r5
	ldrb	r0, [r6, #-1]	@ zero_extendqisi2
	subs	r0, r0, #32
	it	ne
	movne	r0, #1
	pop	{r4, r5, r6, pc}
.L143:
	subs	r4, r4, #43
	movw	r3, #32799
	movt	r3, 36
	uxtb	r4, r4
	lsrs	r3, r3, r4
	ands	r4, r3, #1
	bne	.L145
.L151:
	movs	r0, #0
	pop	{r4, r5, r6, pc}
.L142:
	cmp	r4, #95
	bne	.L151
.L145:
	ldrb	r4, [r2, #1]	@ zero_extendqisi2
	b	.L141
.L153:
	mov	r0, r3
	pop	{r4, r5, r6, pc}
.L150:
	mov	r3, r4
	b	.L138
	.align	1
	.p2align 2,,3
	.global	get_raw_flags
	.syntax unified
	.thumb
	.thumb_func
	.type	get_raw_flags, %function
get_raw_flags:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L159
.LPIC48:
	add	r0, pc
	adds	r0, r0, #16
	bx	lr
.L160:
	.align	2
.L159:
	.word	.LANCHOR0-(.LPIC48+4)
	.align	1
	.p2align 2,,3
	.global	get_makepkg_raw
	.syntax unified
	.thumb
	.thumb_func
	.type	get_makepkg_raw, %function
get_makepkg_raw:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L162
.LPIC49:
	add	r0, pc
	adds	r0, r0, #216
	bx	lr
.L163:
	.align	2
.L162:
	.word	.LANCHOR0-(.LPIC49+4)
	.section	.rodata.str1.4
	.align	2
.LC22:
	.ascii	"\033[1;36mKnown --opt-level values:\012\033[0m\000"
	.align	2
.LC23:
	.ascii	"  0      -O0 no optimization (debug)\000"
	.align	2
.LC24:
	.ascii	"  1      -O1 basic\000"
	.align	2
.LC25:
	.ascii	"  2      -O2 balanced (Arch default, good for low R"
	.ascii	"AM)\000"
	.align	2
.LC26:
	.ascii	"  3      -O3 aggressive (archtoo default)\000"
	.align	2
.LC27:
	.ascii	"  s      -Os optimize for size\000"
	.align	2
.LC28:
	.ascii	"  z      -Oz even more size (clang)\000"
	.align	2
.LC29:
	.ascii	"  fast   -Ofast break standards, max speed\000"
	.align	2
.LC30:
	.ascii	"  g      -Og debug friendly\000"
	.align	2
.LC31:
	.ascii	"  emerge --opt-level=2 htop\000"
	.align	2
.LC32:
	.ascii	"  emerge -O2 htop               (short)\000"
	.align	2
.LC33:
	.ascii	"  emerge --target=skylake -O2 htop\000"
	.align	2
.LC34:
	.ascii	"  emerge --opt-level=fast --no-pipe firefox\000"
	.text
	.align	1
	.p2align 2,,3
	.global	print_known_opt_levels
	.syntax unified
	.thumb
	.thumb_func
	.type	print_known_opt_levels, %function
print_known_opt_levels:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L166
	push	{r3, lr}
.LPIC50:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L166+4
.LPIC51:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+8
.LPIC52:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+12
.LPIC53:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+16
.LPIC54:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+20
.LPIC55:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+24
.LPIC56:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+28
.LPIC57:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+32
.LPIC58:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+36
.LPIC59:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+40
.LPIC60:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+44
.LPIC61:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+48
.LPIC62:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L166+52
	pop	{r3, lr}
.LPIC63:
	add	r0, pc
	b	puts(PLT)
.L167:
	.align	2
.L166:
	.word	.LC22-(.LPIC50+4)
	.word	.LC23-(.LPIC51+4)
	.word	.LC24-(.LPIC52+4)
	.word	.LC25-(.LPIC53+4)
	.word	.LC26-(.LPIC54+4)
	.word	.LC27-(.LPIC55+4)
	.word	.LC28-(.LPIC56+4)
	.word	.LC29-(.LPIC57+4)
	.word	.LC30-(.LPIC58+4)
	.word	.LC16-(.LPIC59+4)
	.word	.LC31-(.LPIC60+4)
	.word	.LC32-(.LPIC61+4)
	.word	.LC33-(.LPIC62+4)
	.word	.LC34-(.LPIC63+4)
	.align	1
	.p2align 2,,3
	.global	set_use_pipe
	.syntax unified
	.thumb
	.thumb_func
	.type	set_use_pipe, %function
set_use_pipe:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L169
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
.LPIC64:
	add	r3, pc
	str	r0, [r3, #168]
	bx	lr
.L170:
	.align	2
.L169:
	.word	.LANCHOR1-(.LPIC64+4)
	.align	1
	.p2align 2,,3
	.global	get_use_pipe
	.syntax unified
	.thumb
	.thumb_func
	.type	get_use_pipe, %function
get_use_pipe:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L172
.LPIC65:
	add	r3, pc
	ldr	r0, [r3, #168]
	bx	lr
.L173:
	.align	2
.L172:
	.word	.LANCHOR1-(.LPIC65+4)
	.section	.rodata.str1.4
	.align	2
.LC35:
	.ascii	"-c\000"
	.align	2
.LC36:
	.ascii	"sh\000"
	.align	2
.LC37:
	.ascii	"/bin/sh\000"
	.text
	.align	1
	.p2align 2,,3
	.global	run_cmd
	.syntax unified
	.thumb
	.thumb_func
	.type	run_cmd, %function
run_cmd:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r5, r0
	sub	sp, sp, #152
	bl	fork(PLT)
	subs	r4, r0, #0
	blt	.L178
	beq	.L182
	add	r5, sp, #12
.L177:
	movs	r2, #0
	mov	r1, r5
	mov	r0, r4
	bl	waitpid(PLT)
	cmp	r0, #0
	bge	.L184
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #4
	beq	.L177
.L178:
	mov	r0, #-1
.L174:
	add	sp, sp, #152
	@ sp needed
	pop	{r4, r5, r6, pc}
.L184:
	ldr	r0, [sp, #12]
	and	r2, r0, #127
	adds	r3, r2, #1
	sbfx	r3, r3, #1, #7
	cmp	r3, #0
	it	gt
	addgt	r0, r2, #128
	bgt	.L174
	cmp	r2, #0
	bne	.L178
	ubfx	r0, r0, #8, #8
	add	sp, sp, #152
	@ sp needed
	pop	{r4, r5, r6, pc}
.L182:
	add	r6, sp, #12
	movs	r2, #140
	mov	r1, r4
	mov	r0, r6
	bl	memset(PLT)
	add	r0, sp, #16
	bl	sigemptyset(PLT)
	mov	r2, r4
	mov	r1, r6
	movs	r0, #2
	bl	sigaction(PLT)
	mov	r2, r4
	mov	r1, r6
	movs	r0, #15
	bl	sigaction(PLT)
	mov	r2, r4
	mov	r1, r6
	movs	r0, #1
	bl	sigaction(PLT)
	ldr	r2, .L185
	ldr	r1, .L185+4
	mov	r3, r5
	ldr	r0, .L185+8
.LPIC66:
	add	r2, pc
.LPIC67:
	add	r1, pc
	str	r4, [sp]
.LPIC68:
	add	r0, pc
	bl	execl(PLT)
	movs	r0, #127
	bl	_exit(PLT)
.L186:
	.align	2
.L185:
	.word	.LC35-(.LPIC66+4)
	.word	.LC36-(.LPIC67+4)
	.word	.LC37-(.LPIC68+4)
	.section	.rodata.str1.4
	.align	2
.LC38:
	.ascii	"/dev/null\000"
	.text
	.align	1
	.p2align 2,,3
	.global	run_cmd_capture
	.syntax unified
	.thumb
	.thumb_func
	.type	run_cmd_capture, %function
run_cmd_capture:
	@ args = 0, pretend = 0, frame = 152
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	beq	.L216
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r3, #0
	mov	r6, r0
	sub	sp, sp, #164
	mov	r10, r1
	str	r3, [r1]
	cmp	r0, #0
	beq	.L189
	add	r0, sp, #12
	bl	pipe(PLT)
	mov	r5, r0
	cmp	r0, #0
	bne	.L189
	bl	fork(PLT)
	subs	r9, r0, #0
	blt	.L221
	beq	.L222
	ldr	r0, [sp, #16]
	mov	r4, #4096
	bl	close(PLT)
	mov	r0, #4096
	bl	malloc(PLT)
	mov	r8, #1024
	mov	r6, r0
	cbz	r0, .L220
.L196:
	cmp	r8, r4
	bcc	.L197
	lsls	r4, r4, #1
	cmp	r4, #16777216
	bhi	.L219
.L198:
	mov	r1, r4
	mov	r0, r6
	bl	realloc(PLT)
	cbz	r0, .L219
	mov	r6, r0
.L197:
	adds	r7, r6, r5
	subs	r2, r4, r5
	ldr	r0, [sp, #12]
	subs	r2, r2, #1
	mov	r1, r7
	bl	read(PLT)
	subs	fp, r0, #0
	blt	.L223
	beq	.L201
	add	r5, r5, fp
	add	r8, r5, #1024
	cmp	r8, r4
	bcc	.L197
	lsls	r4, r4, #1
	cmp	r4, #16777216
	bls	.L198
.L219:
	mov	r0, r6
	bl	free(PLT)
.L220:
	ldr	r0, [sp, #12]
	bl	close(PLT)
	movs	r2, #0
	mov	r1, r2
	mov	r0, r9
	bl	waitpid(PLT)
.L189:
	mov	r0, #-1
.L187:
	add	sp, sp, #164
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L222:
	add	r4, sp, #20
	movs	r2, #140
	mov	r1, r9
	mov	r0, r4
	bl	memset(PLT)
	add	r0, sp, #24
	bl	sigemptyset(PLT)
	mov	r2, r9
	mov	r1, r4
	movs	r0, #2
	bl	sigaction(PLT)
	mov	r2, r9
	mov	r1, r4
	movs	r0, #15
	bl	sigaction(PLT)
	mov	r2, r9
	mov	r1, r4
	movs	r0, #1
	bl	sigaction(PLT)
	ldr	r0, [sp, #12]
	bl	close(PLT)
	ldr	r0, [sp, #16]
	movs	r1, #1
	bl	dup2(PLT)
	cmp	r0, #0
	blt	.L224
	ldr	r0, [sp, #16]
	bl	close(PLT)
	ldr	r0, .L227
	movs	r1, #1
.LPIC69:
	add	r0, pc
	bl	open64(PLT)
	subs	r4, r0, #0
	bge	.L225
.L195:
	ldr	r2, .L227+4
	movs	r4, #0
	ldr	r1, .L227+8
	mov	r3, r6
	ldr	r0, .L227+12
.LPIC70:
	add	r2, pc
.LPIC71:
	add	r1, pc
	str	r4, [sp]
.LPIC72:
	add	r0, pc
	bl	execl(PLT)
	movs	r0, #127
	bl	_exit(PLT)
.L223:
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #4
	beq	.L196
	b	.L219
.L216:
	mov	r0, #-1
	bx	lr
.L225:
	movs	r1, #2
	bl	dup2(PLT)
	mov	r0, r4
	bl	close(PLT)
	b	.L195
.L224:
	movs	r0, #127
	bl	_exit(PLT)
.L201:
	ldr	r0, [sp, #12]
	add	r4, sp, #20
	bl	close(PLT)
	strb	fp, [r7]
	b	.L202
.L203:
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #4
	bne	.L226
.L202:
	movs	r2, #0
	mov	r1, r4
	mov	r0, r9
	bl	waitpid(PLT)
	cmp	r0, #0
	blt	.L203
	ldr	r0, [sp, #20]
	str	r6, [r10]
	and	r2, r0, #127
	adds	r3, r2, #1
	sbfx	r3, r3, #1, #7
	cmp	r3, #0
	it	gt
	addgt	r0, r2, #128
	bgt	.L187
	cmp	r2, #0
	bne	.L189
	ubfx	r0, r0, #8, #8
	b	.L187
.L226:
	mov	r0, r6
	bl	free(PLT)
	b	.L189
.L221:
	ldr	r0, [sp, #12]
	bl	close(PLT)
	ldr	r0, [sp, #16]
	bl	close(PLT)
	b	.L189
.L228:
	.align	2
.L227:
	.word	.LC38-(.LPIC69+4)
	.word	.LC35-(.LPIC70+4)
	.word	.LC36-(.LPIC71+4)
	.word	.LC37-(.LPIC72+4)
	.align	1
	.p2align 2,,3
	.global	shell_quote
	.syntax unified
	.thumb
	.thumb_func
	.type	shell_quote, %function
shell_quote:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r1, #0
	it	ne
	cmpne	r2, #2
	ite	ls
	movls	r3, #1
	movhi	r3, #0
	cmp	r0, #0
	it	eq
	orreq	r3, r3, #1
	cbz	r3, .L230
	movs	r0, #0
	bx	lr
.L230:
	movs	r3, #39
	push	{r4, lr}
	mov	ip, #1
	strb	r3, [r1]
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbz	r3, .L237
	movw	r4, #23591
	movt	r4, 10023
	b	.L236
.L233:
	cmp	lr, r2
	bcs	.L234
	strb	r3, [r1, ip]
	mov	ip, lr
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cbz	r3, .L242
.L236:
	add	lr, ip, #1
	cmp	r3, #39
	bne	.L233
	add	r3, ip, #4
	cmp	r3, r2
	bcs	.L234
	str	r4, [r1, ip]	@ unaligned
	mov	ip, r3
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L236
.L242:
	add	r3, ip, #1
	cmp	r3, r2
	bcs	.L234
.L232:
	movs	r2, #39
	strb	r2, [r1, ip]
	movs	r2, #0
	strb	r2, [r1, r3]
	movs	r0, #1
	pop	{r4, pc}
.L234:
	movs	r0, #0
	pop	{r4, pc}
.L237:
	movs	r3, #2
	b	.L232
	.section	.rodata.str1.4
	.align	2
.LC39:
	.ascii	" @._+-/\000"
	.text
	.align	1
	.p2align 2,,3
	.global	valid_search_query
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_search_query, %function
valid_search_query:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r5, r0
	cbz	r0, .L249
	ldrb	r4, [r0]	@ zero_extendqisi2
	cbz	r4, .L249
	bl	strlen(PLT)
	cmp	r0, #128
	bhi	.L249
	ldr	r7, .L253
	bl	__ctype_b_loc(PLT)
	ldr	r6, [r0]
.LPIC73:
	add	r7, pc
.L246:
	ldrh	r3, [r6, r4, lsl #1]
	mov	r1, r4
	mov	r0, r7
	lsls	r3, r3, #28
	bmi	.L245
	bl	strchr(PLT)
	cbz	r0, .L243
.L245:
	ldrb	r4, [r5, #1]!	@ zero_extendqisi2
	cmp	r4, #0
	bne	.L246
	movs	r0, #1
.L243:
	pop	{r3, r4, r5, r6, r7, pc}
.L249:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, pc}
.L254:
	.align	2
.L253:
	.word	.LC39-(.LPIC73+4)
	.align	1
	.p2align 2,,3
	.global	dep_basename
	.syntax unified
	.thumb
	.thumb_func
	.type	dep_basename, %function
dep_basename:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r2, #0
	it	ne
	cmpne	r1, #0
	beq	.L272
	cbz	r0, .L257
	ldrb	r3, [r0]	@ zero_extendqisi2
	push	{r4, r5, r6, lr}
	cmp	r3, #9
	it	ne
	cmpne	r3, #32
	bne	.L259
.L258:
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #9
	it	ne
	cmpne	r3, #32
	beq	.L258
.L259:
	mov	r6, r1
	cbz	r3, .L261
	mov	r5, r1
	movs	r4, #0
.L263:
	sub	ip, r3, #32
	adds	r4, r4, #1
	mov	lr, #1
	movt	lr, 29696
	uxtb	ip, ip
	mov	r6, r5
	cmp	r4, r2
	bcs	.L261
	lsr	lr, lr, ip
	cmp	r3, #9
	beq	.L261
	cmp	ip, #30
	bhi	.L262
	tst	lr, #1
	bne	.L261
.L262:
	strb	r3, [r5], #1
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L263
	adds	r6, r1, r4
.L261:
	movs	r3, #0
	strb	r3, [r6]
	pop	{r4, r5, r6, pc}
.L272:
	bx	lr
.L257:
	strb	r0, [r1]
	bx	lr
	.section	.rodata.str1.4
	.align	2
.LC40:
	.ascii	"\033[1;31m[-] Internal error: formatted output need"
	.ascii	"s %d bytes but only %zu are available; aborting rat"
	.ascii	"her than running a truncated command or path.\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	xsnprintf
	.syntax unified
	.thumb
	.thumb_func
	.type	xsnprintf, %function
xsnprintf:
	@ args = 4, pretend = 8, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 1
	push	{r2, r3}
	push	{r4, r5, lr}
	mov	r4, r1
	ldr	r5, .L279
	sub	sp, sp, #12
	add	r3, sp, #24
.LPIC75:
	add	r5, pc
	ldr	r2, [r3], #4
	str	r3, [sp, #4]
	bl	vsnprintf(PLT)
	cmp	r0, r4
	ite	cc
	movcc	r3, #0
	movcs	r3, #1
	orrs	r3, r3, r0, lsr #31
	bne	.L278
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, lr}
	add	sp, sp, #8
	bx	lr
.L278:
	mov	r2, r0
	ldr	r0, .L279+4
	ldr	r1, .L279+8
	mov	r3, r4
.LPIC74:
	add	r1, pc
	ldr	r0, [r5, r0]
	ldr	r0, [r0]
	bl	fprintf(PLT)
	movs	r0, #1
	bl	exit(PLT)
.L280:
	.align	2
.L279:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC75+4)
	.word	stderr(GOT)
	.word	.LC40-(.LPIC74+4)
	.section	.rodata.str1.4
	.align	2
.LC41:
	.ascii	"%s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	set_target_arch
	.syntax unified
	.thumb
	.thumb_func
	.type	set_target_arch, %function
set_target_arch:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L296
	push	{r4, lr}
	mov	r4, r0
	bl	valid_target_arch(PLT)
	cbz	r0, .L281
	ldr	r1, .L300
	mov	r0, r4
.LPIC76:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L281
	ldr	r1, .L300+4
	mov	r0, r4
.LPIC77:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L299
.L281:
	pop	{r4, pc}
.L296:
	bx	lr
.L299:
	ldr	r0, .L300+8
	mov	r3, r4
	ldr	r2, .L300+12
	movs	r1, #128
.LPIC79:
	add	r0, pc
	pop	{r4, lr}
.LPIC78:
	add	r2, pc
	adds	r0, r0, #24
	b	xsnprintf(PLT)
.L301:
	.align	2
.L300:
	.word	.LC0-(.LPIC76+4)
	.word	.LC1-(.LPIC77+4)
	.word	.LANCHOR1-(.LPIC79+4)
	.word	.LC41-(.LPIC78+4)
	.align	1
	.p2align 2,,3
	.global	set_opt_level
	.syntax unified
	.thumb
	.thumb_func
	.type	set_opt_level, %function
set_opt_level:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	beq	.L355
	push	{r4, lr}
	mov	r4, r0
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	beq	.L302
	ldr	r1, .L359
	mov	r0, r4
.LPIC80:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L302
	ldr	r1, .L359+4
	mov	r0, r4
.LPIC81:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L302
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #45
	itt	eq
	ldrbeq	r3, [r4, #1]	@ zero_extendqisi2
	addeq	r4, r4, #1
	and	r3, r3, #223
	cmp	r3, #79
	it	eq
	addeq	r4, r4, #1
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #48
	beq	.L358
.L314:
	cmp	r3, #49
	bne	.L315
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cbnz	r2, .L315
.L307:
	ldr	r0, .L359+8
	mov	r3, r4
	ldr	r2, .L359+12
	movs	r1, #16
.LPIC84:
	add	r0, pc
	pop	{r4, lr}
.LPIC83:
	add	r2, pc
	adds	r0, r0, #152
	b	xsnprintf(PLT)
.L315:
	cmp	r3, #50
	bne	.L316
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L307
.L316:
	cmp	r3, #51
	bne	.L317
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L307
.L317:
	cmp	r3, #115
	bne	.L318
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L307
.L318:
	cmp	r3, #103
	bne	.L319
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L307
.L319:
	cmp	r3, #122
	bne	.L320
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L307
.L320:
	ldr	r1, .L359+16
	mov	r0, r4
.LPIC82:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L307
.L302:
	pop	{r4, pc}
.L358:
	ldrb	r2, [r4, #1]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L307
	b	.L314
.L355:
	bx	lr
.L360:
	.align	2
.L359:
	.word	.LC0-(.LPIC80+4)
	.word	.LC1-(.LPIC81+4)
	.word	.LANCHOR1-(.LPIC84+4)
	.word	.LC41-(.LPIC83+4)
	.word	.LC21-(.LPIC82+4)
	.section	.rodata.str1.4
	.align	2
.LC42:
	.ascii	"\000"
	.text
	.align	1
	.p2align 2,,3
	.global	set_raw_flags
	.syntax unified
	.thumb
	.thumb_func
	.type	set_raw_flags, %function
set_raw_flags:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r0
	cbz	r0, .L364
.L362:
	ldr	r0, .L365
	movs	r1, #193
	ldr	r2, .L365+4
.LPIC87:
	add	r0, pc
.LPIC86:
	add	r2, pc
	adds	r0, r0, #16
	b	xsnprintf(PLT)
.L364:
	ldr	r3, .L365+8
.LPIC85:
	add	r3, pc
	b	.L362
.L366:
	.align	2
.L365:
	.word	.LANCHOR0-(.LPIC87+4)
	.word	.LC41-(.LPIC86+4)
	.word	.LC42-(.LPIC85+4)
	.align	1
	.p2align 2,,3
	.global	set_makepkg_raw
	.syntax unified
	.thumb
	.thumb_func
	.type	set_makepkg_raw, %function
set_makepkg_raw:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r0
	cbz	r0, .L370
.L368:
	ldr	r0, .L371
	movs	r1, #193
	ldr	r2, .L371+4
.LPIC90:
	add	r0, pc
.LPIC89:
	add	r2, pc
	adds	r0, r0, #216
	b	xsnprintf(PLT)
.L370:
	ldr	r3, .L371+8
.LPIC88:
	add	r3, pc
	b	.L368
.L372:
	.align	2
.L371:
	.word	.LANCHOR0-(.LPIC90+4)
	.word	.LC41-(.LPIC89+4)
	.word	.LC42-(.LPIC88+4)
	.section	.rodata.str1.4
	.align	2
.LC43:
	.ascii	" -pipe\000"
	.align	2
.LC44:
	.ascii	"-march=%s -O%s%s %s\000"
	.align	2
.LC45:
	.ascii	"-march=%s -O%s%s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	render_build_flags
	.syntax unified
	.thumb
	.thumb_func
	.type	render_build_flags, %function
render_build_flags:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r5, r0
	ldr	r4, .L379
	sub	sp, sp, #52
	ldr	r2, .L379+4
.LPIC93:
	add	r4, pc
	add	r7, sp, #16
	add	r3, r4, #152
	mov	r6, r1
.LPIC94:
	add	r2, pc
	movs	r1, #16
	mov	r0, r7
	bl	xsnprintf(PLT)
	ldr	r3, [r4, #168]
	cbz	r3, .L377
	ldr	r3, .L379+8
.LPIC91:
	add	r3, pc
.L374:
	ldr	r2, .L379+12
	add	r4, sp, #32
	movs	r1, #16
	mov	r0, r4
.LPIC96:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r3, .L379+16
.LPIC97:
	add	r3, pc
	ldrb	r2, [r3, #16]	@ zero_extendqisi2
	cbz	r2, .L375
	adds	r3, r3, #16
	str	r3, [sp, #8]
	ldr	r3, .L379+20
	mov	r1, r6
	ldr	r2, .L379+24
	mov	r0, r5
.LPIC98:
	add	r3, pc
	str	r4, [sp, #4]
.LPIC99:
	add	r2, pc
	adds	r3, r3, #24
	str	r7, [sp]
	bl	xsnprintf(PLT)
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L377:
	ldr	r3, .L379+28
.LPIC92:
	add	r3, pc
	b	.L374
.L375:
	ldr	r3, .L379+32
	mov	r1, r6
	ldr	r2, .L379+36
	mov	r0, r5
.LPIC101:
	add	r3, pc
	str	r4, [sp, #4]
.LPIC102:
	add	r2, pc
	adds	r3, r3, #24
	str	r7, [sp]
	bl	xsnprintf(PLT)
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L380:
	.align	2
.L379:
	.word	.LANCHOR1-(.LPIC93+4)
	.word	.LC41-(.LPIC94+4)
	.word	.LC43-(.LPIC91+4)
	.word	.LC41-(.LPIC96+4)
	.word	.LANCHOR0-(.LPIC97+4)
	.word	.LANCHOR1-(.LPIC98+4)
	.word	.LC44-(.LPIC99+4)
	.word	.LC42-(.LPIC92+4)
	.word	.LANCHOR1-(.LPIC101+4)
	.word	.LC45-(.LPIC102+4)
	.section	.rodata.str1.4
	.align	2
.LC46:
	.ascii	"%s >/dev/null 2>&1\000"
	.text
	.align	1
	.p2align 2,,3
	.global	run_cmd_quiet
	.syntax unified
	.thumb
	.thumb_func
	.type	run_cmd_quiet, %function
run_cmd_quiet:
	@ args = 0, pretend = 0, frame = 4608
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r0
	ldr	r2, .L383
	sub	sp, sp, #4608
	mov	r1, #4608
.LPIC103:
	add	r2, pc
	mov	r0, sp
	bl	xsnprintf(PLT)
	mov	r0, sp
	bl	run_cmd(PLT)
	add	sp, sp, #4608
	@ sp needed
	pop	{r4, pc}
.L384:
	.align	2
.L383:
	.word	.LC46-(.LPIC103+4)
	.align	1
	.p2align 2,,3
	.global	fopen_nofollow
	.syntax unified
	.thumb
	.thumb_func
	.type	fopen_nofollow, %function
fopen_nofollow:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	mov	r4, r1
	ldrb	r3, [r1]	@ zero_extendqisi2
	cmp	r3, #114
	beq	.L392
	cmp	r3, #119
	beq	.L393
	cmp	r3, #97
	beq	.L394
	bl	__errno_location(PLT)
	movs	r3, #22
	str	r3, [r0]
.L387:
	movs	r4, #0
.L385:
	mov	r0, r4
	pop	{r3, r4, r5, pc}
.L393:
	movw	r1, #33345
.L386:
	mov	r2, #420
	bl	open64(PLT)
	subs	r5, r0, #0
	blt	.L387
	mov	r1, r4
	bl	fdopen(PLT)
	mov	r4, r0
	cmp	r0, #0
	bne	.L385
	mov	r0, r5
	bl	close(PLT)
	b	.L385
.L392:
	mov	r1, #32768
	b	.L386
.L394:
	movw	r1, #33857
	b	.L386
	.align	1
	.p2align 2,,3
	.global	file_exists
	.syntax unified
	.thumb
	.thumb_func
	.type	file_exists, %function
file_exists:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
	sub	sp, sp, #116
	mov	r1, sp
	bl	__stat64_time64(PLT)
	cbnz	r0, .L398
	ldr	r0, [sp, #16]
	and	r0, r0, #61440
	sub	r0, r0, #32768
	clz	r0, r0
	lsrs	r0, r0, #5
	add	sp, sp, #116
	@ sp needed
	ldr	pc, [sp], #4
.L398:
	movs	r0, #0
	add	sp, sp, #116
	@ sp needed
	ldr	pc, [sp], #4
	.align	1
	.p2align 2,,3
	.global	dir_exists
	.syntax unified
	.thumb
	.thumb_func
	.type	dir_exists, %function
dir_exists:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
	sub	sp, sp, #116
	mov	r1, sp
	bl	__stat64_time64(PLT)
	cbnz	r0, .L402
	ldr	r0, [sp, #16]
	and	r0, r0, #61440
	sub	r0, r0, #16384
	clz	r0, r0
	lsrs	r0, r0, #5
	add	sp, sp, #116
	@ sp needed
	ldr	pc, [sp], #4
.L402:
	movs	r0, #0
	add	sp, sp, #116
	@ sp needed
	ldr	pc, [sp], #4
	.section	.rodata.str1.4
	.align	2
.LC47:
	.ascii	"@._+-\000"
	.text
	.align	1
	.p2align 2,,3
	.global	valid_pkgname
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_pkgname, %function
valid_pkgname:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r5, r0
	cbz	r0, .L411
	ldrb	r4, [r0]	@ zero_extendqisi2
	cbz	r4, .L411
	sub	r3, r4, #45
	cmp	r3, #1
	bls	.L411
	bl	strlen(PLT)
	cmp	r0, #128
	bhi	.L411
	ldr	r7, .L416
	bl	__ctype_b_loc(PLT)
	ldr	r6, [r0]
.LPIC104:
	add	r7, pc
	b	.L407
.L406:
	ldrb	r4, [r5, #1]!	@ zero_extendqisi2
	cbz	r4, .L415
.L407:
	ldrh	r3, [r6, r4, lsl #1]
	and	r3, r3, #2560
	cmp	r3, #0
	bne	.L406
	mov	r1, r4
	mov	r0, r7
	bl	strchr(PLT)
	cmp	r0, #0
	bne	.L406
	pop	{r3, r4, r5, r6, r7, pc}
.L411:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, pc}
.L415:
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, pc}
.L417:
	.align	2
.L416:
	.word	.LC47-(.LPIC104+4)
	.section	.rodata.str1.4
	.align	2
.LC48:
	.ascii	".^$*+?()[]{}|/\\\000"
	.text
	.align	1
	.p2align 2,,3
	.global	regex_escape
	.syntax unified
	.thumb
	.thumb_func
	.type	regex_escape, %function
regex_escape:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r6, r1
	mov	r7, r2
	ldrb	r1, [r0]	@ zero_extendqisi2
	cbz	r1, .L426
	ldr	r8, .L430
	mov	r5, r0
	movs	r4, #0
	mov	r9, #92
.LPIC105:
	add	r8, pc
	b	.L425
.L429:
	cmp	r3, r7
	bcs	.L424
	adds	r2, r4, #1
	strb	r9, [r6, r4]
	mov	r4, r3
.L423:
	ldrb	r3, [r5]	@ zero_extendqisi2
	strb	r3, [r6, r2]
	ldrb	r1, [r5, #1]!	@ zero_extendqisi2
	cbz	r1, .L419
.L425:
	mov	r0, r8
	bl	strchr(PLT)
	adds	r3, r4, #2
	cmp	r0, #0
	bne	.L429
	adds	r3, r4, #1
	mov	r2, r4
	cmp	r3, r7
	mov	r4, r3
	bcc	.L423
.L424:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L426:
	mov	r4, r1
.L419:
	cmp	r7, r4
	bls	.L424
	movs	r3, #0
	strb	r3, [r6, r4]
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L431:
	.align	2
.L430:
	.word	.LC48-(.LPIC105+4)
	.section	.rodata.str1.4
	.align	2
.LC49:
	.ascii	"SUDO_USER\000"
	.text
	.align	1
	.p2align 2,,3
	.global	build_user
	.syntax unified
	.thumb
	.thumb_func
	.type	build_user, %function
build_user:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L442
	push	{r3, lr}
.LPIC106:
	add	r0, pc
	bl	getenv(PLT)
	cbz	r0, .L433
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L432
.L433:
	bl	getuid(PLT)
	bl	getpwuid(PLT)
	cbz	r0, .L432
	ldr	r0, [r0]
.L432:
	pop	{r3, pc}
.L443:
	.align	2
.L442:
	.word	.LC49-(.LPIC106+4)
	.section	.rodata.str1.4
	.align	2
.LC50:
	.ascii	"\033[1;31m[-] Configuration error: %s\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	load_user_config
	.syntax unified
	.thumb
	.thumb_func
	.type	load_user_config, %function
load_user_config:
	@ args = 0, pretend = 0, frame = 1464
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r2, #512
	ldr	r5, .L449
	sub	sp, sp, #1464
	add	r4, sp, #512
	mov	r1, sp
	mov	r0, r4
.LPIC108:
	add	r5, pc
	bl	config_load(PLT)
	cbz	r0, .L448
	mov	r0, r4
	bl	config_apply(PLT)
	add	sp, sp, #1464
	@ sp needed
	pop	{r4, r5, r6, pc}
.L448:
	ldr	r3, .L449+4
	mov	r2, sp
	ldr	r1, .L449+8
.LPIC107:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	add	sp, sp, #1464
	@ sp needed
	pop	{r4, r5, r6, pc}
.L450:
	.align	2
.L449:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC108+4)
	.word	stderr(GOT)
	.word	.LC50-(.LPIC107+4)
	.section	.rodata.str1.4
	.align	2
.LC51:
	.ascii	"sudo \000"
	.text
	.align	1
	.p2align 2,,3
	.global	priv_prefix
	.syntax unified
	.thumb
	.thumb_func
	.type	priv_prefix, %function
priv_prefix:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
	bl	geteuid(PLT)
	cbnz	r0, .L453
	ldr	r0, .L455
.LPIC109:
	add	r0, pc
	pop	{r3, pc}
.L453:
	ldr	r0, .L455+4
.LPIC110:
	add	r0, pc
	pop	{r3, pc}
.L456:
	.align	2
.L455:
	.word	.LC42-(.LPIC109+4)
	.word	.LC51-(.LPIC110+4)
	.section	.rodata.str1.4
	.align	2
.LC52:
	.ascii	"command -v '%s'\000"
	.text
	.align	1
	.p2align 2,,3
	.global	have_cmd
	.syntax unified
	.thumb
	.thumb_func
	.type	have_cmd, %function
have_cmd:
	@ args = 0, pretend = 0, frame = 5120
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r0
	ldr	r2, .L459
	sub	sp, sp, #5120
	mov	r1, #512
.LPIC111:
	add	r2, pc
	mov	r0, sp
	bl	xsnprintf(PLT)
	ldr	r2, .L459+4
	add	r4, sp, #512
	mov	r3, sp
.LPIC112:
	add	r2, pc
	mov	r1, #4608
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	add	sp, sp, #5120
	@ sp needed
	pop	{r4, pc}
.L460:
	.align	2
.L459:
	.word	.LC52-(.LPIC111+4)
	.word	.LC46-(.LPIC112+4)
	.section	.rodata.str1.4
	.align	2
.LC53:
	.ascii	"sudo\000"
	.align	2
.LC54:
	.ascii	"\033[1;31m[-] sudo is required.\012\033[0m\000"
	.align	2
.LC55:
	.ascii	"sudo -k\000"
	.align	2
.LC56:
	.ascii	"\033[1;31m[-] Could not invalidate sudo credentials"
	.ascii	".\012\033[0m\000"
	.align	2
.LC57:
	.ascii	"\033[1;31m[-] Out of memory.\012\033[0m\000"
	.align	2
.LC59:
	.ascii	"\033[1;31m[-] Could not execute sudo: %s\012\033[0m"
	.ascii	"\000"
	.align	2
.LC58:
	.ascii	"--\000"
	.text
	.align	1
	.p2align 2,,3
	.global	acquire_sudo
	.syntax unified
	.thumb
	.thumb_func
	.type	acquire_sudo, %function
acquire_sudo:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r6, r0
	ldr	r7, .L474
	sub	sp, sp, #16
	mov	r5, r1
.LPIC114:
	add	r7, pc
	bl	geteuid(PLT)
	cbnz	r0, .L470
	movs	r0, #1
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L470:
	ldr	r0, .L474+4
.LPIC113:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	beq	.L471
	ldr	r0, .L474+8
.LPIC116:
	add	r0, pc
	bl	run_cmd(PLT)
	mov	r8, r0
	cmp	r0, #0
	bne	.L472
	movs	r1, #4
	adds	r0, r6, #3
	bl	calloc(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L473
	ldr	r3, .L474+12
	cmp	r6, #0
	strb	r8, [sp, #12]
.LPIC119:
	add	r3, pc
	ldr	r3, [r3]
	strh	r3, [sp, #4]	@ movhi
	lsr	r3, r3, #16
	strb	r3, [sp, #6]
	add	r3, sp, #8
	str	r3, [r0]
	add	r3, sp, #4
	str	r3, [r0, #4]
	movw	r3, #30067
	movt	r3, 28516
	str	r3, [sp, #8]
	ble	.L467
	lsls	r2, r6, #2
	mov	r1, r5
	adds	r0, r0, #8
	bl	memcpy(PLT)
.L467:
	adds	r3, r6, #2
	ldr	r0, .L474+16
	movs	r2, #0
	mov	r1, r4
.LPIC120:
	add	r0, pc
	str	r2, [r4, r3, lsl #2]
	bl	execvp(PLT)
	ldr	r3, .L474+20
	ldr	r3, [r7, r3]
	ldr	r5, [r3]
	bl	__errno_location(PLT)
	ldr	r0, [r0]
	bl	strerror(PLT)
	ldr	r1, .L474+24
	mov	r2, r0
	mov	r0, r5
.LPIC121:
	add	r1, pc
	bl	fprintf(PLT)
	mov	r0, r4
	bl	free(PLT)
.L464:
	movs	r0, #0
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L471:
	ldr	r3, .L474+20
	movs	r2, #33
	ldr	r0, .L474+28
	movs	r1, #1
.LPIC115:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L464
.L472:
	ldr	r3, .L474+20
	movs	r2, #54
	ldr	r0, .L474+32
	movs	r1, #1
.LPIC117:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L464
.L473:
	ldr	r3, .L474+20
	movs	r2, #30
	ldr	r0, .L474+36
	movs	r1, #1
.LPIC118:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L464
.L475:
	.align	2
.L474:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC114+4)
	.word	.LC53-(.LPIC113+4)
	.word	.LC55-(.LPIC116+4)
	.word	.LC58-(.LPIC119+4)
	.word	.LC53-(.LPIC120+4)
	.word	stderr(GOT)
	.word	.LC59-(.LPIC121+4)
	.word	.LC54-(.LPIC115+4)
	.word	.LC56-(.LPIC117+4)
	.word	.LC57-(.LPIC118+4)
	.section	.rodata.str1.4
	.align	2
.LC60:
	.ascii	"chown '%s' '%s'\000"
	.text
	.align	1
	.p2align 2,,3
	.global	fix_owner
	.syntax unified
	.thumb
	.thumb_func
	.type	fix_owner, %function
fix_owner:
	@ args = 0, pretend = 0, frame = 5632
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r4, r0
	sub	sp, sp, #5632
	sub	sp, sp, #8
	bl	geteuid(PLT)
	cbz	r0, .L491
.L476:
	add	sp, sp, #5632
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L491:
	ldr	r0, .L492
.LPIC122:
	add	r0, pc
	bl	getenv(PLT)
	mov	r3, r0
	cbz	r0, .L478
	ldrb	r2, [r0]	@ zero_extendqisi2
	cbnz	r2, .L479
.L478:
	bl	getuid(PLT)
	bl	getpwuid(PLT)
	cmp	r0, #0
	beq	.L476
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L476
.L479:
	ldr	r2, .L492+4
	mov	r1, #1024
	str	r4, [sp]
	add	r4, sp, #8
.LPIC123:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	ldr	r2, .L492+8
	mov	r3, r4
	add	r4, sp, #1032
.LPIC124:
	add	r2, pc
	mov	r1, #4608
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	add	sp, sp, #5632
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L493:
	.align	2
.L492:
	.word	.LC49-(.LPIC122+4)
	.word	.LC60-(.LPIC123+4)
	.word	.LC46-(.LPIC124+4)
	.section	.rodata.str1.4
	.align	2
.LC61:
	.ascii	"%s%s\000"
	.align	2
.LC62:
	.ascii	"\033[1;31m[-] Running as root with no SUDO_USER; ca"
	.ascii	"nnot find an unprivileged user to build as.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC63:
	.ascii	"/dev/urandom\000"
	.align	2
.LC64:
	.ascii	"/usr/local/emerge\000"
	.align	2
.LC65:
	.ascii	"%s/.archtoo-step-%ld-%08lx.sh\000"
	.align	2
.LC66:
	.ascii	"\033[1;31m[-] Cannot create step script in %s: %s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC67:
	.ascii	"w\000"
	.align	2
.LC68:
	.ascii	"\033[1;31m[-] fdopen failed for %s\012\033[0m\000"
	.align	2
.LC69:
	.ascii	"#!/bin/sh\012trap 'exit 130' INT\012trap 'exit 143'"
	.ascii	" TERM\012trap 'exit 129' HUP\012%s%s\012\000"
	.align	2
.LC70:
	.ascii	"\033[1;31m[-] Cannot finish writing %s\012\033[0m\000"
	.align	2
.LC71:
	.ascii	"sudo -u '%s' -- /bin/sh '%s'\000"
	.text
	.align	1
	.p2align 2,,3
	.global	run_as_user
	.syntax unified
	.thumb
	.thumb_func
	.type	run_as_user, %function
run_as_user:
	@ args = 0, pretend = 0, frame = 4728
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r4, r1
	ldr	r3, .L531
	sub	sp, sp, #4736
	sub	sp, sp, #4
.LPIC128:
	add	r3, pc
	str	r0, [sp, #16]
	str	r3, [sp, #24]
	str	r1, [sp, #20]
	bl	geteuid(PLT)
	cbz	r0, .L495
	cbz	r4, .L496
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L497
.L496:
	ldr	r0, [sp, #16]
	add	sp, sp, #4736
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	b	run_cmd(PLT)
.L495:
	ldr	r0, .L531+4
.LPIC127:
	add	r0, pc
	bl	getenv(PLT)
	str	r0, [sp, #28]
	cbz	r0, .L499
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L500
.L499:
	bl	getuid(PLT)
	bl	getpwuid(PLT)
	cmp	r0, #0
	beq	.L501
	ldr	r3, [r0]
	str	r3, [sp, #28]
	cmp	r3, #0
	beq	.L501
.L500:
	ldr	fp, .L531+8
	movs	r3, #16
	ldr	r10, .L531+12
	add	r6, sp, #640
	str	r3, [sp, #12]
.LPIC130:
	add	fp, pc
	ldr	r3, .L531+16
.LPIC131:
	add	r10, pc
	add	r8, sp, #64
	add	r5, sp, #40
.LPIC132:
	add	r3, pc
	str	r3, [sp, #8]
.L502:
	bl	getpid(PLT)
	mov	r1, #524288
	mov	r4, r0
	mov	r0, fp
	bl	open64(PLT)
	movs	r2, #4
	sub	r1, r8, #28
	subs	r9, r0, #0
	blt	.L504
	bl	read(PLT)
	mov	r7, r0
	mov	r0, r9
	bl	close(PLT)
	cmp	r7, #4
	beq	.L526
.L504:
	mov	r1, r6
	movs	r0, #0
	bl	__clock_gettime64(PLT)
	ldr	r9, [r6, #8]
	bl	getpid(PLT)
	mov	r7, r0
	bl	clock(PLT)
	eor	r3, r9, r0
	eor	r0, r3, r7, lsl #16
.L505:
	strd	r4, r0, [sp]
	mov	r3, r10
	ldr	r2, [sp, #8]
	mov	r1, #600
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r2, #448
	mov	r0, r5
	movw	r1, #32961
	bl	open64(PLT)
	subs	r4, r0, #0
	blt	.L527
	ldr	r1, .L531+20
.LPIC135:
	add	r1, pc
	bl	fdopen(PLT)
	mov	r7, r0
	cmp	r0, #0
	beq	.L528
	ldr	r3, [sp, #20]
	cmp	r3, #0
	beq	.L529
.L509:
	ldr	r1, .L531+24
	mov	r0, r7
	ldrd	r3, r2, [sp, #16]
.LPIC137:
	add	r1, pc
	bl	fprintf(PLT)
	mov	r0, r7
	bl	fclose(PLT)
	cmp	r0, #0
	bne	.L530
	movw	r1, #493
	mov	r0, r5
	bl	chmod(PLT)
	mov	r0, r5
	bl	fix_owner(PLT)
	ldr	r2, .L531+28
	ldr	r3, [sp, #28]
	mov	r1, #1024
.LPIC139:
	add	r2, pc
	mov	r0, r6
	str	r5, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	mov	r4, r0
	mov	r0, r5
	bl	unlink(PLT)
.L494:
	mov	r0, r4
	add	sp, sp, #4736
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L527:
	bl	__errno_location(PLT)
	ldr	r0, [r0]
	cmp	r0, #17
	bne	.L507
	ldr	r3, [sp, #12]
	subs	r3, r3, #1
	str	r3, [sp, #12]
	bne	.L502
.L507:
	ldr	r3, .L531+32
	ldr	r2, [sp, #24]
	ldr	r3, [r2, r3]
	ldr	r4, [r3]
	bl	strerror(PLT)
	ldr	r2, .L531+36
	mov	r3, r0
	ldr	r1, .L531+40
	mov	r0, r4
.LPIC133:
	add	r2, pc
.LPIC134:
	add	r1, pc
	bl	fprintf(PLT)
.L503:
	mov	r4, #-1
	b	.L494
.L526:
	sub	r3, r6, #604
	ldr	r0, [r3]
	rev	r0, r0
	b	.L505
.L497:
	ldr	r2, .L531+44
	add	r4, sp, #640
	ldr	r0, [sp, #16]
	mov	r1, #4096
	ldr	r3, [sp, #20]
.LPIC126:
	add	r2, pc
	str	r0, [sp]
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	mov	r4, r0
	mov	r0, r4
	add	sp, sp, #4736
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L529:
	ldr	r3, .L531+48
.LPIC125:
	add	r3, pc
	str	r3, [sp, #20]
	b	.L509
.L530:
	ldr	r3, .L531+32
	mov	r2, r5
	ldr	r0, [sp, #24]
	ldr	r1, .L531+52
	ldr	r3, [r0, r3]
.LPIC138:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r5
	bl	unlink(PLT)
	b	.L503
.L501:
	ldr	r3, .L531+32
	movs	r2, #96
	ldr	r4, [sp, #24]
	movs	r1, #1
	ldr	r0, .L531+56
	ldr	r3, [r4, r3]
.LPIC129:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L503
.L528:
	ldr	r3, .L531+32
	mov	r2, r5
	ldr	r0, [sp, #24]
	ldr	r1, .L531+60
	ldr	r3, [r0, r3]
.LPIC136:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r4
	bl	close(PLT)
	mov	r0, r5
	bl	unlink(PLT)
	b	.L503
.L532:
	.align	2
.L531:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC128+4)
	.word	.LC49-(.LPIC127+4)
	.word	.LC63-(.LPIC130+4)
	.word	.LC64-(.LPIC131+4)
	.word	.LC65-(.LPIC132+4)
	.word	.LC67-(.LPIC135+4)
	.word	.LC69-(.LPIC137+4)
	.word	.LC71-(.LPIC139+4)
	.word	stderr(GOT)
	.word	.LC64-(.LPIC133+4)
	.word	.LC66-(.LPIC134+4)
	.word	.LC61-(.LPIC126+4)
	.word	.LC42-(.LPIC125+4)
	.word	.LC70-(.LPIC138+4)
	.word	.LC62-(.LPIC129+4)
	.word	.LC68-(.LPIC136+4)
	.section	.rodata.str1.4
	.align	2
.LC72:
	.ascii	"/usr/local/emerge/builds\000"
	.align	2
.LC73:
	.ascii	"/usr/local/emerge/backups\000"
	.align	2
.LC74:
	.ascii	"%smkdir -p '%s' '%s'\000"
	.align	2
.LC75:
	.ascii	"\033[1;31m[-] Could not create %s\012\033[0m\000"
	.align	2
.LC76:
	.ascii	"._-\000"
	.align	2
.LC77:
	.ascii	"%schown -R '%s' '%s'\000"
	.align	2
.LC78:
	.ascii	"/usr/local/emerge/world\000"
	.align	2
.LC79:
	.ascii	"a\000"
	.align	2
.LC80:
	.ascii	"\033[1;31m[-] Cannot write world file %s\012\033[0m"
	.ascii	"\000"
	.align	2
.LC81:
	.ascii	"\033[1;31m[-] World file %s is not writable.\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	init_system
	.syntax unified
	.thumb
	.thumb_func
	.type	init_system, %function
init_system:
	@ args = 0, pretend = 0, frame = 5640
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	ldr	r0, .L609
	sub	sp, sp, #5632
	ldr	r7, .L609+4
	sub	sp, sp, #20
.LPIC144:
	add	r0, pc
	add	r5, sp, #1040
.LPIC151:
	add	r7, pc
	mov	r1, r5
	bl	__stat64_time64(PLT)
	cbnz	r0, .L537
	ldr	r3, [r5, #16]
	and	r3, r3, #61440
	cmp	r3, #16384
	beq	.L602
.L537:
	bl	geteuid(PLT)
	cmp	r0, #0
	beq	.L603
.L566:
	ldr	r3, .L609+8
.LPIC141:
	add	r3, pc
.L540:
	ldr	r1, .L609+12
	add	r4, sp, #16
	ldr	r2, .L609+16
	mov	r0, r4
.LPIC147:
	add	r1, pc
.LPIC148:
	add	r2, pc
	strd	r2, r1, [sp]
	ldr	r2, .L609+20
	mov	r1, #1024
.LPIC146:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L604
.L539:
	bl	geteuid(PLT)
	cbz	r0, .L545
	ldr	r0, .L609+24
	movs	r1, #2
.LPIC153:
	add	r0, pc
	bl	access(PLT)
	cbz	r0, .L546
.L545:
	ldr	r0, .L609+28
.LPIC152:
	add	r0, pc
	bl	getenv(PLT)
	mov	r6, r0
	cbz	r0, .L544
	ldrb	r4, [r0]	@ zero_extendqisi2
	cmp	r4, #0
	bne	.L547
.L544:
	bl	getuid(PLT)
	bl	getpwuid(PLT)
	cbz	r0, .L546
	ldr	r6, [r0]
	cmp	r6, #0
	bne	.L605
.L546:
	ldr	r0, .L609+32
	mov	r1, r5
.LPIC158:
	add	r0, pc
	bl	__stat64_time64(PLT)
	cbnz	r0, .L553
	ldr	r3, [r5, #16]
	and	r3, r3, #61440
	cmp	r3, #32768
	beq	.L557
.L553:
	ldr	r4, .L609+36
	ldr	r1, .L609+40
.LPIC160:
	add	r4, pc
.LPIC159:
	add	r1, pc
	mov	r0, r4
	bl	fopen_nofollow(PLT)
	cmp	r0, #0
	beq	.L606
	bl	fclose(PLT)
.L557:
	bl	geteuid(PLT)
	cbz	r0, .L607
.L560:
	ldr	r4, .L609+44
	movs	r1, #2
.LPIC167:
	add	r4, pc
	mov	r0, r4
	bl	access(PLT)
	cmp	r0, #0
	bne	.L608
	movs	r0, #1
	add	sp, sp, #5632
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L602:
	ldr	r0, .L609+48
	mov	r1, r5
.LPIC145:
	add	r0, pc
	bl	__stat64_time64(PLT)
	cmp	r0, #0
	bne	.L537
	ldr	r3, [r5, #16]
	and	r3, r3, #61440
	cmp	r3, #16384
	beq	.L539
	bl	geteuid(PLT)
	cmp	r0, #0
	bne	.L566
.L603:
	ldr	r3, .L609+52
.LPIC140:
	add	r3, pc
	b	.L540
.L607:
	ldr	r0, .L609+56
.LPIC163:
	add	r0, pc
	bl	getenv(PLT)
	mov	r3, r0
	cbz	r0, .L561
	ldrb	r2, [r0]	@ zero_extendqisi2
	cbnz	r2, .L562
.L561:
	bl	getuid(PLT)
	bl	getpwuid(PLT)
	cmp	r0, #0
	beq	.L560
	ldr	r3, [r0]
	cmp	r3, #0
	beq	.L560
.L562:
	ldr	r2, .L609+60
	add	r4, sp, #16
	mov	r1, #1024
	mov	r0, r4
.LPIC165:
	add	r2, pc
	str	r2, [sp]
	ldr	r2, .L609+64
.LPIC164:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r2, .L609+68
	mov	r3, r4
	mov	r1, #4608
.LPIC166:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	b	.L560
.L547:
	bl	valid_pkgname(PLT)
	cbnz	r0, .L549
	mov	r1, r4
.L564:
	ldr	r8, .L609+72
	mov	r4, r6
	str	r1, [sp, #12]
	bl	__ctype_b_loc(PLT)
	ldr	r1, [sp, #12]
.LPIC154:
	add	r8, pc
	ldr	r9, [r0]
.L551:
	ldrh	r3, [r9, r1, lsl #1]
	mov	r0, r8
	lsls	r3, r3, #28
	bmi	.L550
	bl	strchr(PLT)
	cmp	r0, #0
	beq	.L546
.L550:
	ldrb	r1, [r4, #1]!	@ zero_extendqisi2
	cmp	r1, #0
	bne	.L551
.L549:
	bl	geteuid(PLT)
	cmp	r0, #0
	bne	.L567
	ldr	r3, .L609+76
.LPIC142:
	add	r3, pc
.L552:
	ldr	r2, .L609+80
	add	r4, sp, #16
	mov	r1, #1024
	mov	r0, r4
.LPIC156:
	add	r2, pc
	str	r2, [sp, #4]
	ldr	r2, .L609+84
	str	r6, [sp]
.LPIC155:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r2, .L609+88
	mov	r3, r4
	mov	r1, #4608
.LPIC157:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	b	.L546
.L608:
	ldr	r3, .L609+92
	mov	r2, r4
	ldr	r1, .L609+96
.LPIC169:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L541:
	movs	r0, #0
	add	sp, sp, #5632
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L605:
	mov	r0, r6
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	bne	.L549
	ldrb	r1, [r6]	@ zero_extendqisi2
	cmp	r1, #0
	bne	.L564
	b	.L549
.L604:
	ldr	r3, .L609+92
	ldr	r2, .L609+100
	ldr	r1, .L609+104
.LPIC149:
	add	r2, pc
	ldr	r3, [r7, r3]
.LPIC150:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L541
.L567:
	ldr	r3, .L609+108
.LPIC143:
	add	r3, pc
	b	.L552
.L606:
	ldr	r3, .L609+92
	mov	r2, r4
	ldr	r1, .L609+112
.LPIC162:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L541
.L610:
	.align	2
.L609:
	.word	.LC72-(.LPIC144+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC151+4)
	.word	.LC51-(.LPIC141+4)
	.word	.LC73-(.LPIC147+4)
	.word	.LC72-(.LPIC148+4)
	.word	.LC74-(.LPIC146+4)
	.word	.LC64-(.LPIC153+4)
	.word	.LC49-(.LPIC152+4)
	.word	.LC78-(.LPIC158+4)
	.word	.LC78-(.LPIC160+4)
	.word	.LC79-(.LPIC159+4)
	.word	.LC78-(.LPIC167+4)
	.word	.LC73-(.LPIC145+4)
	.word	.LC42-(.LPIC140+4)
	.word	.LC49-(.LPIC163+4)
	.word	.LC78-(.LPIC165+4)
	.word	.LC60-(.LPIC164+4)
	.word	.LC46-(.LPIC166+4)
	.word	.LC76-(.LPIC154+4)
	.word	.LC42-(.LPIC142+4)
	.word	.LC64-(.LPIC156+4)
	.word	.LC77-(.LPIC155+4)
	.word	.LC46-(.LPIC157+4)
	.word	stderr(GOT)
	.word	.LC81-(.LPIC169+4)
	.word	.LC64-(.LPIC149+4)
	.word	.LC75-(.LPIC150+4)
	.word	.LC51-(.LPIC143+4)
	.word	.LC80-(.LPIC162+4)
	.section	.rodata.str1.4
	.align	2
.LC82:
	.ascii	"nano\000"
	.align	2
.LC83:
	.ascii	"EDITOR\000"
	.text
	.align	1
	.p2align 2,,3
	.global	get_editor
	.syntax unified
	.thumb
	.thumb_func
	.type	get_editor, %function
get_editor:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L616
	push	{r3, lr}
.LPIC172:
	add	r0, pc
	bl	getenv(PLT)
	cbz	r0, .L613
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbz	r3, .L615
	pop	{r3, pc}
.L615:
	ldr	r0, .L616+4
.LPIC171:
	add	r0, pc
	pop	{r3, pc}
.L613:
	ldr	r0, .L616+8
.LPIC170:
	add	r0, pc
	pop	{r3, pc}
.L617:
	.align	2
.L616:
	.word	.LC83-(.LPIC172+4)
	.word	.LC82-(.LPIC171+4)
	.word	.LC82-(.LPIC170+4)
	.align	1
	.p2align 2,,3
	.global	get_cpu_cores
	.syntax unified
	.thumb
	.thumb_func
	.type	get_cpu_cores, %function
get_cpu_cores:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
	movs	r0, #84
	bl	sysconf(PLT)
	cmp	r0, #1
	it	lt
	movlt	r0, #1
	pop	{r3, pc}
	.section	.rodata.str1.4
	.align	2
.LC84:
	.ascii	"-j%ld\000"
	.align	2
.LC85:
	.ascii	"KCFLAGS\000"
	.align	2
.LC86:
	.ascii	"KCPPFLAGS\000"
	.align	2
.LC87:
	.ascii	"MAKEFLAGS\000"
	.text
	.align	1
	.p2align 2,,3
	.global	set_build_env
	.syntax unified
	.thumb
	.thumb_func
	.type	set_build_env, %function
set_build_env:
	@ args = 0, pretend = 0, frame = 336
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L626
	push	{r4, r5, lr}
.LPIC175:
	add	r3, pc
	sub	sp, sp, #348
	ldr	r3, [r3, #12]
	cmp	r3, #0
	ble	.L625
.L621:
	ldr	r2, .L626+4
	add	r5, sp, #24
	movs	r1, #64
	mov	r0, r5
.LPIC176:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r3, .L626+8
.LPIC177:
	add	r3, pc
	ldr	r3, [r3, #168]
	cbz	r3, .L623
	ldr	r3, .L626+12
.LPIC173:
	add	r3, pc
.L622:
	ldr	r2, .L626+16
	add	r4, sp, #8
	movs	r1, #16
	mov	r0, r4
.LPIC178:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r3, .L626+20
	ldr	r2, .L626+24
	str	r4, [sp, #4]
.LPIC179:
	add	r3, pc
	add	r4, sp, #88
	add	r1, r3, #152
.LPIC180:
	add	r2, pc
	adds	r3, r3, #24
	str	r1, [sp]
	mov	r0, r4
	mov	r1, #256
	bl	xsnprintf(PLT)
	ldr	r0, .L626+28
	mov	r1, r4
	movs	r2, #1
.LPIC182:
	add	r0, pc
	bl	setenv(PLT)
	ldr	r0, .L626+32
	mov	r1, r4
	movs	r2, #1
.LPIC183:
	add	r0, pc
	bl	setenv(PLT)
	ldr	r0, .L626+36
	movs	r2, #1
	mov	r1, r5
.LPIC184:
	add	r0, pc
	bl	setenv(PLT)
	add	sp, sp, #348
	@ sp needed
	pop	{r4, r5, pc}
.L623:
	ldr	r3, .L626+40
.LPIC174:
	add	r3, pc
	b	.L622
.L625:
	movs	r0, #84
	bl	sysconf(PLT)
	cmp	r0, #1
	mov	r3, r0
	it	lt
	movlt	r3, #1
	b	.L621
.L627:
	.align	2
.L626:
	.word	.LANCHOR0-(.LPIC175+4)
	.word	.LC84-(.LPIC176+4)
	.word	.LANCHOR1-(.LPIC177+4)
	.word	.LC43-(.LPIC173+4)
	.word	.LC41-(.LPIC178+4)
	.word	.LANCHOR1-(.LPIC179+4)
	.word	.LC45-(.LPIC180+4)
	.word	.LC85-(.LPIC182+4)
	.word	.LC86-(.LPIC183+4)
	.word	.LC87-(.LPIC184+4)
	.word	.LC42-(.LPIC174+4)
	.section	.rodata.str1.4
	.align	2
.LC88:
	.ascii	"0\000"
	.align	2
.LC89:
	.ascii	"1\000"
	.align	2
.LC90:
	.ascii	"2\000"
	.align	2
.LC91:
	.ascii	"s\000"
	.align	2
.LC92:
	.ascii	"3\000"
	.align	2
.LC93:
	.ascii	" %s\000"
	.align	2
.LC94:
	.ascii	"z\000"
	.align	2
.LC95:
	.ascii	"g\000"
	.align	2
.LC96:
	.ascii	"-C opt-level=%s -C target-cpu=%s\000"
	.align	2
.LC97:
	.ascii	"%s/makepkg.archtoo.conf\000"
	.align	2
.LC98:
	.ascii	"\033[1;31m[-] Cannot write %s\012\033[0m\000"
	.align	2
.LC99:
	.ascii	"# Generated by archtoo -- do not edit, it is rewrit"
	.ascii	"ten every build.\012# target=%s opt=%s pipe=%d\012s"
	.ascii	"ource /etc/makepkg.conf\012CFLAGS=\"%s\"\012CXXFLAG"
	.ascii	"S=\"%s\"\012LDFLAGS=\"${LDFLAGS}%s\"\012RUSTFLAGS=\""
	.ascii	"%s\"\012MAKEFLAGS=\"-j%ld\"\012\000"
	.text
	.align	1
	.p2align 2,,3
	.global	write_makepkg_conf
	.syntax unified
	.thumb
	.thumb_func
	.type	write_makepkg_conf, %function
write_makepkg_conf:
	@ args = 0, pretend = 0, frame = 992
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r5, r0
	ldr	r3, .L665
	sub	sp, sp, #1020
	ldr	r2, .L665+4
	ldr	r7, .L665+8
.LPIC192:
	add	r3, pc
	add	r6, sp, #32
.LPIC193:
	add	r2, pc
	adds	r3, r3, #152
	mov	r4, r1
	mov	r0, r6
	movs	r1, #16
	add	r8, sp, #248
.LPIC209:
	add	r7, pc
	add	r9, sp, #504
	str	r7, [sp, #28]
	bl	xsnprintf(PLT)
	mov	r1, #256
	mov	r0, r8
	add	r7, sp, #48
	bl	render_build_flags(PLT)
	mov	r1, #256
	mov	r0, r9
	bl	render_build_flags(PLT)
	ldr	r3, .L665+12
	movs	r2, #0
	strb	r2, [r7]
.LPIC194:
	add	r3, pc
	ldrb	r2, [r3, #16]	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L656
.L629:
	ldrh	r3, [r6]
	cmp	r3, #48
	beq	.L657
	cmp	r3, #49
	beq	.L658
	cmp	r3, #50
	beq	.L659
	cmp	r3, #115
	beq	.L660
	cmp	r3, #122
	beq	.L661
	cmp	r3, #103
	beq	.L662
	ldr	r3, .L665+16
.LPIC189:
	add	r3, pc
	b	.L632
.L657:
	ldr	r3, .L665+20
.LPIC185:
	add	r3, pc
.L632:
	ldr	fp, .L665+24
	add	r10, sp, #760
	ldr	r2, .L665+28
	mov	r0, r10
.LPIC204:
	add	fp, pc
.LPIC203:
	add	r2, pc
	add	r1, fp, #24
	str	r1, [sp]
	mov	r1, #256
	bl	xsnprintf(PLT)
	ldr	r3, .L665+32
	ldr	r2, .L665+36
	mov	r1, r4
.LPIC205:
	add	r3, pc
	mov	r0, r5
.LPIC206:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r1, .L665+40
	mov	r0, r5
.LPIC207:
	add	r1, pc
	bl	fopen_nofollow(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L663
	ldr	r3, .L665+44
	ldr	fp, [fp, #168]
.LPIC211:
	add	r3, pc
	ldr	r0, [r3, #12]
	cmp	r0, #0
	ble	.L664
.L645:
	ldr	r2, .L665+48
	mov	r3, r6
	ldr	r1, .L665+52
.LPIC212:
	add	r2, pc
	strd	r10, r0, [sp, #16]
.LPIC213:
	add	r1, pc
	adds	r2, r2, #24
	mov	r0, r4
	strd	r9, r7, [sp, #8]
	str	r8, [sp, #4]
	str	fp, [sp]
	bl	fprintf(PLT)
	mov	r0, r4
	bl	fclose(PLT)
	mov	r0, r5
	bl	fix_owner(PLT)
	movs	r0, #1
.L628:
	add	sp, sp, #1020
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L656:
	ldr	r2, .L665+56
	adds	r3, r3, #16
	movs	r1, #200
	mov	r0, r7
.LPIC196:
	add	r2, pc
	bl	xsnprintf(PLT)
	b	.L629
.L664:
	movs	r0, #84
	bl	sysconf(PLT)
	cmp	r0, #1
	it	lt
	movlt	r0, #1
	b	.L645
.L658:
	ldr	r3, .L665+60
.LPIC186:
	add	r3, pc
	b	.L632
.L659:
	ldr	r3, .L665+64
.LPIC187:
	add	r3, pc
	b	.L632
.L660:
	ldr	r3, .L665+68
.LPIC188:
	add	r3, pc
	b	.L632
.L662:
	ldr	r3, .L665+72
.LPIC191:
	add	r3, pc
	b	.L632
.L661:
	ldr	r3, .L665+76
.LPIC190:
	add	r3, pc
	b	.L632
.L663:
	ldr	r3, .L665+80
	mov	r2, r5
	ldr	r0, [sp, #28]
	ldr	r1, .L665+84
	ldr	r3, [r0, r3]
.LPIC208:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r4
	b	.L628
.L666:
	.align	2
.L665:
	.word	.LANCHOR1-(.LPIC192+4)
	.word	.LC41-(.LPIC193+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC209+4)
	.word	.LANCHOR0-(.LPIC194+4)
	.word	.LC92-(.LPIC189+4)
	.word	.LC88-(.LPIC185+4)
	.word	.LANCHOR1-(.LPIC204+4)
	.word	.LC96-(.LPIC203+4)
	.word	.LC64-(.LPIC205+4)
	.word	.LC97-(.LPIC206+4)
	.word	.LC67-(.LPIC207+4)
	.word	.LANCHOR0-(.LPIC211+4)
	.word	.LANCHOR1-(.LPIC212+4)
	.word	.LC99-(.LPIC213+4)
	.word	.LC93-(.LPIC196+4)
	.word	.LC89-(.LPIC186+4)
	.word	.LC90-(.LPIC187+4)
	.word	.LC91-(.LPIC188+4)
	.word	.LC89-(.LPIC191+4)
	.word	.LC91-(.LPIC190+4)
	.word	stderr(GOT)
	.word	.LC98-(.LPIC208+4)
	.section	.rodata.str1.4
	.align	2
.LC100:
	.ascii	"Y/n\000"
	.align	2
.LC101:
	.ascii	"yes\000"
	.align	2
.LC102:
	.ascii	"y/N\000"
	.align	2
.LC103:
	.ascii	"no\000"
	.align	2
.LC104:
	.ascii	"%s [%s]: %s (auto)\012\000"
	.align	2
.LC105:
	.ascii	"%s [%s]: \000"
	.align	2
.LC106:
	.ascii	"%s (default after %lds)\012\000"
	.text
	.align	1
	.p2align 2,,3
	.global	ask_yes_no
	.syntax unified
	.thumb
	.thumb_func
	.type	ask_yes_no, %function
ask_yes_no:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L707
	push	{r4, r5, r6, lr}
	mov	r6, r0
.LPIC222:
	add	r3, pc
	ldr	r5, .L707+4
	sub	sp, sp, #64
	mov	r4, r1
	ldr	r0, [r3]
.LPIC226:
	add	r5, pc
	cbnz	r0, .L671
	ldr	r3, .L707+8
.LPIC223:
	add	r3, pc
	ldr	r3, [r3]
	cbnz	r3, .L702
.L671:
	cbnz	r4, .L669
	ldr	r2, .L707+12
	ldr	r3, .L707+16
.LPIC216:
	add	r2, pc
.LPIC217:
	add	r3, pc
.L670:
	ldr	r0, .L707+20
	mov	r1, r6
.LPIC224:
	add	r0, pc
	bl	printf(PLT)
.L673:
	mov	r0, r4
.L667:
	add	sp, sp, #64
	@ sp needed
	pop	{r4, r5, r6, pc}
.L669:
	ldr	r2, .L707+24
	ldr	r3, .L707+28
.LPIC214:
	add	r2, pc
.LPIC215:
	add	r3, pc
	b	.L670
.L702:
	bl	isatty(PLT)
	cmp	r0, #0
	beq	.L671
	cmp	r4, #0
	bne	.L703
	ldr	r2, .L707+32
.LPIC219:
	add	r2, pc
.L674:
	ldr	r0, .L707+36
	mov	r1, r6
.LPIC225:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, .L707+40
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fflush(PLT)
	ldr	r3, .L707+44
.LPIC227:
	add	r3, pc
	ldr	r2, [r3, #4]
	cmp	r2, #0
	it	le
	movle	r6, sp
	ble	.L675
	movw	r3, #50331
	movt	r3, 32
	cmp	r2, r3
	vmov.i32	d16, #0  @ v8qi
	it	le
	movle	r3, #1000
	mov	r1, #1
	it	gt
	movwgt	r2, #64888
	mov	r0, sp
	it	gt
	movtgt	r2, 32767
	mov	r6, sp
	it	le
	mulle	r2, r3, r2
	vstr	d16, [sp]
	strh	r1, [sp, #4]	@ movhi
	movs	r1, #1
	bl	poll(PLT)
	cmp	r0, #0
	beq	.L704
	blt	.L705
.L675:
	ldr	r3, .L707+48
	movs	r1, #64
	mov	r0, r6
	ldr	r5, [r5, r3]
	ldr	r2, [r5]
	bl	fgets(PLT)
	cmp	r0, #0
	beq	.L673
	movs	r1, #10
	mov	r0, r6
	bl	strchr(PLT)
	cbz	r0, .L683
.L682:
	ldrb	r3, [sp]	@ zero_extendqisi2
	cmp	r3, #13
	bhi	.L684
	movw	r2, #9217
	lsrs	r2, r2, r3
	lsls	r2, r2, #31
	bmi	.L673
.L684:
	and	r3, r3, #223
	sub	r0, r3, #89
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L667
.L683:
	ldr	r0, [r5]
	bl	getc(PLT)
	cmp	r0, #-1
	it	ne
	cmpne	r0, #10
	bne	.L683
	b	.L682
.L703:
	ldr	r2, .L707+52
.LPIC218:
	add	r2, pc
	b	.L674
.L704:
	cbnz	r4, .L706
	ldr	r1, .L707+56
.LPIC221:
	add	r1, pc
.L678:
	ldr	r3, .L707+60
	ldr	r0, .L707+64
.LPIC228:
	add	r3, pc
.LPIC229:
	add	r0, pc
	ldr	r2, [r3, #4]
	bl	printf(PLT)
	b	.L673
.L706:
	ldr	r1, .L707+68
.LPIC220:
	add	r1, pc
	b	.L678
.L705:
	bl	__errno_location(PLT)
	ldr	r3, [r0]
	cmp	r3, #4
	beq	.L675
	b	.L673
.L708:
	.align	2
.L707:
	.word	.LANCHOR0-(.LPIC222+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC226+4)
	.word	.LANCHOR1-(.LPIC223+4)
	.word	.LC102-(.LPIC216+4)
	.word	.LC103-(.LPIC217+4)
	.word	.LC104-(.LPIC224+4)
	.word	.LC100-(.LPIC214+4)
	.word	.LC101-(.LPIC215+4)
	.word	.LC102-(.LPIC219+4)
	.word	.LC105-(.LPIC225+4)
	.word	stdout(GOT)
	.word	.LANCHOR1-(.LPIC227+4)
	.word	stdin(GOT)
	.word	.LC100-(.LPIC218+4)
	.word	.LC103-(.LPIC221+4)
	.word	.LANCHOR1-(.LPIC228+4)
	.word	.LC106-(.LPIC229+4)
	.word	.LC101-(.LPIC220+4)
	.align	1
	.p2align 2,,3
	.global	set_use_binary
	.syntax unified
	.thumb
	.thumb_func
	.type	set_use_binary, %function
set_use_binary:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L710
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
.LPIC230:
	add	r3, pc
	str	r0, [r3, #412]
	bx	lr
.L711:
	.align	2
.L710:
	.word	.LANCHOR0-(.LPIC230+4)
	.align	1
	.p2align 2,,3
	.global	get_use_binary
	.syntax unified
	.thumb
	.thumb_func
	.type	get_use_binary, %function
get_use_binary:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L713
.LPIC231:
	add	r3, pc
	ldr	r0, [r3, #412]
	bx	lr
.L714:
	.align	2
.L713:
	.word	.LANCHOR0-(.LPIC231+4)
	.section	.rodata.str1.4
	.align	2
.LC107:
	.ascii	"..\000"
	.text
	.align	1
	.p2align 2,,3
	.global	valid_gentoo_chroot_path
	.syntax unified
	.thumb
	.thumb_func
	.type	valid_gentoo_chroot_path, %function
valid_gentoo_chroot_path:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r5, r0
	cbz	r0, .L723
	ldrb	r4, [r0]	@ zero_extendqisi2
	cbz	r4, .L723
	bl	strlen(PLT)
	subs	r4, r4, #47
	add	r0, r0, #-1
	it	ne
	movne	r4, #1
	cmp	r0, #500
	it	cs
	orrcs	r4, r4, #1
	cbz	r4, .L726
.L723:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, pc}
.L726:
	ldr	r7, .L729
	bl	__ctype_b_loc(PLT)
	movs	r2, #47
	ldr	r6, [r0]
.LPIC232:
	add	r7, pc
	b	.L718
.L728:
	ldrb	r2, [r5, #1]!	@ zero_extendqisi2
	cbz	r2, .L727
.L718:
	ldrh	r3, [r6, r2, lsl #1]
	mov	r1, r7
	mov	r0, r5
	sub	r4, r2, #45
	ands	r3, r3, #8
	bne	.L717
	cmp	r4, #2
	bls	.L717
	cmp	r2, #95
	bne	.L723
.L717:
	bl	strstr(PLT)
	cmp	r0, #0
	beq	.L728
	b	.L723
.L727:
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, pc}
.L730:
	.align	2
.L729:
	.word	.LC107-(.LPIC232+4)
	.align	1
	.p2align 2,,3
	.global	set_gentoo_chroot
	.syntax unified
	.thumb
	.thumb_func
	.type	set_gentoo_chroot, %function
set_gentoo_chroot:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L732
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
.LPIC233:
	add	r3, pc
	str	r0, [r3, #416]
	bx	lr
.L733:
	.align	2
.L732:
	.word	.LANCHOR0-(.LPIC233+4)
	.align	1
	.p2align 2,,3
	.global	get_gentoo_chroot
	.syntax unified
	.thumb
	.thumb_func
	.type	get_gentoo_chroot, %function
get_gentoo_chroot:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L735
.LPIC234:
	add	r3, pc
	ldr	r0, [r3, #416]
	bx	lr
.L736:
	.align	2
.L735:
	.word	.LANCHOR0-(.LPIC234+4)
	.align	1
	.p2align 2,,3
	.global	set_portage_imitation
	.syntax unified
	.thumb
	.thumb_func
	.type	set_portage_imitation, %function
set_portage_imitation:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L738
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
.LPIC235:
	add	r3, pc
	str	r0, [r3, #420]
	bx	lr
.L739:
	.align	2
.L738:
	.word	.LANCHOR0-(.LPIC235+4)
	.align	1
	.p2align 2,,3
	.global	get_portage_imitation
	.syntax unified
	.thumb
	.thumb_func
	.type	get_portage_imitation, %function
get_portage_imitation:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L741
.LPIC236:
	add	r3, pc
	ldrd	r3, r0, [r3, #416]
	orrs	r0, r0, r3
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
	bx	lr
.L742:
	.align	2
.L741:
	.word	.LANCHOR0-(.LPIC236+4)
	.align	1
	.p2align 2,,3
	.global	set_gentoo_chroot_path
	.syntax unified
	.thumb
	.thumb_func
	.type	set_gentoo_chroot_path, %function
set_gentoo_chroot_path:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L752
	push	{r4, lr}
	mov	r4, r0
	bl	valid_gentoo_chroot_path(PLT)
	cbnz	r0, .L755
	pop	{r4, pc}
.L755:
	ldr	r0, .L756
	mov	r3, r4
	ldr	r2, .L756+4
	mov	r1, #512
.LPIC239:
	add	r0, pc
	pop	{r4, lr}
.LPIC238:
	add	r2, pc
	adds	r0, r0, #176
	b	xsnprintf(PLT)
.L752:
	bx	lr
.L757:
	.align	2
.L756:
	.word	.LANCHOR1-(.LPIC239+4)
	.word	.LC41-(.LPIC238+4)
	.align	1
	.p2align 2,,3
	.global	get_gentoo_chroot_path
	.syntax unified
	.thumb
	.thumb_func
	.type	get_gentoo_chroot_path, %function
get_gentoo_chroot_path:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L759
.LPIC240:
	add	r0, pc
	adds	r0, r0, #176
	bx	lr
.L760:
	.align	2
.L759:
	.word	.LANCHOR1-(.LPIC240+4)
	.data
	.align	3
	.set	.LANCHOR1,. + 0
	.type	g_emerge_confirm, %object
g_emerge_confirm:
	.word	1
	.type	g_prompt_timeout, %object
g_prompt_timeout:
	.word	300
	.type	g_import_keys, %object
g_import_keys:
	.word	1
	.type	g_inhibit, %object
g_inhibit:
	.word	1
	.type	g_sync, %object
g_sync:
	.word	1
	.type	g_aur_sync, %object
g_aur_sync:
	.word	1
	.type	g_target_arch, %object
g_target_arch:
	.ascii	"native\000"
	.space	121
	.type	g_opt_level, %object
g_opt_level:
	.ascii	"3\000"
	.space	14
	.type	g_use_pipe, %object
g_use_pipe:
	.word	1
	.space	4
	.type	g_gentoo_chroot_path, %object
g_gentoo_chroot_path:
	.ascii	"/usr/local/emerge/gentoo-chroot\000"
	.space	480
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_noconfirm, %object
g_noconfirm:
	.space	4
	.type	g_interactive, %object
g_interactive:
	.space	4
	.type	g_resume, %object
g_resume:
	.space	4
	.type	g_jobs, %object
g_jobs:
	.space	4
	.type	g_raw_flags, %object
g_raw_flags:
	.space	193
	.space	7
	.type	g_makepkg_raw, %object
g_makepkg_raw:
	.space	193
	.space	3
	.type	g_use_binary, %object
g_use_binary:
	.space	4
	.type	g_gentoo_chroot, %object
g_gentoo_chroot:
	.space	4
	.type	g_portage_imitation, %object
g_portage_imitation:
	.space	4
	.section	.note.GNU-stack,"",%progbits
