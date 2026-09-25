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
	mov	x7, x0
	ldrb	w0, [x1]
	cmp	w0, 34
	bne	.L24
	stp	x29, x30, [sp, -80]!
	mov	x0, x1
	mov	x29, sp
	stp	x1, x7, [sp, 16]
	bl	strlen
	add	x0, x0, 1
	bl	malloc
	mov	x6, x0
	cbz	x0, .L11
	ldp	x1, x7, [sp, 16]
	add	x2, x1, 1
	ldrb	w1, [x1, 1]
	cmp	w1, 34
	ccmp	w1, 0, 4, ne
	beq	.L25
	mov	x3, 0
	b	.L21
	.p2align 2,,3
.L15:
	add	x2, x2, 1
.L16:
	mov	x3, x5
	strb	w1, [x4]
.L20:
	ldrb	w1, [x2]
	cmp	w1, 34
	ccmp	w1, 0, 4, ne
	beq	.L36
.L21:
	add	x4, x6, x3
	add	x5, x3, 1
	cmp	w1, 92
	bne	.L15
	ldrb	w1, [x2, 1]
	add	x8, x2, 2
	cmp	w1, 114
	beq	.L26
	bhi	.L17
	cmp	w1, 102
	beq	.L27
	cmp	w1, 110
	beq	.L28
	cmp	w1, 98
	mov	w0, 8
	mov	x2, x8
	csel	w1, w1, w0, ne
	b	.L16
	.p2align 2,,3
.L36:
	add	x3, x6, x3
.L14:
	cmp	w1, 34
	strb	wzr, [x3]
	cinc	x2, x2, eq
	str	x2, [x7]
.L11:
	mov	x0, x6
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L17:
	cmp	w1, 116
	beq	.L30
	cmp	w1, 117
	bne	.L18
	mov	x0, x8
	str	x8, [sp, 16]
	str	w1, [sp, 24]
	stp	x4, x5, [sp, 32]
	stp	x6, x7, [sp, 48]
	stp	x2, x3, [sp, 64]
	bl	strlen
	ldr	w1, [sp, 24]
	ldr	x8, [sp, 16]
	cmp	x0, 3
	ldp	x4, x5, [sp, 32]
	ldp	x6, x7, [sp, 48]
	ldp	x2, x3, [sp, 64]
	bhi	.L19
.L18:
	mov	x2, x8
	b	.L16
	.p2align 2,,3
.L24:
	mov	x6, 0
	mov	x0, x6
	ret
	.p2align 2,,3
.L30:
	mov	x2, x8
	mov	w1, 9
	b	.L16
	.p2align 2,,3
.L26:
	mov	x2, x8
	mov	w1, 13
	b	.L16
	.p2align 2,,3
.L28:
	mov	x2, x8
	mov	w1, 10
	b	.L16
	.p2align 2,,3
.L27:
	mov	x2, x8
	mov	w1, 12
	b	.L16
	.p2align 2,,3
.L25:
	mov	x3, x0
	b	.L14
.L19:
	mov	w0, 92
	strb	w0, [x4]
	strb	w1, [x6, x5]
	add	x3, x3, 6
	add	x2, x2, 6
	ldr	w0, [x2, -4]
	str	w0, [x4, 2]
	b	.L20
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
.L38:
	mov	x0, x19
	add	x1, sp, 32
	bl	strstr
	mov	x19, x0
	cbz	x0, .L37
	cmp	x0, x20
	bcs	.L50
	add	x0, sp, 32
	bl	strlen
	add	x19, x19, x0
	cmp	x20, x19
	bls	.L38
	bl	__ctype_b_loc
	ldr	x2, [x0]
	b	.L40
	.p2align 2,,3
.L41:
	add	x19, x19, 1
	cmp	x20, x19
	beq	.L38
.L40:
	ldrb	w0, [x19]
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x2, x1]
	tbnz	x1, 13, .L41
	cmp	x20, x19
	bls	.L38
	cmp	w0, 58
	bne	.L38
	add	x19, x19, 1
.L37:
	mov	x0, x19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 128
	ret
