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
	.string	"\033[1;34m>>> Mounting chroot...\n\033[0m"
	.align	3
.LC1:
	.string	"%s"
	.align	3
.LC2:
	.ascii	"%smount -t proc proc '%s/proc' 2>/dev/null; mount --rbind /s"
	.ascii	"ys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev"
	.ascii	"/null; mount --rbind /dev '%s/dev' 2>/dev/null; mount --make"
	.ascii	"-rslave '%s/dev' 2>/dev/null; mount --rbind /run '%s/run' 2>"
	.ascii	"/dev/null; mount --make-rslave '%s/run' 2>/d"
	.string	"ev/null; mount -t tmpfs tmpfs '%s/tmp' 2>/dev/null; mkdir -p '%s/%s' '%s/%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mount --bind '%s' '%s/%s' 2>/dev/null; mkdir -p '%s/%s' && touch '%s/%s' && mount --bind '%s' '%s/%s' 2>/dev/null; true"
	.align	3
.LC3:
	.string	"/usr/local/emerge/world"
	.align	3
.LC4:
	.string	"/usr/local/emerge/backups"
	.align	3
.LC5:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC6:
	.string	"/usr/local/emerge"
	.align	3
.LC7:
	.string	"\033[1;33m[!] Some mounts failed (maybe already mounted or no permission), continuing\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.type	gentoo_chroot_mount.part.0, %function
gentoo_chroot_mount.part.0:
	mov	x12, 4320
	sub	sp, sp, x12
	adrp	x1, .LC0
	stp	x29, x30, [sp, 192]
	add	x29, sp, 192
	stp	x19, x20, [sp, 208]
	mov	x19, x0
	add	x0, x1, :lo12:.LC0
	bl	printf
	add	x20, sp, 224
	mov	x3, x19
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	mov	x1, 512
	adrp	x0, .LANCHOR0
	add	x0, x0, :lo12:.LANCHOR0
	add	x0, x0, 16
	bl	xsnprintf
	bl	priv_prefix
	mov	x3, x0
	adrp	x9, .LC4
	adrp	x10, .LC5
	add	x9, x9, :lo12:.LC4
	add	x10, x10, :lo12:.LC5
	adrp	x8, .LC3
	add	x8, x8, :lo12:.LC3
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	adrp	x1, .LC6
	adrp	x2, .LC2
	add	x1, x1, :lo12:.LC6
	add	x2, x2, :lo12:.LC2
	stp	x19, x19, [sp]
	mov	x0, x20
	stp	x19, x19, [sp, 16]
	stp	x19, x10, [sp, 32]
	stp	x19, x9, [sp, 48]
	stp	x19, x1, [sp, 64]
	mov	x1, 4096
	stp	x10, x19, [sp, 80]
	stp	x10, x9, [sp, 96]
	stp	x19, x9, [sp, 112]
	stp	x19, x8, [sp, 128]
	stp	x19, x8, [sp, 144]
	stp	x8, x19, [sp, 160]
	str	x8, [sp, 176]
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbnz	w0, .L9
	ldp	x29, x30, [sp, 192]
	mov	w0, 1
	ldp	x19, x20, [sp, 208]
	mov	x12, 4320
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L9:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 87
	mov	x1, 1
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	ldr	x3, [x3]
	bl	fwrite
	ldp	x29, x30, [sp, 192]
	mov	w0, 1
	ldp	x19, x20, [sp, 208]
	mov	x12, 4320
	add	sp, sp, x12
	ret
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"%s/etc/gentoo-release"
	.align	3
.LC9:
	.string	"%s/etc/os-release"
	.align	3
.LC10:
	.string	"grep -q Gentoo '%s' 2>/dev/null"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_exists
	.type	gentoo_chroot_exists, %function
gentoo_chroot_exists:
	cbz	x0, .L24
	sub	sp, sp, #2208
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	ldrb	w0, [x0]
	cbnz	w0, .L25
.L13:
	mov	w0, 0
.L10:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, 2208
	ret
	.p2align 2,,3
.L25:
	mov	x3, x19
	adrp	x2, .LC8
	add	x2, x2, :lo12:.LC8
	mov	x1, 1024
	add	x20, sp, 32
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	file_exists
	mov	w1, w0
	mov	w0, 1
	cbnz	w1, .L10
	mov	x3, x19
	adrp	x2, .LC9
	add	x2, x2, :lo12:.LC9
	mov	x1, 1024
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	file_exists
	cbz	w0, .L13
	mov	x3, x20
	adrp	x2, .LC10
	add	x2, x2, :lo12:.LC10
	add	x19, sp, 1056
	mov	x1, 1150
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd_quiet
	cmp	w0, 0
	cset	w0, eq
	b	.L10
	.p2align 2,,3
.L24:
	mov	w0, 0
	ret
	.section	.rodata.str1.8
	.align	3
.LC11:
	.string	"(null)"
	.align	3
.LC12:
	.string	"root"
	.align	3
.LC13:
	.string	"\033[1;31m[-] Invalid chroot path: %s\n\033[0m"
	.align	3
.LC14:
	.string	"\033[1;32m[+] Gentoo chroot already exists at %s (persistent mode)\n\033[0m"
	.align	3
.LC15:
	.string	"\033[1;36m>>> Initializing chroot at %s...\n\033[0m"
	.align	3
.LC16:
	.string	"%smkdir -p '%s'"
	.align	3
.LC17:
	.string	"\033[1;31m[-] Cannot create chroot dir %s\n\033[0m"
	.align	3
.LC18:
	.string	"\033[1;34m>>> Fetching latest Gentoo stage3 URL...\n\033[0m"
	.align	3
.LC19:
	.string	"curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt 2>/dev/null | grep -E 'stage3-amd64-openrc.*\\.tar\\.xz' | grep -v '^#' | grep -v 'BEGIN' | head -n1 | awk '{print $1}'"
	.align	3
.LC20:
	.string	"BEGIN"
	.align	3
.LC21:
	.string	".tar"
	.align	3
.LC22:
	.string	"https://"
	.align	3
.LC23:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/%s"
	.align	3
