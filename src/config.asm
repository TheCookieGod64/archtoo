; config.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern __errno_location
extern open
extern pipe
extern snprintf
extern strchr
extern strcmp
extern strerror
extern strlen
extern strncmp
extern strtol
; NASM assembly - converted from C: src/config.c
%use smartalign
section .text
section .rodata
LC0:
	db "true", 0
LC1:
	db "yes", 0
LC2:
	db "enabled", 0
LC3:
	db "false", 0
LC4:
	db "disabled", 0
parse_switch:
	push	rbp
	mov	rbp, rsi
	mov	esi, LC0
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	call	strcmp
	test	eax, eax
	je	.L2
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	jne	.L24
.L2:
	mov	dword [rbp+0], 1
.L7:
	mov	eax, 1
.L1:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L24:
	mov	esi, LC2
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L2
	mov	esi, LC3
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L5
	cmp	byte [rbx], 110
	jne	.L9
	cmp	byte [rbx+1], 111
	jne	.L9
	cmp	byte [rbx+2], 0
	je	.L5
.L9:
	mov	esi, LC4
	mov	rdi, rbx
	call	strcmp
	mov	edx, eax
	xor	eax, eax
	test	edx, edx
	jne	.L1
.L5:
	mov	dword [rbp+0], 0
	jmp	.L7
error_format:
	sub	rsp, 216
	mov	qword [rsp+56], rcx
	mov	qword [rsp+64], r8
	mov	qword [rsp+72], r9
	test	al, al
	je	.L28
	movaps	oword [rsp+80], xmm0
	movaps	oword [rsp+96], xmm1
	movaps	oword [rsp+112], xmm2
	movaps	oword [rsp+128], xmm3
	movaps	oword [rsp+144], xmm4
	movaps	oword [rsp+160], xmm5
	movaps	oword [rsp+176], xmm6
	movaps	oword [rsp+192], xmm7
.L28:
	test	rdi, rdi
	je	.L25
	test	rsi, rsi
	je	.L25
	lea	rax, [rsp+224]
	lea	rcx, [rsp+8]
	mov	dword [rsp+8], 24
	mov	qword [rsp+16], rax
	lea	rax, [rsp+32]
	mov	dword [rsp+12], 48
	mov	qword [rsp+24], rax
	call	vsnprintf
.L25:
	add	rsp, 216
	ret
section .rodata
LC6:
	db "/usr/local/emerge", 0
LC7:
	db "%s/gentoo-chroot", 0
global config_defaults
config_defaults:
	test	rdi, rdi
	je	.L36
	push	rbx
	mov	rbx, rdi
	lea	rdi, [rdi+8]
	movdqa	xmm0, oword [rel LC8]
	mov	rcx, rbx
	xor	eax, eax
	mov	edx, LC7
	mov	esi, 512
	mov	qword [rdi-8], 0
	mov	qword [rdi+944], 0
	and	rdi, -8
	sub	rcx, rdi
	add	ecx, 960
	shr	ecx, 3
	rep stosq
	movups	oword [rbx+20], xmm0
	mov	eax, 51
	movdqa	xmm0, oword [rel LC9]
	mov	dword [rbx+276], 1769234798
	lea	rdi, [rbx+436]
	mov	ecx, LC6
	mov	word [rbx+404], ax
	xor	eax, eax
	movups	oword [rbx+36], xmm0
	movdqa	xmm0, oword [rel LC5]
	mov	dword [rbx], 1
	mov	qword [rbx+8], 300
	mov	byte [rbx+52], 0
	mov	dword [rbx+279], 6649449
	movups	oword [rbx+420], xmm0
	call	snprintf
	mov	qword [rbx+948], 0
	pop	rbx
	ret
.L36:
	ret
section .rodata
LC10:
	db "XDG_CONFIG_HOME", 0
LC11:
	db "%s/archtoo/config", 0
LC12:
	db "%s/.config/archtoo/config", 0
section .rodata
LC13:
	db "cannot determine invoking user's config path", 0
section .rodata
LC14:
	db "r", 0
LC15:
	db "cannot open config: %s", 0
LC16:
	db "config line %lu has no '='", 0
LC17:
	db "emerge_confirm", 0
LC18:
	db "pacman_confirm", 0
LC19:
	db "prompt_timeout", 0
LC20:
	db "welcome_policy", 0
LC21:
	db "command_guide", 0
LC22:
	db "aur_rpc_url", 0
LC23:
	db "https://", 0
LC24:
	db "%s", 0
