; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  provider.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 provider.asm -o provider.o
; ---------------------------------------------------------

default rel

global cmd_provider_v2: function

extern aur_response_destroy
extern aur_rpc_info
extern config_current
extern fprintf
extern stderr
extern __stack_chk_fail
extern dep_basename
extern strtok_r
extern strdup
extern valid_pkgname
extern strstr
extern printf
extern strcmp
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
	push    rbp
	mov     rbp, rdi
	push    rbx
	mov     rbx, rsi
	sub     rsp, 8
	test    rsi, rsi
	jz      loc_005
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_002

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_001:  add     rbp, 1
	sub     rbx, 1
	jz      loc_005
loc_002:  movzx   eax, byte [rbp]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_001
	jmp     loc_004

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_003:  sub     rbx, 1
loc_004:  test    rbx, rbx
	jz      loc_005
	call    __ctype_b_loc
	movzx   edx, byte [rbp+rbx-0x1]
	mov     rax, qword [rax]
	test    byte [rax+rdx*2+0x1], 0x20
	jnz     loc_003
	lea     rdi, [rbx+0x1]
	jmp     loc_006

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_005:  mov     edi, 1
loc_006:  call    malloc
	mov     rcx, rax
	test    rax, rax
	jz      loc_007
	mov     rdx, rbx
	mov     rsi, rbp
	mov     rdi, rax
	call    memcpy
	mov     byte [rax+rbx], 0
	mov     rcx, rax
loc_007:  add     rsp, 8
	mov     rax, rcx
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

print_repo_providers:
	sub     rsp, 5528
	mov     edx, 320
	mov     qword [rsp+0x1568], rbx
	lea     rsi, [rsp+0x2D0]
	mov     qword [rsp+0x1580], r13
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r13, qword [fs:abs 0x28]
	mov     qword [rsp+0x1558], r13
	mov     r13, rdi
	mov     qword [rsp+0x38], 0
	mov     qword [rsp+0x40], 0
	call    shell_quote
	mov     ebx, eax
	test    eax, eax
	jnz     loc_009
loc_008:  mov     rax, qword [rsp+0x1558]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_072
	mov     eax, ebx
	mov     r13, qword [rsp+0x1580]
	mov     rbx, qword [rsp+0x1568]
	add     rsp, 5528
	ret

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_009:  lea     rcx, [rsp+0x2D0]
	mov     esi, 4096
	xor     eax, eax
	mov     qword [rsp+0x1570], rbp
	lea     rdx, [rel str_LC4]
	lea     rdi, [rsp+0x550]
	call    xsnprintf
	lea     rsi, [rsp+0x38]
	lea     rdi, [rsp+0x550]
	call    run_cmd_capture
	mov     rbp, qword [rsp+0x38]
	test    rbp, rbp
	je      loc_045
	mov     qword [rsp+0x1588], r14
	xor     r14d, r14d
	cmp     byte [rbp], 0
	je      loc_068
loc_010:  mov     esi, 10
	mov     rdi, rbp
	call    strchr
	mov     rbx, rax
	test    rax, rax
	jz      loc_012
	sub     rax, rbp
	lea     rdx, [rax-0x1]
	cmp     rdx, 158
	jbe     loc_034
loc_011:  cmp     byte [rbx+0x1], 0
	jz      loc_013
	lea     rbp, [rbx+0x1]
	jmp     loc_010

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_012:  mov     rdi, rbp
	call    strlen
	lea     rdx, [rax-0x1]
	cmp     rdx, 158
	jbe     loc_038
loc_013:  mov     rdi, qword [rsp+0x38]
	call    free
	test    r14, r14
	je      loc_044
	mov     qword [rsp+0x1578], r12
	mov     qword [rsp+0x1590], r15
loc_014:  mov     rax, qword 0x2D206E616D636170
	lea     r12, [rsp+0x50]
	mov     qword [rsp+0x550], rax
	lea     rbp, [r12+r14*8]
	mov     rbx, r12
	mov     rax, qword 0x2D2D2069532D20
	mov     qword [rsp+0x556], rax
	mov     r14d, 13
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_015:  mov     rdi, qword [rbx]
	test    rdi, rdi
	jz      loc_016
	mov     edx, 320
	lea     rsi, [rsp+0x410]
	call    shell_quote
	test    eax, eax
	jz      loc_016
	lea     rdi, [rsp+0x410]
	call    strlen
	lea     r15, [r14+rax+0x1]
	cmp     r15, 4095
	ja      loc_017
	lea     rdi, [rsp+r14+0x551]
	mov     rdx, rax
	lea     rsi, [rsp+0x410]
	mov     byte [rsp+r14+0x550], 32
	call    memcpy
	mov     r14, r15
	mov     byte [rsp+r15+0x550], 0
