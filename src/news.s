	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"curl"
	.align	3
.LC1:
	.string	"\033[1;31m[-] curl is required to fetch Arch news.\n\033[0m"
	.align	3
.LC2:
	.string	"curl -fsSL --max-time 20 -- 'https://archlinux.org/feeds/news/'"
	.align	3
.LC3:
	.string	"\033[1;31m[-] Could not download Arch news feed.\n\033[0m"
	.align	3
.LC4:
	.string	"\033[1;36m>>> Recent Arch Linux news\n\033[0m"
	.align	3
.LC5:
	.string	"<item>"
	.align	3
.LC6:
	.string	"</item>"
	.align	3
.LC7:
	.string	"<title>"
	.align	3
.LC8:
	.string	"<![CDATA["
	.align	3
.LC9:
	.string	"</title>"
	.align	3
.LC10:
	.string	"&amp;"
	.align	3
.LC11:
	.string	"&lt;"
	.align	3
.LC12:
	.string	"&gt;"
	.align	3
.LC13:
	.string	"&quot;"
	.align	3
.LC14:
	.string	"&apos;"
	.align	3
.LC15:
	.string	"&#39;"
	.align	3
.LC16:
	.string	"  %d. %s\n"
	.align	3
.LC17:
	.string	"\033[1;31m[-] News feed contained no items.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_news_v2
	.type	cmd_news_v2, %function
cmd_news_v2:
	sub	sp, sp, #640
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	str	xzr, [sp, 120]
	bl	have_cmd
	cbz	w0, .L40
	add	x1, sp, 120
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	run_cmd_capture
	mov	w22, w0
	cbnz	w0, .L4
	ldr	x0, [sp, 120]
	cbz	x0, .L4
	ldrb	w0, [x0]
	cbz	w0, .L4
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	stp	x19, x20, [sp, 16]
	stp	x23, x24, [sp, 48]
	stp	x25, x26, [sp, 64]
	adrp	x26, .LC6
	adrp	x25, .LC10
	stp	x27, x28, [sp, 80]
	bl	printf
	add	x26, x26, :lo12:.LC6
	ldr	x0, [sp, 120]
	add	x25, x25, :lo12:.LC10
	adrp	x27, .LC5
	.p2align 5,,15
.L23:
	add	x1, x27, :lo12:.LC5
	bl	strstr
	mov	x19, x0
	cbz	x0, .L6
	mov	x1, x26
	bl	strstr
	mov	x21, x0
	cbz	x0, .L6
	mov	x0, x19
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	bl	strstr
	cmp	x0, 0
	ccmp	x21, x0, 0, ne
	bcc	.L20
	add	x20, x0, 7
	add	x19, x0, 16
	mov	x2, 9
	mov	x0, x20
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	bl	strncmp
	cmp	w0, 0
	csel	x20, x20, x19, ne
	adrp	x1, .LC9
	mov	x0, x20
	add	x1, x1, :lo12:.LC9
	bl	strstr
	cmp	x0, 0
	ccmp	x21, x0, 0, ne
	bcc	.L20
	add	x1, x20, 3
	cmp	x0, x1
	bcc	.L9
	ldrb	w1, [x0, -3]
	cmp	w1, 93
	beq	.L41
.L9:
	sub	x19, x0, x20
	add	x23, sp, 128
	cmp	x19, 511
	mov	x0, 511
	csel	x19, x19, x0, ls
	mov	x1, x20
	mov	x2, x19
	mov	x0, x23
	bl	memcpy
	mov	x28, x23
	strb	wzr, [x23, x19]
	ldrb	w19, [sp, 128]
	cbz	w19, .L11
	adrp	x24, .LC11
	mov	x20, x23
	add	x24, x24, :lo12:.LC11
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	str	x0, [sp, 104]
	.p2align 5,,15
.L19:
	add	x28, x28, 1
	cmp	w19, 38
	beq	.L42
.L12:
	add	x20, x20, 1
.L14:
	strb	w19, [x28, -1]
	ldrb	w19, [x20]
	cbnz	w19, .L19
.L11:
	strb	wzr, [x28]
	add	w22, w22, 1
	adrp	x0, .LC16
	mov	x2, x23
	mov	w1, w22
	add	x0, x0, :lo12:.LC16
	bl	printf
	cmp	w22, 10
	beq	.L43
.L20:
	add	x0, x21, 7
	b	.L23
	.p2align 2,,3
.L42:
	mov	x1, x25
	mov	x0, x20
	mov	x2, 5
	bl	strncmp
	cbz	w0, .L44
	mov	x1, x24
	mov	x0, x20
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L45
	ldr	x1, [sp, 104]
	mov	x0, x20
	mov	x2, 4
	bl	strncmp
	cbz	w0, .L46
	adrp	x1, .LC13
	mov	x0, x20
	add	x1, x1, :lo12:.LC13
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L47
	adrp	x1, .LC14
	mov	x0, x20
	add	x1, x1, :lo12:.LC14
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L48
	adrp	x1, .LC15
	mov	x0, x20
	add	x1, x1, :lo12:.LC15
	mov	x2, 5
	bl	strncmp
	cbnz	w0, .L12
	add	x20, x20, 5
	mov	w19, 39
	b	.L14
	.p2align 2,,3
.L4:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	mov	w22, 0
	ldr	x3, [x0]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	fwrite
	ldr	x0, [sp, 120]
	bl	free
.L1:
	ldp	x29, x30, [sp]
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L44:
	add	x20, x20, 5
	b	.L14
	.p2align 2,,3
.L45:
	add	x20, x20, 4
	mov	w19, 60
	b	.L14
	.p2align 2,,3
.L40:
	mov	w22, w0
	mov	x2, 52
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	fwrite
	ldp	x29, x30, [sp]
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L46:
	add	x20, x20, 4
	mov	w19, 62
	b	.L14
	.p2align 2,,3
.L47:
	add	x20, x20, 6
	mov	w19, 34
	b	.L14
	.p2align 2,,3
.L41:
	ldrb	w1, [x0, -2]
	cmp	w1, 93
	bne	.L9
	ldrb	w1, [x0, -1]
	mov	x2, x0
	sub	x0, x0, #3
	cmp	w1, 62
	csel	x0, x0, x2, eq
	b	.L9
	.p2align 2,,3
.L43:
	ldr	x0, [sp, 120]
	bl	free
.L38:
	mov	w22, 1
	mov	w0, w22
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L48:
	add	x20, x20, 6
	mov	w19, 39
	b	.L14
	.p2align 2,,3
.L6:
	ldr	x0, [sp, 120]
	bl	free
	cbnz	w22, .L38
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 45
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L1
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
