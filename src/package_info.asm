; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  package_info.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 package_info.asm -o package_info.o
; ---------------------------------------------------------

global cmd_available_info_v2: function
global cmd_query_v2: function

extern run_cmd
extern strlen
extern fputs
extern aur_response_destroy
extern putc
extern stdout
extern printf
extern puts
extern aur_rpc_info
extern config_current
extern free
extern run_cmd_capture
extern xsnprintf
extern shell_quote
extern fprintf
extern stderr
extern valid_pkgname

SECTION .text   align=16 exec

cmd_available_info_v2:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 1128
	mov     ebp, dword [esp+0x47C]
	mov     dword [esp+0x10], 0
	push    ebp
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jnz     loc_003
	test    ebp, ebp
	mov     eax, loc_038
	cmove   ebp, eax
	sub     esp, 4
	push    ebp
	push    loc_060
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_001:  xor     eax, eax
loc_002:  add     esp, 1116
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_003:  sub     esp, 4
	push    320
	lea     ebx, [esp+0x118]
	push    ebx
	push    ebp
	call    shell_quote
	add     esp, 16
	test    eax, eax
	jz      loc_001
	push    ebx
	push    loc_040
	push    512
	lea     ebx, [esp+0x25C]
	push    ebx
	call    xsnprintf
	pop     eax
	pop     edx
	lea     eax, [esp+0x0C]
	push    eax
	push    ebx
	call    run_cmd_capture
	mov     edx, eax
	mov     eax, dword [esp+0x14]
	add     esp, 16
	test    edx, edx
	jnz     loc_004
	test    eax, eax
	jz      loc_004
	cmp     byte [eax], 0
	jne     loc_033
loc_004:  sub     esp, 12
	push    eax
	call    free
	lea     edi, [esp+0x20]
	lea     ebx, [esp+0x20]
	xor     eax, eax
	mov     ecx, 64
	mov     dword [esp+0x18], 0
	rep stosd
	mov     dword [esp+0x1C], 0
	call    config_current
	mov     dword [esp], 256
	push    ebx
	add     eax, 16
	lea     edx, [esp+0x1C]
	push    edx
	push    ebp
	push    eax
	call    aur_rpc_info
	add     esp, 32
	test    eax, eax
	je      loc_032
	mov     edi, dword [esp+0x0C]
	xor     ebx, ebx
	mov     esi, loc_038
	test    edi, edi
	je      loc_035
; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_005:  lea     ebp, [ebx+ebx*4]
	sub     esp, 12
	shl     ebp, 4
	add     ebp, dword [esp+0x14]
	push    loc_042
	call    puts
	mov     eax, dword [ebp]
	pop     edx
	pop     ecx
	test    eax, eax
	cmove   eax, esi
	push    eax
	push    loc_043
	call    printf
	mov     eax, dword [ebp+0x4]
	pop     edi
	pop     edx
	test    eax, eax
	cmove   eax, esi
	push    eax
	push    loc_044
	call    printf
	mov     eax, dword [ebp+0x8]
	pop     ecx
	pop     edi
	test    eax, eax
	cmove   eax, esi
	push    eax
	push    loc_045
	call    printf
	mov     eax, dword [ebp+0x0C]
	pop     edx
	pop     ecx
	test    eax, eax
	cmove   eax, esi
	push    eax
	push    loc_046
	call    printf
	mov     eax, dword [ebp+0x10]
	pop     edi
	pop     edx
	test    eax, eax
	cmove   eax, esi
	push    eax
	push    loc_047
	call    printf
	mov     eax, dword [ebp+0x14]
	add     esp, 16
	test    eax, eax
	je      loc_031
	cmp     byte [eax], 0
	mov     ecx, loc_039
	cmove   eax, ecx
loc_006:  sub     esp, 8
	push    eax
	push    loc_048
	call    printf
	pop     ecx
	pop     edi
	push    dword [ebp+0x18]
	push    loc_049
	call    printf
	add     esp, 12
	push    dword [ebp+0x20]
	push    dword [ebp+0x1C]
	push    loc_050
	call    printf
	mov     eax, dword [ebp+0x24]
	add     esp, 16
	test    eax, eax
	jne     loc_030
loc_007:  sub     esp, 12
	push    loc_052
	call    printf
	mov     edx, dword [ebp+0x2C]
	add     esp, 16
	test    edx, edx
	je      loc_028
