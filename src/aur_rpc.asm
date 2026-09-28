; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  aur_rpc.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 aur_rpc.asm -o aur_rpc.o
; ---------------------------------------------------------

default rel

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
	push    r15
	push    r14
	push    r13
	push    r12
	mov     r12, rdi
	push    rbp
	push    rbx
	sub     rsp, 104
	mov     rdi, qword [rdi]
	lea     r13, [rsp+0x30]
	mov     r15, rsp
	lea     r14, [rsp+0x28]
	call    free
	mov     rdi, qword [r12+0x8]
	call    free
	mov     rdi, qword [r12+0x10]
	call    free
	mov     rdi, qword [r12+0x18]
	call    free
	mov     rdi, qword [r12+0x20]
	call    free
	mov     rdi, qword [r12+0x28]
	call    free
	lea     rax, [r12+0x48]
	movdqu  xmm0, oword [r12+0x70]
	movdqu  xmm2, oword [r12+0x80]
	mov     qword [rsp], rax
	lea     rax, [r12+0x58]
	movdqu  xmm1, oword [r12+0x50]
	mov     qword [rsp+0x8], rax
	lea     rax, [r12+0x68]
	movdqu  xmm3, oword [r12+0x60]
	punpcklqdq xmm0, xmm2
	mov     qword [rsp+0x10], rax
	lea     rax, [r12+0x78]
	mov     qword [rsp+0x18], rax
	lea     rax, [r12+0x88]
	punpcklqdq xmm1, xmm3
	mov     qword [rsp+0x20], rax
	mov     rax, qword [r12+0x90]
	movaps  oword [rsp+0x30], xmm1
	mov     qword [rsp+0x50], rax
	movaps  oword [rsp+0x40], xmm0
loc_001:  mov     rbp, qword [r13]
	xor     ebx, ebx
	test    rbp, rbp
	jz      loc_003
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_002:  mov     rax, qword [r15]
	mov     rax, qword [rax]
	mov     rdi, qword [rax+rbx*8]
	add     rbx, 1
	call    free
	cmp     rbx, rbp
	jnz     loc_002
loc_003:  mov     rax, qword [r15]
	add     r15, 8
	add     r13, 8
	mov     rdi, qword [rax]
	call    free
	cmp     r15, r14
	jnz     loc_001
	lea     rdi, [r12+0x8]
	mov     qword [r12], 0
	xor     eax, eax
	mov     qword [r12+0x90], 0
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     r12, rdi
	lea     ecx, [r12+0x98]
	shr     ecx, 3
	rep stosq
	add     rsp, 104
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

	nop

ALIGN   16
parse_json_string:
	push    r15
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 40
	mov     rbx, qword [rdi]
	cmp     byte [rbx], 34
	jne     loc_010
	mov     qword [rsp+0x8], rdi
	mov     rdi, rbx
	call    strlen
	lea     rcx, [rax+0x1]
	mov     rdi, rcx
	mov     qword [rsp+0x10], rcx
	call    malloc
	mov     rdx, rax
	test    rax, rax
	je      loc_010
	lea     r12, [rbx+0x1]
	movzx   ebx, byte [rbx+0x1]
	mov     rsi, qword [rsp+0x8]
	test    bl, bl
	je      loc_019
	cmp     bl, 34
	mov     rcx, qword [rsp+0x10]
	je      loc_019
	xor     ebp, ebp
	jmp     loc_006

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_004:  mov     byte [r14], bl
	mov     rbp, r15
	mov     r12, r13
loc_005:  movzx   ebx, byte [r12]
	test    bl, bl
	je      loc_017
	cmp     bl, 34
	je      loc_017
loc_006:  lea     rax, [rbp+0x8]
	lea     r14, [rdx+rbp]
	cmp     rax, rcx
	jnc     loc_014
	lea     r13, [r12+0x1]
	lea     r15, [rbp+0x1]
	cmp     bl, 92
	jnz     loc_004
	movzx   ebx, byte [r12+0x1]
	test    bl, bl
	je      loc_018
	lea     r13, [r12+0x2]
	cmp     bl, 114
	je      loc_013
	jg      loc_007
	cmp     bl, 102
	je      loc_012
	cmp     bl, 110
	jz      loc_008
	cmp     bl, 98
	mov     eax, 8
	cmove   ebx, eax
	jmp     loc_004

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_007:  cmp     bl, 116
	jz      loc_009
	cmp     bl, 117
	jne     loc_004
	mov     rdi, r13
	mov     qword [rsp+0x18], rsi
	mov     qword [rsp+0x10], rdx
	mov     qword [rsp+0x8], rcx
	call    strlen
	mov     rcx, qword [rsp+0x8]
	mov     rdx, qword [rsp+0x10]
	cmp     rax, 3
	mov     rsi, qword [rsp+0x18]
	jbe     loc_004
	mov     eax, 30044
	add     r12, 6
	mov     word [r14], ax
	mov     eax, dword [r12-0x4]
	mov     dword [rdx+rbp+0x2], eax
	add     rbp, 6
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_008:  mov     ebx, 10
	jmp     loc_004

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_009:  mov     ebx, 9
	jmp     loc_004

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_010:  xor     edx, edx
loc_011:  add     rsp, 40
	mov     rax, rdx
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_012:  mov     ebx, 12
	jmp     loc_004

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_013:  mov     ebx, 13
	jmp     loc_004

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_014:  movzx   ebx, byte [r12]
loc_015:  xor     eax, eax
	cmp     bl, 34
	sete    al
	add     r12, rax
