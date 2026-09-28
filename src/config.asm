; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  config.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 config.asm -o config.o
; ---------------------------------------------------------

global config_defaults: function
global config_load: function
global config_apply: function
global config_current: function

extern set_target_arch
extern set_opt_level
extern set_use_pipe
extern set_portage_imitation
extern set_gentoo_chroot
extern set_gentoo_chroot_path
extern set_use_binary
extern guide_set_policy
extern set_emerge_confirm
extern set_prompt_timeout
extern set_interactive
extern valid_gentoo_chroot_path
extern valid_opt_level
extern set_makepkg_raw
extern set_raw_flags
extern valid_raw_flags
extern strerror
extern ferror
extern valid_target_arch
extern strncmp
extern strtol
extern __errno_location
extern geteuid
extern guide_policy_parse
extern fclose
extern strchr
extern fgets
extern fopen
extern getenv
extern getpwnam
extern build_user
extern snprintf
extern vsnprintf
extern strlen
extern __ctype_b_loc
extern strcmp

SECTION .text   align=32 exec

parse_switch:
	push    esi
	mov     esi, edx
	push    ebx
	mov     ebx, eax
	sub     esp, 12
	push    loc_059
	push    eax
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_001
	sub     esp, 8
	push    loc_060
	push    ebx
	call    strcmp
	add     esp, 16
	test    eax, eax
	jnz     loc_004
loc_001:  mov     dword [esi], 1
loc_002:  mov     eax, 1
loc_003:  add     esp, 4
	pop     ebx
	pop     esi
	ret

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_004:  sub     esp, 8
	push    loc_061
	push    ebx
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_001
	sub     esp, 8
	push    loc_062
	push    ebx
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_006
	cmp     byte [ebx], 110
	jnz     loc_005
	cmp     byte [ebx+0x1], 111
	jnz     loc_005
	cmp     byte [ebx+0x2], 0
	jz      loc_006
; Filling space: 0x0D
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_005:  sub     esp, 8
	push    loc_063
	push    ebx
	call    strcmp
	add     esp, 16
	mov     edx, eax
	xor     eax, eax
	test    edx, edx
	jnz     loc_003
loc_006:  mov     dword [esi], 0
	jmp     loc_002

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

trim:
	push    esi
	push    ebx
	mov     ebx, eax
	sub     esp, 4
	call    __ctype_b_loc
	mov     esi, dword [eax]
	movzx   eax, byte [ebx]
	test    byte [esi+eax*2+0x1], 0x20
	jz      loc_008
; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_007:  movzx   eax, byte [ebx+0x1]
	add     ebx, 1
	test    byte [esi+eax*2+0x1], 0x20
	jnz     loc_007
loc_008:  sub     esp, 12
	push    ebx
	call    strlen
	add     esp, 16
	add     eax, ebx
	cmp     ebx, eax
	jc      loc_010
	jmp     loc_011

; Note: No jump seems to point here
	jmp     loc_009

; Filling space: 0x1C
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   16
loc_009:  sub     eax, 1
	cmp     eax, ebx
	jz      loc_011
loc_010:  movzx   edx, byte [eax-0x1]
	test    byte [esi+edx*2+0x1], 0x20
	jnz     loc_009
loc_011:  mov     byte [eax], 0
	add     esp, 4
	mov     eax, ebx
	pop     ebx
	pop     esi
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8

error_format:
	sub     esp, 12
	mov     eax, dword [esp+0x10]
	mov     edx, dword [esp+0x14]
	test    eax, eax
	jz      loc_012
	test    edx, edx
	jz      loc_012
	lea     ecx, [esp+0x1C]
	push    ecx
	push    dword [esp+0x1C]
	push    edx
	push    eax
	call    vsnprintf
	add     esp, 16
loc_012:  add     esp, 12
	ret

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8

