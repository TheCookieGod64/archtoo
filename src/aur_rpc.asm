; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  aur_rpc.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 aur_rpc.asm -o aur_rpc.o
; ---------------------------------------------------------

global aur_response_destroy: function
global aur_rpc_search: function
global aur_rpc_info: function

extern strtod
extern strchr
extern strcmp
extern kill
extern waitpid
extern strerror
extern __errno_location
extern _exit
extern execlp
extern dup2
extern read
extern close
extern fork
extern pipe
extern memcpy
extern strtol
extern strdup
extern strncmp
extern realloc
extern __ctype_b_loc
extern strstr
extern snprintf
extern malloc
extern strlen
extern free

SECTION .text   align=64 exec

package_destroy:
	push    ebp
	push    edi
	push    esi
	mov     esi, eax
	push    ebx
	sub     esp, 88
	push    dword [eax]
	call    free
	pop     eax
	push    dword [esi+0x4]
	call    free
	pop     edx
	push    dword [esi+0x8]
	call    free
	pop     ecx
	push    dword [esi+0x0C]
	call    free
	pop     ebx
	push    dword [esi+0x10]
	call    free
	pop     edi
	push    dword [esi+0x14]
	call    free
	lea     eax, [esi+0x28]
	lea     ebp, [esp+0x28]
	mov     dword [esp+0x28], eax
	lea     eax, [esi+0x30]
	mov     dword [esp+0x2C], eax
	lea     eax, [esi+0x38]
	mov     dword [esp+0x30], eax
	lea     eax, [esi+0x40]
	mov     dword [esp+0x34], eax
	lea     eax, [esi+0x48]
	mov     dword [esp+0x38], eax
	mov     eax, dword [esi+0x2C]
	mov     dword [esp+0x3C], eax
	mov     eax, dword [esi+0x34]
	mov     dword [esp+0x40], eax
	mov     eax, dword [esi+0x3C]
	mov     dword [esp+0x44], eax
	mov     eax, dword [esi+0x44]
	mov     dword [esp+0x48], eax
	mov     eax, dword [esi+0x4C]
	mov     dword [esp+0x4C], eax
	lea     eax, [esp+0x3C]
	mov     dword [esp+0x1C], eax
	add     esp, 16
loc_001:  mov     eax, dword [esp+0x0C]
	xor     edi, edi
	mov     ebx, dword [eax]
	test    ebx, ebx
	jz      loc_003
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_002:  mov     edx, dword [ebp]
	sub     esp, 12
	mov     edx, dword [edx]
	push    dword [edx+edi*4]
	add     edi, 1
	call    free
	add     esp, 16
	cmp     edi, ebx
	jnz     loc_002
loc_003:  mov     eax, dword [ebp]
	sub     esp, 12
	add     ebp, 4
	push    dword [eax]
	call    free
	add     dword [esp+0x1C], 4
	add     esp, 16
	lea     eax, [esp+0x2C]
	cmp     ebp, eax
	jnz     loc_001
	lea     edi, [esi+0x4]
	mov     dword [esi], 0
	xor     eax, eax
	and     edi, 0x0FFFFFFFC
	mov     dword [esi+0x4C], 0
	sub     esi, edi
	lea     ecx, [esi+0x50]
	shr     ecx, 2
	rep stosd
	add     esp, 76
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

parse_json_string:
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 44
	mov     ebx, dword [eax]
	mov     dword [esp+0x14], eax
	cmp     byte [ebx], 34
	jne     loc_010
	sub     esp, 12
	push    ebx
	call    strlen
	add     eax, 1
	mov     dword [esp+0x20], eax
	mov     dword [esp], eax
	call    malloc
	mov     dword [esp+0x1C], eax
	add     esp, 16
	test    eax, eax
	je      loc_010
	lea     edi, [ebx+0x1]
	movzx   ebx, byte [ebx+0x1]
	test    bl, bl
	je      loc_018
	cmp     bl, 34
	je      loc_018
	xor     esi, esi
	jmp     loc_006

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_004:  mov     byte [edx], bl
	mov     esi, ecx
	mov     edi, ebp
loc_005:  movzx   ebx, byte [edi]
	test    bl, bl
	je      loc_016
	cmp     bl, 34
	je      loc_016
loc_006:  mov     eax, dword [esp+0x0C]
	mov     ecx, dword [esp+0x10]
	lea     edx, [eax+esi]
	lea     eax, [esi+0x8]
	cmp     eax, ecx
	jnc     loc_013
	lea     ebp, [edi+0x1]
	lea     ecx, [esi+0x1]
	cmp     bl, 92
	jnz     loc_004
	movzx   ebx, byte [edi+0x1]
	test    bl, bl
	je      loc_017
	lea     ebp, [edi+0x2]
	cmp     bl, 114
	je      loc_012
	jg      loc_007
	cmp     bl, 102
	je      loc_011
	cmp     bl, 110
	jz      loc_008
	cmp     bl, 98
	mov     eax, 8
	cmove   ebx, eax
	jmp     loc_004

loc_007:  cmp     bl, 116
	jz      loc_009
	cmp     bl, 117
	jnz     loc_004
	mov     dword [esp+0x1C], ecx
	sub     esp, 12
	mov     dword [esp+0x24], edx
	push    ebp
	call    strlen
	add     esp, 16
	mov     edx, dword [esp+0x18]
	mov     ecx, dword [esp+0x1C]
	cmp     eax, 3
	jbe     loc_004
	mov     eax, 30044
	add     edi, 6
	mov     word [edx], ax
	mov     edx, dword [esp+0x0C]
	mov     eax, dword [edi-0x4]
	mov     dword [edx+esi+0x2], eax
	add     esi, 6
	jmp     loc_005

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_008:  mov     ebx, 10
	jmp     loc_004

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_009:  mov     ebx, 9
	jmp     loc_004

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_010:  mov     dword [esp+0x0C], 0
	mov     eax, dword [esp+0x0C]
	add     esp, 44
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_011:  mov     ebx, 12
	jmp     loc_004

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_012:  mov     ebx, 13
	jmp     loc_004

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_013:  movzx   ebx, byte [edi]
loc_014:  xor     eax, eax
	cmp     bl, 34
	sete    al
	add     edi, eax
loc_015:  mov     eax, dword [esp+0x14]
	mov     byte [edx], 0
	mov     dword [eax], edi
	mov     eax, dword [esp+0x0C]
	add     esp, 44
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_016:  mov     eax, dword [esp+0x0C]
	lea     edx, [eax+esi]
	jmp     loc_014

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_017:  mov     eax, dword [esp+0x0C]
	mov     byte [edx], 92
	mov     edi, ebp
	lea     edx, [eax+ecx]
	jmp     loc_015

