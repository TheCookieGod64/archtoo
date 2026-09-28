	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	trim_copy, %function
trim_copy:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	str	x21, [sp, 32]
	cbz	x1, .L2
	mov	x19, x1
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L3
	.p2align 2,,3
.L4:
	add	x20, x20, 1
	subs	x19, x19, #1
	beq	.L2
.L3:
	ldrb	w0, [x20]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L4
	.p2align 5,,15
.L6:
	cbz	x19, .L8
	bl	__ctype_b_loc
	sub	x1, x19, #1
	ldr	x0, [x0]
	ldrb	w2, [x20, x1]
	ldrh	w0, [x0, x2, lsl 1]
	tbz	x0, 13, .L21
	mov	x19, x1
	b	.L6
	.p2align 2,,3
.L2:
	mov	x19, 0
	mov	x0, 1
.L5:
	bl	malloc
	mov	x21, x0
	cbz	x0, .L1
	mov	x1, x20
	mov	x2, x19
	bl	memcpy
	strb	wzr, [x21, x19]
.L1:
	mov	x0, x21
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L21:
	add	x0, x19, 1
	b	.L5
.L8:
	mov	x0, 1
	b	.L5
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"repo"
	.align	3
.LC1:
	.string	""
	.align	3
.LC2:
	.string	"(package)"
	.align	3
.LC3:
	.string	"(provides)"
	.align	3
.LC4:
	.string	"pacman -Ssq -- %s"
	.align	3
.LC5:
	.string	"pacman -Si --"
	.align	3
.LC6:
	.string	"\nRepository"
	.align	3
.LC7:
	.string	"Repository"
	.align	3
.LC8:
	.string	"\nName"
	.align	3
.LC9:
	.string	"\nVersion"
	.align	3
.LC10:
	.string	"\nProvides"
	.align	3
.LC11:
	.string	"None"
	.align	3
.LC12:
	.string	" \t"
	.align	3
.LC13:
	.string	"%s/%s %s  %s\n"
	.text
	.align	2
	.p2align 5,,15
	.type	print_repo_providers, %function
print_repo_providers:
	mov	x12, 5552
	sub	sp, sp, x12
	mov	x2, 320
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 176
	mov	x1, x19
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	stp	xzr, xzr, [sp, 152]
	bl	shell_quote
	cbnz	w0, .L165
.L24:
	mov	w21, 0
	mov	x12, 5552
	ldp	x29, x30, [sp]
	mov	w0, w21
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L165:
	mov	x3, x19
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	stp	x23, x24, [sp, 48]
	add	x24, sp, 1456
	mov	x1, 4096
	mov	x0, x24
	bl	xsnprintf
	add	x1, sp, 152
	mov	x0, x24
	bl	run_cmd_capture
	ldr	x21, [sp, 152]
	cbz	x21, .L166
	stp	x25, x26, [sp, 64]
	mov	x25, 0
	ldrb	w0, [x21]
	cbz	w0, .L153
	mov	x0, x21
	mov	w1, 10
	add	x26, sp, 496
	bl	strchr
	add	x23, sp, 816
	mov	x20, x0
	cbz	x0, .L27
	.p2align 5,,15
.L167:
	sub	x19, x0, x21
	sub	x0, x19, #1
	cmp	x0, 158
	bls	.L28
.L85:
	ldrb	w0, [x20, 1]
	mov	x19, x25
	add	x21, x20, 1
	cbz	w0, .L30
.L29:
	mov	x0, x21
	mov	w1, 10
	mov	x25, x19
	bl	strchr
	mov	x20, x0
	cbnz	x0, .L167
.L27:
	mov	x0, x21
	bl	strlen
	mov	x19, x0
	sub	x0, x0, #1
	cmp	x0, 158
	bls	.L168
.L30:
	mov	x19, x25
.L91:
	ldr	x0, [sp, 152]
	bl	free
	cbz	x19, .L155
	add	x20, sp, 816
	stp	x27, x28, [sp, 80]
	b	.L89
	.p2align 2,,3
