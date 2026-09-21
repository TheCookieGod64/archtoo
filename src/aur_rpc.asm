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
	sub     rsp, 24
	mov     rbx, qword [rdi]
	cmp     byte [rbx], 34
	jne     loc_012
	mov     qword [rsp], rdi
	mov     rdi, rbx
	call    strlen
	lea     rdi, [rax+0x1]
	call    malloc
	mov     r15, rax
	test    rax, rax
	je      loc_012
	lea     rbp, [rbx+0x1]
	movzx   ebx, byte [rbx+0x1]
	mov     rdx, qword [rsp]
	test    bl, bl
	je      loc_013
	cmp     bl, 34
	je      loc_013
	xor     r12d, r12d
	lea     rsi, [rel loc_140]
	jmp     loc_007

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_004:  add     rbp, 1
loc_005:  mov     byte [r13], bl
	mov     r12, r14
loc_006:  movzx   ebx, byte [rbp]
	test    bl, bl
	je      loc_009
	cmp     bl, 34
	je      loc_009
loc_007:  lea     r13, [r15+r12]
	lea     r14, [r12+0x1]
	cmp     bl, 92
	jnz     loc_004
	movzx   ebx, byte [rbp+0x1]
	lea     rcx, [rbp+0x2]
	lea     eax, [rbx-0x62]
	cmp     al, 19
	ja      loc_008
	movzx   eax, al
	movsxd  rax, dword [rsi+rax*4]
	add     rax, rsi
	jmp     rax

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
; Note: No jump seems to point here
	mov     rdi, rcx
	mov     qword [rsp+0x8], rdx
	mov     qword [rsp], rcx
	call    strlen
	mov     rcx, qword [rsp]
	mov     rdx, qword [rsp+0x8]
	lea     rsi, [rel loc_140]
	cmp     rax, 3
	ja      loc_014
; Filling space: 0x0D
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x90

ALIGN   16
loc_008:  mov     rbp, rcx
	jmp     loc_005

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
; Note: No jump seems to point here
	mov     rbp, rcx
	mov     ebx, 9
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
; Note: No jump seems to point here
	mov     rbp, rcx
	mov     ebx, 13
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
; Note: No jump seems to point here
	mov     rbp, rcx
	mov     ebx, 12
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
; Note: No jump seems to point here
	mov     rbp, rcx
	mov     ebx, 8
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_009:  add     r12, r15
loc_010:  xor     eax, eax
	cmp     bl, 34
	mov     byte [r12], 0
	sete    al
	add     rbp, rax
	mov     qword [rdx], rbp
loc_011:  add     rsp, 24
	mov     rax, r15
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_012:  xor     r15d, r15d
	jmp     loc_011

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
; Note: No jump seems to point here
	mov     rbp, rcx
	mov     ebx, 10
	jmp     loc_005

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_013:  mov     r12, r15
	jmp     loc_010

loc_014:
	mov     eax, 30044
	add     rbp, 6
	mov     word [r13], ax
	mov     eax, dword [rbp-0x4]
	mov     dword [r15+r12+0x2], eax
	add     r12, 6
	jmp     loc_006

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8

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
loc_015:  mov     rdi, rbx
	mov     rsi, r12
	call    strstr
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_018
	test    rax, rax
	jz      loc_018
	mov     rdi, r12
	call    strlen
	add     rbx, rax
	cmp     rbx, rbp
	jnc     loc_015
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_017

; Filling space: 0x1E
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_016:  add     rbx, 1
	cmp     rbp, rbx
	jz      loc_015
loc_017:  movzx   eax, byte [rbx]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_016
	cmp     rbx, rbp
	jnc     loc_015
	cmp     byte [rbx], 58
	jnz     loc_015
	add     rsp, 96
	lea     rax, [rbx+0x1]
	pop     rbx
	pop     rbp
	pop     r12
	ret

loc_018:
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
	je      loc_026
	mov     r12, rax
	cmp     rax, r13
	jnc     loc_033
	call    __ctype_b_loc
	mov     rcx, qword [rax]
	jmp     loc_020

; Filling space: 0x18
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x90

ALIGN   16
loc_019:  lea     rax, [r12+0x1]
	cmp     rax, r13
	je      loc_031
	mov     r12, rax
loc_020:  movzx   edx, byte [r12]
	mov     rax, rdx
	test    byte [rcx+rdx*2+0x1], 0x20
	jnz     loc_019
