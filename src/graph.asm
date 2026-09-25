; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  graph.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 graph.asm -o graph.o
; ---------------------------------------------------------

default rel

global graph_create: function
global graph_destroy: function
global graph_add_package: function
global graph_add_dependency: function
global graph_has_package: function
global graph_package_count: function
global graph_package_name: function
global graph_package_version: function
global graph_package_source: function
global graph_topological_order: function

extern realloc
extern memcpy
extern strcpy
extern malloc
extern strcmp
extern free
extern calloc
extern __stack_chk_fail
extern strlen
extern snprintf

SECTION .text   align=32 exec

visit:
	sub     rsp, 360
	mov     qword [rsp+0x140], rbp
	lea     rbp, [rsi+rsi*2]
	mov     qword [rsp+0x150], r13
	mov     r13, rdi
	shl     rbp, 4
	mov     rdi, rsi
	mov     qword [rsp+0x160], r15
	mov     r15, rcx
	mov     qword [rsp+0x158], r14
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r14, qword [fs:abs 0x28]
	mov     qword [rsp+0x128], r14
	mov     r14, r9
	lea     r9, [rdx+rsi]
	mov     byte [r9], 1
	mov     rcx, qword [r13]
	lea     rax, [rcx+rbp]
	cmp     qword [rax+0x20], 0
	je      loc_004
	mov     qword [rsp+0x138], rbx
	xor     ebx, ebx
	mov     qword [rsp+0x148], r12
	mov     r12, rdx
	mov     qword [rsp+0x8], r14
	mov     r14, r15
	mov     r15, r8
	mov     qword [rsp+0x10], r9
	mov     qword [rsp+0x18], rsi
	jmp     loc_002

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_001:  lea     rax, [rcx+rbp]
	add     rbx, 1
	cmp     rbx, qword [rax+0x20]
	jnc     loc_003
loc_002:  mov     rdx, qword [rax+0x18]
	mov     rsi, qword [rdx+rbx*8]
	movzx   edx, byte [r12+rsi]
	cmp     dl, 1
	je      loc_006
	test    dl, dl
	jnz     loc_001
	sub     rsp, 8
	mov     rcx, r14
	mov     rdx, r12
	mov     r8, r15
	push    qword [rsp+0x178]
	mov     r9, qword [rsp+0x18]
	mov     rdi, r13
	call    visit
	pop     rdx
	pop     rcx
	test    eax, eax
	je      loc_013
	mov     rcx, qword [r13]
	add     rbx, 1
	lea     rax, [rcx+rbp]
	cmp     rbx, qword [rax+0x20]
	jc      loc_002
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_003:  mov     r9, qword [rsp+0x10]
	mov     rdi, qword [rsp+0x18]
	mov     r8, r15
	mov     r15, r14
	mov     rbx, qword [rsp+0x138]
	mov     r12, qword [rsp+0x148]
loc_004:  mov     byte [r9], 2
	mov     rax, qword [r8]
	lea     rdx, [rax+0x1]
	mov     qword [r8], rdx
	mov     qword [r15+rax*8], rdi
	mov     eax, 1
loc_005:  mov     rdx, qword [rsp+0x128]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jne     loc_018
	mov     rbp, qword [rsp+0x140]
	mov     r13, qword [rsp+0x150]
	mov     r14, qword [rsp+0x158]
	mov     r15, qword [rsp+0x160]
	add     rsp, 360
	ret

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_006:  mov     r14, qword [rsp+0x8]
	test    r14, r14
	jz      loc_007
	cmp     qword [rsp+0x170], 0
	jnz     loc_008
loc_007:  mov     rbx, qword [rsp+0x138]
	mov     r12, qword [rsp+0x148]
	xor     eax, eax
	jmp     loc_005

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_008:  lea     rdx, [rsi+rsi*2]
	mov     rax, qword [rax]
	mov     esi, 256
	lea     rdi, [rsp+0x20]
	shl     rdx, 4
	mov     r8, qword [rcx+rdx]
	mov     rcx, rax
	lea     rdx, [rel str_LC0]
	xor     eax, eax
	call    snprintf
	test    eax, eax
	jns     loc_009
	mov     byte [rsp+0x20], 0
