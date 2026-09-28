	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"/var/lib/pacman/db.lck"
	.align	3
.LC1:
	.string	"\033[1;31m[-] pacman database is locked (/var/lib/pacman/db.lck).\n    Another pacman/emerge transaction is running, or a previous\n    one was interrupted. Remove the lock only if you are sure\n    nothing else is using pacman.\n\033[0m"
	.align	3
.LC2:
	.string	"\033[1;32m[+] pacman database is not locked.\n\033[0m"
	.text
	.align	2
	.p2align 5,,15
	.global	cmd_transaction_check_v2
	.type	cmd_transaction_check_v2, %function
cmd_transaction_check_v2:
	stp	x29, x30, [sp, -16]!
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	mov	x29, sp
	bl	file_exists
	cbnz	w0, .L6
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	mov	w0, 1
	ldp	x29, x30, [sp], 16
	ret
	.p2align 2,,3
.L6:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	mov	x2, 227
	mov	x1, 1
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	ret
	.section	.note.GNU-stack,"",@progbits
