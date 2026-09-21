; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  package_info.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 package_info.asm -o package_info.o
; ---------------------------------------------------------

default rel

global cmd_available_info_v2: function
global cmd_query_v2: function

extern run_cmd
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
	push    r15
	push    r14
	push    r13
	push    r12
	push    rbp
	push    rbx
	mov     rbx, rdi
	sub     rsp, 1144
	mov     qword [rsp+0x18], 0
	call    valid_pkgname
	test    eax, eax
	jnz     loc_003
	test    rbx, rbx
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	lea     rsi, [rel str_LC2]
	cmove   rbx, rax
	xor     eax, eax
	mov     rdx, rbx
	call    fprintf
loc_001:  xor     eax, eax
loc_002:  add     rsp, 1144
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

loc_003:
	lea     rbp, [rsp+0x130]
	mov     edx, 320
	mov     rdi, rbx
	mov     rsi, rbp
	call    shell_quote
	test    eax, eax
	jz      loc_001
	lea     r12, [rsp+0x270]
	mov     rcx, rbp
	mov     esi, 512
	xor     eax, eax
	lea     rdx, [rel str_LC3]
	mov     rdi, r12
	call    xsnprintf
	mov     rdi, r12
	lea     rsi, [rsp+0x18]
	call    run_cmd_capture
	mov     rdi, qword [rsp+0x18]
	test    eax, eax
	jnz     loc_004
	test    rdi, rdi
	jz      loc_004
	cmp     byte [rdi], 0
	jne     loc_033
loc_004:  call    free
	pxor    xmm0, xmm0
	lea     rbp, [rsp+0x30]
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
	call    config_current
	lea     rdx, [rsp+0x20]
	mov     rcx, rbp
	mov     rsi, rbx
	lea     rdi, [rax+0x14]
	mov     r8d, 256
	mov     qword [rsp+0x8], rdx
	call    aur_rpc_info
	test    eax, eax
	je      loc_032
	cmp     qword [rsp+0x28], 0
	je      loc_035
	xor     r13d, r13d
	xor     r12d, r12d
	lea     rbp, [rel str_LC0]
	lea     rbx, [rel str_LC19]
; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16
loc_005:  mov     r14, qword [rsp+0x20]
	lea     rdi, [rel str_LC6]
	call    puts
	lea     rdi, [rel str_LC7]
	add     r14, r13
	mov     rsi, qword [r14]
	test    rsi, rsi
	cmove   rsi, rbp
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x8]
	lea     rdi, [rel str_LC8]
	test    rsi, rsi
	cmove   rsi, rbp
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x10]
	lea     rdi, [rel str_LC9]
	test    rsi, rsi
	cmove   rsi, rbp
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x18]
	lea     rdi, [rel str_LC10]
	test    rsi, rsi
	cmove   rsi, rbp
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x20]
	lea     rdi, [rel str_LC11]
	test    rsi, rsi
	cmove   rsi, rbp
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x28]
	test    rsi, rsi
	je      loc_031
	cmp     byte [rsi], 0
	lea     rax, [rel str_LC1]
	cmove   rsi, rax
loc_006:  lea     rdi, [rel str_LC12]
	xor     eax, eax
	call    printf
	mov     rsi, qword [r14+0x30]
	lea     rdi, [rel str_LC13]
	xor     eax, eax
	call    printf
	movsd   xmm0, qword [r14+0x38]
	mov     eax, 1
	lea     rdi, [rel str_LC14]
	call    printf
	mov     rsi, qword [r14+0x40]
	test    rsi, rsi
	jne     loc_026
loc_007:  xor     eax, eax
	lea     rdi, [rel str_LC16]
	call    printf
	cmp     qword [r14+0x50], 0
	je      loc_030
loc_008:  xor     r15d, r15d
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_009:  mov     rax, qword [r14+0x48]
	mov     rdi, rbx
	mov     rsi, qword [rax+r15*8]
	xor     eax, eax
	add     r15, 1
	call    printf
	cmp     r15, qword [r14+0x50]
	jc      loc_009
loc_010:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC18]
	call    printf
	cmp     qword [r14+0x60], 0
	je      loc_029
loc_011:  xor     r15d, r15d
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_012:  mov     rax, qword [r14+0x58]
	mov     rdi, rbx
	mov     rsi, qword [rax+r15*8]
	xor     eax, eax
	add     r15, 1
	call    printf
	cmp     r15, qword [r14+0x60]
	jc      loc_012
loc_013:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC20]
	call    printf
	cmp     qword [r14+0x70], 0
	je      loc_028