.LC24:
	.string	"\033[1;32m[+] Latest stage3: %s\n\033[0m"
	.align	3
.LC25:
	.string	"\033[1;33m[!] Could not fetch latest list, using fallback\n\033[0m"
	.align	3
.LC26:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/stage3-amd64-openrc-latest.tar.xz"
	.align	3
.LC27:
	.string	"curl -fsI '%s' >/dev/null 2>&1 && echo ok || echo fail"
	.align	3
.LC28:
	.string	"ok"
	.align	3
.LC29:
	.string	"\033[1;33m[!] Fallback not reachable, trying alt\n\033[0m"
	.align	3
.LC30:
	.string	"curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/ 2>/dev/null | grep -oE 'stage3-amd64-openrc-[0-9TZ]+\\.tar\\.xz' | head -n1"
	.align	3
.LC31:
	.string	".tar.xz"
	.align	3
.LC32:
	.string	"https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/%s"
	.align	3
.LC33:
	.string	"\033[1;32m[+] Alternative stage3: %s\n\033[0m"
	.align	3
.LC34:
	.string	"/tmp/gentoo-stage3-%ld.tar.xz"
	.align	3
.LC35:
	.string	"\033[1;34m>>> Downloading stage3 (this may take a while)...\n\033[0m"
	.align	3
.LC36:
	.string	"curl -fL -o '%s' '%s' || wget -O '%s' '%s'"
	.align	3
.LC37:
	.string	"\033[1;31m[-] Failed to download stage3 from %s\n\033[0m"
	.align	3
.LC38:
	.string	"\033[1;33m    Try manually: curl -o %s %s\n\033[0m"
	.align	3
.LC39:
	.string	"\033[1;34m>>> Extracting stage3 to %s...\n\033[0m"
	.align	3
.LC40:
	.string	"%star -xpf '%s' -C '%s' --xattrs-include='*.*' --numeric-owner 2>&1 | head -n 20"
	.align	3
.LC41:
	.string	"rm -f '%s'"
	.align	3
.LC42:
	.string	"\033[1;31m[-] Failed to extract stage3\n\033[0m"
	.align	3
.LC43:
	.string	"\033[1;34m>>> Setting up chroot basics...\n\033[0m"
	.align	3
.LC44:
	.string	"%smkdir -p '%s/proc' '%s/sys' '%s/dev' '%s/tmp' '%s/run' '%s/%s' '%s/%s' '%s/var/db/repos/gentoo' && %scp -L /etc/resolv.conf '%s/etc/resolv.conf' 2>/dev/null; %schown -R '%s' '%s' 2>/dev/null; true"
	.align	3
.LC45:
	.string	"\033[1;34m>>> Fixing Portage profile and repos...\n\033[0m"
	.align	3
.LC46:
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
.LC47:
	.string	"\033[1;34m>>> Syncing Gentoo repos inside chroot (emerge-webrsync fallback)...\n\033[0m"
	.align	3
.LC48:
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
.LC49:
	.string	"\033[1;33m[!] Chroot init finished but gentoo-release not found, may still work\n\033[0m"
	.align	3
.LC50:
	.string	"\033[1;32m[+] Gentoo chroot initialized at %s\n\033[0m"
	.align	3
.LC51:
	.string	"\033[1;33m[!] If repo still fails, run manually: sudo chroot %s emerge --sync\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_init
	.type	gentoo_chroot_init, %function
gentoo_chroot_init:
	mov	x12, 6512
	sub	sp, sp, x12
	stp	x29, x30, [sp, 96]
	add	x29, sp, 96
	stp	x19, x20, [sp, 112]
	cbz	x0, .L91
	mov	x19, x0
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L29
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	ldr	x0, [x0]
.L28:
	adrp	x1, .LC13
	mov	x2, x19
	add	x1, x1, :lo12:.LC13
	bl	fprintf
.L30:
	ldp	x29, x30, [sp, 96]
	mov	w0, 0
	ldp	x19, x20, [sp, 112]
	mov	x12, 6512
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L29:
	mov	x0, x19
	bl	gentoo_chroot_exists
	cbnz	w0, .L92
	mov	x1, x19
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	printf
	add	x20, sp, 2416
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	mov	x1, 4096
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbnz	w0, .L93
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	stp	x21, x22, [sp, 128]
	add	x22, sp, 192
	stp	x23, x24, [sp, 144]
	bl	printf
	add	x1, sp, 168
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	str	xzr, [sp, 168]
	bl	run_cmd_capture
	mov	x2, 1024
	mov	w23, w0
	mov	w1, 0
	mov	x0, x22
	bl	memset
	ldr	x21, [sp, 168]
	cbnz	w23, .L89
	cbz	x21, .L36
	ldrb	w0, [x21]
	cbz	w0, .L89
	mov	x1, 9728
	movk	x1, 0x1, lsl 32
	.p2align 5,,15
.L37:
	cmp	w0, 32
	bhi	.L38
	lsr	x0, x1, x0
	tbz	x0, 0, .L38
	ldrb	w0, [x21, 1]!
	cbnz	w0, .L37
.L38:
	mov	x0, x21
	bl	strlen
	mov	x2, 9728
	movk	x2, 0x1, lsl 32
	cbz	x0, .L41
	.p2align 5,,15
.L40:
	sub	x0, x0, #1
	ldrb	w1, [x21, x0]
	cmp	w1, 32
	bhi	.L41
	lsr	x1, x2, x1
	tbz	x1, 0, .L41
	strb	wzr, [x21, x0]
	cbnz	x0, .L40
.L41:
	adrp	x1, .LC20
	mov	x0, x21
	add	x1, x1, :lo12:.LC20
	bl	strstr
	cbz	x0, .L44
.L45:
	ldr	x0, [sp, 168]
	bl	free
	str	xzr, [sp, 168]
	b	.L36
	.p2align 2,,3
.L91:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x19, .LC11
	add	x19, x19, :lo12:.LC11
	ldr	x0, [x0]
	b	.L28
	.p2align 2,,3
.L93:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC17
	add	x1, x1, :lo12:.LC17
	ldr	x0, [x0]
	bl	fprintf
	b	.L30
	.p2align 2,,3