loc_018:
	mov     edx, dword [esp+0x0C]
	jmp     loc_014

; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16

find_key:
	push    edi
	push    esi
	mov     esi, edx
	push    ebx
	mov     ebx, eax
	sub     esp, 96
	push    ecx
	push    loc_137
	push    96
	lea     edi, [esp+0x0C]
	push    edi
	call    snprintf
	mov     esp, edi
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_019:  sub     esp, 8
	push    edi
	push    ebx
	call    strstr
	add     esp, 16
	mov     ebx, eax
	cmp     eax, esi
	jnc     loc_022
	test    eax, eax
	jz      loc_022
	sub     esp, 12
	push    edi
	call    strlen
	add     esp, 16
	add     ebx, eax
	cmp     ebx, esi
	jnc     loc_019
	call    __ctype_b_loc
	mov     edx, dword [eax]
	jmp     loc_021

; Filling space: 0x0E
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_020:  add     ebx, 1
	cmp     esi, ebx
	jz      loc_019
loc_021:  movzx   eax, byte [ebx]
	test    byte [edx+eax*2+0x1], 0x20
	jnz     loc_020
	cmp     ebx, esi
	jnc     loc_019
	cmp     byte [ebx], 58
	jnz     loc_019
	add     esp, 96
	lea     eax, [ebx+0x1]
	pop     ebx
	pop     esi
	pop     edi
	ret

loc_022:
	add     esp, 96
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8

object_array:
	push    ebp
	push    edi
	push    esi
	mov     esi, edx
	push    ebx
	sub     esp, 44
	call    find_key
	mov     ebx, eax
	mov     eax, dword [esp+0x40]
	mov     dword [eax], 0
	mov     eax, dword [esp+0x44]
	mov     dword [eax], 0
	test    ebx, ebx
	je      loc_030
	cmp     ebx, esi
	jnc     loc_037
	call    __ctype_b_loc
	mov     ecx, dword [eax]
	jmp     loc_024

; Filling space: 0x13
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16
loc_023:  lea     eax, [ebx+0x1]
	cmp     eax, esi
	je      loc_035
	mov     ebx, eax
loc_024:  movzx   edx, byte [ebx]
	mov     eax, edx
	test    byte [ecx+edx*2+0x1], 0x20
	jnz     loc_023
loc_025:  cmp     al, 91
	jnz     loc_030
loc_026:  add     ebx, 1
	mov     dword [esp+0x1C], ebx
	cmp     ebx, esi
	jnc     loc_034
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_027:  call    __ctype_b_loc
	mov     ebp, dword [eax]
	xor     eax, eax
	jmp     loc_029

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_028:  mov     dword [esp+0x0C], ebx
loc_029:  movzx   edx, byte [ebx]
	mov     edi, eax
	movzx   eax, dl
	movzx   eax, byte [ebp+eax*2+0x1]
	shr     al, 5
	and     eax, 0x01
	cmp     dl, 44
	sete    cl
	or      al, cl
	jz      loc_032
	add     ebx, 1
	cmp     ebx, esi
	jnz     loc_028
loc_030:  mov     eax, 1
loc_031:  add     esp, 44
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_032:  mov     eax, edi
	test    al, al
	jz      loc_033
	mov     eax, dword [esp+0x0C]
	mov     dword [esp+0x1C], eax
loc_033:  cmp     dl, 93
	jz      loc_030
	cmp     dl, 34
	jnz     loc_034
	lea     eax, [esp+0x1C]
	call    parse_json_string
	sub     esp, 8
	mov     ebx, eax
	mov     eax, dword [esp+0x4C]
	mov     eax, dword [eax]
	lea     eax, [eax*4+0x4]
	push    eax
	mov     eax, dword [esp+0x4C]
	push    dword [eax]
	call    realloc
	add     esp, 16
	test    ebx, ebx
	jz      loc_036
	test    eax, eax
	jz      loc_036
	mov     edi, dword [esp+0x40]
	mov     dword [edi], eax
	mov     edi, dword [esp+0x44]
	mov     edx, dword [edi]
	lea     ecx, [edx+0x1]
	mov     dword [edi], ecx
	mov     dword [eax+edx*4], ebx
	mov     ebx, dword [esp+0x1C]
	cmp     ebx, esi
	jc      loc_027
loc_034:  xor     eax, eax
	jmp     loc_031

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_035:  movzx   eax, byte [ebx+0x1]
	mov     ebx, esi
	cmp     al, 91
	jne     loc_030
	jmp     loc_026

loc_036:  sub     esp, 12
	push    ebx
	call    free
	add     esp, 16
	xor     eax, eax
	jmp     loc_031

loc_037:
	movzx   eax, byte [ebx]
	jmp     loc_025

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

object_string:
	push    edi
	push    esi
	mov     esi, edx
	push    ebx
	sub     esp, 16
	call    find_key
	mov     dword [esp+0x0C], eax
	test    eax, eax
	jz      loc_042
	mov     ebx, eax
	cmp     eax, esi
	jnc     loc_041
	call    __ctype_b_loc
	xor     edx, edx
	mov     ecx, dword [eax]
	jmp     loc_039

; Note: No jump seems to point here
	jmp     loc_038

; Filling space: 0x18
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_038:  add     ebx, 1
	mov     edx, 1
	cmp     ebx, esi
	jz      loc_044
	mov     edi, ebx
loc_039:  movzx   eax, byte [ebx]
	test    byte [ecx+eax*2+0x1], 0x20
	jnz     loc_038
	test    dl, dl
	jz      loc_040
	mov     dword [esp+0x0C], edi
loc_040:  sub     esi, ebx
	cmp     esi, 3
	jle     loc_041
	sub     esp, 4
	push    4
	push    loc_139
	push    ebx
	call    strncmp
	add     esp, 16
	test    eax, eax
	jz      loc_042
loc_041:  cmp     byte [ebx], 34
	jz      loc_043
loc_042:  sub     esp, 12
	push    loc_138
	call    strdup
	add     esp, 16
	add     esp, 16
	pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_043:  lea     eax, [esp+0x0C]
	call    parse_json_string
	add     esp, 16
	pop     ebx
	pop     esi
	pop     edi
	ret

loc_044:
	cmp     byte [ebx], 34
	mov     dword [esp+0x0C], ebx
	jz      loc_043
	jmp     loc_042

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8

