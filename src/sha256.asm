; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  sha256.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 sha256.asm -o sha256.o
; ---------------------------------------------------------

default rel

global sha256_init: function
global sha256_update: function
global sha256_final: function
global sha256_file: function
global sha256_verify_file: function

extern sprintf
extern ferror
extern fclose
extern fread
extern fopen

SECTION .text   align=64 exec

sha256_transform:
	push    r15
	mov     eax, 16711935
	push    r14
	movd    xmm0, eax
	push    r13
	pshufd  xmm0, xmm0, 0x00
	movdqa  xmm2, xmm0
	movdqa  xmm6, xmm0
	push    r12
	mov     r13, rdi
	push    rbp
	push    rbx
	sub     rsp, 144
	movdqu  xmm1, oword [rsi]
	movdqu  xmm5, oword [rsi+0x10]
	movdqu  xmm3, oword [rsi+0x20]
	movdqu  xmm4, oword [rsi+0x30]
	lea     rax, [rsp-0x38]
	lea     rdx, [rsp+0x88]
	pand    xmm6, xmm5
	psrlw   xmm5, 8
	pand    xmm2, xmm1
	psrlw   xmm1, 8
	packuswb xmm2, xmm6
	movdqa  xmm6, xmm0
	packuswb xmm1, xmm5
	movdqa  xmm5, xmm0
	pand    xmm6, xmm4
	pand    xmm5, xmm3
	psrlw   xmm4, 8
	psrlw   xmm3, 8
	packuswb xmm5, xmm6
	movdqa  xmm6, xmm0
	packuswb xmm3, xmm4
	movdqa  xmm4, xmm0
	pand    xmm6, xmm5
	pand    xmm4, xmm2
	psrlw   xmm5, 8
	packuswb xmm4, xmm6
	psrlw   xmm2, 8
	movdqa  xmm6, xmm0
	pand    xmm6, xmm1
	pand    xmm0, xmm3
	packuswb xmm2, xmm5
	psrlw   xmm3, 8
	psrlw   xmm1, 8
	packuswb xmm6, xmm0
	packuswb xmm1, xmm3
	pxor    xmm0, xmm0
	movdqa  xmm5, xmm4
	movdqa  xmm10, xmm6
	punpckhbw xmm4, xmm0
	punpckhbw xmm6, xmm0
	movdqa  xmm9, xmm2
	movdqa  xmm8, xmm1
	pxor    xmm3, xmm3
	punpcklbw xmm5, xmm0
	punpcklbw xmm10, xmm0
	punpcklbw xmm8, xmm0
	punpckhbw xmm1, xmm0
	punpcklbw xmm9, xmm0
	punpckhbw xmm2, xmm0
	movdqa  xmm7, xmm6
	movdqa  xmm0, xmm4
	punpcklwd xmm6, xmm3
	punpckhwd xmm0, xmm3
	punpckhwd xmm7, xmm3
	punpcklwd xmm4, xmm3
	psllw   xmm2, 8
	pslld   xmm7, 16
	pslld   xmm0, 24
	psllw   xmm9, 8
	movdqa  xmm11, xmm2
	por     xmm0, xmm7
	movdqa  xmm7, xmm1
	punpckhwd xmm11, xmm3
	punpckhwd xmm7, xmm3
	movdqa  xmm12, xmm9
	punpcklwd xmm2, xmm3
	por     xmm7, xmm11
	movdqa  xmm11, xmm10
	punpckhwd xmm10, xmm3
	por     xmm0, xmm7
	movdqa  xmm7, xmm5
	punpckhwd xmm5, xmm3
	punpcklwd xmm7, xmm3
	punpcklwd xmm11, xmm3
	punpcklwd xmm12, xmm3
	movaps  oword [rsp-0x48], xmm0
	pslld   xmm11, 16
	pslld   xmm7, 24
	punpckhwd xmm9, xmm3
	psrldq  xmm0, 8
	por     xmm7, xmm11
	movdqa  xmm11, xmm8
	punpcklwd xmm1, xmm3
	punpcklwd xmm11, xmm3
	pslld   xmm5, 24
	punpckhwd xmm8, xmm3
	pslld   xmm10, 16
	pslld   xmm4, 24
	por     xmm11, xmm12
	pslld   xmm6, 16
	por     xmm5, xmm10
	por     xmm8, xmm9
	por     xmm4, xmm6
	por     xmm1, xmm2
	por     xmm7, xmm11
	por     xmm5, xmm8
	por     xmm1, xmm4
	movaps  oword [rsp-0x78], xmm7
	movaps  oword [rsp-0x68], xmm5
	movaps  oword [rsp-0x58], xmm1
; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16
loc_001:  movq    xmm2, qword [rax-0x3C]
	add     rax, 8
	movdqa  xmm1, xmm2
	movdqa  xmm3, xmm2
	movdqa  xmm4, xmm2
	psrld   xmm3, 18
	pslld   xmm1, 14
	por     xmm1, xmm3
	psrld   xmm4, 7
	movdqa  xmm3, xmm2
	pslld   xmm3, 25
	psrld   xmm2, 3
	por     xmm3, xmm4
	movdqa  xmm4, xmm0
	pxor    xmm1, xmm3
	psrld   xmm4, 17
	movdqa  xmm3, xmm0
	pxor    xmm1, xmm2
	psrld   xmm3, 19
	movdqa  xmm2, xmm0
	pslld   xmm2, 13
	por     xmm2, xmm3
	movdqa  xmm3, xmm0
	pslld   xmm3, 15
	psrld   xmm0, 10
	por     xmm3, xmm4
	pxor    xmm2, xmm3
	pxor    xmm0, xmm2
	movq    xmm2, qword [rax-0x48]
	paddd   xmm1, xmm0
	movq    xmm0, qword [rax-0x24]
	paddd   xmm0, xmm2
	paddd   xmm0, xmm1
	movq    qword [rax-0x8], xmm0
	cmp     rax, rdx
	jne     loc_001
	mov     ebp, dword [r13+0x5C]
	mov     edi, dword [r13+0x6C]
	xor     r8d, r8d
	lea     r12, [rsp-0x78]
	mov     esi, dword [r13+0x50]
	mov     r9d, dword [r13+0x54]
	lea     r14, [rel k]
	movdqu  xmm2, oword [r13+0x50]
	movdqu  xmm1, oword [r13+0x60]
	mov     r10d, dword [r13+0x58]
	mov     ecx, dword [r13+0x60]
	mov     r11d, dword [r13+0x64]
	mov     ebx, dword [r13+0x68]
	jmp     loc_003

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_002:  mov     ebx, r11d
	mov     r10d, r9d
	mov     r11d, ecx
	mov     r9d, esi
	mov     ecx, r15d
	mov     esi, eax
loc_003:  mov     eax, ecx
	mov     edx, ecx
	mov     r15d, ecx
	ror     edx, 11
	ror     eax, 6
	and     r15d, r11d
	xor     eax, edx
	mov     edx, ecx
	rol     edx, 7
	xor     eax, edx
	mov     edx, dword [r12+r8]
	add     edx, dword [r14+r8]
	add     r8, 4
	add     eax, edx
	mov     edx, ecx
	not     edx
	and     edx, ebx
	xor     edx, r15d
	mov     r15d, r9d
	add     eax, edx
	mov     edx, esi
	and     r15d, r10d
	add     eax, edi
	mov     edi, esi
	ror     edx, 2
	ror     edi, 13
	xor     edx, edi
	mov     edi, esi
	rol     edi, 10
	xor     edx, edi
	mov     edi, r9d
	xor     edi, r10d
	and     edi, esi
	xor     edi, r15d
	lea     r15d, [rax+rbp]
	mov     ebp, r10d
	add     edx, edi
	mov     edi, ebx
	add     eax, edx
	cmp     r8, 256
	jnz     loc_002
	movd    xmm7, r10d
	movd    xmm3, r9d
	movd    xmm0, eax
	punpckldq xmm3, xmm7
	movd    xmm7, esi
	movd    xmm5, ebx
	punpckldq xmm0, xmm7
	movd    xmm7, ecx
	punpcklqdq xmm0, xmm3
	paddd   xmm0, xmm2
	movd    xmm2, r11d
	movups  oword [r13+0x50], xmm0
	movd    xmm0, r15d
	punpckldq xmm2, xmm5
	punpckldq xmm0, xmm7
	punpcklqdq xmm0, xmm2
	paddd   xmm0, xmm1
	movups  oword [r13+0x60], xmm0
	add     rsp, 144
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

	nop

ALIGN   16
sha256_init:; Function begin
	movdqa  xmm0, oword [rel str_LC2]
	mov     dword [rdi+0x40], 0
	mov     qword [rdi+0x48], 0
	movups  oword [rdi+0x50], xmm0
	movdqa  xmm0, oword [rel str_LC3]
	movups  oword [rdi+0x60], xmm0
	ret

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_update:; Function begin
	test    rdx, rdx
	je      loc_007
	push    r12
	lea     r12, [rsi+rdx]
	push    rbp
	mov     rbp, rdi
	push    rbx
	mov     rbx, rsi
	jmp     loc_005