loc_008:  xor     edi, edi
; Filling space: 0x0C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_009:  mov     eax, dword [ebp+0x28]
	sub     esp, 8
	push    dword [eax+edi*4]
	add     edi, 1
	push    loc_055
	call    printf
	add     esp, 16
	cmp     edi, dword [ebp+0x2C]
	jc      loc_009
loc_010:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     dword [esp], loc_054
	call    printf
	mov     eax, dword [ebp+0x34]
	add     esp, 16
	test    eax, eax
	je      loc_027
loc_011:  xor     edi, edi
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_012:  mov     eax, dword [ebp+0x30]
	sub     esp, 8
	push    dword [eax+edi*4]
	add     edi, 1
	push    loc_055
	call    printf
	add     esp, 16
	cmp     edi, dword [ebp+0x34]
	jc      loc_012
loc_013:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     dword [esp], loc_056
	call    printf
	mov     eax, dword [ebp+0x3C]
	add     esp, 16
	test    eax, eax
	je      loc_026
loc_014:  xor     edi, edi
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_015:  mov     eax, dword [ebp+0x38]
	sub     esp, 8
	push    dword [eax+edi*4]
	add     edi, 1
	push    loc_055
	call    printf
	add     esp, 16
	cmp     edi, dword [ebp+0x3C]
	jc      loc_015
loc_016:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     dword [esp], loc_057
	call    printf
	mov     edi, dword [ebp+0x44]
	add     esp, 16
	test    edi, edi
	je      loc_025
loc_017:  xor     edi, edi
; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_018:  mov     eax, dword [ebp+0x40]
	sub     esp, 8
	push    dword [eax+edi*4]
	add     edi, 1
	push    loc_055
	call    printf
	add     esp, 16
	cmp     edi, dword [ebp+0x44]
	jc      loc_018
loc_019:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     dword [esp], loc_058
	call    printf
	mov     edx, dword [ebp+0x4C]
	add     esp, 16
	test    edx, edx
	jz      loc_024
loc_020:  xor     edi, edi
; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_021:  mov     eax, dword [ebp+0x48]
	sub     esp, 8
	push    dword [eax+edi*4]
	add     edi, 1
	push    loc_055
	call    printf
	add     esp, 16
	cmp     edi, dword [ebp+0x4C]
	jc      loc_021
loc_022:  sub     esp, 8
	push    dword [stdout]
	add     ebx, 1
	push    10
	call    putc
	add     esp, 16
	cmp     ebx, dword [esp+0x0C]
	jc      loc_029
loc_023:  sub     esp, 12
	lea     eax, [esp+0x14]
	push    eax
	call    aur_response_destroy
	add     esp, 16
	mov     eax, 1
	add     esp, 1116
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_024:  sub     esp, 12
	push    loc_053
	call    printf
	mov     eax, dword [ebp+0x4C]
	add     esp, 16
	test    eax, eax
	jne     loc_020
	jmp     loc_022

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_025:  sub     esp, 12
	push    loc_053
	call    printf
	mov     ecx, dword [ebp+0x44]
	add     esp, 16
	test    ecx, ecx
	jne     loc_017
	jmp     loc_019

loc_026:  sub     esp, 12
	push    loc_053
	call    printf
	mov     eax, dword [ebp+0x3C]
	add     esp, 16
	test    eax, eax
	jne     loc_014
	jmp     loc_016

loc_027:  sub     esp, 12
	push    loc_053
	call    printf
	mov     eax, dword [ebp+0x34]
	add     esp, 16
	test    eax, eax
	jne     loc_011
	jmp     loc_013

loc_028:  sub     esp, 12
	push    loc_053
	call    printf
	mov     eax, dword [ebp+0x2C]
	add     esp, 16
	test    eax, eax
	jne     loc_008
	jmp     loc_010

loc_029:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	add     esp, 16
	cmp     ebx, dword [esp+0x0C]
	jc      loc_005
	jmp     loc_023

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_030:  sub     esp, 8
	push    eax
	push    loc_051
	call    printf
	add     esp, 16
	jmp     loc_007

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_031:  mov     eax, loc_039
	jmp     loc_006

loc_032:  sub     esp, 4
	push    ebx
	push    loc_041
	push    dword [stderr]
	call    fprintf
	add     esp, 16
	jmp     loc_001