.L50:
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
	cbz	x0, .L58
	mov	x19, x0
	cmp	x0, x22
	bcs	.L79
	bl	__ctype_b_loc
	ldr	x2, [x0]
	b	.L56
	.p2align 2,,3
.L57:
	add	x19, x19, 1
	cmp	x19, x22
	beq	.L80
.L56:
	ldrb	w0, [x19]
	ubfiz	x1, x0, 1, 8
	ldrh	w1, [x2, x1]
	tbnz	x1, 13, .L57
.L55:
	cmp	w0, 91
	bne	.L58
	add	x19, x19, 1
	str	x19, [sp, 72]
	cmp	x19, x22
	bcs	.L60
	str	x23, [sp, 48]
	.p2align 5,,15
.L59:
	bl	__ctype_b_loc
	ldr	x3, [x0]
	mov	w0, 0
	b	.L64
	.p2align 2,,3
.L82:
	mov	x23, x19
.L64:
	ldrb	w1, [x19]
	mov	w2, w0
	cmp	w1, 44
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x3, x0]
	and	w0, w0, 8192
	ccmp	w0, 0, 0, ne
	cset	w0, ne
	beq	.L81
	add	x19, x19, 1
	cmp	x19, x22
	bne	.L82
.L76:
	ldr	x23, [sp, 48]
.L58:
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L81:
	cbz	w2, .L62
	str	x23, [sp, 72]
.L62:
	cmp	w1, 93
	beq	.L76
	cmp	w1, 34
	bne	.L78
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
	beq	.L83
	ldr	x1, [x20]
	str	x0, [x21]
	add	x2, x1, 1
	str	x2, [x20]
	str	x19, [x0, x1, lsl 3]
	ldr	x19, [sp, 72]
	cmp	x19, x22
	bcc	.L59
.L78:
	ldr	x23, [sp, 48]
.L60:
	mov	w0, 0
.L84:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 80
	ret
.L80:
	ldrb	w0, [x19]
	ldp	x21, x22, [sp, 32]
	cmp	w0, 91
	ldp	x19, x20, [sp, 16]
	cset	w0, ne
	ldp	x29, x30, [sp], 80
	ret
.L83:
	mov	x0, x19
	bl	free
	ldr	x23, [sp, 48]
	mov	w0, 0
	b	.L84
.L79:
	ldrb	w0, [x0]
	b	.L55
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
	cbz	x0, .L99
	mov	x19, x0
	cmp	x0, x20
	bcs	.L93
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x2, [x0]
	mov	w1, 0
	b	.L88
	.p2align 2,,3
.L89:
	add	x19, x19, 1
	mov	w1, 1
	cmp	x19, x20
	beq	.L100
	mov	x21, x19
.L88:
	ldrb	w0, [x19]
	ldrh	w0, [x2, x0, lsl 1]
	tbnz	x0, 13, .L89
	cbz	w1, .L90
	str	x21, [sp, 56]
.L90:
	sub	x20, x20, x19
	cmp	x20, 3
	ble	.L91
	adrp	x1, .LC2
	mov	x0, x19
	add	x1, x1, :lo12:.LC2
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L101
.L91:
	ldr	x21, [sp, 32]
	mov	x20, x19
.L87:
	ldrb	w0, [x20]
	cmp	w0, 34
	bne	.L99
	add	x0, sp, 56
	bl	parse_json_string
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L99:
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC1
	ldp	x29, x30, [sp], 64
	add	x0, x0, :lo12:.LC1
	b	strdup
	.p2align 2,,3
.L100:
	ldr	x21, [sp, 32]
	str	x20, [sp, 56]
	b	.L87
	.p2align 2,,3
.L101:
	ldr	x21, [sp, 32]
	adrp	x0, .LC1
	ldp	x19, x20, [sp, 16]
	add	x0, x0, :lo12:.LC1
	ldp	x29, x30, [sp], 64
	b	strdup
.L93:
	mov	x20, x0
	b	.L87
	.align	2
	.p2align 5,,15
	.type	object_long, %function
object_long:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x1
	bl	find_key
	cbz	x0, .L103
	mov	x3, x0
	cmp	x19, x0
	bls	.L104
	str	x0, [sp, 40]
	bl	__ctype_b_loc
	ldr	x1, [x0]
	ldr	x3, [sp, 40]
	b	.L105
	.p2align 2,,3
