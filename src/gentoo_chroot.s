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
	sub	sp, sp, #2128
	stp	x29, x30, [sp, 32]
	add	x29, sp, 32
	stp	x19, x20, [sp, 48]
	mov	x20, x0
	stp	x21, x22, [sp, 64]
	bl	valid_pkgname
	cbz	w0, .L138
	bl	get_gentoo_chroot_path
	mov	x19, x0
	cbz	x0, .L135
	ldrb	w1, [x0]
	adrp	x0, .LC63
	add	x0, x0, :lo12:.LC63
	cmp	w1, 0
	csel	x19, x0, x19, eq
.L129:
	mov	x1, x20
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	mov	x0, x19
	bl	gentoo_chroot_init
	mov	w21, w0
	cbz	w0, .L139
	mov	x0, x19
	bl	gentoo_chroot_mount.part.0
	bl	get_jobs
	cbnz	x20, .L132
	mov	x0, x19
	bl	gentoo_chroot_unmount
.L133:
	adrp	x20, :got:stderr;ldr	x20, [x20, :got_lo12:stderr]
	mov	x2, 38
	mov	x1, 1
	adrp	x0, .LC71
	add	x0, x0, :lo12:.LC71
	ldr	x3, [x20]
	bl	fwrite
	ldr	x0, [x20]
	adrp	x1, .LC72
	mov	x3, x19
	mov	x2, x19
	add	x1, x1, :lo12:.LC72
	bl	fprintf
.L128:
	mov	w21, 0
	mov	w0, w21
	ldp	x29, x30, [sp, 32]
	ldp	x19, x20, [sp, 48]
	ldp	x21, x22, [sp, 64]
	add	sp, sp, 2128
	ret
	.p2align 2,,3
.L138:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC64
	add	x1, x1, :lo12:.LC64
	ldr	x0, [x0]
	bl	fprintf
	b	.L128
	.p2align 2,,3
.L139:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC66
	mov	x2, 44
	mov	x1, 1
	add	x0, x0, :lo12:.LC66
	ldr	x3, [x3]
	bl	fwrite
	b	.L128
	.p2align 2,,3
.L135:
	adrp	x19, .LC63
	add	x19, x19, :lo12:.LC63
	b	.L129
	.p2align 2,,3
.L132:
	mov	w2, w0
	mov	x1, x20
	mov	x0, x19
	bl	gentoo_chroot_run_portage.part.0
	mov	w22, w0
	cbnz	w0, .L134
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	printf
	add	x22, sp, 80
	bl	priv_prefix
	mov	x3, x0
	adrp	x6, .LC5
	add	x6, x6, :lo12:.LC5
	mov	x7, x20
	mov	x5, x20
	mov	x4, x6
	adrp	x2, .LC68
	add	x2, x2, :lo12:.LC68
	stp	x19, x6, [sp]
	mov	x1, 2048
	stp	x20, x19, [sp, 16]
	mov	x0, x22
	bl	xsnprintf
	mov	x0, x22
	bl	run_cmd
	mov	x0, x19
	bl	gentoo_chroot_unmount
	mov	x1, x20
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	printf
	ldp	x29, x30, [sp, 32]
	mov	w0, w21
	ldp	x19, x20, [sp, 48]
	ldp	x21, x22, [sp, 64]
	add	sp, sp, 2128
	ret
	.p2align 2,,3
.L134:
	mov	x0, x19
	bl	gentoo_chroot_unmount
	cmp	w22, 130
	bne	.L133
	adrp	x0, .LC70
	add	x0, x0, :lo12:.LC70
	bl	printf
	b	.L128
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
