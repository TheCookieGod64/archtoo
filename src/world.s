	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"/usr/local/emerge/world"
	.align	3
.LC2:
	.string	"\r\n"
	.text
	.align	2
	.p2align 5,,15
	.global	is_in_world
	.type	is_in_world, %function
is_in_world:
	sub	sp, sp, #560
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x21, x0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	fopen_nofollow
	cbz	x0, .L6
	adrp	x22, .LC2
	mov	x20, x0
	add	x19, sp, 48
	add	x22, x22, :lo12:.LC2
	b	.L3
	.p2align 2,,3
.L5:
	bl	strcspn
	mov	x3, x0
	mov	x1, x21
	mov	x0, x19
	strb	wzr, [x19, x3]
	bl	strcmp
	cbz	w0, .L7
.L3:
	mov	w1, 512
	mov	x2, x20
	mov	x0, x19
	bl	fgets
	mov	x1, x22
	mov	x3, x0
	mov	x0, x19
	cbnz	x3, .L5
	mov	w19, 0
.L4:
	mov	x0, x20
	bl	fclose
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 560
	ret
	.p2align 2,,3
.L7:
	mov	w19, 1
	b	.L4
	.p2align 2,,3
.L6:
	mov	w19, 0
	mov	w0, w19
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 560
	ret
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"a"
	.align	3
.LC4:
	.string	"\033[1;31m[-] Could not open world file %s\n\033[0m"
	.align	3
.LC5:
	.string	"%s\n"
	.align	3
.LC6:
	.string	"\033[1;32m[+] %s registered in %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	add_to_world
	.type	add_to_world, %function
add_to_world:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L16
.L10:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L16:
	mov	x0, x19
	bl	is_in_world
	cbnz	w0, .L10
	adrp	x20, .LC1
	add	x20, x20, :lo12:.LC1
	mov	x0, x20
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	str	x21, [sp, 32]
	bl	fopen_nofollow
	mov	x21, x0
	cbz	x0, .L17
	mov	x2, x19
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	bl	fprintf
	mov	x0, x21
	bl	fclose
	mov	x0, x20
	bl	fix_owner
	ldr	x21, [sp, 32]
	mov	x2, x20
	mov	x1, x19
	adrp	x0, .LC6
	ldp	x19, x20, [sp, 16]
	add	x0, x0, :lo12:.LC6
	ldp	x29, x30, [sp], 48
	b	printf
	.p2align 2,,3
.L17:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	ldr	x21, [sp, 32]
	adrp	x1, .LC4
	ldp	x19, x20, [sp, 16]
	add	x1, x1, :lo12:.LC4
	ldp	x29, x30, [sp], 48
	ldr	x0, [x0]
	b	fprintf
	.section	.rodata.str1.8
	.align	3
.LC7:
	.string	"%s.tmp"
	.align	3
.LC8:
	.string	"w"
	.align	3
.LC9:
	.string	"\033[1;31m[-] Could not update world file.\n\033[0m"
	.align	3
.LC10:
	.string	"%s"
	.align	3
.LC11:
	.string	"\033[1;31m[-] Could not replace world file.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	remove_from_world
	.type	remove_from_world, %function
remove_from_world:
	sub	sp, sp, #1632
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x25, x26, [sp, 64]
	adrp	x26, .LC1
	add	x19, x26, :lo12:.LC1
	stp	x21, x22, [sp, 32]
	mov	x22, x0
	mov	x0, x19
	bl	fopen_nofollow
	cbz	x0, .L18
	mov	x3, x19
	adrp	x2, .LC7
	add	x2, x2, :lo12:.LC7
	str	x27, [sp, 80]
	add	x27, sp, 96
	mov	x1, 512
	mov	x21, x0
	mov	x0, x27
	bl	xsnprintf
	add	x20, sp, 608
	mov	x0, x27
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	bl	fopen_nofollow
	mov	x25, x0
	cbz	x0, .L33
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC10
	adrp	x24, .LC2
	add	x23, x23, :lo12:.LC10
	add	x24, x24, :lo12:.LC2
	.p2align 5,,15
.L20:
	mov	x2, x21
	mov	w1, 512
	mov	x0, x20
	add	x19, sp, 1120
	bl	fgets
	mov	x4, x0
	mov	x3, x20
	mov	x2, x23
	mov	x0, x19
	mov	x1, 512
	cbz	x4, .L35
	bl	xsnprintf
	mov	x1, x24
	mov	x0, x19
	bl	strcspn
	mov	x2, x0
	mov	x1, x22
	mov	x0, x19
	strb	wzr, [x19, x2]
	bl	strcmp
	cbz	w0, .L20
	mov	x1, x25
	mov	x0, x20
	bl	fputs
	b	.L20
	.p2align 2,,3
