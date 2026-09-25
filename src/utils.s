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
	tbnz	w0, #31, .L130
	mov	w19, w0
	cbz	w0, .L140
	.p2align 5,,15
.L131:
	add	x1, sp, 40
	mov	w0, w19
	mov	w2, 0
	bl	waitpid
	tbz	w0, #31, .L141
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L131
.L130:
	ldp	x19, x20, [sp, 16]
	mov	w0, -1
	ldp	x29, x30, [sp], 192
	ret
	.p2align 2,,3
.L141:
	ldr	w0, [sp, 40]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L142
	cbnz	w2, .L130
	ldp	x19, x20, [sp, 16]
	ubfx	x0, x0, 8, 8
	ldp	x29, x30, [sp], 192
	ret
	.p2align 2,,3
.L142:
	ldp	x19, x20, [sp, 16]
	add	w0, w2, 128
	ldp	x29, x30, [sp], 192
	ret
.L140:
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
	cbz	x1, .L173
	stp	x29, x30, [sp, -240]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	mov	x26, x1
	str	xzr, [x1]
	cbz	x0, .L144
	mov	x19, x0
	add	x0, sp, 80
	bl	pipe
	cbnz	w0, .L144
	bl	fork
	mov	w25, w0
	tbnz	w0, #31, .L178
	cbz	w0, .L179
	ldr	w0, [sp, 84]
	bl	close
	mov	x0, 4096
	bl	malloc
	mov	x21, x0
	cbz	x0, .L177
	mov	x23, 1024
	mov	x0, 16776192
	add	x24, x23, x0
	mov	x20, 0
	mov	x19, 4096
	.p2align 5,,15
.L150:
	cmp	x23, x19
	bcc	.L151
	lsl	x19, x19, 1
	cmp	x19, x24
	bhi	.L176
.L152:
	mov	x1, x19
	mov	x0, x21
	bl	realloc
	cbz	x0, .L176
	mov	x21, x0
.L151:
	ldr	w0, [sp, 80]
	add	x22, x21, x20
	sub	x2, x19, x20
	mov	x1, x22
	sub	x2, x2, #1
	bl	read
	tbnz	x0, #63, .L180
	cbz	x0, .L155
	add	x20, x20, x0
	add	x23, x20, 1024
	cmp	x23, x19
	bcc	.L151
	lsl	x19, x19, 1
	cmp	x19, x24
	bls	.L152
.L176:
	mov	x0, x21
	bl	free
.L177:
	ldr	w0, [sp, 80]
	bl	close
	mov	w0, w25
	mov	w2, 0
	mov	x1, 0
	bl	waitpid
.L144:
	mov	w0, -1
.L143:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 240
	ret
	.p2align 2,,3
.L179:
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
	tbnz	w0, #31, .L181
	ldr	w0, [sp, 84]
	bl	close
	mov	w1, 1
	adrp	x0, .LC38
	add	x0, x0, :lo12:.LC38
	bl	open
	mov	w20, w0
	tbz	w0, #31, .L182
.L149:
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
.L180:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L150
	b	.L176
	.p2align 2,,3
.L173:
	mov	w0, -1
	ret
	.p2align 2,,3
.L182:
	mov	w1, 2
	bl	dup2
	mov	w0, w20
	bl	close
	b	.L149
	.p2align 2,,3
.L181:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L155:
	ldr	w0, [sp, 80]
	bl	close
	strb	wzr, [x22]
	b	.L156
	.p2align 2,,3
.L157:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L183
.L156:
	add	x1, sp, 88
	mov	w0, w25
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L157
	ldr	w0, [sp, 88]
	str	x21, [x26]
	and	w2, w0, 127
	add	w1, w2, 1
	sbfx	x1, x1, 1, 7
	cmp	w1, 0
	bgt	.L184
	cbnz	w2, .L144
	ubfx	x0, x0, 8, 8
	b	.L143
.L183:
	mov	x0, x21
	bl	free
	b	.L144
.L184:
	add	w0, w2, 128
	b	.L143
.L178:
	ldr	w0, [sp, 80]
	bl	close
	ldr	w0, [sp, 84]
	bl	close
	b	.L144
	.align	2
	.p2align 5,,15
	.global	shell_quote
	.type	shell_quote, %function
shell_quote:
	cmp	x1, 0
	ccmp	x2, 2, 0, ne
	ccmp	x0, 0, 4, hi
	bne	.L186
.L190:
	mov	w0, 0
	ret
	.p2align 2,,3
.L186:
	mov	w3, 39
	strb	w3, [x1]
	mov	x3, 1
	ldrb	w4, [x0]
	cbz	w4, .L193
	mov	w6, 92
	b	.L192
	.p2align 2,,3
.L189:
	add	x5, x3, 1
	cmp	x5, x2
	bcs	.L190
	strb	w4, [x1, x3]
	mov	x3, x5
	ldrb	w4, [x0, 1]!
	cbz	w4, .L195
