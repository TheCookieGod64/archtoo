	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	package_destroy, %function
package_destroy:
	stp	x29, x30, [sp, -160]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x20, sp, 64
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	stp	x23, x24, [sp, 48]
	add	x24, sp, 112
	mov	x23, 1
	ldr	x0, [x0]
	bl	free
	ldr	x0, [x22, 8]
	bl	free
	ldr	x0, [x22, 16]
	bl	free
	ldr	x0, [x22, 24]
	bl	free
	ldr	x0, [x22, 32]
	bl	free
	ldr	x0, [x22, 40]
	bl	free
	ldr	x4, [x22, 80]
	add	x9, x22, 72
	ldr	x3, [x22, 96]
	add	x8, x22, 88
	ldr	x2, [x22, 112]
	add	x7, x22, 104
	ldr	x1, [x22, 128]
	add	x6, x22, 120
	ldr	x0, [x22, 144]
	add	x5, x22, 136
	stp	x9, x8, [sp, 64]
	stp	x7, x6, [sp, 80]
	str	x5, [sp, 96]
	stp	x4, x3, [sp, 112]
	stp	x2, x1, [sp, 128]
	str	x0, [sp, 144]
.L2:
	add	x0, x24, x23, lsl 3
	mov	x19, 0
	ldr	x21, [x0, -8]
	cbz	x21, .L5
	.p2align 5,,15
.L3:
	ldr	x1, [x20]
	ldr	x1, [x1]
	ldr	x0, [x1, x19, lsl 3]
	add	x19, x19, 1
	bl	free
	cmp	x19, x21
	bne	.L3
.L5:
	ldr	x0, [x20], 8
	add	x23, x23, 1
	ldr	x0, [x0]
	bl	free
	cmp	x23, 6
	bne	.L2
	movi	v31.4s, 0
	str	xzr, [x22, 144]
	stp	q31, q31, [x22]
	stp	q31, q31, [x22, 32]
	stp	q31, q31, [x22, 64]
	stp	q31, q31, [x22, 96]
	str	q31, [x22, 128]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 160
	ret
	.align	2
	.p2align 5,,15
	.type	parse_json_string, %function
parse_json_string:
	stp	x29, x30, [sp, -80]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	mov	x25, x0
	ldr	x20, [x0]
	ldrb	w0, [x20]
	cmp	w0, 34
	bne	.L14
	mov	x0, x20
	bl	strlen
	add	x0, x0, 1
	bl	malloc
	mov	x24, x0
	cbz	x0, .L14
	stp	x21, x22, [sp, 32]
	add	x20, x20, 1
	ldrb	w19, [x20]
	cmp	w19, 34
	ccmp	w19, 0, 4, ne
	beq	.L22
	mov	x21, 0
	b	.L20
	.p2align 2,,3
.L16:
	add	x20, x20, 1
.L17:
	mov	x21, x23
	strb	w19, [x22]
.L19:
	ldrb	w19, [x20]
	cmp	w19, 34
	ccmp	w19, 0, 4, ne
	beq	.L35
.L20:
	add	x22, x24, x21
	add	x23, x21, 1
	cmp	w19, 92
	bne	.L16
	ldrb	w19, [x20, 1]
	add	x26, x20, 2
	cmp	w19, 114
	beq	.L23
	bhi	.L18
	cmp	w19, 102
	beq	.L24
	cmp	w19, 110
	beq	.L25
	cmp	w19, 98
	mov	w0, 8
	mov	x20, x26
	csel	w19, w19, w0, ne
	b	.L17
	.p2align 2,,3
.L18:
	cmp	w19, 116
	beq	.L27
	cmp	w19, 117
	bne	.L29
	mov	x0, x26
	bl	strlen
	cmp	x0, 3
	bhi	.L36
.L29:
	mov	x20, x26
	b	.L17
	.p2align 2,,3
.L35:
	add	x21, x24, x21