.L35:
	mov	x0, x21
	bl	fclose
	mov	x0, x25
	add	x26, x26, :lo12:.LC1
	bl	fclose
	mov	x0, x27
	mov	x1, x26
	bl	rename
	cbnz	w0, .L36
	mov	x0, x26
	bl	fix_owner
	ldp	x23, x24, [sp, 48]
	ldr	x27, [sp, 80]
.L18:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	add	sp, sp, 1632
	ret
	.p2align 2,,3
.L36:
	mov	x0, x27
	bl	remove
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 45
	mov	x1, 1
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	ldr	x3, [x3]
	bl	fwrite
	ldr	x27, [sp, 80]
	ldp	x23, x24, [sp, 48]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x25, x26, [sp, 64]
	add	sp, sp, 1632
	ret
	.p2align 2,,3
.L33:
	mov	x0, x21
	bl	fclose
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC9
	mov	x2, 44
	add	x0, x0, :lo12:.LC9
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldr	x27, [sp, 80]
	b	.L18
	.section	.rodata.str1.8
	.align	3
.LC12:
	.string	" --noconfirm"
	.align	3
.LC13:
	.string	""
	.align	3
.LC14:
	.string	"\033[1;35m\n=========================================================="
	.align	3
.LC15:
	.string	"1.0.0"
	.align	3
.LC16:
	.string	"   ARCHTOO WORLD UPDATE v%s\n"
	.align	3
.LC17:
	.string	"==========================================================\n\033[0m"
	.align	3
.LC18:
	.string	"\033[1;34m\n>>> [SYSTEM] Upgrading binary packages (pacman -Syu)...\n\033[0m"
	.align	3
.LC19:
	.string	"%spacman -Syu%s"
	.align	3
.LC20:
	.string	"\033[1;31m[-] pacman -Syu failed (exit %d). Not rebuilding the world set on\n    top of a half-updated system. Fix the upgrade, then retry.\n\033[0m"
	.align	3
.LC21:
	.string	"\033[1;32m[+] Binary packages up to date.\n\033[0m"
	.align	3
.LC22:
	.string	"\033[1;34m>>> [AUR] Refresh enabled for AUR-backed @world packages.\n\033[0m"
	.align	3
.LC23:
	.string	"\033[1;33m>>> [AUR] Refresh disabled; reusing local AUR checkouts.\n\033[0m"
	.align	3
.LC24:
	.string	"\033[1;33m[-] No world file found.\n\033[0m"
	.align	3
.LC25:
	.string	"\033[1;31m[-] Skipping invalid entry in world file: '%s'\n\033[0m"
	.align	3
.LC26:
	.string	"\033[1;31m[-] Out of memory.\n\033[0m"
	.align	3
.LC27:
	.string	"\033[1;33m[-] World file is empty.\n\033[0m"
	.align	3
.LC28:
	.string	"\033[1;33m\n>>> [WORLD %zu/%zu] Rebuilding: %s\n\033[0m"
	.align	3
.LC29:
	.string	"\033[1;35m\n==========================================================\n\033[0m"
	.align	3
.LC30:
	.string	"\033[1;32m>>> WORLD UPDATE COMPLETED (%zu packages)\n\033[0m"
	.align	3
.LC31:
	.string	"\033[1;33m>>> WORLD UPDATE FINISHED: %zu succeeded, %zu FAILED\n\033[0m"
	.align	3
.LC32:
	.string	"\033[1;31m    Failed:\033[0m"
	.align	3
.LC33:
	.string	" %s"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_world_update
	.type	cmd_world_update, %function
cmd_world_update:
	sub	sp, sp, #608
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	bl	puts
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	printf
	bl	get_sync
	cbz	w0, .L83
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	add	x19, sp, 96
	bl	priv_prefix
	mov	x20, x0
	bl	use_noconfirm
	cmp	w0, 0
	adrp	x1, .LC12
	adrp	x4, .LC13
	add	x1, x1, :lo12:.LC12
	add	x4, x4, :lo12:.LC13
	csel	x4, x4, x1, eq
	mov	x3, x20
	adrp	x2, .LC19
	add	x2, x2, :lo12:.LC19
	mov	x1, 256
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	mov	w2, w0
	cbnz	w0, .L84
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	stp	x21, x22, [sp, 32]
	bl	printf
	bl	get_aur_sync
	cbnz	w0, .L85
.L42:
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	printf
.L43:
	adrp	x1, .LC0
	adrp	x0, .LC1
	add	x1, x1, :lo12:.LC0
	add	x0, x0, :lo12:.LC1
	bl	fopen_nofollow
	mov	x21, x0
	cbz	x0, .L86
	stp	x23, x24, [sp, 48]
	adrp	x22, .LC2
	add	x19, sp, 96
	adrp	x24, :got:stderr;ldr	x24, [x24, :got_lo12:stderr]
	add	x22, x22, :lo12:.LC2
	mov	x23, 0
	mov	x20, 0
	stp	x25, x26, [sp, 64]
	mov	x25, 0
	.p2align 5,,15
