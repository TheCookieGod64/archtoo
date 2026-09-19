; graph.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern free
extern malloc
extern memcpy
extern realloc
extern snprintf
extern strcmp
extern strlen
; NASM assembly - converted from C: src/graph.c
%use smartalign
section .text
section .rodata
LC0:
	db "dependency cycle detected: %s -> %s", 0
visit:
	push	r15
	mov	r15, r9
	lea	r9, [rsi+rsi*2]
	push	r14
	sal	r9, 4
	mov	r14, r8
	push	r13
	lea	r13, [rdx+rsi]
	push	r12
	mov	r12, rdi
	mov	rdi, rsi
	push	rbp
	mov	rbp, rdx
	push	rbx
	sub	rsp, 296
	mov	byte [r13+0], 1
	mov	r10, qword [r12]
	lea	rdx, [r10+r9]
	mov	r8, qword [rdx+32]
	test	r8, r8
	je	.L17
	mov	qword [rsp+16], r13
	xor	ebx, ebx
	mov	r13, r9
	mov	qword [rsp+8], r15
	mov	r15, r14
	mov	r14, rcx
	mov	qword [rsp+24], rsi
	jmp	.L2
.L15:
	add	rbx, 1
	cmp	rbx, r8
	jnb	.L33
.L2:
	mov	rax, qword [rdx+24]
	mov	rsi, qword [rax+rbx*8]
	movzx	eax, byte [rbp+0+rsi]
	cmp	al, 1
	je	.L34
	test	al, al
	jne	.L15
	sub	rsp, 8
	mov	rcx, r14
	mov	rdx, rbp
	mov	r8, r15
	push	qword [rsp+360]
	mov	r9, qword [rsp+24]
	mov	rdi, r12
	call	visit
	pop	rdx
	pop	rcx
	test	eax, eax
	je	.L7
	mov	r10, qword [r12]
	add	rbx, 1
	lea	rdx, [r10+r13]
	mov	r8, qword [rdx+32]
	cmp	rbx, r8
	jb	.L2
.L33:
	mov	r13, qword [rsp+16]
	mov	rdi, qword [rsp+24]
	mov	rcx, r14
	mov	r14, r15
.L17:
	mov	byte [r13+0], 2
	mov	rax, qword [r14]
	lea	rdx, [rax+1]
	mov	qword [r14], rdx
	mov	qword [rcx+rax*8], rdi
	mov	eax, 1
.L1:
	add	rsp, 296
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L34:
	mov	r15, qword [rsp+8]
	test	r15, r15
	je	.L7
	cmp	qword [rsp+352], 0
	jne	.L35
.L7:
	xor	eax, eax
	jmp	.L1
.L35:
	lea	rax, [rsi+rsi*2]
	mov	rcx, qword [rdx]
	lea	rbx, [rsp+32]
	mov	edx, LC0
	sal	rax, 4
	mov	esi, 256
	mov	rdi, rbx
	mov	r8, qword [r10+rax]
	xor	eax, eax
	call	snprintf
	test	eax, eax
	jns	.L8
	mov	byte [rsp+32], 0
.L8:
	mov	rdi, rbx
	call	strlen
	mov	rcx, qword [rsp+352]
	lea	rdx, [rcx-1]
	cmp	rax, rcx
	cmovnb	rax, rdx
	mov	ecx, eax
	cmp	eax, 8
	jnb	.L10
	test	al, 4
	jne	.L36
	test	eax, eax
	je	.L11
	movzx	edx, byte [rsp+32]
	mov	byte [r15], dl
	test	al, 2
	je	.L11
	mov	edx, eax
	movzx	ecx, word [rbx-2+rdx]
	mov	word [r15-2+rdx], cx
.L11:
	mov	byte [r15+rax], 0
	xor	eax, eax
	jmp	.L1
.L10:
	mov	rdx, qword [rsp+32]
	lea	rdi, [r15+8]
	mov	rsi, rbx
	and	rdi, -8
	mov	qword [r15], rdx
	mov	edx, eax
	mov	rcx, qword [rbx-8+rdx]
	mov	qword [r15-8+rdx], rcx
	mov	rcx, r15
	sub	rcx, rdi
	sub	rsi, rcx
	add	ecx, eax
	shr	ecx, 3
	rep movsq
	jmp	.L11