.L192:
	cmp	w4, 39
	bne	.L189
	add	x5, x3, 4
	cmp	x5, x2
	bcs	.L190
	strb	w4, [x1, x3]
	add	x3, x1, x3
	strb	w6, [x3, 1]
	strb	w4, [x3, 2]
	strb	w4, [x3, 3]
	mov	x3, x5
	ldrb	w4, [x0, 1]!
	cbnz	w4, .L192
.L195:
	add	x0, x3, 1
	cmp	x0, x2
	bcs	.L190
.L188:
	mov	w2, 39
	strb	w2, [x1, x3]
	strb	wzr, [x1, x0]
	mov	w0, 1
	ret
.L193:
	mov	x0, 2
	b	.L188
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
	cbz	x0, .L213
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L199
	str	w1, [sp, 60]
	bl	strlen
	cmp	x0, 128
	bhi	.L199
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x20, [x0]
	adrp	x21, .LC39
	ldr	w1, [sp, 60]
	add	x21, x21, :lo12:.LC39
	.p2align 5,,15
.L201:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x20, x0]
	tbnz	x0, 3, .L200
	mov	x0, x21
	bl	strchr
	cbz	x0, .L212
.L200:
	ldrb	w1, [x19, 1]!
	cbnz	w1, .L201
	ldr	x21, [sp, 32]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L212:
	ldr	x21, [sp, 32]
.L199:
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L213:
	mov	w0, 0
	ret
	.align	2
	.p2align 5,,15
	.global	dep_basename
	.type	dep_basename, %function
dep_basename:
	cmp	x1, 0
	ccmp	x2, 0, 4, ne
	beq	.L214
	cbz	x0, .L216
	ldrb	w3, [x0]
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	bne	.L218
	.p2align 5,,15
.L217:
	ldrb	w3, [x0, 1]!
	cmp	w3, 32
	ccmp	w3, 9, 4, ne
	beq	.L217
.L218:
	mov	x8, 512
	mov	x5, x1
	movk	x8, 0x1, lsl 32
	mov	x6, x1
	mov	x4, 0
	movk	x8, 0x7400, lsl 48
	cbnz	w3, .L223
	b	.L220
	.p2align 2,,3
.L224:
	cmp	w3, 62
	bhi	.L221
	lsr	x7, x8, x3
	tbnz	x7, 0, .L220
.L221:
	strb	w3, [x5], 1
	ldrb	w3, [x0, x4]
	cbz	w3, .L229
.L223:
	add	x4, x4, 1
	mov	x6, x5
	cmp	x4, x2
	bcc	.L224
.L220:
	strb	wzr, [x6]
.L214:
	ret
	.p2align 2,,3
.L229:
	add	x6, x1, x4
	strb	wzr, [x6]
	b	.L214
	.p2align 2,,3
.L216:
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
	bcs	.L233
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 272
	ret
.L233:
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
	cbz	x0, .L249
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_target_arch
	cbz	w0, .L234
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L234
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbnz	w0, .L252
.L234:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L249:
	ret
	.p2align 2,,3
.L252:
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
	cbz	x0, .L306
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_opt_level
	cbz	w0, .L253
	adrp	x1, .LC0
	mov	x0, x19
	add	x1, x1, :lo12:.LC0
	bl	strcmp
	cbz	w0, .L253
	adrp	x1, .LC1
	mov	x0, x19
	add	x1, x1, :lo12:.LC1
	bl	strcmp
	cbz	w0, .L253
	ldrb	w0, [x19]
	cmp	w0, 45
	beq	.L309
.L255:
	and	w0, w0, -33
	and	w0, w0, 255
	cmp	w0, 79
	cinc	x19, x19, eq
	ldrb	w0, [x19]
	cmp	w0, 48
	beq	.L310
.L265:
	cmp	w0, 49
	bne	.L266
	ldrb	w1, [x19, 1]
	cbnz	w1, .L266
.L258:
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
.L266:
	cmp	w0, 50
	bne	.L267
	ldrb	w1, [x19, 1]
	cbz	w1, .L258
	.p2align 5,,15
.L267:
	cmp	w0, 51
	bne	.L268
	ldrb	w1, [x19, 1]
	cbz	w1, .L258
	.p2align 5,,15
.L268:
	cmp	w0, 115
	bne	.L269
	ldrb	w1, [x19, 1]
	cbz	w1, .L258
.L269:
	cmp	w0, 103
	bne	.L270
	ldrb	w1, [x19, 1]
	cbz	w1, .L258
.L270:
	cmp	w0, 122
	bne	.L271
	ldrb	w0, [x19, 1]
	cbz	w0, .L258
.L271:
	adrp	x1, .LC21
	mov	x0, x19
	add	x1, x1, :lo12:.LC21
	bl	strcmp
	cbz	w0, .L258
.L253:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L310:
	ldrb	w1, [x19, 1]
	cbz	w1, .L258
	b	.L265
	.p2align 2,,3
