	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"-S\000"
	.align	2
.LC1:
	.ascii	"pacman -Slq 2>/dev/null | sort -u\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_completion_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_completion_v2, %function
cmd_completion_v2:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r3, #0
	ldr	r4, .L14
	sub	sp, sp, #12
	ldr	r0, .L14+4
	ldr	r5, .L14+8
.LPIC1:
	add	r4, pc
.LPIC0:
	add	r0, pc
	str	r3, [sp, #4]
.LPIC3:
	add	r5, pc
.L2:
	bl	puts(PLT)
	ldr	r0, [r4, #4]!
	cmp	r0, #0
	bne	.L2
	ldr	r0, .L14+12
	add	r1, sp, #4
.LPIC2:
	add	r0, pc
	bl	run_cmd_capture(PLT)
	mov	r3, r0
	ldr	r0, [sp, #4]
	cbnz	r3, .L3
	cbz	r0, .L3
	ldrb	r3, [r0]	@ zero_extendqisi2
	cbnz	r3, .L13
.L3:
	bl	free(PLT)
	movs	r0, #1
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L13:
	ldr	r3, .L14+16
	ldr	r3, [r5, r3]
	ldr	r1, [r3]
	bl	fputs(PLT)
	ldr	r0, [sp, #4]
	bl	free(PLT)
	movs	r0, #1
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L15:
	.align	2
.L14:
	.word	.LANCHOR0-(.LPIC1+4)
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC3+4)
	.word	.LC1-(.LPIC2+4)
	.word	stdout(GOT)
	.section	.rodata.str1.4
	.align	2
.LC2:
	.ascii	"-I\000"
	.align	2
.LC3:
	.ascii	"-Q\000"
	.align	2
.LC4:
	.ascii	"-A\000"
	.align	2
.LC5:
	.ascii	"-G\000"
	.align	2
.LC6:
	.ascii	"-B\000"
	.align	2
.LC7:
	.ascii	"-C\000"
	.align	2
.LC8:
	.ascii	"-U\000"
	.align	2
.LC9:
	.ascii	"-D\000"
	.align	2
.LC10:
	.ascii	"-v\000"
	.align	2
.LC11:
	.ascii	"-h\000"
	.align	2
.LC12:
	.ascii	"-i\000"
	.align	2
.LC13:
	.ascii	"-j\000"
	.align	2
.LC14:
	.ascii	"-r\000"
	.align	2
.LC15:
	.ascii	"-O0\000"
	.align	2
.LC16:
	.ascii	"-O1\000"
	.align	2
.LC17:
	.ascii	"-O2\000"
	.align	2
.LC18:
	.ascii	"-O3\000"
	.align	2
.LC19:
	.ascii	"-Os\000"
	.align	2
.LC20:
	.ascii	"-Ofast\000"
	.align	2
.LC21:
	.ascii	"-Og\000"
	.align	2
.LC22:
	.ascii	"-Oz\000"
	.align	2
.LC23:
	.ascii	"--help\000"
	.align	2
.LC24:
	.ascii	"--version\000"
	.align	2
.LC25:
	.ascii	"--noconfirm\000"
	.align	2
.LC26:
	.ascii	"--interactive\000"
	.align	2
.LC27:
	.ascii	"--prompt-timeout\000"
	.align	2
.LC28:
	.ascii	"--jobs\000"
	.align	2
.LC29:
	.ascii	"--raw\000"
	.align	2
.LC30:
	.ascii	"--target\000"
	.align	2
.LC31:
	.ascii	"--march\000"
	.align	2
.LC32:
	.ascii	"--cpu\000"
	.align	2
.LC33:
	.ascii	"--opt-level\000"
	.align	2
.LC34:
	.ascii	"--opt\000"
	.align	2
.LC35:
	.ascii	"--optimization\000"
	.align	2
.LC36:
	.ascii	"--pipe\000"
	.align	2
.LC37:
	.ascii	"--no-pipe\000"
	.align	2
.LC38:
	.ascii	"--gentoo-chroot\000"
	.align	2
.LC39:
	.ascii	"--imitation\000"
	.align	2
.LC40:
	.ascii	"--portage-imitation\000"
	.align	2
.LC41:
	.ascii	"--gentoo-imitation\000"
	.align	2
.LC42:
	.ascii	"--no-gentoo-chroot\000"
	.align	2
.LC43:
	.ascii	"--no-imitation\000"
	.align	2
.LC44:
	.ascii	"--chroot-path\000"
	.align	2
.LC45:
	.ascii	"--binary\000"
	.align	2
.LC46:
	.ascii	"--use-binary\000"
	.align	2
.LC47:
	.ascii	"--use-bin\000"
	.align	2
.LC48:
	.ascii	"--bin\000"
	.align	2
.LC49:
	.ascii	"--prebuilt\000"
	.align	2
.LC50:
	.ascii	"--use-prebuilt\000"
	.align	2
.LC51:
	.ascii	"--no-build\000"
	.align	2
.LC52:
	.ascii	"--no-compile\000"
	.align	2
.LC53:
	.ascii	"--no-binary\000"
	.align	2
.LC54:
	.ascii	"--no-use-binary\000"
	.align	2
.LC55:
	.ascii	"--no-bin\000"
	.align	2
.LC56:
	.ascii	"--resume\000"
	.align	2
.LC57:
	.ascii	"--no-keys\000"
	.align	2
.LC58:
	.ascii	"--no-inhibit\000"
	.align	2
.LC59:
	.ascii	"--no-sync\000"
	.align	2
.LC60:
	.ascii	"--no-aur-sync\000"
	.align	2
.LC61:
	.ascii	"--command-guide\000"
	.align	2
.LC62:
	.ascii	"--orphans\000"
	.align	2
.LC63:
	.ascii	"--clean\000"
	.align	2
.LC64:
	.ascii	"--stats\000"
	.align	2
.LC65:
	.ascii	"--news\000"
	.align	2
.LC66:
	.ascii	"--complete\000"
	.align	2
.LC67:
	.ascii	"--devel\000"
	.align	2
.LC68:
	.ascii	"--providers\000"
	.align	2
.LC69:
	.ascii	"--deps\000"
	.align	2
.LC70:
	.ascii	"--review\000"
	.align	2
.LC71:
	.ascii	"--unmerge\000"
	.align	2
.LC72:
	.ascii	"--deselect\000"
	.align	2
.LC73:
	.ascii	"--update\000"
	.section	.data.rel.ro.local,"aw"
	.align	3
	.set	.LANCHOR0,. + 0
	.type	flags.0, %object
flags.0:
	.word	.LC0
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.word	.LC46
	.word	.LC47
	.word	.LC48
	.word	.LC49
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.word	.LC60
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC65
	.word	.LC66
	.word	.LC67
	.word	.LC68
	.word	.LC69
	.word	.LC70
	.word	.LC71
	.word	.LC72
	.word	.LC73
	.word	0
	.section	.note.GNU-stack,"",%progbits
