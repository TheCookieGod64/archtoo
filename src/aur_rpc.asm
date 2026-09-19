; aur_rpc.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern __errno_location
extern _exit
extern close
extern dup2
extern execlp
extern fork
extern free
extern kill
extern malloc
extern memcpy
extern pipe
extern read
extern realloc
extern snprintf
extern strchr
extern strcmp
extern strdup
extern strerror
extern strlen
extern strncmp
extern strstr
extern strtod
extern strtol
extern waitpid
; NASM assembly - converted from C: src/aur_rpc.c
%use smartalign
section .text
package_destroy:
	push	r15
	push	r14
	push	r13
	push	r12
	mov	r12, rdi
	push	rbp
	push	rbx
	sub	rsp, 104
	mov	rdi, qword [rdi]
	lea	r13, [rsp+48]
	mov	r15, rsp
	lea	r14, [rsp+40]
	call	free
	mov	rdi, qword [r12+8]
	call	free
	mov	rdi, qword [r12+16]
	call	free
	mov	rdi, qword [r12+24]
	call	free
	mov	rdi, qword [r12+32]
	call	free
	mov	rdi, qword [r12+40]
	call	free
	lea	rax, [r12+72]
	movdqu	xmm0, oword [r12+112]
	movdqu	xmm2, oword [r12+128]
	mov	qword [rsp], rax
	lea	rax, [r12+88]
	movdqu	xmm1, oword [r12+80]
	mov	qword [rsp+8], rax
	lea	rax, [r12+104]
	movdqu	xmm3, oword [r12+96]
	punpcklqdq	xmm0, xmm2
	mov	qword [rsp+16], rax
	lea	rax, [r12+120]
	mov	qword [rsp+24], rax
	lea	rax, [r12+136]
	punpcklqdq	xmm1, xmm3
	mov	qword [rsp+32], rax
	mov	rax, qword [r12+144]
	movaps	oword [rsp+48], xmm1
	mov	qword [rsp+80], rax
	movaps	oword [rsp+64], xmm0
.L2:
	mov	rbp, qword [r13+0]
	xor	ebx, ebx
	test	rbp, rbp
	je	.L5
.L3:
	mov	rax, qword [r15]
	mov	rax, qword [rax]
	mov	rdi, qword [rax+rbx*8]
	add	rbx, 1
	call	free
	cmp	rbx, rbp
	jne	.L3
.L5:
	mov	rax, qword [r15]
	add	r15, 8
	add	r13, 8
	mov	rdi, qword [rax]
	call	free
	cmp	r15, r14
	jne	.L2
	lea	rdi, [r12+8]
	mov	qword [r12], 0
	xor	eax, eax
	mov	qword [r12+144], 0
	and	rdi, -8
	sub	r12, rdi
	lea	ecx, [r12+152]
	shr	ecx, 3
	rep stosq
	add	rsp, 104
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
parse_json_string:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24
	mov	rbx, qword [rdi]
	cmp	byte [rbx], 34
	jne	.L14
	mov	qword [rsp], rdi
	mov	rdi, rbx
	call	strlen
	lea	rdi, [rax+1]
	call	malloc
	mov	r15, rax
	test	rax, rax
	je	.L14
	lea	rbp, [rbx+1]
	movzx	ebx, byte [rbx+1]
	mov	rdx, qword [rsp]
	cmp	bl, 34
	je	.L29
	test	bl, bl
	je	.L29
	xor	r12d, r12d
	jmp	.L26
.L16:
	add	rbp, 1
.L22:
	mov	byte [r13+0], bl
	mov	r12, r14
.L25:
	movzx	ebx, byte [rbp+0]
	test	bl, bl
	je	.L32
	cmp	bl, 34
	je	.L32
.L26:
	lea	r13, [r15+r12]
	lea	r14, [r12+1]
	cmp	bl, 92
	jne	.L16
	movzx	ebx, byte [rbp+1]
	lea	rcx, [rbp+2]
	lea	eax, [rbx-98]
	cmp	al, 19
	ja	.L31
	movzx	eax, al
	jmp [rel .L19 + rax*8]
section .rodata
.L19:
	dq .L24
	dq .L31
	dq .L31
	dq .L31
	dq .L23
	dq .L31
	dq .L31
	dq .L31
	dq .L31
	dq .L31
	dq .L31
	dq .L31
	dq .L30
	dq .L31
	dq .L31
	dq .L31
	dq .L21
	dq .L31
	dq .L20
	dq .L18
.L18:
	mov	rdi, rcx
	mov	qword [rsp+8], rdx
	mov	qword [rsp], rcx
	call	strlen
	mov	rcx, qword [rsp]
	mov	rdx, qword [rsp+8]
	cmp	rax, 3
	ja	.L47
.L31:
	mov	rbp, rcx
	jmp	.L22
.L20:
	mov	rbp, rcx
	mov	ebx, 9
	jmp	.L22
.L21:
	mov	rbp, rcx
	mov	ebx, 13
	jmp	.L22
.L23:
	mov	rbp, rcx
	mov	ebx, 12
	jmp	.L22
.L24:
	mov	rbp, rcx
	mov	ebx, 8
	jmp	.L22
.L32:
	add	r12, r15
.L15:
	xor	eax, eax
	cmp	bl, 34
	mov	byte [r12], 0
	sete	al
	add	rbp, rax
	mov	qword [rdx], rbp
.L11:
	add	rsp, 24
	mov	rax, r15
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L14:
	xor	r15d, r15d
	jmp	.L11
.L30:
	mov	rbp, rcx
	mov	ebx, 10
	jmp	.L22
.L29:
	mov	r12, r15
	jmp	.L15
