; dependency.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern free
extern printf
extern puts
extern run_cmd_capture
extern stderr
extern stdout
extern strchr
extern strcmp
extern strdup
extern strncmp
extern valid_pkgname
extern xsnprintf
; NASM assembly - converted from C: src/dependency.c
%use smartalign
section .text
section .rodata
LC0:
	db "repo", 0
LC1:
	db "", 0
LC2:
	db "(none)", 0
LC3:
	db "pacman -Si -- %s", 0
LC4:
	db "Version", 0
LC5:
	db "Repository", 0
LC6:
	db "Depends On", 0
LC7:
	db "Optional Deps", 0
LC8:
	db "Make Deps", 0
LC9:
	db "Build Deps", 0
LC10:
	db "Check Deps", 0
section .rodata
LC11:
	db "\033[1;36mPackage: %s %s (%s)\n\033[0m", 0
section .rodata
LC12:
	db "None", 0
LC13:
	db "Depends:", 0
LC14:
	db "  %-14s%s\n", 0
LC15:
	db "MakeDepends:", 0
LC16:
	db "CheckDepends:", 0
LC17:
	db "Optional:", 0
section .rodata
LC18:
	db "\033[1;36mInstall order (dependency-first):\n\033[0m", 0
section .rodata
LC19:
	db " \t", 0
LC20:
	db "  %zu. %s\n", 0
LC21:
	db "  1. %s\n", 0
plan_from_repo:
	push	r15
	mov	edx, 320
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 1320
	lea	rbx, [rsp+480]
	mov	qword [rsp+24], rdi
	mov	qword [rsp+32], 0
	mov	rsi, rbx
	call	shell_quote
	test	eax, eax
	jne	.L150
.L2:
	xor	eax, eax
.L1:
	add	rsp, 1320
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L150:
	mov	rcx, rbx
	mov	edx, LC3
	mov	esi, 512
	xor	eax, eax
	lea	rbp, [rsp+800]
	mov	rdi, rbp
	call	xsnprintf
	lea	rsi, [rsp+32]
	mov	rdi, rbp
	call	run_cmd_capture
	mov	rbx, qword [rsp+32]
	test	eax, eax
	jne	.L3
	test	rbx, rbx
	je	.L3
	cmp	byte [rbx], 0
	je	.L3
	mov	qword [rsp], 0
	xor	r12d, r12d
	xor	ebp, ebp
	xor	r14d, r14d
	mov	qword [rsp+8], 0
	xor	r13d, r13d
	jmp	.L4
.L152:
	lea	rbp, [r8+1]
.L11:
	test	r15, r15
	je	.L8
.L9:
	cmp	byte [r15+1], 0
	lea	rbx, [r15+1]
	je	.L8
.L4:
	mov	esi, 10
	mov	rdi, rbx
	call	strchr
	mov	r15, rax
	test	rax, rax
	je	.L151
	mov	byte [rax], 0
	mov	esi, 58
	mov	rdi, rbx
	call	strchr
	mov	r8, rax
	test	rax, rax
	je	.L9
.L7:
	mov	byte [r8], 0
	mov	edx, 7
	mov	esi, LC4
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	je	.L152
	mov	edx, 10
	mov	esi, LC5
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	jne	.L12
	lea	r12, [r8+1]
	jmp	.L11
.L151:
	mov	esi, 58
	mov	rdi, rbx
	call	strchr
	mov	r8, rax
	test	rax, rax
	jne	.L7
.L8:
	test	rbp, rbp
	je	.L19
	movzx	eax, byte [rbp+0]
	cmp	al, 9
	je	.L120
	cmp	al, 32
	jne	.L19
.L120:
	movzx	eax, byte [rbp+1]
	add	rbp, 1
	cmp	al, 32
	je	.L120
	cmp	al, 9
	je	.L120
.L19:
	test	r12, r12
	je	.L20
	movzx	eax, byte [r12]
	cmp	al, 9
	je	.L121
	cmp	al, 32
	jne	.L20
.L121:
	movzx	eax, byte [r12+1]
	add	r12, 1
	cmp	al, 32
	je	.L121
	cmp	al, 9
	je	.L121