loc_009:  lea     rdi, [rsp+0x20]
	call    strlen
	mov     rdi, qword [rsp+0x170]
	lea     rdx, [rdi-0x1]
	cmp     rax, rdi
	cmovnc  rax, rdx
	mov     edx, eax
	cmp     eax, 64
	jnc     loc_011
	test    al, 0x20
	jne     loc_015
	test    al, 0x10
	jne     loc_016
	test    al, 0x08
	jne     loc_017
	test    al, 0x04
	jne     loc_014
	test    eax, eax
	jz      loc_010
	movzx   edx, byte [rsp+0x20]
	mov     byte [r14], dl
	test    al, 0x02
	jz      loc_010
	mov     edx, eax
	movzx   ecx, word [rsp+rdx+0x1E]
	mov     word [r14+rdx-0x2], cx
	nop
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_010:  mov     byte [r14+rax], 0
	jmp     loc_007

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_011:  mov     edx, eax
	lea     rcx, [r14+rdx]
	lea     rdx, [rsp+rdx+0x20]
	movdqu  xmm0, oword [rdx-0x40]
	movups  oword [rcx-0x40], xmm0
	movdqu  xmm0, oword [rdx-0x30]
	movups  oword [rcx-0x30], xmm0
	movdqu  xmm0, oword [rdx-0x20]
	movups  oword [rcx-0x20], xmm0
	movdqu  xmm0, oword [rdx-0x10]
	lea     edx, [rax-0x1]
	movups  oword [rcx-0x10], xmm0
	cmp     edx, 64
	jc      loc_010
	and     edx, 0x0FFFFFFC0
	xor     esi, esi
loc_012:  mov     ecx, esi
	add     esi, 64
	movdqu  xmm3, oword [rsp+rcx+0x20]
	movdqu  xmm2, oword [rsp+rcx+0x30]
	movdqu  xmm1, oword [rsp+rcx+0x40]
	movdqu  xmm0, oword [rsp+rcx+0x50]
	movups  oword [r14+rcx], xmm3
	movups  oword [r14+rcx+0x10], xmm2
	movups  oword [r14+rcx+0x20], xmm1
	movups  oword [r14+rcx+0x30], xmm0
	cmp     esi, edx
	jc      loc_012
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_013:  mov     rbx, qword [rsp+0x138]
	mov     r12, qword [rsp+0x148]
	jmp     loc_005

loc_014:  mov     ecx, dword [rsp+0x20]
	mov     dword [r14], ecx
	mov     ecx, dword [rsp+rdx+0x1C]
	mov     dword [r14+rdx-0x4], ecx
	jmp     loc_010

loc_015:  movdqu  xmm0, oword [rsp+0x20]
	lea     rcx, [r14+rdx+0x20]
	lea     rdx, [rsp+rdx+0x40]
	movups  oword [r14], xmm0
	movdqu  xmm0, oword [rsp+0x30]
	movups  oword [r14+0x10], xmm0
	movdqu  xmm0, oword [rdx-0x40]
	movups  oword [rcx-0x40], xmm0
	movdqu  xmm0, oword [rdx-0x30]
	movups  oword [rcx-0x30], xmm0
	jmp     loc_010

loc_016:  movdqu  xmm0, oword [rsp+0x20]
	movups  oword [r14], xmm0
	movdqu  xmm0, oword [rsp+rdx+0x10]
	movups  oword [r14+rdx-0x10], xmm0
	jmp     loc_010

loc_017:  mov     rcx, qword [rsp+0x20]
	mov     qword [r14], rcx
	mov     rcx, qword [rsp+rdx+0x18]
	mov     qword [r14+rdx-0x8], rcx
	jmp     loc_010

loc_018:
	mov     qword [rsp+0x138], rbx
	mov     qword [rsp+0x148], r12
	call    __stack_chk_fail
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16

graph_create:
	mov     esi, 24
	mov     edi, 1
	jmp     calloc

	nop

ALIGN   16
graph_destroy:; Function begin
	test    rdi, rdi
	je      loc_021
	sub     rsp, 24
	mov     qword [rsp+0x10], r12
	mov     r12, rdi
	cmp     qword [rdi+0x8], 0
	jz      loc_020
	mov     qword [rsp], rbx
	mov     qword [rsp+0x8], rbp
	xor     ebp, ebp
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_019:  mov     rax, qword [r12]
	lea     rbx, [rbp+rbp*2]
	add     rbp, 1
	shl     rbx, 4
	mov     rdi, qword [rax+rbx]
	call    free
	mov     rax, qword [r12]
	mov     rdi, qword [rax+rbx+0x8]
	call    free
	mov     rax, qword [r12]
	mov     rdi, qword [rax+rbx+0x18]
	call    free
	cmp     rbp, qword [r12+0x8]
	jc      loc_019
	mov     rbx, qword [rsp]
	mov     rbp, qword [rsp+0x8]
