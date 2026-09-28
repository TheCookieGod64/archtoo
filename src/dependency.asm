; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  dependency.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 dependency.asm -o dependency.o
; ---------------------------------------------------------

global cmd_dependency_plan_v2: function

extern fprintf
extern stderr
extern graph_package_source
extern graph_package_version
extern aur_response_destroy
extern aur_rpc_info
extern config_current
extern puts
extern putc
extern stdout
extern graph_destroy
extern graph_package_name
extern graph_topological_order
extern free
extern strtok_r
extern strdup
extern graph_create
extern strcmp
extern printf
extern strncmp
extern strchr
extern run_cmd_capture
extern xsnprintf
extern shell_quote
extern graph_add_package
extern graph_add_dependency
extern graph_has_package
extern valid_pkgname
extern dep_basename

SECTION .text   align=16 exec

add_dep_nodes:
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 188
	mov     ebp, dword [esp+0x0D0]
	mov     dword [esp+0x8], eax
	mov     dword [esp+0x0C], edx
	test    ebp, ebp
	jz      loc_004
	mov     edi, ecx
	xor     ebx, ebx
	lea     esi, [esp+0x10]
; Filling space: 0x0B
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16
loc_001:  sub     esp, 4
	push    160
	push    esi
	push    dword [edi+ebx*4]
	call    dep_basename
	add     esp, 16
	cmp     byte [esp+0x10], 0
	jz      loc_003
	sub     esp, 12
	push    esi
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jz      loc_003
	sub     esp, 8
	push    esi
	push    dword [esp+0x14]
	call    graph_has_package
	add     esp, 16
	test    eax, eax
	jz      loc_005
loc_002:  sub     esp, 4
	push    esi
	push    dword [esp+0x14]
	push    dword [esp+0x14]
	call    graph_add_dependency
	add     esp, 16
loc_003:  add     ebx, 1
	cmp     ebp, ebx
	jnz     loc_001
loc_004:  add     esp, 188
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_005:  push    0
	push    loc_074
	push    esi
	push    dword [esp+0x14]
	call    graph_add_package
	add     esp, 16
	jmp     loc_002

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

plan_from_repo:
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 1312
	mov     dword [esp+0x0C], eax
	mov     dword [esp+0x24], 0
	push    320
	lea     ebx, [esp+0x1D8]
	push    ebx
	push    eax
	call    shell_quote
	add     esp, 16
	test    eax, eax
	jnz     loc_007
loc_006:  add     esp, 1308
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_007:  push    ebx
	push    loc_077
	push    512
	lea     ebx, [esp+0x31C]
	push    ebx
	call    xsnprintf
	pop     edx
	pop     ecx
	lea     eax, [esp+0x28]
	push    eax
	push    ebx
	call    run_cmd_capture
	mov     edi, dword [esp+0x30]
	add     esp, 16
	test    eax, eax
	jne     loc_039
	test    edi, edi
	je      loc_039
	cmp     byte [edi], 0
	je      loc_039
	xor     eax, eax
	xor     edx, edx
	xor     esi, esi
	mov     dword [esp+0x10], 0
	mov     dword [esp+0x0C], 0
	xor     ebp, ebp
	mov     dword [esp+0x14], eax
	mov     dword [esp+0x18], esi
	mov     dword [esp+0x1C], edx
	jmp     loc_011

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_008:  lea     ebp, [ebx+0x1]
loc_009:  test    esi, esi
	je      loc_014
loc_010:  cmp     byte [esi+0x1], 0
	lea     edi, [esi+0x1]
	je      loc_014
loc_011:  sub     esp, 8
	push    10
	push    edi
	call    strchr
	add     esp, 16
	mov     esi, eax
	test    eax, eax
	jz      loc_013
	sub     esp, 8
	mov     byte [eax], 0
	push    58
	push    edi
	call    strchr
	add     esp, 16
	mov     ebx, eax
	test    eax, eax
	jz      loc_010
loc_012:  sub     esp, 4
	mov     byte [ebx], 0
	push    7
	push    loc_078
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jz      loc_008
	sub     esp, 4
	push    10
	push    loc_079
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jne     loc_038
	lea     eax, [ebx+0x1]
	mov     dword [esp+0x14], eax
	jmp     loc_009

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_013:  sub     esp, 8
	push    58
	push    edi
	call    strchr
	add     esp, 16
	mov     ebx, eax
	test    eax, eax
	jnz     loc_012
