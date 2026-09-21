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
	push    rbp
	mov     rbp, rdi
	push    rbx
	sub     rsp, 8
	test    rsi, rsi
	jz      loc_005
	mov     rbx, rsi
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
loc_003:  mov     rbx, rcx
loc_004:  test    rbx, rbx
	jz      loc_008
	call    __ctype_b_loc
	movzx   edx, byte [rbp+rbx-0x1]
	lea     rcx, [rbx-0x1]
	mov     rax, qword [rax]
	test    byte [rax+rdx*2+0x1], 0x20
	jnz     loc_003
	lea     rdi, [rbx+0x1]
	jmp     loc_006

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_005:  xor     ebx, ebx
	mov     edi, 1
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

loc_008:
	mov     edi, 1
	jmp     loc_006

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

print_repo_providers:
	push    r15
	mov     edx, 320
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 5464
	lea     rbx, [rsp+0x50]
	mov     qword [rsp], rdi
	mov     qword [rsp+0x38], 0
	mov     rsi, rbx
	mov     qword [rsp+0x40], 0
	call    shell_quote
	test    eax, eax
	jnz     loc_011
loc_009:  xor     ebx, ebx
loc_010:  add     rsp, 5464
	mov     eax, ebx
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_011:  lea     r12, [rsp+0x550]
	mov     rcx, rbx
	mov     esi, 4096
	xor     eax, eax
	lea     rdx, [rel str_LC4]
	mov     rdi, r12
	call    xsnprintf
	lea     rsi, [rsp+0x38]
	mov     rdi, r12
	call    run_cmd_capture
	mov     rbp, qword [rsp+0x38]
	test    rbp, rbp
	jz      loc_009
	xor     r13d, r13d
	cmp     byte [rbp], 0
	lea     r15, [rsp+0x190]
	jnz     loc_015
	jmp     loc_061

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_012:  mov     r14, rax
	sub     r14, rbp
	lea     rax, [r14-0x1]
	cmp     rax, 158
	jbe     loc_023
loc_013:  cmp     byte [rbx+0x1], 0
	lea     rbp, [rbx+0x1]
	jz      loc_016
	mov     r14, r13
loc_014:  mov     r13, r14
loc_015:  mov     esi, 10
	mov     rdi, rbp
	call    strchr
	mov     rbx, rax
	test    rax, rax
	jnz     loc_012
	mov     rdi, rbp
	call    strlen
	mov     r14, rax
	lea     rax, [rax-0x1]
	cmp     rax, 158
	jbe     loc_025
loc_016:  mov     r14, r13
loc_017:  mov     rdi, qword [rsp+0x38]
	call    free
	test    r14, r14
	je      loc_009
loc_018:  mov     rax, qword 0x2D206E616D636170
	lea     r15, [rsp+0x2D0]
	mov     r13d, 13
	mov     qword [rsp+0x550], rax
	lea     rbp, [r15+r14*8]
	mov     rbx, r15
	mov     rax, qword 0x2D2D2069532D20
	mov     qword [rsp+0x556], rax
	lea     r14, [rsp+0x190]
	jmp     loc_022

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_019:  test    al, 0x04
	jne     loc_045
	test    eax, eax
	jz      loc_020
	movzx   ecx, byte [r14]
	mov     byte [rdx], cl
	test    al, 0x02
	jne     loc_056
loc_020:  mov     byte [rsp+r8+0x550], 0
	mov     r13, r8
loc_021:  add     rbx, 8
	cmp     rbp, rbx
	je      loc_026
loc_022:  mov     rdi, qword [rbx]
	test    rdi, rdi
	jz      loc_021
	mov     edx, 320
	mov     rsi, r14
	call    shell_quote
	test    eax, eax
	jz      loc_021
	mov     rdi, r14
	call    strlen
	lea     rdx, [r13+0x1]
	lea     r8, [rax+rdx]
	cmp     r8, 4095
	ja      loc_026
	mov     byte [rsp+r13+0x550], 32
	add     rdx, r12
	cmp     eax, 8
	jc      loc_019
	mov     rcx, qword [r14]
	lea     rdi, [rdx+0x8]
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	mov     qword [rdx], rcx
	mov     ecx, eax
	mov     rsi, qword [r14+rcx-0x8]
	mov     qword [rdx+rcx-0x8], rsi
	sub     rdx, rdi
	mov     rsi, r14
	lea     ecx, [rax+rdx]
	sub     rsi, rdx
	mov     eax, ecx
	shr     eax, 3
	mov     ecx, eax
	rep movsq
	jmp     loc_020

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_023:  mov     rdi, r15
	mov     rdx, r14
	mov     rsi, rbp
	call    memcpy
	mov     rdi, r15
	mov     byte [rsp+r14+0x190], 0
	call    valid_pkgname
	test    eax, eax
	je      loc_013
	mov     rdi, r15
	lea     r14, [r13+0x1]
	lea     rbp, [rbx+0x1]
	call    strdup
	cmp     byte [rbx+0x1], 0
	mov     qword [rsp+r13*8+0x2D0], rax
	je      loc_017
	cmp     r14, 80
	jne     loc_014
