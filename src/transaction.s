	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"/var/lib/pacman/db.lck\000"
	.align	2
.LC1:
	.ascii	"\033[1;31m[-] pacman database is locked (/var/lib/p"
	.ascii	"acman/db.lck).\012    Another pacman/emerge transac"
	.ascii	"tion is running, or a previous\012    one was inter"
	.ascii	"rupted. Remove the lock only if you are sure\012   "
	.ascii	" nothing else is using pacman.\012\033[0m\000"
	.align	2
.LC2:
	.ascii	"\033[1;32m[+] pacman database is not locked.\012\033"
	.ascii	"[0m\000"
	.text
	.align	1
	.p2align 2,,3
	.global	cmd_transaction_check_v2
	.syntax unified
	.thumb
	.thumb_func
	.type	cmd_transaction_check_v2, %function
cmd_transaction_check_v2:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L7
	push	{r4, lr}
	ldr	r4, .L7+4
.LPIC0:
	add	r0, pc
.LPIC1:
	add	r4, pc
	bl	file_exists(PLT)
	cbnz	r0, .L6
	ldr	r0, .L7+8
.LPIC3:
	add	r0, pc
	bl	printf(PLT)
	movs	r0, #1
	pop	{r4, pc}
.L6:
	ldr	r3, .L7+12
	movs	r2, #227
	ldr	r0, .L7+16
	movs	r1, #1
.LPIC2:
	add	r0, pc
	ldr	r3, [r4, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	movs	r0, #0
	pop	{r4, pc}
.L8:
	.align	2
.L7:
	.word	.LC0-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	.LC2-(.LPIC3+4)
	.word	stderr(GOT)
	.word	.LC1-(.LPIC2+4)
	.section	.note.GNU-stack,"",%progbits
