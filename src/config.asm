; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  config.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 config.asm -o config.o
; ---------------------------------------------------------

default rel

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
extern memcpy
extern valid_gentoo_chroot_path
extern valid_opt_level
extern strerror
extern ferror
extern valid_target_arch
extern strncmp
extern __isoc23_strtol
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
extern memset
extern strcmp
extern __stack_chk_fail
extern vsnprintf
extern strlen
extern __ctype_b_loc

SECTION .text   align=32 exec

trim:
	push    rbp
	push    rbx
	mov     rbx, rdi
	sub     rsp, 8
	call    __ctype_b_loc
	mov     rbp, qword [rax]
	movzx   eax, byte [rbx]
	test    byte [rbp+rax*2+0x1], 0x20
	jz      loc_002
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_001:  movzx   eax, byte [rbx+0x1]
	add     rbx, 1
	test    byte [rbp+rax*2+0x1], 0x20
	jnz     loc_001
loc_002:  mov     rdi, rbx
	call    strlen
	add     rax, rbx
	cmp     rbx, rax
	jc      loc_004
	jmp     loc_005

; Filling space: 0x1F
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_003:  sub     rax, 1
	cmp     rax, rbx
	jz      loc_005
loc_004:  movzx   edx, byte [rax-0x1]
	test    byte [rbp+rdx*2+0x1], 0x20
	jnz     loc_003
loc_005:  mov     byte [rax], 0
	add     rsp, 8
	mov     rax, rbx
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

error_format:
	sub     rsp, 216
	mov     qword [rsp+0x38], rcx
	mov     qword [rsp+0x40], r8
	mov     qword [rsp+0x48], r9
	test    al, al
	jz      loc_006
	movaps  oword [rsp+0x50], xmm0
	movaps  oword [rsp+0x60], xmm1
	movaps  oword [rsp+0x70], xmm2
	movaps  oword [rsp+0x80], xmm3
	movaps  oword [rsp+0x90], xmm4
	movaps  oword [rsp+0x0A0], xmm5
	movaps  oword [rsp+0x0B0], xmm6
	movaps  oword [rsp+0x0C0], xmm7
loc_006:
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x18], rax
	xor     eax, eax
	test    rdi, rdi
	jz      loc_007
	test    rsi, rsi
	jz      loc_007
	lea     rax, [rsp+0x0E0]
	mov     rcx, rsp
	mov     dword [rsp], 24
	mov     qword [rsp+0x8], rax
	lea     rax, [rsp+0x20]
	mov     dword [rsp+0x4], 48
	mov     qword [rsp+0x10], rax
	call    vsnprintf
loc_007:  mov     rax, qword [rsp+0x18]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_008
	add     rsp, 216
	ret

loc_008:
	call    __stack_chk_fail
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
parse_switch:
	push    rbp
	mov     rbp, rsi
	lea     rsi, [rel str_LC0]
	push    rbx
	mov     rbx, rdi
	sub     rsp, 8
	call    strcmp
	test    eax, eax
	jz      loc_009
	lea     rsi, [rel str_LC1]
	mov     rdi, rbx
	call    strcmp
	test    eax, eax
	jnz     loc_012
loc_009:  mov     dword [rbp], 1
loc_010:  mov     eax, 1
loc_011:  add     rsp, 8
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_012:  lea     rsi, [rel str_LC2]
	mov     rdi, rbx
	call    strcmp
	test    eax, eax
	jz      loc_009
	lea     rsi, [rel str_LC3]
	mov     rdi, rbx
	call    strcmp
	test    eax, eax
	jz      loc_014
	cmp     byte [rbx], 110
	jnz     loc_013
	cmp     byte [rbx+0x1], 111
	jnz     loc_013
	cmp     byte [rbx+0x2], 0
	jz      loc_014
	nop
loc_013:  lea     rsi, [rel str_LC4]
	mov     rdi, rbx
	call    strcmp
	test    eax, eax
	mov     eax, 0
	jnz     loc_011
loc_014:  mov     dword [rbp], 0
	jmp     loc_010

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

