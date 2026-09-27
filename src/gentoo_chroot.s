	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.type	chroot_signal_handler, %function
chroot_signal_handler:
	adrp	x0, .LANCHOR0
	mov	w1, 1
	str	w1, [x0, #:lo12:.LANCHOR0]
	ret
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%s/etc/gentoo-release"
	.align	3
.LC1:
	.string	"%s/etc/os-release"
	.align	3
.LC2:
	.string	"grep -q Gentoo '%s' 2>/dev/null"
	.text
	.align	2
	.p2align 5,,15
	.type	gentoo_chroot_exists.part.0, %function
gentoo_chroot_exists.part.0:
	sub	sp, sp, #2208
	mov	x3, x0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 1024
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x0, [sp, 24]
	add	x0, sp, 32
	bl	xsnprintf
	add	x0, sp, 32
	bl	file_exists
	cbz	w0, .L10
	mov	w0, 1
.L3:
	ldp	x29, x30, [sp]
	add	sp, sp, 2208
	ret
	.p2align 2,,3
.L10:
	ldr	x3, [sp, 24]
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	mov	x1, 1024
	add	x0, sp, 32
	bl	xsnprintf
	add	x0, sp, 32
	bl	file_exists
	cbz	w0, .L3
	add	x3, sp, 32
	adrp	x2, .LC2
	add	x2, x2, :lo12:.LC2
	mov	x1, 1150
	add	x0, sp, 1056
	bl	xsnprintf
	add	x0, sp, 1056
	bl	run_cmd_quiet
	cmp	w0, 0
	ldp	x29, x30, [sp]
	cset	w0, eq
	add	sp, sp, 2208
	ret
	.section	.rodata.str1.8
	.align	3
.LC3:
	.string	"\033[1;34m>>> Mounting chroot...\n\033[0m"
	.align	3
.LC4:
	.string	"%s"
	.align	3
.LC5:
	.ascii	"%smount -t proc proc '%s/proc' 2>/dev/null; mount --rbind /s"
	.ascii	"ys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev"
	.ascii	"/null; mount --rbind /dev '%s/dev' 2>/dev/null; mount --make"
	.ascii	"-rslave '%s/dev' 2>/dev/null; mount --rbind /run '%s/run' 2>"
	.ascii	"/dev/null; mount --make-rslave '%s/run' 2>/d"
	.string	"ev/null; mount -t tmpfs tmpfs '%s/tmp' 2>/dev/null; mkdir -p '%s/%s' '%s/%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mkdir -p '%s/%s' && touch '%s/%s' && mount --bind '%s' '%s/%s' 2>/dev/null; true"
	.align	3
.LC6:
	.string	"/usr/local/emerge/world"
	.align	3
.LC7:
	.string	"/usr/local/emerge/backups"
	.align	3
.LC8:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC9:
	.string	"/usr/local/emerge"
	.align	3
.LC10:
	.string	"\033[1;33m[!] Some mounts failed (maybe already mounted or no permission), continuing\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	gentoo_chroot_mount.part.0, %function
gentoo_chroot_mount.part.0:
	mov	x12, 4320
	sub	sp, sp, x12
	stp	x29, x30, [sp, 192]
	add	x29, sp, 192
	str	x19, [sp, 208]
	mov	x19, x0
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	mov	x3, x19
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	mov	x1, 512
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x0, x0, 16
	bl	xsnprintf
	bl	priv_prefix
	mov	x3, x0
	adrp	x1, .LC6
	adrp	x2, .LC7
	add	x1, x1, :lo12:.LC6
	add	x2, x2, :lo12:.LC7
	adrp	x4, .LC9
	add	x4, x4, :lo12:.LC9
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	stp	x19, x19, [sp]
	add	x0, sp, 224
	stp	x19, x19, [sp, 16]
	stp	x19, x2, [sp, 48]
	stp	x19, x4, [sp, 64]
	mov	x4, x19
	stp	x19, x2, [sp, 112]
	stp	x19, x1, [sp, 128]
	stp	x19, x1, [sp, 144]
	stp	x1, x19, [sp, 160]
	str	x1, [sp, 176]
	adrp	x1, .LC8
	add	x1, x1, :lo12:.LC8
	stp	x19, x1, [sp, 32]
	stp	x1, x19, [sp, 80]
	stp	x1, x2, [sp, 96]
	adrp	x2, .LC5
	add	x2, x2, :lo12:.LC5
	mov	x1, 4096
	bl	xsnprintf
	add	x0, sp, 224
	bl	run_cmd
	cbnz	w0, .L17
	ldr	x19, [sp, 208]
	mov	w0, 1
	ldp	x29, x30, [sp, 192]
	mov	x12, 4320
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L17:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 87
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	fwrite
	ldr	x19, [sp, 208]
	mov	w0, 1
	ldp	x29, x30, [sp, 192]
	mov	x12, 4320
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC11:
	.string	"root"
	.align	3
.LC12:
	.string	"\033[1;32m[+] Gentoo chroot already exists at %s (persistent mode)\n\033[0m"
	.align	3
.LC13:
	.string	"\033[1;36m>>> Initializing chroot at %s...\n\033[0m"
	.align	3
.LC14:
	.string	"%smkdir -p '%s'"
	.align	3
.LC15:
	.string	"\033[1;31m[-] Cannot create chroot dir %s\n\033[0m"
	.align	3
.LC16:
	.string	"\033[1;34m>>> Fetching latest Gentoo stage3 URL...\n\033[0m"
	.align	3
.LC17:
	.string	"curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt 2>/dev/null | grep -E 'stage3-amd64-openrc.*\\.tar\\.xz' | grep -v '^#' | grep -v 'BEGIN' | head -n1 | awk '{print $1}'"
	.align	3
.LC18:
	.string	"BEGIN"
	.align	3
.LC19:
	.string	".tar"
	.align	3
.LC20:
	.string	"https://"
	.align	3
.LC21:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/%s"
	.align	3
.LC22:
	.string	"\033[1;32m[+] Latest stage3: %s\n\033[0m"
	.align	3
.LC23:
	.string	"\033[1;33m[!] Could not fetch latest list, using fallback\n\033[0m"
	.align	3
.LC24:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/stage3-amd64-openrc-latest.tar.xz"
	.align	3
.LC25:
	.string	"curl -fsI '%s' >/dev/null 2>&1 && echo ok || echo fail"
	.align	3
.LC26:
	.string	"ok"
	.align	3
.LC27:
	.string	"\033[1;33m[!] Fallback not reachable, trying alt\n\033[0m"
	.align	3
.LC28:
	.string	"curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/ 2>/dev/null | grep -oE 'stage3-amd64-openrc-[0-9TZ]+\\.tar\\.xz' | head -n1"
	.align	3
.LC29:
	.string	".tar.xz"
	.align	3
.LC30:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/%s"
	.align	3
.LC31:
	.string	"\033[1;32m[+] Alternative stage3: %s\n\033[0m"
	.align	3
.LC32:
	.string	"/tmp/gentoo-stage3-%ld.tar.xz"
	.align	3
.LC33:
	.string	"\033[1;34m>>> Downloading stage3 (this may take a while)...\n\033[0m"
	.align	3
.LC34:
	.string	"curl -fL -o '%s' '%s' || wget -O '%s' '%s'"
	.align	3
.LC35:
	.string	"\033[1;31m[-] Failed to download stage3 from %s\n\033[0m"
	.align	3
.LC36:
	.string	"\033[1;33m    Try manually: curl -o %s %s\n\033[0m"
	.align	3
.LC37:
	.string	"\033[1;34m>>> Extracting stage3 to %s...\n\033[0m"
	.align	3
.LC38:
	.string	"%star -xpf '%s' -C '%s' --xattrs-include='*.*' --numeric-owner 2>&1 | head -n 20"
	.align	3
.LC39:
	.string	"rm -f '%s'"
	.align	3
.LC40:
	.string	"\033[1;31m[-] Failed to extract stage3\n\033[0m"
	.align	3
.LC41:
	.string	"\033[1;34m>>> Setting up chroot basics...\n\033[0m"
	.align	3
.LC42:
	.string	"%smkdir -p '%s/proc' '%s/sys' '%s/dev' '%s/tmp' '%s/run' '%s/%s' '%s/%s' '%s/var/db/repos/gentoo' && %scp -L /etc/resolv.conf '%s/etc/resolv.conf' 2>/dev/null; %schown -R '%s' '%s' 2>/dev/null; true"
	.align	3
.LC43:
	.string	"\033[1;34m>>> Fixing Portage profile and repos...\n\033[0m"
	.align	3
.LC44:
	.ascii	"%schroot '%s' /bin/bash -c 'eselect profile list 2>/dev/null"
	.ascii	" | head -n5; if [ ! -e /etc/portage/make.profile ] || [ ! -L"
	.ascii	" /etc/portage/make.profile ]; then   echo \">>> Fixing make."
	.ascii	"profile symlink...\";   rm -rf /etc/portage/make.profile;   "
	.ascii	"if [ -d /var/db/repos/gentoo/profiles/default/linux/amd64/23"
	.ascii	".0 ]; then     ln -sf /var/db/repos/gentoo/profiles/default/"
	.ascii	"linux/amd64/23.0 /etc/portage/make.profile;   elif [ -d /var"
	.ascii	"/db/repos/gentoo/profiles/default/linux/amd64/23.0/no-multil"
	.ascii	"ib ]; then     ln -sf /var/db/repos/gentoo/profiles/default/"
	.ascii	"linux/amd64/23.0/no-multilib /etc/portage/make.prof"
	.string	"ile;   else     prof=$(ls -d /var/db/repos/gentoo/profiles/default/linux/amd64/* 2>/dev/null | head -n1);     if [ -n \"$prof\" ]; then ln -sf $prof /etc/portage/make.profile; fi;   fi; fi; ls -l /etc/portage/make.profile 2>/dev/null; true' 2>&1 | head -n 20"
	.align	3
.LC45:
	.string	"\033[1;34m>>> Syncing Gentoo repos inside chroot (emerge-webrsync fallback)...\n\033[0m"
	.align	3
.LC46:
	.ascii	"%smount -t proc proc '%s/proc' 2>/dev/null; mount --rbind /s"
	.ascii	"ys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev"
	.ascii	"/null; mount --rbind /dev '%s/dev' 2>/dev/null; mount --make"
	.ascii	"-rslave '%s/dev' 2>/dev/null; chroot '%s' /bin/bash -c 'sour"
	.ascii	"ce /etc/profile; mkdir -p /var/db/repos/gentoo; if [ ! -d /v"
	.ascii	"ar/db/repos/gentoo/profiles ]; then   echo \">>> Running eme"
	.ascii	"rge-webrsync (first sync)...\";   emerge-webrsync 2>&1 | tai"
	.ascii	"l -n 30; else   echo \">>> Repo exists, running emerge --syn"
	.ascii	"c...\";   emerge --sync 2>&1 | tail -n 30; fi; eselect profi"
	.ascii	"le list 2>/dev/null | head -n 20; i"
	.string	"f [ ! -L /etc/portage/make.profile ]; then   eselect profile set 1 2>/dev/null || eselect profile set default/linux/amd64/23.0 2>/dev/null || true; fi; '; umount -l '%s/proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; true"
	.align	3
.LC47:
	.string	"\033[1;33m[!] Chroot init finished but gentoo-release not found, may still work\n\033[0m"
	.align	3
.LC48:
	.string	"\033[1;32m[+] Gentoo chroot initialized at %s\n\033[0m"
	.align	3
.LC49:
	.string	"\033[1;33m[!] If repo still fails, run manually: sudo chroot %s emerge --sync\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	gentoo_chroot_init.part.0, %function
gentoo_chroot_init.part.0:
	mov	x12, 6512
	sub	sp, sp, x12
	stp	x29, x30, [sp, 96]
	add	x29, sp, 96
	stp	x19, x20, [sp, 112]
	mov	x19, x0
	stp	x21, x22, [sp, 128]
	cbz	x0, .L19
	ldrb	w1, [x0]
	cbnz	w1, .L94
.L19:
	mov	x1, x19
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC14
	add	x2, x2, :lo12:.LC14
	mov	x1, 4096
	add	x0, sp, 2416
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	mov	w21, w0
	cbnz	w0, .L95
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	str	xzr, [sp, 168]
	add	x1, sp, 168
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	run_cmd_capture
	mov	x2, 1024
	mov	w20, w0
	mov	w1, 0
	add	x0, sp, 192
	bl	memset
	ldr	x3, [sp, 168]
	cbnz	w20, .L22
	cbz	x3, .L23
	ldrb	w1, [x3]
	cbz	w1, .L22
	mov	x0, 9728
	movk	x0, 0x1, lsl 32
	.p2align 5,,15
.L24:
	cmp	w1, 32
	bhi	.L25
	lsr	x1, x0, x1
	tbz	x1, 0, .L25
	ldrb	w1, [x3, 1]!
	cbnz	w1, .L24
.L25:
	mov	x0, x3
	str	x3, [sp, 152]
	bl	strlen
	mov	x1, x0
	mov	x0, 9728
	ldr	x3, [sp, 152]
	movk	x0, 0x1, lsl 32
	cbz	x1, .L30
	.p2align 5,,15
.L29:
	sub	x1, x1, #1
	ldrb	w2, [x3, x1]
	cmp	w2, 32
	bhi	.L30
	lsr	x2, x0, x2
	tbz	x2, 0, .L30
	strb	wzr, [x3, x1]
	cbnz	x1, .L29
.L30:
	adrp	x1, .LC18
	mov	x0, x3
	add	x1, x1, :lo12:.LC18
	str	x3, [sp, 152]
	bl	strstr
	cbz	x0, .L96
.L32:
	ldr	x0, [sp, 168]
	bl	free
	str	xzr, [sp, 168]
	b	.L23
	.p2align 2,,3
.L94:
	bl	gentoo_chroot_exists.part.0
	mov	w21, w0
	cbz	w0, .L19
	adrp	x0, .LC12
	mov	x1, x19
	add	x0, x0, :lo12:.LC12
	bl	printf
.L18:
	ldp	x29, x30, [sp, 96]
	mov	w0, w21
	ldp	x19, x20, [sp, 112]
	mov	x12, 6512
	ldp	x21, x22, [sp, 128]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L95:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	mov	w21, 0
	adrp	x1, .LC15
	add	x1, x1, :lo12:.LC15
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp, 96]
	mov	w0, w21
	ldp	x19, x20, [sp, 112]
	mov	x12, 6512
	ldp	x21, x22, [sp, 128]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L22:
	mov	x0, x3
	bl	free
	str	xzr, [sp, 168]
