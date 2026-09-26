	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	package_destroy, %function
package_destroy:
	stp	x29, x30, [sp, -176]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x22, 1
	stp	x23, x24, [sp, 48]
	mov	x23, x0
	stp	x25, x26, [sp, 64]
	add	x25, sp, 80
	add	x26, sp, 128
	ldr	x0, [x0]
	bl	free
	ldr	x0, [x23, 8]
	bl	free
	ldr	x0, [x23, 16]
	bl	free
	ldr	x0, [x23, 24]
	bl	free
	ldr	x0, [x23, 32]
	bl	free
	ldr	x0, [x23, 40]
	bl	free
	add	x0, x23, 72
	str	x0, [sp, 80]
	add	x0, x23, 88
	str	x0, [sp, 88]
	add	x0, x23, 104
	str	x0, [sp, 96]
	add	x0, x23, 120
	str	x0, [sp, 104]
	add	x0, x23, 136
	str	x0, [sp, 112]
	ldr	x0, [x23, 80]
	str	x0, [sp, 128]
	ldr	x0, [x23, 96]
	str	x0, [sp, 136]
	ldr	x0, [x23, 112]
	str	x0, [sp, 144]
	ldr	x0, [x23, 128]
	str	x0, [sp, 152]
	ldr	x0, [x23, 144]
	str	x0, [sp, 160]
.L2:
	add	x0, x26, x22, lsl 3
	lsl	x24, x22, 3
	add	x21, x25, x24
	mov	x19, 0
	ldr	x20, [x0, -8]
	cbz	x20, .L5
	.p2align 5,,15
.L3:
	ldr	x1, [x21, -8]
	ldr	x1, [x1]
	ldr	x0, [x1, x19, lsl 3]
	add	x19, x19, 1
	bl	free
	cmp	x19, x20
	bne	.L3
.L5:
	add	x24, x25, x24
	add	x22, x22, 1
	ldr	x0, [x24, -8]
	ldr	x0, [x0]
	bl	free
	cmp	x22, 6
	bne	.L2
	movi	v31.4s, 0
	str	xzr, [x23, 144]
	stp	q31, q31, [x23]
	stp	q31, q31, [x23, 32]
	stp	q31, q31, [x23, 64]
	stp	q31, q31, [x23, 96]
	str	q31, [x23, 128]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 176
	ret
	.align	2
	.p2align 5,,15
	.type	parse_json_string, %function
parse_json_string:
	ldr	x1, [x0]
	mov	x9, x0
	ldrb	w0, [x1]
	cmp	w0, 34
	bne	.L24
	stp	x29, x30, [sp, -96]!
	mov	x0, x1
	mov	x29, sp
	stp	x1, x9, [sp, 24]
	bl	strlen
	add	x8, x0, 1
	mov	x0, x8
	str	x8, [sp, 16]
	bl	malloc
	mov	x7, x0
	cbz	x0, .L11
	ldp	x8, x1, [sp, 16]
	mov	x6, x0
	ldr	x9, [sp, 32]
	mov	x2, 0
	add	x3, x1, 1
	ldrb	w1, [x1, 1]
	cmp	w1, 34
	ccmp	w1, 0, 4, ne
	bne	.L14
	b	.L15
	.p2align 2,,3
.L16:
	mov	x2, x5
	mov	x3, x4
	strb	w1, [x6]
.L21:
	ldrb	w1, [x3]
	cmp	w1, 34
	ccmp	w1, 0, 4, ne
	beq	.L36
.L14:
	add	x4, x2, 8
	add	x6, x7, x2
	cmp	x4, x8
	bcs	.L37
	add	x4, x3, 1
	add	x5, x2, 1
	cmp	w1, 92
	bne	.L16
	ldrb	w1, [x3, 1]
	add	x10, x7, x5
	cbz	w1, .L38
	add	x4, x3, 2
	cmp	w1, 114
	beq	.L26
	bhi	.L19
	cmp	w1, 102
	beq	.L27
	cmp	w1, 110
	beq	.L28
	cmp	w1, 98
	mov	w0, 8
	csel	w1, w1, w0, ne
	b	.L16
	.p2align 2,,3