config_defaults.part.0:
	push    edi
	lea     edi, [eax+0x4]
	mov     ecx, eax
	push    ebx
	and     edi, 0x0FFFFFFFC
	mov     ebx, eax
	sub     ecx, edi
	add     ecx, 952
	sub     esp, 4
	shr     ecx, 2
	mov     dword [eax+0x3B4], 0
	xor     eax, eax
	rep stosd
	mov     eax, 51
	mov     dword [ebx], 1
	mov     word [ebx+0x190], ax
	lea     eax, [ebx+0x1B0]
	mov     dword [ebx+0x110], 1769234798
	mov     dword [ebx+0x8], 300
	mov     dword [ebx+0x10], 1886680168
	mov     dword [ebx+0x14], 791624307
	mov     dword [ebx+0x18], 779253089
	mov     dword [ebx+0x1C], 1751347809
	mov     dword [ebx+0x20], 1970170220
	mov     dword [ebx+0x24], 1919889016
	mov     dword [ebx+0x28], 1886531431
	mov     dword [ebx+0x2C], 896937827
	mov     byte [ebx+0x30], 0
	mov     dword [ebx+0x113], 6649449
	mov     dword [ebx+0x1A0], 1
	mov     dword [ebx+0x1A4], 0
	mov     dword [ebx+0x1A8], 0
	mov     dword [ebx+0x1AC], 0
	push    loc_064
	push    loc_065
	push    512
	push    eax
	call    snprintf
	mov     dword [ebx+0x3B0], 0
	mov     dword [ebx+0x3B4], 0
	add     esp, 20
	pop     ebx
	pop     edi
	ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

config_defaults:; Function begin
	mov     eax, dword [esp+0x4]
	test    eax, eax
	jz      loc_013
	jmp     config_defaults.part.0

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_013:  ret

; Filling space: 0x0F
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16

config_load:; Function begin
	push    ebp
	push    edi
	push    esi
	push    ebx
	sub     esp, 2092
	mov     ecx, dword [esp+0x840]
	test    ecx, ecx
	je      loc_022
	mov     eax, dword [esp+0x840]
	call    config_defaults.part.0
	call    build_user
	test    eax, eax
	je      loc_024
	sub     esp, 12
	push    eax
	call    getpwnam
	mov     dword [esp], loc_066
	mov     ebx, eax
	call    getenv
	add     esp, 16
	mov     esi, eax
	test    ebx, ebx
	je      loc_025
	mov     eax, dword [ebx+0x14]
	test    eax, eax
	je      loc_025
	test    esi, esi
	jz      loc_014
	cmp     byte [esi], 0
	jne     loc_028
loc_014:  push    eax
	push    loc_068
loc_015:  push    1024
	lea     ebx, [esp+0x2C]
	push    ebx
	call    snprintf
	add     esp, 16
	sub     esp, 8
	push    loc_069
	push    ebx
	call    fopen
	add     esp, 16
	mov     esi, eax
	test    eax, eax
	je      loc_042
	xor     edi, edi
loc_016:  sub     esp, 4
	push    esi
	push    1024
	lea     eax, [esp+0x42C]
	push    eax
	call    fgets
	add     esp, 16
	test    eax, eax
	je      loc_033
	lea     eax, [esp+0x420]
	add     edi, 1
	call    trim
	mov     ebp, eax
	movzx   eax, byte [eax]
	test    al, al
	jz      loc_016
	cmp     al, 35
	jz      loc_016
	sub     esp, 8
	push    61
	push    ebp
	call    strchr
	add     esp, 16
	test    eax, eax
	je      loc_035
	mov     byte [eax], 0
	add     eax, 1
	call    trim
	mov     ebx, eax
	mov     eax, ebp
	call    trim
	sub     esp, 8
	push    35
	mov     ebp, eax
	push    ebx
	call    strchr
	add     esp, 16
	test    eax, eax
	jz      loc_017
	mov     byte [eax], 0
	mov     eax, ebx
	call    trim
	mov     ebx, eax