.L15:
	cmp	w19, 34
	strb	wzr, [x21]
	cinc	x20, x20, eq
	str	x20, [x25]
	mov	x0, x24
	ldp	x21, x22, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L14:
	mov	x24, 0
	mov	x0, x24
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 80
	ret
	.p2align 2,,3
.L27:
	mov	x20, x26
	mov	w19, 9
	b	.L17
	.p2align 2,,3
.L23:
	mov	x20, x26
	mov	w19, 13
	b	.L17
	.p2align 2,,3
.L25:
	mov	x20, x26
	mov	w19, 10
	b	.L17
	.p2align 2,,3
.L24:
	mov	x20, x26
	mov	w19, 12
	b	.L17
	.p2align 2,,3
.L22:
	mov	x21, x0
	b	.L15
.L36:
	mov	w0, 92
	strb	w0, [x22]
	strb	w19, [x24, x23]
	add	x21, x21, 6
	add	x20, x20, 6
	ldr	w0, [x20, -4]
	str	w0, [x22, 2]
	b	.L19
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"\"%s\""
	.text
	.align	2
	.p2align 5,,15
	.type	find_key, %function
find_key:
	stp	x29, x30, [sp, -144]!
	mov	x3, x2
	adrp	x2, .LC0
	mov	x29, sp
	add	x2, x2, :lo12:.LC0
	str	x21, [sp, 32]
	add	x21, sp, 48
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	mov	x20, x1
	mov	x0, x21
	mov	x1, 96
	bl	snprintf
	.p2align 5,,15
.L38:
	mov	x0, x19
	mov	x1, x21
	bl	strstr
	cmp	x0, 0
	mov	x19, x0
	ccmp	x0, x20, 2, ne
	bcs	.L46
	mov	x0, x21
	bl	strlen
	add	x19, x19, x0
	cmp	x20, x19
	bls	.L38
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L40
	.p2align 2,,3
.L41:
	add	x19, x19, 1
	cmp	x20, x19
	beq	.L38
.L40:
	ldrb	w0, [x19]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L41
	cmp	x20, x19
	bls	.L38
	ldrb	w0, [x19]
	cmp	w0, 58
	bne	.L38
	ldr	x21, [sp, 32]
	add	x0, x19, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 144
	ret
.L46:
	ldr	x21, [sp, 32]
	mov	x0, 0
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 144
	ret
	.align	2
	.p2align 5,,15
	.type	object_array, %function
object_array:
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x3
	mov	x22, x1
	stp	x19, x20, [sp, 16]
	mov	x20, x4
	bl	find_key
	str	xzr, [x21]
	str	xzr, [x20]
	cbz	x0, .L57
	mov	x19, x0
	cmp	x0, x22
	bcs	.L77
	bl	__ctype_b_loc
	ldr	x3, [x0]
	b	.L52
	.p2align 2,,3
.L53:
	cmp	x0, x22
	beq	.L78
	mov	x19, x0
.L52:
	ldrb	w1, [x19]
	add	x0, x19, 1
	ubfiz	x2, x1, 1, 8
	ldrh	w2, [x3, x2]
	tbnz	x2, 13, .L53
.L51:
	cmp	w1, 91
	bne	.L57
.L81:
	add	x19, x19, 1
	stp	x23, x24, [sp, 48]
	add	x23, sp, 88
	str	x19, [sp, 88]
	cmp	x19, x22
	bcs	.L56
	str	x25, [sp, 64]
	.p2align 5,,15
.L55:
	bl	__ctype_b_loc
	ldr	x3, [x0]
	mov	w5, 0
	.p2align 5,,15
.L62:
	ldrb	w2, [x19]
	mov	w1, w5
	add	x19, x19, 1
	cmp	w2, 44
	ubfiz	x0, x2, 1, 8
	ldrh	w0, [x3, x0]
	and	w0, w0, 8192
	ccmp	w0, 0, 0, ne
	cset	w5, ne
	beq	.L79
	mov	x24, x19
	cmp	x19, x22
	bne	.L62