loc_020:  mov     rdi, qword [r12]
	call    free
	mov     rdi, r12
	mov     r12, qword [rsp+0x10]
	add     rsp, 24
	jmp     free

loc_021:
	ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_add_package:; Function begin
	test    rdi, rdi
	jz      loc_022
	test    rsi, rsi
	jz      loc_022
	cmp     byte [rsi], 0
	jnz     loc_023
loc_022:  xor     eax, eax
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_023:  push    r15
	push    r14
	push    r13
	push    r12
	mov     r12, rdi
	push    rbp
	mov     rbp, rdx
	push    rbx
	mov     rbx, rsi
	sub     rsp, 24
	mov     r15, qword [rdi]
	mov     r13, qword [rdi+0x8]
	mov     dword [rsp+0x8], ecx
	mov     qword [rsp], r15
	test    r13, r13
	je      loc_039
	xor     r14d, r14d
	jmp     loc_025

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_024:  add     r14, 1
	add     r15, 48
	cmp     r13, r14
	je      loc_029
loc_025:  mov     rdi, qword [r15]
	mov     rsi, rbx
	call    strcmp
	mov     edx, eax
	test    eax, eax
	jnz     loc_024
	test    rbp, rbp
	je      loc_034
	mov     rdi, rbp
	mov     dword [rsp+0x0C], edx
	call    strlen
	mov     edx, dword [rsp+0x0C]
	lea     rdi, [rax+0x1]
loc_026:  mov     dword [rsp+0x0C], edx
	call    malloc
	mov     edx, dword [rsp+0x0C]
	test    rax, rax
	mov     r13, rax
	jz      loc_028
	mov     rsi, rbp
	mov     rdi, rax
	lea     rbx, [r14+r14*2]
	call    strcpy
	mov     rax, qword [rsp]
	shl     rbx, 4
	mov     rdi, qword [rax+rbx+0x8]
	call    free
	mov     eax, dword [rsp+0x8]
	add     rbx, qword [r12]
	mov     qword [rbx+0x8], r13
	mov     dword [rbx+0x10], eax
loc_027:  mov     edx, 1
loc_028:  add     rsp, 24
	mov     eax, edx
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_029:  cmp     r13, qword [r12+0x10]
	je      loc_035
loc_030:  mov     rdi, rbx
	call    strlen
	lea     r14, [rax+0x1]
	mov     rdi, r14
	call    malloc
	mov     r13, rax
	test    rax, rax
	jz      loc_031
	mov     rdx, r14
	mov     rsi, rbx
	mov     rdi, rax
	call    memcpy
loc_031:  test    rbp, rbp
	jz      loc_033
	mov     rdi, rbp
	call    strlen
	lea     rdi, [rax+0x1]
loc_032:  call    malloc
	mov     rbx, rax
	test    rax, rax
	je      loc_037
	mov     rsi, rbp
	mov     rdi, rax
	call    strcpy
	test    r13, r13
	je      loc_037
	mov     rdx, qword [r12+0x8]
	mov     ecx, dword [rsp+0x8]
	pxor    xmm0, xmm0
	lea     rax, [rdx+rdx*2]
	add     rdx, 1
	shl     rax, 4
	add     rax, qword [r12]
	movups  oword [rax+0x10], xmm0
	mov     qword [rax], r13
	mov     qword [rax+0x8], rbx
	mov     dword [rax+0x10], ecx
	movups  oword [rax+0x20], xmm0
	mov     qword [r12+0x8], rdx
	jmp     loc_027

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_033:  mov     edi, 1
	lea     rbp, [rel str_LC1]
	jmp     loc_032

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_034:  mov     edi, 1
	lea     rbp, [rel str_LC1]
	jmp     loc_026

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_035:  lea     r14, [r13+r13]
	lea     rsi, [r14+r13]
	shl     rsi, 5
loc_036:  mov     rdi, qword [rsp]
	call    realloc
	test    rax, rax
	jz      loc_038
	mov     qword [r12], rax
	mov     qword [r12+0x10], r14
	jmp     loc_030

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_037:  mov     rdi, r13
	call    free
	mov     rdi, rbx
	call    free
loc_038:  xor     edx, edx
	jmp     loc_028

loc_039:
	cmp     qword [rdi+0x10], 0
	jne     loc_030
	mov     esi, 768
	mov     r14d, 16
	jmp     loc_036

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16