loc_014:  mov     eax, dword [esp+0x14]
	mov     esi, dword [esp+0x18]
	mov     edx, dword [esp+0x1C]
	test    ebp, ebp
	jz      loc_017
	movzx   ecx, byte [ebp]
	cmp     cl, 32
	jnz     loc_016
; Filling space: 0x0B
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16
loc_015:  movzx   ecx, byte [ebp+0x1]
	add     ebp, 1
	cmp     cl, 32
	jz      loc_015
loc_016:  cmp     cl, 9
	jz      loc_015
loc_017:  test    eax, eax
	jne     loc_035
	test    esi, esi
	jne     loc_037
loc_018:  mov     edi, dword [esp+0x0C]
	test    edi, edi
	jz      loc_021
loc_019:  movzx   ecx, byte [edi]
	cmp     cl, 32
	je      loc_052
	cmp     cl, 9
	jnz     loc_021
	mov     ecx, edi
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_020:  movzx   ebx, byte [ecx+0x1]
	add     ecx, 1
	cmp     bl, 32
	jz      loc_020
	cmp     bl, 9
	jz      loc_020
	mov     dword [esp+0x0C], ecx
loc_021:  test    edx, edx
	jz      loc_023
	movzx   ecx, byte [edx]
	cmp     cl, 9
	jz      loc_022
	cmp     cl, 32
	jnz     loc_023
; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_022:  movzx   ecx, byte [edx+0x1]
	add     edx, 1
	cmp     cl, 32
	jz      loc_022
	cmp     cl, 9
	jz      loc_022
loc_023:  mov     edi, dword [esp+0x10]
	test    edi, edi
	jz      loc_025
	movzx   ecx, byte [edi]
	cmp     cl, 9
	je      loc_051
	cmp     cl, 32
	jnz     loc_025
	mov     ecx, edi
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_024:  movzx   ebx, byte [ecx+0x1]
	add     ecx, 1
	cmp     bl, 32
	jz      loc_024
	cmp     bl, 9
	jz      loc_024
	mov     dword [esp+0x10], ecx
loc_025:  test    eax, eax
	je      loc_041
	cmp     byte [eax], 0
	mov     ecx, loc_075
	cmove   eax, ecx
loc_026:  test    ebp, ebp
	mov     ecx, loc_074
	mov     dword [esp+0x14], edx
	mov     ebx, loc_076
	cmove   ebp, ecx
	push    eax
	push    ebp
	push    dword [esp+0x10]
	push    loc_103
	call    printf
	add     esp, 16
	test    esi, esi
	mov     edx, dword [esp+0x14]
	jz      loc_027
	cmp     byte [esi], 0
	jz      loc_027
	sub     esp, 8
	push    loc_085
	push    esi
	call    strcmp
	add     esp, 16
	mov     edx, dword [esp+0x14]
	test    eax, eax
	cmovne  ebx, esi
loc_027:  mov     dword [esp+0x14], edx
	sub     esp, 4
	push    ebx
	push    loc_086
	push    loc_087
	call    printf
	mov     edx, dword [esp+0x24]
	add     esp, 16
	test    edx, edx
	je      loc_050
	cmp     byte [edx], 0
	je      loc_050
	sub     esp, 8
	push    loc_085
	push    edx
	mov     dword [esp+0x24], edx
	call    strcmp
	mov     edx, dword [esp+0x24]
	add     esp, 16
	test    eax, eax
	mov     eax, loc_076
	cmove   edx, eax
loc_028:  sub     esp, 4
	push    edx
	push    loc_088
	push    loc_087
	call    printf
	mov     edi, dword [esp+0x20]
	add     esp, 16
	test    edi, edi
	je      loc_049
	cmp     byte [edi], 0
	je      loc_049
	sub     esp, 8
	push    loc_085
	push    edi
	call    strcmp
	add     esp, 16
	test    eax, eax
	mov     eax, loc_076
	cmovne  eax, edi
	mov     dword [esp+0x10], eax
loc_029:  sub     esp, 4
	push    dword [esp+0x14]
	push    loc_089
	push    loc_087
	call    printf
	mov     edi, dword [esp+0x1C]
	add     esp, 16
	test    edi, edi
	je      loc_048
	cmp     byte [edi], 0
	je      loc_048
	sub     esp, 8
	push    loc_085
	push    edi
	call    strcmp
	add     esp, 16
	test    eax, eax
	mov     eax, loc_076
	cmovne  eax, edi
	mov     dword [esp+0x0C], eax
