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
	mov	x19, x1
	str	x21, [sp, 32]
	cbz	x1, .L9
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L3
	.p2align 2,,3
.L4:
	add	x20, x20, 1
	subs	x19, x19, #1
	beq	.L9
.L3:
	ldrb	w0, [x20]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L4
	.p2align 5,,15
.L5:
	cbz	x19, .L9
	bl	__ctype_b_loc
	sub	x1, x19, #1
	ldr	x0, [x0]
	ldrb	w2, [x20, x1]
	ldrh	w0, [x0, x2, lsl 1]
	tbz	x0, 13, .L16
	mov	x19, x1
	b	.L5
	.p2align 2,,3
.L9:
	mov	x0, 1
.L2:
	bl	malloc
	mov	x21, x0
	cbz	x0, .L1
	mov	x2, x19
	mov	x1, x20
	bl	memcpy
	strb	wzr, [x21, x19]
.L1:
	mov	x0, x21
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L16:
	add	x0, x19, 1
	b	.L2
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
	add	x1, sp, 176
	mov	x2, 320
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	stp	x25, x26, [sp, 64]
	mov	x26, x0
	stp	xzr, xzr, [sp, 152]
	bl	shell_quote
	mov	w21, w0
	cbnz	w0, .L166
	ldp	x29, x30, [sp]
	mov	w0, w21
	ldp	x21, x22, [sp, 32]
	mov	x12, 5552
	ldp	x25, x26, [sp, 64]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L166:
	add	x3, sp, 176
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	stp	x23, x24, [sp, 48]
	add	x23, sp, 1456
	mov	x1, 4096
	mov	x0, x23
	stp	x19, x20, [sp, 16]
	bl	xsnprintf
	add	x1, sp, 152
	mov	x0, x23
	bl	run_cmd_capture
	ldr	x20, [sp, 152]
	cbz	x20, .L20
	ldrb	w0, [x20]
	mov	x19, 0
	cbz	w0, .L157
	add	x24, sp, 496
	add	x25, sp, 816
.L26:
	mov	x0, x20
	mov	w1, 10
	bl	strchr
	mov	x21, x0
	cbz	x0, .L21
.L168:
	sub	x22, x0, x20
	sub	x0, x22, #1
	cmp	x0, 158
	bls	.L167
.L23:
	ldrb	w0, [x21, 1]
	cbz	w0, .L92
	add	x20, x21, 1
	mov	w1, 10
	mov	x0, x20
	bl	strchr
	mov	x21, x0
	cbnz	x0, .L168
.L21:
	mov	x0, x20
	bl	strlen
	mov	x21, x0
	sub	x0, x0, #1
	cmp	x0, 158
	bls	.L169
.L92:
	ldr	x0, [sp, 152]
	bl	free
	cbz	x19, .L20
	add	x20, sp, 816
	b	.L88
.L157:
	mov	x0, x20
	bl	free
.L20:
	mov	w21, 0
	mov	x12, 5552
	ldp	x19, x20, [sp, 16]
	mov	w0, w21
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L167:
	mov	x2, x22
	mov	x1, x20
	mov	x0, x24
	bl	memcpy
	strb	wzr, [x24, x22]
	mov	x0, x24
	bl	valid_pkgname
	cbz	w0, .L23
	mov	x0, x24
	bl	strdup
	str	x0, [x25, x19, lsl 3]
	add	x22, x19, 1
	ldrb	w0, [x21, 1]
	mov	x20, x25
	cbz	w0, .L170
	cmp	x22, 80
	beq	.L28
	add	x20, x21, 1
	mov	x19, x22
	b	.L26
	.p2align 2,,3
.L169:
	add	x22, sp, 496
	mov	x2, x21
	mov	x1, x20
	mov	x0, x22
	bl	memcpy
	strb	wzr, [x22, x21]
	mov	x0, x22
	bl	valid_pkgname
	cbz	w0, .L92
	add	x20, sp, 816
	mov	x0, x22
	bl	strdup
	str	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	ldr	x0, [sp, 152]
	bl	free
	.p2align 5,,15
.L88:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	add	x19, x20, w19, uxtw 3
	mov	x21, x20
	mov	x24, 13
	mov	w25, 32
	ldr	x1, [x0]
	str	x1, [sp, 1456]
	ldr	x0, [x0, 6]
	str	x0, [x23, 6]
	.p2align 5,,15
.L33:
	ldr	x0, [x21]
	cbz	x0, .L31
	add	x1, sp, 496
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L31
	add	x0, sp, 496
	bl	strlen
	add	x3, x24, 1
	add	x22, x0, x3
	cmp	x22, 4095
	bhi	.L32
	strb	w25, [x23, x24]
	mov	x24, x22
	mov	x2, x0
	add	x1, sp, 496
	add	x0, x23, x3
	bl	memcpy
	strb	wzr, [x23, x22]
