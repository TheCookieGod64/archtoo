	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_upgrade_v2
	.type	cmd_upgrade_v2, %function
cmd_upgrade_v2:
	b	cmd_world_update
	.section	.note.GNU-stack,"",@progbits
