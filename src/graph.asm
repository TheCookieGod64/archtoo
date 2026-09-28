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
extern strlen
extern snprintf

SECTION .text   align=32 exec

visit:
	push    r15
	lea     r10, [rdx+rsi]
	mov     r15, r8
	push    r14
	mov     r14, rcx
	push    r13
	mov     r13, rdi
	mov     rdi, rsi
	push    r12
	lea     r12, [rsi+rsi*2]
	push    rbp
	shl     r12, 4
	push    rbx
	sub     rsp, 296
	mov     byte [r10], 1
	mov     r8, qword [r13]
	lea     rax, [r8+r12]
	cmp     qword [rax+0x20], 0
	je      loc_004
	mov     qword [rsp+0x10], r10
	mov     rbp, rdx
	xor     ebx, ebx
	mov     qword [rsp+0x18], rsi
	jmp     loc_002

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_001:  lea     rax, [r8+r12]
	add     rbx, 1
	cmp     rbx, qword [rax+0x20]
	jnc     loc_003
loc_002:  mov     rdx, qword [rax+0x18]
	mov     rsi, qword [rdx+rbx*8]
	movzx   edx, byte [rbp+rsi]
	cmp     dl, 1
; Note: Immediate operand could be made smaller by sign extension
	je      loc_006
	test    dl, dl
	jnz     loc_001
	sub     rsp, 8
	mov     rcx, r14
	mov     rdx, rbp
	mov     r8, r15
	push    qword [rsp+0x168]
	mov     rdi, r13
	mov     qword [rsp+0x18], r9
	call    visit
	pop     rdx
	pop     rcx
	test    eax, eax
	jz      loc_007
	mov     r8, qword [r13]
	mov     r9, qword [rsp+0x8]
	add     rbx, 1
	lea     rax, [r8+r12]
	cmp     rbx, qword [rax+0x20]
	jc      loc_002
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_003:  mov     r10, qword [rsp+0x10]
	mov     rdi, qword [rsp+0x18]
loc_004:  mov     byte [r10], 2
	mov     rax, qword [r15]
	lea     rdx, [rax+0x1]
	mov     qword [r15], rdx
	mov     qword [r14+rax*8], rdi
	mov     eax, 1
loc_005:  add     rsp, 296
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
loc_006:  test    r9, r9
	jz      loc_007
	cmp     qword [rsp+0x160], 0
	jnz     loc_008
loc_007:  xor     eax, eax
	jmp     loc_005

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_008:  lea     rdx, [rsi+rsi*2]
	mov     rcx, qword [rax]
	lea     rbx, [rsp+0x20]
	xor     eax, eax
	shl     rdx, 4
	mov     esi, 256
	mov     rdi, rbx
	mov     qword [rsp+0x8], r9
	mov     r8, qword [r8+rdx]
	lea     rdx, [rel str_LC0]
	call    snprintf
	mov     r9, qword [rsp+0x8]
	test    eax, eax
	jns     loc_009
	mov     byte [rsp+0x20], 0
loc_009:  mov     rdi, rbx
	mov     qword [rsp+0x8], r9
	call    strlen
	mov     rcx, qword [rsp+0x160]
	mov     r9, qword [rsp+0x8]
	cmp     rax, rcx
	lea     rdx, [rcx-0x1]
	cmovnc  rax, rdx
	cmp     eax, 8
	mov     ecx, eax
	jnc     loc_011
	test    al, 0x04
	jnz     loc_012
	test    eax, eax
	jz      loc_010
	movzx   edx, byte [rsp+0x20]
	mov     byte [r9], dl
	test    al, 0x02
	jz      loc_010
	mov     edx, eax
	movzx   ecx, word [rbx+rdx-0x2]
	mov     word [r9+rdx-0x2], cx
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_010:  mov     byte [r9+rax], 0
	xor     eax, eax
	jmp     loc_005

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_011:  mov     rdx, qword [rsp+0x20]
	lea     rdi, [r9+0x8]
	mov     rsi, rbx
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	mov     qword [r9], rdx
	mov     edx, eax
	mov     rcx, qword [rbx+rdx-0x8]
	mov     qword [r9+rdx-0x8], rcx
	mov     rcx, r9
	sub     rcx, rdi
	sub     rsi, rcx
	add     ecx, eax
	shr     ecx, 3
	rep movsq
	jmp     loc_010

