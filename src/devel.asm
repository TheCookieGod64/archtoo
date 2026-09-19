; devel.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern fwrite
extern printf
extern puts
extern run_cmd_capture
extern stderr
extern strchr
extern strlen
extern strstr
; NASM assembly - converted from C: src/devel.c
%use smartalign
section .text
section .rodata
LC0:
	db "pacman -Qmq", 0
section .rodata
LC1:
	db "\033[1;31m[-] Could not list foreign packages.\n\033[0m", 0
LC2:
	db "\033[1;36m>>> Development / VCS packages (-git/-hg/-svn/-bzr/-cvs)\n\033[0m", 0
section .rodata
LC3:
	db "-git", 0
LC4:
	db "-hg", 0
LC5:
	db "-svn", 0
LC6:
	db "-bzr", 0
LC7:
	db "-cvs", 0
section .rodata
LC8:
	db "No development packages installed.", 0
global cmd_devel_v2
cmd_devel_v2:
	push	r13
	mov	edi, LC0
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 184
	mov	qword [rsp+8], 0
	lea	rsi, [rsp+8]
	call	run_cmd_capture
	cmp	eax, 1
	ja	.L44
	mov	edi, LC2
	xor	eax, eax
	call	printf
	mov	rbp, qword [rsp+8]
	test	rbp, rbp
	je	.L4
	cmp	byte [rbp+0], 0
	je	.L4
	xor	r13d, r13d
	lea	r12, [rsp+16]
	jmp	.L5
.L45:
	sub	rax, rbp
	lea	rdx, [rax-1]
	cmp	rdx, 158
	jbe	.L8
.L9:
	cmp	byte [rbx+1], 0
	lea	rbp, [rbx+1]
	je	.L17
.L5:
	mov	esi, 10
	mov	rdi, rbp
	call	strchr
	mov	rbx, rax
	test	rax, rax
	jne	.L45
	mov	rdi, rbp
	call	strlen
	lea	rdx, [rax-1]
	cmp	rdx, 158
	jbe	.L8
.L17:
	mov	rdi, qword [rsp+8]
	call	free
	test	r13d, r13d
	je	.L6
	mov	eax, 1
.L47:
	add	rsp, 184
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L8:
	mov	r8d, eax
	mov	rdi, r12
	cmp	eax, 8
	jb	.L11
	mov	ecx, eax
	mov	rsi, rbp
	shr	ecx, 3
	rep movsq
	mov	rbp, rsi
.L11:
	xor	edx, edx
	test	r8b, 4
	je	.L12
	mov	edx, dword [rbp+0]
	mov	dword [rdi], edx
	mov	edx, 4
.L12:
	test	r8b, 2
	je	.L13
	movzx	ecx, word [rbp+0+rdx]
	mov	word [rdi+rdx], cx
	add	rdx, 2
.L13:
	and	r8d, 1
	je	.L14
	movzx	ecx, byte [rbp+0+rdx]
	mov	byte [rdi+rdx], cl
.L14:
	mov	esi, LC3
	mov	rdi, r12
	mov	byte [rsp+16+rax], 0
	call	strstr
	test	rax, rax
	je	.L46
.L15:
	mov	rdi, r12
	mov	r13d, 1
	call	puts
.L16:
	test	rbx, rbx
	jne	.L9
	jmp	.L17
.L46:
	mov	esi, LC4
	mov	rdi, r12
	call	strstr
	test	rax, rax
	jne	.L15
	mov	esi, LC5
	mov	rdi, r12
	call	strstr
	test	rax, rax
	jne	.L15
	mov	esi, LC6
	mov	rdi, r12
	call	strstr
	test	rax, rax
	jne	.L15
	mov	esi, LC7
	mov	rdi, r12
	call	strstr
	test	rax, rax
	jne	.L15
	jmp	.L16
.L44:
	mov	edx, 48
	mov	esi, 1
	mov	edi, LC1
	mov	rcx, qword [rel stderr]
	call	fwrite
	mov	rdi, qword [rsp+8]
	call	free
	add	rsp, 184
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L4:
	mov	rdi, rbp
	call	free
.L6:
	mov	edi, LC8
	call	puts
	mov	eax, 1
	jmp	.L47