.L20:
	mov	rax, qword [rsp+8]
	test	rax, rax
	je	.L24
	movzx	eax, byte [rax]
	cmp	al, 9
	je	.L122
	cmp	al, 32
	jne	.L24
.L122:
	add	qword [rsp+8], 1
	mov	rax, qword [rsp+8]
	movzx	eax, byte [rax]
	cmp	al, 32
	je	.L122
	cmp	al, 9
	je	.L122
.L24:
	test	r13, r13
	je	.L28
	movzx	eax, byte [r13+0]
	cmp	al, 9
	je	.L123
	cmp	al, 32
	jne	.L28
.L123:
	movzx	eax, byte [r13+1]
	add	r13, 1
	cmp	al, 32
	je	.L123
	cmp	al, 9
	je	.L123
.L28:
	test	r14, r14
	je	.L32
	movzx	eax, byte [r14]
	cmp	al, 9
	je	.L124
	cmp	al, 32
	jne	.L32
.L124:
	movzx	eax, byte [r14+1]
	add	r14, 1
	cmp	al, 32
	je	.L124
	cmp	al, 9
	je	.L124
.L32:
	mov	rax, qword [rsp]
	test	rax, rax
	je	.L36
	movzx	eax, byte [rax]
	cmp	al, 9
	je	.L125
	cmp	al, 32
	jne	.L36
.L125:
	add	qword [rsp], 1
	mov	rax, qword [rsp]
	movzx	eax, byte [rax]
	cmp	al, 32
	je	.L125
	cmp	al, 9
	je	.L125
.L36:
	test	r12, r12
	je	.L60
	cmp	byte [r12], 0
	mov	eax, LC0
	cmove	r12, rax
.L40:
	test	rbp, rbp
	mov	eax, LC1
	mov	rsi, qword [rsp+24]
	mov	rcx, r12
	cmove	rbp, rax
	mov	edi, LC11
	xor	eax, eax
	mov	ebx, LC2
	mov	rdx, rbp
	call	printf
	mov	rax, qword [rsp+8]
	test	rax, rax
	je	.L42
	cmp	byte [rax], 0
	mov	r15, rax
	je	.L42
	mov	esi, LC12
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	cmovne	rbx, r15
.L42:
	xor	eax, eax
	mov	rdx, rbx
	mov	esi, LC13
	mov	edi, LC14
	call	printf
	test	r14, r14
	je	.L65
	cmp	byte [r14], 0
	je	.L65
	mov	rdi, r14
	mov	esi, LC12
	call	strcmp
	test	eax, eax
	mov	eax, LC2
	cmove	r14, rax
.L43:
	mov	rdx, r14
	mov	esi, LC15
	mov	edi, LC14
	xor	eax, eax
	call	printf
	mov	rbx, qword [rsp]
	test	rbx, rbx
	je	.L67
	cmp	byte [rbx], 0
	je	.L67
	mov	esi, LC12
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	mov	eax, LC2
	cmovne	rax, rbx
	mov	qword [rsp], rax
.L44:
	mov	rdx, qword [rsp]
	xor	eax, eax
	mov	esi, LC16
	mov	edi, LC14
	call	printf
	test	r13, r13
	je	.L69
	cmp	byte [r13+0], 0
	je	.L69
	mov	rdi, r13
	mov	esi, LC12
	call	strcmp
	test	eax, eax
	mov	eax, LC2
	cmove	r13, rax