.L74:
	ldp	x23, x24, [sp, 48]
	ldr	x25, [sp, 64]
.L57:
	mov	w0, 1
.L47:
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 96
	ret
	.p2align 2,,3
.L79:
	cbz	w1, .L59
	str	x24, [sp, 88]
.L59:
	cmp	w2, 93
	beq	.L74
	cmp	w2, 34
	bne	.L76
	mov	x0, x23
	bl	parse_json_string
	ldr	x1, [x20]
	mov	x25, x0
	ldr	x0, [x21]
	add	x1, x1, 1
	lsl	x1, x1, 3
	bl	realloc
	cmp	x25, 0
	ccmp	x0, 0, 4, ne
	beq	.L80
	ldr	x1, [x20]
	str	x0, [x21]
	ldr	x19, [sp, 88]
	add	x2, x1, 1
	str	x2, [x20]
	str	x25, [x0, x1, lsl 3]
	cmp	x19, x22
	bcc	.L55
.L76:
	ldr	x25, [sp, 64]
.L56:
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	b	.L47
.L78:
	ldrb	w1, [x19, 1]
	mov	x19, x22
	cmp	w1, 91
	bne	.L57
	b	.L81
.L80:
	mov	x0, x25
	bl	free
	ldr	x25, [sp, 64]
	b	.L56
.L77:
	ldrb	w1, [x0]
	b	.L51
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
	cbz	x0, .L97
	mov	x19, x0
	cmp	x0, x20
	bcs	.L84
	str	x21, [sp, 32]
	bl	__ctype_b_loc
	ldr	x2, [x0]
	mov	w1, 0
	b	.L85
	.p2align 2,,3
.L87:
	add	x19, x19, 1
	mov	w1, 1
	mov	x21, x19
	cmp	x19, x20
	beq	.L98
.L85:
	ldrb	w0, [x19]
	ldrh	w0, [x2, x0, lsl 1]
	tbnz	x0, 13, .L87
	cbz	w1, .L88
	str	x21, [sp, 56]
.L88:
	sub	x20, x20, x19
	cmp	x20, 3
	ble	.L96
	adrp	x1, .LC2
	mov	x0, x19
	add	x1, x1, :lo12:.LC2
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L99
.L96:
	ldr	x21, [sp, 32]
.L84:
	ldrb	w0, [x19]
	cmp	w0, 34
	beq	.L89
.L97:
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC1
	ldp	x29, x30, [sp], 64
	add	x0, x0, :lo12:.LC1
	b	strdup
	.p2align 2,,3
.L89:
	add	x0, sp, 56
	bl	parse_json_string
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L98:
	ldrb	w0, [x19]
	str	x19, [sp, 56]
	ldr	x21, [sp, 32]
	cmp	w0, 34
	beq	.L89
	b	.L97
	.p2align 2,,3
.L99:
	ldr	x21, [sp, 32]
	adrp	x0, .LC1
	ldp	x19, x20, [sp, 16]
	add	x0, x0, :lo12:.LC1
	ldp	x29, x30, [sp], 64
	b	strdup
	.align	2
	.p2align 5,,15
	.type	object_long, %function
object_long:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x1
	bl	find_key
	cbz	x0, .L101
	mov	x19, x0
	cmp	x20, x0
	bls	.L102
	bl	__ctype_b_loc
	ldr	x1, [x0]
	b	.L103
	.p2align 2,,3
.L104:
	add	x19, x19, 1
	cmp	x20, x19
	beq	.L102
.L103:
	ldrb	w0, [x19]
	ldrh	w0, [x1, x0, lsl 1]
	tbnz	x0, 13, .L104
.L102:
	mov	x0, x19
	mov	w2, 10
	ldp	x19, x20, [sp, 16]
	mov	x1, 0
	ldp	x29, x30, [sp], 32
	b	strtol
	.p2align 2,,3
