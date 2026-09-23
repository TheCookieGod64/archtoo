	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	""
	.align	3
.LC1:
	.string	" --noconfirm --ask=6"
	.align	3
.LC2:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC3:
	.string	"\033[1;34m>>> Installing repository package %s\n\033[0m"
	.align	3
.LC4:
	.string	"%spacman -S --needed%s -- %s"
	.align	3
.LC5:
	.string	"\033[1;31m[-] Could not install '%s' from repositories.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_repo_install_v2
	.type	cmd_repo_install_v2, %function
cmd_repo_install_v2:
	sub	sp, sp, #1008
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L2
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x19, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	adrp	x1, .LC2
	csel	x2, x2, x19, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L4:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1008
	ret
	.p2align 2,,3
.L2:
	add	x20, sp, 48
	mov	x0, x19
	mov	x1, x20
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L4
	mov	x1, x19
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	str	x21, [sp, 32]
	bl	printf
	bl	priv_prefix
	mov	x21, x0
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x2, .LC1
	adrp	x4, .LC0
	add	x2, x2, :lo12:.LC1
	add	x4, x4, :lo12:.LC0
	add	x1, sp, 368
	mov	x5, x20
	csel	x4, x4, x2, eq
	mov	x3, x21
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x20, x1
	mov	x0, x1
	mov	x1, 640
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L15
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1008
	ret
	.p2align 2,,3
.L15:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	ldr	x0, [x0]
	bl	fprintf
	ldr	x21, [sp, 32]
	b	.L4
	.section	.note.GNU-stack,"",@progbits