loc_021:  cmp     al, 91
	jnz     loc_026
loc_022:  add     r12, 1
	mov     qword [rsp+0x8], r12
	cmp     r12, r13
	jnc     loc_030
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_023:  call    __ctype_b_loc
	mov     rdi, qword [rax]
	xor     eax, eax
	jmp     loc_025

; Filling space: 0x14
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_024:  mov     r14, r12
loc_025:  movzx   edx, byte [r12]
	mov     esi, eax
	movzx   eax, dl
	movzx   eax, byte [rdi+rax*2+0x1]
	shr     al, 5
	and     eax, 0x01
	cmp     dl, 44
	sete    cl
	or      al, cl
	jz      loc_028
	add     r12, 1
	cmp     r12, r13
	jnz     loc_024
loc_026:  mov     eax, 1
loc_027:  add     rsp, 16
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
loc_028:  test    sil, sil
	jz      loc_029
	mov     qword [rsp+0x8], r14
loc_029:  cmp     dl, 93
	jz      loc_026
	cmp     dl, 34
	jnz     loc_030
	lea     rdi, [rsp+0x8]
	call    parse_json_string
	mov     rdi, qword [rbp]
	mov     r12, rax
	mov     rax, qword [rbx]
	lea     rsi, [rax*8+0x8]
	call    realloc
	test    r12, r12
	jz      loc_032
	test    rax, rax
	jz      loc_032
	mov     rdx, qword [rbx]
	mov     qword [rbp], rax
	lea     rcx, [rdx+0x1]
	mov     qword [rbx], rcx
	mov     qword [rax+rdx*8], r12
	mov     r12, qword [rsp+0x8]
	cmp     r12, r13
	jc      loc_023
loc_030:  xor     eax, eax
	jmp     loc_027

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_031:  movzx   eax, byte [r12+0x1]
	mov     r12, r13
	cmp     al, 91
	jne     loc_026
	jmp     loc_022

loc_032:  mov     rdi, r12
	call    free
	xor     eax, eax
	jmp     loc_027

loc_033:
	movzx   eax, byte [rax]
	jmp     loc_021

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
	jz      loc_038
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_037
	call    __ctype_b_loc
	xor     edx, edx
	mov     rcx, qword [rax]
	jmp     loc_035

; Filling space: 0x12
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x80, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_034:  add     rbx, 1
	mov     edx, 1
	cmp     rbx, rbp
	jz      loc_040
	mov     r12, rbx
loc_035:  movzx   eax, byte [rbx]
	test    byte [rcx+rax*2+0x1], 0x20
	jnz     loc_034
	test    dl, dl
	jz      loc_036
	mov     qword [rsp+0x8], r12
loc_036:  sub     rbp, rbx
	cmp     rbp, 3
	jle     loc_037
	mov     edx, 4
	lea     rsi, [rel str_LC3]
	mov     rdi, rbx
	call    strncmp
	test    eax, eax
	jz      loc_038
loc_037:  cmp     byte [rbx], 34
	jz      loc_039
loc_038:  add     rsp, 16
	lea     rdi, [rel str_LC2]
	pop     rbx
	pop     rbp
	pop     r12
	jmp     strdup

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_039:  lea     rdi, [rsp+0x8]
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
loc_040:  cmp     byte [rbx], 34
	mov     qword [rsp+0x8], rbx
	jz      loc_039
	jmp     loc_038

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
	jz      loc_044
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_043
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_042

; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_041:  add     rbx, 1
	cmp     rbp, rbx
	jz      loc_043
loc_042:  movzx   eax, byte [rbx]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_041
loc_043:  add     rsp, 8
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
loc_044:  add     rsp, 8
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
	jz      loc_048
	push    r13
	push    r12
	push    rbp
	mov     rbp, rsi
	push    rbx
	sub     rsp, 8
	test    rsi, rsi
	jz      loc_046
	mov     rbx, rdi
	mov     r12, rdx
	test    rdx, rdx
	jz      loc_047
	mov     rdi, rdx
	call    strlen
	mov     r13, rax
loc_045:  lea     rax, [rbp-0x1]
	cmp     r13, rbp
	mov     rsi, r12
	mov     rdi, rbx
	cmovnc  r13, rax
	mov     rdx, r13
	call    memcpy
	mov     byte [rbx+r13], 0