object_long:
	push    esi
	mov     esi, edx
	push    ebx
	sub     esp, 4
	call    find_key
	test    eax, eax
	jz      loc_048
	mov     ebx, eax
	cmp     eax, esi
	jnc     loc_047
	call    __ctype_b_loc
	mov     edx, dword [eax]
	jmp     loc_046

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_045:  add     ebx, 1
	cmp     esi, ebx
	jz      loc_047
loc_046:  movzx   eax, byte [ebx]
	test    byte [edx+eax*2+0x1], 0x20
	jnz     loc_045
loc_047:  sub     esp, 4
	push    10
	push    0
	push    ebx
	call    strtol
	add     esp, 16
	add     esp, 4
	pop     ebx
	pop     esi
	ret

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_048:  add     esp, 4
	xor     eax, eax
	pop     ebx
	pop     esi
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

set_error:
	test    eax, eax
	jz      loc_052
	push    ebp
	push    edi
	push    esi
	mov     esi, edx
	push    ebx
	sub     esp, 12
	test    edx, edx
	jz      loc_050
	mov     ebx, eax
	mov     edi, ecx
	test    ecx, ecx
	jz      loc_051
	sub     esp, 12
	push    ecx
	call    strlen
	add     esp, 16
	mov     ebp, eax
loc_049:  cmp     ebp, esi
	lea     eax, [esi-0x1]
	cmovnc  ebp, eax
	sub     esp, 4
	push    ebp
	push    edi
	push    ebx
	call    memcpy
	mov     byte [ebx+ebp], 0
	add     esp, 16
loc_050:  add     esp, 12
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_051:  mov     ebp, 13
	mov     edi, loc_140
	jmp     loc_049

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_052:  ret

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

curl_get.constprop.0:
	push    ebp
	push    edi
	mov     edi, edx
	push    esi
	push    ebx
	mov     ebx, eax
	sub     esp, 8248
	mov     dword [edx], 0
	lea     eax, [esp+0x24]
	mov     dword [esp+0x14], ecx
	push    eax
	call    pipe
	add     esp, 16
	test    eax, eax
	jne     loc_059
	call    fork
	mov     dword [esp+0x0C], eax
	test    eax, eax
	js      loc_070
	je      loc_057
	sub     esp, 12
	xor     esi, esi
	xor     ebx, ebx
	push    dword [esp+0x28]
	call    close
	add     esp, 16
	mov     dword [esp+0x4], esi
; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_053:  sub     esp, 4
	push    8192
	lea     eax, [esp+0x28]
	push    eax
	push    dword [esp+0x24]
	call    read
	add     esp, 16
	mov     ebp, eax
	test    eax, eax
	jle     loc_063
	mov     eax, dword [esp+0x4]
	lea     esi, [ebp+eax]
	lea     eax, [esi+0x1]
	cmp     ebx, eax
	jnc     loc_058
	test    ebx, ebx
	jnz     loc_054
	mov     ebx, 8192
	cmp     eax, 8192
	jbe     loc_055
; Filling space: 0x0A
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_054:  add     ebx, ebx
	cmp     ebx, eax
	jc      loc_054
loc_055:  sub     esp, 8
	push    ebx
	push    dword [edi]
	call    realloc
	add     esp, 16
	test    eax, eax
	je      loc_068
	mov     dword [edi], eax
loc_056:  mov     edx, dword [esp+0x4]
	sub     esp, 4
	push    ebp
	add     eax, edx
	lea     ecx, [esp+0x28]
	push    ecx
	push    eax
	call    memcpy
	mov     eax, dword [edi]
	add     esp, 16
	mov     dword [esp+0x4], esi
	mov     byte [eax+esi], 0
	jmp     loc_053

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_057:  sub     esp, 12
	push    dword [esp+0x24]
	call    close
	pop     ebp
	pop     eax
	push    1
	push    dword [esp+0x28]
	call    dup2
	add     esp, 16
	test    eax, eax
	js      loc_062
	sub     esp, 12
	push    dword [esp+0x28]
	call    close
	push    0
	push    ebx
	push    loc_141
	push    loc_142
	push    loc_143
	push    loc_144
	push    loc_145
	push    loc_146
	push    loc_147
	push    loc_148
	push    loc_149
	push    loc_149
	call    execlp
	add     esp, 52
	push    127
	call    _exit
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_058:  mov     eax, dword [edi]
	jmp     loc_056

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_059:  call    __errno_location
	sub     esp, 12
loc_060:  push    dword [eax]
	call    strerror
	mov     edx, dword [esp+0x2050]
	mov     ecx, eax
	mov     eax, dword [esp+0x18]
	call    set_error
	add     esp, 16
loc_061:  add     esp, 8236
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

loc_062:  sub     esp, 12
	push    127
	call    _exit
loc_063:  sub     esp, 12
	push    dword [esp+0x24]
	call    close
	add     esp, 16
	mov     esi, dword [esp+0x0C]
	lea     ebx, [esp+0x14]
	jmp     loc_065

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_064:  call    __errno_location
	cmp     dword [eax], 4
	jnz     loc_066
loc_065:  sub     esp, 4
	push    0
	push    ebx
	push    esi
	call    waitpid
	add     esp, 16
	test    eax, eax
	js      loc_064
loc_066:  mov     eax, dword [edi]
; Note: Length-changing prefix causes delay on old Intel processors
	test    word [esp+0x14], 0x0FF7F
	jne     loc_073
	test    eax, eax
	je      loc_074
loc_067:  test    eax, eax
	setne   al
	add     esp, 8236
	pop     ebx
	movzx   eax, al
	pop     esi
	pop     edi
	pop     ebp
	ret

loc_068:  sub     esp, 12
	push    dword [esp+0x24]
	call    close
	pop     ecx
	pop     ebx
	push    15
	mov     esi, dword [esp+0x18]
	push    esi
	call    kill
	add     esp, 12
	push    0
	push    0
	push    esi
	call    waitpid
	pop     esi
	push    dword [edi]
	call    free
	add     esp, 16
	mov     dword [edi], 0
	mov     edi, dword [esp+0x8]
	test    edi, edi
	je      loc_061
	mov     edx, dword [esp+0x2040]
	test    edx, edx
	je      loc_061
	mov     eax, 14
	cmp     dword [esp+0x2040], eax
	mov     ecx, str_LC14
	cmovbe  eax, dword [esp+0x2040]
	lea     edx, [eax-0x1]
	cmp     edx, 4
	jc      loc_071
	mov     edi, dword [esp+0x8]
; Note: Memory operand is misaligned. Performance penalty
	mov     ebx, dword [str_LC14]
	mov     dword [edi], ebx
