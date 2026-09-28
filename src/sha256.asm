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
extern fclose
extern ferror
extern fread
extern fopen
extern __stack_chk_fail

SECTION .text   align=64 exec

sha256_transform:
	push    r15
	pxor    xmm3, xmm3
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 312
	movdqu  xmm2, oword [rsi]
	movdqu  xmm9, oword [rsi+0x10]
	movdqu  xmm8, oword [rsi+0x20]
	movdqu  xmm6, oword [rsi+0x30]
	lea     r11, [rsp+0x20]
	lea     rax, [rsp+0x60]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r12, qword [fs:abs 0x28]
	mov     qword [rsp+0x128], r12
	mov     r12, rdi
	movdqa  xmm1, xmm2
	movdqa  xmm0, xmm9
	lea     rdx, [rsp+0x120]
	psrlw   xmm0, 8
	psrlw   xmm1, 8
	movdqa  xmm4, xmm8
	packuswb xmm1, xmm0
	psrlw   xmm4, 8
	movdqa  xmm0, xmm6
	psrlw   xmm0, 8
	movdqa  xmm5, xmm1
	packuswb xmm4, xmm0
	psrlw   xmm5, 8
	movdqa  xmm0, xmm4
	psrlw   xmm0, 8
	packuswb xmm5, xmm0
	pcmpeqd xmm0, xmm0
	psrlw   xmm0, 8
	movdqa  xmm7, xmm5
	punpckhbw xmm5, xmm3
	pand    xmm9, xmm0
	pand    xmm6, xmm0
	pand    xmm2, xmm0
	pand    xmm8, xmm0
	packuswb xmm2, xmm9
	pand    xmm4, xmm0
	packuswb xmm8, xmm6
	movdqa  xmm6, xmm0
	pand    xmm1, xmm0
	pand    xmm6, xmm2
	pand    xmm0, xmm8
	packuswb xmm1, xmm4
	packuswb xmm6, xmm0
	movdqa  xmm4, xmm1
	punpckhbw xmm1, xmm3
	movdqa  xmm9, xmm6
	psrlw   xmm8, 8
	punpckhbw xmm6, xmm3
	psrlw   xmm2, 8
	movdqa  xmm0, xmm1
	movdqa  xmm10, xmm6
	packuswb xmm2, xmm8
	punpckhwd xmm0, xmm3
	punpckhwd xmm10, xmm3
	movdqa  xmm8, xmm2
	punpckhbw xmm2, xmm3
	punpcklbw xmm4, xmm3
	psllw   xmm2, 8
	pslld   xmm10, 24
	punpcklbw xmm9, xmm3
	pslld   xmm0, 16
	movdqa  xmm11, xmm2
	punpcklbw xmm8, xmm3
	por     xmm0, xmm10
	movdqa  xmm10, xmm5
	punpcklbw xmm7, xmm3
	punpckhwd xmm11, xmm3
	punpckhwd xmm10, xmm3
	punpcklwd xmm1, xmm3
	por     xmm10, xmm11
	movdqa  xmm11, xmm9
	punpcklwd xmm6, xmm3
	por     xmm0, xmm10
	movdqa  xmm10, xmm4
	punpcklwd xmm11, xmm3
	punpcklwd xmm10, xmm3
	psllw   xmm8, 8
	punpckhwd xmm4, xmm3
	movaps  oword [rsp+0x50], xmm0
	pslld   xmm11, 24
	pslld   xmm10, 16
	movdqa  xmm12, xmm8
	psrldq  xmm0, 8
	por     xmm10, xmm11
	punpckhwd xmm9, xmm3
	movdqa  xmm11, xmm7
	punpcklwd xmm12, xmm3
	punpcklwd xmm11, xmm3
	punpckhwd xmm8, xmm3
	pslld   xmm4, 16
	pslld   xmm9, 24
	punpckhwd xmm7, xmm3
	pslld   xmm1, 16
	pslld   xmm6, 24
	punpcklwd xmm2, xmm3
	punpcklwd xmm5, xmm3
	por     xmm11, xmm12
	por     xmm4, xmm9
	por     xmm7, xmm8
	por     xmm1, xmm6
	por     xmm5, xmm2
	por     xmm10, xmm11
	por     xmm4, xmm7
	por     xmm1, xmm5
	movaps  oword [rsp+0x20], xmm10
	movaps  oword [rsp+0x30], xmm4
	movaps  oword [rsp+0x40], xmm1
; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_001:  movdqa  xmm1, xmm0
	movdqa  xmm3, xmm0
	movdqa  xmm4, xmm0
	add     rax, 8
	psrld   xmm3, 19
	pslld   xmm1, 13
	movq    xmm2, qword [rax-0x44]
	por     xmm1, xmm3
	psrld   xmm4, 17
	movdqa  xmm3, xmm0
	pslld   xmm3, 15
	psrld   xmm0, 10
	por     xmm3, xmm4
	movdqa  xmm4, xmm2
	pxor    xmm1, xmm3
	psrld   xmm4, 7
	movdqa  xmm3, xmm2
	pxor    xmm1, xmm0
	psrld   xmm3, 18
	movdqa  xmm0, xmm2
	pslld   xmm0, 14
	por     xmm0, xmm3
	movdqa  xmm3, xmm2
	pslld   xmm3, 25
	psrld   xmm2, 3
	por     xmm3, xmm4
	pxor    xmm0, xmm3
	pxor    xmm0, xmm2
	movq    xmm2, qword [rax-0x48]
	paddd   xmm1, xmm0
	movq    xmm0, qword [rax-0x24]
	paddd   xmm0, xmm2
	paddd   xmm0, xmm1
	movq    qword [rax-0x8], xmm0
	cmp     rdx, rax
	jne     loc_001
	mov     r15d, dword [r12+0x50]
	mov     eax, dword [r12+0x6C]
	lea     rdi, [rel k]
	mov     r9d, dword [r12+0x54]
	mov     r8d, dword [r12+0x58]
	lea     r13, [rdi+0x100]
	mov     ebp, dword [r12+0x5C]
	mov     ecx, dword [r12+0x60]
	mov     dword [rsp+0x18], eax
	mov     edx, eax
	mov     ebx, dword [r12+0x64]
	mov     r10d, dword [r12+0x68]
	mov     dword [rsp], r9d
	mov     esi, r15d
	mov     dword [rsp+0x4], r8d
	mov     dword [rsp+0x8], ebp
	mov     dword [rsp+0x0C], ecx
	mov     dword [rsp+0x10], ebx
	mov     dword [rsp+0x14], r10d
	mov     dword [rsp+0x1C], r15d
	jmp     loc_003

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_002:  mov     r10d, ebx
	mov     r8d, r9d
	mov     ebx, ecx
	mov     r9d, esi
	mov     ecx, r14d
	mov     esi, eax
loc_003:  mov     eax, ecx
	mov     r14d, ecx
	mov     r15d, ecx
	add     rdi, 4
	ror     r14d, 11
	ror     eax, 6
	and     r15d, ebx
	add     r11, 4
	xor     eax, r14d
	mov     r14d, ecx
	rol     r14d, 7
	xor     eax, r14d
	mov     r14d, dword [r11-0x4]
	add     r14d, dword [rdi-0x4]
	add     eax, r14d
	mov     r14d, ecx
	not     r14d
	and     r14d, r10d
	xor     r14d, r15d
	mov     r15d, r9d
	add     eax, r14d
	mov     r14d, esi
	and     r15d, r8d
	add     eax, edx
	mov     edx, esi
	ror     r14d, 13
	ror     edx, 2
	xor     edx, r14d
	mov     r14d, esi
	rol     r14d, 10
	xor     edx, r14d
	mov     r14d, r9d
	xor     r14d, r8d
	and     r14d, esi
	xor     r14d, r15d
	add     edx, r14d
	lea     r14d, [rax+rbp]
	mov     ebp, r8d
	add     eax, edx
	mov     edx, r10d
	cmp     r13, rdi
	jne     loc_002
	mov     r15d, dword [rsp+0x1C]
	add     r15d, eax
	mov     eax, dword [rsp]
	mov     dword [r12+0x50], r15d
	add     eax, esi
	mov     dword [r12+0x54], eax
	mov     eax, dword [rsp+0x4]
	add     eax, r9d
	mov     dword [r12+0x58], eax
	mov     eax, dword [rsp+0x8]
	add     eax, r8d
	mov     dword [r12+0x5C], eax
	mov     eax, dword [rsp+0x0C]
	add     eax, r14d
	mov     dword [r12+0x60], eax
	mov     eax, dword [rsp+0x10]
	add     eax, ecx
	mov     dword [r12+0x64], eax
	mov     eax, dword [rsp+0x14]
	add     eax, ebx
	mov     dword [r12+0x68], eax
	mov     eax, dword [rsp+0x18]
	add     eax, r10d
	mov     dword [r12+0x6C], eax
	mov     rax, qword [rsp+0x128]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_004
	add     rsp, 312
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_004:
	call    __stack_chk_fail
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8