loc_016:  mov     byte [r14], 0
	mov     qword [rsi], r12
	jmp     loc_011

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_017:  lea     r14, [rdx+rbp]
	jmp     loc_015

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_018:  mov     byte [r14], 92
	mov     r12, r13
	lea     r14, [rdx+r15]
	jmp     loc_016

loc_019:
	mov     r14, rdx
	jmp     loc_015

; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x00

ALIGN   16

find_key:
	push    r12
	mov     rcx, rdx
	xor     eax, eax
	lea     rdx, [rel str_LC1]
	push    rbp
	mov     rbp, rsi
	mov     esi, 96
	push    rbx
	mov     rbx, rdi
	sub     rsp, 96
	mov     rdi, rsp
	mov     r12, rsp
	call    snprintf
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_020:  mov     rdi, rbx
	mov     rsi, r12
	call    strstr
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_023
	test    rax, rax
	jz      loc_023
	mov     rdi, r12
	call    strlen
	add     rbx, rax
	cmp     rbx, rbp
	jnc     loc_020
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_022

; Filling space: 0x1E
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_021:  add     rbx, 1
	cmp     rbp, rbx
	jz      loc_020
loc_022:  movzx   eax, byte [rbx]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_021
	cmp     rbx, rbp
	jnc     loc_020
	cmp     byte [rbx], 58
	jnz     loc_020
	add     rsp, 96
	lea     rax, [rbx+0x1]
	pop     rbx
	pop     rbp
	pop     r12
	ret

loc_023:
	add     rsp, 96
	xor     eax, eax
	pop     rbx
	pop     rbp
	pop     r12
	ret

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16

object_array:
	push    r14
	push    r13
	mov     r13, rsi
	push    r12
	push    rbp
	mov     rbp, rcx
	push    rbx
	mov     rbx, r8
	sub     rsp, 16
	call    find_key
	mov     qword [rbp], 0
	mov     qword [rbx], 0
	test    rax, rax
	je      loc_031
	mov     r12, rax
	cmp     rax, r13
	jnc     loc_038
	call    __ctype_b_loc
	mov     rcx, qword [rax]
	jmp     loc_025

; Filling space: 0x18
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x90

ALIGN   16
loc_024:  lea     rax, [r12+0x1]
	cmp     rax, r13
	je      loc_036
	mov     r12, rax
loc_025:  movzx   edx, byte [r12]
	mov     rax, rdx
	test    byte [rcx+rdx*2+0x1], 0x20
	jnz     loc_024
loc_026:  cmp     al, 91
	jnz     loc_031
loc_027:  add     r12, 1
	mov     qword [rsp+0x8], r12
	cmp     r12, r13
	jnc     loc_035
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_028:  call    __ctype_b_loc
	mov     rdi, qword [rax]
	xor     eax, eax
	jmp     loc_030

; Filling space: 0x14
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_029:  mov     r14, r12
loc_030:  movzx   edx, byte [r12]
	mov     esi, eax
	movzx   eax, dl
	movzx   eax, byte [rdi+rax*2+0x1]
	shr     al, 5
	and     eax, 0x01
	cmp     dl, 44
	sete    cl
	or      al, cl
	jz      loc_033
	add     r12, 1
	cmp     r12, r13
	jnz     loc_029
loc_031:  mov     eax, 1
loc_032:  add     rsp, 16
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_033:  test    sil, sil
	jz      loc_034
	mov     qword [rsp+0x8], r14
loc_034:  cmp     dl, 93
	jz      loc_031
	cmp     dl, 34
	jnz     loc_035
	lea     rdi, [rsp+0x8]
	call    parse_json_string
	mov     rdi, qword [rbp]
	mov     r12, rax
	mov     rax, qword [rbx]
	lea     rsi, [rax*8+0x8]
	call    realloc
	test    r12, r12
	jz      loc_037
	test    rax, rax
	jz      loc_037
	mov     rdx, qword [rbx]
	mov     qword [rbp], rax
	lea     rcx, [rdx+0x1]
	mov     qword [rbx], rcx
	mov     qword [rax+rdx*8], r12
	mov     r12, qword [rsp+0x8]
	cmp     r12, r13
	jc      loc_028
loc_035:  xor     eax, eax
	jmp     loc_032

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_036:  movzx   eax, byte [r12+0x1]
	mov     r12, r13
	cmp     al, 91
	jne     loc_031
	jmp     loc_027

loc_037:  mov     rdi, r12
	call    free
	xor     eax, eax
	jmp     loc_032

loc_038:
	movzx   eax, byte [rax]
	jmp     loc_026

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16

object_string:
	push    r12
	push    rbp
	mov     rbp, rsi
	push    rbx
	sub     rsp, 16
	call    find_key
	mov     qword [rsp+0x8], rax
	test    rax, rax
	jz      loc_043
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_042
	call    __ctype_b_loc
	xor     edx, edx
	mov     rcx, qword [rax]
	jmp     loc_040

; Filling space: 0x12
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x80, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_039:  add     rbx, 1
	mov     edx, 1
	cmp     rbx, rbp
	jz      loc_045
	mov     r12, rbx
loc_040:  movzx   eax, byte [rbx]
	test    byte [rcx+rax*2+0x1], 0x20
	jnz     loc_039
	test    dl, dl
	jz      loc_041
	mov     qword [rsp+0x8], r12
