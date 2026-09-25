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
	sub	sp, sp, #1184
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	str	xzr, [sp, 72]
	stp	xzr, xzr, [sp, 80]
	stp	q31, q31, [sp, 96]
	stp	q31, q31, [sp, 128]
	stp	q31, q31, [sp, 160]
	stp	q31, q31, [sp, 192]
	stp	q31, q31, [sp, 224]
	stp	q31, q31, [sp, 256]
	stp	q31, q31, [sp, 288]
	stp	q31, q31, [sp, 320]
	bl	valid_search_query
	cbnz	w0, .L2
	mov	w19, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x20, .L40
.L3:
	adrp	x1, .LC2
	mov	x2, x20
	add	x1, x1, :lo12:.LC2
	bl	fprintf
.L1:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1184
	ret
	.p2align 2,,3
.L2:
	add	x1, sp, 352
	mov	x0, x20
	mov	x2, 320
	bl	shell_quote
	mov	w19, w0
	cbz	w0, .L1
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	stp	x21, x22, [sp, 32]
	bl	printf
	add	x3, sp, 352
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x1, 512
	add	x0, sp, 672
	bl	xsnprintf
	add	x1, sp, 72
	add	x0, sp, 672
	bl	run_cmd_capture
	cbnz	w0, .L5
	ldr	x0, [sp, 72]
	cbz	x0, .L5
	ldrb	w1, [x0]
	cbnz	w1, .L41
.L5:
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	puts
	mov	w19, 0
	ldr	x21, [sp, 72]
.L6:
	mov	x0, x21
	bl	free
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	printf
	bl	config_current
	add	x0, x0, 20
	add	x3, sp, 96
	add	x2, sp, 80
	mov	x1, x20
	mov	x4, 256
	bl	aur_rpc_search
	cbz	w0, .L7
	ldr	x0, [sp, 88]
	cbz	x0, .L42
	adrp	x0, .LC8
	mov	x19, 0
	adrp	x22, :got:stdout
	ldr	x22, [x22, :got_lo12:stdout]
	mov	x21, 0
	str	x23, [sp, 48]
	add	x23, x0, :lo12:.LC8
	b	.L8
	.p2align 2,,3
.L12:
	ldr	x1, [x22]
	mov	w0, 10
	bl	putc
	ldr	x1, [x20, 24]
	cbz	x1, .L13
	ldrb	w0, [x1]
	cbnz	w0, .L43
.L13:
	ldr	x0, [sp, 88]
	add	x21, x21, 1
	add	x19, x19, 152
	cmp	x0, x21
	bls	.L44
.L8:
	ldr	x0, [sp, 80]
	add	x20, x0, x19
	ldr	x1, [x0, x19]
	adrp	x0, .LC1
	ldr	x2, [x20, 16]
	add	x0, x0, :lo12:.LC1
	cmp	x1, 0
	csel	x1, x0, x1, eq
	cmp	x2, 0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	csel	x2, x0, x2, eq
	mov	x0, x23
	bl	printf
	ldr	x1, [x20, 48]
	cbz	x1, .L12
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	printf
	b	.L12
	.p2align 2,,3
.L40:
	adrp	x20, .LC0
	add	x20, x20, :lo12:.LC0
	b	.L3
	.p2align 2,,3
.L7:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC11
	add	x2, sp, 96
	add	x1, x1, :lo12:.LC11
	ldr	x0, [x0]
	bl	fprintf
.L9:
	add	x0, sp, 80
	bl	aur_response_destroy
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1184
	ret
	.p2align 2,,3
.L43:
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	printf
	b	.L13
	.p2align 2,,3
.L44:
	ldr	x23, [sp, 48]
	mov	w19, 1
	b	.L9
	.p2align 2,,3
.L42:
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	puts
	b	.L9
	.p2align 2,,3
.L41:
	adrp	x22, :got:stdout
	ldr	x22, [x22, :got_lo12:stdout]
	mov	w19, 1
	ldr	x1, [x22]
	bl	fputs
	ldr	x21, [sp, 72]
	mov	x0, x21
	bl	strlen
	add	x0, x21, x0
	ldrb	w0, [x0, -1]
	cmp	w0, 10
	beq	.L6
	ldr	x1, [x22]
	mov	w0, 10
	bl	putc
	ldr	x21, [sp, 72]
	b	.L6
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