graph_add_dependency:; Function begin
	test    rdi, rdi
	je      loc_049
	push    r15
	mov     r15, rsi
	push    r14
	push    r13
	push    r12
	mov     r12, rdx
	push    rbp
	push    rbx
	sub     rsp, 24
	test    rsi, rsi
	je      loc_053
	mov     r14, qword [rdi+0x8]
	test    r14, r14
	je      loc_047
	mov     r13, qword [rdi]
	xor     ebx, ebx
	mov     rbp, r13
	jmp     loc_041

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_040:  add     rbx, 1
	add     rbp, 48
	cmp     r14, rbx
	je      loc_050
loc_041:  mov     rdi, qword [rbp]
	mov     rsi, r15
	call    strcmp
	test    eax, eax
	jnz     loc_040
	test    r12, r12
	jz      loc_047
loc_042:  mov     rbp, r13
	xor     r15d, r15d
	jmp     loc_044

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_043:  add     r15, 1
	add     rbp, 48
	cmp     r14, r15
	jz      loc_047
loc_044:  mov     rdi, qword [rbp]
	mov     rsi, r12
	call    strcmp
	mov     edx, eax
	test    eax, eax
	jnz     loc_043
	cmp     rbx, -1
	jz      loc_048
	lea     rbp, [rbx+rbx*2]
	shl     rbp, 4
	add     rbp, r13
	mov     rcx, qword [rbp+0x20]
	mov     rdi, qword [rbp+0x18]
	test    rcx, rcx
	je      loc_056
	xor     esi, esi
	jmp     loc_046

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_045:  add     rsi, 1
	cmp     rsi, rcx
	jz      loc_051
loc_046:  cmp     qword [rdi+rsi*8], r15
	jnz     loc_045
	mov     edx, 1
	jmp     loc_048

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_047:  xor     edx, edx
loc_048:  add     rsp, 24
	mov     eax, edx
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_049:  xor     eax, eax
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_050:  mov     rbx, -1
	test    r12, r12
	jne     loc_042
	jmp     loc_047

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_051:  cmp     qword [rbp+0x28], rsi
	jz      loc_054
loc_052:  lea     rax, [rcx+0x1]
	mov     edx, 1
	mov     qword [rbp+0x20], rax
	mov     qword [rdi+rcx*8], r15
	jmp     loc_048

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_053:  test    rdx, rdx
	jz      loc_047
	mov     r14, qword [rdi+0x8]
	test    r14, r14
	jz      loc_047
	mov     r13, qword [rdi]
	mov     rbx, -1
	jmp     loc_042

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_054:  lea     rbx, [rsi+rsi]
	shl     rsi, 4
loc_055:  mov     dword [rsp+0x0C], edx
	call    realloc
	mov     edx, dword [rsp+0x0C]
	test    rax, rax
	mov     rdi, rax
	je      loc_048
	mov     qword [rbp+0x18], rax
	mov     rcx, qword [rbp+0x20]
	mov     qword [rbp+0x28], rbx
	jmp     loc_052

loc_056:
	cmp     qword [rbp+0x28], 0
	jnz     loc_052
	mov     esi, 64
	mov     ebx, 8
	jmp     loc_055

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

graph_has_package:; Function begin
	test    rdi, rdi
	je      loc_061
	test    rsi, rsi
	je      loc_061
	sub     rsp, 40
	mov     qword [rsp+0x20], r13
	mov     r13, qword [rdi+0x8]
	test    r13, r13
	jz      loc_060
	mov     qword [rsp+0x8], rbx
	mov     rbx, qword [rdi]
	mov     qword [rsp+0x10], rbp
	xor     ebp, ebp
	mov     qword [rsp+0x18], r12
	mov     r12, rsi
	jmp     loc_058

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_057:  add     rbp, 1
	add     rbx, 48
	cmp     r13, rbp
	jz      loc_059
loc_058:  mov     rdi, qword [rbx]
	mov     rsi, r12
	call    strcmp
	test    eax, eax
	jnz     loc_057
	mov     rbx, qword [rsp+0x8]
	mov     rbp, qword [rsp+0x10]
	mov     eax, 1
	mov     r12, qword [rsp+0x18]
	mov     r13, qword [rsp+0x20]
	add     rsp, 40
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_059:  mov     rbx, qword [rsp+0x8]
	mov     rbp, qword [rsp+0x10]
	mov     r12, qword [rsp+0x18]
loc_060:  mov     r13, qword [rsp+0x20]
	xor     eax, eax
	add     rsp, 40
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_061:  xor     eax, eax
	ret

; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_package_count:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_062
	mov     rax, qword [rdi+0x8]
loc_062:  ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8

