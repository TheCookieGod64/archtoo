; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  provider.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 provider.asm -o provider.o
; ---------------------------------------------------------

global cmd_provider_v2: function

extern aur_response_destroy
extern aur_rpc_info
extern config_current
extern fprintf
extern stderr
extern dep_basename
extern strtok_r
extern strstr
extern printf
extern strcmp
extern strdup
extern valid_pkgname
extern free
extern strlen
extern strchr
extern run_cmd_capture
extern xsnprintf
extern shell_quote
extern memcpy
extern malloc
extern __ctype_b_loc

SECTION .text   align=32 exec

trim_copy:
	push    edi
	push    esi
	mov     esi, eax
	push    ebx
	test    edx, edx
	jz      loc_005
	mov     ebx, edx
	call    __ctype_b_loc
	mov     edx, dword [eax]
	jmp     loc_002

; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_001:  add     esi, 1
	sub     ebx, 1
	jz      loc_005
loc_002:  movzx   eax, byte [esi]
	test    byte [edx+eax*2+0x1], 0x20
	jnz     loc_001
	jmp     loc_004

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_003:  mov     ebx, ecx
loc_004:  test    ebx, ebx
	jz      loc_008
	call    __ctype_b_loc
	movzx   edx, byte [esi+ebx-0x1]
	lea     ecx, [ebx-0x1]
	mov     eax, dword [eax]
	test    byte [eax+edx*2+0x1], 0x20
	jnz     loc_003
	lea     eax, [ebx+0x1]
	jmp     loc_006

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_005:  xor     ebx, ebx
	mov     eax, 1
loc_006:  sub     esp, 12
	push    eax
	call    malloc
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	jz      loc_007
	sub     esp, 4
	push    ebx
	push    esi
	push    eax
	call    memcpy
	mov     byte [edi+ebx], 0
	add     esp, 16
loc_007:  mov     eax, edi
	pop     ebx
	pop     esi
	pop     edi
	ret

loc_008:
	mov     eax, 1
	jmp     loc_006

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

print_repo_providers:
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 5120
	mov     dword [esp+0x0C], eax
	mov     dword [esp+0x28], 0
	mov     dword [esp+0x2C], 0
	push    320
	lea     ebx, [esp+0x178]
	push    ebx
	push    eax
	call    shell_quote
	add     esp, 16
	test    eax, eax
	jnz     loc_010
loc_009:  add     esp, 5116
	xor     ebx, ebx
	mov     eax, ebx
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_010:  push    ebx
	push    loc_080
	push    4096
	lea     eax, [esp+0x3FC]
	push    eax
	call    xsnprintf
	pop     ebx
	pop     esi
	lea     eax, [esp+0x2C]
	push    eax
	lea     eax, [esp+0x3FC]
	push    eax
	call    run_cmd_capture
	mov     ebp, dword [esp+0x34]
	add     esp, 16
	test    ebp, ebp
	jz      loc_009
	xor     esi, esi
	cmp     byte [ebp], 0
	je      loc_058
; Filling space: 0x0D
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_011:  sub     esp, 8
	push    10
	push    ebp
	call    strchr
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	jz      loc_014
	mov     ebx, eax
	sub     ebx, ebp
	lea     eax, [ebx-0x1]
	cmp     eax, 158
	jbe     loc_023
loc_012:  cmp     byte [edi+0x1], 0
	lea     ebp, [edi+0x1]
	jz      loc_015
	mov     ebx, esi
loc_013:  mov     esi, ebx
	jmp     loc_011

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_014:  sub     esp, 12
	push    ebp
	call    strlen
	add     esp, 16
	mov     ebx, eax
	lea     eax, [eax-0x1]
	cmp     eax, 158
	jbe     loc_022
loc_015:  mov     ebx, esi
loc_016:  sub     esp, 12
	push    dword [esp+0x30]
	call    free
	add     esp, 16
	test    ebx, ebx
	je      loc_009
