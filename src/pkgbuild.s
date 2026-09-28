	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\000"
	.align	2
.LC1:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC2:
	.ascii	"%s/PKGBUILD\000"
	.align	2
.LC3:
	.ascii	"\033[1;34m>>> Updating existing checkout %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC4:
	.ascii	"GIT_TERMINAL_PROMPT=0 git -C %s pull --ff-only\000"
	.align	2
.LC5:
	.ascii	"\033[1;34m>>> Cloning https://aur.archlinux.org/%s."
	.ascii	"git\012\033[0m\000"
	.align	2
.LC6:
	.ascii	"GIT_TERMINAL_PROMPT=0 git clone -- 'https://aur.arc"
	.ascii	"hlinux.org/%s.git' %s\000"
	.align	2
.LC7:
	.ascii	"\033[1;31m[-] Could not fetch PKGBUILD for '%s'.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC8:
	.ascii	"\033[1;31m[-] Clone succeeded but %s is missing.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC9:
	.ascii	"\033[1;32m[+] PKGBUILD is at %s\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_get_pkgbuild_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_get_pkgbuild_v2, %function
cmd_get_pkgbuild_v2:
	@ args = 0, pretend = 0, frame = 1856
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, r0
	ldr	r5, .L24
	sub	sp, sp, #1864
.LPIC1:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L2
	ldr	r3, .L24+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	cmp	r4, #0
	beq	.L20
.L3:
	ldr	r1, .L24+8
	mov	r2, r4
.LPIC2:
	add	r1, pc
	bl	fprintf(PLT)
.L4:
	movs	r0, #0
	add	sp, sp, #1864
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L2:
	add	r6, sp, #8
	mov	r2, #320
	mov	r1, r6
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L4
	ldr	r2, .L24+12
	add	r7, sp, #328
	mov	r3, r4
	mov	r1, #512
.LPIC3:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	dir_exists(PLT)
	cbnz	r0, .L21
.L7:
	ldr	r0, .L24+16
	mov	r1, r4
	add	r8, sp, #840
.LPIC6:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L24+20
	mov	r3, r4
	mov	r1, #1024
.LPIC7:
	add	r2, pc
	mov	r0, r8
	str	r6, [sp]
	bl	xsnprintf(PLT)
.L8:
	movs	r1, #0
	mov	r0, r8
	bl	run_as_user(PLT)
	cbnz	r0, .L22
	mov	r0, r7
	bl	file_exists(PLT)
	cbz	r0, .L23
	ldr	r0, .L24+24
	mov	r1, r7
.LPIC10:
	add	r0, pc
	bl	printf(PLT)
	movs	r0, #1
	add	sp, sp, #1864
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L20:
	ldr	r4, .L24+28
.LPIC0:
	add	r4, pc
	b	.L3
.L21:
	mov	r0, r7
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L7
	ldr	r0, .L24+32
	mov	r1, r4
	add	r8, sp, #840
.LPIC4:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L24+36
	mov	r3, r6
	mov	r1, #1024
.LPIC5:
	add	r2, pc
	mov	r0, r8
	bl	xsnprintf(PLT)
	b	.L8
.L22:
	ldr	r3, .L24+4
	mov	r2, r4
	ldr	r1, .L24+40
.LPIC8:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L4
.L23:
	ldr	r3, .L24+4
	mov	r2, r7
	ldr	r1, .L24+44
.LPIC9:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L4
.L25:
	.align	2
