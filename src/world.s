	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"r\000"
	.align	2
.LC1:
	.ascii	"/usr/local/emerge/world\000"
	.align	2
.LC2:
	.ascii	"\015\012\000"
	.text
	.align	1
	.p2align 2,,3
	.global	is_in_world
	.syntax unified
	.thumb
	.thumb_func
	.type	is_in_world, %function
is_in_world:
	@ args = 0, pretend = 0, frame = 512
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r6, r0
	ldr	r1, .L10
	ldr	r0, .L10+4
	sub	sp, sp, #512
.LPIC0:
	add	r1, pc
.LPIC1:
	add	r0, pc
	bl	fopen_nofollow(PLT)
	mov	r5, r0
	mov	r4, r0
	cbz	r0, .L1
	ldr	r7, .L10+8
	mov	r4, sp
	mov	r8, #0
.LPIC2:
	add	r7, pc
	b	.L3
.L5:
	bl	strcspn(PLT)
	mov	r3, r0
	mov	r1, r6
	mov	r0, r4
	strb	r8, [r4, r3]
	bl	strcmp(PLT)
	cbz	r0, .L7
.L3:
	mov	r1, #512
	mov	r2, r5
	mov	r0, r4
	bl	fgets(PLT)
	mov	r1, r7
	mov	r3, r0
	mov	r0, r4
	cmp	r3, #0
	bne	.L5
	mov	r4, r3
.L4:
	mov	r0, r5
	bl	fclose(PLT)
.L1:
	mov	r0, r4
	add	sp, sp, #512
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L7:
	movs	r4, #1
	b	.L4
.L11:
	.align	2
.L10:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.section	.rodata.str1.4
	.align	2
.LC3:
	.ascii	"a\000"
	.align	2
.LC4:
	.ascii	"\033[1;31m[-] Could not open world file %s\012\033["
	.ascii	"0m\000"
	.align	2
.LC5:
	.ascii	"%s\012\000"
	.align	2
.LC6:
	.ascii	"\033[1;32m[+] %s registered in %s\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	add_to_world
	.syntax unified
	.thumb
	.thumb_func
	.type	add_to_world, %function
add_to_world:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r4, r0
	ldr	r5, .L20
.LPIC7:
	add	r5, pc
	bl	valid_pkgname(PLT)
	cbnz	r0, .L18
.L12:
	pop	{r3, r4, r5, r6, r7, pc}
.L18:
	mov	r0, r4
	bl	is_in_world(PLT)
	cmp	r0, #0
	bne	.L12
	ldr	r7, .L20+4
	ldr	r1, .L20+8
.LPIC4:
	add	r7, pc
.LPIC3:
	add	r1, pc
	mov	r0, r7
	bl	fopen_nofollow(PLT)
	mov	r6, r0
	cbz	r0, .L19
	ldr	r1, .L20+12
	mov	r2, r4
.LPIC8:
	add	r1, pc
	bl	fprintf(PLT)
	mov	r0, r6
	bl	fclose(PLT)
	mov	r0, r7
	bl	fix_owner(PLT)
	ldr	r0, .L20+16
	mov	r2, r7
	mov	r1, r4
.LPIC11:
	add	r0, pc
	pop	{r3, r4, r5, r6, r7, lr}
	b	printf(PLT)
.L19:
	ldr	r3, .L20+20
	mov	r2, r7
	ldr	r1, .L20+24
.LPIC6:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	pop	{r3, r4, r5, r6, r7, lr}
	b	fprintf(PLT)
.L21:
	.align	2