loc_017:  sub     esp, 8
	push    loc_072
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_019
	sub     esp, 8
	push    loc_073
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_027
	sub     esp, 8
	push    loc_074
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_029
	sub     esp, 8
	push    loc_075
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_026
	sub     esp, 8
	push    loc_076
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_026
	sub     esp, 8
	push    loc_077
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_030
	sub     esp, 8
	push    loc_080
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_032
	sub     esp, 8
	push    loc_081
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_032
	sub     esp, 8
	push    loc_082
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_032
	sub     esp, 8
	push    loc_083
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_032
	sub     esp, 8
	push    loc_084
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_037
	sub     esp, 8
	push    loc_085
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_037
	sub     esp, 8
	push    loc_086
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_038
	push    eax
	push    eax
	push    loc_087
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_038
	push    eax
	push    eax
	push    loc_088
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_039
	push    eax
	push    eax
	push    loc_089
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_039
	push    eax
	push    eax
	push    loc_090
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_039
	push    eax
	push    eax
	push    loc_091
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_039
	push    ecx
	push    ecx
	push    loc_092
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_046
	push    edx
	push    edx
	push    loc_093
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_046
	push    eax
	push    eax
	push    loc_094
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_045
	push    eax
	push    eax
	push    loc_095
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_045
	push    eax
	push    eax
	push    loc_096
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_045
	push    eax
	push    eax
	push    loc_097
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_045
	push    eax
	push    eax
	push    loc_098
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_045
	push    ecx
	push    ecx
	push    loc_099
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_043
	push    edx
	push    edx
	push    loc_100
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_043
	push    eax
	push    eax
	push    loc_101
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	je      loc_018
	push    eax
	push    eax
	push    loc_102
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    eax
	push    eax
	push    loc_103
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    eax
	push    eax
	push    loc_104
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    eax
	push    eax
	push    loc_105
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    ecx
	push    ecx
	push    loc_106
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    edx
	push    edx
	push    loc_107
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jz      loc_018
	push    eax
	push    eax
	push    loc_108
	push    ebp
	call    strcmp
	add     esp, 16
	test    eax, eax
	jne     loc_044
loc_018:  lea     edx, [esp+0x1C]
	mov     eax, ebx
	call    parse_switch
	test    eax, eax
	jz      loc_020
	mov     ecx, dword [esp+0x840]
	mov     eax, dword [esp+0x1C]
	mov     dword [ecx+0x3B4], 1
	mov     dword [ecx+0x3B0], eax
	jmp     loc_016

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_019:  mov     edx, dword [esp+0x840]
	mov     eax, ebx
	call    parse_switch
	test    eax, eax
	jne     loc_016
loc_020:  sub     esp, 8
	push    ebx
	push    edi
	push    ebp
	push    loc_112
loc_021:  push    dword [esp+0x860]
	push    dword [esp+0x860]
	call    error_format
	add     esp, 20
	push    esi
	call    fclose
	add     esp, 16
loc_022:  xor     eax, eax
loc_023:  add     esp, 2092
	pop     ebx
	pop     esi
	pop     edi
	pop     ebp
	ret

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_024:  sub     esp, 12
	push    loc_066
	call    getenv
	add     esp, 16
loc_025:  sub     esp, 4
	push    loc_110
	push    dword [esp+0x850]
	push    dword [esp+0x850]
	call    error_format
	add     esp, 16
	jmp     loc_022

loc_026:  sub     esp, 8
	mov     eax, dword [esp+0x848]
	add     eax, 12
	push    eax
	push    ebx
	call    guide_policy_parse
	add     esp, 16
	test    eax, eax
	je      loc_020
	jmp     loc_016

; Filling space: 0x4
; Filler type: lea with same source and destination
;       db 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_027:  mov     eax, dword [esp+0x840]
	lea     edx, [eax+0x4]
	mov     eax, ebx
	call    parse_switch
	test    eax, eax
	je      loc_020
	jmp     loc_016

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_028:  call    geteuid
	test    eax, eax
	jne     loc_031
	mov     eax, dword [ebx+0x14]
	jmp     loc_014

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_029:  call    __errno_location
	sub     esp, 4
	mov     dword [esp+0x10], eax
	mov     dword [eax], 0
	push    10
	lea     eax, [esp+0x24]
	push    eax
	push    ebx
	call    strtol
	mov     edx, dword [esp+0x1C]
	add     esp, 16
	mov     edx, dword [edx]
	test    edx, edx
	jne     loc_020
	mov     edx, dword [esp+0x1C]
	cmp     byte [edx], 0
	jne     loc_020
	cmp     eax, 86400
	ja      loc_020
	mov     ecx, dword [esp+0x840]
	mov     dword [ecx+0x8], eax
	jmp     loc_016

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_030:  sub     esp, 4
	push    8
	push    loc_078
	push    ebx
	call    strncmp
	add     esp, 16
	test    eax, eax
	jne     loc_020
	sub     esp, 12
	push    ebx
	call    strlen
	add     esp, 16
	cmp     eax, 255
	ja      loc_020
	push    ebx
	push    loc_079
	push    256
	mov     eax, dword [esp+0x84C]
	add     eax, 16
	push    eax
	call    snprintf
	add     esp, 16
	jmp     loc_016