.L89:
	mov	x0, x21
	bl	free
	str	xzr, [sp, 168]
.L36:
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	printf
	add	x21, sp, 1216
	mov	x1, 1024
	mov	x0, x22
	adrp	x2, .LC26
	add	x2, x2, :lo12:.LC26
	bl	xsnprintf
	mov	x3, x22
	adrp	x2, .LC27
	add	x2, x2, :lo12:.LC27
	mov	x1, 1200
	mov	x0, x21
	bl	xsnprintf
	add	x1, sp, 176
	mov	x0, x21
	str	xzr, [sp, 176]
	bl	run_cmd_capture
	ldr	x23, [sp, 176]
	cbz	w0, .L94
.L49:
	mov	x0, x23
	bl	free
	adrp	x0, .LC29
	add	x0, x0, :lo12:.LC29
	bl	printf
	str	xzr, [sp, 184]
	add	x1, sp, 184
	adrp	x0, .LC30
	add	x0, x0, :lo12:.LC30
	bl	run_cmd_capture
	ldr	x23, [sp, 184]
	mov	x24, x23
	cbnz	w0, .L52
	cbz	x23, .L52
	ldrb	w0, [x23]
	cbz	w0, .L52
	mov	x0, x23
	mov	w1, 10
	bl	strchr
	cbz	x0, .L54
	strb	wzr, [x0]
	ldr	x23, [sp, 184]
.L54:
	adrp	x1, .LC31
	mov	x24, x23
	mov	x0, x23
	add	x1, x1, :lo12:.LC31
	bl	strstr
	cbz	x0, .L52
	mov	x3, x23
	adrp	x2, .LC32
	add	x2, x2, :lo12:.LC32
	mov	x1, 1024
	mov	x0, x22
	bl	xsnprintf
	mov	x1, x22
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	printf
	ldr	x24, [sp, 184]
	.p2align 5,,15
.L52:
	mov	x0, x24
	bl	free
.L48:
	bl	getpid
	sxtw	x3, w0
	adrp	x2, .LC34
	add	x2, x2, :lo12:.LC34
	mov	x1, 512
	mov	x0, x21
	bl	xsnprintf
	adrp	x0, .LC35
	add	x0, x0, :lo12:.LC35
	bl	printf
	mov	x6, x22
	mov	x5, x21
	mov	x4, x22
	mov	x3, x21
	adrp	x2, .LC36
	add	x2, x2, :lo12:.LC36
	mov	x1, 4096
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	cbnz	w0, .L95
	mov	x1, x19
	adrp	x0, .LC39
	add	x0, x0, :lo12:.LC39
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x21
	mov	x5, x19
	adrp	x2, .LC40
	add	x2, x2, :lo12:.LC40
	mov	x1, 4096
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	x3, x21
	adrp	x2, .LC41
	add	x2, x2, :lo12:.LC41
	mov	x1, 4096
	mov	w21, w0
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd_quiet
	cbnz	w21, .L96
	adrp	x0, .LC43
	add	x0, x0, :lo12:.LC43
	bl	printf
	bl	priv_prefix
	mov	x23, x0
	bl	priv_prefix
	mov	x22, x0
	bl	priv_prefix
	mov	x21, x0
	bl	build_user
	cbz	x0, .L59
	bl	build_user
.L57:
	adrp	x4, .LC5
	add	x4, x4, :lo12:.LC5
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x3, x23
	adrp	x1, .LC4
	adrp	x2, .LC44
	add	x1, x1, :lo12:.LC4
	add	x2, x2, :lo12:.LC44
	stp	x19, x19, [sp]
	stp	x4, x19, [sp, 16]
	mov	x4, x19
	stp	x1, x19, [sp, 32]
	mov	x1, 4096
	stp	x22, x19, [sp, 48]
	stp	x21, x0, [sp, 64]
	mov	x0, x20
	str	x19, [sp, 80]
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC46
	add	x2, x2, :lo12:.LC46
	mov	x1, 4096
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	adrp	x0, .LC47
	add	x0, x0, :lo12:.LC47
	bl	printf
	bl	priv_prefix
	mov	x3, x0
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	adrp	x2, .LC48
	add	x2, x2, :lo12:.LC48
	stp	x19, x19, [sp]
	mov	x1, 4096
	mov	x0, x20
	stp	x19, x19, [sp, 16]
	str	x19, [sp, 32]
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	x0, x19
	bl	gentoo_chroot_exists
	cbz	w0, .L97
.L58:
	mov	x1, x19
	adrp	x0, .LC50
	add	x0, x0, :lo12:.LC50
	bl	printf
	mov	x1, x19
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	bl	printf
	ldp	x21, x22, [sp, 128]
	mov	w0, 1
	ldp	x23, x24, [sp, 144]
.L98:
	mov	x12, 6512
	ldp	x29, x30, [sp, 96]
	ldp	x19, x20, [sp, 112]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L92:
	mov	x1, x19
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	printf
	mov	w0, 1
	b	.L98
	.p2align 2,,3
.L94:
	cbz	x23, .L49
	adrp	x1, .LC28
	mov	x0, x23
	add	x1, x1, :lo12:.LC28
	bl	strstr
	cbz	x0, .L49
	mov	x0, x23
	bl	free
	b	.L48
	.p2align 2,,3
.L95:
	adrp	x19, :got:stderr;ldr	x19, [x19, :got_lo12:stderr]
	mov	x2, x22
	adrp	x1, .LC37
	add	x1, x1, :lo12:.LC37
	ldr	x0, [x19]
	bl	fprintf
	ldr	x0, [x19]
	mov	x3, x22
	mov	x2, x21
	adrp	x1, .LC38
	add	x1, x1, :lo12:.LC38
	bl	fprintf
	ldp	x21, x22, [sp, 128]
	ldp	x23, x24, [sp, 144]
	b	.L30
	.p2align 2,,3
.L96:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC42
	mov	x2, 40
	add	x0, x0, :lo12:.LC42
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x21, x22, [sp, 128]
	ldp	x23, x24, [sp, 144]
	b	.L30
	.p2align 2,,3
