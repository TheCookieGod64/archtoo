	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"pacman -Qdtq"
	.align	3
.LC1:
	.string	"No orphaned packages."
	.align	3
.LC2:
	.string	"\033[1;31m[-] Could not query orphaned packages.\n\033[0m"
	.align	3
.LC3:
	.string	"\033[1;36m>>> Orphaned dependencies (installed as deps, required by none)\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_orphans_v2
	.type	cmd_orphans_v2, %function
cmd_orphans_v2:
	stp	x29, x30, [sp, -48]!
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	add	x1, sp, 40
	str	xzr, [sp, 40]
	bl	run_cmd_capture
	cmp	w0, 1
	bhi	.L2
	ldr	x1, [sp, 40]
	cbz	x1, .L3
	ldrb	w1, [x1]
	cbz	w1, .L3
	cbnz	w0, .L2
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	adrp	x2, :got:stdout
	ldr	x2, [x2, :got_lo12:stdout]
	str	x2, [sp, 24]
	ldr	x0, [sp, 40]
	ldr	x1, [x2]
	bl	fputs
	ldr	x1, [sp, 40]
	str	x1, [sp, 16]
	mov	x0, x1
	bl	strlen
	ldr	x1, [sp, 16]
	add	x0, x1, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	bne	.L17
	mov	x0, x1
	bl	free
.L8:
	mov	w0, 1
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L3:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	puts
	ldr	x0, [sp, 40]
	bl	free
	b	.L8
	.p2align 2,,3
.L2:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	fwrite
	ldr	x0, [sp, 40]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L17:
	ldr	x2, [sp, 24]
	mov	w0, 10
	ldr	x1, [x2]
	bl	putc
	ldr	x1, [sp, 40]
	mov	x0, x1
	bl	free
	b	.L8
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