loc_016:  add     rbx, 8
	cmp     rbx, rbp
	jnz     loc_015
loc_017:  lea     rsi, [rsp+0x40]
	lea     rdi, [rsp+0x550]
	call    run_cmd_capture
	mov     r14, qword [rsp+0x40]
	mov     ebx, eax
	test    eax, eax
	jne     loc_048
	test    r14, r14
	je      loc_049
	cmp     byte [r14], 0
	je      loc_049
	mov     qword [rsp+0x8], r13
	mov     r13, r14
	mov     dword [rsp+0x14], 0
	mov     qword [rsp+0x20], r12
	mov     qword [rsp+0x28], rbp
	jmp     loc_026

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_018:  test    r13b, r13b
	je      loc_025
	mov     esi, 58
	mov     rdi, r15
	call    strchr
	mov     rdx, rax
	test    rax, rax
	je      loc_025
	xor     r13d, r13d
	cmp     rax, rbp
	jnc     loc_025
loc_019:  mov     rdi, rdx
	mov     esi, 10
	mov     qword [rsp+0x18], rdx
	call    strchr
	mov     rdx, qword [rsp+0x18]
	lea     rbp, [rdx+0x1]
	test    rax, rax
	je      loc_064
	sub     rax, rdx
	lea     rsi, [rax-0x1]
loc_020:  mov     rdi, rbp
	call    trim_copy
	mov     rbp, rax
	test    rax, rax
	jz      loc_021
	lea     rsi, [rel str_LC10]
	mov     rdi, rax
	call    strcmp
	test    eax, eax
	jne     loc_069
loc_021:  mov     rdi, rbp
	call    free
	test    r12, r12
	jz      loc_025
	test    r13d, r13d
	jz      loc_025
loc_022:  lea     r8, [rel str_LC0]
loc_023:  mov     rax, qword [rsp]
	test    r14, r14
	lea     rcx, [rel str_LC2]
	lea     rsi, [rel str_LC3]
	cmovne  rcx, r14
	test    rax, rax
	jz      loc_024
	cmp     byte [rax], 0
	cmovne  rsi, rax
loc_024:  mov     rdx, r12
	lea     rdi, [rel str_LC12]
	xor     eax, eax
	call    printf
	mov     dword [rsp+0x14], 1
loc_025:  mov     rdi, r12
	call    free
	mov     rdi, r14
	call    free
	mov     rdi, qword [rsp]
	call    free
	test    rbx, rbx
	je      loc_062
	lea     r13, [rbx+0x1]
	cmp     byte [rbx+0x1], 0
	je      loc_062
loc_026:  lea     rsi, [rel str_LC5]
	mov     rdi, r13
	call    strstr
	mov     rbx, rax
	cmp     rax, r13
	je      loc_061
loc_027:  mov     rbp, rbx
	test    rbx, rbx
	je      loc_060
loc_028:  lea     rsi, [rel str_LC6]
	mov     rdi, r13
	call    strstr
	lea     rsi, [rel str_LC7]
	mov     rdi, r13
	mov     qword [rsp], rax
	call    strstr
	lea     rsi, [rel str_LC8]
	mov     rdi, r13
	mov     r12, rax
	call    strstr
	lea     rsi, [rel str_LC9]
	mov     rdi, r13
	mov     r14, rax
	call    strstr
	mov     rdx, qword [rsp]
	mov     r15, rax
	test    rdx, rdx
	je      loc_056
	cmp     rdx, rbp
	jnc     loc_056
	mov     esi, 58
	mov     rdi, rdx
	call    strchr
	mov     r13, rax
	test    rax, rax
	je      loc_056
	cmp     rax, rbp
	jnc     loc_056
	mov     rdi, rax
	mov     esi, 10
	call    strchr
	lea     rdi, [r13+0x1]
	test    rax, rax
	je      loc_066
	sub     rax, r13
	lea     rsi, [rax-0x1]
loc_029:  call    trim_copy
	mov     qword [rsp], rax
