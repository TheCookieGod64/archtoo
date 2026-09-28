	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%ssed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{"
	.ascii	"s/[[:space:]]+%s([[:space:]]|$)/\\1/g;s/=[[:space:]"
	.ascii	"]*%s([[:space:]]|$)/= /g;s/[[:space:]]+$//;s/=[[:sp"
	.ascii	"ace:]]+/= /g}' '%s'\000"
	.align	2
.LC1:
	.ascii	"/etc/pacman.conf\000"
	.text
	.align	1
	.p2align 2,,3
	.global	unlock_pacman_pkg
	.syntax unified
	.thumb
	.thumb_func
	.type	unlock_pacman_pkg, %function
unlock_pacman_pkg:
	@ args = 0, pretend = 0, frame = 2368
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r2, #320
	sub	sp, sp, #2384
	add	r4, sp, #16
	mov	r1, r4
	bl	regex_escape(PLT)
	cbz	r0, .L1
	bl	priv_prefix(PLT)
	ldr	r1, .L8
	ldr	r2, .L8+4
	mov	r3, r0
.LPIC1:
	add	r1, pc
	str	r4, [sp]
	strd	r4, r1, [sp, #4]
	add	r4, sp, #336
.LPIC0:
	add	r2, pc
	mov	r1, #2048
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
.L1:
	add	sp, sp, #2384
	@ sp needed
	pop	{r4, pc}
.L9:
	.align	2
.L8:
	.word	.LC1-(.LPIC1+4)
	.word	.LC0-(.LPIC0+4)
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC3:
	.ascii	"\033[1;33m[!] %s is not in the world set; unlocking"
	.ascii	" anyway.\012\033[0m\000"
	.align	2
.LC4:
	.ascii	"\033[1;34m>>> [1/2] Unlocking %s in pacman.conf...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC5:
	.ascii	"%s-headers\000"
	.align	2
.LC6:
	.ascii	"\033[1;34m>>> [2/2] Removing %s from the world set."
	.ascii	"..\012\033[0m\000"
	.align	2
.LC7:
	.ascii	"\033[1;32m[+] %s deselected. It stays installed, an"
	.ascii	"d pacman will\012    manage it again from the offic"
	.ascii	"ial repositories.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_deselect
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_deselect, %function
cmd_deselect:
	@ args = 0, pretend = 0, frame = 256
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r4, r0
	ldr	r6, .L22
	sub	sp, sp, #256
.LPIC3:
	add	r6, pc
	bl	valid_pkgname(PLT)
	cbz	r0, .L19
	mov	r0, r4
	bl	is_in_world(PLT)
	cbz	r0, .L20
.L13:
	ldr	r0, .L22+4
	mov	r1, r4
.LPIC5:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	unlock_pacman_pkg(PLT)
	mov	r0, r4
	bl	is_kernel(PLT)
	cbnz	r0, .L21
.L14:
	ldr	r0, .L22+8
	mov	r1, r4
	movs	r5, #1
.LPIC7:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	remove_from_world(PLT)
	ldr	r0, .L22+12
	mov	r1, r4
.LPIC8:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r5
	add	sp, sp, #256
	@ sp needed
	pop	{r4, r5, r6, pc}
.L21:
	ldr	r2, .L22+16
	mov	r3, r4
	mov	r1, #256
	mov	r0, sp
.LPIC6:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, sp
	bl	unlock_pacman_pkg(PLT)
	b	.L14
.L20:
	ldr	r3, .L22+20
	mov	r2, r4
	ldr	r1, .L22+24
.LPIC4:
	add	r1, pc
	ldr	r3, [r6, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L13
.L19:
	ldr	r3, .L22+20
	mov	r5, r0
	ldr	r1, .L22+28
	mov	r2, r4
.LPIC2:
	add	r1, pc
	ldr	r3, [r6, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r5
	add	sp, sp, #256
	@ sp needed
	pop	{r4, r5, r6, pc}
.L23:
	.align	2
.L22:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC5-(.LPIC6+4)
	.word	stderr(GOT)
	.word	.LC3-(.LPIC4+4)
	.word	.LC2-(.LPIC2+4)
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	" --noconfirm\000"
	.align	2
.LC9:
	.ascii	"\000"
	.align	2
.LC10:
	.ascii	"\033[1;34m>>> [1/2] Imitation package: removing %s "
	.ascii	"via chroot-world manifest...\012\033[0m\000"
	.align	2
.LC11:
	.ascii	"\033[1;31m[-] Chroot unmerge failed.\012\033[0m\000"
	.align	2
.LC12:
	.ascii	"\033[1;34m>>> [2/2] Cleaning world entry...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC13:
	.ascii	"\033[1;32m[+] %s successfully unmerged (chroot vdb "
	.ascii	"left intact).\012\033[0m\000"
	.align	2
.LC14:
	.ascii	"\033[1;34m>>> [1/3] Unmerging %s via pacman...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC15:
	.ascii	"%s-debug\000"
	.align	2
.LC16:
	.ascii	"pacman -Qq '%s'\000"
	.align	2
.LC17:
	.ascii	"%spacman -Rns '%s' '%s'%s\000"
	.align	2
.LC18:
	.ascii	"%spacman -Rns '%s'%s\000"
	.align	2
.LC19:
	.ascii	"\033[1;31m[-] Unmerge failed.\012\033[0m\000"
	.align	2
.LC20:
	.ascii	"\033[1;34m>>> [2/3] Unlocking %s in pacman.conf...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC21:
	.ascii	"\033[1;34m>>> [3/3] Cleaning up world file and buil"
	.ascii	"d directory...\012\033[0m\000"
	.align	2
.LC22:
	.ascii	"/usr/local/emerge/builds\000"
	.align	2
.LC23:
	.ascii	"rm -rf '%s/%s'\000"
	.align	2
.LC24:
	.ascii	"\033[1;32m[+] %s successfully unmerged.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_unmerge
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_unmerge, %function
cmd_unmerge:
	@ args = 0, pretend = 0, frame = 2048
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	mov	r4, r0
	ldr	r5, .L48
	subw	sp, sp, #2068
.LPIC14:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L43
	mov	r0, r4
	bl	gentoo_chroot_manifest_exists(PLT)
	cbz	r0, .L27
	ldr	r0, .L48+4
	mov	r1, r4
.LPIC15:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	gentoo_chroot_unmerge(PLT)
	cmp	r0, #0
	beq	.L44
	ldr	r0, .L48+8
.LPIC17:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	remove_from_world(PLT)
	ldr	r0, .L48+12
	mov	r1, r4
.LPIC18:
	add	r0, pc
	bl	printf(PLT)
.L30:
	movs	r0, #1
	addw	sp, sp, #2068
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L27:
	ldr	r0, .L48+16
	mov	r1, r4
	add	r7, sp, #16
	add	r6, sp, #528
.LPIC19:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L48+20
	mov	r3, r4
	mov	r1, #256
.LPIC20:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	ldr	r2, .L48+24
	mov	r3, r7
	mov	r1, #512
.LPIC21:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	cmp	r0, #0
	beq	.L45
	bl	priv_prefix(PLT)
	mov	r7, r0
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	beq	.L38
	ldr	r2, .L48+28
.LPIC11:
	add	r2, pc
.L34:
	str	r2, [sp, #4]
	add	r6, sp, #1040
	ldr	r2, .L48+32
	mov	r3, r7
	mov	r1, #1024
	mov	r0, r6
.LPIC23:
	add	r2, pc
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L46
.L35:
	ldr	r0, .L48+36
	mov	r1, r4
.LPIC25:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	unlock_pacman_pkg(PLT)
	mov	r0, r4
	bl	is_kernel(PLT)
	cmp	r0, #0
	bne	.L47
.L36:
	ldr	r0, .L48+40
.LPIC27:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	remove_from_world(PLT)
	ldr	r3, .L48+44
	ldr	r2, .L48+48
	mov	r1, #1024
.LPIC28:
	add	r3, pc
	mov	r0, r6
.LPIC29:
	add	r2, pc
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	ldr	r0, .L48+52
	mov	r1, r4
.LPIC30:
	add	r0, pc
	bl	printf(PLT)
	b	.L30
.L43:
	ldr	r3, .L48+56
	mov	r2, r4
	ldr	r1, .L48+60
.LPIC13:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L26:
	movs	r0, #0
	addw	sp, sp, #2068
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L44:
	ldr	r3, .L48+56
	movs	r2, #38
	ldr	r0, .L48+64
	movs	r1, #1
.LPIC16:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L26
.L45:
	bl	priv_prefix(PLT)
	mov	r6, r0
	bl	use_noconfirm(PLT)
	cbz	r0, .L37
	ldr	r3, .L48+68
.LPIC9:
	add	r3, pc
.L32:
	ldr	r2, .L48+72
	mov	r1, #1024
	str	r3, [sp, #8]
	mov	r3, r6
	add	r6, sp, #1040
.LPIC22:
	add	r2, pc
	mov	r0, r6
	strd	r4, r7, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	cmp	r0, #0
	beq	.L35
.L46:
	ldr	r3, .L48+56
	movs	r2, #31
	ldr	r0, .L48+76
	movs	r1, #1
.LPIC24:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L26
.L38:
	ldr	r2, .L48+80
.LPIC12:
	add	r2, pc
	b	.L34
.L37:
	ldr	r3, .L48+84
.LPIC10:
	add	r3, pc
	b	.L32
.L47:
	ldr	r2, .L48+88
	add	r5, sp, #272
	mov	r3, r4
	mov	r1, #256
.LPIC26:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	unlock_pacman_pkg(PLT)
	b	.L36
.L49:
	.align	2
.L48:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC14+4)
	.word	.LC10-(.LPIC15+4)
	.word	.LC12-(.LPIC17+4)
	.word	.LC13-(.LPIC18+4)
	.word	.LC14-(.LPIC19+4)
	.word	.LC15-(.LPIC20+4)
	.word	.LC16-(.LPIC21+4)
	.word	.LC8-(.LPIC11+4)
	.word	.LC18-(.LPIC23+4)
	.word	.LC20-(.LPIC25+4)
	.word	.LC21-(.LPIC27+4)
	.word	.LC22-(.LPIC28+4)
	.word	.LC23-(.LPIC29+4)
	.word	.LC24-(.LPIC30+4)
	.word	stderr(GOT)
	.word	.LC2-(.LPIC13+4)
	.word	.LC11-(.LPIC16+4)
	.word	.LC8-(.LPIC9+4)
	.word	.LC17-(.LPIC22+4)
	.word	.LC19-(.LPIC24+4)
	.word	.LC9-(.LPIC12+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC5-(.LPIC26+4)
	.section	.note.GNU-stack,"",%progbits
