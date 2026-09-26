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
extern __isoc23_strtol
extern strdup
extern strncmp
extern realloc
extern __ctype_b_loc
extern strstr
extern snprintf
extern malloc
extern strlen
extern __stack_chk_fail
extern free

SECTION .text   align=64 exec

package_destroy:
	push    r15
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 104
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r12, qword [fs:abs 0x28]
	mov     qword [rsp+0x58], r12
	mov     r12, rdi
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
; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

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
	pxor    xmm0, xmm0
	xor     eax, eax
	movups  oword [r12+0x58], xmm0
	movups  oword [r12+0x68], xmm0
	movups  oword [r12+0x78], xmm0
	movups  oword [r12+0x88], xmm0
loc_004:  mov     edx, eax
	add     eax, 64
	movups  oword [r12+rdx], xmm0
	movups  oword [r12+rdx+0x10], xmm0
	movups  oword [r12+rdx+0x20], xmm0
	movups  oword [r12+rdx+0x30], xmm0
	cmp     eax, 128
	jc      loc_004
	mov     rax, qword [rsp+0x58]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_005
	add     rsp, 104
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_005:
	call    __stack_chk_fail
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
parse_json_string:
	mov     rdx, qword [rdi]
	xor     r10d, r10d
	cmp     byte [rdx], 34
	jne     loc_016
	push    r14
	mov     r14, rdi
	mov     rdi, rdx
	push    rbx
	sub     rsp, 72
	mov     qword [rsp+0x8], rdx
	call    strlen
	lea     rbx, [rax+0x1]
	mov     rdi, rbx
	call    malloc
	mov     r10, rax
	test    rax, rax
	je      loc_013
	mov     rdx, qword [rsp+0x8]
	lea     rsi, [rdx+0x1]
	movzx   edx, byte [rdx+0x1]
	test    dl, dl
	je      loc_021
	cmp     dl, 34
	je      loc_021
	xor     ecx, ecx
	jmp     loc_008

loc_006:  mov     byte [r8], dl
	mov     rcx, r9
	mov     rsi, rdi
loc_007:  movzx   edx, byte [rsi]
	test    dl, dl
	je      loc_019
	cmp     dl, 34
	je      loc_019
loc_008:  lea     rax, [rcx+0x8]
	lea     r8, [r10+rcx]
	cmp     rax, rbx
	jnc     loc_010
	lea     rdi, [rsi+0x1]
	lea     r9, [rcx+0x1]
	cmp     dl, 92
	jnz     loc_006
	movzx   edx, byte [rsi+0x1]
	test    dl, dl
	je      loc_020
	lea     rdi, [rsi+0x2]
	cmp     dl, 114
	je      loc_018
	jg      loc_009
	cmp     dl, 102
	je      loc_017
	cmp     dl, 110
	je      loc_014
	cmp     dl, 98
	mov     eax, 8
	cmove   edx, eax
	jmp     loc_006

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_009:  cmp     dl, 116
	je      loc_015
	cmp     dl, 117
	jne     loc_006
	mov     qword [rsp+0x28], r10
	mov     qword [rsp+0x20], r9
	mov     qword [rsp+0x18], r8
	mov     byte [rsp+0x17], dl
	mov     qword [rsp+0x8], rdi
	mov     qword [rsp+0x30], rsi
	mov     qword [rsp+0x38], rcx
	call    strlen
	mov     rdi, qword [rsp+0x8]
	movzx   edx, byte [rsp+0x17]
	cmp     rax, 3
	mov     r8, qword [rsp+0x18]
	mov     r9, qword [rsp+0x20]
	mov     r10, qword [rsp+0x28]
	mov     rsi, qword [rsp+0x30]
	mov     rcx, qword [rsp+0x38]
	jbe     loc_006
	mov     eax, 30044
	add     rsi, 6
	mov     word [r8], ax
	mov     eax, dword [rsi-0x4]
	mov     dword [r10+rcx+0x2], eax
	add     rcx, 6
	jmp     loc_007

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_010:  movzx   edx, byte [rsi]
loc_011:  xor     eax, eax
	cmp     dl, 34
	sete    al
	add     rsi, rax
loc_012:  mov     byte [r8], 0
	mov     qword [r14], rsi
loc_013:  add     rsp, 72
	mov     rax, r10
	pop     rbx
	pop     r14
	ret

loc_014:  mov     edx, 10
	jmp     loc_006

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_015:  mov     edx, 9
	jmp     loc_006

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_016:  mov     rax, r10
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_017:  mov     edx, 12
	jmp     loc_006

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_018:  mov     edx, 13
	jmp     loc_006

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_019:  lea     r8, [r10+rcx]
	jmp     loc_011

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_020:  mov     byte [r8], 92
	mov     rsi, rdi
	lea     r8, [r10+r9]
	jmp     loc_012

loc_021:
	mov     r8, r10
	jmp     loc_011

; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

find_key:
	push    rbp
	mov     rcx, rdx
	mov     rbp, rsi
	lea     rdx, [rel str_LC1]
	push    rbx
	mov     esi, 96
	mov     rbx, rdi
	sub     rsp, 120
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x68], rax
	xor     eax, eax
	mov     rdi, rsp
	call    snprintf
; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_022:  mov     rdi, rbx
	mov     rsi, rsp
	call    strstr
	mov     rbx, rax
	test    rax, rax
	jz      loc_025
	cmp     rax, rbp
	jnc     loc_026
	mov     rdi, rsp
	call    strlen
	add     rbx, rax
	cmp     rbx, rbp
	jnc     loc_022
	call    __ctype_b_loc
	mov     rdx, qword [rax]
	jmp     loc_024

; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_023:  add     rbx, 1
	cmp     rbp, rbx
	jz      loc_022
loc_024:  movzx   eax, byte [rbx]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_023
	cmp     rbx, rbp
	jnc     loc_022
	cmp     byte [rbx], 58
	jnz     loc_022
	add     rbx, 1
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_025:  mov     rax, qword [rsp+0x68]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_027
	add     rsp, 120
	mov     rax, rbx
	pop     rbx
	pop     rbp
	ret

loc_026:  xor     ebx, ebx
	jmp     loc_025

loc_027:
	call    __stack_chk_fail
; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
object_array:
	sub     rsp, 56
	mov     qword [rsp+0x18], rbp
	mov     rbp, rcx
	mov     qword [rsp+0x28], r13
	mov     r13, rsi
	mov     qword [rsp+0x10], rbx
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbx, qword [fs:abs 0x28]
	mov     qword [rsp+0x8], rbx
	mov     rbx, r8
	call    find_key
	mov     qword [rbp], 0
	mov     qword [rbx], 0
	test    rax, rax
	je      loc_035
	mov     qword [rsp+0x20], r12
	mov     r12, rax
	cmp     rax, r13
	jnc     loc_044
	call    __ctype_b_loc
	mov     rcx, qword [rax]
	jmp     loc_029

