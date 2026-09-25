; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  search.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 search.asm -o search.o
; ---------------------------------------------------------

default rel

global cmd_search_v2: function

extern __stack_chk_fail
extern strlen
extern fputs
extern aur_response_destroy
extern putc
extern stdout
extern aur_rpc_search
extern config_current
extern free
extern puts
extern run_cmd_capture
extern xsnprintf
extern printf
extern shell_quote
extern fprintf
extern stderr
extern valid_search_query

SECTION .text   align=16 exec

cmd_search_v2:; Function begin
	sub     rsp, 1176
	pxor    xmm0, xmm0
	mov     qword [rsp+0x480], rbx
	mov     qword [rsp+0x488], rbp
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rbp, qword [fs:abs 0x28]
	mov     qword [rsp+0x478], rbp
	mov     rbp, rdi
	movaps  oword [rsp+0x30], xmm0
	mov     qword [rsp+0x18], 0
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
	movaps  oword [rsp+0x20], xmm0
	call    valid_search_query
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
loc_001:  mov     rax, qword [rsp+0x478]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_014
	mov     eax, ebx
	mov     rbp, qword [rsp+0x488]
	mov     rbx, qword [rsp+0x480]
	add     rsp, 1176
	ret

loc_002:  mov     edx, 320
	lea     rsi, [rsp+0x130]
	mov     rdi, rbp
	call    shell_quote
	mov     ebx, eax
	test    eax, eax
	jz      loc_001
	lea     rdi, [rel str_LC3]
	xor     eax, eax
	call    printf
	mov     esi, 512
	xor     eax, eax
	lea     rdi, [rsp+0x270]
	lea     rcx, [rsp+0x130]
	lea     rdx, [rel str_LC4]
	call    xsnprintf
	lea     rsi, [rsp+0x18]
	lea     rdi, [rsp+0x270]
	call    run_cmd_capture
	test    eax, eax
	jnz     loc_003
	mov     rdi, qword [rsp+0x18]
	test    rdi, rdi
	jz      loc_003
	cmp     byte [rdi], 0
	jne     loc_013
loc_003:  lea     rdi, [rel str_LC5]
	xor     ebx, ebx
	call    puts
	mov     rdi, qword [rsp+0x18]
loc_004:  call    free
	lea     rdi, [rel str_LC6]
	xor     eax, eax
	call    printf
	call    config_current
	mov     r8d, 256
	lea     rcx, [rsp+0x30]
	mov     rsi, rbp
	lea     rdi, [rax+0x14]
	lea     rdx, [rsp+0x20]
	call    aur_rpc_search
	test    eax, eax
	je      loc_008
	cmp     qword [rsp+0x28], 0
	je      loc_012
	mov     qword [rsp+0x490], r12
	xor     ebp, ebp
	xor     r12d, r12d
	jmp     loc_007

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_005:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	mov     rsi, qword [rbx+0x18]
	test    rsi, rsi
	jz      loc_006
	cmp     byte [rsi], 0
	jne     loc_010
loc_006:  add     rbp, 1
	add     r12, 152
	cmp     rbp, qword [rsp+0x28]
	jnc     loc_011
loc_007:  mov     rbx, qword [rsp+0x20]
	lea     rax, [rel str_LC0]
	lea     rdi, [rel str_LC8]
	add     rbx, r12
	mov     rdx, qword [rbx+0x10]
	mov     rsi, qword [rbx]
	test    rdx, rdx
	cmove   rdx, rax
	test    rsi, rsi
	lea     rax, [rel str_LC1]
	cmove   rsi, rax
	xor     eax, eax
	call    printf
	mov     rsi, qword [rbx+0x30]
	test    rsi, rsi
	jz      loc_005
	lea     rdi, [rel str_LC9]
	xor     eax, eax
	call    printf
	jmp     loc_005

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_008:  mov     rdi, qword [rel stderr]
	lea     rdx, [rsp+0x30]
	lea     rsi, [rel str_LC11]
	xor     eax, eax
	call    fprintf
loc_009:  lea     rdi, [rsp+0x20]
	call    aur_response_destroy
	jmp     loc_001

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_010:  lea     rdi, [rel str_LC10]
	xor     eax, eax
	call    printf
	jmp     loc_006

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_011:  mov     r12, qword [rsp+0x490]
	mov     ebx, 1
	jmp     loc_009

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_012:  lea     rdi, [rel str_LC7]
	call    puts
	jmp     loc_009

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_013:  mov     rsi, qword [rel stdout]
	mov     ebx, 1
	call    fputs
	mov     rdi, qword [rsp+0x18]
	mov     qword [rsp+0x8], rdi
	call    strlen
	mov     rdi, qword [rsp+0x8]
	cmp     byte [rdi+rax-0x1], 10
	je      loc_004
	mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	mov     rdi, qword [rsp+0x18]
	jmp     loc_004

loc_014:
	mov     qword [rsp+0x490], r12
; Note: Function does not end with ret or jmp
	call    __stack_chk_fail

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x00

str_LC1:
	db 0x3F, 0x00

str_LC3:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x52, 0x65, 0x70, 0x6F, 0x73
	db 0x69, 0x74, 0x6F, 0x72, 0x69, 0x65, 0x73, 0x0A
	db 0x1B, 0x5B, 0x30, 0x6D, 0x00

str_LC4:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x73, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

str_LC5:
	db 0x20, 0x20, 0x20, 0x20, 0x28, 0x6E, 0x6F, 0x20
	db 0x72, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x20, 0x6D, 0x61, 0x74, 0x63, 0x68
	db 0x65, 0x73, 0x29, 0x00

str_LC6:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x3E
	db 0x3E, 0x3E, 0x20, 0x41, 0x55, 0x52, 0x0A, 0x1B
	db 0x5B, 0x30, 0x6D, 0x00

str_LC7:
	db 0x20, 0x20, 0x20, 0x20, 0x28, 0x6E, 0x6F, 0x20
	db 0x41, 0x55, 0x52, 0x20, 0x6D, 0x61, 0x74, 0x63
	db 0x68, 0x65, 0x73, 0x29, 0x00

str_LC8:
	db 0x61, 0x75, 0x72, 0x2F, 0x25, 0x73, 0x20, 0x25
	db 0x73, 0x00

str_LC9:
	db 0x20, 0x28, 0x25, 0x6C, 0x64, 0x20, 0x76, 0x6F
	db 0x74, 0x65, 0x73, 0x29, 0x00

str_LC10:
	db 0x20, 0x20, 0x20, 0x20, 0x25, 0x73, 0x0A, 0x00

str_LC11:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x33, 0x6D, 0x5B
	db 0x21, 0x5D, 0x20, 0x41, 0x55, 0x52, 0x20, 0x52
	db 0x50, 0x43, 0x3A, 0x20, 0x25, 0x73, 0x0A, 0x1B
	db 0x5B, 0x30, 0x6D, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC2:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x73, 0x65, 0x61, 0x72, 0x63
	db 0x68, 0x20, 0x71, 0x75, 0x65, 0x72, 0x79, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