loc_012:
	mov     edx, dword [rsp+0x20]
	mov     dword [r9], edx
	mov     edx, dword [rbx+rcx-0x4]
	mov     dword [r9+rcx-0x4], edx
	jmp     loc_010

; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16

graph_create:; Function begin
	mov     esi, 24
	mov     edi, 1
	jmp     calloc

	nop

ALIGN   16
graph_destroy:; Function begin
	test    rdi, rdi
	jz      loc_015
	push    r12
	mov     r12, rdi
	push    rbp
	push    rbx
	cmp     qword [rdi+0x8], 0
	jz      loc_014
	xor     ebp, ebp
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_013:  mov     rax, qword [r12]
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
	jc      loc_013
loc_014:  mov     rdi, qword [r12]
	call    free
	pop     rbx
	mov     rdi, r12
	pop     rbp
	pop     r12
	jmp     free

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_015:  ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

graph_add_package:; Function begin
	push    r15
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 24
	mov     dword [rsp+0x4], ecx
	test    rdi, rdi
	jz      loc_016
	mov     rbx, rsi
	test    rsi, rsi
	jz      loc_016
	cmp     byte [rsi], 0
	jnz     loc_017
loc_016:  add     rsp, 24
	xor     eax, eax
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_017:  mov     rax, qword [rdi]
	mov     r14, qword [rdi+0x8]
	mov     rbp, rdi
	mov     r12, rdx
	mov     qword [rsp+0x8], rax
	test    r14, r14
	je      loc_031
	mov     r13, rax
	xor     r15d, r15d
	jmp     loc_019

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_018:  add     r15, 1
	add     r13, 48
	cmp     r14, r15
	jz      loc_022
loc_019:  mov     rdi, qword [r13]
	mov     rsi, rbx
	call    strcmp
	test    eax, eax
	jnz     loc_018
	test    r12, r12
	je      loc_027
	mov     rdi, r12
	call    strlen
	lea     rdi, [rax+0x1]
loc_020:  call    malloc
	mov     r14, rax
	test    rax, rax
	jz      loc_016
	mov     rsi, r12
	mov     rdi, rax
	lea     rbx, [r15+r15*2]
	call    strcpy
	mov     rax, qword [rsp+0x8]
	shl     rbx, 4
	mov     rdi, qword [rax+rbx+0x8]
	call    free
	mov     eax, dword [rsp+0x4]
	add     rbx, qword [rbp]
	mov     qword [rbx+0x8], r14
	mov     dword [rbx+0x10], eax
loc_021:  add     rsp, 24
	mov     eax, 1
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
loc_022:  cmp     qword [rbp+0x10], r14
	je      loc_028
loc_023:  mov     rdi, rbx
	call    strlen
	lea     r15, [rax+0x1]
	mov     rdi, r15
	call    malloc
	mov     r14, rax
	test    rax, rax
	jz      loc_024
	mov     rdx, r15
	mov     rsi, rbx
	mov     rdi, rax
	call    memcpy
loc_024:  test    r12, r12
	jz      loc_026
	mov     rdi, r12
	call    strlen
	lea     rdi, [rax+0x1]
loc_025:  call    malloc
	mov     rbx, rax
	test    rax, rax
	je      loc_030
	mov     rsi, r12
	mov     rdi, rax
	call    strcpy
	test    r14, r14
	je      loc_030
	mov     rdx, qword [rbp+0x8]
	mov     ecx, dword [rsp+0x4]
	pxor    xmm0, xmm0
	lea     rax, [rdx+rdx*2]
	add     rdx, 1
	shl     rax, 4
	add     rax, qword [rbp]
	movups  oword [rax+0x10], xmm0
	mov     qword [rax], r14
	mov     qword [rax+0x8], rbx
	mov     dword [rax+0x10], ecx
	movups  oword [rax+0x20], xmm0
	mov     qword [rbp+0x8], rdx
	jmp     loc_021

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_026:  mov     edi, 1
	lea     r12, [rel str_LC1]
	jmp     loc_025

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_027:  mov     edi, 1
	lea     r12, [rel str_LC1]
	jmp     loc_020

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_028:  lea     r15, [r14+r14]
	lea     rsi, [r15+r14]
	shl     rsi, 5