.L309:
	ldrb	w0, [x19, 1]
	add	x19, x19, 1
	b	.L255
	.p2align 2,,3
.L306:
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
	mov	x12, 4624
	sub	sp, sp, x12
	mov	x3, x0
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
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
	beq	.L318
	cmp	w1, 119
	beq	.L319
	cmp	w1, 97
	beq	.L320
	bl	__errno_location
	mov	w1, 22
	str	w1, [x0]
.L316:
	mov	x1, 0
.L313:
	mov	x0, x1
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L319:
	mov	w1, 33345
.L314:
	mov	w2, 420
	str	x3, [sp, 24]
	bl	open
	tbnz	w0, #31, .L316
	ldr	x1, [sp, 24]
	str	w0, [sp, 24]
	bl	fdopen
	mov	x1, x0
	cbnz	x0, .L313
	ldr	w0, [sp, 24]
	str	x1, [sp, 24]
	bl	close
	ldr	x1, [sp, 24]
	b	.L313
	.p2align 2,,3
.L320:
	mov	w1, 33857
	b	.L314
	.p2align 2,,3
.L318:
	mov	w1, 32768
	b	.L314
	.align	2
	.p2align 5,,15
	.global	file_exists
	.type	file_exists, %function
file_exists:
	stp	x29, x30, [sp, -144]!
	mov	x29, sp
	add	x1, sp, 16
	bl	stat
	cbnz	w0, .L324
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 32768
	cset	w0, eq
	ret
	.p2align 2,,3
.L324:
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
	cbnz	w0, .L328
	ldr	w0, [sp, 32]
	ldp	x29, x30, [sp], 144
	and	w0, w0, 61440
	cmp	w0, 16384
	cset	w0, eq
	ret
	.p2align 2,,3
.L328:
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
	cbz	x0, .L347
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L333
	sub	w2, w1, #45
	and	w2, w2, 255
	cmp	w2, 1
	bls	.L333
	str	w1, [sp, 60]
	bl	strlen
	cmp	x0, 128
	bhi	.L333
	stp	x21, x22, [sp, 32]
	bl	__ctype_b_loc
	adrp	x22, .LC43
	ldr	x21, [x0]
	add	x22, x22, :lo12:.LC43
	ldr	w1, [sp, 60]
	mov	w20, 2560
	b	.L335
	.p2align 2,,3
.L334:
	ldrb	w1, [x19, 1]!
	cbz	w1, .L348
.L335:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x21, x0]
	tst	w20, w0
	bne	.L334
	mov	x0, x22
	bl	strchr
	cbnz	x0, .L334
	ldp	x21, x22, [sp, 32]
.L333:
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L348:
	ldp	x21, x22, [sp, 32]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L347:
	mov	w0, 0
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
	mov	x22, x2
	stp	x23, x24, [sp, 48]
	mov	x24, x1
	ldrb	w1, [x0]
	cbz	w1, .L356
	adrp	x21, .LC44
	mov	x20, x0
	add	x21, x21, :lo12:.LC44
	mov	x19, 0
	mov	w23, 92
	b	.L355
	.p2align 2,,3
.L360:
	add	x0, x19, 2
	cmp	x0, x22
	bcs	.L352
	add	x2, x19, 1
	strb	w23, [x24, x19]
	mov	x19, x0
	ldrb	w0, [x20]
	strb	w0, [x24, x2]
	ldrb	w1, [x20, 1]!
	cbz	w1, .L350
.L355:
	mov	x0, x21
	bl	strchr
	cbnz	x0, .L360
	add	x0, x19, 1
	cmp	x0, x22
	bcs	.L352
	mov	x2, x19
	mov	x19, x0
	ldrb	w0, [x20]
	strb	w0, [x24, x2]
	ldrb	w1, [x20, 1]!
	cbnz	w1, .L355
.L350:
	cmp	x22, x19
	bls	.L352
	strb	wzr, [x24, x19]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L352:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 64
	ret
.L356:
	mov	x19, 0
	b	.L350
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
	cbz	x0, .L362
	ldrb	w1, [x0]
	cbnz	w1, .L361
.L362:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L361
	ldr	x0, [x0]
.L361:
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
	sub	sp, sp, #1488
	mov	x2, 512
	add	x1, sp, 16
	add	x0, sp, 528
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	config_load
	cbz	w0, .L375
	add	x0, sp, 528
	bl	config_apply
	ldp	x29, x30, [sp]
	add	sp, sp, 1488
	ret
	.p2align 2,,3
.L375:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 16
	adrp	x1, .LC46
	add	x1, x1, :lo12:.LC46
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	add	sp, sp, 1488
	ret
	.section	.rodata.str1.8
	.align	3
.LC47:
	.string	"sudo "
	.align	3
.LC48:
	.string	""
	.text
	.align	2
	.p2align 5,,15
	.global	priv_prefix
	.type	priv_prefix, %function
