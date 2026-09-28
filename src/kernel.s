	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s%s\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	run_priv_cmd, %function
run_priv_cmd:
	@ args = 0, pretend = 0, frame = 512
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r4, r0
	sub	sp, sp, #520
	bl	priv_prefix(PLT)
	ldr	r2, .L4
	mov	r3, r0
	mov	r1, #512
	str	r4, [sp]
	add	r4, sp, #8
.LPIC0:
	add	r2, pc
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd(PLT)
	add	sp, sp, #520
	@ sp needed
	pop	{r4, pc}
.L5:
	.align	2
.L4:
	.word	.LC0-(.LPIC0+4)
	.section	.rodata.str1.4
	.align	2
.LC1:
	.ascii	"firmware\000"
	.align	2
.LC2:
	.ascii	"linux\000"
	.align	2
.LC3:
	.ascii	"linux-\000"
	.align	2
.LC4:
	.ascii	"-headers\000"
	.align	2
.LC5:
	.ascii	"-docs\000"
	.align	2
.LC6:
	.ascii	"-firmware\000"
	.align	2
.LC7:
	.ascii	"-whence\000"
	.text
	.align	1
	.p2align 2,,3
	.global	is_kernel
	.syntax unified
	.thumb
	.thumb_func
	.type	is_kernel, %function
is_kernel:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r1, .L41
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, r0
.LPIC2:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L18
	ldr	r1, .L41+4
	movs	r2, #6
	mov	r0, r4