loc_017:  lea     edi, [esp+0x30]
	mov     ecx, 45
	mov     dword [esp+0x3F0], 1835229552
	mov     esi, 13
	lea     eax, [edi+ebx*4]
	mov     dword [esp+0x0C], edi
	mov     ebx, edi
	lea     ebp, [esp+0x2B0]
	mov     dword [esp+0x3F4], 757100129
	mov     dword [esp+0x3F8], 757098835
	mov     word [esp+0x3FC], cx
	mov     dword [esp], eax
	jmp     loc_021

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_018:  test    ecx, ecx
	jz      loc_019
	movzx   eax, byte [ebp]
	mov     byte [edx], al
	test    cl, 0x02
	jne     loc_053
loc_019:  mov     eax, dword [esp+0x4]
	mov     byte [esp+eax+0x3F0], 0
	mov     esi, eax
loc_020:  add     ebx, 4
	cmp     dword [esp], ebx
	je      loc_024
loc_021:  mov     eax, dword [ebx]
	test    eax, eax
	jz      loc_020
	sub     esp, 4
	push    320
	push    ebp
	push    eax
	call    shell_quote
	add     esp, 16
	test    eax, eax
	jz      loc_020
	sub     esp, 12
	push    ebp
	call    strlen
	lea     edx, [esi+0x1]
	add     esp, 16
	mov     ecx, eax
	lea     eax, [eax+edx]
	mov     dword [esp+0x4], eax
	cmp     eax, 4095
	ja      loc_024
	lea     eax, [esp+0x3F0]
	mov     byte [esp+esi+0x3F0], 32
	add     edx, eax
	cmp     ecx, 4
	jc      loc_018
	mov     esi, dword [ebp]
	lea     edi, [edx+0x4]
	and     edi, 0x0FFFFFFFC
	mov     dword [edx], esi
	mov     esi, dword [ebp+ecx-0x4]
	mov     dword [edx+ecx-0x4], esi
	sub     edx, edi
	mov     esi, ebp
	add     ecx, edx
	sub     esi, edx
	shr     ecx, 2
	rep movsd
	jmp     loc_019

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_022:  lea     edi, [esp+0x2B0]
	sub     esp, 4
	push    ebx
	push    ebp
	push    edi
	call    memcpy
	mov     byte [esp+ebx+0x2C0], 0
	mov     dword [esp], edi
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	je      loc_015
	sub     esp, 12
	lea     ebx, [esi+0x1]
	push    edi
	call    strdup
	mov     dword [esp+esi*4+0x40], eax
	pop     eax
	push    dword [esp+0x30]
	call    free
	add     esp, 16
	jmp     loc_017

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_023:  sub     esp, 4
	push    ebx
	push    ebp
	lea     eax, [esp+0x2BC]
	push    eax
	call    memcpy
	mov     byte [esp+ebx+0x2C0], 0
	pop     edx
	lea     eax, [esp+0x2BC]
	push    eax
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	je      loc_012
	sub     esp, 12
	lea     ebx, [esi+0x1]
	lea     ebp, [edi+0x1]
	lea     eax, [esp+0x2BC]
	push    eax
	call    strdup
	mov     dword [esp+esi*4+0x40], eax
	add     esp, 16
	cmp     byte [edi+0x1], 0
	je      loc_016
	cmp     ebx, 80
	jne     loc_013
	sub     esp, 12
	push    dword [esp+0x30]
	call    free
	add     esp, 16
	jmp     loc_017

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_024:  mov     edi, dword [esp+0x0C]
	sub     esp, 8
	lea     eax, [esp+0x30]
	push    eax
	lea     eax, [esp+0x3FC]
	push    eax
	call    run_cmd_capture
	mov     ebp, dword [esp+0x38]
	add     esp, 16
	mov     ebx, eax
	test    eax, eax
	jz      loc_027
	xor     ebx, ebx
loc_025:  sub     esp, 12
	push    ebp
	call    free
	mov     esi, dword [esp+0x10]
	add     esp, 16
; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_026:  sub     esp, 12
	push    dword [edi]
	add     edi, 4
	call    free
	add     esp, 16
	cmp     esi, edi
	jnz     loc_026
	add     esp, 5116
	mov     eax, ebx
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_027:  test    ebp, ebp
	jz      loc_025
	cmp     byte [ebp], 0
	jz      loc_025
	mov     dword [esp+0x18], 0
	mov     dword [esp+0x1C], edi
	jmp     loc_036

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_028:  test    al, al
	je      loc_035
	sub     esp, 8
	push    58
	push    dword [esp+0x18]
	call    strchr
	add     esp, 16
	mov     ebp, eax
	cmp     eax, ebx
	jnc     loc_035
	mov     dword [esp+0x4], 0
	test    eax, eax
	je      loc_035
loc_029:  sub     esp, 8
	lea     ebx, [ebp+0x1]
	push    10
	push    ebp
	call    strchr
	add     esp, 16
	test    eax, eax
	je      loc_054
	sub     eax, ebp
	lea     edx, [eax-0x1]
loc_030:  mov     eax, ebx
	call    trim_copy
	mov     ebp, eax
	test    eax, eax
	jz      loc_031
	sub     esp, 8
	push    loc_086
	push    eax
	call    strcmp
	add     esp, 16
	test    eax, eax
	jne     loc_059
loc_031:  sub     esp, 12
	push    ebp
	call    free
	add     esp, 16
	test    edi, edi
	jz      loc_035
	mov     ebp, dword [esp+0x4]
	test    ebp, ebp
	jz      loc_035
loc_032:  mov     edx, loc_076
loc_033:  mov     eax, dword [esp+0x10]
	mov     ebx, dword [esp+0x14]
	mov     ecx, loc_078
	test    eax, eax
	cmovne  ecx, eax
	mov     eax, loc_079
	test    ebx, ebx
	jz      loc_034
	cmp     byte [ebx], 0
	cmovne  eax, ebx
loc_034:  sub     esp, 12
	push    edx
	push    ecx
	push    edi
	push    eax
	push    loc_088
	call    printf
	add     esp, 32
	mov     dword [esp+0x18], 1
loc_035:  sub     esp, 12
	push    edi
	call    free
	pop     ecx
	push    dword [esp+0x1C]
	call    free
	pop     ebx
	push    dword [esp+0x20]
	call    free
	add     esp, 16
	test    esi, esi
	je      loc_052
	cmp     byte [esi+0x1], 0
	lea     ebp, [esi+0x1]
	je      loc_052
loc_036:  sub     esp, 8
	push    loc_081
	push    ebp
	call    strstr
	add     esp, 16
	mov     esi, eax
	cmp     eax, ebp
	je      loc_050
	mov     ebx, esi
	test    esi, esi
	je      loc_051
loc_037:  sub     esp, 8
	push    loc_082
	push    ebp
	call    strstr
	pop     edx
	pop     ecx
	mov     dword [esp+0x18], eax
	push    loc_083
	push    ebp
	call    strstr
	pop     edi
	pop     edx
	push    loc_084
	push    ebp
	mov     edi, eax
	call    strstr
	pop     ecx
	pop     edx
	mov     dword [esp+0x0C], eax
	push    loc_085
	push    ebp
	call    strstr
	mov     edx, dword [esp+0x20]
	add     esp, 16
	mov     dword [esp+0x0C], eax
	test    edx, edx
	je      loc_046
	cmp     edx, ebx
	jnc     loc_046
	sub     esp, 8
	push    58
	push    edx
	call    strchr
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	je      loc_046
	cmp     eax, ebx
	jnc     loc_046
	sub     esp, 8
	push    10
	push    eax
	call    strchr
	add     esp, 16
	lea     ecx, [ebp+0x1]
	test    eax, eax
	je      loc_055
	sub     eax, ebp
	lea     edx, [eax-0x1]
loc_038:  mov     eax, ecx
	call    trim_copy
	mov     dword [esp+0x14], eax
