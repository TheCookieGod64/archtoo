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
	mov	x22, x0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	fopen_nofollow
	cbz	x0, .L6
	adrp	x21, .LC2
	mov	x20, x0
	add	x19, sp, 48
	add	x21, x21, :lo12:.LC2
	b	.L3
	.p2align 2,,3
.L5:
	mov	x1, x21
	mov	x0, x19
	bl	strcspn
	strb	wzr, [x19, x0]
	mov	x1, x22
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L7
.L3:
	mov	x2, x20
	mov	x0, x19
	mov	w1, 512
	bl	fgets
	cbnz	x0, .L5
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
	stp	x29, x30, [sp, -64]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L17
.L10:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L17:
	mov	x0, x19
	bl	is_in_world
	cbnz	w0, .L10
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	str	x21, [sp, 32]
	mov	x21, x0
	bl	fopen_nofollow
	cbz	x0, .L18
	mov	x2, x19
	adrp	x1, .LC5
	add	x1, x1, :lo12:.LC5
	str	x0, [sp, 56]
	bl	fprintf
	ldr	x0, [sp, 56]
	bl	fclose
	mov	x0, x21
	bl	fix_owner
	mov	x2, x21
	mov	x1, x19
	ldr	x21, [sp, 32]
	adrp	x0, .LC6
	ldp	x19, x20, [sp, 16]
	add	x0, x0, :lo12:.LC6
	ldp	x29, x30, [sp], 64
	b	printf
	.p2align 2,,3
.L18:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x21
	ldr	x21, [sp, 32]
	adrp	x1, .LC4
	ldr	x0, [x0]
	add	x1, x1, :lo12:.LC4
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
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
	sub	sp, sp, #1616
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x23, x24, [sp, 48]
	mov	x23, x0
	str	x25, [sp, 64]
	adrp	x25, .LC1
	add	x0, x25, :lo12:.LC1
	bl	fopen_nofollow
	cbz	x0, .L19
	add	x3, x25, :lo12:.LC1
	adrp	x2, .LC7
	add	x2, x2, :lo12:.LC7
	mov	x1, 512
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	add	x0, sp, 80
	bl	xsnprintf
	add	x0, sp, 80
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	bl	fopen_nofollow
	mov	x24, x0
	cbz	x0, .L33
	stp	x21, x22, [sp, 32]
	adrp	x22, .LC10
	adrp	x21, .LC2
	add	x22, x22, :lo12:.LC10
	add	x21, x21, :lo12:.LC2
	.p2align 5,,15
.L21:
	mov	x2, x20
	add	x0, sp, 592
	mov	w1, 512
	bl	fgets
	cbz	x0, .L35
.L23:
	add	x3, sp, 592
	mov	x2, x22
	add	x19, sp, 1104
	mov	x1, 512
	mov	x0, x19
	bl	xsnprintf
	mov	x1, x21
	mov	x0, x19
	bl	strcspn
	strb	wzr, [x19, x0]
	mov	x1, x23
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L21
	mov	x1, x24
	add	x0, sp, 592
	bl	fputs
	mov	x2, x20
	add	x0, sp, 592
	mov	w1, 512
	bl	fgets
	cbnz	x0, .L23
.L35:
	mov	x0, x20
	bl	fclose
	mov	x0, x24
	bl	fclose
	add	x1, x25, :lo12:.LC1
	add	x0, sp, 80
	bl	rename
	cbnz	w0, .L36
	add	x0, x25, :lo12:.LC1
	bl	fix_owner
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
.L19:
	ldr	x25, [sp, 64]
	ldp	x29, x30, [sp]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 1616
	ret
	.p2align 2,,3
.L36:
	add	x0, sp, 80
	bl	remove
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 45
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	fwrite
	ldr	x25, [sp, 64]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 1616
	ret
	.p2align 2,,3
.L33:
	mov	x0, x20
	bl	fclose
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 44
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	b	.L19
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
	cbz	w0, .L82
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	printf
	bl	priv_prefix
	mov	x20, x0
	bl	use_noconfirm
	cbnz	w0, .L83
	adrp	x4, .LC13
	add	x4, x4, :lo12:.LC13
.L39:
	mov	x3, x20
	adrp	x2, .LC19
	add	x2, x2, :lo12:.LC19
	mov	x1, 256
	add	x0, sp, 96
	bl	xsnprintf
	add	x0, sp, 96
	bl	run_cmd
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
	mov	x22, x0
	cbz	x0, .L86
	stp	x25, x26, [sp, 64]
	add	x19, sp, 96
	adrp	x25, .LC25
	adrp	x26, :got:stderr
	ldr	x26, [x26, :got_lo12:stderr]
	add	x25, x25, :lo12:.LC25
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC2
	add	x23, x23, :lo12:.LC2
	mov	x24, 0
	mov	x20, 0
	mov	x21, 0
	str	x27, [sp, 80]
	.p2align 5,,15