LC25:
	db "target_arch", 0
LC26:
	db "target", 0
LC27:
	db "march", 0
LC28:
	db "cpu", 0
LC29:
	db "opt_level", 0
LC30:
	db "opt", 0
LC31:
	db "optimization", 0
LC32:
	db "o", 0
LC33:
	db "pipe", 0
LC34:
	db "use_pipe", 0
LC35:
	db "gentoo_chroot", 0
LC36:
	db "portage_chroot", 0
LC37:
	db "imitation", 0
LC38:
	db "portage_imitation", 0
LC39:
	db "gentoo_imitation", 0
LC40:
	db "gentoo_chroot_path", 0
LC41:
	db "chroot_path", 0
LC42:
	db "binary", 0
LC43:
	db "use_binary", 0
LC44:
	db "use_bin", 0
LC45:
	db "bin", 0
LC46:
	db "prebuilt", 0
LC47:
	db "use_prebuilt", 0
LC48:
	db "no_build", 0
LC49:
	db "no-build", 0
section .rodata
LC50:
	db "unknown config key on line %lu: %s", 0
LC51:
	db "invalid value for %s on line %lu: %s", 0
section .rodata
LC52:
	db "error reading config: %s", 0
global config_load
config_load:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 2120
	mov	qword [rsp], rdx
	test	rdi, rdi
	je	.L40
	mov	qword [rdi], 0
	mov	rbp, rdi
	lea	rdi, [rdi+8]
	xor	eax, eax
	mov	rcx, rbp
	movdqa	xmm0, oword [rel LC8]
	mov	rbx, rsi
	mov	edx, LC7
	mov	qword [rdi+944], 0
	and	rdi, -8
	mov	esi, 512
	sub	rcx, rdi
	add	ecx, 960
	shr	ecx, 3
	rep stosq
	lea	rax, [rbp+20]
	movups	oword [rbp+20], xmm0
	mov	ecx, 51
	movdqa	xmm0, oword [rel LC9]
	mov	qword [rsp+16], rax
	lea	rax, [rbp+276]
	mov	qword [rsp+24], rax
	lea	rax, [rbp+404]
	mov	dword [rbp+276], 1769234798
	mov	word [rbp+404], cx
	mov	ecx, LC6
	movups	oword [rbp+36], xmm0
	movdqa	xmm0, oword [rel LC5]
	mov	dword [rbp+0], 1
	mov	qword [rbp+8], 300
	mov	byte [rbp+52], 0
	mov	dword [rbp+279], 6649449
	mov	qword [rsp+32], rax
	lea	rax, [rbp+436]
	mov	qword [rsp+40], rax
	mov	rdi, rax
	xor	eax, eax
	movups	oword [rbp+420], xmm0
	call	snprintf
	mov	qword [rbp+948], 0
	call	build_user
	test	rax, rax
	je	.L229
	mov	rdi, rax
	call	getpwnam
	mov	edi, LC10
	mov	r12, rax
	call	getenv
	mov	r13, rax
	test	r12, r12
	je	.L42
	mov	rcx, qword [r12+32]
	test	rcx, rcx
	je	.L42
	test	rax, rax
	je	.L43
	cmp	byte [rax], 0
	jne	.L230
.L43:
	lea	r12, [rsp+64]
	mov	edx, LC12
	mov	esi, 1024
	xor	eax, eax
	mov	rdi, r12
	call	snprintf
.L45:
	mov	rdi, r12
	mov	esi, LC14
	call	fopen
	mov	r12, rax
	test	rax, rax
	je	.L231
	mov	qword [rsp+8], rbx
	xor	r13d, r13d
.L47:
	mov	rdx, r12
	mov	esi, 1024
	lea	rdi, [rsp+1088]
	call	fgets
	test	rax, rax
	je	.L232
	call	__ctype_b_loc
	add	r13, 1
	lea	r15, [rsp+1088]
	mov	r14, qword [rax]
	movzx	eax, byte [rsp+1088]
	test	byte [r14+1+rax*2], 32
	je	.L49
.L50:
	movzx	eax, byte [r15+1]
	add	r15, 1
	test	byte [r14+1+rax*2], 32
	jne	.L50
.L49:
	mov	rdi, r15
	call	strlen
	add	rax, r15
	cmp	r15, rax
	jb	.L51
	jmp	.L52
.L53:
	sub	rax, 1
	cmp	rax, r15
	je	.L52