loc_030:  cmp     r14, rbp
	setb    r13b
	test    r14, r14
	setne   al
	and     r13d, eax
	test    r12, r12
	je      loc_052
	cmp     r12, rbp
	jnc     loc_052
	mov     rdi, r12
	mov     esi, 58
	call    strchr
	mov     r12, rax
	test    rax, rax
	je      loc_052
	cmp     rax, rbp
	jnc     loc_052
	mov     rdi, rax
	mov     esi, 10
	call    strchr
	lea     rdi, [r12+0x1]
	test    rax, rax
	je      loc_065
	sub     rax, r12
	lea     rsi, [rax-0x1]
loc_031:  call    trim_copy
	mov     r12, rax
	test    r13b, r13b
	jz      loc_032
	mov     esi, 58
	mov     rdi, r14
	call    strchr
	mov     r13, rax
	test    rax, rax
	jz      loc_032
	cmp     rax, rbp
	jc      loc_058
loc_032:  xor     r14d, r14d
loc_033:  test    r15, r15
	setne   r13b
	cmp     r15, rbp
	setb    al
	and     r13d, eax
	test    r12, r12
	je      loc_054
	mov     rsi, qword [rsp+0x8]
	mov     rdi, r12
	call    strcmp
	test    eax, eax
	jne     loc_018
	test    r13b, r13b
	je      loc_022
	mov     esi, 58
	mov     rdi, r15
	call    strchr
	mov     rdx, rax
	test    rax, rax
	je      loc_022
	mov     r13d, 1
	cmp     rax, rbp
	jc      loc_019
	jmp     loc_022

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_034:  lea     rdi, [rsp+0x410]
	mov     rdx, rbp
	cmp     eax, 64
	jnc     loc_042
loc_035:  mov     r8d, eax
	and     r8d, 0x3F
	jz      loc_037
	xor     ecx, ecx
loc_036:  mov     esi, ecx
	add     ecx, 1
	movzx   r9d, byte [rdx+rsi]
	mov     byte [rdi+rsi], r9b
	cmp     ecx, r8d
	jc      loc_036
loc_037:  mov     byte [rsp+rax+0x410], 0
	lea     rdi, [rsp+0x410]
	call    valid_pkgname
	test    eax, eax
	je      loc_011
	lea     rdi, [rsp+0x410]
	mov     qword [rsp+0x1578], r12
	lea     r12, [r14+0x1]
	call    strdup
	mov     qword [rsp+r14*8+0x50], rax
	cmp     byte [rbx+0x1], 0
	je      loc_063
	cmp     r12, 80
	je      loc_051
	mov     r14, r12
	lea     rbp, [rbx+0x1]
	mov     r12, qword [rsp+0x1578]
	jmp     loc_010

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_038:  lea     rbx, [rsp+0x410]
	mov     rdx, rbp
	mov     rdi, rbx
	cmp     eax, 64
	jnc     loc_046
loc_039:  mov     r8d, eax
	and     r8d, 0x3F
	jz      loc_041
	xor     ecx, ecx
loc_040:  mov     esi, ecx
	add     ecx, 1
	movzx   r9d, byte [rdx+rsi]
	mov     byte [rdi+rsi], r9b
	cmp     ecx, r8d
	jc      loc_040
loc_041:  mov     byte [rsp+rax+0x410], 0
	mov     rdi, rbx
	call    valid_pkgname
	test    eax, eax
	je      loc_013
	mov     rdi, rbx
	mov     qword [rsp+0x1578], r12
	mov     qword [rsp+0x1590], r15
	call    strdup
	mov     rdi, qword [rsp+0x38]
	mov     qword [rsp+r14*8+0x50], rax
	add     r14, 1
	call    free
	jmp     loc_014

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_042:  mov     esi, eax
	xor     edx, edx
	and     esi, 0x0FFFFFFC0
loc_043:  mov     ecx, edx
	add     edx, 64
	movdqu  xmm3, oword [rbp+rcx]
	movdqu  xmm2, oword [rbp+rcx+0x10]
	movdqu  xmm1, oword [rbp+rcx+0x20]
	movdqu  xmm0, oword [rbp+rcx+0x30]
	movaps  oword [rsp+rcx+0x410], xmm3
	movaps  oword [rsp+rcx+0x420], xmm2
	movaps  oword [rsp+rcx+0x430], xmm1
	movaps  oword [rsp+rcx+0x440], xmm0
	cmp     edx, esi
	jc      loc_043
	lea     rdi, [rsp+rdx+0x410]
	add     rdx, rbp
	jmp     loc_035