.L101:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
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
	beq	.L113
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x1
	mov	x20, x2
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	cbz	x2, .L111
	mov	x0, x2
	bl	strlen
	mov	x22, x0
.L109:
	cmp	x19, x22
	sub	x19, x19, #1
	csel	x22, x19, x22, ls
	mov	x1, x20
	mov	x2, x22
	mov	x0, x21
	bl	memcpy
	strb	wzr, [x21, x22]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L113:
	ret
	.p2align 2,,3
.L111:
	adrp	x20, .LC3
	mov	x22, 13
	add	x20, x20, :lo12:.LC3
	b	.L109
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
	add	x0, sp, 136
	stp	x21, x22, [sp, 64]
	mov	x21, x1
	stp	x25, x26, [sp, 96]
	mov	x26, x2
	mov	x25, x3
	str	xzr, [x1]
	bl	pipe
	cbnz	w0, .L146
	stp	x23, x24, [sp, 80]
	bl	fork
	mov	w24, w0
	cmp	w0, 0
	blt	.L147
	str	x27, [sp, 112]
	beq	.L148
	ldr	w0, [sp, 140]
	add	x23, sp, 144
	mov	x19, 0
	mov	x22, 0
	bl	close
	ldr	w0, [sp, 136]
	mov	x1, x23
	mov	x2, 8192
	bl	read
	mov	x20, x0
	cmp	x0, 0
	ble	.L149
	.p2align 5,,15
.L132:
	add	x27, x20, x22
	add	x4, x27, 1
	cmp	x4, x19
	bls	.L150
	cbnz	x19, .L127
	mov	x19, 8192
	cmp	x4, x19
	bls	.L128
	.p2align 5,,15
.L127:
	lsl	x19, x19, 1
	cmp	x4, x19
	bhi	.L127
.L128:
	ldr	x0, [x21]
	mov	x1, x19
	bl	realloc
	cbz	x0, .L151
	str	x0, [x21]
.L125:
	mov	x2, x20
	add	x0, x0, x22
	mov	x1, x23
	bl	memcpy
	ldr	x0, [x21]
	mov	x1, x23
	mov	x2, 8192
	mov	x22, x27
	strb	wzr, [x0, x27]
	ldr	w0, [sp, 136]
	bl	read
	mov	x20, x0
	cmp	x0, 0
	bgt	.L132
.L149:
	ldr	w0, [sp, 136]
	add	x19, sp, 132
	bl	close
	b	.L134
	.p2align 2,,3
.L152:
	bl	__errno_location
	ldr	w0, [x0]
	cmp	w0, 4
	bne	.L133
.L134:
	mov	x1, x19
	mov	w0, w24
	mov	w2, 0
	bl	waitpid
	tbnz	w0, #31, .L152
.L133:
	ldr	w2, [sp, 132]
	mov	w1, 65407
	ldr	x0, [x21]
	tst	w2, w1
	bne	.L153
	cbz	x0, .L154
.L137:
	cmp	x0, 0
	mov	x12, 8336
	ldr	x27, [sp, 112]
	cset	w0, ne
	ldp	x23, x24, [sp, 80]
	ldp	x29, x30, [sp, 32]
	ldp	x19, x20, [sp, 48]
	ldp	x21, x22, [sp, 64]
	ldp	x25, x26, [sp, 96]
	add	sp, sp, x12
	ret
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
	adrp	x1, .LC11
	adrp	x0, .LC12
	add	x1, x1, :lo12:.LC11
	add	x0, x0, :lo12:.LC12
	stp	x0, x1, [sp]
	adrp	x1, .LC10
	add	x1, x1, :lo12:.LC10
	adrp	x7, .LC4
	adrp	x6, .LC5
	adrp	x5, .LC6
	adrp	x4, .LC7
	adrp	x3, .LC8
	adrp	x2, .LC9
	mov	x0, x1
	add	x7, x7, :lo12:.LC4
	add	x6, x6, :lo12:.LC5
	add	x5, x5, :lo12:.LC6
	add	x4, x4, :lo12:.LC7
	add	x3, x3, :lo12:.LC8
	add	x2, x2, :lo12:.LC9
	bl	execlp