.L47:
	mov	eax, 30044
	add	rbp, 6
	mov	word [r13+0], ax
	mov	ecx, dword [rbp-4]
	lea	rax, [r15+2+r12]
	add	r12, 6
	mov	dword [rax], ecx
	jmp	.L25
section .rodata
LC1:
	db '"%s"', 0
find_key:
	push	r12
	mov	rcx, rdx
	xor	eax, eax
	mov	edx, LC1
	push	rbp
	mov	rbp, rsi
	mov	esi, 96
	push	rbx
	mov	rbx, rdi
	sub	rsp, 96
	mov	rdi, rsp
	mov	r12, rsp
	call	snprintf
.L49:
	mov	rdi, rbx
	mov	rsi, r12
	call	strstr
	mov	rbx, rax
	cmp	rax, rbp
	jnb	.L57
	test	rax, rax
	je	.L57
	mov	rdi, r12
	call	strlen
	add	rbx, rax
	cmp	rbx, rbp
	jnb	.L49
	call	__ctype_b_loc
	mov	rdx, qword [rax]
	jmp	.L51
.L52:
	add	rbx, 1
	cmp	rbp, rbx
	je	.L49
.L51:
	movzx	eax, byte [rbx]
	test	byte [rdx+1+rax*2], 32
	jne	.L52
	cmp	rbx, rbp
	jnb	.L49
	cmp	byte [rbx], 58
	jne	.L49
	add	rsp, 96
	lea	rax, [rbx+1]
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L57:
	add	rsp, 96
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	ret
object_array:
	push	r14
	push	r13
	mov	r13, rsi
	push	r12
	push	rbp
	mov	rbp, rcx
	push	rbx
	mov	rbx, r8
	sub	rsp, 16
	call	find_key
	mov	qword [rbp+0], 0
	mov	qword [rbx], 0
	test	rax, rax
	je	.L72
	mov	r12, rax
	cmp	rax, r13
	jnb	.L89
	call	__ctype_b_loc
	mov	rcx, qword [rax]
	jmp	.L67
.L68:
	lea	rax, [r12+1]
	cmp	rax, r13
	je	.L90
	mov	r12, rax
.L67:
	movzx	edx, byte [r12]
	mov	rax, rdx
	test	byte [rcx+1+rdx*2], 32
	jne	.L68
.L66:
	cmp	al, 91
	jne	.L72
.L93:
	add	r12, 1
	mov	qword [rsp+8], r12
	cmp	r12, r13
	jnb	.L71
.L70:
	call	__ctype_b_loc
	mov	rdi, qword [rax]
	xor	eax, eax
	jmp	.L78
.L92:
	mov	r14, r12
.L78:
	movzx	edx, byte [r12]
	mov	esi, eax
	movzx	eax, dl
	movzx	eax, byte [rdi+1+rax*2]
	shr	al, 5
	and	eax, 1
	cmp	dl, 44
	sete	cl
	or	al, cl
	je	.L91
	add	r12, 1
	cmp	r12, r13
	jne	.L92
.L72:
	mov	eax, 1
.L62:
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L91:
	test	sil, sil
	je	.L74
	mov	qword [rsp+8], r14
.L74:
	cmp	dl, 93
	je	.L72
	cmp	dl, 34
	jne	.L71
	lea	rdi, [rsp+8]
	call	parse_json_string
	mov	rdi, qword [rbp+0]
	mov	r12, rax
	mov	rax, qword [rbx]
	lea	rsi, [8+rax*8]
	call	realloc
	test	r12, r12
	je	.L80
	test	rax, rax
	je	.L80
	mov	rdx, qword [rbx]
	mov	qword [rbp+0], rax
	lea	rcx, [rdx+1]
	mov	qword [rbx], rcx
	mov	qword [rax+rdx*8], r12
	mov	r12, qword [rsp+8]
	cmp	r12, r13
	jb	.L70
.L71:
	xor	eax, eax
	jmp	.L62
.L90:
	movzx	eax, byte [r12+1]
	mov	r12, r13
	cmp	al, 91
	jne	.L72
	jmp	.L93
.L80:
	mov	rdi, r12
	call	free
	xor	eax, eax
	jmp	.L62
.L89:
	movzx	eax, byte [rax]
	jmp	.L66
section .rodata
LC2:
	db "", 0
LC3:
	db "null", 0
object_string:
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	sub	rsp, 16
	call	find_key
	mov	qword [rsp+8], rax
	test	rax, rax
	je	.L107
	mov	rbx, rax
	cmp	rax, rbp
	jnb	.L96
	call	__ctype_b_loc
	xor	edx, edx
	mov	rcx, qword [rax]
	jmp	.L97
.L99:
	add	rbx, 1
	mov	edx, 1
	cmp	rbx, rbp
	je	.L108
	mov	r12, rbx
.L97:
	movzx	eax, byte [rbx]
	test	byte [rcx+1+rax*2], 32
	jne	.L99
	test	dl, dl
	je	.L100
	mov	qword [rsp+8], r12
.L100:
	sub	rbp, rbx
	cmp	rbp, 3
	jle	.L96
	mov	edx, 4
	mov	esi, LC3
	mov	rdi, rbx
	call	strncmp
	test	eax, eax
	je	.L107
.L96:
	cmp	byte [rbx], 34
	je	.L101
.L107:
	add	rsp, 16
	mov	edi, LC2
	pop	rbx
	pop	rbp
	pop	r12
	jmp	strdup
.L101:
	lea	rdi, [rsp+8]
	call	parse_json_string
	add	rsp, 16
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L108:
	cmp	byte [rbx], 34
	mov	qword [rsp+8], rbx
	je	.L101
	jmp	.L107