.L19:
	cmp	w1, 116
	beq	.L29
	cmp	w1, 117
	bne	.L16
	mov	x0, x4
	str	x4, [sp, 16]
	str	w1, [sp, 24]
	stp	x8, x6, [sp, 32]
	stp	x5, x7, [sp, 48]
	stp	x9, x3, [sp, 64]
	stp	x2, x10, [sp, 80]
	bl	strlen
	ldr	w1, [sp, 24]
	ldr	x4, [sp, 16]
	cmp	x0, 3
	ldp	x8, x6, [sp, 32]
	ldp	x5, x7, [sp, 48]
	ldp	x9, x3, [sp, 64]
	ldp	x2, x10, [sp, 80]
	bls	.L16
	mov	w0, 92
	strb	w0, [x6]
	strb	w1, [x10]
	add	x2, x2, 6
	add	x3, x3, 6
	ldr	w0, [x3, -4]
	str	w0, [x6, 2]
	b	.L21
	.p2align 2,,3
.L37:
	ldrb	w1, [x3]
.L15:
	cmp	w1, 34
	cinc	x3, x3, eq
.L18:
	strb	wzr, [x6]
	str	x3, [x9]
.L11:
	mov	x0, x7
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L28:
	mov	w1, 10
	b	.L16
	.p2align 2,,3
.L29:
	mov	w1, 9
	b	.L16
	.p2align 2,,3
.L24:
	mov	x7, 0
	mov	x0, x7
	ret
	.p2align 2,,3
.L27:
	mov	w1, 12
	b	.L16
	.p2align 2,,3
.L26:
	mov	w1, 13
	b	.L16
	.p2align 2,,3
.L36:
	add	x6, x7, x2
	b	.L15
	.p2align 2,,3
.L38:
	mov	w0, 92
	mov	x3, x4
	strb	w0, [x6]
	mov	x6, x10
	b	.L18
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"\"%s\""
	.text
	.align	2
	.p2align 5,,15
	.type	find_key, %function
find_key:
	stp	x29, x30, [sp, -128]!
	mov	x3, x2
	adrp	x2, .LC0
	mov	x29, sp
	add	x2, x2, :lo12:.LC0
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x20, x1
	add	x0, sp, 32
	mov	x1, 96
	bl	snprintf
	.p2align 5,,15
.L40:
	mov	x0, x19
	add	x1, sp, 32
	bl	strstr
	mov	x19, x0
	cbz	x0, .L39
	cmp	x0, x20
	bcs	.L52
	add	x0, sp, 32
	bl	strlen
	add	x19, x19, x0
	cmp	x20, x19
	bls	.L40
	bl	__ctype_b_loc
	ldr	x2, [x0]
	b	.L42
	.p2align 2,,3
.L43:
	add	x19, x19, 1
	cmp	x20, x19
	beq	.L40
.L42:
	ldrb	w0, [x19]
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x2, x1]
	tbnz	x1, 13, .L43
	cmp	x20, x19
	bls	.L40
	cmp	w0, 58
	bne	.L40
	add	x19, x19, 1
.L39:
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 128
	ret
.L52:
	mov	x19, 0
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 128
	ret
	.align	2
	.p2align 5,,15
	.type	object_array, %function
object_array:
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x3
	mov	x22, x1
	stp	x19, x20, [sp, 16]
	mov	x20, x4
	bl	find_key
	str	xzr, [x21]
	str	xzr, [x20]
	cbz	x0, .L60
	mov	x19, x0
	cmp	x0, x22
	bcs	.L81
	bl	__ctype_b_loc
	ldr	x2, [x0]
	b	.L58
	.p2align 2,,3
.L59:
	add	x19, x19, 1
	cmp	x19, x22
	beq	.L82
.L58:
	ldrb	w0, [x19]
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x2, x1]
	tbnz	x1, 13, .L59
.L57:
	cmp	w0, 91
	bne	.L60
	add	x19, x19, 1
	str	x19, [sp, 72]
	cmp	x19, x22
	bcs	.L62
	str	x23, [sp, 48]
	.p2align 5,,15
.L61:
	bl	__ctype_b_loc
	ldr	x3, [x0]
	mov	w0, 0
	b	.L66
	.p2align 2,,3
.L84:
	mov	x23, x19
.L66:
	ldrb	w1, [x19]
	mov	w2, w0
	cmp	w1, 44
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x3, x0]
	and	w0, w0, 8192
	ccmp	w0, 0, 0, ne
	cset	w0, ne
	beq	.L83
	add	x19, x19, 1
	cmp	x19, x22
	bne	.L84
.L78:
	ldr	x23, [sp, 48]
.L60:
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L83:
	cbz	w2, .L64
	str	x23, [sp, 72]
.L64:
	cmp	w1, 93
	beq	.L78
	cmp	w1, 34
	bne	.L80
	add	x0, sp, 72
	bl	parse_json_string
	ldr	x1, [x20]
	mov	x19, x0
	ldr	x0, [x21]
	add	x1, x1, 1
	lsl	x1, x1, 3
	bl	realloc
	cmp	x19, 0
	ccmp	x0, 0, 4, ne
	beq	.L85
	ldr	x1, [x20]
	str	x0, [x21]
	add	x2, x1, 1
	str	x2, [x20]
	str	x19, [x0, x1, lsl 3]
	ldr	x19, [sp, 72]
	cmp	x19, x22
	bcc	.L61
