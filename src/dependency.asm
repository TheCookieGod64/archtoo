; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  dependency.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 dependency.asm -o dependency.o
; ---------------------------------------------------------

default rel

global cmd_dependency_plan_v2: function

extern fprintf
extern stderr
extern graph_package_source
extern graph_package_version
extern aur_response_destroy
extern aur_rpc_info
extern config_current
extern puts
extern putc
extern stdout
extern graph_destroy
extern graph_package_name
extern graph_topological_order
extern free
extern strtok_r
extern strdup
extern graph_create
extern strcmp
extern printf
extern strncmp
extern strchr
extern run_cmd_capture
extern xsnprintf
extern shell_quote
extern graph_add_package
extern graph_add_dependency
extern graph_has_package
extern valid_pkgname
extern dep_basename

SECTION .text   align=16 exec

add_dep_nodes:
	test    rcx, rcx
	je      loc_005
	push    r15
	mov     r15, rsi
	push    r14
	mov     r14, rdi
	push    r13
	mov     r13, rdx
	push    r12
	mov     r12, rcx
	push    rbp
	push    rbx
	xor     ebx, ebx
	sub     rsp, 168
	mov     rbp, rsp
; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_001:  mov     rdi, qword [r13+rbx*8]
	mov     edx, 160
	mov     rsi, rbp
	call    dep_basename
	cmp     byte [rsp], 0
	jz      loc_003
	mov     rdi, rbp
	call    valid_pkgname
	test    eax, eax
	jz      loc_003
	mov     rsi, rbp
	mov     rdi, r14
	call    graph_has_package
	test    eax, eax
	jz      loc_004
loc_002:  mov     rdx, rbp
	mov     rsi, r15
	mov     rdi, r14
	call    graph_add_dependency
loc_003:  add     rbx, 1
	cmp     r12, rbx
	jnz     loc_001
	add     rsp, 168
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
loc_004:  xor     ecx, ecx
	lea     rdx, [rel str_LC0]
	mov     rsi, rbp
	mov     rdi, r14
	call    graph_add_package
	jmp     loc_002

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_005:  ret

; Filling space: 0x0F
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x0F, 0x1F, 0x40, 0x00

ALIGN   16

plan_from_repo:
	push    r15
	mov     edx, 320
	push    r14
	push    r13
	push    r12
	mov     r12, rdi
	push    rbp
	push    rbx
	sub     rsp, 1320
	lea     rbx, [rsp+0x1E0]
	mov     qword [rsp+0x20], 0
	mov     rsi, rbx
	call    shell_quote
	test    eax, eax
	jnz     loc_008
loc_006:  xor     eax, eax
loc_007:  add     rsp, 1320
	pop     rbx
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	pop     r15
	ret

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_008:  lea     rbp, [rsp+0x320]
	mov     rcx, rbx
	mov     esi, 512
	xor     eax, eax
	lea     rdx, [rel str_LC3]
	mov     rdi, rbp
	call    xsnprintf
	lea     rsi, [rsp+0x20]
	mov     rdi, rbp
	call    run_cmd_capture
	mov     r13, qword [rsp+0x20]
	test    eax, eax
	jne     loc_041
	test    r13, r13
	je      loc_041
	cmp     byte [r13], 0
	je      loc_041
	xor     eax, eax
	xor     r14d, r14d
	xor     r8d, r8d
	xor     ebp, ebp
	mov     qword [rsp+0x18], r12
	xor     ebx, ebx
	xor     r15d, r15d
	mov     r12, rax
	mov     qword [rsp], rbp
	mov     qword [rsp+0x8], r8
	mov     qword [rsp+0x10], r14
	jmp     loc_012

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_009:  lea     rbx, [rbp+0x1]
loc_010:  test    r14, r14
	je      loc_015
loc_011:  cmp     byte [r14+0x1], 0
	lea     r13, [r14+0x1]
	je      loc_015
