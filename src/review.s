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
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L29
	mov	w1, 10
	bl	strchr
	cbz	x0, .L30
.L27:
	ldp	x19, x20, [sp, 16]
.L4:
	mov	w0, 0
.L1:
	ldp	x29, x30, [sp]
	mov	x12, 6720
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L30:
	mov	x0, x19
	mov	w1, 13
	bl	strchr
	cbnz	x0, .L27
	mov	x0, x19
	bl	dir_exists
	cbz	w0, .L31
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	add	x20, sp, 1072
	mov	x1, 1200
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	file_exists
	cbz	w0, .L32
	add	x20, sp, 48
	mov	x0, x19
	mov	x1, x20
	mov	x2, 1024
	bl	shell_quote
	cbz	w0, .L27
	mov	x3, x19
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x1, 1200
	str	x21, [sp, 32]
	add	x21, sp, 3472
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	dir_exists
	mov	x1, 4672
	add	x21, sp, x1
	cbnz	w0, .L33
.L10:
	mov	x3, x19
	adrp	x2, .LC7
	add	x2, x2, :lo12:.LC7
	add	x0, sp, 2272
	mov	x1, 1200
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	bl	file_exists
	cbnz	w0, .L34
.L11:
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	mov	x3, x20
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	cmp	w0, 0
	ldr	x21, [sp, 32]
	cset	w0, eq
	ldp	x19, x20, [sp, 16]
	b	.L1
	.p2align 2,,3
.L29:
	ldp	x19, x20, [sp, 16]
.L2:
	adrp	x0, .LC0
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 44
	mov	x1, 1
	add	x0, x0, :lo12:.LC0
	ldr	x3, [x3]
	bl	fwrite
	b	.L4
	.p2align 2,,3
.L32:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	b	.L4
	.p2align 2,,3
.L31:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC1
	add	x1, x1, :lo12:.LC1
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	b	.L4
.L34:
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	mov	x3, x20
	adrp	x2, .LC9
	add	x2, x2, :lo12:.LC9
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	b	.L11
.L33:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	mov	x3, x20
	adrp	x2, .LC6
	add	x2, x2, :lo12:.LC6
	mov	x1, 2048
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	run_cmd
	b	.L10
	.section	.note.GNU-stack,"",@progbits