config_defaults.part.0:
	push    rbx
	mov     edx, 960
	xor     esi, esi
	mov     rbx, rdi
	call    memset
	mov     eax, 51
	movdqa  xmm0, oword [rel str_LC8]
	mov     dword [rbx+0x114], 1769234798
	mov     word [rbx+0x194], ax
	mov     esi, 512
	xor     eax, eax
	lea     rdi, [rbx+0x1B4]
	movups  oword [rbx+0x14], xmm0
	movdqa  xmm0, oword [rel str_LC9]
	lea     rcx, [rel str_LC6]
	lea     rdx, [rel str_LC7]
	mov     dword [rbx], 1
	movups  oword [rbx+0x24], xmm0
	movdqa  xmm0, oword [rel str_LC5]
	mov     qword [rbx+0x8], 300
	mov     dword [rbx+0x117], 6649449
	movups  oword [rbx+0x1A4], xmm0
	call    snprintf
	mov     qword [rbx+0x3B4], 0
	pop     rbx
	ret

; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

config_defaults:; Function begin
	test    rdi, rdi
	jz      loc_015
	jmp     config_defaults.part.0

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_015:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

config_load:; Function begin
	sub     rsp, 2152
	mov     qword [rsp], rdx
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x828], rax
	xor     eax, eax
	test    rdi, rdi
	je      loc_025
	mov     qword [rsp+0x848], r12
	mov     r12, rdi
	mov     qword [rsp+0x860], r15
	mov     r15, rsi
	call    config_defaults.part.0
	call    build_user
	test    rax, rax
	je      loc_027
	mov     rdi, rax
	mov     qword [rsp+0x838], rbx
	mov     qword [rsp+0x840], rbp
	mov     qword [rsp+0x850], r13
	mov     qword [rsp+0x858], r14
	call    getpwnam
	lea     rdi, [rel str_LC10]
	mov     rbx, rax
	call    getenv
	mov     rbp, rax
	test    rbx, rbx
	je      loc_032
	mov     rcx, qword [rbx+0x20]
	test    rcx, rcx
	je      loc_032
	test    rax, rax
	jz      loc_016
	cmp     byte [rax], 0
	jne     loc_031
loc_016:  lea     rbx, [rsp+0x20]
	lea     rdx, [rel str_LC12]
	mov     esi, 1024
	xor     eax, eax
	mov     rdi, rbx
	call    snprintf
loc_017:  lea     rsi, [rel str_LC14]
	mov     rdi, rbx
	call    fopen
	mov     r14, rax
	test    rax, rax
	je      loc_046
	xor     r13d, r13d
loc_018:  mov     rdx, r14
	mov     esi, 1024
	lea     rdi, [rsp+0x420]
	call    fgets
	test    rax, rax
	je      loc_037
	lea     rdi, [rsp+0x420]
	add     r13, 1
	call    trim
	mov     rbp, rax
	movzx   eax, byte [rax]
	test    al, al
	jz      loc_018
	cmp     al, 35
	jz      loc_018
	mov     esi, 61
	mov     rdi, rbp
	call    strchr
	test    rax, rax
	je      loc_039
	mov     byte [rax], 0
	lea     rdi, [rax+0x1]
	call    trim
	mov     rdi, rbp
	mov     rbx, rax
	call    trim
	mov     esi, 35
	mov     rdi, rbx
	mov     rbp, rax
	call    strchr
	test    rax, rax
	jz      loc_019
	mov     byte [rax], 0
	mov     rdi, rbx
	call    trim
	mov     rbx, rax
