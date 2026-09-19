; sha256.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

; NASM assembly - converted from C: src/sha256.c
%use smartalign
section .text
sha256_transform:
	push	r14
	mov	eax, 16711935
	push	r13
	movd	xmm0, eax
	push	r12
	pshufd	xmm0, xmm0, 0
	movdqa	xmm1, xmm0
	movdqa	xmm6, xmm0
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 136
	movdqu	xmm2, oword [rsi]
	movdqu	xmm4, oword [rsi+16]
	movdqu	xmm3, oword [rsi+32]
	movdqu	xmm5, oword [rsi+48]
	lea	rax, [rsp-56]
	pand	xmm6, xmm4
	psrlw	xmm4, 8
	pand	xmm1, xmm2
	psrlw	xmm2, 8
	packuswb	xmm1, xmm6
	movdqa	xmm6, xmm0
	packuswb	xmm2, xmm4
	movdqa	xmm4, xmm0
	pand	xmm6, xmm5
	pand	xmm4, xmm3
	psrlw	xmm5, 8
	psrlw	xmm3, 8
	packuswb	xmm4, xmm6
	movdqa	xmm6, xmm0
	packuswb	xmm3, xmm5
	movdqa	xmm5, xmm0
	pand	xmm6, xmm1
	pand	xmm5, xmm4
	psrlw	xmm1, 8
	psrlw	xmm4, 8
	packuswb	xmm6, xmm5
	packuswb	xmm1, xmm4
	movdqa	xmm4, xmm0
	pand	xmm0, xmm3
	pand	xmm4, xmm2
	psrlw	xmm3, 8
	movdqa	xmm10, xmm6
	psrlw	xmm2, 8
	packuswb	xmm4, xmm0
	pxor	xmm0, xmm0
	packuswb	xmm2, xmm3
	punpckhbw	xmm6, xmm0
	movdqa	xmm5, xmm4
	movdqa	xmm7, xmm1
	punpckhbw	xmm4, xmm0
	movdqa	xmm9, xmm2
	pxor	xmm3, xmm3
	punpcklbw	xmm10, xmm0
	punpcklbw	xmm5, xmm0
	punpcklbw	xmm9, xmm0
	punpckhbw	xmm2, xmm0
	punpcklbw	xmm7, xmm0
	punpckhbw	xmm1, xmm0
	movdqa	xmm8, xmm6
	movdqa	xmm0, xmm4
	punpckhwd	xmm0, xmm3
	punpckhwd	xmm8, xmm3
	movdqa	xmm11, xmm2
	psllw	xmm1, 8
	pslld	xmm8, 24
	punpckhwd	xmm11, xmm3
	pslld	xmm0, 16
	psllw	xmm7, 8
	movdqa	xmm12, xmm9
	por	xmm0, xmm8
	movdqa	xmm8, xmm1
	punpcklwd	xmm4, xmm3
	punpckhwd	xmm8, xmm3
	punpcklwd	xmm6, xmm3
	punpcklwd	xmm12, xmm3
	por	xmm8, xmm11
	movdqa	xmm11, xmm10
	punpckhwd	xmm10, xmm3
	por	xmm0, xmm8
	movdqa	xmm8, xmm5
	punpcklwd	xmm11, xmm3
	punpcklwd	xmm8, xmm3
	pslld	xmm11, 24
	punpckhwd	xmm5, xmm3
	movaps	oword [rsp-72], xmm0
	pslld	xmm8, 16
	pslld	xmm5, 16
	punpckhwd	xmm9, xmm3
	psrldq	xmm0, 8
	por	xmm8, xmm11
	movdqa	xmm11, xmm7
	punpcklwd	xmm2, xmm3
	punpcklwd	xmm11, xmm3
	pslld	xmm10, 24
	punpckhwd	xmm7, xmm3
	pslld	xmm4, 16
	pslld	xmm6, 24
	punpcklwd	xmm1, xmm3
	por	xmm11, xmm12
	por	xmm5, xmm10
	por	xmm7, xmm9
	por	xmm4, xmm6
	por	xmm1, xmm2
	por	xmm8, xmm11
	por	xmm5, xmm7
	por	xmm1, xmm4
	movaps	oword [rsp-120], xmm8
	movaps	oword [rsp-104], xmm5
	movaps	oword [rsp-88], xmm1
