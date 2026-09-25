	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"-S"
	.align	3
.LC1:
	.string	"pacman -Slq 2>/dev/null | sort -u"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_completion_v2
	.type	cmd_completion_v2, %function
cmd_completion_v2:
	stp	x29, x30, [sp, -48]!
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	str	x19, [sp, 16]
	adrp	x19, .LANCHOR0
	add	x19, x19, :lo12:.LANCHOR0
	str	xzr, [sp, 40]
	add	x19, x19, 8
	.p2align 5,,15
.L2:
	bl	puts
	ldr	x0, [x19], 8
	cbnz	x0, .L2
	add	x1, sp, 40
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	run_cmd_capture
	mov	w1, w0
	ldr	x0, [sp, 40]
	cbnz	w1, .L4
	cbz	x0, .L4
	ldrb	w1, [x0]
	cbnz	w1, .L15
.L4:
	bl	free
	ldr	x19, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 48
	ret
	.p2align 2,,3
.L15:
	adrp	x1, :got:stdout
	ldr	x1, [x1, :got_lo12:stdout]
	ldr	x1, [x1]
	bl	fputs
	ldr	x0, [sp, 40]
	bl	free
	ldr	x19, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 48
	ret
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"-I"
	.align	3
.LC3:
	.string	"-Q"
	.align	3
.LC4:
	.string	"-A"
	.align	3
.LC5:
	.string	"-G"
	.align	3
.LC6:
	.string	"-B"
	.align	3
.LC7:
	.string	"-C"
	.align	3
.LC8:
	.string	"-U"
	.align	3
.LC9:
	.string	"-D"
	.align	3
.LC10:
	.string	"-v"
	.align	3
.LC11:
	.string	"-h"
	.align	3
.LC12:
	.string	"-i"
	.align	3
.LC13:
	.string	"-j"
	.align	3
.LC14:
	.string	"-r"
	.align	3
.LC15:
	.string	"-O0"
	.align	3
.LC16:
	.string	"-O1"
	.align	3
.LC17:
	.string	"-O2"
	.align	3
.LC18:
	.string	"-O3"
	.align	3
.LC19:
	.string	"-Os"
	.align	3
.LC20:
	.string	"-Ofast"
	.align	3
.LC21:
	.string	"-Og"
	.align	3
.LC22:
	.string	"-Oz"
	.align	3
.LC23:
	.string	"--help"
	.align	3
.LC24:
	.string	"--version"
	.align	3
.LC25:
	.string	"--noconfirm"
	.align	3
.LC26:
	.string	"--interactive"
	.align	3
.LC27:
	.string	"--prompt-timeout"
	.align	3
.LC28:
	.string	"--jobs"
	.align	3
.LC29:
	.string	"--target"
	.align	3
.LC30:
	.string	"--march"
	.align	3
.LC31:
	.string	"--cpu"
	.align	3
.LC32:
	.string	"--opt-level"
	.align	3
.LC33:
	.string	"--opt"
	.align	3
.LC34:
	.string	"--optimization"
	.align	3
.LC35:
	.string	"--pipe"
	.align	3
.LC36:
	.string	"--no-pipe"
	.align	3
.LC37:
	.string	"--gentoo-chroot"
	.align	3
.LC38:
	.string	"--imitation"
	.align	3
.LC39:
	.string	"--portage-imitation"
	.align	3
.LC40:
	.string	"--gentoo-imitation"
	.align	3
.LC41:
	.string	"--no-gentoo-chroot"
	.align	3
.LC42:
	.string	"--no-imitation"
	.align	3
.LC43:
	.string	"--chroot-path"
	.align	3
.LC44:
	.string	"--binary"
	.align	3
.LC45:
	.string	"--use-binary"
	.align	3
.LC46:
	.string	"--use-bin"
	.align	3
.LC47:
	.string	"--bin"
	.align	3
.LC48:
	.string	"--prebuilt"
	.align	3
.LC49:
	.string	"--use-prebuilt"
	.align	3
.LC50:
	.string	"--no-build"
	.align	3
.LC51:
	.string	"--no-compile"
	.align	3
.LC52:
	.string	"--no-binary"
	.align	3
.LC53:
	.string	"--no-use-binary"
	.align	3
.LC54:
	.string	"--no-bin"
	.align	3
.LC55:
	.string	"--resume"
	.align	3
.LC56:
	.string	"--no-keys"
	.align	3
.LC57:
	.string	"--no-inhibit"
	.align	3
.LC58:
	.string	"--no-sync"
	.align	3
.LC59:
	.string	"--no-aur-sync"
	.align	3
.LC60:
	.string	"--command-guide"
	.align	3
.LC61:
	.string	"--orphans"
	.align	3
.LC62:
	.string	"--clean"
	.align	3
.LC63:
	.string	"--stats"
	.align	3
.LC64:
	.string	"--news"
	.align	3
.LC65:
	.string	"--complete"
	.align	3
.LC66:
	.string	"--devel"
	.align	3
.LC67:
	.string	"--providers"
	.align	3
.LC68:
	.string	"--deps"
	.align	3
.LC69:
	.string	"--review"
	.align	3
.LC70:
	.string	"--unmerge"
	.align	3
.LC71:
	.string	"--deselect"
	.align	3
.LC72:
	.string	"--update"
	.section	.data.rel.ro.local,"aw"
	.align	4
	.set	.LANCHOR0,. + 0
	.type	flags.0, %object
flags.0:
	.xword	.LC0
	.xword	.LC2
	.xword	.LC3
	.xword	.LC4
	.xword	.LC5
	.xword	.LC6
	.xword	.LC7
	.xword	.LC8
	.xword	.LC9
	.xword	.LC10
	.xword	.LC11
	.xword	.LC12
	.xword	.LC13
	.xword	.LC14
	.xword	.LC15
	.xword	.LC16
	.xword	.LC17
	.xword	.LC18
	.xword	.LC19
	.xword	.LC20
	.xword	.LC21
	.xword	.LC22
	.xword	.LC23
	.xword	.LC24
	.xword	.LC25
	.xword	.LC26
	.xword	.LC27
	.xword	.LC28
	.xword	.LC29
	.xword	.LC30
	.xword	.LC31
	.xword	.LC32
	.xword	.LC33
	.xword	.LC34
	.xword	.LC35
	.xword	.LC36
	.xword	.LC37
	.xword	.LC38
	.xword	.LC39
	.xword	.LC40
	.xword	.LC41
	.xword	.LC42
	.xword	.LC43
	.xword	.LC44
	.xword	.LC45
	.xword	.LC46
	.xword	.LC47
	.xword	.LC48
	.xword	.LC49
	.xword	.LC50
	.xword	.LC51
	.xword	.LC52
	.xword	.LC53
	.xword	.LC54
	.xword	.LC55
	.xword	.LC56
	.xword	.LC57
	.xword	.LC58
	.xword	.LC59
	.xword	.LC60
	.xword	.LC61
	.xword	.LC62
	.xword	.LC63
	.xword	.LC64
	.xword	.LC65
	.xword	.LC66
	.xword	.LC67
	.xword	.LC68
	.xword	.LC69
	.xword	.LC70
	.xword	.LC71
	.xword	.LC72
	.xword	0
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