.L145:
	mov	w0, 127
	bl	_exit
	.p2align 2,,3
.L150:
	ldr	x0, [x21]
	b	.L125
	.p2align 2,,3
.L146:
	bl	__errno_location
	ldr	w0, [x0]
	bl	strerror
	mov	x2, x0
	mov	x1, x25
	mov	x0, x26
	bl	set_error
.L118:
	ldp	x29, x30, [sp, 32]
	mov	w0, 0
	ldp	x19, x20, [sp, 48]
	mov	x12, 8336
	ldp	x21, x22, [sp, 64]
	ldp	x25, x26, [sp, 96]
	add	sp, sp, x12
	ret
.L151:
	ldr	w0, [sp, 136]
	bl	close
	mov	w1, 15
	mov	w0, w24
	bl	kill
	mov	w2, 0
	mov	x1, 0
	mov	w0, w24
	bl	waitpid
	ldr	x0, [x21]
	bl	free
	str	xzr, [x21]
	cmp	x26, 0
	ccmp	x25, 0, 4, ne
	beq	.L143
	cmp	x25, 14
	mov	x19, 14
	csel	x19, x25, x19, ls
	adrp	x1, .LC13
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC13
.L144:
	mov	x2, x19
	mov	x0, x26
	bl	memcpy
	strb	wzr, [x26, x19]
	ldr	x27, [sp, 112]
	ldp	x23, x24, [sp, 80]
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
	mov	x0, x26
	bl	set_error
	ldp	x23, x24, [sp, 80]
	b	.L118
.L143:
	ldr	x27, [sp, 112]
	ldp	x23, x24, [sp, 80]
	b	.L118
.L153:
	bl	free
	str	xzr, [x21]
	cmp	x26, 0
	ccmp	x25, 0, 4, ne
	beq	.L143
	cmp	x25, 28
	mov	x0, 28
	csel	x19, x25, x0, ls
	adrp	x1, .LC14
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC14
	b	.L144
.L154:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	strdup
	str	x0, [x21]
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
	mov	x24, x1
	stp	x25, x26, [sp, 64]
	mov	x25, x0
	mov	x0, x2
	bl	strlen
	mov	x23, x0
	add	x0, x0, x0, lsl 1
	add	x0, x0, 1
	bl	malloc
	cbz	x0, .L156
	mov	x26, x0
	mov	x5, x0
	cbz	x23, .L158
	bl	__ctype_b_loc
	ldr	x8, [x0]
	adrp	x9, .LANCHOR0
	mov	x2, x19
	add	x6, x19, x23
	add	x9, x9, :lo12:.LANCHOR0
	mov	x5, 0
	mov	w11, 37
	b	.L164
	.p2align 2,,3
.L277:
	cmp	w3, 95
	ccmp	w1, 1, 0, ne
	bls	.L161
	lsr	w10, w3, 4
	and	w1, w3, 15
	add	x0, x5, 2
	cmp	w3, 126
	beq	.L161
	ldrb	w3, [x9, w10, sxtw]
	add	x2, x2, 1
	strb	w11, [x26, x5]
	add	x5, x5, 3
	ldrb	w1, [x9, w1, sxtw]
	strb	w3, [x26, x4]
	strb	w1, [x26, x0]
	cmp	x6, x2
	beq	.L276
	.p2align 5,,15
.L164:
	ldrb	w3, [x2]
	add	x4, x5, 1
	add	x7, x26, x5
	sub	w1, w3, #45
	ubfiz	x0, x3, 1, 8
	and	w1, w1, 255
	ldrh	w0, [x8, x0]
	tbz	x0, 3, .L277
.L161:
	add	x2, x2, 1
	strb	w3, [x7]
	mov	x5, x4
	cmp	x6, x2
	bne	.L164
