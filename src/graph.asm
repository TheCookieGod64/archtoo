; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  graph.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 graph.asm -o graph.o
; ---------------------------------------------------------

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

SECTION .text   align=16 exec

visit:
	push    ebp
	push    edi
	mov     edi, ecx
	push    esi
	lea     esi, [ecx+edx]
	push    ebx
	sub     esp, 284
	mov     byte [esi], 1
	mov     ecx, dword [eax]
	mov     dword [esp+0x8], esi
	lea     esi, [edx+edx*2]
	shl     esi, 3
	mov     dword [esp+0x4], eax
	lea     eax, [ecx+esi]
	mov     ebp, dword [eax+0x10]
	test    ebp, ebp
	jz      loc_004
	mov     dword [esp+0x0C], edx
	xor     ebx, ebx
	jmp     loc_002

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_001:  lea     eax, [ecx+esi]
	add     ebx, 1
	cmp     ebx, dword [eax+0x10]
	jnc     loc_003
loc_002:  mov     edx, dword [eax+0x0C]
	mov     ebp, dword [edx+ebx*4]
	movzx   edx, byte [edi+ebp]
	cmp     dl, 1
	je      loc_005
	test    dl, dl
	jnz     loc_001
	push    dword [esp+0x13C]
	mov     edx, ebp
	mov     ecx, edi
	push    dword [esp+0x13C]
	push    dword [esp+0x13C]
	push    dword [esp+0x13C]
	mov     ebp, dword [esp+0x14]
	mov     eax, ebp
	call    visit
	add     esp, 16
	test    eax, eax
	jz      loc_006
	mov     ecx, dword [ebp]
	add     ebx, 1
	lea     eax, [ecx+esi]
	cmp     ebx, dword [eax+0x10]
	jc      loc_002
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_003:  mov     edx, dword [esp+0x0C]
loc_004:  mov     eax, dword [esp+0x8]
	mov     edi, dword [esp+0x134]
	mov     byte [eax], 2
	mov     eax, dword [esp+0x134]
	mov     eax, dword [eax]
	lea     ecx, [eax+0x1]
	mov     dword [edi], ecx
	mov     edi, dword [esp+0x130]
	mov     dword [edi+eax*4], edx
	add     esp, 284
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_005:  mov     ebx, dword [esp+0x138]
	test    ebx, ebx
	jz      loc_006
	mov     edx, dword [esp+0x13C]
	test    edx, edx
	jnz     loc_008
loc_006:  xor     eax, eax
loc_007:  add     esp, 284
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_008:  sub     esp, 12
	lea     edx, [ebp+ebp*2]
	push    dword [ecx+edx*8]
	push    dword [eax]
	push    loc_062
	push    256
	lea     esi, [esp+0x2C]
	push    esi
	call    snprintf
	add     esp, 32
	test    eax, eax
	jns     loc_009
	mov     byte [esp+0x10], 0
loc_009:  sub     esp, 12
	push    esi
	call    strlen
	mov     edi, dword [esp+0x14C]
	add     esp, 16
	lea     edx, [edi-0x1]
	cmp     eax, edi
	cmovnc  eax, edx
	cmp     eax, 4
	jnc     loc_011
	test    eax, eax
	jz      loc_010
	movzx   edx, byte [esp+0x10]
	mov     edi, dword [esp+0x138]
	mov     byte [edi], dl
	test    al, 0x02
	jz      loc_010
	movzx   edx, word [esp+eax+0x0E]
	mov     edi, dword [esp+0x138]
	mov     word [edi+eax-0x2], dx
; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_010:  mov     edi, dword [esp+0x138]
	mov     byte [edi+eax], 0
	xor     eax, eax
	jmp     loc_007

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_011:  mov     edx, dword [esp+0x10]
	mov     edi, dword [esp+0x138]
	mov     dword [edi], edx
	mov     edx, dword [esp+eax+0x0C]
	mov     edi, dword [esp+0x138]
	mov     dword [edi+eax-0x4], edx
	mov     edi, dword [esp+0x138]
	mov     edx, dword [esp+0x138]
	add     edi, 4
	and     edi, 0x0FFFFFFFC
	sub     edx, edi
	lea     ecx, [eax+edx]
	sub     esi, edx
	shr     ecx, 2
	rep movsd
	jmp     loc_010

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16

graph_create:; Function begin
	sub     esp, 20
	push    12
	push    1
	call    calloc
	add     esp, 28
	ret

graph_destroy:; Function begin
	push    edi
	push    esi
	push    ebx
	mov     esi, dword [esp+0x10]
	test    esi, esi
	jz      loc_014
	mov     ecx, dword [esi+0x4]
	test    ecx, ecx
	jz      loc_013
	xor     ebx, ebx
; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_012:  mov     edx, dword [esi]
	lea     eax, [ebx+ebx*2]
	sub     esp, 12
	add     ebx, 1
	lea     edi, [eax*8]
	push    dword [edx+eax*8]
	call    free
	pop     eax
	mov     eax, dword [esi]
	push    dword [eax+edi+0x4]
	call    free
	mov     eax, dword [esi]
	pop     edx
	push    dword [eax+edi+0x0C]
	call    free
	add     esp, 16
	cmp     ebx, dword [esi+0x4]
	jc      loc_012
loc_013:  sub     esp, 12
	push    dword [esi]
	call    free
	add     esp, 16
	mov     dword [esp+0x10], esi
	pop     ebx
	pop     esi
	pop     edi
	jmp     free

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_014:  pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8

graph_add_package:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 28
	mov     edi, dword [esp+0x30]
	mov     ebx, dword [esp+0x34]
	test    edi, edi
	jz      loc_015
	test    ebx, ebx
	jz      loc_015
	cmp     byte [ebx], 0
	jnz     loc_016
loc_015:  add     esp, 28
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_016:  mov     eax, dword [esp+0x30]
	mov     esi, dword [eax]
	mov     edi, dword [eax+0x4]
	mov     dword [esp+0x0C], esi
	test    edi, edi
	je      loc_031
	xor     ebp, ebp
	jmp     loc_018

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_017:  add     ebp, 1
	add     esi, 24
	cmp     edi, ebp
	je      loc_021
loc_018:  sub     esp, 8
	push    ebx
	push    dword [esi]
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_017
	mov     eax, dword [esp+0x38]
	test    eax, eax
	je      loc_027
	sub     esp, 12
	push    dword [esp+0x44]
	call    strlen
	add     esp, 16
	add     eax, 1
loc_019:  sub     esp, 12
	push    eax
	call    malloc
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	je      loc_015
	sub     esp, 8
	push    dword [esp+0x40]
	push    eax
	call    strcpy
	lea     eax, [ebp+ebp*2]
	pop     esi
	lea     ebx, [eax*8]
	mov     eax, dword [esp+0x18]
	push    dword [eax+ebx+0x4]
	call    free
	mov     edx, dword [esp+0x40]
	mov     eax, dword [edx]
	mov     edx, dword [esp+0x4C]
	add     esp, 16
	add     eax, ebx
	mov     dword [eax+0x4], edi
	mov     dword [eax+0x8], edx
loc_020:  add     esp, 28
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_021:  mov     eax, dword [esp+0x30]
	cmp     dword [eax+0x8], edi
	je      loc_028
loc_022:  sub     esp, 12
	push    ebx
	call    strlen
	lea     ebp, [eax+0x1]
	mov     dword [esp], ebp
	call    malloc
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	jz      loc_023
	sub     esp, 4
	push    ebp
	push    ebx
	push    eax
	call    memcpy
	add     esp, 16
loc_023:  mov     edx, dword [esp+0x38]
	test    edx, edx
	je      loc_026
	sub     esp, 12
	push    dword [esp+0x44]
	call    strlen
	add     esp, 16
	add     eax, 1
loc_024:  sub     esp, 12
	push    eax
	call    malloc
	add     esp, 16
	mov     ebx, eax
	test    eax, eax
	je      loc_030
	sub     esp, 8
	push    dword [esp+0x40]
	push    eax
	call    strcpy
	add     esp, 16
	test    edi, edi
	je      loc_030
	mov     eax, dword [esp+0x30]
	xor     ebp, ebp
	mov     edx, dword [eax+0x4]
	mov     eax, dword [eax]
	lea     ecx, [edx+edx*2]
	lea     ecx, [eax+ecx*8]
	xor     eax, eax
loc_025:  mov     dword [ecx+eax], ebp
	mov     dword [ecx+eax+0x4], ebp
	add     eax, 8
	cmp     eax, 24
	jc      loc_025
	mov     eax, dword [esp+0x3C]
	add     edx, 1
	mov     dword [ecx], edi
	mov     dword [ecx+0x4], ebx
	mov     dword [ecx+0x8], eax
	mov     eax, dword [esp+0x30]
	mov     dword [eax+0x4], edx
	jmp     loc_020

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_026:  mov     dword [esp+0x38], loc_063
	mov     eax, 1
	jmp     loc_024

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_027:  mov     dword [esp+0x38], loc_063
	mov     eax, 1
	jmp     loc_019

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_028:  lea     ebp, [edi+edi]
	add     edi, ebp
	shl     edi, 4