loc_041:  sub     rbp, rbx
	cmp     rbp, 3
	jle     loc_042
	mov     edx, 4
	lea     rsi, [rel str_LC3]
	mov     rdi, rbx
	call    strncmp
	test    eax, eax
	jz      loc_043
loc_042:  cmp     byte [rbx], 34
	jz      loc_044
loc_043:  add     rsp, 16
	lea     rdi, [rel str_LC2]
	pop     rbx
	pop     rbp
	pop     r12
	jmp     strdup

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_044:  lea     rdi, [rsp+0x8]
	call    parse_json_string
	add     rsp, 16
	pop     rbx
	pop     rbp
	pop     r12
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_045:  cmp     byte [rbx], 34
	mov     qword [rsp+0x8], rbx
	jz      loc_044
	jmp     loc_043

; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16

object_long:
	push    rbp
	mov     rbp, rsi
	push    rbx
	sub     rsp, 8
	call    find_key
	test    rax, rax
	jz      loc_049
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_048
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_047

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_046:  add     rbx, 1
	cmp     rbp, rbx
	jz      loc_048
loc_047:  movzx   eax, byte [rbx]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_046
loc_048:  add     rsp, 8
	mov     rdi, rbx
	mov     edx, 10
	xor     esi, esi
	pop     rbx
	pop     rbp
	jmp     strtol

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_049:  add     rsp, 8
	xor     eax, eax
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

set_error:
	test    rdi, rdi
	jz      loc_053
	push    r13
	push    r12
	push    rbp
	mov     rbp, rsi
	push    rbx
	sub     rsp, 8
	test    rsi, rsi
	jz      loc_051
	mov     rbx, rdi
	mov     r12, rdx
	test    rdx, rdx
	jz      loc_052
	mov     rdi, rdx
	call    strlen
	mov     r13, rax
loc_050:  lea     rax, [rbp-0x1]
	cmp     r13, rbp
	mov     rsi, r12
	mov     rdi, rbx
	cmovnc  r13, rax
	mov     rdx, r13
	call    memcpy
	mov     byte [rbx+r13], 0
loc_051:  add     rsp, 8
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	ret

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_052:  mov     r13d, 13
	lea     r12, [rel str_LC4]
	jmp     loc_050

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_053:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

curl_get.constprop.0:
	push    r15
	push    r14
	push    r13
	push    r12
	push    rbp
	mov     rbp, rdi
	push    rbx
	mov     rbx, rsi
	sub     rsp, 8248
	mov     qword [rsi], 0
	lea     rdi, [rsp+0x28]
	mov     qword [rsp+0x10], rdx
	mov     qword [rsp+0x18], rcx
	call    pipe
	test    eax, eax
	jne     loc_062
	call    fork
	mov     dword [rsp+0x0C], eax
	test    eax, eax
	js      loc_061
	je      loc_058
	mov     edi, dword [rsp+0x2C]
	xor     r15d, r15d
	xor     ebp, ebp
	lea     r12, [rsp+0x30]
	call    close
; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16
loc_054:  mov     edi, dword [rsp+0x28]
	mov     edx, 8192
	mov     rsi, r12
	call    read
	mov     r14, rax
	test    rax, rax
	jle     loc_065
	lea     r13, [r14+rbp]
	lea     rax, [r13+0x1]
	cmp     r15, rax
	jnc     loc_060
	test    r15, r15
	jnz     loc_055
	mov     r15d, 8192
	cmp     rax, 8192
	jbe     loc_056
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_055:  add     r15, r15
	cmp     r15, rax
	jc      loc_055
loc_056:  mov     rdi, qword [rbx]
	mov     rsi, r15
	call    realloc
	test    rax, rax
	je      loc_070
	mov     qword [rbx], rax
loc_057:  lea     rdi, [rax+rbp]
	mov     rdx, r14
	mov     rsi, r12
	mov     rbp, r13
	call    memcpy
	mov     rax, qword [rbx]
	mov     byte [rax+r13], 0
	jmp     loc_054

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_058:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	mov     esi, 1
	call    dup2
	test    eax, eax
	js      loc_059
	mov     edi, dword [rsp+0x2C]
	call    close
	lea     rax, [rel str_LC10]
	push    0
	lea     rdi, [rel str_LC9]
	push    rbp
	lea     r9, [rel str_LC5]
	lea     r8, [rel str_LC6]
	mov     rsi, rdi
	push    rax
	lea     rax, [rel str_LC11]
	lea     rcx, [rel str_LC7]
	push    rax
	lea     rax, [rel str_LC12]
	lea     rdx, [rel str_LC8]
	push    rax
	lea     rax, [rel str_LC13]
	push    rax
	xor     eax, eax
	call    execlp
	add     rsp, 48
loc_059:  mov     edi, 127
	call    _exit
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_060:  mov     rax, qword [rbx]
	jmp     loc_057

loc_061:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	call    close
loc_062:  call    __errno_location
	mov     edi, dword [rax]
	call    strerror
	mov     rsi, qword [rsp+0x18]
	mov     rdi, qword [rsp+0x10]
	mov     rdx, rax
	call    set_error
loc_063:  xor     eax, eax
loc_064:  add     rsp, 8248
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_065:  mov     edi, dword [rsp+0x28]
	lea     rbp, [rsp+0x24]
	call    close
	jmp     loc_067

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_066:  call    __errno_location
	cmp     dword [rax], 4
	jnz     loc_068