loc_030:  sub     esp, 4
	push    dword [esp+0x10]
	push    loc_090
	push    loc_087
	call    printf
	mov     dword [esp], loc_104
	lea     edi, [esp+0x0E0]
	call    printf
	call    graph_create
	mov     ecx, 64
	mov     dword [esp+0x34], 0
	mov     ebx, eax
	xor     eax, eax
	mov     dword [esp+0x38], 0
	add     esp, 16
	rep stosd
	test    ebx, ebx
	je      loc_047
	push    0
	push    ebp
	push    dword [esp+0x10]
	push    ebx
	call    graph_add_package
	add     esp, 16
	test    esi, esi
	je      loc_044
	cmp     byte [esi], 0
	je      loc_044
	sub     esp, 8
	push    loc_085
	push    esi
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_044
	sub     esp, 12
	push    esi
	call    strdup
	mov     dword [esp+0x3C], 0
	add     esp, 16
	test    eax, eax
	je      loc_044
	sub     esp, 4
	lea     ebp, [esp+0x30]
	push    ebp
	push    loc_091
	push    eax
	mov     dword [esp+0x1C], eax
	call    strtok_r
	add     esp, 16
	mov     edx, dword [esp+0x0C]
	test    eax, eax
	lea     edi, [esp+0x30]
	je      loc_043
	mov     esi, edx
	jmp     loc_032

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_031:  sub     esp, 4
	push    ebp
	push    loc_091
	push    0
	call    strtok_r
	add     esp, 16
	test    eax, eax
	je      loc_042
loc_032:  sub     esp, 4
	push    160
	push    edi
	push    eax
	call    dep_basename
	add     esp, 16
	cmp     byte [esp+0x30], 0
	jz      loc_031
	sub     esp, 12
	push    edi
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jz      loc_031
	sub     esp, 8
	push    edi
	push    ebx
	call    graph_has_package
	add     esp, 16
	test    eax, eax
	je      loc_056
loc_033:  sub     esp, 4
	push    edi
	push    dword [esp+0x10]
	push    ebx
	call    graph_add_dependency
	add     esp, 16
	jmp     loc_031

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_034:  add     eax, 1
loc_035:  movzx   ecx, byte [eax]
	cmp     cl, 32
	jz      loc_034
	cmp     cl, 9
	jz      loc_034
	test    esi, esi
	jnz     loc_037
	jmp     loc_018

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_036:  add     esi, 1
loc_037:  movzx   ecx, byte [esi]
	cmp     cl, 32
	jz      loc_036
	cmp     cl, 9
	jz      loc_036
	mov     edi, dword [esp+0x0C]
	test    edi, edi
	jne     loc_019
	jmp     loc_021

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_038:  sub     esp, 4
	push    10
	push    loc_080
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jz      loc_040
	sub     esp, 4
	push    13
	push    loc_081
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jne     loc_053
	lea     eax, [ebx+0x1]
	mov     dword [esp+0x0C], eax
	jmp     loc_009

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_039:  sub     esp, 12
	push    edi
	call    free
	add     esp, 16
	jmp     loc_006

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_040:  lea     eax, [ebx+0x1]
	mov     dword [esp+0x18], eax
	jmp     loc_009

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_041:  mov     eax, loc_075
	jmp     loc_026

loc_042:  mov     edx, esi
loc_043:  sub     esp, 12
	push    edx
	call    free
	add     esp, 16
loc_044:  sub     esp, 12
	push    256
	lea     eax, [esp+0x0E0]
	push    eax
	lea     eax, [esp+0x3C]
	push    eax
	lea     eax, [esp+0x3C]
	push    eax
	push    ebx
	call    graph_topological_order
	add     esp, 32
	test    eax, eax
	je      loc_055
	mov     eax, dword [esp+0x28]
	xor     esi, esi
	test    eax, eax
	jz      loc_046
; Filling space: 0x0B
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16
loc_045:  sub     esp, 8
	mov     eax, dword [esp+0x2C]
	push    dword [eax+esi*4]
	add     esi, 1
	push    ebx
	call    graph_package_name
	add     esp, 12
	push    eax
	push    esi
	push    loc_092
	call    printf
	add     esp, 16
	cmp     esi, dword [esp+0x28]
	jc      loc_045