loc_019:  lea     rsi, [rel str_LC17]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_021
	lea     rsi, [rel str_LC18]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_030
	lea     rsi, [rel str_LC19]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_033
	lea     rsi, [rel str_LC20]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_029
	lea     rsi, [rel str_LC21]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_029
	lea     rsi, [rel str_LC22]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_034
	lea     rsi, [rel str_LC25]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_036
	lea     rsi, [rel str_LC26]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_036
	lea     rsi, [rel str_LC27]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_036
	lea     rsi, [rel str_LC28]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_036
	lea     rsi, [rel str_LC29]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_042
	lea     rsi, [rel str_LC30]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_042
	lea     rsi, [rel str_LC31]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_042
	lea     rsi, [rel str_LC32]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_042
	lea     rsi, [rel str_LC33]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_045
	lea     rsi, [rel str_LC34]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_045
	lea     rsi, [rel str_LC35]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_047
	lea     rsi, [rel str_LC36]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_047
	lea     rsi, [rel str_LC37]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_047
	lea     rsi, [rel str_LC38]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_047
	lea     rsi, [rel str_LC39]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_047
	lea     rsi, [rel str_LC40]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_049
	lea     rsi, [rel str_LC41]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_049
	lea     rsi, [rel str_LC42]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	je      loc_020
	lea     rsi, [rel str_LC43]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC44]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC45]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC46]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC47]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC48]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jz      loc_020
	lea     rsi, [rel str_LC49]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jne     loc_048
loc_020:  lea     rsi, [rsp+0x18]
	mov     rdi, rbx
	call    parse_switch
	test    eax, eax
	jz      loc_022
	mov     dword [r12+0x3B8], 1
	mov     eax, dword [rsp+0x18]
	mov     dword [r12+0x3B4], eax
	jmp     loc_018

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_021:  mov     rsi, r12
	mov     rdi, rbx
	call    parse_switch
	test    eax, eax
	jne     loc_018
loc_022:  mov     rsi, qword [rsp]
	mov     r9, rbx
	mov     r8, r13
	mov     rcx, rbp
	lea     rdx, [rel str_LC51]
	mov     rdi, r15
	xor     eax, eax
	call    error_format
loc_023:  mov     rdi, r14
	call    fclose
loc_024:  mov     rbx, qword [rsp+0x838]
	mov     rbp, qword [rsp+0x840]
	mov     r12, qword [rsp+0x848]
	mov     r13, qword [rsp+0x850]
	mov     r14, qword [rsp+0x858]
	mov     r15, qword [rsp+0x860]
loc_025:  xor     eax, eax
loc_026:  mov     rdx, qword [rsp+0x828]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jne     loc_044
	add     rsp, 2152
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_027:  lea     rdi, [rel str_LC10]
	call    getenv
loc_028:  mov     rsi, qword [rsp]
	mov     rdi, r15
	lea     rdx, [rel str_LC13]
	xor     eax, eax
	call    error_format
	mov     r12, qword [rsp+0x848]
	mov     r15, qword [rsp+0x860]
	jmp     loc_025

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_029:  lea     rsi, [r12+0x10]
	mov     rdi, rbx
	call    guide_policy_parse
	test    eax, eax
	je      loc_022
	jmp     loc_018

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_030:  lea     rsi, [r12+0x4]
	mov     rdi, rbx
	call    parse_switch
	test    eax, eax
	je      loc_022
	jmp     loc_018

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_031:  call    geteuid
	test    eax, eax
	jne     loc_035
	mov     rcx, qword [rbx+0x20]
	jmp     loc_016

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_032:  mov     rbx, qword [rsp+0x838]
	mov     rbp, qword [rsp+0x840]
	mov     r13, qword [rsp+0x850]
	mov     r14, qword [rsp+0x858]
	jmp     loc_028

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_033:  call    __errno_location
	mov     edx, 10
	lea     rsi, [rsp+0x18]
	mov     rdi, rbx
	mov     dword [rax], 0
	mov     qword [rsp+0x8], rax
	call    __isoc23_strtol
	mov     rcx, qword [rsp+0x8]
	mov     edx, dword [rcx]
	test    edx, edx
	jne     loc_022
	mov     rdx, qword [rsp+0x18]
	cmp     byte [rdx], 0
	jne     loc_022
	cmp     rax, 86400
	ja      loc_022
	mov     qword [r12+0x8], rax
	jmp     loc_018

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_034:  mov     edx, 8
	lea     rsi, [rel str_LC23]
	mov     rdi, rbx
	call    strncmp
	test    eax, eax
	jne     loc_022
	mov     rdi, rbx
	call    strlen
	cmp     rax, 255
	ja      loc_022
	lea     rdi, [r12+0x14]
	mov     rcx, rbx
	mov     esi, 256
	xor     eax, eax
	lea     rdx, [rel str_LC24]
	call    snprintf
	jmp     loc_018