.L59:
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	b	.L57
	.p2align 2,,3
.L97:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC49
	mov	x2, 81
	mov	x1, 1
	add	x0, x0, :lo12:.LC49
	ldr	x3, [x3]
	bl	fwrite
	b	.L58
.L44:
	adrp	x1, .LC21
	mov	x0, x21
	add	x1, x1, :lo12:.LC21
	bl	strstr
	cbz	x0, .L45
	mov	x0, x21
	bl	strlen
	cmp	x0, 10
	bls	.L45
	mov	x0, x21
	adrp	x1, .LC22
	mov	x2, 8
	add	x1, x1, :lo12:.LC22
	bl	strncmp
	mov	x3, x21
	cbnz	w0, .L46
	adrp	x2, .LC1
	mov	x0, x22
	add	x2, x2, :lo12:.LC1
	mov	x1, 1024
	bl	xsnprintf
.L47:
	mov	x1, x22
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	printf
	ldr	x0, [sp, 168]
	add	x21, sp, 1216
	bl	free
	str	xzr, [sp, 168]
	b	.L48
.L46:
	mov	x0, x22
	adrp	x2, .LC23
	mov	x1, 1024
	add	x2, x2, :lo12:.LC23
	bl	xsnprintf
	b	.L47
	.align	2
	.p2align 5,,15
	.global	gentoo_chroot_mount
	.type	gentoo_chroot_mount, %function
gentoo_chroot_mount:
	cbz	x0, .L101
	stp	x29, x30, [sp, -16]!
	mov	x29, sp
	bl	gentoo_chroot_mount.part.0
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L101:
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
	cbz	x0, .L109
	mov	x12, 4192
	sub	sp, sp, x12
	stp	x29, x30, [sp, 64]
	add	x29, sp, 64
	stp	x19, x20, [sp, 80]
	mov	x19, x0
	ldrb	w0, [x0]
	cbnz	w0, .L108
	adrp	x1, .LANCHOR0
	add	x1, x1, :lo12:.LANCHOR0
	add	x19, x1, 16
	ldrb	w1, [x1, 16]
	cbz	w1, .L106
.L108:
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	bl	printf
	add	x20, sp, 96
	bl	priv_prefix
	mov	x3, x0
	mov	x6, x19
	mov	x4, x19
	adrp	x1, .LC5
	adrp	x7, .LC4
	add	x1, x1, :lo12:.LC5
	add	x7, x7, :lo12:.LC4
	adrp	x5, .LC3
	adrp	x2, .LC53
	add	x5, x5, :lo12:.LC3
	add	x2, x2, :lo12:.LC53
	stp	x19, x1, [sp]
	mov	x1, 4096
	mov	x0, x20
	stp	x19, x19, [sp, 16]
	stp	x19, x19, [sp, 32]
	str	x19, [sp, 48]
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x19
	adrp	x2, .LC54
	add	x2, x2, :lo12:.LC54
	mov	x1, 4096
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	printf
	mov	w0, 1
.L106:
	ldp	x29, x30, [sp, 64]
	mov	x12, 4192
	ldp	x19, x20, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L109:
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
	mov	x12, 8304
	sub	sp, sp, x12
	stp	x29, x30, [sp, 48]
	add	x29, sp, 48
	stp	x21, x22, [sp, 80]
	mov	w21, w2
	mov	x2, 4208
	mov	x22, x1
	stp	x19, x20, [sp, 64]
	mov	x19, x0
	add	x20, sp, x2
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	str	x23, [sp, 96]
	bl	printf
	adrp	x23, .LANCHOR0
	mov	x2, x19
	mov	w1, w21
	adrp	x0, .LC57
	add	x0, x0, :lo12:.LC57
	bl	printf
	movi	v31.4s, 0
	adrp	x1, chroot_signal_handler
	add	x1, x1, :lo12:chroot_signal_handler
	str	x1, [sp, 4208]
	add	x1, sp, 4096
	mov	x3, 4216
	add	x0, sp, x3
	str	q31, [x1, 120]
	stp	q31, q31, [x0, 16]
	stp	q31, q31, [x0, 48]
	stp	q31, q31, [x0, 80]
	stp	q31, q31, [x0, 112]
	bl	sigemptyset
	mov	x1, x20
	mov	x2, 0
	mov	w0, 2
	bl	sigaction
	mov	x1, x20
	mov	x2, 0
	mov	w0, 15
	bl	sigaction
	mov	x1, x20
	mov	x2, 0
	mov	w0, 1
	bl	sigaction
	str	wzr, [x23, #:lo12:.LANCHOR0]
	bl	priv_prefix
	mov	x3, x0
	mov	x7, x19
	mov	x6, x19
	mov	x5, x19
	mov	x4, x19
	adrp	x2, .LC58
	add	x2, x2, :lo12:.LC58
	stp	x19, x19, [sp]
	mov	x1, 4096
	mov	x0, x20
	stp	x19, x19, [sp, 16]
	stp	x19, x19, [sp, 32]
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	mov	x6, x22
	mov	w5, w21
	mov	w4, w21
	mov	x3, x19
	adrp	x2, .LC59
	add	x2, x2, :lo12:.LC59
	mov	x1, 4096
	add	x20, sp, 112
	mov	x0, x20
	bl	xsnprintf
	mov	x0, x20
	bl	run_cmd
	ldr	w1, [x23, #:lo12:.LANCHOR0]
	cbnz	w1, .L121
	mov	w20, w0
	cbnz	w0, .L122
	adrp	x0, .LC62
	add	x0, x0, :lo12:.LC62
	bl	printf
	ldr	x23, [sp, 96]
	mov	w0, w20
	ldp	x29, x30, [sp, 48]
	mov	x12, 8304
	ldp	x19, x20, [sp, 64]
	ldp	x21, x22, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L122:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w20
	adrp	x1, .LC61
	add	x1, x1, :lo12:.LC61
	ldr	x0, [x0]
	bl	fprintf
	ldr	x23, [sp, 96]
	mov	w0, w20
	ldp	x29, x30, [sp, 48]
	mov	x12, 8304
	ldp	x19, x20, [sp, 64]
	ldp	x21, x22, [sp, 80]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L121:
	adrp	x0, .LC60
	add	x0, x0, :lo12:.LC60
	bl	printf
	mov	w20, 130
	mov	x0, x19
	bl	gentoo_chroot_unmount
	ldr	x23, [sp, 96]
	mov	w0, w20
	ldp	x29, x30, [sp, 48]
	mov	x12, 8304
	ldp	x19, x20, [sp, 64]
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
	bne	.L125
	mov	w0, 1
	ret
	.p2align 2,,3
.L125:
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
	cbz	x0, .L136
	sub	sp, sp, #672
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x19, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L137
	ldr	x19, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp]
	add	sp, sp, 672
	ret
	.p2align 2,,3
.L137:
	mov	x4, x19
	adrp	x3, .LC6
	adrp	x2, .LC63
	add	x3, x3, :lo12:.LC6
	add	x2, x2, :lo12:.LC63
	add	x0, sp, 32
	mov	x1, 640
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	bl	file_exists
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp]
	add	sp, sp, 672
	ret
	.p2align 2,,3