.L31:
	add	x21, x21, 8
	cmp	x19, x21
	bne	.L33
.L32:
	mov	x0, x23
	add	x1, sp, 160
	bl	run_cmd_capture
	mov	w21, w0
	ldr	x23, [sp, 160]
	cbz	w0, .L171
	mov	w21, 0
.L34:
	mov	x0, x23
	bl	free
	.p2align 5,,15
.L81:
	ldr	x0, [x20], 8
	bl	free
	cmp	x19, x20
	bne	.L81
	ldp	x19, x20, [sp, 16]
	mov	w0, w21
	ldp	x23, x24, [sp, 48]
	mov	x12, 5552
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L171:
	cbz	x23, .L34
	ldrb	w0, [x23]
	cbz	w0, .L34
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	str	x0, [sp, 112]
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	stp	x27, x28, [sp, 80]
	str	wzr, [sp, 124]
	str	x0, [sp, 128]
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	str	x0, [sp, 136]
	.p2align 5,,15
.L80:
	ldr	x1, [sp, 112]
	mov	x0, x23
	bl	strstr
	mov	x21, x0
	cmp	x0, x23
	beq	.L172
	mov	x22, x21
	cbz	x21, .L173
.L38:
	adrp	x0, .LC7
	add	x1, x0, :lo12:.LC7
	mov	x0, x23
	bl	strstr
	mov	x24, x0
	adrp	x0, .LC8
	add	x1, x0, :lo12:.LC8
	mov	x0, x23
	bl	strstr
	mov	x25, x0
	adrp	x0, .LC9
	add	x1, x0, :lo12:.LC9
	mov	x0, x23
	bl	strstr
	mov	x27, x0
	adrp	x0, .LC10
	add	x1, x0, :lo12:.LC10
	mov	x0, x23
	bl	strstr
	mov	x28, x0
	cmp	x24, 0
	ccmp	x22, x24, 0, ne
	bls	.L39
	mov	x0, x24
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x22, x0, 0, ne
	bls	.L39
	mov	w1, 10
	add	x24, x23, 1
	bl	strchr
	cbz	x0, .L42
	sub	x0, x0, x23
	sub	x1, x0, #1
.L43:
	mov	x0, x24
	bl	trim_copy
	mov	x24, x0
.L41:
	cmp	x27, 0
	ccmp	x22, x27, 0, ne
	cset	w0, hi
	str	w0, [sp, 104]
	cmp	x25, 0
	ccmp	x22, x25, 0, ne
	bls	.L44
	mov	x0, x25
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x22, x0, 0, ne
	bls	.L44
	mov	w1, 10
	add	x25, x23, 1
	bl	strchr
	cbz	x0, .L48
	sub	x0, x0, x23
	sub	x1, x0, #1
.L49:
	mov	x0, x25
	bl	trim_copy
	mov	x25, x0
	ldr	w0, [sp, 104]
	cbz	w0, .L52
	mov	x0, x27
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x22, x0, 0, ne
	bhi	.L83
.L52:
	mov	x27, 0
.L51:
	cmp	x28, 0
	ccmp	x22, x28, 0, ne
	cset	w23, hi
	cbz	x25, .L47
	mov	x1, x26
	mov	x0, x25
	bl	strcmp
	cbz	w0, .L58
	cbz	w23, .L57
	mov	x0, x28
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x0, x22, 2, ne
	mov	w28, 0
	bcs	.L57
.L82:
	mov	x0, x23
	mov	w1, 10
	add	x22, x23, 1
	bl	strchr
	cbz	x0, .L65
	sub	x0, x0, x23
	sub	x1, x0, #1
.L66:
	mov	x0, x22
	bl	trim_copy
	mov	x23, x0
	cbz	x0, .L67
	ldr	x1, [sp, 136]
	bl	strcmp
	cbnz	w0, .L174
.L67:
	mov	x0, x23
	bl	free
	cbz	x25, .L57
	cbz	w28, .L57
.L74:
	cbz	x24, .L165
	ldrb	w0, [x24]
	cbz	w0, .L165
	mov	x3, x27
	mov	x1, x24
	cbz	x27, .L175
.L161:
	adrp	x4, .LC2
	add	x4, x4, :lo12:.LC2
.L64:
	ldr	x0, [sp, 128]
	mov	x2, x25
	bl	printf
	mov	w0, 1
	str	w0, [sp, 124]
.L57:
	mov	x0, x25
	bl	free
	mov	x0, x27
	bl	free
	mov	x0, x24
	bl	free
	cbz	x21, .L79
	ldrb	w0, [x21, 1]
	add	x23, x21, 1
	cbnz	w0, .L80