; Filling space: 0x1E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_028:  add     r12, 1
	cmp     r12, r13
	je      loc_041
loc_029:  movzx   edx, byte [r12]
	mov     rax, rdx
	test    byte [rcx+rdx*2+0x1], 0x20
	jnz     loc_028
loc_030:  cmp     al, 91
	jne     loc_042
	add     r12, 1
	mov     qword [rsp], r12
	cmp     r12, r13
	jnc     loc_040
	mov     qword [rsp+0x30], r14
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_031:  call    __ctype_b_loc
	mov     rdi, qword [rax]
	xor     eax, eax
	jmp     loc_033

; Filling space: 0x14
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_032:  mov     r14, r12
loc_033:  movzx   edx, byte [r12]
	mov     esi, eax
	movzx   eax, dl
	movzx   eax, byte [rdi+rax*2+0x1]
	shr     al, 5
	and     eax, 0x01
	cmp     dl, 44
	sete    cl
	or      al, cl
	jz      loc_037
	add     r12, 1
	cmp     r12, r13
	jnz     loc_032
loc_034:  mov     r12, qword [rsp+0x20]
	mov     r14, qword [rsp+0x30]
loc_035:  mov     eax, 1
loc_036:  mov     rdx, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jne     loc_045
	mov     rbx, qword [rsp+0x10]
	mov     rbp, qword [rsp+0x18]
	mov     r13, qword [rsp+0x28]
	add     rsp, 56
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_037:  test    sil, sil
	jz      loc_038
	mov     qword [rsp], r14
loc_038:  cmp     dl, 93
	jz      loc_034
	cmp     dl, 34
	jnz     loc_039
	mov     rdi, rsp
	call    parse_json_string
	mov     rdi, qword [rbp]
	mov     r12, rax
	mov     rax, qword [rbx]
	lea     rsi, [rax*8+0x8]
	call    realloc
	test    r12, r12
	jz      loc_043
	test    rax, rax
	jz      loc_043
	mov     rdx, qword [rbx]
	mov     qword [rbp], rax
	lea     rcx, [rdx+0x1]
	mov     qword [rbx], rcx
	mov     qword [rax+rdx*8], r12
	mov     r12, qword [rsp]
	cmp     r12, r13
	jc      loc_031
loc_039:  mov     r14, qword [rsp+0x30]
loc_040:  mov     r12, qword [rsp+0x20]
	xor     eax, eax
	jmp     loc_036

loc_041:  xor     eax, eax
	cmp     byte [r12], 91
	mov     r12, qword [rsp+0x20]
	setne   al
	jmp     loc_036

loc_042:  mov     r12, qword [rsp+0x20]
	jmp     loc_035

loc_043:  mov     rdi, r12
	call    free
	mov     r14, qword [rsp+0x30]
	jmp     loc_040

loc_044:  movzx   eax, byte [rax]
	jmp     loc_030

loc_045:
	mov     qword [rsp+0x20], r12
	mov     qword [rsp+0x30], r14
	call    __stack_chk_fail
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
object_string:
	sub     rsp, 40
	mov     qword [rsp+0x18], rbp
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbp, qword [fs:abs 0x28]
	mov     qword [rsp+0x8], rbp
	mov     rbp, rsi
	call    find_key
	mov     qword [rsp], rax
	test    rax, rax
	je      loc_054
	mov     qword [rsp+0x10], rbx
	mov     rbx, rax
	cmp     rax, rbp
	jnc     loc_056
	mov     qword [rsp+0x20], r12
	call    __ctype_b_loc
	xor     edx, edx
	mov     rcx, qword [rax]
	jmp     loc_047

; Filling space: 0x12
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x66
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_046:  add     rbx, 1
	mov     edx, 1
	cmp     rbx, rbp
	jz      loc_052
	mov     r12, rbx
loc_047:  movzx   eax, byte [rbx]
	test    byte [rcx+rax*2+0x1], 0x20
	jnz     loc_046
	test    dl, dl
	jz      loc_048
	mov     qword [rsp], r12
loc_048:  sub     rbp, rbx
	cmp     rbp, 3
	jle     loc_049
	mov     edx, 4
	lea     rsi, [rel str_LC3]
	mov     rdi, rbx
	call    strncmp
	test    eax, eax
	je      loc_055
loc_049:  mov     r12, qword [rsp+0x20]
	mov     rbp, rbx
loc_050:  cmp     byte [rbp], 34
	jz      loc_053
loc_051:  mov     rax, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_057
	mov     rbx, qword [rsp+0x10]
	mov     rbp, qword [rsp+0x18]
	lea     rdi, [rel str_LC2]
	add     rsp, 40
	jmp     strdup

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_052:  mov     qword [rsp], rbp
	mov     r12, qword [rsp+0x20]
	cmp     byte [rbp], 34
	jnz     loc_051
loc_053:  mov     rdi, rsp
	call    parse_json_string
	mov     rdx, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jnz     loc_057
	mov     rbx, qword [rsp+0x10]
	mov     rbp, qword [rsp+0x18]
	add     rsp, 40
	ret

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_054:  mov     rax, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_059
	mov     rbp, qword [rsp+0x18]
	lea     rdi, [rel str_LC2]
	add     rsp, 40
	jmp     strdup

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_055:  mov     rax, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_058
	mov     rbx, qword [rsp+0x10]
	mov     r12, qword [rsp+0x20]
	lea     rdi, [rel str_LC2]
	mov     rbp, qword [rsp+0x18]
	add     rsp, 40
	jmp     strdup

loc_056:  mov     rbp, rax
	jmp     loc_050

loc_057:  mov     qword [rsp+0x20], r12
loc_058:  call    __stack_chk_fail
loc_059:  mov     qword [rsp+0x10], rbx
	mov     qword [rsp+0x20], r12
	call    __stack_chk_fail
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
object_long:
	push    rbx
	mov     rbx, rsi
	sub     rsp, 16
	call    find_key
	test    rax, rax
	jz      loc_063
	mov     rdi, rax
	cmp     rax, rbx
	jnc     loc_062
	mov     qword [rsp+0x8], rax
	call    __ctype_b_loc
	mov     rdi, qword [rsp+0x8]
	mov     rdx, qword [rax]
	jmp     loc_061

; Filling space: 0x12
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x66
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_060:  add     rdi, 1
	cmp     rbx, rdi
	jz      loc_062
loc_061:  movzx   eax, byte [rdi]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_060
loc_062:  add     rsp, 16
	mov     edx, 10
	xor     esi, esi
	pop     rbx
	jmp     __isoc23_strtol

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_063:  add     rsp, 16
	xor     eax, eax
	pop     rbx
	ret