priv_prefix:
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	bl	geteuid
	cbnz	w0, .L378
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	ret
	.p2align 2,,3
.L378:
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC47
	add	x0, x0, :lo12:.LC47
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
	mov	x12, 5136
	sub	sp, sp, x12
	mov	x3, x0
	mov	x1, 512
	add	x0, sp, 16
	adrp	x2, .LC49
	stp	x29, x30, [sp]
	add	x2, x2, :lo12:.LC49
	mov	x29, sp
	bl	xsnprintf
	add	x3, sp, 16
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
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
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	w20, 1
	stp	x21, x22, [sp, 32]
	mov	w21, w0
	mov	x22, x1
	bl	geteuid
	cbnz	w0, .L391
.L382:
	ldp	x21, x22, [sp, 32]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L391:
	adrp	x0, .LC50
	add	x19, x0, :lo12:.LC50
	mov	x0, x19
	bl	have_cmd
	mov	w20, w0
	cbz	w0, .L392
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	bl	run_cmd
	mov	w20, w0
	cbnz	w0, .L393
	sxtw	x0, w21
	mov	x1, 8
	str	x23, [sp, 48]
	mov	x23, x0
	add	x0, x0, 3
	bl	calloc
	mov	x3, x0
	cbz	x0, .L394
	ldrb	w0, [x19, 4]
	add	x1, sp, 88
	strb	w0, [sp, 92]
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
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
	ble	.L388
	ubfiz	x2, x0, 3, 32
	mov	x1, x22
	add	x0, x3, 16
	str	x3, [sp, 72]
	bl	memcpy
	ldr	x3, [sp, 72]
.L388:
	add	x0, x23, 2
	mov	x1, x3
	str	x3, [sp, 72]
	str	xzr, [x3, x0, lsl 3]
	adrp	x0, .LC50
	add	x0, x0, :lo12:.LC50
	bl	execvp
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x19, [x0]
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x2, x0
	adrp	x1, .LC56
	mov	x0, x19
	add	x1, x1, :lo12:.LC56
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
.L392:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 33
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	bl	fwrite
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L393:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 54
	mov	x1, 1
	mov	w20, 0
	ldr	x3, [x0]
	adrp	x0, .LC53
	add	x0, x0, :lo12:.LC53
	bl	fwrite
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
.L394:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 30
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	fwrite
	ldr	x23, [sp, 48]
	b	.L382
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
	str	x19, [sp, 16]
	mov	x19, x0
	bl	geteuid
	cbz	w0, .L409
.L395:
	ldr	x19, [sp, 16]
	mov	x12, 5664
	ldp	x29, x30, [sp]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L409:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x3, x0
	cbz	x0, .L397
	ldrb	w0, [x0]
	cbnz	w0, .L398
.L397:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L395
	ldr	x3, [x0]
	cbz	x3, .L395
.L398:
	mov	x4, x19
	add	x0, sp, 32
	mov	x1, 1024
	adrp	x2, .LC57
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	add	x3, sp, 32
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
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
	cbz	w0, .L411
	cbz	x21, .L412
	ldrb	w0, [x21]
	cbnz	w0, .L413
.L412:
	ldp	x29, x30, [sp]
	mov	x0, x28
	ldp	x19, x20, [sp, 16]
	mov	x12, 4800
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, x12
	b	run_cmd
	.p2align 2,,3
.L411:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	stp	x25, x26, [sp, 64]
	bl	getenv
	mov	x26, x0
	cbz	x0, .L415
	ldrb	w0, [x0]
	cbnz	w0, .L416
.L415:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L417
	ldr	x26, [x0]
	cbz	x26, .L417
.L416:
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC60
	add	x23, x23, :lo12:.LC60
	mov	w22, 16
	adrp	x24, .LC61
	adrp	x25, .LC62
	.p2align 5,,15
.L418:
	bl	getpid
	sxtw	x20, w0
	mov	w1, 524288
	mov	x0, x23
	bl	open
	mov	w19, w0
	tbnz	w0, #31, .L420
	add	x1, sp, 96
	mov	x2, 4
	bl	read
	mov	x27, x0
	mov	w0, w19
	bl	close
	cmp	x27, 4
	beq	.L442
.L420:
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
.L421:
	mov	x4, x20
	add	x3, x24, :lo12:.LC61
	add	x2, x25, :lo12:.LC62
	mov	x1, 600
	add	x0, sp, 104
	bl	xsnprintf
	add	x0, sp, 104
	mov	w2, 448
	mov	w1, 32961
	bl	open
	mov	w19, w0
	tbnz	w0, #31, .L443
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	bl	fdopen
	mov	x20, x0
	cbz	x0, .L444
	cbz	x21, .L445