loc_039:  mov     eax, dword [esp+0x4]
	cmp     eax, ebx
	setb    dl
	test    eax, eax
	setne   al
	and     edx, eax
	mov     ebp, edx
	test    edi, edi
	je      loc_043
	cmp     edi, ebx
	jnc     loc_043
	sub     esp, 8
	push    58
	push    edi
	call    strchr
	add     esp, 16
	mov     edi, eax
	test    eax, eax
	je      loc_043
	cmp     eax, ebx
	jnc     loc_043
	sub     esp, 8
	push    10
	push    eax
	call    strchr
	add     esp, 16
	lea     ecx, [edi+0x1]
	test    eax, eax
	je      loc_057
	sub     eax, edi
	lea     edx, [eax-0x1]
loc_040:  mov     eax, ecx
	call    trim_copy
	mov     dword [esp+0x10], 0
	mov     edi, eax
	mov     eax, ebp
	test    al, al
	jz      loc_042
	sub     esp, 8
	push    58
	push    dword [esp+0x10]
	call    strchr
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	jz      loc_041
	cmp     eax, ebx
	jc      loc_044
loc_041:  mov     dword [esp+0x10], 0
loc_042:  mov     eax, dword [esp+0x0C]
	cmp     eax, ebx
	setb    dl
	test    eax, eax
	setne   al
	and     edx, eax
	mov     ebp, edx
	test    edi, edi
	je      loc_048
	sub     esp, 8
	push    dword [esp+0x10]
	push    edi
	call    strcmp
	add     esp, 16
	test    eax, eax
	mov     eax, ebp
	jne     loc_028
	test    al, al
	je      loc_032
	sub     esp, 8
	push    58
	push    dword [esp+0x18]
	call    strchr
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	je      loc_032
	mov     dword [esp+0x4], 1
	cmp     eax, ebx
	jc      loc_029
	jmp     loc_032

loc_043:  mov     eax, ebp
	test    al, al
	jz      loc_047
	sub     esp, 8
	push    58
	push    dword [esp+0x10]
	call    strchr
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	jz      loc_047
	cmp     eax, ebx
	jnc     loc_047
	xor     edi, edi
loc_044:  sub     esp, 8
	push    10
	push    ebp
	call    strchr
	add     esp, 16
	lea     ecx, [ebp+0x1]
	test    eax, eax
	je      loc_056
	sub     eax, ebp
	lea     edx, [eax-0x1]
loc_045:  mov     eax, ecx
	call    trim_copy
	mov     dword [esp+0x10], eax
	jmp     loc_042

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_046:  mov     dword [esp+0x14], 0
	jmp     loc_039

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_047:  mov     dword [esp+0x10], 0
loc_048:  mov     eax, dword [esp+0x0C]
	test    eax, eax
	jz      loc_049
	cmp     eax, ebx
	jnc     loc_049
	sub     esp, 8
	push    58
	push    dword [esp+0x18]
	call    strchr
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	jz      loc_049
	mov     dword [esp+0x4], 0
	xor     edi, edi
	cmp     eax, ebx
	jc      loc_029
; Filling space: 0x0B
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16
loc_049:  xor     edi, edi
	jmp     loc_035

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_050:  sub     esp, 8
	lea     eax, [ebp+0x1]
	push    loc_081
	push    eax
	call    strstr
	add     esp, 16
	mov     esi, eax
	mov     ebx, esi
	test    esi, esi
	jne     loc_037
loc_051:  sub     esp, 12
	push    ebp
	call    strlen
	add     esp, 16
	lea     ebx, [ebp+eax]
	jmp     loc_037

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_052:  mov     edi, dword [esp+0x1C]
	mov     ebp, dword [esp+0x28]
	mov     ebx, dword [esp+0x18]
	jmp     loc_025

loc_053:  movzx   esi, word [ebp+ecx-0x2]
	mov     word [edx+ecx-0x2], si
	jmp     loc_019

loc_054:  sub     esp, 12
	push    ebx
	call    strlen
	add     esp, 16
	mov     edx, eax
	jmp     loc_030

