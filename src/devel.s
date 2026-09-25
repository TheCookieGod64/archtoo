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
	stp	x23, x24, [sp, 48]
	str	xzr, [sp, 88]
	bl	run_cmd_capture
	cmp	w0, 1
	bhi	.L28
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	stp	x19, x20, [sp, 16]
	bl	printf
	ldr	x20, [sp, 88]
	cbz	x20, .L5
	ldrb	w0, [x20]
	mov	w23, 0
	cbz	w0, .L5
	adrp	x24, .LC3
	adrp	x0, .LC4
	add	x24, x24, :lo12:.LC3
	stp	x21, x22, [sp, 32]
	str	x25, [sp, 64]
	add	x25, x0, :lo12:.LC4
	b	.L12
	.p2align 2,,3
.L29:
	sub	x21, x0, x20
	sub	x0, x21, #1
	cmp	x0, 158
	bls	.L7
.L8:
	ldrb	w0, [x19, 1]
	add	x20, x19, 1
	cbz	w0, .L13
.L12:
	mov	x0, x20
	mov	w1, 10
	bl	strchr
	mov	x19, x0
	cbnz	x0, .L29
	mov	x0, x20
	bl	strlen
	mov	x21, x0
	sub	x0, x0, #1
	cmp	x0, 158
	bls	.L7
.L13:
	ldr	x0, [sp, 88]
	bl	free
	cbz	w23, .L30
	ldr	x25, [sp, 64]
	mov	w0, w23
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 256
	ret
	.p2align 2,,3
.L7:
	add	x22, sp, 96
	mov	x2, x21
	mov	x1, x20
	mov	x0, x22
	bl	memcpy
	mov	x1, x24
	mov	x0, x22
	strb	wzr, [x22, x21]
	bl	strstr
	cbz	x0, .L31
.L10:
	mov	x0, x22
	mov	w23, 1
	bl	puts
	cbnz	x19, .L8
	b	.L13
	.p2align 2,,3
.L31:
	mov	x1, x25
	mov	x0, x22
	bl	strstr
	cbnz	x0, .L10
	adrp	x1, .LC5
	mov	x0, x22
	add	x1, x1, :lo12:.LC5
	bl	strstr
	cbnz	x0, .L10
	adrp	x1, .LC6
	mov	x0, x22
	add	x1, x1, :lo12:.LC6
	bl	strstr
	cbnz	x0, .L10
	adrp	x1, .LC7
	mov	x0, x22
	add	x1, x1, :lo12:.LC7
	bl	strstr
	cbnz	x0, .L10
	cbnz	x19, .L8
	b	.L13
	.p2align 2,,3
.L28:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 48
	mov	x1, 1
	mov	w23, 0
	ldr	x3, [x0]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	fwrite
	ldr	x0, [sp, 88]
	bl	free
	mov	w0, w23
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 256
	ret
	.p2align 2,,3
.L30:
	ldp	x21, x22, [sp, 32]
	ldr	x25, [sp, 64]
.L14:
	mov	w23, 1
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	puts
	mov	w0, w23
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 256
	ret
	.p2align 2,,3
.L5:
	mov	x0, x20
	bl	free
	b	.L14
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
