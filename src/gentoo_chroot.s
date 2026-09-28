	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	chroot_signal_handler, %function
chroot_signal_handler:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
	movs	r2, #1
.LPIC0:
	add	r3, pc
	str	r2, [r3]
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LANCHOR0-(.LPIC0+4)
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"\033[1;34m>>> Mounting chroot...\012\033[0m\000"
	.align	2
.LC1:
	.ascii	"%s\000"
	.align	2
.LC2:
	.ascii	"%smount -t proc proc '%s/proc' 2>/dev/null; mount -"
	.ascii	"-rbind /sys '%s/sys' 2>/dev/null; mount --make-rsla"
	.ascii	"ve '%s/sys' 2>/dev/null; mount --rbind /dev '%s/dev"
	.ascii	"' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/"
	.ascii	"null; mount --rbind /run '%s/run' 2>/dev/null; moun"
	.ascii	"t --make-rslave '%s/run' 2>/dev/null; mount -t tmpf"
	.ascii	"s tmpfs '%s/tmp' 2>/dev/null; mkdir -p '%s/%s' '%s/"
	.ascii	"%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' "
	.ascii	"2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null;"
	.ascii	" mkdir -p '%s/%s' && touch '%s/%s' && mount --bind "
	.ascii	"'%s' '%s/%s' 2>/dev/null; true\000"
	.align	2
.LC3:
	.ascii	"/usr/local/emerge/world\000"
	.align	2
.LC4:
	.ascii	"/usr/local/emerge/backups\000"
	.align	2
.LC5:
	.ascii	"/usr/local/emerge/builds\000"
	.align	2
.LC6:
	.ascii	"/usr/local/emerge\000"
	.align	2
.LC7:
	.ascii	"\033[1;33m[!] Some mounts failed (maybe already mou"
	.ascii	"nted or no permission), continuing\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_mount.part.0, %function
gentoo_chroot_mount.part.0:
	@ args = 0, pretend = 0, frame = 4096
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	ldr	r0, .L12
	sub	sp, sp, #4192
	ldr	r5, .L12+4
	sub	sp, sp, #20
.LPIC1:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L12+8
	ldr	r2, .L12+12
	mov	r3, r4
.LPIC3:
	add	r0, pc
	mov	r1, #512
.LPIC2:
	add	r2, pc
	adds	r0, r0, #8
	bl	xsnprintf(PLT)
.LPIC16:
	add	r5, pc
	bl	priv_prefix(PLT)
	ldr	r2, .L12+16
	mov	r3, r0
	ldr	r1, .L12+20