.L2:
	movq	xmm2, qword [rax-60]
	lea	rbx, [rsp+136]
	add	rax, 8
	movdqa	xmm1, xmm2
	movdqa	xmm3, xmm2
	movdqa	xmm4, xmm2
	psrld	xmm3, 18
	pslld	xmm1, 14
	por	xmm1, xmm3
	psrld	xmm4, 7
	movdqa	xmm3, xmm2
	pslld	xmm3, 25
	psrld	xmm2, 3
	por	xmm3, xmm4
	movdqa	xmm4, xmm0
	pxor	xmm1, xmm3
	psrld	xmm4, 17
	movdqa	xmm3, xmm0
	pxor	xmm1, xmm2
	psrld	xmm3, 19
	movdqa	xmm2, xmm0
	pslld	xmm2, 13
	por	xmm2, xmm3
	movdqa	xmm3, xmm0
	pslld	xmm3, 15
	psrld	xmm0, 10
	por	xmm3, xmm4
	pxor	xmm2, xmm3
	pxor	xmm0, xmm2
	movq	xmm2, qword [rax-72]
	paddd	xmm1, xmm0
	movq	xmm0, qword [rax-36]
	paddd	xmm0, xmm2
	paddd	xmm0, xmm1
	movq	qword [rax-8], xmm0
	cmp	rax, rbx
	jne	.L2
	movdqu	xmm2, oword [rbp+80]
	mov	ebx, dword [rbp+92]
	xor	edi, edi
	lea	r12, [rsp-120]
	movdqu	xmm1, oword [rbp+96]
	mov	r13d, dword [rbp+108]
	mov	ecx, dword [rbp+80]
	mov	r8d, dword [rbp+84]
	mov	r9d, dword [rbp+88]
	mov	edx, dword [rbp+96]
	mov	r10d, dword [rbp+100]
	mov	r11d, dword [rbp+104]
	jmp	.L3
.L4:
	mov	r11d, r10d
	mov	r9d, r8d
	mov	r10d, edx
	mov	r8d, ecx
	mov	edx, esi
	mov	ecx, eax
.L3:
	mov	eax, edx
	mov	esi, edx
	mov	r14d, edx
	ror	esi, 11
	ror	eax, 6
	and	r14d, r10d
	xor	eax, esi
	mov	esi, edx
	rol	esi, 7
	xor	eax, esi
	mov	esi, dword [r12+rdi]
	add	esi, dword k[rdi]
	add	rdi, 4
	add	eax, esi
	mov	esi, edx
	not	esi
	and	esi, r11d
	xor	esi, r14d
	mov	r14d, r8d
	add	eax, esi
	mov	esi, ecx
	and	r14d, r9d
	add	eax, r13d
	mov	r13d, ecx
	ror	esi, 13
	ror	r13d, 2
	xor	r13d, esi
	mov	esi, ecx
	rol	esi, 10
	xor	r13d, esi
	mov	esi, r8d
	xor	esi, r9d
	and	esi, ecx
	xor	esi, r14d
	add	r13d, esi
	lea	esi, [rax+rbx]
	mov	ebx, r9d
	add	eax, r13d
	mov	r13d, r11d
	cmp	rdi, 256
	jne	.L4
	movd	xmm7, r9d
	movd	xmm3, r8d
	movd	xmm0, eax
	punpckldq	xmm3, xmm7
	movd	xmm7, ecx
	punpckldq	xmm0, xmm7
	movd	xmm7, r11d
	punpcklqdq	xmm0, xmm3
	paddd	xmm0, xmm2
	movd	xmm2, r10d
	movups	oword [rbp+80], xmm0
	punpckldq	xmm2, xmm7
	movd	xmm0, esi
	movd	xmm7, edx
	punpckldq	xmm0, xmm7
	punpcklqdq	xmm0, xmm2
	paddd	xmm0, xmm1
	movups	oword [rbp+96], xmm0
	add	rsp, 136
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
global sha256_init
sha256_init:
	movdqa	xmm0, oword [rel LC2]
	mov	dword [rdi+64], 0
	mov	qword [rdi+72], 0
	movups	oword [rdi+80], xmm0
	movdqa	xmm0, oword [rel LC3]
	movups	oword [rdi+96], xmm0
	ret
