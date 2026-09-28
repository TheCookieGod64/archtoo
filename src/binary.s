	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"?\000"
	.align	2
.LC1:
	.ascii	"\000"
	.align	2
.LC2:
	.ascii	"\033[1;32m    aur/%s  %s  (\342\227\206%ld %.2f) %s"
	.ascii	"\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	aur_has_exact, %function
aur_has_exact:
	@ args = 0, pretend = 0, frame = 264
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r5, #256
	mov	r2, r5
	sub	sp, sp, #284
	movs	r1, #0
	add	r4, sp, #24
	mov	r8, r0
	mov	r0, r4
	add	r9, sp, #16
	bl	memset(PLT)
	vmov.i32	d16, #0  @ v8qi
	vstr	d16, [sp, #16]
	bl	config_current(PLT)
	mov	r3, r4
	adds	r0, r0, #16
	mov	r2, r9
	mov	r1, r8
	str	r5, [sp]
	bl	aur_rpc_info(PLT)
	mov	r6, r0
	cbz	r0, .L1
	ldr	r6, [r9, #4]
	cbz	r6, .L3
	ldr	r4, [r9]
	movs	r7, #0
.L7:
	ldr	r5, [r4]
	mov	r1, r8
	mov	r0, r5
	cbz	r5, .L4
	bl	strcmp(PLT)
	cbnz	r0, .L4
	ldr	r2, [r4, #8]
	cbz	r2, .L19
.L5:
	ldr	r6, [r4, #12]
	ldr	r3, [r4, #24]
	vldr.64	d16, [r4, #32]
	cbz	r6, .L20
.L6:
	str	r6, [sp, #8]
	movs	r6, #1
	ldr	r0, .L21
	mov	r1, r5
	vstr.64	d16, [sp]
.LPIC2:
	add	r0, pc
	bl	printf(PLT)
.L3:
	mov	r0, r9
	bl	aur_response_destroy(PLT)
.L1:
	mov	r0, r6
	add	sp, sp, #284
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L4:
	adds	r7, r7, #1
	adds	r4, r4, #88
	cmp	r7, r6
	bne	.L7
	movs	r6, #0
	b	.L3
.L20:
	ldr	r6, .L21+4
.LPIC1:
	add	r6, pc
	b	.L6
.L19:
	ldr	r2, .L21+8
.LPIC0:
	add	r2, pc
	b	.L5
.L22:
	.align	2
.L21:
	.word	.LC2-(.LPIC2+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC0-(.LPIC0+4)
	.section	.rodata.str1.4
	.align	2
.LC3:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC4:
	.ascii	"\033[1;33m>>> Binary mode: repo first, then yay-sty"
	.ascii	"le AUR binary search (long flag only)\012\033[0m\000"
	.align	2
.LC5:
	.ascii	"\033[1;34m>>> [1/2] Trying official repo binary via"
	.ascii	" pacman -S --needed %s...\012\033[0m\000"
	.align	2
.LC6:
	.ascii	"%spacman -S --needed --noconfirm '%s' 2>&1\000"
	.align	2
.LC7:
	.ascii	"pacman -Si '%s' >/dev/null 2>&1\000"
	.align	2
.LC8:
	.ascii	"\033[1;32m[+] %s installed from the official repo ("
	.ascii	"pacman -S). No world/lock needed: pacman owns it.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC9:
	.ascii	"\033[1;33m[!] Against Gentoo principles, but boring"
	.ascii	"-fast like yay\012\033[0m\000"
	.align	2
.LC10:
	.ascii	"\033[1;33m[!] %s is in the repos but pacman -S fail"
	.ascii	"ed (rc=%d); trying manual download route...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC11:
	.ascii	"pacman -Sp --noconfirm '%s' 2>/dev/null | head -n1\000"
	.align	2
.LC12:
	.ascii	"\033[1;31m[-] Could not get binary URL for %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC13:
	.ascii	"http\000"
	.align	2
.LC14:
	.ascii	"\033[1;31m[-] Invalid URL: '%s'\012\033[0m\000"
	.align	2
.LC15:
	.ascii	"\033[1;32m[+] Binary URL: %s\012\033[0m\000"
	.align	2
.LC16:
	.ascii	"/tmp/archtoo-bin-%s-%ld.pkg.tar.zst\000"
	.align	2
.LC17:
	.ascii	"curl -fL -o '%s' '%s' 2>&1 || wget -O '%s' '%s' 2>&"
	.ascii	"1\000"
	.align	2
.LC18:
	.ascii	"\033[1;34m>>> Downloading binary package...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC19:
	.ascii	"\033[1;31m[-] Failed to download binary for %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC20:
	.ascii	"rm -f '%s'\000"
	.align	2
.LC21:
	.ascii	"\033[1;34m>>> Checking SHA256 (self implementation,"
	.ascii	" no external program)...\012\033[0m\000"
	.align	2
.LC22:
	.ascii	"\033[1;31m[-] Could not compute SHA256 for %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC23:
	.ascii	"SHA256 check failed, try again?\000"
	.align	2
.LC24:
	.ascii	"\033[1;33m[!] Retrying download...\012\033[0m\000"
	.align	2
.LC25:
	.ascii	"\033[1;32m[+] SHA256(%s) = %s\012\033[0m\000"
	.align	2
.LC26:
	.ascii	"\033[1;31m[-] Downloaded file too small or invalid "
	.ascii	"(%ld bytes)\012\033[0m\000"
	.align	2
.LC27:
	.ascii	"Delete and try again?\000"
	.align	2
.LC28:
	.ascii	"\033[1;34m>>> Installing binary package with pacman"
	.ascii	" -U...\012\033[0m\000"
	.align	2
.LC29:
	.ascii	"pacman -U --noconfirm '%s' 2>&1\000"
	.align	2
.LC30:
	.ascii	"\033[1;31m[-] Binary install failed for %s (exit %d"
	.ascii	")\012\033[0m\000"
	.align	2
.LC31:
	.ascii	"Binary install failed, try again?\000"
	.align	2
.LC32:
	.ascii	"\033[1;32m[+] Binary package %s installed successfu"
	.ascii	"lly\012\033[0m\000"
	.align	2
.LC33:
	.ascii	"\033[1;33m[!] Against Gentoo principles, but fast l"
	.ascii	"ike yay\012\033[0m\000"
	.align	2
.LC34:
	.ascii	"\033[1;33m[!] %s not in official repos \342\206\222"
	.ascii	" searching AUR for a prebuilt binary (like yay)...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC35:
	.ascii	"\033[1;32m[+] %s is itself the prebuilt AUR variant"
	.ascii	" (makepkg only repackages the upstream binary) - go"
	.ascii	"ing straight there\012\033[0m\000"
	.align	2
.LC36:
	.ascii	"%s\000"
	.align	2
.LC37:
	.ascii	"%s%s\000"
	.align	2
.LC38:
	.ascii	"\033[1;32m[+] Prebuilt AUR variant found: %s (upstr"
	.ascii	"eam binary, makepkg only repackages it - no compili"
	.ascii	"ng)\012\033[0m\000"
	.align	2
.LC39:
	.ascii	"\033[1;34m>>> --binary: installing %s instead of %s"
	.ascii	" (that is the whole point of --binary)\012\033[0m\000"
	.align	2
.LC40:
	.ascii	"\033[1;33m[!] %s exists in AUR but only as a source"
	.ascii	" build; no -bin variant found (yay would compile it"
	.ascii	")\012\033[0m\000"
	.align	2
.LC41:
	.ascii	"\033[1;31m[-] %s: not in official repos and nothing"
	.ascii	" in AUR either - no binary to find\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_binary_install
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_binary_install, %function
cmd_binary_install:
	@ args = 0, pretend = 0, frame = 5792
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r4, r0
	ldr	r9, .L117
	sub	sp, sp, #5792
	sub	sp, sp, #20
.LPIC4:
	add	r9, pc
	strd	r1, r2, [sp, #20]
	bl	valid_pkgname(PLT)
	cmp	r0, #0
	beq	.L109
	ldr	r0, .L117+4
	add	r8, sp, #1712
	subw	r5, r8, #1676
	add	r6, sp, #1336
.LPIC5:
	add	r0, pc
	add	r10, sp, #48
	bl	printf(PLT)
	ldr	r0, .L117+8
	mov	r1, r4
.LPIC6:
	add	r0, pc
	bl	printf(PLT)
	movs	r3, #0
	str	r3, [r5]
	bl	priv_prefix(PLT)
	ldr	r2, .L117+12
	mov	r3, r0
	mov	r1, #700
	mov	r0, r6
.LPIC7:
	add	r2, pc
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r6
	mov	r1, r5
	bl	run_cmd_capture(PLT)
	mov	r7, r0
	ldr	r0, [r5]
	cbz	r0, .L26
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L110
.L26:
	bl	free(PLT)
	subw	r3, r8, #1676
	movs	r2, #0
	add	r6, sp, #3760
	str	r2, [r3]
	cbnz	r7, .L27
	ldr	r2, .L117+16
	mov	r3, r4
	mov	r1, #600
	mov	r0, r6
.LPIC8:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	cmp	r0, #0
	beq	.L111
.L27:
	ldr	r2, .L117+20
	mov	r3, r4
	mov	r1, #600
	mov	r0, r6
.LPIC11:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	run_cmd_quiet(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L112
	ldr	r0, .L117+24
	mov	r1, r4
.LPIC39:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	strlen(PLT)
	ldr	r2, .L117+28
	mov	r5, r0
	movs	r3, #4
.LPIC40:
	add	r2, pc
	subs	r0, r5, r3
	add	r7, r2, #16
	add	r8, r2, #4
	add	r0, r0, r4
	cmp	r3, r5
	bcs	.L54
.L113:
	ldr	r1, [r2]
	bl	strcasecmp(PLT)
	cmp	r0, #0
	beq	.L55
.L54:
	cmp	r8, r7
	beq	.L56
.L114:
	ldr	r0, [r8]
	bl	strlen(PLT)
	mov	r3, r0
	mov	r2, r8
	subs	r0, r5, r3
	add	r8, r2, #4
	add	r0, r0, r4
	cmp	r3, r5
	bcc	.L113
	cmp	r8, r7
	bne	.L114
.L56:
	ldr	r5, .L117+32
	ldr	r7, .L117+36
.LPIC49:
	add	r5, pc
.LPIC43:
	add	r7, pc
	add	r8, r5, #16
.L61:
	ldr	r3, [r5], #4
	mov	r2, r7
	str	r3, [sp]
	mov	r1, #300
	mov	r3, r4
	mov	r0, r6
	bl	xsnprintf(PLT)
	mov	r0, r6
	bl	aur_has_exact(PLT)
	cmp	r0, #0
	bne	.L115
	cmp	r5, r8
	bne	.L61
.L65:
	mov	r0, r4
	bl	aur_has_exact(PLT)
	cmp	r0, #0
	beq	.L62
	ldr	r0, .L117+40
	mov	r1, r4
.LPIC47:
	add	r0, pc
	bl	printf(PLT)
	b	.L25
.L112:
	ldr	r0, .L117+44
	mov	r2, r7
	mov	r1, r4
	sub	fp, r8, #1672
.LPIC12:
	add	r0, pc
	addw	r7, sp, #2036
	bl	printf(PLT)
	ldr	r2, .L117+48
	mov	r1, #700
	mov	r3, r4
.LPIC13:
	add	r2, pc
	mov	r0, r7
	str	r5, [fp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	sub	r1, r10, #8
	bl	run_cmd_capture(PLT)
	cmp	r0, #0
	bne	.L30
	ldr	r7, [fp]
	cmp	r7, #0
	beq	.L30
	ldrb	r2, [r7]	@ zero_extendqisi2
	cmp	r2, #0
	beq	.L30
	movs	r1, #10
	mov	r0, r7
	str	r2, [sp, #28]
	bl	strchr(PLT)
	ldr	r2, [sp, #28]
	cbz	r0, .L33
	strb	r5, [r0]
	ldr	r7, [fp]
	ldrb	r2, [r7]	@ zero_extendqisi2
.L33:
	movs	r1, #19
	movt	r1, 128
	b	.L34
.L36:
	ldrb	r2, [r7, #1]!	@ zero_extendqisi2
.L34:
	sub	r3, r2, #9
	uxtb	r3, r3
	cmp	r3, #23
	bhi	.L35
	lsr	r3, r1, r3
	lsls	r2, r3, #31
	bmi	.L36
	mov	r0, r7
	bl	strlen(PLT)
	cbz	r0, .L63
.L38:
	subs	r0, r0, #1
	movs	r1, #19
	movt	r1, 128
	adds	r2, r7, r0
	mov	ip, #0
	rsb	r0, r7, #1
.L40:
	ldrb	r3, [r2], #-1	@ zero_extendqisi2
	subs	r3, r3, #9
	uxtb	r3, r3
	cmp	r3, #23
	bhi	.L41
	lsr	r3, r1, r3
	lsls	r3, r3, #31
	bpl	.L41
	cmn	r0, r2
	strb	ip, [r2, #1]
	bne	.L40
.L41:
	ldrb	r2, [r7]	@ zero_extendqisi2
.L39:
	cbz	r2, .L43
.L63:
	ldr	r1, .L117+52
	movs	r2, #4
	mov	r0, r7
.LPIC15:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L44
.L43:
	ldr	r3, .L117+56
	mov	r2, r7
	ldr	r1, .L117+60
.LPIC16:
	add	r1, pc
	ldr	r3, [r9, r3]
.L105:
	sub	r8, r8, #1672
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r0, [r8]
	bl	free(PLT)
	mov	r0, r5
	add	sp, sp, #5792
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L109:
	ldr	r3, .L117+56
	mov	r2, r4
	ldr	r1, .L117+64
.LPIC3:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L25:
	movs	r5, #0
.L23:
	mov	r0, r5
	add	sp, sp, #5792
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L110:
	ldr	r3, .L117+68
	ldr	r3, [r9, r3]
	ldr	r1, [r3]
	bl	fputs(PLT)
	ldr	r0, [r5]
	b	.L26
.L111:
	ldr	r0, .L117+72
	mov	r1, r4
	movs	r5, #1
.LPIC9:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L117+76
.LPIC10:
	add	r0, pc
	bl	printf(PLT)
	b	.L23
.L30:
	ldr	r3, .L117+56
	mov	r2, r4
	ldr	r1, .L117+80
.LPIC14:
	add	r1, pc
	ldr	r3, [r9, r3]
	b	.L105
.L62:
	ldr	r0, .L117+84
	mov	r1, r4
.LPIC48:
	add	r0, pc
	bl	printf(PLT)
	b	.L25
.L55:
	mov	r0, r4
	bl	aur_has_exact(PLT)
	cmp	r0, #0
	beq	.L65
	ldr	r0, .L117+88
	mov	r1, r4
.LPIC41:
	add	r0, pc
	bl	printf(PLT)
	ldrd	r3, r2, [sp, #20]
	cmp	r3, #0
	it	ne
	cmpne	r2, #0
	bne	.L116
.L58:
	movs	r5, #2
	b	.L23
.L35:
	mov	r0, r7
	str	r2, [sp, #28]
	bl	strlen(PLT)
	ldr	r2, [sp, #28]
	cmp	r0, #0
	bne	.L38
	b	.L39
.L44:
	ldr	r0, .L117+92
	mov	r1, r7
	add	fp, sp, #224
	sub	r8, r8, #1672
.LPIC17:
	add	r0, pc
	bl	printf(PLT)
	bl	getpid(PLT)
	ldr	r2, .L117+96
	mov	r3, r4
	mov	r1, #512
.LPIC18:
	add	r2, pc
	str	r0, [sp]
	mov	r0, fp
	bl	xsnprintf(PLT)
	ldr	r2, .L117+100
	mov	r3, fp
	mov	r1, #2048
.LPIC19:
	add	r2, pc
	mov	r0, r6
	str	r7, [sp, #8]
	strd	r7, fp, [sp]
	bl	xsnprintf(PLT)
	ldr	r0, .L117+104
.LPIC20:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r6
	bl	run_cmd(PLT)
	mov	r6, r0
	ldr	r0, [r8]
	bl	free(PLT)
	cmp	r6, #0
	bne	.L47
	mov	r0, fp
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L47
	ldr	r0, .L117+108
	sub	r10, r10, #4
.LPIC23:
	add	r0, pc
	bl	printf(PLT)
	mov	r1, r10
	mov	r0, fp
	bl	sha256_file(PLT)
	mov	r6, r0
	cmp	r0, #0
	bne	.L48
	ldr	r3, .L117+56
	mov	r2, fp
	ldr	r1, .L117+112
	add	r5, sp, #2736
.LPIC24:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r2, .L117+116
	mov	r3, fp
	mov	r1, #600
.LPIC25:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd_quiet(PLT)
	ldr	r0, .L117+120
	mov	r1, r6
.LPIC26:
	add	r0, pc
	bl	ask_yes_no(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L23
	ldr	r0, .L117+124
.LPIC27:
	add	r0, pc
	bl	printf(PLT)
.L107:
	ldrd	r1, r2, [sp, #20]
	mov	r0, r4
	bl	cmd_binary_install(PLT)
	mov	r5, r0
	b	.L23
.L115:
	ldr	r0, .L117+128
	mov	r1, r6
.LPIC44:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L117+132
	mov	r2, r4
	mov	r1, r6
.LPIC45:
	add	r0, pc
	bl	printf(PLT)
	ldrd	r3, r2, [sp, #20]
	cmp	r3, #0
	it	ne
	cmpne	r2, #0
	beq	.L58
	ldr	r2, .L117+136
	mov	r3, r6
	ldrd	r0, r1, [sp, #20]
.LPIC46:
	add	r2, pc
	bl	xsnprintf(PLT)
	b	.L58
.L47:
	ldr	r3, .L117+56
	mov	r2, r4
	ldr	r1, .L117+140
	add	r4, sp, #2736
.LPIC21:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r2, .L117+144
	mov	r3, fp
	mov	r1, #600
.LPIC22:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd_quiet(PLT)
	b	.L23
.L48:
	ldr	r0, .L117+148
	mov	r2, r10
	mov	r1, r4
	add	r7, sp, #112
.LPIC28:
	add	r0, pc
	bl	printf(PLT)
	mov	r1, r7
	mov	r0, fp
	bl	__stat64_time64(PLT)
	mov	r6, r0
	ldrd	r2, r3, [sp, #152]
	cbnz	r0, .L50
	cmp	r2, #1024
	sbcs	r3, r3, #0
	bge	.L51
.L50:
	ldr	r3, .L117+56
	add	r5, sp, #2736
	ldr	r1, .L117+152
.LPIC29:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r2, .L117+156
	mov	r3, fp
	mov	r1, #600
.LPIC30:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd_quiet(PLT)
	ldr	r0, .L117+160
	movs	r1, #0
.LPIC31:
	add	r0, pc
	bl	ask_yes_no(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L23
	b	.L107
.L116:
	ldr	r2, .L117+164
	mov	r3, r4
	ldrd	r0, r1, [sp, #20]
.LPIC42:
	add	r2, pc
	bl	xsnprintf(PLT)
	b	.L58
.L51:
	ldr	r0, .L117+168
	add	r7, sp, #2736
	add	r8, sp, #736
.LPIC32:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L117+172
	mov	r3, fp
	mov	r1, #1024
.LPIC33:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	ldr	r2, .L117+176
	mov	r7, r0
	mov	r3, fp
.LPIC34:
	add	r2, pc
	mov	r1, #600
	mov	r0, r8
	bl	xsnprintf(PLT)
	mov	r0, r8
	bl	run_cmd_quiet(PLT)
	cbz	r7, .L53
	ldr	r2, .L117+56
	mov	r3, r7
	ldr	r1, .L117+180
.LPIC35:
	add	r1, pc
	ldr	r2, [r9, r2]
	ldr	r0, [r2]
	mov	r2, r4
	bl	fprintf(PLT)
	ldr	r0, .L117+184
	mov	r1, r6
.LPIC36:
	add	r0, pc
	bl	ask_yes_no(PLT)
	cmp	r0, #0
	beq	.L23
	b	.L107
.L53:
	ldr	r0, .L117+188
	mov	r1, r4
	movs	r5, #1
.LPIC37:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L117+192
.LPIC38:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	add_to_world(PLT)
	b	.L23
.L118:
	.align	2
.L117:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC4+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC7-(.LPIC11+4)
	.word	.LC34-(.LPIC39+4)
	.word	.LANCHOR0-(.LPIC40+4)
	.word	sfx.1-(.LPIC49+4)
	.word	.LC37-(.LPIC43+4)
	.word	.LC40-(.LPIC47+4)
	.word	.LC10-(.LPIC12+4)
	.word	.LC11-(.LPIC13+4)
	.word	.LC13-(.LPIC15+4)
	.word	stderr(GOT)
	.word	.LC14-(.LPIC16+4)
	.word	.LC3-(.LPIC3+4)
	.word	stdout(GOT)
	.word	.LC8-(.LPIC9+4)
	.word	.LC9-(.LPIC10+4)
	.word	.LC12-(.LPIC14+4)
	.word	.LC41-(.LPIC48+4)
	.word	.LC35-(.LPIC41+4)
	.word	.LC15-(.LPIC17+4)
	.word	.LC16-(.LPIC18+4)
	.word	.LC17-(.LPIC19+4)
	.word	.LC18-(.LPIC20+4)
	.word	.LC21-(.LPIC23+4)
	.word	.LC22-(.LPIC24+4)
	.word	.LC20-(.LPIC25+4)
	.word	.LC23-(.LPIC26+4)
	.word	.LC24-(.LPIC27+4)
	.word	.LC38-(.LPIC44+4)
	.word	.LC39-(.LPIC45+4)
	.word	.LC36-(.LPIC46+4)
	.word	.LC19-(.LPIC21+4)
	.word	.LC20-(.LPIC22+4)
	.word	.LC25-(.LPIC28+4)
	.word	.LC26-(.LPIC29+4)
	.word	.LC20-(.LPIC30+4)
	.word	.LC27-(.LPIC31+4)
	.word	.LC36-(.LPIC42+4)
	.word	.LC28-(.LPIC32+4)
	.word	.LC29-(.LPIC33+4)
	.word	.LC20-(.LPIC34+4)
	.word	.LC30-(.LPIC35+4)
	.word	.LC31-(.LPIC36+4)
	.word	.LC32-(.LPIC37+4)
	.word	.LC33-(.LPIC38+4)
	.section	.rodata.str1.4
	.align	2
.LC42:
	.ascii	"-bin\000"
	.align	2
.LC43:
	.ascii	"-binary\000"
	.align	2
.LC44:
	.ascii	"-prebuilt\000"
	.align	2
.LC45:
	.ascii	"-release\000"
	.set	sfx.1,sfx.0
	.section	.data.rel.ro.local,"aw"
	.align	3
	.set	.LANCHOR0,. + 0
	.type	sfx.0, %object
sfx.0:
	.word	.LC42
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.section	.note.GNU-stack,"",%progbits