.L136:
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
	mov	x12, 22128
	sub	sp, sp, x12
	mov	x4, x1
	mov	x3, x0
	adrp	x2, .LC64
	add	x2, x2, :lo12:.LC64
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	add	x19, sp, 4048
	mov	x20, x1
	mov	x1, 1024
	str	x0, [sp, 120]
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	add	x1, sp, 192
	str	xzr, [sp, 192]
	bl	run_cmd_capture
	ldr	x19, [sp, 192]
	cbnz	w0, .L139
	cbz	x19, .L139
	stp	x21, x22, [sp, 32]
	mov	w21, w0
	ldrb	w0, [x19]
	cbz	w0, .L244
	mov	x0, x19
	bl	strlen
	cbnz	x0, .L142
	b	.L143
	.p2align 2,,3
.L144:
	strb	wzr, [x19, x0]
	ldr	x19, [sp, 192]
	cbz	x0, .L143
.L142:
	sub	x0, x0, #1
	ldrb	w1, [x19, x0]
	cmp	w1, 10
	ccmp	w1, 13, 4, ne
	beq	.L144
.L143:
	mov	x3, x19
	mov	x16, 10728
	adrp	x2, .LC66
	add	x2, x2, :lo12:.LC66
	add	x0, sp, x16
	mov	x1, 1400
	mov	x19, x0
	bl	xsnprintf
	mov	x0, x19
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	fopen
	mov	x19, x0
	cbz	x0, .L245
	add	x22, sp, 712
	stp	x23, x24, [sp, 48]
	adrp	x23, .LC6
	add	x23, x23, :lo12:.LC6
	add	x24, sp, 1992
	mov	x0, x22
	mov	x3, x23
	mov	x1, 640
	adrp	x2, .LC69
	add	x2, x2, :lo12:.LC69
	stp	x25, x26, [sp, 64]
	add	x25, sp, 1352
	stp	x27, x28, [sp, 80]
	bl	xsnprintf
	mov	x3, x22
	mov	x1, 640
	mov	x0, x24
	adrp	x2, .LC1
	add	x2, x2, :lo12:.LC1
	bl	xsnprintf
	add	x27, sp, 2632
	mov	x4, x20
	mov	x3, x23
	adrp	x2, .LC63
	add	x2, x2, :lo12:.LC63
	mov	x1, 640
	mov	x0, x24
	bl	xsnprintf
	bl	getpid
	sxtw	x4, w0
	mov	x3, x24
	adrp	x2, .LC70
	add	x2, x2, :lo12:.LC70
	mov	x1, 648
	mov	x0, x27
	bl	xsnprintf
	bl	getpid
	sxtw	x4, w0
	mov	x3, x23
	adrp	x2, .LC71
	add	x2, x2, :lo12:.LC71
	mov	x1, 640
	mov	x0, x25
	bl	xsnprintf
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x22
	add	x1, sp, 3280
	adrp	x2, .LC16
	add	x2, x2, :lo12:.LC16
	mov	x22, x1
	mov	x0, x1
	mov	x1, 768
	bl	xsnprintf
	mov	x0, x22
	adrp	x22, .LC72
	bl	run_cmd
	add	x22, x22, :lo12:.LC72
	mov	x1, x22
	mov	x0, x25
	bl	fopen
	mov	x1, x22
	mov	x22, x0
	mov	x0, x27
	str	x22, [sp, 136]
	bl	fopen
	str	x0, [sp, 144]
	cmp	x22, 0
	ccmp	x0, 0, 4, ne
	beq	.L246
	adrp	x0, .LC78
	mov	x2, 5072
	add	x0, x0, :lo12:.LC78
	mov	w22, 25199
	mov	w23, 26980
	mov	w26, 31091
	add	x28, sp, x2
	mov	x3, 19528
	movk	w22, 0x206a, lsl 16
	movk	w23, 0x2072, lsl 16
	movk	w26, 0x206d, lsl 16
	str	wzr, [sp, 108]
	str	x0, [sp, 128]
	add	x0, sp, x3
	str	x0, [sp, 112]
	str	x20, [sp, 152]
	stp	wzr, wzr, [sp, 160]
	.p2align 5,,15
.L147:
	mov	x2, x19
	mov	x0, x28
	mov	w1, 1024
	bl	fgets
	cbz	x0, .L247
.L178:
	ldr	w0, [x28]
	strb	wzr, [sp, 200]
	cmp	w0, w22
	beq	.L248
	cmp	w0, w23
	beq	.L249
	cmp	w0, w26
	bne	.L147
	ldr	x1, [sp, 128]
	add	x20, x28, 4
	mov	x0, x20
	bl	strstr
	mov	x3, x0
	cbz	x0, .L147
	subs	x2, x0, x20
	bne	.L160
	b	.L161
	.p2align 2,,3
.L162:
	subs	x2, x2, #1
	beq	.L161
.L160:
	add	x0, x28, x2
	ldrb	w0, [x0, 3]
	cmp	w0, 32
	beq	.L162
	cmp	x2, 1023
	bhi	.L147
	.p2align 5,,15