graph_package_name:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_063
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_063
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     rax, qword [rax]
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_063:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_package_version:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_064
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_064
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     rax, qword [rax+0x8]
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_064:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_package_source:; Function begin
	test    rdi, rdi
	jz      loc_065
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_065
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     eax, dword [rax+0x10]
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_065:  mov     eax, 2
	ret

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16

graph_topological_order:; Function begin
	sub     rsp, 104
	mov     qword [rsp+0x60], r15
	mov     r15, rdx
	mov     qword [rsp+0x10], rsi
	mov     qword [rsp+0x8], rcx
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x28], rax
	xor     eax, eax
	test    rsi, rsi
	mov     qword [rsp+0x20], 0
	sete    al
	test    rdx, rdx
	sete    dl
	or      al, dl
	jne     loc_069
	mov     qword [rsp+0x58], r14
	mov     r14, rdi
	test    rdi, rdi
	je      loc_068
	mov     qword [rsp+0x38], rbx
	mov     qword [rsp+0x40], rbp
	mov     rbp, r8
	mov     qword [rsp+0x50], r13
	mov     qword [rsp+0x48], r12
	mov     qword [rsi], 0
	mov     esi, 1
	mov     qword [r15], 0
	mov     rbx, qword [rdi+0x8]
	mov     edi, 1
	test    rbx, rbx
	cmovne  rdi, rbx
	call    calloc
	test    rax, rax
	mov     r13, rax
	sete    byte [rsp+0x1F]
	test    rbx, rbx
	je      loc_074
	lea     rdi, [rbx*8]
	call    malloc
	mov     r12, rax
	test    rax, rax
	je      loc_075
	cmp     byte [rsp+0x1F], 0
	jne     loc_075
	xor     ebx, ebx
	jmp     loc_067

; Filling space: 0x11
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00, 0x66, 0x66
;       db 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_066:  add     rbx, 1
	cmp     rbx, qword [r14+0x8]
	jnc     loc_071
loc_067:  cmp     byte [r13+rbx], 0
	jnz     loc_066
	sub     rsp, 8
	mov     rcx, r12
	mov     rdx, r13
	mov     rsi, rbx
	push    rbp
	mov     r9, qword [rsp+0x18]
	mov     rdi, r14
	lea     r8, [rsp+0x30]
	call    visit
	pop     rdx
	pop     rcx
	test    eax, eax
	jnz     loc_066
	mov     rdi, r13
	mov     dword [rsp+0x8], eax
	call    free
	mov     rdi, r12
	call    free
	mov     eax, dword [rsp+0x8]
	jmp     loc_073

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_068:  mov     r14, qword [rsp+0x58]
loc_069:  xor     eax, eax
loc_070:  mov     rdx, qword [rsp+0x28]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jne     loc_076
	mov     r15, qword [rsp+0x60]
	add     rsp, 104
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_071:  mov     rbx, qword [rsp+0x20]
loc_072:  mov     rdi, r13
	call    free
	mov     rax, qword [rsp+0x10]
	mov     qword [rax], r12
	mov     eax, 1
	mov     qword [r15], rbx
loc_073:  mov     rbx, qword [rsp+0x38]
	mov     rbp, qword [rsp+0x40]
	mov     r12, qword [rsp+0x48]
	mov     r13, qword [rsp+0x50]
	mov     r14, qword [rsp+0x58]
	jmp     loc_070

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_074:  mov     edi, 8
	call    malloc
	mov     r12, rax
	test    rax, rax
	jz      loc_075
	cmp     byte [rsp+0x1F], 0
	jz      loc_072
loc_075:  mov     rdi, r13
	call    free
	mov     rdi, r12
	call    free
	mov     rbx, qword [rsp+0x38]
	mov     rbp, qword [rsp+0x40]
	mov     r12, qword [rsp+0x48]
	mov     r13, qword [rsp+0x50]
	mov     r14, qword [rsp+0x58]
	jmp     loc_069

loc_076:
	mov     qword [rsp+0x38], rbx
	mov     qword [rsp+0x40], rbp
	mov     qword [rsp+0x48], r12
	mov     qword [rsp+0x50], r13
	mov     qword [rsp+0x58], r14
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.8 align=8 noexec

str_LC0:
	db 0x64, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x65, 0x6E
	db 0x63, 0x79, 0x20, 0x63, 0x79, 0x63, 0x6C, 0x65
	db 0x20, 0x64, 0x65, 0x74, 0x65, 0x63, 0x74, 0x65
	db 0x64, 0x3A, 0x20, 0x25, 0x73, 0x20, 0x2D, 0x3E
	db 0x20, 0x25, 0x73, 0x00

SECTION .rodata.str1.1 align=1 noexec

str_LC1:
	db 0x00