.L51:
	movzx	edx, byte [rax-1]
	test	byte [r14+1+rdx*2], 32
	jne	.L53
.L52:
	mov	byte [rax], 0
	movzx	eax, byte [r15]
	test	al, al
	je	.L47
	cmp	al, 35
	je	.L47
	mov	esi, 61
	mov	rdi, r15
	call	strchr
	test	rax, rax
	je	.L233
	mov	byte [rax], 0
	lea	rbx, [rax+1]
	movzx	eax, byte [rax+1]
	test	byte [r14+1+rax*2], 32
	je	.L57
.L58:
	movzx	eax, byte [rbx+1]
	add	rbx, 1
	test	byte [r14+1+rax*2], 32
	jne	.L58
.L57:
	mov	rdi, rbx
	call	strlen
	add	rax, rbx
	cmp	rbx, rax
	jb	.L59
	jmp	.L60
.L61:
	sub	rax, 1
	cmp	rbx, rax
	je	.L60
.L59:
	movzx	edx, byte [rax-1]
	test	byte [r14+1+rdx*2], 32
	jne	.L61
.L60:
	mov	byte [rax], 0
	movzx	eax, byte [r15]
	test	byte [r14+1+rax*2], 32
	je	.L62
.L63:
	movzx	eax, byte [r15+1]
	add	r15, 1
	test	byte [r14+1+rax*2], 32
	jne	.L63
.L62:
	mov	rdi, r15
	call	strlen
	add	rax, r15
	cmp	r15, rax
	jb	.L64
	jmp	.L65
.L66:
	sub	rax, 1
	cmp	r15, rax
	je	.L65
.L64:
	movzx	edx, byte [rax-1]
	test	byte [r14+1+rdx*2], 32
	jne	.L66
.L65:
	mov	byte [rax], 0
	mov	esi, 35
	mov	rdi, rbx
	call	strchr
	test	rax, rax
	je	.L67
	mov	byte [rax], 0
	movzx	eax, byte [rbx]
	test	byte [r14+1+rax*2], 32
	je	.L68
.L69:
	movzx	eax, byte [rbx+1]
	add	rbx, 1
	test	byte [r14+1+rax*2], 32
	jne	.L69
.L68:
	mov	rdi, rbx
	call	strlen
	add	rax, rbx
	cmp	rbx, rax
	jb	.L70
	jmp	.L71
.L72:
	sub	rax, 1
	cmp	rax, rbx
	je	.L71
.L70:
	movzx	edx, byte [rax-1]
	test	byte [r14+1+rdx*2], 32
	jne	.L72
.L71:
	mov	byte [rax], 0
.L67:
	mov	esi, LC17
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L234
	mov	esi, LC18
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L235
	mov	esi, LC19
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L236
	mov	esi, LC20
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L78
	mov	esi, LC21
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L78
	mov	esi, LC22
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L237
	mov	esi, LC25
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L81
	mov	esi, LC26
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L81
	mov	esi, LC27
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L81
	mov	esi, LC28
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L81
	mov	esi, LC29
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L83
	mov	esi, LC30
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L83
	mov	esi, LC31
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L83
	mov	esi, LC32
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L83
	mov	esi, LC33
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L87
	mov	esi, LC34
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L87
	mov	esi, LC35
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L91
	mov	esi, LC36
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L91
	mov	esi, LC37
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L91
	mov	esi, LC38
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L91
	mov	esi, LC39
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L91
	mov	esi, LC40
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L94
	mov	esi, LC41
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L94
	mov	esi, LC42
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC43
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC44
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC45
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC46
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC47
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC48
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	je	.L96
	mov	esi, LC49
	mov	rdi, r15
	call	strcmp
	test	eax, eax
	jne	.L97
.L96:
	lea	rsi, [rsp+56]
	mov	rdi, rbx
	call	parse_switch
	test	eax, eax
	je	.L90
	mov	dword [rbp+952], 1
	mov	eax, dword [rsp+56]
	mov	dword [rbp+948], eax
	jmp	.L47
.L234:
	mov	rsi, rbp
	mov	rdi, rbx
	call	parse_switch
	test	eax, eax
	jne	.L47
.L90:
	mov	r14, rbx
	mov	rbx, qword [rsp+8]
	mov	rsi, qword [rsp]
	mov	r8, r13
	mov	r9, r14
	mov	rcx, r15
	mov	edx, LC51
	xor	eax, eax
	mov	rdi, rbx
	call	error_format
	mov	rdi, r12
	call	fclose
.L40:
	xor	eax, eax
