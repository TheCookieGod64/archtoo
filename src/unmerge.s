	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"/etc/pacman.conf"
	.align	3
.LC1:
	.string	"%ssed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{s/[[:space:]]+%s([[:space:]]|$)/\\1/g;s/=[[:space:]]*%s([[:space:]]|$)/= /g;s/[[:space:]]+$//;s/=[[:space:]]+/= /g}' '%s'"
	.text
	.align	2
	.p2align 5,,15
	.global	unlock_pacman_pkg
	.type	unlock_pacman_pkg, %function
unlock_pacman_pkg:
	sub	sp, sp, #2400
	mov	x2, 320
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 32
	mov	x1, x19
	bl	regex_escape
	cbz	w0, .L1
	bl	priv_prefix
	mov	x3, x0
	mov	x5, x19
	mov	x4, x19
	adrp	x6, .LC0
	adrp	x2, .LC1
	add	x6, x6, :lo12:.LC0
	add	x2, x2, :lo12:.LC1
	add	x20, sp, 352
	mov	x1, 2048
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
.L1:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 2400
	ret
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC3:
	.string	"\033[1;33m[!] %s is not in the world set; unlocking anyway.\n\033[0m"
	.align	3
.LC4:
	.string	"\033[1;34m>>> [1/2] Unlocking %s in pacman.conf...\n\033[0m"
	.align	3
.LC5:
	.string	"%s-headers"
	.align	3
.LC6:
	.string	"\033[1;34m>>> [2/2] Removing %s from the world set...\n\033[0m"
	.align	3
.LC7:
	.string	"\033[1;32m[+] %s deselected. It stays installed, and pacman will\n    manage it again from the official repositories.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_deselect
	.type	cmd_deselect, %function
cmd_deselect:
	stp	x29, x30, [sp, -288]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbz	w0, .L17
	mov	x0, x19
	bl	is_in_world
	cbz	w0, .L18
.L11:
	mov	x1, x19
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	printf
	mov	x0, x19
	bl	unlock_pacman_pkg
	mov	x0, x19
	bl	is_kernel
	cbnz	w0, .L19
.L12:
	mov	x1, x19
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	printf
	mov	x0, x19
	mov	w20, 1
	bl	remove_from_world
	mov	x1, x19
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	printf
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 288
	ret
	.p2align 2,,3
.L19:
	mov	x3, x19
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	add	x20, sp, 32
	mov	x1, 256
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	unlock_pacman_pkg
	b	.L12
	.p2align 2,,3
.L18:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	ldr	x0, [x0]
	bl	fprintf
	b	.L11
	.p2align 2,,3
.L17:
	mov	w20, w0
	mov	x2, x19
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 288
	ret
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	" --noconfirm"
	.align	3
.LC9:
	.string	""
	.align	3
.LC10:
	.string	"\033[1;34m>>> [1/3] Unmerging %s via pacman...\n\033[0m"
	.align	3
.LC11:
	.string	"%s-debug"
	.align	3
.LC12:
	.string	"pacman -Qq '%s'"
	.align	3
.LC13:
	.string	"%spacman -Rns '%s' '%s'%s"
	.align	3
.LC14:
	.string	"%spacman -Rns '%s'%s"
	.align	3
.LC15:
	.string	"\033[1;31m[-] Unmerge failed.\n\033[0m"
	.align	3
.LC16:
	.string	"\033[1;34m>>> [2/3] Unlocking %s in pacman.conf...\n\033[0m"
	.align	3
.LC17:
	.string	"\033[1;34m>>> [3/3] Cleaning up world file and build directory...\n\033[0m"
	.align	3
.LC18:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC19:
	.string	"rm -rf '%s/%s'"
	.align	3
.LC20:
	.string	"\033[1;32m[+] %s successfully unmerged.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_unmerge
	.type	cmd_unmerge, %function
cmd_unmerge:
	sub	sp, sp, #2096
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbz	w0, .L36
	mov	x1, x19
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	stp	x21, x22, [sp, 32]
	bl	printf
	add	x21, sp, 48
	mov	x3, x19
	mov	x1, 256
	mov	x0, x21
	adrp	x2, .LC11
	add	x2, x2, :lo12:.LC11
	bl	xsnprintf
	add	x20, sp, 560
	mov	x3, x21
	adrp	x2, .LC12
	add	x2, x2, :lo12:.LC12
	mov	x1, 512
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	cbz	w0, .L37
	bl	priv_prefix
	mov	x21, x0
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x1, .LC8
	adrp	x5, .LC9
	add	x1, x1, :lo12:.LC8
	add	x5, x5, :lo12:.LC9
	csel	x5, x5, x1, eq
	mov	x3, x21
	mov	x4, x19
	adrp	x2, .LC14
	add	x2, x2, :lo12:.LC14
	add	x20, sp, 1072
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbnz	w0, .L38
.L27:
	mov	x1, x19
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	mov	x0, x19
	bl	unlock_pacman_pkg
	mov	x0, x19
	bl	is_kernel
	cbnz	w0, .L39
.L29:
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	mov	x0, x19
	bl	remove_from_world
	mov	x4, x19
	adrp	x3, .LC18
	adrp	x2, .LC19
	add	x3, x3, :lo12:.LC18
	add	x2, x2, :lo12:.LC19
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	x1, x19
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 2096
	ret
	.p2align 2,,3
.L37:
	bl	priv_prefix
	mov	x22, x0
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x1, .LC8
	adrp	x6, .LC9
	add	x1, x1, :lo12:.LC8
	add	x6, x6, :lo12:.LC9
	csel	x6, x6, x1, eq
	mov	x5, x21
	mov	x3, x22
	mov	x4, x19
	adrp	x2, .LC13
	add	x2, x2, :lo12:.LC13
	add	x20, sp, 1072
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbz	w0, .L27
.L38:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC15
	mov	x2, 31
	add	x0, x0, :lo12:.LC15
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x21, x22, [sp, 32]
	mov	w0, 0
.L40:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 2096
	ret
	.p2align 2,,3
.L36:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L40
	.p2align 2,,3
.L39:
	mov	x3, x19
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	add	x21, sp, 304
	mov	x1, 256
	mov	x0, x21
	bl	xsnprintf
	mov	x0, x21
	bl	unlock_pacman_pkg
	b	.L29
	.section	.note.GNU-stack,"",@progbits