; Note: Memory operand is misaligned. Performance penalty
	mov     ebx, dword [str_LC14-0x4+edx]
	mov     dword [edi+edx-0x4], ebx
	lea     ebx, [edi+0x4]
	and     ebx, 0x0FFFFFFFC
	sub     edi, ebx
	add     edx, edi
	sub     ecx, edi
	and     edx, 0x0FFFFFFFC
	cmp     edx, 4
	jc      loc_072
	and     edx, 0x0FFFFFFFC
	xor     esi, esi
loc_069:  mov     edi, dword [ecx+esi]
	mov     dword [ebx+esi], edi
	add     esi, 4
	cmp     esi, edx
	jc      loc_069
	jmp     loc_072

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_070:  sub     esp, 12
	push    dword [esp+0x24]
	call    close
	pop     eax
	push    dword [esp+0x28]
	call    close
	call    __errno_location
	pop     edx
	jmp     loc_060

loc_071:  test    edx, edx
	jz      loc_072
	movzx   ecx, byte [str_LC14]
	mov     edi, dword [esp+0x8]
	mov     byte [edi], cl
	test    dl, 0x02
	jne     loc_077
loc_072:  mov     edx, dword [esp+0x8]
	mov     byte [edx+eax-0x1], 0
	jmp     loc_061

loc_073:  sub     esp, 12
	push    eax
	call    free
	add     esp, 16
	mov     dword [edi], 0
	mov     edi, dword [esp+0x8]
	test    edi, edi
	je      loc_061
	mov     eax, dword [esp+0x2040]
	test    eax, eax
	je      loc_061
	mov     eax, 28
	cmp     dword [esp+0x2040], eax
	mov     ebx, str_LC15
	cmovbe  eax, dword [esp+0x2040]
	lea     edx, [eax-0x1]
	cmp     edx, 4
	jnc     loc_075
	test    edx, edx
	jz      loc_072
	movzx   ecx, byte [str_LC15]
	mov     byte [edi], cl
	test    dl, 0x02
	jz      loc_072
; Note: Memory operand is misaligned. Performance penalty
	movzx   ecx, word [str_LC15-0x2+edx]
	mov     edi, dword [esp+0x8]
	mov     word [edi+edx-0x2], cx
	jmp     loc_072

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_074:  sub     esp, 12
	push    loc_138
	call    strdup
	add     esp, 16
	mov     dword [edi], eax
	jmp     loc_067

loc_075:  mov     edi, dword [esp+0x8]
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC15]
	mov     dword [edi], ecx
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC15-0x4+edx]
	mov     dword [edi+edx-0x4], ecx
	lea     ecx, [edi+0x4]
	and     ecx, 0x0FFFFFFFC
	sub     edi, ecx
	add     edx, edi
	sub     ebx, edi
	and     edx, 0x0FFFFFFFC
	cmp     edx, 4
	jc      loc_072
	and     edx, 0x0FFFFFFFC
	xor     esi, esi
loc_076:  mov     edi, dword [ebx+esi]
	mov     dword [ecx+esi], edi
	add     esi, 4
	cmp     esi, edx
	jc      loc_076
	jmp     loc_072

loc_077:
; Note: Memory operand is misaligned. Performance penalty
	movzx   ecx, word [str_LC14-0x2+edx]
	mov     edi, dword [esp+0x8]
	mov     word [edi+edx-0x2], cx
	jmp     loc_072

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8

request:
	push    ebp
	push    edi
	push    esi
	mov     esi, edx
	push    ebx
	mov     ebx, ecx
	sub     esp, 152
	mov     dword [esp+0x24], eax
	mov     ebp, dword [esp+0x0AC]
	push    ecx
	call    strlen
	mov     edi, eax
	lea     eax, [eax+eax*2+0x1]
	mov     dword [esp], eax
	call    malloc
	mov     dword [esp+0x1C], eax
	add     esp, 16
	test    eax, eax
	je      loc_118
	mov     ecx, eax
	test    edi, edi
	je      loc_082
	call    __ctype_b_loc
	add     edi, ebx
	mov     dword [esp+0x1C], esi
	xor     ecx, ecx
	mov     eax, dword [eax]
	mov     dword [esp+0x14], edi
	mov     dword [esp+0x0A0], ebp
	mov     dword [esp+0x10], eax
	mov     eax, ebx
	jmp     loc_079

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_078:  lea     ebx, [ebx-0x2D]
	cmp     bl, 1
	jbe     loc_080
	cmp     dl, 95
	jz      loc_080
	cmp     dl, 126
	jz      loc_080
	mov     ebx, edx
	and     edx, 0x0F
	mov     edi, dword [esp+0x0C]
	mov     byte [esi], 37
	shr     bl, 4
	movzx   edx, byte [hex.0+edx]
	lea     esi, [ecx+0x2]
	add     eax, 1
	movzx   ebx, bl
	movzx   ebx, byte [hex.0+ebx]
	mov     byte [edi+ecx+0x1], bl
	add     ecx, 3
	mov     byte [edi+esi], dl
	mov     edi, dword [esp+0x14]
	cmp     eax, edi
	jz      loc_081
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_079:  movzx   ebx, byte [eax]
	mov     esi, dword [esp+0x0C]
	lea     ebp, [ecx+0x1]
	mov     edi, dword [esp+0x10]
	mov     edx, ebx
	add     esi, ecx
	test    byte [edi+ebx*2], 0x08
	jz      loc_078
loc_080:  mov     edi, dword [esp+0x14]
	add     eax, 1
	mov     byte [esi], dl
	mov     ecx, ebp
	cmp     eax, edi
	jnz     loc_079
loc_081:  mov     eax, dword [esp+0x0C]
	mov     esi, dword [esp+0x1C]
	mov     ebp, dword [esp+0x0A0]
	add     ecx, eax
loc_082:  mov     dword [esp+0x2C], 0
	sub     esp, 12
	mov     byte [ecx], 0
	mov     dword [ebp], 0
	mov     dword [ebp+0x4], 0
	push    dword [esp+0x24]
	call    strlen
	mov     dword [esp], esi
	mov     edi, eax
	call    strlen
	pop     edx
	push    dword [esp+0x18]
	mov     ebx, eax
	lea     ebx, [edi+ebx+0x20]
	call    strlen
	add     ebx, eax
	mov     dword [esp], ebx
	call    malloc
	mov     dword [esp+0x20], eax
	add     esp, 16
	test    eax, eax
	je      loc_133
	sub     esp, 8
	push    loc_150
	push    esi
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_088
	sub     esp, 12
	push    dword [esp+0x18]
	push    dword [esp+0x28]
	push    loc_152
	push    ebx
	push    dword [esp+0x2C]
	call    snprintf
	add     esp, 32