loc_012:  mov     esi, 10
	mov     rdi, r13
	call    strchr
	mov     r14, rax
	test    rax, rax
	jz      loc_014
	mov     byte [rax], 0
	mov     esi, 58
	mov     rdi, r13
	call    strchr
	mov     rbp, rax
	test    rax, rax
	jz      loc_011
loc_013:  mov     byte [rbp], 0
	mov     edx, 7
	lea     rsi, [rel str_LC4]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jz      loc_009
	mov     edx, 10
	lea     rsi, [rel str_LC5]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jne     loc_040
	lea     r12, [rbp+0x1]
	jmp     loc_010

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_014:  mov     esi, 58
	mov     rdi, r13
	call    strchr
	mov     rbp, rax
	test    rax, rax
	jnz     loc_013
loc_015:  mov     rax, r12
	mov     rbp, qword [rsp]
	mov     r8, qword [rsp+0x8]
	mov     r14, qword [rsp+0x10]
	mov     r12, qword [rsp+0x18]
	test    rbx, rbx
	jz      loc_018
	movzx   edx, byte [rbx]
	cmp     dl, 32
	jnz     loc_017
; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_016:  movzx   edx, byte [rbx+0x1]
	add     rbx, 1
	cmp     dl, 32
	jz      loc_016
loc_017:  cmp     dl, 9
	jz      loc_016
loc_018:  test    rax, rax
	jne     loc_035
	test    r15, r15
	jne     loc_037
loc_019:  test    rbp, rbp
	jne     loc_039
loc_020:  test    r8, r8
	jz      loc_023
loc_021:  movzx   edx, byte [r8]
	cmp     dl, 9
	jz      loc_022
	cmp     dl, 32
	jnz     loc_023
loc_022:  movzx   edx, byte [r8+0x1]
	add     r8, 1
	cmp     dl, 32
	jz      loc_022
	cmp     dl, 9
	jz      loc_022
loc_023:  test    r14, r14
	jz      loc_025
	movzx   edx, byte [r14]
	cmp     dl, 9
	jz      loc_024
	cmp     dl, 32
	jnz     loc_025
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_024:  movzx   edx, byte [r14+0x1]
	add     r14, 1
	cmp     dl, 32
	jz      loc_024
	cmp     dl, 9
	jz      loc_024
loc_025:  test    rax, rax
	je      loc_043
	cmp     byte [rax], 0
	lea     rdx, [rel str_LC1]
	cmove   rax, rdx
loc_026:  test    rbx, rbx
	mov     rcx, rax
	mov     rsi, r12
	mov     qword [rsp], r8
	lea     rdx, [rel str_LC0]
	lea     rdi, [rel str_LC11]
	cmove   rbx, rdx
	xor     eax, eax
	lea     r13, [rel str_LC2]
	mov     rdx, rbx
	call    printf
	test    r15, r15
	mov     r8, qword [rsp]
	jz      loc_027
	cmp     byte [r15], 0
	jz      loc_027
	lea     rsi, [rel str_LC12]
	mov     rdi, r15
	call    strcmp
	mov     r8, qword [rsp]
	test    eax, eax
	cmovne  r13, r15
