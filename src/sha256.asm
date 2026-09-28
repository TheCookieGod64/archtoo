; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  sha256.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 sha256.asm -o sha256.o
; ---------------------------------------------------------

global sha256_init: function
global sha256_update: function
global sha256_final: function
global sha256_file: function
global sha256_verify_file: function

extern sprintf
extern ferror
extern fclose
extern fread
extern fopen

SECTION .text   align=64 exec

sha256_transform:
	push    ebp
	mov     ecx, edx
	xor     edx, edx
	push    edi
	push    esi
	push    ebx
	sub     esp, 316
	mov     dword [esp+0x20], eax
	jmp     loc_001

; Filling space: 0x2C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_001:  movzx   eax, byte [ecx+edx]
	movzx   ebx, byte [ecx+edx+0x1]
	shl     eax, 24
	shl     ebx, 16
	or      eax, ebx
	movzx   ebx, byte [ecx+edx+0x3]
	or      eax, ebx
	movzx   ebx, byte [ecx+edx+0x2]
	shl     ebx, 8
	or      eax, ebx
	mov     dword [esp+edx+0x3C], eax
	add     edx, 4
	cmp     edx, 64
	jnz     loc_001
	mov     ebp, dword [esp+0x74]
	mov     esi, dword [esp+0x78]
	lea     ecx, [esp+0x40]
	mov     ebx, dword [esp+0x3C]
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_002:  mov     eax, ebp
	mov     edx, ebp
	mov     edi, ebx
	mov     ebx, dword [ecx]
	rol     edx, 13
	rol     eax, 15
	add     ecx, 4
	xor     eax, edx
	shr     ebp, 10
	mov     edx, ebx
	xor     eax, ebp
	mov     ebp, ebx
	ror     edx, 7
	add     eax, dword [ecx+0x1C]
	rol     ebp, 14
	xor     edx, ebp
	mov     ebp, ebx
	shr     ebp, 3
	xor     edx, ebp
	mov     ebp, esi
	add     eax, edx
	lea     esi, [edi+eax]
	lea     eax, [esp+0x100]
	mov     dword [ecx+0x38], esi
	cmp     ecx, eax
	jnz     loc_002
	mov     eax, dword [esp+0x20]
	mov     ebp, dword [eax+0x60]
	mov     ebx, dword [eax+0x50]
	mov     edi, dword [eax+0x54]
	mov     edx, dword [eax+0x4C]
	mov     esi, dword [eax+0x58]
	mov     ecx, dword [eax+0x5C]
	mov     dword [esp+0x18], ebp
	mov     ebp, dword [eax+0x64]
	mov     eax, dword [eax+0x68]
	mov     dword [esp+0x28], edi
	mov     dword [esp+0x10], edi
	xor     edi, edi
	mov     dword [esp+0x1C], ebp
	mov     ebp, eax
	mov     dword [esp+0x34], eax
	mov     eax, dword [esp+0x1C]
	mov     dword [esp+0x24], ebx
	mov     dword [esp+0x4], eax
	mov     eax, dword [esp+0x18]
	mov     dword [esp+0x8], ebx
	mov     ebx, edx
	mov     dword [esp+0x2C], esi
	mov     dword [esp+0x30], ecx
	mov     dword [esp+0x0C], eax
	mov     dword [esp+0x14], esi
	mov     dword [esp+0x38], edx
	mov     dword [esp], edi
	jmp     loc_004

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_003:  mov     edi, dword [esp+0x0C]
	mov     dword [esp+0x0C], ecx
	mov     ecx, esi
	mov     dword [esp+0x4], edi
	mov     edi, dword [esp+0x8]
	mov     dword [esp+0x8], ebx
	mov     ebx, eax
	mov     dword [esp+0x10], edi
