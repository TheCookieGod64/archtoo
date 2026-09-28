	.arch armv8-a
	.text
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 5,,15
	.global	main
	.type	main, %function
main:
	b	archtoo_cli_main
	.section	.note.GNU-stack,"",@progbits