.L168:
	add	x23, sp, 496
	mov	x1, x21
	mov	x2, x19
	mov	x0, x23
	bl	memcpy
	strb	wzr, [x23, x19]
	mov	x0, x23
	bl	valid_pkgname
	cbz	w0, .L30
	add	x20, sp, 816
	mov	x0, x23
	stp	x27, x28, [sp, 80]
	bl	strdup
	add	x19, x25, 1
	str	x0, [x20, x25, lsl 3]
	ldr	x0, [sp, 152]
	bl	free
	.p2align 5,,15
.L89:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	add	x23, sp, 496
	add	x19, x20, w19, uxtw 3
	mov	x27, x20
	mov	x25, 13
	ldr	x1, [x0]
	str	x1, [sp, 1456]
	ldr	x0, [x0, 6]
	mov	w26, 32
	str	x0, [x24, 6]
	.p2align 5,,15
.L41:
	ldr	x0, [x27]
	mov	x1, x23
	mov	x2, 320
	cbz	x0, .L37
	bl	shell_quote
	mov	w1, w0
	mov	x0, x23
	cbz	w1, .L37
	bl	strlen
	mov	x2, x0
	add	x3, x25, 1
	mov	x1, x23
	add	x21, x2, x3
	add	x0, x24, x3
	cmp	x21, 4095
	bhi	.L40
	strb	w26, [x24, x25]
	mov	x25, x21
	bl	memcpy
	strb	wzr, [x24, x21]
.L37:
	add	x27, x27, 8
	cmp	x19, x27
	bne	.L41
.L40:
	mov	x0, x24
	add	x1, sp, 160
	bl	run_cmd_capture
	mov	w21, w0
	ldr	x25, [sp, 160]
	cbz	w0, .L169
	mov	w21, 0
.L42:
	mov	x0, x25
	bl	free
	.p2align 5,,15
.L81:
	ldr	x0, [x20], 8
	bl	free
	cmp	x19, x20
	bne	.L81
	ldp	x23, x24, [sp, 48]
	mov	w0, w21
	ldp	x25, x26, [sp, 64]
	mov	x12, 5552
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L28:
	mov	x1, x21
	mov	x2, x19
	mov	x0, x26
	bl	memcpy
	strb	wzr, [x26, x19]
	mov	x0, x26
	bl	valid_pkgname
	cbz	w0, .L85
	mov	x0, x26
	bl	strdup
	ldrb	w1, [x20, 1]
	add	x21, x20, 1
	str	x0, [x23, x25, lsl 3]
	add	x19, x25, 1
	mov	x20, x23
	cbz	w1, .L91
	cmp	x19, 80
	bne	.L29
	ldr	x0, [sp, 152]
	stp	x27, x28, [sp, 80]
	bl	free
	b	.L89
	.p2align 2,,3
.L169:
	cbz	x25, .L42
	ldrb	w0, [x25]
	cbz	w0, .L42
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	adrp	x1, .LC6
	add	x1, x1, :lo12:.LC6
	str	x1, [sp, 104]
	str	wzr, [sp, 116]
	str	x0, [sp, 120]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	str	x0, [sp, 128]
	.p2align 5,,15
.L80:
	ldr	x1, [sp, 104]
	mov	x0, x25
	bl	strstr
	mov	x21, x0
	cmp	x0, x25
	beq	.L170
.L43:
	mov	x23, x21
	cbz	x21, .L171
.L44:
	adrp	x0, .LC7
	add	x1, x0, :lo12:.LC7
	mov	x0, x25
	bl	strstr
	mov	x28, x0
	adrp	x0, .LC8
	add	x1, x0, :lo12:.LC8
	mov	x0, x25
	bl	strstr
	mov	x26, x0
	adrp	x1, .LC9
	mov	x0, x25
	add	x1, x1, :lo12:.LC9
	bl	strstr
	adrp	x1, .LC10
	mov	x24, x0
	add	x1, x1, :lo12:.LC10
	mov	x0, x25
	bl	strstr
	mov	x27, 0
	cmp	x28, 0
	mov	x25, x0
	ccmp	x23, x28, 0, ne
	bls	.L45
	mov	x0, x28
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x28, x0
	ccmp	x23, x0, 0, ne
	bls	.L45
	mov	w1, 10
	add	x27, x28, 1
	bl	strchr
	cbz	x0, .L46
	sub	x0, x0, x28
	sub	x1, x0, #1