loc_024:  mov     rdi, qword [rsp+0x38]
	call    free
	jmp     loc_018

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_025:  lea     rbx, [rsp+0x190]
	mov     rdx, r14
	mov     rsi, rbp
	mov     rdi, rbx
	call    memcpy
	mov     rdi, rbx
	mov     byte [rsp+r14+0x190], 0
	call    valid_pkgname
	test    eax, eax
	je      loc_016
	mov     rdi, rbx
	lea     r14, [r13+0x1]
	call    strdup
	mov     qword [rsp+r13*8+0x2D0], rax
	jmp     loc_024

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_026:  lea     rsi, [rsp+0x40]
	mov     rdi, r12
	call    run_cmd_capture
	mov     r13, qword [rsp+0x40]
	mov     ebx, eax
	test    eax, eax
	jz      loc_029
	xor     ebx, ebx
loc_027:  mov     rdi, r13
	call    free
; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x00

ALIGN   16
loc_028:  mov     rdi, qword [r15]
	add     r15, 8
	call    free
	cmp     rbp, r15
	jnz     loc_028
	jmp     loc_010

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_029:  test    r13, r13
	jz      loc_027
	cmp     byte [r13], 0
	jz      loc_027
	mov     dword [rsp+0x1C], 0
	mov     qword [rsp+0x20], rbp
	mov     qword [rsp+0x28], r15
	jmp     loc_038

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_030:  test    r12b, r12b
	je      loc_037
	mov     rdi, r13
	mov     esi, 58
	call    strchr
	mov     r13, rax
	cmp     rax, rbp
	jnc     loc_037
	xor     r12d, r12d
	test    rax, rax
	je      loc_037
loc_031:  mov     esi, 10
	mov     rdi, r13
	lea     rbp, [r13+0x1]
	call    strchr
	test    rax, rax
	je      loc_057
	sub     rax, r13
	lea     rsi, [rax-0x1]
loc_032:  mov     rdi, rbp
	call    trim_copy
	mov     r15, rax
	test    rax, rax
	jz      loc_033
	lea     rsi, [rel str_LC10]
	mov     rdi, rax
	call    strcmp
	test    eax, eax
	jne     loc_062
loc_033:  mov     rdi, r15
	call    free
	test    r14, r14
	jz      loc_037
	test    r12d, r12d
	jz      loc_037
loc_034:  lea     r8, [rel str_LC0]
loc_035:  mov     rax, qword [rsp+0x8]
	lea     rcx, [rel str_LC2]
	lea     rsi, [rel str_LC3]
	test    rax, rax
	cmovne  rcx, rax
	mov     rax, qword [rsp+0x10]
	test    rax, rax
	jz      loc_036
	cmp     byte [rax], 0
	cmovne  rsi, rax
loc_036:  mov     rdx, r14
	lea     rdi, [rel str_LC12]
	xor     eax, eax
	call    printf
	mov     dword [rsp+0x1C], 1
loc_037:  mov     rdi, r14
	call    free
	mov     rdi, qword [rsp+0x8]
	call    free
	mov     rdi, qword [rsp+0x10]
	call    free
	test    rbx, rbx
	je      loc_055
	cmp     byte [rbx+0x1], 0
	lea     r13, [rbx+0x1]
	je      loc_055
loc_038:  lea     rsi, [rel str_LC5]
	mov     rdi, r13
	call    strstr
	mov     rbx, rax
	cmp     rax, r13
	je      loc_053
	mov     rbp, rbx
	test    rbx, rbx
	je      loc_054
loc_039:  mov     rdi, r13
	lea     rsi, [rel str_LC6]
	call    strstr
	mov     rdi, r13
	lea     rsi, [rel str_LC7]
	mov     r15, rax
	call    strstr
	mov     rdi, r13
	lea     rsi, [rel str_LC8]
	mov     r14, rax
	call    strstr
	mov     rdi, r13
	lea     rsi, [rel str_LC9]
	mov     r12, rax
	call    strstr
	mov     r13, rax
	test    r15, r15
	je      loc_049
	cmp     r15, rbp
	jnc     loc_049
	mov     rdi, r15
	mov     esi, 58
	call    strchr
	mov     r15, rax
	test    rax, rax
	je      loc_049
	cmp     rax, rbp
	jnc     loc_049
	mov     rdi, rax
	mov     esi, 10
	call    strchr
	lea     rdi, [r15+0x1]
	test    rax, rax
	je      loc_058
	sub     rax, r15
	lea     rsi, [rax-0x1]