loc_046:  sub     esp, 12
	push    dword [esp+0x30]
	call    free
	mov     dword [esp], ebx
	call    graph_destroy
	add     esp, 16
loc_047:  sub     esp, 12
	push    dword [esp+0x2C]
	call    free
	add     esp, 16
	mov     eax, 1
	add     esp, 1308
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_048:  mov     dword [esp+0x0C], loc_076
	jmp     loc_030

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_049:  mov     dword [esp+0x10], loc_076
	jmp     loc_029

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_050:  mov     edx, loc_076
	jmp     loc_028

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_051:  mov     ecx, dword [esp+0x10]
	jmp     loc_024

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_052:  mov     ecx, dword [esp+0x0C]
	jmp     loc_020

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_053:  sub     esp, 4
	push    9
	push    loc_082
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jz      loc_054
	sub     esp, 4
	push    10
	push    loc_083
	push    edi
	call    strncmp
	add     esp, 16
	test    eax, eax
	jz      loc_054
	sub     esp, 4
	push    10
	push    loc_084
	push    edi
	call    strncmp
	add     esp, 16
	lea     ecx, [ebx+0x1]
	test    eax, eax
	cmovne  ecx, dword [esp+0x10]
	mov     dword [esp+0x10], ecx
	jmp     loc_009

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_054:  lea     eax, [ebx+0x1]
	mov     dword [esp+0x1C], eax
	jmp     loc_009

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_055:  sub     esp, 8
	push    dword [esp+0x10]
	push    loc_093
	call    printf
	add     esp, 16
	jmp     loc_046

loc_056:
	push    0
	push    loc_074
	push    edi
	push    ebx
	call    graph_add_package
	add     esp, 16
	jmp     loc_033

	nop

ALIGN   16
print_dep_list:
	push    edi
	mov     edi, edx
	push    esi
	mov     esi, ecx
	push    ebx
	sub     esp, 8
	push    eax
	push    loc_095
	call    printf
	add     esp, 16
	test    esi, esi
	jz      loc_059
	mov     edx, dword [edi]
	xor     ebx, ebx
	mov     eax, loc_074
	jmp     loc_058

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_057:  mov     edx, dword [edi+ebx*4]
	mov     eax, loc_094
loc_058:  sub     esp, 4
	add     ebx, 1
	push    edx
	push    eax
	push    loc_096
	call    printf
	add     esp, 16
	cmp     esi, ebx
	jnz     loc_057
	sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	add     esp, 16
	pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_059:  sub     esp, 12
	push    loc_076
	call    puts
	add     esp, 16
	pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16

plan_from_aur:
	push    ebp
	mov     ecx, 64
	push    edi
	push    esi
	push    ebx
	mov     ebx, eax
	sub     esp, 300
	mov     dword [esp+0x0C], eax
	lea     edi, [esp+0x20]
	xor     eax, eax
	mov     dword [esp+0x18], 0
	rep stosd
	mov     dword [esp+0x1C], 0
	mov     dword [esp+0x10], 0
	mov     dword [esp+0x14], 0
	call    config_current
	sub     esp, 12
	push    256
	add     eax, 16
	lea     edi, [esp+0x30]
	push    edi
	lea     edi, [esp+0x2C]
	push    edi
	push    ebx
	push    eax
	call    aur_rpc_info
	add     esp, 32
	test    eax, eax
	jz      loc_060
	mov     eax, dword [esp+0x1C]
	test    eax, eax
	jnz     loc_061
loc_060:  sub     esp, 12
	xor     esi, esi
	lea     eax, [esp+0x24]
	push    eax
	call    aur_response_destroy
	add     esp, 16
	mov     eax, esi
	add     esp, 300
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_061:  call    graph_create
	mov     ebx, eax
	test    eax, eax
	jz      loc_060
	mov     eax, dword [esp+0x1C]
	test    eax, eax
	je      loc_063
	xor     ebp, ebp
; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_062:  lea     esi, [ebp+ebp*4]
	mov     edx, loc_074
	shl     esi, 4
	add     esi, dword [esp+0x18]
	mov     edi, dword [esi]
	mov     eax, dword [esi+0x8]
	test    edi, edi
	cmove   edi, dword [esp+0x0C]
	test    eax, eax
	push    1
	cmove   eax, edx
	push    eax
	push    edi
	push    ebx
	call    graph_add_package
	mov     eax, dword [esi+0x8]
	add     esp, 12
	mov     edx, loc_074
	test    eax, eax
	cmove   eax, edx
	add     ebp, 1
	push    eax
	push    edi
	push    loc_105
	call    printf
	mov     ecx, dword [esi+0x2C]
	mov     edx, dword [esi+0x28]
	mov     eax, loc_086
	call    print_dep_list
	mov     ecx, dword [esi+0x34]
	mov     edx, dword [esi+0x30]
	mov     eax, loc_088
	call    print_dep_list
	mov     ecx, dword [esi+0x3C]
	mov     edx, dword [esi+0x38]
	mov     eax, loc_089
	call    print_dep_list
	pop     eax
	mov     ecx, dword [esi+0x28]
	push    dword [esi+0x2C]
	mov     edx, edi
	mov     eax, ebx
	call    add_dep_nodes
	pop     eax
	mov     ecx, dword [esi+0x30]
	push    dword [esi+0x34]
	mov     edx, edi
	mov     eax, ebx
	call    add_dep_nodes
	pop     eax
	mov     ecx, dword [esi+0x38]
	push    dword [esi+0x3C]
	mov     edx, edi
	mov     eax, ebx
	call    add_dep_nodes
	add     esp, 16
	cmp     ebp, dword [esp+0x1C]
	jc      loc_062
loc_063:  sub     esp, 12
	push    loc_104
	call    printf
	lea     eax, [esp+0x30]
	mov     dword [esp], 256
	push    eax
	lea     eax, [esp+0x28]
	push    eax
	lea     eax, [esp+0x28]
	push    eax
	push    ebx
	call    graph_topological_order
	add     esp, 32
	mov     esi, eax
	test    eax, eax
	je      loc_069
	mov     ecx, dword [esp+0x14]
	xor     esi, esi
	test    ecx, ecx
	je      loc_067
; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_064:  sub     esp, 8
	mov     eax, dword [esp+0x18]
	push    dword [eax+esi*4]
	push    ebx
	call    graph_package_name
	pop     edx
	pop     ecx
	mov     edi, eax
	mov     eax, dword [esp+0x18]
	push    dword [eax+esi*4]
	push    ebx
	call    graph_package_version
	mov     ebp, eax
	pop     eax
	pop     edx
	mov     eax, dword [esp+0x18]
	push    dword [eax+esi*4]
	push    ebx
	call    graph_package_source
	add     esp, 16
	mov     edx, loc_097
	cmp     eax, 1
	mov     eax, loc_098
	cmovne  edx, eax
	test    ebp, ebp
	jz      loc_065
	cmp     byte [ebp], 0
	mov     eax, loc_099
	jnz     loc_066
loc_065:  mov     ebp, loc_074
	mov     eax, ebp
loc_066:  test    edi, edi
	mov     ecx, loc_100
	cmove   edi, ecx
	sub     esp, 8
	add     esi, 1
	push    edx
	push    ebp
	push    eax
	push    edi
	push    esi
	push    loc_101
	call    printf
	add     esp, 32
	cmp     esi, dword [esp+0x14]
	jc      loc_064
loc_067:  mov     esi, 1
loc_068:  sub     esp, 12
	push    dword [esp+0x1C]
	call    free
	mov     dword [esp], ebx
	call    graph_destroy
	pop     eax
	lea     eax, [esp+0x24]
	push    eax
	call    aur_response_destroy
	add     esp, 16
	mov     eax, esi
	add     esp, 300
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_069:  sub     esp, 4
	lea     eax, [esp+0x24]
	push    eax
	push    loc_102
	push    dword [stderr]
	call    fprintf
	add     esp, 16
	jmp     loc_068

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8

cmd_dependency_plan_v2:; Function begin
	push    ebx
	sub     esp, 20
	mov     ebx, dword [esp+0x1C]
	push    ebx
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jnz     loc_071
	test    ebx, ebx
	mov     eax, loc_074
	cmove   ebx, eax
	sub     esp, 4
	push    ebx
	push    loc_106
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_070:  add     esp, 8
	xor     eax, eax
	pop     ebx
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_071:  mov     eax, ebx
	call    plan_from_repo
	test    eax, eax
	jnz     loc_072
	mov     eax, ebx
	call    plan_from_aur
	test    eax, eax
	jz      loc_073