section .rodata
LC4:
	db "unknown error", 0
LC5:
	db "--location", 0
LC6:
	db "--show-error", 0
LC7:
	db "--silent", 0
LC8:
	db "--fail", 0
LC9:
	db "curl", 0
LC10:
	db "60", 0
LC11:
	db "--max-time", 0
LC12:
	db "15", 0
LC13:
	db "--connect-timeout", 0
LC14:
	db "out of memory", 0
LC15:
	db "AUR RPC HTTP request failed", 0
curl_get.constprop.0:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	mov	rbx, rsi
	sub	rsp, 8248
	mov	qword [rsi], 0
	lea	rdi, [rsp+40]
	mov	qword [rsp+16], rdx
	mov	qword [rsp+24], rcx
	call	pipe
	test	eax, eax
	jne	.L165
	call	fork
	mov	r15d, eax
	test	eax, eax
	js	.L166
	je	.L167
	mov	edi, dword [rsp+44]
	xor	r14d, r14d
	xor	ebp, ebp
	lea	r12, [rsp+48]
	call	close
.L123:
	mov	edi, dword [rsp+40]
	mov	edx, 8192
	mov	rsi, r12
	call	read
	mov	rdx, rax
	test	rax, rax
	jle	.L168
	lea	r13, [rdx+rbp]
	lea	rax, [r13+1]
	cmp	r14, rax
	jnb	.L169
	test	r14, r14
	jne	.L127
	mov	r14d, 8192
	cmp	rax, 8192
	jbe	.L128
.L127:
	add	r14, r14
	cmp	r14, rax
	jb	.L127
.L128:
	mov	rdi, qword [rbx]
	mov	rsi, r14
	mov	qword [rsp+8], rdx
	call	realloc
	mov	rdx, qword [rsp+8]
	test	rax, rax
	je	.L170
	mov	qword [rbx], rax
.L125:
	lea	rdi, [rax+rbp]
	mov	rsi, r12
	mov	rbp, r13
	call	memcpy
	mov	rax, qword [rbx]
	mov	byte [rax+r13], 0
	jmp	.L123
.L167:
	mov	edi, dword [rsp+40]
	call	close
	mov	edi, dword [rsp+44]
	mov	esi, 1
	call	dup2
	test	eax, eax
	js	.L164
	mov	edi, dword [rsp+44]
	call	close
	push	0
	mov	esi, LC9
	xor	eax, eax
	push	rbp
	mov	r9d, LC5
	mov	r8d, LC6
	mov	rdi, rsi
	push	LC10
	mov	ecx, LC7
	mov	edx, LC8
	push	LC11
	push	LC12
	push	LC13
	call	execlp
	add	rsp, 48
.L164:
	mov	edi, 127
	call	_exit
.L169:
	mov	rax, qword [rbx]
	jmp	.L125
.L165:
	call	__errno_location
	mov	edi, dword [rax]
	call	strerror
	cmp	qword [rsp+16], 0
	mov	rbx, rax
	je	.L113
	cmp	qword [rsp+24], 0
	je	.L113
	test	rax, rax
	je	.L149
	mov	rdi, rax
	call	strlen
	mov	rbp, rax
.L114:
	mov	rcx, qword [rsp+24]
	mov	rsi, rbx
	mov	rbx, qword [rsp+16]
	lea	rax, [rcx-1]
	cmp	rbp, rcx
	mov	rdi, rbx
	cmovnb	rbp, rax
	mov	rdx, rbp
	call	memcpy
	mov	byte [rbx+rbp], 0
.L113:
	xor	eax, eax
.L109:
	add	rsp, 8248
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L149:
	mov	ebp, 13
	mov	ebx, LC4
	jmp	.L114
.L168:
	mov	edi, dword [rsp+40]
	lea	rbp, [rsp+36]
	call	close
	jmp	.L140
.L171:
	call	__errno_location
	cmp	dword [rax], 4
	jne	.L139
.L140:
	xor	edx, edx
	mov	rsi, rbp
	mov	edi, r15d
	call	waitpid
	test	eax, eax
	js	.L171
.L139:
	mov	rdi, qword [rbx]
	test	word [rsp+36], -129
	jne	.L172
	test	rdi, rdi
	je	.L173
.L148:
	xor	eax, eax
	test	rdi, rdi
	setne	al
	jmp	.L109
.L170:
	mov	edi, dword [rsp+40]
	call	close
	mov	esi, 15
	mov	edi, r15d
	call	kill
	xor	edx, edx
	xor	esi, esi
	mov	edi, r15d
	call	waitpid
	mov	rdi, qword [rbx]
	call	free
	cmp	qword [rsp+16], 0
	mov	qword [rbx], 0
	je	.L113
	cmp	qword [rsp+24], 0
	je	.L113
	mov	rcx, qword [rsp+24]
	mov	eax, 14
	cmp	rcx, rax
	mov	rdx, rcx
	mov	ecx, LC14
	cmova	rdx, rax
	lea	rax, [rdx-1]
	cmp	eax, 8
	jnb	.L132
	test	al, 4
	jne	.L174
	test	eax, eax
	je	.L143
	movzx	ecx, byte [rel LC14]
	mov	rbx, qword [rsp+16]
	mov	byte [rbx], cl
	test	al, 2
	jne	.L175
.L143:
	mov	rax, qword [rsp+16]
	mov	byte [rax-1+rdx], 0
	jmp	.L113
.L166:
	mov	edi, dword [rsp+40]
	call	close
	mov	edi, dword [rsp+44]
	call	close
	call	__errno_location
	mov	edi, dword [rax]
	call	strerror
	cmp	qword [rsp+16], 0
	mov	rbp, rax
	je	.L113
	cmp	qword [rsp+24], 0
	je	.L113
	test	rax, rax
	je	.L150
	mov	rdi, rax
	call	strlen
	mov	rbx, rax