loc_035:  lea     rbx, [rsp+0x20]
	mov     rcx, rbp
	mov     esi, 1024
	xor     eax, eax
	lea     rdx, [rel str_LC11]
	mov     rdi, rbx
	call    snprintf
	jmp     loc_017

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_036:  mov     rdi, rbx
	call    valid_target_arch
	test    eax, eax
	je      loc_022
	mov     rdi, rbx
	call    strlen
	cmp     rax, 127
	ja      loc_022
	lea     rdi, [r12+0x114]
	mov     rcx, rbx
	mov     esi, 128
	xor     eax, eax
	lea     rdx, [rel str_LC24]
	call    snprintf
	jmp     loc_018

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_037:  mov     rdi, r14
	call    ferror
	test    eax, eax
	jnz     loc_041
	mov     rdi, r14
	call    fclose
loc_038:  mov     rbx, qword [rsp+0x838]
	mov     rbp, qword [rsp+0x840]
	mov     eax, 1
	mov     r12, qword [rsp+0x848]
	mov     r13, qword [rsp+0x850]
	mov     r14, qword [rsp+0x858]
	mov     r15, qword [rsp+0x860]
	jmp     loc_026

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_039:  mov     rsi, qword [rsp]
	mov     rcx, r13
	lea     rdx, [rel str_LC16]
	mov     rdi, r15
loc_040:  call    error_format
	jmp     loc_023

loc_041:  call    __errno_location
	mov     edi, dword [rax]
	call    strerror
	mov     rsi, qword [rsp]
	lea     rdx, [rel str_LC52]
	mov     rdi, r15
	mov     rcx, rax
	xor     eax, eax
	jmp     loc_040

loc_042:  mov     rdi, rbx
	call    valid_opt_level
	test    eax, eax
	je      loc_022
	mov     rdi, rbx
	call    strlen
	cmp     rax, 16
	ja      loc_022
	movzx   eax, byte [rbx]
	cmp     al, 45
	jnz     loc_043
	movzx   eax, byte [rbx+0x1]
	add     rbx, 1
loc_043:  and     eax, 0x0FFFFFFDF
	lea     rdi, [r12+0x194]
	mov     esi, 16
	cmp     al, 79
	lea     rdx, [rel str_LC24]
	sete    al
	movzx   eax, al
	lea     rcx, [rbx+rax]
	xor     eax, eax
	call    snprintf
	jmp     loc_018

loc_044:  mov     qword [rsp+0x838], rbx
	mov     qword [rsp+0x840], rbp
	mov     qword [rsp+0x848], r12
	mov     qword [rsp+0x850], r13
	mov     qword [rsp+0x858], r14
	mov     qword [rsp+0x860], r15
	call    __stack_chk_fail
loc_045:  lea     rsi, [rsp+0x18]
	mov     rdi, rbx
	call    parse_switch
	test    eax, eax
	je      loc_022
	mov     dword [r12+0x1A8], 1
	mov     eax, dword [rsp+0x18]
	mov     dword [r12+0x1A4], eax
	jmp     loc_018

loc_046:  call    __errno_location
	mov     edi, dword [rax]
	cmp     edi, 2
	je      loc_038
	call    strerror
	mov     rsi, qword [rsp]
	lea     rdx, [rel str_LC15]
	mov     rdi, r15
	mov     rcx, rax
	xor     eax, eax
	call    error_format
	jmp     loc_024

loc_047:  lea     rsi, [rsp+0x18]
	mov     rdi, rbx
	call    parse_switch
	test    eax, eax
	je      loc_022
	movd    xmm1, dword [rsp+0x18]
	pshufd  xmm0, xmm1, 0x0E0
	movq    qword [r12+0x1AC], xmm0
	jmp     loc_018

loc_048:  mov     rsi, qword [rsp]
	mov     r8, rbp
	mov     rcx, r13
	mov     rdi, r15
	lea     rdx, [rel str_LC50]
	xor     eax, eax
	call    error_format
	jmp     loc_023

