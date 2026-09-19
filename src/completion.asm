; completion.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern pipe
extern puts
extern run_cmd_capture
extern stdout
; NASM assembly - converted from C: src/completion.c
%use smartalign
section .text
section .rodata
LC0:
	db "-S", 0
section .rodata
LC1:
	db "pacman -Slq 2>/dev/null | sort -u", 0
global cmd_completion_v2
cmd_completion_v2:
	push	rbx
	mov	edi, LC0
	mov	ebx, flags.0+8
	sub	rsp, 16
	mov	qword [rsp+8], 0
.L2:
	call	puts
	mov	rdi, qword [rbx]
	add	rbx, 8
	test	rdi, rdi
	jne	.L2
	mov	edi, LC1
	lea	rsi, [rsp+8]
	call	run_cmd_capture
	mov	rdi, qword [rsp+8]
	test	eax, eax
	jne	.L3
	test	rdi, rdi
	je	.L3
	cmp	byte [rdi], 0
	jne	.L10
.L3:
	call	free
	add	rsp, 16
	mov	eax, 1
	pop	rbx
	ret
.L10:
	mov	rsi, qword [rel stdout]
	call	fputs
	mov	rdi, qword [rsp+8]
	call	free
	add	rsp, 16
	mov	eax, 1
	pop	rbx
	ret
section .rodata
LC2:
	db "-I", 0
LC3:
	db "-Q", 0
LC4:
	db "-A", 0
LC5:
	db "-G", 0
LC6:
	db "-B", 0
LC7:
	db "-C", 0
LC8:
	db "-U", 0
LC9:
	db "-D", 0
LC10:
	db "-v", 0
LC11:
	db "-h", 0
LC12:
	db "-i", 0
LC13:
	db "-j", 0
LC14:
	db "-r", 0
LC15:
	db "-O0", 0
LC16:
	db "-O1", 0
LC17:
	db "-O2", 0
LC18:
	db "-O3", 0
LC19:
	db "-Os", 0
LC20:
	db "-Ofast", 0
LC21:
	db "-Og", 0
LC22:
	db "-Oz", 0
LC23:
	db "--help", 0
LC24:
	db "--version", 0
LC25:
	db "--noconfirm", 0
LC26:
	db "--interactive", 0
LC27:
	db "--prompt-timeout", 0
LC28:
	db "--jobs", 0
LC29:
	db "--target", 0
LC30:
	db "--march", 0
LC31:
	db "--cpu", 0
LC32:
	db "--opt-level", 0
LC33:
	db "--opt", 0
LC34:
	db "--optimization", 0
LC35:
	db "--pipe", 0
LC36:
	db "--no-pipe", 0
LC37:
	db "--gentoo-chroot", 0
LC38:
	db "--imitation", 0
LC39:
	db "--portage-imitation", 0
LC40:
	db "--gentoo-imitation", 0
LC41:
	db "--no-gentoo-chroot", 0
LC42:
	db "--no-imitation", 0
LC43:
	db "--chroot-path", 0
LC44:
	db "--binary", 0
LC45:
	db "--use-binary", 0
LC46:
	db "--use-bin", 0
LC47:
	db "--bin", 0
LC48:
	db "--prebuilt", 0
LC49:
	db "--use-prebuilt", 0
LC50:
	db "--no-build", 0
LC51:
	db "--no-compile", 0
LC52:
	db "--no-binary", 0
LC53:
	db "--no-use-binary", 0
LC54:
	db "--no-bin", 0
LC55:
	db "--resume", 0
LC56:
	db "--no-keys", 0
LC57:
	db "--no-inhibit", 0
LC58:
	db "--no-sync", 0
LC59:
	db "--no-aur-sync", 0
LC60:
	db "--command-guide", 0
LC61:
	db "--orphans", 0
LC62:
	db "--clean", 0
LC63:
	db "--stats", 0
LC64:
	db "--news", 0
LC65:
	db "--complete", 0
LC66:
	db "--devel", 0
LC67:
	db "--providers", 0
LC68:
	db "--deps", 0
LC69:
	db "--review", 0
LC70:
	db "--unmerge", 0
LC71:
	db "--deselect", 0
LC72:
	db "--update", 0
section .rodata
flags.0:
	dq LC0
	dq LC2
	dq LC3
	dq LC4
	dq LC5
	dq LC6
	dq LC7
	dq LC8
	dq LC9
	dq LC10
	dq LC11
	dq LC12
	dq LC13
	dq LC14
	dq LC15
	dq LC16
	dq LC17
	dq LC18
	dq LC19
	dq LC20
	dq LC21
	dq LC22
	dq LC23
	dq LC24
	dq LC25
	dq LC26
	dq LC27
	dq LC28
	dq LC29
	dq LC30
	dq LC31
	dq LC32
	dq LC33
	dq LC34
	dq LC35
	dq LC36
	dq LC37
	dq LC38
	dq LC39
	dq LC40
	dq LC41
	dq LC42
	dq LC43
	dq LC44
	dq LC45
	dq LC46
	dq LC47
	dq LC48
	dq LC49
	dq LC50
	dq LC51
	dq LC52
	dq LC53
	dq LC54
	dq LC55
	dq LC56
	dq LC57
	dq LC58
	dq LC59
	dq LC60
	dq LC61
	dq LC62
	dq LC63
	dq LC64
	dq LC65
	dq LC66
	dq LC67
	dq LC68
	dq LC69
	dq LC70
	dq LC71
	dq LC72
	dq 0