sha256_init:
	movdqa  xmm0, oword [rel str_LC1]
	mov     dword [rdi+0x40], 0
	mov     qword [rdi+0x48], 0
	movups  oword [rdi+0x50], xmm0
	movdqa  xmm0, oword [rel str_LC2]
	movups  oword [rdi+0x60], xmm0
	ret

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_update:; Function begin
	test    rdx, rdx
	je      loc_008
	push    r12
	lea     r12, [rsi+rdx]
	push    rbp
	mov     rbp, rdi
	push    rbx
	mov     rbx, rsi
	jmp     loc_006

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
loc_005:  add     rbx, 1
	cmp     rbx, r12
	jz      loc_007
loc_006:  mov     ecx, dword [rbp+0x40]
	movzx   esi, byte [rbx]
	mov     rax, rcx
	mov     byte [rbp+rcx], sil
	add     eax, 1
	mov     dword [rbp+0x40], eax
	cmp     eax, 64
	jnz     loc_005
	mov     rsi, rbp
	mov     rdi, rbp
	add     rbx, 1
	call    sha256_transform
	add     qword [rbp+0x48], 512
	mov     dword [rbp+0x40], 0
	cmp     rbx, r12
	jnz     loc_006
loc_007:  pop     rbx
	pop     rbp
	pop     r12
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_008:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_final:; Function begin
	push    rbp
	pxor    xmm0, xmm0
	mov     rbp, rsi
	push    rbx
	mov     rbx, rdi
	sub     rsp, 24
	mov     edx, dword [rdi+0x40]
	mov     ecx, edx
	lea     eax, [rdx+0x1]
	mov     byte [rdi+rcx], 128
	cmp     edx, 55
	ja      loc_011
	cmp     eax, 56
	jz      loc_009
	mov     ecx, 55
	add     rax, rdi
	sub     ecx, edx
	cmp     ecx, 64
	jnc     loc_015
	test    cl, 0x20
	jne     loc_021
	test    cl, 0x10
	jne     loc_017
	test    cl, 0x08
	jne     loc_023
	test    cl, 0x04
	jne     loc_025
	test    ecx, ecx
	jz      loc_009
	mov     byte [rax], 0
	test    cl, 0x02
	jne     loc_020
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_009:  lea     eax, [rdx*8]
	add     rax, qword [rbx+0x48]
	mov     rsi, rbx
	mov     rdi, rbx
	mov     qword [rbx+0x48], rax
	bswap   rax
	mov     qword [rbx+0x38], rax
	call    sha256_transform
	mov     rax, rbp
	mov     ecx, 24
loc_010:  mov     edx, dword [rbx+0x50]
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
	jnz     loc_010
	add     rsp, 24
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_011:  cmp     eax, 63
	ja      loc_012
	mov     ecx, 63
	add     rax, rdi
	movdqa  xmm1, xmm0
	sub     ecx, edx
	cmp     ecx, 64
	jnc     loc_013
	test    cl, 0x20
	jne     loc_022
	test    cl, 0x10
	jne     loc_018
	test    cl, 0x08
	jne     loc_024
	test    cl, 0x04
	jne     loc_026
	test    ecx, ecx
	jz      loc_012
	mov     byte [rax], 0
	test    cl, 0x02
	jne     loc_019
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_012:  mov     rsi, rbx
	mov     rdi, rbx
	mov     dword [rsp+0x0C], edx
	call    sha256_transform
	pxor    xmm0, xmm0
	mov     edx, dword [rsp+0x0C]
	mov     qword [rbx+0x30], 0
	movups  oword [rbx], xmm0
	movups  oword [rbx+0x10], xmm0
	movups  oword [rbx+0x20], xmm0
	jmp     loc_009

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_013:  mov     esi, ecx
	sub     ecx, 1
	movups  oword [rax+rsi-0x40], xmm0
	movups  oword [rax+rsi-0x30], xmm0
	movups  oword [rax+rsi-0x20], xmm0
	movups  oword [rax+rsi-0x10], xmm0
	cmp     ecx, 64
	jc      loc_012
	and     ecx, 0x0FFFFFFC0
	xor     esi, esi