loc_072:  add     esp, 8
	mov     eax, 1
	pop     ebx
	ret

loc_073:
	sub     esp, 4
	push    ebx
	push    loc_107
	push    dword [stderr]
	call    fprintf
	add     esp, 16
	jmp     loc_070

SECTION .rodata.str1.1 align=1 noexec

loc_074:
	db 0x00

loc_075:
	db 0x72, 0x65, 0x70, 0x6F, 0x00

loc_076:
	db 0x28, 0x6E, 0x6F, 0x6E, 0x65, 0x29, 0x00

loc_077:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

loc_078:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00

loc_079:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x00

loc_080:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x20
	db 0x4F, 0x6E, 0x00

loc_081:
	db 0x4F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C
	db 0x20, 0x44, 0x65, 0x70, 0x73, 0x00

loc_082:
	db 0x4D, 0x61, 0x6B, 0x65, 0x20, 0x44, 0x65, 0x70
	db 0x73, 0x00

loc_083:
	db 0x42, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x00

loc_084:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x00

loc_085:
	db 0x4E, 0x6F, 0x6E, 0x65, 0x00

loc_086:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x3A
	db 0x00

loc_087:
	db 0x20, 0x20, 0x25, 0x2D, 0x31, 0x34, 0x73, 0x25
	db 0x73, 0x0A, 0x00

loc_088:
	db 0x4D, 0x61, 0x6B, 0x65, 0x44, 0x65, 0x70, 0x65
	db 0x6E, 0x64, 0x73, 0x3A, 0x00

loc_089:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x44, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x73, 0x3A, 0x00

loc_090:
	db 0x4F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C
	db 0x3A, 0x00

loc_091:
	db 0x20, 0x09, 0x00

loc_092:
	db 0x20, 0x20, 0x25, 0x7A, 0x75, 0x2E, 0x20, 0x25
	db 0x73, 0x0A, 0x00

loc_093:
	db 0x20, 0x20, 0x31, 0x2E, 0x20, 0x25, 0x73, 0x0A
	db 0x00

loc_094:
	db 0x20, 0x20, 0x00

loc_095:
	db 0x20, 0x20, 0x25, 0x2D, 0x31, 0x34, 0x73, 0x00

loc_096:
	db 0x25, 0x73, 0x25, 0x73, 0x00

loc_097:
	db 0x61, 0x75, 0x72, 0x00

loc_098:
	db 0x72, 0x65, 0x70, 0x6F, 0x2F, 0x64, 0x65, 0x70
	db 0x00

loc_099:
	db 0x20, 0x00

loc_100:
	db 0x3F, 0x00

loc_101:
	db 0x20, 0x20, 0x25, 0x7A, 0x75, 0x2E, 0x20, 0x25
	db 0x73, 0x25, 0x73, 0x25, 0x73, 0x20, 0x20, 0x5B
	db 0x25, 0x73, 0x5D, 0x0A, 0x00

loc_102:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x25, 0x73, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_103:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x50
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x3A, 0x20
	db 0x25, 0x73, 0x20, 0x25, 0x73, 0x20, 0x28, 0x25
	db 0x73, 0x29, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

loc_104:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x49
	db 0x6E, 0x73, 0x74, 0x61, 0x6C, 0x6C, 0x20, 0x6F
	db 0x72, 0x64, 0x65, 0x72, 0x20, 0x28, 0x64, 0x65
	db 0x70, 0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x79
	db 0x2D, 0x66, 0x69, 0x72, 0x73, 0x74, 0x29, 0x3A
	db 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00, 0x00, 0x00

loc_105:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x50
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x3A, 0x20
	db 0x25, 0x73, 0x20, 0x25, 0x73, 0x20, 0x28, 0x61
	db 0x75, 0x72, 0x29, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00, 0x00, 0x00, 0x00

loc_106:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00

loc_107:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x43, 0x6F, 0x75, 0x6C, 0x64
	db 0x20, 0x6E, 0x6F, 0x74, 0x20, 0x72, 0x65, 0x73
	db 0x6F, 0x6C, 0x76, 0x65, 0x20, 0x64, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x69, 0x65
	db 0x73, 0x20, 0x66, 0x6F, 0x72, 0x20, 0x27, 0x25
	db 0x73, 0x27, 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00