global sha256_update
sha256_update:
	test	rdx, rdx
	je	.L16
	push	r12
	lea	r12, [rsi+rdx]
	push	rbp
	mov	rbp, rdi
	push	rbx
	mov	rbx, rsi
	mov	eax, dword [rdi+64]
	jmp	.L13
.L11:
	add	rbx, 1
	cmp	r12, rbx
	je	.L9
.L13:
	movzx	ecx, byte [rbx]
	mov	edx, eax
	add	eax, 1
	mov	byte [rbp+0+rdx], cl
	mov	dword [rbp+64], eax
	cmp	eax, 64
	jne	.L11
	mov	rsi, rbp
	mov	rdi, rbp
	call	sha256_transform
	lea	rax, [rbx+1]
	add	qword [rbp+72], 512
	mov	dword [rbp+64], 0
	cmp	rax, r12
	je	.L9
	movzx	eax, byte [rbx+1]
	add	rbx, 2
	mov	dword [rbp+64], 1
	mov	byte [rbp+0], al
	cmp	r12, rbx
	je	.L9
	movzx	eax, byte [rbx]
	add	rbx, 1
	mov	dword [rbp+64], 2
	mov	byte [rbp+1], al
	mov	eax, 2
	cmp	r12, rbx
	jne	.L13
.L9:
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L16:
	ret
global sha256_final
sha256_final:
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	r12d, dword [rdi+64]
	mov	rbx, rdi
	mov	edx, r12d
	lea	eax, [r12+1]
	mov	byte [rdi+rdx], -128
	cmp	r12d, 55
	ja	.L20
	cmp	eax, 56
	je	.L22
	mov	edx, 55
	add	rax, rdi
	xor	esi, esi
	sub	edx, r12d
	cmp	edx, 8
	jnb	.L23
	test	dl, 4
	jne	.L53
	test	edx, edx
	jne	.L54
.L22:
	lea	eax, [0+r12*8]
	add	rax, qword [rbx+72]
	mov	rsi, rbx
	mov	rdi, rbx
	mov	qword [rbx+72], rax
	bswap	rax
	mov	qword [rbx+56], rax
	call	sha256_transform
	movzx	eax, byte [rbx+83]
	mov	byte [rbp+0], al
	movzx	eax, byte [rbx+87]
	mov	byte [rbp+4], al
	movzx	eax, byte [rbx+91]
	mov	byte [rbp+8], al
	movzx	eax, byte [rbx+95]
	mov	byte [rbp+12], al
	movzx	eax, byte [rbx+99]
	mov	byte [rbp+16], al
	movzx	eax, byte [rbx+103]
	mov	byte [rbp+20], al
	movzx	eax, byte [rbx+107]
	mov	byte [rbp+24], al
	movzx	eax, byte [rbx+111]
	mov	byte [rbp+28], al
	movzx	eax, word [rbx+82]
	mov	byte [rbp+1], al
	movzx	eax, word [rbx+86]
	mov	byte [rbp+5], al
	movzx	eax, word [rbx+90]
	mov	byte [rbp+9], al
	movzx	eax, word [rbx+94]
	mov	byte [rbp+13], al
	movzx	eax, word [rbx+98]
	mov	byte [rbp+17], al
	movzx	eax, word [rbx+102]
	mov	byte [rbp+21], al
	movzx	eax, word [rbx+106]
	mov	byte [rbp+25], al
	movzx	eax, word [rbx+110]
	mov	byte [rbp+29], al
	mov	eax, dword [rbx+80]
	mov	byte [rbp+2], ah
	mov	eax, dword [rbx+84]
	mov	byte [rbp+6], ah
	mov	eax, dword [rbx+88]
	mov	byte [rbp+10], ah
	mov	eax, dword [rbx+92]
	mov	byte [rbp+14], ah
	mov	eax, dword [rbx+96]
	mov	byte [rbp+18], ah
	mov	eax, dword [rbx+100]
	mov	byte [rbp+22], ah
	mov	eax, dword [rbx+104]
	mov	byte [rbp+26], ah
	mov	eax, dword [rbx+108]
	mov	byte [rbp+30], ah
	mov	eax, dword [rbx+80]
	mov	byte [rbp+3], al
	mov	eax, dword [rbx+84]
	mov	byte [rbp+7], al
	mov	eax, dword [rbx+88]
	mov	byte [rbp+11], al
	mov	eax, dword [rbx+92]
	mov	byte [rbp+15], al
	mov	eax, dword [rbx+96]
	mov	byte [rbp+19], al
	mov	eax, dword [rbx+100]
	mov	byte [rbp+23], al
	mov	eax, dword [rbx+104]
	mov	byte [rbp+27], al
	mov	eax, dword [rbx+108]
	mov	byte [rbp+31], al
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L20:
	cmp	eax, 63
	ja	.L37
	mov	edx, 63
	add	rax, rdi
	xor	esi, esi
	sub	edx, r12d
	cmp	edx, 8
	jnb	.L31
	test	dl, 4
	jne	.L55
	test	edx, edx
	jne	.L56