loc_049:
	mov     rdi, rbx
	call    valid_gentoo_chroot_path
	test    eax, eax
	je      loc_022
	lea     rdi, [r12+0x1B4]
	mov     rcx, rbx
	mov     esi, 512
	xor     eax, eax
	lea     rdx, [rel str_LC24]
	call    snprintf
	jmp     loc_018

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16

config_apply:; Function begin
	test    rdi, rdi
	je      loc_061
	push    rbx
	mov     rsi, rdi
	mov     rbx, rdi
	mov     edx, 960
	lea     rdi, [rel g_config]
	call    memcpy
	mov     edi, dword [rbx+0x4]
	mov     dword [rel g_initialized], 1
	call    set_interactive
	mov     rdi, qword [rbx+0x8]
	call    set_prompt_timeout
	mov     edi, dword [rbx]
	call    set_emerge_confirm
	mov     edi, dword [rbx+0x10]
	call    guide_set_policy
	cmp     byte [rbx+0x114], 0
	jne     loc_060
	cmp     byte [rbx+0x194], 0
	jne     loc_059
loc_050:  mov     edx, dword [rbx+0x1A8]
	test    edx, edx
	jnz     loc_058
loc_051:  mov     edi, dword [rbx+0x1AC]
	test    edi, edi
	jnz     loc_057
loc_052:  cmp     byte [rbx+0x1B4], 0
	jnz     loc_056
loc_053:  mov     eax, dword [rbx+0x3B8]
	test    eax, eax
	jnz     loc_055
loc_054:  pop     rbx
	ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_055:  mov     edi, dword [rbx+0x3B4]
	pop     rbx
	jmp     set_use_binary

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_056:  lea     rdi, [rbx+0x1B4]
	call    set_gentoo_chroot_path
	mov     eax, dword [rbx+0x3B8]
	test    eax, eax
	jz      loc_054
	jmp     loc_055

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_057:  call    set_gentoo_chroot
	mov     edi, dword [rbx+0x1B0]
	call    set_portage_imitation
	cmp     byte [rbx+0x1B4], 0
	jz      loc_053
	jmp     loc_056

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_058:  mov     edi, dword [rbx+0x1A4]
	call    set_use_pipe
	mov     edi, dword [rbx+0x1AC]
	test    edi, edi
	jz      loc_052
	jmp     loc_057

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_059:  lea     rdi, [rbx+0x194]
	call    set_opt_level
	mov     edx, dword [rbx+0x1A8]
	test    edx, edx
	je      loc_051
	jmp     loc_058

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_060:  lea     rdi, [rbx+0x114]
	call    set_target_arch
	cmp     byte [rbx+0x194], 0
	je      loc_050
	jmp     loc_059

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_061:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

config_current:; Function begin
	mov     edx, dword [rel g_initialized]
	lea     rax, [rel g_config]
	test    edx, edx
	jz      loc_062
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_062:  sub     rsp, 8
	mov     rdi, rax
	call    config_defaults.part.0
	lea     rax, [rel g_config]
	mov     dword [rel g_initialized], 1
	add     rsp, 8
	ret

SECTION .bss    align=32 noexec

g_initialized:
	resd    8                                       ; 0000

g_config:
	resb    960                                     ; 0020

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x74, 0x72, 0x75, 0x65, 0x00

str_LC1:
	db 0x79, 0x65, 0x73, 0x00

str_LC2:
	db 0x65, 0x6E, 0x61, 0x62, 0x6C, 0x65, 0x64, 0x00

str_LC3:
	db 0x66, 0x61, 0x6C, 0x73, 0x65, 0x00

str_LC4:
	db 0x64, 0x69, 0x73, 0x61, 0x62, 0x6C, 0x65, 0x64
	db 0x00

str_LC6:
	db 0x2F, 0x75, 0x73, 0x72, 0x2F, 0x6C, 0x6F, 0x63
	db 0x61, 0x6C, 0x2F, 0x65, 0x6D, 0x65, 0x72, 0x67
	db 0x65, 0x00

