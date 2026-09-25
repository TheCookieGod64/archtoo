; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  devel.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 devel.asm -o devel.o
; ---------------------------------------------------------

default rel

global cmd_devel_v2: function

extern __stack_chk_fail
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
	sub     rsp, 216
	lea     rdi, [rel str_LC0]
	mov     qword [rsp+0x0D0], r12
	lea     rsi, [rsp+0x8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x0B8], rax
	xor     eax, eax
	mov     qword [rsp+0x8], 0
	call    run_cmd_capture
	cmp     eax, 1
	ja      loc_015
	lea     rdi, [rel str_LC2]
	xor     eax, eax
	mov     qword [rsp+0x0C8], rbp
	call    printf
	mov     rbp, qword [rsp+0x8]
	test    rbp, rbp
	je      loc_016
	cmp     byte [rbp], 0
	je      loc_016
	mov     qword [rsp+0x0C0], rbx
	xor     r12d, r12d
	jmp     loc_003

loc_001:  sub     rax, rbp
	lea     rdx, [rax-0x1]
	cmp     rdx, 158
	jbe     loc_006
loc_002:  lea     rbp, [rbx+0x1]
	cmp     byte [rbx+0x1], 0
	jz      loc_004
loc_003:  mov     esi, 10
	mov     rdi, rbp
	call    strchr
	mov     rbx, rax
	test    rax, rax
	jnz     loc_001
	mov     rdi, rbp
	call    strlen
	lea     rdx, [rax-0x1]
	cmp     rdx, 158
	jbe     loc_006
loc_004:  mov     rdi, qword [rsp+0x8]
	call    free
	mov     rbx, qword [rsp+0x0C0]
	test    r12d, r12d
	je      loc_017
	mov     rbp, qword [rsp+0x0C8]
loc_005:  mov     rax, qword [rsp+0x0B8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_018
	mov     eax, r12d
	mov     r12, qword [rsp+0x0D0]
	add     rsp, 216
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_006:  mov     ecx, eax
	lea     r8, [rsp+0x10]
	mov     rdx, rbp
	cmp     eax, 64
	jnc     loc_012
loc_007:  and     ecx, 0x3F
	jz      loc_009
	xor     esi, esi
loc_008:  mov     edi, esi
	add     esi, 1
	movzx   r9d, byte [rdx+rdi]
	mov     byte [r8+rdi], r9b
	cmp     esi, ecx
	jc      loc_008
loc_009:  lea     rsi, [rel str_LC3]
	lea     rdi, [rsp+0x10]
	mov     byte [rsp+rax+0x10], 0
	call    strstr
	test    rax, rax
	jz      loc_014
loc_010:  lea     rdi, [rsp+0x10]
	mov     r12d, 1
	call    puts
loc_011:  test    rbx, rbx
	jne     loc_002
	jmp     loc_004

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_012:  mov     edi, eax
	xor     edx, edx
	and     edi, 0x0FFFFFFC0
loc_013:  mov     esi, edx
	add     edx, 64
	movdqu  xmm3, oword [rbp+rsi]
	movdqu  xmm2, oword [rbp+rsi+0x10]
	movdqu  xmm1, oword [rbp+rsi+0x20]
	movdqu  xmm0, oword [rbp+rsi+0x30]
	movaps  oword [rsp+rsi+0x10], xmm3
	movaps  oword [rsp+rsi+0x20], xmm2
	movaps  oword [rsp+rsi+0x30], xmm1
	movaps  oword [rsp+rsi+0x40], xmm0
	cmp     edx, edi
	jc      loc_013
	lea     r8, [rsp+rdx+0x10]
	add     rdx, rbp
	jmp     loc_007

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_014:  lea     rsi, [rel str_LC4]
	lea     rdi, [rsp+0x10]
	call    strstr
	test    rax, rax
	jne     loc_010
	lea     rsi, [rel str_LC5]
	lea     rdi, [rsp+0x10]
	call    strstr
	test    rax, rax
	jne     loc_010
	lea     rsi, [rel str_LC6]
	lea     rdi, [rsp+0x10]
	call    strstr
	test    rax, rax
	jne     loc_010
	lea     rsi, [rel str_LC7]
	lea     rdi, [rsp+0x10]
	call    strstr
	test    rax, rax
	jne     loc_010
	jmp     loc_011

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_015:  mov     rcx, qword [rel stderr]
	mov     edx, 48
	mov     esi, 1
	xor     r12d, r12d
	lea     rdi, [rel str_LC1]
	call    fwrite
	mov     rdi, qword [rsp+0x8]
	call    free
	jmp     loc_005

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_016:  mov     rdi, rbp
	call    free
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_017:  lea     rdi, [rel str_LC8]
	mov     r12d, 1
	call    puts
	mov     rbp, qword [rsp+0x0C8]
	jmp     loc_005

loc_018:
	mov     qword [rsp+0x0C0], rbx
	mov     qword [rsp+0x0C8], rbp
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x6D, 0x71, 0x00

str_LC3:
	db 0x2D, 0x67, 0x69, 0x74, 0x00

str_LC4:
	db 0x2D, 0x68, 0x67, 0x00

str_LC5:
	db 0x2D, 0x73, 0x76, 0x6E, 0x00

str_LC6:
	db 0x2D, 0x62, 0x7A, 0x72, 0x00

str_LC7:
	db 0x2D, 0x63, 0x76, 0x73, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC1:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x43, 0x6F, 0x75, 0x6C, 0x64
	db 0x20, 0x6E, 0x6F, 0x74, 0x20, 0x6C, 0x69, 0x73
	db 0x74, 0x20, 0x66, 0x6F, 0x72, 0x65, 0x69, 0x67
	db 0x6E, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61, 0x67
	db 0x65, 0x73, 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC2:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x44, 0x65, 0x76, 0x65, 0x6C
	db 0x6F, 0x70, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x2F
	db 0x20, 0x56, 0x43, 0x53, 0x20, 0x70, 0x61, 0x63
	db 0x6B, 0x61, 0x67, 0x65, 0x73, 0x20, 0x28, 0x2D
	db 0x67, 0x69, 0x74, 0x2F, 0x2D, 0x68, 0x67, 0x2F
	db 0x2D, 0x73, 0x76, 0x6E, 0x2F, 0x2D, 0x62, 0x7A
	db 0x72, 0x2F, 0x2D, 0x63, 0x76, 0x73, 0x29, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00, 0x00, 0x00, 0x00

str_LC8:
	db 0x4E, 0x6F, 0x20, 0x64, 0x65, 0x76, 0x65, 0x6C
	db 0x6F, 0x70, 0x6D, 0x65, 0x6E, 0x74, 0x20, 0x70
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x73, 0x20
	db 0x69, 0x6E, 0x73, 0x74, 0x61, 0x6C, 0x6C, 0x65
	db 0x64, 0x2E, 0x00