loc_004:  mov     edx, ecx
	mov     eax, ecx
	mov     edi, dword [esp]
	mov     esi, dword [esp+0x0C]
	ror     edx, 6
	ror     eax, 11
	add     dword [esp], 1
	xor     eax, edx
	mov     edx, ecx
	and     esi, ecx
	rol     edx, 7
	xor     eax, edx
	mov     edx, dword [esp+edi*4+0x3C]
	add     edx, dword [k+edi*4]
	add     eax, edx
	mov     edi, dword [esp+0x4]
	mov     edx, ecx
	not     edx
	and     edx, edi
	mov     edi, dword [esp+0x10]
	xor     edx, esi
	mov     esi, ebx
	add     eax, edx
	mov     edx, ebx
	ror     esi, 13
	ror     edx, 2
	add     eax, ebp
	mov     ebp, dword [esp+0x8]
	xor     esi, edx
	mov     edx, ebx
	rol     edx, 10
	xor     esi, edx
	mov     edx, ebp
	and     ebp, edi
	xor     edx, edi
	and     edx, ebx
	xor     edx, ebp
	mov     ebp, dword [esp+0x4]
	add     edx, esi
	mov     esi, dword [esp+0x14]
	mov     dword [esp+0x14], edi
	add     esi, eax
	add     eax, edx
	mov     edx, dword [esp]
	cmp     edx, 64
	jne     loc_003
	mov     edx, dword [esp+0x38]
	mov     edi, dword [esp+0x20]
	add     eax, edx
	mov     dword [edi+0x4C], eax
	mov     eax, dword [esp+0x24]
	add     eax, ebx
	mov     ebx, edi
	mov     dword [edi+0x50], eax
	mov     edi, dword [esp+0x8]
	mov     eax, dword [esp+0x28]
	add     eax, edi
	mov     edi, dword [esp+0x10]
	mov     dword [ebx+0x54], eax
	mov     eax, dword [esp+0x2C]
	add     eax, edi
	mov     dword [ebx+0x58], eax
	mov     eax, dword [esp+0x30]
	add     eax, esi
	mov     dword [ebx+0x5C], eax
	mov     eax, dword [esp+0x18]
	add     eax, ecx
	mov     ecx, ebx
	mov     dword [ebx+0x60], eax
	mov     ebx, dword [esp+0x0C]
	mov     eax, dword [esp+0x1C]
	add     eax, ebx
	mov     dword [ecx+0x64], eax
	mov     eax, dword [esp+0x34]
	add     eax, ebp
	mov     dword [ecx+0x68], eax
	add     esp, 316
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x0D
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   16

sha256_init:; Function begin
	mov     eax, dword [esp+0x4]
	mov     dword [eax+0x40], 0
	mov     dword [eax+0x44], 0
	mov     dword [eax+0x48], 0
	mov     dword [eax+0x4C], 1779033703
	mov     dword [eax+0x50], -1150833019
	mov     dword [eax+0x54], 1013904242
	mov     dword [eax+0x58], -1521486534
	mov     dword [eax+0x5C], 1359893119
	mov     dword [eax+0x60], -1694144372
	mov     dword [eax+0x64], 528734635
	mov     dword [eax+0x68], 1541459225
	ret

; Filling space: 0x0E
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_update:; Function begin
	push    edi
	push    esi
	push    ebx
	mov     esi, dword [esp+0x18]
	mov     edi, dword [esp+0x10]
	test    esi, esi
	jz      loc_007
	mov     ebx, dword [esp+0x14]
	add     esi, ebx
	jmp     loc_006

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_005:  add     ebx, 1
	cmp     ebx, esi
	jz      loc_007
loc_006:  mov     eax, dword [edi+0x40]
	movzx   edx, byte [ebx]
	mov     byte [edi+eax], dl
	add     eax, 1
	mov     dword [edi+0x40], eax
	cmp     eax, 64
	jnz     loc_005
	mov     edx, edi
	mov     eax, edi
	call    sha256_transform
	add     dword [edi+0x44], 512
	adc     dword [edi+0x48], 0
	add     ebx, 1
	mov     dword [edi+0x40], 0
	cmp     ebx, esi
	jnz     loc_006
loc_007:  pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