loc_055:  sub     esp, 12
	push    ecx
	mov     dword [esp+0x20], ecx
	call    strlen
	add     esp, 16
	mov     ecx, dword [esp+0x10]
	mov     edx, eax
	jmp     loc_038

loc_056:  sub     esp, 12
	push    ecx
	mov     dword [esp+0x14], ecx
	call    strlen
	add     esp, 16
	mov     ecx, dword [esp+0x4]
	mov     edx, eax
	jmp     loc_045

loc_057:  sub     esp, 12
	push    ecx
	mov     dword [esp+0x20], ecx
	call    strlen
	add     esp, 16
	mov     ecx, dword [esp+0x10]
	mov     edx, eax
	jmp     loc_040

loc_058:  sub     esp, 12
	push    ebp
	call    free
	add     esp, 16
	jmp     loc_009

loc_059:
	mov     dword [esp+0x2C], 0
	sub     esp, 4
	lea     eax, [esp+0x30]
	push    eax
	push    loc_087
	push    ebp
	call    strtok_r
	add     esp, 16
	test    eax, eax
	je      loc_031
	lea     ebx, [esp+0x2B0]
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_060:  sub     esp, 4
	push    256
	push    ebx
	push    eax
	call    dep_basename
	add     esp, 16
	cmp     byte [esp+0x2B0], 0
	jz      loc_061
	sub     esp, 8
	push    dword [esp+0x10]
	push    ebx
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_061
	sub     esp, 12
	push    ebp
	call    free
	add     esp, 16
	test    edi, edi
	je      loc_035
	mov     eax, dword [esp+0x4]
	test    eax, eax
	jne     loc_032
	mov     edx, loc_077
	jmp     loc_033

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_061:  sub     esp, 4
	lea     eax, [esp+0x30]
	push    eax
	push    loc_087
	push    0
	call    strtok_r
	add     esp, 16
	test    eax, eax
	jnz     loc_060
	jmp     loc_031

cmd_provider_v2:; Function begin
	push    ebp
	xor     eax, eax
	mov     ecx, 64
	push    edi
	push    esi
	push    ebx
	sub     esp, 556
	mov     esi, dword [esp+0x240]
	lea     ebx, [esp+0x20]
	mov     dword [esp+0x18], 0
	sub     esp, 12
	mov     edi, ebx
	mov     dword [esp+0x28], 0
	rep stosd
	push    esi
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jnz     loc_064
	test    esi, esi
	mov     eax, loc_078
	cmove   esi, eax
	sub     esp, 4
	push    esi
	push    loc_091
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_062:  mov     dword [esp+0x0C], 0
loc_063:  mov     eax, dword [esp+0x0C]
	add     esp, 556
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_064:  sub     esp, 8
	push    esi
	push    loc_092
	call    printf
	mov     eax, esi
	call    print_repo_providers
	mov     dword [esp+0x1C], eax
	call    config_current
	mov     dword [esp], 256
	push    ebx
	add     eax, 16
	lea     edx, [esp+0x2C]
	push    edx
	push    esi
	push    eax
	call    aur_rpc_info
	add     esp, 32
	test    eax, eax
	je      loc_074
	mov     ecx, dword [esp+0x1C]
	test    ecx, ecx
	je      loc_074
	mov     dword [esp+0x4], 0
	jmp     loc_068

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_065:  sub     esp, 8
	push    esi
	push    ebx
	call    strcmp
	add     esp, 16
	test    eax, eax
	jne     loc_071
	mov     edx, dword [esp+0x8]
	mov     eax, loc_077
	test    edx, edx
	jne     loc_073
loc_066:  mov     ebx, dword [ebp+0x8]
	mov     edx, loc_078
	mov     ecx, loc_089
	test    ebx, ebx
	cmove   ebx, edx
	mov     edx, dword [ebp]
	push    eax
	test    edx, edx
	push    ebx
	cmove   edx, ecx
	push    edx
	push    loc_090
	call    printf
	add     esp, 16
	mov     dword [esp+0x0C], 1