loc_083:  sub     esp, 12
	push    dword [esp+0x18]
	call    free
	lea     edx, [esp+0x3C]
	pop     eax
	push    dword [esp+0x0B4]
	mov     ecx, dword [esp+0x0B4]
	mov     eax, dword [esp+0x20]
	call    curl_get.constprop.0
	mov     ecx, dword [esp+0x3C]
	mov     dword [esp+0x1C], eax
	mov     dword [esp+0x24], ecx
	add     esp, 16
	test    eax, eax
	je      loc_110
	sub     esp, 8
	push    loc_153
	push    ecx
	call    strstr
	add     esp, 16
	test    eax, eax
	je      loc_122
	sub     esp, 8
	push    91
	push    eax
	call    strchr
	add     esp, 16
	test    eax, eax
	je      loc_122
	lea     ebx, [eax+0x1]
	movzx   eax, byte [eax+0x1]
	test    al, al
	je      loc_115
; Filling space: 0x0D
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_084:  mov     esi, ebx
	cmp     al, 123
	jnz     loc_086
	jmp     loc_090

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_085:  movzx   eax, byte [esi+0x1]
	add     esi, 1
	test    al, al
	je      loc_117
	cmp     al, 123
	jz      loc_089
loc_086:  cmp     al, 93
	jnz     loc_085
loc_087:  sub     esp, 12
	push    dword [esp+0x1C]
	call    free
	pop     eax
	push    dword [esp+0x20]
	call    free
	add     esp, 16
	mov     eax, dword [esp+0x0C]
	add     esp, 140
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

loc_088:  sub     esp, 12
	push    dword [esp+0x18]
	push    dword [esp+0x28]
	push    loc_151
	push    ebx
	push    dword [esp+0x2C]
	call    snprintf
	add     esp, 32
	jmp     loc_083

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_089:  test    al, al
	je      loc_117
loc_090:  mov     ebx, esi
	xor     edi, edi
	mov     edx, 123
; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_091:  lea     eax, [ebx+0x1]
	cmp     dl, 34
	je      loc_104
	cmp     dl, 123
	je      loc_103
	cmp     dl, 125
	je      loc_102
loc_092:  mov     ebx, eax
loc_093:  movzx   edx, byte [ebx]
	test    dl, dl
	jnz     loc_091
; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_094:  test    edi, edi
	jne     loc_108
loc_095:  xor     eax, eax
	mov     ecx, 20
	lea     edi, [esp+0x30]
	mov     edx, ebx
	rep stosd
	mov     ecx, loc_154
	mov     eax, esi
	call    object_string
	mov     ecx, loc_155
	mov     edx, ebx
	mov     dword [esp+0x30], eax
	mov     eax, esi
	call    object_string
	mov     ecx, loc_156
	mov     edx, ebx
	mov     dword [esp+0x34], eax
	mov     eax, esi
	call    object_string
	mov     ecx, loc_157
	mov     edx, ebx
	mov     dword [esp+0x38], eax
	mov     eax, esi
	call    object_string
	mov     ecx, loc_158
	mov     edx, ebx
	mov     dword [esp+0x3C], eax
	mov     eax, esi
	call    object_string
	mov     ecx, loc_159
	mov     edx, ebx
	mov     dword [esp+0x40], eax
	mov     eax, esi
	call    object_string
	mov     ecx, loc_160
	mov     edx, ebx
	mov     dword [esp+0x44], eax
	mov     eax, esi
	call    object_long
	mov     ecx, loc_161
	mov     edx, ebx
	mov     dword [esp+0x48], eax
	mov     eax, esi
	call    find_key
	mov     edi, eax
	test    eax, eax
	je      loc_113
	cmp     eax, ebx
	jnc     loc_098
	call    __ctype_b_loc
	mov     edx, dword [eax]
	jmp     loc_097

; Note: No jump seems to point here
	jmp     loc_096

; Filling space: 0x16
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_096:  add     edi, 1
	cmp     ebx, edi
	jz      loc_098
loc_097:  movzx   eax, byte [edi]
	test    byte [edx+eax*2+0x1], 0x20
	jnz     loc_096
loc_098:  sub     esp, 8
	push    0
	push    edi
	call    strtod
	add     esp, 16
loc_099:  mov     edx, ebx
	mov     ecx, loc_162
	mov     eax, esi
	fstp    qword [esp+0x4C]
	call    object_long
	mov     edx, dword [esp+0x30]
	mov     dword [esp+0x54], eax
	test    edx, edx
	jz      loc_100
	mov     eax, dword [esp+0x34]
	test    eax, eax
	jz      loc_100
	mov     eax, dword [esp+0x38]
	test    eax, eax
	jz      loc_100
	mov     eax, dword [esp+0x3C]
	test    eax, eax
	jz      loc_100
	mov     eax, dword [esp+0x40]
	test    eax, eax
	jz      loc_100
	mov     eax, dword [esp+0x44]
	test    eax, eax
	jz      loc_100
	sub     esp, 8
	mov     ecx, loc_163
	mov     edx, ebx
	lea     eax, [esp+0x64]
	push    eax
	lea     eax, [esp+0x64]
	push    eax
	mov     eax, esi
	call    object_array
	add     esp, 16
	test    eax, eax
	jz      loc_100
	sub     esp, 8
	mov     ecx, loc_164
	mov     edx, ebx
	lea     eax, [esp+0x6C]
	push    eax
	lea     eax, [esp+0x6C]
	push    eax
	mov     eax, esi
	call    object_array
	add     esp, 16
	test    eax, eax
	jne     loc_114
; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_100:  lea     eax, [esp+0x30]
	call    package_destroy
	mov     edi, dword [esp+0x0A4]
	test    edi, edi
	je      loc_110
	mov     esi, dword [esp+0x0A8]
	test    esi, esi
	je      loc_110
	mov     edx, 34
	cmp     dword [esp+0x0A8], edx
	mov     esi, str_LC37
	cmovbe  edx, dword [esp+0x0A8]
	lea     eax, [edx-0x1]
	cmp     eax, 4
	jc      loc_129
	mov     edi, dword [esp+0x0A4]
	mov     ecx, dword [str_LC37]
	mov     dword [edi], ecx
	mov     ecx, dword [str_LC37-0x4+eax]
	mov     edi, dword [esp+0x0A4]
	mov     dword [edi+eax-0x4], ecx
	mov     ecx, dword [esp+0x0A4]
	lea     ebx, [ecx+0x4]
	and     ebx, 0x0FFFFFFFC
	sub     ecx, ebx
	add     eax, ecx
	sub     esi, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_109
	and     eax, 0x0FFFFFFFC
	xor     ecx, ecx