; Filling space: 0x3
; Filler type: lea with same source and destination
;       db 0x8D, 0x76, 0x00

ALIGN   8
loc_031:  push    esi
	push    loc_067
	jmp     loc_015

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_032:  sub     esp, 12
	push    ebx
	call    valid_target_arch
	add     esp, 16
	test    eax, eax
	je      loc_020
	sub     esp, 12
	push    ebx
	call    strlen
	add     esp, 16
	cmp     eax, 127
	ja      loc_020
	push    ebx
	push    loc_079
	push    128
	mov     eax, dword [esp+0x84C]
	add     eax, 272
	push    eax
	call    snprintf
	add     esp, 16
	jmp     loc_016

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_033:  sub     esp, 12
	push    esi
	call    ferror
	add     esp, 16
	test    eax, eax
	jnz     loc_036
	sub     esp, 12
	push    esi
	call    fclose
	add     esp, 16
loc_034:  mov     eax, 1
	jmp     loc_023

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_035:  push    edi
	push    loc_071
	push    dword [esp+0x850]
	push    dword [esp+0x850]
	call    error_format
	mov     dword [esp], esi
	call    fclose
	add     esp, 16
	jmp     loc_022

loc_036:  call    __errno_location
	sub     esp, 12
	push    dword [eax]
	call    strerror
	push    eax
	push    loc_109
	push    dword [esp+0x860]
	push    dword [esp+0x860]
	call    error_format
	add     esp, 20
	push    esi
	call    fclose
	add     esp, 16
	jmp     loc_022

loc_037:  sub     esp, 12
	push    ebx
	call    valid_raw_flags
	add     esp, 16
	test    eax, eax
	je      loc_020
	sub     esp, 12
	push    ebx
	call    set_raw_flags
	add     esp, 16
	jmp     loc_016

loc_038:  sub     esp, 12
	push    ebx
	call    valid_raw_flags
	add     esp, 16
	test    eax, eax
	je      loc_020
	sub     esp, 12
	push    ebx
	call    set_makepkg_raw
	add     esp, 16
	jmp     loc_016

loc_039:  sub     esp, 12
	push    ebx
	call    valid_opt_level
	add     esp, 16
	test    eax, eax
	je      loc_020
	sub     esp, 12
	push    ebx
	call    strlen
	add     esp, 16
	cmp     eax, 16
	ja      loc_020
	cmp     byte [ebx], 45
	jnz     loc_040
	add     ebx, 1
loc_040:  movzx   eax, byte [ebx]
	and     eax, 0x0FFFFFFDF
	cmp     al, 79
	jnz     loc_041
	add     ebx, 1
loc_041:  push    ebx
	push    loc_079
	push    16
	mov     eax, dword [esp+0x84C]
	add     eax, 400
	push    eax
	call    snprintf
	add     esp, 16
	jmp     loc_016

loc_042:  call    __errno_location
	mov     eax, dword [eax]
	cmp     eax, 2
	je      loc_034
	sub     esp, 12
	push    eax
	call    strerror
	push    eax
	push    loc_070
	push    dword [esp+0x860]
	push    dword [esp+0x860]
	call    error_format
	add     esp, 32
	jmp     loc_022

loc_043:  sub     esp, 12
	push    ebx
	call    valid_gentoo_chroot_path
	add     esp, 16
	test    eax, eax
	je      loc_020
	push    ebx
	push    loc_079
	push    512
	mov     eax, dword [esp+0x84C]
	add     eax, 432
	push    eax
	call    snprintf
	add     esp, 16
	jmp     loc_016

loc_044:  sub     esp, 12
	push    ebp
	push    edi
	push    loc_111
	jmp     loc_021

loc_045:  lea     edx, [esp+0x1C]
	mov     eax, ebx
	call    parse_switch
	test    eax, eax
	je      loc_020
	mov     eax, dword [esp+0x1C]
	mov     ecx, dword [esp+0x840]
	mov     dword [ecx+0x1A8], eax
	mov     dword [ecx+0x1AC], eax
	jmp     loc_016