loc_067:  add     dword [esp+0x4], 1
	mov     eax, dword [esp+0x4]
	cmp     eax, dword [esp+0x1C]
	jnc     loc_074
loc_068:  mov     eax, dword [esp+0x4]
	lea     ecx, [eax+eax*4]
	shl     ecx, 4
	add     ecx, dword [esp+0x18]
	mov     eax, dword [ecx]
	mov     ebx, dword [ecx+0x44]
	mov     ebp, ecx
	test    eax, eax
	je      loc_075
	sub     esp, 8
	push    esi
	push    eax
	call    strcmp
	add     esp, 16
	test    eax, eax
	sete    al
	movzx   eax, al
	mov     dword [esp+0x8], eax
	test    ebx, ebx
	jz      loc_072
loc_069:  xor     edi, edi
	lea     ebx, [esp+0x120]
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_070:  mov     eax, dword [ebp+0x40]
	sub     esp, 4
	push    256
	push    ebx
	push    dword [eax+edi*4]
	call    dep_basename
	add     esp, 16
	cmp     byte [esp+0x120], 0
	jne     loc_065
loc_071:  add     edi, 1
	cmp     edi, dword [ebp+0x44]
	jc      loc_070
loc_072:  cmp     dword [esp+0x8], 0
	je      loc_067
; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_073:  mov     eax, loc_076
	jmp     loc_066

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_074:  sub     esp, 12
	lea     eax, [esp+0x24]
	push    eax
	call    aur_response_destroy
	mov     eax, dword [esp+0x1C]
	add     esp, 16
	test    eax, eax
	jne     loc_063
	sub     esp, 4
	push    esi
	push    loc_093
	push    dword [stderr]
	call    fprintf
	add     esp, 16
	jmp     loc_062

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_075:  mov     dword [esp+0x8], 0
	test    ebx, ebx
	jne     loc_069
	jmp     loc_067

SECTION .rodata.str1.1 align=1 noexec

loc_076:
	db 0x28, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65
	db 0x29, 0x00

loc_077:
	db 0x28, 0x70, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65
	db 0x73, 0x29, 0x00

loc_078:
	db 0x00

loc_079:
	db 0x72, 0x65, 0x70, 0x6F, 0x00

loc_080:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x73, 0x71, 0x20, 0x2D, 0x2D, 0x20, 0x25
	db 0x73, 0x00

loc_081:
	db 0x0A, 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74
	db 0x6F, 0x72, 0x79, 0x00

loc_082:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x00

loc_083:
	db 0x0A, 0x4E, 0x61, 0x6D, 0x65, 0x00

loc_084:
	db 0x0A, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E
	db 0x00

loc_085:
	db 0x0A, 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65
	db 0x73, 0x00

loc_086:
	db 0x4E, 0x6F, 0x6E, 0x65, 0x00

loc_087:
	db 0x20, 0x09, 0x00

loc_088:
	db 0x25, 0x73, 0x2F, 0x25, 0x73, 0x20, 0x25, 0x73
	db 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_089:
	db 0x3F, 0x00

loc_090:
	db 0x61, 0x75, 0x72, 0x2F, 0x25, 0x73, 0x20, 0x25
	db 0x73, 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_091:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00

loc_092:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x50, 0x72, 0x6F, 0x76, 0x69
	db 0x64, 0x65, 0x72, 0x73, 0x20, 0x6F, 0x66, 0x20
	db 0x25, 0x73, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

loc_093:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x33, 0x6D, 0x5B
	db 0x21, 0x5D, 0x20, 0x4E, 0x6F, 0x20, 0x70, 0x72
	db 0x6F, 0x76, 0x69, 0x64, 0x65, 0x72, 0x73, 0x20
	db 0x66, 0x6F, 0x75, 0x6E, 0x64, 0x20, 0x66, 0x6F
	db 0x72, 0x20, 0x27, 0x25, 0x73, 0x27, 0x2E, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00