.L161:
	mov	x13, 6096
	add	x20, sp, x13
	add	x1, x28, 4
	mov	x0, x20
	str	x2, [sp, 96]
	str	x3, [sp, 168]
	bl	memcpy
	ldr	x3, [sp, 168]
	ldr	x2, [sp, 96]
	ldrb	w1, [x3, 2]
	strb	wzr, [x20, x2]
	add	x2, x3, 2
	cmp	w1, 32
	bne	.L163
	.p2align 5,,15
.L164:
	ldrb	w1, [x2, 1]!
	cmp	w1, 32
	beq	.L164
.L163:
	ands	w0, w1, -33
	ccmp	w1, 10, 4, ne
	beq	.L183
	add	x5, sp, 200
	mov	x0, 1
	b	.L166
	.p2align 2,,3
.L251:
	add	x0, x0, 1
	cmp	x0, 512
	beq	.L250
.L166:
	add	x3, x5, x0
	strb	w1, [x3, -1]
	ldrb	w1, [x2, x0]
	ands	w3, w1, -33
	ccmp	w1, 10, 4, ne
	bne	.L251
.L165:
	strb	wzr, [x5, x0]
	mov	w0, 1
	str	w0, [sp, 96]
	b	.L154
	.p2align 2,,3
.L244:
	ldp	x21, x22, [sp, 32]
.L139:
	mov	x0, x19
	bl	free
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC65
	mov	x2, x20
	add	x1, x1, :lo12:.LC65
	ldr	x0, [x0]
	bl	fprintf
.L141:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	mov	x12, 22128
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L248:
	mov	x15, 6096
	add	x20, sp, x15
	adrp	x1, .LC75
	mov	x2, x20
	add	x1, x1, :lo12:.LC75
	add	x0, x28, 4
	str	wzr, [sp, 96]
	bl	__isoc99_sscanf
	cmp	w0, 1
	bne	.L147
.L154:
	mov	x12, 4192
	add	x0, sp, x12
	ldrb	w0, [x0, 1904]
	cmp	w0, 47
	bne	.L147
	ldr	w1, [x20]
	mov	w0, 29999
	movk	w0, 0x7273, lsl 16
	cmp	w1, w0
	beq	.L252
.L167:
	ldr	w0, [sp, 108]
	mov	x2, x19
	mov	w1, 1024
	add	w0, w0, 1
	str	w0, [sp, 108]
	mov	x0, x28
	bl	fgets
	cbnz	x0, .L178
	.p2align 5,,15
.L247:
	ldr	x20, [sp, 152]
	mov	x0, x19
	bl	fclose
	ldr	x0, [sp, 136]
	bl	fclose
	ldr	x0, [sp, 144]
	bl	fclose
	ldr	x0, [sp, 192]
	bl	free
	ldr	x1, [sp, 112]
	mov	x0, x25
	mov	x2, 1600
	bl	shell_quote
	cbz	w0, .L253
	bl	priv_prefix
	mov	x3, x0
	ldr	x4, [sp, 112]
	mov	x1, 16928
	adrp	x2, .LC90
	add	x2, x2, :lo12:.LC90
	add	x19, sp, x1
	mov	x1, 1400
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	mov	w19, w0
	mov	x0, x25
	bl	unlink
	cbnz	w19, .L254
	mov	x0, x24
	bl	unlink
	mov	x1, x24
	mov	x0, x27
	bl	rename
	cbnz	w0, .L255
.L181:
	ldr	w4, [sp, 108]
	mov	w1, w21
	ldp	w3, w2, [sp, 160]
	adrp	x0, .LC93
	add	x0, x0, :lo12:.LC93
	bl	printf
	mov	x0, x20
	bl	add_to_world
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	mov	x12, 22128
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L249:
	mov	x14, 6096
	add	x20, sp, x14
	adrp	x1, .LC75
	mov	x2, x20
	add	x1, x1, :lo12:.LC75
	add	x0, x28, 4
	bl	__isoc99_sscanf
	cmp	w0, 1
	bne	.L147
	mov	w0, 2
	str	w0, [sp, 96]
	b	.L154
	.p2align 2,,3
.L254:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC91
	add	x1, x1, :lo12:.LC91
	ldr	x0, [x0]
	bl	fprintf
	mov	x0, x27
.L243:
	bl	unlink
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L141
	.p2align 2,,3
.L253:
	mov	x0, x27
	bl	unlink
	mov	x0, x25
	b	.L243
	.p2align 2,,3
.L252:
	ldrb	w0, [x20, 4]
	cmp	w0, 47
	bne	.L167
	mov	x9, 7120
	add	x5, sp, x9
	add	x3, x20, 4
	mov	x0, x5
	mov	x1, 1152
	adrp	x2, .LC80
	add	x2, x2, :lo12:.LC80
	str	x5, [sp, 176]
	bl	xsnprintf
	ldr	x3, [sp, 120]
	mov	x10, 9424
	add	x6, sp, x10
	mov	x4, x20
	mov	x0, x6
	mov	x1, 1300
	adrp	x2, .LC81
	add	x2, x2, :lo12:.LC81
	str	x6, [sp, 168]
	bl	xsnprintf
	ldr	x6, [sp, 168]
	mov	x11, 16928
	add	x1, sp, x11
	mov	x2, 2600
	mov	x20, x1
	mov	x0, x6
	bl	shell_quote
	cbz	w0, .L147
	ldr	x5, [sp, 176]
	mov	x8, 12128
	add	x0, sp, x8
	mov	x2, 2400
	mov	x1, x0
	stp	x5, x0, [sp, 168]
	mov	x0, x5
	bl	shell_quote
	cbz	w0, .L147
	ldr	x5, [sp, 168]
	mov	x0, x5
	bl	strlen
	mov	x3, x0
	ldr	x5, [sp, 168]
	b	.L172
	.p2align 2,,3
.L257:
	ldrb	w1, [x5, x0]
	cmp	w1, 47
	beq	.L256
	mov	x3, x0
.L172:
	sub	x0, x3, #1
	cbnz	x3, .L257