.L37:
	mov	rsi, rbx
	mov	rdi, rbx
	call	sha256_transform
	pxor	xmm0, xmm0
	mov	qword [rbx+48], 0
	movups	oword [rbx], xmm0
	movups	oword [rbx+16], xmm0
	movups	oword [rbx+32], xmm0
	jmp	.L22
.L31:
	mov	ecx, edx
	mov	qword [rax], 0
	mov	qword [rax-8+rcx], 0
	lea	rcx, [rax+8]
	and	rcx, -8
	sub	rax, rcx
	add	edx, eax
	and	edx, -8
	cmp	edx, 8
	jb	.L37
	and	edx, -8
	xor	eax, eax
.L35:
	mov	edi, eax
	add	eax, 8
	mov	qword [rcx+rdi], rsi
	cmp	eax, edx
	jb	.L35
	jmp	.L37
.L23:
	mov	ecx, edx
	mov	qword [rax], 0
	mov	qword [rax-8+rcx], 0
	lea	rcx, [rax+8]
	and	rcx, -8
	sub	rax, rcx
	add	edx, eax
	and	edx, -8
	cmp	edx, 8
	jb	.L22
	and	edx, -8
	xor	eax, eax
.L27:
	mov	edi, eax
	add	eax, 8
	mov	qword [rcx+rdi], rsi
	cmp	eax, edx
	jb	.L27
	jmp	.L22
.L54:
	mov	byte [rax], 0
	test	dl, 2
	je	.L22
	xor	esi, esi
	mov	word [rax-2+rdx], si
	jmp	.L22
.L56:
	mov	byte [rax], 0
	test	dl, 2
	je	.L37
	xor	ecx, ecx
	mov	word [rax-2+rdx], cx
	jmp	.L37
.L55:
	mov	dword [rax], 0
	mov	dword [rax-4+rdx], 0
	jmp	.L37
.L53:
	mov	dword [rax], 0
	mov	dword [rax-4+rdx], 0
	jmp	.L22
section .rodata
LC4:
	db "rb", 0
LC5:
	db "%02x", 0
global sha256_file
sha256_file:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8360
	mov	qword [rsp+8], rsi
	test	rdi, rdi
	je	.L60
	test	rsi, rsi
	je	.L60
	mov	esi, LC4
	call	fopen
	mov	r14, rax
	test	rax, rax
	je	.L60
	movdqa	xmm0, oword [rel LC2]
	mov	dword [rsp+112], 0
	xor	ebp, ebp
	lea	r12, [rsp+48]
	mov	qword [rsp+120], 0
	lea	r13, [rsp+160]
	movaps	oword [rsp+128], xmm0
	movdqa	xmm0, oword [rel LC3]
	movaps	oword [rsp+144], xmm0
.L62:
	mov	rcx, r14
	mov	edx, 8192
	mov	esi, 1
	mov	rdi, r13
	call	fread
	test	rax, rax
	je	.L78
	mov	rbx, r13
	lea	r15, [r13+0+rax]
	jmp	.L65
.L63:
	add	rbx, 1
	cmp	rbx, r15
	je	.L62