loc_046:
	lea     edx, [esp+0x1C]
	mov     eax, ebx
	call    parse_switch
	test    eax, eax
	je      loc_020
	mov     ecx, dword [esp+0x840]
	mov     eax, dword [esp+0x1C]
	mov     dword [ecx+0x1A4], 1
	mov     dword [ecx+0x1A0], eax
	jmp     loc_016

config_apply:; Function begin
	push    edi
	push    esi
	push    ebx
	mov     ebx, dword [esp+0x10]
	test    ebx, ebx
	je      loc_051
	mov     edi, g_config
	mov     ecx, 238
	mov     esi, ebx
	sub     esp, 12
	rep movsd
	mov     dword [g_initialized], 1
	push    dword [ebx+0x4]
	call    set_interactive
	pop     esi
	push    dword [ebx+0x8]
	call    set_prompt_timeout
	pop     edi
	push    dword [ebx]
	call    set_emerge_confirm
	pop     eax
	push    dword [ebx+0x0C]
	call    guide_set_policy
	add     esp, 16
	cmp     byte [ebx+0x110], 0
	jne     loc_057
	cmp     byte [ebx+0x190], 0
	jne     loc_056
loc_047:  mov     ecx, dword [ebx+0x1A4]
	test    ecx, ecx
	jne     loc_055
loc_048:  mov     eax, dword [ebx+0x1A8]
	test    eax, eax
	jnz     loc_054
loc_049:  cmp     byte [ebx+0x1B0], 0
	jnz     loc_053
loc_050:  mov     eax, dword [ebx+0x3B4]
	test    eax, eax
	jnz     loc_052
loc_051:  pop     ebx
	pop     esi
	pop     edi
	ret

; Filling space: 0x8
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_052:  mov     eax, dword [ebx+0x3B0]
	mov     dword [esp+0x10], eax
	pop     ebx
	pop     esi
	pop     edi
	jmp     set_use_binary

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_053:  sub     esp, 12
	lea     eax, [ebx+0x1B0]
	push    eax
	call    set_gentoo_chroot_path
	mov     eax, dword [ebx+0x3B4]
	add     esp, 16
	test    eax, eax
	jz      loc_051
	jmp     loc_052

; Filling space: 0x0A
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x90

ALIGN   16
loc_054:  sub     esp, 12
	push    eax
	call    set_gentoo_chroot
	pop     edx
	push    dword [ebx+0x1AC]
	call    set_portage_imitation
	add     esp, 16
	cmp     byte [ebx+0x1B0], 0
	jz      loc_050
	jmp     loc_053

; Filling space: 0x5
; Filler type: lea with same source and destination
;       db 0x2E, 0x8D, 0x74, 0x26, 0x00

ALIGN   8
loc_055:  sub     esp, 12
	push    dword [ebx+0x1A0]
	call    set_use_pipe
	mov     eax, dword [ebx+0x1A8]
	add     esp, 16
	test    eax, eax
	je      loc_049
	jmp     loc_054

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_056:  sub     esp, 12
	lea     eax, [ebx+0x190]
	push    eax
	call    set_opt_level
	mov     ecx, dword [ebx+0x1A4]
	add     esp, 16
	test    ecx, ecx
	je      loc_048
	jmp     loc_055

; Filling space: 0x6
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B6, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_057:  sub     esp, 12
	lea     eax, [ebx+0x110]
	push    eax
	call    set_target_arch
	add     esp, 16
	cmp     byte [ebx+0x190], 0
	je      loc_047
	jmp     loc_056

; Filling space: 0x7
; Filler type: lea with same source and destination
;       db 0x8D, 0x0B4, 0x26, 0x00, 0x00, 0x00, 0x00

ALIGN   8

config_current:; Function begin
	mov     eax, dword [g_initialized]
	test    eax, eax
	jz      loc_058
	mov     eax, g_config
	ret

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_058:  sub     esp, 12
	mov     eax, g_config
	call    config_defaults.part.0
	mov     eax, g_config
	mov     dword [g_initialized], 1
	add     esp, 12
	ret

SECTION .bss    align=32 noexec

g_initialized:
	resd    8                                       ; 0000

g_config:
	resb    952                                     ; 0020

SECTION .rodata.str1.1 align=1 noexec

loc_059:
	db 0x74, 0x72, 0x75, 0x65, 0x00

loc_060:
	db 0x79, 0x65, 0x73, 0x00

loc_061:
	db 0x65, 0x6E, 0x61, 0x62, 0x6C, 0x65, 0x64, 0x00