.L47:
	mov	x0, x27
	bl	trim_copy
	mov	x27, x0
.L45:
	cmp	x24, 0
	ccmp	x23, x24, 0, ne
	cset	w0, hi
	str	w0, [sp, 96]
	cmp	x26, 0
	ccmp	x23, x26, 0, ne
	bls	.L160
	mov	x0, x26
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x26, x0
	ccmp	x23, x0, 0, ne
	bhi	.L51
	ldr	w0, [sp, 96]
.L160:
	cbz	w0, .L156
	mov	x0, x24
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x24, x0
	ccmp	x23, x0, 0, ne
	mov	x26, 0
	bls	.L156
.L83:
	mov	x0, x24
	mov	w1, 10
	add	x28, x24, 1
	bl	strchr
	cbz	x0, .L55
	sub	x0, x0, x24
	sub	x1, x0, #1
.L56:
	mov	x0, x28
	bl	trim_copy
	mov	x28, x0
.L54:
	cmp	x25, 0
	ccmp	x23, x25, 0, ne
	cset	w24, hi
	cbz	x26, .L50
	mov	x1, x22
	mov	x0, x26
	bl	strcmp
	cbz	w0, .L60
	cbz	w24, .L59
	mov	x0, x25
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x24, x0
	ccmp	x0, x23, 2, ne
	mov	w25, 0
	bcs	.L59
.L82:
	mov	x0, x24
	mov	w1, 10
	add	x23, x24, 1
	bl	strchr
	cbz	x0, .L67
	sub	x0, x0, x24
	sub	x1, x0, #1
.L68:
	mov	x0, x23
	bl	trim_copy
	mov	x24, x0
	cbz	x0, .L69
	adrp	x1, .LC11
	add	x1, x1, :lo12:.LC11
	bl	strcmp
	cbnz	w0, .L172
.L69:
	mov	x0, x24
	bl	free
	cbz	x26, .L59
	cbz	w25, .L59
.L88:
	cbz	x27, .L163
.L75:
	ldrb	w0, [x27]
	cbz	w0, .L163
	cbz	x28, .L105
	mov	x3, x28
	mov	x1, x27
.L65:
	ldr	x4, [sp, 128]
.L66:
	mov	x2, x26
	ldr	x0, [sp, 120]
	bl	printf
	mov	w0, 1
	str	w0, [sp, 116]
.L59:
	mov	x0, x26
	bl	free
	mov	x0, x28
	bl	free
	mov	x0, x27
	bl	free
	cbz	x21, .L159
	ldrb	w0, [x21, 1]
	add	x25, x21, 1
	cbnz	w0, .L80
.L159:
	ldr	x25, [sp, 160]
	ldr	w21, [sp, 116]
	b	.L42
	.p2align 2,,3
.L155:
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L24
	.p2align 2,,3
.L166:
	ldp	x23, x24, [sp, 48]
	b	.L24
	.p2align 2,,3
.L156:
	mov	x28, 0
.L50:
	cmp	x25, 0
	ccmp	x23, x25, 0, ne
	bls	.L158
	mov	x0, x25
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x24, x0
	ccmp	x23, x0, 0, ne
	bls	.L158
	mov	w25, 0
	mov	x26, 0
	b	.L82
	.p2align 2,,3
.L60:
	cbnz	w24, .L62
	cbnz	x27, .L75
	cbz	x28, .L102
	adrp	x1, .LC0
	adrp	x4, .LC2
	add	x1, x1, :lo12:.LC0
	add	x4, x4, :lo12:.LC2
	mov	x3, x28
	b	.L66
	.p2align 2,,3
.L171:
	mov	x0, x25
	bl	strlen
	add	x23, x25, x0
	b	.L44
	.p2align 2,,3
.L170:
	ldr	x1, [sp, 104]
	add	x0, x25, 1
	bl	strstr
	mov	x21, x0
	b	.L43
	.p2align 2,,3
.L51:
	mov	w1, 10
	add	x28, x26, 1
	bl	strchr
	cbz	x0, .L52
	sub	x0, x0, x26
	sub	x1, x0, #1