loc_027:  mov     rdx, r13
	lea     r13, [rel str_LC14]
	xor     eax, eax
	mov     qword [rsp], r8
	lea     rsi, [rel str_LC13]
	mov     rdi, r13
	call    printf
	mov     r8, qword [rsp]
	test    r8, r8
	je      loc_051
	cmp     byte [r8], 0
	je      loc_051
	mov     rdi, r8
	lea     rsi, [rel str_LC12]
	call    strcmp
	mov     r8, qword [rsp]
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmove   r8, rax
loc_028:  xor     eax, eax
	mov     rdx, r8
	mov     rdi, r13
	lea     rsi, [rel str_LC15]
	call    printf
	test    r14, r14
	je      loc_050
	cmp     byte [r14], 0
	je      loc_050
	mov     rdi, r14
	lea     rsi, [rel str_LC12]
	call    strcmp
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmove   r14, rax
loc_029:  xor     eax, eax
	mov     rdx, r14
	mov     rdi, r13
	lea     rsi, [rel str_LC16]
	call    printf
	test    rbp, rbp
	je      loc_049
	cmp     byte [rbp], 0
	je      loc_049
	mov     rdi, rbp
	lea     rsi, [rel str_LC12]
	call    strcmp
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmove   rbp, rax
loc_030:  mov     rdx, rbp
	lea     rsi, [rel str_LC17]
	mov     rdi, r13
	xor     eax, eax
	call    printf
	lea     rdi, [rel str_LC18]
	xor     eax, eax
	call    printf
	call    graph_create
	pxor    xmm0, xmm0
	mov     qword [rsp+0x28], 0
	mov     qword [rsp+0x30], 0
	mov     rbp, rax
	movaps  oword [rsp+0x0E0], xmm0
	movaps  oword [rsp+0x0F0], xmm0
	movaps  oword [rsp+0x100], xmm0
	movaps  oword [rsp+0x110], xmm0
	movaps  oword [rsp+0x120], xmm0
	movaps  oword [rsp+0x130], xmm0
	movaps  oword [rsp+0x140], xmm0
	movaps  oword [rsp+0x150], xmm0
	movaps  oword [rsp+0x160], xmm0
	movaps  oword [rsp+0x170], xmm0
	movaps  oword [rsp+0x180], xmm0
	movaps  oword [rsp+0x190], xmm0
	movaps  oword [rsp+0x1A0], xmm0
	movaps  oword [rsp+0x1B0], xmm0
	movaps  oword [rsp+0x1C0], xmm0
	movaps  oword [rsp+0x1D0], xmm0
	test    rax, rax
	je      loc_048
	xor     ecx, ecx
	mov     rdx, rbx
	mov     rsi, r12
	mov     rdi, rax
	call    graph_add_package
	test    r15, r15
	je      loc_045
	cmp     byte [r15], 0
	je      loc_045
	lea     rsi, [rel str_LC12]
	mov     rdi, r15
	call    strcmp
	test    eax, eax
	je      loc_045
	mov     rdi, r15
	call    strdup
	mov     qword [rsp+0x38], 0
	mov     r14, rax
	test    rax, rax
	je      loc_045
	lea     r13, [rsp+0x38]
	lea     rbx, [rel str_LC19]
	mov     rdi, rax
	mov     rdx, r13
	mov     rsi, rbx
	lea     r15, [rsp+0x40]
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	jnz     loc_032
	jmp     loc_044

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_031:  xor     edi, edi
	mov     rdx, r13
	mov     rsi, rbx
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	je      loc_044
loc_032:  mov     edx, 160
	mov     rsi, r15
	call    dep_basename
	cmp     byte [rsp+0x40], 0
	jz      loc_031
	mov     rdi, r15
	call    valid_pkgname
	test    eax, eax
	jz      loc_031
	mov     rsi, r15
	mov     rdi, rbp
	call    graph_has_package
	test    eax, eax
	je      loc_055
loc_033:  mov     rdx, r15
	mov     rsi, r12
	mov     rdi, rbp
	call    graph_add_dependency
	jmp     loc_031

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_034:  add     rax, 1
loc_035:  movzx   edx, byte [rax]
	cmp     dl, 32
	jz      loc_034
	cmp     dl, 9
	jz      loc_034
	test    r15, r15
	jnz     loc_037
	jmp     loc_019

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_036:  add     r15, 1
loc_037:  movzx   edx, byte [r15]
	cmp     dl, 32
	jz      loc_036
	cmp     dl, 9
	jz      loc_036
	test    rbp, rbp
	jnz     loc_039
	jmp     loc_020

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_038:  add     rbp, 1
loc_039:  movzx   edx, byte [rbp]
	cmp     dl, 32
	jz      loc_038
	cmp     dl, 9
	jz      loc_038
	test    r8, r8
	jne     loc_021
	jmp     loc_023