loc_033:  sub     esp, 8
	push    dword [stdout]
	push    eax
	call    fputs
	mov     ebx, dword [esp+0x14]
	mov     dword [esp], ebx
	call    strlen
	add     esp, 16
	cmp     byte [ebx+eax-0x1], 10
	jz      loc_034
	sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     ebx, dword [esp+0x14]
	add     esp, 16
loc_034:  sub     esp, 12
	push    ebx
	call    free
	add     esp, 16
	mov     eax, 1
	jmp     loc_002

loc_035:
	sub     esp, 4
	push    ebp
	push    loc_061
	push    dword [stderr]
	call    fprintf
	pop     ecx
	lea     eax, [esp+0x14]
	push    eax
	call    aur_response_destroy
	add     esp, 16
	jmp     loc_001

	nop

ALIGN   16
cmd_query_v2:; Function begin
	push    esi
	push    ebx
	sub     esp, 848
	mov     ebx, dword [esp+0x35C]
	push    ebx
	call    valid_pkgname
	add     esp, 16
	test    eax, eax
	jnz     loc_037
	test    ebx, ebx
	mov     eax, loc_038
	cmove   ebx, eax
	sub     esp, 4
	push    ebx
	push    loc_060
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_036:  add     esp, 836
	xor     eax, eax
	pop     ebx
	pop     esi
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_037:  sub     esp, 4
	push    320
	lea     esi, [esp+0x8]
	push    esi
	push    ebx
	call    shell_quote
	mov     esp, esi
	test    eax, eax
	jz      loc_036
	push    esi
	push    loc_059
	push    512
	lea     ebx, [esp+0x14C]
	push    ebx
	call    xsnprintf
	mov     dword [esp], ebx
	call    run_cmd
	add     esp, 16
	test    eax, eax
	sete    al
	add     esp, 836
	movzx   eax, al
	pop     ebx
	pop     esi
	ret

SECTION .rodata.str1.1 align=1 noexec

loc_038:
	db 0x00

loc_039:
	db 0x28, 0x6F, 0x72, 0x70, 0x68, 0x61, 0x6E, 0x29
	db 0x00

loc_040:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

loc_041:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x25, 0x73, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

loc_042:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x61, 0x75, 0x72, 0x00

loc_043:
	db 0x4E, 0x61, 0x6D, 0x65, 0x20, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_044:
	db 0x50, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x20
	db 0x42, 0x61, 0x73, 0x65, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_045:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_046:
	db 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74
	db 0x69, 0x6F, 0x6E, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_047:
	db 0x55, 0x52, 0x4C, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_048:
	db 0x4D, 0x61, 0x69, 0x6E, 0x74, 0x61, 0x69, 0x6E
	db 0x65, 0x72, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_049:
	db 0x56, 0x6F, 0x74, 0x65, 0x73, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x6C, 0x64, 0x0A, 0x00

loc_050:
	db 0x50, 0x6F, 0x70, 0x75, 0x6C, 0x61, 0x72, 0x69
	db 0x74, 0x79, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x2E, 0x32, 0x66, 0x0A, 0x00

loc_051:
	db 0x4F, 0x75, 0x74, 0x20, 0x4F, 0x66, 0x20, 0x44
	db 0x61, 0x74, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x6C, 0x64, 0x0A, 0x00

loc_052:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x20
	db 0x4F, 0x6E, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

loc_053:
	db 0x20, 0x4E, 0x6F, 0x6E, 0x65, 0x00

loc_054:
	db 0x4D, 0x61, 0x6B, 0x65, 0x20, 0x44, 0x65, 0x70
	db 0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

loc_055:
	db 0x20, 0x25, 0x73, 0x00

loc_056:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

loc_057:
	db 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65, 0x73
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

loc_058:
	db 0x43, 0x6F, 0x6E, 0x66, 0x6C, 0x69, 0x63, 0x74
	db 0x73, 0x20, 0x57, 0x69, 0x74, 0x68, 0x20, 0x20
	db 0x3A, 0x00

loc_059:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_060:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00

loc_061:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x50, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20
	db 0x77, 0x61, 0x73, 0x20, 0x6E, 0x6F, 0x74, 0x20
	db 0x66, 0x6F, 0x75, 0x6E, 0x64, 0x20, 0x69, 0x6E
	db 0x20, 0x72, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74
	db 0x6F, 0x72, 0x69, 0x65, 0x73, 0x20, 0x6F, 0x72
	db 0x20, 0x74, 0x68, 0x65, 0x20, 0x41, 0x55, 0x52
	db 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