; Filling space: 0x37
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66
;       db 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_004:  add     rbx, 1
	cmp     rbx, r12
	jz      loc_006
loc_005:  mov     ecx, dword [rbp+0x40]
	movzx   esi, byte [rbx]
	mov     rax, rcx
	mov     byte [rbp+rcx], sil
	add     eax, 1
	mov     dword [rbp+0x40], eax
	cmp     eax, 64
	jnz     loc_004
	mov     rsi, rbp
	mov     rdi, rbp
	add     rbx, 1
	call    sha256_transform
	add     qword [rbp+0x48], 512
	mov     dword [rbp+0x40], 0
	cmp     rbx, r12
	jnz     loc_005
loc_006:  pop     rbx
	pop     rbp
	pop     r12
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_007:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

sha256_final:; Function begin
	push    r12
	push    rbp
	mov     rbp, rsi
	push    rbx
	mov     r12d, dword [rdi+0x40]
	mov     rbx, rdi
	mov     edx, r12d
	lea     eax, [r12+0x1]
	mov     byte [rdi+rdx], 128
	cmp     r12d, 55
	ja      loc_010
	cmp     eax, 56
	jz      loc_008
	mov     edx, 55
	add     rax, rdi
	xor     esi, esi
	sub     edx, r12d
	cmp     edx, 8
	jnc     loc_014
	test    dl, 0x04
	jne     loc_019
	test    edx, edx
	jne     loc_016
loc_008:  lea     eax, [r12*8]
	add     rax, qword [rbx+0x48]
	mov     rsi, rbx
	mov     rdi, rbx
	mov     qword [rbx+0x48], rax
	bswap   rax
	mov     qword [rbx+0x38], rax
	call    sha256_transform
	mov     rax, rbp
	mov     ecx, 24
loc_009:  mov     edx, dword [rbx+0x50]
	add     rax, 1
	shr     edx, cl
	mov     byte [rax-0x1], dl
	mov     edx, dword [rbx+0x54]
	shr     edx, cl
	mov     byte [rax+0x3], dl
	mov     edx, dword [rbx+0x58]
	shr     edx, cl
	mov     byte [rax+0x7], dl
	mov     edx, dword [rbx+0x5C]
	shr     edx, cl
	mov     byte [rax+0x0B], dl
	mov     edx, dword [rbx+0x60]
	shr     edx, cl
	mov     byte [rax+0x0F], dl
	mov     edx, dword [rbx+0x64]
	shr     edx, cl
	mov     byte [rax+0x13], dl
	mov     edx, dword [rbx+0x68]
	shr     edx, cl
	mov     byte [rax+0x17], dl
	mov     edx, dword [rbx+0x6C]
	shr     edx, cl
	sub     ecx, 8
	mov     byte [rax+0x1B], dl
	cmp     ecx, -8
	jnz     loc_009
	pop     rbx
	pop     rbp
	pop     r12
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_010:  cmp     eax, 63
	ja      loc_011
	mov     edx, 63
	add     rax, rdi
	xor     esi, esi
	sub     edx, r12d
	cmp     edx, 8
	jnc     loc_012
	test    dl, 0x04
	jne     loc_018
	test    edx, edx
	jne     loc_017
loc_011:  mov     rsi, rbx
	mov     rdi, rbx
	call    sha256_transform
	pxor    xmm0, xmm0
	mov     qword [rbx+0x30], 0
	movups  oword [rbx], xmm0
	movups  oword [rbx+0x10], xmm0
	movups  oword [rbx+0x20], xmm0
	jmp     loc_008

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_012:  mov     ecx, edx
	mov     qword [rax], 0
	mov     qword [rax+rcx-0x8], 0
	lea     rcx, [rax+0x8]
	and     rcx, 0x0FFFFFFFFFFFFFFF8
	sub     rax, rcx
	add     edx, eax
	and     edx, 0x0FFFFFFF8
	cmp     edx, 8
	jc      loc_011
	and     edx, 0x0FFFFFFF8
	xor     eax, eax
loc_013:  mov     edi, eax
	add     eax, 8
	mov     qword [rcx+rdi], rsi
	cmp     eax, edx
	jc      loc_013
	jmp     loc_011

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_014:  mov     ecx, edx
	mov     qword [rax], 0
	mov     qword [rax+rcx-0x8], 0
	lea     rcx, [rax+0x8]
	and     rcx, 0x0FFFFFFFFFFFFFFF8
	sub     rax, rcx
	add     edx, eax
	and     edx, 0x0FFFFFFF8
	cmp     edx, 8
	jc      loc_008
	and     edx, 0x0FFFFFFF8
	xor     eax, eax