.L45:
	mov	rdx, r13
	mov	esi, LC17
	mov	edi, LC14
	xor	eax, eax
	call	printf
	mov	edi, LC18
	xor	eax, eax
	call	printf
	call	graph_create
	pxor	xmm0, xmm0
	mov	qword [rsp+40], 0
	mov	qword [rsp+48], 0
	mov	r12, rax
	movaps	oword [rsp+224], xmm0
	movaps	oword [rsp+240], xmm0
	movaps	oword [rsp+256], xmm0
	movaps	oword [rsp+272], xmm0
	movaps	oword [rsp+288], xmm0
	movaps	oword [rsp+304], xmm0
	movaps	oword [rsp+320], xmm0
	movaps	oword [rsp+336], xmm0
	movaps	oword [rsp+352], xmm0
	movaps	oword [rsp+368], xmm0
	movaps	oword [rsp+384], xmm0
	movaps	oword [rsp+400], xmm0
	movaps	oword [rsp+416], xmm0
	movaps	oword [rsp+432], xmm0
	movaps	oword [rsp+448], xmm0
	movaps	oword [rsp+464], xmm0
	test	rax, rax
	je	.L46
	mov	rsi, qword [rsp+24]
	xor	ecx, ecx
	mov	rdx, rbp
	mov	rdi, rax
	call	graph_add_package
	mov	rax, qword [rsp+8]
	test	rax, rax
	je	.L47
	cmp	byte [rax], 0
	je	.L47
	mov	esi, LC12
	mov	rdi, rax
	call	strcmp
	test	eax, eax
	je	.L47
	mov	rdi, qword [rsp+8]
	call	strdup
	mov	qword [rsp+56], 0
	mov	r13, rax
	test	rax, rax
	je	.L47
	lea	rbp, [rsp+56]
	mov	rdi, rax
	mov	esi, LC19
	mov	rdx, rbp
	lea	rbx, [rsp+64]
	call	strtok_r
	mov	rdi, rax
	test	rax, rax
	jne	.L49
	jmp	.L54
.L51:
	xor	edi, edi
	mov	rdx, rbp
	mov	esi, LC19
	call	strtok_r
	mov	rdi, rax
	test	rax, rax
	je	.L54
.L49:
	mov	edx, 160
	mov	rsi, rbx
	call	dep_basename
	cmp	byte [rsp+64], 0
	je	.L51
	mov	rdi, rbx
	call	valid_pkgname
	test	eax, eax
	je	.L51
	mov	rsi, rbx
	mov	rdi, r12
	call	graph_has_package
	test	eax, eax
	je	.L153
.L53:
	mov	rsi, qword [rsp+24]
	mov	rdx, rbx
	mov	rdi, r12
	call	graph_add_dependency
	jmp	.L51
.L12:
	mov	edx, 10
	mov	esi, LC6
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	je	.L154
	mov	edx, 13
	mov	esi, LC7
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	jne	.L14
	lea	r13, [r8+1]
	jmp	.L11
.L3:
	mov	rdi, rbx
	call	free
	jmp	.L2
.L154:
	lea	rax, [r8+1]
	mov	qword [rsp+8], rax
	jmp	.L11
.L54:
	mov	rdi, r13
	call	free
.L47:
	lea	rcx, [rsp+224]
	lea	rdx, [rsp+48]
	mov	r8d, 256
	mov	rdi, r12
	lea	rsi, [rsp+40]
	call	graph_topological_order
	test	eax, eax
	je	.L55
	xor	ebx, ebx
	cmp	qword [rsp+48], 0
	je	.L57
.L56:
	mov	rax, qword [rsp+40]
	mov	rdi, r12
	mov	rsi, qword [rax+rbx*8]
	add	rbx, 1
	call	graph_package_name
	mov	rsi, rbx
	mov	edi, LC20
	mov	rdx, rax
	xor	eax, eax
	call	printf
	cmp	rbx, qword [rsp+48]
	jb	.L56
.L57:
	mov	rdi, qword [rsp+40]
	call	free
	mov	rdi, r12
	call	graph_destroy
.L46:
	mov	rdi, qword [rsp+32]
	call	free
	mov	eax, 1
	jmp	.L1
.L69:
	mov	r13d, LC2
	jmp	.L45
.L67:
	mov	qword [rsp], LC2
	jmp	.L44
.L65:
	mov	r14d, LC2
	jmp	.L43
.L14:
	mov	edx, 9
	mov	esi, LC8
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	je	.L15
	mov	edx, 10
	mov	esi, LC9
	mov	rdi, rbx
	call	strncmp
	mov	r8, qword [rsp+16]
	test	eax, eax
	je	.L15
	mov	edx, 10
	mov	esi, LC10
	mov	rdi, rbx
	mov	qword [rsp+16], r8
	call	strncmp
	mov	r8, qword [rsp+16]
	add	r8, 1
	test	eax, eax
	cmovne	r8, qword [rsp]
	mov	qword [rsp], r8
	jmp	.L11
