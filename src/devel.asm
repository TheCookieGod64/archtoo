; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  devel.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 devel.asm -o devel.o
; ---------------------------------------------------------

global cmd_devel_v2: function

extern fwrite
extern stderr
extern puts
extern strstr
extern free
extern strlen
extern strchr
extern printf
extern run_cmd_capture

SECTION .text   align=16 exec

cmd_devel_v2:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 212
	lea     eax, [esp+0x24]
	mov     dword [esp+0x24], 0
	push    eax
	push    loc_016
	call    run_cmd_capture
	add     esp, 16
	cmp     eax, 1
	ja      loc_013
	sub     esp, 12
	push    loc_023
	call    printf
	mov     esi, dword [esp+0x2C]
	add     esp, 16
	test    esi, esi
	je      loc_014
	cmp     byte [esi], 0
	je      loc_014
	mov     dword [esp+0x0C], 0
	lea     ebp, [esp+0x20]
	jmp     loc_003

loc_001:  sub     eax, esi
	lea     edx, [eax-0x1]
	cmp     edx, 158
	jbe     loc_006
loc_002:  cmp     byte [ebx+0x1], 0
	lea     esi, [ebx+0x1]
	jz      loc_004
loc_003:  sub     esp, 8
	push    10
	push    esi
	call    strchr
	add     esp, 16
	mov     ebx, eax
	test    eax, eax
	jnz     loc_001
	sub     esp, 12
	push    esi
	call    strlen
	add     esp, 16
	lea     edx, [eax-0x1]
	cmp     edx, 158
	jbe     loc_006
loc_004:  sub     esp, 12
	push    dword [esp+0x28]
	call    free
	mov     eax, dword [esp+0x1C]
	add     esp, 16
	test    eax, eax
	je      loc_015
	mov     eax, 1
loc_005:  add     esp, 204
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_006:  cmp     eax, 4
	jnc     loc_010
	test    eax, eax
	jne     loc_012
loc_007:  mov     byte [esp+eax+0x20], 0
	sub     esp, 8
	push    loc_017
	push    ebp
	call    strstr
	add     esp, 16
	test    eax, eax
	jz      loc_011
loc_008:  sub     esp, 12
	push    ebp
	call    puts
	add     esp, 16
	mov     dword [esp+0x0C], 1
loc_009:  test    ebx, ebx
	jne     loc_002
	jmp     loc_004

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_010:  mov     edx, dword [esi+eax-0x4]
	lea     ecx, [eax-0x1]
	mov     edi, ebp
	shr     ecx, 2
	mov     dword [ebp+eax-0x4], edx
	rep movsd
	jmp     loc_007

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_011:  sub     esp, 8
	push    loc_018
	push    ebp
	call    strstr
	add     esp, 16
	test    eax, eax
	jnz     loc_008
	sub     esp, 8
	push    loc_019
	push    ebp
	call    strstr
	add     esp, 16
	test    eax, eax
	jnz     loc_008
	sub     esp, 8
	push    loc_020
	push    ebp
	call    strstr
	add     esp, 16
	test    eax, eax
	jnz     loc_008
	sub     esp, 8
	push    loc_021
	push    ebp
	call    strstr
	add     esp, 16
	test    eax, eax
	jne     loc_008
	jmp     loc_009

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_012:  movzx   edx, byte [esi]
	mov     byte [ebp], dl
	test    al, 0x02
	je      loc_007
	movzx   edx, word [esi+eax-0x2]
	mov     word [ebp+eax-0x2], dx
	jmp     loc_007

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_013:  push    dword [stderr]
	push    48
	push    1
	push    loc_022
	call    fwrite
	pop     edx
	push    dword [esp+0x28]
	call    free
	add     esp, 16
	xor     eax, eax
	add     esp, 204
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_014:  sub     esp, 12
	push    esi
	call    free
	add     esp, 16
; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_015:  sub     esp, 12
	push    loc_024
	call    puts
	add     esp, 16
	mov     eax, 1
	jmp     loc_005

SECTION .rodata.str1.1 align=1 noexec

loc_016:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x6D, 0x71, 0x00

loc_017:
	db 0x2D, 0x67, 0x69, 0x74, 0x00

loc_018:
	db 0x2D, 0x68, 0x67, 0x00

loc_019:
	db 0x2D, 0x73, 0x76, 0x6E, 0x00

loc_020:
	db 0x2D, 0x62, 0x7A, 0x72, 0x00

loc_021:
	db 0x2D, 0x63, 0x76, 0x73, 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_022:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x43, 0x6F, 0x75, 0x6C, 0x64
	db 0x20, 0x6E, 0x6F, 0x74, 0x20, 0x6C, 0x69, 0x73
	db 0x74, 0x20, 0x66, 0x6F, 0x72, 0x65, 0x69, 0x67
	db 0x6E, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67
	db 0x65, 0x73, 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00, 0x00, 0x00, 0x00

loc_023:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x44, 0x65, 0x76, 0x65, 0x6C
	db 0x6F, 0x70, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x2F
	db 0x20, 0x56, 0x43, 0x53, 0x20, 0x70, 0x61, 0x63
	db 0x6B, 0x61, 0x67, 0x65, 0x73, 0x20, 0x28, 0x2D
	db 0x67, 0x69, 0x74, 0x2F, 0x2D, 0x68, 0x67, 0x2F
	db 0x2D, 0x73, 0x76, 0x6E, 0x2F, 0x2D, 0x62, 0x7A
	db 0x72, 0x2F, 0x2D, 0x63, 0x76, 0x73, 0x29, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00, 0x00, 0x00, 0x00

loc_024:
	db 0x4E, 0x6F, 0x20, 0x64, 0x65, 0x76, 0x65, 0x6C
	db 0x6F, 0x70, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x70
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x73, 0x20
	db 0x69, 0x6E, 0x73, 0x74, 0x61, 0x6C, 0x6C, 0x65
	db 0x64, 0x2E, 0x00