loc_044:  mov     r14, qword [rsp+0x1588]
loc_045:  mov     rbp, qword [rsp+0x1570]
	xor     ebx, ebx
	jmp     loc_008

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_046:  mov     esi, eax
	xor     edx, edx
	and     esi, 0x0FFFFFFC0
loc_047:  mov     ecx, edx
	add     edx, 64
	movdqu  xmm3, oword [rbp+rcx]
	movdqu  xmm2, oword [rbp+rcx+0x10]
	movdqu  xmm1, oword [rbp+rcx+0x20]
	movdqu  xmm0, oword [rbp+rcx+0x30]
	movaps  oword [rbx+rcx], xmm3
	movaps  oword [rbx+rcx+0x10], xmm2
	movaps  oword [rbx+rcx+0x20], xmm1
	movaps  oword [rbx+rcx+0x30], xmm0
	cmp     edx, esi
	jc      loc_047
	lea     rdi, [rbx+rdx]
	add     rdx, rbp
	jmp     loc_039

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_048:  xor     ebx, ebx
loc_049:  mov     rdi, r14
	call    free
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_050:  mov     rdi, qword [r12]
	add     r12, 8
	call    free
	cmp     r12, rbp
	jnz     loc_050
	mov     rbp, qword [rsp+0x1570]
	mov     r12, qword [rsp+0x1578]
	mov     r14, qword [rsp+0x1588]
	mov     r15, qword [rsp+0x1590]
	jmp     loc_008

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_051:  mov     rdi, qword [rsp+0x38]
	mov     qword [rsp+0x1590], r15
	mov     r14d, 80
	call    free
	jmp     loc_014

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_052:  test    r13b, r13b
	jnz     loc_057
loc_053:  xor     r14d, r14d
loc_054:  test    r15, r15
	jz      loc_055
	cmp     r15, rbp
	jnc     loc_055
	mov     esi, 58
	mov     rdi, r15
	call    strchr
	mov     rdx, rax
	test    rax, rax
	jz      loc_055
	xor     r13d, r13d
	xor     r12d, r12d
	cmp     rax, rbp
	jc      loc_019
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_055:  xor     r12d, r12d
	jmp     loc_025

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_056:  mov     qword [rsp], 0
	jmp     loc_030

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_057:  mov     esi, 58
	mov     rdi, r14
	call    strchr
	mov     r13, rax
	test    rax, rax
	jz      loc_053
	cmp     rax, rbp
	jnc     loc_053
	xor     r12d, r12d
loc_058:  mov     esi, 10
	mov     rdi, r13
	lea     r14, [r13+0x1]
	call    strchr
	test    rax, rax
	je      loc_067
	sub     rax, r13
	lea     rsi, [rax-0x1]
loc_059:  mov     rdi, r14
	call    trim_copy
	mov     r14, rax
	jmp     loc_033

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_060:  mov     rdi, r13
	call    strlen
	lea     rbp, [r13+rax]
	jmp     loc_028

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_061:  lea     rdi, [r13+0x1]
	lea     rsi, [rel str_LC5]
	call    strstr
	mov     rbx, rax
	jmp     loc_027

loc_062:  mov     r12, qword [rsp+0x20]
	mov     rbp, qword [rsp+0x28]
	mov     r14, qword [rsp+0x40]
	mov     ebx, dword [rsp+0x14]
	jmp     loc_049

loc_063:  mov     r14, r12
	mov     r12, qword [rsp+0x1578]
	jmp     loc_013

loc_064:  mov     rdi, rbp
	call    strlen
	mov     rsi, rax
	jmp     loc_020

loc_065:  mov     qword [rsp+0x18], rdi
	call    strlen
	mov     rdi, qword [rsp+0x18]
	mov     rsi, rax
	jmp     loc_031

loc_066:  mov     qword [rsp], rdi
	call    strlen
	mov     rdi, qword [rsp]
	mov     rsi, rax
	jmp     loc_029

loc_067:  mov     rdi, r14
	call    strlen
	mov     rsi, rax
	jmp     loc_059

loc_068:  mov     rdi, rbp
	call    free
	mov     r14, qword [rsp+0x1588]
	jmp     loc_045