loc_029:  mov     rdi, qword [rsp+0x8]
	call    realloc
	test    rax, rax
	je      loc_016
	mov     qword [rbp], rax
	mov     qword [rbp+0x10], r15
	jmp     loc_023

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_030:  mov     rdi, r14
	call    free
	mov     rdi, rbx
	call    free
	jmp     loc_016

loc_031:
	cmp     qword [rdi+0x10], 0
	jne     loc_023
	mov     esi, 768
	mov     r15d, 16
	jmp     loc_029

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16

graph_add_dependency:; Function begin
	test    rdi, rdi
	je      loc_044
	push    r15
	push    r14
	mov     r14, rdx
	push    r13
	push    r12
	mov     r12, rsi
	push    rbp
	push    rbx
	sub     rsp, 8
	test    rsi, rsi
	je      loc_045
	mov     r13, qword [rdi+0x8]
	mov     r15, qword [rdi]
	test    r13, r13
	je      loc_040
	mov     rbx, r15
	xor     ebp, ebp
	jmp     loc_033

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_032:  add     rbp, 1
	add     rbx, 48
	cmp     r13, rbp
	je      loc_041
loc_033:  mov     rdi, qword [rbx]
	mov     rsi, r12
	call    strcmp
	test    eax, eax
	jnz     loc_032
	test    r14, r14
; Note: Immediate operand could be made smaller by sign extension
	je      loc_040
loc_034:  mov     r12, r15
	xor     ebx, ebx
	jmp     loc_036

loc_035:  add     rbx, 1
	add     r12, 48
	cmp     r13, rbx
	jz      loc_040
loc_036:  mov     rdi, qword [r12]
	mov     rsi, r14
	call    strcmp
	test    eax, eax
	jnz     loc_035
	cmp     rbp, -1
	jz      loc_040
	lea     r12, [rbp+rbp*2]
	shl     r12, 4
	add     r12, r15
	mov     rdx, qword [r12+0x20]
	mov     rdi, qword [r12+0x18]
	test    rdx, rdx
	je      loc_048
	xor     esi, esi
	jmp     loc_038

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_037:  add     rsi, 1
	cmp     rsi, rdx
	jz      loc_042
loc_038:  cmp     qword [rdi+rsi*8], rbx
	jnz     loc_037
loc_039:  add     rsp, 8
	mov     eax, 1
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
loc_040:  add     rsp, 8
	xor     eax, eax
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_041:  mov     rbp, -1
	test    r14, r14
	jne     loc_034
	jmp     loc_040

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_042:  cmp     qword [r12+0x28], rsi
	jz      loc_046
loc_043:  lea     rax, [rdx+0x1]
	mov     qword [r12+0x20], rax
	mov     qword [rdi+rdx*8], rbx
	jmp     loc_039

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_044:  xor     eax, eax
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_045:  test    rdx, rdx
	jz      loc_040
	mov     r13, qword [rdi+0x8]
	mov     r15, qword [rdi]
	test    r13, r13
	jz      loc_040
	mov     rbp, -1
	jmp     loc_034

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_046:  lea     rbp, [rsi+rsi]
	shl     rsi, 4
loc_047:  call    realloc
	mov     rdi, rax
	test    rax, rax
	je      loc_040
	mov     qword [r12+0x18], rax
	mov     rdx, qword [r12+0x20]
	mov     qword [r12+0x28], rbp
	jmp     loc_043

loc_048:
	cmp     qword [r12+0x28], 0
	jnz     loc_043
	mov     esi, 64
	mov     ebp, 8
	jmp     loc_047

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16