loc_029:  sub     esp, 8
	push    edi
	push    dword [esp+0x18]
	call    realloc
	add     esp, 16
	test    eax, eax
	je      loc_015
	mov     ecx, dword [esp+0x30]
	mov     dword [ecx], eax
	mov     dword [ecx+0x8], ebp
	jmp     loc_022

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_030:  sub     esp, 12
	push    edi
	call    free
	mov     dword [esp], ebx
	call    free
	add     esp, 16
	jmp     loc_015

loc_031:
	mov     eax, dword [esp+0x30]
	mov     ecx, dword [eax+0x8]
	test    ecx, ecx
	jne     loc_022
	mov     edi, 384
	mov     ebp, 16
	jmp     loc_029

; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16

graph_add_dependency:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 28
	mov     eax, dword [esp+0x30]
	mov     edi, dword [esp+0x34]
	test    eax, eax
	je      loc_040
	test    edi, edi
	je      loc_044
	mov     ebp, dword [eax]
	mov     esi, dword [eax+0x4]
	mov     dword [esp+0x0C], ebp
	test    esi, esi
	je      loc_040
	xor     ebx, ebx
	jmp     loc_033

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_032:  add     ebx, 1
	add     ebp, 24
	cmp     esi, ebx
	je      loc_041
loc_033:  sub     esp, 8
	push    edi
	push    dword [ebp]
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_032
	mov     eax, dword [esp+0x38]
	test    eax, eax
	jz      loc_040
loc_034:  mov     edi, dword [esp+0x0C]
	xor     ebp, ebp
	jmp     loc_036

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_035:  add     ebp, 1
	add     edi, 24
	cmp     esi, ebp
	jz      loc_040
loc_036:  sub     esp, 8
	push    dword [esp+0x40]
	push    dword [edi]
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_035
	cmp     ebx, -1
	jz      loc_040
	mov     edx, dword [esp+0x0C]
	lea     eax, [ebx+ebx*2]
	lea     esi, [edx+eax*8]
	mov     ecx, dword [esi+0x10]
	mov     edi, dword [esi+0x0C]
	test    ecx, ecx
	je      loc_047
	xor     eax, eax
	jmp     loc_038

loc_037:  add     eax, 1
	cmp     eax, ecx
	jz      loc_042
loc_038:  cmp     dword [edi+eax*4], ebp
	jnz     loc_037
	mov     eax, 1
loc_039:  add     esp, 28
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_040:  add     esp, 28
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_041:  mov     eax, dword [esp+0x38]
	mov     ebx, 4294967295
	test    eax, eax
	jne     loc_034
	jmp     loc_040

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_042:  cmp     dword [esi+0x14], eax
	jz      loc_045
loc_043:  lea     eax, [ecx+0x1]
	mov     dword [esi+0x10], eax
	mov     eax, 1
	mov     dword [edi+ecx*4], ebp
	jmp     loc_039

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_044:  mov     ecx, dword [esp+0x38]
	test    ecx, ecx
	jz      loc_040
	mov     edx, dword [eax]
	mov     esi, dword [eax+0x4]
	mov     dword [esp+0x0C], edx
	test    esi, esi
	jz      loc_040
	mov     ebx, 4294967295
	jmp     loc_034

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_045:  lea     ebx, [eax+eax]
	shl     eax, 3
loc_046:  sub     esp, 8
	push    eax
	push    edi
	call    realloc
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	jz      loc_040
	mov     dword [esi+0x0C], eax
	mov     ecx, dword [esi+0x10]
	mov     dword [esi+0x14], ebx
	jmp     loc_043

loc_047:
	mov     edx, dword [esi+0x14]
	test    edx, edx
	jnz     loc_043
	mov     eax, 32
	mov     ebx, 8
	jmp     loc_046

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16

graph_has_package:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 12
	mov     eax, dword [esp+0x20]
	mov     esi, dword [esp+0x24]
	test    eax, eax
	jz      loc_050
	test    esi, esi
	jz      loc_050
	mov     edi, dword [eax+0x4]
	mov     ebx, dword [eax]
	test    edi, edi
	jz      loc_050
	xor     ebp, ebp
	jmp     loc_049

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_048:  add     ebp, 1
	add     ebx, 24
	cmp     edi, ebp
	jz      loc_050
loc_049:  sub     esp, 8
	push    esi
	push    dword [ebx]
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_048
	add     esp, 12
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_050:  add     esp, 12
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x0E
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_package_count:; Function begin
	mov     edx, dword [esp+0x4]
	xor     eax, eax
	test    edx, edx
	jz      loc_051
	mov     eax, dword [edx+0x4]