loc_040:  call    trim_copy
	mov     qword [rsp+0x10], rax
loc_041:  cmp     r12, rbp
	setb    r15b
	test    r12, r12
	setne   al
	and     r15d, eax
	test    r14, r14
	je      loc_046
	cmp     r14, rbp
	jnc     loc_046
	mov     rdi, r14
	mov     esi, 58
	call    strchr
	mov     r14, rax
	test    rax, rax
	je      loc_046
	cmp     rax, rbp
	jnc     loc_046
	mov     rdi, rax
	mov     esi, 10
	call    strchr
	lea     rdi, [r14+0x1]
	test    rax, rax
	je      loc_060
	sub     rax, r14
	lea     rsi, [rax-0x1]
loc_042:  call    trim_copy
	mov     qword [rsp+0x8], 0
	mov     r14, rax
	test    r15b, r15b
	jz      loc_044
	mov     rdi, r12
	mov     esi, 58
	call    strchr
	mov     r12, rax
	test    rax, rax
	jz      loc_043
	cmp     rax, rbp
	jc      loc_047
loc_043:  mov     qword [rsp+0x8], 0
loc_044:  cmp     r13, rbp
	setb    r12b
	test    r13, r13
	setne   al
	and     r12d, eax
	test    r14, r14
	je      loc_051
	mov     rsi, qword [rsp]
	mov     rdi, r14
	call    strcmp
	test    eax, eax
	jne     loc_030
	test    r12b, r12b
	je      loc_034
	mov     rdi, r13
	mov     esi, 58
	call    strchr
	mov     r13, rax
	test    rax, rax
	je      loc_034
	mov     r12d, 1
	cmp     rax, rbp
	jc      loc_031
	jmp     loc_034

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_045:  mov     ecx, dword [r14]
	mov     eax, eax
	mov     dword [rdx], ecx
	mov     ecx, dword [r14+rax-0x4]
	mov     dword [rdx+rax-0x4], ecx
	jmp     loc_020

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_046:  test    r15b, r15b
	jz      loc_050
	mov     rdi, r12
	mov     esi, 58
	call    strchr
	mov     r12, rax
	test    rax, rax
	jz      loc_050
	cmp     rax, rbp
	jnc     loc_050
	xor     r14d, r14d
loc_047:  mov     esi, 10
	mov     rdi, r12
	lea     r15, [r12+0x1]
	call    strchr
	test    rax, rax
	je      loc_059
	sub     rax, r12
	lea     rsi, [rax-0x1]
loc_048:  mov     rdi, r15
	call    trim_copy
	mov     qword [rsp+0x8], rax
	jmp     loc_044

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_049:  mov     qword [rsp+0x10], 0
	jmp     loc_041

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_050:  mov     qword [rsp+0x8], 0
loc_051:  test    r13, r13
	jz      loc_052
	cmp     r13, rbp
	jnc     loc_052
	mov     rdi, r13
	mov     esi, 58
	call    strchr
	mov     r13, rax
	test    rax, rax
	jz      loc_052
	xor     r12d, r12d
	xor     r14d, r14d
	cmp     rax, rbp
	jc      loc_031
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_052:  xor     r14d, r14d
	jmp     loc_037

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_053:  lea     rdi, [r13+0x1]
	lea     rsi, [rel str_LC5]
	call    strstr
	mov     rbx, rax
	mov     rbp, rbx
	test    rbx, rbx
	jne     loc_039
loc_054:  mov     rdi, r13
	call    strlen
	lea     rbp, [r13+rax]
	jmp     loc_039

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_055:  mov     rbp, qword [rsp+0x20]
	mov     r15, qword [rsp+0x28]
	mov     r13, qword [rsp+0x40]
	mov     ebx, dword [rsp+0x1C]
	jmp     loc_027

loc_056:  mov     eax, eax
	movzx   ecx, word [r14+rax-0x2]
	mov     word [rdx+rax-0x2], cx
	jmp     loc_020

loc_057:  mov     rdi, rbp
	call    strlen
	mov     rsi, rax
	jmp     loc_032

loc_058:  mov     qword [rsp+0x8], rdi
	call    strlen
	mov     rdi, qword [rsp+0x8]
	mov     rsi, rax
	jmp     loc_040

loc_059:  mov     rdi, r15
	call    strlen
	mov     rsi, rax
	jmp     loc_048

loc_060:  mov     qword [rsp+0x8], rdi
	call    strlen
	mov     rdi, qword [rsp+0x8]
	mov     rsi, rax
	jmp     loc_042

loc_061:  mov     rdi, rbp
	call    free
	jmp     loc_009