.L80:
	ldr	x23, [sp, 48]
.L62:
	mov	w0, 0
.L86:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
.L82:
	ldrb	w0, [x19]
	ldp	x21, x22, [sp, 32]
	cmp	w0, 91
	ldp	x19, x20, [sp, 16]
	cset	w0, ne
	ldp	x29, x30, [sp], 80
	ret
.L85:
	mov	x0, x19
	bl	free
	ldr	x23, [sp, 48]
	mov	w0, 0
	b	.L86
.L81:
	ldrb	w0, [x0]
	b	.L57
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	""
	.align	3
.LC2:
	.string	"null"
	.text
	.align	2
	.p2align 5,,15
	.type	object_string, %function
object_string:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x1
	bl	find_key
	str	x0, [sp, 56]
	cbz	x0, .L101
	mov	x19, x0
	cmp	x0, x20
	bcs	.L95
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x2, [x0]
	mov	w1, 0
	b	.L90
	.p2align 2,,3
.L91:
	add	x19, x19, 1
	mov	w1, 1
	cmp	x19, x20
	beq	.L102
	mov	x21, x19
.L90:
	ldrb	w0, [x19]
	ldrh	w0, [x2, x0, lsl 1]
	tbnz	x0, 13, .L91
	cbz	w1, .L92
	str	x21, [sp, 56]
.L92:
	sub	x20, x20, x19
	cmp	x20, 3
	ble	.L93
	adrp	x1, .LC2
	mov	x0, x19
	add	x1, x1, :lo12:.LC2
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L103
.L93:
	ldr	x21, [sp, 32]
	mov	x20, x19
.L89:
	ldrb	w0, [x20]
	cmp	w0, 34
	bne	.L101
	add	x0, sp, 56
	bl	parse_json_string
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L101:
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC1
	ldp	x29, x30, [sp], 64
	add	x0, x0, :lo12:.LC1
	b	strdup
	.p2align 2,,3
.L102:
	ldr	x21, [sp, 32]
	str	x20, [sp, 56]
	b	.L89
	.p2align 2,,3
.L103:
	ldr	x21, [sp, 32]
	adrp	x0, .LC1
	ldp	x19, x20, [sp, 16]
	add	x0, x0, :lo12:.LC1
	ldp	x29, x30, [sp], 64
	b	strdup
.L95:
	mov	x20, x0
	b	.L89
	.align	2
	.p2align 5,,15
	.type	object_long, %function
object_long:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x1
	bl	find_key
	cbz	x0, .L105
	mov	x3, x0
	cmp	x19, x0
	bls	.L106
	str	x0, [sp, 40]
	bl	__ctype_b_loc
	ldr	x1, [x0]
	ldr	x3, [sp, 40]
	b	.L107
	.p2align 2,,3
.L108:
	add	x3, x3, 1
	cmp	x19, x3
	beq	.L106
.L107:
	ldrb	w0, [x3]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L108
.L106:
	ldr	x19, [sp, 16]
	mov	x0, x3
	ldp	x29, x30, [sp], 48
	mov	w2, 10
	mov	x1, 0
	b	strtol
	.p2align 2,,3
.L105:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"unknown error"
	.text
	.align	2
	.p2align 5,,15
	.type	set_error, %function
set_error:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	beq	.L117
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	cbz	x2, .L115
	mov	x0, x2
	stp	x2, x1, [sp, 32]
	bl	strlen
	ldp	x3, x1, [sp, 32]
	mov	x20, x0
.L113:
	cmp	x1, x20
	sub	x0, x1, #1
	csel	x20, x0, x20, ls
	mov	x1, x3
	mov	x2, x20
	mov	x0, x19
	bl	memcpy
	strb	wzr, [x19, x20]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L117:
	ret
	.p2align 2,,3
.L115:
	adrp	x3, .LC3
	mov	x20, 13
	add	x3, x3, :lo12:.LC3
	b	.L113
	.section	.rodata.str1.8
	.align	3
.LC4:
	.string	"15"
	.align	3
.LC5:
	.string	"--connect-timeout"
	.align	3
.LC6:
	.string	"--location"
	.align	3
.LC7:
	.string	"--show-error"
	.align	3
.LC8:
	.string	"--silent"
	.align	3
.LC9:
	.string	"--fail"
	.align	3