loc_101:  mov     edi, dword [esi+ecx]
	mov     dword [ebx+ecx], edi
	add     ecx, 4
	cmp     ecx, eax
	jc      loc_101
	jmp     loc_109

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_102:  sub     edi, 1
	jne     loc_092
	mov     ebx, eax
	jmp     loc_095

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_103:  add     edi, 1
	jmp     loc_092

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_104:  movzx   edx, byte [ebx+0x1]
	test    dl, dl
	je      loc_121
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_105:  lea     ecx, [eax+0x1]
	mov     ebx, ecx
	cmp     dl, 92
	jz      loc_107
	movzx   eax, byte [eax+0x1]
	cmp     dl, 34
	je      loc_093
	mov     edx, eax
loc_106:  mov     eax, ecx
	test    dl, dl
	jnz     loc_105
	mov     ebx, ecx
	jmp     loc_094

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_107:  cmp     byte [eax+0x1], 0
	je      loc_094
	movzx   edx, byte [eax+0x2]
	lea     ecx, [eax+0x2]
	jmp     loc_106

loc_108:  mov     ebx, dword [esp+0x0A4]
	test    ebx, ebx
	jz      loc_110
	mov     ecx, dword [esp+0x0A8]
	test    ecx, ecx
	jz      loc_110
	mov     edx, 25
	cmp     dword [esp+0x0A8], edx
	mov     esi, str_LC22
	cmovbe  edx, dword [esp+0x0A8]
	lea     eax, [edx-0x1]
	cmp     eax, 4
	jnc     loc_130
	test    eax, eax
	jz      loc_109
	movzx   ecx, byte [str_LC22]
	mov     edi, dword [esp+0x0A4]
	mov     byte [edi], cl
	test    al, 0x02
	jne     loc_132
loc_109:  mov     eax, dword [esp+0x0A4]
	mov     byte [eax+edx-0x1], 0
; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_110:  mov     edx, dword [ebp+0x4]
	xor     ebx, ebx
	test    edx, edx
	jz      loc_112
; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_111:  lea     eax, [ebx+ebx*4]
	add     ebx, 1
	shl     eax, 4
	add     eax, dword [ebp]
	call    package_destroy
	cmp     ebx, dword [ebp+0x4]
	jc      loc_111
loc_112:  sub     esp, 12
	push    dword [ebp]
	call    free
	add     esp, 16
	mov     dword [ebp], 0
	mov     dword [ebp+0x4], 0
	mov     dword [esp+0x0C], 0
	jmp     loc_087

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_113:  fldz
	jmp     loc_099

loc_114:  sub     esp, 8
	mov     ecx, loc_165
	mov     edx, ebx
	lea     eax, [esp+0x74]
	push    eax
	lea     eax, [esp+0x74]
	push    eax
	mov     eax, esi
	call    object_array
	add     esp, 16
	test    eax, eax
	je      loc_100
	sub     esp, 8
	mov     ecx, loc_166
	mov     edx, ebx
	lea     eax, [esp+0x7C]
	push    eax
	lea     eax, [esp+0x7C]
	push    eax
	mov     eax, esi
	call    object_array
	add     esp, 16
	test    eax, eax
	je      loc_100
	sub     esp, 8
	mov     ecx, loc_167
	mov     edx, ebx
	lea     eax, [esp+0x84]
	push    eax
	lea     eax, [esp+0x84]
	push    eax
	mov     eax, esi
	call    object_array
	add     esp, 16
	test    eax, eax
	je      loc_100
	mov     eax, dword [ebp+0x4]
	sub     esp, 8
	lea     eax, [eax+eax*4+0x5]
	shl     eax, 4
	push    eax
	push    dword [ebp]
	call    realloc
	add     esp, 16
	test    eax, eax
	je      loc_100
	mov     edx, dword [ebp+0x4]
	mov     dword [ebp], eax
	lea     esi, [esp+0x30]
	lea     ecx, [edx+0x1]
	lea     edx, [edx+edx*4]
	shl     edx, 4
	mov     dword [ebp+0x4], ecx
	mov     ecx, 20
	add     eax, edx
	mov     edi, eax
	rep movsd
	movzx   eax, byte [ebx]
	test    al, al
	jne     loc_084
loc_115:  mov     ebx, dword [esp+0x0A4]
	test    ebx, ebx
	je      loc_110
	mov     ecx, dword [esp+0x0A8]
	test    ecx, ecx
	je      loc_110
	mov     edx, 26
	cmp     dword [esp+0x0A8], edx
	mov     esi, str_LC38
	cmovbe  edx, dword [esp+0x0A8]
	lea     eax, [edx-0x1]
	cmp     eax, 4
	jc      loc_128
	mov     edi, dword [esp+0x0A4]
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC38]
	mov     dword [edi], ecx
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC38-0x4+eax]
	mov     edi, dword [esp+0x0A4]
	mov     dword [edi+eax-0x4], ecx
	mov     ecx, dword [esp+0x0A4]
	lea     ebx, [ecx+0x4]
	and     ebx, 0x0FFFFFFFC
	sub     ecx, ebx
	add     eax, ecx
	sub     esi, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_109
	and     eax, 0x0FFFFFFFC
	xor     ecx, ecx
loc_116:  mov     edi, dword [esi+ecx]
	mov     dword [ebx+ecx], edi
	add     ecx, 4
	cmp     ecx, eax
	jc      loc_116
	jmp     loc_109

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_117:  mov     ebx, esi
	jmp     loc_095

loc_118:  mov     ebx, dword [esp+0x0A4]
	mov     dword [ebp], 0
	mov     dword [ebp+0x4], 0
	test    ebx, ebx
	jz      loc_120
	mov     ecx, dword [esp+0x0A8]
	test    ecx, ecx
	jz      loc_120
	mov     edx, 14
	cmp     dword [esp+0x0A8], edx
	mov     ecx, str_LC14
	cmovbe  edx, dword [esp+0x0A8]
	lea     eax, [edx-0x1]
	cmp     eax, 4
	jnc     loc_124
	test    eax, eax
	jne     loc_127
loc_119:  mov     eax, dword [esp+0x0A4]
	mov     byte [eax+edx-0x1], 0
loc_120:  mov     dword [esp+0x0C], 0
	mov     eax, dword [esp+0x0C]
	add     esp, 140
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

