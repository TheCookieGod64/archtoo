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
	stp	x19, x20, [sp, 16]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	adrp	x20, :got:stdout;ldr	x20, [x20, :got_lo12:stdout]
	bl	printf
	ldr	x0, [sp, 40]
	ldr	x1, [x20]
	bl	fputs
	ldr	x19, [sp, 40]
	mov	x0, x19
	bl	strlen
	add	x0, x19, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	bne	.L17
	mov	x0, x19
	bl	free
	ldp	x19, x20, [sp, 16]
.L5:
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
	b	.L5
	.p2align 2,,3
.L2:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	ldr	x3, [x3]
	bl	fwrite
	ldr	x0, [sp, 40]
	bl	free
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L17:
	ldr	x1, [x20]
	mov	w0, 10
	bl	putc
	ldr	x19, [sp, 40]
	mov	x0, x19
	bl	free
	ldp	x19, x20, [sp, 16]
	b	.L5
	.section	.note.GNU-stack,"",@progbits
