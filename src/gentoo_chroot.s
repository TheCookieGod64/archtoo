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
	.string	"/usr/local/emerge/gentoo-chroot"
	.align	3
.LC64:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC65:
	.string	"\033[1;32m>>> Emerging %s\n\033[0m"
	.align	3
.LC66:
	.string	"\033[1;31m[-] Failed to init Gentoo chroot\n\033[0m"
	.align	3
.LC67:
	.string	"\033[1;34m>>> Copying artifacts...\n\033[0m"
	.align	3
.LC68:
	.string	"%sls '%s/%s/' 2>/dev/null; echo '>>> Binary backup currently at %s/%s'; mkdir -p '%s/var/cache/binpkgs' 2>/dev/null; cp -a '%s/%s/'*.pkg.tar.* '%s/var/cache/binpkgs/' 2>/dev/null; echo '>>> Copied Arch binaries into Gentoo chroot binpkgs (imitation)'; true"
	.align	3
.LC69:
	.string	"\033[1;32m\n>>> Completed %s\n\033[0m"
	.align	3
.LC70:
	.string	"\033[1;33m[!] Build interrupted, chroot cleaned up\n\033[0m"
	.align	3
.LC71:
	.string	"\033[1;31m[-] Imitation build failed\n\033[0m"
	.align	3
.LC72:
	.string	"\033[1;33m    Tip: try manual fix: sudo chroot %s emerge --sync && sudo chroot %s eselect profile set 1\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_gentoo_imitation_build
	.type	cmd_gentoo_imitation_build, %function
cmd_gentoo_imitation_build:
	sub	sp, sp, #2144
	stp	x29, x30, [sp, 32]
	add	x29, sp, 32
	stp	x19, x20, [sp, 48]
	str	x21, [sp, 64]
	mov	x21, x0
	bl	valid_pkgname
	cbz	w0, .L156
	bl	get_gentoo_chroot_path
	mov	x19, x0
	cbz	x0, .L154
	ldrb	w0, [x0]
	cbnz	w0, .L144
.L154:
	adrp	x19, .LC63
	add	x19, x19, :lo12:.LC63
.L144:
	mov	x1, x21
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L145
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	adrp	x1, .LC51
	mov	x2, x19
	add	x1, x1, :lo12:.LC51
	ldr	x0, [x20]
	bl	fprintf
.L146:
	ldr	x3, [x20]
	adrp	x0, .LC66
	mov	x2, 44
	add	x0, x0, :lo12:.LC66
	mov	x1, 1
	bl	fwrite
.L152:
	mov	w20, 0
	mov	w0, w20
	ldr	x21, [sp, 64]
	ldp	x29, x30, [sp, 32]
	ldp	x19, x20, [sp, 48]
	add	sp, sp, 2144
	ret
	.p2align 2,,3
.L156:
	mov	w20, w0
	mov	x2, x21
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	ldr	x0, [x0]
	bl	fprintf
	ldr	x21, [sp, 64]
	mov	w0, w20
	ldp	x29, x30, [sp, 32]
	ldp	x19, x20, [sp, 48]
	add	sp, sp, 2144
	ret
	.p2align 2,,3
.L145:
	mov	x0, x19
	bl	gentoo_chroot_init.part.0
	mov	w20, w0
	cbz	w0, .L157
	mov	x0, x19
	bl	gentoo_chroot_mount.part.0
	bl	get_jobs
	cbnz	x21, .L148
	mov	x0, x19
	bl	gentoo_chroot_unmount
.L149:
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	mov	x2, 38
	mov	x1, 1
	adrp	x0, .LC71
	add	x0, x0, :lo12:.LC71
	ldr	x3, [x20]
	bl	fwrite
	ldr	x0, [x20]
	mov	x3, x19
	mov	x2, x19
	adrp	x1, .LC72
	add	x1, x1, :lo12:.LC72
	bl	fprintf
	b	.L152
	.p2align 2,,3
.L148:
	mov	x1, x21
	mov	w2, w0
	mov	x0, x19
	bl	gentoo_chroot_run_portage.part.0
	mov	w1, w0
	cbz	w0, .L150
	mov	x0, x19
	str	w1, [sp, 92]
	bl	gentoo_chroot_unmount
	ldr	w1, [sp, 92]
	cmp	w1, 130
	bne	.L149
	adrp	x0, .LC70
	add	x0, x0, :lo12:.LC70
	bl	printf
	b	.L152
	.p2align 2,,3
.L150:
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	adrp	x6, .LC8
	add	x6, x6, :lo12:.LC8
	mov	x7, x21
	mov	x5, x21
	mov	x4, x6
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
	stp	x19, x6, [sp]
	mov	x1, 2048
	stp	x21, x19, [sp, 16]
	add	x0, sp, 96
	bl	xsnprintf
	add	x0, sp, 96
	bl	run_cmd
	mov	x0, x19
	bl	gentoo_chroot_unmount
	mov	x1, x21
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	printf
	ldr	x21, [sp, 64]
	mov	w0, w20
	ldp	x29, x30, [sp, 32]
	ldp	x19, x20, [sp, 48]
	add	sp, sp, 2144
	ret
	.p2align 2,,3
.L157:
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	b	.L146
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
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