loc_121:  mov     ebx, eax
	jmp     loc_094

loc_122:  mov     edi, dword [esp+0x0A4]
	test    edi, edi
	je      loc_110
	mov     esi, dword [esp+0x0A8]
	test    esi, esi
	je      loc_110
	mov     edx, 25
	cmp     dword [esp+0x0A8], edx
	mov     esi, str_LC21
	cmovbe  edx, dword [esp+0x0A8]
	lea     eax, [edx-0x1]
	cmp     eax, 4
	jc      loc_126
	mov     edi, dword [esp+0x0A4]
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC21]
	mov     dword [edi], ecx
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [str_LC21-0x4+eax]
	mov     edi, dword [esp+0x0A4]
	mov     dword [edi+eax-0x4], ecx
	mov     ecx, dword [esp+0x0A4]
	lea     ebx, [ecx+0x4]
	and     ebx, 0x0FFFFFFFC
	sub     ecx, ebx
	add     eax, ecx
	sub     esi, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_109
	and     eax, 0x0FFFFFFFC
	xor     ecx, ecx
loc_123:  mov     edi, dword [esi+ecx]
	mov     dword [ebx+ecx], edi
	add     ecx, 4
	cmp     ecx, eax
	jc      loc_123
	jmp     loc_109

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_124:  mov     edi, dword [esp+0x0A4]
; Note: Memory operand is misaligned. Performance penalty
	mov     ebx, dword [str_LC14]
	mov     dword [edi], ebx
; Note: Memory operand is misaligned. Performance penalty
	mov     ebx, dword [str_LC14-0x4+eax]
	mov     edi, dword [esp+0x0A4]
	mov     dword [edi+eax-0x4], ebx
	mov     edi, dword [esp+0x0A4]
	lea     ebx, [edi+0x4]
	mov     esi, edi
	and     ebx, 0x0FFFFFFFC
	sub     esi, ebx
	add     eax, esi
	sub     ecx, esi
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_119
	and     eax, 0x0FFFFFFFC
	xor     esi, esi
loc_125:  mov     edi, dword [ecx+esi]
	mov     dword [ebx+esi], edi
	add     esi, 4
	cmp     esi, eax
	jc      loc_125
	jmp     loc_119

loc_126:  test    eax, eax
	je      loc_109
	movzx   ecx, byte [str_LC21]
	mov     edi, dword [esp+0x0A4]
	mov     byte [edi], cl
	test    al, 0x02
	je      loc_109
; Note: Memory operand is misaligned. Performance penalty
	movzx   ecx, word [str_LC21-0x2+eax]
	mov     edi, dword [esp+0x0A4]
	mov     word [edi+eax-0x2], cx
	jmp     loc_109

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_127:  movzx   ecx, byte [str_LC14]
	mov     edi, dword [esp+0x0A4]
	mov     byte [edi], cl
	test    al, 0x02
	je      loc_119
; Note: Memory operand is misaligned. Performance penalty
	movzx   ecx, word [str_LC14-0x2+eax]
	mov     edi, dword [esp+0x0A4]
	mov     word [edi+eax-0x2], cx
	jmp     loc_119

loc_128:  test    eax, eax
	je      loc_109
	movzx   ecx, byte [str_LC38]
	mov     edi, dword [esp+0x0A4]
	mov     byte [edi], cl
	test    al, 0x02
	je      loc_109
; Note: Memory operand is misaligned. Performance penalty
	movzx   ecx, word [str_LC38-0x2+eax]
	mov     edi, dword [esp+0x0A4]
	mov     word [edi+eax-0x2], cx
	jmp     loc_109

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_129:  test    eax, eax
	je      loc_109
	movzx   ecx, byte [str_LC37]
	mov     edi, dword [esp+0x0A4]
	mov     byte [edi], cl
	test    al, 0x02
	je      loc_109
	movzx   ecx, word [str_LC37-0x2+eax]
	mov     edi, dword [esp+0x0A4]
	mov     word [edi+eax-0x2], cx
	jmp     loc_109

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_130:  mov     edi, dword [esp+0x0A4]
	mov     ecx, dword [str_LC22]
	mov     dword [edi], ecx
	mov     ecx, dword [str_LC22-0x4+eax]
	mov     edi, dword [esp+0x0A4]
	mov     dword [edi+eax-0x4], ecx
	mov     ecx, dword [esp+0x0A4]
	lea     ebx, [ecx+0x4]
	and     ebx, 0x0FFFFFFFC
	sub     ecx, ebx
	add     eax, ecx
	sub     esi, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_109
	and     eax, 0x0FFFFFFFC
	xor     ecx, ecx
loc_131:  mov     edi, dword [esi+ecx]
	mov     dword [ebx+ecx], edi
	add     ecx, 4
	cmp     ecx, eax
	jc      loc_131
	jmp     loc_109

loc_132:  movzx   ecx, word [str_LC22-0x2+eax]
	mov     edi, dword [esp+0x0A4]
	mov     word [edi+eax-0x2], cx
	jmp     loc_109

loc_133:
	sub     esp, 12
	push    dword [esp+0x18]
	call    free
	mov     edx, dword [esp+0x0B8]
	mov     ecx, str_LC14
	mov     eax, dword [esp+0x0B4]
	call    set_error
	add     esp, 16
	jmp     loc_120

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8

aur_response_destroy:; Function begin
	push    esi
	push    ebx
	sub     esp, 4
	mov     esi, dword [esp+0x10]
	test    esi, esi
	jz      loc_136
	mov     eax, dword [esi+0x4]
	test    eax, eax
	jz      loc_135
	xor     ebx, ebx
; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_134:  lea     eax, [ebx+ebx*4]
	add     ebx, 1
	shl     eax, 4
	add     eax, dword [esi]
	call    package_destroy
	cmp     ebx, dword [esi+0x4]
	jc      loc_134
loc_135:  sub     esp, 12
	push    dword [esi]
	call    free
	mov     dword [esi], 0
	add     esp, 16
	mov     dword [esi+0x4], 0
loc_136:  add     esp, 4
	pop     ebx
	pop     esi
	ret

; Filling space: 0x0B
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x76, 0x00

ALIGN   16

aur_rpc_search:; Function begin
	push    ebx
	mov     eax, dword [esp+0x8]
	mov     ebx, loc_169
	mov     edx, dword [esp+0x10]
	mov     ecx, dword [esp+0x0C]
	test    eax, eax
	cmove   eax, ebx
	mov     ebx, dword [esp+0x18]
	mov     dword [esp+0x8], edx
	mov     edx, loc_150
	mov     dword [esp+0x10], ebx
	mov     ebx, dword [esp+0x14]
	mov     dword [esp+0x0C], ebx
	pop     ebx
	jmp     request

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16