.L79:
	ldr	x23, [sp, 160]
	ldp	x27, x28, [sp, 80]
	ldr	w21, [sp, 124]
	b	.L34
	.p2align 2,,3
.L28:
	ldr	x0, [sp, 152]
	mov	x19, x22
	bl	free
	b	.L88
	.p2align 2,,3
.L44:
	ldr	w0, [sp, 104]
	cbz	w0, .L84
	mov	x0, x27
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x22, x0, 0, ne
	mov	x25, 0
	bls	.L84
.L83:
	mov	x0, x23
	mov	w1, 10
	bl	strchr
	add	x2, x23, 1
	cbz	x0, .L53
	sub	x0, x0, x23
	sub	x1, x0, #1
.L54:
	mov	x0, x2
	bl	trim_copy
	mov	x27, x0
	b	.L51
	.p2align 2,,3
.L84:
	mov	x27, 0
.L47:
	cmp	x28, 0
	ccmp	x22, x28, 0, ne
	bls	.L162
	mov	x0, x28
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x22, x0, 0, ne
	bls	.L162
	mov	w28, 0
	mov	x25, 0
	b	.L82
	.p2align 2,,3
.L39:
	mov	x24, 0
	b	.L41
	.p2align 2,,3
.L58:
	cbnz	w23, .L61
	cbz	x24, .L62
	ldrb	w0, [x24]
	cbz	w0, .L62
	mov	x3, x27
	mov	x1, x24
	cbnz	x27, .L161
	adrp	x3, .LC1
	adrp	x4, .LC2
	add	x3, x3, :lo12:.LC1
	add	x4, x4, :lo12:.LC2
	b	.L64
	.p2align 2,,3
.L172:
	ldr	x1, [sp, 112]
	add	x0, x23, 1
	bl	strstr
	mov	x21, x0
	mov	x22, x21
	cbnz	x21, .L38
.L173:
	mov	x0, x23
	bl	strlen
	add	x22, x23, x0
	b	.L38
	.p2align 2,,3
.L162:
	mov	x25, 0
	b	.L57
	.p2align 2,,3
.L61:
	mov	x0, x28
	mov	w1, 58
	bl	strchr
	cmp	x0, 0
	mov	x23, x0
	ccmp	x0, x22, 2, ne
	bcs	.L74
	mov	w28, 1
	b	.L82
	.p2align 2,,3
.L165:
	mov	x3, x27
	cbz	x27, .L100
.L160:
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	b	.L161
.L170:
	mov	x19, x22
	b	.L92
.L65:
	mov	x0, x22
	bl	strlen
	mov	x1, x0
	b	.L66
.L42:
	mov	x0, x24
	bl	strlen
	mov	x1, x0
	b	.L43
.L48:
	mov	x0, x25
	bl	strlen
	mov	x1, x0
	b	.L49
.L53:
	mov	x0, x2
	str	x2, [sp, 104]
	bl	strlen
	mov	x1, x0
	ldr	x2, [sp, 104]
	b	.L54
	.p2align 2,,3
.L62:
	mov	x3, x27
	cbnz	x27, .L160
.L100:
	adrp	x3, .LC1
	adrp	x1, .LC0
	adrp	x4, .LC2
	add	x3, x3, :lo12:.LC1
	add	x1, x1, :lo12:.LC0
	add	x4, x4, :lo12:.LC2
	b	.L64
.L174:
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	mov	x1, x0
	add	x2, sp, 168
	str	x0, [sp, 104]
	mov	x0, x23
	str	xzr, [sp, 168]
	bl	strtok_r
	cbz	x0, .L67
	.p2align 5,,15
.L71:
	add	x1, sp, 496
	mov	x2, 256
	bl	dep_basename
	ldrb	w0, [sp, 496]
	cbz	w0, .L69
	mov	x1, x26
	add	x0, sp, 496
	bl	strcmp
	cbnz	w0, .L69
	mov	x0, x23
	bl	free
	cbz	x25, .L57
	cbz	x24, .L102
	ldrb	w0, [x24]
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	cmp	w0, 0
	csel	x1, x1, x24, eq
.L77:
	mov	x3, x27
	cbz	x27, .L176
.L78:
	cbnz	w28, .L161
	adrp	x4, .LC3
	add	x4, x4, :lo12:.LC3
	b	.L64
.L176:
	adrp	x3, .LC1
	add	x3, x3, :lo12:.LC1
	b	.L78
	.p2align 2,,3
.L69:
	ldr	x1, [sp, 104]
	add	x2, sp, 168
	mov	x0, 0
	bl	strtok_r
	cbnz	x0, .L71
	b	.L67