set_error:
	test    rdi, rdi
	jz      loc_065
	mov     rax, rsi
	test    rsi, rsi
	jz      loc_065
	push    rbp
	mov     rsi, rdx
	mov     rbp, rdi
	mov     rdx, rax
	push    rbx
	sub     rsp, 24
	test    rsi, rsi
	jz      loc_066
	mov     rdi, rsi
	mov     qword [rsp], rsi
	mov     qword [rsp+0x8], rax
	call    strlen
	mov     rsi, qword [rsp]
	mov     rdx, qword [rsp+0x8]
	mov     rbx, rax
loc_064:  cmp     rbx, rdx
	lea     rax, [rdx-0x1]
	mov     rdi, rbp
	cmovnc  rbx, rax
	mov     rdx, rbx
	call    memcpy
	mov     byte [rbp+rbx], 0
	add     rsp, 24
	pop     rbx
	pop     rbp
	ret

loc_065:  ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_066:  mov     ebx, 13
	lea     rsi, [rel str_LC4]
	jmp     loc_064

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16

curl_get.constprop.0:
	sub     rsp, 8312
	mov     qword [rsp+0x2048], rbx
	mov     rbx, rsi
	mov     qword [rsp+0x2050], rbp
	mov     rbp, rdi
	lea     rdi, [rsp+0x28]
	mov     qword [rsp+0x2058], r12
	mov     qword [rsp+0x10], rdx
	mov     qword [rsp+0x18], rcx
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x2038], rax
	xor     eax, eax
	mov     qword [rsi], 0
	call    pipe
	test    eax, eax
	jne     loc_074
	mov     r12d, eax
	call    fork
	mov     dword [rsp+0x0C], eax
	test    eax, eax
	js      loc_081
	mov     qword [rsp+0x2060], r13
	mov     qword [rsp+0x2068], r14
	mov     qword [rsp+0x2070], r15
	je      loc_071
	mov     edi, dword [rsp+0x2C]
	xor     r15d, r15d
	xor     ebp, ebp
	call    close
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_067:  mov     edi, dword [rsp+0x28]
	mov     edx, 8192
	lea     rsi, [rsp+0x30]
	call    read
	mov     r14, rax
	test    rax, rax
	jle     loc_076
	lea     r13, [r14+rbp]
	lea     rax, [r13+0x1]
	cmp     r15, rax
	jnc     loc_073
	test    r15, r15
	jnz     loc_068
	mov     r15d, 8192
	cmp     rax, 8192
	jbe     loc_069
; Filling space: 0x0D
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_068:  add     r15, r15
	cmp     r15, rax
	jc      loc_068
loc_069:  mov     rdi, qword [rbx]
	mov     rsi, r15
	call    realloc
	test    rax, rax
	je      loc_082
	mov     qword [rbx], rax
loc_070:  lea     rdi, [rax+rbp]
	mov     rdx, r14
	lea     rsi, [rsp+0x30]
	mov     rbp, r13
	call    memcpy
	mov     rax, qword [rbx]
	mov     byte [rax+r13], 0
	jmp     loc_067

loc_071:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	mov     esi, 1
	call    dup2
	test    eax, eax
	js      loc_072
	mov     edi, dword [rsp+0x2C]
	call    close
	lea     rax, [rel str_LC10]
	push    0
	lea     rsi, [rel str_LC9]
	push    rbp
	lea     r9, [rel str_LC5]
	lea     r8, [rel str_LC6]
	mov     rdi, rsi
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
loc_072:  mov     edi, 127
	call    _exit
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_073:  mov     rax, qword [rbx]
	jmp     loc_070

loc_074:  call    __errno_location
	xor     r12d, r12d
	mov     edi, dword [rax]
	call    strerror
	mov     rsi, qword [rsp+0x18]
	mov     rdi, qword [rsp+0x10]
	mov     rdx, rax
	call    set_error
loc_075:  mov     rax, qword [rsp+0x2038]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_102
	mov     eax, r12d
	mov     rbx, qword [rsp+0x2048]
	mov     rbp, qword [rsp+0x2050]
	mov     r12, qword [rsp+0x2058]
	add     rsp, 8312
	ret

loc_076:  mov     edi, dword [rsp+0x28]
	call    close
	jmp     loc_078

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_077:  call    __errno_location
	cmp     dword [rax], 4
	jnz     loc_079
loc_078:  mov     edi, dword [rsp+0x0C]
	xor     edx, edx
	lea     rsi, [rsp+0x24]
	call    waitpid
	test    eax, eax
	js      loc_077
loc_079:  mov     rdi, qword [rbx]
; Note: Length-changing prefix causes delay on old Intel processors
	test    word [rsp+0x24], 0x0FF7F
	jne     loc_084
	test    rdi, rdi
	je      loc_092
loc_080:  xor     r12d, r12d
	test    rdi, rdi
	mov     r13, qword [rsp+0x2060]
	mov     r14, qword [rsp+0x2068]
	mov     r15, qword [rsp+0x2070]
	setne   r12b
	jmp     loc_075

loc_081:  mov     edi, dword [rsp+0x28]
	call    close
	mov     edi, dword [rsp+0x2C]
	call    close
	call    __errno_location
	mov     edi, dword [rax]
	call    strerror
	mov     rsi, qword [rsp+0x18]
	mov     rdi, qword [rsp+0x10]
	mov     rdx, rax
	call    set_error
	jmp     loc_075

loc_082:  mov     edi, dword [rsp+0x28]
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
	mov     qword [rbx], 0
	cmp     qword [rsp+0x10], 0
	je      loc_085
	mov     rcx, qword [rsp+0x18]
	test    rcx, rcx
	je      loc_085
	mov     eax, 14
	lea     rsi, [rel str_LC14]
	cmp     rcx, rax
	cmova   rcx, rax
	lea     rax, [rcx-0x1]
	cmp     eax, 64
	jnc     loc_088
	test    al, 0x20
	jne     loc_094
	test    al, 0x10
	jne     loc_093
	test    al, 0x08
	jne     loc_096
	test    al, 0x04
	jne     loc_095
	test    eax, eax
	jz      loc_083
	movzx   edx, byte [rel str_LC14]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], dl
	test    al, 0x02
	jne     loc_099
loc_083:  mov     rax, qword [rsp+0x10]
	mov     byte [rax+rcx-0x1], 0
	mov     r13, qword [rsp+0x2060]
	mov     r14, qword [rsp+0x2068]
	mov     r15, qword [rsp+0x2070]
	jmp     loc_075