loc_014:  mov     edi, esi
	add     esi, 64
	movups  oword [rax+rdi], xmm1
	movups  oword [rax+rdi+0x10], xmm1
	movups  oword [rax+rdi+0x20], xmm1
	movups  oword [rax+rdi+0x30], xmm1
	cmp     esi, ecx
	jc      loc_014
	jmp     loc_012

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_015:  mov     esi, ecx
	sub     ecx, 1
	movups  oword [rax+rsi-0x40], xmm0
	movups  oword [rax+rsi-0x30], xmm0
	movups  oword [rax+rsi-0x20], xmm0
	movups  oword [rax+rsi-0x10], xmm0
	cmp     ecx, 64
	jc      loc_009
	and     ecx, 0x0FFFFFFC0
	xor     esi, esi
loc_016:  mov     edi, esi
	add     esi, 64
	movups  oword [rax+rdi], xmm0
	movups  oword [rax+rdi+0x10], xmm0
	movups  oword [rax+rdi+0x20], xmm0
	movups  oword [rax+rdi+0x30], xmm0
	cmp     esi, ecx
	jc      loc_016
	jmp     loc_009

loc_017:  movups  oword [rax], xmm0
	movups  oword [rax+rcx-0x10], xmm0
	jmp     loc_009

loc_018:  movups  oword [rax], xmm0
	movups  oword [rax+rcx-0x10], xmm0
	jmp     loc_012

loc_019:  xor     esi, esi
	mov     word [rax+rcx-0x2], si
	jmp     loc_012

loc_020:  xor     edi, edi
	mov     word [rax+rcx-0x2], di
	jmp     loc_009

loc_021:  movups  oword [rax], xmm0
	movups  oword [rax+0x10], xmm0
	movups  oword [rax+rcx-0x20], xmm0
	movups  oword [rax+rcx-0x10], xmm0
	jmp     loc_009

loc_022:  movups  oword [rax], xmm0
	movups  oword [rax+0x10], xmm0
	movups  oword [rax+rcx-0x20], xmm0
	movups  oword [rax+rcx-0x10], xmm0
	jmp     loc_012

loc_023:  mov     qword [rax], 0
	mov     qword [rax+rcx-0x8], 0
	jmp     loc_009

loc_024:  mov     qword [rax], 0
	mov     qword [rax+rcx-0x8], 0
	jmp     loc_012

loc_025:  mov     dword [rax], 0
	mov     dword [rax+rcx-0x4], 0
	jmp     loc_009

loc_026:
	mov     dword [rax], 0
	mov     dword [rax+rcx-0x4], 0
	jmp     loc_012

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

sha256_file.part.0:
	sub     rsp, 8392
	mov     qword [rsp+0x20B8], r13
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r13, qword [fs:abs 0x28]
	mov     qword [rsp+0x2098], r13
	mov     r13, rsi
	lea     rsi, [rel str_LC3]
	call    fopen
	test    rax, rax
	je      loc_034
	movdqa  xmm0, oword [rel str_LC1]
	mov     qword [rsp+0x20A0], rbx
	mov     qword [rsp+0x20C0], r14
	movaps  oword [rsp+0x50], xmm0
	movdqa  xmm0, oword [rel str_LC2]
	mov     dword [rsp+0x40], 0
	mov     qword [rsp+0x48], 0
	mov     qword [rsp+0x20A8], rbp
	lea     rbp, [rsp+0x90]
	mov     qword [rsp+0x20B0], r12
	mov     r12, rax
	movaps  oword [rsp+0x60], xmm0
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_027:  mov     rcx, r12
	mov     edx, 8192
	mov     esi, 1
	mov     rdi, rbp
	call    fread
	test    rax, rax
	jz      loc_030
	mov     rbx, rbp
	lea     r14, [rbp+rax]
	jmp     loc_029