loc_046:  add     rsp, 8
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
loc_047:  mov     r13d, 13
	lea     r12, [rel str_LC4]
	jmp     loc_045

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_048:  ret

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
	jne     loc_057
	call    fork
	mov     dword [rsp+0x0C], eax
	test    eax, eax
	js      loc_056
	je      loc_053
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
loc_049:  mov     edi, dword [rsp+0x28]
	mov     edx, 8192
	mov     rsi, r12
	call    read
	mov     r14, rax
	test    rax, rax
	jle     loc_060
	lea     r13, [r14+rbp]
	lea     rax, [r13+0x1]
	cmp     r15, rax
	jnc     loc_055
	test    r15, r15
	jnz     loc_050
	mov     r15d, 8192
	cmp     rax, 8192
	jbe     loc_051
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_050:  add     r15, r15
	cmp     r15, rax
	jc      loc_050
loc_051:  mov     rdi, qword [rbx]
	mov     rsi, r15
	call    realloc
	test    rax, rax
	je      loc_065
	mov     qword [rbx], rax
loc_052:  lea     rdi, [rax+rbp]
	mov     rdx, r14
	mov     rsi, r12
	mov     rbp, r13
	call    memcpy
	mov     rax, qword [rbx]
	mov     byte [rax+r13], 0
	jmp     loc_049

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_053:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	mov     esi, 1
	call    dup2
	test    eax, eax
	js      loc_054
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
loc_054:  mov     edi, 127
	call    _exit
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_055:  mov     rax, qword [rbx]
	jmp     loc_052

loc_056:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	call    close
loc_057:  call    __errno_location
	mov     edi, dword [rax]
	call    strerror
	mov     rsi, qword [rsp+0x18]
	mov     rdi, qword [rsp+0x10]
	mov     rdx, rax
	call    set_error
loc_058:  xor     eax, eax
loc_059:  add     rsp, 8248
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_060:  mov     edi, dword [rsp+0x28]
	lea     rbp, [rsp+0x24]
	call    close
	jmp     loc_062

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_061:  call    __errno_location
	cmp     dword [rax], 4
	jnz     loc_063
loc_062:  mov     edi, dword [rsp+0x0C]
	xor     edx, edx
	mov     rsi, rbp
	call    waitpid
	test    eax, eax
	js      loc_061
loc_063:  mov     rdi, qword [rbx]
; Note: Length-changing prefix causes delay on old Intel processors
	test    word [rsp+0x24], 0x0FF7F
	jne     loc_069
	test    rdi, rdi
	je      loc_071
loc_064:  xor     eax, eax
	test    rdi, rdi
	setne   al
	jmp     loc_059

loc_065:  mov     edi, dword [rsp+0x28]
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
	je      loc_058
	cmp     qword [rsp+0x18], 0
	je      loc_058
	mov     rcx, qword [rsp+0x18]
	mov     eax, 14
	lea     rdx, [rel str_LC14]
	cmp     rcx, rax
	cmova   rcx, rax
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_067
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC14]
	test    al, 0x04
	jne     loc_075
	test    eax, eax
	jz      loc_066
	movzx   esi, byte [rel str_LC14]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], sil
	test    al, 0x02
	jne     loc_070
loc_066:  mov     rax, qword [rsp+0x10]
	mov     byte [rax+rcx-0x1], 0
	jmp     loc_058

loc_067:  mov     rbx, qword [rsp+0x10]
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
	jc      loc_066
	and     eax, 0x0FFFFFFF8
	xor     edi, edi
loc_068:  mov     r8d, edi
	add     edi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rsi+r8], r9
	cmp     edi, eax
	jc      loc_068
	jmp     loc_066

loc_069:  call    free
	cmp     qword [rsp+0x10], 0
	mov     qword [rbx], 0
	je      loc_058
	mov     rax, qword [rsp+0x18]
	test    rax, rax
	je      loc_058
	mov     ecx, 28
	lea     rdx, [rel str_LC15]
	cmp     rax, rcx
	cmovbe  rcx, rax
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_072
	test    al, 0x04
	jne     loc_074
	test    eax, eax
	je      loc_066
	movzx   esi, byte [rel str_LC15]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], sil
	test    al, 0x02
	je      loc_066
loc_070:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	movzx   edx, word [rdx+rax-0x2]
	mov     word [rbx+rax-0x2], dx
	jmp     loc_066

loc_071:  lea     rdi, [rel str_LC2]
	call    strdup
	mov     qword [rbx], rax
	mov     rdi, rax
	jmp     loc_064

