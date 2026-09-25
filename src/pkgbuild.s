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
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L2
	mov	w4, w0
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	cbz	x19, .L21
.L3:
	mov	x2, x19
	adrp	x1, .LC1
	add	x1, x1, :lo12:.LC1
	str	w4, [sp, 40]
	bl	fprintf
	ldr	w4, [sp, 40]
.L1:
	ldr	x19, [sp, 16]
	mov	w0, w4
	ldp	x29, x30, [sp]
	add	sp, sp, 1904
	ret
	.p2align 2,,3
.L2:
	add	x1, sp, 48
	mov	x0, x19
	mov	x2, 320
	bl	shell_quote
	mov	w4, w0
	cbz	w0, .L1
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 512
	add	x0, sp, 368
	bl	xsnprintf
	mov	x0, x19
	bl	dir_exists
	cbnz	w0, .L22
.L5:
	mov	x1, x19
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	printf
	add	x5, sp, 880
	add	x4, sp, 48
	mov	x0, x5
	mov	x3, x19
	adrp	x2, .LC6
	mov	x1, 1024
	add	x2, x2, :lo12:.LC6
	str	x5, [sp, 40]
	bl	xsnprintf
	ldr	x5, [sp, 40]
.L6:
	mov	x0, x5
	mov	x1, 0
	bl	run_as_user
	cbnz	w0, .L23
	add	x0, sp, 368
	bl	file_exists
	mov	w4, w0
	cbz	w0, .L24
	add	x1, sp, 368
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	printf
	ldr	x19, [sp, 16]
	mov	w4, 1
	ldp	x29, x30, [sp]
	mov	w0, w4
	add	sp, sp, 1904
	ret
	.p2align 2,,3
.L21:
	adrp	x19, .LC0
	add	x19, x19, :lo12:.LC0
	b	.L3
	.p2align 2,,3
.L22:
	add	x0, sp, 368
	bl	file_exists
	cbz	w0, .L5
	mov	x1, x19
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	add	x5, sp, 880
	add	x3, sp, 48
	mov	x0, x5
	adrp	x2, .LC4
	mov	x1, 1024
	add	x2, x2, :lo12:.LC4
	str	x5, [sp, 40]
	bl	xsnprintf
	ldr	x5, [sp, 40]
	b	.L6
	.p2align 2,,3
.L23:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC7
	add	x1, x1, :lo12:.LC7
	ldr	x0, [x0]
	bl	fprintf
	mov	w4, 0
	b	.L1
	.p2align 2,,3
.L24:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 368
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	str	w4, [sp, 40]
	ldr	x0, [x0]
	bl	fprintf
	ldr	w4, [sp, 40]
	b	.L1
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
	mov	x12, 4320
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	cbz	x0, .L26
	str	x19, [sp, 16]
	mov	x19, x0
	ldrb	w1, [x0]
	cbz	w1, .L48
	mov	w1, 10
	bl	strchr
	cbnz	x0, .L29
	mov	x0, x19
	mov	w1, 13
	bl	strchr
	cbz	x0, .L30
.L29:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 40
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	fwrite
	ldr	x19, [sp, 16]
.L31:
	mov	w3, 0
.L25:
	ldp	x29, x30, [sp]
	mov	w0, w3
	mov	x12, 4320
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L48:
	ldr	x19, [sp, 16]
.L26:
	mov	x2, 49
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	fwrite
	b	.L31
	.p2align 2,,3
.L30:
	mov	x0, x19
	bl	dir_exists
	cbz	w0, .L49
	mov	x3, x19
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 1200
	add	x0, sp, 1072
	bl	xsnprintf
	add	x0, sp, 1072
	bl	file_exists
	cbz	w0, .L50
	add	x1, sp, 48
	mov	x0, x19
	mov	x2, 1024
	bl	shell_quote
	mov	w3, w0
	cbz	w0, .L46
	mov	x1, x19
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	bl	use_noconfirm
	cbz	w0, .L35
	adrp	x4, .LC10
	add	x4, x4, :lo12:.LC10
.L34:
	add	x3, sp, 48
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	mov	x1, 2048
	add	x0, sp, 2272
	bl	xsnprintf
	add	x0, sp, 2272
	mov	x1, 0
	bl	run_as_user
	mov	w3, 1
	cbnz	w0, .L51
.L46:
	ldr	x19, [sp, 16]
	b	.L25
	.p2align 2,,3
.L50:
	adrp	x1, .LC14
	mov	x2, x19
	add	x1, x1, :lo12:.LC14
	str	w0, [sp, 44]
.L47:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
	bl	fprintf
	ldr	x19, [sp, 16]
	ldr	w3, [sp, 44]
	b	.L25
.L51:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 35
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	fwrite
	ldr	x19, [sp, 16]
	b	.L31
	.p2align 2,,3
.L49:
	adrp	x1, .LC13
	mov	x2, x19
	add	x1, x1, :lo12:.LC13
	str	w0, [sp, 44]
	b	.L47
	.p2align 2,,3
.L35:
	adrp	x4, .LC0
	add	x4, x4, :lo12:.LC0
	b	.L34
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