.L39:
	add	rsp, 2120
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L229:
	mov	edi, LC10
	call	getenv
.L42:
	mov	rsi, qword [rsp]
	mov	edx, LC13
	mov	rdi, rbx
	xor	eax, eax
	call	error_format
	jmp	.L40
.L78:
	lea	rsi, [rbp+16]
	mov	rdi, rbx
	call	guide_policy_parse
	test	eax, eax
	je	.L90
	jmp	.L47
.L235:
	lea	rsi, [rbp+4]
	mov	rdi, rbx
	call	parse_switch
	test	eax, eax
	je	.L90
	jmp	.L47
.L230:
	call	geteuid
	test	eax, eax
	jne	.L44
	mov	rcx, qword [r12+32]
	jmp	.L43
.L236:
	call	__errno_location
	mov	edx, 10
	lea	rsi, [rsp+56]
	mov	rdi, rbx
	mov	dword [rax], 0
	mov	r14, rax
	call	strtol
	mov	edx, dword [r14]
	test	edx, edx
	jne	.L90
	mov	rdx, qword [rsp+56]
	cmp	byte [rdx], 0
	jne	.L90
	cmp	rax, 86400
	ja	.L90
	mov	qword [rbp+8], rax
	jmp	.L47
.L237:
	mov	edx, 8
	mov	esi, LC23
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	jne	.L90
	mov	rdi, rbx
	call	strlen
	cmp	rax, 255
	ja	.L90
	mov	rdi, qword [rsp+16]
	mov	rcx, rbx
	mov	edx, LC24
	xor	eax, eax
	mov	esi, 256
	call	snprintf
	jmp	.L47
.L44:
	lea	r12, [rsp+64]
	mov	rcx, r13
	mov	edx, LC11
	xor	eax, eax
	mov	esi, 1024
	mov	rdi, r12
	call	snprintf
	jmp	.L45
.L81:
	mov	rdi, rbx
	call	valid_target_arch
	test	eax, eax
	je	.L90
	mov	rdi, rbx
	call	strlen
	cmp	rax, 127
	ja	.L90
	mov	rdi, qword [rsp+24]
	mov	rcx, rbx
	mov	edx, LC24
	xor	eax, eax
	mov	esi, 128
	call	snprintf
	jmp	.L47
.L232:
	mov	rdi, r12
	mov	rbx, qword [rsp+8]
	call	ferror
	test	eax, eax
	jne	.L238
	mov	rdi, r12
	call	fclose
.L48:
	mov	eax, 1
	jmp	.L39
.L233:
	mov	rbx, qword [rsp+8]
	mov	rsi, qword [rsp]
	mov	rcx, r13
	mov	edx, LC16
	mov	rdi, rbx
	call	error_format
	mov	rdi, r12
	call	fclose
	jmp	.L40
.L238:
	call	__errno_location
	mov	edi, dword [rax]
	call	strerror
	mov	rsi, qword [rsp]
	mov	rdi, rbx
	mov	edx, LC52
	mov	rcx, rax
	xor	eax, eax
	call	error_format
	mov	rdi, r12
	call	fclose
	jmp	.L40
.L83:
	mov	rdi, rbx
	call	valid_opt_level
	test	eax, eax
	je	.L90
	mov	rdi, rbx
	call	strlen
	cmp	rax, 16
	ja	.L90
	movzx	eax, byte [rbx]
	cmp	al, 45
	jne	.L85
	movzx	eax, byte [rbx+1]
	add	rbx, 1
.L85:
	and	eax, -33
	mov	rdi, qword [rsp+32]
	mov	edx, LC24
	mov	esi, 16
	cmp	al, 79
	sete	al
	movzx	eax, al
	add	rbx, rax
	xor	eax, eax
	mov	rcx, rbx
	call	snprintf
	jmp	.L47
.L231:
	call	__errno_location
	mov	edi, dword [rax]
	cmp	edi, 2
	je	.L48
	call	strerror
	mov	rsi, qword [rsp]
	mov	edx, LC15
	mov	rdi, rbx
	mov	rcx, rax
	xor	eax, eax
	call	error_format
	jmp	.L40
.L94:
	mov	rdi, rbx
	call	valid_gentoo_chroot_path
	test	eax, eax
	je	.L90
	mov	rdi, qword [rsp+40]
	mov	rcx, rbx
	mov	edx, LC24
	xor	eax, eax
	mov	esi, 512
	call	snprintf
	jmp	.L47