loc_062:
	db 0x66, 0x61, 0x6C, 0x73, 0x65, 0x00

loc_063:
	db 0x64, 0x69, 0x73, 0x61, 0x62, 0x6C, 0x65, 0x64
	db 0x00

loc_064:
	db 0x2F, 0x75, 0x73, 0x72, 0x2F, 0x6C, 0x6F, 0x63
	db 0x61, 0x6C, 0x2F, 0x65, 0x6D, 0x65, 0x72, 0x67
	db 0x65, 0x00

loc_065:
	db 0x25, 0x73, 0x2F, 0x67, 0x65, 0x6E, 0x74, 0x6F
	db 0x6F, 0x2D, 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74
	db 0x00

loc_066:
	db 0x58, 0x44, 0x47, 0x5F, 0x43, 0x4F, 0x4E, 0x46
	db 0x49, 0x47, 0x5F, 0x48, 0x4F, 0x4D, 0x45, 0x00

loc_067:
	db 0x25, 0x73, 0x2F, 0x61, 0x72, 0x63, 0x68, 0x74
	db 0x6F, 0x6F, 0x2F, 0x63, 0x6F, 0x6E, 0x66, 0x69
	db 0x67, 0x00

loc_068:
	db 0x25, 0x73, 0x2F, 0x2E, 0x63, 0x6F, 0x6E, 0x66
	db 0x69, 0x67, 0x2F, 0x61, 0x72, 0x63, 0x68, 0x74
	db 0x6F, 0x6F, 0x2F, 0x63, 0x6F, 0x6E, 0x66, 0x69
	db 0x67, 0x00

loc_069:
	db 0x72, 0x00

loc_070:
	db 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x6F
	db 0x70, 0x65, 0x6E, 0x20, 0x63, 0x6F, 0x6E, 0x66
	db 0x69, 0x67, 0x3A, 0x20, 0x25, 0x73, 0x00

loc_071:
	db 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20, 0x6C
	db 0x69, 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75, 0x20
	db 0x68, 0x61, 0x73, 0x20, 0x6E, 0x6F, 0x20, 0x27
	db 0x3D, 0x27, 0x00

loc_072:
	db 0x65, 0x6D, 0x65, 0x72, 0x67, 0x65, 0x5F, 0x63
	db 0x6F, 0x6E, 0x66, 0x69, 0x72, 0x6D, 0x00

loc_073:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x5F, 0x63
	db 0x6F, 0x6E, 0x66, 0x69, 0x72, 0x6D, 0x00

loc_074:
	db 0x70, 0x72, 0x6F, 0x6D, 0x70, 0x74, 0x5F, 0x74
	db 0x69, 0x6D, 0x65, 0x6F, 0x75, 0x74, 0x00

loc_075:
	db 0x77, 0x65, 0x6C, 0x63, 0x6F, 0x6D, 0x65, 0x5F
	db 0x70, 0x6F, 0x6C, 0x69, 0x63, 0x79, 0x00

loc_076:
	db 0x63, 0x6F, 0x6D, 0x6D, 0x61, 0x6E, 0x64, 0x5F
	db 0x67, 0x75, 0x69, 0x64, 0x65, 0x00

loc_077:
	db 0x61, 0x75, 0x72, 0x5F, 0x72, 0x70, 0x63, 0x5F
	db 0x75, 0x72, 0x6C, 0x00

loc_078:
	db 0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F
	db 0x00

loc_079:
	db 0x25, 0x73, 0x00

loc_080:
	db 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x5F, 0x61
	db 0x72, 0x63, 0x68, 0x00

loc_081:
	db 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x00

loc_082:
	db 0x6D, 0x61, 0x72, 0x63, 0x68, 0x00

loc_083:
	db 0x63, 0x70, 0x75, 0x00

loc_084:
	db 0x72, 0x61, 0x77, 0x00

loc_085:
	db 0x72, 0x61, 0x77, 0x5F, 0x66, 0x6C, 0x61, 0x67
	db 0x73, 0x00

loc_086:
	db 0x6D, 0x61, 0x6B, 0x65, 0x70, 0x6B, 0x67, 0x5F
	db 0x72, 0x61, 0x77, 0x00

loc_087:
	db 0x6D, 0x61, 0x6B, 0x65, 0x70, 0x6B, 0x67, 0x5F
	db 0x66, 0x6C, 0x61, 0x67, 0x73, 0x00