.L15:
	lea	r14, [r8+1]
	jmp	.L11
.L60:
	mov	r12d, LC0
	jmp	.L40
.L55:
	mov	rsi, qword [rsp+24]
	mov	edi, LC21
	xor	eax, eax
	call	printf
	jmp	.L57
.L153:
	xor	ecx, ecx
	mov	edx, LC1
	mov	rsi, rbx
	mov	rdi, r12
	call	graph_add_package
	jmp	.L53
section .rodata
LC22:
	db "aur", 0
LC23:
	db "repo/dep", 0
LC24:
	db " ", 0
section .rodata
LC25:
	db "\033[1;36mPackage: %s %s (aur)\n\033[0m", 0
section .rodata
LC26:
	db "  %-14s", 0
LC27:
	db "%s%s", 0
LC28:
	db "  ", 0
LC29:
	db "  %zu. %s%s%s  [%s]\n", 0
LC30:
	db "?", 0
LC31:
	db "\033[1;31m[-] %s\n\033[0m", 0
plan_from_aur:
	push	r15
	pxor	xmm0, xmm0
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 488
	mov	qword [rsp+24], rdi
	movaps	oword [rsp+48], xmm0
	movaps	oword [rsp+224], xmm0
	movaps	oword [rsp+240], xmm0
	movaps	oword [rsp+256], xmm0
	movaps	oword [rsp+272], xmm0
	movaps	oword [rsp+288], xmm0
	movaps	oword [rsp+304], xmm0
	movaps	oword [rsp+320], xmm0
	movaps	oword [rsp+336], xmm0
	movaps	oword [rsp+352], xmm0
	movaps	oword [rsp+368], xmm0
	movaps	oword [rsp+384], xmm0
	movaps	oword [rsp+400], xmm0
	movaps	oword [rsp+416], xmm0
	movaps	oword [rsp+432], xmm0
	movaps	oword [rsp+448], xmm0
	movaps	oword [rsp+464], xmm0
	mov	qword [rsp+32], 0
	mov	qword [rsp+40], 0
	call	config_current
	mov	r8d, 256
	lea	rdx, [rsp+48]
	mov	rsi, rbx
	lea	rdi, [rax+20]
	lea	rcx, [rsp+224]
	call	aur_rpc_info
	test	eax, eax
	je	.L156
	cmp	qword [rsp+56], 0
	jne	.L157
.L156:
	lea	rdi, [rsp+48]
	xor	ebp, ebp
	call	aur_response_destroy
.L155:
	add	rsp, 488
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L157:
	call	graph_create
	mov	rbx, rax
	test	rax, rax
	je	.L156
	cmp	qword [rsp+56], 0
	je	.L159
	mov	qword [rsp+8], 0
	mov	qword [rsp], 0
.L193:
	mov	rbp, qword [rsp+8]
	add	rbp, qword [rsp+48]
	mov	ecx, 1
	mov	rdi, rbx
	mov	r12, qword [rbp+0]
	mov	rdx, qword [rbp+16]
	mov	r15d, LC1
	test	r12, r12
	cmove	r12, qword [rsp+24]
	test	rdx, rdx
	cmove	rdx, r15
	mov	rsi, r12
	call	graph_add_package
	mov	rdx, qword [rbp+16]
	mov	rsi, r12
	mov	edi, LC25
	test	rdx, rdx
	cmove	rdx, r15
	xor	eax, eax
	call	printf
	mov	r13, qword [rbp+80]
	xor	eax, eax
	mov	esi, LC13
	mov	edi, LC26
	mov	r15, qword [rbp+72]
	call	printf
	test	r13, r13
	je	.L251
	mov	rdx, qword [r15]
	xor	eax, eax
	mov	esi, LC1
	mov	edi, LC27
	call	printf
	cmp	r13, 1
	je	.L165
	mov	r14d, 1
.L166:
	mov	rdx, qword [r15+r14*8]
	mov	esi, LC28
	mov	edi, LC27
	xor	eax, eax
	add	r14, 1
	call	printf
	cmp	r13, r14
	jne	.L166