loc_040:  mov     edx, 10
	lea     rsi, [rel str_LC6]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jz      loc_042
	mov     edx, 13
	lea     rsi, [rel str_LC7]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jne     loc_052
	lea     rax, [rbp+0x1]
	mov     qword [rsp], rax
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_041:  mov     rdi, r13
	call    free
	jmp     loc_006

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_042:  lea     r15, [rbp+0x1]
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_043:  lea     rax, [rel str_LC1]
	jmp     loc_026

loc_044:  mov     rdi, r14
	call    free
; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_045:  lea     rcx, [rsp+0x0E0]
	lea     rdx, [rsp+0x30]
	mov     r8d, 256
	mov     rdi, rbp
	lea     rsi, [rsp+0x28]
	call    graph_topological_order
	test    eax, eax
	je      loc_054
	xor     ebx, ebx
	cmp     qword [rsp+0x30], 0
	lea     r12, [rel str_LC20]
	jz      loc_047
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_046:  mov     rax, qword [rsp+0x28]
	mov     rdi, rbp
	mov     rsi, qword [rax+rbx*8]
	add     rbx, 1
	call    graph_package_name
	mov     rsi, rbx
	mov     rdi, r12
	mov     rdx, rax
	xor     eax, eax
	call    printf
	cmp     rbx, qword [rsp+0x30]
	jc      loc_046
loc_047:  mov     rdi, qword [rsp+0x28]
	call    free
	mov     rdi, rbp
	call    graph_destroy
loc_048:  mov     rdi, qword [rsp+0x20]
	call    free
	mov     eax, 1
	jmp     loc_007

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_049:  lea     rbp, [rel str_LC2]
	jmp     loc_030

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_050:  lea     r14, [rel str_LC2]
	jmp     loc_029

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_051:  lea     r8, [rel str_LC2]
	jmp     loc_028

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_052:  mov     edx, 9
	lea     rsi, [rel str_LC8]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jz      loc_053
	mov     edx, 10
	lea     rsi, [rel str_LC9]
	mov     rdi, r13
	call    strncmp
	test    eax, eax
	jz      loc_053
	mov     edx, 10
	lea     rsi, [rel str_LC10]
	mov     rdi, r13
	call    strncmp
	lea     r8, [rbp+0x1]
	test    eax, eax
	cmovne  r8, qword [rsp+0x10]
	mov     qword [rsp+0x10], r8
	jmp     loc_010

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_053:  lea     rax, [rbp+0x1]
	mov     qword [rsp+0x8], rax
	jmp     loc_010

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_054:  mov     rsi, r12
	lea     rdi, [rel str_LC21]
	xor     eax, eax
	call    printf
	jmp     loc_047

loc_055:
	xor     ecx, ecx
	lea     rdx, [rel str_LC0]
	mov     rsi, r15
	mov     rdi, rbp
	call    graph_add_package
	jmp     loc_033

	nop

ALIGN   16
print_dep_list:
	push    r14
	xor     eax, eax
	push    r13
	push    r12
	mov     r12, rsi
	mov     rsi, rdi
	lea     rdi, [rel str_LC23]
	push    rbp
	mov     rbp, rdx
	push    rbx
	call    printf
	test    rbp, rbp
	jz      loc_058
	mov     rdx, qword [r12]
	xor     ebx, ebx
	lea     rsi, [rel str_LC0]
	lea     r13, [rel str_LC24]
	lea     r14, [rel str_LC22]
	jmp     loc_057

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_056:  mov     rdx, qword [r12+rbx*8]
	mov     rsi, r14
loc_057:  mov     rdi, r13
	xor     eax, eax
	add     rbx, 1
	call    printf
	cmp     rbp, rbx
	jnz     loc_056
	mov     rsi, qword [rel stdout]
	pop     rbx
	mov     edi, 10
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	jmp     putc

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_058:  pop     rbx
	lea     rdi, [rel str_LC2]
	pop     rbp
	pop     r12
	pop     r13
	pop     r14
	jmp     puts

; Filling space: 0x0C
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00, 0x90

ALIGN   16