.L65:
	movzx	ecx, byte [rbx]
	mov	edx, ebp
	add	ebp, 1
	mov	dword [rsp+112], ebp
	mov	byte [rsp+48+rdx], cl
	cmp	ebp, 64
	jne	.L63
	mov	rsi, r12
	mov	rdi, r12
	call	sha256_transform
	lea	rdx, [rbx+1]
	add	qword [rsp+120], 512
	mov	dword [rsp+112], 0
	cmp	r15, rdx
	je	.L70
	movzx	edx, byte [rbx+1]
	add	rbx, 2
	mov	dword [rsp+112], 1
	mov	byte [rsp+48], dl
	cmp	r15, rbx
	je	.L71
	movzx	edx, byte [rbx]
	mov	dword [rsp+112], 2
	mov	ebp, 2
	mov	byte [rsp+49], dl
	jmp	.L63
.L79:
	call	fclose
.L60:
	xor	eax, eax
.L57:
	add	rsp, 8360
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L70:
	xor	ebp, ebp
	jmp	.L62
.L71:
	mov	ebp, 1
	jmp	.L62
.L78:
	mov	rdi, r14
	call	ferror
	mov	rdi, r14
	test	eax, eax
	jne	.L79
	call	fclose
	lea	rbx, [rsp+16]
	lea	r12, [rsp+48]
	mov	rsi, rbx
	mov	rdi, r12
	call	sha256_final
	mov	rbp, qword [rsp+8]
.L69:
	movzx	edx, byte [rbx]
	mov	rdi, rbp
	mov	esi, LC5
	xor	eax, eax
	add	rbx, 1
	add	rbp, 2
	call	sprintf
	cmp	rbx, r12
	jne	.L69
	mov	rax, qword [rsp+8]
	mov	byte [rax+64], 0
	mov	eax, 1
	jmp	.L57
global sha256_verify_file
sha256_verify_file:
	push	rbp
	push	rbx
	mov	rbx, rsi
	sub	rsp, 88
	mov	rsi, rsp
	call	sha256_file
	test	rbx, rbx
	je	.L86
	test	al, 1
	je	.L86
	mov	rbp, rsp
	xor	ecx, ecx
	jmp	.L84
.L90:
	add	rcx, 1
	cmp	rcx, 64
	je	.L89
.L84:
	movzx	edx, byte [rbp+0+rcx]
	movzx	eax, byte [rbx+rcx]
	lea	edi, [rdx-65]
	lea	esi, [rdx+32]
	cmp	dil, 6
	lea	edi, [rax-65]
	cmovb	edx, esi
	lea	esi, [rax+32]
	cmp	dil, 6
	cmovb	eax, esi
	cmp	dl, al
	je	.L90
.L86:
	add	rsp, 88
	xor	eax, eax
	pop	rbx
	pop	rbp
	ret
.L89:
	add	rsp, 88
	mov	eax, 1
	pop	rbx
	pop	rbp
	ret
section .rodata
k:
	dd 1116352408
	dd 1899447441
	dd -1245643825
	dd -373957723
	dd 961987163
	dd 1508970993
	dd -1841331548
	dd -1424204075
	dd -670586216
	dd 310598401
	dd 607225278
	dd 1426881987
	dd 1925078388
	dd -2132889090
	dd -1680079193
	dd -1046744716
	dd -459576895
	dd -272742522
	dd 264347078
	dd 604807628
	dd 770255983
	dd 1249150122
	dd 1555081692
	dd 1996064986
	dd -1740746414
	dd -1473132947
	dd -1341970488
	dd -1084653625
	dd -958395405
	dd -710438585
	dd 113926993
	dd 338241895
	dd 666307205
	dd 773529912
	dd 1294757372
	dd 1396182291
	dd 1695183700
	dd 1986661051
	dd -2117940946
	dd -1838011259
	dd -1564481375
	dd -1474664885
	dd -1035236496
	dd -949202525
	dd -778901479
	dd -694614492
	dd -200395387
	dd 275423344
	dd 430227734
	dd 506948616
	dd 659060556
	dd 883997877
	dd 958139571
	dd 1322822218
	dd 1537002063
	dd 1747873779
	dd 1955562222
	dd 2024104815
	dd -2067236844
	dd -1933114872
	dd -1866530822
	dd -1538233109
	dd -1090935817
	dd -965641998
section .rodata
LC2:
	dd 1779033703
	dd -1150833019
	dd 1013904242
	dd -1521486534
LC3:
	dd 1359893119
	dd -1694144372
	dd 528734635
	dd 1541459225