loc_067:  mov     edi, dword [rsp+0x0C]
	xor     edx, edx
	mov     rsi, rbp
	call    waitpid
	test    eax, eax
	js      loc_066
loc_068:  mov     rdi, qword [rbx]
; Note: Length-changing prefix causes delay on old Intel processors
	test    word [rsp+0x24], 0x0FF7F
	jne     loc_074
	test    rdi, rdi
	je      loc_076
loc_069:  xor     eax, eax
	test    rdi, rdi
	setne   al
	jmp     loc_064

loc_070:  mov     edi, dword [rsp+0x28]
	call    close
	mov     r14d, dword [rsp+0x0C]
	mov     esi, 15
	mov     edi, r14d
	call    kill
	xor     edx, edx
	xor     esi, esi
	mov     edi, r14d
	call    waitpid
	mov     rdi, qword [rbx]
	call    free
	cmp     qword [rsp+0x10], 0
	mov     qword [rbx], 0
	je      loc_063
	cmp     qword [rsp+0x18], 0
	je      loc_063
	mov     rcx, qword [rsp+0x18]
	mov     eax, 14
	lea     rdx, [rel str_LC14]
	cmp     rcx, rax
	cmova   rcx, rax
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_072
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC14]
	test    al, 0x04
	jne     loc_080
	test    eax, eax
	jz      loc_071
	movzx   esi, byte [rel str_LC14]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], sil
	test    al, 0x02
	jne     loc_075
loc_071:  mov     rax, qword [rsp+0x10]
	mov     byte [rax+rcx-0x1], 0
	jmp     loc_063

loc_072:  mov     rbx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC14]
	mov     qword [rbx], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbx+rsi-0x8], rdi
	lea     rsi, [rbx+0x8]
	and     rsi, 0x0FFFFFFFFFFFFFFF8
	sub     rbx, rsi
	add     eax, ebx
	sub     rdx, rbx
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_071
	and     eax, 0x0FFFFFFF8
	xor     edi, edi
loc_073:  mov     r8d, edi
	add     edi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rsi+r8], r9
	cmp     edi, eax
	jc      loc_073
	jmp     loc_071

loc_074:  call    free
	cmp     qword [rsp+0x10], 0
	mov     qword [rbx], 0
	je      loc_063
	mov     rax, qword [rsp+0x18]
	test    rax, rax
	je      loc_063
	mov     ecx, 28
	lea     rdx, [rel str_LC15]
	cmp     rax, rcx
	cmovbe  rcx, rax
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_077
	test    al, 0x04
	jne     loc_079
	test    eax, eax
	je      loc_071
	movzx   esi, byte [rel str_LC15]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], sil
	test    al, 0x02
	je      loc_071
loc_075:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	movzx   edx, word [rdx+rax-0x2]
	mov     word [rbx+rax-0x2], dx
	jmp     loc_071

loc_076:  lea     rdi, [rel str_LC2]
	call    strdup
	mov     qword [rbx], rax
	mov     rdi, rax
	jmp     loc_069

loc_077:  mov     rbx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC15]
	mov     qword [rbx], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbx+rsi-0x8], rdi
	lea     rdi, [rbx+0x8]
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rbx, rdi
	add     eax, ebx
	sub     rdx, rbx
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_071
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_078:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_078
	jmp     loc_071

loc_079:
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC15]
loc_080:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbx], esi
	mov     dword [rbx+rax-0x4], edx
	jmp     loc_071

	nop

ALIGN   16
request:
	push    r15
	push    r14
	push    r13
	mov     r13, rdx
	push    r12
	mov     r12, r9
	push    rbp
	mov     rbp, r8
	push    rbx
	mov     rbx, rcx
	sub     rsp, 216
	mov     qword [rsp+0x10], rdi
	mov     rdi, rdx
	mov     qword [rsp], rsi
	call    strlen
	lea     rdi, [rax+rax*2+0x1]
	mov     r14, rax
	call    malloc
	test    rax, rax
	je      loc_121
	mov     r15, rax
	mov     rcx, rax
	test    r14, r14
	je      loc_085
	call    __ctype_b_loc
	mov     rdx, r13
	lea     r9, [r13+r14]
	xor     ecx, ecx
	mov     r10, qword [rax]
	lea     r11, [rel hex.0]
	jmp     loc_082

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_081:  lea     esi, [rsi-0x2D]
	cmp     sil, 1
	jbe     loc_083
	cmp     al, 95
	jz      loc_083
	cmp     al, 126
	jz      loc_083
	mov     esi, eax
	and     eax, 0x0F
	mov     byte [rdi], 37
	add     rdx, 1
	shr     sil, 4
	movzx   eax, byte [r11+rax]
	lea     rdi, [rcx+0x2]
	and     esi, 0x0F
	movzx   esi, byte [r11+rsi]
	mov     byte [r15+rcx+0x1], sil
	add     rcx, 3
	mov     byte [r15+rdi], al
	cmp     r9, rdx
	jz      loc_084
; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16
loc_082:  movzx   esi, byte [rdx]
	lea     r13, [rcx+0x1]
	lea     rdi, [r15+rcx]
	mov     rax, rsi
	test    byte [r10+rsi*2], 0x08
; Note: Immediate operand could be made smaller by sign extension
	je      loc_081
loc_083:  add     rdx, 1
	mov     byte [rdi], al
	mov     rcx, r13
	cmp     r9, rdx
	jnz     loc_082