.L106:
	add	x3, x3, 1
	cmp	x19, x3
	beq	.L104
.L105:
	ldrb	w0, [x3]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L106
.L104:
	ldr	x19, [sp, 16]
	mov	x0, x3
	ldp	x29, x30, [sp], 48
	mov	w2, 10
	mov	x1, 0
	b	strtol
	.p2align 2,,3
.L103:
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
	beq	.L115
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	cbz	x2, .L113
	mov	x0, x2
	stp	x2, x1, [sp, 32]
	bl	strlen
	ldp	x3, x1, [sp, 32]
	mov	x20, x0
.L111:
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
.L115:
	ret
	.p2align 2,,3
.L113:
	adrp	x3, .LC3
	mov	x20, 13
	add	x3, x3, :lo12:.LC3
	b	.L111
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
	cbnz	w0, .L146
	mov	w22, w0
	bl	fork
	mov	w24, w0
	tbnz	w0, #31, .L147
	str	x27, [sp, 112]
	cbz	w0, .L148
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
	ble	.L149
	.p2align 5,,15
.L133:
	add	x27, x26, x21
	add	x3, x27, 1
	cmp	x3, x19
	bls	.L150
	cbnz	x19, .L128
	mov	x19, 8192
	cmp	x3, x19
	bls	.L129
	.p2align 5,,15
.L128:
	lsl	x19, x19, 1
	cmp	x3, x19
	bhi	.L128
.L129:
	ldr	x0, [x20]
	mov	x1, x19
	bl	realloc
	cbz	x0, .L131
	str	x0, [x20]
.L126:
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
	bgt	.L133
.L149:
	ldr	w0, [sp, 136]
	bl	close
	b	.L135
	.p2align 2,,3
.L151:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L134
.L135:
	add	x1, sp, 132
	mov	w0, w24
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L151
.L134:
	ldr	w2, [sp, 132]
	mov	w1, 65407
	ldr	x0, [x20]
	tst	w2, w1
	bne	.L152
	cbz	x0, .L153
.L137:
	cmp	x0, 0
	ldr	x27, [sp, 112]
	cset	w22, ne
	b	.L118
	.p2align 2,,3
.L148:
	ldr	w0, [sp, 136]
	bl	close
	ldr	w0, [sp, 140]
	mov	w1, 1
	bl	dup2
	tbnz	w0, #31, .L145
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
.L145:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L150:
	ldr	x0, [x20]
	b	.L126
	.p2align 2,,3
.L146:
	bl	__errno_location
	ldr	w0, [x0]
	mov	w22, 0
	bl	strerror
	mov	x2, x0
	mov	x1, x25
	mov	x0, x23
	bl	set_error
.L118:
	ldp	x29, x30, [sp, 32]
	mov	w0, w22
	ldp	x19, x20, [sp, 48]
	mov	x12, 8336
	ldp	x21, x22, [sp, 64]
	ldp	x23, x24, [sp, 80]
	ldp	x25, x26, [sp, 96]
	add	sp, sp, x12
	ret
.L131:
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
	beq	.L144
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
	b	.L118
.L147:
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
	b	.L118
.L152:
	bl	free
	str	xzr, [x20]
	cmp	x23, 0
	ccmp	x25, 0, 4, ne
	bne	.L154
.L144:
	ldr	x27, [sp, 112]
	b	.L118
.L154:
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
	b	.L118
.L153:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	strdup
	str	x0, [x20]
	b	.L137
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
	cbz	x0, .L156
	mov	x26, x0
	mov	x3, x0
	cbz	x24, .L158
	bl	__ctype_b_loc
	ldr	x7, [x0]
	adrp	x8, .LANCHOR0
	mov	x2, x19
	add	x6, x19, x24
	add	x8, x8, :lo12:.LANCHOR0
	mov	x3, 0
	mov	w9, 37
	b	.L164
	.p2align 2,,3
.L274:
	sub	w0, w1, #45
	cmp	w1, 95
	and	w0, w0, 255
	ccmp	w0, 1, 0, ne
	bls	.L161
	cmp	w1, 126
	beq	.L161
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
	beq	.L273
	.p2align 5,,15
