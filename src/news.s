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
	str	xzr, [sp, 120]
	bl	have_cmd
	cbz	w0, .L41
	add	x1, sp, 120
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	stp	x21, x22, [sp, 32]
	bl	run_cmd_capture
	mov	w21, w0
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
	adrp	x26, .LC10
	add	x26, x26, :lo12:.LC10
	stp	x27, x28, [sp, 80]
	bl	printf
	adrp	x27, .LC6
	ldr	x23, [sp, 120]
	add	x27, x27, :lo12:.LC6
	adrp	x28, .LC5
	.p2align 5,,15
.L25:
	mov	x0, x23
	add	x1, x28, :lo12:.LC5
	bl	strstr
	mov	x19, x0
	cbz	x0, .L7
	mov	x1, x27
	bl	strstr
	mov	x20, x0
	cbz	x0, .L7
	mov	x0, x19
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	bl	strstr
	cmp	x0, 0
	add	x23, x20, 7
	mov	x19, x0
	ccmp	x20, x0, 0, ne
	bcc	.L25
	add	x24, x0, 7
	mov	x2, 9
	mov	x0, x24
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	bl	strncmp
	cmp	w0, 0
	add	x19, x19, 16
	csel	x24, x24, x19, ne
	adrp	x1, .LC9
	mov	x0, x24
	add	x1, x1, :lo12:.LC9
	bl	strstr
	cmp	x0, 0
	ccmp	x20, x0, 0, ne
	bcc	.L25
	add	x1, x24, 3
	cmp	x0, x1
	bcc	.L10
	ldrb	w1, [x0, -3]
	sub	x2, x0, #3
	cmp	w1, 93
	beq	.L42
.L10:
	sub	x19, x0, x24
	mov	x0, 511
	cmp	x19, x0
	add	x22, sp, 128
	csel	x19, x19, x0, ls
	mov	x1, x24
	mov	x2, x19
	mov	x0, x22
	bl	memcpy
	strb	wzr, [x22, x19]
	ldrb	w19, [sp, 128]
	cbz	w19, .L27
	adrp	x25, .LC12
	adrp	x24, .LC11
	add	x0, x25, :lo12:.LC12
	add	x24, x24, :lo12:.LC11
	mov	x25, x22
	mov	x20, x22
	str	x0, [sp, 104]
	.p2align 5,,15
.L20:
	add	x25, x25, 1
	cmp	w19, 38
	beq	.L43
.L13:
	add	x20, x20, 1
.L15:
	strb	w19, [x25, -1]
	ldrb	w19, [x20]
	cbnz	w19, .L20
.L12:
	strb	wzr, [x25]
	add	w21, w21, 1
	adrp	x0, .LC16
	mov	x2, x22
	mov	w1, w21
	add	x0, x0, :lo12:.LC16
	bl	printf
	cmp	w21, 10
	bne	.L25
	ldr	x0, [sp, 120]
	bl	free
.L24:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L1
	.p2align 2,,3
.L43:
	mov	x1, x26
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
	cbnz	w0, .L13
	add	x20, x20, 5
	mov	w19, 39
	b	.L15
	.p2align 2,,3
.L4:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	ldr	x3, [x3]
	bl	fwrite
	ldr	x0, [sp, 120]
	bl	free
	ldp	x21, x22, [sp, 32]
.L3:
	mov	w0, 0
.L1:
	ldp	x29, x30, [sp]
	add	sp, sp, 640
	ret
	.p2align 2,,3
.L44:
	add	x20, x20, 5
	b	.L15
	.p2align 2,,3
.L45:
	add	x20, x20, 4
	mov	w19, 60
	b	.L15
	.p2align 2,,3
.L41:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC1
	mov	x2, 52
	mov	x1, 1
	add	x0, x0, :lo12:.LC1
	ldr	x3, [x3]
	bl	fwrite
	b	.L3
	.p2align 2,,3
.L46:
	add	x20, x20, 4
	mov	w19, 62
	b	.L15
	.p2align 2,,3
.L47:
	add	x20, x20, 6
	mov	w19, 34
	b	.L15
	.p2align 2,,3
.L42:
	ldrb	w1, [x0, -2]
	cmp	w1, 93
	bne	.L10
	ldrb	w1, [x0, -1]
	cmp	w1, 62
	csel	x0, x0, x2, ne
	b	.L10
	.p2align 2,,3
.L48:
	add	x20, x20, 6
	mov	w19, 39
	b	.L15
	.p2align 2,,3
.L7:
	ldr	x0, [sp, 120]
	bl	free
	cbnz	w21, .L24
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC17
	mov	x2, 45
	add	x0, x0, :lo12:.LC17
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L3
	.p2align 2,,3
.L27:
	mov	x25, x22
	b	.L12
	.section	.note.GNU-stack,"",@progbits