str_LC7:
	db 0x25, 0x73, 0x2F, 0x67, 0x65, 0x6E, 0x74, 0x6F
	db 0x6F, 0x2D, 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74
	db 0x00

str_LC10:
	db 0x58, 0x44, 0x47, 0x5F, 0x43, 0x4F, 0x4E, 0x46
	db 0x49, 0x47, 0x5F, 0x48, 0x4F, 0x4D, 0x45, 0x00

str_LC11:
	db 0x25, 0x73, 0x2F, 0x61, 0x72, 0x63, 0x68, 0x74
	db 0x6F, 0x6F, 0x2F, 0x63, 0x6F, 0x6E, 0x66, 0x69
	db 0x67, 0x00

str_LC12:
	db 0x25, 0x73, 0x2F, 0x2E, 0x63, 0x6F, 0x6E, 0x66
	db 0x69, 0x67, 0x2F, 0x61, 0x72, 0x63, 0x68, 0x74
	db 0x6F, 0x6F, 0x2F, 0x63, 0x6F, 0x6E, 0x66, 0x69
	db 0x67, 0x00

str_LC14:
	db 0x72, 0x00

str_LC15:
	db 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x6F
	db 0x70, 0x65, 0x6E, 0x20, 0x63, 0x6F, 0x6E, 0x66
	db 0x69, 0x67, 0x3A, 0x20, 0x25, 0x73, 0x00

str_LC16:
	db 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20, 0x6C
	db 0x69, 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75, 0x20
	db 0x68, 0x61, 0x73, 0x20, 0x6E, 0x6F, 0x20, 0x27
	db 0x3D, 0x27, 0x00

str_LC17:
	db 0x65, 0x6D, 0x65, 0x72, 0x67, 0x65, 0x5F, 0x63
	db 0x6F, 0x6E, 0x66, 0x69, 0x72, 0x6D, 0x00

str_LC18:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x5F, 0x63
	db 0x6F, 0x6E, 0x66, 0x69, 0x72, 0x6D, 0x00

str_LC19:
	db 0x70, 0x72, 0x6F, 0x6D, 0x70, 0x74, 0x5F, 0x74
	db 0x69, 0x6D, 0x65, 0x6F, 0x75, 0x74, 0x00

str_LC20:
	db 0x77, 0x65, 0x6C, 0x63, 0x6F, 0x6D, 0x65, 0x5F
	db 0x70, 0x6F, 0x6C, 0x69, 0x63, 0x79, 0x00

str_LC21:
	db 0x63, 0x6F, 0x6D, 0x6D, 0x61, 0x6E, 0x64, 0x5F
	db 0x67, 0x75, 0x69, 0x64, 0x65, 0x00

str_LC22:
	db 0x61, 0x75, 0x72, 0x5F, 0x72, 0x70, 0x63, 0x5F
	db 0x75, 0x72, 0x6C, 0x00

str_LC23:
	db 0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F
	db 0x00

str_LC24:
	db 0x25, 0x73, 0x00

str_LC25:
	db 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x5F, 0x61
	db 0x72, 0x63, 0x68, 0x00

str_LC26:
	db 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x00

str_LC27:
	db 0x6D, 0x61, 0x72, 0x63, 0x68, 0x00

str_LC28:
	db 0x63, 0x70, 0x75, 0x00

str_LC29:
	db 0x6F, 0x70, 0x74, 0x5F, 0x6C, 0x65, 0x76, 0x65
	db 0x6C, 0x00

str_LC30:
	db 0x6F, 0x70, 0x74, 0x00

str_LC31:
	db 0x6F, 0x70, 0x74, 0x69, 0x6D, 0x69, 0x7A, 0x61
	db 0x74, 0x69, 0x6F, 0x6E, 0x00

str_LC32:
	db 0x6F, 0x00

str_LC33:
	db 0x70, 0x69, 0x70, 0x65, 0x00

str_LC34:
	db 0x75, 0x73, 0x65, 0x5F, 0x70, 0x69, 0x70, 0x65
	db 0x00

str_LC35:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x63
	db 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x00