aur_rpc_info:; Function begin
	push    ebx
	mov     eax, dword [esp+0x8]
	mov     ebx, loc_169
	mov     edx, dword [esp+0x10]
	mov     ecx, dword [esp+0x0C]
	test    eax, eax
	cmove   eax, ebx
	mov     ebx, dword [esp+0x18]
	mov     dword [esp+0x8], edx
	mov     edx, loc_168
	mov     dword [esp+0x10], ebx
	mov     ebx, dword [esp+0x14]
	mov     dword [esp+0x0C], ebx
	pop     ebx
	jmp     request

SECTION .rodata.str1.1 align=1 noexec

loc_137:
	db 0x22, 0x25, 0x73, 0x22, 0x00

loc_138:
	db 0x00

loc_139:
	db 0x6E, 0x75, 0x6C, 0x6C, 0x00

loc_140:
	db 0x75, 0x6E, 0x6B, 0x6E, 0x6F, 0x77, 0x6E, 0x20
	db 0x65, 0x72, 0x72, 0x6F, 0x72, 0x00

loc_141:
	db 0x36, 0x30, 0x00

loc_142:
	db 0x2D, 0x2D, 0x6D, 0x61, 0x78, 0x2D, 0x74, 0x69
	db 0x6D, 0x65, 0x00

loc_143:
	db 0x31, 0x35, 0x00

loc_144:
	db 0x2D, 0x2D, 0x63, 0x6F, 0x6E, 0x6E, 0x65, 0x63
	db 0x74, 0x2D, 0x74, 0x69, 0x6D, 0x65, 0x6F, 0x75
	db 0x74, 0x00

loc_145:
	db 0x2D, 0x2D, 0x6C, 0x6F, 0x63, 0x61, 0x74, 0x69
	db 0x6F, 0x6E, 0x00

loc_146:
	db 0x2D, 0x2D, 0x73, 0x68, 0x6F, 0x77, 0x2D, 0x65
	db 0x72, 0x72, 0x6F, 0x72, 0x00

loc_147:
	db 0x2D, 0x2D, 0x73, 0x69, 0x6C, 0x65, 0x6E, 0x74
	db 0x00

loc_148:
	db 0x2D, 0x2D, 0x66, 0x61, 0x69, 0x6C, 0x00

loc_149:
	db 0x63, 0x75, 0x72, 0x6C, 0x00

str_LC14:  dd 0x2074756F, 0x6D20666F
	dd 0x726F6D65
	db 0x79, 0x00

str_LC15:  dd 0x20525541, 0x20435052
	dd 0x50545448, 0x71657220
	dd 0x74736575, 0x69616620
	dd 0x0064656C

loc_150:
	db 0x73, 0x65, 0x61, 0x72, 0x63, 0x68, 0x00

loc_151:
	db 0x25, 0x73, 0x2F, 0x73, 0x65, 0x61, 0x72, 0x63
	db 0x68, 0x2F, 0x25, 0x73, 0x3F, 0x62, 0x79, 0x3D
	db 0x6E, 0x61, 0x6D, 0x65, 0x2D, 0x64, 0x65, 0x73
	db 0x63, 0x00

loc_152:
	db 0x25, 0x73, 0x2F, 0x69, 0x6E, 0x66, 0x6F, 0x3F
	db 0x61, 0x72, 0x67, 0x5B, 0x5D, 0x3D, 0x25, 0x73
	db 0x00

loc_153:
	db 0x22, 0x72, 0x65, 0x73, 0x75, 0x6C, 0x74, 0x73
	db 0x22, 0x00

str_LC21:  dd 0x61766E69, 0x2064696C
	dd 0x20525541, 0x20435052
	dd 0x70736572, 0x65736E6F
	db 0x00

str_LC22:  dd 0x6E757274, 0x65746163
	dd 0x55412064, 0x50522052
	dd 0x626F2043, 0x7463656A
	db 0x00

loc_154:
	db 0x4E, 0x61, 0x6D, 0x65, 0x00

loc_155:
	db 0x50, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x42
	db 0x61, 0x73, 0x65, 0x00

loc_156:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00

loc_157:
	db 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74
	db 0x69, 0x6F, 0x6E, 0x00

loc_158:
	db 0x55, 0x52, 0x4C, 0x00

loc_159:
	db 0x4D, 0x61, 0x69, 0x6E, 0x74, 0x61, 0x69, 0x6E
	db 0x65, 0x72, 0x00

loc_160:
	db 0x4E, 0x75, 0x6D, 0x56, 0x6F, 0x74, 0x65, 0x73
	db 0x00

loc_161:
	db 0x50, 0x6F, 0x70, 0x75, 0x6C, 0x61, 0x72, 0x69
	db 0x74, 0x79, 0x00

loc_162:
	db 0x4F, 0x75, 0x74, 0x4F, 0x66, 0x44, 0x61, 0x74
	db 0x65, 0x00

loc_163:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x00

loc_164:
	db 0x4D, 0x61, 0x6B, 0x65, 0x44, 0x65, 0x70, 0x65
	db 0x6E, 0x64, 0x73, 0x00

loc_165:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x44, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x73, 0x00

loc_166:
	db 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65, 0x73
	db 0x00

loc_167:
	db 0x43, 0x6F, 0x6E, 0x66, 0x6C, 0x69, 0x63, 0x74
	db 0x73, 0x00

str_LC38:  dd 0x6E757274, 0x65746163
	dd 0x55412064, 0x50522052
	dd 0x65722043, 0x746C7573
	db 0x73, 0x00

loc_168:
	db 0x69, 0x6E, 0x66, 0x6F, 0x00

SECTION .rodata.str1.4 align=4 noexec

str_LC37:
	dd 0x6E6E6163, 0x7020746F
	dd 0x65737261, 0x52554120
	dd 0x63617020, 0x6567616B
	dd 0x74656D20, 0x74616461
	dd 0x00000061

loc_169:
	db 0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F
	db 0x61, 0x75, 0x72, 0x2E, 0x61, 0x72, 0x63, 0x68
	db 0x6C, 0x69, 0x6E, 0x75, 0x78, 0x2E, 0x6F, 0x72
	db 0x67, 0x2F, 0x72, 0x70, 0x63, 0x2F, 0x76, 0x35
	db 0x00

SECTION .rodata align=4 noexec

hex.0:
	db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
	db 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	db 0x00

