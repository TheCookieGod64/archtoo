	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	" --noconfirm"
	.align	3
.LC1:
	.string	""
	.align	3
.LC2:
	.string	"\033[1;34m>>> Removing leftover pacman download fragments...\n\033[0m"
	.align	3
.LC3:
	.string	"find /var/cache/pacman/pkg -maxdepth 1 \\( -type f -o -type d \\) -name 'download-*' -exec rm -rf {} + 2>/dev/null || true"
	.align	3
.LC4:
	.string	"\033[1;34m>>> Cleaning uninstalled package cache...\n\033[0m"
	.align	3
.LC5:
	.string	"%spacman -Sc%s"
	.align	3
.LC6:
	.string	"\033[1;31m[-] pacman cache clean failed (exit %d).\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_clean_v2
	.type	cmd_clean_v2, %function
cmd_clean_v2:
	sub	sp, sp, #544
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	stp	x29, x30, [sp]
	mov	x29, sp
	bl	printf
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	run_cmd
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	printf
	bl	priv_prefix
	str	x0, [sp, 24]
	bl	use_noconfirm
	ldr	x3, [sp, 24]
	cbz	w0, .L4
	adrp	x4, .LC0
	add	x4, x4, :lo12:.LC0
.L2:
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 512
	add	x0, sp, 32
	bl	xsnprintf
	add	x0, sp, 32
	bl	run_cmd
	mov	w2, w0
	mov	w0, 1
	cbnz	w2, .L9
	ldp	x29, x30, [sp]
	add	sp, sp, 544
	ret
	.p2align 2,,3
.L4:
	adrp	x4, .LC1
	add	x4, x4, :lo12:.LC1
	b	.L2
	.p2align 2,,3
.L9:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC6
	add	x1, x1, :lo12:.LC6
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp]
	mov	w0, 0
	add	sp, sp, 544
	ret
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
