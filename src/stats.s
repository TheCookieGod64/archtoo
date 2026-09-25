	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	count_cmd_lines, %function
count_cmd_lines:
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	add	x1, sp, 56
	stp	x21, x22, [sp, 32]
	str	xzr, [sp, 56]
	bl	run_cmd_capture
	ldr	x22, [sp, 56]
	cmp	w0, 1
	bhi	.L27
	cbz	x22, .L5
	ldrb	w0, [x22]
	cbz	w0, .L5
	stp	x19, x20, [sp, 16]
	mov	x19, x22
	mov	x21, 0
	.p2align 5,,15
.L12:
	mov	x0, x19
	mov	w1, 10
	bl	strchr
	mov	x20, x0
	cbz	x0, .L6
	subs	x0, x0, x19
	beq	.L8
.L7:
	mov	x1, 0
	.p2align 5,,15
.L11:
	ldrb	w2, [x19, x1]
	and	w3, w2, -5
	cmp	w2, 32
	ccmp	w3, 9, 4, ne
	bne	.L10
	add	x1, x1, 1
	cmp	x1, x0
	bcc	.L11
.L13:
	cbz	x20, .L25
.L8:
	ldrb	w0, [x20, 1]
	add	x19, x20, 1
	cbnz	w0, .L12
.L25:
	ldp	x19, x20, [sp, 16]
.L9:
	mov	x0, x22
	bl	free
.L1:
	mov	x0, x21
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L10:
	add	x21, x21, 1
	b	.L13
	.p2align 2,,3
.L6:
	mov	x0, x19
	bl	strlen
	cbnz	x0, .L7
	b	.L25
.L5:
	mov	x21, 0
	b	.L9
.L27:
	mov	x0, x22
	mov	x21, -1
	bl	free
	b	.L1
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"pacman -Qq"
	.align	3
.LC1:
	.string	"pacman -Qmq"
	.align	3
.LC2:
	.string	"pacman -Qeq"
	.align	3
.LC3:
	.string	"pacman -Qdtq"
	.align	3
.LC4:
	.string	"\033[1;31m[-] Could not query pacman package lists.\n\033[0m"
	.align	3
.LC5:
	.string	"r"
	.align	3
.LC6:
	.string	"/usr/local/emerge/world"
	.align	3
.LC7:
	.string	"1.0.0"
	.align	3
.LC8:
	.string	"Archtoo Emerge Engine"
	.align	3
.LC9:
	.string	"\033[1;36m%s v%s\n\033[0m"
	.align	3
.LC10:
	.string	"Installed packages : %ld\n"
	.align	3
.LC11:
	.string	"Explicit packages  : %ld\n"
	.align	3
.LC12:
	.string	"Foreign packages   : %ld\n"
	.align	3
.LC13:
	.string	"Orphaned packages  : %ld\n"
	.align	3
.LC14:
	.string	"@world entries     : %ld\n"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_stats_v2
	.type	cmd_stats_v2, %function
cmd_stats_v2:
	stp	x29, x30, [sp, -336]!
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	stp	x23, x24, [sp, 48]
	str	x25, [sp, 64]
	bl	count_cmd_lines
	mov	x25, x0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	count_cmd_lines
	mov	x23, x0
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	count_cmd_lines
	mov	x24, x0
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	count_cmd_lines
	cmn	x25, #1
	ccmn	x23, #1, 4, ne
	ccmn	x24, #1, 4, ne
	beq	.L43
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	stp	x19, x20, [sp, 16]
	mov	x19, 0
	stp	x21, x22, [sp, 32]
	bic	x22, x0, x0, asr #63
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	fopen
	mov	x20, x0
	cbz	x0, .L32
	mov	x21, -1026
	mov	x2, x20
	add	x0, sp, 80
	movk	x21, 0xfff7, lsl 32
	mov	w1, 256
	bl	fgets
	cbz	x0, .L35
	.p2align 5,,15
.L44:
	ldrb	w0, [sp, 80]
	add	x1, sp, 80
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	bne	.L36
	.p2align 5,,15
.L33:
	ldrb	w0, [x1, 1]!
	cmp	w0, 32
	ccmp	w0, 9, 4, ne
	beq	.L33
.L36:
	cmp	w0, 36
	asr	x1, x21, x0
	and	x1, x1, 1
	mov	x2, x20
	csinc	x0, x1, xzr, cc
	mov	w1, 256
	add	x19, x19, x0
	add	x0, sp, 80
	bl	fgets
	cbnz	x0, .L44
.L35:
	mov	x0, x20
	bl	fclose
.L32:
	adrp	x2, .LC7
	add	x2, x2, :lo12:.LC7
	adrp	x1, .LC8
	adrp	x0, .LC9
	add	x1, x1, :lo12:.LC8
	add	x0, x0, :lo12:.LC9
	bl	printf
	mov	x1, x25
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	mov	x1, x24
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	printf
	mov	x1, x23
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	printf
	mov	x1, x22
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	printf
	mov	x1, x19
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	printf
	ldr	x25, [sp, 64]
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 336
	ret
	.p2align 2,,3
.L43:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 53
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	fwrite
	ldr	x25, [sp, 64]
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp], 336
	ret
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