loc_084:  add     rcx, r15
loc_085:  mov     byte [rcx], 0
	pxor    xmm0, xmm0
	mov     rdi, qword [rsp+0x10]
	movups  oword [rbx], xmm0
	mov     qword [rsp+0x28], 0
	call    strlen
	mov     rdi, qword [rsp]
	mov     qword [rsp+0x8], rax
	call    strlen
	mov     rdi, r15
	mov     r13, rax
	call    strlen
	mov     rdx, qword [rsp+0x8]
	lea     rdx, [rdx+r13+0x20]
	lea     r13, [rdx+rax]
	mov     rdi, r13
	call    malloc
	mov     qword [rsp+0x8], rax
	test    rax, rax
	je      loc_141
	mov     rdi, qword [rsp]
	lea     rsi, [rel str_LC17]
	call    strcmp
	mov     rcx, qword [rsp+0x10]
	mov     r8, r15
	test    eax, eax
	je      loc_092
	mov     rdi, qword [rsp+0x8]
	lea     rdx, [rel str_LC19]
	mov     rsi, r13
	xor     eax, eax
	call    snprintf
loc_086:  mov     rdi, r15
	call    free
	mov     rdi, qword [rsp+0x8]
	mov     rcx, r12
	mov     rdx, rbp
	lea     rsi, [rsp+0x28]
	call    curl_get.constprop.0
	mov     rdi, qword [rsp+0x28]
	mov     dword [rsp+0x10], eax
	mov     qword [rsp+0x18], rdi
	test    eax, eax
	je      loc_112
	lea     rsi, [rel str_LC20]
	call    strstr
	mov     rdi, rax
	test    rax, rax
	je      loc_125
	mov     esi, 91
	call    strchr
	test    rax, rax
	je      loc_125
	lea     r15, [rax+0x1]
	movzx   eax, byte [rax+0x1]
	test    al, al
	je      loc_118
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_087:  mov     r13, r15
	cmp     al, 123
	jnz     loc_089
	jmp     loc_094

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_088:  movzx   eax, byte [r13+0x1]
	add     r13, 1
	test    al, al
	je      loc_120
	cmp     al, 123
	jz      loc_093
loc_089:  cmp     al, 93
	jnz     loc_088
loc_090:  mov     rdi, qword [rsp+0x8]
	call    free
	mov     rdi, qword [rsp+0x18]
	call    free
loc_091:  mov     eax, dword [rsp+0x10]
	add     rsp, 216
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_092:  mov     rdi, qword [rsp+0x8]
	lea     rdx, [rel str_LC18]
	mov     rsi, r13
	call    snprintf
	jmp     loc_086

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_093:  test    al, al
	je      loc_120
loc_094:  mov     r15, r13
	xor     esi, esi
	mov     eax, 123
	jmp     loc_098

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_095:  cmp     al, 125
	jz      loc_099
loc_096:  mov     r15, rdx
loc_097:  movzx   eax, byte [r15]
	test    al, al
	je      loc_110
loc_098:  lea     rdx, [r15+0x1]
	cmp     al, 34
	je      loc_107
	cmp     al, 123
	jnz     loc_095
	add     esi, 1
	jmp     loc_096

loc_099:  sub     esi, 1
	jnz     loc_096
	mov     r15, rdx
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_100:  lea     r14, [rsp+0x30]
	xor     eax, eax
	mov     ecx, 19
	mov     rsi, r15
	mov     rdi, r14
	lea     rdx, [rel str_LC23]
	rep stosq
	mov     rdi, r13
	call    object_string
	lea     rdx, [rel str_LC24]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x30], rax
	call    object_string
	lea     rdx, [rel str_LC25]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x38], rax
	call    object_string
	lea     rdx, [rel str_LC26]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x40], rax
	call    object_string
	lea     rdx, [rel str_LC27]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x48], rax
	call    object_string
	lea     rdx, [rel str_LC28]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x50], rax
	call    object_string
	lea     rdx, [rel str_LC29]
	mov     rsi, r15
	mov     rdi, r13
	mov     qword [rsp+0x58], rax
	call    object_long
	mov     rdi, r13
	lea     rdx, [rel str_LC30]
	mov     rsi, r15
	mov     qword [rsp+0x60], rax
	call    find_key
	mov     rdi, rax
	test    rax, rax
	je      loc_116
	cmp     rax, r15
	jnc     loc_103
	mov     qword [rsp], rax
	call    __ctype_b_loc
	mov     rdi, qword [rsp]
	mov     rdx, qword [rax]
	jmp     loc_102

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_101:  add     rdi, 1
	cmp     r15, rdi
	jz      loc_103
loc_102:  movzx   eax, byte [rdi]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_101
loc_103:  xor     esi, esi
	call    strtod
loc_104:  lea     rdx, [rel str_LC31]
	mov     rsi, r15
	mov     rdi, r13
	movsd   qword [rsp+0x68], xmm0
	call    object_long
	cmp     qword [rsp+0x30], 0
	mov     qword [rsp+0x70], rax