; Filling space: 0x2C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66
;       db 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_028:  add     rbx, 1
	cmp     rbx, r14
	jz      loc_027
loc_029:  mov     ecx, dword [rsp+0x40]
	movzx   esi, byte [rbx]
	mov     rdx, rcx
	mov     byte [rsp+rcx], sil
	add     edx, 1
	mov     dword [rsp+0x40], edx
	cmp     edx, 64
	jnz     loc_028
	mov     rsi, rsp
	mov     rdi, rsp
	call    sha256_transform
	mov     dword [rsp+0x40], 0
	add     qword [rsp+0x48], 512
	jmp     loc_028

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_030:  mov     rdi, r12
	call    ferror
	mov     rdi, r12
	test    eax, eax
	jne     loc_033
	call    fclose
	mov     rdi, rsp
	lea     rsi, [rsp+0x70]
	mov     r12, r13
	call    sha256_final
	lea     rbx, [rsp+0x70]
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_031:  movzx   edx, byte [rbx]
	mov     rdi, r12
	lea     rsi, [rel str_LC4]
	xor     eax, eax
	add     rbx, 1
	add     r12, 2
	call    sprintf
	cmp     rbx, rbp
	jnz     loc_031
	mov     byte [r13+0x40], 0
	mov     rbx, qword [rsp+0x20A0]
	mov     eax, 1
	mov     rbp, qword [rsp+0x20A8]
	mov     r12, qword [rsp+0x20B0]
	mov     r14, qword [rsp+0x20C0]
loc_032:  mov     rdx, qword [rsp+0x2098]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jnz     loc_035
	mov     r13, qword [rsp+0x20B8]
	add     rsp, 8392
	ret

loc_033:  call    fclose
	mov     rbx, qword [rsp+0x20A0]
	mov     rbp, qword [rsp+0x20A8]
	mov     r12, qword [rsp+0x20B0]
	mov     r14, qword [rsp+0x20C0]
loc_034:  xor     eax, eax
	jmp     loc_032

loc_035:
	mov     qword [rsp+0x20A0], rbx
	mov     qword [rsp+0x20A8], rbp
	mov     qword [rsp+0x20B0], r12
	mov     qword [rsp+0x20C0], r14
	call    __stack_chk_fail
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8

sha256_file:
	test    rdi, rdi
	jz      loc_036
	test    rsi, rsi
	jz      loc_036
	jmp     sha256_file.part.0

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_036:  xor     eax, eax
	ret

; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_verify_file:; Function begin
	sub     rsp, 104
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x58], rax
	xor     eax, eax
	test    rdi, rdi
	jnz     loc_039
loc_037:  xor     eax, eax
loc_038:  mov     rdx, qword [rsp+0x58]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jnz     loc_043
	add     rsp, 104
	ret

loc_039:  mov     qword [rsp+0x8], rsi
	lea     rsi, [rsp+0x10]
	call    sha256_file.part.0
	mov     rdx, qword [rsp+0x8]
	test    rdx, rdx
	jz      loc_037
	test    al, 0x01
	jz      loc_037
	lea     rcx, [rsp+0x10]
	mov     rsi, rdx
	lea     r9, [rsp+0x50]
	jmp     loc_041

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_040:  add     rcx, 1
	add     rsi, 1
	cmp     rcx, r9
	jz      loc_042
loc_041:  movzx   edx, byte [rcx]
	movzx   eax, byte [rsi]
	lea     r8d, [rdx-0x41]
	lea     edi, [rdx+0x20]
	cmp     r8b, 6
	lea     r8d, [rax-0x41]
	cmovc   edx, edi
	lea     edi, [rax+0x20]
	cmp     r8b, 6
	cmovc   eax, edi
	cmp     dl, al
	jz      loc_040
	jmp     loc_037

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_042:  mov     eax, 1
	jmp     loc_038

loc_043:
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.1 align=1 noexec

str_LC3:
	db 0x72, 0x62, 0x00

str_LC4:
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
str_LC1:
	dq 0x0BB67AE856A09E667
	dq 0x0A54FF53A3C6EF372

str_LC2:
	dq 0x9B05688C510E527F
	dq 0x5BE0CD191F83D9AB

