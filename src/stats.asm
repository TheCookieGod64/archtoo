; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  stats.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 stats.asm -o stats.o
; ---------------------------------------------------------

default rel

global cmd_stats_v2: function

extern fwrite
extern stderr
extern printf
extern fclose
extern fgets
extern fopen
extern __stack_chk_fail
extern strlen
extern free
extern strchr
extern run_cmd_capture

SECTION .text   align=16 exec

count_cmd_lines:
	sub     rsp, 56
	mov     qword [rsp+0x28], r12
	mov     rsi, rsp
	mov     qword [rsp+0x20], rbp
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x8], rax
	xor     eax, eax
	mov     qword [rsp], 0
	call    run_cmd_capture
	mov     r12, qword [rsp]
	cmp     eax, 1
	ja      loc_013
	test    r12, r12
	je      loc_012
	cmp     byte [r12], 0
	je      loc_012
	mov     qword [rsp+0x30], r13
	xor     ebp, ebp
	mov     qword [rsp+0x18], rbx
	mov     rbx, r12
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_001:  mov     esi, 10
	mov     rdi, rbx
	call    strchr
	mov     r13, rax
	test    rax, rax
	jz      loc_011
	sub     rax, rbx
	jz      loc_006
loc_002:  xor     edx, edx
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_003:  movzx   ecx, byte [rbx+rdx]
	mov     esi, ecx
	and     esi, 0x0FFFFFFFB
	cmp     sil, 9
	jz      loc_004
	cmp     cl, 32
	jnz     loc_010
loc_004:  add     rdx, 1
	cmp     rdx, rax
	jc      loc_003
loc_005:  test    r13, r13
	jz      loc_007
loc_006:  lea     rbx, [r13+0x1]
	cmp     byte [r13+0x1], 0
	jnz     loc_001
loc_007:  mov     rbx, qword [rsp+0x18]
	mov     r13, qword [rsp+0x30]
loc_008:  mov     rdi, r12
	call    free