.L23:
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	printf
	add	x20, sp, 1216
	mov	x1, 1024
	add	x0, sp, 192
	adrp	x2, .LC24
	add	x2, x2, :lo12:.LC24
	bl	xsnprintf
	add	x3, sp, 192
	adrp	x2, .LC25
	add	x2, x2, :lo12:.LC25
	mov	x1, 1200
	mov	x0, x20
	bl	xsnprintf
	add	x1, sp, 176
	mov	x0, x20
	str	xzr, [sp, 176]
	bl	run_cmd_capture
	ldr	x2, [sp, 176]
	cbnz	w0, .L36
	cbz	x2, .L36
	mov	x0, x2
	adrp	x1, .LC26
	add	x1, x1, :lo12:.LC26
	str	x2, [sp, 152]
	bl	strstr
	ldr	x2, [sp, 152]
	cbz	x0, .L36
	mov	x0, x2
	bl	free
	b	.L35
	.p2align 2,,3
.L36:
	mov	x0, x2
	bl	free
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	printf
	str	xzr, [sp, 184]
	add	x1, sp, 184
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	run_cmd_capture
	ldr	x3, [sp, 184]
	cbnz	w0, .L39
	cbz	x3, .L39
	ldrb	w0, [x3]
	cbz	w0, .L39
	mov	x0, x3
	mov	w1, 10
	str	x3, [sp, 152]
	bl	strchr
	ldr	x3, [sp, 152]
	cbz	x0, .L42
	strb	wzr, [x0]
	ldr	x3, [sp, 184]