graph_has_package:; Function begin
	test    rdi, rdi
	jz      loc_052
	push    r13
	push    r12
	mov     r12, rsi
	push    rbp
	push    rbx
	sub     rsp, 8
	test    rsi, rsi
	jz      loc_051
	mov     r13, qword [rdi+0x8]
	mov     rbx, qword [rdi]
	test    r13, r13
	jz      loc_051
	xor     ebp, ebp
	jmp     loc_050

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_049:  add     rbp, 1
	add     rbx, 48
	cmp     r13, rbp
	jz      loc_051
loc_050:  mov     rdi, qword [rbx]
	mov     rsi, r12
	call    strcmp
	test    eax, eax
	jnz     loc_049
	add     rsp, 8
	mov     eax, 1
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_051:  add     rsp, 8
	xor     eax, eax
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_052:  xor     eax, eax
	ret

; Filling space: 0x0D
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x90

ALIGN   16

graph_package_count:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_053
	mov     rax, qword [rdi+0x8]
loc_053:  ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8

graph_package_name:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_054
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_054
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     rax, qword [rax]
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_054:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

graph_package_version:; Function begin
	xor     eax, eax
	test    rdi, rdi
	jz      loc_055
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_055
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     rax, qword [rax+0x8]
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_055:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

graph_package_source:; Function begin
	mov     eax, 2
	test    rdi, rdi
	jz      loc_056
	cmp     rsi, qword [rdi+0x8]
	jnc     loc_056
	lea     rax, [rsi+rsi*2]
	shl     rax, 4
	add     rax, qword [rdi]
	mov     eax, dword [rax+0x10]
	ret

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_056:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

graph_topological_order:; Function begin
	push    r15
	push    r14
	push    r13
	mov     r13, rdx
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 56
	test    rsi, rsi
	sete    al
	test    rdx, rdx
	mov     qword [rsp+0x18], rsi
	sete    dl
	mov     qword [rsp+0x8], rcx
	mov     qword [rsp+0x28], 0
	or      al, dl
	jne     loc_063
	mov     r12, rdi
	test    rdi, rdi
	je      loc_063
	mov     qword [rsi], 0
	mov     esi, 1
	mov     rbp, r8
	mov     qword [r13], 0
	mov     r15, qword [rdi+0x8]
	mov     edi, 1
	test    r15, r15
	cmovne  rdi, r15
	call    calloc
	test    rax, rax
	mov     rbx, rax
	sete    byte [rsp+0x10]
	test    r15, r15
	je      loc_061
	lea     rdi, [r15*8]
	call    malloc
	mov     r14, rax
	test    rax, rax
	je      loc_062
	cmp     byte [rsp+0x10], 0
	jne     loc_062
	lea     rax, [rsp+0x28]
	xor     r15d, r15d
	mov     qword [rsp+0x10], rax
	jmp     loc_058

; Filling space: 0x19
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x1F
;       db 0x00

ALIGN   16
loc_057:  add     r15, 1
	cmp     r15, qword [r12+0x8]
	jnc     loc_059
loc_058:  cmp     byte [rbx+r15], 0
	jnz     loc_057
	sub     rsp, 8
	mov     rcx, r14
	mov     rdx, rbx
	mov     rsi, r15
	push    rbp
	mov     r9, qword [rsp+0x18]
	mov     rdi, r12
	mov     r8, qword [rsp+0x20]
	call    visit
	pop     rdx
	pop     rcx
	test    eax, eax
	jz      loc_062
	add     r15, 1
	cmp     r15, qword [r12+0x8]
	jc      loc_058
loc_059:  mov     r15, qword [rsp+0x28]
loc_060:  mov     rdi, rbx
	call    free
	mov     rax, qword [rsp+0x18]
	mov     qword [rax], r14
	mov     eax, 1
	mov     qword [r13], r15
	add     rsp, 56
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_061:  mov     edi, 8
	call    malloc
	mov     r14, rax
	test    rax, rax
	jz      loc_062
	cmp     byte [rsp+0x10], 0
	jz      loc_060
loc_062:  mov     rdi, rbx
	call    free
	mov     rdi, r14
	call    free
loc_063:  add     rsp, 56
	xor     eax, eax
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

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