loc_014:  xor     r15d, r15d
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_015:  mov     rax, qword [r14+0x68]
	mov     rdi, rbx
	mov     rsi, qword [rax+r15*8]
	xor     eax, eax
	add     r15, 1
	call    printf
	cmp     r15, qword [r14+0x70]
	jc      loc_015
loc_016:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC21]
	call    printf
	cmp     qword [r14+0x80], 0
	je      loc_027
loc_017:  xor     r15d, r15d
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_018:  mov     rax, qword [r14+0x78]
	mov     rdi, rbx
	mov     rsi, qword [rax+r15*8]
	xor     eax, eax
	add     r15, 1
	call    printf
	cmp     r15, qword [r14+0x80]
	jc      loc_018
loc_019:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	xor     eax, eax
	lea     rdi, [rel str_LC22]
	call    printf
	cmp     qword [r14+0x90], 0
	je      loc_025
loc_020:  xor     r15d, r15d
	nop
loc_021:  mov     rax, qword [r14+0x88]
	mov     rdi, rbx
	mov     rsi, qword [rax+r15*8]
	xor     eax, eax
	add     r15, 1
	call    printf
	cmp     r15, qword [r14+0x90]
	jc      loc_021
loc_022:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	add     r12, 1
	call    putc
	cmp     r12, qword [rsp+0x28]
	jc      loc_024
loc_023:  mov     rdi, qword [rsp+0x8]
	call    aur_response_destroy
	mov     eax, 1
	jmp     loc_002

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_024:  mov     rsi, qword [rel stdout]
	mov     edi, 10
	add     r13, 152
	call    putc
	cmp     r12, qword [rsp+0x28]
	jc      loc_005
	jmp     loc_023

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_025:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [r14+0x90], 0
	jne     loc_020
	jmp     loc_022

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_026:  lea     rdi, [rel str_LC15]
	xor     eax, eax
	call    printf
	jmp     loc_007

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_027:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [r14+0x80], 0
	jne     loc_017
	jmp     loc_019

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_028:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [r14+0x70], 0
	jne     loc_014
	jmp     loc_016

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_029:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [r14+0x60], 0
	jne     loc_011
	jmp     loc_013

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_030:  xor     eax, eax
	lea     rdi, [rel str_LC17]
	call    printf
	cmp     qword [r14+0x50], 0
	jne     loc_008
	jmp     loc_010

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_031:  lea     rsi, [rel str_LC1]
	jmp     loc_006

loc_032:  mov     rdi, qword [rel stderr]
	mov     rdx, rbp
	lea     rsi, [rel str_LC4]
	call    fprintf
	jmp     loc_001

loc_033:  mov     rsi, qword [rel stdout]
	call    fputs
	mov     rbx, qword [rsp+0x18]
	mov     rdi, rbx
	call    strlen
	cmp     byte [rbx+rax-0x1], 10
	jz      loc_034
	mov     rsi, qword [rel stdout]
	mov     edi, 10
	call    putc
	mov     rbx, qword [rsp+0x18]
loc_034:  mov     rdi, rbx
	call    free
	mov     eax, 1
	jmp     loc_002

loc_035:
	mov     rdi, qword [rel stderr]
	mov     rdx, rbx
	lea     rsi, [rel str_LC5]
	xor     eax, eax
	call    fprintf
	mov     rdi, qword [rsp+0x8]
	call    aur_response_destroy
	jmp     loc_001

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16

cmd_query_v2:; Function begin
	push    rbp
	push    rbx
	mov     rbx, rdi
	sub     rsp, 840
	call    valid_pkgname
	test    eax, eax
	jnz     loc_037
	test    rbx, rbx
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	lea     rsi, [rel str_LC2]
	cmove   rbx, rax
	xor     eax, eax
	mov     rdx, rbx
	call    fprintf
loc_036:  add     rsp, 840
	xor     eax, eax
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_037:  mov     edx, 320
	mov     rsi, rsp
	mov     rdi, rbx
	call    shell_quote
	test    eax, eax
	jz      loc_036
	lea     rbx, [rsp+0x140]
	mov     rcx, rsp
	mov     esi, 512
	xor     eax, eax
	mov     rdi, rbx
	lea     rdx, [rel str_LC23]
	call    xsnprintf
	mov     rdi, rbx
	call    run_cmd
	test    eax, eax
	sete    al
	add     rsp, 840
	movzx   eax, al
	pop     rbx
	pop     rbp
	ret

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
	db 0x4D, 0x61, 0x6B, 0x65, 0x20, 0x44, 0x65, 0x70
	db 0x73, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	db 0x3A, 0x00

str_LC19:
	db 0x20, 0x25, 0x73, 0x00

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