.L276:
	add	x5, x26, x5
.L158:
	strb	wzr, [x5]
	mov	x0, x25
	stp	xzr, xzr, [x20]
	str	xzr, [sp, 96]
	bl	strlen
	mov	x19, x0
	mov	x0, x24
	bl	strlen
	mov	x23, x0
	mov	x0, x26
	bl	strlen
	add	x1, x19, x23
	add	x19, x0, 32
	add	x19, x19, x1
	mov	x0, x19
	bl	malloc
	mov	x23, x0
	cbz	x0, .L278
	mov	x0, x24
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	bl	strcmp
	mov	x3, x25
	mov	x1, x19
	cbz	w0, .L279
	adrp	x2, .LC17
	mov	x4, x26
	add	x2, x2, :lo12:.LC17
	mov	x0, x23
	bl	snprintf
.L169:
	mov	x0, x26
	bl	free
	mov	x3, x22
	mov	x2, x21
	add	x1, sp, 96
	mov	x0, x23
	bl	curl_get.constprop.0
	mov	w24, w0
	ldr	x25, [sp, 96]
	cbz	w0, .L173
	adrp	x1, .LC18
	mov	x0, x25
	add	x1, x1, :lo12:.LC18
	bl	strstr
	cbz	x0, .L171
	mov	w1, 91
	bl	strchr
	cbz	x0, .L171
	ldrb	w1, [x0, 1]
	add	x19, x0, 1
	cbz	w1, .L175
	stp	x27, x28, [sp, 80]
	.p2align 5,,15
.L274:
	mov	x27, x19
	cmp	w1, 123
	bne	.L200
	b	.L199
	.p2align 2,,3
.L177:
	ldrb	w1, [x27, 1]!
	cmp	w1, 123
	ccmp	w1, 0, 4, ne
	beq	.L176
.L200:
	cmp	w1, 93
	bne	.L177
	ldp	x27, x28, [sp, 80]
.L178:
	mov	x0, x23
	bl	free
	mov	x0, x25
	bl	free
	mov	w0, w24
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 256
	ret
.L279:
	mov	x4, x26
	mov	x0, x23
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	bl	snprintf
	b	.L169
	.p2align 2,,3
.L176:
	cbz	w1, .L280
.L199:
	mov	x19, x27
	mov	w3, 0
	mov	w1, 123
	.p2align 5,,15
.L188:
	add	x2, x19, 1
	cmp	w1, 34
	beq	.L281
	cmp	w1, 123
	beq	.L282
	cmp	w1, 125
	beq	.L283
.L187:
	mov	x19, x2
.L184:
	ldrb	w1, [x19]
	cbnz	w1, .L188
	.p2align 5,,15
.L203:
	cbnz	w3, .L284
.L179:
	movi	v31.4s, 0
	add	x28, sp, 104
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC21
	add	x2, x2, :lo12:.LC21
	str	xzr, [x28, 144]
	stp	q31, q31, [x28]
	stp	q31, q31, [x28, 32]
	stp	q31, q31, [x28, 64]
	stp	q31, q31, [x28, 96]
	str	q31, [x28, 128]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC22
	add	x2, x2, :lo12:.LC22
	str	x3, [sp, 104]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC23
	add	x2, x2, :lo12:.LC23
	str	x3, [sp, 112]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC24
	add	x2, x2, :lo12:.LC24
	str	x3, [sp, 120]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC25
	add	x2, x2, :lo12:.LC25
	str	x3, [sp, 128]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	str	x3, [sp, 136]
	bl	object_string
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC27
	add	x2, x2, :lo12:.LC27
	str	x3, [sp, 144]
	bl	object_long
	mov	x3, x0
	mov	x1, x19
	mov	x0, x27
	adrp	x2, .LC28
	add	x2, x2, :lo12:.LC28
	str	x3, [sp, 152]
	bl	find_key
	mov	x26, x0
	cbz	x0, .L207
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
	cbz	x0, .L194
	ldr	x0, [sp, 112]
	cbz	x0, .L194
	ldr	x0, [sp, 120]
	cbz	x0, .L194
	ldr	x0, [sp, 128]
	cbz	x0, .L194
	ldr	x0, [sp, 136]
	cbz	x0, .L194
	ldr	x0, [sp, 144]
	cbz	x0, .L194
	adrp	x2, .LC30
	add	x4, sp, 184
	add	x2, x2, :lo12:.LC30
	add	x3, sp, 176
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L194
	adrp	x2, .LC31
	add	x4, sp, 200
	add	x2, x2, :lo12:.LC31
	add	x3, sp, 192
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbnz	w0, .L285
	.p2align 5,,15