plan_from_aur:
	push    r15
	pxor    xmm0, xmm0
	push    r14
	mov     r14, rdi
	push    r13
	push    r12
	push    rbp
	push    rbx
	sub     rsp, 328
	mov     qword [rsp+0x8], rdi
	lea     rbx, [rsp+0x40]
	lea     r15, [rsp+0x30]
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
	movaps  oword [rsp+0x130], xmm0
	mov     qword [rsp+0x20], 0
	mov     qword [rsp+0x28], 0
	call    config_current
	mov     rcx, rbx
	mov     rdx, r15
	mov     rsi, r14
	lea     rdi, [rax+0x14]
	mov     r8d, 256
	call    aur_rpc_info
	test    eax, eax
	jz      loc_059
	cmp     qword [rsp+0x38], 0
	jnz     loc_061
loc_059:  mov     rdi, r15
	xor     r12d, r12d
	call    aur_response_destroy
loc_060:  add     rsp, 328
	mov     eax, r12d
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
loc_061:  call    graph_create
	mov     rbp, rax
	test    rax, rax
	jz      loc_059
	cmp     qword [rsp+0x38], 0
	je      loc_063
	xor     r12d, r12d
	xor     r14d, r14d
	mov     qword [rsp+0x10], r15
	lea     r13, [rel str_LC0]
	mov     qword [rsp+0x18], rbx
	mov     r15, r12
	mov     rbx, r14
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_062:  mov     r14, qword [rsp+0x30]
	mov     ecx, 1
	mov     rdi, rbp
	add     r14, r15
	mov     r12, qword [r14]
	mov     rdx, qword [r14+0x10]
	test    r12, r12
	cmove   r12, qword [rsp+0x8]
	test    rdx, rdx
	cmove   rdx, r13
	mov     rsi, r12
	call    graph_add_package
	mov     rdx, qword [r14+0x10]
	mov     rsi, r12
	lea     rdi, [rel str_LC29]
	test    rdx, rdx
	cmove   rdx, r13
	xor     eax, eax
	add     rbx, 1
	add     r15, 152
	call    printf
	mov     rdx, qword [r14+0x50]
	mov     rsi, qword [r14+0x48]
	lea     rdi, [rel str_LC13]
	call    print_dep_list
	mov     rdx, qword [r14+0x60]
	mov     rsi, qword [r14+0x58]
	lea     rdi, [rel str_LC15]
	call    print_dep_list
	mov     rdx, qword [r14+0x70]
	mov     rsi, qword [r14+0x68]
	lea     rdi, [rel str_LC16]
	call    print_dep_list
	mov     rcx, qword [r14+0x50]
	mov     rdx, qword [r14+0x48]
	mov     rsi, r12
	mov     rdi, rbp
	call    add_dep_nodes
	mov     rcx, qword [r14+0x60]
	mov     rdx, qword [r14+0x58]
	mov     rsi, r12
	mov     rdi, rbp
	call    add_dep_nodes
	mov     rcx, qword [r14+0x70]
	mov     rdx, qword [r14+0x68]
	mov     rsi, r12
	mov     rdi, rbp
	call    add_dep_nodes
	cmp     rbx, qword [rsp+0x38]
	jc      loc_062
	mov     r15, qword [rsp+0x10]
	mov     rbx, qword [rsp+0x18]
loc_063:  lea     rdi, [rel str_LC18]
	xor     eax, eax
	call    printf
	lea     rdx, [rsp+0x28]
	mov     rcx, rbx
	mov     rdi, rbp
	lea     rsi, [rsp+0x20]
	mov     r8d, 256
	call    graph_topological_order
	mov     r12d, eax
	test    eax, eax
	je      loc_069
	xor     ebx, ebx
	cmp     qword [rsp+0x28], 0
	lea     r13, [rel str_LC25]
	lea     r12, [rel str_LC0]
	je      loc_067
	mov     qword [rsp+0x8], r15
; Filling space: 0x0B
; Filler type: Multi-byte NOP
;       db 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00
;       db 0x00, 0x00, 0x00