; Note: Immediate operand could be made smaller by sign extension
	je      loc_105
	cmp     qword [rsp+0x38], 0
	jz      loc_105
	cmp     qword [rsp+0x40], 0
	jz      loc_105
	cmp     qword [rsp+0x48], 0
	jz      loc_105
	cmp     qword [rsp+0x50], 0
	jz      loc_105
	cmp     qword [rsp+0x58], 0
	jz      loc_105
	lea     rcx, [rsp+0x78]
	lea     rdx, [rel str_LC32]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x80]
	call    object_array
	test    eax, eax
	jz      loc_105
	lea     rcx, [rsp+0x88]
	lea     rdx, [rel str_LC33]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x90]
	call    object_array
	test    eax, eax
	jne     loc_117
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_105:  mov     rdi, r14
	call    package_destroy
	test    rbp, rbp
	je      loc_112
	test    r12, r12
	je      loc_112
	mov     ecx, 34
	lea     rdx, [rel str_LC37]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jc      loc_133
	mov     rsi, qword [rel str_LC37]
	mov     qword [rbp], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbp+rsi-0x8], rdi
	lea     rdi, [rbp+0x8]
	mov     rsi, rbp
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rsi, rdi
	add     eax, esi
	sub     rdx, rsi
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_111
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_106:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_106
	jmp     loc_111

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_107:  movzx   eax, byte [r15+0x1]
	test    al, al
	je      loc_124
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_108:  lea     rcx, [rdx+0x1]
	mov     r15, rcx
	cmp     al, 92
	je      loc_115
	movzx   edx, byte [rdx+0x1]
	cmp     al, 34
	je      loc_097
	mov     eax, edx
loc_109:  mov     rdx, rcx
	test    al, al
	jnz     loc_108
	mov     r15, rcx
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_110:  test    esi, esi
	je      loc_100
	test    rbp, rbp
	jz      loc_112
	test    r12, r12
	jz      loc_112
	mov     ecx, 25
	lea     rdx, [rel str_LC22]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_134
	test    al, 0x04
	jne     loc_138
	test    eax, eax
	jz      loc_111
	movzx   esi, byte [rel str_LC22]
	mov     byte [rbp], sil
	test    al, 0x02
	jne     loc_126
loc_111:  mov     byte [rbp+rcx-0x1], 0
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_112:  xor     ebp, ebp
	cmp     qword [rbx+0x8], 0
	jz      loc_114
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_113:  lea     rax, [rbp+rbp*8]
	lea     rdx, [rbp+rax*2]
	mov     rax, qword [rbx]
	add     rbp, 1
	lea     rdi, [rax+rdx*8]
	call    package_destroy
	cmp     rbp, qword [rbx+0x8]
	jc      loc_113
loc_114:  mov     rdi, qword [rbx]
	call    free
	mov     qword [rbx], 0
	mov     qword [rbx+0x8], 0
	mov     dword [rsp+0x10], 0
	jmp     loc_090

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_115:  cmp     byte [rdx+0x1], 0
	je      loc_110
	movzx   eax, byte [rdx+0x2]
	lea     rcx, [rdx+0x2]
	jmp     loc_109

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_116:  pxor    xmm0, xmm0
	jmp     loc_104

loc_117:  lea     rcx, [rsp+0x98]
	lea     rdx, [rel str_LC34]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0A0]
	call    object_array
	test    eax, eax
	je      loc_105
	lea     rcx, [rsp+0x0A8]
	lea     rdx, [rel str_LC35]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0B0]
	call    object_array
	test    eax, eax
	je      loc_105
	lea     rcx, [rsp+0x0B8]
	lea     rdx, [rel str_LC36]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0C0]
	call    object_array
	test    eax, eax
	je      loc_105
	mov     rax, qword [rbx+0x8]
	mov     rdi, qword [rbx]
	add     rax, 1
	lea     rdx, [rax+rax*8]
	lea     rsi, [rax+rdx*2]
	shl     rsi, 3
	call    realloc
	mov     rdx, rax
	test    rax, rax
	je      loc_105
	mov     qword [rbx], rax
	mov     rax, qword [rbx+0x8]
	movdqa  xmm0, oword [rsp+0x30]
	lea     rcx, [rax+0x1]
	mov     qword [rbx+0x8], rcx
	lea     rcx, [rax+rax*8]
	lea     rax, [rax+rcx*2]
	lea     rax, [rdx+rax*8]
	movups  oword [rax], xmm0
	movdqa  xmm0, oword [rsp+0x40]
	movups  oword [rax+0x10], xmm0
	movdqa  xmm0, oword [rsp+0x50]
	movups  oword [rax+0x20], xmm0
	movdqa  xmm0, oword [rsp+0x60]
	movups  oword [rax+0x30], xmm0
	movdqa  xmm0, oword [rsp+0x70]
	movups  oword [rax+0x40], xmm0
	movdqa  xmm0, oword [rsp+0x80]
	movups  oword [rax+0x50], xmm0
	movdqa  xmm0, oword [rsp+0x90]
	movups  oword [rax+0x60], xmm0
	movdqa  xmm0, oword [rsp+0x0A0]
	movups  oword [rax+0x70], xmm0
	movdqa  xmm0, oword [rsp+0x0B0]
	movups  oword [rax+0x80], xmm0
	mov     rdx, qword [rsp+0x0C0]
	mov     qword [rax+0x90], rdx
	movzx   eax, byte [r15]
	test    al, al
	jne     loc_087
loc_118:  test    rbp, rbp
	je      loc_112
	test    r12, r12
	je      loc_112
	mov     ecx, 26
	lea     rdx, [rel str_LC38]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jc      loc_132
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC38]
	mov     qword [rbp], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbp+rsi-0x8], rdi
	lea     rdi, [rbp+0x8]
	mov     rsi, rbp
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rsi, rdi
	add     eax, esi
	sub     rdx, rsi
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_111
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_119:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_119
	jmp     loc_111

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_120:  mov     r15, r13
	jmp     loc_100

