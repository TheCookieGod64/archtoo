	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"%s%s"
	.text
	.align	2
	.p2align 5,,15
	.type	run_priv_cmd, %function
run_priv_cmd:
	sub	sp, sp, #544
	stp	x29, x30, [sp]
	mov	x29, sp
	str	x0, [sp, 24]
	bl	priv_prefix
	ldr	x4, [sp, 24]
	mov	x3, x0
	adrp	x2, .LC0
	add	x2, x2, :lo12:.LC0
	mov	x1, 512
	add	x0, sp, 32
	bl	xsnprintf
	add	x0, sp, 32
	bl	run_cmd
	ldp	x29, x30, [sp]
	add	sp, sp, 544
	ret
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"firmware"
	.align	3
.LC2:
	.string	"linux"
	.align	3
.LC3:
	.string	"linux-"
	.align	3
.LC4:
	.string	"-headers"
	.align	3
.LC5:
	.string	"-docs"
	.align	3
.LC6:
	.string	"-firmware"
	.align	3
.LC7:
	.string	"-whence"
	.text
	.align	2
	.p2align 5,,15
	.global	is_kernel
	.type	is_kernel, %function
is_kernel:
	stp	x29, x30, [sp, -64]!
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	mov	x20, x0
	bl	strcmp
	cbz	w0, .L5
	adrp	x1, .LC3
	mov	x0, x20
	add	x1, x1, :lo12:.LC3
	mov	x2, 6
	bl	strncmp
	cbnz	w0, .L15
	ldrb	w1, [x20, 6]
	cbz	w1, .L4
	stp	x21, x22, [sp, 32]
	adrp	x22, .LANCHOR0
	adrp	x21, .LC1
	add	x22, x22, :lo12:.LANCHOR0
	add	x21, x21, :lo12:.LC1
	str	x23, [sp, 48]
	add	x23, x20, 6
	mov	x19, 8
	.p2align 5,,15
.L9:
	mov	x2, x19
	mov	x1, x21
	mov	x0, x23
	bl	strncmp
	cbnz	w0, .L7
	ldrb	w1, [x23, x19]
	cmp	w1, 45
	ccmp	w1, 0, 4, ne
	bne	.L7
.L43:
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
.L4:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L15:
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L7:
	ldr	x21, [x22, 8]!
	cbz	x21, .L8
	mov	x0, x21
	bl	strlen
	mov	x19, x0
	b	.L9
	.p2align 2,,3
.L10:
	cmp	x0, 5
	bhi	.L12
.L44:
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
.L5:
	mov	w0, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 64
	ret
	.p2align 2,,3
.L8:
	mov	x0, x20
	bl	strlen
	mov	x19, x0
	cmp	x0, 8
	bls	.L10
	sub	x0, x0, #8
	adrp	x1, .LC4
	add	x0, x20, x0
	add	x1, x1, :lo12:.LC4
	bl	strcmp
	cbz	w0, .L43
	sub	x0, x19, #5
	adrp	x1, .LC5
	add	x0, x20, x0
	add	x1, x1, :lo12:.LC5
	bl	strcmp
	cbz	w0, .L43
	cmp	x19, 9
	bne	.L45
.L13:
	sub	x0, x19, #7
	adrp	x1, .LC7
	add	x0, x20, x0
	add	x1, x1, :lo12:.LC7
	bl	strcmp
	cmp	w0, 0
	ldr	x23, [sp, 48]
	cset	w0, ne
	ldp	x21, x22, [sp, 32]
	b	.L4
.L45:
	sub	x0, x19, #9
	adrp	x1, .LC6
	add	x0, x20, x0
	add	x1, x1, :lo12:.LC6
	bl	strcmp
	cbz	w0, .L43
	b	.L13
.L12:
	sub	x0, x0, #5
	adrp	x1, .LC5
	add	x0, x20, x0
	add	x1, x1, :lo12:.LC5
	bl	strcmp
	cbz	w0, .L43
	cmp	x19, 8
	bne	.L44
	b	.L13
	.section	.rodata.str1.8
	.align	3