.L42:
	mov	x0, x3
	adrp	x1, .LC29
	add	x1, x1, :lo12:.LC29
	str	x3, [sp, 152]
	bl	strstr
	ldr	x3, [sp, 152]
	cbz	x0, .L39
	adrp	x2, .LC30
	add	x2, x2, :lo12:.LC30
	mov	x1, 1024
	add	x0, sp, 192
	bl	xsnprintf
	add	x1, sp, 192
	adrp	x0, .LC31
	add	x0, x0, :lo12:.LC31
	bl	printf
	ldr	x3, [sp, 184]
	.p2align 5,,15
.L39:
	mov	x0, x3
	bl	free
.L35:
	bl	getpid
	sxtw	x3, w0
	adrp	x2, .LC32
	add	x2, x2, :lo12:.LC32
	mov	x1, 512
	mov	x0, x20
	bl	xsnprintf
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	printf
	add	x6, sp, 192
	mov	x5, x20
	mov	x4, x6
	mov	x3, x20
	adrp	x2, .LC34
	add	x2, x2, :lo12:.LC34
	mov	x1, 4096
	add	x0, sp, 2416
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	cbnz	w0, .L97
	mov	x1, x19
	adrp	x0, .LC37
	add	x0, x0, :lo12:.LC37
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x5, x19
	mov	x4, x20
	adrp	x2, .LC38
	add	x2, x2, :lo12:.LC38
	mov	x1, 4096
	add	x0, sp, 2416
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	mov	x3, x20
	adrp	x2, .LC39
	add	x2, x2, :lo12:.LC39
	mov	x1, 4096
	mov	w21, w0
	add	x0, sp, 2416
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd_quiet
	cbnz	w21, .L98
	adrp	x0, .LC41
	add	x0, x0, :lo12:.LC41
	bl	printf
	bl	priv_prefix
	mov	x22, x0
	bl	priv_prefix
	mov	x20, x0
	bl	priv_prefix
	mov	x21, x0
	bl	build_user
	cbz	x0, .L48
	bl	build_user
.L45:
	stp	x21, x0, [sp, 64]
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	mov	x3, x22
	adrp	x2, .LC42
	add	x2, x2, :lo12:.LC42
	stp	x19, x19, [sp]
	mov	x1, 4096
	stp	x0, x19, [sp, 32]
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	stp	x0, x19, [sp, 16]
	add	x0, sp, 2416
	stp	x20, x19, [sp, 48]
	str	x19, [sp, 80]
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	adrp	x0, .LC43
	add	x0, x0, :lo12:.LC43
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC44
	add	x2, x2, :lo12:.LC44
	mov	x1, 4096
	add	x0, sp, 2416
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	stp	x19, x19, [sp]
	mov	x1, 4096
	add	x0, sp, 2416
	stp	x19, x19, [sp, 16]
	str	x19, [sp, 32]
	bl	xsnprintf
	add	x0, sp, 2416
	bl	run_cmd
	cbz	x19, .L46
	ldrb	w0, [x19]
	cbnz	w0, .L99
.L46:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 81
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC47
	add	x0, x0, :lo12:.LC47
	bl	fwrite
.L47:
	mov	x1, x19
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	bl	printf
	mov	x1, x19
	mov	w21, 1
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	bl	printf
	ldp	x29, x30, [sp, 96]
	mov	w0, w21
	ldp	x19, x20, [sp, 112]
	mov	x12, 6512
	ldp	x21, x22, [sp, 128]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L97:
	adrp	x19, :got:stderr
	ldr	x19, [x19, :got_lo12:stderr]
	add	x2, sp, 192
	adrp	x1, .LC35
	add	x1, x1, :lo12:.LC35
	ldr	x0, [x19]
	bl	fprintf
	ldr	x0, [x19]
	add	x3, sp, 192
	mov	x2, x20
	adrp	x1, .LC36
	add	x1, x1, :lo12:.LC36
	bl	fprintf
	ldp	x29, x30, [sp, 96]
	mov	w0, w21
	ldp	x19, x20, [sp, 112]
	mov	x12, 6512
	ldp	x21, x22, [sp, 128]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L98:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 40
	mov	x1, 1
	mov	w21, 0
	ldr	x3, [x0]
	adrp	x0, .LC40
	add	x0, x0, :lo12:.LC40
	bl	fwrite
	b	.L18
	.p2align 2,,3
.L48:
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	b	.L45
	.p2align 2,,3
.L99:
	mov	x0, x19
	bl	gentoo_chroot_exists.part.0
	cbnz	w0, .L47
	b	.L46
	.p2align 2,,3
.L96:
	ldr	x0, [sp, 152]
	adrp	x1, .LC19
	add	x1, x1, :lo12:.LC19
	bl	strstr
	cbz	x0, .L32
	ldr	x0, [sp, 152]
	bl	strlen
	cmp	x0, 10
	bls	.L32
	ldr	x0, [sp, 152]
	mov	x2, 8
	adrp	x1, .LC20
	add	x1, x1, :lo12:.LC20
	bl	strncmp
	ldr	x3, [sp, 152]
	cbnz	w0, .L33
	adrp	x2, .LC4
	add	x0, sp, 192
	add	x2, x2, :lo12:.LC4
	mov	x1, 1024
	bl	xsnprintf
.L34:
	add	x1, sp, 192
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	printf
	ldr	x0, [sp, 168]
	add	x20, sp, 1216
	bl	free
	str	xzr, [sp, 168]
	b	.L35
.L33:
	add	x0, sp, 192
	adrp	x2, .LC21
	mov	x1, 1024
	add	x2, x2, :lo12:.LC21
	bl	xsnprintf
	b	.L34
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_exists
	.type	gentoo_chroot_exists, %function
gentoo_chroot_exists:
	cbz	x0, .L102
	ldrb	w1, [x0]
	cbnz	w1, .L107
.L102:
	mov	w0, 0
	ret
	.p2align 2,,3
.L107:
	b	gentoo_chroot_exists.part.0
	.section	.rodata.str1.8
	.align	3