ALIGN   16
loc_064:  mov     rax, qword [rsp+0x20]
	mov     rdi, rbp
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_name
	mov     rdi, rbp
	mov     r14, rax
	mov     rax, qword [rsp+0x20]
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_version
	mov     rdi, rbp
	mov     r15, rax
	mov     rax, qword [rsp+0x20]
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_source
	lea     r9, [rel str_LC26]
	cmp     eax, 1
	cmove   r9, r13
	test    r15, r15
	jz      loc_065
	cmp     byte [r15], 0
	lea     rcx, [rel str_LC27]
	jnz     loc_066
loc_065:  mov     r15, r12
	mov     rcx, r12
loc_066:  test    r14, r14
	lea     rax, [rel str_LC28]
	mov     r8, r15
	cmove   r14, rax
	add     rbx, 1
	lea     rdi, [rel str_LC30]
	xor     eax, eax
	mov     rsi, rbx
	mov     rdx, r14
	call    printf
	cmp     rbx, qword [rsp+0x28]
	jc      loc_064
	mov     r15, qword [rsp+0x8]
loc_067:  mov     r12d, 1
loc_068:  mov     rdi, qword [rsp+0x20]
	call    free
	mov     rdi, rbp
	call    graph_destroy
	mov     rdi, r15
	call    aur_response_destroy
	jmp     loc_060

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_069:  mov     rdi, qword [rel stderr]
	mov     rdx, rbx
	lea     rsi, [rel str_LC31]
	xor     eax, eax
	call    fprintf
	jmp     loc_068

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

cmd_dependency_plan_v2:; Function begin
	push    rbx
	mov     rbx, rdi
	call    valid_pkgname
	test    eax, eax
	jnz     loc_071
	test    rbx, rbx
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	lea     rsi, [rel str_LC32]
	cmove   rbx, rax
	xor     eax, eax
	mov     rdx, rbx
	call    fprintf
	xor     eax, eax
loc_070:  pop     rbx
	ret

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_071:  mov     rdi, rbx
	call    plan_from_repo
	test    eax, eax
	jnz     loc_072
	mov     rdi, rbx
	call    plan_from_aur
	test    eax, eax
	jz      loc_073
loc_072:  mov     eax, 1
	pop     rbx
	ret

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_073:  mov     rdi, qword [rel stderr]
	mov     rdx, rbx
	lea     rsi, [rel str_LC33]
	call    fprintf
	xor     eax, eax
	jmp     loc_070

SECTION .rodata.str1.1 align=1 noexec

str_LC0:
	db 0x00

str_LC1:
	db 0x72, 0x65, 0x70, 0x6F, 0x00

str_LC2:
	db 0x28, 0x6E, 0x6F, 0x6E, 0x65, 0x29, 0x00

str_LC3:
	db 0x70, 0x61, 0x63, 0x6D, 0x61, 0x6E, 0x20, 0x2D
	db 0x53, 0x69, 0x20, 0x2D, 0x2D, 0x20, 0x25, 0x73
	db 0x00

str_LC4:
	db 0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x00

str_LC5:
	db 0x52, 0x65, 0x70, 0x6F, 0x73, 0x69, 0x74, 0x6F
	db 0x72, 0x79, 0x00

str_LC6:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x20
	db 0x4F, 0x6E, 0x00

str_LC7:
	db 0x4F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C
	db 0x20, 0x44, 0x65, 0x70, 0x73, 0x00

str_LC8:
	db 0x4D, 0x61, 0x6B, 0x65, 0x20, 0x44, 0x65, 0x70
	db 0x73, 0x00

str_LC9:
	db 0x42, 0x75, 0x69, 0x6C, 0x64, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x00

str_LC10:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x20, 0x44, 0x65
	db 0x70, 0x73, 0x00

str_LC12:
	db 0x4E, 0x6F, 0x6E, 0x65, 0x00

str_LC13:
	db 0x44, 0x65, 0x70, 0x65, 0x6E, 0x64, 0x73, 0x3A
	db 0x00

str_LC14:
	db 0x20, 0x20, 0x25, 0x2D, 0x31, 0x34, 0x73, 0x25
	db 0x73, 0x0A, 0x00