.L165:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
.L164:
	mov	r13, qword [rbp+96]
	xor	eax, eax
	mov	esi, LC15
	mov	edi, LC26
	mov	r15, qword [rbp+88]
	call	printf
	test	r13, r13
	je	.L252
	mov	rdx, qword [r15]
	xor	eax, eax
	mov	esi, LC1
	mov	edi, LC27
	call	printf
	cmp	r13, 1
	je	.L169
	mov	r14d, 1
.L170:
	mov	rdx, qword [r15+r14*8]
	mov	esi, LC28
	mov	edi, LC27
	xor	eax, eax
	add	r14, 1
	call	printf
	cmp	r13, r14
	jne	.L170
.L169:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
.L168:
	mov	r13, qword [rbp+112]
	xor	eax, eax
	mov	esi, LC16
	mov	edi, LC26
	mov	r15, qword [rbp+104]
	call	printf
	test	r13, r13
	je	.L253
	mov	rdx, qword [r15]
	xor	eax, eax
	mov	esi, LC1
	mov	edi, LC27
	call	printf
	cmp	r13, 1
	je	.L173
	mov	r14d, 1
.L174:
	mov	rdx, qword [r15+r14*8]
	mov	esi, LC28
	mov	edi, LC27
	xor	eax, eax
	add	r14, 1
	call	printf
	cmp	r13, r14
	jne	.L174
.L173:
	mov	rsi, qword [rel stdout]
	mov	edi, 10
	call	putc
.L172:
	mov	rdx, qword [rbp+80]
	mov	r14, qword [rbp+72]
	test	rdx, rdx
	je	.L175
	xor	r15d, r15d
	mov	qword [rsp+16], rbp
	lea	r13, [rsp+64]
	mov	rbp, r15
	mov	r15, r14
	mov	r14, rdx
.L180:
	mov	rdi, qword [r15+rbp*8]
	mov	edx, 160
	mov	rsi, r13
	call	dep_basename
	cmp	byte [rsp+64], 0
	je	.L177
	mov	rdi, r13
	call	valid_pkgname
	test	eax, eax
	je	.L177
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_has_package
	test	eax, eax
	je	.L254
.L179:
	mov	rdx, r13
	mov	rsi, r12
	mov	rdi, rbx
	call	graph_add_dependency
.L177:
	add	rbp, 1
	cmp	r14, rbp
	jne	.L180
	mov	rbp, qword [rsp+16]
.L175:
	mov	rdx, qword [rbp+96]
	mov	r14, qword [rbp+88]
	test	rdx, rdx
	je	.L181
	xor	r15d, r15d
	mov	qword [rsp+16], rbp
	lea	r13, [rsp+64]
	mov	rbp, r15
	mov	r15, r14
	mov	r14, rdx
.L186:
	mov	rdi, qword [r15+rbp*8]
	mov	edx, 160
	mov	rsi, r13
	call	dep_basename
	cmp	byte [rsp+64], 0
	je	.L183
	mov	rdi, r13
	call	valid_pkgname
	test	eax, eax
	je	.L183
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_has_package
	test	eax, eax
	je	.L255
.L185:
	mov	rdx, r13
	mov	rsi, r12
	mov	rdi, rbx
	call	graph_add_dependency
.L183:
	add	rbp, 1
	cmp	r14, rbp
	jne	.L186
	mov	rbp, qword [rsp+16]
.L181:
	mov	r15, qword [rbp+112]
	mov	r14, qword [rbp+104]
	test	r15, r15
	je	.L187
	xor	ebp, ebp
	lea	r13, [rsp+64]
.L192:
	mov	rdi, qword [r14+rbp*8]
	mov	edx, 160
	mov	rsi, r13
	call	dep_basename
	cmp	byte [rsp+64], 0
	je	.L189
	mov	rdi, r13
	call	valid_pkgname
	test	eax, eax
	je	.L189
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_has_package
	test	eax, eax
	je	.L256
.L191:
	mov	rdx, r13
	mov	rsi, r12
	mov	rdi, rbx
	call	graph_add_dependency