loc_072:  mov     rbx, qword [rsp+0x10]
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
	jc      loc_066
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_073:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_073
	jmp     loc_066

loc_074:
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC15]
loc_075:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbx], esi
	mov     dword [rbx+rax-0x4], edx
	jmp     loc_066

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
	je      loc_116
	mov     r15, rax
	mov     rcx, rax
	test    r14, r14
	je      loc_080
	call    __ctype_b_loc
	mov     rdx, r13
	lea     r9, [r13+r14]
	xor     ecx, ecx
	mov     r10, qword [rax]
	lea     r11, [rel hex.0]
	jmp     loc_077

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_076:  lea     esi, [rsi-0x2D]
	cmp     sil, 1
	jbe     loc_078
	cmp     al, 95
	jz      loc_078
	cmp     al, 126
	jz      loc_078
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
	jz      loc_079
; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16
loc_077:  movzx   esi, byte [rdx]
	lea     r13, [rcx+0x1]
	lea     rdi, [r15+rcx]
	mov     rax, rsi
	test    byte [r10+rsi*2], 0x08
; Note: Immediate operand could be made smaller by sign extension
	je      loc_076
loc_078:  add     rdx, 1
	mov     byte [rdi], al
	mov     rcx, r13
	cmp     r9, rdx
	jnz     loc_077
loc_079:  add     rcx, r15
loc_080:  mov     byte [rcx], 0
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
	je      loc_136
	mov     rdi, qword [rsp]
	lea     rsi, [rel str_LC17]
	call    strcmp
	mov     rcx, qword [rsp+0x10]
	mov     r8, r15
	test    eax, eax
	je      loc_087
	mov     rdi, qword [rsp+0x8]
	lea     rdx, [rel str_LC19]
	mov     rsi, r13
	xor     eax, eax
	call    snprintf
loc_081:  mov     rdi, r15
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
	je      loc_107
	lea     rsi, [rel str_LC20]
	call    strstr
	mov     rdi, rax
	test    rax, rax
	je      loc_120
	mov     esi, 91
	call    strchr
	test    rax, rax
	je      loc_120
	lea     r15, [rax+0x1]
	movzx   eax, byte [rax+0x1]
	test    al, al
	je      loc_113
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_082:  mov     r13, r15
	cmp     al, 123
	jnz     loc_084
	jmp     loc_089

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_083:  movzx   eax, byte [r13+0x1]
	add     r13, 1
	test    al, al
	je      loc_115
	cmp     al, 123
	jz      loc_088
loc_084:  cmp     al, 93
	jnz     loc_083
loc_085:  mov     rdi, qword [rsp+0x8]
	call    free
	mov     rdi, qword [rsp+0x18]
	call    free
loc_086:  mov     eax, dword [rsp+0x10]
	add     rsp, 216
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_087:  mov     rdi, qword [rsp+0x8]
	lea     rdx, [rel str_LC18]
	mov     rsi, r13
	call    snprintf
	jmp     loc_081

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_088:  test    al, al
	je      loc_115
loc_089:  mov     r15, r13
	xor     esi, esi
	mov     eax, 123
	jmp     loc_093

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_090:  cmp     al, 125
	jz      loc_094
loc_091:  mov     r15, rdx
loc_092:  movzx   eax, byte [r15]
	test    al, al
	je      loc_105
loc_093:  lea     rdx, [r15+0x1]
	cmp     al, 34
	je      loc_102
	cmp     al, 123
	jnz     loc_090
	add     esi, 1
	jmp     loc_091

loc_094:  sub     esi, 1
	jnz     loc_091
	mov     r15, rdx
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_095:  lea     r14, [rsp+0x30]
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
	je      loc_111
	cmp     rax, r15
	jnc     loc_098
	mov     qword [rsp], rax
	call    __ctype_b_loc
	mov     rdi, qword [rsp]
	mov     rdx, qword [rax]
	jmp     loc_097

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_096:  add     rdi, 1
	cmp     r15, rdi
	jz      loc_098
loc_097:  movzx   eax, byte [rdi]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_096
loc_098:  xor     esi, esi
	call    strtod
loc_099:  lea     rdx, [rel str_LC31]
	mov     rsi, r15
	mov     rdi, r13
	movsd   qword [rsp+0x68], xmm0
	call    object_long
	cmp     qword [rsp+0x30], 0
	mov     qword [rsp+0x70], rax
