	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s/src\000"
	.align	2
.LC1:
	.ascii	"find '%s' -mindepth 1 -maxdepth 1 -print -quit | gr"
	.ascii	"ep -q .\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	has_reusable_source_tree, %function
has_reusable_source_tree:
	@ args = 0, pretend = 0, frame = 1704
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r0
	ldr	r2, .L8
	sub	sp, sp, #1704
	mov	r1, #700
	add	r4, sp, #4
.LPIC0:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	dir_exists(PLT)
	cbz	r0, .L1
	ldr	r2, .L8+4
	mov	r3, r4
	add	r4, sp, #704
	mov	r1, #1000
.LPIC1:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd_quiet(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
.L1:
	add	sp, sp, #1704
	@ sp needed
	pop	{r4, pc}
.L9:
	.align	2
.L8:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"%s/.git/config\000"
	.align	2
.LC3:
	.ascii	"grep -qF 'aur.archlinux.org' '%s'\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	is_aur_checkout, %function
is_aur_checkout:
	@ args = 0, pretend = 0, frame = 1600
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r0
	ldr	r2, .L16
	sub	sp, sp, #1600
	mov	r1, #700
.LPIC2:
	add	r2, pc
	mov	r0, sp
	bl	xsnprintf(PLT)
	mov	r0, sp
	bl	file_exists(PLT)
	cbz	r0, .L10
	ldr	r2, .L16+4
	add	r4, sp, #700
	mov	r3, sp
	mov	r1, #900
.LPIC3:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd_quiet(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
.L10:
	add	sp, sp, #1600
	@ sp needed
	pop	{r4, pc}
.L17:
	.align	2
.L16:
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	restore_on_signal, %function
restore_on_signal:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r3, #1
	ldr	r4, .L25
.LPIC4:
	add	r4, pc
	str	r3, [r4]
	ldr	r3, [r4, #4]
	cbnz	r3, .L24
.L19:
	movs	r0, #130
	bl	_exit(PLT)
.L24:
	ldr	r1, .L25+4
	movs	r2, #52
	movs	r0, #2
.LPIC6:
	add	r1, pc
	bl	write(PLT)
	add	r1, r4, #8
	add	r0, r4, #776
	bl	rename(PLT)
	movs	r3, #0
	str	r3, [r4, #4]
	b	.L19
.L26:
	.align	2
.L25:
	.word	.LANCHOR0-(.LPIC4+4)
	.word	.LANCHOR1-(.LPIC6+4)
	.section	.rodata.str1.4
	.align	2
.LC4:
	.ascii	"\033[1;33m[!] Restoring previous build tree...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC5:
	.ascii	"rm -rf '%s'\000"
	.align	2
.LC6:
	.ascii	"cp -a '%s' '%s' && rm -rf '%s'\000"
	.align	2
.LC7:
	.ascii	"\033[1;32m[+] Previous build tree restored to %s\012"
	.ascii	"\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	restore_backup.part.0, %function
restore_backup.part.0:
	@ args = 0, pretend = 0, frame = 1704
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L34
	movs	r2, #48
	push	{r4, r5, r6, r7, lr}
	movs	r1, #1
	ldr	r4, .L34+4
.LPIC10:
	add	r3, pc
	ldr	r0, .L34+8
	subw	sp, sp, #1716
.LPIC11:
	add	r0, pc
	add	r5, sp, #12
	ldr	r7, [r3, r4]
	ldr	r4, .L34+12
	ldr	r3, [r7]
.LPIC12:
	add	r4, pc
	bl	fwrite(PLT)
	ldr	r2, .L34+16
	add	r6, r4, #8
	movw	r1, #1700
.LPIC13:
	add	r2, pc
	mov	r3, r6
	mov	r0, r5
	add	r4, r4, #776
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd_quiet(PLT)
	mov	r1, r6
	mov	r0, r4
	bl	rename(PLT)
	cbnz	r0, .L33
.L28:
	ldr	r3, .L34+20
	movs	r4, #0
	ldr	r1, .L34+24
.LPIC20:
	add	r3, pc
	ldr	r0, [r7]
.LPIC22:
	add	r1, pc
	add	r2, r3, #8
	str	r4, [r3, #4]
	bl	fprintf(PLT)
	addw	sp, sp, #1716
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L33:
	ldr	r2, .L34+28
	mov	r3, r4
	mov	r0, r5
	strd	r6, r4, [sp]
.LPIC17:
	add	r2, pc
	movw	r1, #1700
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd_quiet(PLT)
	b	.L28
.L35:
	.align	2
.L34:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC10+4)
	.word	stderr(GOT)
	.word	.LC4-(.LPIC11+4)
	.word	.LANCHOR0-(.LPIC12+4)
	.word	.LC5-(.LPIC13+4)
	.word	.LANCHOR0-(.LPIC20+4)
	.word	.LC7-(.LPIC22+4)
	.word	.LC6-(.LPIC17+4)
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	"/usr/local/emerge/builds\000"
	.align	2
.LC9:
	.ascii	"%s/%s\000"
	.align	2
.LC10:
	.ascii	"\033[1;31m[-] Cannot change directory to %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC11:
	.ascii	"%s/.git\000"
	.align	2
.LC12:
	.ascii	"\033[1;31m[-] Cannot resume %s: its local AUR sourc"
	.ascii	"e tree is missing, and\012    --no-aur-sync forbids"
	.ascii	" retrieving it again.\012\033[0m\000"
	.align	2
.LC13:
	.ascii	"\033[1;32m[+] Resuming in existing build tree %s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC14:
	.ascii	"\033[1;33m[!] Not a git checkout; resuming anyway.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC15:
	.ascii	"\033[1;33m[!] --resume given but no build tree exis"
	.ascii	"ts for %s; starting fresh.\012\033[0m\000"
	.align	2
.LC16:
	.ascii	"\033[1;31m[-] Local AUR checkout exists for %s, but"
	.ascii	" its source tree is not reusable;\012    --no-aur-s"
	.ascii	"ync forbids downloading or extracting fresh AUR sou"
	.ascii	"rces.\012\033[0m\000"
	.align	2
.LC17:
	.ascii	"\033[1;33m[!] AUR refresh disabled; using local che"
	.ascii	"ckout %s\012\033[0m\000"
	.align	2
.LC18:
	.ascii	"/usr/local/emerge/backups\000"
	.align	2
.LC19:
	.ascii	"%s/%s.bak\000"
	.align	2
.LC20:
	.ascii	"\033[1;33m[!] Existing build tree found for %s.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC21:
	.ascii	"    Backing it up and removing it so the package is"
	.ascii	" rebuilt from scratch.\000"
	.align	2
.LC22:
	.ascii	"\033[1;31m[-] Could not move %s aside; refusing to "
	.ascii	"destroy it.\012\033[0m\000"
	.align	2
.LC23:
	.ascii	"\033[1;32m[+] Backup kept at %s\012\033[0m\000"
	.align	2
.LC24:
	.ascii	"Searching in official Arch repositories...\000"
	.align	2
.LC25:
	.ascii	"GIT_TERMINAL_PROMPT=0 pkgctl repo clone --protocol="
	.ascii	"https '%s' 2>'%s/.archtoo-fetch.log'\000"
	.align	2
.LC26:
	.ascii	"%s/PKGBUILD\000"
	.align	2
.LC27:
	.ascii	"\033[1;31m[-] %s is not in the official repos and n"
	.ascii	"o reusable local AUR\012    checkout exists; --no-a"
	.ascii	"ur-sync forbids cloning it.\012\033[0m\000"
	.align	2
.LC28:
	.ascii	"\033[1;33m[!] Not found in official repos. Refreshi"
	.ascii	"ng from AUR...\012\033[0m\000"
	.align	2
.LC29:
	.ascii	"GIT_TERMINAL_PROMPT=0 git clone 'https://aur.archli"
	.ascii	"nux.org/%s.git' 2>>'%s/.archtoo-fetch.log'\000"
	.align	2
.LC30:
	.ascii	"\033[1;31m[-] Package '%s' not found in Arch repos "
	.ascii	"or AUR.\012\033[0m\000"
	.align	2
.LC31:
	.ascii	"\033[1;33m    Details: %s/.archtoo-fetch.log\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	fetch_sources
	.syntax unified
	.thumb
	.thumb_func
	.type	fetch_sources, %function
fetch_sources:
	@ args = 0, pretend = 0, frame = 2912
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r1, #512
	ldr	ip, .L98
	subw	sp, sp, #2924
	ldr	r6, .L98+4
.LPIC23:
	add	ip, pc
	ldr	r2, .L98+8
.LPIC24:
	add	r6, pc
	add	r5, sp, #8
	str	r0, [sp]
	mov	lr, #0
	ldr	r7, .L98+12
	mov	r4, r0
	mov	r3, r6
.LPIC25:
	add	r2, pc
	mov	r0, r5
	str	lr, [ip, #1544]
	bl	xsnprintf(PLT)
	mov	r0, r6
.LPIC29:
	add	r7, pc
	bl	chdir(PLT)
	cmp	r0, #0
	bne	.L90
	bl	get_resume(PLT)
	cmp	r0, #0
	bne	.L91
.L39:
	bl	get_aur_sync(PLT)
	cbnz	r0, .L45
	mov	r0, r5
	bl	dir_exists(PLT)
	cmp	r0, #0
	bne	.L92
.L45:
	ldr	r6, .L98+16
	mov	r1, #768
	ldr	r3, .L98+20
.LPIC40:
	add	r6, pc
	ldr	r2, .L98+24
	add	r8, r6, #8
.LPIC38:
	add	r3, pc
.LPIC39:
	add	r2, pc
	mov	r0, r8
	str	r4, [sp]
	add	r6, r6, #776
	bl	xsnprintf(PLT)
	ldr	r3, .L98+28
	ldr	r2, .L98+32
	mov	r1, #768
.LPIC41:
	add	r3, pc
	mov	r0, r6
.LPIC42:
	add	r2, pc
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r8
	bl	dir_exists(PLT)
	addw	r8, sp, #1220
	cbz	r0, .L48
	mov	r0, r6
	addw	r8, sp, #1220
	bl	dir_exists(PLT)
	cmp	r0, #0
	bne	.L87
.L49:
	ldr	r0, .L98+36
	mov	r1, r4
	ldr	r6, .L98+40
.LPIC48:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L98+44
.LPIC50:
	add	r6, pc
	add	r9, r6, #776
.LPIC49:
	add	r0, pc
	adds	r6, r6, #8
	bl	puts(PLT)
	mov	r1, r9
	mov	r0, r6
	bl	rename(PLT)
	cmp	r0, #0
	bne	.L93
.L50:
	ldr	r1, .L98+48
	movs	r3, #1
	ldr	r0, .L98+52
.LPIC58:
	add	r1, pc
.LPIC60:
	add	r0, pc
	str	r3, [r1, #4]
	add	r1, r1, #776
	bl	printf(PLT)
.L48:
	ldr	r0, .L98+56
.LPIC61:
	add	r0, pc
	bl	puts(PLT)
	ldr	r3, .L98+60
	ldr	r2, .L98+64
	mov	r1, #1024
.LPIC63:
	add	r3, pc
	mov	r0, r8
	str	r3, [sp]
.LPIC62:
	add	r2, pc
	mov	r3, r4
	bl	xsnprintf(PLT)
	movs	r1, #0
	mov	r0, r8
	bl	run_as_user(PLT)
	cmp	r0, #0
	beq	.L51
.L54:
	bl	get_aur_sync(PLT)
	cmp	r0, #0
	beq	.L94
	ldr	r0, .L98+68
.LPIC66:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, .L98+72
	ldr	r2, .L98+76
	mov	r1, #1024
.LPIC68:
	add	r3, pc
	mov	r0, r8
	str	r3, [sp]
.LPIC67:
	add	r2, pc
	mov	r3, r4
	bl	xsnprintf(PLT)
	movs	r1, #0
	mov	r0, r8
	bl	run_as_user(PLT)
	cbnz	r0, .L59
	ldr	r2, .L98+80
	add	r6, sp, #520
	mov	r3, r5
	mov	r1, #700
.LPIC69:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	file_exists(PLT)
	cmp	r0, #0
	bne	.L47
.L59:
	mov	r0, r5
	bl	dir_exists(PLT)
	cmp	r0, #0
	bne	.L95
.L60:
	ldr	r3, .L98+84
	mov	r2, r4
	ldr	r1, .L98+88
.LPIC72:
	add	r1, pc
	ldr	r4, [r7, r3]
	ldr	r0, [r4]
	bl	fprintf(PLT)
	ldr	r2, .L98+92
	ldr	r1, .L98+96
	ldr	r0, [r4]
.LPIC73:
	add	r2, pc
.LPIC74:
	add	r1, pc
	bl	fprintf(PLT)
	b	.L38
.L91:
	ldr	r2, .L98+100
	addw	r8, sp, #1220
	mov	r3, r5
	mov	r1, #600
.LPIC30:
	add	r2, pc
	mov	r0, r8
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	dir_exists(PLT)
	cbz	r0, .L40
	bl	get_aur_sync(PLT)
	cbnz	r0, .L41
	mov	r0, r5
	bl	is_aur_checkout(PLT)
	cbz	r0, .L41
	mov	r0, r5
	bl	has_reusable_source_tree(PLT)
	mov	r6, r0
	cmp	r0, #0
	beq	.L96
.L41:
	ldr	r0, .L98+104
	mov	r1, r5
.LPIC32:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r8
	bl	dir_exists(PLT)
	cmp	r0, #0
	beq	.L97
.L47:
	movs	r6, #1
	mov	r0, r6
	addw	sp, sp, #2924
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L90:
	ldr	r3, .L98+84
	mov	r2, r6
	ldr	r1, .L98+108
.LPIC28:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L38:
	movs	r6, #0
.L36:
	mov	r0, r6
	addw	sp, sp, #2924
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L40:
	ldr	r3, .L98+84
	mov	r2, r4
	ldr	r1, .L98+112
.LPIC34:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L39
.L93:
	ldr	r2, .L98+116
	mov	r3, r6
	mov	r0, r8
	strd	r9, r6, [sp]
.LPIC53:
	add	r2, pc
	movw	r1, #1700
	bl	xsnprintf(PLT)
	mov	r0, r8
	bl	run_cmd_quiet(PLT)
	cmp	r0, #0
	beq	.L50
	ldr	r3, .L98+84
	mov	r2, r6
	ldr	r1, .L98+120
.LPIC57:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L38
.L51:
	ldr	r2, .L98+124
	add	r6, sp, #520
	mov	r3, r5
	mov	r1, #700
.LPIC64:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L54
	b	.L47
.L92:
	mov	r0, r5
	bl	is_aur_checkout(PLT)
	cmp	r0, #0
	beq	.L45
	mov	r0, r5
	bl	has_reusable_source_tree(PLT)
	cmp	r0, #0
	bne	.L46
	ldr	r3, .L98+84
	mov	r2, r4
	ldr	r1, .L98+128
.LPIC35:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L38
.L87:
	ldr	r2, .L98+132
	mov	r3, r6
	mov	r0, r8
	movw	r1, #1700
.LPIC47:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r8
	bl	run_cmd_quiet(PLT)
	b	.L49
.L94:
	ldr	r3, .L98+84
	mov	r2, r4
	ldr	r1, .L98+136
.LPIC65:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L38
.L97:
	ldr	r3, .L98+84
	movs	r2, #52
	ldr	r0, .L98+140
	movs	r1, #1
.LPIC33:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L47
.L96:
	ldr	r3, .L98+84
	mov	r2, r4
	ldr	r1, .L98+144
.LPIC31:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L36
.L95:
	ldr	r2, .L98+148
	add	r6, sp, #520
	mov	r3, r5
	mov	r1, #700
.LPIC70:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	file_exists(PLT)
	cmp	r0, #0
	bne	.L60
	ldr	r2, .L98+152
	mov	r3, r5
	mov	r1, #1024
	mov	r0, r8
.LPIC71:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r8
	bl	run_cmd_quiet(PLT)
	b	.L60
.L46:
	ldr	r0, .L98+156
	mov	r1, r5
.LPIC36:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, .L98+160
	movs	r2, #1
.LPIC37:
	add	r3, pc
	str	r2, [r3, #1544]
	b	.L47
.L99:
	.align	2
.L98:
	.word	.LANCHOR0-(.LPIC23+4)
	.word	.LC8-(.LPIC24+4)
	.word	.LC9-(.LPIC25+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC29+4)
	.word	.LANCHOR0-(.LPIC40+4)
	.word	.LC8-(.LPIC38+4)
	.word	.LC9-(.LPIC39+4)
	.word	.LC18-(.LPIC41+4)
	.word	.LC19-(.LPIC42+4)
	.word	.LC20-(.LPIC48+4)
	.word	.LANCHOR0-(.LPIC50+4)
	.word	.LC21-(.LPIC49+4)
	.word	.LANCHOR0-(.LPIC58+4)
	.word	.LC23-(.LPIC60+4)
	.word	.LC24-(.LPIC61+4)
	.word	.LC8-(.LPIC63+4)
	.word	.LC25-(.LPIC62+4)
	.word	.LC28-(.LPIC66+4)
	.word	.LC8-(.LPIC68+4)
	.word	.LC29-(.LPIC67+4)
	.word	.LC26-(.LPIC69+4)
	.word	stderr(GOT)
	.word	.LC30-(.LPIC72+4)
	.word	.LC8-(.LPIC73+4)
	.word	.LC31-(.LPIC74+4)
	.word	.LC11-(.LPIC30+4)
	.word	.LC13-(.LPIC32+4)
	.word	.LC10-(.LPIC28+4)
	.word	.LC15-(.LPIC34+4)
	.word	.LC6-(.LPIC53+4)
	.word	.LC22-(.LPIC57+4)
	.word	.LC26-(.LPIC64+4)
	.word	.LC16-(.LPIC35+4)
	.word	.LC5-(.LPIC47+4)
	.word	.LC27-(.LPIC65+4)
	.word	.LC14-(.LPIC33+4)
	.word	.LC12-(.LPIC31+4)
	.word	.LC26-(.LPIC70+4)
	.word	.LC5-(.LPIC71+4)
	.word	.LC17-(.LPIC36+4)
	.word	.LANCHOR0-(.LPIC37+4)
	.section	.rodata.str1.4
	.align	2
.LC32:
	.ascii	" --noconfirm --ask=6\000"
	.align	2
.LC33:
	.ascii	"\000"
	.align	2
.LC34:
	.ascii	"e\000"
	.align	2
.LC35:
	.ascii	" --noconfirm\000"
	.align	2
.LC36:
	.ascii	" -pipe\000"
	.align	2
.LC37:
	.ascii	"\033[1;31m[-] Cannot enter %s\012\033[0m\000"
	.align	2
.LC38:
	.ascii	"PKGBUILD\000"
	.align	2
.LC39:
	.ascii	"\033[1;31m[-] No PKGBUILD in %s\012\033[0m\000"
	.align	2
.LC40:
	.ascii	"\033[1;34m>>> Edit PKGBUILD for custom flags?\012\033"
	.ascii	"[0m\000"
	.align	2
.LC41:
	.ascii	"Open in editor\000"
	.align	2
.LC42:
	.ascii	"%s PKGBUILD\000"
	.align	2
.LC43:
	.ascii	"keys=$(awk '/^[[:space:]]*validpgpkeys=\\(/,/\\)/' "
	.ascii	"PKGBUILD | grep -oE '[0-9A-Fa-f]{40}|[0-9A-Fa-f]{16"
	.ascii	"}' | sort -u); [ -z \"$keys\" ] && exit 0; for k in"
	.ascii	" $keys; do   if gpg --list-keys \"$k\" >/dev/null 2"
	.ascii	">&1; then     echo \"    already have $k\";   else "
	.ascii	"    echo \"    importing $k\";     gpg --keyserver "
	.ascii	"keyserver.ubuntu.com --recv-keys \"$k\" >/dev/null "
	.ascii	"2>&1       || gpg --keyserver keys.openpgp.org --re"
	.ascii	"cv-keys \"$k\" >/dev/null 2>&1       || echo \"    "
	.ascii	"[!] could not fetch $k\";   fi; done\000"
	.align	2
.LC44:
	.ascii	"\033[1;34m>>> Checking PGP signing keys...\012\033["
	.ascii	"0m\000"
	.align	2
.LC45:
	.ascii	"makepkg --printsrcinfo > .archtoo-srcinfo\000"
	.align	2
.LC46:
	.ascii	"\033[1;31m[-] Could not inspect PKGBUILD dependenci"
	.ascii	"es.\012\033[0m\000"
	.align	2
.LC47:
	.ascii	"deps=$(awk '$1 ~ /^(depends|makedepends|checkdepend"
	.ascii	"s|depend|makedepend|checkdepend)(_[A-Za-z0-9_]+)?$/"
	.ascii	" && $2 == \"=\" { print $3 }' .archtoo-srcinfo | se"
	.ascii	"d 's/[<>=].*$//' | sort -u); own=$(awk '$1 ~ /^(pkg"
	.ascii	"name|pkgbase|provides|provide)(_[A-Za-z0-9_]+)?$/ &"
	.ascii	"& $2 == \"=\" { print $3 }' .archtoo-srcinfo | sed "
	.ascii	"'s/[<>=].*$//' | sort -u); printf '%%s\\n' $own > ."
	.ascii	"archtoo-ownpkgs; missing=; if [ -n \"$deps\" ]; the"
	.ascii	"n missing=$(pacman -T $deps 2>/dev/null | grep -vxF"
	.ascii	" -f .archtoo-ownpkgs || true); fi; if [ -n \"$missi"
	.ascii	"ng\" ]; then echo '>>> Installing missing repositor"
	.ascii	"y build dependencies...'; pacman -S --needed%s%s --"
	.ascii	" $missing; fi\000"
	.align	2
.LC48:
	.ascii	".archtoo-srcinfo\000"
	.align	2
.LC49:
	.ascii	".archtoo-ownpkgs\000"
	.align	2
.LC50:
	.ascii	"\033[1;31m[-] Could not install required repository"
	.ascii	" build dependencies (exit %d).\012\033[0m\000"
	.align	2
.LC51:
	.ascii	"\033[1;33m[!] Existing checkout has no reusable sou"
	.ascii	"rce tree; makepkg will fetch and extract it again.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC52:
	.ascii	" %s\000"
	.align	2
.LC53:
	.ascii	"makepkg -f%s --config '%s'%s%s\000"
	.align	2
.LC54:
	.ascii	"systemd-inhibit\000"
	.align	2
.LC55:
	.ascii	"systemd-inhibit --what=idle --who=archtoo --why=pro"
	.ascii	"be true\000"
	.align	2
.LC56:
	.ascii	"\033[1;34m>>> Suspend and idle inhibited for the du"
	.ascii	"ration of the build.\012\033[0m\000"
	.align	2
.LC57:
	.ascii	"systemd-inhibit --what=sleep:idle:handle-lid-switch"
	.ascii	" --who=archtoo --why='Compiling %s' --mode=block --"
	.ascii	" %s\000"
	.align	2
.LC58:
	.ascii	"\033[1;33m[!] systemd-inhibit is present but not us"
	.ascii	"able here (no logind session?);\012    building wit"
	.ascii	"hout suspend inhibition.\012\033[0m\000"
	.align	2
.LC59:
	.ascii	"%s\000"
	.align	2
.LC60:
	.ascii	"\033[1;33m[!] systemd-inhibit not found; the machin"
	.ascii	"e may suspend mid-build.\012\033[0m\000"
	.align	2
.LC61:
	.ascii	"-march=%s -O%s%s\000"
	.align	2
.LC62:
	.ascii	"export KCFLAGS='%s'\012export KCPPFLAGS='%s'\012exp"
	.ascii	"ort MAKEFLAGS='-j%ld'\012\000"
	.align	2
.LC63:
	.ascii	"\033[1;31m\012[-] Build interrupted by user.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC64:
	.ascii	"\033[1;31m[-] Compilation failed (exit %d).\012\033"
	.ascii	"[0m\000"
	.align	2
.LC65:
	.ascii	"remove_debug=; for archive in ./*.pkg.tar.*; do [ -"
	.ascii	"f \"$archive\" ] || continue; case $archive in *.si"
	.ascii	"g) continue;; esac; pkgname=$(bsdtar -xOf \"$archiv"
	.ascii	"e\" .PKGINFO 2>/dev/null | sed -n 's/^pkgname = //p"
	.ascii	"' | head -n1); case $pkgname in *-debug) ;; *) cont"
	.ascii	"inue;; esac; while IFS= read -r entry; do case $ent"
	.ascii	"ry in */|'') continue;; esac; entry=${entry#./}; ow"
	.ascii	"ner=$(pacman -Qoq \"/$entry\" 2>/dev/null | head -n"
	.ascii	"1); case $owner in *-debug) ;; *) continue;; esac; "
	.ascii	"[ \"$owner\" = \"$pkgname\" ] && continue; case \" "
	.ascii	"$remove_debug \" in *\" $owner \"*) ;; *) remove_de"
	.ascii	"bug=\"$remove_debug $owner\";; esac; done < <(bsdta"
	.ascii	"r -tf \"$archive\"); done; if [ -n \"$remove_debug\""
	.ascii	" ]; then echo \">>> Removing conflicting debug pack"
	.ascii	"age(s):$remove_debug\"; pacman -R%s -- $remove_debu"
	.ascii	"g || exit $?; fi\000"
	.align	2
.LC66:
	.ascii	"\033[1;31m[-] Could not remove conflicting debug pa"
	.ascii	"ckage(s).\012\033[0m\000"
	.align	2
.LC67:
	.ascii	"\033[1;34m>>> Installing built package(s) with pacm"
	.ascii	"an...\012\033[0m\000"
	.align	2
.LC68:
	.ascii	"find . -maxdepth 1 -type f -name '*.pkg.tar.*' ! -n"
	.ascii	"ame '*.sig' -exec pacman -U%s -- {} +\000"
	.align	2
.LC69:
	.ascii	"\033[1;31m[-] Package installation failed (exit %d)"
	.ascii	".\012\033[0m\000"
	.align	2
.LC70:
	.ascii	" [reusing sources]\000"
	.align	2
.LC71:
	.ascii	"\033[1;34m>>> Compiling with makepkg (%s, -j%ld)%s."
	.ascii	"..\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	compile_package
	.syntax unified
	.thumb
	.thumb_func
	.type	compile_package, %function
compile_package:
	@ args = 0, pretend = 0, frame = 14808
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r1, #512
	ldr	r3, .L187
	sub	sp, sp, #14784
	ldr	r2, .L187+4
	sub	sp, sp, #40
	ldr	r7, .L187+8
	add	r6, sp, #488
	mov	r5, r0
.LPIC87:
	add	r3, pc
.LPIC88:
	add	r2, pc
	str	r0, [sp]
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
.LPIC90:
	add	r7, pc
	bl	chdir(PLT)
	cmp	r0, #0
	bne	.L171
	mov	r4, r0
	ldr	r0, .L187+12
.LPIC91:
	add	r0, pc
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L172
	ldr	r0, .L187+16
.LPIC93:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L187+20
	mov	r1, r4
.LPIC94:
	add	r0, pc
	bl	ask_yes_no(PLT)
	cmp	r0, #0
	bne	.L173
.L105:
	bl	get_import_keys(PLT)
	cbz	r0, .L107
	ldr	r0, .L187+24
.LPIC96:
	add	r0, pc
	bl	file_exists(PLT)
	cmp	r0, #0
	bne	.L174
.L107:
	ldr	r0, .L187+28
	movs	r1, #0
.LPIC99:
	add	r0, pc
	bl	run_as_user(PLT)
	cmp	r0, #0
	bne	.L175
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	bne	.L176
	ldr	r8, .L187+32
.LPIC76:
	add	r8, pc
.L110:
	bl	use_noconfirm(PLT)
	ldr	r2, .L187+36
	addw	r4, sp, #2536
	mov	r3, r8
.LPIC102:
	add	r2, pc
	str	r2, [sp]
	ldr	r2, .L187+40
	mov	r1, #4096
	mov	r0, r4
.LPIC101:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	mov	r8, r0
	ldr	r0, .L187+44
.LPIC103:
	add	r0, pc
	bl	unlink(PLT)
	ldr	r0, .L187+48
.LPIC104:
	add	r0, pc
	bl	unlink(PLT)
	cmp	r8, #0
	bne	.L177
	add	r8, sp, #1000
	bl	set_build_env(PLT)
	mov	r1, #512
	mov	r0, r8
	bl	write_makepkg_conf(PLT)
	cmp	r0, #0
	beq	.L102
	ldr	r3, .L187+52
.LPIC106:
	add	r3, pc
	ldr	r3, [r3, #1544]
	cmp	r3, #0
	beq	.L178
.L112:
	bl	get_resume(PLT)
	mov	r1, #256
	mov	r0, r4
	bl	render_build_flags(PLT)
	bl	get_jobs(PLT)
	ldr	r3, .L187+56
	mov	r2, r0
	ldr	r0, .L187+60
.LPIC130:
	add	r3, pc
	mov	r1, r4
.LPIC131:
	add	r0, pc
	bl	printf(PLT)
	subw	r3, r4, #2500
	movs	r2, #0
	strb	r2, [r3]
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L141
	add	r9, sp, #40
	add	r6, sp, #36
.L142:
	ldr	r10, .L187+64
.LPIC77:
	add	r10, pc
.L125:
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	beq	.L145
	ldr	r3, .L187+68
.LPIC79:
	add	r3, pc
.L126:
	ldr	r2, .L187+72
	mov	r1, #1024
	str	r8, [sp]
	add	r8, sp, #1512
.LPIC110:
	add	r2, pc
	strd	r3, r6, [sp, #4]
	mov	r0, r8
	mov	r3, r10
	bl	xsnprintf(PLT)
	bl	get_inhibit(PLT)
	cbz	r0, .L128
	ldr	r0, .L187+76
.LPIC111:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	bne	.L179
.L128:
	ldr	r2, .L187+80
	add	r6, sp, #6624
	adds	r6, r6, #8
	mov	r3, r8
.LPIC116:
	add	r2, pc
	mov	r1, #8192
	mov	r0, r6
	bl	xsnprintf(PLT)
	bl	get_inhibit(PLT)
	cmp	r0, #0
	bne	.L180
.L131:
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L146
	ldr	r3, .L187+84
.LPIC81:
	add	r3, pc
.L134:
	ldr	r2, .L187+88
	sub	r9, r9, #20
	movs	r1, #16
	mov	r0, r9
.LPIC119:
	add	r2, pc
	bl	xsnprintf(PLT)
	bl	get_target_arch(PLT)
	mov	r5, r0
	bl	get_opt_level(PLT)
	ldr	r2, .L187+92
	mov	r3, r5
	add	r5, sp, #232
.LPIC120:
	add	r2, pc
	mov	r1, #256
	str	r0, [sp]
	mov	r0, r5
	str	r9, [sp, #4]
	bl	xsnprintf(PLT)
	bl	get_jobs(PLT)
	ldr	r2, .L187+96
	mov	r3, r5
	mov	r1, #1024
.LPIC121:
	add	r2, pc
	str	r0, [sp, #4]
	str	r5, [sp]
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r1, r4
	mov	r0, r6
	bl	run_as_user(PLT)
	sub	r3, r0, #129
	cmp	r0, #143
	it	ne
	cmpne	r3, #2
	bls	.L181
	cmp	r0, #0
	bne	.L182
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	bne	.L183
	ldr	r3, .L187+100
.LPIC84:
	add	r3, pc
.L138:
	ldr	r2, .L187+104
	mov	r1, #8192
	mov	r0, r6
.LPIC125:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L184
	ldr	r0, .L187+108
.LPIC127:
	add	r0, pc
	bl	printf(PLT)
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	beq	.L148
	ldr	r3, .L187+112
.LPIC85:
	add	r3, pc
.L140:
	ldr	r2, .L187+116
	mov	r1, #8192
	mov	r0, r6
.LPIC128:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L185
	movs	r0, #1
	b	.L100
.L172:
	ldr	r3, .L187+120
	mov	r2, r6
	ldr	r1, .L187+124
.LPIC92:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L102:
	movs	r0, #0
.L100:
	add	sp, sp, #14784
	add	sp, sp, #40
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L171:
	ldr	r3, .L187+120
	mov	r2, r6
	ldr	r1, .L187+128
.LPIC89:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L102
.L176:
	ldr	r8, .L187+132
.LPIC75:
	add	r8, pc
	b	.L110
.L174:
	ldr	r2, .L187+136
	addw	r4, sp, #2536
	mov	r1, #2048
	mov	r0, r4
.LPIC97:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r0, .L187+140
.LPIC98:
	add	r0, pc
	bl	printf(PLT)
	movs	r1, #0
	mov	r0, r4
	bl	run_as_user(PLT)
	b	.L107
.L175:
	ldr	r3, .L187+120
	movs	r2, #56
	ldr	r0, .L187+144
	movs	r1, #1
.LPIC100:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L102
.L173:
	bl	get_editor(PLT)
	add	r8, sp, #6624
	ldr	r2, .L187+148
	add	r8, r8, #8
	mov	r3, r0
	mov	r1, #8192
.LPIC95:
	add	r2, pc
	mov	r0, r8
	bl	xsnprintf(PLT)
	mov	r1, r4
	mov	r0, r8
	bl	run_as_user(PLT)
	b	.L105
.L146:
	ldr	r3, .L187+152
.LPIC82:
	add	r3, pc
	b	.L134
.L145:
	ldr	r3, .L187+156
.LPIC80:
	add	r3, pc
	b	.L126
.L177:
	ldr	r3, .L187+120
	mov	r2, r8
	ldr	r1, .L187+160
.LPIC105:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L102
.L183:
	ldr	r3, .L187+164
.LPIC83:
	add	r3, pc
	b	.L138
.L179:
	ldr	r0, .L187+168
.LPIC112:
	add	r0, pc
	bl	run_cmd_quiet(PLT)
	cmp	r0, #0
	bne	.L130
	ldr	r0, .L187+172
	add	r6, sp, #6624
	adds	r6, r6, #8
.LPIC113:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L187+176
	mov	r3, r5
	mov	r1, #8192
.LPIC114:
	add	r2, pc
	mov	r0, r6
	str	r8, [sp]
	bl	xsnprintf(PLT)
	b	.L131
.L182:
	ldr	r3, .L187+120
	mov	r2, r0
	ldr	r1, .L187+180
.LPIC124:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L102
.L178:
	bl	get_resume(PLT)
	cmp	r0, #0
	bne	.L186
.L113:
	bl	get_resume(PLT)
	cbz	r0, .L165
	ldr	r0, .L187+184
.LPIC107:
	add	r0, pc
	bl	printf(PLT)
.L165:
	mov	r1, #256
	mov	r0, r4
	bl	render_build_flags(PLT)
	bl	get_jobs(PLT)
	ldr	r3, .L187+188
	mov	r2, r0
	ldr	r0, .L187+192
.LPIC132:
	add	r3, pc
	mov	r1, r4
.LPIC133:
	add	r0, pc
	bl	printf(PLT)
	subw	r3, r4, #2500
	movs	r2, #0
	strb	r2, [r3]
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L143
	add	r9, sp, #40
	add	r6, sp, #36
.L124:
	ldr	r10, .L187+196
.LPIC78:
	add	r10, pc
	b	.L125
.L180:
	ldr	r0, .L187+200
.LPIC117:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	bne	.L131
	ldr	r3, .L187+120
	movs	r2, #77
	ldr	r0, .L187+204
	movs	r1, #1
.LPIC118:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L131
.L184:
	ldr	r3, .L187+120
	movs	r2, #62
	ldr	r0, .L187+208
	movs	r1, #1
.LPIC126:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L102
.L148:
	ldr	r3, .L187+212
.LPIC86:
	add	r3, pc
	b	.L140
.L141:
	bl	get_makepkg_raw(PLT)
	add	r9, sp, #40
	ldr	r2, .L187+216
	sub	r6, r9, #4
	mov	r3, r0
	movs	r1, #194
.LPIC109:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	b	.L142
.L143:
	bl	get_makepkg_raw(PLT)
	add	r9, sp, #40
	ldr	r2, .L187+220
	sub	r6, r9, #4
	mov	r3, r0
	movs	r1, #194
.LPIC108:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	b	.L124
.L186:
	mov	r0, r6
	bl	has_reusable_source_tree(PLT)
	cmp	r0, #0
	bne	.L112
	b	.L113
.L185:
	ldr	r3, .L187+120
	mov	r2, r0
	ldr	r1, .L187+224
.LPIC129:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L102
.L130:
	ldr	r3, .L187+120
	movs	r2, #125
	ldr	r0, .L187+228
	movs	r1, #1
.LPIC115:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L128
.L181:
	ldr	r3, .L187+120
	movs	r2, #43
	ldr	r0, .L187+232
	movs	r1, #1
.LPIC122:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	ldr	r3, .L187+236
.LPIC123:
	add	r3, pc
	ldr	r3, [r3, #4]
	cbz	r3, .L136
	bl	restore_backup.part.0(PLT)
.L136:
	movs	r0, #130
	bl	exit(PLT)
.L188:
	.align	2
.L187:
	.word	.LC8-(.LPIC87+4)
	.word	.LC9-(.LPIC88+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC90+4)
	.word	.LC38-(.LPIC91+4)
	.word	.LC40-(.LPIC93+4)
	.word	.LC41-(.LPIC94+4)
	.word	.LC38-(.LPIC96+4)
	.word	.LC45-(.LPIC99+4)
	.word	.LC33-(.LPIC76+4)
	.word	.LC33-(.LPIC102+4)
	.word	.LC47-(.LPIC101+4)
	.word	.LC48-(.LPIC103+4)
	.word	.LC49-(.LPIC104+4)
	.word	.LANCHOR0-(.LPIC106+4)
	.word	.LC70-(.LPIC130+4)
	.word	.LC71-(.LPIC131+4)
	.word	.LC34-(.LPIC77+4)
	.word	.LC35-(.LPIC79+4)
	.word	.LC53-(.LPIC110+4)
	.word	.LC54-(.LPIC111+4)
	.word	.LC59-(.LPIC116+4)
	.word	.LC36-(.LPIC81+4)
	.word	.LC59-(.LPIC119+4)
	.word	.LC61-(.LPIC120+4)
	.word	.LC62-(.LPIC121+4)
	.word	.LC33-(.LPIC84+4)
	.word	.LC65-(.LPIC125+4)
	.word	.LC67-(.LPIC127+4)
	.word	.LC32-(.LPIC85+4)
	.word	.LC68-(.LPIC128+4)
	.word	stderr(GOT)
	.word	.LC39-(.LPIC92+4)
	.word	.LC37-(.LPIC89+4)
	.word	.LC32-(.LPIC75+4)
	.word	.LC43-(.LPIC97+4)
	.word	.LC44-(.LPIC98+4)
	.word	.LC46-(.LPIC100+4)
	.word	.LC42-(.LPIC95+4)
	.word	.LC33-(.LPIC82+4)
	.word	.LC33-(.LPIC80+4)
	.word	.LC50-(.LPIC105+4)
	.word	.LC35-(.LPIC83+4)
	.word	.LC55-(.LPIC112+4)
	.word	.LC56-(.LPIC113+4)
	.word	.LC57-(.LPIC114+4)
	.word	.LC64-(.LPIC124+4)
	.word	.LC51-(.LPIC107+4)
	.word	.LC33-(.LPIC132+4)
	.word	.LC71-(.LPIC133+4)
	.word	.LC33-(.LPIC78+4)
	.word	.LC54-(.LPIC117+4)
	.word	.LC60-(.LPIC118+4)
	.word	.LC66-(.LPIC126+4)
	.word	.LC33-(.LPIC86+4)
	.word	.LC52-(.LPIC109+4)
	.word	.LC52-(.LPIC108+4)
	.word	.LC69-(.LPIC129+4)
	.word	.LC58-(.LPIC115+4)
	.word	.LC63-(.LPIC122+4)
	.word	.LANCHOR0-(.LPIC123+4)
	.section	.rodata.str1.4
	.align	2
.LC72:
	.ascii	"grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:"
	.ascii	"space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'\000"
	.align	2
.LC73:
	.ascii	"/etc/pacman.conf\000"
	.align	2
.LC74:
	.ascii	"\033[1;32m[+] %s is already locked in IgnorePkg\012"
	.ascii	"\033[0m\000"
	.align	2
.LC75:
	.ascii	"%scp -n '%s' '%s.archtoo.bak'\000"
	.align	2
.LC76:
	.ascii	"if grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=' '"
	.ascii	"%s'; then %ssed -i -E '0,/^[[:space:]]*IgnorePkg[[:"
	.ascii	"space:]]*=/{ /^[[:space:]]*IgnorePkg[[:space:]]*=/{"
	.ascii	" s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; elif grep -"
	.ascii	"qE '^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*"
	.ascii	"=' '%s'; then %ssed -i -E '0,/^[[:space:]]*#[[:spac"
	.ascii	"e:]]*IgnorePkg[[:space:]]*=/{ /^[[:space:]]*#[[:spa"
	.ascii	"ce:]]*IgnorePkg[[:space:]]*=/{ s/^[[:space:]]*#[[:s"
	.ascii	"pace:]]*//; s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; "
	.ascii	"else %ssed -i '/^\\[options\\]/a IgnorePkg = %s' '%"
	.ascii	"s'; fi\000"
	.align	2
.LC77:
	.ascii	"\033[1;31m[-] Failed to lock %s in %s -- check the "
	.ascii	"file by hand.\012\033[0m\000"
	.align	2
.LC78:
	.ascii	"\033[1;32m[+] %s locked in pacman.conf\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	lock_pacman_pkg
	.syntax unified
	.thumb
	.thumb_func
	.type	lock_pacman_pkg, %function
lock_pacman_pkg:
	@ args = 0, pretend = 0, frame = 2368
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r2, #320
	ldr	r8, .L202
	subw	sp, sp, #2412
	mov	r4, r0
	add	r7, sp, #40
.LPIC150:
	add	r8, pc
	mov	r1, r7
	bl	regex_escape(PLT)
	cbnz	r0, .L199
.L190:
	movs	r0, #0
	addw	sp, sp, #2412
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L199:
	ldr	r9, .L202+4
	add	r6, sp, #360
	ldr	r5, .L202+8
	mov	r3, r7
.LPIC134:
	add	r9, pc
	mov	r1, #2048
.LPIC135:
	add	r5, pc
	mov	r2, r9
	mov	r0, r6
	str	r5, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	cmp	r0, #0
	beq	.L200
	bl	priv_prefix(PLT)
	ldr	r2, .L202+12
	mov	r3, r0
	mov	r1, #2048
.LPIC137:
	add	r2, pc
	mov	r0, r6
	strd	r5, r5, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	bl	priv_prefix(PLT)
	mov	r10, r0
	bl	priv_prefix(PLT)
	mov	fp, r0
	bl	priv_prefix(PLT)
	ldr	r2, .L202+16
	mov	r3, r5
	mov	r1, #2048
.LPIC141:
	add	r2, pc
	str	r0, [sp, #28]
	str	fp, [sp, #16]
	mov	r0, r6
	str	r10, [sp]
	strd	r4, r5, [sp, #32]
	strd	r4, r5, [sp, #20]
	strd	r5, r5, [sp, #8]
	str	r4, [sp, #4]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	mov	r3, r7
	mov	r2, r9
	mov	r1, #2048
	mov	r0, r6
	str	r5, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	cbnz	r0, .L201
	ldr	r0, .L202+20
	mov	r1, r4
.LPIC151:
	add	r0, pc
	bl	printf(PLT)
.L192:
	movs	r0, #1
	addw	sp, sp, #2412
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L200:
	ldr	r0, .L202+24
	mov	r1, r4
.LPIC136:
	add	r0, pc
	bl	printf(PLT)
	b	.L192
.L201:
	ldr	r0, .L202+28
	mov	r3, r5
	ldr	r1, .L202+32
	mov	r2, r4
.LPIC149:
	add	r1, pc
	ldr	r0, [r8, r0]
	ldr	r0, [r0]
	bl	fprintf(PLT)
	b	.L190
.L203:
	.align	2
.L202:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC150+4)
	.word	.LC72-(.LPIC134+4)
	.word	.LC73-(.LPIC135+4)
	.word	.LC75-(.LPIC137+4)
	.word	.LC76-(.LPIC141+4)
	.word	.LC78-(.LPIC151+4)
	.word	.LC74-(.LPIC136+4)
	.word	stderr(GOT)
	.word	.LC77-(.LPIC149+4)
	.section	.rodata.str1.4
	.align	2
.LC79:
	.ascii	"\033[1;33m[-] Build directory kept (--resume): %s/%"
	.ascii	"s\012\033[0m\000"
	.align	2
.LC80:
	.ascii	"\033[1;34m>>> Clean up build directory?\012\033[0m\000"
	.align	2
.LC81:
	.ascii	"Remove directory\000"
	.align	2
.LC82:
	.ascii	"\033[1;33m[-] Build directory preserved in %s/%s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC83:
	.ascii	"rm -rf '%s/%s'\000"
	.align	2
.LC84:
	.ascii	"\033[1;32m[+] Build directory cleaned up.\012\033[0"
	.ascii	"m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cleanup_build_dir
	.syntax unified
	.thumb
	.thumb_func
	.type	cleanup_build_dir, %function
cleanup_build_dir:
	@ args = 0, pretend = 0, frame = 600
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r5, r0
	sub	sp, sp, #612
	bl	get_resume(PLT)
	cbnz	r0, .L211
	mov	r4, r0
	ldr	r0, .L213
.LPIC154:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L213+4
	mov	r1, r4
.LPIC155:
	add	r0, pc
	bl	ask_yes_no(PLT)
	cbz	r0, .L212
	ldr	r4, .L213+8
.LPIC158:
	add	r4, pc
	mov	r0, r4
	bl	chdir(PLT)
	cbnz	r0, .L204
	ldr	r2, .L213+12
	mov	r3, r4
	add	r4, sp, #8
	mov	r1, #600
.LPIC160:
	add	r2, pc
	mov	r0, r4
	str	r5, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	ldr	r0, .L213+16
.LPIC161:
	add	r0, pc
	bl	printf(PLT)
.L204:
	add	sp, sp, #612
	@ sp needed
	pop	{r4, r5, pc}
.L212:
	ldr	r1, .L213+20
	mov	r2, r5
	ldr	r0, .L213+24
.LPIC156:
	add	r1, pc
.LPIC157:
	add	r0, pc
	add	sp, sp, #612
	@ sp needed
	pop	{r4, r5, lr}
	b	printf(PLT)
.L211:
	ldr	r1, .L213+28
	mov	r2, r5
	ldr	r0, .L213+32
.LPIC152:
	add	r1, pc
.LPIC153:
	add	r0, pc
	add	sp, sp, #612
	@ sp needed
	pop	{r4, r5, lr}
	b	printf(PLT)
.L214:
	.align	2
.L213:
	.word	.LC80-(.LPIC154+4)
	.word	.LC81-(.LPIC155+4)
	.word	.LC8-(.LPIC158+4)
	.word	.LC83-(.LPIC160+4)
	.word	.LC84-(.LPIC161+4)
	.word	.LC8-(.LPIC156+4)
	.word	.LC82-(.LPIC157+4)
	.word	.LC8-(.LPIC152+4)
	.word	.LC79-(.LPIC153+4)
	.section	.rodata.str1.4
	.align	2
.LC85:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC86:
	.ascii	"\033[1;32m[+] --binary: proceeding with %s (not %s)"
	.ascii	"\012\033[0m\000"
	.align	2
.LC87:
	.ascii	"\033[1;33m[!] Binary install failed for %s, falling"
	.ascii	" back to source build\012\033[0m\000"
	.align	2
.LC88:
	.ascii	"Continue with source build?\000"
	.align	2
.LC89:
	.ascii	".\000"
	.align	2
.LC90:
	.ascii	"\033[1;34m>>> [%d/%d] Fetching sources for %s...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC91:
	.ascii	"\033[1;34m>>> [%d/%d] Compiling package...\012\033["
	.ascii	"0m\000"
	.align	2
.LC92:
	.ascii	"\033[1;34m>>> [%d/%d] Running kernel hooks...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC93:
	.ascii	"%s-headers\000"
	.align	2
.LC94:
	.ascii	"\033[1;34m>>> [%d/%d] Locking in pacman.conf...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC95:
	.ascii	"\033[1;34m>>> [%d/%d] Cleaning up...\012\033[0m\000"
	.align	2
.LC96:
	.ascii	"\033[1;32m\012>>> DONE! %s is custom built and inst"
	.ascii	"alled.\012\033[0m\000"
	.align	2
.LC97:
	.ascii	"\033[1;33m[!] Reboot to load your new kernel.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC98:
	.ascii	"\033[1;33m[!] %s is named like a kernel, but the bu"
	.ascii	"ilt package contains no\012    usr/lib/modules/<kve"
	.ascii	"r>/vmlinuz; skipping kernel hooks and the -headers "
	.ascii	"lock.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_build
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_build, %function
cmd_build:
	@ args = 0, pretend = 0, frame = 1200
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r2, #300
	mov	r4, r0
	sub	sp, sp, #1200
	ldr	r8, .L256
	movs	r1, #0
	mov	r0, sp
	bl	memset(PLT)
	mov	r0, r4
.LPIC163:
	add	r8, pc
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L252
	bl	get_use_binary(PLT)
	cmp	r0, #0
	bne	.L253
.L219:
	ldr	r0, .L256+4
	mov	r1, #524288
	add	r6, sp, #300
.LPIC167:
	add	r0, pc
	bl	open64(PLT)
	add	r3, sp, #304
	movs	r2, #136
	movs	r1, #0
	mov	r7, r0
	mov	r0, r3
	bl	memset(PLT)
	ldr	r3, .L256+8
.LPIC168:
	add	r3, pc
	str	r3, [r6]
	bl	sigemptyset(PLT)
	movs	r2, #0
	mov	r1, r6
	movs	r0, #2
	bl	sigaction(PLT)
	movs	r2, #0
	mov	r1, r6
	movs	r0, #15
	bl	sigaction(PLT)
	mov	r1, r6
	movs	r2, #0
	movs	r0, #1
	bl	sigaction(PLT)
	ldr	r3, .L256+12
	mov	r0, r4
	movs	r2, #0
.LPIC169:
	add	r3, pc
	str	r2, [r3, #4]
	bl	is_kernel(PLT)
	subs	r10, r0, #0
	ldr	r0, .L256+16
	ite	eq
	moveq	r9, #4
	movne	r9, #5
.LPIC170:
	add	r0, pc
	mov	r3, r4
	mov	r2, r9
	movs	r1, #1
	bl	printf(PLT)
	mov	r0, r4
	bl	fetch_sources(PLT)
	cbnz	r0, .L254
.L224:
	ldr	r3, .L256+20
.LPIC186:
	add	r3, pc
	ldr	r3, [r3, #4]
	cbz	r3, .L232
	bl	restore_backup.part.0(PLT)
.L232:
	movs	r5, #0
.L231:
	cmp	r7, #0
	blt	.L215
	mov	r0, r7
	bl	fchdir(PLT)
	mov	r0, r7
	bl	close(PLT)
.L215:
	mov	r0, r5
	add	sp, sp, #1200
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L254:
	ldr	r0, .L256+24
	mov	r2, r9
	movs	r1, #2
.LPIC171:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	compile_package(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L224
	cmp	r10, #0
	bne	.L255
	ldr	r0, .L256+28
	mov	r2, r9
	movs	r1, #3
.LPIC187:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	lock_pacman_pkg(PLT)
	mov	r0, r4
	bl	add_to_world(PLT)
	ldr	r0, .L256+32
	movs	r1, #4
	mov	r2, r9
.LPIC188:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	cleanup_build_dir(PLT)
	ldr	r0, .L256+36
	mov	r1, r4
.LPIC189:
	add	r0, pc
	bl	printf(PLT)
.L227:
	ldr	r4, .L256+40
.LPIC182:
	add	r4, pc
	ldr	r3, [r4, #4]
	cmp	r3, #0
	beq	.L231
	ldr	r2, .L256+44
	add	r3, r4, #776
	mov	r1, #900
	mov	r0, r6
.LPIC184:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	movs	r3, #0
	str	r3, [r4, #4]
	b	.L231
.L253:
	mov	r2, #300
	mov	r1, sp
	mov	r0, r4
	bl	cmd_binary_install(PLT)
	mov	r5, r0
	cmp	r0, #1
	beq	.L215
	cmp	r0, #2
	bne	.L221
	ldrb	r3, [sp]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L219
	mov	r1, r4
	mov	r0, sp
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L219
	ldr	r0, .L256+48
	mov	r2, r4
	mov	r1, sp
	mov	r4, sp
.LPIC164:
	add	r0, pc
	bl	printf(PLT)
	b	.L219
.L252:
	ldr	r3, .L256+52
	mov	r2, r4
	ldr	r1, .L256+56
.LPIC162:
	add	r1, pc
	ldr	r3, [r8, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L217:
	movs	r5, #0
	mov	r0, r5
	add	sp, sp, #1200
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L221:
	ldr	r0, .L256+60
	mov	r1, r4
.LPIC165:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L256+64
	movs	r1, #0
.LPIC166:
	add	r0, pc
	bl	ask_yes_no(PLT)
	cmp	r0, #0
	bne	.L219
	b	.L217
.L255:
	mov	r0, r4
	bl	pkg_ships_kernel(PLT)
	cbz	r0, .L226
	ldr	r0, .L256+68
	mov	r2, r9
	movs	r1, #3
.LPIC172:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	run_kernel_hooks(PLT)
	ldr	r2, .L256+72
	mov	r3, r4
	mov	r1, #256
.LPIC173:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	lock_pacman_pkg(PLT)
	ldr	r0, .L256+76
	mov	r2, r9
	movs	r1, #4
.LPIC174:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	lock_pacman_pkg(PLT)
	mov	r0, r4
	bl	add_to_world(PLT)
	ldr	r0, .L256+80
	mov	r2, r9
	movs	r1, #5
.LPIC175:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	cleanup_build_dir(PLT)
	ldr	r0, .L256+84
	mov	r1, r4
.LPIC176:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L256+88
.LPIC177:
	add	r0, pc
	bl	printf(PLT)
	b	.L227
.L226:
	ldr	r3, .L256+52
	mov	r2, r4
	ldr	r1, .L256+92
.LPIC178:
	add	r1, pc
	ldr	r3, [r8, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r0, .L256+96
	mov	r2, r9
	movs	r1, #3
.LPIC179:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	lock_pacman_pkg(PLT)
	mov	r0, r4
	bl	add_to_world(PLT)
	ldr	r0, .L256+100
	mov	r2, r9
	movs	r1, #4
.LPIC180:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	cleanup_build_dir(PLT)
	ldr	r0, .L256+104
	mov	r1, r4
.LPIC181:
	add	r0, pc
	bl	printf(PLT)
	b	.L227
.L257:
	.align	2
.L256:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC163+4)
	.word	.LC89-(.LPIC167+4)
	.word	restore_on_signal-(.LPIC168+4)
	.word	.LANCHOR0-(.LPIC169+4)
	.word	.LC90-(.LPIC170+4)
	.word	.LANCHOR0-(.LPIC186+4)
	.word	.LC91-(.LPIC171+4)
	.word	.LC94-(.LPIC187+4)
	.word	.LC95-(.LPIC188+4)
	.word	.LC96-(.LPIC189+4)
	.word	.LANCHOR0-(.LPIC182+4)
	.word	.LC5-(.LPIC184+4)
	.word	.LC86-(.LPIC164+4)
	.word	stderr(GOT)
	.word	.LC85-(.LPIC162+4)
	.word	.LC87-(.LPIC165+4)
	.word	.LC88-(.LPIC166+4)
	.word	.LC92-(.LPIC172+4)
	.word	.LC93-(.LPIC173+4)
	.word	.LC94-(.LPIC174+4)
	.word	.LC95-(.LPIC175+4)
	.word	.LC96-(.LPIC176+4)
	.word	.LC97-(.LPIC177+4)
	.word	.LC98-(.LPIC178+4)
	.word	.LC94-(.LPIC179+4)
	.word	.LC95-(.LPIC180+4)
	.word	.LC96-(.LPIC181+4)
	.section	.rodata
	.align	3
	.set	.LANCHOR1,. + 0
	.type	msg.0, %object
msg.0:
	.ascii	"\012[!] Interrupted - restoring previous build tree"
	.ascii	"...\012\000"
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_interrupted, %object
g_interrupted:
	.space	4
	.type	g_have_backup, %object
g_have_backup:
	.space	4
	.type	g_target, %object
g_target:
	.space	768
	.type	g_backup, %object
g_backup:
	.space	768
	.type	g_reused_local_sources, %object
g_reused_local_sources:
	.space	4
	.section	.note.GNU-stack,"",%progbits