.L118:
	mov	rcx, qword [rsp+24]
	mov	r15, qword [rsp+16]
	mov	rsi, rbp
	lea	rax, [rcx-1]
	cmp	rbx, rcx
	mov	rdi, r15
	cmovnb	rbx, rax
	mov	rdx, rbx
	call	memcpy
	mov	byte [r15+rbx], 0
	jmp	.L113
.L132:
	mov	rbx, qword [rsp+16]
	mov	rsi, qword [rel LC14]
	mov	qword [rbx], rsi
	mov	esi, eax
	mov	rdi, qword LC[rsi-8+14]
	mov	qword [rbx-8+rsi], rdi
	lea	rsi, [rbx+8]
	and	rsi, -8
	sub	rbx, rsi
	add	eax, ebx
	sub	rcx, rbx
	and	eax, -8
	cmp	eax, 8
	jb	.L143
	and	eax, -8
	xor	edi, edi
.L136:
	mov	r8d, edi
	add	edi, 8
	mov	r9, qword [rcx+r8]
	mov	qword [rsi+r8], r9
	cmp	edi, eax
	jb	.L136
	jmp	.L143
.L150:
	mov	ebx, 13
	mov	ebp, LC4
	jmp	.L118
.L172:
	call	free
	cmp	qword [rsp+16], 0
	mov	qword [rbx], 0
	je	.L113
	mov	rax, qword [rsp+24]
	test	rax, rax
	je	.L113
	mov	edx, 28
	mov	edi, LC15
	cmp	rax, rdx
	cmovbe	rdx, rax
	lea	rax, [rdx-1]
	cmp	eax, 8
	jnb	.L142
	test	al, 4
	jne	.L176
	test	eax, eax
	je	.L143
	movzx	ecx, byte [rel LC15]
	mov	rbx, qword [rsp+16]
	mov	byte [rbx], cl
	test	al, 2
	je	.L143
	mov	eax, eax
	mov	rbx, qword [rsp+16]
	movzx	ecx, word LC[rax-2+15]
	mov	word [rbx-2+rax], cx
	jmp	.L143
.L173:
	mov	edi, LC2
	call	strdup
	mov	qword [rbx], rax
	mov	rdi, rax
	jmp	.L148
.L142:
	mov	rbx, qword [rsp+16]
	mov	rcx, qword [rel LC15]
	mov	qword [rbx], rcx
	mov	ecx, eax
	mov	rsi, qword LC[rcx-8+15]
	mov	qword [rbx-8+rcx], rsi
	lea	rsi, [rbx+8]
	mov	rcx, rbx
	and	rsi, -8
	sub	rcx, rsi
	add	eax, ecx
	sub	rdi, rcx
	and	eax, -8
	cmp	eax, 8
	jb	.L143
	and	eax, -8
	xor	ecx, ecx
.L146:
	mov	r8d, ecx
	add	ecx, 8
	mov	r9, qword [rdi+r8]
	mov	qword [rsi+r8], r9
	cmp	ecx, eax
	jb	.L146
	jmp	.L143
.L174:
	mov	ecx, dword [rel LC14]
	mov	rbx, qword [rsp+16]
	mov	eax, eax
	mov	dword [rbx], ecx
	mov	ecx, dword LC[rax-4+14]
	mov	dword [rbx-4+rax], ecx
	jmp	.L143
.L176:
	mov	ecx, dword [rel LC15]
	mov	rbx, qword [rsp+16]
	mov	eax, eax
	mov	dword [rbx], ecx
	mov	ecx, dword LC[rax-4+15]
	mov	dword [rbx-4+rax], ecx
	jmp	.L143
.L175:
	mov	eax, eax
	mov	rbx, qword [rsp+16]
	movzx	ecx, word LC[rax-2+14]
	mov	word [rbx-2+rax], cx
	jmp	.L143
section .rodata
LC17:
	db "search", 0
LC18:
	db "%s/search/%s?by=name-desc", 0
LC19:
	db "%s/info?arg[]=%s", 0
LC20:
	db '"results"', 0
LC21:
	db "invalid AUR RPC response", 0
LC22:
	db "truncated AUR RPC object", 0
LC23:
	db "Name", 0
LC24:
	db "PackageBase", 0
LC25:
	db "Version", 0
LC26:
	db "Description", 0
LC27:
	db "URL", 0
LC28:
	db "Maintainer", 0
LC29:
	db "NumVotes", 0
LC30:
	db "Popularity", 0
LC31:
	db "OutOfDate", 0
LC32:
	db "Depends", 0
LC33:
	db "MakeDepends", 0
LC34:
	db "CheckDepends", 0
LC35:
	db "Provides", 0
LC36:
	db "Conflicts", 0
section .rodata
LC37:
	db "cannot parse AUR package metadata", 0
section .rodata
LC38:
	db "truncated AUR RPC results", 0
request:
	push	r15
	push	r14
	push	r13
	mov	r13, rdx
	push	r12
	mov	r12, r9
	push	rbp
	mov	rbp, r8
	push	rbx
	mov	rbx, rcx
	sub	rsp, 216
	mov	qword [rsp+16], rdi
	mov	rdi, rdx
	mov	qword [rsp], rsi
	call	strlen
	lea	rdi, [rax+1+rax*2]
	mov	r14, rax
	call	malloc
	test	rax, rax
	je	.L178
	mov	r15, rax
	mov	rcx, rax
	test	r14, r14
	je	.L180
	call	__ctype_b_loc
	mov	rdx, r13
	lea	r9, [r13+0+r14]
	xor	ecx, ecx
	mov	r10, qword [rax]
	jmp	.L187