.LC50:
	.string	"(null)"
	.align	3
.LC51:
	.string	"\033[1;31m[-] Invalid chroot path: %s\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_init
	.type	gentoo_chroot_init, %function
gentoo_chroot_init:
	stp	x29, x30, [sp, -32]!
	mov	x29, sp
	cbz	x0, .L115
	str	x0, [sp, 24]
	bl	valid_gentoo_chroot_path
	ldr	x2, [sp, 24]
	cbnz	w0, .L111
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC51
	add	x1, x1, :lo12:.LC51
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.p2align 2,,3
.L111:
	ldp	x29, x30, [sp], 32
	mov	x0, x2
	b	gentoo_chroot_init.part.0
	.p2align 2,,3
.L115:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x2, .LC50
	adrp	x1, .LC51
	add	x2, x2, :lo12:.LC50
	add	x1, x1, :lo12:.LC51
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_mount
	.type	gentoo_chroot_mount, %function
gentoo_chroot_mount:
	cbz	x0, .L117
	b	gentoo_chroot_mount.part.0
	.p2align 2,,3
.L117:
	mov	w0, 0
	ret
	.section	.rodata.str1.8
	.align	3
.LC52:
	.string	"\033[1;34m>>> Unmounting...\n\033[0m"
	.align	3
.LC53:
	.ascii	"%sum"
	.string	"ount -l '%s/%s' 2>/dev/null; umount -l '%s/%s' 2>/dev/null; umount -l '%s/%s' 2>/dev/null; umount -l '%s/tmp' 2>/dev/null; umount -l '%s/run' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/proc' 2>/dev/null; true"
	.align	3
.LC54:
	.string	"%sgrep '%s' /proc/mounts | cut -d' ' -f2 | sort -r | xargs -r umount -l 2>/dev/null; true"
	.align	3
.LC55:
	.string	"\033[1;32m[+] Unmounted\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_unmount
	.type	gentoo_chroot_unmount, %function
gentoo_chroot_unmount:
	cbz	x0, .L129
	mov	x12, 4192
	sub	sp, sp, x12
	stp	x29, x30, [sp, 64]
	add	x29, sp, 64
	str	x19, [sp, 80]
	mov	x19, x0
	ldrb	w0, [x0]
	cbnz	w0, .L121
	adrp	x19, .LANCHOR0
	add	x19, x19, :lo12:.LANCHOR0
	ldrb	w0, [x19, 16]
	cbz	w0, .L122
	add	x19, x19, 16
.L121:
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x6, x19
	mov	x4, x19
	adrp	x1, .LC8
	adrp	x7, .LC7
	add	x1, x1, :lo12:.LC8
	add	x7, x7, :lo12:.LC7
	adrp	x5, .LC6
	adrp	x2, .LC53
	add	x5, x5, :lo12:.LC6
	add	x2, x2, :lo12:.LC53
	stp	x19, x1, [sp]
	mov	x1, 4096
	add	x0, sp, 96
	stp	x19, x19, [sp, 16]
	stp	x19, x19, [sp, 32]
	str	x19, [sp, 48]
	bl	xsnprintf
	add	x0, sp, 96
	bl	run_cmd
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC54
	add	x2, x2, :lo12:.LC54
	mov	x1, 4096
	add	x0, sp, 96
	bl	xsnprintf
	add	x0, sp, 96
	bl	run_cmd
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	printf
	ldr	x19, [sp, 80]
	mov	w0, 1
	ldp	x29, x30, [sp, 64]
	mov	x12, 4192
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L122:
	ldr	x19, [sp, 80]
	mov	w0, 0
	ldp	x29, x30, [sp, 64]
	mov	x12, 4192
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L129:
	mov	w0, 0
	ret
	.section	.rodata.str1.8
	.align	3
.LC56:
	.string	"\033[1;32m>>> Emerging (1 of 1) %s::gentoo\n\033[0m"
	.align	3
.LC57:
	.string	"\033[1;34m>>> Jobs: %d  Chroot: %s\n\033[0m"
	.align	3
.LC58:
	.ascii	"%sif [ ! -d '%s/var/db/repos/gentoo/profiles' ]; then   echo"
	.ascii	" '>>> Repo missing, syncing...';   mount -t proc proc '%s/pr"
	.ascii	"oc' 2>/dev/null;   mount --rbind /sys '%s/sys' 2>/dev/null; "
	.ascii	"mount --make-rslave '%s/sys' 2>/dev/null;   mount --rbind /d"
	.ascii	"ev "
	.string	"'%s/dev' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/null;   chroot '%s' /bin/bash -c 'source /etc/profile; emerge-webrsync 2>&1 | tail -n 20';   umount -l '%s/proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; fi; true"
	.align	3
.LC59:
	.string	"chroot '%s' /bin/bash -c \"source /etc/profile; if [ ! -L /etc/portage/make.profile ]; then eselect profile set 1 2>/dev/null || true; fi; emerge --ask n --jobs=%d --load-average=%d '%s' 2>&1\""
	.align	3
.LC60:
	.string	"\033[1;31m\n[!] Interrupted (Ctrl+C) - cleaning up chroot mounts...\n\033[0m"
	.align	3
.LC61:
	.string	"\033[1;31m[-] Portage inside chroot failed (exit %d)\n\033[0m"
	.align	3
.LC62:
	.string	"\033[1;32m[+] Portage inside chroot finished successfully\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	gentoo_chroot_run_portage.part.0, %function