sha256_final:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 12
	mov     ebx, dword [esp+0x20]
	mov     esi, dword [ebx+0x40]
	mov     byte [ebx+esi], 128
	lea     edx, [esi+0x1]
	cmp     esi, 55
	ja      loc_010
	cmp     edx, 56
	jz      loc_008
	mov     eax, 55
	lea     ecx, [ebx+edx]
	xor     ebp, ebp
	sub     eax, esi
	cmp     eax, 4
	jnc     loc_014
	test    eax, eax
	jne     loc_016
loc_008:  mov     eax, dword [ebx+0x44]
	mov     edx, dword [ebx+0x48]
	shl     esi, 3
	add     eax, esi
	adc     edx, 0
	mov     dword [ebx+0x44], eax
	bswap   eax
	mov     dword [ebx+0x48], edx
	bswap   edx
	mov     dword [ebx+0x3C], eax
	mov     eax, ebx
	mov     dword [ebx+0x38], edx
	mov     edx, ebx
	call    sha256_transform
	mov     eax, dword [esp+0x24]
	mov     ecx, 24
loc_009:  mov     edx, dword [ebx+0x4C]
	add     eax, 1
	shr     edx, cl
	mov     byte [eax-0x1], dl
	mov     edx, dword [ebx+0x50]
	shr     edx, cl
	mov     byte [eax+0x3], dl
	mov     edx, dword [ebx+0x54]
	shr     edx, cl
	mov     byte [eax+0x7], dl
	mov     edx, dword [ebx+0x58]
	shr     edx, cl
	mov     byte [eax+0x0B], dl
	mov     edx, dword [ebx+0x5C]
	shr     edx, cl
	mov     byte [eax+0x0F], dl
	mov     edx, dword [ebx+0x60]
	shr     edx, cl
	mov     byte [eax+0x13], dl
	mov     edx, dword [ebx+0x64]
	shr     edx, cl
	mov     byte [eax+0x17], dl
	mov     edx, dword [ebx+0x68]
	shr     edx, cl
	sub     ecx, 8
	mov     byte [eax+0x1B], dl
	cmp     ecx, -8
	jnz     loc_009
	add     esp, 12
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_010:  cmp     edx, 63
	ja      loc_011
	mov     eax, 63
	lea     ecx, [ebx+edx]
	xor     ebp, ebp
	sub     eax, esi
	cmp     eax, 4
	jnc     loc_012
	test    eax, eax
	jne     loc_017
loc_011:  mov     eax, ebx
	mov     edx, ebx
	lea     edi, [ebx+0x4]
	call    sha256_transform
	and     edi, 0x0FFFFFFFC
	mov     ecx, ebx
	xor     eax, eax
	sub     ecx, edi
	mov     dword [ebx], 0
	add     ecx, 56
	mov     dword [ebx+0x34], 0
	shr     ecx, 2
	rep stosd
	jmp     loc_008

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_012:  lea     edx, [ecx+0x4]
	mov     dword [ecx], 0
	and     edx, 0x0FFFFFFFC
	mov     dword [ecx+eax-0x4], 0
	sub     ecx, edx
	add     eax, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_011
	mov     edi, eax
	lea     ecx, [eax-0x1]
	and     edi, 0x0FFFFFFFC
	shr     ecx, 2
	mov     dword [esp+0x4], edi
	mov     edi, 4
	and     ecx, 0x01
	mov     dword [edx], 0
	cmp     edi, eax
	jnc     loc_011
	test    ecx, ecx
	jne     loc_019
loc_013:  mov     dword [edx+edi], ebp
	mov     dword [edx+edi+0x4], ebp
	mov     eax, dword [esp+0x4]
	add     edi, 8
	cmp     edi, eax
	jc      loc_013
	jmp     loc_011

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_014:  lea     edx, [ecx+0x4]
	mov     dword [ecx], 0
	and     edx, 0x0FFFFFFFC
	mov     dword [ecx+eax-0x4], 0
	sub     ecx, edx
	add     eax, ecx
	and     eax, 0x0FFFFFFFC
	cmp     eax, 4
	jc      loc_008
	mov     edi, eax
	lea     ecx, [eax-0x1]
	and     edi, 0x0FFFFFFFC
	shr     ecx, 2
	mov     dword [esp+0x4], edi
	mov     edi, 4
	and     ecx, 0x01
	mov     dword [edx], 0
	cmp     edi, eax
	jnc     loc_008
	test    ecx, ecx
	jnz     loc_018
