; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  devel.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 devel.asm -o devel.o
; ---------------------------------------------------------

default rel

global cmd_devel_v2: function

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
	push    r15
	lea     rdi, [rel str_LC0]
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 184
	mov     qword [rsp+0x8], 0
	lea     rsi, [rsp+0x8]
	call    run_cmd_capture
	cmp     eax, 1
	ja      loc_013
	lea     rdi, [rel str_LC2]
	xor     eax, eax
	call    printf
	mov     rbp, qword [rsp+0x8]
	test    rbp, rbp
	je      loc_015
	cmp     byte [rbp], 0
	je      loc_015
	xor     r13d, r13d
	lea     r12, [rsp+0x10]
	lea     r14, [rel str_LC3]
	lea     r15, [rel str_LC4]
	jmp     loc_003

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_001:  sub     rax, rbp
	lea     rdx, [rax-0x1]
	cmp     rdx, 158
	jbe     loc_005
loc_002:  cmp     byte [rbx+0x1], 0
	lea     rbp, [rbx+0x1]
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
	jbe     loc_005
loc_004:  mov     rdi, qword [rsp+0x8]
	call    free
	test    r13d, r13d
	je      loc_016
	mov     eax, 1
	jmp     loc_014

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_005:  mov     r8d, eax
	mov     rdi, r12
	cmp     eax, 8
	jc      loc_006
	mov     ecx, eax
	mov     rsi, rbp
	shr     ecx, 3
	rep movsq
	mov     rbp, rsi
loc_006:  xor     edx, edx
	test    r8b, 0x04
	jz      loc_007
	mov     edx, dword [rbp]
	mov     dword [rdi], edx
	mov     edx, 4
loc_007:  test    r8b, 0x02
	jz      loc_008
	movzx   ecx, word [rbp+rdx]
	mov     word [rdi+rdx], cx
	add     rdx, 2
loc_008:  and     r8d, 0x01
	jz      loc_009
	movzx   ecx, byte [rbp+rdx]
	mov     byte [rdi+rdx], cl
loc_009:  mov     rsi, r14
	mov     rdi, r12
	mov     byte [rsp+rax+0x10], 0
	call    strstr
	test    rax, rax
	jz      loc_012
loc_010:  mov     rdi, r12
	mov     r13d, 1
	call    puts
loc_011:  test    rbx, rbx
	jne     loc_002
	jmp     loc_004

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_012:  mov     rsi, r15
	mov     rdi, r12
	call    strstr
	test    rax, rax
	jnz     loc_010
	lea     rsi, [rel str_LC5]
	mov     rdi, r12
	call    strstr
	test    rax, rax
	jnz     loc_010
	lea     rsi, [rel str_LC6]
	mov     rdi, r12
	call    strstr
	test    rax, rax
	jnz     loc_010
	lea     rsi, [rel str_LC7]
	mov     rdi, r12
	call    strstr
	test    rax, rax
	jnz     loc_010
	jmp     loc_011

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_013:  mov     rcx, qword [rel stderr]
	mov     edx, 48
	mov     esi, 1
	lea     rdi, [rel str_LC1]
	call    fwrite
	mov     rdi, qword [rsp+0x8]
	call    free
	xor     eax, eax
loc_014:  add     rsp, 184
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
loc_015:  mov     rdi, rbp
	call    free
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_016:  lea     rdi, [rel str_LC8]
	call    puts
	mov     eax, 1
	jmp     loc_014

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