.LC8:
	.string	"/usr/local/emerge/builds"
	.align	3
.LC9:
	.string	"for f in '%s/%s'/*.pkg.tar.*; do [ -e \"$f\" ] || continue; tar -tf \"$f\" 2>/dev/null | grep -q '^[./]*usr/lib/modules/.*/vmlinuz' && exit 0; done; exit 1"
	.text
	.align	2
	.p2align 5,,15
	.global	pkg_ships_kernel
	.type	pkg_ships_kernel, %function
pkg_ships_kernel:
	sub	sp, sp, #1040
	mov	x4, x0
	adrp	x3, .LC8
	adrp	x2, .LC9
	add	x3, x3, :lo12:.LC8
	add	x2, x2, :lo12:.LC9
	stp	x29, x30, [sp]
	mov	x1, 1024
	mov	x29, sp
	add	x0, sp, 16
	bl	xsnprintf
	add	x0, sp, 16
	bl	run_cmd_quiet
	cmp	w0, 0
	ldp	x29, x30, [sp]
	cset	w0, eq
	add	sp, sp, 1040
	ret
	.section	.rodata.str1.8
	.align	3
.LC10:
	.string	"\033[1;35m>>> [KERNEL HOOK] Kernel detected: %s\n\033[0m"
	.align	3
.LC11:
	.string	"mkinitcpio"
	.align	3
.LC12:
	.string	"\033[1;34m>>> [KERNEL HOOK] Generating initramfs (mkinitcpio -P)...\n\033[0m"
	.align	3
.LC13:
	.string	"mkinitcpio -P"
	.align	3
.LC14:
	.string	"\033[1;31m[-] mkinitcpio failed -- do NOT reboot yet.\n\033[0m"
	.align	3
.LC15:
	.string	"dracut"
	.align	3
.LC16:
	.string	"\033[1;34m>>> [KERNEL HOOK] Generating initramfs (dracut)...\n\033[0m"
	.align	3
.LC17:
	.string	"dracut --regenerate-all --force"
	.align	3
.LC18:
	.string	"\033[1;31m[-] dracut failed -- do NOT reboot yet.\n\033[0m"
	.align	3
.LC19:
	.string	"grub-mkconfig"
	.align	3
.LC20:
	.string	"/boot/grub"
	.align	3
.LC21:
	.string	"\033[1;34m>>> [KERNEL HOOK] Updating GRUB...\n\033[0m"
	.align	3
.LC22:
	.string	"grub-mkconfig -o /boot/grub/grub.cfg"
	.align	3
.LC23:
	.string	"\033[1;31m[-] grub-mkconfig failed.\n\033[0m"
	.align	3
.LC24:
	.string	"/boot/loader/entries"
	.align	3
.LC25:
	.string	"bootctl"
	.align	3
.LC26:
	.string	"\033[1;34m>>> [KERNEL HOOK] systemd-boot detected.\n\033[0m"
	.align	3
.LC27:
	.string	"bootctl update || true"
	.align	3
.LC28:
	.string	"/boot/refind_linux.conf"
	.align	3
.LC29:
	.string	"\033[1;33m[!] rEFInd detected -- verify /boot/refind_linux.conf.\n\033[0m"
	.align	3
.LC30:
	.string	"/boot/EFI/refind"
	.align	3
.LC31:
	.string	"/boot/limine.conf"
	.align	3
.LC32:
	.string	"\033[1;33m[!] Limine detected -- verify your limine config.\n\033[0m"
	.align	3
.LC33:
	.string	"/boot/limine.cfg"
	.align	3
.LC34:
	.string	"\033[1;33m[!] No known bootloader found. Update your boot entries manually.\n\033[0m"
	.align	3
.LC35:
	.string	"sbctl"
	.align	3