loc_084:  call    free
	mov     qword [rbx], 0
	cmp     qword [rsp+0x10], 0
	jz      loc_085
	mov     rcx, qword [rsp+0x18]
	test    rcx, rcx
	jnz     loc_086
loc_085:  mov     r13, qword [rsp+0x2060]
	mov     r14, qword [rsp+0x2068]
	mov     r15, qword [rsp+0x2070]
	jmp     loc_075

loc_086:  mov     eax, 28
	mov     rdx, rcx
	cmp     rcx, rax
	lea     rcx, [rel str_LC15]
	cmova   rdx, rax
	lea     rax, [rdx-0x1]
	cmp     eax, 64
	jnc     loc_090
	test    al, 0x20
	jne     loc_101
	test    al, 0x10
	jne     loc_100
	test    al, 0x08
	jne     loc_098
	test    al, 0x04
	jne     loc_097
	test    eax, eax
	jz      loc_087
	movzx   esi, byte [rel str_LC15]
	mov     rbx, qword [rsp+0x10]
	mov     byte [rbx], sil
	test    al, 0x02
	jne     loc_103
loc_087:  mov     rax, qword [rsp+0x10]
	mov     byte [rax+rdx-0x1], 0
	mov     r13, qword [rsp+0x2060]
	mov     r14, qword [rsp+0x2068]
	mov     r15, qword [rsp+0x2070]
	jmp     loc_075

loc_088:  mov     rbx, qword [rsp+0x10]
	mov     edx, eax
	sub     eax, 1
	lea     rdi, [rbx+rdx]
	add     rdx, rsi
	movdqu  xmm0, oword [rdx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rdx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rdx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rdx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_083
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_089:  mov     edx, edi
	mov     rbx, qword [rsp+0x10]
	add     edi, 64
	movdqu  xmm3, oword [rsi+rdx]
	movdqu  xmm2, oword [rsi+rdx+0x10]
	movdqu  xmm1, oword [rsi+rdx+0x20]
	movdqu  xmm0, oword [rsi+rdx+0x30]
	movups  oword [rbx+rdx], xmm3
	movups  oword [rbx+rdx+0x10], xmm2
	movups  oword [rbx+rdx+0x20], xmm1
	movups  oword [rbx+rdx+0x30], xmm0
	cmp     edi, eax
	jc      loc_089
	jmp     loc_083

loc_090:  mov     rbx, qword [rsp+0x10]
	mov     esi, eax
	sub     eax, 1
	lea     rdi, [rbx+rsi]
	add     rsi, rcx
	movdqu  xmm0, oword [rsi-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rsi-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rsi-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rsi-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_087
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_091:  mov     esi, edi
	mov     rbx, qword [rsp+0x10]
	add     edi, 64
	movdqu  xmm3, oword [rcx+rsi]
	movdqu  xmm2, oword [rcx+rsi+0x10]
	movdqu  xmm1, oword [rcx+rsi+0x20]
	movdqu  xmm0, oword [rcx+rsi+0x30]
	movups  oword [rbx+rsi], xmm3
	movups  oword [rbx+rsi+0x10], xmm2
	movups  oword [rbx+rsi+0x20], xmm1
	movups  oword [rbx+rsi+0x30], xmm0
	cmp     edi, eax
	jc      loc_091
	jmp     loc_087

loc_092:  lea     rdi, [rel str_LC2]
	call    strdup
	mov     qword [rbx], rax
	mov     rdi, rax
	jmp     loc_080

loc_093:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14]
	mov     rdx, qword [rsp+0x10]
	mov     eax, eax
	movups  oword [rdx], xmm0
	movdqu  xmm0, oword [rsi+rax-0x10]
	movups  oword [rdx+rax-0x10], xmm0
	jmp     loc_083

loc_094:  mov     rdx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14]
	mov     eax, eax
	movups  oword [rdx], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14+0x10]
	movups  oword [rdx+0x10], xmm0
	lea     rdx, [rdx+rax+0x20]
	lea     rax, [rsi+rax+0x20]
	movdqu  xmm0, oword [rax-0x40]
	movups  oword [rdx-0x40], xmm0
	movdqu  xmm0, oword [rax-0x30]
	movups  oword [rdx-0x30], xmm0
	jmp     loc_083

loc_095:
; Note: Memory operand is misaligned. Performance penalty
	mov     edx, dword [rel str_LC14]
	mov     rbx, qword [rsp+0x10]
	mov     eax, eax
	mov     dword [rbx], edx
	mov     edx, dword [rsi+rax-0x4]
	mov     dword [rbx+rax-0x4], edx
	jmp     loc_083

loc_096:
; Note: Memory operand is misaligned. Performance penalty
	mov     rdx, qword [rel str_LC14]
	mov     rbx, qword [rsp+0x10]
	mov     eax, eax
	mov     qword [rbx], rdx
	mov     rdx, qword [rsi+rax-0x8]
	mov     qword [rbx+rax-0x8], rdx
	jmp     loc_083

loc_097:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	mov     esi, dword [rel str_LC15]
	mov     ecx, dword [rcx+rax-0x4]
	mov     dword [rbx], esi
	mov     dword [rbx+rax-0x4], ecx
	jmp     loc_087

loc_098:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	mov     rsi, qword [rel str_LC15]
	mov     rcx, qword [rcx+rax-0x8]
	mov     qword [rbx], rsi
	mov     qword [rbx+rax-0x8], rcx
	jmp     loc_087

loc_099:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	movzx   edx, word [rsi+rax-0x2]
	mov     word [rbx+rax-0x2], dx
	jmp     loc_083

loc_100:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC15]
	mov     rbx, qword [rsp+0x10]
	mov     eax, eax
	movups  oword [rbx], xmm0
	movdqu  xmm0, oword [rcx+rax-0x10]
	movups  oword [rbx+rax-0x10], xmm0
	jmp     loc_087

loc_101:  mov     rbx, qword [rsp+0x10]
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC15]
	mov     eax, eax
	movups  oword [rbx], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC15+0x10]
	lea     rsi, [rbx+rax+0x20]
	lea     rax, [rcx+rax+0x20]
	movups  oword [rbx+0x10], xmm0
	movdqu  xmm0, oword [rax-0x40]
	movups  oword [rsi-0x40], xmm0
	movdqu  xmm0, oword [rax-0x30]
	movups  oword [rsi-0x30], xmm0
	jmp     loc_087

loc_102:  mov     qword [rsp+0x2060], r13
	mov     qword [rsp+0x2068], r14
	mov     qword [rsp+0x2070], r15
	call    __stack_chk_fail
loc_103:  mov     eax, eax
	mov     rbx, qword [rsp+0x10]
	movzx   ecx, word [rcx+rax-0x2]
	mov     word [rbx+rax-0x2], cx
	jmp     loc_087

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8