.L53:
	mov	x0, x28
	bl	trim_copy
	mov	x26, x0
	ldr	w0, [sp, 96]
	mov	x28, 0
	cbz	w0, .L54
	mov	x0, x24
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x24, x0
	ccmp	x23, x0, 0, ne
	bls	.L54
	b	.L83
	.p2align 2,,3
.L158:
	mov	x26, 0
	b	.L59
	.p2align 2,,3
.L163:
	cbz	x28, .L173
	adrp	x1, .LC0
	mov	x3, x28
	add	x1, x1, :lo12:.LC0
	b	.L65
	.p2align 2,,3
.L62:
	mov	x0, x25
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x24, x0
	ccmp	x0, x23, 2, ne
	bcs	.L88
	mov	w25, 1
	b	.L82
.L67:
	mov	x0, x23
	bl	strlen
	mov	x1, x0
	b	.L68
.L55:
	mov	x0, x28
	bl	strlen
	mov	x1, x0
	b	.L56
.L52:
	mov	x0, x28
	bl	strlen
	mov	x1, x0
	b	.L53
.L46:
	mov	x0, x27
	bl	strlen
	mov	x1, x0
	b	.L47
.L173:
	adrp	x3, .LC1
	adrp	x1, .LC0
	add	x3, x3, :lo12:.LC1
	add	x1, x1, :lo12:.LC0
	b	.L65
.L105:
	adrp	x3, .LC1
	mov	x1, x27
	add	x3, x3, :lo12:.LC1
	b	.L65
.L153:
	mov	x0, x21
	bl	free
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	b	.L24
.L172:
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	add	x2, sp, 168
	mov	x1, x0
	str	x0, [sp, 96]
	mov	x0, x24
	str	x2, [sp, 136]
	str	xzr, [sp, 168]
	bl	strtok_r
	cbz	x0, .L69
	add	x23, sp, 496
	.p2align 5,,15
.L73:
	mov	x1, x23
	mov	x2, 256
	bl	dep_basename
	ldrb	w2, [sp, 496]
	mov	x1, x22
	mov	x0, x23
	cbz	w2, .L71
	bl	strcmp
	cbnz	w0, .L71
	mov	x0, x24
	bl	free
	cbz	x26, .L59
	cbz	x27, .L106
	ldrb	w0, [x27]
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	cmp	w0, 0
	csel	x1, x1, x27, eq
.L77:
	cmp	x28, 0
	adrp	x3, .LC1
	add	x3, x3, :lo12:.LC1
	csel	x3, x3, x28, eq
	cbnz	w25, .L65
	adrp	x4, .LC3
	add	x4, x4, :lo12:.LC3
	b	.L66
	.p2align 2,,3
.L71:
	ldr	x1, [sp, 96]
	mov	x0, 0
	ldr	x2, [sp, 136]
	bl	strtok_r
	cbnz	x0, .L73
	b	.L69
.L102:
	adrp	x3, .LC1
	adrp	x1, .LC0
	adrp	x4, .LC2
	add	x3, x3, :lo12:.LC1
	add	x1, x1, :lo12:.LC0
	add	x4, x4, :lo12:.LC2
	b	.L66
.L106:
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	b	.L77
	.section	.rodata.str1.8
	.align	3
.LC14:
	.string	"?"
	.align	3
.LC15:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC16:
	.string	"\033[1;36m>>> Providers of %s\n\033[0m"
	.align	3
.LC17:
	.string	"aur/%s %s  %s\n"
	.align	3
.LC18:
	.string	"\033[1;33m[!] No providers found for '%s'.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_provider_v2
	.type	cmd_provider_v2, %function
cmd_provider_v2:
	movi	v31.4s, 0
	sub	sp, sp, #640
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 128
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	stp	x23, x24, [sp, 48]
	stp	xzr, xzr, [sp, 112]
	stp	q31, q31, [x19]
	stp	q31, q31, [x19, 32]
	stp	q31, q31, [x19, 64]
	stp	q31, q31, [x19, 96]
	stp	q31, q31, [x19, 128]
	stp	q31, q31, [x19, 160]
	stp	q31, q31, [x19, 192]
	stp	q31, q31, [x19, 224]
	bl	valid_pkgname
	cbnz	w0, .L175
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x21, 0
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	adrp	x1, .LC15
	csel	x2, x2, x21, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC15
	bl	fprintf