.LC10:
	.string	"curl"
	.align	3
.LC11:
	.string	"60"
	.align	3
.LC12:
	.string	"--max-time"
	.align	3
.LC13:
	.string	"out of memory"
	.align	3
.LC14:
	.string	"AUR RPC HTTP request failed"
	.text
	.align	2
	.p2align 5,,15
	.type	curl_get.constprop.0, %function
curl_get.constprop.0:
	mov	x12, 8336
	sub	sp, sp, x12
	stp	x29, x30, [sp, 32]
	add	x29, sp, 32
	stp	x19, x20, [sp, 48]
	mov	x19, x0
	mov	x20, x1
	stp	x21, x22, [sp, 64]
	add	x0, sp, 136
	stp	x23, x24, [sp, 80]
	mov	x23, x2
	stp	x25, x26, [sp, 96]
	mov	x25, x3
	str	xzr, [x1]
	bl	pipe
	cbnz	w0, .L148
	mov	w22, w0
	bl	fork
	mov	w24, w0
	tbnz	w0, #31, .L149
	str	x27, [sp, 112]
	cbz	w0, .L150
	ldr	w0, [sp, 140]
	mov	x19, 0
	mov	x21, 0
	bl	close
	ldr	w0, [sp, 136]
	add	x1, sp, 144
	mov	x2, 8192
	bl	read
	mov	x26, x0
	cmp	x0, 0
	ble	.L151
	.p2align 5,,15
.L135:
	add	x27, x26, x21
	add	x3, x27, 1
	cmp	x3, x19
	bls	.L152
	cbnz	x19, .L130
	mov	x19, 8192
	cmp	x3, x19
	bls	.L131
	.p2align 5,,15
.L130:
	lsl	x19, x19, 1
	cmp	x3, x19
	bhi	.L130
.L131:
	ldr	x0, [x20]
	mov	x1, x19
	bl	realloc
	cbz	x0, .L133
	str	x0, [x20]
.L128:
	mov	x2, x26
	add	x1, sp, 144
	add	x0, x0, x21
	bl	memcpy
	ldr	x0, [x20]
	add	x1, sp, 144
	mov	x2, 8192
	mov	x21, x27
	strb	wzr, [x0, x27]
	ldr	w0, [sp, 136]
	bl	read
	mov	x26, x0
	cmp	x0, 0
	bgt	.L135
.L151:
	ldr	w0, [sp, 136]
	bl	close
	b	.L137
	.p2align 2,,3
.L153:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L136
.L137:
	add	x1, sp, 132
	mov	w0, w24
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L153
.L136:
	ldr	w2, [sp, 132]
	mov	w1, 65407
	ldr	x0, [x20]
	tst	w2, w1
	bne	.L154
	cbz	x0, .L155
.L139:
	cmp	x0, 0
	ldr	x27, [sp, 112]
	cset	w22, ne
	b	.L120
	.p2align 2,,3
.L150:
	ldr	w0, [sp, 136]
	bl	close
	ldr	w0, [sp, 140]
	mov	w1, 1
	bl	dup2
	tbnz	w0, #31, .L147
	ldr	w0, [sp, 140]
	bl	close
	stp	x19, xzr, [sp, 16]
	adrp	x2, .LC11
	adrp	x0, .LC12
	add	x2, x2, :lo12:.LC11
	add	x0, x0, :lo12:.LC12
	stp	x0, x2, [sp]
	adrp	x1, .LC10
	add	x1, x1, :lo12:.LC10
	adrp	x7, .LC4
	adrp	x6, .LC5
	adrp	x5, .LC6
	adrp	x4, .LC7
	adrp	x3, .LC8
	adrp	x2, .LC9
	add	x7, x7, :lo12:.LC4
	add	x6, x6, :lo12:.LC5
	add	x5, x5, :lo12:.LC6
	add	x4, x4, :lo12:.LC7
	add	x3, x3, :lo12:.LC8
	add	x2, x2, :lo12:.LC9
	mov	x0, x1
	bl	execlp
.L147:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L152:
	ldr	x0, [x20]
	b	.L128
	.p2align 2,,3
.L148:
	bl	__errno_location
	ldr	w0, [x0]
	mov	w22, 0
	bl	strerror
	mov	x2, x0
	mov	x1, x25
	mov	x0, x23
	bl	set_error
.L120:
	ldp	x29, x30, [sp, 32]
	mov	w0, w22
	ldp	x19, x20, [sp, 48]
	mov	x12, 8336
	ldp	x21, x22, [sp, 64]
	ldp	x23, x24, [sp, 80]
	ldp	x25, x26, [sp, 96]
	add	sp, sp, x12
	ret