loc_015:  mov     dword [edx+edi], ebp
	mov     dword [edx+edi+0x4], ebp
	mov     eax, dword [esp+0x4]
	add     edi, 8
	cmp     edi, eax
	jc      loc_015
	jmp     loc_008

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_016:  mov     byte [ecx], 0
	test    al, 0x02
	je      loc_008
	xor     edi, edi
	mov     word [ecx+eax-0x2], di
	jmp     loc_008

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_017:  mov     byte [ecx], 0
	test    al, 0x02
	je      loc_011
	xor     edx, edx
	mov     word [ecx+eax-0x2], dx
	jmp     loc_011

; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_018:  mov     dword [edx+0x4], 0
	mov     eax, dword [esp+0x4]
	mov     edi, 8
	cmp     edi, eax
	jc      loc_015
	jmp     loc_008

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_019:  mov     dword [edx+0x4], 0
	mov     eax, dword [esp+0x4]
	mov     edi, 8
	cmp     edi, eax
	jc      loc_013
	jmp     loc_011

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8

sha256_file:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 8364
	mov     eax, dword [esp+0x20C0]
	mov     ebp, dword [esp+0x20C4]
	test    eax, eax
	je      loc_024
	test    ebp, ebp
	je      loc_024
	sub     esp, 8
	push    loc_031
	push    eax
	call    fopen
	add     esp, 16
	test    eax, eax
	je      loc_024
	mov     dword [esp+0x74], 0
	lea     esi, [esp+0x34]
	lea     edi, [esp+0x0A0]
	mov     dword [esp+0x78], 0
	mov     dword [esp+0x7C], 0
	mov     dword [esp+0x80], 1779033703
	mov     dword [esp+0x84], -1150833019
	mov     dword [esp+0x88], 1013904242
	mov     dword [esp+0x8C], -1521486534
	mov     dword [esp+0x90], 1359893119
	mov     dword [esp+0x94], -1694144372
	mov     dword [esp+0x98], 528734635
	mov     dword [esp+0x9C], 1541459225
	mov     dword [esp+0x0C], eax
	mov     dword [esp+0x20C4], ebp
; Filling space: 0x9
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x90

ALIGN   16
loc_020:  push    dword [esp+0x0C]
	push    8192
	push    1
	push    edi
	call    fread
	add     esp, 16
	test    eax, eax
	jz      loc_025
	mov     ebx, edi
	lea     ebp, [edi+eax]
	jmp     loc_022

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_021:  add     ebx, 1
	cmp     ebx, ebp
	jz      loc_020
loc_022:  mov     eax, dword [esp+0x74]
	movzx   edx, byte [ebx]
	mov     byte [esp+eax+0x34], dl
	add     eax, 1
	mov     dword [esp+0x74], eax
	cmp     eax, 64
	jnz     loc_021
	mov     edx, esi
	mov     eax, esi
	call    sha256_transform
	add     dword [esp+0x78], 512
	mov     dword [esp+0x74], 0
	adc     dword [esp+0x7C], 0
	jmp     loc_021

loc_023:  sub     esp, 12
	push    edx
	call    fclose
	add     esp, 16
loc_024:  add     esp, 8364
	xor     eax, eax
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
loc_025:  mov     edx, dword [esp+0x0C]
	mov     ebp, dword [esp+0x20C4]
	sub     esp, 12
	push    edx
	mov     dword [esp+0x1C], edx
	call    ferror
	add     esp, 16
	mov     edx, dword [esp+0x0C]
	test    eax, eax
	jnz     loc_023
	sub     esp, 12
	mov     edi, ebp
	push    edx
	call    fclose
	pop     eax
	pop     edx
	lea     ebx, [esp+0x1C]
	push    ebx
	lea     esi, [esp+0x40]
	push    esi
	call    sha256_final
	add     esp, 16
