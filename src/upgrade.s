	.arch armv8-a
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_upgrade_v2
	.type	cmd_upgrade_v2, %function
cmd_upgrade_v2:
	b	cmd_world_update
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