.L425:
	mov	x3, x28
	mov	x2, x21
	adrp	x1, .LC66
	add	x1, x1, :lo12:.LC66
	mov	x0, x20
	bl	fprintf
	mov	x0, x20
	bl	fclose
	cbnz	w0, .L446
	mov	w1, 493
	add	x0, sp, 104
	bl	chmod
	add	x0, sp, 104
	bl	fix_owner
	mov	x3, x26
	add	x4, sp, 104
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
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
.L410:
	mov	w0, w19
	ldp	x29, x30, [sp]
	mov	x12, 4800
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L443:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 17
	bne	.L423
	subs	w22, w22, #1
	bne	.L418
.L423:
	adrp	x1, :got:stderr
	ldr	x1, [x1, :got_lo12:stderr]
	ldr	x19, [x1]
	bl	strerror
	add	x2, x24, :lo12:.LC61
	mov	x3, x0
	adrp	x1, .LC63
	mov	x0, x19
	add	x1, x1, :lo12:.LC63
	bl	fprintf
	ldp	x23, x24, [sp, 48]
.L419:
	mov	w19, -1
	ldp	x25, x26, [sp, 64]
	b	.L410
	.p2align 2,,3
.L442:
	ldr	w5, [sp, 96]
	rev	w5, w5
	b	.L421
	.p2align 2,,3
.L413:
	mov	x4, x28
	mov	x3, x21
	adrp	x2, .LC58
	add	x2, x2, :lo12:.LC58
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
.L445:
	adrp	x21, .LC48
	add	x21, x21, :lo12:.LC48
	b	.L425
.L446:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 104
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	ldr	x0, [x0]
	bl	fprintf
	add	x0, sp, 104
	bl	unlink
	ldp	x23, x24, [sp, 48]
	b	.L419
.L417:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 96
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC59
	add	x0, x0, :lo12:.LC59
	bl	fwrite
	b	.L419
.L444:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 104
	adrp	x1, .LC65
	add	x1, x1, :lo12:.LC65
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, w19
	bl	close
	add	x0, sp, 104
	bl	unlink
	ldp	x23, x24, [sp, 48]
	b	.L419
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
	mov	x12, 5696
	sub	sp, sp, x12
	add	x1, sp, 1088
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	adrp	x19, .LC69
	adrp	x20, .LC70
	add	x0, x19, :lo12:.LC69
	bl	stat
	cbnz	w0, .L451
	ldr	w0, [sp, 1104]
	adrp	x20, .LC70
	and	w0, w0, 61440
	cmp	w0, 16384
	beq	.L520
.L451:
	bl	geteuid
	cbz	w0, .L521
.L479:
	adrp	x3, .LC47
	add	x3, x3, :lo12:.LC47
.L454:
	add	x5, x20, :lo12:.LC70
	add	x4, x19, :lo12:.LC69
	adrp	x2, .LC71
	add	x2, x2, :lo12:.LC71
	mov	x1, 1024
	add	x0, sp, 64
	bl	xsnprintf
	add	x0, sp, 64
	bl	run_cmd
	cbnz	w0, .L522
.L453:
	bl	geteuid
	cbz	w0, .L459
	adrp	x0, .LC61
	mov	w1, 2
	add	x0, x0, :lo12:.LC61
	bl	access
	cbz	w0, .L460
.L459:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x19, x0
	cbz	x0, .L458
	ldrb	w20, [x0]
	cbnz	w20, .L461
.L458:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L460
	ldr	x19, [x0]
	cbnz	x19, .L523
.L460:
	adrp	x19, .LC75
	add	x1, sp, 1088
	add	x0, x19, :lo12:.LC75
	bl	stat
	cbnz	w0, .L468
	ldr	w0, [sp, 1104]
	and	w0, w0, 61440
	cmp	w0, 32768
	beq	.L472
.L468:
	adrp	x1, .LC76
	add	x0, x19, :lo12:.LC75
	add	x1, x1, :lo12:.LC76
	bl	fopen_nofollow
	cbz	x0, .L524
	bl	fclose
.L472:
	bl	geteuid
	cbz	w0, .L525
.L474:
	mov	w1, 2
	add	x0, x19, :lo12:.LC75
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L526
.L447:
	ldp	x29, x30, [sp]
	mov	x12, 5696
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L520:
	add	x1, sp, 1088
	add	x0, x20, :lo12:.LC70
	bl	stat
	cbnz	w0, .L451
	ldr	w0, [sp, 1104]
	and	w0, w0, 61440
	cmp	w0, 16384
	beq	.L453
	bl	geteuid
	cbnz	w0, .L479
.L521:
	adrp	x3, .LC48
	add	x3, x3, :lo12:.LC48
	b	.L454
	.p2align 2,,3
.L525:
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	getenv
	mov	x3, x0
	cbz	x0, .L475
	ldrb	w0, [x0]
	cbnz	w0, .L476
.L475:
	bl	getuid
	bl	getpwuid
	cbz	x0, .L474
	ldr	x3, [x0]
	cbz	x3, .L474