; Filling space: 0x0E
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_026:  movzx   eax, byte [ebx]
	sub     esp, 4
	add     ebx, 1
	push    eax
	push    loc_032
	push    edi
	add     edi, 2
	call    sprintf
	add     esp, 16
	cmp     ebx, esi
	jnz     loc_026
	mov     byte [ebp+0x40], 0
	add     esp, 8364
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x0D
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   16

sha256_verify_file:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 116
	lea     edi, [esp+0x27]
	mov     esi, dword [esp+0x8C]
	push    edi
	push    dword [esp+0x8C]
	call    sha256_file
	add     esp, 16
	test    esi, esi
	je      loc_029
	test    al, 0x01
	jz      loc_029
	mov     dword [esp+0x0C], 0
	jmp     loc_028

; Note: No jump seems to point here
	jmp     loc_027

; Filling space: 0x36
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_027:  add     dword [esp+0x0C], 1
	mov     eax, dword [esp+0x0C]
	cmp     eax, 64
	jz      loc_030
loc_028:  mov     eax, dword [esp+0x0C]
	movzx   edx, byte [edi+eax]
	movzx   eax, byte [esi+eax]
	lea     ebp, [edx-0x41]
	lea     ebx, [edx+0x20]
	mov     ecx, ebp
	lea     ebp, [eax-0x41]
	cmp     cl, 6
	mov     ecx, ebp
	cmovc   edx, ebx
	lea     ebx, [eax+0x20]
	cmp     cl, 6
	cmovc   eax, ebx
	cmp     dl, al
	jz      loc_027
loc_029:  add     esp, 108
	xor     eax, eax
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_030:  add     esp, 108
	mov     eax, 1
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

SECTION .rodata.str1.1 align=1 noexec

loc_031:
	db 0x72, 0x62, 0x00

loc_032:
	db 0x25, 0x30, 0x32, 0x78, 0x00

SECTION .rodata align=32 noexec

k:
	dd 0x428A2F98, 0x71374491
	dd 0x0B5C0FBCF, 0x0E9B5DBA5
	dd 0x3956C25B, 0x59F111F1
	dd 0x923F82A4, 0x0AB1C5ED5
	dd 0x0D807AA98, 0x12835B01
	dd 0x243185BE, 0x550C7DC3
	dd 0x72BE5D74, 0x80DEB1FE
	dd 0x9BDC06A7, 0x0C19BF174
	dd 0x0E49B69C1, 0x0EFBE4786
	dd 0x0FC19DC6, 0x240CA1CC
	dd 0x2DE92C6F, 0x4A7484AA
	dd 0x5CB0A9DC, 0x76F988DA
	dd 0x983E5152, 0x0A831C66D
	dd 0x0B00327C8, 0x0BF597FC7
	dd 0x0C6E00BF3, 0x0D5A79147
	dd 0x06CA6351, 0x14292967
	dd 0x27B70A85, 0x2E1B2138
	dd 0x4D2C6DFC, 0x53380D13
	dd 0x650A7354, 0x766A0ABB
	dd 0x81C2C92E, 0x92722C85
	dd 0x0A2BFE8A1, 0x0A81A664B
	dd 0x0C24B8B70, 0x0C76C51A3
	dd 0x0D192E819, 0x0D6990624
	dd 0x0F40E3585, 0x106AA070
	dd 0x19A4C116, 0x1E376C08
	dd 0x2748774C, 0x34B0BCB5
	dd 0x391C0CB3, 0x4ED8AA4A
	dd 0x5B9CCA4F, 0x682E6FF3
	dd 0x748F82EE, 0x78A5636F
	dd 0x84C87814, 0x8CC70208
	dd 0x90BEFFFA, 0x0A4506CEB
	dd 0x0BEF9A3F7, 0x0C67178F2