.L20:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC7+4)
	.word	.LC1-(.LPIC4+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC5-(.LPIC8+4)
	.word	.LC6-(.LPIC11+4)
	.word	stderr(GOT)
	.word	.LC4-(.LPIC6+4)
	.section	.rodata.str1.4
	.align	2
.LC7:
	.ascii	"%s.tmp\000"
	.align	2
.LC8:
	.ascii	"w\000"
	.align	2
.LC9:
	.ascii	"\033[1;31m[-] Could not update world file.\012\033["
	.ascii	"0m\000"
	.align	2
.LC10:
	.ascii	"%s\000"
	.align	2
.LC11:
	.ascii	"\033[1;31m[-] Could not replace world file.\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	remove_from_world
	.syntax unified
	.thumb
	.thumb_func
	.type	remove_from_world, %function
remove_from_world:
	@ args = 0, pretend = 0, frame = 1544
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r8, r0
	ldr	r4, .L41
	subw	sp, sp, #1548
	ldr	r1, .L41+4
	ldr	r3, .L41+8
.LPIC13:
	add	r4, pc
.LPIC12:
	add	r1, pc
	mov	r0, r4
.LPIC17:
	add	r3, pc
	str	r3, [sp, #4]
	bl	fopen_nofollow(PLT)
	cmp	r0, #0
	beq	.L22
	ldr	r2, .L41+12
	add	fp, sp, #8
	mov	r3, r4
	mov	r1, #512
.LPIC15:
	add	r2, pc
	mov	r6, r0
	mov	r0, fp
	bl	xsnprintf(PLT)
	ldr	r1, .L41+16
	mov	r0, fp
.LPIC16:
	add	r1, pc
	bl	fopen_nofollow(PLT)
	mov	r7, r0
	cmp	r0, #0
	beq	.L36
	ldr	r9, .L41+20
	add	r5, sp, #520
	ldr	r10, .L41+24
.LPIC19:
	add	r9, pc
.LPIC20:
	add	r10, pc
.L24:
	mov	r2, r6
	mov	r1, #512
	mov	r0, r5
	add	r4, sp, #1032
	bl	fgets(PLT)
	mov	ip, r0
	mov	r3, r5
	mov	r2, r9
	mov	r1, #512
	mov	r0, r4
	cmp	ip, #0
	beq	.L39
	bl	xsnprintf(PLT)
	mov	r1, r10
	mov	r0, r4
	bl	strcspn(PLT)
	mov	r3, r0
	mov	r1, r8
	mov	r0, r4
	movs	r2, #0
	strb	r2, [r4, r3]
	bl	strcmp(PLT)
	mov	r1, r7
	mov	r3, r0
	mov	r0, r5
	cmp	r3, #0
	beq	.L24
	bl	fputs(PLT)
	b	.L24
.L39:
	ldr	r4, .L41+28
	mov	r0, r6
	bl	fclose(PLT)
	mov	r0, r7
.LPIC21:
	add	r4, pc
	bl	fclose(PLT)
	mov	r0, fp
	mov	r1, r4
	bl	rename(PLT)
	cbnz	r0, .L40
	mov	r0, r4
	bl	fix_owner(PLT)
.L22:
	addw	sp, sp, #1548
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L40:
	mov	r0, fp
	bl	remove(PLT)
	ldr	r0, .L41+32
	ldr	r3, .L41+36
	movs	r2, #45
.LPIC22:
	add	r0, pc
.L38:
	ldr	r4, [sp, #4]
	movs	r1, #1
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	addw	sp, sp, #1548
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L36:
	mov	r0, r6
	bl	fclose(PLT)
	ldr	r0, .L41+40
	ldr	r3, .L41+36
	movs	r2, #44
.LPIC18:
	add	r0, pc
	b	.L38
.L42:
	.align	2
.L41:
	.word	.LC1-(.LPIC13+4)
	.word	.LC0-(.LPIC12+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC17+4)
	.word	.LC7-(.LPIC15+4)
	.word	.LC8-(.LPIC16+4)
	.word	.LC10-(.LPIC19+4)
	.word	.LC2-(.LPIC20+4)
	.word	.LC1-(.LPIC21+4)
	.word	.LC11-(.LPIC22+4)
	.word	stderr(GOT)
	.word	.LC9-(.LPIC18+4)
	.section	.rodata.str1.4
	.align	2
.LC12:
	.ascii	" --noconfirm\000"
	.align	2
.LC13:
	.ascii	"\000"
	.align	2
.LC14:
	.ascii	"\033[1;35m\012====================================="
	.ascii	"=====================\000"
	.align	2
.LC15:
	.ascii	"1.0.0\000"
	.align	2
.LC16:
	.ascii	"   ARCHTOO WORLD UPDATE v%s\012\000"
	.align	2
.LC17:
	.ascii	"==================================================="
	.ascii	"=======\012\033[0m\000"
	.align	2
.LC18:
	.ascii	"\033[1;34m\012>>> [SYSTEM] Upgrading binary package"
	.ascii	"s (pacman -Syu)...\012\033[0m\000"
	.align	2
.LC19:
	.ascii	"%spacman -Syu%s\000"
	.align	2
.LC20:
	.ascii	"\033[1;31m[-] pacman -Syu failed (exit %d). Not reb"
	.ascii	"uilding the world set on\012    top of a half-updat"
	.ascii	"ed system. Fix the upgrade, then retry.\012\033[0m\000"
	.align	2
.LC21:
	.ascii	"\033[1;32m[+] Binary packages up to date.\012\033[0"
	.ascii	"m\000"
	.align	2
.LC22:
	.ascii	"\033[1;34m>>> [AUR] Refresh enabled for AUR-backed "
	.ascii	"@world packages.\012\033[0m\000"
	.align	2
.LC23:
	.ascii	"\033[1;33m>>> [AUR] Refresh disabled; reusing local"
	.ascii	" AUR checkouts.\012\033[0m\000"
	.align	2
.LC24:
	.ascii	"\033[1;33m[-] No world file found.\012\033[0m\000"
	.align	2
.LC25:
	.ascii	"\033[1;31m[-] Skipping invalid entry in world file:"
	.ascii	" '%s'\012\033[0m\000"
	.align	2
.LC26:
	.ascii	"\033[1;31m[-] Out of memory.\012\033[0m\000"
	.align	2
.LC27:
	.ascii	"\033[1;33m[-] World file is empty.\012\033[0m\000"
	.align	2
.LC28:
	.ascii	"\033[1;33m\012>>> [WORLD %zu/%zu] Rebuilding: %s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC29:
	.ascii	"\033[1;35m\012====================================="
	.ascii	"=====================\012\033[0m\000"
	.align	2
.LC30:
	.ascii	"\033[1;32m>>> WORLD UPDATE COMPLETED (%zu packages)"
	.ascii	"\012\033[0m\000"
	.align	2
.LC31:
	.ascii	"\033[1;33m>>> WORLD UPDATE FINISHED: %zu succeeded,"
	.ascii	" %zu FAILED\012\033[0m\000"
	.align	2
.LC32:
	.ascii	"\033[1;31m    Failed:\033[0m\000"
	.align	2
.LC33:
	.ascii	" %s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_world_update
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_world_update, %function
cmd_world_update:
	@ args = 0, pretend = 0, frame = 528
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r0, .L97
	sub	sp, sp, #540
	ldr	fp, .L97+4
.LPIC26:
	add	r0, pc
	bl	puts(PLT)
	ldr	r1, .L97+8
	ldr	r0, .L97+12
.LPIC33:
	add	fp, pc
.LPIC27:
	add	r1, pc
.LPIC28:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L97+16
.LPIC29:
	add	r0, pc
	bl	printf(PLT)
	bl	get_sync(PLT)
	cbz	r0, .L44
	ldr	r0, .L97+20
.LPIC30:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	mov	r5, r0
	bl	use_noconfirm(PLT)
	cmp	r0, #0
	bne	.L89
	ldr	r1, .L97+24
.LPIC25:
	add	r1, pc
.L45:
	ldr	r2, .L97+28
	add	r4, sp, #24
	str	r1, [sp]
	mov	r3, r5
.LPIC31:
	add	r2, pc
	mov	r1, #256
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L90
	ldr	r0, .L97+32
.LPIC34:
	add	r0, pc
	bl	printf(PLT)
.L44:
	bl	get_aur_sync(PLT)
	cmp	r0, #0
	bne	.L91
	ldr	r0, .L97+36
.LPIC36:
	add	r0, pc
	bl	printf(PLT)
.L49:
	ldr	r1, .L97+40
	ldr	r0, .L97+44
.LPIC37:
	add	r1, pc
.LPIC38:
	add	r0, pc
	bl	fopen_nofollow(PLT)
	mov	r7, r0
	cmp	r0, #0
	beq	.L92
	ldr	r9, .L97+48
	mov	r8, #0
	ldr	r3, .L97+52
	mov	r5, r8
	mov	r10, r8
.LPIC40:
	add	r9, pc
	add	r4, sp, #24
.LPIC41:
	add	r3, pc
	str	r3, [sp, #12]
.L50:
	movs	r6, #0
.L52:
	mov	r1, #512
	mov	r2, r7
	mov	r0, r4
	bl	fgets(PLT)
	mov	r1, r9
	mov	r3, r0
	mov	r0, r4
	cmp	r3, #0
	beq	.L57
	bl	strcspn(PLT)
	strb	r6, [r4, r0]
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #35
	it	ne
	cmpne	r3, #0
	beq	.L52
	mov	r0, r4
	bl	valid_pkgname(PLT)
	cbz	r0, .L93
	cmp	r8, r5
	bne	.L72
	cmp	r8, #0
	beq	.L73
	lsl	r1, r8, #3
	lsl	r8, r8, #1
.L56:
	mov	r0, r10
	bl	realloc(PLT)
	mov	r6, r0
	cmp	r0, #0
	beq	.L94
.L55:
	mov	r0, r4
	bl	strdup(PLT)
	str	r0, [r6, r5, lsl #2]
	cbz	r0, .L74
	mov	r10, r6
	adds	r5, r5, #1
	movs	r6, #0
	b	.L52
.L91:
	ldr	r0, .L97+56
.LPIC35:
	add	r0, pc
	bl	printf(PLT)
	b	.L49
.L89:
	ldr	r1, .L97+60
.LPIC24:
	add	r1, pc
	b	.L45
.L72:
	mov	r6, r10
	b	.L55
.L73:
	movs	r1, #64
	mov	r8, #16
	b	.L56
.L93:
	ldr	r3, .L97+64
	mov	r2, r4
	ldr	r1, [sp, #12]
	ldr	r3, [fp, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L50
.L74:
	mov	r10, r6
.L57:
	mov	r0, r7
	bl	fclose(PLT)
	cmp	r5, #0
	beq	.L95
	movs	r1, #1
	mov	r0, r5
	bl	calloc(PLT)
	ldr	r3, .L97+68
	movs	r6, #0
	sub	r7, r10, #4
.LPIC44:
	add	r3, pc
	mov	r9, r6
	str	r3, [sp, #16]
	rsb	r3, r0, #1
	str	r10, [sp, #20]
	add	fp, r5, r0
	mov	r4, r0
	mov	r6, r0
	mov	r10, r3
	mov	r8, r9
	str	r5, [sp, #12]
.L64:
	ldr	r5, [r7, #4]!
	add	r1, r10, r4
	ldr	r2, [sp, #12]
	ldr	r0, [sp, #16]
	mov	r3, r5
	bl	printf(PLT)
	mov	r0, r5
	bl	cmd_build(PLT)
	cbz	r6, .L61
	strb	r0, [r4]
.L61:
	cbz	r0, .L62
	add	r9, r9, #1
.L63:
	adds	r4, r4, #1
	cmp	r4, fp
	bne	.L64
	ldr	r0, .L97+72
	mov	r3, r8
	ldr	r10, [sp, #20]
	mov	r8, r6
.LPIC45:
	add	r0, pc
	ldr	r5, [sp, #12]
	mov	r6, r3
	bl	printf(PLT)
	mov	r1, r9
	cbnz	r6, .L65
	ldr	r0, .L97+76
.LPIC46:
	add	r0, pc
	bl	printf(PLT)
.L66:
	mov	r4, r10
	add	r5, r10, r5, lsl #2
	mov	r0, r8
	bl	free(PLT)
.L69:
	ldr	r0, [r4], #4
	bl	free(PLT)
	cmp	r4, r5
	bne	.L69
	mov	r0, r10
	bl	free(PLT)
	clz	r0, r6
	lsrs	r0, r0, #5
	add	sp, sp, #540
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L62:
	add	r8, r8, #1
	b	.L63
.L95:
	ldr	r0, .L97+80
.LPIC43:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r10
	bl	free(PLT)
.L47:
	movs	r0, #0
	add	sp, sp, #540
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L65:
	ldr	r0, .L97+84
	mov	r2, r6
.LPIC47:
	add	r0, pc
	bl	printf(PLT)
	cmp	r8, #0
	beq	.L66
	ldr	r0, .L97+88
	add	fp, r5, #-1
	ldr	r9, .L97+92
	add	r4, r8, #-1
.LPIC48:
	add	r0, pc
	add	fp, fp, r8
.LPIC49:
	add	r9, pc
	mov	r7, r10
	bl	printf(PLT)
	b	.L68
.L67:
	adds	r7, r7, #4
	cmp	r4, fp
	beq	.L96
.L68:
	ldrb	r3, [r4, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L67
	ldr	r1, [r7]
	mov	r0, r9
	bl	printf(PLT)
	adds	r7, r7, #4
	cmp	r4, fp
	bne	.L68
.L96:
	movs	r0, #10
	bl	putchar(PLT)
	b	.L66
.L90:
	ldr	r3, .L97+64
	mov	r2, r0
	ldr	r1, .L97+96
.LPIC32:
	add	r1, pc
	ldr	r3, [fp, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L47
.L92:
	ldr	r3, .L97+64
	movs	r2, #36
	ldr	r0, .L97+100
	movs	r1, #1
.LPIC39:
	add	r0, pc
	ldr	r3, [fp, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L47
.L94:
	ldr	r3, .L97+64
	movs	r2, #30
	ldr	r0, .L97+104
	movs	r1, #1
.LPIC42:
	add	r0, pc
	ldr	r3, [fp, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L57
.L98:
	.align	2
.L97:
	.word	.LC14-(.LPIC26+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC33+4)
	.word	.LC15-(.LPIC27+4)
	.word	.LC16-(.LPIC28+4)
	.word	.LC17-(.LPIC29+4)
	.word	.LC18-(.LPIC30+4)
	.word	.LC13-(.LPIC25+4)
	.word	.LC19-(.LPIC31+4)
	.word	.LC21-(.LPIC34+4)
	.word	.LC23-(.LPIC36+4)
	.word	.LC0-(.LPIC37+4)
	.word	.LC1-(.LPIC38+4)
	.word	.LC2-(.LPIC40+4)
	.word	.LC25-(.LPIC41+4)
	.word	.LC22-(.LPIC35+4)
	.word	.LC12-(.LPIC24+4)
	.word	stderr(GOT)
	.word	.LC28-(.LPIC44+4)
	.word	.LC29-(.LPIC45+4)
	.word	.LC30-(.LPIC46+4)
	.word	.LC27-(.LPIC43+4)
	.word	.LC31-(.LPIC47+4)
	.word	.LC32-(.LPIC48+4)
	.word	.LC33-(.LPIC49+4)
	.word	.LC20-(.LPIC32+4)
	.word	.LC24-(.LPIC39+4)
	.word	.LC26-(.LPIC42+4)
	.section	.note.GNU-stack,"",%progbits