.L171:
	mov	x6, 8272
	add	x6, sp, x6
	mov	x0, x6
	adrp	x2, .LC83
	mov	x1, 1152
	add	x2, x2, :lo12:.LC83
	str	x6, [sp, 168]
	str	x5, [sp, 184]
	bl	xsnprintf
	ldr	x6, [sp, 168]
	ldr	x5, [sp, 184]
.L173:
	mov	x4, 14528
	add	x0, sp, x4
	mov	x2, 2400
	mov	x1, x0
	mov	x0, x6
	str	x5, [sp, 168]
	str	x1, [sp, 184]
	bl	shell_quote
	cbz	w0, .L147
	ldr	w0, [sp, 96]
	ldr	x5, [sp, 168]
	cbz	w0, .L258
	ldr	w0, [sp, 96]
	str	x5, [sp, 96]
	cmp	w0, 1
	beq	.L259
	ldr	x0, [sp, 136]
	adrp	x1, .LC88
	ldr	x2, [sp, 176]
	add	x1, x1, :lo12:.LC88
	bl	fprintf
	ldr	x5, [sp, 96]
	adrp	x1, .LC89
	ldr	x0, [sp, 144]
	add	x1, x1, :lo12:.LC89
	mov	x2, x5
	bl	fprintf
	ldr	w0, [sp, 160]
	add	w0, w0, 1
	str	w0, [sp, 160]
	b	.L147
.L255:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x24
	adrp	x1, .LC92
	add	x1, x1, :lo12:.LC92
	ldr	x0, [x0]
	bl	fprintf
	b	.L181
.L256:
	cmp	x3, 1
	beq	.L171
	mov	x7, 8272
	add	x6, sp, x7
	mov	x0, x6
	mov	x4, x5
	adrp	x2, .LC82
	mov	x1, 1152
	add	x2, x2, :lo12:.LC82
	str	x5, [sp, 168]
	str	x6, [sp, 184]
	bl	xsnprintf
	ldr	x5, [sp, 168]
	ldr	x6, [sp, 184]
	b	.L173
.L250:
	mov	x0, 511
	b	.L165
.L183:
	add	x5, sp, 200
	mov	x0, 0
	b	.L165
.L258:
	ldp	x4, x2, [sp, 176]
	mov	x3, x20
	ldr	x0, [sp, 136]
	adrp	x1, .LC84
	add	x1, x1, :lo12:.LC84
	str	x5, [sp, 96]
	add	w21, w21, 1
	bl	fprintf
	ldr	x5, [sp, 96]
	adrp	x1, .LC85
	ldr	x0, [sp, 144]
	add	x1, x1, :lo12:.LC85
	mov	x2, x5
	bl	fprintf
	b	.L147
.L259:
	ldr	x20, [sp, 112]
	add	x0, sp, 200
	mov	x2, 2600
	mov	x1, x20
	bl	shell_quote
	cbz	w0, .L147
	ldp	x4, x2, [sp, 176]
	mov	x3, x20
	ldr	x0, [sp, 136]
	adrp	x1, .LC86
	add	x1, x1, :lo12:.LC86
	bl	fprintf
	ldr	x5, [sp, 96]
	adrp	x1, .LC87
	ldr	x0, [sp, 144]
	add	x1, x1, :lo12:.LC87
	mov	x2, x5
	bl	fprintf
	ldr	w0, [sp, 164]
	add	w0, w0, 1
	str	w0, [sp, 164]
	b	.L147
.L245:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC68
	ldr	x2, [sp, 192]
	add	x1, x1, :lo12:.LC68
	ldr	x0, [x0]
	bl	fprintf
	ldr	x0, [sp, 192]
	bl	free
	ldp	x21, x22, [sp, 32]
	b	.L141
.L246:
	ldr	x0, [sp, 136]
	cbz	x0, .L148
	bl	fclose
.L148:
	ldr	x0, [sp, 144]
	cbz	x0, .L149
	bl	fclose
.L149:
	mov	x0, x19
	bl	fclose
	ldr	x0, [sp, 192]
	bl	free
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC73
	mov	x2, 48
	add	x0, x0, :lo12:.LC73
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L141
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
	cbz	x0, .L290
	mov	x12, 7312
	sub	sp, sp, x12
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x19, x0
	bl	valid_pkgname
	cbnz	w0, .L294
.L262:
	ldp	x29, x30, [sp]
	mov	w0, 0
	ldp	x19, x20, [sp, 16]
	mov	x12, 7312
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L294:
	stp	x21, x22, [sp, 32]
	adrp	x21, .LC6
	add	x21, x21, :lo12:.LC6
	mov	x4, x19
	mov	x3, x21
	adrp	x2, .LC63
	add	x2, x2, :lo12:.LC63
	stp	x27, x28, [sp, 80]
	add	x27, sp, 112
	mov	x1, 640
	mov	x0, x27
	bl	xsnprintf
	mov	x0, x27
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	fopen
	mov	x20, x0
	cbz	x0, .L293
	stp	x23, x24, [sp, 48]
	bl	getpid
	mov	x3, x21
	sxtw	x4, w0
	adrp	x2, .LC94
	add	x2, x2, :lo12:.LC94
	add	x24, sp, 752
	mov	x1, 640
	mov	x0, x24
	bl	xsnprintf
	mov	x0, x24
	adrp	x1, .LC72
	add	x1, x1, :lo12:.LC72
	bl	fopen
	mov	x23, x0
	cbz	x0, .L295
	adrp	x21, .LC95
	mov	x1, 4712
	add	x21, x21, :lo12:.LC95
	add	x19, sp, 2160
	add	x22, sp, 1392
	stp	x25, x26, [sp, 64]
	add	x26, sp, x1
	adrp	x25, .LC96
	add	x0, x25, :lo12:.LC96
	str	wzr, [sp, 100]
	str	x0, [sp, 104]
	.p2align 5,,15
.L264:
	mov	x2, x20
	mov	x0, x19
	mov	w1, 1152
	bl	fgets
	cbz	x0, .L296