request:
	sub     rsp, 264
	mov     qword [rsp+0x0D8], rbx
	mov     rbx, rcx
	mov     qword [rsp+0x0E0], rbp
	mov     rbp, r8
	mov     qword [rsp+0x0F0], r13
	mov     r13, rdx
	mov     qword [rsp+0x0F8], r14
	mov     qword [rsp+0x0E8], r12
	mov     qword [rsp+0x10], rdi
	mov     rdi, rdx
	mov     qword [rsp+0x8], rsi
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     r12, qword [fs:abs 0x28]
	mov     qword [rsp+0x0C8], r12
	mov     r12, r9
	call    strlen
	lea     rdi, [rax+rax*2+0x1]
	mov     r14, rax
	call    malloc
	test    rax, rax
	je      loc_142
	mov     qword [rsp+0x100], r15
	mov     rcx, rax
	mov     r15, rax
	test    r14, r14
	je      loc_108
	call    __ctype_b_loc
	mov     rdx, r13
	lea     r9, [r13+r14]
	xor     ecx, ecx
	mov     r10, qword [rax]
	lea     r11, [rel hex.0]
	jmp     loc_105

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_104:  lea     esi, [rsi-0x2D]
	cmp     sil, 1
; Note: Immediate operand could be made smaller by sign extension
	jbe     loc_106
	cmp     al, 95
	jz      loc_106
	cmp     al, 126
	jz      loc_106
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
	jz      loc_107
; Filling space: 0x28
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00, 0x66
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2E
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_105:  movzx   esi, byte [rdx]
	lea     r13, [rcx+0x1]
	lea     rdi, [r15+rcx]
	mov     rax, rsi
	test    byte [r10+rsi*2], 0x08
	je      loc_104
loc_106:  add     rdx, 1
	mov     byte [rdi], al
	mov     rcx, r13
	cmp     r9, rdx
	jnz     loc_105
loc_107:  add     rcx, r15
loc_108:  mov     byte [rcx], 0
	pxor    xmm0, xmm0
	mov     rdi, qword [rsp+0x10]
	movups  oword [rbx], xmm0
	mov     qword [rsp+0x28], 0
	call    strlen
	mov     rdi, qword [rsp+0x8]
	mov     r14, rax
	call    strlen
	mov     rdi, r15
	lea     r13, [rax+r14+0x20]
	call    strlen
	add     r13, rax
	mov     rdi, r13
	call    malloc
	mov     r14, rax
	test    rax, rax
	je      loc_175
	mov     rdi, qword [rsp+0x8]
	lea     rsi, [rel str_LC17]
	call    strcmp
	mov     rcx, qword [rsp+0x10]
	mov     r8, r15
	test    eax, eax
	je      loc_115
	lea     rdx, [rel str_LC19]
	mov     rsi, r13
	mov     rdi, r14
	xor     eax, eax
	call    snprintf
loc_109:  mov     rdi, r15
	call    free
	mov     rdi, r14
	lea     rsi, [rsp+0x28]
	mov     rcx, r12
	mov     rdx, rbp
	call    curl_get.constprop.0
	mov     rdi, qword [rsp+0x28]
	mov     dword [rsp+0x10], eax
	mov     qword [rsp+0x18], rdi
	test    eax, eax
	je      loc_134
	lea     rsi, [rel str_LC20]
	call    strstr
	test    rax, rax
	je      loc_146
	mov     esi, 91
	mov     rdi, rax
	call    strchr
	mov     r13, rax
	test    rax, rax
	je      loc_146
	movzx   eax, byte [rax+0x1]
	add     r13, 1
	test    al, al
	je      loc_140
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_110:  mov     r15, r13
	cmp     al, 123
	jnz     loc_112
	jmp     loc_117

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_111:  movzx   eax, byte [r15+0x1]
	add     r15, 1
	test    al, al
	je      loc_141
	cmp     al, 123
	je      loc_116
loc_112:  cmp     al, 93
	jnz     loc_111
loc_113:  mov     rdi, r14
	call    free
	mov     rdi, qword [rsp+0x18]
	call    free
	mov     r15, qword [rsp+0x100]
loc_114:  mov     rax, qword [rsp+0x0C8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_176
	mov     eax, dword [rsp+0x10]
	mov     rbx, qword [rsp+0x0D8]
	mov     rbp, qword [rsp+0x0E0]
	mov     r12, qword [rsp+0x0E8]
	mov     r13, qword [rsp+0x0F0]
	mov     r14, qword [rsp+0x0F8]
	add     rsp, 264
	ret

loc_115:  lea     rdx, [rel str_LC18]
	mov     rsi, r13
	mov     rdi, r14
	call    snprintf
	jmp     loc_109

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_116:  test    al, al
	je      loc_141
loc_117:  mov     r13, r15
	xor     esi, esi
	mov     eax, 123
	jmp     loc_120

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_118:  mov     r13, rdx
	cmp     al, 125
	jz      loc_121
loc_119:  movzx   eax, byte [r13]
	test    al, al
	je      loc_132
loc_120:  lea     rdx, [r13+0x1]
	cmp     al, 34
	je      loc_129
	cmp     al, 123
	jnz     loc_118
	add     esi, 1
	mov     r13, rdx
	jmp     loc_119

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_121:  sub     esi, 1
	jnz     loc_119
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_122:  pxor    xmm0, xmm0
	xor     eax, eax
loc_123:  mov     edx, eax
	add     eax, 64
	movaps  oword [rsp+rdx+0x30], xmm0
	movaps  oword [rsp+rdx+0x40], xmm0
	movaps  oword [rsp+rdx+0x50], xmm0
	movaps  oword [rsp+rdx+0x60], xmm0
	cmp     eax, 128
	jc      loc_123
	lea     rdx, [rel str_LC23]
	mov     rsi, r13
	mov     rdi, r15
	movaps  oword [rsp+rax+0x30], xmm0
	mov     qword [rsp+rax+0x40], 0
	call    object_string
	lea     rdx, [rel str_LC24]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x30], rax
	call    object_string
	lea     rdx, [rel str_LC25]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x38], rax
	call    object_string
	lea     rdx, [rel str_LC26]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x40], rax
	call    object_string
	lea     rdx, [rel str_LC27]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x48], rax
	call    object_string
	lea     rdx, [rel str_LC28]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x50], rax
	call    object_string
	lea     rdx, [rel str_LC29]
	mov     rsi, r13
	mov     rdi, r15
	mov     qword [rsp+0x58], rax
	call    object_long
	mov     rdi, r15
	lea     rdx, [rel str_LC30]
	mov     rsi, r13
	mov     qword [rsp+0x60], rax
	call    find_key
	mov     rdi, rax
	test    rax, rax
	je      loc_138
	cmp     rax, r13
	jnc     loc_126
	mov     qword [rsp+0x8], rax
	call    __ctype_b_loc
	mov     rdi, qword [rsp+0x8]
	mov     rdx, qword [rax]
	jmp     loc_125