loc_009:  mov     rax, qword [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_014
	mov     rax, rbp
	mov     r12, qword [rsp+0x28]
	mov     rbp, qword [rsp+0x20]
	add     rsp, 56
	ret

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_010:  add     rbp, 1
	jmp     loc_005

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_011:  mov     rdi, rbx
	call    strlen
	test    rax, rax
	jne     loc_002
	jmp     loc_007

loc_012:  xor     ebp, ebp
	jmp     loc_008

loc_013:  mov     rdi, r12
	mov     rbp, -1
	call    free
	jmp     loc_009

loc_014:
	mov     qword [rsp+0x18], rbx
	mov     qword [rsp+0x30], r13
	call    __stack_chk_fail
; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16

cmd_stats_v2:
	sub     rsp, 344
	mov     qword [rsp+0x140], r13
	mov     qword [rsp+0x148], r14
	mov     qword [rsp+0x150], r15
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rdi, qword [fs:abs 0x28]
	mov     qword [rsp+0x118], rdi
	lea     rdi, [rel str_LC0]
	call    count_cmd_lines
	lea     rdi, [rel str_LC1]
	mov     r14, rax
	call    count_cmd_lines
	lea     rdi, [rel str_LC2]
	mov     r13, rax
	call    count_cmd_lines
	lea     rdi, [rel str_LC3]
	mov     r15, rax
	call    count_cmd_lines
	cmp     r14, -1
	mov     rdx, rax
	sete    al
	cmp     r13, -1
	sete    cl
	or      al, cl
	jne     loc_022
	cmp     r15, -1
	je      loc_022
	xor     eax, eax
	test    rdx, rdx
	lea     rsi, [rel str_LC5]
	mov     qword [rsp+0x130], rbp
	cmovns  rax, rdx
	lea     rdi, [rel str_LC6]
	mov     qword [rsp+0x128], rbx
	mov     qword [rsp+0x8], rax
	call    fopen
	mov     rbp, rax
	test    rax, rax
	je      loc_024
	mov     qword [rsp+0x138], r12
	xor     ebx, ebx
	mov     r12, qword 0x0FFFFFFF7FFFFFBFE
; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_015:  mov     rdx, rbp
	mov     esi, 256
	lea     rdi, [rsp+0x10]
	call    fgets
	test    rax, rax
	jz      loc_019
	movzx   ecx, byte [rsp+0x10]
	cmp     cl, 9
	jz      loc_016
	cmp     cl, 32
	jnz     loc_018
loc_016:  lea     rax, [rsp+0x10]
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_017:  movzx   ecx, byte [rax+0x1]
	add     rax, 1
	cmp     cl, 32
	jz      loc_017
	cmp     cl, 9
	jz      loc_017
loc_018:  mov     rax, r12
	mov     edx, 1
	sar     rax, cl
	and     eax, 0x01
	cmp     cl, 36
	cmovnc  rax, rdx
	add     rbx, rax
	jmp     loc_015

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_019:  mov     rdi, rbp
	call    fclose
	mov     r12, qword [rsp+0x138]
loc_020:  lea     rdx, [rel str_LC7]
	lea     rsi, [rel str_LC8]
	xor     eax, eax
	lea     rdi, [rel str_LC9]
	call    printf
	mov     rsi, r14
	lea     rdi, [rel str_LC10]
	xor     eax, eax
	call    printf
	mov     rsi, r15
	lea     rdi, [rel str_LC11]
	xor     eax, eax
	call    printf
	mov     rsi, r13
	lea     rdi, [rel str_LC12]
	xor     eax, eax
	call    printf
	mov     rsi, qword [rsp+0x8]
	lea     rdi, [rel str_LC13]
	xor     eax, eax
	call    printf
	mov     rsi, rbx
	lea     rdi, [rel str_LC14]
	xor     eax, eax
	call    printf
	mov     rbx, qword [rsp+0x128]
	mov     eax, 1
	mov     rbp, qword [rsp+0x130]
loc_021:  mov     rdx, qword [rsp+0x118]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jnz     loc_023
	mov     r13, qword [rsp+0x140]
	mov     r14, qword [rsp+0x148]
	mov     r15, qword [rsp+0x150]
	add     rsp, 344
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_022:  mov     rcx, qword [rel stderr]
	mov     edx, 53
	mov     esi, 1
	lea     rdi, [rel str_LC4]
	call    fwrite
	xor     eax, eax
	jmp     loc_021

loc_023:  mov     qword [rsp+0x128], rbx
	mov     qword [rsp+0x130], rbp
	mov     qword [rsp+0x138], r12
	call    __stack_chk_fail
loc_024:  xor     ebx, ebx
	jmp     loc_020

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x71, 0x00

str_LC1:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x6D, 0x71, 0x00

str_LC2:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x65, 0x71, 0x00

str_LC3:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x64, 0x74, 0x71, 0x00

str_LC5:
	db 0x72, 0x00

str_LC6:
	db 0x2F, 0x75, 0x73, 0x72, 0x2F, 0x6C, 0x6F, 0x63
	db 0x61, 0x6C, 0x2F, 0x65, 0x6D, 0x65, 0x72, 0x67
	db 0x65, 0x2F, 0x77, 0x6F, 0x72, 0x6C, 0x64, 0x00

str_LC7:
	db 0x33, 0x2E, 0x30, 0x2E, 0x30, 0x00

str_LC8:
	db 0x41, 0x72, 0x63, 0x68, 0x74, 0x6F, 0x6F, 0x20
	db 0x45, 0x6D, 0x65, 0x72, 0x67, 0x65, 0x20, 0x45
	db 0x6E, 0x67, 0x69, 0x6E, 0x65, 0x00

str_LC9:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x25
	db 0x73, 0x20, 0x76, 0x25, 0x73, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

str_LC10:
	db 0x49, 0x6E, 0x73, 0x74, 0x61, 0x6C, 0x6C, 0x65
	db 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67
	db 0x65, 0x73, 0x20, 0x3A, 0x20, 0x25, 0x6C, 0x64
	db 0x0A, 0x00

str_LC11:
	db 0x45, 0x78, 0x70, 0x6C, 0x69, 0x63, 0x69, 0x74
	db 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65
	db 0x73, 0x20, 0x20, 0x3A, 0x20, 0x25, 0x6C, 0x64
	db 0x0A, 0x00

str_LC12:
	db 0x46, 0x6F, 0x72, 0x65, 0x69, 0x67, 0x6E, 0x20
	db 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x73
	db 0x20, 0x20, 0x20, 0x3A, 0x20, 0x25, 0x6C, 0x64
	db 0x0A, 0x00

str_LC13:
	db 0x4F, 0x72, 0x70, 0x68, 0x61, 0x6E, 0x65, 0x64
	db 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65
	db 0x73, 0x20, 0x20, 0x3A, 0x20, 0x25, 0x6C, 0x64
	db 0x0A, 0x00

str_LC14:
	db 0x40, 0x77, 0x6F, 0x72, 0x6C, 0x64, 0x20, 0x65
	db 0x6E, 0x74, 0x72, 0x69, 0x65, 0x73, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x3A, 0x20, 0x25, 0x6C, 0x64
	db 0x0A, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC4:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x43, 0x6F, 0x75, 0x6C, 0x64
	db 0x20, 0x6E, 0x6F, 0x74, 0x20, 0x71, 0x75, 0x65
	db 0x72, 0x79, 0x20, 0x70, 0x61, 0x63, 0x6D, 0x61
	db 0x6E, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67
	db 0x65, 0x20, 0x6C, 0x69, 0x73, 0x74, 0x73, 0x2E
	db 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