loc_015:  mov     edi, eax
	add     eax, 8
	mov     qword [rcx+rdi], rsi
	cmp     eax, edx
	jc      loc_015
	jmp     loc_008

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_016:  mov     byte [rax], 0
	test    dl, 0x02
	je      loc_008
	xor     esi, esi
	mov     word [rax+rdx-0x2], si
	jmp     loc_008

loc_017:  mov     byte [rax], 0
	test    dl, 0x02
	je      loc_011
	xor     ecx, ecx
	mov     word [rax+rdx-0x2], cx
	jmp     loc_011

loc_018:  mov     dword [rax], 0
	mov     dword [rax+rdx-0x4], 0
	jmp     loc_011

loc_019:
	mov     dword [rax], 0
	mov     dword [rax+rdx-0x4], 0
	jmp     loc_008

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

sha256_file:; Function begin
	test    rdi, rdi
	je      loc_028
	push    r15
	push    r14
	push    r13
	mov     r13, rsi
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 8344
	test    rsi, rsi
	je      loc_024
	lea     rsi, [rel str_LC4]
	call    fopen
	mov     r12, rax
	test    rax, rax
	je      loc_024
	movdqa  xmm0, oword [rel str_LC2]
	mov     dword [rsp+0x60], 0
	lea     rbp, [rsp+0x90]
	lea     rbx, [rsp+0x20]
	mov     qword [rsp+0x68], 0
	movaps  oword [rsp+0x70], xmm0
	movdqa  xmm0, oword [rel str_LC3]
	movaps  oword [rsp+0x80], xmm0
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_020:  mov     rcx, r12
	mov     edx, 8192
	mov     esi, 1
	mov     rdi, rbp
	call    fread
	test    rax, rax
	je      loc_026
	mov     r14, rbp
	lea     r15, [rbp+rax]
	jmp     loc_022

; Filling space: 0x38
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66
;       db 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90

ALIGN   16
loc_021:  add     r14, 1
	cmp     r14, r15
	jz      loc_020
loc_022:  mov     ecx, dword [rsp+0x60]
	movzx   esi, byte [r14]
	mov     rdx, rcx
	mov     byte [rsp+rcx+0x20], sil
	add     edx, 1
	mov     dword [rsp+0x60], edx
	cmp     edx, 64
	jnz     loc_021
	mov     rsi, rbx
	mov     rdi, rbx
	call    sha256_transform
	mov     dword [rsp+0x60], 0
	add     qword [rsp+0x68], 512
	jmp     loc_021

loc_023:  call    fclose
loc_024:  xor     eax, eax
loc_025:  add     rsp, 8344
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_026:  mov     rdi, r12
	call    ferror
	mov     rdi, r12
	test    eax, eax
	jnz     loc_023
	call    fclose
	lea     r12, [rsp+0x20]
	mov     rsi, rsp
	mov     rbx, rsp
	mov     rdi, r12
	mov     rbp, r13
	lea     r14, [rel str_LC5]
	call    sha256_final
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16
loc_027:  movzx   edx, byte [rbx]
	mov     rdi, rbp
	mov     rsi, r14
	xor     eax, eax
	add     rbx, 1
	add     rbp, 2
	call    sprintf
	cmp     r12, rbx
	jnz     loc_027
	mov     byte [r13+0x40], 0
	mov     eax, 1
	jmp     loc_025

loc_028:
	xor     eax, eax
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8

sha256_verify_file:; Function begin
	push    rbp
	push    rbx
	mov     rbx, rsi
	sub     rsp, 88
	mov     rsi, rsp
	call    sha256_file
	test    rbx, rbx
	jz      loc_031
	test    al, 0x01
	jz      loc_031
	mov     rbp, rsp
	xor     ecx, ecx
	jmp     loc_030

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16
loc_029:  add     rcx, 1
	cmp     rcx, 64
	jz      loc_032
loc_030:  movzx   edx, byte [rbp+rcx]
	movzx   eax, byte [rbx+rcx]
	lea     edi, [rdx-0x41]
	lea     esi, [rdx+0x20]
	cmp     dil, 6
	lea     edi, [rax-0x41]
	cmovc   edx, esi
	lea     esi, [rax+0x20]
	cmp     dil, 6
	cmovc   eax, esi
	cmp     dl, al
	jz      loc_029
loc_031:  add     rsp, 88
	xor     eax, eax
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_032:  add     rsp, 88
	mov     eax, 1
	pop     rbx
	pop     rbp
	ret