.L175:
	adrp	x3, .LC1
	adrp	x4, .LC2
	add	x3, x3, :lo12:.LC1
	add	x4, x4, :lo12:.LC2
	b	.L64
.L102:
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
	sub	sp, sp, #624
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	stp	xzr, xzr, [sp, 96]
	stp	q31, q31, [sp, 112]
	stp	q31, q31, [sp, 144]
	stp	q31, q31, [sp, 176]
	stp	q31, q31, [sp, 208]
	stp	q31, q31, [sp, 240]
	stp	q31, q31, [sp, 272]
	stp	q31, q31, [sp, 304]
	stp	q31, q31, [sp, 336]
	bl	valid_pkgname
	cbnz	w0, .L178
	mov	w22, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x21, .L220
.L179:
	adrp	x1, .LC15
	mov	x2, x21
	add	x1, x1, :lo12:.LC15
	bl	fprintf
.L177:
	ldp	x29, x30, [sp]
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 624
	ret
	.p2align 2,,3
.L178:
	mov	x1, x21
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	mov	x0, x21
	bl	print_repo_providers
	mov	w22, w0
	bl	config_current
	add	x0, x0, 20
	add	x3, sp, 112
	add	x2, sp, 96
	mov	x1, x21
	mov	x4, 256
	bl	aur_rpc_info
	cbz	w0, .L182
	ldr	x2, [sp, 104]
	cbz	x2, .L182
	adrp	x0, .LC17
	stp	x25, x26, [sp, 64]
	add	x26, x0, :lo12:.LC17
	stp	x19, x20, [sp, 16]
	stp	x23, x24, [sp, 48]
	mov	x23, 0
	mov	x24, 0
	.p2align 5,,15
.L197:
	ldr	x0, [sp, 96]
	add	x20, x0, x23
	ldr	x19, [x0, x23]
	ldr	x3, [x20, 128]
	cbz	x19, .L221
	mov	x1, x21
	mov	x0, x19
	stp	x3, x2, [sp, 80]
	bl	strcmp
	ldp	x3, x2, [sp, 80]
	cbz	x3, .L187
	cmp	w0, 0
	cset	w25, eq
.L185:
	mov	x19, 0
	.p2align 5,,15
.L191:
	ldr	x0, [x20, 120]
	mov	x2, 256
	add	x1, sp, 368
	ldr	x0, [x0, x19, lsl 3]
	bl	dep_basename
	ldrb	w2, [sp, 368]
	cbz	w2, .L188
	mov	x1, x21
	add	x0, sp, 368
	bl	strcmp
	cbnz	w0, .L188
	ldr	x19, [x20]
	cbz	x19, .L222
	ldr	x2, [x20, 16]
	cbz	x2, .L223
	.p2align 5,,15
.L196:
	cmp	w25, 0
	adrp	x0, .LC2
	adrp	x1, .LC3
	add	x0, x0, :lo12:.LC2
	add	x3, x1, :lo12:.LC3
	csel	x3, x3, x0, eq
.L195:
	mov	w22, 1
	mov	x1, x19
	mov	x0, x26
	bl	printf
.L217:
	ldr	x2, [sp, 104]
.L193:
	add	x24, x24, 1
	add	x23, x23, 152
	cmp	x2, x24
	bhi	.L197
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
.L182:
	add	x0, sp, 96
	bl	aur_response_destroy
	cbnz	w22, .L177
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC18
	add	x1, x1, :lo12:.LC18
	ldr	x0, [x0]
	bl	fprintf
	b	.L177
	.p2align 2,,3
.L220:
	adrp	x21, .LC1
	add	x21, x21, :lo12:.LC1
	b	.L179
	.p2align 2,,3
.L188:
	ldr	x0, [x20, 128]
	add	x19, x19, 1
	cmp	x0, x19
	bhi	.L191
	cbz	w25, .L217
	ldr	x19, [x20]
	ldr	x2, [x20, 16]
	cbz	x19, .L224
.L219:
	cbnz	x2, .L215
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
.L215:
	adrp	x3, .LC2
	add	x3, x3, :lo12:.LC2
	b	.L195
	.p2align 2,,3
.L222:
	ldr	x2, [x20, 16]
	adrp	x19, .LC14
	add	x19, x19, :lo12:.LC14
	cbnz	x2, .L196
.L223:
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	b	.L196
	.p2align 2,,3
.L221:
	mov	w25, 0
	cbnz	x3, .L185
	b	.L193
.L187:
	cbnz	w0, .L193
	ldr	x2, [x20, 16]
	b	.L219
.L224:
	cbnz	x2, .L216
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
.L216:
	adrp	x19, .LC14
	adrp	x3, .LC2
	add	x19, x19, :lo12:.LC14
	add	x3, x3, :lo12:.LC2
	b	.L195
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