.L164:
	ldrb	w1, [x2]
	add	x4, x3, 1
	add	x5, x26, x3
	ubfiz	x0, x1, 1, 8
	ldrh	w0, [x7, x0]
	tbz	x0, 3, .L274
.L161:
	add	x2, x2, 1
	strb	w1, [x5]
	mov	x3, x4
	cmp	x6, x2
	bne	.L164
.L273:
	add	x3, x26, x3
.L158:
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
	cbz	x0, .L275
	mov	x0, x23
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	bl	strcmp
	mov	x4, x26
	mov	x3, x25
	cbz	w0, .L276
	adrp	x2, .LC17
	mov	x1, x19
	add	x2, x2, :lo12:.LC17
	mov	x0, x24
	bl	snprintf
.L169:
	mov	x0, x26
	bl	free
	mov	x3, x22
	mov	x2, x21
	add	x1, sp, 96
	mov	x0, x24
	bl	curl_get.constprop.0
	mov	w23, w0
	ldr	x25, [sp, 96]
	cbz	w0, .L170
	adrp	x1, .LC18
	mov	x0, x25
	add	x1, x1, :lo12:.LC18
	bl	strstr
	cbz	x0, .L171
	mov	w1, 91
	bl	strchr
	cbz	x0, .L171
	ldrb	w1, [x0, 1]
	cbz	w1, .L174
	add	x19, x0, 1
	str	x27, [sp, 80]
	.p2align 5,,15
.L271:
	mov	x27, x19
	cmp	w1, 123
	bne	.L196
	b	.L195
	.p2align 2,,3
.L176:
	ldrb	w1, [x27, 1]!
	cmp	w1, 123
	ccmp	w1, 0, 4, ne
	beq	.L175
.L196:
	cmp	w1, 93
	bne	.L176
	ldr	x27, [sp, 80]
.L177:
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
.L276:
	mov	x1, x19
	mov	x0, x24
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	snprintf
	b	.L169
	.p2align 2,,3
.L175:
	cbz	w1, .L277
.L195:
	mov	x19, x27
	mov	w3, 0
	mov	w1, 123
	b	.L186
	.p2align 2,,3
.L185:
	mov	x19, x2
	cmp	w1, 125
	beq	.L278
.L183:
	ldrb	w1, [x19]
	cbz	w1, .L180
.L186:
	add	x2, x19, 1
	cmp	w1, 34
	beq	.L279
	cmp	w1, 123
	bne	.L185
	mov	x19, x2
	add	w3, w3, 1
	ldrb	w1, [x19]
	cbnz	w1, .L186
	.p2align 5,,15
.L180:
	cbnz	w3, .L280
.L178:
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
	cbz	x0, .L203
	cmp	x19, x0
	bls	.L188
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L189
	.p2align 2,,3
.L190:
	add	x26, x26, 1
	cmp	x19, x26
	beq	.L188
.L189:
	ldrb	w0, [x26]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L190
.L188:
	mov	x0, x26
	mov	x1, 0
	bl	strtod
.L187:
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC29
	add	x2, x2, :lo12:.LC29
	str	d0, [sp, 160]
	bl	object_long
	str	x0, [sp, 168]
	ldr	x0, [sp, 104]
	cbz	x0, .L191
	ldr	x0, [sp, 112]
	cbz	x0, .L191
	ldr	x0, [sp, 120]
	cbz	x0, .L191
	ldr	x0, [sp, 128]
	cbz	x0, .L191
	ldr	x0, [sp, 136]
	cbz	x0, .L191
	ldr	x0, [sp, 144]
	cbz	x0, .L191
	adrp	x2, .LC30
	add	x4, sp, 184
	add	x3, sp, 176
	add	x2, x2, :lo12:.LC30
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L191
	adrp	x2, .LC31
	add	x4, sp, 200
	add	x3, sp, 192
	add	x2, x2, :lo12:.LC31
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbnz	w0, .L281
	.p2align 5,,15
.L191:
	add	x0, sp, 104
	bl	package_destroy
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L268
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
.L170:
	ldr	x0, [x20, 8]
	cbz	x0, .L197
	mov	x21, 0
	mov	x19, 0
	.p2align 5,,15