loc_069:  mov     rdi, rbp
	lea     rdx, [rsp+0x48]
	lea     rsi, [rel str_LC11]
	mov     qword [rsp+0x48], 0
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	je      loc_021
	mov     r15, rbp
	mov     rbp, rbx
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_070:  mov     edx, 256
	lea     rsi, [rsp+0x410]
	call    dep_basename
	cmp     byte [rsp+0x410], 0
	jz      loc_071
	mov     rsi, qword [rsp+0x8]
	lea     rdi, [rsp+0x410]
	call    strcmp
	test    eax, eax
	jnz     loc_071
	mov     rdi, r15
	mov     rbx, rbp
	call    free
	test    r12, r12
	je      loc_025
	test    r13d, r13d
	jne     loc_022
	lea     r8, [rel str_LC1]
	jmp     loc_023

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_071:  xor     edi, edi
	lea     rdx, [rsp+0x48]
	lea     rsi, [rel str_LC11]
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	jnz     loc_070
	mov     rbx, rbp
	mov     rbp, r15
	jmp     loc_021

loc_072:
	mov     qword [rsp+0x1570], rbp
	mov     qword [rsp+0x1578], r12
	mov     qword [rsp+0x1588], r14
	mov     qword [rsp+0x1590], r15
	call    __stack_chk_fail
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

cmd_provider_v2:
	sub     rsp, 616
	pxor    xmm0, xmm0
	mov     qword [rsp+0x238], rbx
	mov     qword [rsp+0x240], rbp
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbx, qword [fs:abs 0x28]
	mov     qword [rsp+0x228], rbx
	mov     rbx, rdi
	movaps  oword [rsp+0x10], xmm0
	movaps  oword [rsp+0x20], xmm0
	movaps  oword [rsp+0x30], xmm0
	movaps  oword [rsp+0x40], xmm0
	movaps  oword [rsp+0x50], xmm0
	movaps  oword [rsp+0x60], xmm0
	movaps  oword [rsp+0x70], xmm0
	movaps  oword [rsp+0x80], xmm0
	movaps  oword [rsp+0x90], xmm0
	movaps  oword [rsp+0x0A0], xmm0
	movaps  oword [rsp+0x0B0], xmm0
	movaps  oword [rsp+0x0C0], xmm0
	movaps  oword [rsp+0x0D0], xmm0
	movaps  oword [rsp+0x0E0], xmm0
	movaps  oword [rsp+0x0F0], xmm0
	movaps  oword [rsp+0x100], xmm0
	movaps  oword [rsp+0x110], xmm0
	call    valid_pkgname
	test    eax, eax
	jnz     loc_074
	test    rbx, rbx
	mov     ebp, eax
	lea     rax, [rel str_LC2]
	mov     rdi, qword [rel stderr]
	cmove   rbx, rax
	lea     rsi, [rel str_LC14]
	xor     eax, eax
	mov     rdx, rbx
	call    fprintf
loc_073:  mov     rax, qword [rsp+0x228]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_086
	mov     eax, ebp
	mov     rbx, qword [rsp+0x238]
	mov     rbp, qword [rsp+0x240]
	add     rsp, 616
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_074:  mov     rsi, rbx
	lea     rdi, [rel str_LC15]
	xor     eax, eax
	call    printf
	mov     rdi, rbx
	call    print_repo_providers
	mov     ebp, eax
	call    config_current
	lea     rcx, [rsp+0x20]
	lea     rdx, [rsp+0x10]
	mov     rsi, rbx
	lea     rdi, [rax+0x14]
	mov     r8d, 256
	call    aur_rpc_info
	test    eax, eax
	je      loc_084
	cmp     qword [rsp+0x18], 0
	je      loc_084
	mov     qword [rsp+0x258], r14
	xor     r14d, r14d
	mov     qword [rsp+0x248], r12
	mov     qword [rsp+0x250], r13
	mov     qword [rsp+0x260], r15
	mov     qword [rsp+0x8], 0
	jmp     loc_078

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_075:  mov     rsi, rbx
	lea     rdi, [rsp+0x120]
	call    strcmp
	test    eax, eax
	jne     loc_081
	test    r12d, r12d
	lea     rcx, [rel str_LC1]
	lea     rax, [rel str_LC0]
	cmovne  rcx, rax