; Filling space: 0x14
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00
;       db 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_124:  add     rdi, 1
	cmp     r13, rdi
	jz      loc_126
loc_125:  movzx   eax, byte [rdi]
	test    byte [rdx+rax*2+0x1], 0x20
	jnz     loc_124
loc_126:  xor     esi, esi
	call    strtod
loc_127:  lea     rdx, [rel str_LC31]
	mov     rsi, r13
	mov     rdi, r15
	movsd   qword [rsp+0x68], xmm0
	call    object_long
	mov     qword [rsp+0x70], rax
	cmp     qword [rsp+0x30], 0
; Note: Immediate operand could be made smaller by sign extension
	je      loc_128
	cmp     qword [rsp+0x38], 0
	jz      loc_128
	cmp     qword [rsp+0x40], 0
	jz      loc_128
	cmp     qword [rsp+0x48], 0
	jz      loc_128
	cmp     qword [rsp+0x50], 0
	jz      loc_128
	cmp     qword [rsp+0x58], 0
	jz      loc_128
	lea     rcx, [rsp+0x78]
	lea     rdx, [rel str_LC32]
	mov     rsi, r13
	mov     rdi, r15
	lea     r8, [rsp+0x80]
	call    object_array
	test    eax, eax
	jz      loc_128
	lea     rcx, [rsp+0x88]
	lea     rdx, [rel str_LC33]
	mov     rsi, r13
	mov     rdi, r15
	lea     r8, [rsp+0x90]
	call    object_array
	test    eax, eax
	jne     loc_139
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_128:  lea     rdi, [rsp+0x30]
	call    package_destroy
	test    rbp, rbp
	je      loc_134
	test    r12, r12
	je      loc_134
	mov     esi, 34
	lea     rdx, [rel str_LC37]
	cmp     r12, rsi
	cmovbe  rsi, r12
	lea     rax, [rsi-0x1]
	cmp     eax, 64
	jnc     loc_154
	test    al, 0x20
	jne     loc_168
	test    al, 0x10
	jne     loc_167
	test    al, 0x08
	jne     loc_181
	test    al, 0x04
	jne     loc_180
	test    eax, eax
	je      loc_133
	movzx   ecx, byte [rel str_LC37]
	mov     byte [rbp], cl
	test    al, 0x02
	je      loc_133
	jmp     loc_147

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_129:  movzx   eax, byte [r13+0x1]
	test    al, al
	je      loc_145
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_130:  lea     rcx, [rdx+0x1]
	movzx   edi, byte [rdx+0x1]
	mov     r13, rcx
	cmp     al, 92
	je      loc_137
	cmp     al, 34
	je      loc_119
	mov     eax, edi
loc_131:  mov     rdx, rcx
	test    al, al
	jnz     loc_130
	mov     r13, rcx
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_132:  test    esi, esi
	je      loc_122
	test    rbp, rbp
	jz      loc_134
	test    r12, r12
	jz      loc_134
	mov     esi, 25
	lea     rdx, [rel str_LC22]
	cmp     r12, rsi
	cmovbe  rsi, r12
	lea     rax, [rsi-0x1]
	cmp     eax, 64
	jnc     loc_157
	test    al, 0x20
	jne     loc_159
	test    al, 0x10
	jne     loc_166
	test    al, 0x08
	jne     loc_179
	test    al, 0x04
	jne     loc_178
	test    eax, eax
	jz      loc_133
	movzx   ecx, byte [rel str_LC22]
	mov     byte [rbp], cl
	test    al, 0x02
	jne     loc_147
loc_133:  mov     byte [rbp+rsi-0x1], 0
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_134:  cmp     qword [rbx+0x8], 0
	jz      loc_136
	xor     ebp, ebp
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_135:  imul    rdi, rbp, 152
	add     rdi, qword [rbx]
	add     rbp, 1
	call    package_destroy
	cmp     rbp, qword [rbx+0x8]
	jc      loc_135
loc_136:  mov     rdi, qword [rbx]
	call    free
	mov     qword [rbx], 0
	mov     qword [rbx+0x8], 0
	mov     dword [rsp+0x10], 0
	jmp     loc_113

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_137:  test    dil, dil
	je      loc_132
	movzx   eax, byte [rdx+0x2]
	lea     rcx, [rdx+0x2]
	jmp     loc_131

loc_138:  pxor    xmm0, xmm0
	jmp     loc_127

loc_139:  lea     rcx, [rsp+0x98]
	lea     rdx, [rel str_LC34]
	mov     rsi, r13
	mov     rdi, r15
	lea     r8, [rsp+0x0A0]
	call    object_array
	test    eax, eax
	je      loc_128
	lea     rcx, [rsp+0x0A8]
	lea     rdx, [rel str_LC35]
	mov     rsi, r13
	mov     rdi, r15
	lea     r8, [rsp+0x0B0]
	call    object_array
	test    eax, eax
	je      loc_128
	lea     rcx, [rsp+0x0B8]
	lea     rdx, [rel str_LC36]
	mov     rsi, r13
	mov     rdi, r15
	lea     r8, [rsp+0x0C0]
	call    object_array
	test    eax, eax
	je      loc_128
	mov     rax, qword [rbx+0x8]
	mov     rdi, qword [rbx]
	lea     rsi, [rax+0x1]
	imul    rsi, rsi, 152
	call    realloc
	test    rax, rax
	je      loc_128
	mov     rdx, qword [rbx+0x8]
	movdqa  xmm0, oword [rsp+0x30]
	mov     qword [rbx], rax
	lea     rcx, [rdx+0x1]
	imul    rdx, rdx, 152
	mov     qword [rbx+0x8], rcx
	add     rax, rdx
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
	movzx   eax, byte [r13]
	test    al, al
	jne     loc_110
loc_140:  test    rbp, rbp
	je      loc_134
	test    r12, r12
	je      loc_134
	mov     esi, 26
	lea     rdx, [rel str_LC38]
	cmp     r12, rsi
	cmovbe  rsi, r12
	lea     rax, [rsi-0x1]
	cmp     eax, 64
	jnc     loc_152
	test    al, 0x20
	jne     loc_173
	test    al, 0x10
	jne     loc_172
	test    al, 0x08
	jne     loc_171
	test    al, 0x04
	jne     loc_174
	test    eax, eax
	je      loc_133
	movzx   ecx, byte [rel str_LC38]
	mov     byte [rbp], cl
	test    al, 0x02
	je      loc_133
	jmp     loc_147

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_141:  mov     r13, r15
	jmp     loc_122

