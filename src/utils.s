	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.global	set_noconfirm
	.type	set_noconfirm, %function
set_noconfirm:
	adrp	x1, .LANCHOR0
	str	w0, [x1, #:lo12:.LANCHOR0]
	ret
	.align	2
	.p2align 5,,15
	.global	get_noconfirm
	.type	get_noconfirm, %function
get_noconfirm:
	adrp	x0, .LANCHOR0
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	ret
	.align	2
	.p2align 5,,15
	.global	set_emerge_confirm
	.type	set_emerge_confirm, %function
set_emerge_confirm:
	adrp	x1, .LANCHOR1
	str	w0, [x1, #:lo12:.LANCHOR1]
	ret
	.align	2
	.p2align 5,,15
	.global	get_emerge_confirm
	.type	get_emerge_confirm, %function
get_emerge_confirm:
	adrp	x0, .LANCHOR1
	ldr	w0, [x0, #:lo12:.LANCHOR1]
	ret
	.align	2
	.p2align 5,,15
	.global	set_interactive
	.type	set_interactive, %function
set_interactive:
	adrp	x1, .LANCHOR0+4
	str	w0, [x1, #:lo12:.LANCHOR0+4]
	ret
	.align	2
	.p2align 5,,15
	.global	get_interactive
	.type	get_interactive, %function
get_interactive:
	adrp	x0, .LANCHOR0+4
	ldr	w0, [x0, #:lo12:.LANCHOR0+4]
	ret
	.align	2
	.p2align 5,,15
	.global	use_noconfirm
	.type	use_noconfirm, %function
use_noconfirm:
	adrp	x0, .LANCHOR0
	add	x2, x0, :lo12:.LANCHOR0
	ldr	w1, [x0, #:lo12:.LANCHOR0]
	mov	w0, 1
	cbnz	w1, .L8
	ldr	w0, [x2, 4]
	cmp	w0, 0
	cset	w0, eq
.L8:
	ret
	.align	2
	.p2align 5,,15
	.global	set_prompt_timeout
	.type	set_prompt_timeout, %function
set_prompt_timeout:
	adrp	x1, .LANCHOR1+8
	str	x0, [x1, #:lo12:.LANCHOR1+8]
	ret
	.align	2
	.p2align 5,,15
	.global	get_prompt_timeout
	.type	get_prompt_timeout, %function
get_prompt_timeout:
	adrp	x0, .LANCHOR1+8
	ldr	x0, [x0, #:lo12:.LANCHOR1+8]
	ret
	.align	2
	.p2align 5,,15
	.global	set_resume
	.type	set_resume, %function
set_resume:
	adrp	x1, .LANCHOR0+8
	str	w0, [x1, #:lo12:.LANCHOR0+8]
	ret
	.align	2
	.p2align 5,,15
	.global	get_resume
	.type	get_resume, %function
get_resume:
	adrp	x0, .LANCHOR0+8
	ldr	w0, [x0, #:lo12:.LANCHOR0+8]
	ret
	.align	2
	.p2align 5,,15
	.global	set_import_keys
	.type	set_import_keys, %function
set_import_keys:
	adrp	x1, .LANCHOR1+16
	str	w0, [x1, #:lo12:.LANCHOR1+16]
	ret
	.align	2
	.p2align 5,,15
	.global	get_import_keys
	.type	get_import_keys, %function
get_import_keys:
	adrp	x0, .LANCHOR1+16
	ldr	w0, [x0, #:lo12:.LANCHOR1+16]
	ret
	.align	2
	.p2align 5,,15
	.global	set_inhibit
	.type	set_inhibit, %function
set_inhibit:
	adrp	x1, .LANCHOR1+20
	str	w0, [x1, #:lo12:.LANCHOR1+20]
	ret
	.align	2
	.p2align 5,,15
	.global	get_inhibit
	.type	get_inhibit, %function
get_inhibit:
	adrp	x0, .LANCHOR1+20
	ldr	w0, [x0, #:lo12:.LANCHOR1+20]
	ret
	.align	2
	.p2align 5,,15
	.global	set_sync
	.type	set_sync, %function
set_sync:
	adrp	x1, .LANCHOR1+24
	str	w0, [x1, #:lo12:.LANCHOR1+24]
	ret
	.align	2
	.p2align 5,,15
	.global	get_sync
	.type	get_sync, %function
get_sync:
	adrp	x0, .LANCHOR1+24
	ldr	w0, [x0, #:lo12:.LANCHOR1+24]
	ret
	.align	2
	.p2align 5,,15
	.global	set_aur_sync
	.type	set_aur_sync, %function
set_aur_sync:
	adrp	x1, .LANCHOR1+28
	str	w0, [x1, #:lo12:.LANCHOR1+28]
	ret
	.align	2
	.p2align 5,,15
	.global	get_aur_sync
	.type	get_aur_sync, %function
get_aur_sync:
	adrp	x0, .LANCHOR1+28
	ldr	w0, [x0, #:lo12:.LANCHOR1+28]
	ret
	.align	2
	.p2align 5,,15
	.global	set_jobs
	.type	set_jobs, %function
set_jobs:
	adrp	x1, .LANCHOR0+16
	str	x0, [x1, #:lo12:.LANCHOR0+16]
	ret
	.align	2
	.p2align 5,,15
	.global	get_jobs
	.type	get_jobs, %function
get_jobs:
	adrp	x0, .LANCHOR0+16
	ldr	x0, [x0, #:lo12:.LANCHOR0+16]
	cmp	x0, 0
	ble	.L30
	ret
	.p2align 2,,3
.L30:
	stp	x29, x30, [sp, -16]!
	mov	w0, 84
	mov	x29, sp
	bl	sysconf
	cmp	x0, 0
	csinc	x0, x0, xzr, gt
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"help"
	.align	3
.LC1:
	.string	"list"
	.text
	.align	2
	.p2align 5,,15
	.global	valid_target_arch
	.type	valid_target_arch, %function
valid_target_arch:
	cbz	x0, .L54
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w20, [x0]
	cbz	w20, .L32
	bl	strlen
	sub	x0, x0, #1
	cmp	x0, 63
	bhi	.L32
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L33
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L33
	bl	__ctype_b_loc
	ldr	x2, [x0]
	ubfiz	x0, x20, 1, 8
	ldrh	w0, [x2, x0]
	and	w1, w0, 8
	tbz	x0, 3, .L32
	.p2align 5,,15
.L37:
	cbnz	w1, .L36
	sub	w0, w20, #45
	cmp	w20, 95
	and	w0, w0, 255
	ccmp	w0, 1, 0, ne
	bhi	.L32
.L36:
	ldrb	w20, [x19, 1]!
	cbz	w20, .L33
	ubfiz	x0, x20, 1, 8
	ldrh	w0, [x2, x0]
	and	w1, w0, 8
	b	.L37
	.p2align 2,,3
.L32:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L33:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L54:
	mov	w0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	get_target_arch
	.type	get_target_arch, %function
get_target_arch:
	adrp	x0, .LANCHOR1
	add	x0, x0, :lo12:.LANCHOR1
	add	x0, x0, 32
	ret
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"\033[1;36mKnown --target values (common x86-64 -march):\n\033[0m"
	.align	3
.LC3:
	.string	"  native (default, detects host CPU)"
	.align	3
.LC4:
	.string	"  x86-64, x86-64-v2, x86-64-v3, x86-64-v4, generic"
	.align	3
.LC5:
	.string	"\n\033[1;36mIntel:\n\033[0m"
	.align	3
.LC6:
	.string	"  bonnell, atom, silvermont, goldmont, goldmont-plus, tremont"
	.align	3
.LC7:
	.string	"  core2, nehalem, westmere, sandybridge, ivybridge"
	.align	3
.LC8:
	.string	"  haswell, broadwell, skylake, skylake-avx512, cannonlake"
	.align	3
.LC9:
	.string	"  icelake-client, icelake-server, cascadelake, tigerlake"
	.align	3
.LC10:
	.string	"  sapphirerapids, alderlake, raptorlake, meteorlake, arrowlake"
	.align	3
.LC11:
	.string	"  lunarlake, emeraldrapids, graniterapids"
	.align	3
.LC12:
	.base64	"ChtbMTszNm1BTUQ6ChtbMG0A"
	.align	3
.LC13:
	.string	"  k8, athlon64, amdfam10, bdver1, bdver2, bdver3, bdver4"
	.align	3
.LC14:
	.string	"  znver1, znver2, znver3, znver4, znver5"
	.align	3
.LC15:
	.string	"  btver1, btver2"
	.align	3
.LC16:
	.string	"\nExamples:"
	.align	3
.LC17:
	.string	"  emerge --target=skylake htop"
	.align	3
.LC18:
	.string	"  emerge --target=znver3 firefox"
	.align	3
.LC19:
	.string	"  emerge --target=x86-64-v3 --jobs 4 linux-zen"
	.align	3
.LC20:
	.string	"  emerge --target=native -U   (explicit default)"
	.text
	.align	2
	.p2align 5,,15
	.global	print_known_targets
	.type	print_known_targets, %function
print_known_targets:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	mov	x29, sp
	bl	printf
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	puts
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	puts
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	puts
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	puts
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	puts
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	puts
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	printf
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	puts
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	puts
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	puts
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	puts
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	puts
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	puts
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	bl	puts
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	b	puts
	.section	.rodata.str1.8
	.align	3
.LC21:
	.string	"fast"
	.text
	.align	2
	.p2align 5,,15
	.global	valid_opt_level
	.type	valid_opt_level, %function
valid_opt_level:
	cbz	x0, .L121
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w20, [x0]
	cbz	w20, .L64
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L66
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L66
	cmp	w20, 45
	beq	.L122
	and	w20, w20, -33
	cmp	w20, 79
	bne	.L77
.L76:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
.L68:
	cbz	w0, .L64
.L77:
	ldrb	w20, [x19]
	cmp	w20, 48
	bne	.L79
	ldrb	w0, [x19, 1]
	cbnz	w0, .L79
	.p2align 5,,15
.L66:
	mov	w0, 1
.L61:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L64:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L122:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
	and	w1, w0, -33
	cmp	w1, 79
	beq	.L76
	b	.L68
	.p2align 2,,3
.L79:
	cmp	w20, 49
	bne	.L80
	ldrb	w0, [x19, 1]
	cbz	w0, .L66
.L80:
	cmp	w20, 50
	beq	.L123
.L81:
	cmp	w20, 51
	bne	.L82
	ldrb	w0, [x19, 1]
	cbz	w0, .L66
.L82:
	cmp	w20, 115
	bne	.L83
	ldrb	w0, [x19, 1]
	cbz	w0, .L66
.L83:
	adrp	x1, .LC21
	mov	x0, x19
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L66
	cmp	w20, 103
	bne	.L84
	ldrb	w0, [x19, 1]
	cbz	w0, .L66
.L84:
	subs	w20, w20, #122
	bne	.L75
	ldrb	w20, [x19, 1]
.L75:
	cmp	w20, 0
	cset	w0, eq
	b	.L61
	.p2align 2,,3
.L121:
	mov	w0, 0
	ret
	.p2align 2,,3
.L123:
	ldrb	w0, [x19, 1]
	cbz	w0, .L66
	b	.L81
	.align	2
	.p2align 5,,15
	.global	get_opt_level
	.type	get_opt_level, %function
get_opt_level:
	adrp	x0, .LANCHOR1
	add	x0, x0, :lo12:.LANCHOR1
	add	x0, x0, 160
	ret
	.align	2
	.p2align 5,,15
	.global	valid_raw_flags
	.type	valid_raw_flags, %function
valid_raw_flags:
	cbz	x0, .L147
	ldrb	w1, [x0]
	cbz	w1, .L147
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	str	w1, [sp, 36]
	bl	strlen
	mov	x4, x0
	cmp	x0, 192
	bhi	.L126
	ldr	w1, [sp, 36]
	cmp	w1, 32
	bne	.L136
	mov	x3, x19
	.p2align 5,,15
.L130:
	ldrb	w2, [x3, 1]!
	cmp	w2, 32
	beq	.L130
.L129:
	cmp	w2, 45
	bne	.L126
	str	w1, [sp, 36]
	str	x4, [sp, 40]
	bl	__ctype_b_loc
	ldr	x4, [sp, 40]
	mov	x5, -9223372028264841217
	ldr	w1, [sp, 36]
	movk	x5, 0xf800, lsl 0
	ldr	x3, [x0]
	add	x0, x19, 1
	mov	x6, 1
	movk	x5, 0x2400, lsl 16
.L135:
	ubfiz	x2, x1, 1, 8
	ldrh	w2, [x3, x2]
	tbnz	x2, 3, .L133
	sub	w1, w1, #32
	and	w1, w1, 255
	cmp	w1, 63
	bhi	.L126
	lsl	x1, x6, x1
	tst	x1, x5
	bne	.L133
	tbz	x1, 0, .L126
	ldrb	w1, [x0]
	cmp	w1, 32
	beq	.L126
.L132:
	add	x0, x0, 1
	cbnz	w1, .L135
	add	x2, x19, x4
	ldrb	w0, [x2, -1]
	cmp	w0, 32
	cset	w0, ne
	b	.L125
	.p2align 2,,3
.L126:
	mov	w0, 0
.L125:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L147:
	mov	w0, 0
	ret
	.p2align 2,,3
.L133:
	ldrb	w1, [x0]
	b	.L132
	.p2align 2,,3
.L136:
	mov	w2, w1
	b	.L129
	.align	2
	.p2align 5,,15
	.global	get_raw_flags
	.type	get_raw_flags, %function
get_raw_flags:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x0, x0, 32
	ret
	.section	.rodata.str1.8
	.align	3
.LC22:
	.string	"\033[1;36mKnown --opt-level values:\n\033[0m"
	.align	3
.LC23:
	.string	"  0      -O0 no optimization (debug)"
	.align	3
.LC24:
	.string	"  1      -O1 basic"
	.align	3
.LC25:
	.string	"  2      -O2 balanced (Arch default, good for low RAM)"
	.align	3
.LC26:
	.string	"  3      -O3 aggressive (archtoo default)"
	.align	3
.LC27:
	.string	"  s      -Os optimize for size"
	.align	3
.LC28:
	.string	"  z      -Oz even more size (clang)"
	.align	3
.LC29:
	.string	"  fast   -Ofast break standards, max speed"
	.align	3
.LC30:
	.string	"  g      -Og debug friendly"
	.align	3
.LC31:
	.string	"  emerge --opt-level=2 htop"
	.align	3
.LC32:
	.string	"  emerge -O2 htop               (short)"
	.align	3
.LC33:
	.string	"  emerge --target=skylake -O2 htop"
	.align	3
.LC34:
	.string	"  emerge --opt-level=fast --no-pipe firefox"
	.text
	.align	2
	.p2align 5,,15
	.global	print_known_opt_levels
	.type	print_known_opt_levels, %function
print_known_opt_levels:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	mov	x29, sp
	bl	printf
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	puts
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	puts
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	puts
	adrp	x0, .LC26
	add	x0, x0, :lo12:.LC26
	bl	puts
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	puts
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	puts
	adrp	x0, .LC29
	add	x0, x0, :lo12:.LC29
	bl	puts
	adrp	x0, .LC30
	add	x0, x0, :lo12:.LC30
	bl	puts
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	puts
	adrp	x0, .LC31
	add	x0, x0, :lo12:.LC31
	bl	puts
	adrp	x0, .LC32
	add	x0, x0, :lo12:.LC32
	bl	puts
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	puts
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC34
	add	x0, x0, :lo12:.LC34
	b	puts
	.align	2
	.p2align 5,,15
	.global	set_use_pipe
	.type	set_use_pipe, %function
set_use_pipe:
	cmp	w0, 0
	adrp	x0, .LANCHOR1+176
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR1+176]
	ret
	.align	2
	.p2align 5,,15
	.global	get_use_pipe
	.type	get_use_pipe, %function
get_use_pipe:
	adrp	x0, .LANCHOR1+176
	ldr	w0, [x0, #:lo12:.LANCHOR1+176]
	ret
	.section	.rodata.str1.8
	.align	3
.LC35:
	.string	"-c"
	.align	3
.LC36:
	.string	"sh"
	.align	3
.LC37:
	.string	"/bin/sh"
	.text
	.align	2
	.p2align 5,,15
	.global	run_cmd
	.type	run_cmd, %function
run_cmd:
	stp	x29, x30, [sp, -192]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	bl	fork
	tbnz	w0, #31, .L155
	mov	w19, w0
	cbz	w0, .L165
	.p2align 5,,15
.L156:
	add	x1, sp, 40
	mov	w0, w19
	mov	w2, 0
	bl	waitpid
	tbz	w0, #31, .L166
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L156
.L155:
	ldp	x19, x20, [sp, 16]
	mov	w0, -1
	ldp	x29, x30, [sp], 192
	ret
	.p2align 2,,3
.L166:
	ldr	w0, [sp, 40]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L167
	cbnz	w2, .L155
	ldp	x19, x20, [sp, 16]
	ubfx	x0, x0, 8, 8
	ldp	x29, x30, [sp], 192
	ret
	.p2align 2,,3
.L167:
	ldp	x19, x20, [sp, 16]
	add	w0, w2, 128
	ldp	x29, x30, [sp], 192
	ret
.L165:
	movi	v31.4s, 0
	add	x0, sp, 56
	str	q31, [sp, 40]
	stp	q31, q31, [x0]
	add	x0, sp, 88
	stp	q31, q31, [x0]
	add	x0, sp, 120
	stp	q31, q31, [x0]
	add	x0, sp, 152
	stp	q31, q31, [x0]
	add	x0, sp, 48
	str	xzr, [sp, 184]
	bl	sigemptyset
	add	x1, sp, 40
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	add	x1, sp, 40
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	add	x1, sp, 40
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	mov	x3, x20
	adrp	x2, .LC35
	adrp	x1, .LC36
	add	x2, x2, :lo12:.LC35
	add	x1, x1, :lo12:.LC36
	mov	x4, 0
	adrp	x0, .LC37
	add	x0, x0, :lo12:.LC37
	bl	execl
	mov	w0, 127
	bl	_exit
	.section	.rodata.str1.8
	.align	3
.LC38:
	.string	"/dev/null"
	.text
	.align	2
	.p2align 5,,15
	.global	run_cmd_capture
	.type	run_cmd_capture, %function
run_cmd_capture:
	cbz	x1, .L198
	stp	x29, x30, [sp, -240]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	mov	x26, x1
	str	xzr, [x1]
	cbz	x0, .L169
	mov	x19, x0
	add	x0, sp, 80
	bl	pipe
	cbnz	w0, .L169
	bl	fork
	mov	w25, w0
	tbnz	w0, #31, .L203
	cbz	w0, .L204
	ldr	w0, [sp, 84]
	bl	close
	mov	x0, 4096
	bl	malloc
	mov	x21, x0
	cbz	x0, .L202
	mov	x23, 1024
	mov	x0, 16776192
	add	x24, x23, x0
	mov	x20, 0
	mov	x19, 4096
	.p2align 5,,15
.L175:
	cmp	x23, x19
	bcc	.L176
	lsl	x19, x19, 1
	cmp	x19, x24
	bhi	.L201
.L177:
	mov	x1, x19
	mov	x0, x21
	bl	realloc
	cbz	x0, .L201
	mov	x21, x0
.L176:
	ldr	w0, [sp, 80]
	add	x22, x21, x20
	sub	x2, x19, x20
	mov	x1, x22
	sub	x2, x2, #1
	bl	read
	tbnz	x0, #63, .L205
	cbz	x0, .L180
	add	x20, x20, x0
	add	x23, x20, 1024
	cmp	x23, x19
	bcc	.L176
	lsl	x19, x19, 1
	cmp	x19, x24
	bls	.L177
.L201:
	mov	x0, x21
	bl	free
.L202:
	ldr	w0, [sp, 80]
	bl	close
	mov	w0, w25
	mov	w2, 0
	mov	x1, 0
	bl	waitpid
.L169:
	mov	w0, -1
.L168:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 240
	ret
	.p2align 2,,3
.L204:
	movi	v31.4s, 0
	add	x0, sp, 104
	str	q31, [sp, 88]
	stp	q31, q31, [x0]
	add	x0, sp, 136
	stp	q31, q31, [x0]
	add	x0, sp, 168
	stp	q31, q31, [x0]
	add	x0, sp, 200
	stp	q31, q31, [x0]
	add	x0, sp, 96
	str	xzr, [sp, 232]
	bl	sigemptyset
	add	x1, sp, 88
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	add	x1, sp, 88
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	add	x1, sp, 88
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	ldr	w0, [sp, 80]
	bl	close
	ldr	w0, [sp, 84]
	mov	w1, 1
	bl	dup2
	tbnz	w0, #31, .L206
	ldr	w0, [sp, 84]
	bl	close
	mov	w1, 1
	adrp	x0, .LC38
	add	x0, x0, :lo12:.LC38
	bl	open
	mov	w20, w0
	tbz	w0, #31, .L207
.L174:
	mov	x3, x19
	adrp	x2, .LC35
	adrp	x1, .LC36
	add	x2, x2, :lo12:.LC35
	add	x1, x1, :lo12:.LC36
	mov	x4, 0
	adrp	x0, .LC37
	add	x0, x0, :lo12:.LC37
	bl	execl
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L205:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L175
	b	.L201
	.p2align 2,,3
.L198:
	mov	w0, -1
	ret
	.p2align 2,,3
.L207:
	mov	w1, 2
	bl	dup2
	mov	w0, w20
	bl	close
	b	.L174
	.p2align 2,,3
.L206:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L180:
	ldr	w0, [sp, 80]
	bl	close
	strb	wzr, [x22]
	b	.L181
	.p2align 2,,3
.L182:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L208
.L181:
	add	x1, sp, 88
	mov	w0, w25
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L182
	ldr	w0, [sp, 88]
	str	x21, [x26]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L209
	cbnz	w2, .L169
	ubfx	x0, x0, 8, 8
	b	.L168
.L208:
	mov	x0, x21
	bl	free
	b	.L169
.L209:
	add	w0, w2, 128
	b	.L168
.L203:
	ldr	w0, [sp, 80]
	bl	close
	ldr	w0, [sp, 84]
	bl	close
	b	.L169
	.align	2
	.p2align 5,,15
	.global	shell_quote
	.type	shell_quote, %function
shell_quote:
	cmp	x1, 0
	ccmp	x2, 2, 0, ne
	ccmp	x0, 0, 4, hi
	bne	.L211
.L215:
	mov	w0, 0
	ret
	.p2align 2,,3
.L211:
	mov	w3, 39
	strb	w3, [x1]
	mov	x3, 1
	ldrb	w4, [x0]
	cbz	w4, .L218
	mov	w6, 92
	b	.L217
	.p2align 2,,3
.L214:
	add	x5, x3, 1
	cmp	x5, x2
	bcs	.L215
	strb	w4, [x1, x3]
	mov	x3, x5
	ldrb	w4, [x0, 1]!
	cbz	w4, .L220
.L217:
	cmp	w4, 39
	bne	.L214
	add	x5, x3, 4
	cmp	x5, x2
	bcs	.L215
	strb	w4, [x1, x3]
	add	x3, x1, x3
	strb	w6, [x3, 1]
	strb	w4, [x3, 2]
	strb	w4, [x3, 3]
	mov	x3, x5
	ldrb	w4, [x0, 1]!
	cbnz	w4, .L217
.L220:
	add	x0, x3, 1
	cmp	x0, x2
	bcs	.L215
.L213:
	mov	w2, 39
	strb	w2, [x1, x3]
	strb	wzr, [x1, x0]
	mov	w0, 1
	ret
.L218:
	mov	x0, 2
	b	.L213
	.section	.rodata.str1.8
	.align	3
.LC39:
	.string	" @._+-/"
	.text
	.align	2
	.p2align 5,,15
	.global	valid_search_query
	.type	valid_search_query, %function
valid_search_query:
	cbz	x0, .L238
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L224
	str	w1, [sp, 60]
	bl	strlen
	cmp	x0, 128
	bhi	.L224
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x20, [x0]
	adrp	x21, .LC39
	ldr	w1, [sp, 60]
	add	x21, x21, :lo12:.LC39
	.p2align 5,,15
.L226:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x20, x0]
	tbnz	x0, 3, .L225
	mov	x0, x21
	bl	strchr
	cbz	x0, .L237
.L225:
	ldrb	w1, [x19, 1]!
	cbnz	w1, .L226
	ldr	x21, [sp, 32]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L237:
	ldr	x21, [sp, 32]
.L224:
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L238:
	mov	w0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	dep_basename
	.type	dep_basename, %function
dep_basename:
	cmp	x1, 0
	ccmp	x2, 0, 4, ne
	beq	.L239
	cbz	x0, .L241
	ldrb	w3, [x0]
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	bne	.L243
	.p2align 5,,15
.L242:
	ldrb	w3, [x0, 1]!
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	beq	.L242
.L243:
	mov	x8, 512
	mov	x5, x1
	movk	x8, 0x1, lsl 32
	mov	x6, x1
	mov	x4, 0
	movk	x8, 0x7400, lsl 48
	cbnz	w3, .L248
	b	.L245
	.p2align 2,,3
.L249:
	cmp	w3, 62
	bhi	.L246
	lsr	x7, x8, x3
	tbnz	x7, 0, .L245
.L246:
	strb	w3, [x5], 1
	ldrb	w3, [x0, x4]
	cbz	w3, .L254
.L248:
	add	x4, x4, 1
	mov	x6, x5
	cmp	x4, x2
	bcc	.L249
.L245:
	strb	wzr, [x6]
.L239:
	ret
	.p2align 2,,3
.L254:
	add	x6, x1, x4
	strb	wzr, [x6]
	b	.L239
	.p2align 2,,3
.L241:
	strb	wzr, [x1]
	ret
	.section	.rodata.str1.8
	.align	3
.LC40:
	.string	"\033[1;31m[-] Internal error: formatted output needs %d bytes but only %zu are available; aborting rather than running a truncated command or path.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	xsnprintf
	.type	xsnprintf, %function
xsnprintf:
	stp	x29, x30, [sp, -272]!
	mov	x29, sp
	stp	x3, x4, [sp, 232]
	add	x3, sp, 272
	stp	x3, x3, [sp, 64]
	add	x3, sp, 224
	ldr	q31, [sp, 64]
	str	x3, [sp, 80]
	mov	w3, -40
	str	w3, [sp, 88]
	mov	w3, -128
	str	w3, [sp, 92]
	str	q31, [sp, 32]
	add	x3, sp, 32
	ldr	q31, [sp, 80]
	str	x19, [sp, 16]
	mov	x19, x1
	stp	q0, q1, [sp, 96]
	str	q31, [sp, 48]
	stp	q2, q3, [sp, 128]
	stp	q4, q5, [sp, 160]
	stp	q6, q7, [sp, 192]
	stp	x5, x6, [sp, 248]
	str	x7, [sp, 264]
	bl	vsnprintf
	sxtw	x1, w0
	cmp	w0, 0
	ccmp	x1, x19, 2, ge
	bcs	.L258
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 272
	ret
.L258:
	mov	w2, w0
	mov	x3, x19
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC40
	add	x1, x1, :lo12:.LC40
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 1
	bl	exit
	.section	.rodata.str1.8
	.align	3
.LC41:
	.string	"%s"
	.text
	.align	2
	.p2align 5,,15
	.global	set_target_arch
	.type	set_target_arch, %function
set_target_arch:
	cbz	x0, .L274
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_target_arch
	cbz	w0, .L259
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L259
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbnz	w0, .L277
.L259:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L274:
	ret
	.p2align 2,,3
.L277:
	mov	x3, x19
	adrp	x0, .LANCHOR1
	ldr	x19, [sp, 16]
	add	x0, x0, :lo12:.LANCHOR1
	ldp	x29, x30, [sp], 32
	add	x0, x0, 32
	adrp	x2, .LC41
	mov	x1, 128
	add	x2, x2, :lo12:.LC41
	b	xsnprintf
	.align	2
	.p2align 5,,15
	.global	set_opt_level
	.type	set_opt_level, %function
set_opt_level:
	cbz	x0, .L331
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_opt_level
	cbz	w0, .L278
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L278
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L278
	ldrb	w0, [x19]
	cmp	w0, 45
	beq	.L334
.L280:
	and	w0, w0, -33
	and	w0, w0, 255
	cmp	w0, 79
	cinc	x19, x19, eq
	ldrb	w0, [x19]
	cmp	w0, 48
	beq	.L335
.L290:
	cmp	w0, 49
	bne	.L291
	ldrb	w1, [x19, 1]
	cbnz	w1, .L291
.L283:
	mov	x3, x19
	adrp	x0, .LANCHOR1
	ldr	x19, [sp, 16]
	add	x0, x0, :lo12:.LANCHOR1
	ldp	x29, x30, [sp], 32
	add	x0, x0, 160
	adrp	x2, .LC41
	mov	x1, 16
	add	x2, x2, :lo12:.LC41
	b	xsnprintf
	.p2align 2,,3
.L291:
	cmp	w0, 50
	bne	.L292
	ldrb	w1, [x19, 1]
	cbz	w1, .L283
	.p2align 5,,15
.L292:
	cmp	w0, 51
	bne	.L293
	ldrb	w1, [x19, 1]
	cbz	w1, .L283
	.p2align 5,,15
.L293:
	cmp	w0, 115
	bne	.L294
	ldrb	w1, [x19, 1]
	cbz	w1, .L283
.L294:
	cmp	w0, 103
	bne	.L295
	ldrb	w1, [x19, 1]
	cbz	w1, .L283
.L295:
	cmp	w0, 122
	bne	.L296
	ldrb	w0, [x19, 1]
	cbz	w0, .L283
.L296:
	adrp	x1, .LC21
	mov	x0, x19
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L283
.L278:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L335:
	ldrb	w1, [x19, 1]
	cbz	w1, .L283
	b	.L290
	.p2align 2,,3
.L334:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
	b	.L280
	.p2align 2,,3
.L331:
	ret
	.section	.rodata.str1.8
	.align	3
.LC42:
	.string	""
	.text
	.align	2
	.p2align 5,,15
	.global	set_raw_flags
	.type	set_raw_flags, %function
set_raw_flags:
	mov	x3, x0
	cbz	x0, .L339
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x0, x0, 32
	adrp	x2, .LC41
	mov	x1, 193
	add	x2, x2, :lo12:.LC41
	b	xsnprintf
	.p2align 2,,3
.L339:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x0, x0, 32
	adrp	x3, .LC42
	adrp	x2, .LC41
	add	x3, x3, :lo12:.LC42
	add	x2, x2, :lo12:.LC41
	mov	x1, 193
	b	xsnprintf
	.section	.rodata.str1.8
	.align	3
.LC43:
	.string	" -pipe"
	.align	3
.LC44:
	.string	"-march=%s -O%s%s %s"
	.align	3
.LC45:
	.string	"-march=%s -O%s%s"
	.text
	.align	2
	.p2align 5,,15
	.global	render_build_flags
	.type	render_build_flags, %function
render_build_flags:
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	adrp	x19, .LANCHOR1
	adrp	x20, .LC41
	stp	x21, x22, [sp, 32]
	add	x21, x19, :lo12:.LANCHOR1
	mov	x22, x0
	add	x3, x21, 160
	add	x2, x20, :lo12:.LC41
	add	x0, sp, 64
	str	x23, [sp, 48]
	mov	x23, x1
	mov	x1, 16
	bl	xsnprintf
	ldr	w0, [x21, 176]
	cbz	w0, .L344
	adrp	x3, .LC43
	add	x3, x3, :lo12:.LC43
.L341:
	add	x2, x20, :lo12:.LC41
	add	x0, sp, 80
	mov	x1, 16
	bl	xsnprintf
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x6, x0, 32
	add	x3, x19, :lo12:.LANCHOR1
	add	x5, sp, 80
	add	x4, sp, 64
	ldrb	w0, [x0, 32]
	add	x3, x3, 32
	cbz	w0, .L342
	mov	x1, x23
	mov	x0, x22
	adrp	x2, .LC44
	add	x2, x2, :lo12:.LC44
	bl	xsnprintf
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L344:
	adrp	x3, .LC42
	add	x3, x3, :lo12:.LC42
	b	.L341
	.p2align 2,,3
.L342:
	mov	x1, x23
	mov	x0, x22
	adrp	x2, .LC45
	add	x2, x2, :lo12:.LC45
	bl	xsnprintf
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.section	.rodata.str1.8
	.align	3
.LC46:
	.string	"%s >/dev/null 2>&1"
	.text
	.align	2
	.p2align 5,,15
	.global	run_cmd_quiet
	.type	run_cmd_quiet, %function
run_cmd_quiet:
	mov	x12, 4624
	sub	sp, sp, x12
	mov	x3, x0
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4608
	stp	x29, x30, [sp]
	add	x0, sp, 16
	mov	x29, sp
	bl	xsnprintf
	add	x0, sp, 16
	bl	run_cmd
	ldp	x29, x30, [sp]
	mov	x12, 4624
	add	sp, sp, x12
	ret
	.align	2
	.p2align 5,,15
	.global	fopen_nofollow
	.type	fopen_nofollow, %function
fopen_nofollow:
	stp	x29, x30, [sp, -32]!
	mov	x3, x1
	mov	x29, sp
	ldrb	w1, [x1]
	cmp	w1, 114
	beq	.L353
	cmp	w1, 119
	beq	.L354
	cmp	w1, 97
	beq	.L355
	bl	__errno_location
	mov	w1, 22
	str	w1, [x0]
.L351:
	mov	x1, 0
.L348:
	mov	x0, x1
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L354:
	mov	w1, 33345
.L349:
	mov	w2, 420
	str	x3, [sp, 24]
	bl	open
	tbnz	w0, #31, .L351
	ldr	x1, [sp, 24]
	str	w0, [sp, 24]
	bl	fdopen
	mov	x1, x0
	cbnz	x0, .L348
	ldr	w0, [sp, 24]
	str	x1, [sp, 24]
	bl	close
	ldr	x1, [sp, 24]
	b	.L348
	.p2align 2,,3
.L355:
	mov	w1, 33857
	b	.L349
	.p2align 2,,3
.L353:
	mov	w1, 32768
	b	.L349
	.align	2
	.p2align 5,,15
	.global	file_exists
	.type	file_exists, %function
file_exists:
	stp	x29, x30, [sp, -144]!
	mov	x29, sp
	add	x1, sp, 16
	bl	stat
	cbnz	w0, .L359
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 32768
	cset	w0, eq
	ret
	.p2align 2,,3
.L359:
	mov	w0, 0
	ldp	x29, x30, [sp], 144
	ret
	.align	2
	.p2align 5,,15
	.global	dir_exists
	.type	dir_exists, %function
dir_exists:
	stp	x29, x30, [sp, -144]!
	mov	x29, sp
	add	x1, sp, 16
	bl	stat
	cbnz	w0, .L363
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 16384
	cset	w0, eq
	ret
	.p2align 2,,3
.L363:
	mov	w0, 0
	ldp	x29, x30, [sp], 144
	ret
	.section	.rodata.str1.8
	.align	3
.LC47:
	.string	"@._+-"
	.text
	.align	2
	.p2align 5,,15
	.global	valid_pkgname
	.type	valid_pkgname, %function
valid_pkgname:
	cbz	x0, .L382
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L368
	sub	w2, w1, #45
	and	w2, w2, 255
	cmp	w2, 1
	bls	.L368
	str	w1, [sp, 60]
	bl	strlen
	cmp	x0, 128
	bhi	.L368
	stp	x21, x22, [sp, 32]
	bl	__ctype_b_loc
	adrp	x22, .LC47
	ldr	x21, [x0]
	add	x22, x22, :lo12:.LC47
	ldr	w1, [sp, 60]
	mov	w20, 2560
	b	.L370
	.p2align 2,,3
.L369:
	ldrb	w1, [x19, 1]!
	cbz	w1, .L383
.L370:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x21, x0]
	tst	w20, w0
	bne	.L369
	mov	x0, x22
	bl	strchr
	cbnz	x0, .L369
	ldp	x21, x22, [sp, 32]
.L368:
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L383:
	ldp	x21, x22, [sp, 32]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L382:
	mov	w0, 0
	ret
	.section	.rodata.str1.8
	.align	3
.LC48:
	.string	".^$*+?()[]{}|/\\"
	.text
	.align	2
	.p2align 5,,15
	.global	regex_escape
	.type	regex_escape, %function
regex_escape:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, x2
	stp	x23, x24, [sp, 48]
	mov	x24, x1
	ldrb	w1, [x0]
	cbz	w1, .L391
	adrp	x21, .LC48
	mov	x20, x0
	add	x21, x21, :lo12:.LC48
	mov	x19, 0
	mov	w23, 92
	b	.L390
	.p2align 2,,3
.L395:
	add	x0, x19, 2
	cmp	x0, x22
	bcs	.L387
	add	x2, x19, 1
	strb	w23, [x24, x19]
	mov	x19, x0
	ldrb	w0, [x20]
	strb	w0, [x24, x2]
	ldrb	w1, [x20, 1]!
	cbz	w1, .L385
.L390:
	mov	x0, x21
	bl	strchr
	cbnz	x0, .L395
	add	x0, x19, 1
	cmp	x0, x22
	bcs	.L387
	mov	x2, x19
	mov	x19, x0
	ldrb	w0, [x20]
	strb	w0, [x24, x2]
	ldrb	w1, [x20, 1]!
	cbnz	w1, .L390
.L385:
	cmp	x22, x19
	bls	.L387
	strb	wzr, [x24, x19]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L387:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
.L391:
	mov	x19, 0
	b	.L385
	.section	.rodata.str1.8
	.align	3
.LC49:
	.string	"SUDO_USER"
	.text
	.align	2
	.p2align 5,,15
	.global	build_user
	.type	build_user, %function
build_user:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	mov	x29, sp
	bl	getenv
	cbz	x0, .L397
	ldrb	w1, [x0]
	cbnz	w1, .L396
.L397:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L396
	ldr	x0, [x0]
.L396:
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata.str1.8
	.align	3
.LC50:
	.string	"\033[1;31m[-] Configuration error: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	load_user_config
	.type	load_user_config, %function
load_user_config:
	sub	sp, sp, #1488
	mov	x2, 512
	add	x1, sp, 16
	add	x0, sp, 528
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	config_load
	cbz	w0, .L410
	add	x0, sp, 528
	bl	config_apply
	ldp	x29, x30, [sp]
	add	sp, sp, 1488
	ret
	.p2align 2,,3
.L410:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 16
	adrp	x1, .LC50
	add	x1, x1, :lo12:.LC50
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	add	sp, sp, 1488
	ret
	.section	.rodata.str1.8
	.align	3
.LC51:
	.string	"sudo "
	.text
	.align	2
	.p2align 5,,15
	.global	priv_prefix
	.type	priv_prefix, %function
priv_prefix:
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	bl	geteuid
	cbnz	w0, .L413
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC42
	add	x0, x0, :lo12:.LC42
	ret
	.p2align 2,,3
.L413:
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	ret
	.section	.rodata.str1.8
	.align	3
.LC52:
	.string	"command -v '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	have_cmd
	.type	have_cmd, %function
have_cmd:
	mov	x12, 5136
	sub	sp, sp, x12
	mov	x3, x0
	mov	x1, 512
	add	x0, sp, 16
	adrp	x2, .LC52
	stp	x29, x30, [sp]
	add	x2, x2, :lo12:.LC52
	mov	x29, sp
	bl	xsnprintf
	add	x3, sp, 16
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4608
	add	x0, sp, 528
	bl	xsnprintf
	add	x0, sp, 528
	bl	run_cmd
	cmp	w0, 0
	ldp	x29, x30, [sp]
	cset	w0, eq
	mov	x12, 5136
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC53:
	.string	"sudo"
	.align	3
.LC54:
	.string	"\033[1;31m[-] sudo is required.\n\033[0m"
	.align	3
.LC55:
	.string	"sudo -k"
	.align	3
.LC56:
	.string	"\033[1;31m[-] Could not invalidate sudo credentials.\n\033[0m"
	.align	3
.LC57:
	.string	"\033[1;31m[-] Out of memory.\n\033[0m"
	.align	3
.LC59:
	.string	"\033[1;31m[-] Could not execute sudo: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	acquire_sudo
	.type	acquire_sudo, %function
acquire_sudo:
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	w20, 1
	stp	x21, x22, [sp, 32]
	mov	w21, w0
	mov	x22, x1
	bl	geteuid
	cbnz	w0, .L426
.L417:
	ldp	x21, x22, [sp, 32]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L426:
	adrp	x0, .LC53
	add	x19, x0, :lo12:.LC53
	mov	x0, x19
	bl	have_cmd
	mov	w20, w0
	cbz	w0, .L427
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	run_cmd
	mov	w20, w0
	cbnz	w0, .L428
	sxtw	x0, w21
	mov	x1, 8
	str	x23, [sp, 48]
	mov	x23, x0
	add	x0, x0, 3
	bl	calloc
	mov	x3, x0
	cbz	x0, .L429
	ldrb	w0, [x19, 4]
	add	x1, sp, 88
	strb	w0, [sp, 92]
	adrp	x0, .LC58
	add	x0, x0, :lo12:.LC58
	ldr	w2, [x19]
	str	w2, [sp, 88]
	add	x2, sp, 80
	ldrh	w5, [x0]
	ldrb	w0, [x0, 2]
	strh	w5, [sp, 80]
	strb	w0, [sp, 82]
	mov	w0, w21
	stp	x1, x2, [x3]
	cmp	w21, 0
	ble	.L423
	ubfiz	x2, x0, 3, 32
	mov	x1, x22
	add	x0, x3, 16
	str	x3, [sp, 72]
	bl	memcpy
	ldr	x3, [sp, 72]
.L423:
	add	x0, x23, 2
	mov	x1, x3
	str	x3, [sp, 72]
	str	xzr, [x3, x0, lsl 3]
	adrp	x0, .LC53
	add	x0, x0, :lo12:.LC53
	bl	execvp
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x19, [x0]
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x2, x0
	adrp	x1, .LC59
	mov	x0, x19
	add	x1, x1, :lo12:.LC59
	bl	fprintf
	ldr	x0, [sp, 72]
	bl	free
	ldr	x23, [sp, 48]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L427:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 33
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	fwrite
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L428:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 54
	mov	x1, 1
	mov	w20, 0
	ldr	x3, [x0]
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	bl	fwrite
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
.L429:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 30
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC57
	add	x0, x0, :lo12:.LC57
	bl	fwrite
	ldr	x23, [sp, 48]
	b	.L417
	.section	.rodata.str1.8
	.align	3
.LC58:
	.string	"--"
	.text
	.section	.rodata.str1.8
	.align	3
.LC60:
	.string	"chown '%s' '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	fix_owner
	.type	fix_owner, %function
fix_owner:
	mov	x12, 5664
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	geteuid
	cbz	w0, .L444
.L430:
	ldr	x19, [sp, 16]
	mov	x12, 5664
	ldp	x29, x30, [sp]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L444:
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	bl	getenv
	mov	x3, x0
	cbz	x0, .L432
	ldrb	w0, [x0]
	cbnz	w0, .L433
.L432:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L430
	ldr	x3, [x0]
	cbz	x3, .L430
.L433:
	mov	x4, x19
	add	x0, sp, 32
	mov	x1, 1024
	adrp	x2, .LC60
	add	x2, x2, :lo12:.LC60
	bl	xsnprintf
	add	x3, sp, 32
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4608
	add	x0, sp, 1056
	bl	xsnprintf
	add	x0, sp, 1056
	bl	run_cmd
	ldr	x19, [sp, 16]
	mov	x12, 5664
	ldp	x29, x30, [sp]
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC61:
	.string	"%s%s"
	.align	3
.LC62:
	.string	"\033[1;31m[-] Running as root with no SUDO_USER; cannot find an unprivileged user to build as.\n\033[0m"
	.align	3
.LC63:
	.string	"/dev/urandom"
	.align	3
.LC64:
	.string	"/usr/local/emerge"
	.align	3
.LC65:
	.string	"%s/.archtoo-step-%ld-%08lx.sh"
	.align	3
.LC66:
	.string	"\033[1;31m[-] Cannot create step script in %s: %s\n\033[0m"
	.align	3
.LC67:
	.string	"w"
	.align	3
.LC68:
	.string	"\033[1;31m[-] fdopen failed for %s\n\033[0m"
	.align	3
.LC69:
	.string	"#!/bin/sh\ntrap 'exit 130' INT\ntrap 'exit 143' TERM\ntrap 'exit 129' HUP\n%s%s\n"
	.align	3
.LC70:
	.string	"\033[1;31m[-] Cannot finish writing %s\n\033[0m"
	.align	3
.LC71:
	.string	"sudo -u '%s' -- /bin/sh '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	run_as_user
	.type	run_as_user, %function
run_as_user:
	mov	x12, 4800
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	stp	x27, x28, [sp, 80]
	mov	x28, x0
	bl	geteuid
	cbz	w0, .L446
	cbz	x21, .L447
	ldrb	w0, [x21]
	cbnz	w0, .L448
.L447:
	ldp	x29, x30, [sp]
	mov	x0, x28
	ldp	x19, x20, [sp, 16]
	mov	x12, 4800
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, x12
	b	run_cmd
	.p2align 2,,3
.L446:
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	stp	x25, x26, [sp, 64]
	bl	getenv
	mov	x26, x0
	cbz	x0, .L450
	ldrb	w0, [x0]
	cbnz	w0, .L451
.L450:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L452
	ldr	x26, [x0]
	cbz	x26, .L452
.L451:
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC63
	add	x23, x23, :lo12:.LC63
	mov	w22, 16
	adrp	x24, .LC64
	adrp	x25, .LC65
	.p2align 5,,15
.L453:
	bl	getpid
	sxtw	x20, w0
	mov	w1, 524288
	mov	x0, x23
	bl	open
	mov	w19, w0
	tbnz	w0, #31, .L455
	add	x1, sp, 96
	mov	x2, 4
	bl	read
	mov	x27, x0
	mov	w0, w19
	bl	close
	cmp	x27, 4
	beq	.L477
.L455:
	add	x1, sp, 704
	mov	w0, 0
	bl	clock_gettime
	ldr	x19, [sp, 712]
	bl	getpid
	sbfiz	x27, x0, 16, 32
	bl	clock
	eor	x5, x19, x0
	eor	x5, x5, x27
	and	x5, x5, 4294967295
.L456:
	mov	x4, x20
	add	x3, x24, :lo12:.LC64
	add	x2, x25, :lo12:.LC65
	mov	x1, 600
	add	x0, sp, 104
	bl	xsnprintf
	add	x0, sp, 104
	mov	w2, 448
	mov	w1, 32961
	bl	open
	mov	w19, w0
	tbnz	w0, #31, .L478
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	fdopen
	mov	x20, x0
	cbz	x0, .L479
	cbz	x21, .L480
.L460:
	mov	x3, x28
	mov	x2, x21
	adrp	x1, .LC69
	add	x1, x1, :lo12:.LC69
	mov	x0, x20
	bl	fprintf
	mov	x0, x20
	bl	fclose
	cbnz	w0, .L481
	mov	w1, 493
	add	x0, sp, 104
	bl	chmod
	add	x0, sp, 104
	bl	fix_owner
	mov	x3, x26
	add	x4, sp, 104
	adrp	x2, .LC71
	add	x2, x2, :lo12:.LC71
	mov	x1, 1024
	add	x0, sp, 704
	bl	xsnprintf
	add	x0, sp, 704
	bl	run_cmd
	mov	w19, w0
	add	x0, sp, 104
	bl	unlink
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
.L445:
	mov	w0, w19
	ldp	x29, x30, [sp]
	mov	x12, 4800
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L478:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	bne	.L458
	subs	w22, w22, #1
	bne	.L453
.L458:
	adrp	x1, :got:stderr
	ldr	x1, [x1, :got_lo12:stderr]
	ldr	x19, [x1]
	bl	strerror
	add	x2, x24, :lo12:.LC64
	mov	x3, x0
	adrp	x1, .LC66
	mov	x0, x19
	add	x1, x1, :lo12:.LC66
	bl	fprintf
	ldp	x23, x24, [sp, 48]
.L454:
	mov	w19, -1
	ldp	x25, x26, [sp, 64]
	b	.L445
	.p2align 2,,3
.L477:
	ldr	w5, [sp, 96]
	rev	w5, w5
	b	.L456
	.p2align 2,,3
.L448:
	mov	x4, x28
	mov	x3, x21
	adrp	x2, .LC61
	add	x2, x2, :lo12:.LC61
	mov	x1, 4096
	add	x0, sp, 704
	bl	xsnprintf
	add	x0, sp, 704
	bl	run_cmd
	mov	w19, w0
	mov	x12, 4800
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L480:
	adrp	x21, .LC42
	add	x21, x21, :lo12:.LC42
	b	.L460
.L481:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 104
	adrp	x1, .LC70
	add	x1, x1, :lo12:.LC70
	ldr	x0, [x0]
	bl	fprintf
	add	x0, sp, 104
	bl	unlink
	ldp	x23, x24, [sp, 48]
	b	.L454
.L452:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 96
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC62
	add	x0, x0, :lo12:.LC62
	bl	fwrite
	b	.L454
.L479:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 104
	adrp	x1, .LC68
	add	x1, x1, :lo12:.LC68
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, w19
	bl	close
	add	x0, sp, 104
	bl	unlink
	ldp	x23, x24, [sp, 48]
	b	.L454
	.section	.rodata.str1.8
	.align	3
.LC72:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC73:
	.string	"/usr/local/emerge/backups"
	.align	3
.LC74:
	.string	"%smkdir -p '%s' '%s'"
	.align	3
.LC75:
	.string	"\033[1;31m[-] Could not create %s\n\033[0m"
	.align	3
.LC76:
	.string	"._-"
	.align	3
.LC77:
	.string	"%schown -R '%s' '%s'"
	.align	3
.LC78:
	.string	"/usr/local/emerge/world"
	.align	3
.LC79:
	.string	"a"
	.align	3
.LC80:
	.string	"\033[1;31m[-] Cannot write world file %s\n\033[0m"
	.align	3
.LC81:
	.string	"\033[1;31m[-] World file %s is not writable.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	init_system
	.type	init_system, %function
init_system:
	mov	x12, 5696
	sub	sp, sp, x12
	add	x1, sp, 1088
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	adrp	x19, .LC72
	adrp	x20, .LC73
	add	x0, x19, :lo12:.LC72
	bl	stat
	cbnz	w0, .L486
	ldr	w0, [sp, 1104]
	adrp	x20, .LC73
	and	w0, w0, 61440
	cmp	w0, 16384
	beq	.L555
.L486:
	bl	geteuid
	cbz	w0, .L556
.L514:
	adrp	x3, .LC51
	add	x3, x3, :lo12:.LC51
.L489:
	add	x5, x20, :lo12:.LC73
	add	x4, x19, :lo12:.LC72
	adrp	x2, .LC74
	add	x2, x2, :lo12:.LC74
	mov	x1, 1024
	add	x0, sp, 64
	bl	xsnprintf
	add	x0, sp, 64
	bl	run_cmd
	cbnz	w0, .L557
.L488:
	bl	geteuid
	cbz	w0, .L494
	adrp	x0, .LC64
	mov	w1, 2
	add	x0, x0, :lo12:.LC64
	bl	access
	cbz	w0, .L495
.L494:
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	bl	getenv
	mov	x19, x0
	cbz	x0, .L493
	ldrb	w20, [x0]
	cbnz	w20, .L496
.L493:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L495
	ldr	x19, [x0]
	cbnz	x19, .L558
.L495:
	adrp	x19, .LC78
	add	x1, sp, 1088
	add	x0, x19, :lo12:.LC78
	bl	stat
	cbnz	w0, .L503
	ldr	w0, [sp, 1104]
	and	w0, w0, 61440
	cmp	w0, 32768
	beq	.L507
.L503:
	adrp	x1, .LC79
	add	x0, x19, :lo12:.LC78
	add	x1, x1, :lo12:.LC79
	bl	fopen_nofollow
	cbz	x0, .L559
	bl	fclose
.L507:
	bl	geteuid
	cbz	w0, .L560
.L509:
	mov	w1, 2
	add	x0, x19, :lo12:.LC78
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L561
.L482:
	ldp	x29, x30, [sp]
	mov	x12, 5696
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L555:
	add	x1, sp, 1088
	add	x0, x20, :lo12:.LC73
	bl	stat
	cbnz	w0, .L486
	ldr	w0, [sp, 1104]
	and	w0, w0, 61440
	cmp	w0, 16384
	beq	.L488
	bl	geteuid
	cbnz	w0, .L514
.L556:
	adrp	x3, .LC42
	add	x3, x3, :lo12:.LC42
	b	.L489
	.p2align 2,,3
.L560:
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	bl	getenv
	mov	x3, x0
	cbz	x0, .L510
	ldrb	w0, [x0]
	cbnz	w0, .L511
.L510:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L509
	ldr	x3, [x0]
	cbz	x3, .L509
.L511:
	add	x4, x19, :lo12:.LC78
	mov	x1, 1024
	add	x0, sp, 64
	adrp	x2, .LC60
	add	x2, x2, :lo12:.LC60
	bl	xsnprintf
	add	x3, sp, 64
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4608
	add	x0, sp, 1088
	bl	xsnprintf
	add	x0, sp, 1088
	bl	run_cmd
	mov	w1, 2
	add	x0, x19, :lo12:.LC78
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbz	w1, .L482
	.p2align 5,,15
.L561:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, x19, :lo12:.LC78
	adrp	x1, .LC81
	add	x1, x1, :lo12:.LC81
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
.L562:
	ldp	x29, x30, [sp]
	mov	x12, 5696
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L496:
	bl	valid_pkgname
	cbnz	w0, .L498
	mov	w1, w20
	stp	x21, x22, [sp, 32]
.L512:
	adrp	x22, .LC76
	str	w1, [sp, 60]
	bl	__ctype_b_loc
	ldr	x21, [x0]
	mov	x20, x19
	ldr	w1, [sp, 60]
	add	x22, x22, :lo12:.LC76
	.p2align 5,,15
.L501:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x21, x0]
	tbnz	x0, 3, .L500
	mov	x0, x22
	bl	strchr
	cbz	x0, .L554
.L500:
	ldrb	w1, [x20, 1]!
	cbnz	w1, .L501
	ldp	x21, x22, [sp, 32]
.L498:
	bl	geteuid
	cbnz	w0, .L515
	adrp	x3, .LC42
	add	x3, x3, :lo12:.LC42
.L502:
	mov	x4, x19
	add	x0, sp, 64
	mov	x1, 1024
	adrp	x5, .LC64
	adrp	x2, .LC77
	add	x5, x5, :lo12:.LC64
	add	x2, x2, :lo12:.LC77
	bl	xsnprintf
	add	x3, sp, 64
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4608
	add	x0, sp, 1088
	bl	xsnprintf
	add	x0, sp, 1088
	bl	run_cmd
	b	.L495
	.p2align 2,,3
.L558:
	mov	x0, x19
	bl	valid_pkgname
	cbnz	w0, .L498
	ldrb	w1, [x19]
	cbz	w1, .L498
	stp	x21, x22, [sp, 32]
	b	.L512
	.p2align 2,,3
.L557:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x2, .LC64
	adrp	x1, .LC75
	add	x2, x2, :lo12:.LC64
	add	x1, x1, :lo12:.LC75
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L562
	.p2align 2,,3
.L515:
	adrp	x3, .LC51
	add	x3, x3, :lo12:.LC51
	b	.L502
	.p2align 2,,3
.L554:
	ldp	x21, x22, [sp, 32]
	b	.L495
.L559:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, x19, :lo12:.LC78
	adrp	x1, .LC80
	add	x1, x1, :lo12:.LC80
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L562
	.section	.rodata.str1.8
	.align	3
.LC82:
	.string	"nano"
	.align	3
.LC83:
	.string	"EDITOR"
	.text
	.align	2
	.p2align 5,,15
	.global	get_editor
	.type	get_editor, %function
get_editor:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC83
	add	x0, x0, :lo12:.LC83
	mov	x29, sp
	bl	getenv
	cbz	x0, .L565
	ldrb	w1, [x0]
	cbz	w1, .L565
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L565:
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC82
	add	x0, x0, :lo12:.LC82
	ret
	.align	2
	.p2align 5,,15
	.global	get_cpu_cores
	.type	get_cpu_cores, %function
get_cpu_cores:
	stp	x29, x30, [sp, -16]!
	mov	w0, 84
	mov	x29, sp
	bl	sysconf
	cmp	x0, 0
	csinc	x0, x0, xzr, gt
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata.str1.8
	.align	3
.LC84:
	.string	"-j%ld"
	.align	3
.LC85:
	.string	"KCFLAGS"
	.align	3
.LC86:
	.string	"KCPPFLAGS"
	.align	3
.LC87:
	.string	"MAKEFLAGS"
	.text
	.align	2
	.p2align 5,,15
	.global	set_build_env
	.type	set_build_env, %function
set_build_env:
	stp	x29, x30, [sp, -368]!
	adrp	x0, .LANCHOR0+16
	mov	x29, sp
	ldr	x3, [x0, #:lo12:.LANCHOR0+16]
	str	x19, [sp, 16]
	cmp	x3, 0
	ble	.L574
.L570:
	add	x0, sp, 48
	adrp	x2, .LC84
	mov	x1, 64
	add	x2, x2, :lo12:.LC84
	bl	xsnprintf
	adrp	x19, .LANCHOR1
	add	x0, x19, :lo12:.LANCHOR1
	ldr	w0, [x0, 176]
	cbz	w0, .L572
	adrp	x3, .LC43
	add	x3, x3, :lo12:.LC43
.L571:
	add	x0, sp, 32
	mov	x1, 16
	adrp	x2, .LC41
	add	x2, x2, :lo12:.LC41
	bl	xsnprintf
	add	x3, x19, :lo12:.LANCHOR1
	add	x5, sp, 32
	add	x4, x3, 160
	add	x3, x3, 32
	add	x0, sp, 112
	mov	x1, 256
	adrp	x2, .LC45
	add	x2, x2, :lo12:.LC45
	bl	xsnprintf
	add	x1, sp, 112
	mov	w2, 1
	adrp	x0, .LC85
	add	x0, x0, :lo12:.LC85
	bl	setenv
	add	x1, sp, 112
	mov	w2, 1
	adrp	x0, .LC86
	add	x0, x0, :lo12:.LC86
	bl	setenv
	add	x1, sp, 48
	mov	w2, 1
	adrp	x0, .LC87
	add	x0, x0, :lo12:.LC87
	bl	setenv
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 368
	ret
	.p2align 2,,3
.L572:
	adrp	x3, .LC42
	add	x3, x3, :lo12:.LC42
	b	.L571
	.p2align 2,,3
.L574:
	mov	w0, 84
	bl	sysconf
	cmp	x0, 0
	csinc	x3, x0, xzr, gt
	b	.L570
	.section	.rodata.str1.8
	.align	3
.LC88:
	.string	"0"
	.align	3
.LC89:
	.string	"1"
	.align	3
.LC90:
	.string	"2"
	.align	3
.LC91:
	.string	"s"
	.align	3
.LC92:
	.string	"3"
	.align	3
.LC93:
	.string	" %s"
	.align	3
.LC94:
	.string	"z"
	.align	3
.LC95:
	.string	"g"
	.align	3
.LC96:
	.string	"-C opt-level=%s -C target-cpu=%s"
	.align	3
.LC97:
	.string	"%s/makepkg.archtoo.conf"
	.align	3
.LC98:
	.string	"\033[1;31m[-] Cannot write %s\n\033[0m"
	.align	3
.LC99:
	.string	"# Generated by archtoo -- do not edit, it is rewritten every build.\n# target=%s opt=%s pipe=%d\nsource /etc/makepkg.conf\nCFLAGS=\"%s\"\nCXXFLAGS=\"%s\"\nLDFLAGS=\"${LDFLAGS}%s\"\nRUSTFLAGS=\"%s\"\nMAKEFLAGS=\"-j%ld\"\n"
	.text
	.align	2
	.p2align 5,,15
	.global	write_makepkg_conf
	.type	write_makepkg_conf, %function
write_makepkg_conf:
	sub	sp, sp, #1088
	adrp	x2, .LC41
	add	x2, x2, :lo12:.LC41
	stp	x29, x30, [sp, 16]
	add	x29, sp, 16
	stp	x19, x20, [sp, 32]
	adrp	x19, .LANCHOR1
	add	x3, x19, :lo12:.LANCHOR1
	add	x3, x3, 160
	stp	x21, x22, [sp, 48]
	mov	x21, x0
	mov	x22, x1
	add	x0, sp, 104
	mov	x1, 16
	str	x23, [sp, 64]
	bl	xsnprintf
	adrp	x20, .LANCHOR0
	add	x0, sp, 320
	mov	x1, 256
	bl	render_build_flags
	add	x0, sp, 576
	mov	x1, 256
	bl	render_build_flags
	strb	wzr, [sp, 120]
	add	x0, x20, :lo12:.LANCHOR0
	add	x3, x0, 32
	ldrb	w0, [x0, 32]
	cbnz	w0, .L605
.L576:
	ldrh	w0, [sp, 104]
	adrp	x3, .LC88
	add	x3, x3, :lo12:.LC88
	cmp	w0, 48
	beq	.L579
	cmp	w0, 49
	beq	.L604
	adrp	x3, .LC90
	add	x3, x3, :lo12:.LC90
	cmp	w0, 50
	beq	.L579
	cmp	w0, 115
	beq	.L589
	cmp	w0, 122
	beq	.L589
	adrp	x3, .LC92
	add	x3, x3, :lo12:.LC92
	cmp	w0, 103
	beq	.L604
	.p2align 5,,15
.L579:
	add	x23, x19, :lo12:.LANCHOR1
	mov	x1, 256
	add	x4, x23, 32
	add	x0, sp, 832
	adrp	x2, .LC96
	add	x2, x2, :lo12:.LC96
	bl	xsnprintf
	adrp	x3, .LC64
	adrp	x2, .LC97
	add	x3, x3, :lo12:.LC64
	add	x2, x2, :lo12:.LC97
	mov	x1, x22
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	fopen_nofollow
	mov	x22, x0
	cbz	x0, .L606
	add	x20, x20, :lo12:.LANCHOR0
	ldr	w4, [x23, 176]
	ldr	x0, [x20, 16]
	cmp	x0, 0
	ble	.L607
.L594:
	add	x1, sp, 832
	add	x2, x19, :lo12:.LANCHOR1
	add	x7, sp, 120
	add	x6, sp, 576
	add	x5, sp, 320
	add	x3, sp, 104
	add	x2, x2, 32
	stp	x1, x0, [sp]
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	mov	x0, x22
	bl	fprintf
	mov	x0, x22
	bl	fclose
	mov	x0, x21
	bl	fix_owner
	mov	w0, 1
.L575:
	ldr	x23, [sp, 64]
	ldp	x29, x30, [sp, 16]
	ldp	x19, x20, [sp, 32]
	ldp	x21, x22, [sp, 48]
	add	sp, sp, 1088
	ret
	.p2align 2,,3
.L604:
	adrp	x3, .LC89
	add	x3, x3, :lo12:.LC89
	b	.L579
	.p2align 2,,3
.L605:
	add	x0, sp, 120
	adrp	x2, .LC93
	mov	x1, 200
	add	x2, x2, :lo12:.LC93
	bl	xsnprintf
	b	.L576
	.p2align 2,,3
.L607:
	mov	w0, 84
	str	w4, [sp, 92]
	bl	sysconf
	cmp	x0, 0
	ldr	w4, [sp, 92]
	csinc	x0, x0, xzr, gt
	b	.L594
	.p2align 2,,3
.L589:
	adrp	x3, .LC91
	add	x3, x3, :lo12:.LC91
	b	.L579
.L606:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC98
	add	x1, x1, :lo12:.LC98
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L575
	.section	.rodata.str1.8
	.align	3
.LC100:
	.string	"Y/n"
	.align	3
.LC101:
	.string	"yes"
	.align	3
.LC102:
	.string	"y/N"
	.align	3
.LC103:
	.string	"no"
	.align	3
.LC104:
	.string	"%s [%s]: %s (auto)\n"
	.align	3
.LC105:
	.string	"%s [%s]: "
	.align	3
.LC106:
	.string	"%s (default after %lds)\n"
	.text
	.align	2
	.p2align 5,,15
	.global	ask_yes_no
	.type	ask_yes_no, %function
ask_yes_no:
	stp	x29, x30, [sp, -128]!
	mov	x4, x0
	adrp	x0, .LANCHOR0
	mov	x29, sp
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	stp	x19, x20, [sp, 16]
	mov	w19, w1
	cbnz	w0, .L612
	adrp	x20, .LANCHOR1
	ldr	w0, [x20, #:lo12:.LANCHOR1]
	cbnz	w0, .L648
.L612:
	cbnz	w19, .L610
	adrp	x2, .LC102
	adrp	x3, .LC103
	add	x2, x2, :lo12:.LC102
	add	x3, x3, :lo12:.LC103
.L611:
	adrp	x0, .LC104
	mov	x1, x4
	add	x0, x0, :lo12:.LC104
	bl	printf
.L614:
	mov	w0, w19
.L608:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 128
	ret
	.p2align 2,,3
.L610:
	adrp	x2, .LC100
	adrp	x3, .LC101
	add	x2, x2, :lo12:.LC100
	add	x3, x3, :lo12:.LC101
	b	.L611
	.p2align 2,,3
.L648:
	mov	w0, 0
	str	x4, [sp, 56]
	bl	isatty
	ldr	x4, [sp, 56]
	cbz	w0, .L612
	str	x21, [sp, 32]
	cbnz	w19, .L649
	adrp	x2, .LC102
	add	x2, x2, :lo12:.LC102
.L615:
	mov	x1, x4
	adrp	x0, .LC105
	add	x0, x0, :lo12:.LC105
	bl	printf
	adrp	x0, :got:stdout
	ldr	x0, [x0, :got_lo12:stdout]
	add	x21, sp, 64
	ldr	x0, [x0]
	bl	fflush
	add	x0, x20, :lo12:.LANCHOR1
	ldr	x0, [x0, 8]
	cmp	x0, 0
	ble	.L616
	mov	x1, 4294967296
	mov	x2, 50331
	str	x1, [sp, 64]
	mov	w1, 1000
	movk	x2, 0x20, lsl 16
	cmp	x0, x2
	mul	w1, w0, w1
	mov	w2, 64888
	add	x0, sp, 64
	movk	w2, 0x7fff, lsl 16
	mov	x21, x0
	csel	w2, w1, w2, le
	mov	x1, 1
	bl	poll
	cbz	w0, .L650
	tbnz	w0, #31, .L651
.L616:
	adrp	x20, :got:stdin
	ldr	x20, [x20, :got_lo12:stdin]
	mov	x0, x21
	mov	w1, 64
	ldr	x2, [x20]
	bl	fgets
	cbz	x0, .L647
	mov	x0, x21
	mov	w1, 10
	bl	strchr
	cbz	x0, .L624
.L623:
	ldrb	w0, [sp, 64]
	cmp	w0, 13
	bhi	.L625
	mov	x1, 9217
	lsr	x1, x1, x0
	tbz	x1, 0, .L625
.L647:
	ldr	x21, [sp, 32]
	b	.L614
	.p2align 2,,3
.L652:
	cmn	w0, #1
	beq	.L623
.L624:
	ldr	x0, [x20]
	bl	getc
	cmp	w0, 10
	bne	.L652
	b	.L623
	.p2align 2,,3
.L649:
	adrp	x2, .LC100
	add	x2, x2, :lo12:.LC100
	b	.L615
	.p2align 2,,3
.L625:
	and	w0, w0, -33
	cmp	w0, 89
	ldr	x21, [sp, 32]
	cset	w0, eq
	b	.L608
	.p2align 2,,3
.L650:
	cbnz	w19, .L653
	adrp	x1, .LC103
	add	x1, x1, :lo12:.LC103
.L619:
	add	x20, x20, :lo12:.LANCHOR1
	adrp	x0, .LC106
	add	x0, x0, :lo12:.LC106
	ldr	x2, [x20, 8]
	bl	printf
	ldr	x21, [sp, 32]
	b	.L614
	.p2align 2,,3
.L653:
	adrp	x1, .LC101
	add	x1, x1, :lo12:.LC101
	b	.L619
	.p2align 2,,3
.L651:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L616
	ldr	x21, [sp, 32]
	b	.L614
	.align	2
	.p2align 5,,15
	.global	set_use_binary
	.type	set_use_binary, %function
set_use_binary:
	cmp	w0, 0
	adrp	x0, .LANCHOR0+228
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+228]
	ret
	.align	2
	.p2align 5,,15
	.global	get_use_binary
	.type	get_use_binary, %function
get_use_binary:
	adrp	x0, .LANCHOR0+228
	ldr	w0, [x0, #:lo12:.LANCHOR0+228]
	ret
	.section	.rodata.str1.8
	.align	3
.LC107:
	.string	".."
	.text
	.align	2
	.p2align 5,,15
	.global	valid_gentoo_chroot_path
	.type	valid_gentoo_chroot_path, %function
valid_gentoo_chroot_path:
	cbz	x0, .L671
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w20, [x0]
	cbz	w20, .L659
	bl	strlen
	sub	x0, x0, #1
	cmp	x0, 499
	mov	w1, 47
	ccmp	w20, w1, 0, ls
	beq	.L672
.L659:
	mov	w0, 0
.L656:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L672:
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x21, [x0]
	adrp	x20, .LC107
	mov	w0, 47
	add	x20, x20, :lo12:.LC107
	b	.L661
	.p2align 2,,3
.L674:
	ldrb	w0, [x19, 1]!
	cbz	w0, .L673
.L661:
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x21, x1]
	tbnz	x1, 3, .L660
	sub	w1, w0, #45
	and	w1, w1, 255
	cmp	w1, 2
	bls	.L660
	cmp	w0, 95
	bne	.L670
.L660:
	mov	x1, x20
	mov	x0, x19
	bl	strstr
	cbz	x0, .L674
.L670:
	ldr	x21, [sp, 32]
	b	.L659
	.p2align 2,,3
.L671:
	mov	w0, 0
	ret
	.p2align 2,,3
.L673:
	ldr	x21, [sp, 32]
	mov	w0, 1
	b	.L656
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot
	.type	set_gentoo_chroot, %function
set_gentoo_chroot:
	cmp	w0, 0
	adrp	x0, .LANCHOR0+232
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+232]
	ret
	.align	2
	.p2align 5,,15
	.global	get_gentoo_chroot
	.type	get_gentoo_chroot, %function
get_gentoo_chroot:
	adrp	x0, .LANCHOR0+232
	ldr	w0, [x0, #:lo12:.LANCHOR0+232]
	ret
	.align	2
	.p2align 5,,15
	.global	set_portage_imitation
	.type	set_portage_imitation, %function
set_portage_imitation:
	cmp	w0, 0
	adrp	x0, .LANCHOR0+236
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+236]
	ret
	.align	2
	.p2align 5,,15
	.global	get_portage_imitation
	.type	get_portage_imitation, %function
get_portage_imitation:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldp	w0, w1, [x0, 232]
	orr	w0, w1, w0
	cmp	w0, 0
	cset	w0, ne
	ret
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot_path
	.type	set_gentoo_chroot_path, %function
set_gentoo_chroot_path:
	cbz	x0, .L688
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L691
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L691:
	mov	x3, x19
	adrp	x0, .LANCHOR1
	ldr	x19, [sp, 16]
	add	x0, x0, :lo12:.LANCHOR1
	ldp	x29, x30, [sp], 32
	add	x0, x0, 192
	adrp	x2, .LC41
	mov	x1, 512
	add	x2, x2, :lo12:.LC41
	b	xsnprintf
	.p2align 2,,3
.L688:
	ret
	.align	2
	.p2align 5,,15
	.global	get_gentoo_chroot_path
	.type	get_gentoo_chroot_path, %function
get_gentoo_chroot_path:
	adrp	x0, .LANCHOR1
	add	x0, x0, :lo12:.LANCHOR1
	add	x0, x0, 192
	ret
	.data
	.align	4
	.set	.LANCHOR1,. + 0
	.type	g_emerge_confirm, %object
g_emerge_confirm:
	.word	1
	.zero	4
	.type	g_prompt_timeout, %object
g_prompt_timeout:
	.xword	300
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
	.string	"native"
	.zero	121
	.type	g_opt_level, %object
g_opt_level:
	.string	"3"
	.zero	14
	.type	g_use_pipe, %object
g_use_pipe:
	.word	1
	.zero	12
	.type	g_gentoo_chroot_path, %object
g_gentoo_chroot_path:
	.string	"/usr/local/emerge/gentoo-chroot"
	.zero	480
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	g_noconfirm, %object
g_noconfirm:
	.zero	4
	.type	g_interactive, %object
g_interactive:
	.zero	4
	.type	g_resume, %object
g_resume:
	.zero	4
	.zero	4
	.type	g_jobs, %object
g_jobs:
	.zero	8
	.zero	8
	.type	g_raw_flags, %object
g_raw_flags:
	.zero	193
	.zero	3
	.type	g_use_binary, %object
g_use_binary:
	.zero	4
	.type	g_gentoo_chroot, %object
g_gentoo_chroot:
	.zero	4
	.type	g_portage_imitation, %object
g_portage_imitation:
	.zero	4
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