gentoo_chroot_run_portage.part.0:
	mov	x12, 8288
	sub	sp, sp, x12
	stp	x29, x30, [sp, 48]
	add	x29, sp, 48
	stp	x19, x20, [sp, 64]
	mov	x19, x0
	mov	w20, w2
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	stp	x21, x22, [sp, 80]
	mov	x22, x1
	bl	printf
	mov	w1, w20
	mov	x2, x19
	adrp	x0, .LC57
	add	x0, x0, :lo12:.LC57
	bl	printf
	adrp	x21, .LANCHOR0
	movi	v31.4s, 0
	mov	x0, 4200
	add	x0, sp, x0
	mov	x1, 4216
	mov	x2, 4248
	mov	x3, 4280
	mov	x4, 4312
	mov	x5, 4200
	str	q31, [x0]
	add	x0, sp, x1
	stp	q31, q31, [x0]
	add	x0, sp, x2
	stp	q31, q31, [x0]
	add	x0, sp, x3
	stp	q31, q31, [x0]
	add	x0, sp, x4
	stp	q31, q31, [x0]
	adrp	x0, chroot_signal_handler
	add	x0, x0, :lo12:chroot_signal_handler
	str	x0, [sp, 4192]
	add	x0, sp, x5
	bl	sigemptyset
	mov	x6, 4192
	mov	x2, 0
	add	x1, sp, x6
	mov	w0, 2
	bl	sigaction
	mov	x7, 4192
	mov	x2, 0
	add	x1, sp, x7
	mov	w0, 15
	bl	sigaction
	mov	x8, 4192
	add	x1, sp, x8
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	str	wzr, [x21, #:lo12:.LANCHOR0]
	bl	priv_prefix
	stp	x19, x19, [sp]
	mov	x9, 4192
	stp	x19, x19, [sp, 16]
	mov	x7, x19
	mov	x3, x0
	stp	x19, x19, [sp, 32]
	add	x0, sp, x9
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	mov	x1, 4096
	adrp	x2, .LC58
	add	x2, x2, :lo12:.LC58
	bl	xsnprintf
	mov	x10, 4192
	add	x0, sp, x10
	bl	run_cmd
	mov	w5, w20
	mov	w4, w20
	mov	x6, x22
	mov	x3, x19
	adrp	x2, .LC59
	add	x2, x2, :lo12:.LC59
	mov	x1, 4096
	add	x0, sp, 96
	bl	xsnprintf
	add	x0, sp, 96
	bl	run_cmd
	mov	w20, w0
	ldr	w0, [x21, #:lo12:.LANCHOR0]
	cbnz	w0, .L136
	cbnz	w20, .L137
	adrp	x0, .LC62
	add	x0, x0, :lo12:.LC62
	bl	printf
	ldp	x29, x30, [sp, 48]
	mov	w0, w20
	ldp	x19, x20, [sp, 64]
	mov	x12, 8288
	ldp	x21, x22, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L137:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w20
	adrp	x1, .LC61
	add	x1, x1, :lo12:.LC61
	ldr	x0, [x0]
	bl	fprintf
	ldp	x29, x30, [sp, 48]
	mov	w0, w20
	ldp	x19, x20, [sp, 64]
	mov	x12, 8288
	ldp	x21, x22, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L136:
	adrp	x0, .LC60
	add	x0, x0, :lo12:.LC60
	bl	printf
	mov	w20, 130
	mov	x0, x19
	bl	gentoo_chroot_unmount
	ldp	x29, x30, [sp, 48]
	mov	w0, w20
	ldp	x19, x20, [sp, 64]
	mov	x12, 8288
	ldp	x21, x22, [sp, 80]
	add	sp, sp, x12
	ret
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_run_portage
	.type	gentoo_chroot_run_portage, %function
gentoo_chroot_run_portage:
	cmp	x0, 0
	ccmp	x1, 0, 4, ne
	bne	.L140
	mov	w0, 1
	ret
	.p2align 2,,3
.L140:
	b	gentoo_chroot_run_portage.part.0
	.section	.rodata.str1.8
	.align	3
.LC63:
	.string	"%s/chroot-world/%s"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_manifest_exists
	.type	gentoo_chroot_manifest_exists, %function
gentoo_chroot_manifest_exists:
	cbz	x0, .L143
	sub	sp, sp, #672
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L151
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 672
	ret
	.p2align 2,,3
.L151:
	mov	x4, x19
	adrp	x3, .LC9
	adrp	x2, .LC63
	add	x3, x3, :lo12:.LC9
	add	x2, x2, :lo12:.LC63
	mov	x1, 640
	add	x0, sp, 32
	bl	xsnprintf
	add	x0, sp, 32
	bl	file_exists
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 672
	ret
	.p2align 2,,3
.L143:
	mov	w0, 0
	ret
	.section	.rodata.str1.8
	.align	3
.LC64:
	.string	"ls -1d '%s'/var/db/pkg/*/'%s'-[0-9]* 2>/dev/null | sort -V | tail -n1"
	.align	3
.LC65:
	.string	"\033[1;33m[!] No merged package found in the chroot database for '%s'; nothing was installed on the host.\n\033[0m"
	.align	3
.LC66:
	.string	"%s/CONTENTS"
	.align	3
.LC67:
	.string	"r"
	.align	3
.LC68:
	.string	"\033[1;31m[-] Chroot package %s has no CONTENTS manifest\n\033[0m"
	.align	3
.LC69:
	.string	"%s/chroot-world"
	.align	3
.LC70:
	.string	"%s.tmp.%ld"
	.align	3
.LC71:
	.string	"%s/.chroot-merge-%ld.sh"
	.align	3
.LC72:
	.string	"w"
	.align	3
.LC73:
	.string	"\033[1;31m[-] Cannot write chroot merge script\n\033[0m"
	.align	3
.LC74:
	.string	"obj "
	.align	3
.LC75:
	.string	"%1023s"
	.align	3
.LC76:
	.string	"dir "
	.align	3
.LC77:
	.string	"sym "
	.align	3
.LC78:
	.string	"->"
	.align	3
.LC79:
	.string	"/usr/"
	.align	3
.LC80:
	.string	"/usr/local%s"
	.align	3
.LC81:
	.string	"%s%s"
	.align	3
.LC82:
	.string	"%.*s"
	.align	3
.LC83:
	.string	"/"
	.align	3
.LC84:
	.string	"install -d %s && cp -a %s %s\n"
	.align	3
.LC85:
	.string	"obj %s\n"
	.align	3
.LC86:
	.string	"install -d %s && ln -sfn %s %s\n"
	.align	3
.LC87:
	.string	"sym %s\n"
	.align	3
.LC88:
	.string	"install -d %s\n"
	.align	3
.LC89:
	.string	"dir %s\n"
	.align	3
.LC90:
	.string	"%ssh %s"
	.align	3
.LC91:
	.string	"\033[1;31m[-] Imitation merge failed (exit %d); manifest discarded\n\033[0m"
	.align	3
.LC92:
	.string	"\033[1;33m[!] Could not register manifest %s\n\033[0m"
	.align	3
.LC93:
	.string	"\033[1;32m[+] Imitation merge: %d file(s), %d link(s), %d dir(s) installed under /usr/local (%d chroot-only entries skipped)\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_install_artifacts
	.type	gentoo_chroot_install_artifacts, %function
gentoo_chroot_install_artifacts:
	mov	x12, 22080
	sub	sp, sp, x12
	mov	x4, x1
	mov	x3, x0
	adrp	x2, .LC64
	add	x2, x2, :lo12:.LC64
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	mov	x1, 1024
	stp	x23, x24, [sp, 48]
	mov	x24, x0
	add	x0, sp, 4000
	bl	xsnprintf
	str	xzr, [sp, 144]
	add	x1, sp, 144
	add	x0, sp, 4000
	bl	run_cmd_capture
	ldr	x19, [sp, 144]
	cbnz	w0, .L153
	cbz	x19, .L153
	ldrb	w0, [x19]
	cbz	w0, .L153
	mov	x0, x19
	bl	strlen
	cbnz	x0, .L156
	b	.L157
	.p2align 2,,3
.L158:
	strb	wzr, [x19, x0]
	ldr	x19, [sp, 144]
	cbz	x0, .L157
.L156:
	sub	x0, x0, #1
	ldrb	w1, [x19, x0]
	cmp	w1, 10
	ccmp	w1, 13, 4, ne
	beq	.L158
.L157:
	mov	x15, 10680
	mov	x3, x19
	add	x0, sp, x15
	mov	x1, 1400
	adrp	x2, .LC66
	add	x2, x2, :lo12:.LC66
	bl	xsnprintf
	mov	x16, 10680
	adrp	x1, .LC67
	add	x0, sp, x16
	add	x1, x1, :lo12:.LC67
	bl	fopen
	mov	x19, x0
	cbz	x0, .L253
	adrp	x20, .LC9
	mov	x1, 640
	add	x3, x20, :lo12:.LC9
	add	x0, sp, 664
	adrp	x2, .LC69
	add	x2, x2, :lo12:.LC69
	bl	xsnprintf
	add	x3, sp, 664
	mov	x1, 640
	add	x0, sp, 1944
	adrp	x2, .LC4
	add	x2, x2, :lo12:.LC4
	bl	xsnprintf
	add	x3, x20, :lo12:.LC9
	mov	x4, x21
	adrp	x2, .LC63
	add	x2, x2, :lo12:.LC63
	mov	x1, 640
	add	x0, sp, 1944
	bl	xsnprintf
	bl	getpid
	sxtw	x4, w0
	add	x3, sp, 1944
	adrp	x2, .LC70
	add	x2, x2, :lo12:.LC70
	mov	x1, 648
	add	x0, sp, 2584
	bl	xsnprintf
	bl	getpid
	sxtw	x4, w0
	add	x3, x20, :lo12:.LC9
	adrp	x2, .LC71
	add	x2, x2, :lo12:.LC71
	mov	x1, 640
	add	x0, sp, 1304
	bl	xsnprintf
	adrp	x20, .LC72
	bl	priv_prefix
	mov	x3, x0
	add	x4, sp, 664
	adrp	x2, .LC14
	add	x2, x2, :lo12:.LC14
	mov	x1, 768
	add	x0, sp, 3232
	bl	xsnprintf
	add	x0, sp, 3232
	bl	run_cmd
	add	x1, x20, :lo12:.LC72
	add	x0, sp, 1304
	bl	fopen
	mov	x22, x0
	add	x1, x20, :lo12:.LC72
	add	x0, sp, 2584
	str	x22, [sp, 96]
	bl	fopen
	str	x0, [sp, 104]
	cmp	x22, 0
	ccmp	x0, 0, 4, ne
	beq	.L254
	mov	x8, 5024
	mov	w20, 25199
	mov	w22, 26980
	mov	w23, 31091
	adrp	x0, .LC78
	stp	x25, x26, [sp, 64]
	add	x26, sp, x8
	stp	x27, x28, [sp, 80]
	add	x28, x0, :lo12:.LC78
	movk	w20, 0x206a, lsl 16
	movk	w22, 0x2072, lsl 16
	movk	w23, 0x206d, lsl 16
	stp	wzr, wzr, [sp, 112]
	stp	wzr, wzr, [sp, 120]
	.p2align 5,,15
.L160:
	mov	x2, x19
	mov	x0, x26
	mov	w1, 1024
	bl	fgets
	cbz	x0, .L255
.L191:
	ldr	w0, [x26]
	strb	wzr, [sp, 152]
	cmp	w0, w20
	beq	.L256
	cmp	w0, w22
	beq	.L257
	cmp	w0, w23
	bne	.L160
	add	x25, x26, 4
	mov	x1, x28
	mov	x0, x25
	bl	strstr
	mov	x3, x0
	cbz	x0, .L160
	subs	x2, x0, x25
	bne	.L175
	b	.L176
	.p2align 2,,3
.L177:
	subs	x2, x2, #1
	beq	.L176
.L175:
	add	x0, x26, x2
	ldrb	w0, [x0, 3]
	cmp	w0, 32
	beq	.L177
	cmp	x2, 1023
	bhi	.L160
	.p2align 5,,15
.L176:
	mov	x12, 6048
	add	x25, sp, x12
	add	x1, x26, 4
	mov	x0, x25
	stp	x2, x3, [sp, 128]
	bl	memcpy
	ldp	x2, x3, [sp, 128]
	strb	wzr, [x25, x2]
	ldrb	w0, [x3, 2]
	add	x2, x3, 2
	cmp	w0, 32
	bne	.L178
	.p2align 5,,15
.L179:
	ldrb	w0, [x2, 1]!
	cmp	w0, 32
	beq	.L179
.L178:
	and	w3, w0, -33
	add	x4, sp, 152
	mov	x1, 0
	cbnz	w3, .L180
	b	.L181
	.p2align 2,,3
.L259:
	add	x1, x1, 1
	cmp	x1, 512
	beq	.L258
	add	x3, x4, x1
	strb	w0, [x3, -1]
	ldrb	w0, [x2, x1]
	and	w3, w0, -33
	cbz	w3, .L181
.L180:
	cmp	w0, 10
	bne	.L259
.L181:
	mov	w27, 1
	strb	wzr, [x4, x1]
	b	.L168
	.p2align 2,,3
.L153:
	mov	x0, x19
	bl	free
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC65
	mov	x2, x21
	add	x1, x1, :lo12:.LC65
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
.L152:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 22080
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L256:
	mov	x14, 6048
	add	x25, sp, x14
	adrp	x1, .LC75
	mov	x2, x25
	add	x1, x1, :lo12:.LC75
	add	x0, x26, 4
	mov	w27, 0
	bl	__isoc99_sscanf
	cmp	w0, 1
	bne	.L160
.L168:
	mov	x11, 6048
	add	x0, sp, x11
	ldrb	w0, [x0]
	cmp	w0, 47
	bne	.L160
	ldr	w1, [x25]
	mov	w0, 29999
	movk	w0, 0x7273, lsl 16
	cmp	w1, w0
	beq	.L260
.L183:
	ldr	w0, [sp, 112]
	mov	x2, x19
	mov	w1, 1024
	add	w0, w0, 1
	str	w0, [sp, 112]
	mov	x0, x26
	bl	fgets
	cbnz	x0, .L191
	.p2align 5,,15
.L255:
	mov	x0, x19
	bl	fclose
	ldr	x0, [sp, 96]
	bl	fclose
	ldr	x0, [sp, 104]
	bl	fclose
	ldr	x0, [sp, 144]
	bl	free
	mov	x7, 19480
	add	x0, sp, 1304
	add	x1, sp, x7
	mov	x2, 1600
	bl	shell_quote
	mov	w19, w0
	cbz	w0, .L261
	bl	priv_prefix
	mov	x3, x0
	mov	x5, 16880
	mov	x1, 19480
	add	x0, sp, x5
	add	x4, sp, x1
	adrp	x2, .LC90
	mov	x1, 1400
	add	x2, x2, :lo12:.LC90
	bl	xsnprintf
	mov	x6, 16880
	add	x0, sp, x6
	bl	run_cmd
	mov	w19, w0
	add	x0, sp, 1304
	bl	unlink
	cbnz	w19, .L262
	add	x0, sp, 1944
	bl	unlink
	add	x1, sp, 1944
	add	x0, sp, 2584
	bl	rename
	cbnz	w0, .L263
.L194:
	ldp	w4, w3, [sp, 112]
	adrp	x0, .LC93
	ldp	w1, w2, [sp, 120]
	add	x0, x0, :lo12:.LC93
	mov	w19, 1
	bl	printf
	mov	x0, x21
	bl	add_to_world
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x25, x26, [sp, 64]
	mov	x12, 22080
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L257:
	mov	x13, 6048
	add	x25, sp, x13
	mov	x2, x25
	add	x0, x26, 4
	adrp	x1, .LC75
	mov	w27, 2
	add	x1, x1, :lo12:.LC75
	bl	__isoc99_sscanf
	cmp	w0, 1
	beq	.L168
	b	.L160
	.p2align 2,,3
.L262:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC91
	add	x1, x1, :lo12:.LC91
	mov	w19, 0
	ldr	x0, [x0]
	bl	fprintf
	add	x0, sp, 2584
	bl	unlink
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L152
	.p2align 2,,3
.L261:
	add	x0, sp, 2584
	bl	unlink
	add	x0, sp, 1304
	bl	unlink
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x25, x26, [sp, 64]
	mov	x12, 22080
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L260:
	ldrb	w0, [x25, 4]
	cmp	w0, 47
	bne	.L183
	mov	x7, 7072
	add	x3, x25, 4
	add	x0, sp, x7
	mov	x1, 1152
	adrp	x2, .LC80
	add	x2, x2, :lo12:.LC80
	bl	xsnprintf
	mov	x8, 9376
	mov	x1, 1300
	mov	x4, x25
	mov	x3, x24
	add	x0, sp, x8
	adrp	x2, .LC81
	add	x2, x2, :lo12:.LC81
	bl	xsnprintf
	mov	x9, 16880
	mov	x10, 9376
	add	x1, sp, x9
	add	x0, sp, x10
	mov	x2, 2600
	bl	shell_quote
	cbz	w0, .L160
	mov	x5, 12080
	mov	x6, 7072
	add	x1, sp, x5
	add	x0, sp, x6
	mov	x2, 2400
	bl	shell_quote
	cbz	w0, .L160
	mov	x2, 7072
	add	x0, sp, x2
	bl	strlen
	mov	x3, x0
	mov	x4, 7072
	add	x5, sp, x4
	.p2align 5,,15
.L187:
	cbz	x3, .L186
	sub	x0, x3, #1
	ldrb	w1, [x5, x0]
	cmp	w1, 47
	beq	.L264
	mov	x3, x0
	b	.L187
.L263:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	add	x2, sp, 1944
	adrp	x1, .LC92
	add	x1, x1, :lo12:.LC92
	ldr	x0, [x0]
	bl	fprintf
	b	.L194
.L258:
	mov	x1, 511
	b	.L181
.L264:
	cmp	x3, 1
	beq	.L186
	mov	x1, 8224
	add	x25, sp, x1
	adrp	x2, .LC82
	mov	x4, x5
	add	x2, x2, :lo12:.LC82
	mov	x0, x25
	mov	x1, 1152
	bl	xsnprintf
.L188:
	mov	x30, 14480
	mov	x0, x25
	add	x1, sp, x30
	mov	x2, 2400
	bl	shell_quote
	cbz	w0, .L160
	cbz	w27, .L265
	cmp	w27, 1
	beq	.L266
	ldr	x0, [sp, 96]
	mov	x9, 12080
	adrp	x1, .LC88
	add	x2, sp, x9
	add	x1, x1, :lo12:.LC88
	bl	fprintf
	ldr	x0, [sp, 104]
	mov	x10, 7072
	adrp	x1, .LC89
	add	x2, sp, x10
	add	x1, x1, :lo12:.LC89
	bl	fprintf
	ldr	w0, [sp, 116]
	add	w0, w0, 1
	str	w0, [sp, 116]
	b	.L160
.L186:
	mov	x0, 8224
	add	x25, sp, x0
	mov	x0, x25
	adrp	x2, .LC83
	mov	x1, 1152
	add	x2, x2, :lo12:.LC83
	bl	xsnprintf
	b	.L188
.L265:
	ldr	x0, [sp, 96]
	mov	x16, 12080
	mov	x17, 16880
	mov	x18, 14480
	add	x4, sp, x16
	add	x2, sp, x18
	add	x3, sp, x17
	adrp	x1, .LC84
	add	x1, x1, :lo12:.LC84
	bl	fprintf
	ldr	x0, [sp, 104]
	mov	x25, 7072
	adrp	x1, .LC85
	add	x2, sp, x25
	add	x1, x1, :lo12:.LC85
	bl	fprintf
	ldr	w0, [sp, 120]
	add	w0, w0, 1
	str	w0, [sp, 120]
	b	.L160
.L266:
	mov	x15, 19480
	add	x0, sp, 152
	add	x1, sp, x15
	mov	x2, 2600
	bl	shell_quote
	cbz	w0, .L160
	ldr	x0, [sp, 96]
	mov	x11, 12080
	mov	x12, 19480
	mov	x13, 14480
	add	x4, sp, x11
	add	x2, sp, x13
	add	x3, sp, x12
	adrp	x1, .LC86
	add	x1, x1, :lo12:.LC86
	bl	fprintf
	ldr	x0, [sp, 104]
	mov	x14, 7072
	adrp	x1, .LC87
	add	x2, sp, x14
	add	x1, x1, :lo12:.LC87
	bl	fprintf
	ldr	w0, [sp, 124]
	add	w0, w0, 1
	str	w0, [sp, 124]
	b	.L160
.L253:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC68
	ldr	x2, [sp, 144]
	add	x1, x1, :lo12:.LC68
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 144]
	bl	free
	b	.L152
.L254:
	ldr	x0, [sp, 96]
	cbz	x0, .L161
	bl	fclose
.L161:
	ldr	x0, [sp, 104]
	cbz	x0, .L162
	bl	fclose
.L162:
	mov	x0, x19
	bl	fclose
	ldr	x0, [sp, 144]
	mov	w19, 0
	bl	free
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 48
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC73
	add	x0, x0, :lo12:.LC73
	bl	fwrite
	b	.L152
	.section	.rodata.str1.8
	.align	3
.LC94:
	.string	"%s/.chroot-unmerge-%ld.sh"
	.align	3
.LC95:
	.string	"%7s %1100[^\n]"
	.align	3
.LC96:
	.string	"/usr/local"
	.align	3
.LC97:
	.string	"rmdir --ignore-fail-on-non-empty -p %s 2>/dev/null; true\n"
	.align	3
.LC98:
	.string	"rm -f %s\n"
	.align	3
.LC99:
	.string	"\033[1;31m[-] Chroot manifest removal failed (exit %d)\n\033[0m"
	.align	3
.LC100:
	.string	"%srm -f '%s'"
	.align	3
.LC101:
	.string	"\033[1;32m[+] Removed %d manifest entr(ies) from /usr/local\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_unmerge
	.type	gentoo_chroot_unmerge, %function
gentoo_chroot_unmerge:
	mov	x12, 7280
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	cbz	x0, .L268
	mov	x20, x0
	bl	valid_pkgname
	mov	w19, w0
	cbnz	w0, .L299
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 7280
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L299:
	mov	x4, x20
	adrp	x19, .LC9
	adrp	x2, .LC63
	add	x3, x19, :lo12:.LC9
	add	x2, x2, :lo12:.LC63
	mov	x1, 640
	add	x0, sp, 80
	bl	xsnprintf
	add	x0, sp, 80
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	fopen
	mov	x20, x0
	cbz	x0, .L268
	stp	x21, x22, [sp, 32]
	bl	getpid
	add	x3, x19, :lo12:.LC9
	sxtw	x4, w0
	adrp	x2, .LC94
	add	x2, x2, :lo12:.LC94
	mov	x1, 640
	add	x0, sp, 720
	bl	xsnprintf
	add	x0, sp, 720
	adrp	x1, .LC72
	add	x1, x1, :lo12:.LC72
	bl	fopen
	mov	x22, x0
	cbz	x0, .L300
	adrp	x21, .LC95
	adrp	x0, .LC96
	add	x21, x21, :lo12:.LC95
	stp	x23, x24, [sp, 48]
	add	x24, x0, :lo12:.LC96
	mov	w23, 0
	.p2align 5,,15
.L270:
	mov	x2, x20
	add	x0, sp, 2128
	mov	w1, 1152
	bl	fgets
	cbz	x0, .L301
.L278:
	add	x19, sp, 3280
	add	x2, sp, 1360
	mov	x3, x19
	mov	x1, x21
	add	x0, sp, 2128
	bl	__isoc99_sscanf
	cmp	w0, 2
	bne	.L270
	mov	x0, x19
	bl	strlen
	mov	x4, x0
	cbnz	x0, .L273
	b	.L270
	.p2align 2,,3
.L275:
	strb	wzr, [x1, -1]
	subs	x4, x4, #1
	beq	.L270
.L273:
	add	x1, x19, x4
	ldrb	w0, [x1, -1]
	cmp	w0, 10
	ccmp	w0, 13, 4, ne
	beq	.L275
	mov	x1, x24
	mov	x0, x19
	mov	x2, 10
	str	x4, [sp, 72]
	bl	strncmp
	cmp	w0, 0
	ldr	x4, [sp, 72]
	ccmp	x4, 11, 0, eq
	bls	.L270
	mov	x5, 4680
	mov	x0, x19
	add	x1, sp, x5
	mov	x2, 2600
	bl	shell_quote
	cbz	w0, .L270
	ldrb	w0, [sp, 1360]
	mov	x4, 4680
	add	x2, sp, x4
	cmp	w0, 100
	beq	.L302
	add	w23, w23, 1
	mov	x0, x22
	adrp	x1, .LC98
	add	x1, x1, :lo12:.LC98
	bl	fprintf
.L305:
	mov	x2, x20
	add	x0, sp, 2128
	mov	w1, 1152
	bl	fgets
	cbnz	x0, .L278
	.p2align 5,,15
.L301:
	mov	x0, x20
	bl	fclose
	mov	x0, x22
	bl	fclose
	mov	x3, 4680
	add	x0, sp, 720
	add	x1, sp, x3
	mov	x2, 1600
	bl	shell_quote
	mov	w19, w0
	cbz	w0, .L303
	bl	priv_prefix
	mov	x3, x0
	mov	x1, 4680
	adrp	x2, .LC90
	add	x4, sp, x1
	add	x2, x2, :lo12:.LC90
	mov	x1, 1400
	add	x0, sp, 3280
	bl	xsnprintf
	add	x0, sp, 3280
	bl	run_cmd
	mov	w19, w0
	add	x0, sp, 720
	bl	unlink
	cbnz	w19, .L304
	bl	priv_prefix
	mov	x3, x0
	add	x4, sp, 80
	adrp	x2, .LC100
	add	x2, x2, :lo12:.LC100
	mov	x1, 768
	add	x0, sp, 1360
	bl	xsnprintf
	add	x0, sp, 1360
	mov	w19, 1
	bl	run_cmd
	mov	w1, w23
	adrp	x0, .LC101
	add	x0, x0, :lo12:.LC101
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	mov	x12, 7280
	ldp	x23, x24, [sp, 48]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L304:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	.p2align 5,,15
.L268:
	mov	w19, 0
.L306:
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	mov	x12, 7280
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L303:
	add	x0, sp, 720
	bl	unlink
	ldp	x29, x30, [sp]
	mov	w0, w19
	ldp	x21, x22, [sp, 32]
	mov	x12, 7280
	ldp	x23, x24, [sp, 48]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
.L302:
	mov	x0, x22
	adrp	x1, .LC97
	add	w23, w23, 1
	add	x1, x1, :lo12:.LC97
	bl	fprintf
	b	.L305
.L300:
	mov	x0, x20
	mov	w19, 0
	bl	fclose
	ldp	x21, x22, [sp, 32]
	b	.L306
	.section	.rodata.str1.8
	.align	3
.LC102:
	.string	"/usr/local/emerge/gentoo-chroot"
	.align	3
.LC103:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC104:
	.string	"\033[1;32m>>> Emerging %s\n\033[0m"
	.align	3
.LC105:
	.string	"\033[1;31m[-] Failed to init Gentoo chroot\n\033[0m"
	.align	3
.LC106:
	.string	"\033[1;32m\n>>> Completed %s\n\033[0m"
	.align	3
.LC107:
	.string	"\033[1;33m[!] Build interrupted, chroot cleaned up\n\033[0m"
	.align	3
.LC108:
	.string	"\033[1;31m[-] Imitation build failed\n\033[0m"
	.align	3
.LC109:
	.string	"\033[1;33m    Tip: try manual fix: sudo chroot %s emerge --sync && sudo chroot %s eselect profile set 1\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_gentoo_imitation_build
	.type	cmd_gentoo_imitation_build, %function
cmd_gentoo_imitation_build:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	str	x21, [sp, 32]
	mov	x21, x0
	bl	valid_pkgname
	cbz	w0, .L323
	bl	get_gentoo_chroot_path
	mov	x19, x0
	cbz	x0, .L321
	ldrb	w0, [x0]
	cbnz	w0, .L310
.L321:
	adrp	x19, .LC102
	add	x19, x19, :lo12:.LC102
.L310:
	mov	x1, x21
	adrp	x0, .LC104
	add	x0, x0, :lo12:.LC104
	bl	printf
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L311
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	adrp	x1, .LC51
	mov	x2, x19
	add	x1, x1, :lo12:.LC51
	ldr	x0, [x20]
	bl	fprintf
.L312:
	ldr	x3, [x20]
	adrp	x0, .LC105
	mov	x2, 44
	add	x0, x0, :lo12:.LC105
	mov	x1, 1
	bl	fwrite
.L319:
	mov	w20, 0
	mov	w0, w20
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L323:
	mov	w20, w0
	mov	x2, x21
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC103
	add	x1, x1, :lo12:.LC103
	ldr	x0, [x0]
	bl	fprintf
	ldr	x21, [sp, 32]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L311:
	mov	x0, x19
	bl	gentoo_chroot_init.part.0
	cbz	w0, .L324
	mov	x0, x19
	bl	gentoo_chroot_mount.part.0
	bl	get_jobs
	cbnz	x21, .L314
	mov	x0, x19
	bl	gentoo_chroot_unmount
.L315:
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	mov	x2, 38
	mov	x1, 1
	adrp	x0, .LC108
	add	x0, x0, :lo12:.LC108
	ldr	x3, [x20]
	bl	fwrite
	ldr	x0, [x20]
	mov	x3, x19
	mov	x2, x19
	adrp	x1, .LC109
	add	x1, x1, :lo12:.LC109
	bl	fprintf
	b	.L319
	.p2align 2,,3
.L314:
	mov	w2, w0
	mov	x1, x21
	mov	x0, x19
	bl	gentoo_chroot_run_portage.part.0
	mov	w20, w0
	cbz	w0, .L325
	mov	x0, x19
	bl	gentoo_chroot_unmount
	cmp	w20, 130
	bne	.L315
	adrp	x0, .LC107
	add	x0, x0, :lo12:.LC107
	bl	printf
	b	.L319
	.p2align 2,,3
.L325:
	mov	x1, x21
	mov	x0, x19
	bl	gentoo_chroot_install_artifacts
	mov	w20, w0
	mov	x0, x19
	cbnz	w20, .L317
	bl	gentoo_chroot_unmount
	b	.L315
	.p2align 2,,3
.L317:
	bl	gentoo_chroot_unmount
	mov	x1, x21
	adrp	x0, .LC106
	add	x0, x0, :lo12:.LC106
	bl	printf
	ldr	x21, [sp, 32]
	mov	w0, w20
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L324:
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	b	.L312
	.bss
	.align	4
	.set	.LANCHOR0,. + 0
	.type	g_chroot_interrupted, %object
g_chroot_interrupted:
	.zero	4
	.zero	12
	.type	g_chroot_path_store, %object
g_chroot_path_store:
	.zero	512
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