.L346:
	lea	edi, [rdi-45]
	cmp	dil, 1
	jbe	.L184
	cmp	al, 95
	je	.L184
	cmp	al, 126
	je	.L184
	mov	byte [rsi], 37
	mov	esi, eax
	and	eax, 15
	lea	rdi, [rcx+2]
	shr	sil, 4
	movzx	eax, byte hex.[rax]
	add	rdx, 1
	and	esi, 15
	movzx	esi, byte hex.[rsi]
	mov	byte [r15+1+rcx], sil
	add	rcx, 3
	mov	byte [r15+rdi], al
	cmp	r9, rdx
	je	.L345
.L187:
	movzx	edi, byte [rdx]
	lea	r11, [rcx+1]
	lea	rsi, [r15+rcx]
	mov	rax, rdi
	test	byte [r10+rdi*2], 8
	je	.L346
.L184:
	add	rdx, 1
	mov	byte [rsi], al
	mov	rcx, r11
	cmp	r9, rdx
	jne	.L187
.L345:
	add	rcx, r15
.L180:
	mov	byte [rcx], 0
	pxor	xmm0, xmm0
	mov	rdi, qword [rsp+16]
	movups	oword [rbx], xmm0
	mov	qword [rsp+40], 0
	call	strlen
	mov	rdi, qword [rsp]
	mov	qword [rsp+8], rax
	call	strlen
	mov	rdi, r15
	mov	r13, rax
	call	strlen
	mov	rdx, qword [rsp+8]
	lea	rdx, [rdx+32+r13]
	lea	r13, [rdx+rax]
	mov	rdi, r13
	call	malloc
	mov	qword [rsp+8], rax
	test	rax, rax
	je	.L347
	mov	rdi, qword [rsp]
	mov	esi, LC17
	call	strcmp
	mov	rcx, qword [rsp+16]
	mov	r8, r15
	test	eax, eax
	je	.L348
	mov	rdi, qword [rsp+8]
	mov	edx, LC19
	mov	rsi, r13
	xor	eax, eax
	call	snprintf
.L199:
	mov	rdi, r15
	call	free
	mov	rdi, qword [rsp+8]
	mov	rcx, r12
	mov	rdx, rbp
	lea	rsi, [rsp+40]
	call	curl_get.constprop.0
	mov	rdi, qword [rsp+40]
	mov	dword [rsp+16], eax
	mov	qword [rsp+24], rdi
	test	eax, eax
	je	.L209
	mov	esi, LC20
	call	strstr
	mov	rdi, rax
	test	rax, rax
	je	.L201
	mov	esi, 91
	call	strchr
	test	rax, rax
	je	.L201
	lea	r15, [rax+1]
	movzx	eax, byte [rax+1]
	test	al, al
	je	.L211
.L210:
	mov	r13, r15
	cmp	al, 123
	jne	.L256
	jmp	.L249
.L213:
	movzx	eax, byte [r13+1]
	add	r13, 1
	test	al, al
	je	.L266
	cmp	al, 123
	je	.L212
.L256:
	cmp	al, 93
	jne	.L213
.L214:
	mov	rdi, qword [rsp+8]
	call	free
	mov	rdi, qword [rsp+24]
	call	free
.L177:
	mov	eax, dword [rsp+16]
	add	rsp, 216
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L348:
	mov	rdi, qword [rsp+8]
	mov	edx, LC18
	mov	rsi, r13
	call	snprintf
	jmp	.L199
.L212:
	test	al, al
	je	.L266
.L249:
	mov	r15, r13
	xor	esi, esi
	mov	eax, 123
	jmp	.L224
.L222:
	cmp	al, 125
	je	.L349
.L223:
	mov	r15, rdx
.L220:
	movzx	eax, byte [r15]
	test	al, al
	je	.L265
.L224:
	lea	rdx, [r15+1]
	cmp	al, 34
	je	.L350
	cmp	al, 123
	jne	.L222
	add	esi, 1
	jmp	.L223
.L349:
	sub	esi, 1
	jne	.L223
	mov	r15, rdx
.L215:
	lea	r14, [rsp+48]
	xor	eax, eax
	mov	ecx, 19
	mov	rsi, r15
	mov	rdi, r14
	mov	edx, LC23
	rep stosq
	mov	rdi, r13
	call	object_string
	mov	edx, LC24
	mov	rsi, r15
	mov	rdi, r13
	mov	qword [rsp+48], rax
	call	object_string
	mov	edx, LC25
	mov	rsi, r15
	mov	rdi, r13
	mov	qword [rsp+56], rax
	call	object_string
	mov	edx, LC26
	mov	rsi, r15
	mov	rdi, r13
	mov	qword [rsp+64], rax
	call	object_string
	mov	edx, LC27
	mov	rsi, r15
	mov	rdi, r13
	mov	qword [rsp+72], rax
	call	object_string
	mov	edx, LC28
	mov	rsi, r15
	mov	rdi, r13
	mov	qword [rsp+80], rax
	call	object_string
	mov	rdi, r13
	mov	edx, LC29
	mov	rsi, r15
	mov	qword [rsp+88], rax
	call	find_key
	mov	rdi, rax
	test	rax, rax
	je	.L269
	cmp	rax, r15
	jnb	.L232
	mov	qword [rsp], rax
	call	__ctype_b_loc
	mov	rdi, qword [rsp]
	mov	rdx, qword [rax]
	jmp	.L233
.L234:
	add	rdi, 1
	cmp	r15, rdi
	je	.L232
