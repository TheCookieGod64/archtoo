	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	""
	.align	3
.LC1:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC2:
	.string	"%s/PKGBUILD"
	.align	3
.LC3:
	.string	"\033[1;34m>>> Updating existing checkout %s\n\033[0m"
	.align	3
.LC4:
	.string	"GIT_TERMINAL_PROMPT=0 git -C %s pull --ff-only"
	.align	3
.LC5:
	.string	"\033[1;34m>>> Cloning https://aur.archlinux.org/%s.git\n\033[0m"
	.align	3
.LC6:
	.string	"GIT_TERMINAL_PROMPT=0 git clone -- 'https://aur.archlinux.org/%s.git' %s"
	.align	3
.LC7:
	.string	"\033[1;31m[-] Could not fetch PKGBUILD for '%s'.\n\033[0m"
	.align	3
.LC8:
	.string	"\033[1;31m[-] Clone succeeded but %s is missing.\n\033[0m"
	.align	3
.LC9:
	.string	"\033[1;32m[+] PKGBUILD is at %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_get_pkgbuild_v2
	.type	cmd_get_pkgbuild_v2, %function
cmd_get_pkgbuild_v2:
	sub	sp, sp, #1904
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
	adrp	x1, .LC1
	csel	x2, x2, x19, eq
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC1
	bl	fprintf
.L4:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1904
	ret
	.p2align 2,,3
.L2:
	add	x20, sp, 48
	mov	x0, x19
	mov	x1, x20
	mov	x2, 320
	bl	shell_quote
	cbz	w0, .L4
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 512
	stp	x21, x22, [sp, 32]
	add	x21, sp, 368
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x19
	bl	dir_exists
	cbnz	w0, .L20
.L7:
	mov	x1, x19
	add	x22, sp, 880
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	adrp	x2, .LC6
	mov	x4, x20
	mov	x0, x22
	mov	x3, x19
	add	x2, x2, :lo12:.LC6
	mov	x1, 1024
	bl	xsnprintf
.L8:
	mov	x0, x22
	mov	x1, 0
	bl	run_as_user
	cbnz	w0, .L21
	mov	x0, x21
	bl	file_exists
	cbz	w0, .L22
	mov	x1, x21
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 1904
	ret
	.p2align 2,,3
.L20:
	mov	x0, x21
	bl	file_exists
	cbz	w0, .L7
	mov	x1, x19
	add	x22, sp, 880
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	mov	x3, x20
	mov	x0, x22
	adrp	x2, .LC4
	mov	x1, 1024
	add	x2, x2, :lo12:.LC4
	bl	xsnprintf
	b	.L8
	.p2align 2,,3
.L21:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
	b	.L4
	.p2align 2,,3
.L22:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
	b	.L4
	.section	.rodata.str1.8
	.align	3
.LC10:
	.string	" --noconfirm"
	.align	3
.LC11:
	.string	"\033[1;31m[-] Local build requires a directory.\n\033[0m"
	.align	3
.LC12:
	.string	"\033[1;31m[-] Invalid build directory.\n\033[0m"
	.align	3
.LC13:
	.string	"\033[1;31m[-] Directory does not exist: %s\n\033[0m"
	.align	3
.LC14:
	.string	"\033[1;31m[-] No PKGBUILD in %s\n\033[0m"
	.align	3
.LC15:
	.string	"\033[1;34m>>> Building local PKGBUILD in %s\n\033[0m"
	.align	3
.LC16:
	.string	"cd %s && makepkg -f%s"
	.align	3
.LC17:
	.string	"\033[1;31m[-] Local build failed.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_local_build_v2
	.type	cmd_local_build_v2, %function
cmd_local_build_v2:
	mov	x12, 4304
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	cbz	x0, .L24
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L45
	mov	w1, 10
	bl	strchr
	cbnz	x0, .L27
	mov	x0, x19
	mov	w1, 13
	bl	strchr
	cbz	x0, .L28
.L27:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC12
	mov	x2, 40
	add	x0, x0, :lo12:.LC12
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x19, x20, [sp, 16]
.L26:
	mov	w0, 0
.L23:
	ldp	x29, x30, [sp]
	mov	x12, 4304
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L45:
	ldp	x19, x20, [sp, 16]
.L24:
	adrp	x0, .LC11
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 49
	mov	x1, 1
	add	x0, x0, :lo12:.LC11
	ldr	x3, [x3]
	bl	fwrite
	b	.L26
	.p2align 2,,3
.L28:
	mov	x0, x19
	bl	dir_exists
	cbz	w0, .L46
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	add	x20, sp, 1056
	mov	x1, 1200
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	file_exists
	cbz	w0, .L47
	add	x20, sp, 32
	mov	x0, x19
	mov	x1, x20
	mov	x2, 1024
	bl	shell_quote
	cbz	w0, .L43
	mov	x1, x19
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	add	x19, sp, 2256
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x4, .LC0
	adrp	x0, .LC10
	add	x4, x4, :lo12:.LC0
	add	x0, x0, :lo12:.LC10
	csel	x4, x4, x0, eq
	mov	x3, x20
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	mov	x1, 2048
	mov	x0, x19
	bl	xsnprintf
	mov	x1, 0
	mov	x0, x19
	bl	run_as_user
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L48
	ldp	x19, x20, [sp, 16]
	b	.L23
	.p2align 2,,3
.L47:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC14
	add	x1, x1, :lo12:.LC14
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	b	.L26
	.p2align 2,,3
.L46:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC13
	add	x1, x1, :lo12:.LC13
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	b	.L26
	.p2align 2,,3
.L43:
	ldp	x19, x20, [sp, 16]
	b	.L26
.L48:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC17
	mov	x2, 35
	add	x0, x0, :lo12:.LC17
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	b	.L26
	.section	.note.GNU-stack,"",@progbits