loc_062:
	lea     r13, [rsp+0x48]
	mov     rdi, r15
	lea     rsi, [rel str_LC11]
	mov     qword [rsp+0x48], 0
	mov     rdx, r13
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	je      loc_033
	lea     rbp, [rsp+0x190]
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16
loc_063:  mov     edx, 256
	mov     rsi, rbp
	call    dep_basename
	cmp     byte [rsp+0x190], 0
	jz      loc_064
	mov     rsi, qword [rsp]
	mov     rdi, rbp
	call    strcmp
	test    eax, eax
	jnz     loc_064
	mov     rdi, r15
	call    free
	test    r14, r14
	je      loc_037
	test    r12d, r12d
	jne     loc_034
	lea     r8, [rel str_LC1]
	jmp     loc_035

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_064:  xor     edi, edi
	mov     rdx, r13
	lea     rsi, [rel str_LC11]
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	jnz     loc_063
	jmp     loc_033

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

cmd_provider_v2:; Function begin
	push    r15
	pxor    xmm0, xmm0
	push    r14
	push    r13
	push    r12
	push    rbp
	mov     rbp, rdi
	push    rbx
	sub     rsp, 568
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
	movaps  oword [rsp+0x120], xmm0
	call    valid_pkgname
	test    eax, eax
	jnz     loc_067
	test    rbp, rbp
	lea     rax, [rel str_LC2]
	mov     rdi, qword [rel stderr]
	lea     rsi, [rel str_LC14]
	cmove   rbp, rax
	xor     eax, eax
	mov     rdx, rbp
	call    fprintf
loc_065:  mov     dword [rsp+0x14], 0
loc_066:  mov     eax, dword [rsp+0x14]
	add     rsp, 568
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_067:  mov     rsi, rbp
	lea     rdi, [rel str_LC15]
	xor     eax, eax
	call    printf
	mov     rdi, rbp
	lea     rbx, [rsp+0x20]
	call    print_repo_providers
	mov     dword [rsp+0x14], eax
	call    config_current
	lea     rcx, [rsp+0x30]
	mov     rdx, rbx
	mov     rsi, rbp
	lea     rdi, [rax+0x14]
	mov     r8d, 256
	call    aur_rpc_info
	test    eax, eax
	je      loc_078
	cmp     qword [rsp+0x28], 0
	je      loc_078
	mov     qword [rsp+0x8], 0
	xor     r15d, r15d
	mov     qword [rsp+0x18], rbx
; Note: Immediate operand could be made smaller by sign extension
	jmp     loc_071

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_068:  mov     rsi, rbp
	mov     rdi, r12
	call    strcmp
	test    eax, eax
	jne     loc_074
	lea     rcx, [rel str_LC1]
	test    r13d, r13d
	jne     loc_076
loc_069:  mov     rdx, qword [rbx+0x10]
	mov     rsi, qword [rbx]
	lea     rax, [rel str_LC2]
	lea     rdi, [rel str_LC16]
	test    rdx, rdx
	cmove   rdx, rax
	test    rsi, rsi
	lea     rax, [rel str_LC13]
	cmove   rsi, rax
	xor     eax, eax
	call    printf
	mov     dword [rsp+0x14], 1
loc_070:  add     qword [rsp+0x8], 1
	add     r15, 152
	mov     rax, qword [rsp+0x8]
	cmp     rax, qword [rsp+0x28]
	jnc     loc_077
loc_071:  mov     rbx, qword [rsp+0x20]
	add     rbx, r15
	mov     rdi, qword [rbx]
	mov     r12, qword [rbx+0x80]
	test    rdi, rdi
	je      loc_079
	mov     rsi, rbp
	xor     r13d, r13d
	call    strcmp
	test    eax, eax
	sete    r13b
	test    r12, r12
	jz      loc_075
loc_072:  xor     r14d, r14d
	lea     r12, [rsp+0x130]
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_073:  mov     rax, qword [rbx+0x78]
	mov     edx, 256
	mov     rsi, r12
	mov     rdi, qword [rax+r14*8]
	call    dep_basename
	cmp     byte [rsp+0x130], 0
	jne     loc_068
loc_074:  add     r14, 1
	cmp     r14, qword [rbx+0x80]
	jc      loc_073
loc_075:  test    r13d, r13d
	je      loc_070
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_076:  lea     rcx, [rel str_LC0]
	jmp     loc_069

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_077:  mov     rbx, qword [rsp+0x18]
loc_078:  mov     rdi, rbx
	call    aur_response_destroy
	mov     eax, dword [rsp+0x14]
	test    eax, eax
	jne     loc_066
	mov     rdi, qword [rel stderr]
	mov     rdx, rbp
	lea     rsi, [rel str_LC17]
	xor     eax, eax
	call    fprintf
	jmp     loc_065

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_079:  xor     r13d, r13d
	test    r12, r12
	jne     loc_072
	jmp     loc_070

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