.L198:
	ldr	x0, [x20]
	add	x19, x19, 1
	add	x0, x0, x21
	bl	package_destroy
	ldr	x0, [x20, 8]
	add	x21, x21, 152
	cmp	x19, x0
	bcc	.L198
.L197:
	ldr	x0, [x20]
	mov	w23, 0
	bl	free
	stp	xzr, xzr, [x20]
	b	.L177
	.p2align 2,,3
.L278:
	subs	w3, w3, #1
	bne	.L183
	b	.L178
	.p2align 2,,3
.L279:
	ldrb	w0, [x19, 1]
	cbz	w0, .L200
	.p2align 5,,15
.L184:
	add	x1, x2, 1
	ldrb	w4, [x2, 1]
	mov	x19, x1
	cmp	w0, 92
	beq	.L282
	cmp	w0, 34
	beq	.L183
	mov	w0, w4
.L182:
	mov	x2, x1
	cbnz	w0, .L184
	mov	x19, x1
	cbz	w3, .L178
	b	.L280
	.p2align 2,,3
.L282:
	cbz	w4, .L180
	ldrb	w0, [x2, 2]
	add	x1, x1, 1
	b	.L182
.L280:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	bne	.L283
	.p2align 5,,15
.L268:
	ldr	x27, [sp, 80]
	b	.L170
	.p2align 2,,3
.L203:
	movi	d0, #0
	b	.L187
.L281:
	adrp	x2, .LC32
	add	x4, sp, 216
	add	x3, sp, 208
	add	x2, x2, :lo12:.LC32
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L191
	adrp	x2, .LC33
	add	x4, sp, 232
	add	x3, sp, 224
	add	x2, x2, :lo12:.LC33
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L191
	adrp	x2, .LC34
	add	x4, sp, 248
	add	x3, sp, 240
	add	x2, x2, :lo12:.LC34
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L191
	ldp	x0, x1, [x20]
	add	x1, x1, 1
	add	x2, x1, x1, lsl 3
	add	x1, x1, x2, lsl 1
	lsl	x1, x1, 3
	bl	realloc
	mov	x2, x0
	cbz	x0, .L191
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
	cbnz	w1, .L271
	ldr	x27, [sp, 80]
.L174:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L170
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
	b	.L170
.L277:
	mov	x19, x27
	b	.L178
.L156:
	stp	xzr, xzr, [x20]
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L159
.L270:
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
.L159:
	mov	w23, 0
.L284:
	ldp	x19, x20, [sp, 16]
	mov	w0, w23
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 256
	ret
.L200:
	mov	x19, x2
	cbz	w3, .L178
	b	.L280
	.p2align 2,,3
.L171:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L170
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
	b	.L170
.L283:
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
	b	.L170
.L275:
	mov	x0, x26
	bl	free
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	bne	.L270
	mov	w23, 0
	b	.L284
	.align	2
	.p2align 5,,15
	.global	aur_response_destroy
	.type	aur_response_destroy, %function
aur_response_destroy:
	cbz	x0, .L297
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x21, [sp, 32]
	mov	x21, x0
	ldr	x0, [x0, 8]
	cbz	x0, .L287
	stp	x19, x20, [sp, 16]
	mov	x20, 0
	mov	x19, 0
	.p2align 5,,15
.L288:
	ldr	x0, [x21]
	add	x19, x19, 1
	add	x0, x0, x20
	bl	package_destroy
	ldr	x0, [x21, 8]
	add	x20, x20, 152
	cmp	x19, x0
	bcc	.L288
	ldp	x19, x20, [sp, 16]
.L287:
	ldr	x0, [x21]
	bl	free
	stp	xzr, xzr, [x21]
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L297:
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
	cbz	x0, .L303
	mov	x5, x4
	mov	x4, x3
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	b	request
	.p2align 2,,3
.L303:
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
	cbz	x0, .L307
	mov	x5, x4
	mov	x4, x3
	mov	x3, x2
	mov	x2, x1
	adrp	x1, .LC38
	add	x1, x1, :lo12:.LC38
	b	request
	.p2align 2,,3
.L307:
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
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
