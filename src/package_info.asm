; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  package_info.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 package_info.asm -o package_info.o
; ---------------------------------------------------------

default rel

global cmd_available_info_v2: function
global cmd_query_v2: function

extern run_cmd
extern __stack_chk_fail
extern strlen
extern fputs
extern aur_response_destroy
extern putc
extern stdout
extern printf
extern puts
extern aur_rpc_info
extern config_current
extern free
extern run_cmd_capture
extern xsnprintf
extern shell_quote
extern fprintf
extern stderr
extern valid_pkgname

SECTION .text   align=16 exec

cmd_available_info_v2:; Function begin
	sub     rsp, 1176
	mov     qword [rsp+0x470], rbx
	mov     qword [rsp+0x478], rbp
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbp, qword [fs:abs 0x28]
	mov     qword [rsp+0x468], rbp
	mov     rbp, rdi
	mov     qword [rsp+0x8], 0
	call    valid_pkgname
	test    eax, eax
	jnz     loc_002
	test    rbp, rbp
	mov     ebx, eax
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	cmove   rbp, rax
	lea     rsi, [rel str_LC2]
	xor     eax, eax
	mov     rdx, rbp
	call    fprintf
loc_001:  mov     rax, qword [rsp+0x468]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_035
	mov     eax, ebx
	mov     rbp, qword [rsp+0x478]
	mov     rbx, qword [rsp+0x470]
	add     rsp, 1176
	ret

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_002:  mov     edx, 320
	lea     rsi, [rsp+0x120]
	mov     rdi, rbp
	call    shell_quote
	mov     ebx, eax
	test    eax, eax
	jz      loc_001
	lea     rcx, [rsp+0x120]
	mov     esi, 512
	xor     eax, eax
	lea     rdx, [rel str_LC3]
	lea     rdi, [rsp+0x260]
	call    xsnprintf
	lea     rdi, [rsp+0x260]
	lea     rsi, [rsp+0x8]
	call    run_cmd_capture
	mov     rdi, qword [rsp+0x8]
	test    eax, eax
	jnz     loc_003
	test    rdi, rdi
	jz      loc_003
	cmp     byte [rdi], 0
	jne     loc_032
loc_003:  call    free
	pxor    xmm0, xmm0
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
	call    config_current
	mov     r8d, 256
	lea     rcx, [rsp+0x20]
	mov     rsi, rbp
	lea     rdi, [rax+0x14]
	lea     rdx, [rsp+0x10]
	call    aur_rpc_info
	mov     ebx, eax
	test    eax, eax
	je      loc_031
	cmp     qword [rsp+0x18], 0
	je      loc_034
	mov     qword [rsp+0x480], r12
	lea     r12, [rel str_LC0]
	mov     qword [rsp+0x488], r13
	xor     r13d, r13d
	mov     qword [rsp+0x490], r14
	xor     r14d, r14d
	nop
loc_004:  mov     rbx, qword [rsp+0x10]
	lea     rdi, [rel str_LC6]
	call    puts
	lea     rdi, [rel str_LC7]
	add     rbx, r14
	mov     rsi, qword [rbx]
	test    rsi, rsi
	cmove   rsi, r12
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x8]
	lea     rdi, [rel str_LC8]
	test    rsi, rsi
	cmove   rsi, r12
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x10]
	lea     rdi, [rel str_LC9]
	test    rsi, rsi
	cmove   rsi, r12
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x18]
	lea     rdi, [rel str_LC10]
	test    rsi, rsi
	cmove   rsi, r12
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x20]
	lea     rdi, [rel str_LC11]
	test    rsi, rsi
	cmove   rsi, r12
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x28]
	test    rsi, rsi
	je      loc_030
	cmp     byte [rsi], 0
	lea     rax, [rel str_LC1]
	cmove   rsi, rax
loc_005:  lea     rdi, [rel str_LC12]
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x30]
	lea     rdi, [rel str_LC13]
	xor     eax, eax
	call    printf
	movsd   xmm0, qword [rbx+0x38]
	mov     eax, 1
	lea     rdi, [rel str_LC14]
	call    printf
	mov     rsi, qword [rbx+0x40]
	test    rsi, rsi
	jne     loc_029
loc_006:  xor     eax, eax
	lea     rdi, [rel str_LC16]
	call    printf
	cmp     qword [rbx+0x50], 0
	je      loc_027