SECTION .rodata.str1.1 align=1 noexec

str_LC4:
	db 0x72, 0x62, 0x00

str_LC5:
	db 0x25, 0x30, 0x32, 0x78, 0x00

SECTION .rodata align=32 noexec

k:
	db 0x98, 0x2F, 0x8A, 0x42, 0x91, 0x44, 0x37, 0x71
	db 0x0CF, 0x0FB, 0x0C0, 0x0B5, 0x0A5, 0x0DB, 0x0B5, 0x0E9; 0008 _ ........
	db 0x5B, 0x0C2, 0x56, 0x39, 0x0F1, 0x11, 0x0F1, 0x59
	db 0x0A4, 0x82, 0x3F, 0x92, 0x0D5, 0x5E, 0x1C, 0x0AB
	db 0x98, 0x0AA, 0x07, 0x0D8, 0x01, 0x5B, 0x83, 0x12
	db 0x0BE, 0x85, 0x31, 0x24, 0x0C3, 0x7D, 0x0C, 0x55
	db 0x74, 0x5D, 0x0BE, 0x72, 0x0FE, 0x0B1, 0x0DE, 0x80
	db 0x0A7, 0x06, 0x0DC, 0x9B, 0x74, 0x0F1, 0x9B, 0x0C1
	db 0x0C1, 0x69, 0x9B, 0x0E4, 0x86, 0x47, 0x0BE, 0x0EF
	db 0x0C6, 0x9D, 0x0C1, 0x0F, 0x0CC, 0x0A1, 0x0C, 0x24
	db 0x6F, 0x2C, 0x0E9, 0x2D, 0x0AA, 0x84, 0x74, 0x4A
	db 0x0DC, 0x0A9, 0x0B0, 0x5C, 0x0DA, 0x88, 0x0F9, 0x76
	db 0x52, 0x51, 0x3E, 0x98, 0x6D, 0x0C6, 0x31, 0x0A8
	db 0x0C8, 0x27, 0x03, 0x0B0, 0x0C7, 0x7F, 0x59, 0x0BF
	db 0x0F3, 0x0B, 0x0E0, 0x0C6, 0x47, 0x91, 0x0A7, 0x0D5
	db 0x51, 0x63, 0x0CA, 0x06, 0x67, 0x29, 0x29, 0x14
	db 0x85, 0x0A, 0x0B7, 0x27, 0x38, 0x21, 0x1B, 0x2E
	db 0x0FC, 0x6D, 0x2C, 0x4D, 0x13, 0x0D, 0x38, 0x53
	db 0x54, 0x73, 0x0A, 0x65, 0x0BB, 0x0A, 0x6A, 0x76
	db 0x2E, 0x0C9, 0x0C2, 0x81, 0x85, 0x2C, 0x72, 0x92
	db 0x0A1, 0x0E8, 0x0BF, 0x0A2, 0x4B, 0x66, 0x1A, 0x0A8
	db 0x70, 0x8B, 0x4B, 0x0C2, 0x0A3, 0x51, 0x6C, 0x0C7
	db 0x19, 0x0E8, 0x92, 0x0D1, 0x24, 0x06, 0x99, 0x0D6
	db 0x85, 0x35, 0x0E, 0x0F4, 0x70, 0x0A0, 0x6A, 0x10
	db 0x16, 0x0C1, 0x0A4, 0x19, 0x08, 0x6C, 0x37, 0x1E
	db 0x4C, 0x77, 0x48, 0x27, 0x0B5, 0x0BC, 0x0B0, 0x34
	db 0x0B3, 0x0C, 0x1C, 0x39, 0x4A, 0x0AA, 0x0D8, 0x4E
	db 0x4F, 0x0CA, 0x9C, 0x5B, 0x0F3, 0x6F, 0x2E, 0x68
	db 0x0EE, 0x82, 0x8F, 0x74, 0x6F, 0x63, 0x0A5, 0x78
	db 0x14, 0x78, 0x0C8, 0x84, 0x08, 0x02, 0x0C7, 0x8C
	db 0x0FA, 0x0FF, 0x0BE, 0x90, 0x0EB, 0x6C, 0x50, 0x0A4
	db 0x0F7, 0x0A3, 0x0F9, 0x0BE, 0x0F2, 0x78, 0x71, 0x0C6

SECTION .rodata.cst16 align=16 noexec

ALIGN   16
str_LC2:
	dq 0x0BB67AE856A09E667
	dq 0x0A54FF53A3C6EF372

str_LC3:
	dq 0x9B05688C510E527F
	dq 0x5BE0CD191F83D9AB