.L194:
	mov	x0, x28
	bl	package_destroy
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L272
	cmp	x22, 34
	mov	x19, 34
	csel	x19, x22, x19, ls
	adrp	x1, .LC35
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC35
.L275:
	mov	x2, x19
	mov	x0, x21
	bl	memcpy
	strb	wzr, [x21, x19]
	ldp	x27, x28, [sp, 80]
	b	.L173
	.p2align 2,,3
.L283:
	subs	w3, w3, #1
	bne	.L187
	mov	x19, x2
	b	.L179
	.p2align 2,,3
.L282:
	add	w3, w3, 1
	b	.L187
	.p2align 2,,3
.L281:
	ldrb	w0, [x19, 1]
	cbz	w0, .L205
	.p2align 5,,15
.L185:
	add	x1, x2, 1
	mov	x19, x1
	cmp	w0, 92
	beq	.L286
	ldrb	w2, [x2, 1]
	cmp	w0, 34
	beq	.L184
	mov	w0, w2
.L183:
	mov	x2, x1
	cbnz	w0, .L185
	mov	x19, x1
	b	.L203
	.p2align 2,,3
.L286:
	ldrb	w0, [x2, 1]
	cbz	w0, .L203
	ldrb	w0, [x2, 2]
	add	x1, x1, 1
	b	.L183
.L284:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	bne	.L287
	.p2align 5,,15
.L272:
	ldp	x27, x28, [sp, 80]
.L173:
	mov	x21, 0
	ldr	x0, [x20, 8]
	mov	x19, 0
	cbz	x0, .L202
	.p2align 5,,15
.L201:
	ldr	x0, [x20]
	add	x19, x19, 1
	add	x0, x0, x21
	bl	package_destroy
	ldr	x0, [x20, 8]
	add	x21, x21, 152
	cmp	x19, x0
	bcc	.L201
.L202:
	ldr	x0, [x20]
	mov	w24, 0
	bl	free
	stp	xzr, xzr, [x20]
	b	.L178
	.p2align 2,,3
.L207:
	movi	d0, #0
	b	.L189
.L285:
	adrp	x2, .LC32
	add	x4, sp, 216
	add	x2, x2, :lo12:.LC32
	add	x3, sp, 208
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L194
	adrp	x2, .LC33
	add	x4, sp, 232
	add	x2, x2, :lo12:.LC33
	add	x3, sp, 224
	mov	x1, x19
	mov	x0, x27
	bl	object_array
	cbz	w0, .L194
	adrp	x2, .LC34
	mov	x0, x27
	add	x4, sp, 248
	add	x2, x2, :lo12:.LC34
	add	x3, sp, 240
	mov	x1, x19
	bl	object_array
	cbz	w0, .L194
	ldp	x0, x1, [x20]
	add	x1, x1, 1
	add	x2, x1, x1, lsl 3
	add	x1, x1, x2, lsl 1
	lsl	x1, x1, 3
	bl	realloc
	mov	x2, x0
	cbz	x0, .L194
	ldr	x1, [x20, 8]
	add	x0, x1, 1
	stp	x2, x0, [x20]
	add	x0, x1, x1, lsl 3
	ldp	q26, q28, [x28]
	add	x0, x1, x0, lsl 1
	ldp	q29, q31, [x28, 64]
	lsl	x1, x0, 3
	ldp	q27, q30, [x28, 32]
	add	x0, x2, x0, lsl 3
	str	q26, [x2, x1]
	stp	q28, q27, [x0, 16]
	stp	q30, q29, [x0, 48]
	str	q31, [x0, 80]
	ldr	q31, [x28, 128]
	ldp	q30, q29, [x28, 96]
	ldr	x1, [x28, 144]
	str	x1, [x0, 144]
	stp	q30, q29, [x0, 96]
	str	q31, [x0, 128]
	ldrb	w1, [x19]
	cbnz	w1, .L274
	ldp	x27, x28, [sp, 80]