.LPIC5:
	add	r2, pc
	strd	r4, r2, [sp, #100]
	strd	r2, r4, [sp, #84]
.LPIC11:
	add	r1, pc
	strd	r2, r2, [sp, #92]
	ldr	r2, .L12+24
	ldr	r0, .L12+28
.LPIC9:
	add	r2, pc
	strd	r2, r4, [sp, #76]
	strd	r2, r4, [sp, #68]
.LPIC13:
	add	r0, pc
	str	r2, [sp, #44]
	ldr	r2, .L12+32
	strd	r4, r4, [sp, #12]
	strd	r4, r4, [sp, #4]
.LPIC4:
	add	r2, pc
	str	r4, [sp]
	str	r4, [sp, #60]
	str	r4, [sp, #48]
	str	r4, [sp, #40]
	strd	r4, r4, [sp, #28]
	strd	r4, r4, [sp, #20]
	add	r4, sp, #112
	str	r1, [sp, #64]
	str	r1, [sp, #56]
	str	r1, [sp, #36]
	mov	r1, #4096
	str	r0, [sp, #52]
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	cbnz	r0, .L11
	movs	r0, #1
	add	sp, sp, #4192
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L11:
	ldr	r3, .L12+36
	movs	r2, #87
	ldr	r0, .L12+40
	movs	r1, #1
.LPIC17:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	movs	r0, #1
	add	sp, sp, #4192
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L13:
	.align	2
.L12:
	.word	.LC0-(.LPIC1+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC16+4)
	.word	.LANCHOR0-(.LPIC3+4)
	.word	.LC1-(.LPIC2+4)
	.word	.LC3-(.LPIC5+4)
	.word	.LC5-(.LPIC11+4)
	.word	.LC4-(.LPIC9+4)
	.word	.LC6-(.LPIC13+4)
	.word	.LC2-(.LPIC4+4)
	.word	stderr(GOT)
	.word	.LC7-(.LPIC17+4)
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	"%s/etc/gentoo-release\000"
	.align	2
.LC9:
	.ascii	"%s/etc/os-release\000"
	.align	2
.LC10:
	.ascii	"grep -q Gentoo '%s' 2>/dev/null\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_exists
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_exists, %function
gentoo_chroot_exists:
	@ args = 0, pretend = 0, frame = 2176
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L28
	push	{r4, r5, lr}
	mov	r4, r0
	ldrb	r3, [r0]	@ zero_extendqisi2
	subw	sp, sp, #2180
	cbnz	r3, .L29
.L17:
	movs	r0, #0
.L14:
	addw	sp, sp, #2180
	@ sp needed
	pop	{r4, r5, pc}
.L29:
	ldr	r2, .L31
	mov	r3, r0
	mov	r1, #1024
	mov	r0, sp
.LPIC18:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, sp
	bl	file_exists(PLT)
	cbz	r0, .L30
	movs	r0, #1
	addw	sp, sp, #2180
	@ sp needed
	pop	{r4, r5, pc}
.L30:
	ldr	r2, .L31+4
	mov	r3, r4
	mov	r1, #1024
	mov	r0, sp
.LPIC19:
	add	r2, pc
	bl	xsnprintf(PLT)
	mov	r0, sp
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L17
	ldr	r2, .L31+8
	add	r4, sp, #1024
	mov	r3, sp
	movw	r1, #1150
.LPIC20:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd_quiet(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L14
.L28:
	movs	r0, #0
	bx	lr
.L32:
	.align	2
.L31:
	.word	.LC8-(.LPIC18+4)
	.word	.LC9-(.LPIC19+4)
	.word	.LC10-(.LPIC20+4)
	.section	.rodata.str1.4
	.align	2
.LC11:
	.ascii	"(null)\000"
	.align	2
.LC12:
	.ascii	"root\000"
	.align	2
.LC13:
	.ascii	"\033[1;31m[-] Invalid chroot path: %s\012\033[0m\000"
	.align	2
.LC14:
	.ascii	"\033[1;32m[+] Gentoo chroot already exists at %s (p"
	.ascii	"ersistent mode)\012\033[0m\000"
	.align	2
.LC15:
	.ascii	"\033[1;36m>>> Initializing chroot at %s...\012\033["
	.ascii	"0m\000"
	.align	2
.LC16:
	.ascii	"%smkdir -p '%s'\000"
	.align	2
.LC17:
	.ascii	"\033[1;31m[-] Cannot create chroot dir %s\012\033[0"
	.ascii	"m\000"
	.align	2
.LC18:
	.ascii	"\033[1;34m>>> Fetching latest Gentoo stage3 URL...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC19:
	.ascii	"curl -fsSL https://distfiles.gentoo.org/releases/am"
	.ascii	"d64/autobuilds/latest-stage3-amd64-openrc.txt 2>/de"
	.ascii	"v/null | grep -E 'stage3-amd64-openrc.*\\.tar\\.xz'"
	.ascii	" | grep -v '^#' | grep -v 'BEGIN' | head -n1 | awk "
	.ascii	"'{print $1}'\000"
	.align	2
.LC20:
	.ascii	"BEGIN\000"
	.align	2
.LC21:
	.ascii	".tar\000"
	.align	2
.LC22:
	.ascii	"https://\000"
	.align	2
.LC23:
	.ascii	"https://distfiles.gentoo.org/releases/amd64/autobui"
	.ascii	"lds/%s\000"
	.align	2
.LC24:
	.ascii	"\033[1;32m[+] Latest stage3: %s\012\033[0m\000"
	.align	2
.LC25:
	.ascii	"\033[1;33m[!] Could not fetch latest list, using fa"
	.ascii	"llback\012\033[0m\000"
	.align	2
.LC26:
	.ascii	"https://distfiles.gentoo.org/releases/amd64/autobui"
	.ascii	"lds/current-stage3-amd64-openrc/stage3-amd64-openrc"
	.ascii	"-latest.tar.xz\000"
	.align	2
.LC27:
	.ascii	"curl -fsI '%s' >/dev/null 2>&1 && echo ok || echo f"
	.ascii	"ail\000"
	.align	2
.LC28:
	.ascii	"ok\000"
	.align	2
.LC29:
	.ascii	"\033[1;33m[!] Fallback not reachable, trying alt\012"
	.ascii	"\033[0m\000"
	.align	2
.LC30:
	.ascii	"curl -fsSL https://distfiles.gentoo.org/releases/am"
	.ascii	"d64/autobuilds/current-stage3-amd64-openrc/ 2>/dev/"
	.ascii	"null | grep -oE 'stage3-amd64-openrc-[0-9TZ]+\\.tar"
	.ascii	"\\.xz' | head -n1\000"
	.align	2
.LC31:
	.ascii	".tar.xz\000"
	.align	2
.LC32:
	.ascii	"https://distfiles.gentoo.org/releases/amd64/autobui"
	.ascii	"lds/current-stage3-amd64-openrc/%s\000"
	.align	2
.LC33:
	.ascii	"\033[1;32m[+] Alternative stage3: %s\012\033[0m\000"
	.align	2
.LC34:
	.ascii	"/tmp/gentoo-stage3-%ld.tar.xz\000"
	.align	2
.LC35:
	.ascii	"\033[1;34m>>> Downloading stage3 (this may take a w"
	.ascii	"hile)...\012\033[0m\000"
	.align	2
.LC36:
	.ascii	"curl -fL -o '%s' '%s' || wget -O '%s' '%s'\000"
	.align	2
.LC37:
	.ascii	"\033[1;31m[-] Failed to download stage3 from %s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC38:
	.ascii	"\033[1;33m    Try manually: curl -o %s %s\012\033[0"
	.ascii	"m\000"
	.align	2
.LC39:
	.ascii	"\033[1;34m>>> Extracting stage3 to %s...\012\033[0m"
	.ascii	"\000"
	.align	2
.LC40:
	.ascii	"%star -xpf '%s' -C '%s' --xattrs-include='*.*' --nu"
	.ascii	"meric-owner 2>&1 | head -n 20\000"
	.align	2
.LC41:
	.ascii	"rm -f '%s'\000"
	.align	2
.LC42:
	.ascii	"\033[1;31m[-] Failed to extract stage3\012\033[0m\000"
	.align	2
.LC43:
	.ascii	"\033[1;34m>>> Setting up chroot basics...\012\033[0"
	.ascii	"m\000"
	.align	2
.LC44:
	.ascii	"%smkdir -p '%s/proc' '%s/sys' '%s/dev' '%s/tmp' '%s"
	.ascii	"/run' '%s/%s' '%s/%s' '%s/var/db/repos/gentoo' && %"
	.ascii	"scp -L /etc/resolv.conf '%s/etc/resolv.conf' 2>/dev"
	.ascii	"/null; %schown -R '%s' '%s' 2>/dev/null; true\000"
	.align	2
.LC45:
	.ascii	"\033[1;34m>>> Fixing Portage profile and repos...\012"
	.ascii	"\033[0m\000"
	.align	2
.LC46:
	.ascii	"%schroot '%s' /bin/bash -c 'eselect profile list 2>"
	.ascii	"/dev/null | head -n5; if [ ! -e /etc/portage/make.p"
	.ascii	"rofile ] || [ ! -L /etc/portage/make.profile ]; the"
	.ascii	"n   echo \">>> Fixing make.profile symlink...\";   "
	.ascii	"rm -rf /etc/portage/make.profile;   if [ -d /var/db"
	.ascii	"/repos/gentoo/profiles/default/linux/amd64/23.0 ]; "
	.ascii	"then     ln -sf /var/db/repos/gentoo/profiles/defau"
	.ascii	"lt/linux/amd64/23.0 /etc/portage/make.profile;   el"
	.ascii	"if [ -d /var/db/repos/gentoo/profiles/default/linux"
	.ascii	"/amd64/23.0/no-multilib ]; then     ln -sf /var/db/"
	.ascii	"repos/gentoo/profiles/default/linux/amd64/23.0/no-m"
	.ascii	"ultilib /etc/portage/make.profile;   else     prof="
	.ascii	"$(ls -d /var/db/repos/gentoo/profiles/default/linux"
	.ascii	"/amd64/* 2>/dev/null | head -n1);     if [ -n \"$pr"
	.ascii	"of\" ]; then ln -sf $prof /etc/portage/make.profile"
	.ascii	"; fi;   fi; fi; ls -l /etc/portage/make.profile 2>/"
	.ascii	"dev/null; true' 2>&1 | head -n 20\000"
	.align	2
.LC47:
	.ascii	"\033[1;34m>>> Syncing Gentoo repos inside chroot (e"
	.ascii	"merge-webrsync fallback)...\012\033[0m\000"
	.align	2
.LC48:
	.ascii	"%smount -t proc proc '%s/proc' 2>/dev/null; mount -"
	.ascii	"-rbind /sys '%s/sys' 2>/dev/null; mount --make-rsla"
	.ascii	"ve '%s/sys' 2>/dev/null; mount --rbind /dev '%s/dev"
	.ascii	"' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/"
	.ascii	"null; chroot '%s' /bin/bash -c 'source /etc/profile"
	.ascii	"; mkdir -p /var/db/repos/gentoo; if [ ! -d /var/db/"
	.ascii	"repos/gentoo/profiles ]; then   echo \">>> Running "
	.ascii	"emerge-webrsync (first sync)...\";   emerge-webrsyn"
	.ascii	"c 2>&1 | tail -n 30; else   echo \">>> Repo exists,"
	.ascii	" running emerge --sync...\";   emerge --sync 2>&1 |"
	.ascii	" tail -n 30; fi; eselect profile list 2>/dev/null |"
	.ascii	" head -n 20; if [ ! -L /etc/portage/make.profile ];"
	.ascii	" then   eselect profile set 1 2>/dev/null || eselec"
	.ascii	"t profile set default/linux/amd64/23.0 2>/dev/null "
	.ascii	"|| true; fi; '; umount -l '%s/proc' 2>/dev/null; um"
	.ascii	"ount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>"
	.ascii	"/dev/null; true\000"
	.align	2
.LC49:
	.ascii	"\033[1;33m[!] Chroot init finished but gentoo-relea"
	.ascii	"se not found, may still work\012\033[0m\000"
	.align	2
.LC50:
	.ascii	"\033[1;32m[+] Gentoo chroot initialized at %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC51:
	.ascii	"\033[1;33m[!] If repo still fails, run manually: su"
	.ascii	"do chroot %s emerge --sync\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_init
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_init, %function
gentoo_chroot_init:
	@ args = 0, pretend = 0, frame = 6344
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r5, .L108
	sub	sp, sp, #6400
	sub	sp, sp, #12
.LPIC23:
	add	r5, pc
	cmp	r0, #0
	beq	.L101
	mov	r4, r0
	bl	valid_gentoo_chroot_path(PLT)
	cbnz	r0, .L36
	ldr	r3, .L108+4
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
.L35:
	ldr	r1, .L108+8
	mov	r2, r4
.LPIC24:
	add	r1, pc
	bl	fprintf(PLT)
.L37:
	movs	r0, #0
	add	sp, sp, #6400
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L36:
	mov	r0, r4
	bl	gentoo_chroot_exists(PLT)
	cmp	r0, #0
	bne	.L102
	ldr	r0, .L108+12
	mov	r1, r4
	addw	r7, sp, #2312
.LPIC26:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L108+16
	mov	r3, r0
	mov	r1, #4096
.LPIC27:
	add	r2, pc
	mov	r0, r7
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	mov	r6, r0
	cmp	r0, #0
	bne	.L103
	ldr	r0, .L108+20
	subw	fp, r7, #2236
	add	r8, sp, #104
.LPIC29:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L108+24
	sub	r1, r8, #28
	str	r6, [fp]
.LPIC30:
	add	r0, pc
	bl	run_cmd_capture(PLT)
	mov	r2, #1024
	mov	r10, r0
	mov	r1, r6
	sub	r0, r7, #2224
	bl	memset(PLT)
	ldr	r9, [fp]
	cmp	r10, #0
	bne	.L99
	cmp	r9, #0
	beq	.L43
	ldrb	r6, [r9]	@ zero_extendqisi2
	movs	r3, #19
	movt	r3, 128
	cmp	r6, #0
	beq	.L99
.L44:
	subs	r6, r6, #9
	uxtb	r6, r6
	cmp	r6, #23
	bhi	.L45
	lsr	r6, r3, r6
	lsls	r2, r6, #31
	bpl	.L45
	ldrb	r6, [r9, #1]!	@ zero_extendqisi2
	cmp	r6, #0
	bne	.L44
.L45:
	mov	r0, r9
	bl	strlen(PLT)
	cbz	r0, .L49
	subs	r2, r0, #1
	movs	r1, #19
	movt	r1, 128
	add	r2, r2, r9
	movs	r6, #0
	rsb	r0, r9, #1
.L48:
	ldrb	r3, [r2], #-1	@ zero_extendqisi2
	subs	r3, r3, #9
	uxtb	r3, r3
	cmp	r3, #23
	bhi	.L49
	lsr	r3, r1, r3
	lsls	r3, r3, #31
	bpl	.L49
	cmn	r0, r2
	strb	r6, [r2, #1]
	bne	.L48
.L49:
	ldr	r1, .L108+28
	mov	r0, r9
.LPIC31:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	beq	.L51
.L52:
	subw	r6, r7, #2236
	ldr	r0, [r6]
	bl	free(PLT)
	movs	r3, #0
	str	r3, [r6]
	b	.L43
.L101:
	ldr	r3, .L108+4
	ldr	r4, .L108+32
.LPIC21:
	add	r4, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	b	.L35
.L103:
	ldr	r3, .L108+4
	mov	r2, r4
	ldr	r1, .L108+36
.LPIC28:
	add	r1, pc
	ldr	r3, [r5, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L37
.L99:
	mov	r0, r9
	bl	free(PLT)
	str	r6, [fp]
.L43:
	ldr	r0, .L108+40
	sub	r10, r8, #16
	add	r6, sp, #1112
	subw	r9, r7, #2232
.LPIC37:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L108+44
	mov	r1, #1024
	mov	r0, r10
.LPIC38:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r2, .L108+48
	mov	r3, r10
	mov	r1, #1200
.LPIC39:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	sub	r1, r8, #24
	mov	r0, r6
	movs	r3, #0
	str	r3, [r9]
	bl	run_cmd_capture(PLT)
	ldr	r9, [r9]
	cmp	r0, #0
	beq	.L104
.L56:
	mov	r0, r9
	bl	free(PLT)
	ldr	r0, .L108+52
.LPIC41:
	add	r0, pc
	bl	printf(PLT)
	sub	r1, r8, #20
	ldr	r0, .L108+56
	subw	r8, r7, #2228
	movs	r3, #0
.LPIC42:
	add	r0, pc
	str	r3, [r8]
	bl	run_cmd_capture(PLT)
	ldr	r3, [r8]
	mov	r8, r0
	cbnz	r0, .L59
	cbz	r3, .L59
	ldrb	r2, [r3]	@ zero_extendqisi2
	cbz	r2, .L59
	mov	r0, r3
	movs	r1, #10
	bl	strchr(PLT)
	cbz	r0, .L61
	strb	r8, [r0]
.L61:
	subw	r8, r7, #2228
	ldr	r1, .L108+60
.LPIC43:
	add	r1, pc
	ldr	r3, [r8]
	str	r3, [sp, #68]
	mov	r0, r3
	bl	strstr(PLT)
	ldr	r3, [sp, #68]
	cbz	r0, .L59
	ldr	r2, .L108+64
	mov	r1, #1024
	mov	r0, r10
.LPIC44:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r0, .L108+68
	mov	r1, r10
.LPIC45:
	add	r0, pc
	bl	printf(PLT)
	ldr	r3, [r8]
.L59:
	mov	r0, r3
	bl	free(PLT)
.L55:
	bl	getpid(PLT)
	ldr	r2, .L108+72
	mov	r3, r0
	mov	r1, #512
.LPIC46:
	add	r2, pc
	mov	r0, r6
	bl	xsnprintf(PLT)
	ldr	r0, .L108+76
.LPIC47:
	add	r0, pc
	bl	printf(PLT)
	ldr	r2, .L108+80
	mov	r3, r6
	mov	r1, #4096
.LPIC48:
	add	r2, pc
	mov	r0, r7
	strd	r6, r10, [sp, #4]
	str	r10, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	cmp	r0, #0
	bne	.L105
	ldr	r0, .L108+84
	mov	r1, r4
.LPIC51:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L108+88
	mov	r3, r0
	mov	r1, #4096
.LPIC52:
	add	r2, pc
	strd	r6, r4, [sp]
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	ldr	r2, .L108+92
	mov	r3, r6
	mov	r1, #4096
	mov	r6, r0
.LPIC53:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd_quiet(PLT)
	cmp	r6, #0
	bne	.L106
	ldr	r0, .L108+96
.LPIC55:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	mov	r8, r0
	bl	priv_prefix(PLT)
	mov	r6, r0
	bl	priv_prefix(PLT)
	mov	r9, r0
	bl	build_user(PLT)
	cmp	r0, #0
	beq	.L66
	bl	build_user(PLT)
.L64:
	ldr	r2, .L108+100
	mov	r3, r8
	mov	r1, #4096
	strd	r9, r0, [sp, #48]
.LPIC57:
	add	r2, pc
	strd	r2, r4, [sp, #32]
	ldr	r2, .L108+104
	mov	r0, r7
	str	r4, [sp, #56]
.LPIC58:
	add	r2, pc
	strd	r2, r4, [sp, #24]
	ldr	r2, .L108+108
	strd	r6, r4, [sp, #40]
.LPIC56:
	add	r2, pc
	strd	r4, r4, [sp, #16]
	strd	r4, r4, [sp, #8]
	strd	r4, r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	ldr	r0, .L108+112
.LPIC59:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L108+116
	mov	r3, r0
	mov	r1, #4096
.LPIC60:
	add	r2, pc
	mov	r0, r7
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	ldr	r0, .L108+120
.LPIC61:
	add	r0, pc
	bl	printf(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L108+124
	mov	r3, r0
	mov	r1, #4096
.LPIC62:
	add	r2, pc
	mov	r0, r7
	strd	r4, r4, [sp, #28]
	strd	r4, r4, [sp, #20]
	strd	r4, r4, [sp, #12]
	strd	r4, r4, [sp, #4]
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r7
	bl	run_cmd(PLT)
	mov	r0, r4
	bl	gentoo_chroot_exists(PLT)
	cmp	r0, #0
	beq	.L107
.L65:
	ldr	r0, .L108+128
	mov	r1, r4
.LPIC64:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L108+132
	mov	r1, r4
.LPIC65:
	add	r0, pc
	bl	printf(PLT)
	b	.L39
.L102:
	ldr	r0, .L108+136
	mov	r1, r4
.LPIC25:
	add	r0, pc
	bl	printf(PLT)
.L39:
	movs	r0, #1
	add	sp, sp, #6400
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L104:
	cmp	r9, #0
	beq	.L56
	ldr	r1, .L108+140
	mov	r0, r9
.LPIC40:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	beq	.L56
	mov	r0, r9
	bl	free(PLT)
	b	.L55
.L105:
	ldr	r3, .L108+4
	mov	r2, r10
	ldr	r1, .L108+144
.LPIC49:
	add	r1, pc
	ldr	r4, [r5, r3]
	ldr	r0, [r4]
	bl	fprintf(PLT)
	ldr	r1, .L108+148
	ldr	r0, [r4]
	mov	r3, r10
	mov	r2, r6
.LPIC50:
	add	r1, pc
	bl	fprintf(PLT)
	b	.L37
.L106:
	ldr	r3, .L108+4
	movs	r2, #40
	ldr	r0, .L108+152
	movs	r1, #1
.LPIC54:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L37
.L66:
	ldr	r0, .L108+156
.LPIC22:
	add	r0, pc
	b	.L64
.L107:
	ldr	r3, .L108+4
	movs	r2, #81
	ldr	r0, .L108+160
	movs	r1, #1
.LPIC63:
	add	r0, pc
	ldr	r3, [r5, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L65
.L51:
	ldr	r1, .L108+164
	mov	r0, r9
.LPIC32:
	add	r1, pc
	bl	strstr(PLT)
	cmp	r0, #0
	beq	.L52
	mov	r0, r9
	bl	strlen(PLT)
	cmp	r0, #10
	bls	.L52
	ldr	r1, .L108+168
	movs	r2, #8
	mov	r0, r9
	sub	r10, r8, #16
.LPIC33:
	add	r1, pc
	bl	strncmp(PLT)
	mov	r3, r9
	cbnz	r0, .L53
	ldr	r2, .L108+172
	mov	r1, #1024
	mov	r0, r10
.LPIC34:
	add	r2, pc
	bl	xsnprintf(PLT)
.L54:
	subw	r6, r7, #2236
	ldr	r0, .L108+176
	mov	r1, r10
.LPIC36:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, [r6]
	bl	free(PLT)
	movs	r3, #0
	str	r3, [r6]
	add	r6, sp, #1112
	b	.L55
.L53:
	ldr	r2, .L108+180
	mov	r1, #1024
	mov	r0, r10
.LPIC35:
	add	r2, pc
	bl	xsnprintf(PLT)
	b	.L54
.L109:
	.align	2
.L108:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC23+4)
	.word	stderr(GOT)
	.word	.LC13-(.LPIC24+4)
	.word	.LC15-(.LPIC26+4)
	.word	.LC16-(.LPIC27+4)
	.word	.LC18-(.LPIC29+4)
	.word	.LC19-(.LPIC30+4)
	.word	.LC20-(.LPIC31+4)
	.word	.LC11-(.LPIC21+4)
	.word	.LC17-(.LPIC28+4)
	.word	.LC25-(.LPIC37+4)
	.word	.LC26-(.LPIC38+4)
	.word	.LC27-(.LPIC39+4)
	.word	.LC29-(.LPIC41+4)
	.word	.LC30-(.LPIC42+4)
	.word	.LC31-(.LPIC43+4)
	.word	.LC32-(.LPIC44+4)
	.word	.LC33-(.LPIC45+4)
	.word	.LC34-(.LPIC46+4)
	.word	.LC35-(.LPIC47+4)
	.word	.LC36-(.LPIC48+4)
	.word	.LC39-(.LPIC51+4)
	.word	.LC40-(.LPIC52+4)
	.word	.LC41-(.LPIC53+4)
	.word	.LC43-(.LPIC55+4)
	.word	.LC4-(.LPIC57+4)
	.word	.LC5-(.LPIC58+4)
	.word	.LC44-(.LPIC56+4)
	.word	.LC45-(.LPIC59+4)
	.word	.LC46-(.LPIC60+4)
	.word	.LC47-(.LPIC61+4)
	.word	.LC48-(.LPIC62+4)
	.word	.LC50-(.LPIC64+4)
	.word	.LC51-(.LPIC65+4)
	.word	.LC14-(.LPIC25+4)
	.word	.LC28-(.LPIC40+4)
	.word	.LC37-(.LPIC49+4)
	.word	.LC38-(.LPIC50+4)
	.word	.LC42-(.LPIC54+4)
	.word	.LC12-(.LPIC22+4)
	.word	.LC49-(.LPIC63+4)
	.word	.LC21-(.LPIC32+4)
	.word	.LC22-(.LPIC33+4)
	.word	.LC1-(.LPIC34+4)
	.word	.LC24-(.LPIC36+4)
	.word	.LC23-(.LPIC35+4)
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_mount
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_mount, %function
gentoo_chroot_mount:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
	cbz	r0, .L110
	bl	gentoo_chroot_mount.part.0(PLT)
	movs	r0, #1
.L110:
	pop	{r3, pc}
	.section	.rodata.str1.4
	.align	2
.LC52:
	.ascii	"\033[1;34m>>> Unmounting...\012\033[0m\000"
	.align	2
.LC53:
	.ascii	"%sumount -l '%s/%s' 2>/dev/null; umount -l '%s/%s' "
	.ascii	"2>/dev/null; umount -l '%s/%s' 2>/dev/null; umount "
	.ascii	"-l '%s/tmp' 2>/dev/null; umount -l '%s/run' 2>/dev/"
	.ascii	"null; umount -l '%s/dev' 2>/dev/null; umount -l '%s"
	.ascii	"/sys' 2>/dev/null; umount -l '%s/proc' 2>/dev/null;"
	.ascii	" true\000"
	.align	2
.LC54:
	.ascii	"%sgrep '%s' /proc/mounts | cut -d' ' -f2 | sort -r "
	.ascii	"| xargs -r umount -l 2>/dev/null; true\000"
	.align	2
.LC55:
	.ascii	"\033[1;32m[+] Unmounted\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_unmount
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_unmount, %function
gentoo_chroot_unmount:
	@ args = 0, pretend = 0, frame = 4096
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	sub	sp, sp, #4128
	sub	sp, sp, #20
	cmp	r0, #0
	beq	.L114
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L116
	ldr	r3, .L120
.LPIC67:
	add	r3, pc
	ldrb	r0, [r3, #8]	@ zero_extendqisi2
	cmp	r0, #0
	beq	.L114
	add	r4, r3, #8
.L116:
	ldr	r0, .L120+4
	ldr	r5, .L120+8
.LPIC68:
	add	r0, pc
	bl	printf(PLT)
.LPIC70:
	add	r5, pc
	bl	priv_prefix(PLT)
	ldr	r2, .L120+12
	ldr	r1, .L120+16
	mov	r3, r0
.LPIC71:
	add	r2, pc
	strd	r2, r4, [sp, #12]
	ldr	r2, .L120+20
.LPIC72:
	add	r1, pc
	str	r5, [sp, #20]
	add	r5, sp, #48
.LPIC69:
	add	r2, pc
	strd	r1, r4, [sp, #4]
	mov	r0, r5
	mov	r1, #4096
	strd	r4, r4, [sp, #36]
	strd	r4, r4, [sp, #28]
	str	r4, [sp, #24]
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L120+24
	mov	r3, r0
	mov	r1, #4096
.LPIC73:
	add	r2, pc
	mov	r0, r5
	str	r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	ldr	r0, .L120+28
.LPIC74:
	add	r0, pc
	bl	printf(PLT)
	movs	r0, #1
.L114:
	add	sp, sp, #4128
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L121:
	.align	2
.L120:
	.word	.LANCHOR0-(.LPIC67+4)
	.word	.LC52-(.LPIC68+4)
	.word	.LC5-(.LPIC70+4)
	.word	.LC4-(.LPIC71+4)
	.word	.LC3-(.LPIC72+4)
	.word	.LC53-(.LPIC69+4)
	.word	.LC54-(.LPIC73+4)
	.word	.LC55-(.LPIC74+4)
	.section	.rodata.str1.4
	.align	2
.LC56:
	.ascii	"\033[1;32m>>> Emerging (1 of 1) %s::gentoo\012\033["
	.ascii	"0m\000"
	.align	2
.LC57:
	.ascii	"\033[1;34m>>> Jobs: %d  Chroot: %s\012\033[0m\000"
	.align	2
.LC58:
	.ascii	"%sif [ ! -d '%s/var/db/repos/gentoo/profiles' ]; th"
	.ascii	"en   echo '>>> Repo missing, syncing...';   mount -"
	.ascii	"t proc proc '%s/proc' 2>/dev/null;   mount --rbind "
	.ascii	"/sys '%s/sys' 2>/dev/null; mount --make-rslave '%s/"
	.ascii	"sys' 2>/dev/null;   mount --rbind /dev '%s/dev' 2>/"
	.ascii	"dev/null; mount --make-rslave '%s/dev' 2>/dev/null;"
	.ascii	"   chroot '%s' /bin/bash -c 'source /etc/profile; e"
	.ascii	"merge-webrsync 2>&1 | tail -n 20';   umount -l '%s/"
	.ascii	"proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; "
	.ascii	"umount -l '%s/dev' 2>/dev/null; fi; true\000"
	.align	2
.LC59:
	.ascii	"chroot '%s' /bin/bash -c \"source /etc/profile; if "
	.ascii	"[ ! -L /etc/portage/make.profile ]; then eselect pr"
	.ascii	"ofile set 1 2>/dev/null || true; fi; emerge --ask n"
	.ascii	" --jobs=%d --load-average=%d '%s' 2>&1\"\000"
	.align	2
.LC60:
	.ascii	"\033[1;31m\012[!] Interrupted (Ctrl+C) - cleaning u"
	.ascii	"p chroot mounts...\012\033[0m\000"
	.align	2
.LC61:
	.ascii	"\033[1;31m[-] Portage inside chroot failed (exit %d"
	.ascii	")\012\033[0m\000"
	.align	2
.LC62:
	.ascii	"\033[1;32m[+] Portage inside chroot finished succes"
	.ascii	"sfully\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_run_portage.part.0, %function
gentoo_chroot_run_portage.part.0:
	@ args = 0, pretend = 0, frame = 8192
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r4, r0
	ldr	r0, .L129
	sub	sp, sp, #8192
	mov	r6, r2
	sub	sp, sp, #44
.LPIC75:
	add	r0, pc
	mov	r9, r1
	bl	printf(PLT)
	ldr	r0, .L129+4
	mov	r2, r4
	mov	r1, r6
	add	r5, sp, #4128
.LPIC76:
	add	r0, pc
	adds	r5, r5, #8
	bl	printf(PLT)
	add	r3, sp, #4128
	adds	r3, r3, #12
	movs	r2, #136
	movs	r1, #0
	mov	r0, r3
	bl	memset(PLT)
	ldr	r3, .L129+8
	ldr	r7, .L129+12
.LPIC77:
	add	r3, pc
	str	r3, [r5]
	bl	sigemptyset(PLT)
.LPIC78:
	add	r7, pc
	mov	r1, r5
	movs	r2, #0
	movs	r0, #2
	ldr	r8, .L129+16
	bl	sigaction(PLT)
	mov	r1, r5
	movs	r2, #0
	movs	r0, #15
	bl	sigaction(PLT)
	mov	r1, r5
	movs	r2, #0
	movs	r0, #1
	bl	sigaction(PLT)
	movs	r3, #0
	str	r3, [r7]
	bl	priv_prefix(PLT)
	ldr	r2, .L129+20
	mov	r3, r0
	mov	r1, #4096
	mov	r0, r5
.LPIC79:
	add	r2, pc
	strd	r4, r4, [sp, #32]
	strd	r4, r4, [sp, #24]
.LPIC84:
	add	r8, pc
	strd	r4, r4, [sp, #16]
	strd	r4, r4, [sp, #8]
	strd	r4, r4, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	ldr	r2, .L129+24
	add	r5, sp, #40
	mov	r3, r4
.LPIC80:
	add	r2, pc
	mov	r1, #4096
	mov	r0, r5
	str	r9, [sp, #8]
	strd	r6, r6, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	ldr	r3, [r7]
	cbnz	r3, .L127
	mov	r5, r0
	cbnz	r0, .L128
	ldr	r0, .L129+28
.LPIC85:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r5
	add	sp, sp, #8192
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L128:
	ldr	r3, .L129+32
	mov	r2, r0
	ldr	r1, .L129+36
.LPIC83:
	add	r1, pc
	ldr	r3, [r8, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	mov	r0, r5
	add	sp, sp, #8192
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L127:
	ldr	r0, .L129+40
	movs	r5, #130
.LPIC82:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	gentoo_chroot_unmount(PLT)
	mov	r0, r5
	add	sp, sp, #8192
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L130:
	.align	2
.L129:
	.word	.LC56-(.LPIC75+4)
	.word	.LC57-(.LPIC76+4)
	.word	chroot_signal_handler-(.LPIC77+4)
	.word	.LANCHOR0-(.LPIC78+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC84+4)
	.word	.LC58-(.LPIC79+4)
	.word	.LC59-(.LPIC80+4)
	.word	.LC62-(.LPIC85+4)
	.word	stderr(GOT)
	.word	.LC61-(.LPIC83+4)
	.word	.LC60-(.LPIC82+4)
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_run_portage
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_run_portage, %function
gentoo_chroot_run_portage:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r1, #0
	it	ne
	cmpne	r0, #0
	bne	.L133
	movs	r0, #1
	bx	lr
.L133:
	b	gentoo_chroot_run_portage.part.0(PLT)
	.section	.rodata.str1.4
	.align	2
.LC63:
	.ascii	"%s/chroot-world/%s\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_manifest_exists
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_manifest_exists, %function
gentoo_chroot_manifest_exists:
	@ args = 0, pretend = 0, frame = 640
	@ frame_needed = 0, uses_anonymous_args = 0
	cbz	r0, .L144
	push	{r4, lr}
	mov	r4, r0
	sub	sp, sp, #648
	bl	valid_pkgname(PLT)
	cbnz	r0, .L145
	movs	r0, #0
	add	sp, sp, #648
	@ sp needed
	pop	{r4, pc}
.L145:
	ldr	r3, .L146
	mov	r1, #640
	ldr	r2, .L146+4
	str	r4, [sp]
	add	r4, sp, #8
.LPIC86:
	add	r3, pc
.LPIC87:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	file_exists(PLT)
	add	sp, sp, #648
	@ sp needed
	pop	{r4, pc}
.L144:
	movs	r0, #0
	bx	lr
.L147:
	.align	2
.L146:
	.word	.LC6-(.LPIC86+4)
	.word	.LC63-(.LPIC87+4)
	.section	.rodata.str1.4
	.align	2
.LC64:
	.ascii	"ls -1d '%s'/var/db/pkg/*/'%s'-[0-9]* 2>/dev/null | "
	.ascii	"sort -V | tail -n1\000"
	.align	2
.LC65:
	.ascii	"\033[1;33m[!] No merged package found in the chroot"
	.ascii	" database for '%s'; nothing was installed on the ho"
	.ascii	"st.\012\033[0m\000"
	.align	2
.LC66:
	.ascii	"%s/CONTENTS\000"
	.align	2
.LC67:
	.ascii	"r\000"
	.align	2
.LC68:
	.ascii	"\033[1;31m[-] Chroot package %s has no CONTENTS man"
	.ascii	"ifest\012\033[0m\000"
	.align	2
.LC69:
	.ascii	"%s/chroot-world\000"
	.align	2
.LC70:
	.ascii	"%s.tmp.%ld\000"
	.align	2
.LC71:
	.ascii	"%s/.chroot-merge-%ld.sh\000"
	.align	2
.LC72:
	.ascii	"w\000"
	.align	2
.LC73:
	.ascii	"\033[1;31m[-] Cannot write chroot merge script\012\033"
	.ascii	"[0m\000"
	.align	2
.LC74:
	.ascii	"obj \000"
	.align	2
.LC75:
	.ascii	"%1023s\000"
	.align	2
.LC76:
	.ascii	"dir \000"
	.align	2
.LC77:
	.ascii	"sym \000"
	.align	2
.LC78:
	.ascii	"->\000"
	.align	2
.LC79:
	.ascii	"/usr/\000"
	.align	2
.LC80:
	.ascii	"/usr/local%s\000"
	.align	2
.LC81:
	.ascii	"%s%s\000"
	.align	2
.LC82:
	.ascii	"%.*s\000"
	.align	2
.LC83:
	.ascii	"/\000"
	.align	2
.LC84:
	.ascii	"install -d %s && cp -a %s %s\012\000"
	.align	2
.LC85:
	.ascii	"obj %s\012\000"
	.align	2
.LC86:
	.ascii	"install -d %s && ln -sfn %s %s\012\000"
	.align	2
.LC87:
	.ascii	"sym %s\012\000"
	.align	2
.LC88:
	.ascii	"install -d %s\012\000"
	.align	2
.LC89:
	.ascii	"dir %s\012\000"
	.align	2
.LC90:
	.ascii	"%ssh %s\000"
	.align	2
.LC91:
	.ascii	"\033[1;31m[-] Imitation merge failed (exit %d); man"
	.ascii	"ifest discarded\012\033[0m\000"
	.align	2
.LC92:
	.ascii	"\033[1;33m[!] Could not register manifest %s\012\033"
	.ascii	"[0m\000"
	.align	2
.LC93:
	.ascii	"\033[1;32m[+] Imitation merge: %d file(s), %d link("
	.ascii	"s), %d dir(s) installed under /usr/local (%d chroot"
	.ascii	"-only entries skipped)\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_install_artifacts
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_install_artifacts, %function
gentoo_chroot_install_artifacts:
	@ args = 0, pretend = 0, frame = 22000
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r3, r0
	ldr	r2, .L266
	sub	sp, sp, #21888
	ldr	r9, .L266+4
	sub	sp, sp, #124
.LPIC88:
	add	r2, pc
	add	r6, sp, #1528
	addw	r5, sp, #3932
	sub	r7, r6, #1448
	mov	r4, r1
	str	r0, [sp, #44]
	mov	r0, r5
	str	r1, [sp]
	mov	r1, #1024
	bl	xsnprintf(PLT)
	mov	r0, r5
	mov	r1, r7
	add	r3, sp, #120
.LPIC90:
	add	r9, pc
	str	r3, [sp, #36]
	movs	r3, #0
	str	r3, [r7]
	bl	run_cmd_capture(PLT)
	ldr	r5, [r7]
	str	r0, [sp, #24]
	cmp	r0, #0
	bne	.L149
	cmp	r5, #0
	beq	.L149
	ldrb	r3, [r5]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L149
	mov	r0, r5
	bl	strlen(PLT)
	cbz	r0, .L153
	ldr	r2, [sp, #24]
	b	.L152
.L154:
	strb	r2, [r5, r0]
	ldr	r5, [r7]
	cbz	r0, .L153
.L152:
	subs	r0, r0, #1
	ldrb	r3, [r5, r0]	@ zero_extendqisi2
	cmp	r3, #13
	it	ne
	cmpne	r3, #10
	beq	.L154
.L153:
	mov	r3, r5
	ldr	r2, .L266+8
	add	r5, sp, #10560
	mov	r1, #1400
	adds	r5, r5, #48
.LPIC91:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	ldr	r1, .L266+12
	mov	r0, r5
.LPIC92:
	add	r1, pc
	bl	fopen64(PLT)
	str	r0, [sp, #8]
	cmp	r0, #0
	beq	.L253
	ldr	r7, .L266+16
	add	r5, sp, #596
	ldr	r2, .L266+20
	mov	r1, #640
.LPIC94:
	add	r7, pc
	mov	r0, r5
	mov	r3, r7
.LPIC95:
	add	r2, pc
	bl	xsnprintf(PLT)
	ldr	r2, .L266+24
	addw	r10, sp, #1876
	mov	r3, r5
.LPIC96:
	add	r2, pc
	mov	r1, #640
	mov	r0, r10
	bl	xsnprintf(PLT)
	ldr	r2, .L266+28
	mov	r3, r7
	mov	r1, #640
.LPIC98:
	add	r2, pc
	mov	r0, r10
	str	r4, [sp]
	bl	xsnprintf(PLT)
	bl	getpid(PLT)
	ldr	r2, .L266+32
	addw	r3, sp, #2516
	mov	r1, #648
.LPIC99:
	add	r2, pc
	str	r0, [sp]
	str	r3, [sp, #64]
	mov	r0, r3
	mov	r3, r10
	mov	r8, r0
	bl	xsnprintf(PLT)
	bl	getpid(PLT)
	addw	r2, sp, #1236
	mov	r3, r7
	str	r2, [sp, #32]
	mov	r7, r2
	ldr	r2, .L266+36
	mov	r1, #640
	str	r0, [sp]
.LPIC101:
	add	r2, pc
	mov	r0, r7
	bl	xsnprintf(PLT)
	bl	priv_prefix(PLT)
	ldr	r2, .L266+40
	str	r5, [sp]
	addw	r5, sp, #3164
	mov	r3, r0
.LPIC102:
	add	r2, pc
	mov	r1, #768
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	ldr	r5, .L266+44
	bl	run_cmd(PLT)
	mov	r0, r7
.LPIC103:
	add	r5, pc
	mov	r1, r5
	bl	fopen64(PLT)
	mov	r1, r5
	str	r0, [sp, #48]
	mov	r5, r0
	mov	r0, r8
	bl	fopen64(PLT)
	cmp	r0, #0
	it	ne
	cmpne	r5, #0
	mov	r3, r5
	str	r0, [sp, #52]
	ite	eq
	moveq	r3, #1
	movne	r3, #0
	beq	.L254
	add	r5, sp, #4928
	str	r3, [sp, #28]
	strd	r3, r3, [sp, #68]
	add	r3, sp, #4960
	adds	r3, r3, #24
	movw	r7, #25199
	movt	r7, 8298
	movw	fp, #26980
	movt	fp, 8306
	str	r3, [sp, #12]
	str	r9, [sp, #56]
	add	r3, sp, #19328
	adds	r5, r5, #28
	mov	r9, r4
	adds	r3, r3, #80
	movw	r2, #31091
	movt	r2, 8301
	str	r3, [sp, #40]
	str	r2, [sp, #20]
	str	r10, [sp, #60]
.L157:
	ldr	r2, [sp, #8]
	mov	r1, #1024
	mov	r0, r5
	bl	fgets(PLT)
	cmp	r0, #0
	beq	.L255
.L189:
	subw	r3, r6, #1444
	ldr	r2, [r5]
	movs	r1, #0
	cmp	r2, r7
	strb	r1, [r3]
	beq	.L256
	cmp	r2, fp
	beq	.L257
	ldr	r3, [sp, #20]
	cmp	r2, r3
	bne	.L157
	ldr	r3, [sp, #12]
	ldr	r1, .L266+48
	sub	r4, r3, #24
.LPIC111:
	add	r1, pc
	mov	r0, r4
	bl	strstr(PLT)
	mov	r10, r0
	cmp	r0, #0
	beq	.L157
	subs	r4, r0, r4
	beq	.L170
	adds	r3, r4, #4
	add	r3, r3, r5
	b	.L171
.L172:
	subs	r4, r4, #1
	beq	.L170
.L171:
	ldrb	r2, [r3, #-1]!	@ zero_extendqisi2
	cmp	r2, #32
	beq	.L172
	cmp	r4, #1024
	bcs	.L157
.L170:
	add	r3, sp, #5984
	mov	r2, r4
	adds	r3, r3, #24
	str	r3, [sp, #16]
	sub	r8, r3, #28
	ldr	r3, [sp, #12]
	mov	r0, r8
	add	r10, r10, #2
	sub	r1, r3, #24
	bl	memcpy(PLT)
	ldrb	r2, [r10]	@ zero_extendqisi2
	add	r3, sp, #9664
	movs	r0, #0
	adds	r3, r3, #56
	cmp	r2, #32
	strb	r0, [r8, r4]
	bne	.L173
.L174:
	ldrb	r2, [r10, #1]!	@ zero_extendqisi2
	cmp	r2, #32
	beq	.L174
.L173:
	and	r1, r2, #223
	cmp	r1, #0
	it	ne
	cmpne	r2, #10
	ite	ne
	movne	ip, #1
	moveq	ip, #0
	beq	.L175
	ldr	r1, [sp, #36]
	addw	lr, r10, #511
	sub	r0, r1, #37
	mov	r1, r10
	b	.L177
.L176:
	cmp	lr, r1
	beq	.L258
.L177:
	mov	ip, r1
	strb	r2, [r0, #1]!
	ldrb	r2, [r1, #1]!	@ zero_extendqisi2
	and	r4, r2, #223
	cmp	r4, #0
	it	ne
	cmpne	r2, #10
	bne	.L176
	rsb	r10, r10, #1
	add	ip, ip, r10
.L175:
	subw	r2, r6, #1444
	movs	r1, #0
	mov	r10, #1
	strb	r1, [r2, ip]
	b	.L164
.L149:
	mov	r0, r5
	bl	free(PLT)
	ldr	r3, .L266+52
	ldr	r1, .L266+56
	mov	r2, r4
.LPIC89:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
.L151:
	movs	r0, #0
	add	sp, sp, #21888
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L256:
	add	r3, sp, #5984
	mov	r10, r1
	adds	r3, r3, #24
	ldr	r1, .L266+60
	sub	r8, r3, #28
	str	r3, [sp, #16]
	ldr	r3, [sp, #12]
.LPIC107:
	add	r1, pc
	mov	r2, r8
	sub	r0, r3, #24
	bl	__isoc99_sscanf(PLT)
	cmp	r0, #1
	bne	.L157
.L252:
	add	r3, sp, #9664
	adds	r3, r3, #56
.L164:
	subw	r3, r3, #3740
	ldrb	r3, [r3]	@ zero_extendqisi2
	cmp	r3, #47
	bne	.L157
	ldr	r2, [r8]
	movw	r3, #29999
	movt	r3, 29299
	cmp	r2, r3
	beq	.L259
.L178:
	ldr	r3, [sp, #28]
	mov	r1, #1024
	ldr	r2, [sp, #8]
	mov	r0, r5
	adds	r3, r3, #1
	str	r3, [sp, #28]
	bl	fgets(PLT)
	cmp	r0, #0
	bne	.L189
.L255:
	ldr	r0, [sp, #8]
	sub	r6, r6, #1448
	mov	r4, r9
	ldrd	r9, r10, [sp, #56]
	bl	fclose(PLT)
	ldr	r0, [sp, #48]
	bl	fclose(PLT)
	ldr	r0, [sp, #52]
	bl	fclose(PLT)
	ldr	r0, [r6]
	bl	free(PLT)
	ldr	r1, [sp, #40]
	ldr	r0, [sp, #32]
	mov	r2, #1600
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L260
	bl	priv_prefix(PLT)
	ldr	r2, [sp, #40]
	str	r2, [sp]
	add	r5, sp, #16768
	ldr	r2, .L266+64
	adds	r5, r5, #40
	mov	r3, r0
	mov	r1, #1400
.LPIC123:
	add	r2, pc
	mov	r0, r5
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	mov	r5, r0
	ldr	r0, [sp, #32]
	bl	unlink(PLT)
	cbnz	r5, .L261
	mov	r0, r10
	bl	unlink(PLT)
	ldr	r0, [sp, #64]
	mov	r1, r10
	bl	rename(PLT)
	cmp	r0, #0
	bne	.L262
.L192:
	ldrd	r1, r0, [sp, #24]
	str	r0, [sp]
	ldr	r0, .L266+68
	ldrd	r3, r2, [sp, #68]
.LPIC126:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	add_to_world(PLT)
	movs	r0, #1
	add	sp, sp, #21888
	add	sp, sp, #124
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L257:
	add	r3, sp, #5984
	ldr	r1, .L266+72
	adds	r3, r3, #24
	str	r3, [sp, #16]
	sub	r8, r3, #28
	ldr	r3, [sp, #12]
.LPIC109:
	add	r1, pc
	mov	r2, r8
	sub	r0, r3, #24
	bl	__isoc99_sscanf(PLT)
	cmp	r0, #1
	it	eq
	moveq	r10, #2
	beq	.L252
	b	.L157
.L261:
	ldr	r3, .L266+52
	mov	r2, r5
	ldr	r1, .L266+76
.LPIC124:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r0, [sp, #64]
	bl	unlink(PLT)
	b	.L151
.L260:
	ldr	r0, [sp, #64]
	bl	unlink(PLT)
	ldr	r0, [sp, #32]
	bl	unlink(PLT)
	b	.L151
.L259:
	ldrb	r3, [r8, #4]	@ zero_extendqisi2
	cmp	r3, #47
	bne	.L178
	add	r2, sp, #6976
	ldr	r3, [sp, #16]
	adds	r2, r2, #28
	str	r2, [sp, #16]
	mov	r0, r2
	ldr	r2, .L266+80
	subs	r3, r3, #24
	mov	r1, #1152
.LPIC113:
	add	r2, pc
	add	r4, sp, #9280
	bl	xsnprintf(PLT)
	ldr	r2, .L266+84
	adds	r4, r4, #28
	ldr	r3, [sp, #44]
.LPIC114:
	add	r2, pc
	movw	r1, #1300
	mov	r0, r4
	str	r8, [sp]
	bl	xsnprintf(PLT)
	add	r3, sp, #16768
	adds	r3, r3, #40
	mov	r0, r4
	mov	r1, r3
	movw	r2, #2600
	str	r3, [sp, #76]
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L157
	ldr	r4, [sp, #16]
	add	r8, sp, #11968
	add	r8, r8, #40
	mov	r2, #2400
	mov	r1, r8
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L157
	mov	r0, r4
	bl	strlen(PLT)
	mov	r2, r4
	mov	r3, r0
	add	r2, r2, r0
.L183:
	cmp	r3, #0
	beq	.L182
	ldrb	r1, [r2, #-1]!	@ zero_extendqisi2
	subs	r0, r3, #1
	cmp	r1, #47
	beq	.L263
	mov	r3, r0
	b	.L183
.L262:
	ldr	r3, .L266+52
	mov	r2, r10
	ldr	r1, .L266+88
.LPIC125:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L192
.L258:
	movw	ip, #511
	b	.L175
.L263:
	cmp	r3, #1
	beq	.L182
	ldr	r2, [sp, #16]
	add	r4, sp, #8128
	str	r2, [sp]
	adds	r4, r4, #28
	ldr	r2, .L266+92
	mov	r1, #1152
	mov	r0, r4
.LPIC115:
	add	r2, pc
	bl	xsnprintf(PLT)
.L184:
	mov	r0, r4
	add	r4, sp, #14400
	adds	r4, r4, #8
	mov	r2, #2400
	mov	r1, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L157
	cmp	r10, #0
	beq	.L264
	cmp	r10, #1
	beq	.L265
	ldr	r1, .L266+96
	mov	r2, r8
	ldr	r0, [sp, #48]
.LPIC121:
	add	r1, pc
	bl	fprintf(PLT)
	ldr	r1, .L266+100
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #52]
.LPIC122:
	add	r1, pc
	bl	fprintf(PLT)
	ldr	r3, [sp, #68]
	adds	r3, r3, #1
	str	r3, [sp, #68]
	b	.L157
.L182:
	add	r4, sp, #8128
	ldr	r2, .L266+104
	adds	r4, r4, #28
	mov	r1, #1152
.LPIC116:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	b	.L184
.L264:
	ldr	r1, .L266+108
	mov	r2, r4
	ldr	r3, [sp, #76]
.LPIC117:
	add	r1, pc
	ldr	r0, [sp, #48]
	str	r8, [sp]
	bl	fprintf(PLT)
	ldr	r1, .L266+112
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #52]
.LPIC118:
	add	r1, pc
	bl	fprintf(PLT)
	ldr	r3, [sp, #24]
	adds	r3, r3, #1
	str	r3, [sp, #24]
	b	.L157
.L265:
	ldr	r2, [sp, #36]
	ldr	r10, [sp, #40]
	sub	r0, r2, #36
	movw	r2, #2600
	mov	r1, r10
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L157
	ldr	r1, .L266+116
	mov	r3, r10
	mov	r2, r4
	ldr	r0, [sp, #48]
.LPIC119:
	add	r1, pc
	str	r8, [sp]
	bl	fprintf(PLT)
	ldr	r1, .L266+120
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #52]
.LPIC120:
	add	r1, pc
	bl	fprintf(PLT)
	ldr	r3, [sp, #72]
	adds	r3, r3, #1
	str	r3, [sp, #72]
	b	.L157
.L253:
	ldr	r3, .L266+52
	sub	r6, r6, #1448
	ldr	r1, .L266+124
	ldr	r2, [r6]
.LPIC93:
	add	r1, pc
	ldr	r3, [r9, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	ldr	r0, [r6]
	bl	free(PLT)
	b	.L151
.L254:
	ldr	r3, [sp, #48]
	cbz	r3, .L158
	mov	r0, r3
	bl	fclose(PLT)
.L158:
	ldr	r3, [sp, #52]
	cbz	r3, .L159
	mov	r0, r3
	bl	fclose(PLT)
.L159:
	sub	r6, r6, #1448
	ldr	r0, [sp, #8]
	bl	fclose(PLT)
	ldr	r0, [r6]
	bl	free(PLT)
	ldr	r3, .L266+52
	ldr	r0, .L266+128
	movs	r2, #48
	movs	r1, #1
.LPIC105:
	add	r0, pc
	ldr	r3, [r9, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L151
.L267:
	.align	2
.L266:
	.word	.LC64-(.LPIC88+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC90+4)
	.word	.LC66-(.LPIC91+4)
	.word	.LC67-(.LPIC92+4)
	.word	.LC6-(.LPIC94+4)
	.word	.LC69-(.LPIC95+4)
	.word	.LC1-(.LPIC96+4)
	.word	.LC63-(.LPIC98+4)
	.word	.LC70-(.LPIC99+4)
	.word	.LC71-(.LPIC101+4)
	.word	.LC16-(.LPIC102+4)
	.word	.LC72-(.LPIC103+4)
	.word	.LC78-(.LPIC111+4)
	.word	stderr(GOT)
	.word	.LC65-(.LPIC89+4)
	.word	.LC75-(.LPIC107+4)
	.word	.LC90-(.LPIC123+4)
	.word	.LC93-(.LPIC126+4)
	.word	.LC75-(.LPIC109+4)
	.word	.LC91-(.LPIC124+4)
	.word	.LC80-(.LPIC113+4)
	.word	.LC81-(.LPIC114+4)
	.word	.LC92-(.LPIC125+4)
	.word	.LC82-(.LPIC115+4)
	.word	.LC88-(.LPIC121+4)
	.word	.LC89-(.LPIC122+4)
	.word	.LC83-(.LPIC116+4)
	.word	.LC84-(.LPIC117+4)
	.word	.LC85-(.LPIC118+4)
	.word	.LC86-(.LPIC119+4)
	.word	.LC87-(.LPIC120+4)
	.word	.LC68-(.LPIC93+4)
	.word	.LC73-(.LPIC105+4)
	.section	.rodata.str1.4
	.align	2
.LC94:
	.ascii	"%s/.chroot-unmerge-%ld.sh\000"
	.align	2
.LC95:
	.ascii	"%7s %1100[^\012]\000"
	.align	2
.LC96:
	.ascii	"/usr/local\000"
	.align	2
.LC97:
	.ascii	"rmdir --ignore-fail-on-non-empty -p %s 2>/dev/null;"
	.ascii	" true\012\000"
	.align	2
.LC98:
	.ascii	"rm -f %s\012\000"
	.align	2
.LC99:
	.ascii	"\033[1;31m[-] Chroot manifest removal failed (exit "
	.ascii	"%d)\012\033[0m\000"
	.align	2
.LC100:
	.ascii	"%srm -f '%s'\000"
	.align	2
.LC101:
	.ascii	"\033[1;32m[+] Removed %d manifest entr(ies) from /u"
	.ascii	"sr/local\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	gentoo_chroot_unmerge
	.syntax unified
	.thumb
	.thumb_func
	.type	gentoo_chroot_unmerge, %function
gentoo_chroot_unmerge:
	@ args = 0, pretend = 0, frame = 7224
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	fp, .L308
	sub	sp, sp, #7232
	sub	sp, sp, #4
.LPIC139:
	add	fp, pc
	cbz	r0, .L270
	mov	r4, r0
	bl	valid_pkgname(PLT)
	cbnz	r0, .L302
.L270:
	movs	r0, #0
	add	sp, sp, #7232
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L302:
	ldr	r5, .L308+4
	add	r3, sp, #32
	ldr	r2, .L308+8
	mov	r0, r3
.LPIC127:
	add	r5, pc
	mov	r1, #640
.LPIC128:
	add	r2, pc
	str	r3, [sp, #28]
	str	r4, [sp]
	mov	r3, r5
	mov	r4, r0
	bl	xsnprintf(PLT)
	ldr	r1, .L308+12
	mov	r0, r4
.LPIC129:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r7, r0
	cmp	r0, #0
	beq	.L270
	bl	getpid(PLT)
	ldr	r2, .L308+16
	add	r4, sp, #672
	mov	r3, r5
.LPIC131:
	add	r2, pc
	mov	r1, #640
	str	r0, [sp]
	mov	r0, r4
	bl	xsnprintf(PLT)
	ldr	r1, .L308+20
	mov	r0, r4
.LPIC132:
	add	r1, pc
	bl	fopen64(PLT)
	mov	r9, r0
	cmp	r0, #0
	beq	.L303
	ldr	r8, .L308+24
	add	r10, sp, #4608
	ldr	r3, .L308+28
	add	r10, r10, #24
.LPIC133:
	add	r8, pc
	add	r5, sp, #2080
.LPIC134:
	add	r3, pc
	str	r4, [sp, #24]
	str	r3, [sp, #20]
	movs	r3, #0
	str	r3, [sp, #12]
.L272:
	mov	r2, r7
	mov	r1, #1152
	mov	r0, r5
	bl	fgets(PLT)
	cmp	r0, #0
	beq	.L304
.L280:
	add	r6, sp, #3232
	add	r4, sp, #1312
	mov	r3, r6
	mov	r2, r4
	mov	r1, r8
	mov	r0, r5
	bl	__isoc99_sscanf(PLT)
	cmp	r0, #2
	bne	.L272
	mov	r0, r6
	bl	strlen(PLT)
	cmp	r0, #0
	beq	.L272
	adds	r2, r6, r0
	mov	ip, #0
	b	.L275
.L276:
	strb	ip, [r2]
	cmp	r0, #0
	beq	.L272
.L275:
	ldrb	r1, [r2, #-1]!	@ zero_extendqisi2
	mov	r3, r0
	subs	r0, r0, #1
	cmp	r1, #13
	it	ne
	cmpne	r1, #10
	beq	.L276
	ldr	r1, [sp, #20]
	movs	r2, #10
	mov	r0, r6
	str	r3, [sp, #16]
	bl	strncmp(PLT)
	ldr	r3, [sp, #16]
	cmp	r3, #11
	ite	hi
	movhi	r3, #0
	movls	r3, #1
	cmp	r0, #0
	it	ne
	orrne	r3, r3, #1
	cmp	r3, #0
	bne	.L272
	mov	r0, r6
	mov	r1, r10
	movw	r2, #2600
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L272
	ldrb	r3, [r4]	@ zero_extendqisi2
	cmp	r3, #100
	beq	.L305
	ldr	r1, .L308+32
	mov	r2, r10
	mov	r0, r9
.LPIC136:
	add	r1, pc
	bl	fprintf(PLT)
.L278:
	ldr	r3, [sp, #12]
	mov	r2, r7
	mov	r1, #1152
	mov	r0, r5
	adds	r3, r3, #1
	str	r3, [sp, #12]
	bl	fgets(PLT)
	cmp	r0, #0
	bne	.L280
.L304:
	ldr	r4, [sp, #24]
	mov	r0, r7
	bl	fclose(PLT)
	mov	r0, r9
	bl	fclose(PLT)
	mov	r2, #1600
	mov	r1, r10
	mov	r0, r4
	bl	shell_quote(PLT)
	cmp	r0, #0
	beq	.L306
	bl	priv_prefix(PLT)
	ldr	r2, .L308+36
	add	r5, sp, #3232
	mov	r3, r0
.LPIC137:
	add	r2, pc
	mov	r1, #1400
	mov	r0, r5
	str	r10, [sp]
	bl	xsnprintf(PLT)
	mov	r0, r5
	bl	run_cmd(PLT)
	mov	r2, r0
	mov	r0, r4
	mov	r4, r2
	bl	unlink(PLT)
	cbnz	r4, .L307
	bl	priv_prefix(PLT)
	ldr	r2, .L308+40
	ldr	r1, [sp, #28]
	add	r4, sp, #1312
	mov	r3, r0
.LPIC140:
	add	r2, pc
	str	r1, [sp]
	mov	r0, r4
	mov	r1, #768
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	ldr	r0, .L308+44
	ldr	r1, [sp, #12]
.LPIC141:
	add	r0, pc
	bl	printf(PLT)
	movs	r0, #1
	add	sp, sp, #7232
	add	sp, sp, #4
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L307:
	ldr	r3, .L308+48
	mov	r2, r4
	ldr	r1, .L308+52
.LPIC138:
	add	r1, pc
	ldr	r3, [fp, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L270
.L306:
	mov	r0, r4
	bl	unlink(PLT)
	b	.L270
.L305:
	ldr	r1, .L308+56
	mov	r2, r10
	mov	r0, r9
.LPIC135:
	add	r1, pc
	bl	fprintf(PLT)
	b	.L278
.L303:
	mov	r0, r7
	bl	fclose(PLT)
	b	.L270
.L309:
	.align	2
.L308:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC139+4)
	.word	.LC6-(.LPIC127+4)
	.word	.LC63-(.LPIC128+4)
	.word	.LC67-(.LPIC129+4)
	.word	.LC94-(.LPIC131+4)
	.word	.LC72-(.LPIC132+4)
	.word	.LC95-(.LPIC133+4)
	.word	.LC96-(.LPIC134+4)
	.word	.LC98-(.LPIC136+4)
	.word	.LC90-(.LPIC137+4)
	.word	.LC100-(.LPIC140+4)
	.word	.LC101-(.LPIC141+4)
	.word	stderr(GOT)
	.word	.LC99-(.LPIC138+4)
	.word	.LC97-(.LPIC135+4)
	.section	.rodata.str1.4
	.align	2
.LC102:
	.ascii	"/usr/local/emerge/gentoo-chroot\000"
	.align	2
.LC103:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC104:
	.ascii	"\033[1;32m>>> Emerging %s\012\033[0m\000"
	.align	2
.LC105:
	.ascii	"\033[1;31m[-] Failed to init Gentoo chroot\012\033["
	.ascii	"0m\000"
	.align	2
.LC106:
	.ascii	"\033[1;32m\012>>> Completed %s\012\033[0m\000"
	.align	2
.LC107:
	.ascii	"\033[1;33m[!] Build interrupted, chroot cleaned up\012"
	.ascii	"\033[0m\000"
	.align	2
.LC108:
	.ascii	"\033[1;31m[-] Imitation build failed\012\033[0m\000"
	.align	2
.LC109:
	.ascii	"\033[1;33m    Tip: try manual fix: sudo chroot %s e"
	.ascii	"merge --sync && sudo chroot %s eselect profile set "
	.ascii	"1\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_gentoo_imitation_build
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_gentoo_imitation_build, %function
cmd_gentoo_imitation_build:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r5, r0
	ldr	r6, .L325
.LPIC145:
	add	r6, pc
	bl	valid_pkgname(PLT)
	cbz	r0, .L323
	bl	get_gentoo_chroot_path(PLT)
	mov	r4, r0
	cmp	r0, #0
	beq	.L320
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L313
	ldr	r4, .L325+4
.LPIC143:
	add	r4, pc
.L313:
	ldr	r0, .L325+8
	mov	r1, r5
.LPIC146:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r4
	bl	gentoo_chroot_init(PLT)
	cbz	r0, .L324
	mov	r0, r4
	bl	gentoo_chroot_mount.part.0(PLT)
	bl	get_jobs(PLT)
	cbnz	r5, .L316
	mov	r0, r4
	bl	gentoo_chroot_unmount(PLT)
.L317:
	ldr	r3, .L325+12
	movs	r2, #38
	ldr	r0, .L325+16
	movs	r1, #1
.LPIC150:
	add	r0, pc
	ldr	r5, [r6, r3]
	ldr	r3, [r5]
	bl	fwrite(PLT)
	ldr	r1, .L325+20
	ldr	r0, [r5]
	mov	r3, r4
	mov	r2, r4
.LPIC151:
	add	r1, pc
	bl	fprintf(PLT)
.L312:
	movs	r7, #0
	mov	r0, r7
	pop	{r3, r4, r5, r6, r7, pc}
.L323:
	ldr	r3, .L325+12
	mov	r2, r5
	ldr	r1, .L325+24
.LPIC144:
	add	r1, pc
	ldr	r3, [r6, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L312
.L324:
	ldr	r3, .L325+12
	movs	r2, #44
	ldr	r0, .L325+28
	movs	r1, #1
.LPIC147:
	add	r0, pc
	ldr	r3, [r6, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L312
.L320:
	ldr	r4, .L325+32
.LPIC142:
	add	r4, pc
	b	.L313
.L316:
	mov	r2, r0
	mov	r1, r5
	mov	r0, r4
	bl	gentoo_chroot_run_portage.part.0(PLT)
	mov	r7, r0
	cbnz	r0, .L318
	mov	r1, r5
	mov	r0, r4
	bl	gentoo_chroot_install_artifacts(PLT)
	mov	r7, r0
	mov	r0, r4
	cbnz	r7, .L319
	bl	gentoo_chroot_unmount(PLT)
	b	.L317
.L319:
	bl	gentoo_chroot_unmount(PLT)
	ldr	r0, .L325+36
	mov	r1, r5
.LPIC148:
	add	r0, pc
	bl	printf(PLT)
	mov	r0, r7
	pop	{r3, r4, r5, r6, r7, pc}
.L318:
	mov	r0, r4
	bl	gentoo_chroot_unmount(PLT)
	cmp	r7, #130
	bne	.L317
	ldr	r0, .L325+40
.LPIC149:
	add	r0, pc
	bl	printf(PLT)
	b	.L312
.L326:
	.align	2
.L325:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC145+4)
	.word	.LC102-(.LPIC143+4)
	.word	.LC104-(.LPIC146+4)
	.word	stderr(GOT)
	.word	.LC108-(.LPIC150+4)
	.word	.LC109-(.LPIC151+4)
	.word	.LC103-(.LPIC144+4)
	.word	.LC105-(.LPIC147+4)
	.word	.LC102-(.LPIC142+4)
	.word	.LC106-(.LPIC148+4)
	.word	.LC107-(.LPIC149+4)
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_chroot_interrupted, %object
g_chroot_interrupted:
	.space	4
	.space	4
	.type	g_chroot_path_store, %object
g_chroot_path_store:
	.space	512
	.section	.note.GNU-stack,"",%progbits