.L133:
	ldr	w0, [sp, 136]
	bl	close
	mov	w1, 15
	mov	w0, w24
	bl	kill
	mov	w2, 0
	mov	x1, 0
	mov	w0, w24
	bl	waitpid
	ldr	x0, [x20]
	bl	free
	str	xzr, [x20]
	cmp	x23, 0
	ccmp	x25, 0, 4, ne
	beq	.L146
	cmp	x25, 14
	mov	x19, 14
	csel	x19, x25, x19, ls
	mov	x0, x23
	sub	x19, x19, #1
	adrp	x1, .LC13
	mov	x2, x19
	add	x1, x1, :lo12:.LC13
	bl	memcpy
	strb	wzr, [x23, x19]
	ldr	x27, [sp, 112]
	b	.L120
.L149:
	ldr	w0, [sp, 136]
	bl	close
	ldr	w0, [sp, 140]
	bl	close
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x2, x0
	mov	x1, x25
	mov	x0, x23
	bl	set_error
	b	.L120
.L154:
	bl	free
	str	xzr, [x20]
	cmp	x23, 0
	ccmp	x25, 0, 4, ne
	bne	.L156
.L146:
	ldr	x27, [sp, 112]
	b	.L120
.L156:
	cmp	x25, 28
	mov	x0, 28
	csel	x19, x25, x0, ls
	adrp	x1, .LC14
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC14
	mov	x2, x19
	mov	x0, x23
	bl	memcpy
	strb	wzr, [x23, x19]
	ldr	x27, [sp, 112]
	b	.L120
.L155:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	strdup
	str	x0, [x20]
	b	.L139
	.section	.rodata.str1.8
	.align	3
.LC15:
	.string	"search"
	.align	3
.LC16:
	.string	"%s/search/%s?by=name-desc"
	.align	3
.LC17:
	.string	"%s/info?arg[]=%s"
	.align	3
.LC18:
	.string	"\"results\""
	.align	3
.LC19:
	.string	"invalid AUR RPC response"
	.align	3
.LC20:
	.string	"truncated AUR RPC object"
	.align	3
.LC21:
	.string	"Name"
	.align	3
.LC22:
	.string	"PackageBase"
	.align	3
.LC23:
	.string	"Version"
	.align	3
.LC24:
	.string	"Description"
	.align	3
.LC25:
	.string	"URL"
	.align	3
.LC26:
	.string	"Maintainer"
	.align	3
.LC27:
	.string	"NumVotes"
	.align	3
.LC28:
	.string	"Popularity"
	.align	3
.LC29:
	.string	"OutOfDate"
	.align	3
.LC30:
	.string	"Depends"
	.align	3
.LC31:
	.string	"MakeDepends"
	.align	3
.LC32:
	.string	"CheckDepends"
	.align	3
.LC33:
	.string	"Provides"
	.align	3
.LC34:
	.string	"Conflicts"
	.align	3
.LC35:
	.string	"cannot parse AUR package metadata"
	.align	3
.LC36:
	.string	"truncated AUR RPC results"
	.text
	.align	2
	.p2align 5,,15
	.type	request, %function
request:
	stp	x29, x30, [sp, -256]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x2
	mov	x20, x3
	stp	x21, x22, [sp, 32]
	mov	x21, x4
	mov	x22, x5
	stp	x23, x24, [sp, 48]
	mov	x23, x1
	stp	x25, x26, [sp, 64]
	mov	x25, x0
	mov	x0, x2
	bl	strlen
	mov	x24, x0
	add	x0, x0, x0, lsl 1
	add	x0, x0, 1
	bl	malloc
	cbz	x0, .L158
	mov	x26, x0
	mov	x3, x0
	cbz	x24, .L160
	bl	__ctype_b_loc
	ldr	x7, [x0]
	adrp	x8, .LANCHOR0
	mov	x2, x19
	add	x6, x19, x24
	add	x8, x8, :lo12:.LANCHOR0
	mov	x3, 0
	mov	w9, 37
	b	.L166
	.p2align 2,,3
.L276:
	sub	w0, w1, #45
	cmp	w1, 95
	and	w0, w0, 255
	ccmp	w0, 1, 0, ne
	bls	.L163
	cmp	w1, 126
	beq	.L163
	lsr	w5, w1, 4
	and	w1, w1, 15
	add	x0, x3, 2
	strb	w9, [x26, x3]
	add	x2, x2, 1
	add	x3, x3, 3
	ldrb	w5, [x8, w5, sxtw]
	ldrb	w1, [x8, w1, sxtw]
	strb	w5, [x26, x4]
	strb	w1, [x26, x0]
	cmp	x6, x2
	beq	.L275
	.p2align 5,,15