.L175:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L173
	cmp	x22, 26
	mov	x19, 26
	csel	x19, x22, x19, ls
	mov	x0, x21
	sub	x19, x19, #1
	adrp	x1, .LC36
	mov	x2, x19
	add	x1, x1, :lo12:.LC36
	bl	memcpy
	strb	wzr, [x21, x19]
	b	.L173
.L280:
	mov	x19, x27
	b	.L179
.L156:
	stp	xzr, xzr, [x20]
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	str	xzr, [sp, 96]
	beq	.L159
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
	mov	w24, 0
.L288:
	ldp	x19, x20, [sp, 16]
	mov	w0, w24
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp], 256
	ret
.L205:
	mov	x19, x2
	b	.L203
.L171:
	cmp	x21, 0
	ccmp	x22, 0, 4, ne
	beq	.L173
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
	b	.L173
.L287:
	cmp	x22, 25
	mov	x19, 25
	csel	x19, x22, x19, ls
	adrp	x1, .LC20
	sub	x19, x19, #1
	add	x1, x1, :lo12:.LC20
	b	.L275
.L278:
	mov	x0, x26
	bl	free
	mov	x1, x22
	mov	x0, x21
	adrp	x2, .LC13
	mov	w24, 0
	add	x2, x2, :lo12:.LC13
	bl	set_error
	b	.L288
	.align	2
	.p2align 5,,15
	.global	aur_response_destroy
	.type	aur_response_destroy, %function
aur_response_destroy:
	cbz	x0, .L301
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x21, [sp, 32]
	mov	x21, x0
	ldr	x0, [x0, 8]
	cbz	x0, .L291
	stp	x19, x20, [sp, 16]
	mov	x20, 0
	mov	x19, 0
	.p2align 5,,15
.L292:
	ldr	x0, [x21]
	add	x19, x19, 1
	add	x0, x0, x20
	bl	package_destroy
	ldr	x0, [x21, 8]
	add	x20, x20, 152
	cmp	x19, x0
	bcc	.L292
	ldp	x19, x20, [sp, 16]
.L291:
	ldr	x0, [x21]
	bl	free
	stp	xzr, xzr, [x21]
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L301:
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
	mov	x5, x2
	mov	x7, x3
	cmp	x0, 0
	adrp	x6, .LC37
	add	x6, x6, :lo12:.LC37
	mov	x2, x1
	mov	x3, x5
	csel	x0, x6, x0, eq
	mov	x5, x4
	adrp	x1, .LC15
	mov	x4, x7
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
	mov	x5, x2
	mov	x7, x3
	cmp	x0, 0
	adrp	x6, .LC37
	add	x6, x6, :lo12:.LC37
	mov	x2, x1
	mov	x3, x5
	csel	x0, x6, x0, eq
	mov	x5, x4
	adrp	x1, .LC38
	mov	x4, x7
	add	x1, x1, :lo12:.LC38
	b	request
	.section	.rodata
	.align	4
	.set	.LANCHOR0,. + 0
	.type	hex.0, %object
hex.0:
	.string	"0123456789ABCDEF"
	.section	.note.GNU-stack,"",@progbits