loc_007:  xor     ebp, ebp
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_008:  mov     rax, qword [rbx+0x48]
	lea     rdi, [rel str_LC18]
	mov     rsi, qword [rax+rbp*8]
	xor     eax, eax
	add     rbp, 1
	call    printf
	cmp     rbp, qword [rbx+0x50]
	jc      loc_008
loc_009:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC19]
	call    printf
	cmp     qword [rbx+0x60], 0
	je      loc_026
loc_010:  xor     ebp, ebp
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_011:  mov     rax, qword [rbx+0x58]
	lea     rdi, [rel str_LC18]
	mov     rsi, qword [rax+rbp*8]
	xor     eax, eax
	add     rbp, 1
	call    printf
	cmp     rbp, qword [rbx+0x60]
	jc      loc_011
loc_012:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC20]
	call    printf
	cmp     qword [rbx+0x70], 0
	je      loc_025
loc_013:  xor     ebp, ebp
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_014:  mov     rax, qword [rbx+0x68]
	lea     rdi, [rel str_LC18]
	mov     rsi, qword [rax+rbp*8]
	xor     eax, eax
	add     rbp, 1
	call    printf
	cmp     rbp, qword [rbx+0x70]
	jc      loc_014
loc_015:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC21]
	call    printf
	cmp     qword [rbx+0x80], 0
	je      loc_024
loc_016:  xor     ebp, ebp
	nop
loc_017:  mov     rax, qword [rbx+0x78]
	lea     rdi, [rel str_LC18]
	mov     rsi, qword [rax+rbp*8]
	xor     eax, eax
	add     rbp, 1
	call    printf
	cmp     rbp, qword [rbx+0x80]
	jc      loc_017
loc_018:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC22]
	call    printf
	cmp     qword [rbx+0x90], 0
	jz      loc_023
loc_019:  xor     ebp, ebp
; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_020:  mov     rax, qword [rbx+0x88]
	lea     rdi, [rel str_LC18]
	mov     rsi, qword [rax+rbp*8]
	xor     eax, eax
	add     rbp, 1
	call    printf
	cmp     rbp, qword [rbx+0x90]
	jc      loc_020
loc_021:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	add     r13, 1
	call    putc
	cmp     r13, qword [rsp+0x18]
	jc      loc_028
loc_022:  lea     rdi, [rsp+0x10]
	mov     ebx, 1
	call    aur_response_destroy
	mov     r12, qword [rsp+0x480]
	mov     r13, qword [rsp+0x488]
	mov     r14, qword [rsp+0x490]
	jmp     loc_001

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_023:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [rbx+0x90], 0
	jne     loc_019
	jmp     loc_021

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_024:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [rbx+0x80], 0
	jne     loc_016
	jmp     loc_018

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_025:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [rbx+0x70], 0
	jne     loc_013
	jmp     loc_015

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_026:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [rbx+0x60], 0
	jne     loc_010
	jmp     loc_012

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_027:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [rbx+0x50], 0
	jne     loc_007
	jmp     loc_009

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_028:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	add     r14, 152
	call    putc
	cmp     r13, qword [rsp+0x18]
	jc      loc_004
	jmp     loc_022

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_029:  lea     rdi, [rel str_LC15]
	xor     eax, eax
	call    printf
	jmp     loc_006

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_030:  lea     rsi, [rel str_LC1]
	jmp     loc_005

loc_031:  mov     rdi, qword [rel stderr]
	lea     rdx, [rsp+0x20]
	lea     rsi, [rel str_LC4]
	xor     eax, eax
	call    fprintf
	jmp     loc_001

loc_032:  mov     rsi, qword [rel stdout]
	call    fputs
	mov     rbx, qword [rsp+0x8]
	mov     rdi, rbx
	call    strlen
	cmp     byte [rbx+rax-0x1], 10
	jz      loc_033
	mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	mov     rbx, qword [rsp+0x8]
loc_033:  mov     rdi, rbx
	mov     ebx, 1
	call    free
	jmp     loc_001

loc_034:  mov     rdi, qword [rel stderr]
	mov     rdx, rbp
	xor     eax, eax
	xor     ebx, ebx
	lea     rsi, [rel str_LC5]
	call    fprintf
	lea     rdi, [rsp+0x10]
	call    aur_response_destroy
	jmp     loc_001