.L24:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	stderr(GOT)
	.word	.LC1-(.LPIC2+4)
	.word	.LC2-(.LPIC3+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC0-(.LPIC0+4)
	.word	.LC3-(.LPIC4+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC8-(.LPIC9+4)
	.section	.rodata.str1.4
	.align	2
.LC10:
	.ascii	" --noconfirm\000"
	.align	2
.LC11:
	.ascii	"\033[1;31m[-] Local build requires a directory.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC12:
	.ascii	"\033[1;31m[-] Invalid build directory.\012\033[0m\000"
	.align	2
.LC13:
	.ascii	"\033[1;31m[-] Directory does not exist: %s\012\033["
	.ascii	"0m\000"
	.align	2
.LC14:
	.ascii	"\033[1;31m[-] No PKGBUILD in %s\012\033[0m\000"
	.align	2
.LC15:
	.ascii	"\033[1;34m>>> Building local PKGBUILD in %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC16:
	.ascii	" %s\000"
	.align	2
.LC17:
	.ascii	"cd %s && makepkg -f%s%s\000"
	.align	2
.LC18:
	.ascii	"\033[1;31m[-] Local build failed.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_local_build_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_local_build_v2, %function
cmd_local_build_v2:
	@ args = 0, pretend = 0, frame = 4472
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	ldr	r5, .L53
	sub	sp, sp, #4480
	sub	sp, sp, #4
.LPIC13:
	add	r5, pc
	cbz	r0, .L27
	ldrb	r3, [r0]	@ zero_extendqisi2
	mov	r4, r0
	cbz	r3, .L27
	movs	r1, #10
	bl	strchr(PLT)
	cbnz	r0, .L30
	movs	r1, #13
	mov	r0, r4
	bl	strchr(PLT)
	mov	r6, r0
	cbz	r0, .L31
.L30:
	ldr	r3, .L53+4
	movs	r2, #40
	ldr	r0, .L53+8
	movs	r1, #1
.LPIC15:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
.L29:
	movs	r0, #0
.L26:
	add	sp, sp, #4480
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L27:
	ldr	r3, .L53+4
	movs	r2, #49
	ldr	r0, .L53+12
	movs	r1, #1
.LPIC14:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L29
.L31:
	mov	r0, r4
	bl	dir_exists(PLT)
	cmp	r0, #0
	beq	.L49
	ldr	r2, .L53+16
	add	r7, sp, #1232
	mov	r3, r4
	mov	r1, #1200
.LPIC17:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	file_exists(PLT)
	cbz	r0, .L50
	add	r7, sp, #208
	mov	r2, #1024
	mov	r1, r7
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L29
	ldr	r0, .L53+20
	mov	r1, r4
	add	r4, sp, #12
.LPIC19:
	add	r0, pc
	bl	printf(PLT)
	strb	r6, [sp, #12]
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L51
.L35:
	bl	use_noconfirm(PLT)
	cbz	r0, .L37
	ldr	r1, .L53+24
.LPIC11:
	add	r1, pc
.L36:
	ldr	r2, .L53+28
	mov	r3, r7
	str	r4, [sp, #4]
	add	r4, sp, #2432
	str	r1, [sp]
.LPIC21:
	add	r2, pc
	mov	r1, #2048
	mov	r0, r4
	bl	xsnprintf(PLT)
	movs	r1, #0
	mov	r0, r4
	bl	run_as_user(PLT)
	cbnz	r0, .L52
	movs	r0, #1
	b	.L26
.L50:
	ldr	r3, .L53+4
	mov	r2, r4
	ldr	r1, .L53+32
.LPIC18:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L29
.L49:
	ldr	r3, .L53+4
	mov	r2, r4
	ldr	r1, .L53+36
.LPIC16:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L29
.L37:
	ldr	r1, .L53+40
.LPIC12:
	add	r1, pc
	b	.L36
.L51:
	bl	get_makepkg_raw(PLT)
	ldr	r2, .L53+44
	add	r4, sp, #12
	mov	r3, r0
.LPIC20:
	add	r2, pc
	movs	r1, #194
	mov	r0, r4
	bl	xsnprintf(PLT)
	b	.L35
.L52:
	ldr	r3, .L53+4
	movs	r2, #35
	ldr	r0, .L53+48
	movs	r1, #1
.LPIC22:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L29
.L54:
	.align	2
.L53:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC13+4)
	.word	stderr(GOT)
	.word	.LC12-(.LPIC15+4)
	.word	.LC11-(.LPIC14+4)
	.word	.LC2-(.LPIC17+4)
	.word	.LC15-(.LPIC19+4)
	.word	.LC10-(.LPIC11+4)
	.word	.LC17-(.LPIC21+4)
	.word	.LC14-(.LPIC18+4)
	.word	.LC13-(.LPIC16+4)
	.word	.LC0-(.LPIC12+4)
	.word	.LC16-(.LPIC20+4)
	.word	.LC18-(.LPIC22+4)
	.section	.note.GNU-stack,"",%progbits