loc_142:  pxor    xmm0, xmm0
	movups  oword [rbx], xmm0
	test    rbp, rbp
	jz      loc_144
	test    r12, r12
	jz      loc_144
	mov     edx, 14
	lea     rsi, [rel str_LC14]
	cmp     r12, rdx
	cmovbe  rdx, r12
	lea     rax, [rdx-0x1]
	cmp     eax, 64
	jnc     loc_148
	test    al, 0x20
	jne     loc_161
	test    al, 0x10
	jne     loc_156
	test    al, 0x08
	jne     loc_170
	test    al, 0x04
	jne     loc_169
	test    eax, eax
	jz      loc_143
	movzx   ecx, byte [rel str_LC14]
	mov     byte [rbp], cl
	test    al, 0x02
	jz      loc_143
	mov     eax, eax
	movzx   ecx, word [rsi+rax-0x2]
	mov     word [rbp+rax-0x2], cx
loc_143:  mov     byte [rbp+rdx-0x1], 0
loc_144:  mov     dword [rsp+0x10], 0
	jmp     loc_114

loc_145:  mov     r13, rdx
	jmp     loc_132

loc_146:  test    rbp, rbp
	je      loc_134
	test    r12, r12
	je      loc_134
	mov     esi, 25
	lea     rdx, [rel str_LC21]
	cmp     r12, rsi
	cmovbe  rsi, r12
	lea     rax, [rsi-0x1]
	cmp     eax, 64
	jnc     loc_150
	test    al, 0x20
	jne     loc_163
	test    al, 0x10
	jne     loc_162
	test    al, 0x08
	jne     loc_165
	test    al, 0x04
	jne     loc_164
	test    eax, eax
	je      loc_133
	movzx   ecx, byte [rel str_LC21]
	mov     byte [rbp], cl
	test    al, 0x02
	je      loc_133
loc_147:  mov     eax, eax
	movzx   edx, word [rdx+rax-0x2]
	mov     word [rbp+rax-0x2], dx
	jmp     loc_133

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_148:  mov     ecx, eax
	sub     eax, 1
	lea     rdi, [rbp+rcx]
	add     rcx, rsi
	movdqu  xmm0, oword [rcx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rcx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rcx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rcx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_143
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_149:  mov     ecx, edi
	add     edi, 64
	movdqu  xmm3, oword [rsi+rcx]
	movdqu  xmm2, oword [rsi+rcx+0x10]
	movdqu  xmm1, oword [rsi+rcx+0x20]
	movdqu  xmm0, oword [rsi+rcx+0x30]
	movups  oword [rbp+rcx], xmm3
	movups  oword [rbp+rcx+0x10], xmm2
	movups  oword [rbp+rcx+0x20], xmm1
	movups  oword [rbp+rcx+0x30], xmm0
	cmp     edi, eax
	jc      loc_149
	jmp     loc_143

loc_150:  mov     ecx, eax
	sub     eax, 1
	lea     rdi, [rbp+rcx]
	add     rcx, rdx
	movdqu  xmm0, oword [rcx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rcx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rcx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rcx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_133
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_151:  mov     ecx, edi
	add     edi, 64
	movdqu  xmm3, oword [rdx+rcx]
	movdqu  xmm2, oword [rdx+rcx+0x10]
	movdqu  xmm1, oword [rdx+rcx+0x20]
	movdqu  xmm0, oword [rdx+rcx+0x30]
	movups  oword [rbp+rcx], xmm3
	movups  oword [rbp+rcx+0x10], xmm2
	movups  oword [rbp+rcx+0x20], xmm1
	movups  oword [rbp+rcx+0x30], xmm0
	cmp     edi, eax
	jc      loc_151
	jmp     loc_133

loc_152:  mov     ecx, eax
	sub     eax, 1
	lea     rdi, [rbp+rcx]
	add     rcx, rdx
	movdqu  xmm0, oword [rcx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rcx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rcx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rcx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_133
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_153:  mov     ecx, edi
	add     edi, 64
	movdqu  xmm3, oword [rdx+rcx]
	movdqu  xmm2, oword [rdx+rcx+0x10]
	movdqu  xmm1, oword [rdx+rcx+0x20]
	movdqu  xmm0, oword [rdx+rcx+0x30]
	movups  oword [rbp+rcx], xmm3
	movups  oword [rbp+rcx+0x10], xmm2
	movups  oword [rbp+rcx+0x20], xmm1
	movups  oword [rbp+rcx+0x30], xmm0
	cmp     edi, eax
	jc      loc_153
	jmp     loc_133

loc_154:  mov     ecx, eax
	sub     eax, 1
	lea     rdi, [rbp+rcx]
	add     rcx, rdx
	movdqu  xmm0, oword [rcx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rcx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rcx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rcx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_133
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_155:  mov     ecx, edi
	add     edi, 64
	movdqu  xmm3, oword [rdx+rcx]
	movdqu  xmm2, oword [rdx+rcx+0x10]
	movdqu  xmm1, oword [rdx+rcx+0x20]
	movdqu  xmm0, oword [rdx+rcx+0x30]
	movups  oword [rbp+rcx], xmm3
	movups  oword [rbp+rcx+0x10], xmm2
	movups  oword [rbp+rcx+0x20], xmm1
	movups  oword [rbp+rcx+0x30], xmm0
	cmp     edi, eax
	jc      loc_155
	jmp     loc_133

loc_156:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14]
	mov     eax, eax
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rsi+rax-0x10]
	movups  oword [rbp+rax-0x10], xmm0
	jmp     loc_143

loc_157:  mov     ecx, eax
	sub     eax, 1
	lea     rdi, [rbp+rcx]
	add     rcx, rdx
	movdqu  xmm0, oword [rcx-0x40]
	movups  oword [rdi-0x40], xmm0
	movdqu  xmm0, oword [rcx-0x30]
	movups  oword [rdi-0x30], xmm0
	movdqu  xmm0, oword [rcx-0x20]
	movups  oword [rdi-0x20], xmm0
	movdqu  xmm0, oword [rcx-0x10]
	movups  oword [rdi-0x10], xmm0
	cmp     eax, 64
	jc      loc_133
	and     eax, 0x0FFFFFFC0
	xor     edi, edi
loc_158:  mov     ecx, edi
	add     edi, 64
	movdqu  xmm3, oword [rdx+rcx]
	movdqu  xmm2, oword [rdx+rcx+0x10]
	movdqu  xmm1, oword [rdx+rcx+0x20]
	movdqu  xmm0, oword [rdx+rcx+0x30]
	movups  oword [rbp+rcx], xmm3
	movups  oword [rbp+rcx+0x10], xmm2
	movups  oword [rbp+rcx+0x20], xmm1
	movups  oword [rbp+rcx+0x30], xmm0
	cmp     edi, eax
	jc      loc_158
	jmp     loc_133

loc_159:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC22]
	movups  oword [rbp], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC22+0x10]