.L233:
	movzx	eax, byte [rdi]
	test	byte [rdx+1+rax*2], 32
	jne	.L234
.L232:
	mov	edx, 10
	xor	esi, esi
	call	strtol
.L231:
	mov	rdi, r13
	mov	edx, LC30
	mov	rsi, r15
	mov	qword [rsp+96], rax
	call	find_key
	mov	rdi, rax
	test	rax, rax
	je	.L271
	cmp	rax, r15
	jnb	.L236
	mov	qword [rsp], rax
	call	__ctype_b_loc
	mov	rdi, qword [rsp]
	mov	rdx, qword [rax]
	jmp	.L237
.L238:
	add	rdi, 1
	cmp	r15, rdi
	je	.L236
.L237:
	movzx	eax, byte [rdi]
	test	byte [rdx+1+rax*2], 32
	jne	.L238
.L236:
	xor	esi, esi
	call	strtod
.L235:
	mov	rdi, r13
	mov	edx, LC31
	mov	rsi, r15
	movsd	qword [rsp+104], xmm0
	call	find_key
	mov	rdi, rax
	test	rax, rax
	je	.L273
	cmp	rax, r15
	jnb	.L240
	mov	qword [rsp], rax
	call	__ctype_b_loc
	mov	rdi, qword [rsp]
	mov	rdx, qword [rax]
	jmp	.L241
.L242:
	add	rdi, 1
	cmp	r15, rdi
	je	.L240
.L241:
	movzx	eax, byte [rdi]
	test	byte [rdx+1+rax*2], 32
	jne	.L242
.L240:
	mov	edx, 10
	xor	esi, esi
	call	strtol
.L239:
	cmp	qword [rsp+48], 0
	mov	qword [rsp+112], rax
	je	.L244
	cmp	qword [rsp+56], 0
	je	.L244
	cmp	qword [rsp+64], 0
	je	.L244
	cmp	qword [rsp+72], 0
	je	.L244
	cmp	qword [rsp+80], 0
	je	.L244
	cmp	qword [rsp+88], 0
	je	.L244
	lea	rcx, [rsp+120]
	mov	edx, LC32
	mov	rsi, r15
	mov	rdi, r13
	lea	r8, [rsp+128]
	call	object_array
	test	eax, eax
	je	.L244
	lea	rcx, [rsp+136]
	mov	edx, LC33
	mov	rsi, r15
	mov	rdi, r13
	lea	r8, [rsp+144]
	call	object_array
	test	eax, eax
	jne	.L351
.L244:
	mov	rdi, r14
	call	package_destroy
	test	rbp, rbp
	je	.L209
	test	r12, r12
	je	.L209
	mov	edx, 34
	mov	edi, LC37
	cmp	r12, rdx
	cmovbe	rdx, r12
	lea	rax, [rdx-1]
	cmp	eax, 8
	jnb	.L250
	test	al, 4
	jne	.L352
	test	eax, eax
	je	.L258
	movzx	ecx, byte [rel LC37]
	mov	byte [rbp+0], cl
	test	al, 2
	je	.L258
	mov	eax, eax
	movzx	ecx, word LC[rax-2+37]
	mov	word [rbp-2+rax], cx
	jmp	.L258
.L350:
	movzx	eax, byte [r15+1]
	test	al, al
	je	.L267
.L221:
	lea	rcx, [rdx+1]
	mov	r15, rcx
	cmp	al, 92
	je	.L353
	movzx	edx, byte [rdx+1]
	cmp	al, 34
	je	.L220
	mov	eax, edx
.L219:
	mov	rdx, rcx
	test	al, al
	jne	.L221
	mov	r15, rcx
.L265:
	test	esi, esi
	je	.L215
	test	rbp, rbp
	je	.L209
	test	r12, r12
	je	.L209
	mov	edx, 25
	mov	edi, LC22
	cmp	r12, rdx
	cmovbe	rdx, r12
	lea	rax, [rdx-1]
	cmp	eax, 8
	jnb	.L225
	test	al, 4
	jne	.L354
	test	eax, eax
	je	.L258
	movzx	ecx, byte [rel LC22]
	mov	byte [rbp+0], cl
	test	al, 2
	jne	.L355
.L258:
	mov	byte [rbp-1+rdx], 0
.L209:
	xor	ebp, ebp
	cmp	qword [rbx+8], 0
	je	.L264
.L263:
	lea	rax, [rbp+0+rbp*8]
	lea	rdx, [rbp+0+rax*2]
	mov	rax, qword [rbx]
	add	rbp, 1
	lea	rdi, [rax+rdx*8]
	call	package_destroy
	cmp	rbp, qword [rbx+8]
	jb	.L263
.L264:
	mov	rdi, qword [rbx]
	call	free
	mov	qword [rbx], 0
	mov	qword [rbx+8], 0
	mov	dword [rsp+16], 0
	jmp	.L214
.L353:
	cmp	byte [rdx+1], 0
	je	.L265
	movzx	eax, byte [rdx+2]
	lea	rcx, [rdx+2]
	jmp	.L219
.L273:
	xor	eax, eax
	jmp	.L239
.L271:
	pxor	xmm0, xmm0
	jmp	.L235
.L269:
	xor	eax, eax
	jmp	.L231
