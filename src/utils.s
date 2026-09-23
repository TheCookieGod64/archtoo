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
	adrp	x1, .LANCHOR0
	add	x2, x1, :lo12:.LANCHOR0
	mov	w0, 1
	ldr	w1, [x1, #:lo12:.LANCHOR0]
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
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x21, [sp, 32]
	cbz	x0, .L35
	stp	x19, x20, [sp, 16]
	mov	w21, 0
	mov	x20, x0
	ldrb	w19, [x0]
	cbz	w19, .L52
	bl	strlen
	sub	x0, x0, #1
	cmp	x0, 63
	bhi	.L52
	mov	x0, x20
	adrp	x1, .LC0
	mov	w21, 1
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L52
	adrp	x1, .LC1
	mov	x0, x20
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L52
	bl	__ctype_b_loc
	mov	w21, 0
	ldr	x2, [x0]
	ubfiz	x1, x19, 1, 8
	ldrh	w0, [x2, x1]
	and	w1, w0, 8
	tbnz	x0, 3, .L34
	b	.L52
	.p2align 2,,3
.L53:
	ldrh	w0, [x2, x0]
	and	w1, w0, 8
.L34:
	sub	w0, w19, #45
	cmp	w19, 95
	and	w0, w0, 255
	cbnz	w1, .L33
	ccmp	w0, 1, 0, ne
	bhi	.L41
.L33:
	ldrb	w19, [x20, 1]!
	ubfiz	x0, x19, 1, 8
	cbnz	w19, .L53
	ldp	x19, x20, [sp, 16]
	mov	w21, 1
	b	.L31
	.p2align 2,,3
.L52:
	ldp	x19, x20, [sp, 16]
.L31:
	mov	w0, w21
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L35:
	mov	w21, 0
	mov	w0, w21
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L41:
	ldp	x19, x20, [sp, 16]
	mov	w21, 0
	b	.L31
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
	.string	"\n\033[1;36mAMD:\n\033[0m"
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
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	cbz	x0, .L70
	str	x21, [sp, 32]
	mov	x19, x0
	mov	w20, 0
	ldrb	w21, [x0]
	cbz	w21, .L114
	adrp	x1, .LC0
	mov	w20, 1
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L114
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L114
	cmp	w21, 45
	beq	.L115
	and	w21, w21, -33
	cmp	w21, 79
	bne	.L69
.L68:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
.L60:
	mov	w20, 0
	cbz	w0, .L114
.L69:
	ldrb	w21, [x19]
	cmp	w21, 48
	bne	.L83
	ldrb	w0, [x19, 1]
	mov	w20, 1
	cbnz	w0, .L83
	.p2align 5,,15
.L114:
	ldr	x21, [sp, 32]
.L57:
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L115:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
	and	w1, w0, -33
	cmp	w1, 79
	beq	.L68
	b	.L60
	.p2align 2,,3
.L83:
	cmp	w21, 49
	bne	.L84
	ldrb	w0, [x19, 1]
	mov	w20, 1
	cbz	w0, .L114
.L84:
	cmp	w21, 50
	beq	.L116
.L85:
	cmp	w21, 51
	bne	.L86
	ldrb	w0, [x19, 1]
	mov	w20, 1
	cbz	w0, .L114
.L86:
	cmp	w21, 115
	bne	.L87
	ldrb	w0, [x19, 1]
	mov	w20, 1
	cbz	w0, .L114
.L87:
	mov	x0, x19
	adrp	x1, .LC21
	mov	w20, 1
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L114
	cmp	w21, 103
	bne	.L88
	ldrb	w0, [x19, 1]
	cbz	w0, .L114
.L88:
	subs	w21, w21, #122
	bne	.L67
	ldrb	w21, [x19, 1]
.L67:
	cmp	w21, 0
	ldr	x21, [sp, 32]
	cset	w20, eq
	b	.L57
	.p2align 2,,3
.L70:
	mov	w20, 0
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L116:
	ldrb	w0, [x19, 1]
	mov	w20, 1
	cbz	w0, .L114
	b	.L85
	.align	2
	.p2align 5,,15
	.global	get_opt_level
	.type	get_opt_level, %function
get_opt_level:
	adrp	x0, .LANCHOR1
	add	x0, x0, :lo12:.LANCHOR1
	add	x0, x0, 160
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
	adrp	x1, .LANCHOR1+176
	cmp	w0, 0
	cset	w0, ne
	str	w0, [x1, #:lo12:.LANCHOR1+176]
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
	stp	x29, x30, [sp, -208]!
	mov	x29, sp
	str	x21, [sp, 32]
	mov	x21, x0
	bl	fork
	cmp	w0, 0
	blt	.L126
	stp	x19, x20, [sp, 16]
	mov	w19, w0
	add	x20, sp, 56
	beq	.L134
	.p2align 5,,15
.L125:
	mov	x1, x20
	mov	w0, w19
	mov	w2, 0
	bl	waitpid
	tbz	w0, #31, .L135
	bl	__errno_location
	ldr	w1, [x0]
	cmp	w1, 4
	beq	.L125
.L133:
	ldp	x19, x20, [sp, 16]
.L126:
	mov	w0, -1
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 208
	ret
	.p2align 2,,3
.L135:
	ldr	w0, [sp, 56]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L136
	cbnz	w2, .L133
	ldr	x21, [sp, 32]
	ubfx	x0, x0, 8, 8
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 208
	ret
	.p2align 2,,3
.L136:
	ldr	x21, [sp, 32]
	add	w0, w2, 128
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 208
	ret
.L134:
	movi	v31.4s, 0
	str	xzr, [x20, 144]
	add	x0, sp, 64
	str	q31, [sp, 56]
	stp	q31, q31, [x20, 16]
	stp	q31, q31, [x20, 48]
	stp	q31, q31, [x20, 80]
	stp	q31, q31, [x20, 112]
	bl	sigemptyset
	mov	x1, x20
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	mov	x1, x20
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	mov	x1, x20
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	mov	x3, x21
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
	cbz	x1, .L166
	stp	x29, x30, [sp, -240]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	mov	x25, x1
	str	xzr, [x1]
	cbz	x0, .L139
	add	x0, sp, 80
	bl	pipe
	cbnz	w0, .L139
	bl	fork
	mov	w24, w0
	cmp	w0, 0
	blt	.L171
	beq	.L172
	ldr	w0, [sp, 84]
	bl	close
	mov	x0, 4096
	bl	malloc
	mov	x20, x0
	cbz	x0, .L170
	mov	x22, 1024
	mov	x0, 16776192
	add	x23, x22, x0
	mov	x26, 0
	mov	x19, 4096
	.p2align 5,,15
.L146:
	cmp	x22, x19
	bcc	.L147
	lsl	x19, x19, 1
	cmp	x19, x23
	bhi	.L169
.L148:
	mov	x1, x19
	mov	x0, x20
	bl	realloc
	cbz	x0, .L169
	mov	x20, x0
.L147:
	ldr	w0, [sp, 80]
	add	x21, x20, x26
	sub	x2, x19, x26
	mov	x1, x21
	sub	x2, x2, #1
	bl	read
	cmp	x0, 0
	blt	.L173
	beq	.L151
	add	x26, x26, x0
	add	x22, x26, 1024
	cmp	x22, x19
	bcc	.L147
	lsl	x19, x19, 1
	cmp	x19, x23
	bls	.L148
.L169:
	mov	x0, x20
	bl	free
.L170:
	ldr	w0, [sp, 80]
	bl	close
	mov	w0, w24
	mov	w2, 0
	mov	x1, 0
	bl	waitpid
.L139:
	mov	w0, -1
.L137:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 240
	ret
	.p2align 2,,3
.L172:
	movi	v31.4s, 0
	add	x19, sp, 88
	str	xzr, [x19, 144]
	add	x0, sp, 96
	str	q31, [sp, 88]
	stp	q31, q31, [x19, 16]
	stp	q31, q31, [x19, 48]
	stp	q31, q31, [x19, 80]
	stp	q31, q31, [x19, 112]
	bl	sigemptyset
	mov	x1, x19
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	mov	x1, x19
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	mov	x1, x19
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	ldr	w0, [sp, 80]
	bl	close
	ldr	w0, [sp, 84]
	mov	w1, 1
	bl	dup2
	tbnz	w0, #31, .L174
	ldr	w0, [sp, 84]
	bl	close
	adrp	x0, .LC38
	mov	w1, 1
	add	x0, x0, :lo12:.LC38
	bl	open
	mov	w19, w0
	tbz	w0, #31, .L175
.L145:
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
	.p2align 2,,3
.L173:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L146
	b	.L169
	.p2align 2,,3
.L166:
	mov	w0, -1
	ret
	.p2align 2,,3
.L175:
	mov	w1, 2
	bl	dup2
	mov	w0, w19
	bl	close
	b	.L145
	.p2align 2,,3
.L174:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L151:
	ldr	w0, [sp, 80]
	add	x19, sp, 88
	bl	close
	strb	wzr, [x21]
	b	.L152
	.p2align 2,,3
.L153:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L176
.L152:
	mov	x1, x19
	mov	w0, w24
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L153
	ldr	w0, [sp, 88]
	str	x20, [x25]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L177
	cbnz	w2, .L139
	ubfx	x0, x0, 8, 8
	b	.L137
.L176:
	mov	x0, x20
	bl	free
	b	.L139
.L177:
	add	w0, w2, 128
	b	.L137
.L171:
	ldr	w0, [sp, 80]
	bl	close
	ldr	w0, [sp, 84]
	bl	close
	b	.L139
	.align	2
	.p2align 5,,15
	.global	shell_quote
	.type	shell_quote, %function
shell_quote:
	cmp	x1, 0
	ccmp	x2, 2, 0, ne
	ccmp	x0, 0, 4, hi
	bne	.L179
.L183:
	mov	w0, 0
	ret
	.p2align 2,,3
.L179:
	mov	w3, 39
	strb	w3, [x1]
	mov	x4, 1
	ldrb	w3, [x0]
	cbz	w3, .L186
	mov	w7, 92
	b	.L185
	.p2align 2,,3
.L182:
	cmp	x5, x2
	bcs	.L183
	strb	w3, [x1, x4]
	mov	x4, x5
	ldrb	w3, [x0, 1]!
	cbz	w3, .L188
.L185:
	add	x5, x4, 1
	cmp	w3, 39
	bne	.L182
	add	x6, x4, 4
	add	x5, x1, x4
	cmp	x6, x2
	bcs	.L183
	strb	w3, [x1, x4]
	mov	x4, x6
	strb	w7, [x5, 1]
	strb	w3, [x5, 2]
	strb	w3, [x5, 3]
	ldrb	w3, [x0, 1]!
	cbnz	w3, .L185
.L188:
	add	x3, x4, 1
	cmp	x3, x2
	bcs	.L183
.L181:
	mov	w0, 39
	strb	w0, [x1, x4]
	mov	w0, 1
	strb	wzr, [x1, x3]
	ret
.L186:
	mov	x3, 2
	b	.L181
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
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	cbz	x0, .L193
	ldrb	w1, [x0]
	mov	x19, x0
	str	w1, [sp, 60]
	mov	w20, 0
	cbz	w1, .L189
	bl	strlen
	cmp	x0, 128
	bhi	.L189
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x21, [x0]
	adrp	x20, .LC39
	ldr	w1, [sp, 60]
	add	x20, x20, :lo12:.LC39
	.p2align 5,,15
.L192:
	ubfiz	x2, x1, 1, 8
	mov	x0, x20
	ldrh	w2, [x21, x2]
	tbnz	x2, 3, .L191
	bl	strchr
	cbz	x0, .L196
.L191:
	ldrb	w1, [x19, 1]!
	cbnz	w1, .L192
	ldr	x21, [sp, 32]
	mov	w20, 1
.L189:
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L193:
	mov	w20, 0
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L196:
	mov	w20, 0
	mov	w0, w20
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.align	2
	.p2align 5,,15
	.global	dep_basename
	.type	dep_basename, %function
dep_basename:
	cmp	x1, 0
	ccmp	x2, 0, 4, ne
	beq	.L200
	cbz	x0, .L202
	ldrb	w3, [x0]
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	bne	.L204
	.p2align 5,,15
.L203:
	ldrb	w3, [x0, 1]!
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	beq	.L203
.L204:
	mov	x8, 512
	mov	x5, x1
	movk	x8, 0x1, lsl 32
	mov	x6, x1
	mov	x4, 0
	movk	x8, 0x7400, lsl 48
	cbnz	w3, .L208
	b	.L206
	.p2align 2,,3
.L209:
	cmp	w3, 62
	bhi	.L207
	lsr	x7, x8, x3
	tbnz	x7, 0, .L206
.L207:
	strb	w3, [x5], 1
	ldrb	w3, [x0, x4]
	cbz	w3, .L214
.L208:
	add	x4, x4, 1
	mov	x6, x5
	cmp	x4, x2
	bcc	.L209
.L206:
	strb	wzr, [x6]
.L200:
	ret
	.p2align 2,,3
.L214:
	add	x6, x1, x4
	strb	wzr, [x6]
	b	.L200
	.p2align 2,,3
.L202:
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
	mov	w10, -40
	mov	w9, -128
	mov	x29, sp
	add	x8, sp, 272
	add	x11, sp, 224
	stp	x8, x8, [sp, 64]
	add	x8, sp, 32
	str	x11, [sp, 80]
	stp	w10, w9, [sp, 88]
	str	x19, [sp, 16]
	mov	x19, x1
	ldp	q30, q31, [sp, 64]
	stp	x3, x4, [sp, 232]
	mov	x3, x8
	stp	x5, x6, [sp, 248]
	str	x7, [sp, 264]
	str	q30, [sp, 32]
	stp	q0, q1, [sp, 96]
	stp	q2, q3, [sp, 128]
	stp	q4, q5, [sp, 160]
	stp	q6, q7, [sp, 192]
	str	q31, [x8, 16]
	bl	vsnprintf
	mov	w2, w0
	tbnz	w0, #31, .L216
	cmp	x19, w0, sxtw
	bls	.L216
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 272
	ret
.L216:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x3, x19
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
	cbz	x0, .L234
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_target_arch
	cbz	w0, .L219
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L219
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbnz	w0, .L237
.L219:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L234:
	ret
	.p2align 2,,3
.L237:
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
	cbz	x0, .L291
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_opt_level
	cbz	w0, .L238
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L238
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L238
	ldrb	w0, [x19]
	cmp	w0, 45
	beq	.L294
.L240:
	and	w0, w0, -33
	and	w0, w0, 255
	cmp	w0, 79
	cinc	x19, x19, eq
	ldrb	w0, [x19]
	cmp	w0, 48
	beq	.L295
.L250:
	cmp	w0, 49
	bne	.L251
	ldrb	w1, [x19, 1]
	cbnz	w1, .L251
.L243:
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
.L251:
	cmp	w0, 50
	bne	.L252
	ldrb	w1, [x19, 1]
	cbz	w1, .L243
	.p2align 5,,15
.L252:
	cmp	w0, 51
	bne	.L253
	ldrb	w1, [x19, 1]
	cbz	w1, .L243
	.p2align 5,,15
.L253:
	cmp	w0, 115
	bne	.L254
	ldrb	w1, [x19, 1]
	cbz	w1, .L243
.L254:
	cmp	w0, 103
	bne	.L255
	ldrb	w1, [x19, 1]
	cbz	w1, .L243
.L255:
	cmp	w0, 122
	bne	.L256
	ldrb	w0, [x19, 1]
	cbz	w0, .L243
.L256:
	adrp	x1, .LC21
	mov	x0, x19
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L243
.L238:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L295:
	ldrb	w1, [x19, 1]
	cbz	w1, .L243
	b	.L250
	.p2align 2,,3
.L294:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
	b	.L240
	.p2align 2,,3
.L291:
	ret
	.section	.rodata.str1.8
	.align	3
.LC42:
	.string	"%s >/dev/null 2>&1"
	.text
	.align	2
	.p2align 5,,15
	.global	run_cmd_quiet
	.type	run_cmd_quiet, %function
run_cmd_quiet:
	mov	x12, 4640
	sub	sp, sp, x12
	mov	x3, x0
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	add	x19, sp, 32
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	ldr	x19, [sp, 16]
	mov	x12, 4640
	ldp	x29, x30, [sp]
	add	sp, sp, x12
	ret
	.align	2
	.p2align 5,,15
	.global	fopen_nofollow
	.type	fopen_nofollow, %function
fopen_nofollow:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x1
	ldrb	w1, [x1]
	cmp	w1, 114
	beq	.L305
	cmp	w1, 119
	beq	.L306
	cmp	w1, 97
	beq	.L307
	bl	__errno_location
	mov	w1, 22
	str	w1, [x0]
.L300:
	mov	x19, 0
.L298:
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L306:
	mov	w1, 33345
.L299:
	mov	w2, 420
	bl	open
	mov	w20, w0
	tbnz	w0, #31, .L300
	mov	x1, x19
	bl	fdopen
	mov	x19, x0
	cbnz	x0, .L298
	mov	w0, w20
	bl	close
	b	.L298
	.p2align 2,,3
.L307:
	mov	w1, 33857
	b	.L299
	.p2align 2,,3
.L305:
	mov	w1, 32768
	b	.L299
	.align	2
	.p2align 5,,15
	.global	file_exists
	.type	file_exists, %function
file_exists:
	stp	x29, x30, [sp, -144]!
	mov	x29, sp
	add	x1, sp, 16
	bl	stat
	cbnz	w0, .L311
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 32768
	cset	w0, eq
	ret
	.p2align 2,,3
.L311:
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
	cbnz	w0, .L315
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 16384
	cset	w0, eq
	ret
	.p2align 2,,3
.L315:
	mov	w0, 0
	ldp	x29, x30, [sp], 144
	ret
	.section	.rodata.str1.8
	.align	3
.LC43:
	.string	"@._+-"
	.text
	.align	2
	.p2align 5,,15
	.global	valid_pkgname
	.type	valid_pkgname, %function
valid_pkgname:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	cbz	x0, .L321
	stp	x19, x20, [sp, 16]
	mov	w21, 0
	mov	x20, x0
	ldrb	w19, [x0]
	cbz	w19, .L331
	sub	w1, w19, #45
	and	w1, w1, 255
	cmp	w1, 1
	bls	.L331
	bl	strlen
	cmp	x0, 128
	bhi	.L331
	mov	w22, 2560
	str	x23, [sp, 48]
	adrp	x23, .LC43
	bl	__ctype_b_loc
	ldr	x21, [x0]
	add	x23, x23, :lo12:.LC43
	b	.L320
	.p2align 2,,3
.L319:
	ldrb	w19, [x20, 1]!
	cbz	w19, .L332
.L320:
	ubfiz	x0, x19, 1, 8
	ldrh	w0, [x21, x0]
	tst	w22, w0
	bne	.L319
	mov	w1, w19
	mov	x0, x23
	bl	strchr
	cbnz	x0, .L319
	ldr	x23, [sp, 48]
	mov	w21, 0
	ldp	x19, x20, [sp, 16]
	b	.L317
	.p2align 2,,3
.L331:
	ldp	x19, x20, [sp, 16]
.L317:
	mov	w0, w21
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L332:
	mov	w21, 1
	mov	w0, w21
	ldr	x23, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L321:
	mov	w21, 0
	mov	w0, w21
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ret
	.section	.rodata.str1.8
	.align	3
.LC44:
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
	mov	x21, x2
	stp	x23, x24, [sp, 48]
	mov	x24, x1
	ldrb	w1, [x0]
	cbz	w1, .L341
	adrp	x22, .LC44
	mov	x20, x0
	add	x22, x22, :lo12:.LC44
	mov	x19, 0
	mov	w23, 92
	b	.L340
	.p2align 2,,3
.L344:
	cmp	x3, x21
	bcs	.L339
	add	x0, x19, 1
	strb	w23, [x24, x19]
	mov	x19, x3
.L338:
	ldrb	w3, [x20]
	strb	w3, [x24, x0]
	ldrb	w1, [x20, 1]!
	cbz	w1, .L334
.L340:
	mov	x0, x22
	bl	strchr
	add	x3, x19, 2
	cbnz	x0, .L344
	add	x1, x19, 1
	mov	x0, x19
	mov	x19, x1
	cmp	x1, x21
	bcc	.L338
.L339:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
.L341:
	mov	x19, 0
	.p2align 5,,15
.L334:
	cmp	x21, x19
	bls	.L339
	strb	wzr, [x24, x19]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.section	.rodata.str1.8
	.align	3
.LC45:
	.string	"SUDO_USER"
	.text
	.align	2
	.p2align 5,,15
	.global	build_user
	.type	build_user, %function
build_user:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	mov	x29, sp
	bl	getenv
	cbz	x0, .L346
	ldrb	w1, [x0]
	cbnz	w1, .L345
.L346:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L345
	ldr	x0, [x0]
.L345:
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata.str1.8
	.align	3
.LC46:
	.string	"\033[1;31m[-] Configuration error: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	load_user_config
	.type	load_user_config, %function
load_user_config:
	sub	sp, sp, #1504
	mov	x2, 512
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x20, sp, 32
	add	x19, sp, 544
	mov	x1, x20
	mov	x0, x19
	bl	config_load
	cbz	w0, .L359
	mov	x0, x19
	bl	config_apply
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1504
	ret
	.p2align 2,,3
.L359:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC46
	add	x1, x1, :lo12:.LC46
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1504
	ret
	.section	.rodata.str1.8
	.align	3
.LC47:
	.string	""
	.align	3
.LC48:
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
	adrp	x1, .LC47
	cmp	w0, 0
	add	x1, x1, :lo12:.LC47
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	csel	x0, x0, x1, ne
	ldp	x29, x30, [sp], 16
	ret
	.section	.rodata.str1.8
	.align	3
.LC49:
	.string	"command -v '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	have_cmd
	.type	have_cmd, %function
have_cmd:
	mov	x12, 5152
	sub	sp, sp, x12
	mov	x3, x0
	mov	x1, 512
	adrp	x2, .LC49
	add	x2, x2, :lo12:.LC49
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x20, sp, 32
	mov	x0, x20
	bl	xsnprintf
	add	x19, sp, 544
	mov	x3, x20
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	cmp	w0, 0
	ldp	x29, x30, [sp]
	cset	w0, eq
	ldp	x19, x20, [sp, 16]
	mov	x12, 5152
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC50:
	.string	"sudo"
	.align	3
.LC51:
	.string	"\033[1;31m[-] sudo is required.\n\033[0m"
	.align	3
.LC52:
	.string	"sudo -k"
	.align	3
.LC53:
	.string	"\033[1;31m[-] Could not invalidate sudo credentials.\n\033[0m"
	.align	3
.LC54:
	.string	"\033[1;31m[-] Out of memory.\n\033[0m"
	.align	3
.LC56:
	.string	"\033[1;31m[-] Could not execute sudo: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	acquire_sudo
	.type	acquire_sudo, %function
acquire_sudo:
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	w20, w0
	mov	x19, x1
	bl	geteuid
	cbnz	w0, .L375
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L375:
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC50
	add	x22, x23, :lo12:.LC50
	mov	x0, x22
	bl	have_cmd
	cbz	w0, .L376
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	bl	run_cmd
	cbnz	w0, .L377
	sxtw	x24, w20
	mov	x1, 8
	add	x0, x24, 3
	bl	calloc
	mov	x21, x0
	cbz	x0, .L378
	adrp	x1, .LC55
	add	x1, x1, :lo12:.LC55
	ldr	w4, [x22]
	add	x0, sp, 64
	str	w4, [sp, 72]
	add	x2, sp, 72
	ldrh	w5, [x1]
	strh	w5, [sp, 64]
	ldrb	w3, [x1, 2]
	ldrb	w1, [x22, 4]
	stp	x2, x0, [x21]
	strb	w3, [sp, 66]
	strb	w1, [sp, 76]
	cmp	w20, 0
	ble	.L372
	ubfiz	x2, x20, 3, 32
	mov	x1, x19
	add	x0, x21, 16
	bl	memcpy
.L372:
	add	x24, x24, 2
	mov	x1, x21
	add	x0, x23, :lo12:.LC50
	str	xzr, [x21, x24, lsl 3]
	bl	execvp
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	ldr	x19, [x0]
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x2, x0
	adrp	x1, .LC56
	add	x1, x1, :lo12:.LC56
	mov	x0, x19
	bl	fprintf
	mov	x0, x21
	bl	free
.L369:
	ldp	x21, x22, [sp, 32]
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L376:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC51
	mov	x2, 33
	mov	x1, 1
	add	x0, x0, :lo12:.LC51
	ldr	x3, [x3]
	bl	fwrite
	b	.L369
	.p2align 2,,3
.L377:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC53
	mov	x2, 54
	mov	x1, 1
	add	x0, x0, :lo12:.LC53
	ldr	x3, [x3]
	bl	fwrite
	b	.L369
.L378:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC54
	mov	x2, 30
	mov	x1, 1
	add	x0, x0, :lo12:.LC54
	ldr	x3, [x3]
	bl	fwrite
	b	.L369
	.section	.rodata.str1.8
	.align	3
.LC55:
	.string	"--"
	.text
	.section	.rodata.str1.8
	.align	3
.LC57:
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
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	geteuid
	cbz	w0, .L394
.L379:
	ldp	x29, x30, [sp]
	mov	x12, 5664
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L394:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x3, x0
	cbz	x0, .L381
	ldrb	w0, [x0]
	cbnz	w0, .L382
.L381:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L379
	ldr	x3, [x0]
	cbz	x3, .L379
.L382:
	add	x20, sp, 32
	mov	x4, x19
	mov	x0, x20
	mov	x1, 1024
	adrp	x2, .LC57
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	add	x19, sp, 1056
	mov	x3, x20
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	ldp	x29, x30, [sp]
	mov	x12, 5664
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC58:
	.string	"%s%s"
	.align	3
.LC59:
	.string	"\033[1;31m[-] Running as root with no SUDO_USER; cannot find an unprivileged user to build as.\n\033[0m"
	.align	3
.LC60:
	.string	"/dev/urandom"
	.align	3
.LC61:
	.string	"/usr/local/emerge"
	.align	3
.LC62:
	.string	"%s/.archtoo-step-%ld-%08lx.sh"
	.align	3
.LC63:
	.string	"\033[1;31m[-] Cannot create step script in %s: %s\n\033[0m"
	.align	3
.LC64:
	.string	"w"
	.align	3
.LC65:
	.string	"\033[1;31m[-] fdopen failed for %s\n\033[0m"
	.align	3
.LC66:
	.string	"#!/bin/sh\ntrap 'exit 130' INT\ntrap 'exit 143' TERM\ntrap 'exit 129' HUP\n%s%s\n"
	.align	3
.LC67:
	.string	"\033[1;31m[-] Cannot finish writing %s\n\033[0m"
	.align	3
.LC68:
	.string	"sudo -u '%s' -- /bin/sh '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	run_as_user
	.type	run_as_user, %function
run_as_user:
	mov	x12, 4832
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	str	x0, [sp, 112]
	bl	geteuid
	cbz	w0, .L396
	cbz	x21, .L397
	ldrb	w0, [x21]
	cbnz	w0, .L398
.L397:
	ldp	x29, x30, [sp]
	mov	x12, 4832
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldr	x0, [sp, 112]
	add	sp, sp, x12
	b	run_cmd
	.p2align 2,,3
.L396:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	str	x0, [sp, 120]
	cbz	x0, .L400
	ldrb	w0, [x0]
	cbnz	w0, .L401
.L400:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L402
	ldr	x0, [x0]
	str	x0, [sp, 120]
	cbz	x0, .L402
.L401:
	add	x20, sp, 136
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC60
	add	x23, x23, :lo12:.LC60
	stp	x25, x26, [sp, 64]
	add	x25, sp, 128
	stp	x27, x28, [sp, 80]
	add	x28, sp, 736
	mov	w0, 16
	adrp	x24, .LC61
	adrp	x26, .LC62
	str	w0, [sp, 108]
	.p2align 5,,15
.L403:
	bl	getpid
	sxtw	x19, w0
	mov	w1, 524288
	mov	x0, x23
	bl	open
	mov	w27, w0
	mov	x1, x25
	mov	x2, 4
	tbnz	w0, #31, .L405
	bl	read
	mov	x22, x0
	mov	w0, w27
	bl	close
	cmp	x22, 4
	beq	.L428
.L405:
	mov	x1, x28
	mov	w0, 0
	bl	clock_gettime
	ldr	x27, [sp, 744]
	bl	getpid
	mov	w22, w0
	bl	clock
	eor	x5, x27, x0
	sbfiz	x1, x22, 16, 32
	eor	x5, x5, x1
	and	x5, x5, 4294967295
.L406:
	mov	x4, x19
	add	x3, x24, :lo12:.LC61
	add	x2, x26, :lo12:.LC62
	mov	x1, 600
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	mov	w2, 448
	mov	w1, 32961
	bl	open
	mov	w19, w0
	tbnz	w0, #31, .L429
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	bl	fdopen
	mov	x22, x0
	cbz	x0, .L430
	ldr	x3, [sp, 112]
	cmp	x21, 0
	adrp	x2, .LC47
	add	x2, x2, :lo12:.LC47
	csel	x2, x2, x21, eq
	adrp	x1, .LC66
	add	x1, x1, :lo12:.LC66
	bl	fprintf
	mov	x0, x22
	bl	fclose
	cbnz	w0, .L431
	mov	w1, 493
	mov	x0, x20
	bl	chmod
	add	x19, sp, 736
	mov	x0, x20
	bl	fix_owner
	ldr	x3, [sp, 120]
	mov	x4, x20
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
	mov	x1, 1024
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	mov	w19, w0
	mov	x0, x20
	bl	unlink
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
.L395:
	mov	w0, w19
	ldp	x29, x30, [sp]
	mov	x12, 4832
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L429:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	bne	.L408
	ldr	w1, [sp, 108]
	subs	w1, w1, #1
	str	w1, [sp, 108]
	bne	.L403
.L408:
	adrp	x1, :got:stderr;ldr	x1, [x1, :got_lo12:stderr]
	ldr	x19, [x1]
	bl	strerror
	add	x2, x24, :lo12:.LC61
	mov	x3, x0
	adrp	x1, .LC63
	mov	x0, x19
	add	x1, x1, :lo12:.LC63
	mov	w19, -1
	bl	fprintf
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L395
	.p2align 2,,3
.L428:
	ldr	w5, [sp, 128]
	rev	w5, w5
	b	.L406
	.p2align 2,,3
.L398:
	ldr	x4, [sp, 112]
	mov	x3, x21
	adrp	x2, .LC58
	add	x2, x2, :lo12:.LC58
	add	x19, sp, 736
	mov	x1, 4096
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	mov	w19, w0
	mov	x12, 4832
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
.L431:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC67
	mov	x2, x20
	add	x1, x1, :lo12:.LC67
	ldr	x0, [x0]
	bl	fprintf
.L427:
	mov	x0, x20
	mov	w19, -1
	bl	unlink
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L395
.L402:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC59
	mov	x2, 96
	add	x0, x0, :lo12:.LC59
	mov	x1, 1
	mov	w19, -1
	ldr	x3, [x3]
	bl	fwrite
	b	.L395
.L430:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC65
	add	x1, x1, :lo12:.LC65
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, w19
	bl	close
	b	.L427
	.section	.rodata.str1.8
	.align	3
.LC69:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC70:
	.string	"/usr/local/emerge/backups"
	.align	3
.LC71:
	.string	"%smkdir -p '%s' '%s'"
	.align	3
.LC72:
	.string	"\033[1;31m[-] Could not create %s\n\033[0m"
	.align	3
.LC73:
	.string	"._-"
	.align	3
.LC74:
	.string	"%schown -R '%s' '%s'"
	.align	3
.LC75:
	.string	"/usr/local/emerge/world"
	.align	3
.LC76:
	.string	"a"
	.align	3
.LC77:
	.string	"\033[1;31m[-] Cannot write world file %s\n\033[0m"
	.align	3
.LC78:
	.string	"\033[1;31m[-] World file %s is not writable.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	init_system
	.type	init_system, %function
init_system:
	mov	x12, 5712
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	add	x21, sp, 1104
	mov	x1, x21
	adrp	x22, .LC70
	stp	x19, x20, [sp, 16]
	adrp	x20, .LC69
	add	x0, x20, :lo12:.LC69
	bl	stat
	cbnz	w0, .L436
	ldr	w0, [sp, 1120]
	adrp	x22, .LC70
	and	w0, w0, 61440
	cmp	w0, 16384
	beq	.L506
.L436:
	bl	geteuid
	cmp	w0, 0
	adrp	x3, .LC48
	adrp	x0, .LC47
	add	x3, x3, :lo12:.LC48
	add	x0, x0, :lo12:.LC47
	csel	x3, x3, x0, ne
	add	x5, x22, :lo12:.LC70
	add	x4, x20, :lo12:.LC69
	adrp	x2, .LC71
	add	x2, x2, :lo12:.LC71
	add	x19, sp, 80
	mov	x1, 1024
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	cbnz	w0, .L507
.L438:
	bl	geteuid
	cbz	w0, .L444
	adrp	x0, .LC61
	mov	w1, 2
	add	x0, x0, :lo12:.LC61
	bl	access
	cbnz	w0, .L444
.L445:
	adrp	x19, .LC75
	mov	x1, x21
	add	x0, x19, :lo12:.LC75
	bl	stat
	cbnz	w0, .L452
	ldr	w0, [sp, 1120]
	and	w0, w0, 61440
	cmp	w0, 32768
	beq	.L456
.L452:
	add	x20, x19, :lo12:.LC75
	adrp	x1, .LC76
	mov	x0, x20
	add	x1, x1, :lo12:.LC76
	bl	fopen_nofollow
	cbz	x0, .L508
	bl	fclose
.L456:
	bl	geteuid
	cbz	w0, .L509
.L459:
	add	x19, x19, :lo12:.LC75
	mov	w1, 2
	mov	x0, x19
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L510
.L432:
	ldp	x29, x30, [sp]
	mov	x12, 5712
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L444:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x20, x0
	cbz	x0, .L443
	ldrb	w19, [x0]
	cbnz	w19, .L446
.L443:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L445
	ldr	x20, [x0]
	cbz	x20, .L445
	mov	x0, x20
	bl	valid_pkgname
	cbnz	w0, .L448
	ldrb	w1, [x20]
	cbz	w1, .L448
	str	x23, [sp, 48]
	b	.L463
	.p2align 2,,3
.L506:
	mov	x1, x21
	add	x0, x22, :lo12:.LC70
	bl	stat
	cbnz	w0, .L436
	ldr	w0, [sp, 1120]
	and	w0, w0, 61440
	cmp	w0, 16384
	bne	.L436
	b	.L438
	.p2align 2,,3
.L509:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x3, x0
	cbz	x0, .L460
	ldrb	w0, [x0]
	cbnz	w0, .L461
.L460:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L459
	ldr	x3, [x0]
	cbz	x3, .L459
.L461:
	add	x20, sp, 80
	add	x4, x19, :lo12:.LC75
	mov	x1, 1024
	mov	x0, x20
	adrp	x2, .LC57
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	add	x19, x19, :lo12:.LC75
	mov	x3, x20
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	mov	w1, 2
	mov	x0, x19
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbz	w1, .L432
	.p2align 5,,15
.L510:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC78
	add	x1, x1, :lo12:.LC78
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
.L511:
	ldp	x29, x30, [sp]
	mov	x12, 5712
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L446:
	bl	valid_pkgname
	cbnz	w0, .L448
	mov	w1, w19
	str	x23, [sp, 48]
.L463:
	str	w1, [sp, 76]
	bl	__ctype_b_loc
	ldr	x23, [x0]
	adrp	x22, .LC73
	ldr	w1, [sp, 76]
	mov	x19, x20
	add	x22, x22, :lo12:.LC73
	.p2align 5,,15
.L450:
	ubfiz	x2, x1, 1, 8
	mov	x0, x22
	ldrh	w2, [x23, x2]
	tbnz	x2, 3, .L449
	bl	strchr
	cbz	x0, .L505
.L449:
	ldrb	w1, [x19, 1]!
	cbnz	w1, .L450
	ldr	x23, [sp, 48]
.L448:
	bl	geteuid
	cmp	w0, 0
	add	x19, sp, 80
	adrp	x0, .LC47
	adrp	x3, .LC48
	add	x0, x0, :lo12:.LC47
	add	x3, x3, :lo12:.LC48
	csel	x3, x3, x0, ne
	mov	x4, x20
	mov	x0, x19
	mov	x1, 1024
	adrp	x5, .LC61
	adrp	x2, .LC74
	add	x5, x5, :lo12:.LC61
	add	x2, x2, :lo12:.LC74
	bl	xsnprintf
	mov	x3, x19
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	b	.L445
	.p2align 2,,3
.L507:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x2, .LC61
	adrp	x1, .LC72
	add	x2, x2, :lo12:.LC61
	add	x1, x1, :lo12:.LC72
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L511
	.p2align 2,,3
.L505:
	ldr	x23, [sp, 48]
	b	.L445
.L508:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC77
	add	x1, x1, :lo12:.LC77
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L511
	.section	.rodata.str1.8
	.align	3
.LC79:
	.string	"nano"
	.align	3
.LC80:
	.string	"EDITOR"
	.text
	.align	2
	.p2align 5,,15
	.global	get_editor
	.type	get_editor, %function
get_editor:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC80
	add	x0, x0, :lo12:.LC80
	mov	x29, sp
	bl	getenv
	cbz	x0, .L514
	ldrb	w2, [x0]
	adrp	x1, .LC79
	add	x1, x1, :lo12:.LC79
	cmp	w2, 0
	csel	x0, x1, x0, eq
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L514:
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC79
	add	x0, x0, :lo12:.LC79
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
.LC81:
	.string	" -pipe"
	.align	3
.LC82:
	.string	"-j%ld"
	.align	3
.LC83:
	.string	"-march=%s -O%s%s"
	.align	3
.LC84:
	.string	"KCFLAGS"
	.align	3
.LC85:
	.string	"KCPPFLAGS"
	.align	3
.LC86:
	.string	"MAKEFLAGS"
	.text
	.align	2
	.p2align 5,,15
	.global	set_build_env
	.type	set_build_env, %function
set_build_env:
	stp	x29, x30, [sp, -384]!
	adrp	x0, .LANCHOR0+16
	mov	x29, sp
	ldr	x3, [x0, #:lo12:.LANCHOR0+16]
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	cmp	x3, 0
	ble	.L523
.L519:
	adrp	x20, .LANCHOR1
	add	x20, x20, :lo12:.LANCHOR1
	add	x21, sp, 64
	mov	x1, 64
	mov	x0, x21
	adrp	x2, .LC82
	add	x2, x2, :lo12:.LC82
	bl	xsnprintf
	ldr	w5, [x20, 176]
	adrp	x4, .LC81
	add	x4, x4, :lo12:.LC81
	add	x22, sp, 48
	cmp	w5, 0
	adrp	x3, .LC47
	add	x3, x3, :lo12:.LC47
	mov	x0, x22
	csel	x3, x3, x4, eq
	mov	x1, 16
	adrp	x2, .LC41
	add	x2, x2, :lo12:.LC41
	bl	xsnprintf
	add	x19, sp, 128
	mov	x5, x22
	add	x4, x20, 160
	add	x3, x20, 32
	mov	x0, x19
	mov	x1, 256
	adrp	x2, .LC83
	add	x2, x2, :lo12:.LC83
	bl	xsnprintf
	mov	x1, x19
	mov	w2, 1
	adrp	x0, .LC84
	add	x0, x0, :lo12:.LC84
	bl	setenv
	mov	x1, x19
	mov	w2, 1
	adrp	x0, .LC85
	add	x0, x0, :lo12:.LC85
	bl	setenv
	mov	x1, x21
	mov	w2, 1
	adrp	x0, .LC86
	add	x0, x0, :lo12:.LC86
	bl	setenv
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 384
	ret
	.p2align 2,,3
.L523:
	mov	w0, 84
	bl	sysconf
	cmp	x0, 0
	csinc	x3, x0, xzr, gt
	b	.L519
	.section	.rodata.str1.8
	.align	3
.LC87:
	.string	"0"
	.align	3
.LC88:
	.string	"1"
	.align	3
.LC89:
	.string	"2"
	.align	3
.LC90:
	.string	"s"
	.align	3
.LC91:
	.string	"3"
	.align	3
.LC92:
	.string	"z"
	.align	3
.LC93:
	.string	"g"
	.align	3
.LC94:
	.string	"-C opt-level=%s -C target-cpu=%s"
	.align	3
.LC95:
	.string	"%s/makepkg.archtoo.conf"
	.align	3
.LC96:
	.string	"\033[1;31m[-] Cannot write %s\n\033[0m"
	.align	3
.LC97:
	.string	"# Generated by archtoo -- do not edit, it is rewritten every build.\n# target=%s opt=%s pipe=%d\nsource /etc/makepkg.conf\nCFLAGS=\"%s\"\nCXXFLAGS=\"%s\"\nLDFLAGS=\"${LDFLAGS}\"\nRUSTFLAGS=\"%s\"\nMAKEFLAGS=\"-j%ld\"\n"
	.text
	.align	2
	.p2align 5,,15
	.global	write_makepkg_conf
	.type	write_makepkg_conf, %function
write_makepkg_conf:
	sub	sp, sp, #928
	adrp	x2, .LC81
	adrp	x3, .LC47
	add	x2, x2, :lo12:.LC81
	add	x3, x3, :lo12:.LC47
	stp	x29, x30, [sp, 16]
	add	x29, sp, 16
	stp	x19, x20, [sp, 32]
	mov	x20, x0
	stp	x21, x22, [sp, 48]
	adrp	x22, .LANCHOR1
	add	x19, x22, :lo12:.LANCHOR1
	stp	x23, x24, [sp, 64]
	add	x21, sp, 128
	adrp	x24, .LC41
	stp	x25, x26, [sp, 80]
	add	x24, x24, :lo12:.LC41
	add	x23, sp, 144
	ldr	w4, [x19, 176]
	mov	x0, x21
	str	x27, [sp, 96]
	mov	x27, x1
	cmp	w4, 0
	mov	x1, 16
	csel	x3, x3, x2, eq
	mov	x2, x24
	adrp	x26, .LC83
	add	x26, x26, :lo12:.LC83
	bl	xsnprintf
	add	x25, sp, 416
	mov	x2, x24
	add	x3, x19, 160
	mov	x1, 16
	add	x19, x19, 32
	mov	x0, x23
	add	x24, sp, 160
	bl	xsnprintf
	mov	x3, x19
	mov	x5, x21
	mov	x4, x23
	mov	x2, x26
	mov	x1, 256
	mov	x0, x24
	bl	xsnprintf
	mov	x3, x19
	mov	x5, x21
	mov	x2, x26
	mov	x0, x25
	mov	x4, x23
	mov	x1, 256
	bl	xsnprintf
	ldrh	w0, [sp, 144]
	adrp	x3, .LC87
	add	x3, x3, :lo12:.LC87
	cmp	w0, 48
	beq	.L528
	adrp	x3, .LC88
	add	x3, x3, :lo12:.LC88
	cmp	w0, 49
	beq	.L528
	adrp	x3, .LC89
	add	x3, x3, :lo12:.LC89
	cmp	w0, 50
	beq	.L528
	cmp	w0, 115
	beq	.L550
	cmp	w0, 122
	beq	.L550
	cmp	w0, 103
	adrp	x3, .LC91
	adrp	x0, .LC88
	add	x3, x3, :lo12:.LC91
	add	x0, x0, :lo12:.LC88
	csel	x3, x3, x0, ne
	.p2align 5,,15
.L528:
	add	x26, x22, :lo12:.LANCHOR1
	add	x21, sp, 672
	add	x4, x26, 32
	mov	x1, 256
	mov	x0, x21
	adrp	x2, .LC94
	add	x2, x2, :lo12:.LC94
	bl	xsnprintf
	adrp	x3, .LC61
	adrp	x2, .LC95
	add	x3, x3, :lo12:.LC61
	add	x2, x2, :lo12:.LC95
	mov	x1, x27
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	bl	fopen_nofollow
	mov	x19, x0
	cbz	x0, .L551
	adrp	x0, .LANCHOR0+16
	ldr	w4, [x26, 176]
	ldr	x0, [x0, #:lo12:.LANCHOR0+16]
	cmp	x0, 0
	ble	.L552
.L541:
	add	x2, x22, :lo12:.LANCHOR1
	mov	x7, x21
	add	x2, x2, 32
	mov	x6, x25
	mov	x5, x24
	mov	x3, x23
	adrp	x1, .LC97
	add	x1, x1, :lo12:.LC97
	str	x0, [sp]
	mov	x0, x19
	bl	fprintf
	mov	x0, x19
	bl	fclose
	mov	x0, x20
	bl	fix_owner
	mov	w0, 1
.L524:
	ldr	x27, [sp, 96]
	ldp	x29, x30, [sp, 16]
	ldp	x19, x20, [sp, 32]
	ldp	x21, x22, [sp, 48]
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	add	sp, sp, 928
	ret
	.p2align 2,,3
.L552:
	mov	w0, 84
	str	w4, [sp, 124]
	bl	sysconf
	cmp	x0, 0
	ldr	w4, [sp, 124]
	csinc	x0, x0, xzr, gt
	b	.L541
	.p2align 2,,3
.L550:
	adrp	x3, .LC90
	add	x3, x3, :lo12:.LC90
	b	.L528
.L551:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC96
	add	x1, x1, :lo12:.LC96
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L524
	.section	.rodata.str1.8
	.align	3
.LC98:
	.string	"Y/n"
	.align	3
.LC99:
	.string	"yes"
	.align	3
.LC100:
	.string	"y/N"
	.align	3
.LC101:
	.string	"no"
	.align	3
.LC102:
	.string	"%s [%s]: %s (auto)\n"
	.align	3
.LC103:
	.string	"%s [%s]: "
	.align	3
.LC104:
	.string	"%s (default after %lds)\n"
	.text
	.align	2
	.p2align 5,,15
	.global	ask_yes_no
	.type	ask_yes_no, %function
ask_yes_no:
	stp	x29, x30, [sp, -112]!
	adrp	x2, .LANCHOR0
	mov	x29, sp
	ldr	w2, [x2, #:lo12:.LANCHOR0]
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	mov	w19, w1
	cbnz	w2, .L557
	str	x21, [sp, 32]
	adrp	x21, .LANCHOR1
	ldr	w0, [x21, #:lo12:.LANCHOR1]
	cbnz	w0, .L592
.L588:
	ldr	x21, [sp, 32]
.L557:
	cbnz	w19, .L555
	adrp	x2, .LC100
	adrp	x3, .LC101
	add	x2, x2, :lo12:.LC100
	add	x3, x3, :lo12:.LC101
.L556:
	adrp	x0, .LC102
	mov	x1, x20
	add	x0, x0, :lo12:.LC102
	bl	printf
.L559:
	mov	w0, w19
.L553:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 112
	ret
	.p2align 2,,3
.L555:
	adrp	x2, .LC98
	adrp	x3, .LC99
	add	x2, x2, :lo12:.LC98
	add	x3, x3, :lo12:.LC99
	b	.L556
	.p2align 2,,3
.L592:
	mov	w0, 0
	bl	isatty
	cbz	w0, .L588
	cmp	w19, 0
	adrp	x0, .LC98
	adrp	x2, .LC100
	add	x0, x0, :lo12:.LC98
	add	x2, x2, :lo12:.LC100
	mov	x1, x20
	csel	x2, x2, x0, eq
	adrp	x0, .LC103
	add	x0, x0, :lo12:.LC103
	bl	printf
	adrp	x0, :got:stdout;ldr	x0, [x0, :got_lo12:stdout]
	add	x21, x21, :lo12:.LANCHOR1
	add	x20, sp, 48
	ldr	x0, [x0]
	bl	fflush
	ldr	x2, [x21, 8]
	cmp	x2, 0
	ble	.L561
	mov	w0, 1000
	mov	x1, 50331
	movk	x1, 0x20, lsl 16
	cmp	x2, x1
	mov	x3, 4294967296
	mul	w2, w2, w0
	mov	w1, 64888
	add	x20, sp, 48
	movk	w1, 0x7fff, lsl 16
	mov	x0, x20
	csel	w2, w2, w1, le
	mov	x1, 1
	str	x3, [sp, 48]
	bl	poll
	cmp	w0, 0
	cbz	w0, .L593
	blt	.L594
.L561:
	adrp	x21, :got:stdin;ldr	x21, [x21, :got_lo12:stdin]
	mov	x0, x20
	mov	w1, 64
	ldr	x2, [x21]
	bl	fgets
	cbz	x0, .L590
	mov	x0, x20
	mov	w1, 10
	bl	strchr
	cbz	x0, .L569
.L568:
	ldrb	w0, [sp, 48]
	cmp	w0, 13
	bhi	.L570
	mov	x1, 9217
	lsr	x1, x1, x0
	tbz	x1, 0, .L570
.L590:
	ldr	x21, [sp, 32]
	b	.L559
	.p2align 2,,3
.L569:
	ldr	x0, [x21]
	bl	getc
	cmp	w0, 10
	ccmn	w0, #1, 4, ne
	beq	.L568
	ldr	x0, [x21]
	bl	getc
	cmp	w0, 10
	ccmn	w0, #1, 4, ne
	bne	.L569
	b	.L568
	.p2align 2,,3
.L570:
	and	w0, w0, -33
	cmp	w0, 89
	ldr	x21, [sp, 32]
	cset	w0, eq
	b	.L553
	.p2align 2,,3
.L593:
	ldr	x2, [x21, 8]
	cmp	w19, 0
	adrp	x0, .LC99
	adrp	x1, .LC101
	add	x0, x0, :lo12:.LC99
	add	x1, x1, :lo12:.LC101
	csel	x1, x1, x0, eq
	adrp	x0, .LC104
	add	x0, x0, :lo12:.LC104
	bl	printf
	ldr	x21, [sp, 32]
	b	.L559
	.p2align 2,,3
.L594:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L561
	ldr	x21, [sp, 32]
	b	.L559
	.align	2
	.p2align 5,,15
	.global	set_use_binary
	.type	set_use_binary, %function
set_use_binary:
	adrp	x1, .LANCHOR0+24
	cmp	w0, 0
	cset	w0, ne
	str	w0, [x1, #:lo12:.LANCHOR0+24]
	ret
	.align	2
	.p2align 5,,15
	.global	get_use_binary
	.type	get_use_binary, %function
get_use_binary:
	adrp	x0, .LANCHOR0+24
	ldr	w0, [x0, #:lo12:.LANCHOR0+24]
	ret
	.section	.rodata.str1.8
	.align	3
.LC105:
	.string	".."
	.text
	.align	2
	.p2align 5,,15
	.global	valid_gentoo_chroot_path
	.type	valid_gentoo_chroot_path, %function
valid_gentoo_chroot_path:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	cbz	x0, .L601
	stp	x19, x20, [sp, 16]
	mov	w22, 0
	mov	x19, x0
	ldrb	w21, [x0]
	cbz	w21, .L610
	bl	strlen
	sub	x0, x0, #1
	cmp	x0, 499
	mov	w20, 47
	ccmp	w21, w20, 0, ls
	beq	.L611
.L610:
	ldp	x19, x20, [sp, 16]
.L597:
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L611:
	bl	__ctype_b_loc
	ldr	x21, [x0]
	mov	w2, w20
	adrp	x20, .LC105
	add	x20, x20, :lo12:.LC105
	b	.L600
	.p2align 2,,3
.L613:
	ldrb	w2, [x19, 1]!
	cbz	w2, .L612
.L600:
	ubfiz	x3, x2, 1, 8
	sub	w0, w2, #45
	and	w4, w0, 255
	mov	x1, x20
	mov	x0, x19
	ldrh	w3, [x21, x3]
	tbnz	x3, 3, .L599
	cmp	w4, 2
	bls	.L599
	cmp	w2, 95
	bne	.L605
.L599:
	bl	strstr
	cbz	x0, .L613
.L605:
	ldp	x19, x20, [sp, 16]
	mov	w22, 0
	b	.L597
	.p2align 2,,3
.L601:
	mov	w22, 0
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L612:
	ldp	x19, x20, [sp, 16]
	mov	w22, 1
	b	.L597
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot
	.type	set_gentoo_chroot, %function
set_gentoo_chroot:
	adrp	x1, .LANCHOR0+28
	cmp	w0, 0
	cset	w0, ne
	str	w0, [x1, #:lo12:.LANCHOR0+28]
	ret
	.align	2
	.p2align 5,,15
	.global	get_gentoo_chroot
	.type	get_gentoo_chroot, %function
get_gentoo_chroot:
	adrp	x0, .LANCHOR0+28
	ldr	w0, [x0, #:lo12:.LANCHOR0+28]
	ret
	.align	2
	.p2align 5,,15
	.global	set_portage_imitation
	.type	set_portage_imitation, %function
set_portage_imitation:
	adrp	x1, .LANCHOR0+32
	cmp	w0, 0
	cset	w0, ne
	str	w0, [x1, #:lo12:.LANCHOR0+32]
	ret
	.align	2
	.p2align 5,,15
	.global	get_portage_imitation
	.type	get_portage_imitation, %function
get_portage_imitation:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldp	w1, w0, [x0, 28]
	orr	w0, w0, w1
	cmp	w0, 0
	cset	w0, ne
	ret
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot_path
	.type	set_gentoo_chroot_path, %function
set_gentoo_chroot_path:
	cbz	x0, .L627
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L630
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L630:
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
.L627:
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
	.align	3
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