loc_160:  mov     eax, eax
	movups  oword [rbp+0x10], xmm0
	lea     rcx, [rbp+rax+0x20]
	lea     rax, [rdx+rax+0x20]
	movdqu  xmm0, oword [rax-0x40]
	movups  oword [rcx-0x40], xmm0
	movdqu  xmm0, oword [rax-0x30]
	movups  oword [rcx-0x30], xmm0
	jmp     loc_133

loc_161:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14]
	mov     eax, eax
	lea     rcx, [rbp+rax+0x20]
	lea     rax, [rsi+rax+0x20]
	movups  oword [rbp], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC14+0x10]
	movups  oword [rbp+0x10], xmm0
	movdqu  xmm0, oword [rax-0x40]
	movups  oword [rcx-0x40], xmm0
	movdqu  xmm0, oword [rax-0x30]
	movups  oword [rcx-0x30], xmm0
	jmp     loc_143

loc_162:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC21]
	mov     eax, eax
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rdx+rax-0x10]
	movups  oword [rbp+rax-0x10], xmm0
	jmp     loc_133

loc_163:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC21]
	movups  oword [rbp], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC21+0x10]
	jmp     loc_160

loc_164:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [rel str_LC21]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], ecx
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_133

loc_165:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     rcx, qword [rel str_LC21]
	mov     rdx, qword [rdx+rax-0x8]
	mov     qword [rbp], rcx
	mov     qword [rbp+rax-0x8], rdx
	jmp     loc_133

loc_166:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC22]
	mov     eax, eax
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rdx+rax-0x10]
	movups  oword [rbp+rax-0x10], xmm0
	jmp     loc_133

loc_167:  movdqu  xmm0, oword [rel str_LC37]
	mov     eax, eax
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rdx+rax-0x10]
	movups  oword [rbp+rax-0x10], xmm0
	jmp     loc_133

loc_168:  movdqu  xmm0, oword [rel str_LC37]
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rel str_LC37+0x10]
	jmp     loc_160

loc_169:
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [rel str_LC14]
	mov     eax, eax
	mov     dword [rbp], ecx
	mov     ecx, dword [rsi+rax-0x4]
	mov     dword [rbp+rax-0x4], ecx
	jmp     loc_143

loc_170:
; Note: Memory operand is misaligned. Performance penalty
	mov     rcx, qword [rel str_LC14]
	mov     eax, eax
	mov     qword [rbp], rcx
	mov     rcx, qword [rsi+rax-0x8]
	mov     qword [rbp+rax-0x8], rcx
	jmp     loc_143

loc_171:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     rcx, qword [rel str_LC38]
	mov     rdx, qword [rdx+rax-0x8]
	mov     qword [rbp], rcx
	mov     qword [rbp+rax-0x8], rdx
	jmp     loc_133

loc_172:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC38]
	mov     eax, eax
	movups  oword [rbp], xmm0
	movdqu  xmm0, oword [rdx+rax-0x10]
	movups  oword [rbp+rax-0x10], xmm0
	jmp     loc_133

loc_173:
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC38]
	movups  oword [rbp], xmm0
; Note: Memory operand is misaligned. Performance penalty
	movdqu  xmm0, oword [rel str_LC38+0x10]
	jmp     loc_160

loc_174:  mov     eax, eax
; Note: Memory operand is misaligned. Performance penalty
	mov     ecx, dword [rel str_LC38]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], ecx
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_133

loc_175:  mov     rdi, r15
	call    free
	test    rbp, rbp
	jz      loc_177
	test    r12, r12
	jz      loc_177
	mov     eax, 14
	lea     rsi, [rel str_LC14]
	mov     rdi, rbp
	cmp     r12, rax
	cmovbe  rax, r12
	lea     ecx, [rax-0x1]
	rep movsb
	mov     byte [rbp+rax-0x1], 0
	mov     r15, qword [rsp+0x100]
	jmp     loc_144

loc_176:  mov     qword [rsp+0x100], r15
	call    __stack_chk_fail
loc_177:  mov     r15, qword [rsp+0x100]
	jmp     loc_144

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_178:  mov     eax, eax
	mov     ecx, dword [rel str_LC22]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], ecx
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_133

loc_179:  mov     eax, eax
	mov     rcx, qword [rel str_LC22]
	mov     rdx, qword [rdx+rax-0x8]
	mov     qword [rbp], rcx
	mov     qword [rbp+rax-0x8], rdx
	jmp     loc_133

loc_180:  mov     eax, eax
	mov     ecx, dword [rel str_LC37]
	mov     edx, dword [rdx+rax-0x4]
	mov     dword [rbp], ecx
	mov     dword [rbp+rax-0x4], edx
	jmp     loc_133

loc_181:
	mov     eax, eax
	mov     rcx, qword [rel str_LC37]
	mov     rdx, qword [rdx+rax-0x8]
	mov     qword [rbp], rcx
	mov     qword [rbp+rax-0x8], rdx
	jmp     loc_133

aur_response_destroy:; Function begin
	test    rdi, rdi
	jz      loc_184
	sub     rsp, 24
	mov     qword [rsp+0x10], rbp
	mov     rbp, rdi
	cmp     qword [rdi+0x8], 0
	jz      loc_183
	mov     qword [rsp+0x8], rbx
	xor     ebx, ebx
	nop
loc_182:  imul    rdi, rbx, 152
	add     rdi, qword [rbp]
	add     rbx, 1
	call    package_destroy
	cmp     rbx, qword [rbp+0x8]
	jc      loc_182
	mov     rbx, qword [rsp+0x8]
loc_183:  mov     rdi, qword [rbp]
	call    free
	mov     qword [rbp], 0
	mov     qword [rbp+0x8], 0
	mov     rbp, qword [rsp+0x10]
	add     rsp, 24
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_184:  ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8

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

str_LC14:
	dq 0x6D20666F2074756F
	db 0x65, 0x6D, 0x6F, 0x72, 0x79, 0x00

str_LC15:
	dq 0x2043505220525541
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

str_LC21:
	dq 0x2064696C61766E69
	dq 0x2043505220525541
	dq 0x65736E6F70736572
	db 0x00

str_LC22:
	dq 0x657461636E757274
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

str_LC38:
	dq 0x657461636E757274
	dq 0x5052205255412064
	dq 0x746C757365722043
	db 0x73, 0x00

str_LC41:
	db 0x69, 0x6E, 0x66, 0x6F, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC37:
	dq 0x7020746F6E6E6163
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