; Note: Immediate operand could be made smaller by sign extension
	je      loc_100
	cmp     qword [rsp+0x38], 0
	jz      loc_100
	cmp     qword [rsp+0x40], 0
	jz      loc_100
	cmp     qword [rsp+0x48], 0
	jz      loc_100
	cmp     qword [rsp+0x50], 0
	jz      loc_100
	cmp     qword [rsp+0x58], 0
	jz      loc_100
	lea     rcx, [rsp+0x78]
	lea     rdx, [rel str_LC32]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x80]
	call    object_array
	test    eax, eax
	jz      loc_100
	lea     rcx, [rsp+0x88]
	lea     rdx, [rel str_LC33]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x90]
	call    object_array
	test    eax, eax
	jne     loc_112
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_100:  mov     rdi, r14
	call    package_destroy
	test    rbp, rbp
	je      loc_107
	test    r12, r12
	je      loc_107
	mov     ecx, 34
	lea     rdx, [rel str_LC37]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jc      loc_128
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
	jc      loc_106
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_101:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_101
	jmp     loc_106

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_102:  movzx   eax, byte [r15+0x1]
	test    al, al
	je      loc_119
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_103:  lea     rcx, [rdx+0x1]
	mov     r15, rcx
	cmp     al, 92
	je      loc_110
	movzx   edx, byte [rdx+0x1]
	cmp     al, 34
	je      loc_092
	mov     eax, edx
loc_104:  mov     rdx, rcx
	test    al, al
	jnz     loc_103
	mov     r15, rcx
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_105:  test    esi, esi
	je      loc_095
	test    rbp, rbp
	jz      loc_107
	test    r12, r12
	jz      loc_107
	mov     ecx, 25
	lea     rdx, [rel str_LC22]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_129
	test    al, 0x04
	jne     loc_133
	test    eax, eax
	jz      loc_106
	movzx   esi, byte [rel str_LC22]
	mov     byte [rbp], sil
	test    al, 0x02
	jne     loc_121
loc_106:  mov     byte [rbp+rcx-0x1], 0
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_107:  xor     ebp, ebp
	cmp     qword [rbx+0x8], 0
	jz      loc_109
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_108:  lea     rax, [rbp+rbp*8]
	lea     rdx, [rbp+rax*2]
	mov     rax, qword [rbx]
	add     rbp, 1
	lea     rdi, [rax+rdx*8]
	call    package_destroy
	cmp     rbp, qword [rbx+0x8]
	jc      loc_108
loc_109:  mov     rdi, qword [rbx]
	call    free
	mov     qword [rbx], 0
	mov     qword [rbx+0x8], 0
	mov     dword [rsp+0x10], 0
	jmp     loc_085

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_110:  cmp     byte [rdx+0x1], 0
	je      loc_105
	movzx   eax, byte [rdx+0x2]
	lea     rcx, [rdx+0x2]
	jmp     loc_104

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_111:  pxor    xmm0, xmm0
	jmp     loc_099

loc_112:  lea     rcx, [rsp+0x98]
	lea     rdx, [rel str_LC34]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0A0]
	call    object_array
	test    eax, eax
	je      loc_100
	lea     rcx, [rsp+0x0A8]
	lea     rdx, [rel str_LC35]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0B0]
	call    object_array
	test    eax, eax
	je      loc_100
	lea     rcx, [rsp+0x0B8]
	lea     rdx, [rel str_LC36]
	mov     rsi, r15
	mov     rdi, r13
	lea     r8, [rsp+0x0C0]
	call    object_array
	test    eax, eax
	je      loc_100
	mov     rax, qword [rbx+0x8]
	mov     rdi, qword [rbx]
	add     rax, 1
	lea     rdx, [rax+rax*8]
	lea     rsi, [rax+rdx*2]
	shl     rsi, 3
	call    realloc
	mov     rdx, rax
	test    rax, rax
	je      loc_100
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
	jne     loc_082
loc_113:  test    rbp, rbp
	je      loc_107
	test    r12, r12
	je      loc_107
	mov     ecx, 26
	lea     rdx, [rel str_LC38]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jc      loc_127
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
	jc      loc_106
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_114:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_114
	jmp     loc_106

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_115:  mov     r15, r13
	jmp     loc_095

loc_116:  pxor    xmm0, xmm0
	movups  oword [rbx], xmm0
	test    rbp, rbp
	jz      loc_118
	test    r12, r12
	jz      loc_118
	mov     edx, 14
	lea     rcx, [rel str_LC14]
	cmp     r12, rdx
	cmovbe  rdx, r12
	lea     rax, [rdx-0x1]
	cmp     eax, 8
	jnc     loc_122
	test    al, 0x04
	jne     loc_134
	test    eax, eax
	jne     loc_126