.L272:
	add	x25, sp, 3312
	mov	x2, x22
	mov	x3, x25
	mov	x1, x21
	mov	x0, x19
	bl	__isoc99_sscanf
	cmp	w0, 2
	bne	.L264
	mov	x0, x25
	bl	strlen
	mov	x28, x0
	cbnz	x0, .L267
	b	.L264
	.p2align 2,,3
.L268:
	strb	wzr, [x1, -1]
	subs	x28, x28, #1
	beq	.L264
.L267:
	add	x1, x25, x28
	ldrb	w0, [x1, -1]
	cmp	w0, 10
	ccmp	w0, 13, 4, ne
	beq	.L268
	ldr	x1, [sp, 104]
	mov	x0, x25
	mov	x2, 10
	bl	strncmp
	cmp	w0, 0
	ccmp	x28, 11, 0, eq
	bls	.L264
	mov	x0, x25
	mov	x1, x26
	mov	x2, 2600
	bl	shell_quote
	cbz	w0, .L264
	ldrb	w0, [sp, 1392]
	cmp	w0, 100
	beq	.L297
	adrp	x1, .LC98
	mov	x2, x26
	add	x1, x1, :lo12:.LC98
	mov	x0, x23
	bl	fprintf
.L270:
	ldr	w0, [sp, 100]
	mov	x2, x20
	mov	w1, 1152
	add	w0, w0, 1
	str	w0, [sp, 100]
	mov	x0, x19
	bl	fgets
	cbnz	x0, .L272
	.p2align 5,,15
.L296:
	mov	x0, x20
	bl	fclose
	mov	x0, x23
	bl	fclose
	mov	x1, x26
	mov	x0, x24
	mov	x2, 1600
	bl	shell_quote
	cbz	w0, .L298
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x26
	adrp	x2, .LC90
	add	x2, x2, :lo12:.LC90
	add	x19, sp, 3312
	mov	x1, 1400
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	mov	w19, w0
	mov	x0, x24
	bl	unlink
	cbnz	w19, .L299
	bl	priv_prefix
	mov	x3, x0
	mov	x4, x27
	adrp	x2, .LC100
	add	x2, x2, :lo12:.LC100
	add	x19, sp, 1392
	mov	x1, 768
	mov	x0, x19
	bl	xsnprintf
	mov	x0, x19
	bl	run_cmd
	ldr	w1, [sp, 100]
	adrp	x0, .LC101
	add	x0, x0, :lo12:.LC101
	bl	printf
	ldp	x29, x30, [sp]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	mov	x12, 7312
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	ldp	x19, x20, [sp, 16]
	add	sp, sp, x12
	ret
	.p2align 2,,3
.L290:
	mov	w0, 0
	ret
	.p2align 2,,3
.L299:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	ldr	x0, [x0]
	bl	fprintf
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L262
	.p2align 2,,3
.L298:
	mov	x0, x24
	bl	unlink
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L262
.L297:
	mov	x2, x26
	mov	x0, x23
	adrp	x1, .LC97
	add	x1, x1, :lo12:.LC97
	bl	fprintf
	b	.L270
.L295:
	mov	x0, x20
	bl	fclose
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	ldp	x27, x28, [sp, 80]
	b	.L262
.L293:
	ldp	x21, x22, [sp, 32]
	ldp	x27, x28, [sp, 80]
	b	.L262
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
	mov	x20, x0
	str	x21, [sp, 32]
	bl	valid_pkgname
	cbz	w0, .L313
	bl	get_gentoo_chroot_path
	mov	x19, x0
	cbz	x0, .L310
	ldrb	w1, [x0]
	adrp	x0, .LC102
	add	x0, x0, :lo12:.LC102
	cmp	w1, 0
	csel	x19, x0, x19, eq
.L303:
	mov	x1, x20
	adrp	x0, .LC104
	add	x0, x0, :lo12:.LC104
	bl	printf
	mov	x0, x19
	bl	gentoo_chroot_init
	cbz	w0, .L314
	mov	x0, x19
	bl	gentoo_chroot_mount.part.0
	bl	get_jobs
	cbnz	x20, .L306
	mov	x0, x19
	bl	gentoo_chroot_unmount
.L307:
	adrp	x20, :got:stderr;ldr	x20, [x20, :got_lo12:stderr]
	mov	x2, 38
	mov	x1, 1
	adrp	x0, .LC108
	add	x0, x0, :lo12:.LC108
	ldr	x3, [x20]
	bl	fwrite
	ldr	x0, [x20]
	adrp	x1, .LC109
	mov	x3, x19
	mov	x2, x19
	add	x1, x1, :lo12:.LC109
	bl	fprintf
.L302:
	mov	w21, 0
	mov	w0, w21
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L313:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC103
	add	x1, x1, :lo12:.LC103
	ldr	x0, [x0]
	bl	fprintf
	b	.L302
	.p2align 2,,3
.L314:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC105
	mov	x2, 44
	mov	x1, 1
	add	x0, x0, :lo12:.LC105
	ldr	x3, [x3]
	bl	fwrite
	b	.L302
	.p2align 2,,3
.L310:
	adrp	x19, .LC102
	add	x19, x19, :lo12:.LC102
	b	.L303
	.p2align 2,,3
.L306:
	mov	w2, w0
	mov	x1, x20
	mov	x0, x19
	bl	gentoo_chroot_run_portage.part.0
	mov	w21, w0
	cbnz	w0, .L308
	mov	x1, x20
	mov	x0, x19
	bl	gentoo_chroot_install_artifacts
	mov	w21, w0
	mov	x0, x19
	cbnz	w21, .L309
	bl	gentoo_chroot_unmount
	b	.L307
	.p2align 2,,3
.L309:
	bl	gentoo_chroot_unmount
	mov	x1, x20
	adrp	x0, .LC106
	add	x0, x0, :lo12:.LC106
	bl	printf
	mov	w0, w21
	ldr	x21, [sp, 32]
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L308:
	mov	x0, x19
	bl	gentoo_chroot_unmount
	cmp	w21, 130
	bne	.L307
	adrp	x0, .LC107
	add	x0, x0, :lo12:.LC107
	bl	printf
	b	.L302
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