.LPIC3:
	add	r1, pc
	bl	strncmp(PLT)
	cbnz	r0, .L17
	ldrb	r3, [r4, #6]	@ zero_extendqisi2
	cbz	r3, .L6
	ldr	r7, .L41+8
	add	r8, r4, #6
	ldr	r6, .L41+12
	movs	r5, #8
.LPIC4:
	add	r7, pc
.LPIC1:
	add	r6, pc
.L10:
	mov	r2, r5
	mov	r1, r6
	mov	r0, r8
	bl	strncmp(PLT)
	cbnz	r0, .L8
	ldrb	r3, [r8, r5]	@ zero_extendqisi2
	cmp	r3, #45
	it	ne
	cmpne	r3, #0
	bne	.L8
.L6:
	pop	{r4, r5, r6, r7, r8, pc}
.L17:
	movs	r0, #0
	pop	{r4, r5, r6, r7, r8, pc}
.L8:
	ldr	r6, [r7, #4]!
	mov	r0, r6
	cbz	r6, .L9
	bl	strlen(PLT)
	mov	r5, r0
	b	.L10
.L11:
	cmp	r0, #5
	bhi	.L13
.L18:
	movs	r0, #1
	pop	{r4, r5, r6, r7, r8, pc}
.L9:
	mov	r0, r4
	bl	strlen(PLT)
	mov	r5, r0
	cmp	r0, #8
	bls	.L11
	ldr	r1, .L41+16
	subs	r0, r0, #8
	add	r0, r0, r4
.LPIC5:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L6
	ldr	r1, .L41+20
	subs	r0, r5, #5
	add	r0, r0, r4
.LPIC6:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L6
	cmp	r5, #9
	bne	.L40
.L14:
	ldr	r1, .L41+24
	subs	r0, r5, #7
	add	r0, r0, r4
.LPIC8:
	add	r1, pc
	bl	strcmp(PLT)
	subs	r0, r0, #0
	it	ne
	movne	r0, #1
	b	.L6
.L40:
	ldr	r1, .L41+28
	sub	r0, r5, #9
	add	r0, r0, r4
.LPIC7:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L6
	b	.L14
.L13:
	ldr	r1, .L41+32
	subs	r0, r0, #5
	add	r0, r0, r4
.LPIC9:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L6
	cmp	r5, #8
	bne	.L18
	b	.L14
.L42:
	.align	2
.L41:
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LANCHOR0-(.LPIC4+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC4-(.LPIC5+4)
	.word	.LC5-(.LPIC6+4)
	.word	.LC7-(.LPIC8+4)
	.word	.LC6-(.LPIC7+4)
	.word	.LC5-(.LPIC9+4)
	.section	.rodata.str1.4
	.align	2
.LC8:
	.ascii	"/usr/local/emerge/builds\000"
	.align	2
.LC9:
	.ascii	"for f in '%s/%s'/*.pkg.tar.*; do [ -e \"$f\" ] || c"
	.ascii	"ontinue; tar -tf \"$f\" 2>/dev/null | grep -q '^[./"
	.ascii	"]*usr/lib/modules/.*/vmlinuz' && exit 0; done; exit"
	.ascii	" 1\000"
	.text
	.align	1
	.p2align 2,,3
	.global	pkg_ships_kernel
	.syntax unified
	.thumb
	.thumb_func
	.type	pkg_ships_kernel, %function
pkg_ships_kernel:
	@ args = 0, pretend = 0, frame = 1024
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r1, #1024
	ldr	r3, .L45
	sub	sp, sp, #1032
	ldr	r2, .L45+4
	add	r4, sp, #8
.LPIC10:
	add	r3, pc
.LPIC11:
	add	r2, pc
	str	r0, [sp]
	mov	r0, r4
	bl	xsnprintf(PLT)
	mov	r0, r4
	bl	run_cmd_quiet(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	add	sp, sp, #1032
	@ sp needed
	pop	{r4, pc}
.L46:
	.align	2
.L45:
	.word	.LC8-(.LPIC10+4)
	.word	.LC9-(.LPIC11+4)
	.section	.rodata.str1.4
	.align	2
.LC10:
	.ascii	"\033[1;35m>>> [KERNEL HOOK] Kernel detected: %s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC11:
	.ascii	"mkinitcpio\000"
	.align	2
.LC12:
	.ascii	"\033[1;34m>>> [KERNEL HOOK] Generating initramfs (m"
	.ascii	"kinitcpio -P)...\012\033[0m\000"
	.align	2
.LC13:
	.ascii	"mkinitcpio -P\000"
	.align	2
.LC14:
	.ascii	"\033[1;31m[-] mkinitcpio failed -- do NOT reboot ye"
	.ascii	"t.\012\033[0m\000"
	.align	2
.LC15:
	.ascii	"dracut\000"
	.align	2
.LC16:
	.ascii	"\033[1;34m>>> [KERNEL HOOK] Generating initramfs (d"
	.ascii	"racut)...\012\033[0m\000"
	.align	2
.LC17:
	.ascii	"dracut --regenerate-all --force\000"
	.align	2
.LC18:
	.ascii	"\033[1;31m[-] dracut failed -- do NOT reboot yet.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC19:
	.ascii	"grub-mkconfig\000"
	.align	2
.LC20:
	.ascii	"/boot/grub\000"
	.align	2
.LC21:
	.ascii	"\033[1;34m>>> [KERNEL HOOK] Updating GRUB...\012\033"
	.ascii	"[0m\000"
	.align	2
.LC22:
	.ascii	"grub-mkconfig -o /boot/grub/grub.cfg\000"
	.align	2
.LC23:
	.ascii	"\033[1;31m[-] grub-mkconfig failed.\012\033[0m\000"
	.align	2
.LC24:
	.ascii	"/boot/loader/entries\000"
	.align	2
.LC25:
	.ascii	"bootctl\000"
	.align	2
.LC26:
	.ascii	"\033[1;34m>>> [KERNEL HOOK] systemd-boot detected.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC27:
	.ascii	"bootctl update || true\000"
	.align	2
.LC28:
	.ascii	"/boot/refind_linux.conf\000"
	.align	2
.LC29:
	.ascii	"\033[1;33m[!] rEFInd detected -- verify /boot/refin"
	.ascii	"d_linux.conf.\012\033[0m\000"
	.align	2
.LC30:
	.ascii	"/boot/EFI/refind\000"
	.align	2
.LC31:
	.ascii	"/boot/limine.conf\000"
	.align	2
.LC32:
	.ascii	"\033[1;33m[!] Limine detected -- verify your limine"
	.ascii	" config.\012\033[0m\000"
	.align	2
.LC33:
	.ascii	"/boot/limine.cfg\000"
	.align	2
.LC34:
	.ascii	"\033[1;33m[!] No known bootloader found. Update you"
	.ascii	"r boot entries manually.\012\033[0m\000"
	.align	2
.LC35:
	.ascii	"sbctl\000"
	.align	2
.LC36:
	.ascii	"\033[1;33m[!] sbctl present: re-sign the new kernel"
	.ascii	" if Secure Boot is on.\012\033[0m\000"
	.align	2
.LC37:
	.ascii	"\033[1;32m[+] Kernel hooks processed.\012\033[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	run_kernel_hooks
	.syntax unified
	.thumb
	.thumb_func
	.type	run_kernel_hooks, %function
run_kernel_hooks:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, r0
	ldr	r0, .L87
	push	{r3, r4, r5, lr}
.LPIC12:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L87+4
	ldr	r4, .L87+8
.LPIC13:
	add	r0, pc
.LPIC16:
	add	r4, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	beq	.L48
	ldr	r0, .L87+12
.LPIC14:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L87+16
.LPIC15:
	add	r0, pc
	bl	run_priv_cmd(PLT)
	cmp	r0, #0
	bne	.L83
.L50:
	ldr	r0, .L87+20
.LPIC22:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	bne	.L52
.L54:
	movs	r5, #0
.L53:
	ldr	r0, .L87+24
.LPIC27:
	add	r0, pc
	bl	dir_exists(PLT)
	cmp	r0, #0
	bne	.L84
.L59:
	ldr	r0, .L87+28
.LPIC31:
	add	r0, pc
	bl	file_exists(PLT)
	cbnz	r0, .L62
	ldr	r0, .L87+32
.LPIC33:
	add	r0, pc
	bl	dir_exists(PLT)
	cbnz	r0, .L62
.L61:
	ldr	r0, .L87+36
.LPIC34:
	add	r0, pc
	bl	file_exists(PLT)
	cbnz	r0, .L65
	ldr	r0, .L87+40
.LPIC36:
	add	r0, pc
	bl	file_exists(PLT)
	cmp	r0, #0
	beq	.L85
.L65:
	ldr	r0, .L87+44
.LPIC35:
	add	r0, pc
	bl	printf(PLT)
.L64:
	ldr	r0, .L87+48
.LPIC38:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	bne	.L86
.L66:
	ldr	r0, .L87+52
	pop	{r3, r4, r5, lr}
.LPIC40:
	add	r0, pc
	b	printf(PLT)
.L62:
	ldr	r0, .L87+56
	movs	r5, #1
.LPIC32:
	add	r0, pc
	bl	printf(PLT)
	b	.L61
.L48:
	ldr	r0, .L87+60
.LPIC18:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	beq	.L50
	ldr	r0, .L87+64
.LPIC19:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L87+68
.LPIC20:
	add	r0, pc
	bl	run_priv_cmd(PLT)
	cmp	r0, #0
	beq	.L50
	ldr	r3, .L87+72
	movs	r2, #51
	ldr	r0, .L87+76
	movs	r1, #1
.LPIC21:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L50
.L85:
	cmp	r5, #0
	bne	.L64
	ldr	r3, .L87+72
	movs	r2, #77
	ldr	r0, .L87+80
	movs	r1, #1
.LPIC37:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L64
.L86:
	ldr	r0, .L87+84
.LPIC39:
	add	r0, pc
	bl	printf(PLT)
	b	.L66
.L84:
	ldr	r0, .L87+88
.LPIC28:
	add	r0, pc
	bl	have_cmd(PLT)
	cmp	r0, #0
	beq	.L59
	ldr	r0, .L87+92
	movs	r5, #1
.LPIC29:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L87+96
.LPIC30:
	add	r0, pc
	bl	run_priv_cmd(PLT)
	b	.L59
.L52:
	ldr	r0, .L87+100
.LPIC23:
	add	r0, pc
	bl	dir_exists(PLT)
	cmp	r0, #0
	beq	.L54
	ldr	r0, .L87+104
.LPIC24:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L87+108
.LPIC25:
	add	r0, pc
	bl	run_priv_cmd(PLT)
	cbnz	r0, .L55
.L56:
	movs	r5, #1
	b	.L53
.L83:
	ldr	r3, .L87+72
	movs	r2, #55
	ldr	r0, .L87+112
	movs	r1, #1
.LPIC17:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L50
.L55:
	ldr	r3, .L87+72
	movs	r2, #37
	ldr	r0, .L87+116
	movs	r1, #1
.LPIC26:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L56
.L88:
	.align	2
.L87:
	.word	.LC10-(.LPIC12+4)
	.word	.LC11-(.LPIC13+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC16+4)
	.word	.LC12-(.LPIC14+4)
	.word	.LC13-(.LPIC15+4)
	.word	.LC19-(.LPIC22+4)
	.word	.LC24-(.LPIC27+4)
	.word	.LC28-(.LPIC31+4)
	.word	.LC30-(.LPIC33+4)
	.word	.LC31-(.LPIC34+4)
	.word	.LC33-(.LPIC36+4)
	.word	.LC32-(.LPIC35+4)
	.word	.LC35-(.LPIC38+4)
	.word	.LC37-(.LPIC40+4)
	.word	.LC29-(.LPIC32+4)
	.word	.LC15-(.LPIC18+4)
	.word	.LC16-(.LPIC19+4)
	.word	.LC17-(.LPIC20+4)
	.word	stderr(GOT)
	.word	.LC18-(.LPIC21+4)
	.word	.LC34-(.LPIC37+4)
	.word	.LC36-(.LPIC39+4)
	.word	.LC25-(.LPIC28+4)
	.word	.LC26-(.LPIC29+4)
	.word	.LC27-(.LPIC30+4)
	.word	.LC20-(.LPIC23+4)
	.word	.LC21-(.LPIC24+4)
	.word	.LC22-(.LPIC25+4)
	.word	.LC14-(.LPIC17+4)
	.word	.LC23-(.LPIC26+4)
	.section	.rodata.str1.4
	.align	2
.LC38:
	.ascii	"api-headers\000"
	.align	2
.LC39:
	.ascii	"tools\000"
	.align	2
.LC40:
	.ascii	"docs\000"
	.align	2
.LC41:
	.ascii	"wifi\000"
	.align	2
.LC42:
	.ascii	"atm\000"
	.section	.data.rel.ro.local,"aw"
	.align	3
	.set	.LANCHOR0,. + 0
	.type	not_families.0, %object
not_families.0:
	.word	.LC1
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	0
	.section	.note.GNU-stack,"",%progbits