loc_076:  mov     rdx, qword [r15+0x10]
	mov     rsi, qword [r15]
	lea     rax, [rel str_LC2]
	lea     rdi, [rel str_LC16]
	mov     ebp, 1
	test    rdx, rdx
	cmove   rdx, rax
	test    rsi, rsi
	lea     rax, [rel str_LC13]
	cmove   rsi, rax
	xor     eax, eax
	call    printf
loc_077:  add     qword [rsp+0x8], 1
	add     r14, 152
	mov     rax, qword [rsp+0x8]
	cmp     rax, qword [rsp+0x18]
	jnc     loc_083
loc_078:  mov     r15, qword [rsp+0x10]
	add     r15, r14
	mov     rdi, qword [r15]
	mov     r13, qword [r15+0x80]
	test    rdi, rdi
	je      loc_085
	mov     rsi, rbx
	xor     r12d, r12d
	call    strcmp
	test    eax, eax
	sete    r12b
	test    r13, r13
	jz      loc_082
loc_079:  xor     r13d, r13d
	nop
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_080:  mov     rax, qword [r15+0x78]
	mov     edx, 256
	lea     rsi, [rsp+0x120]
	mov     rdi, qword [rax+r13*8]
	call    dep_basename
	cmp     byte [rsp+0x120], 0
	jne     loc_075
loc_081:  add     r13, 1
	cmp     r13, qword [r15+0x80]
	jc      loc_080
loc_082:  test    r12d, r12d
	je      loc_077
	lea     rcx, [rel str_LC0]
	jmp     loc_076

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_083:  mov     r12, qword [rsp+0x248]
	mov     r13, qword [rsp+0x250]
	mov     r14, qword [rsp+0x258]
	mov     r15, qword [rsp+0x260]
loc_084:  lea     rdi, [rsp+0x10]
	call    aur_response_destroy
	test    ebp, ebp
	jne     loc_073
	mov     rdi, qword [rel stderr]
	mov     rdx, rbx
	lea     rsi, [rel str_LC17]
	xor     eax, eax
	call    fprintf
	jmp     loc_073

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_085:  xor     r12d, r12d
	test    r13, r13
	jne     loc_079
	jmp     loc_077

loc_086:
	mov     qword [rsp+0x248], r12
	mov     qword [rsp+0x250], r13
	mov     qword [rsp+0x258], r14
	mov     qword [rsp+0x260], r15
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x28, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65
	db 0x29, 0x00

str_LC1:
	db 0x28, 0x70, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65
	db 0x73, 0x29, 0x00

str_LC2:
	db 0x00

str_LC3:
	db 0x72, 0x65, 0x70, 0x6F, 0x00

str_LC4:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x73, 0x71, 0x20, 0x2D, 0x2D, 0x20, 0x25
	db 0x73, 0x00

str_LC5:
	db 0x0A, 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74
	db 0x6F, 0x72, 0x79, 0x00

str_LC6:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x00

str_LC7:
	db 0x0A, 0x4E, 0x61, 0x6D, 0x65, 0x00

str_LC8:
	db 0x0A, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E
	db 0x00

str_LC9:
	db 0x0A, 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65
	db 0x73, 0x00

str_LC10:
	db 0x4E, 0x6F, 0x6E, 0x65, 0x00

str_LC11:
	db 0x20, 0x09, 0x00

str_LC12:
	db 0x25, 0x73, 0x2F, 0x25, 0x73, 0x20, 0x25, 0x73
	db 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC13:
	db 0x3F, 0x00

str_LC16:
	db 0x61, 0x75, 0x72, 0x2F, 0x25, 0x73, 0x20, 0x25
	db 0x73, 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC14:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC15:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x50, 0x72, 0x6F, 0x76, 0x69
	db 0x64, 0x65, 0x72, 0x73, 0x20, 0x6F, 0x66, 0x20
	db 0x25, 0x73, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

str_LC17:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x33, 0x6D, 0x5B
	db 0x21, 0x5D, 0x20, 0x4E, 0x6F, 0x20, 0x70, 0x72
	db 0x6F, 0x76, 0x69, 0x64, 0x65, 0x72, 0x73, 0x20
	db 0x66, 0x6F, 0x75, 0x6E, 0x64, 0x20, 0x66, 0x6F
	db 0x72, 0x20, 0x27, 0x25, 0x73, 0x27, 0x2E, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00