loc_117:  mov     byte [rbp+rdx-0x1], 0
loc_118:  mov     dword [rsp+0x10], 0
	jmp     loc_086

loc_119:  mov     r15, rdx
	jmp     loc_105

loc_120:  test    rbp, rbp
	je      loc_107
	test    r12, r12
	je      loc_107
	mov     ecx, 25
	lea     rdx, [rel str_LC21]
	cmp     r12, rcx
	cmovbe  rcx, r12
	lea     rax, [rcx-0x1]
	cmp     eax, 8
	jnc     loc_124
	test    al, 0x04
	jne     loc_131
	test    eax, eax
	je      loc_106
	movzx   esi, byte [rel str_LC21]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_106
loc_121:  mov     eax, eax
	movzx   edx, word [rdx+rax-0x2]
	mov     word [rbp+rax-0x2], dx
	jmp     loc_106

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_122:
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
	jc      loc_117
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_123:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rcx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_123
	jmp     loc_117

loc_124:
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
	jc      loc_106
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_125:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_125
	jmp     loc_106

loc_126:  movzx   esi, byte [rel str_LC14]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_117
	mov     eax, eax
	movzx   ecx, word [rcx+rax-0x2]
	mov     word [rbp+rax-0x2], cx
	jmp     loc_117

loc_127:  test    al, 0x04
	jne     loc_135
	test    eax, eax
	je      loc_106
	movzx   esi, byte [rel str_LC38]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_106
	jmp     loc_121

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_128:  test    al, 0x04
	jne     loc_132
	test    eax, eax
	je      loc_106
	movzx   esi, byte [rel str_LC37]
	mov     byte [rbp], sil
	test    al, 0x02
	je      loc_106
	jmp     loc_121

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_129:  mov     rsi, qword [rel str_LC22]
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
	jc      loc_106
	and     eax, 0x0FFFFFFF8
	xor     esi, esi
loc_130:  mov     r8d, esi
	add     esi, 8
	mov     r9, qword [rdx+r8]
	mov     qword [rdi+r8], r9
	cmp     esi, eax
	jc      loc_130
	jmp     loc_106

loc_131:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC21]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_106

loc_132:  mov     eax, eax
	mov     esi, dword [rel str_LC37]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_106

loc_133:  mov     eax, eax
	mov     esi, dword [rel str_LC22]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_106

loc_134:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC14]
	mov     ecx, dword [rcx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], ecx
	jmp     loc_117

loc_135:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC38]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], esi
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_106

loc_136:
	mov     rdi, r15
	call    free
	lea     rdx, [rel str_LC14]
	mov     rsi, r12
	mov     rdi, rbp
	call    set_error
	jmp     loc_118

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

aur_response_destroy:; Function begin
	test    rdi, rdi
	jz      loc_139
	push    rbp
	mov     rbp, rdi
	push    rbx
	sub     rsp, 8
	cmp     qword [rdi+0x8], 0
	jz      loc_138
	xor     ebx, ebx
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_137:  lea     rax, [rbx+rbx*8]
	lea     rdx, [rbx+rax*2]
	mov     rax, qword [rbp]
	add     rbx, 1
	lea     rdi, [rax+rdx*8]
	call    package_destroy
	cmp     rbx, qword [rbp+0x8]
	jc      loc_137
loc_138:  mov     rdi, qword [rbp]
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
loc_139:  ret

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

SECTION .rodata align=16 noexec

loc_140:
	dd package_destroy-$+0x280
	dd loc_008-$+0x4
	dd loc_008-$+0x8
	dd loc_008-$+0x0C
	dd package_destroy-$+0x270
	dd loc_008-$+0x14
	dd loc_008-$+0x18
	dd loc_008-$+0x1C
	dd loc_008-$+0x20
	dd loc_008-$+0x24
	dd loc_008-$+0x28
	dd loc_008-$+0x2C
	dd package_destroy-$+0x2C8
	dd loc_008-$+0x34
	dd loc_008-$+0x38
	dd loc_008-$+0x3C
	dd package_destroy-$+0x260
	dd loc_008-$+0x44
	dd package_destroy-$+0x250
	dd package_destroy-$+0x208

hex.0:
	db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
	db 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	db 0x00

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