.L178:
	pxor	xmm0, xmm0
	movups	oword [rbx], xmm0
	test	rbp, rbp
	je	.L183
	test	r12, r12
	je	.L183
	mov	eax, 14
	mov	ecx, LC14
	cmp	r12, rax
	cmovbe	rax, r12
	mov	rdx, rax
	lea	rax, [rax-1]
	cmp	eax, 8
	jb	.L356
	mov	rsi, qword [rel LC14]
	mov	qword [rbp+0], rsi
	mov	esi, eax
	mov	rdi, qword LC[rsi-8+14]
	mov	qword [rbp-8+rsi], rdi
	lea	rsi, [rbp+8]
	mov	rdi, rbp
	and	rsi, -8
	sub	rdi, rsi
	add	eax, edi
	sub	rcx, rdi
	and	eax, -8
	cmp	eax, 8
	jb	.L191
	and	eax, -8
	xor	edi, edi
.L194:
	mov	r8d, edi
	add	edi, 8
	mov	r9, qword [rcx+r8]
	mov	qword [rsi+r8], r9
	cmp	edi, eax
	jb	.L194
.L191:
	mov	byte [rbp-1+rdx], 0
.L183:
	mov	dword [rsp+16], 0
	jmp	.L177
.L351:
	lea	rcx, [rsp+152]
	mov	edx, LC34
	mov	rsi, r15
	mov	rdi, r13
	lea	r8, [rsp+160]
	call	object_array
	test	eax, eax
	je	.L244
	lea	rcx, [rsp+168]
	mov	edx, LC35
	mov	rsi, r15
	mov	rdi, r13
	lea	r8, [rsp+176]
	call	object_array
	test	eax, eax
	je	.L244
	lea	rcx, [rsp+184]
	mov	edx, LC36
	mov	rsi, r15
	mov	rdi, r13
	lea	r8, [rsp+192]
	call	object_array
	test	eax, eax
	je	.L244
	mov	rax, qword [rbx+8]
	mov	rdi, qword [rbx]
	add	rax, 1
	lea	rdx, [rax+rax*8]
	lea	rsi, [rax+rdx*2]
	sal	rsi, 3
	call	realloc
	mov	rdx, rax
	test	rax, rax
	je	.L244
	mov	qword [rbx], rax
	mov	rax, qword [rbx+8]
	movdqa	xmm0, oword [rsp+48]
	lea	rcx, [rax+1]
	mov	qword [rbx+8], rcx
	lea	rcx, [rax+rax*8]
	lea	rax, [rax+rcx*2]
	lea	rax, [rdx+rax*8]
	movups	oword [rax], xmm0
	movdqa	xmm0, oword [rsp+64]
	movups	oword [rax+16], xmm0
	movdqa	xmm0, oword [rsp+80]
	movups	oword [rax+32], xmm0
	movdqa	xmm0, oword [rsp+96]
	movups	oword [rax+48], xmm0
	movdqa	xmm0, oword [rsp+112]
	movups	oword [rax+64], xmm0
	movdqa	xmm0, oword [rsp+128]
	movups	oword [rax+80], xmm0
	movdqa	xmm0, oword [rsp+144]
	movups	oword [rax+96], xmm0
	movdqa	xmm0, oword [rsp+160]
	movups	oword [rax+112], xmm0
	movdqa	xmm0, oword [rsp+176]
	movups	oword [rax+128], xmm0
	mov	rdx, qword [rsp+192]
	mov	qword [rax+144], rdx
	movzx	eax, byte [r15]
	test	al, al
	jne	.L210
.L211:
	test	rbp, rbp
	je	.L209
	test	r12, r12
	je	.L209
	mov	edx, 26
	mov	edi, LC38
	cmp	r12, rdx
	cmovbe	rdx, r12
	lea	rax, [rdx-1]
	cmp	eax, 8
	jnb	.L257
	test	al, 4
	jne	.L357
	test	eax, eax
	je	.L258
	movzx	ecx, byte [rel LC38]
	mov	byte [rbp+0], cl
	test	al, 2
	je	.L258
	mov	eax, eax
	movzx	ecx, word LC[rax-2+38]
	mov	word [rbp-2+rax], cx
	jmp	.L258
.L356:
	test	al, 4
	jne	.L358
	test	eax, eax
	je	.L191
	movzx	ecx, byte [rel LC14]
	mov	byte [rbp+0], cl
	test	al, 2
	je	.L191
	mov	eax, eax
	movzx	ecx, word LC[rax-2+14]
	mov	word [rbp-2+rax], cx
	jmp	.L191
.L266:
	mov	r15, r13
	jmp	.L215
.L267:
	mov	r15, rdx
	jmp	.L265
.L201:
	test	rbp, rbp
	je	.L209
	test	r12, r12
	je	.L209
	mov	eax, 25
	mov	esi, LC21
	cmp	r12, rax
	cmovbe	rax, r12
	mov	rdx, rax
	lea	rax, [rax-1]
	cmp	eax, 8
	jnb	.L203
	test	al, 4
	jne	.L359
	test	eax, eax
	je	.L258
	movzx	ecx, byte [rel LC21]
	mov	byte [rbp+0], cl
	test	al, 2
	je	.L258
	mov	eax, eax
	movzx	ecx, word LC[rax-2+21]
	mov	word [rbp-2+rax], cx
	jmp	.L258
.L203:
	mov	rcx, qword [rel LC21]
	mov	qword [rbp+0], rcx
	mov	ecx, eax
	mov	rdi, qword LC[rcx-8+21]
	mov	qword [rbp-8+rcx], rdi
	lea	rdi, [rbp+8]
	mov	rcx, rbp
	and	rdi, -8
	sub	rcx, rdi
	add	eax, ecx
	sub	rsi, rcx
	and	eax, -8
	cmp	eax, 8
	jb	.L258
	and	eax, -8
	xor	ecx, ecx
.L207:
	mov	r8d, ecx
	add	ecx, 8
	mov	r9, qword [rsi+r8]
	mov	qword [rdi+r8], r9
	cmp	ecx, eax
	jb	.L207
	jmp	.L258