.L36:
	mov	edx, dword [rsp+32]
	mov	dword [r15], edx
	mov	edx, dword [rbx-4+rcx]
	mov	dword [r15-4+rcx], edx
	jmp	.L11
global graph_create
graph_create:
	mov	esi, 24
	mov	edi, 1
	jmp	calloc
global graph_destroy
graph_destroy:
	test	rdi, rdi
	je	.L38
	push	r12
	mov	r12, rdi
	push	rbp
	push	rbx
	cmp	qword [rdi+8], 0
	je	.L40
	xor	ebp, ebp
.L41:
	mov	rax, qword [r12]
	lea	rbx, [rbp+0+rbp*2]
	add	rbp, 1
	sal	rbx, 4
	mov	rdi, qword [rax+rbx]
	call	free
	mov	rax, qword [r12]
	mov	rdi, qword [rax+8+rbx]
	call	free
	mov	rax, qword [r12]
	mov	rdi, qword [rax+24+rbx]
	call	free
	cmp	rbp, qword [r12+8]
	jb	.L41
.L40:
	mov	rdi, qword [r12]
	call	free
	pop	rbx
	mov	rdi, r12
	pop	rbp
	pop	r12
	jmp	free
.L38:
	ret
section .rodata
LC1:
	db "", 0
global graph_add_package
graph_add_package:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24
	mov	qword [rsp], rdx
	mov	dword [rsp+12], ecx
	test	rdi, rdi
	je	.L49
	mov	rbx, rsi
	test	rsi, rsi
	je	.L49
	cmp	byte [rsi], 0
	jne	.L85
.L49:
	add	rsp, 24
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L85:
	mov	r13, qword [rdi+8]
	mov	r14, qword [rdi]
	mov	rbp, rdi
	test	r13, r13
	je	.L51
	xor	r15d, r15d
	xor	r12d, r12d
	jmp	.L53
.L87:
	add	r12, 1
	add	r15, 48
	cmp	r13, r12
	je	.L86
.L53:
	mov	rdi, qword [r14+r15]
	mov	rsi, rbx
	call	strcmp
	test	eax, eax
	jne	.L87
	cmp	qword [rsp], 0
	je	.L88
	mov	rdi, qword [rsp]
	call	strlen
	lea	rdi, [rax+1]
.L64:
	call	malloc
	mov	rbx, rax
	test	rax, rax
	je	.L49
	mov	rsi, qword [rsp]
	mov	rdi, rax
	call	strcpy
	mov	rdi, qword [r14+8+r15]
	call	free
	mov	rdx, qword [rbp+0]
	mov	eax, dword [rsp+12]
	add	rdx, r15
	mov	qword [rdx+8], rbx
	mov	dword [rdx+16], eax
.L57:
	add	rsp, 24
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L86:
	cmp	r13, qword [rbp+16]
	je	.L89
.L56:
	mov	rdi, rbx
	call	strlen
	lea	r14, [rax+1]
	mov	rdi, r14
	call	malloc
	mov	r13, rax
	test	rax, rax
	je	.L58
	mov	rdx, r14
	mov	rsi, rbx
	mov	rdi, rax
	call	memcpy
.L58:
	mov	rdi, qword [rsp]
	test	rdi, rdi
	je	.L67
	call	strlen
	lea	rdi, [rax+1]
.L59:
	call	malloc
	mov	rbx, rax
	test	rax, rax
	je	.L62
	mov	rsi, qword [rsp]
	mov	rdi, rax
	call	strcpy
	test	r13, r13
	je	.L62
	mov	rdx, qword [rbp+8]
	mov	ecx, dword [rsp+12]
	pxor	xmm0, xmm0
	lea	rax, [rdx+rdx*2]
	add	rdx, 1
	sal	rax, 4
	add	rax, qword [rbp+0]
	movups	oword [rax+16], xmm0
	mov	qword [rax], r13
	mov	qword [rax+8], rbx
	mov	dword [rax+16], ecx
	movups	oword [rax+32], xmm0
	mov	qword [rbp+8], rdx
	jmp	.L57