.L189:
	add	rbp, 1
	cmp	r15, rbp
	jne	.L192
.L187:
	add	qword [rsp], 1
	mov	rax, qword [rsp]
	add	qword [rsp+8], 152
	cmp	rax, qword [rsp+56]
	jb	.L193
.L159:
	mov	edi, LC18
	xor	eax, eax
	call	printf
	lea	rdx, [rsp+40]
	mov	rdi, rbx
	lea	rsi, [rsp+32]
	mov	r8d, 256
	lea	rcx, [rsp+224]
	call	graph_topological_order
	mov	ebp, eax
	test	eax, eax
	je	.L194
	xor	ebp, ebp
	cmp	qword [rsp+40], 0
	mov	r14d, LC23
	jne	.L195
	jmp	.L201
.L250:
	xor	eax, eax
	mov	rsi, rbp
	mov	edi, LC29
	call	printf
	cmp	rbp, qword [rsp+40]
	jnb	.L201
.L195:
	mov	rax, qword [rsp+32]
	mov	rdi, rbx
	mov	rsi, qword [rax+rbp*8]
	call	graph_package_name
	mov	rdi, rbx
	mov	r13, rax
	mov	rax, qword [rsp+32]
	mov	rsi, qword [rax+rbp*8]
	call	graph_package_version
	mov	rdi, rbx
	mov	r12, rax
	mov	rax, qword [rsp+32]
	mov	rsi, qword [rax+rbp*8]
	call	graph_package_source
	mov	r9d, LC22
	cmp	eax, 1
	cmovne	r9, r14
	test	r12, r12
	je	.L204
	cmp	byte [r12], 0
	mov	ecx, LC24
	jne	.L198
.L204:
	mov	r12d, LC1
	mov	rcx, r12
.L198:
	add	rbp, 1
	mov	r8, r12
	mov	rdx, r13
	test	r13, r13
	jne	.L250
	mov	edx, LC30
	jmp	.L250
.L256:
	xor	ecx, ecx
	mov	edx, LC1
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_add_package
	jmp	.L191
.L254:
	xor	ecx, ecx
	mov	edx, LC1
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_add_package
	jmp	.L179
.L255:
	xor	ecx, ecx
	mov	edx, LC1
	mov	rsi, r13
	mov	rdi, rbx
	call	graph_add_package
	jmp	.L185
.L253:
	mov	edi, LC2
	call	puts
	jmp	.L172
.L251:
	mov	edi, LC2
	call	puts
	jmp	.L164
.L252:
	mov	edi, LC2
	call	puts
	jmp	.L168
.L201:
	mov	ebp, 1
.L196:
	mov	rdi, qword [rsp+32]
	call	free
	mov	rdi, rbx
	call	graph_destroy
	lea	rdi, [rsp+48]
	call	aur_response_destroy
	jmp	.L155
.L194:
	mov	rdi, qword [rel stderr]
	lea	rdx, [rsp+224]
	mov	esi, LC31
	xor	eax, eax
	call	fprintf
	jmp	.L196
section .rodata
LC32:
	db "\033[1;31m[-] Invalid package name: '%s'\n\033[0m", 0
LC33:
	db "\033[1;31m[-] Could not resolve dependencies for '%s'.\n\033[0m", 0
global cmd_dependency_plan_v2
cmd_dependency_plan_v2:
	push	rbx
	mov	rbx, rdi
	call	valid_pkgname
	test	eax, eax
	jne	.L258
	test	rbx, rbx
	mov	eax, LC1
	mov	esi, LC32
	mov	rdi, qword [rel stderr]
	cmove	rbx, rax
	xor	eax, eax
	mov	rdx, rbx
	call	fprintf
	xor	eax, eax
.L257:
	pop	rbx
	ret
.L258:
	mov	rdi, rbx
	call	plan_from_repo
	test	eax, eax
	jne	.L263
	mov	rdi, rbx
	call	plan_from_aur
	test	eax, eax
	je	.L266
.L263:
	mov	eax, 1
	pop	rbx
	ret
.L266:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC33
	call	fprintf
	xor	eax, eax
	jmp	.L257
