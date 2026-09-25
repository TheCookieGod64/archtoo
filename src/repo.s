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
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L2
	mov	w3, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x19, .L15
.L3:
	mov	x2, x19
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	str	w3, [sp, 40]
	bl	fprintf
	ldr	w3, [sp, 40]
.L1:
	ldr	x19, [sp, 16]
	mov	w0, w3
	ldp	x29, x30, [sp]
	add	sp, sp, 1008
	ret
	.p2align 2,,3
.L2:
	add	x1, sp, 48
	mov	x0, x19
	mov	x2, 320
	bl	shell_quote
	mov	w3, w0
	cbz	w0, .L1
	mov	x1, x19
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	bl	priv_prefix
	str	x0, [sp, 40]
	bl	use_noconfirm
	ldr	x3, [sp, 40]
	cbnz	w0, .L16
	adrp	x4, .LC0
	add	x4, x4, :lo12:.LC0
.L5:
	add	x5, sp, 48
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x1, 640
	add	x0, sp, 368
	bl	xsnprintf
	add	x0, sp, 368
	bl	run_cmd
	mov	w3, 1
	cbz	w0, .L1
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	ldr	x0, [x0]
	bl	fprintf
	mov	w3, 0
	b	.L1
	.p2align 2,,3
.L15:
	adrp	x19, .LC0
	add	x19, x19, :lo12:.LC0
	b	.L3
	.p2align 2,,3
.L16:
	adrp	x4, .LC1
	add	x4, x4, :lo12:.LC1
	b	.L5
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
