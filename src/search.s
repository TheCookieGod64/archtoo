	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	""
	.align	3
.LC1:
	.string	"?"
	.align	3
.LC2:
	.string	"\033[1;31m[-] Invalid search query: '%s'\n\033[0m"
	.align	3
.LC3:
	.string	"\033[1;36m>>> Repositories\n\033[0m"
	.align	3
.LC4:
	.string	"pacman -Ss -- %s"
	.align	3
.LC5:
	.string	"    (no repository matches)"
	.align	3
.LC6:
	.string	"\033[1;36m>>> AUR\n\033[0m"
	.align	3
.LC7:
	.string	"    (no AUR matches)"
	.align	3
.LC8:
	.string	"aur/%s %s"
	.align	3
.LC9:
	.string	" (%ld votes)"
	.align	3
.LC10:
	.string	"    %s\n"
	.align	3
.LC11:
	.string	"\033[1;33m[!] AUR RPC: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_search_v2
	.type	cmd_search_v2, %function
cmd_search_v2:
	movi	v31.4s, 0
	sub	sp, sp, #1216
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 128
	mov	x20, x0
	stp	x21, x22, [sp, 32]
	str	xzr, [sp, 104]
	stp	xzr, xzr, [sp, 112]
	stp	q31, q31, [x19]
	stp	q31, q31, [x19, 32]
	stp	q31, q31, [x19, 64]
	stp	q31, q31, [x19, 96]
	stp	q31, q31, [x19, 128]
	stp	q31, q31, [x19, 160]
	stp	q31, q31, [x19, 192]
	stp	q31, q31, [x19, 224]
	bl	valid_search_query
	cbnz	w0, .L2
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	cmp	x20, 0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	adrp	x1, .LC2
	csel	x2, x2, x20, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L4:
	mov	w21, 0
	mov	w0, w21
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 1216
	ret
	.p2align 2,,3
.L2:
	add	x21, sp, 384
	mov	x0, x20
	mov	x1, x21
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L4
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	stp	x25, x26, [sp, 64]
	bl	printf
	mov	x3, x21
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	add	x0, sp, 704
	mov	x1, 512
	mov	x21, x0
	bl	xsnprintf
	mov	x0, x21
	add	x1, sp, 104
	bl	run_cmd_capture
	cbnz	w0, .L7
	ldr	x0, [sp, 104]
	cbz	x0, .L7
	ldrb	w1, [x0]
	cbnz	w1, .L40
.L7:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	puts
	mov	w21, 0
	ldr	x22, [sp, 104]
.L8:
	mov	x0, x22
	bl	free
	add	x25, sp, 112
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	printf
	bl	config_current
	add	x0, x0, 20
	mov	x1, x20
	mov	x2, x25
	mov	x3, x19
	mov	x4, 256
	bl	aur_rpc_search
	cbz	w0, .L9
	ldr	x0, [sp, 120]
	cbz	x0, .L41
	adrp	x26, .LC8
	adrp	x22, .LC0
	add	x26, x26, :lo12:.LC8
	add	x22, x22, :lo12:.LC0
	mov	x19, 0
	mov	x21, 0
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC1
	add	x23, x23, :lo12:.LC1
	adrp	x24, :got:stdout;ldr	x24, [x24, :got_lo12:stdout]
	str	x27, [sp, 80]
	adrp	x27, .LC9
	add	x27, x27, :lo12:.LC9
	b	.L10
	.p2align 2,,3
.L14:
	ldr	x1, [x24]
	mov	w0, 10
	bl	putc
	ldr	x1, [x20, 24]
	cbz	x1, .L15
	ldrb	w0, [x1]
	cbnz	w0, .L42
.L15:
	ldr	x0, [sp, 120]
	add	x21, x21, 1
	add	x19, x19, 152
	cmp	x0, x21
	bls	.L43
.L10:
	ldr	x1, [sp, 112]
	mov	x0, x26
	add	x20, x1, x19
	ldr	x1, [x1, x19]
	ldr	x2, [x20, 16]
	cmp	x1, 0
	csel	x1, x23, x1, eq
	cmp	x2, 0
	csel	x2, x22, x2, eq
	bl	printf
	ldr	x1, [x20, 48]
	cbz	x1, .L14
	mov	x0, x27
	bl	printf
	b	.L14
	.p2align 2,,3
.L9:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC11
	mov	x2, x19
	add	x1, x1, :lo12:.LC11
	ldr	x0, [x0]
	bl	fprintf
.L11:
	mov	x0, x25
	bl	aur_response_destroy
	ldp	x29, x30, [sp]
	mov	w0, w21
	ldp	x25, x26, [sp, 64]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 1216
	ret
	.p2align 2,,3
.L42:
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	b	.L15
	.p2align 2,,3
.L43:
	ldr	x27, [sp, 80]
	mov	w21, 1
	ldp	x23, x24, [sp, 48]
	b	.L11
	.p2align 2,,3
.L41:
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	puts
	b	.L11
	.p2align 2,,3
.L40:
	stp	x23, x24, [sp, 48]
	mov	w21, 1
	adrp	x24, :got:stdout;ldr	x24, [x24, :got_lo12:stdout]
	ldr	x1, [x24]
	bl	fputs
	ldr	x22, [sp, 104]
	mov	x0, x22
	bl	strlen
	add	x0, x22, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	beq	.L38
	ldr	x1, [x24]
	mov	w0, 10
	bl	putc
	ldr	x22, [sp, 104]
	ldp	x23, x24, [sp, 48]
	b	.L8
	.p2align 2,,3
.L38:
	ldp	x23, x24, [sp, 48]
	b	.L8
	.section	.note.GNU-stack,"",@progbits
