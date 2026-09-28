	.arch armv7-a
	.fpu neon
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_upgrade_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_upgrade_v2, %function
cmd_upgrade_v2:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	b	cmd_world_update(PLT)
	.section	.note.GNU-stack,"",%progbits
