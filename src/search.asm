; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  search.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 search.asm -o search.o
; ---------------------------------------------------------

global cmd_search_v2: function

extern strlen
extern fputs
extern aur_response_destroy
extern putc
extern stdout
extern aur_rpc_search
extern config_current
extern free
extern puts
extern run_cmd_capture
extern xsnprintf
extern printf
extern shell_quote
extern fprintf
extern stderr
extern valid_search_query

SECTION .text   align=16 exec

cmd_search_v2:; Function begin
	push    ebp
	xor     eax, eax
	mov     ecx, 64
	push    edi
	push    esi
	push    ebx
	sub     esp, 1116
	mov     ebx, dword [esp+0x470]
	lea     esi, [esp+0x10]
	mov     dword [esp+0x4], 0
	sub     esp, 12
	mov     edi, esi
	mov     dword [esp+0x14], 0
	rep stosd
	mov     dword [esp+0x18], 0
	push    ebx
	call    valid_search_query
	add     esp, 16
	test    eax, eax
	jnz     loc_002
	test    ebx, ebx
	mov     eax, loc_014
	cmove   ebx, eax
	sub     esp, 4
	push    ebx
	push    loc_025
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_001:  add     esp, 1116
	xor     ebp, ebp
	pop     ebx
	mov     eax, ebp
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_002:  sub     esp, 4
	push    320
	lea     edi, [esp+0x118]
	push    edi
	push    ebx
	call    shell_quote
	add     esp, 16
	test    eax, eax
	jz      loc_001
	sub     esp, 12
	push    loc_016
	call    printf
	push    edi
	push    loc_017
	push    512
	lea     edi, [esp+0x26C]
	push    edi
	call    xsnprintf
	add     esp, 24
	lea     eax, [esp+0x0C]
	push    eax
	push    edi
	call    run_cmd_capture
	add     esp, 16
	test    eax, eax
	jnz     loc_003
	mov     eax, dword [esp+0x4]
	test    eax, eax
	jz      loc_003
	cmp     byte [eax], 0
	jne     loc_013
loc_003:  sub     esp, 12
	xor     ebp, ebp
	push    loc_018
	call    puts
	mov     edi, dword [esp+0x14]
	add     esp, 16
loc_004:  sub     esp, 12
	push    edi
	call    free
	mov     dword [esp], loc_019
	call    printf
	call    config_current
	mov     dword [esp], 256
	push    esi
	add     eax, 16
	lea     ecx, [esp+0x1C]
	push    ecx
	push    ebx
	push    eax
	call    aur_rpc_search
	add     esp, 32
	test    eax, eax
	je      loc_008
	mov     eax, dword [esp+0x0C]
	xor     ebx, ebx
	mov     edi, loc_014
	mov     esi, loc_015
	test    eax, eax
	jnz     loc_007
	jmp     loc_012

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_005:  sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     eax, dword [ebp+0x0C]
	add     esp, 16
	test    eax, eax
	jz      loc_006
	cmp     byte [eax], 0
	jne     loc_010
loc_006:  add     ebx, 1
	cmp     ebx, dword [esp+0x0C]
	jnc     loc_011
loc_007:  lea     edx, [ebx+ebx*4]
	shl     edx, 4
	add     edx, dword [esp+0x8]
	mov     ecx, dword [edx+0x8]
	mov     eax, dword [edx]
	mov     ebp, edx
	test    ecx, ecx
	cmove   ecx, edi
	test    eax, eax
	cmove   eax, esi
	sub     esp, 4
	push    ecx
	push    eax
	push    loc_021
	call    printf
	mov     eax, dword [ebp+0x18]
	add     esp, 16
	test    eax, eax
	jz      loc_005
	sub     esp, 8
	push    eax
	push    loc_022
	call    printf
	add     esp, 16
	jmp     loc_005

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_008:  sub     esp, 4
	push    esi
	push    loc_024
	push    dword [stderr]
	call    fprintf
	add     esp, 16
loc_009:  sub     esp, 12
	lea     eax, [esp+0x14]
	push    eax
	call    aur_response_destroy
	add     esp, 16
	mov     eax, ebp
	add     esp, 1116
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_010:  sub     esp, 8
	push    eax
	push    loc_023
	call    printf
	add     esp, 16
	jmp     loc_006

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_011:  mov     ebp, 1
	jmp     loc_009

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_012:  sub     esp, 12
	push    loc_020
	call    puts
	add     esp, 16
	jmp     loc_009

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_013:  sub     esp, 8
	push    dword [stdout]
	mov     ebp, 1
	push    eax
	call    fputs
	mov     edi, dword [esp+0x14]
	mov     dword [esp], edi
	call    strlen
	add     esp, 16
	cmp     byte [edi+eax-0x1], 10
	je      loc_004
	sub     esp, 8
	push    dword [stdout]
	push    10
	call    putc
	mov     edi, dword [esp+0x14]
	add     esp, 16
	jmp     loc_004

SECTION .rodata.str1.1 align=1 noexec

loc_014:
	db 0x00

loc_015:
	db 0x3F, 0x00

loc_016:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x52, 0x65, 0x70, 0x6F, 0x73
	db 0x69, 0x74, 0x6F, 0x72, 0x69, 0x65, 0x73, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00

loc_017:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x73, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

loc_018:
	db 0x20, 0x20, 0x20, 0x20, 0x28, 0x6E, 0x6F, 0x20
	db 0x72, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x20, 0x6D, 0x61, 0x74, 0x63, 0x68
	db 0x65, 0x73, 0x29, 0x00

loc_019:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x41, 0x55, 0x52, 0x0A, 0x1B
	db 0x5B, 0x30, 0x6D, 0x00

loc_020:
	db 0x20, 0x20, 0x20, 0x20, 0x28, 0x6E, 0x6F, 0x20
	db 0x41, 0x55, 0x52, 0x20, 0x6D, 0x61, 0x74, 0x63
	db 0x68, 0x65, 0x73, 0x29, 0x00

loc_021:
	db 0x61, 0x75, 0x72, 0x2F, 0x25, 0x73, 0x20, 0x25
	db 0x73, 0x00

loc_022:
	db 0x20, 0x28, 0x25, 0x6C, 0x64, 0x20, 0x76, 0x6F
	db 0x74, 0x65, 0x73, 0x29, 0x00

loc_023:
	db 0x20, 0x20, 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

loc_024:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x33, 0x6D, 0x5B
	db 0x21, 0x5D, 0x20, 0x41, 0x55, 0x52, 0x20, 0x52
	db 0x50, 0x43, 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x1B
	db 0x5B, 0x30, 0x6D, 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_025:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x73, 0x65, 0x61, 0x72, 0x63
	db 0x68, 0x20, 0x71, 0x75, 0x65, 0x72, 0x79, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