str_LC36:
	db 0x70, 0x6F, 0x72, 0x74, 0x61, 0x67, 0x65, 0x5F
	db 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x00

str_LC37:
	db 0x69, 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F
	db 0x6E, 0x00

str_LC38:
	db 0x70, 0x6F, 0x72, 0x74, 0x61, 0x67, 0x65, 0x5F
	db 0x69, 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F
	db 0x6E, 0x00

str_LC39:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x69
	db 0x6D, 0x69, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E
	db 0x00

str_LC40:
	db 0x67, 0x65, 0x6E, 0x74, 0x6F, 0x6F, 0x5F, 0x63
	db 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x5F, 0x70, 0x61
	db 0x74, 0x68, 0x00

str_LC41:
	db 0x63, 0x68, 0x72, 0x6F, 0x6F, 0x74, 0x5F, 0x70
	db 0x61, 0x74, 0x68, 0x00

str_LC42:
	db 0x62, 0x69, 0x6E, 0x61, 0x72, 0x79, 0x00

str_LC43:
	db 0x75, 0x73, 0x65, 0x5F, 0x62, 0x69, 0x6E, 0x61
	db 0x72, 0x79, 0x00

str_LC44:
	db 0x75, 0x73, 0x65, 0x5F, 0x62, 0x69, 0x6E, 0x00

str_LC45:
	db 0x62, 0x69, 0x6E, 0x00

str_LC46:
	db 0x70, 0x72, 0x65, 0x62, 0x75, 0x69, 0x6C, 0x74
	db 0x00

str_LC47:
	db 0x75, 0x73, 0x65, 0x5F, 0x70, 0x72, 0x65, 0x62
	db 0x75, 0x69, 0x6C, 0x74, 0x00

str_LC48:
	db 0x6E, 0x6F, 0x5F, 0x62, 0x75, 0x69, 0x6C, 0x64
	db 0x00

str_LC49:
	db 0x6E, 0x6F, 0x2D, 0x62, 0x75, 0x69, 0x6C, 0x64
	db 0x00

str_LC52:
	db 0x65, 0x72, 0x72, 0x6F, 0x72, 0x20, 0x72, 0x65
	db 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20, 0x63, 0x6F
	db 0x6E, 0x66, 0x69, 0x67, 0x3A, 0x20, 0x25, 0x73
	db 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC13:
	db 0x63, 0x61, 0x6E, 0x6E, 0x6F, 0x74, 0x20, 0x64
	db 0x65, 0x74, 0x65, 0x72, 0x6D, 0x69, 0x6E, 0x65
	db 0x20, 0x69, 0x6E, 0x76, 0x6F, 0x6B, 0x69, 0x6E
	db 0x67, 0x20, 0x75, 0x73, 0x65, 0x72, 0x27, 0x73
	db 0x20, 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20
	db 0x70, 0x61, 0x74, 0x68, 0x00, 0x00, 0x00, 0x00

str_LC50:
	db 0x75, 0x6E, 0x6B, 0x6E, 0x6F, 0x77, 0x6E, 0x20
	db 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x20, 0x6B
	db 0x65, 0x79, 0x20, 0x6F, 0x6E, 0x20, 0x6C, 0x69
	db 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75, 0x3A, 0x20
	db 0x25, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC51:
	db 0x69, 0x6E, 0x76, 0x61, 0x6C, 0x69, 0x64, 0x20
	db 0x76, 0x61, 0x6C, 0x75, 0x65, 0x20, 0x66, 0x6F
	db 0x72, 0x20, 0x25, 0x73, 0x20, 0x6F, 0x6E, 0x20
	db 0x6C, 0x69, 0x6E, 0x65, 0x20, 0x25, 0x6C, 0x75
	db 0x3A, 0x20, 0x25, 0x73, 0x00

SECTION .rodata.cst16 align=16 noexec

ALIGN   16
str_LC5:
	dq 0x0000000000000001
	dq 0x0000000000000000

str_LC8:
	dq 0x2F2F3A7370747468
	dq 0x686372612E727561

str_LC9:
	dq 0x726F2E78756E696C
	dq 0x35762F6370722F67

