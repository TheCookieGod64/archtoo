	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"pacman -Qmq"
	.align	3
.LC1:
	.string	"\033[1;31m[-] Could not list foreign packages.\n\033[0m"
	.align	3
.LC2:
	.string	"\033[1;36m>>> Development / VCS packages (-git/-hg/-svn/-bzr/-cvs)\n\033[0m"
	.align	3
.LC3:
	.string	"-git"
	.align	3
.LC4:
	.string	"-hg"
	.align	3
.LC5:
	.string	"-svn"
	.align	3
.LC6:
	.string	"-bzr"
	.align	3
.LC7:
	.string	"-cvs"
	.align	3
.LC8:
	.string	"No development packages installed."
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_devel_v2
	.type	cmd_devel_v2, %function
cmd_devel_v2:
	stp	x29, x30, [sp, -256]!
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	add	x1, sp, 88
	str	xzr, [sp, 88]
	bl	run_cmd_capture
	cmp	w0, 1
	bhi	.L35
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	stp	x19, x20, [sp, 16]
	bl	printf
	ldr	x20, [sp, 88]
	cbz	x20, .L4
	stp	x23, x24, [sp, 48]
	mov	w24, 0
	ldrb	w0, [x20]
	cbz	w0, .L31
	adrp	x23, .LC3
	add	x23, x23, :lo12:.LC3
	stp	x21, x22, [sp, 32]
	str	x25, [sp, 64]
	adrp	x25, .LC4
	add	x25, x25, :lo12:.LC4
	b	.L5
	.p2align 2,,3
.L36:
	sub	x21, x0, x20
	sub	x0, x21, #1
	cmp	x0, 158
	bls	.L8
.L9:
	ldrb	w0, [x19, 1]
	add	x20, x19, 1
	cbz	w0, .L13
.L5:
	mov	x0, x20
	mov	w1, 10
	bl	strchr
	mov	x19, x0
	cbnz	x0, .L36
	mov	x0, x20
	bl	strlen
	mov	x21, x0
	sub	x0, x0, #1
	cmp	x0, 158
	bls	.L8
.L13:
	ldr	x0, [sp, 88]
	bl	free
	ldp	x21, x22, [sp, 32]
	cbz	w24, .L32
	ldp	x23, x24, [sp, 48]
	ldr	x25, [sp, 64]
.L14:
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 256
	ret
	.p2align 2,,3
.L8:
	add	x22, sp, 96
	mov	x2, x21
	mov	x1, x20
	mov	x0, x22
	bl	memcpy
	mov	x1, x23
	mov	x0, x22
	strb	wzr, [x22, x21]
	bl	strstr
	cbz	x0, .L37
.L11:
	mov	x0, x22
	mov	w24, 1
	bl	puts
	cbnz	x19, .L9
	b	.L13
	.p2align 2,,3
.L37:
	mov	x1, x25
	mov	x0, x22
	bl	strstr
	cbnz	x0, .L11
	adrp	x1, .LC5
	mov	x0, x22
	add	x1, x1, :lo12:.LC5
	bl	strstr
	cbnz	x0, .L11
	adrp	x1, .LC6
	mov	x0, x22
	add	x1, x1, :lo12:.LC6
	bl	strstr
	cbnz	x0, .L11
	adrp	x1, .LC7
	mov	x0, x22
	add	x1, x1, :lo12:.LC7
	bl	strstr
	cbnz	x0, .L11
	cbnz	x19, .L9
	b	.L13
	.p2align 2,,3
.L35:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 48
	mov	x1, 1
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	ldr	x3, [x3]
	bl	fwrite
	ldr	x0, [sp, 88]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 256
	ret
	.p2align 2,,3
.L32:
	ldp	x23, x24, [sp, 48]
	ldr	x25, [sp, 64]
.L6:
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	puts
	b	.L14
.L31:
	ldp	x23, x24, [sp, 48]
	.p2align 5,,15
.L4:
	mov	x0, x20
	bl	free
	b	.L6
	.section	.note.GNU-stack,"",@progbits