.L67:
	mov	qword [rsp], LC1
	mov	edi, 1
	jmp	.L59
.L88:
	mov	qword [rsp], LC1
	mov	edi, 1
	jmp	.L64
.L89:
	lea	r15, [r13+r13]
	lea	rsi, [r15+r13]
	sal	rsi, 5
.L55:
	mov	rdi, r14
	call	realloc
	test	rax, rax
	je	.L49
	mov	qword [rbp+0], rax
	mov	qword [rbp+16], r15
	jmp	.L56
.L62:
	mov	rdi, r13
	call	free
	mov	rdi, rbx
	call	free
	jmp	.L49
.L51:
	cmp	qword [rdi+16], 0
	jne	.L56
	mov	esi, 768
	mov	r15d, 16
	jmp	.L55
global graph_add_dependency
graph_add_dependency:
	test	rdi, rdi
	je	.L130
	push	r15
	mov	r15, rsi
	push	r14
	push	r13
	mov	r13, rdx
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24
	test	rsi, rsi
	je	.L93
	mov	r12, qword [rdi+8]
	mov	r14, qword [rdi]
	test	r12, r12
	je	.L94
	mov	rbx, r14
	xor	ebp, ebp
	jmp	.L96
.L132:
	add	rbp, 1
	add	rbx, 48
	cmp	r12, rbp
	je	.L131
.L96:
	mov	rdi, qword [rbx]
	mov	rsi, r15
	call	strcmp
	test	eax, eax
	jne	.L132
	mov	byte [rsp+15], 0
.L95:
	test	r13, r13
	je	.L94
.L104:
	mov	r15, r14
	xor	ebx, ebx
	jmp	.L98
.L133:
	add	rbx, 1
	add	r15, 48
	cmp	rbx, r12
	je	.L94
.L98:
	mov	rdi, qword [r15]
	mov	rsi, r13
	call	strcmp
	test	eax, eax
	jne	.L133
	cmp	byte [rsp+15], 0
	jne	.L94
	lea	r12, [rbp+0+rbp*2]
	sal	r12, 4
	add	r12, r14
	mov	rdx, qword [r12+32]
	mov	rdi, qword [r12+24]
	test	rdx, rdx
	je	.L99
	xor	esi, esi
	jmp	.L101
.L135:
	add	rsi, 1
	cmp	rsi, rdx
	je	.L134
.L101:
	cmp	qword [rdi+rsi*8], rbx
	jne	.L135
.L100:
	add	rsp, 24
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L94:
	add	rsp, 24
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L131:
	mov	byte [rsp+15], 1
	mov	rbp, -1
	jmp	.L95
.L134:
	cmp	qword [r12+40], rsi
	je	.L136
.L102:
	lea	rax, [rdx+1]
	mov	qword [r12+32], rax
	mov	qword [rdi+rdx*8], rbx
	jmp	.L100
.L93:
	test	rdx, rdx
	je	.L94
	mov	r12, qword [rdi+8]
	mov	r14, qword [rdi]
	test	r12, r12
	je	.L94
	mov	byte [rsp+15], 1
	mov	rbp, -1
	jmp	.L104
.L130:
	xor	eax, eax
	ret
.L136:
	lea	rbp, [rsi+rsi]
	sal	rsi, 4
.L103:
	call	realloc
	mov	rdi, rax
	test	rax, rax
	je	.L94
	mov	qword [r12+24], rax
	mov	rdx, qword [r12+32]
	mov	qword [r12+40], rbp
	jmp	.L102
.L99:
	cmp	qword [r12+40], 0
	jne	.L102
	mov	esi, 64
	mov	ebp, 8
	jmp	.L103
global graph_has_package
graph_has_package:
	test	rdi, rdi
	je	.L145
	push	r13
	push	r12
	mov	r12, rsi
	push	rbp
	push	rbx
	sub	rsp, 8
	test	rsi, rsi
	je	.L141
	mov	r13, qword [rdi+8]
	mov	rbx, qword [rdi]
	test	r13, r13
	je	.L141
	xor	ebp, ebp
	jmp	.L139