.L177:
	mov	w23, 0
	mov	w0, w23
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L175:
	mov	x1, x21
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	stp	x25, x26, [sp, 64]
	bl	printf
	mov	x0, x21
	bl	print_repo_providers
	add	x26, sp, 112
	mov	w23, w0
	bl	config_current
	add	x0, x0, 20
	mov	x3, x19
	mov	x2, x26
	mov	x1, x21
	mov	x4, 256
	bl	aur_rpc_info
	cbz	w0, .L178
	ldr	x20, [sp, 120]
	cbz	x20, .L178
	stp	x27, x28, [sp, 80]
	adrp	x27, .LC17
	add	x0, x27, :lo12:.LC17
	adrp	x28, .LC2
	mov	x22, 0
	mov	x25, 0
	str	x0, [sp, 96]
	add	x0, x28, :lo12:.LC2
	str	x0, [sp, 104]
	.p2align 5,,15
.L193:
	ldr	x0, [sp, 112]
	add	x28, x0, x22
	ldr	x19, [x0, x22]
	ldr	x27, [x28, 128]
	cbz	x19, .L216
	mov	x1, x21
	mov	x0, x19
	bl	strcmp
	cmp	w0, 0
	cset	w24, eq
	cbz	x27, .L182
.L180:
	add	x20, sp, 384
	mov	x19, 0
	.p2align 5,,15
.L186:
	ldr	x0, [x28, 120]
	mov	x1, x20
	mov	x2, 256
	ldr	x0, [x0, x19, lsl 3]
	bl	dep_basename
	ldrb	w2, [sp, 384]
	mov	x1, x21
	mov	x0, x20
	cbz	w2, .L183
	bl	strcmp
	cbnz	w0, .L183
	ldr	x19, [x28]
	adrp	x1, .LC14
	ldr	x2, [x28, 16]
	cmp	x19, 0
	add	x1, x1, :lo12:.LC14
	adrp	x0, .LC1
	csel	x19, x1, x19, eq
	add	x0, x0, :lo12:.LC1
	cmp	x2, 0
	csel	x2, x0, x2, eq
	cbnz	w24, .L190
	adrp	x3, .LC3
	add	x3, x3, :lo12:.LC3
.L192:
	ldr	x0, [sp, 96]
	mov	x1, x19
	mov	w23, 1
	bl	printf
	ldr	x20, [sp, 120]
.L188:
	add	x25, x25, 1
	add	x22, x22, 152
	cmp	x20, x25
	bhi	.L193
	ldp	x27, x28, [sp, 80]
.L178:
	mov	x0, x26
	bl	aur_response_destroy
	cbz	w23, .L217
	ldp	x25, x26, [sp, 64]
	mov	w0, w23
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 640
	ret
.L182:
	cbnz	w0, .L188
	ldr	x2, [x28, 16]
.L215:
	cbnz	x2, .L190
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	.p2align 5,,15
.L190:
	ldr	x3, [sp, 104]
	b	.L192
	.p2align 2,,3
.L183:
	ldr	x0, [x28, 128]
	add	x19, x19, 1
	cmp	x0, x19
	bhi	.L186
	cbnz	w24, .L187
	ldr	x20, [sp, 120]
	b	.L188
	.p2align 2,,3
.L216:
	mov	w24, 0
	cbnz	x27, .L180
	b	.L188
	.p2align 2,,3
.L217:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC18
	add	x1, x1, :lo12:.LC18
	ldr	x0, [x0]
	bl	fprintf
	ldp	x25, x26, [sp, 64]
	b	.L177
.L187:
	ldr	x19, [x28]
	ldr	x2, [x28, 16]
	cbnz	x19, .L215
	cbz	x2, .L197
	ldr	x3, [sp, 104]
	adrp	x19, .LC14
	add	x19, x19, :lo12:.LC14
	b	.L192
.L197:
	ldr	x3, [sp, 104]
	adrp	x2, .LC1
	adrp	x19, .LC14
	add	x2, x2, :lo12:.LC1
	add	x19, x19, :lo12:.LC14
	b	.L192
	.section	.note.GNU-stack,"",@progbits