.L166:
	ldrb	w1, [x2]
	add	x4, x3, 1
	add	x5, x26, x3
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x7, x0]
	tbz	x0, 3, .L276
.L163:
	add	x2, x2, 1
	strb	w1, [x5]
	mov	x3, x4
	cmp	x6, x2
	bne	.L166
.L275:
	add	x3, x26, x3
.L160:
	strb	wzr, [x3]
	mov	x0, x25
	stp	xzr, xzr, [x20]
	str	xzr, [sp, 96]
	bl	strlen
	mov	x24, x0
	mov	x0, x23
	bl	strlen
	add	x24, x24, x0
	mov	x0, x26
	bl	strlen
	add	x19, x0, 32
	add	x19, x19, x24
	mov	x0, x19
	bl	malloc
	mov	x24, x0
	cbz	x0, .L277
	mov	x0, x23
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	bl	strcmp
	mov	x4, x26
	mov	x3, x25
	cbz	w0, .L278
	adrp	x2, .LC17
	mov	x1, x19
	add	x2, x2, :lo12:.LC17
	mov	x0, x24
	bl	snprintf
.L171:
	mov	x0, x26
	bl	free
	mov	x3, x22
	mov	x2, x21
	add	x1, sp, 96
	mov	x0, x24
	bl	curl_get.constprop.0
	mov	w23, w0
	ldr	x25, [sp, 96]
	cbz	w0, .L172
	adrp	x1, .LC18
	mov	x0, x25
	add	x1, x1, :lo12:.LC18
	bl	strstr
	cbz	x0, .L173
	mov	w1, 91
	bl	strchr
	cbz	x0, .L173
	ldrb	w1, [x0, 1]
	cbz	w1, .L176
	add	x19, x0, 1
	str	x27, [sp, 80]
	.p2align 5,,15
.L273:
	mov	x27, x19
	cmp	w1, 123
	bne	.L198
	b	.L197
	.p2align 2,,3
.L178:
	ldrb	w1, [x27, 1]!
	cmp	w1, 123
	ccmp	w1, 0, 4, ne
	beq	.L177
.L198:
	cmp	w1, 93
	bne	.L178
	ldr	x27, [sp, 80]
.L179:
	mov	x0, x24
	bl	free
	mov	x0, x25
	bl	free
	mov	w0, w23
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 256
	ret
.L278:
	mov	x1, x19
	mov	x0, x24
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	snprintf
	b	.L171
	.p2align 2,,3
.L177:
	cbz	w1, .L279
.L197:
	mov	x19, x27
	mov	w3, 0
	mov	w1, 123
	b	.L188
	.p2align 2,,3
.L187:
	mov	x19, x2
	cmp	w1, 125
	beq	.L280
.L185:
	ldrb	w1, [x19]
	cbz	w1, .L182
.L188:
	add	x2, x19, 1
	cmp	w1, 34
	beq	.L281
	cmp	w1, 123
	bne	.L187
	mov	x19, x2
	add	w3, w3, 1
	ldrb	w1, [x19]
	cbnz	w1, .L188
	.p2align 5,,15
.L182:
	cbnz	w3, .L282
.L180:
	movi	v31.4s, 0
	add	x0, sp, 104
	mov	x1, x19
	adrp	x2, .LC21
	add	x2, x2, :lo12:.LC21
	stp	q31, q31, [x0]
	add	x0, sp, 136
	stp	q31, q31, [x0]
	add	x0, sp, 168
	stp	q31, q31, [x0]
	add	x0, sp, 200
	stp	q31, q31, [x0]
	mov	x0, x27
	str	q31, [sp, 232]
	str	xzr, [sp, 248]
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC22
	add	x2, x2, :lo12:.LC22
	str	x0, [sp, 104]
	mov	x0, x27
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC23
	add	x2, x2, :lo12:.LC23
	str	x0, [sp, 112]
	mov	x0, x27
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC24
	add	x2, x2, :lo12:.LC24
	str	x0, [sp, 120]
	mov	x0, x27
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC25
	add	x2, x2, :lo12:.LC25
	str	x0, [sp, 128]
	mov	x0, x27
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	str	x0, [sp, 136]
	mov	x0, x27
	bl	object_string
	mov	x1, x19
	adrp	x2, .LC27
	add	x2, x2, :lo12:.LC27
	str	x0, [sp, 144]
	mov	x0, x27
	bl	object_long
	mov	x1, x19
	adrp	x2, .LC28
	add	x2, x2, :lo12:.LC28
	str	x0, [sp, 152]
	mov	x0, x27
	bl	find_key
	mov	x26, x0
	cbz	x0, .L205
	cmp	x19, x0
	bls	.L190
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L191
	.p2align 2,,3