loc_121:  pxor    xmm0, xmm0
	movups  oword [rbx], xmm0
	test    rbp, rbp
	jz      loc_123
	test    r12, r12
	jz      loc_123
	mov     edx, 14
	lea     rcx, [rel str_LC14]
	cmp     r12, rdx
	cmovbe  rdx, r12
	lea     rax, [rdx-0x1]
	cmp     eax, 8
	jnc     loc_127
	test    al, 0x04
	jne     loc_139
	test    eax, eax
	jne     loc_131
loc_122:  mov     byte [rbp+rdx-0x1], 0
loc_123:  mov     dword [rsp+0x10], 0
	jmp     loc_091

loc_124:  mov     r15, rdx
	jmp     loc_110

loc_125:  test    rbp, rbp
	je      loc_112
	test    r12, r12
	je      loc_112
	mov     ecx, 25
	lea     rdx, [rel str_LC21]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_129
	test    al, 0x04
	jne     loc_136
	test    eax, eax
	je      loc_111
	movzx   esi, byte [rel str_LC21]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_111
loc_126:  mov     eax, eax
	movzx   edx, word [rdx+rax-0x2]
	mov     word [rbp+rax-0x2], dx
	jmp     loc_111

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_127:
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC14]
	mov     qword [rbp], rsi
	mov     esi, eax
	mov     rdi, qword [rcx+rsi-0x8]
	mov     qword [rbp+rsi-0x8], rdi
	lea     rdi, [rbp+0x8]
	mov     rsi, rbp
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rsi, rdi
	add     eax, esi
	sub     rcx, rsi
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_122
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_128:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rcx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_128
	jmp     loc_122

loc_129:
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC21]
	mov     qword [rbp], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbp+rsi-0x8], rdi
	lea     rdi, [rbp+0x8]
	mov     rsi, rbp
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rsi, rdi
	add     eax, esi
	sub     rdx, rsi
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_111
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_130:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_130
	jmp     loc_111

loc_131:  movzx   esi, byte [rel str_LC14]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_122
	mov     eax, eax
	movzx   ecx, word [rcx+rax-0x2]
	mov     word [rbp+rax-0x2], cx
	jmp     loc_122

loc_132:  test    al, 0x04
	jne     loc_140
	test    eax, eax
	je      loc_111
	movzx   esi, byte [rel str_LC38]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_111
	jmp     loc_126

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_133:  test    al, 0x04
	jne     loc_137
	test    eax, eax
	je      loc_111
	movzx   esi, byte [rel str_LC37]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_111
	jmp     loc_126

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_134:  mov     rsi, qword [rel str_LC22]
	mov     qword [rbp], rsi
	mov     esi, eax
	mov     rdi, qword [rdx+rsi-0x8]
	mov     qword [rbp+rsi-0x8], rdi
	lea     rdi, [rbp+0x8]
	mov     rsi, rbp
	and     rdi, 0x0FFFFFFFFFFFFFFF8
	sub     rsi, rdi
	add     eax, esi
	sub     rdx, rsi
	and     eax, 0x0FFFFFFF8
	cmp     eax, 8
	jc      loc_111
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_135:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_135
	jmp     loc_111

loc_136:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC21]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_111

loc_137:  mov     eax, eax
	mov     esi, dword [rel str_LC37]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_111

loc_138:  mov     eax, eax
	mov     esi, dword [rel str_LC22]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_111

loc_139:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC14]
	mov     ecx, dword [rcx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], ecx
	jmp     loc_122

loc_140:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC38]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_111

loc_141:
	mov     rdi, r15
	call    free
	lea     rdx, [rel str_LC14]
	mov     rsi, r12
	mov     rdi, rbp
	call    set_error
	jmp     loc_123

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

aur_response_destroy:; Function begin
	test    rdi, rdi
	jz      loc_144
	push    rbp
	mov     rbp, rdi
	push    rbx
	sub     rsp, 8
	cmp     qword [rdi+0x8], 0
	jz      loc_143
	xor     ebx, ebx
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_142:  lea     rax, [rbx+rbx*8]
	lea     rdx, [rbx+rax*2]
	mov     rax, qword [rbp]
	add     rbx, 1
	lea     rdi, [rax+rdx*8]
	call    package_destroy
	cmp     rbx, qword [rbp+0x8]
	jc      loc_142
loc_143:  mov     rdi, qword [rbp]
	call    free
	mov     qword [rbp], 0
	mov     qword [rbp+0x8], 0
	add     rsp, 8
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_144:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

aur_rpc_search:; Function begin
	test    rdi, rdi
	lea     rax, [rel str_LC40]
	mov     r9, r8
	mov     r8, rcx
	cmove   rdi, rax
	mov     rcx, rdx
	mov     rdx, rsi
	lea     rsi, [rel str_LC17]
	jmp     request

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16

aur_rpc_info:; Function begin
	test    rdi, rdi
	lea     rax, [rel str_LC40]
	mov     r9, r8
	mov     r8, rcx
	cmove   rdi, rax
	mov     rcx, rdx
	mov     rdx, rsi
	lea     rsi, [rel str_LC41]
	jmp     request

SECTION .rodata.str1.1 align=1 noexec

str_LC1:
	db 0x22, 0x25, 0x73, 0x22, 0x00

str_LC2:
	db 0x00

str_LC3:
	db 0x6E, 0x75, 0x6C, 0x6C, 0x00