.L476:
	add	x4, x19, :lo12:.LC75
	mov	x1, 1024
	add	x0, sp, 64
	adrp	x2, .LC57
	add	x2, x2, :lo12:.LC57
	bl	xsnprintf
	add	x3, sp, 64
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	add	x0, sp, 1088
	bl	xsnprintf
	add	x0, sp, 1088
	bl	run_cmd
	mov	w1, 2
	add	x0, x19, :lo12:.LC75
	bl	access
	mov	w1, w0
	mov	w0, 1
	cbz	w1, .L447
	.p2align 5,,15
.L526:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, x19, :lo12:.LC75
	adrp	x1, .LC78
	add	x1, x1, :lo12:.LC78
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
.L527:
	ldp	x29, x30, [sp]
	mov	x12, 5696
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L461:
	bl	valid_pkgname
	cbnz	w0, .L463
	mov	w1, w20
	stp	x21, x22, [sp, 32]
.L477:
	adrp	x22, .LC73
	str	w1, [sp, 60]
	bl	__ctype_b_loc
	ldr	x21, [x0]
	mov	x20, x19
	ldr	w1, [sp, 60]
	add	x22, x22, :lo12:.LC73
	.p2align 5,,15
.L466:
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x21, x0]
	tbnz	x0, 3, .L465
	mov	x0, x22
	bl	strchr
	cbz	x0, .L519
.L465:
	ldrb	w1, [x20, 1]!
	cbnz	w1, .L466
	ldp	x21, x22, [sp, 32]
.L463:
	bl	geteuid
	cbnz	w0, .L480
	adrp	x3, .LC48
	add	x3, x3, :lo12:.LC48
.L467:
	mov	x4, x19
	add	x0, sp, 64
	mov	x1, 1024
	adrp	x5, .LC61
	adrp	x2, .LC74
	add	x5, x5, :lo12:.LC61
	add	x2, x2, :lo12:.LC74
	bl	xsnprintf
	add	x3, sp, 64
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	mov	x1, 4608
	add	x0, sp, 1088
	bl	xsnprintf
	add	x0, sp, 1088
	bl	run_cmd
	b	.L460
	.p2align 2,,3
.L523:
	mov	x0, x19
	bl	valid_pkgname
	cbnz	w0, .L463
	ldrb	w1, [x19]
	cbz	w1, .L463
	stp	x21, x22, [sp, 32]
	b	.L477
	.p2align 2,,3
.L522:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x2, .LC61
	adrp	x1, .LC72
	add	x2, x2, :lo12:.LC61
	add	x1, x1, :lo12:.LC72
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L527
	.p2align 2,,3
.L480:
	adrp	x3, .LC47
	add	x3, x3, :lo12:.LC47
	b	.L467
	.p2align 2,,3
.L519:
	ldp	x21, x22, [sp, 32]
	b	.L460