.LC36:
	.string	"\033[1;33m[!] sbctl present: re-sign the new kernel if Secure Boot is on.\n\033[0m"
	.align	3
.LC37:
	.string	"\033[1;32m[+] Kernel hooks processed.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	run_kernel_hooks
	.type	run_kernel_hooks, %function
run_kernel_hooks:
	stp	x29, x30, [sp, -32]!
	mov	x1, x0
	adrp	x0, .LC10
	mov	x29, sp
	add	x0, x0, :lo12:.LC10
	str	x19, [sp, 16]
	bl	printf
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	have_cmd
	cbz	w0, .L49
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	printf
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	run_priv_cmd
	cbnz	w0, .L86
.L50:
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	bl	have_cmd
	mov	w19, w0
	cbnz	w0, .L87
.L51:
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	dir_exists
	cbnz	w0, .L88
.L56:
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	file_exists
	cbnz	w0, .L59
	adrp	x0, .LC30
	add	x0, x0, :lo12:.LC30
	bl	dir_exists
	cbnz	w0, .L59
.L58:
	adrp	x0, .LC31
	add	x0, x0, :lo12:.LC31
	bl	file_exists
	cbnz	w0, .L62
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	file_exists
	cbz	w0, .L89
.L62:
	adrp	x0, .LC32
	add	x0, x0, :lo12:.LC32
	bl	printf
.L61:
	adrp	x0, .LC35
	add	x0, x0, :lo12:.LC35
	bl	have_cmd
	cbnz	w0, .L90
	ldr	x19, [sp, 16]
	adrp	x0, .LC37
	ldp	x29, x30, [sp], 32
	add	x0, x0, :lo12:.LC37
	b	printf
	.p2align 2,,3
.L59:
	adrp	x0, .LC29
	mov	w19, 1
	add	x0, x0, :lo12:.LC29
	bl	printf
	b	.L58
	.p2align 2,,3
.L49:
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	have_cmd
	cbz	w0, .L50
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	printf
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	run_priv_cmd
	cbz	w0, .L50
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 51
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	fwrite
	b	.L50
	.p2align 2,,3
.L89:
	cbnz	w19, .L61
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 77
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC34
	add	x0, x0, :lo12:.LC34
	bl	fwrite
	b	.L61
	.p2align 2,,3
.L90:
	adrp	x0, .LC36
	add	x0, x0, :lo12:.LC36
	bl	printf
	ldr	x19, [sp, 16]
	adrp	x0, .LC37
	ldp	x29, x30, [sp], 32
	add	x0, x0, :lo12:.LC37
	b	printf
	.p2align 2,,3
.L88:
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	have_cmd
	cbz	w0, .L56
	adrp	x0, .LC26
	add	x0, x0, :lo12:.LC26
	bl	printf
	mov	w19, 1
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	run_priv_cmd
	b	.L56
	.p2align 2,,3
.L87:
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	dir_exists
	mov	w19, w0
	cbz	w0, .L51
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	printf
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	run_priv_cmd
	cbnz	w0, .L52
	mov	w19, 1
	b	.L51
	.p2align 2,,3
.L86:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 55
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	fwrite
	b	.L50
	.p2align 2,,3
.L52:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 37
	mov	x1, 1
	mov	w19, 1
	ldr	x3, [x0]
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	fwrite
	b	.L51
	.section	.rodata.str1.8
	.align	3
.LC38:
	.string	"api-headers"
	.align	3
.LC39:
	.string	"tools"
	.align	3
.LC40:
	.string	"docs"
	.align	3
.LC41:
	.string	"wifi"
	.align	3
.LC42:
	.string	"atm"
	.section	.data.rel.ro.local,"aw"
	.align	4
	.set	.LANCHOR0,. + 0
	.type	not_families.0, %object
not_families.0:
	.xword	.LC1
	.xword	.LC38
	.xword	.LC39
	.xword	.LC40
	.xword	.LC41
	.xword	.LC42
	.xword	0
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
