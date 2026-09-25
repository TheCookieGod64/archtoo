	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"\033[1;31m[-] Review requires a directory.\n\033[0m"
	.align	3
.LC1:
	.string	"\033[1;31m[-] Directory does not exist: %s\n\033[0m"
	.align	3
.LC2:
	.string	"%s/PKGBUILD"
	.align	3
.LC3:
	.string	"\033[1;31m[-] No PKGBUILD in %s\n\033[0m"
	.align	3
.LC4:
	.string	"%s/.git"
	.align	3
.LC5:
	.string	"\033[1;36m>>> git diff (PKGBUILD / .SRCINFO)\n\033[0m"
	.align	3
.LC6:
	.string	"git -C %s diff -- PKGBUILD .SRCINFO"
	.align	3
.LC7:
	.string	"%s/.SRCINFO"
	.align	3
.LC8:
	.string	"\033[1;36m>>> .SRCINFO\n\033[0m"
	.align	3
.LC9:
	.string	"sed -n '1,120p' %s/.SRCINFO"
	.align	3
.LC10:
	.string	"\033[1;36m>>> PKGBUILD\n\033[0m"
	.align	3
.LC11:
	.string	"sed -n '1,240p' %s/PKGBUILD"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_review_v2
	.type	cmd_review_v2, %function
cmd_review_v2:
	mov	x12, 6720
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	cbz	x0, .L2
	str	x19, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L28
	mov	w1, 10
	bl	strchr
	cbz	x0, .L29
.L24:
	ldr	x19, [sp, 16]
.L5:
	mov	w3, 0
.L1:
	ldp	x29, x30, [sp]
	mov	w0, w3
	mov	x12, 6720
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L29:
	mov	x0, x19
	mov	w1, 13
	bl	strchr
	cbnz	x0, .L24
	mov	x0, x19
	bl	dir_exists
	cbz	w0, .L30
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 1200
	add	x0, sp, 1072
	bl	xsnprintf
	add	x0, sp, 1072
	bl	file_exists
	cbz	w0, .L31
	add	x1, sp, 48
	mov	x0, x19
	mov	x2, 1024
	bl	shell_quote
	mov	w3, w0
	cbz	w0, .L25
	mov	x3, x19
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x1, 1200
	add	x0, sp, 3472
	bl	xsnprintf
	add	x0, sp, 3472
	bl	dir_exists
	cbnz	w0, .L32
.L8:
	mov	x3, x19
	adrp	x2, .LC7
	add	x2, x2, :lo12:.LC7
	mov	x1, 1200
	add	x0, sp, 2272
	bl	xsnprintf
	add	x0, sp, 2272
	bl	file_exists
	cbnz	w0, .L33
.L9:
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	add	x3, sp, 48
	mov	x1, 2048
	adrp	x2, .LC11
	mov	x0, 4672
	add	x2, x2, :lo12:.LC11
	add	x0, sp, x0
	bl	xsnprintf
	mov	x1, 4672
	add	x0, sp, x1
	bl	run_cmd
	cmp	w0, 0
	ldr	x19, [sp, 16]
	cset	w3, eq
	b	.L1
	.p2align 2,,3
.L28:
	ldr	x19, [sp, 16]
.L2:
	mov	x2, 44
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	fwrite
	b	.L5
	.p2align 2,,3
.L31:
	adrp	x1, .LC3
	mov	x2, x19
	add	x1, x1, :lo12:.LC3
	str	w0, [sp, 44]
.L26:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	bl	fprintf
	ldr	x19, [sp, 16]
	ldr	w3, [sp, 44]
	b	.L1
	.p2align 2,,3
.L30:
	adrp	x1, .LC1
	mov	x2, x19
	add	x1, x1, :lo12:.LC1
	str	w0, [sp, 44]
	b	.L26
	.p2align 2,,3
.L25:
	ldr	x19, [sp, 16]
	b	.L1
.L33:
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	mov	x4, 4672
	add	x3, sp, 48
	add	x0, sp, x4
	mov	x1, 2048
	adrp	x2, .LC9
	add	x2, x2, :lo12:.LC9
	bl	xsnprintf
	mov	x5, 4672
	add	x0, sp, x5
	bl	run_cmd
	b	.L9
.L32:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	mov	x6, 4672
	add	x3, sp, 48
	add	x0, sp, x6
	mov	x1, 2048
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	bl	xsnprintf
	mov	x7, 4672
	add	x0, sp, x7
	bl	run_cmd
	b	.L8
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