str_LC15:
	db 0x4D, 0x61, 0x6B, 0x65, 0x44, 0x65, 0x70, 0x65
	db 0x6E, 0x64, 0x73, 0x3A, 0x00

str_LC16:
	db 0x43, 0x68, 0x65, 0x63, 0x6B, 0x44, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x73, 0x3A, 0x00

str_LC17:
	db 0x4F, 0x70, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C
	db 0x3A, 0x00

str_LC19:
	db 0x20, 0x09, 0x00

str_LC20:
	db 0x20, 0x20, 0x25, 0x7A, 0x75, 0x2E, 0x20, 0x25
	db 0x73, 0x0A, 0x00

str_LC21:
	db 0x20, 0x20, 0x31, 0x2E, 0x20, 0x25, 0x73, 0x0A
	db 0x00

str_LC22:
	db 0x20, 0x20, 0x00

str_LC23:
	db 0x20, 0x20, 0x25, 0x2D, 0x31, 0x34, 0x73, 0x00

str_LC24:
	db 0x25, 0x73, 0x25, 0x73, 0x00

str_LC25:
	db 0x61, 0x75, 0x72, 0x00

str_LC26:
	db 0x72, 0x65, 0x70, 0x6F, 0x2F, 0x64, 0x65, 0x70
	db 0x00

str_LC27:
	db 0x20, 0x00

str_LC28:
	db 0x3F, 0x00

str_LC30:
	db 0x20, 0x20, 0x25, 0x7A, 0x75, 0x2E, 0x20, 0x25
	db 0x73, 0x25, 0x73, 0x25, 0x73, 0x20, 0x20, 0x5B
	db 0x25, 0x73, 0x5D, 0x0A, 0x00

str_LC31:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x25, 0x73, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00

SECTION .rodata.str1.8 align=8 noexec

str_LC11:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x50
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x3A, 0x20
	db 0x25, 0x73, 0x20, 0x25, 0x73, 0x20, 0x28, 0x25
	db 0x73, 0x29, 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00

str_LC18:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x49
	db 0x6E, 0x73, 0x74, 0x61, 0x6C, 0x6C, 0x20, 0x6F
	db 0x72, 0x64, 0x65, 0x72, 0x20, 0x28, 0x64, 0x65
	db 0x70, 0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x79
	db 0x2D, 0x66, 0x69, 0x72, 0x73, 0x74, 0x29, 0x3A
	db 0x0A, 0x1B, 0x5B, 0x30, 0x6D, 0x00, 0x00, 0x00

str_LC29:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x36, 0x6D, 0x50
	db 0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x3A, 0x20
	db 0x25, 0x73, 0x20, 0x25, 0x73, 0x20, 0x28, 0x61
	db 0x75, 0x72, 0x29, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC32:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x49, 0x6E, 0x76, 0x61, 0x6C
	db 0x69, 0x64, 0x20, 0x70, 0x61, 0x63, 0x6B, 0x61
	db 0x67, 0x65, 0x20, 0x6E, 0x61, 0x6D, 0x65, 0x3A
	db 0x20, 0x27, 0x25, 0x73, 0x27, 0x0A, 0x1B, 0x5B
	db 0x30, 0x6D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

str_LC33:
	db 0x1B, 0x5B, 0x31, 0x3B, 0x33, 0x31, 0x6D, 0x5B
	db 0x2D, 0x5D, 0x20, 0x43, 0x6F, 0x75, 0x6C, 0x64
	db 0x20, 0x6E, 0x6F, 0x74, 0x20, 0x72, 0x65, 0x73
	db 0x6F, 0x6C, 0x76, 0x65, 0x20, 0x64, 0x65, 0x70
	db 0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x69, 0x65
	db 0x73, 0x20, 0x66, 0x6F, 0x72, 0x20, 0x27, 0x25
	db 0x73, 0x27, 0x2E, 0x0A, 0x1B, 0x5B, 0x30, 0x6D
	db 0x00