loc_035:
	mov     qword [rsp+0x480], r12
	mov     qword [rsp+0x488], r13
	mov     qword [rsp+0x490], r14
	call    __stack_chk_fail
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00, 0x66, 0x66, 0x2E, 0x0F
;       db 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16

cmd_query_v2:
	push    rbx
	sub     rsp, 864
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbx, qword [fs:abs 0x28]
	mov     qword [rsp+0x358], rbx
	mov     rbx, rdi
	call    valid_pkgname
	test    eax, eax
	jnz     loc_037
	mov     ecx, eax
	test    rbx, rbx
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	cmovne  rax, rbx
	lea     rsi, [rel str_LC2]
	mov     dword [rsp+0x0C], ecx
	mov     rdx, rax
	xor     eax, eax
	call    fprintf
	mov     ecx, dword [rsp+0x0C]
loc_036:  mov     rax, qword [rsp+0x358]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_038
	add     rsp, 864
	mov     eax, ecx
	pop     rbx
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_037:  mov     edx, 320
	lea     rsi, [rsp+0x10]
	mov     rdi, rbx
	call    shell_quote
	mov     ecx, eax
	test    eax, eax
	jz      loc_036
	lea     rcx, [rsp+0x10]
	mov     esi, 512
	xor     eax, eax
	lea     rdx, [rel str_LC23]
	lea     rdi, [rsp+0x150]
	call    xsnprintf
	lea     rdi, [rsp+0x150]
	call    run_cmd
	xor     ecx, ecx
	test    eax, eax
	sete    cl
	jmp     loc_036

loc_038:
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x00

str_LC1:
	db 0x28, 0x6F, 0x72, 0x70, 0x68, 0x61, 0x6E, 0x29
	db 0x00

str_LC3:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

str_LC4:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x25, 0x73, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

str_LC6:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x61, 0x75, 0x72, 0x00

str_LC7:
	db 0x4E, 0x61, 0x6D, 0x65, 0x20, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC8:
	db 0x50, 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x20
	db 0x42, 0x61, 0x73, 0x65, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC9:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC10:
	db 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70, 0x74
	db 0x69, 0x6F, 0x6E, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC11:
	db 0x55, 0x52, 0x4C, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC12:
	db 0x4D, 0x61, 0x69, 0x6E, 0x74, 0x61, 0x69, 0x6E
	db 0x65, 0x72, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC13:
	db 0x56, 0x6F, 0x74, 0x65, 0x73, 0x20, 0x20, 0x20
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x6C, 0x64, 0x0A, 0x00

str_LC14:
	db 0x50, 0x6F, 0x70, 0x75, 0x6C, 0x61, 0x72, 0x69
	db 0x74, 0x79, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x2E, 0x32, 0x66, 0x0A, 0x00

str_LC15:
	db 0x4F, 0x75, 0x74, 0x20, 0x4F, 0x66, 0x20, 0x44
	db 0x61, 0x74, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x20, 0x25, 0x6C, 0x64, 0x0A, 0x00

str_LC16:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x20
	db 0x4F, 0x6E, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

str_LC17:
	db 0x20, 0x4E, 0x6F, 0x6E, 0x65, 0x00

str_LC18:
	db 0x20, 0x25, 0x73, 0x00

str_LC19:
	db 0x4D, 0x61, 0x6B, 0x65, 0x20, 0x44, 0x65, 0x70
	db 0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

str_LC20:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

str_LC21:
	db 0x50, 0x72, 0x6F, 0x76, 0x69, 0x64, 0x65, 0x73
	db 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

str_LC22:
	db 0x43, 0x6F, 0x6E, 0x66, 0x6C, 0x69, 0x63, 0x74
	db 0x73, 0x20, 0x57, 0x69, 0x74, 0x68, 0x20, 0x20
	db 0x3A, 0x00

str_LC23:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x51, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC2:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC5:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x50, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20
	db 0x77, 0x61, 0x73, 0x20, 0x6E, 0x6F, 0x74, 0x20
	db 0x66, 0x6F, 0x75, 0x6E, 0x64, 0x20, 0x69, 0x6E
	db 0x20, 0x72, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74
	db 0x6F, 0x72, 0x69, 0x65, 0x73, 0x20, 0x6F, 0x72
	db 0x20, 0x74, 0x68, 0x65, 0x20, 0x41, 0x55, 0x52
	db 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