.L250:
	mov	rcx, qword [rel LC37]
	mov	qword [rbp+0], rcx
	mov	ecx, eax
	mov	rsi, qword LC[rcx-8+37]
	mov	qword [rbp-8+rcx], rsi
	lea	rsi, [rbp+8]
	mov	rcx, rbp
	and	rsi, -8
	sub	rcx, rsi
	add	eax, ecx
	sub	rdi, rcx
	and	eax, -8
	cmp	eax, 8
	jb	.L258
	and	eax, -8
	xor	ecx, ecx
.L254:
	mov	r8d, ecx
	add	ecx, 8
	mov	r9, qword [rdi+r8]
	mov	qword [rsi+r8], r9
	cmp	ecx, eax
	jb	.L254
	jmp	.L258
.L225:
	mov	rcx, qword [rel LC22]
	mov	qword [rbp+0], rcx
	mov	ecx, eax
	mov	rsi, qword LC[rcx-8+22]
	mov	qword [rbp-8+rcx], rsi
	lea	rsi, [rbp+8]
	mov	rcx, rbp
	and	rsi, -8
	sub	rcx, rsi
	add	eax, ecx
	sub	rdi, rcx
	and	eax, -8
	cmp	eax, 8
	jb	.L258
	and	eax, -8
	xor	ecx, ecx
.L229:
	mov	r8d, ecx
	add	ecx, 8
	mov	r9, qword [rdi+r8]
	mov	qword [rsi+r8], r9
	cmp	ecx, eax
	jb	.L229
	jmp	.L258
.L257:
	mov	rcx, qword [rel LC38]
	mov	qword [rbp+0], rcx
	mov	ecx, eax
	mov	rsi, qword LC[rcx-8+38]
	mov	qword [rbp-8+rcx], rsi
	lea	rsi, [rbp+8]
	mov	rcx, rbp
	and	rsi, -8
	sub	rcx, rsi
	add	eax, ecx
	sub	rdi, rcx
	and	eax, -8
	cmp	eax, 8
	jb	.L258
	and	eax, -8
	xor	ecx, ecx
.L261:
	mov	r8d, ecx
	add	ecx, 8
	mov	r9, qword [rdi+r8]
	mov	qword [rsi+r8], r9
	cmp	ecx, eax
	jb	.L261
	jmp	.L258
.L358:
	mov	ecx, dword [rel LC14]
	mov	eax, eax
	mov	dword [rbp+0], ecx
	mov	ecx, dword LC[rax-4+14]
	mov	dword [rbp-4+rax], ecx
	jmp	.L191
.L354:
	mov	ecx, dword [rel LC22]
	mov	eax, eax
	mov	dword [rbp+0], ecx
	mov	ecx, dword LC[rax-4+22]
	mov	dword [rbp-4+rax], ecx
	jmp	.L258
.L352:
	mov	ecx, dword [rel LC37]
	mov	eax, eax
	mov	dword [rbp+0], ecx
	mov	ecx, dword LC[rax-4+37]
	mov	dword [rbp-4+rax], ecx
	jmp	.L258
.L357:
	mov	ecx, dword [rel LC38]
	mov	eax, eax
	mov	dword [rbp+0], ecx
	mov	ecx, dword LC[rax-4+38]
	mov	dword [rbp-4+rax], ecx
	jmp	.L258
.L359:
	mov	ecx, dword [rel LC21]
	mov	eax, eax
	mov	dword [rbp+0], ecx
	mov	ecx, dword LC[rax-4+21]
	mov	dword [rbp-4+rax], ecx
	jmp	.L258
.L355:
	mov	eax, eax
	movzx	ecx, word LC[rax-2+22]
	mov	word [rbp-2+rax], cx
	jmp	.L258
.L347:
	mov	rdi, r15
	call	free
	test	rbp, rbp
	je	.L183
	test	r12, r12
	je	.L183
	mov	eax, 14
	mov	esi, LC14
	mov	rdi, rbp
	cmp	r12, rax
	cmovbe	rax, r12
	lea	ecx, [rax-1]
	rep movsb
	mov	byte [rbp-1+rax], 0
	jmp	.L183
global aur_response_destroy
aur_response_destroy:
	test	rdi, rdi
	je	.L369
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 8
	cmp	qword [rdi+8], 0
	je	.L362
	xor	ebx, ebx
.L363:
	lea	rax, [rbx+rbx*8]
	lea	rdx, [rbx+rax*2]
	mov	rax, qword [rbp+0]
	add	rbx, 1
	lea	rdi, [rax+rdx*8]
	call	package_destroy
	cmp	rbx, qword [rbp+8]
	jb	.L363
.L362:
	mov	rdi, qword [rbp+0]
	call	free
	mov	qword [rbp+0], 0
	mov	qword [rbp+8], 0
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L369:
	ret
section .rodata
LC40:
	db "https://aur.archlinux.org/rpc/v5", 0
global aur_rpc_search
aur_rpc_search:
	test	rdi, rdi
	mov	eax, LC40
	mov	r9, r8
	mov	r8, rcx
	cmove	rdi, rax
	mov	rcx, rdx
	mov	rdx, rsi
	mov	esi, LC17
	jmp	request
section .rodata
LC41:
	db "info", 0
global aur_rpc_info
aur_rpc_info:
	test	rdi, rdi
	mov	eax, LC40
	mov	r9, r8
	mov	r8, rcx
	cmove	rdi, rax
	mov	rcx, rdx
	mov	rdx, rsi
	mov	esi, LC41
	jmp	request
section .rodata
hex.0:
	db "0123456789ABCDEF", 0