loc_051:  ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

graph_package_name:; Function begin
	mov     edx, dword [esp+0x4]
	mov     eax, dword [esp+0x8]
	xor     ecx, ecx
	test    edx, edx
	jz      loc_052
	cmp     eax, dword [edx+0x4]
	jnc     loc_052
	mov     ecx, dword [edx]
	lea     eax, [eax+eax*2]
	lea     eax, [ecx+eax*8]
	mov     ecx, dword [eax]
loc_052:  mov     eax, ecx
	ret

graph_package_version:; Function begin
	mov     edx, dword [esp+0x4]
	mov     eax, dword [esp+0x8]
	xor     ecx, ecx
	test    edx, edx
	jz      loc_053
	cmp     eax, dword [edx+0x4]
	jnc     loc_053
	mov     ecx, dword [edx]
	lea     eax, [eax+eax*2]
	lea     eax, [ecx+eax*8]
	mov     ecx, dword [eax+0x4]
loc_053:  mov     eax, ecx
	ret

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

graph_package_source:; Function begin
	mov     eax, dword [esp+0x4]
	mov     edx, dword [esp+0x8]
	mov     ecx, 2
	test    eax, eax
	jz      loc_054
	cmp     edx, dword [eax+0x4]
	jnc     loc_054
	mov     ecx, dword [eax]
	lea     edx, [edx+edx*2]
	lea     edx, [ecx+edx*8]
	mov     ecx, dword [edx+0x8]
loc_054:  mov     eax, ecx
	ret

; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16

graph_topological_order:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 44
	mov     eax, dword [esp+0x44]
	mov     edx, dword [esp+0x48]
	mov     dword [esp+0x1C], 0
	mov     ebx, dword [esp+0x40]
	test    eax, eax
	sete    al
	test    edx, edx
	sete    dl
	or      al, dl
	jne     loc_061
	test    ebx, ebx
	je      loc_061
	mov     eax, dword [esp+0x44]
	sub     esp, 8
	mov     dword [eax], 0
	mov     eax, dword [esp+0x50]
	mov     dword [eax], 0
	mov     ebp, dword [ebx+0x4]
	mov     eax, 1
	push    1
	test    ebp, ebp
	cmovne  eax, ebp
	push    eax
	call    calloc
	add     esp, 16
	test    eax, eax
	mov     edi, eax
	sete    byte [esp+0x0F]
	test    ebp, ebp
	je      loc_059
	sub     esp, 12
	lea     edx, [ebp*4]
	push    edx
	call    malloc
	add     esp, 16
	mov     esi, eax
	test    eax, eax
	je      loc_060
	cmp     byte [esp+0x0F], 0
	jne     loc_060
	xor     ebp, ebp
	jmp     loc_056

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_055:  add     ebp, 1
	cmp     ebp, dword [ebx+0x4]
	jnc     loc_057
loc_056:  cmp     byte [edi+ebp], 0
	jnz     loc_055
	push    dword [esp+0x50]
	mov     ecx, edi
	mov     edx, ebp
	push    dword [esp+0x50]
	lea     eax, [esp+0x24]
	push    eax
	mov     eax, ebx
	push    esi
	call    visit
	add     esp, 16
	test    eax, eax
	jz      loc_060
	add     ebp, 1
	cmp     ebp, dword [ebx+0x4]
	jc      loc_056
loc_057:  mov     ebp, dword [esp+0x1C]
loc_058:  sub     esp, 12
	push    edi
	call    free
	mov     eax, dword [esp+0x54]
	mov     dword [eax], esi
	mov     eax, dword [esp+0x58]
	add     esp, 16
	mov     dword [eax], ebp
	add     esp, 44
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_059:  sub     esp, 12
	push    4
	call    malloc
	add     esp, 16
	mov     esi, eax
	test    eax, eax
	jz      loc_060
	cmp     byte [esp+0x0F], 0
	jz      loc_058
loc_060:  sub     esp, 12
	push    edi
	call    free
	mov     dword [esp], esi
	call    free
	add     esp, 16
loc_061:  add     esp, 44
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

SECTION .rodata.str1.4 align=4 noexec

loc_062:
	db 0x64, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x65, 0x6E
	db 0x63, 0x79, 0x20, 0x63, 0x79, 0x63, 0x6C, 0x65
	db 0x20, 0x64, 0x65, 0x74, 0x65, 0x63, 0x74, 0x65
	db 0x64, 0x3A, 0x20, 0x25, 0x73, 0x20, 0x2D, 0x3E
	db 0x20, 0x25, 0x73, 0x00

SECTION .rodata.str1.1 align=1 noexec

loc_063:
	db 0x00