.L97:
	mov	rbx, qword [rsp+8]
	mov	rsi, qword [rsp]
	mov	r8, r15
	mov	rcx, r13
	mov	edx, LC50
	xor	eax, eax
	mov	rdi, rbx
	call	error_format
	mov	rdi, r12
	call	fclose
	jmp	.L40
.L91:
	lea	rsi, [rsp+56]
	mov	rdi, rbx
	call	parse_switch
	test	eax, eax
	je	.L90
	movd	xmm1, dword [rsp+56]
	pshufd	xmm0, xmm1, 0xe0
	movq	qword [rbp+428], xmm0
	jmp	.L47
.L87:
	lea	rsi, [rsp+56]
	mov	rdi, rbx
	call	parse_switch
	test	eax, eax
	je	.L90
	mov	dword [rbp+424], 1
	mov	eax, dword [rsp+56]
	mov	dword [rbp+420], eax
	jmp	.L47
global config_apply
config_apply:
	test	rdi, rdi
	je	.L252
	push	rbx
	mov	rbx, rdi
	mov	ecx, 120
	mov	edi, g_config
	mov	dword [rel g_initialized], 1
	mov	rsi, rbx
	rep movsq
	mov	edi, dword [rbx+4]
	call	set_interactive
	mov	rdi, qword [rbx+8]
	call	set_prompt_timeout
	mov	edi, dword [rbx]
	call	set_emerge_confirm
	mov	edi, dword [rbx+16]
	call	guide_set_policy
	cmp	byte [rbx+276], 0
	jne	.L255
	cmp	byte [rbx+404], 0
	jne	.L256
.L243:
	mov	edx, dword [rbx+424]
	test	edx, edx
	jne	.L257
.L244:
	mov	edi, dword [rbx+428]
	test	edi, edi
	jne	.L258
.L245:
	cmp	byte [rbx+436], 0
	jne	.L259
.L246:
	mov	eax, dword [rbx+952]
	test	eax, eax
	jne	.L260
.L239:
	pop	rbx
	ret
.L260:
	mov	edi, dword [rbx+948]
	pop	rbx
	jmp	set_use_binary
.L259:
	lea	rdi, [rbx+436]
	call	set_gentoo_chroot_path
	mov	eax, dword [rbx+952]
	test	eax, eax
	je	.L239
	jmp	.L260
.L258:
	call	set_gentoo_chroot
	mov	edi, dword [rbx+432]
	call	set_portage_imitation
	cmp	byte [rbx+436], 0
	je	.L246
	jmp	.L259
.L257:
	mov	edi, dword [rbx+420]
	call	set_use_pipe
	mov	edi, dword [rbx+428]
	test	edi, edi
	je	.L245
	jmp	.L258
.L256:
	lea	rdi, [rbx+404]
	call	set_opt_level
	mov	edx, dword [rbx+424]
	test	edx, edx
	je	.L244
	jmp	.L257
.L255:
	lea	rdi, [rbx+276]
	call	set_target_arch
	cmp	byte [rbx+404], 0
	je	.L243
	jmp	.L256
.L252:
	ret
global config_current
config_current:
	mov	ecx, dword [rel g_initialized]
	test	ecx, ecx
	je	.L267
	mov	eax, g_config
	ret
.L267:
	sub	rsp, 8
	mov	edx, g_config
	xor	eax, eax
	mov	ecx, 120
	movdqa	xmm0, oword [rel LC8]
	mov	rdi, rdx
	mov	edx, 51
	mov	esi, 512
	rep stosq
	mov	word g_config[rip+404], dx
	mov	ecx, LC6
	mov	edx, LC7
	movups	oword g_config[rip+20], xmm0
	mov	edi, g_config+436
	movdqa	xmm0, oword [rel LC9]
	mov	dword g_config[rip+276], 1769234798
	movups	oword g_config[rip+36], xmm0
	movdqa	xmm0, oword [rel LC5]
	mov	dword [rel g_config], 1
	mov	qword g_config[rip+8], 300
	mov	dword g_config[rip+279], 6649449
	movups	oword g_config[rip+420], xmm0
	call	snprintf
	mov	eax, g_config
	mov	qword g_config[rip+948], 0
	mov	dword [rel g_initialized], 1
	add	rsp, 8
	ret
section .rodata
LC5:
	dd 1
	dd 0
	dd 0
	dd 0
LC8:
	dq 3400000511170344040
	dq 7521981564355507553
LC9:
	dq 8245860537639790956
	dq 3852318635396837223