str_LC4:
	db 0x75, 0x6E, 0x6B, 0x6E, 0x6F, 0x77, 0x6E, 0x20
	db 0x65, 0x72, 0x72, 0x6F, 0x72, 0x00

str_LC5:
	db 0x2D, 0x2D, 0x6C, 0x6F, 0x63, 0x61, 0x74, 0x69
	db 0x6F, 0x6E, 0x00

str_LC6:
	db 0x2D, 0x2D, 0x73, 0x68, 0x6F, 0x77, 0x2D, 0x65
	db 0x72, 0x72, 0x6F, 0x72, 0x00

str_LC7:
	db 0x2D, 0x2D, 0x73, 0x69, 0x6C, 0x65, 0x6E, 0x74
	db 0x00

str_LC8:
	db 0x2D, 0x2D, 0x66, 0x61, 0x69, 0x6C, 0x00

str_LC9:
	db 0x63, 0x75, 0x72, 0x6C, 0x00

str_LC10:
	db 0x36, 0x30, 0x00

str_LC11:
	db 0x2D, 0x2D, 0x6D, 0x61, 0x78, 0x2D, 0x74, 0x69
	db 0x6D, 0x65, 0x00

str_LC12:
	db 0x31, 0x35, 0x00

str_LC13:
	db 0x2D, 0x2D, 0x63, 0x6F, 0x6E, 0x6E, 0x65, 0x63
	db 0x74, 0x2D, 0x74, 0x69, 0x6D, 0x65, 0x6F, 0x75
	db 0x74, 0x00

str_LC14:  dq 0x6D20666F2074756F
	db 0x65, 0x6D, 0x6F, 0x72, 0x79, 0x00

str_LC15:  dq 0x2043505220525541
	dq 0x7165722050545448
	dq 0x6961662074736575
	db 0x6C, 0x65, 0x64, 0x00

str_LC17:
	db 0x73, 0x65, 0x61, 0x72, 0x63, 0x68, 0x00

str_LC18:
	db 0x25, 0x73, 0x2F, 0x73, 0x65, 0x61, 0x72, 0x63
	db 0x68, 0x2F, 0x25, 0x73, 0x3F, 0x62, 0x79, 0x3D
	db 0x6E, 0x61, 0x6D, 0x65, 0x2D, 0x64, 0x65, 0x73
	db 0x63, 0x00

str_LC19:
	db 0x25, 0x73, 0x2F, 0x69, 0x6E, 0x66, 0x6F, 0x3F
	db 0x61, 0x72, 0x67, 0x5B, 0x5D, 0x3D, 0x25, 0x73
	db 0x00

str_LC20:
	db 0x22, 0x72, 0x65, 0x73, 0x75, 0x6C, 0x74, 0x73
	db 0x22, 0x00

str_LC21:  dq 0x2064696C61766E69
	dq 0x2043505220525541
	dq 0x65736E6F70736572
	db 0x00

str_LC22:  dq 0x657461636E757274
	dq 0x5052205255412064
	dq 0x7463656A626F2043
	db 0x00

str_LC23:
	db 0x4E, 0x61, 0x6D, 0x65, 0x00

str_LC24:
	db 0x50, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x42
	db 0x61, 0x73, 0x65, 0x00

str_LC25:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00

str_LC26:
	db 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74
	db 0x69, 0x6F, 0x6E, 0x00

str_LC27:
	db 0x55, 0x52, 0x4C, 0x00

str_LC28:
	db 0x4D, 0x61, 0x69, 0x6E, 0x74, 0x61, 0x69, 0x6E
	db 0x65, 0x72, 0x00

str_LC29:
	db 0x4E, 0x75, 0x6D, 0x56, 0x6F, 0x74, 0x65, 0x73
	db 0x00

str_LC30:
	db 0x50, 0x6F, 0x70, 0x75, 0x6C, 0x61, 0x72, 0x69
	db 0x74, 0x79, 0x00

str_LC31:
	db 0x4F, 0x75, 0x74, 0x4F, 0x66, 0x44, 0x61, 0x74
	db 0x65, 0x00

str_LC32:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x00

str_LC33:
	db 0x4D, 0x61, 0x6B, 0x65, 0x44, 0x65, 0x70, 0x65
	db 0x6E, 0x64, 0x73, 0x00

str_LC34:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x44, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x73, 0x00

str_LC35:
	db 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65, 0x73
	db 0x00

str_LC36:
	db 0x43, 0x6F, 0x6E, 0x66, 0x6C, 0x69, 0x63, 0x74
	db 0x73, 0x00

str_LC38:  dq 0x657461636E757274
	dq 0x5052205255412064
	dq 0x746C757365722043
	db 0x73, 0x00

str_LC41:
	db 0x69, 0x6E, 0x66, 0x6F, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC37:  dq 0x7020746F6E6E6163
	dq 0x5255412065737261
	dq 0x6567616B63617020
	dq 0x7461646174656D20
	dq 0x0000000000000061

str_LC40:
	db 0x68, 0x74, 0x74, 0x70, 0x73, 0x3A, 0x2F, 0x2F
	db 0x61, 0x75, 0x72, 0x2E, 0x61, 0x72, 0x63, 0x68
	db 0x6C, 0x69, 0x6E, 0x75, 0x78, 0x2E, 0x6F, 0x72
	db 0x67, 0x2F, 0x72, 0x70, 0x63, 0x2F, 0x76, 0x35
	db 0x00

SECTION .rodata align=16 noexec

hex.0:
	db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
	db 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	db 0x00