.L192:
	add	x26, x26, 1
	cmp	x19, x26
	beq	.L190
.L191:
	ldrb	w0, [x26]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L192
.L190:
	mov	x0, x26
	mov	x1, 0
	bl	strtod
.L189:
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	str	d0, [sp, 160]
	bl	object_long
	str	x0, [sp, 168]
	ldr	x0, [sp, 104]
	cbz	x0, .L193
	ldr	x0, [sp, 112]
	cbz	x0, .L193
	ldr	x0, [sp, 120]
	cbz	x0, .L193
	ldr	x0, [sp, 128]
	cbz	x0, .L193
	ldr	x0, [sp, 136]
	cbz	x0, .L193
	ldr	x0, [sp, 144]
	cbz	x0, .L193
	adrp	x2, .LC30
	add	x4, sp, 184
	add	x3, sp, 176
	add	x2, x2, :lo12:.LC30
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L193
	adrp	x2, .LC31
	add	x4, sp, 200
	add	x3, sp, 192
	add	x2, x2, :lo12:.LC31
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbnz	w0, .L283
	.p2align 5,,15
.L193:
	add	x0, sp, 104
	bl	package_destroy
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L270
	cmp	x22, 34
	mov	x19, 34
	csel	x19, x22, x19, ls
	mov	x0, x21
	sub	x19, x19, #1
	adrp	x1, .LC35
	mov	x2, x19
	add	x1, x1, :lo12:.LC35
	bl	memcpy
	strb	wzr, [x21, x19]
	ldr	x27, [sp, 80]
	.p2align 5,,15
.L172:
	ldr	x0, [x20, 8]
	cbz	x0, .L199
	mov	x21, 0
	mov	x19, 0
	.p2align 5,,15
.L200:
	ldr	x0, [x20]
	add	x19, x19, 1
	add	x0, x0, x21
	bl	package_destroy
	ldr	x0, [x20, 8]
	add	x21, x21, 152
	cmp	x19, x0
	bcc	.L200
.L199:
	ldr	x0, [x20]
	mov	w23, 0
	bl	free
	stp	xzr, xzr, [x20]
	b	.L179
	.p2align 2,,3
.L280:
	subs	w3, w3, #1
	bne	.L185
	b	.L180
	.p2align 2,,3
.L281:
	ldrb	w0, [x19, 1]
	cbz	w0, .L202
	.p2align 5,,15
.L186:
	add	x1, x2, 1
	ldrb	w4, [x2, 1]
	mov	x19, x1
	cmp	w0, 92
	beq	.L284
	cmp	w0, 34
	beq	.L185
	mov	w0, w4
.L184:
	mov	x2, x1
	cbnz	w0, .L186
	mov	x19, x1
	cbz	w3, .L180
	b	.L282
	.p2align 2,,3
.L284:
	cbz	w4, .L182
	ldrb	w0, [x2, 2]
	add	x1, x1, 1
	b	.L184
.L282:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	bne	.L285
	.p2align 5,,15
.L270:
	ldr	x27, [sp, 80]
	b	.L172
	.p2align 2,,3
.L205:
	movi	d0, #0
	b	.L189
.L283:
	adrp	x2, .LC32
	add	x4, sp, 216
	add	x3, sp, 208
	add	x2, x2, :lo12:.LC32
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L193
	adrp	x2, .LC33
	add	x4, sp, 232
	add	x3, sp, 224
	add	x2, x2, :lo12:.LC33
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L193
	adrp	x2, .LC34
	add	x4, sp, 248
	add	x3, sp, 240
	add	x2, x2, :lo12:.LC34
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L193
	ldp	x0, x1, [x20]
	add	x1, x1, 1
	add	x2, x1, x1, lsl 3
	add	x1, x1, x2, lsl 1
	lsl	x1, x1, 3
	bl	realloc
	mov	x2, x0
	cbz	x0, .L193
	ldr	x1, [x20, 8]
	add	x3, sp, 104
	add	x0, x1, 1
	stp	x2, x0, [x20]
	add	x0, x1, x1, lsl 3
	ldp	q26, q28, [x3]
	add	x3, sp, 136
	add	x0, x1, x0, lsl 1
	ldp	q27, q30, [x3]
	add	x3, sp, 168
	lsl	x1, x0, 3
	add	x0, x2, x0, lsl 3
	ldp	q29, q31, [x3]
	str	q26, [x2, x1]
	add	x1, sp, 200
	stp	q28, q27, [x0, 16]
	stp	q30, q29, [x0, 48]
	str	q31, [x0, 80]
	ldr	q31, [sp, 232]
	ldp	q30, q29, [x1]
	ldr	x1, [sp, 248]
	str	x1, [x0, 144]
	stp	q30, q29, [x0, 96]
	str	q31, [x0, 128]
	ldrb	w1, [x19]
	cbnz	w1, .L273
	ldr	x27, [sp, 80]