.L524:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, x19, :lo12:.LC75
	adrp	x1, .LC77
	add	x1, x1, :lo12:.LC77
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L527
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
	cbz	x0, .L530
	ldrb	w1, [x0]
	cbz	w1, .L530
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L530:
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
	stp	x29, x30, [sp, -368]!
	adrp	x0, .LANCHOR0+16
	mov	x29, sp
	ldr	x3, [x0, #:lo12:.LANCHOR0+16]
	str	x19, [sp, 16]
	cmp	x3, 0
	ble	.L539
.L535:
	add	x0, sp, 48
	adrp	x2, .LC82
	mov	x1, 64
	add	x2, x2, :lo12:.LC82
	bl	xsnprintf
	adrp	x19, .LANCHOR1
	add	x0, x19, :lo12:.LANCHOR1
	ldr	w0, [x0, 176]
	cbz	w0, .L537
	adrp	x3, .LC81
	add	x3, x3, :lo12:.LC81
.L536:
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
	adrp	x2, .LC83
	add	x2, x2, :lo12:.LC83
	bl	xsnprintf
	add	x1, sp, 112
	mov	w2, 1
	adrp	x0, .LC84
	add	x0, x0, :lo12:.LC84
	bl	setenv
	add	x1, sp, 112
	mov	w2, 1
	adrp	x0, .LC85
	add	x0, x0, :lo12:.LC85
	bl	setenv
	add	x1, sp, 48
	mov	w2, 1
	adrp	x0, .LC86
	add	x0, x0, :lo12:.LC86
	bl	setenv
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 368
	ret
	.p2align 2,,3
.L537:
	adrp	x3, .LC48
	add	x3, x3, :lo12:.LC48
	b	.L536
	.p2align 2,,3
.L539:
	mov	w0, 84
	bl	sysconf
	cmp	x0, 0
	csinc	x3, x0, xzr, gt
	b	.L535
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
	sub	sp, sp, #896
	stp	x29, x30, [sp, 16]
	add	x29, sp, 16
	stp	x19, x20, [sp, 32]
	adrp	x20, .LANCHOR1
	stp	x21, x22, [sp, 48]
	mov	x21, x0
	add	x0, x20, :lo12:.LANCHOR1
	mov	x22, x1
	ldr	w0, [x0, 176]
	str	x23, [sp, 64]
	cbz	w0, .L560
	adrp	x3, .LC81
	add	x3, x3, :lo12:.LC81
.L541:
	adrp	x2, .LC41
	add	x19, x2, :lo12:.LC41
	mov	x2, x19
	add	x23, x20, :lo12:.LANCHOR1
	mov	x1, 16
	add	x0, sp, 96
	bl	xsnprintf
	mov	x2, x19
	add	x3, x23, 160
	mov	x1, 16
	add	x0, sp, 112
	bl	xsnprintf
	adrp	x19, .LC83
	add	x5, sp, 96
	add	x4, sp, 112
	add	x3, x23, 32
	add	x2, x19, :lo12:.LC83
	mov	x1, 256
	add	x0, sp, 128
	bl	xsnprintf
	add	x3, x23, 32
	add	x5, sp, 96
	add	x4, sp, 112
	add	x2, x19, :lo12:.LC83
	add	x0, sp, 384
	mov	x1, 256
	bl	xsnprintf
	ldrh	w0, [sp, 112]
	adrp	x3, .LC87
	add	x3, x3, :lo12:.LC87
	cmp	w0, 48
	beq	.L544
	cmp	w0, 49
	beq	.L567
	adrp	x3, .LC89
	add	x3, x3, :lo12:.LC89
	cmp	w0, 50
	beq	.L544
	cmp	w0, 115
	beq	.L554
	cmp	w0, 122
	beq	.L554
	adrp	x3, .LC91
	add	x3, x3, :lo12:.LC91
	cmp	w0, 103
	beq	.L567
	.p2align 5,,15
.L544:
	add	x23, x20, :lo12:.LANCHOR1
	mov	x1, 256
	add	x4, x23, 32
	add	x0, sp, 640
	adrp	x2, .LC94
	add	x2, x2, :lo12:.LC94
	bl	xsnprintf
	adrp	x3, .LC61
	adrp	x2, .LC95
	add	x3, x3, :lo12:.LC61
	add	x2, x2, :lo12:.LC95
	mov	x1, x22
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	bl	fopen_nofollow
	mov	x19, x0
	cbz	x0, .L568
	adrp	x0, .LANCHOR0+16
	ldr	w4, [x23, 176]
	ldr	x0, [x0, #:lo12:.LANCHOR0+16]
	cmp	x0, 0
	ble	.L569
.L559:
	add	x2, x20, :lo12:.LANCHOR1
	add	x7, sp, 640
	add	x6, sp, 384
	add	x5, sp, 128
	add	x3, sp, 112
	add	x2, x2, 32
	adrp	x1, .LC97
	add	x1, x1, :lo12:.LC97
	str	x0, [sp]
	mov	x0, x19
	bl	fprintf
	mov	x0, x19
	bl	fclose
	mov	x0, x21
	bl	fix_owner
	mov	w0, 1
.L540:
	ldr	x23, [sp, 64]
	ldp	x29, x30, [sp, 16]
	ldp	x19, x20, [sp, 32]
	ldp	x21, x22, [sp, 48]
	add	sp, sp, 896
	ret
	.p2align 2,,3
.L560:
	adrp	x3, .LC48
	add	x3, x3, :lo12:.LC48
	b	.L541
	.p2align 2,,3
.L567:
	adrp	x3, .LC88
	add	x3, x3, :lo12:.LC88
	b	.L544
	.p2align 2,,3
.L569:
	mov	w0, 84
	str	w4, [sp, 92]
	bl	sysconf
	cmp	x0, 0
	ldr	w4, [sp, 92]
	csinc	x0, x0, xzr, gt
	b	.L559
	.p2align 2,,3
.L554:
	adrp	x3, .LC90
	add	x3, x3, :lo12:.LC90
	b	.L544
.L568:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC96
	add	x1, x1, :lo12:.LC96
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L540
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
	stp	x29, x30, [sp, -128]!
	mov	x4, x0
	adrp	x0, .LANCHOR0
	mov	x29, sp
	ldr	w0, [x0, #:lo12:.LANCHOR0]
	stp	x19, x20, [sp, 16]
	mov	w19, w1
	cbnz	w0, .L574
	adrp	x20, .LANCHOR1
	ldr	w0, [x20, #:lo12:.LANCHOR1]
	cbnz	w0, .L610
.L574:
	cbnz	w19, .L572
	adrp	x2, .LC100
	adrp	x3, .LC101
	add	x2, x2, :lo12:.LC100
	add	x3, x3, :lo12:.LC101
.L573:
	adrp	x0, .LC102
	mov	x1, x4
	add	x0, x0, :lo12:.LC102
	bl	printf
.L576:
	mov	w0, w19
.L570:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 128
	ret
	.p2align 2,,3
.L572:
	adrp	x2, .LC98
	adrp	x3, .LC99
	add	x2, x2, :lo12:.LC98
	add	x3, x3, :lo12:.LC99
	b	.L573
	.p2align 2,,3
.L610:
	mov	w0, 0
	str	x4, [sp, 56]
	bl	isatty
	ldr	x4, [sp, 56]
	cbz	w0, .L574
	str	x21, [sp, 32]
	cbnz	w19, .L611
	adrp	x2, .LC100
	add	x2, x2, :lo12:.LC100
.L577:
	mov	x1, x4
	adrp	x0, .LC103
	add	x0, x0, :lo12:.LC103
	bl	printf
	adrp	x0, :got:stdout
	ldr	x0, [x0, :got_lo12:stdout]
	add	x21, sp, 64
	ldr	x0, [x0]
	bl	fflush
	add	x0, x20, :lo12:.LANCHOR1
	ldr	x0, [x0, 8]
	cmp	x0, 0
	ble	.L578
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
	cbz	w0, .L612
	tbnz	w0, #31, .L613
.L578:
	adrp	x20, :got:stdin
	ldr	x20, [x20, :got_lo12:stdin]
	mov	x0, x21
	mov	w1, 64
	ldr	x2, [x20]
	bl	fgets
	cbz	x0, .L609
	mov	x0, x21
	mov	w1, 10
	bl	strchr
	cbz	x0, .L586
.L585:
	ldrb	w0, [sp, 64]
	cmp	w0, 13
	bhi	.L587
	mov	x1, 9217
	lsr	x1, x1, x0
	tbz	x1, 0, .L587
.L609:
	ldr	x21, [sp, 32]
	b	.L576
	.p2align 2,,3
.L614:
	cmn	w0, #1
	beq	.L585
.L586:
	ldr	x0, [x20]
	bl	getc
	cmp	w0, 10
	bne	.L614
	b	.L585
	.p2align 2,,3
.L611:
	adrp	x2, .LC98
	add	x2, x2, :lo12:.LC98
	b	.L577
	.p2align 2,,3
.L587:
	and	w0, w0, -33
	cmp	w0, 89
	ldr	x21, [sp, 32]
	cset	w0, eq
	b	.L570
	.p2align 2,,3
.L612:
	cbnz	w19, .L615
	adrp	x1, .LC101
	add	x1, x1, :lo12:.LC101
.L581:
	add	x20, x20, :lo12:.LANCHOR1
	adrp	x0, .LC104
	add	x0, x0, :lo12:.LC104
	ldr	x2, [x20, 8]
	bl	printf
	ldr	x21, [sp, 32]
	b	.L576
	.p2align 2,,3
.L615:
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	b	.L581
	.p2align 2,,3
.L613:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	beq	.L578
	ldr	x21, [sp, 32]
	b	.L576
	.align	2
	.p2align 5,,15
	.global	set_use_binary
	.type	set_use_binary, %function
set_use_binary:
	cmp	w0, 0
	adrp	x0, .LANCHOR0+24
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+24]
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
	cbz	x0, .L633
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w20, [x0]
	cbz	w20, .L621
	bl	strlen
	sub	x0, x0, #1
	cmp	x0, 499
	mov	w1, 47
	ccmp	w20, w1, 0, ls
	beq	.L634
.L621:
	mov	w0, 0
.L618:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L634:
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x21, [x0]
	adrp	x20, .LC105
	mov	w0, 47
	add	x20, x20, :lo12:.LC105
	b	.L623
	.p2align 2,,3
.L636:
	ldrb	w0, [x19, 1]!
	cbz	w0, .L635
.L623:
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x21, x1]
	tbnz	x1, 3, .L622
	sub	w1, w0, #45
	and	w1, w1, 255
	cmp	w1, 2
	bls	.L622
	cmp	w0, 95
	bne	.L632
.L622:
	mov	x1, x20
	mov	x0, x19
	bl	strstr
	cbz	x0, .L636
.L632:
	ldr	x21, [sp, 32]
	b	.L621
	.p2align 2,,3
.L633:
	mov	w0, 0
	ret
	.p2align 2,,3
.L635:
	ldr	x21, [sp, 32]
	mov	w0, 1
	b	.L618
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot
	.type	set_gentoo_chroot, %function
set_gentoo_chroot:
	cmp	w0, 0
	adrp	x0, .LANCHOR0+28
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+28]
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
	cmp	w0, 0
	adrp	x0, .LANCHOR0+32
	cset	w1, ne
	str	w1, [x0, #:lo12:.LANCHOR0+32]
	ret
	.align	2
	.p2align 5,,15
	.global	get_portage_imitation
	.type	get_portage_imitation, %function
get_portage_imitation:
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	ldp	w0, w1, [x0, 28]
	orr	w0, w1, w0
	cmp	w0, 0
	cset	w0, ne
	ret
	.align	2
	.p2align 5,,15
	.global	set_gentoo_chroot_path
	.type	set_gentoo_chroot_path, %function
set_gentoo_chroot_path:
	cbz	x0, .L650
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L653
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L653:
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
.L650:
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
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