.L148:
	add	rbp, 1
	add	rbx, 48
	cmp	r13, rbp
	je	.L141
.L139:
	mov	rdi, qword [rbx]
	mov	rsi, r12
	call	strcmp
	test	eax, eax
	jne	.L148
	add	rsp, 8
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L141:
	add	rsp, 8
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L145:
	xor	eax, eax
	ret
global graph_package_count
graph_package_count:
	xor	eax, eax
	test	rdi, rdi
	je	.L149
	mov	rax, qword [rdi+8]
.L149:
	ret
global graph_package_name
graph_package_name:
	xor	eax, eax
	test	rdi, rdi
	je	.L153
	cmp	rsi, qword [rdi+8]
	jnb	.L153
	lea	rax, [rsi+rsi*2]
	sal	rax, 4
	add	rax, qword [rdi]
	mov	rax, qword [rax]
	ret
.L153:
	ret
global graph_package_version
graph_package_version:
	xor	eax, eax
	test	rdi, rdi
	je	.L157
	cmp	rsi, qword [rdi+8]
	jnb	.L157
	lea	rax, [rsi+rsi*2]
	sal	rax, 4
	add	rax, qword [rdi]
	mov	rax, qword [rax+8]
	ret
.L157:
	ret
global graph_package_source
graph_package_source:
	mov	eax, 2
	test	rdi, rdi
	je	.L161
	cmp	rsi, qword [rdi+8]
	jnb	.L161
	lea	rax, [rsi+rsi*2]
	sal	rax, 4
	add	rax, qword [rdi]
	mov	eax, dword [rax+16]
	ret
.L161:
	ret
global graph_topological_order
graph_topological_order:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 56
	test	rsi, rsi
	sete	al
	test	rdx, rdx
	mov	qword [rsp+16], rsi
	mov	qword [rsp+24], rdx
	mov	qword [rsp+8], rcx
	mov	rcx, rsi
	mov	rsi, rdx
	sete	dl
	mov	qword [rsp+40], 0
	or	al, dl
	jne	.L166
	mov	r14, rdi
	test	rdi, rdi
	je	.L166
	mov	qword [rcx], 0
	mov	r12, r8
	mov	qword [rsi], 0
	mov	rbp, qword [rdi+8]
	mov	edi, 1
	mov	esi, 1
	test	rbp, rbp
	cmovne	rdi, rbp
	call	calloc
	test	rax, rax
	mov	r13, rax
	sete	bl
	test	rbp, rbp
	je	.L167
	lea	rdi, [0+rbp*8]
	call	malloc
	mov	r15, rax
	test	rax, rax
	je	.L173
	test	bl, bl
	jne	.L173
	xor	ebx, ebx
	jmp	.L168
.L171:
	add	rbx, 1
	cmp	rbx, rbp
	jnb	.L178
.L168:
	cmp	byte [r13+0+rbx], 0
	jne	.L171
	sub	rsp, 8
	mov	rcx, r15
	mov	rdx, r13
	mov	rsi, rbx
	push	r12
	mov	r9, qword [rsp+24]
	mov	rdi, r14
	lea	r8, [rsp+56]
	call	visit
	pop	rdx
	pop	rcx
	test	eax, eax
	je	.L173
	mov	rbp, qword [r14+8]
	add	rbx, 1
	cmp	rbx, rbp
	jb	.L168
.L178:
	mov	rbp, qword [rsp+40]
.L174:
	mov	rdi, r13
	call	free
	mov	rax, qword [rsp+16]
	mov	qword [rax], r15
	mov	rax, qword [rsp+24]
	mov	qword [rax], rbp
	add	rsp, 56
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L167:
	mov	edi, 8
	call	malloc
	mov	r15, rax
	test	rax, rax
	je	.L173
	test	bl, bl
	je	.L174
.L173:
	mov	rdi, r13
	call	free
	mov	rdi, r15
	call	free
.L166:
	add	rsp, 56
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