.L46:
	mov	x2, x21
	mov	x0, x19
	mov	w1, 512
	bl	fgets
	cbz	x0, .L51
.L52:
	mov	x1, x22
	mov	x0, x19
	bl	strcspn
	strb	wzr, [x19, x0]
	ldrb	w1, [sp, 96]
	cmp	w1, 35
	ccmp	w1, 0, 4, ne
	beq	.L46
	mov	x0, x19
	bl	valid_pkgname
	cbz	w0, .L87
	cmp	x23, x20
	bne	.L66
	cbz	x23, .L67
	lsl	x1, x23, 4
	lsl	x23, x23, 1
.L50:
	mov	x0, x25
	bl	realloc
	mov	x26, x0
	cbz	x0, .L88
.L49:
	mov	x0, x19
	bl	strdup
	str	x0, [x26, x20, lsl 3]
	cbz	x0, .L68
	add	x20, x20, 1
	mov	x25, x26
	mov	x2, x21
	mov	x0, x19
	mov	w1, 512
	bl	fgets
	cbnz	x0, .L52
.L51:
	mov	x0, x21
	bl	fclose
	cbz	x20, .L89
	mov	x0, x20
	mov	x1, 1
	adrp	x26, .LC28
	add	x26, x26, :lo12:.LC28
	str	x27, [sp, 80]
	bl	calloc
	mov	x21, x0
	mov	x19, 0
	mov	x22, 0
	mov	x24, 0
	.p2align 5,,15
.L58:
	mov	x23, x19
	add	x19, x19, 1
	mov	x1, x19
	mov	x2, x20
	mov	x0, x26
	ldr	x27, [x25, x23, lsl 3]
	mov	x3, x27
	bl	printf
	mov	x0, x27
	bl	cmd_build
	cbz	x21, .L55
	strb	w0, [x21, x23]
.L55:
	cbz	w0, .L56
	add	x24, x24, 1
.L57:
	cmp	x19, x20
	bne	.L58
	adrp	x0, .LC29
	add	x0, x0, :lo12:.LC29
	bl	printf
	mov	x1, x24
	cbnz	x22, .L59
	adrp	x0, .LC30
	add	x0, x0, :lo12:.LC30
	bl	printf
.L60:
	add	x20, x25, x20, lsl 3
	mov	x19, x25
	mov	x0, x21
	bl	free
	.p2align 5,,15
.L63:
	ldr	x0, [x19], 8
	bl	free
	cmp	x20, x19
	bne	.L63
	mov	x0, x25
	bl	free
	cmp	x22, 0
	ldr	x27, [sp, 80]
	cset	w0, eq
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 608
	ret
	.p2align 2,,3
.L83:
	stp	x21, x22, [sp, 32]
	bl	get_aur_sync
	cbz	w0, .L42
.L85:
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	b	.L43
	.p2align 2,,3
.L66:
	mov	x26, x25
	b	.L49
	.p2align 2,,3
.L67:
	mov	x1, 128
	mov	x23, 16
	b	.L50
	.p2align 2,,3
.L56:
	add	x22, x22, 1
	b	.L57
	.p2align 2,,3
.L87:
	ldr	x0, [x24]
	mov	x2, x19
	adrp	x1, .LC25
	add	x1, x1, :lo12:.LC25
	bl	fprintf
	b	.L46
	.p2align 2,,3
.L89:
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	printf
	mov	x0, x25
	bl	free
	ldp	x21, x22, [sp, 32]
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
.L91:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 608
	ret
	.p2align 2,,3
.L59:
	adrp	x0, .LC31
	mov	x2, x22
	add	x0, x0, :lo12:.LC31
	bl	printf
	cbz	x21, .L60
	adrp	x0, .LC32
	adrp	x23, .LC33
	add	x0, x0, :lo12:.LC32
	add	x23, x23, :lo12:.LC33
	mov	x19, 0
	bl	printf
	b	.L62
	.p2align 2,,3
.L61:
	add	x19, x19, 1
	cmp	x20, x19
	beq	.L90
.L62:
	ldrb	w0, [x21, x19]
	cbnz	w0, .L61
	ldr	x1, [x25, x19, lsl 3]
	mov	x0, x23
	add	x19, x19, 1
	bl	printf
	cmp	x20, x19
	bne	.L62
.L90:
	mov	w0, 10
	bl	putchar
	b	.L60
.L84:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC20
	add	x1, x1, :lo12:.LC20
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L91
.L86:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC24
	mov	x2, 36
	add	x0, x0, :lo12:.LC24
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	b	.L91
.L68:
	mov	x25, x26
	b	.L51
.L88:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC26
	mov	x2, 30
	mov	x1, 1
	add	x0, x0, :lo12:.LC26
	ldr	x3, [x3]
	bl	fwrite
	b	.L51
	.section	.note.GNU-stack,"",@progbits