loc_088:
	db 0x6F, 0x70, 0x74, 0x5F, 0x6C, 0x65, 0x76, 0x65
	db 0x6C, 0x00

loc_089:
	db 0x6F, 0x70, 0x74, 0x00

loc_090:
	db 0x6F, 0x70, 0x74, 0x69, 0x6D, 0x69, 0x7A, 0x61
	db 0x74, 0x69, 0x6F, 0x6E, 0x00

loc_091:
	db 0x6F, 0x00

loc_092:
	db 0x70, 0x69, 0x70, 0x65, 0x00

loc_093:
	db 0x75, 0x73, 0x65, 0x5F, 0x70, 0x69, 0x70, 0x65
	db 0x00

loc_094:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x63
	db 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x00

loc_095:
	db 0x70, 0x6F, 0x72, 0x74, 0x61, 0x67, 0x65, 0x5F
	db 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x00

loc_096:
	db 0x69, 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F
	db 0x6E, 0x00

loc_097:
	db 0x70, 0x6F, 0x72, 0x74, 0x61, 0x67, 0x65, 0x5F
	db 0x69, 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F
	db 0x6E, 0x00

loc_098:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x69
	db 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E
	db 0x00

loc_099:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x63
	db 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x5F, 0x70, 0x61
	db 0x74, 0x68, 0x00

loc_100:
	db 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x5F, 0x70
	db 0x61, 0x74, 0x68, 0x00

loc_101:
	db 0x62, 0x69, 0x6E, 0x61, 0x72, 0x79, 0x00

loc_102:
	db 0x75, 0x73, 0x65, 0x5F, 0x62, 0x69, 0x6E, 0x61
	db 0x72, 0x79, 0x00

loc_103:
	db 0x75, 0x73, 0x65, 0x5F, 0x62, 0x69, 0x6E, 0x00

loc_104:
	db 0x62, 0x69, 0x6E, 0x00

loc_105:
	db 0x70, 0x72, 0x65, 0x62, 0x75, 0x69, 0x6C, 0x74
	db 0x00

loc_106:
	db 0x75, 0x73, 0x65, 0x5F, 0x70, 0x72, 0x65, 0x62
	db 0x75, 0x69, 0x6C, 0x74, 0x00

loc_107:
	db 0x6E, 0x6F, 0x5F, 0x62, 0x75, 0x69, 0x6C, 0x64
	db 0x00

loc_108:
	db 0x6E, 0x6F, 0x2D, 0x62, 0x75, 0x69, 0x6C, 0x64
	db 0x00

loc_109:
	db 0x65, 0x72, 0x72, 0x6F, 0x72, 0x20, 0x72, 0x65
	db 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20, 0x63, 0x6F
	db 0x6E, 0x66, 0x69, 0x67, 0x3A, 0x20, 0x25, 0x73
	db 0x00

SECTION .rodata.str1.4 align=4 noexec

loc_110:
	db 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x64
	db 0x65, 0x74, 0x65, 0x72, 0x6D, 0x69, 0x6E, 0x65
	db 0x20, 0x69, 0x6E, 0x76, 0x6F, 0x6B, 0x69, 0x6E
	db 0x67, 0x20, 0x75, 0x73, 0x65, 0x72, 0x27, 0x73
	db 0x20, 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20
	db 0x70, 0x61, 0x74, 0x68, 0x00, 0x00, 0x00, 0x00

loc_111:
	db 0x75, 0x6E, 0x6B, 0x6E, 0x6F, 0x77, 0x6E, 0x20
	db 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20, 0x6B
	db 0x65, 0x79, 0x20, 0x6F, 0x6E, 0x20, 0x6C, 0x69
	db 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75, 0x3A, 0x20
	db 0x25, 0x73, 0x00, 0x00

loc_112:
	db 0x69, 0x6E, 0x76, 0x61, 0x6C, 0x69, 0x64, 0x20
	db 0x76, 0x61, 0x6C, 0x75, 0x65, 0x20, 0x66, 0x6F
	db 0x72, 0x20, 0x25, 0x73, 0x20, 0x6F, 0x6E, 0x20
	db 0x6C, 0x69, 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75
	db 0x3A, 0x20, 0x25, 0x73, 0x00