.L44:
	mov	x2, x22
	mov	x0, x19
	mov	w1, 512
	bl	fgets
	cbz	x0, .L52
.L53:
	mov	x1, x23
	mov	x0, x19
	bl	strcspn
	strb	wzr, [x19, x0]
	ldrb	w0, [sp, 96]
	cmp	w0, 35
	ccmp	w0, 0, 4, ne
	beq	.L44
	mov	x0, x19
	bl	valid_pkgname
	cbz	w0, .L87
	cmp	x20, x24
	bne	.L66
	cbz	x20, .L67
	lsl	x1, x20, 4
	lsl	x24, x20, 1
.L50:
	mov	x0, x21
	bl	realloc
	mov	x27, x0
	cbz	x0, .L88
.L49:
	mov	x0, x19
	bl	strdup
	str	x0, [x27, x20, lsl 3]
	cbz	x0, .L68
	add	x20, x20, 1
	mov	x21, x27
	mov	x2, x22
	mov	x0, x19
	mov	w1, 512
	bl	fgets
	cbnz	x0, .L53
.L52:
	mov	x0, x22
	bl	fclose
	cbz	x20, .L89
	mov	x0, x20
	mov	x1, 1
	adrp	x25, .LC28
	bl	calloc
	add	x25, x25, :lo12:.LC28
	mov	x22, x0
	mov	x19, 0
	mov	x24, 0
	mov	x26, 0
	.p2align 5,,15
.L58:
	mov	x23, x19
	add	x19, x19, 1
	mov	x2, x20
	mov	x1, x19
	mov	x0, x25
	ldr	x27, [x21, x23, lsl 3]
	mov	x3, x27
	bl	printf
	mov	x0, x27
	bl	cmd_build
	cbz	x22, .L55
	strb	w0, [x22, x23]
.L55:
	cbz	w0, .L56
	add	x26, x26, 1
.L57:
	cmp	x19, x20
	bne	.L58
	adrp	x0, .LC29
	add	x0, x0, :lo12:.LC29
	bl	printf
	cbnz	x24, .L59
	adrp	x0, .LC30
	mov	x1, x26
	add	x0, x0, :lo12:.LC30
	bl	printf
.L60:
	mov	x19, x21
	add	x20, x21, x20, lsl 3
	mov	x0, x22
	bl	free
	.p2align 5,,15
.L63:
	ldr	x0, [x19], 8
	bl	free
	cmp	x20, x19
	bne	.L63
	mov	x0, x21
	bl	free
	cmp	x24, 0
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
.L82:
	stp	x21, x22, [sp, 32]
	bl	get_aur_sync
	cbz	w0, .L42
.L85:
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	b	.L43
	.p2align 2,,3
.L83:
	adrp	x4, .LC12
	add	x4, x4, :lo12:.LC12
	b	.L39
	.p2align 2,,3
.L66:
	mov	x27, x21
	b	.L49
	.p2align 2,,3
.L67:
	mov	x1, 128
	mov	x24, 16
	b	.L50
	.p2align 2,,3
.L56:
	add	x24, x24, 1
	b	.L57
	.p2align 2,,3
.L87:
	ldr	x0, [x26]
	mov	x2, x19
	mov	x1, x25
	bl	fprintf
	b	.L44
	.p2align 2,,3
.L89:
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	printf
	mov	x0, x21
	bl	free
	ldp	x21, x22, [sp, 32]
	mov	w0, 0
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldr	x27, [sp, 80]
.L91:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 608
	ret
	.p2align 2,,3
.L59:
	adrp	x0, .LC31
	mov	x2, x24
	mov	x1, x26
	add	x0, x0, :lo12:.LC31
	bl	printf
	cbz	x22, .L60
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
	ldrb	w0, [x22, x19]
	cbnz	w0, .L61
	ldr	x1, [x21, x19, lsl 3]
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
	mov	w2, w0
	adrp	x1, .LC20
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC20
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	b	.L91
.L86:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 36
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	fwrite
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	b	.L91
.L68:
	mov	x21, x27
	b	.L52
.L88:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 30
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC26
	add	x0, x0, :lo12:.LC26
	bl	fwrite
	b	.L52
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