.L176:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L172
	cmp	x22, 26
	mov	x0, 26
	csel	x19, x22, x0, ls
	adrp	x1, .LC36
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC36
	mov	x2, x19
	mov	x0, x21
	bl	memcpy
	strb	wzr, [x21, x19]
	b	.L172
.L279:
	mov	x19, x27
	b	.L180
.L158:
	stp	xzr, xzr, [x20]
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L161
.L272:
	cmp	x22, 14
	mov	x19, 14
	csel	x19, x22, x19, ls
	mov	x0, x21
	sub	x19, x19, #1
	adrp	x1, .LC13
	mov	x2, x19
	add	x1, x1, :lo12:.LC13
	bl	memcpy
	strb	wzr, [x21, x19]
.L161:
	mov	w23, 0
.L286:
	ldp	x19, x20, [sp, 16]
	mov	w0, w23
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 256
	ret
.L202:
	mov	x19, x2
	cbz	w3, .L180
	b	.L282
	.p2align 2,,3
.L173:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L172
	cmp	x22, 25
	mov	x19, 25
	csel	x19, x22, x19, ls
	mov	x0, x21
	sub	x19, x19, #1
	adrp	x1, .LC19
	mov	x2, x19
	add	x1, x1, :lo12:.LC19
	bl	memcpy
	strb	wzr, [x21, x19]
	b	.L172
.L285:
	cmp	x22, 25
	mov	x19, 25
	csel	x19, x22, x19, ls
	mov	x0, x21
	sub	x19, x19, #1
	adrp	x1, .LC20
	mov	x2, x19
	add	x1, x1, :lo12:.LC20
	bl	memcpy
	strb	wzr, [x21, x19]
	ldr	x27, [sp, 80]
	b	.L172
.L277:
	mov	x0, x26
	bl	free
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	bne	.L272
	mov	w23, 0
	b	.L286
	.align	2
	.p2align 5,,15
	.global	aur_response_destroy
	.type	aur_response_destroy, %function
aur_response_destroy:
	cbz	x0, .L299
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x21, [sp, 32]
	mov	x21, x0
	ldr	x0, [x0, 8]
	cbz	x0, .L289
	stp	x19, x20, [sp, 16]
	mov	x20, 0
	mov	x19, 0
	.p2align 5,,15
.L290:
	ldr	x0, [x21]
	add	x19, x19, 1
	add	x0, x0, x20
	bl	package_destroy
	ldr	x0, [x21, 8]
	add	x20, x20, 152
	cmp	x19, x0
	bcc	.L290
	ldp	x19, x20, [sp, 16]
.L289:
	ldr	x0, [x21]
	bl	free
	stp	xzr, xzr, [x21]
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L299:
	ret
	.section	.rodata.str1.8
	.align	3
.LC37:
	.string	"https://aur.archlinux.org/rpc/v5"
	.text
	.align	2
	.p2align 5,,15
	.global	aur_rpc_search
	.type	aur_rpc_search, %function
aur_rpc_search:
	cbz	x0, .L305
	mov	x5, x4
	mov	x4, x3
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	b	request
	.p2align 2,,3
.L305:
	mov	x5, x4
	adrp	x0, .LC37
	mov	x4, x3
	add	x0, x0, :lo12:.LC37
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	b	request
	.section	.rodata.str1.8
	.align	3
.LC38:
	.string	"info"
	.text
	.align	2
	.p2align 5,,15
	.global	aur_rpc_info
	.type	aur_rpc_info, %function
aur_rpc_info:
	cbz	x0, .L309
	mov	x5, x4
	mov	x4, x3
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC38
	add	x1, x1, :lo12:.LC38
	b	request
	.p2align 2,,3
.L309:
	mov	x5, x4
	adrp	x0, .LC37
	mov	x4, x3
	add	x0, x0, :lo12:.LC37
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC38
	add	x1, x1, :lo12:.LC38
	b	request
	.section	.rodata
	.align	4
	.set	.LANCHOR0,. + 0
	.type	hex.0, %object
hex.0:
	.string	"0123456789ABCDEF"
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
