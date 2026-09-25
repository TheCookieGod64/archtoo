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
extern __stack_chk_fail
extern graph_add_package
extern graph_add_dependency
extern graph_has_package
extern valid_pkgname
extern dep_basename

SECTION .text   align=32 exec

add_dep_nodes:
	sub     rsp, 216
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x0A8], rax
	xor     eax, eax
	test    rcx, rcx
	je      loc_004
	mov     qword [rsp+0x0B0], rbx
	xor     ebx, ebx
	mov     qword [rsp+0x0B8], rbp
	mov     rbp, rcx
	mov     qword [rsp+0x0C0], r12
	mov     r12, rdx
	mov     qword [rsp+0x0C8], r13
	mov     r13, rdi
	mov     qword [rsp+0x0D0], r14
	mov     r14, rsi
; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_001:  mov     rdi, qword [r12+rbx*8]
	mov     edx, 160
	mov     rsi, rsp
	call    dep_basename
	cmp     byte [rsp], 0
	jz      loc_003
	mov     rdi, rsp
	call    valid_pkgname
	test    eax, eax
	jz      loc_003
	mov     rsi, rsp
	mov     rdi, r13
	call    graph_has_package
	test    eax, eax
	jz      loc_005
loc_002:  mov     rdx, rsp
	mov     rsi, r14
	mov     rdi, r13
	call    graph_add_dependency
loc_003:  add     rbx, 1
	cmp     rbp, rbx
	jnz     loc_001
	mov     rbx, qword [rsp+0x0B0]
	mov     rbp, qword [rsp+0x0B8]
	mov     r12, qword [rsp+0x0C0]
	mov     r13, qword [rsp+0x0C8]
	mov     r14, qword [rsp+0x0D0]
loc_004:  mov     rax, qword [rsp+0x0A8]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jnz     loc_006
	add     rsp, 216
	ret

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_005:  xor     ecx, ecx
	lea     rdx, [rel str_LC0]
	mov     rsi, rsp
	mov     rdi, r13
	call    graph_add_package
	jmp     loc_002

loc_006:
	mov     qword [rsp+0x0B0], rbx
	mov     qword [rsp+0x0B8], rbp
	mov     qword [rsp+0x0C0], r12
	mov     qword [rsp+0x0C8], r13
	mov     qword [rsp+0x0D0], r14
	call    __stack_chk_fail
; Filling space: 0x0D
; Filler type: NOP with prefixes
;       db 0x66, 0x90, 0x66, 0x66, 0x2E, 0x0F, 0x1F, 0x84
;       db 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
plan_from_repo:
	sub     rsp, 1384
	mov     edx, 320
	mov     qword [rsp+0x18], rdi
	lea     rsi, [rsp+0x1E0]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x528], rax
	xor     eax, eax
	mov     qword [rsp+0x20], 0
	call    shell_quote
	test    eax, eax
	jnz     loc_008
loc_007:  mov     rdx, qword [rsp+0x528]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rdx, qword [fs:abs 0x28]
	jne     loc_058
	add     rsp, 1384
	ret

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_008:  lea     rcx, [rsp+0x1E0]
	mov     esi, 512
	xor     eax, eax
	mov     qword [rsp+0x538], rbx
	lea     rdx, [rel str_LC3]
	lea     rdi, [rsp+0x320]
	call    xsnprintf
	lea     rsi, [rsp+0x20]
	lea     rdi, [rsp+0x320]
	call    run_cmd_capture
	mov     rbx, qword [rsp+0x20]
	test    eax, eax
	jne     loc_042
	test    rbx, rbx
	je      loc_042
	cmp     byte [rbx], 0
	je      loc_042
	mov     qword [rsp+0x540], rbp
	xor     ebp, ebp
	mov     qword [rsp+0x548], r12
	xor     r12d, r12d
	mov     qword [rsp+0x550], r13
	xor     r13d, r13d
	mov     qword [rsp+0x558], r14
	xor     r14d, r14d
	mov     qword [rsp+0x560], r15
	mov     qword [rsp], 0
	mov     qword [rsp+0x8], 0
	jmp     loc_012

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_009:  lea     rbp, [rcx+0x1]
loc_010:  test    r15, r15
	je      loc_015
loc_011:  lea     rbx, [r15+0x1]
	cmp     byte [r15+0x1], 0
	je      loc_015
loc_012:  mov     esi, 10
	mov     rdi, rbx
	call    strchr
	mov     r15, rax
	test    rax, rax
	jz      loc_014
	mov     byte [rax], 0
	mov     esi, 58
	mov     rdi, rbx
	call    strchr
	mov     rcx, rax
	test    rax, rax
	jz      loc_011
loc_013:  mov     byte [rcx], 0
	mov     edx, 7
	lea     rsi, [rel str_LC4]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jz      loc_009
	mov     edx, 10
	lea     rsi, [rel str_LC5]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jne     loc_041
	lea     r12, [rcx+0x1]
	jmp     loc_010

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_014:  mov     esi, 58
	mov     rdi, rbx
	call    strchr
	mov     rcx, rax
	test    rax, rax
	jnz     loc_013
loc_015:  test    rbp, rbp
	jz      loc_018
	movzx   eax, byte [rbp]
	cmp     al, 32
	jnz     loc_017
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_016:  movzx   eax, byte [rbp+0x1]
	add     rbp, 1
	cmp     al, 32
	jz      loc_016
loc_017:  cmp     al, 9
	jz      loc_016
loc_018:  test    r12, r12
	jz      loc_020
	movzx   eax, byte [r12]
	cmp     al, 9
	jz      loc_019
	cmp     al, 32
	jnz     loc_020
; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_019:  movzx   eax, byte [r12+0x1]
	add     r12, 1
	cmp     al, 32
	jz      loc_019
	cmp     al, 9
	jz      loc_019
loc_020:  mov     rax, qword [rsp+0x8]
	test    rax, rax
	jnz     loc_022
	jmp     loc_023

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_021:  add     qword [rsp+0x8], 1
	mov     rax, qword [rsp+0x8]
loc_022:  movzx   eax, byte [rax]
	cmp     al, 32
	jz      loc_021
	cmp     al, 9
	jz      loc_021
loc_023:  test    r13, r13
	jnz     loc_025
	jmp     loc_026

; Filling space: 0x3
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00

ALIGN   8
loc_024:  add     r13, 1
loc_025:  movzx   eax, byte [r13]
	cmp     al, 32
	jz      loc_024
	cmp     al, 9
	jz      loc_024
loc_026:  test    r14, r14
	jnz     loc_028
	jmp     loc_029

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_027:  add     r14, 1
loc_028:  movzx   eax, byte [r14]
	cmp     al, 32
	jz      loc_027
	cmp     al, 9
	jz      loc_027
loc_029:  mov     rax, qword [rsp]
	test    rax, rax
	jnz     loc_031
	jmp     loc_032

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_030:  add     qword [rsp], 1
	mov     rax, qword [rsp]
loc_031:  movzx   eax, byte [rax]
	cmp     al, 32
	jz      loc_030
	cmp     al, 9
	jz      loc_030
loc_032:  test    r12, r12
	je      loc_055
	cmp     byte [r12], 0
	lea     rax, [rel str_LC1]
	cmove   r12, rax
loc_033:  test    rbp, rbp
	lea     rax, [rel str_LC0]
	mov     rsi, qword [rsp+0x18]
	mov     rcx, r12
	cmove   rbp, rax
	lea     rdi, [rel str_LC11]
	xor     eax, eax
	mov     rdx, rbp
	call    printf
	cmp     qword [rsp+0x8], 0
	je      loc_052
	mov     rbx, qword [rsp+0x8]
	cmp     byte [rbx], 0
	je      loc_052
	lea     rsi, [rel str_LC12]
	mov     rdi, rbx
	call    strcmp
	lea     rdx, [rel str_LC2]
	test    eax, eax
	cmovne  rdx, rbx
loc_034:  lea     rsi, [rel str_LC13]
	lea     rdi, [rel str_LC14]
	xor     eax, eax
	call    printf
	test    r14, r14
	je      loc_051
	cmp     byte [r14], 0
	je      loc_051
	mov     rdi, r14
	lea     rsi, [rel str_LC12]
	call    strcmp
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmove   r14, rax
loc_035:  xor     eax, eax
	mov     rdx, r14
	lea     rsi, [rel str_LC15]
	lea     rdi, [rel str_LC14]
	call    printf
	cmp     qword [rsp], 0
	je      loc_050
	mov     rbx, qword [rsp]
	cmp     byte [rbx], 0
	je      loc_050
	lea     rsi, [rel str_LC12]
	mov     rdi, rbx
	call    strcmp
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmovne  rax, rbx
	mov     qword [rsp], rax
loc_036:  mov     rdx, qword [rsp]
	xor     eax, eax
	lea     rsi, [rel str_LC16]
	lea     rdi, [rel str_LC14]
	call    printf
	test    r13, r13
	je      loc_049
	cmp     byte [r13], 0
	je      loc_049
	mov     rdi, r13
	lea     rsi, [rel str_LC12]
	call    strcmp
	test    eax, eax
	lea     rax, [rel str_LC2]
	cmove   r13, rax
loc_037:  mov     rdx, r13
	lea     rsi, [rel str_LC17]
	xor     eax, eax
	lea     rdi, [rel str_LC14]
	call    printf
	lea     rdi, [rel str_LC18]
	xor     eax, eax
	call    printf
	call    graph_create
	pxor    xmm0, xmm0
	mov     qword [rsp+0x28], 0
	mov     qword [rsp+0x30], 0
	mov     r12, rax
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
	mov     rsi, qword [rsp+0x18]
	xor     ecx, ecx
	mov     rdx, rbp
	mov     rdi, rax
	call    graph_add_package
	mov     rax, qword [rsp+0x8]
	test    rax, rax
	je      loc_045
	cmp     byte [rax], 0
	je      loc_045
	lea     rsi, [rel str_LC12]
	mov     rdi, rax
	call    strcmp
	test    eax, eax
	je      loc_045
	mov     rdi, qword [rsp+0x8]
	call    strdup
	mov     qword [rsp+0x38], 0
	mov     rbx, rax
	test    rax, rax
	je      loc_045
	mov     rdi, rax
	lea     rdx, [rsp+0x38]
	lea     rsi, [rel str_LC19]
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	jnz     loc_039
	jmp     loc_044

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_038:  xor     edi, edi
	lea     rdx, [rsp+0x38]
	lea     rsi, [rel str_LC19]
	call    strtok_r
	mov     rdi, rax
	test    rax, rax
	je      loc_044
loc_039:  mov     edx, 160
	lea     rsi, [rsp+0x40]
	call    dep_basename
	cmp     byte [rsp+0x40], 0
	jz      loc_038
	lea     rdi, [rsp+0x40]
	call    valid_pkgname
	test    eax, eax
	jz      loc_038
	lea     rsi, [rsp+0x40]
	mov     rdi, r12
	call    graph_has_package
	test    eax, eax
	je      loc_057
loc_040:  mov     rsi, qword [rsp+0x18]
	lea     rdx, [rsp+0x40]
	mov     rdi, r12
	call    graph_add_dependency
	jmp     loc_038

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_041:  mov     edx, 10
	lea     rsi, [rel str_LC6]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jz      loc_043
	mov     edx, 13
	lea     rsi, [rel str_LC7]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jne     loc_053
	lea     r13, [rcx+0x1]
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_042:  mov     rdi, rbx
	call    free
	mov     rbx, qword [rsp+0x538]
	xor     eax, eax
	jmp     loc_007

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_043:  lea     rax, [rcx+0x1]
	mov     qword [rsp+0x8], rax
	jmp     loc_010

loc_044:  mov     rdi, rbx
	call    free
; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_045:  lea     rcx, [rsp+0x0E0]
	lea     rdx, [rsp+0x30]
	mov     r8d, 256
	mov     rdi, r12
	lea     rsi, [rsp+0x28]
	call    graph_topological_order
	test    eax, eax
	je      loc_056
	cmp     qword [rsp+0x30], 0
	jz      loc_047
	xor     ebx, ebx
; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_046:  mov     rax, qword [rsp+0x28]
	mov     rdi, r12
	mov     rsi, qword [rax+rbx*8]
	add     rbx, 1
	call    graph_package_name
	mov     rsi, rbx
	lea     rdi, [rel str_LC20]
	mov     rdx, rax
	xor     eax, eax
	call    printf
	cmp     rbx, qword [rsp+0x30]
	jc      loc_046
loc_047:  mov     rdi, qword [rsp+0x28]
	call    free
	mov     rdi, r12
	call    graph_destroy
loc_048:  mov     rdi, qword [rsp+0x20]
	call    free
	mov     rbx, qword [rsp+0x538]
	mov     rbp, qword [rsp+0x540]
	mov     eax, 1
	mov     r12, qword [rsp+0x548]
	mov     r13, qword [rsp+0x550]
	mov     r14, qword [rsp+0x558]
	mov     r15, qword [rsp+0x560]
	jmp     loc_007

; Filling space: 0x0A
; Filler type: Multi-byte NOP
;       db 0x66, 0x2E, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00
;       db 0x00, 0x00

ALIGN   16
loc_049:  lea     r13, [rel str_LC2]
	jmp     loc_037

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_050:  lea     rax, [rel str_LC2]
	mov     qword [rsp], rax
	jmp     loc_036

loc_051:  lea     r14, [rel str_LC2]
	jmp     loc_035

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_052:  lea     rdx, [rel str_LC2]
	jmp     loc_034

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_053:  mov     edx, 9
	lea     rsi, [rel str_LC8]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jz      loc_054
	mov     edx, 10
	lea     rsi, [rel str_LC9]
	mov     rdi, rbx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	test    eax, eax
	jz      loc_054
	mov     edx, 10
	lea     rsi, [rel str_LC10]
	mov     rdi, rbx
	mov     qword [rsp+0x10], rcx
	call    strncmp
	mov     rcx, qword [rsp+0x10]
	add     rcx, 1
	test    eax, eax
	cmovne  rcx, qword [rsp]
	mov     qword [rsp], rcx
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_054:  lea     r14, [rcx+0x1]
	jmp     loc_010

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_055:  lea     r12, [rel str_LC1]
	jmp     loc_033

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_056:  mov     rsi, qword [rsp+0x18]
	lea     rdi, [rel str_LC21]
	xor     eax, eax
	call    printf
	jmp     loc_047

loc_057:  xor     ecx, ecx
	lea     rdx, [rel str_LC0]
	lea     rsi, [rsp+0x40]
	mov     rdi, r12
	call    graph_add_package
	jmp     loc_040

loc_058:
	mov     qword [rsp+0x538], rbx
	mov     qword [rsp+0x540], rbp
	mov     qword [rsp+0x548], r12
	mov     qword [rsp+0x550], r13
	mov     qword [rsp+0x558], r14
	mov     qword [rsp+0x560], r15
	call    __stack_chk_fail
print_dep_list:
	sub     rsp, 40
	xor     eax, eax
	mov     qword [rsp+0x10], rbp
	mov     rbp, rdx
	mov     qword [rsp+0x18], r12
	mov     r12, rsi
	mov     rsi, rdi
	lea     rdi, [rel str_LC23]
	call    printf
	test    rbp, rbp
	jz      loc_061
	mov     qword [rsp+0x8], rbx
	mov     rdx, qword [r12]
	xor     ebx, ebx
	lea     rsi, [rel str_LC0]
	mov     qword [rsp+0x20], r13
	lea     r13, [rel str_LC22]
	jmp     loc_060

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_059:  mov     rdx, qword [r12+rbx*8]
	mov     rsi, r13
loc_060:  lea     rdi, [rel str_LC24]
	xor     eax, eax
	add     rbx, 1
	call    printf
	cmp     rbp, rbx
	jnz     loc_059
	mov     rbx, qword [rsp+0x8]
	mov     r13, qword [rsp+0x20]
	mov     edi, 10
	mov     rsi, qword [rel stdout]
	mov     rbp, qword [rsp+0x10]
	mov     r12, qword [rsp+0x18]
	add     rsp, 40
	jmp     putc

; Filling space: 0x9
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00
;       db 0x00

ALIGN   16
loc_061:  mov     rbp, qword [rsp+0x10]
	mov     r12, qword [rsp+0x18]
	lea     rdi, [rel str_LC2]
	add     rsp, 40
	jmp     puts

; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

plan_from_aur:
	sub     rsp, 376
	pxor    xmm0, xmm0
	mov     qword [rsp+0x148], rbx
	mov     rbx, rdi
	mov     qword [rsp+0x8], rdi
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	mov     rax, qword [fs:abs 0x28]
	mov     qword [rsp+0x138], rax
	xor     eax, eax
	movaps  oword [rsp+0x20], xmm0
	mov     qword [rsp+0x10], 0
	mov     qword [rsp+0x18], 0
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
	mov     r8d, 256
	lea     rcx, [rsp+0x30]
	mov     rsi, rbx
	lea     rdi, [rax+0x14]
	lea     rdx, [rsp+0x20]
	call    aur_rpc_info
	test    eax, eax
	jz      loc_062
	cmp     qword [rsp+0x28], 0
	jnz     loc_064
loc_062:  lea     rdi, [rsp+0x20]
	xor     ebx, ebx
	call    aur_response_destroy
loc_063:  mov     rax, qword [rsp+0x138]
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
	sub     rax, qword [fs:abs 0x28]
	jne     loc_074
	mov     eax, ebx
	mov     rbx, qword [rsp+0x148]
	add     rsp, 376
	ret

; Filling space: 0x8
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_064:  mov     qword [rsp+0x158], r12
	call    graph_create
	mov     r12, rax
	test    rax, rax
	je      loc_073
	mov     qword [rsp+0x150], rbp
	mov     qword [rsp+0x160], r13
	mov     qword [rsp+0x168], r14
	mov     qword [rsp+0x170], r15
	cmp     qword [rsp+0x28], 0
	je      loc_066
	xor     r14d, r14d
	xor     r15d, r15d
	lea     r13, [rel str_LC0]
; Filling space: 0x0E
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x00, 0x66, 0x66, 0x2E, 0x0F, 0x1F
;       db 0x84, 0x00, 0x00, 0x00, 0x00, 0x00

ALIGN   16
loc_065:  mov     rbx, qword [rsp+0x20]
	mov     ecx, 1
	mov     rdi, r12
	add     rbx, r14
	mov     rbp, qword [rbx]
	mov     rdx, qword [rbx+0x10]
	test    rbp, rbp
	cmove   rbp, qword [rsp+0x8]
	test    rdx, rdx
	cmove   rdx, r13
	mov     rsi, rbp
	call    graph_add_package
	mov     rdx, qword [rbx+0x10]
	mov     rsi, rbp
	lea     rdi, [rel str_LC29]
	test    rdx, rdx
	cmove   rdx, r13
	xor     eax, eax
	add     r15, 1
	add     r14, 152
	call    printf
	mov     rdx, qword [rbx+0x50]
	mov     rsi, qword [rbx+0x48]
	lea     rdi, [rel str_LC13]
	call    print_dep_list
	mov     rdx, qword [rbx+0x60]
	mov     rsi, qword [rbx+0x58]
	lea     rdi, [rel str_LC15]
	call    print_dep_list
	mov     rdx, qword [rbx+0x70]
	mov     rsi, qword [rbx+0x68]
	lea     rdi, [rel str_LC16]
	call    print_dep_list
	mov     rcx, qword [rbx+0x50]
	mov     rdx, qword [rbx+0x48]
	mov     rsi, rbp
	mov     rdi, r12
	call    add_dep_nodes
	mov     rcx, qword [rbx+0x60]
	mov     rdx, qword [rbx+0x58]
	mov     rsi, rbp
	mov     rdi, r12
	call    add_dep_nodes
	mov     rcx, qword [rbx+0x70]
	mov     rdx, qword [rbx+0x68]
	mov     rsi, rbp
	mov     rdi, r12
	call    add_dep_nodes
	cmp     r15, qword [rsp+0x28]
	jc      loc_065
loc_066:  lea     rdi, [rel str_LC18]
	xor     eax, eax
	call    printf
	lea     rdx, [rsp+0x18]
	lea     rsi, [rsp+0x10]
	mov     rdi, r12
	mov     r8d, 256
	lea     rcx, [rsp+0x30]
	call    graph_topological_order
	mov     ebx, eax
	test    eax, eax
	je      loc_072
	xor     ebx, ebx
	cmp     qword [rsp+0x18], 0
	je      loc_070
	lea     r15, [rel str_LC25]
	lea     r13, [rel str_LC0]
	jmp     loc_069

; Filling space: 0x7
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x80, 0x00, 0x00, 0x00, 0x00

ALIGN   8
loc_067:  cmp     byte [rbp], 0
	lea     rcx, [rel str_LC27]
	mov     r8, rbp
	cmove   rcx, r13
	cmove   r8, r13
loc_068:  lea     rdx, [rel str_LC28]
	test    r14, r14
	cmovne  rdx, r14
	add     rbx, 1
	lea     rdi, [rel str_LC30]
	xor     eax, eax
	mov     rsi, rbx
	call    printf
	cmp     rbx, qword [rsp+0x18]
	jnc     loc_070
loc_069:  mov     rax, qword [rsp+0x10]
	mov     rdi, r12
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_name
	mov     rdi, r12
	mov     r14, rax
	mov     rax, qword [rsp+0x10]
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_version
	mov     rdi, r12
	mov     rbp, rax
	mov     rax, qword [rsp+0x10]
	mov     rsi, qword [rax+rbx*8]
	call    graph_package_source
	lea     r9, [rel str_LC26]
	cmp     eax, 1
	cmove   r9, r15
	test    rbp, rbp
	jne     loc_067
	mov     r8, r13
	lea     rcx, [rel str_LC0]
	jmp     loc_068

; Filling space: 0x1
; Filler type: NOP
;       db 0x90

ALIGN   8
loc_070:  mov     ebx, 1
loc_071:  mov     rdi, qword [rsp+0x10]
	call    free
	mov     rdi, r12
	call    graph_destroy
	lea     rdi, [rsp+0x20]
	call    aur_response_destroy
	mov     rbp, qword [rsp+0x150]
	mov     r12, qword [rsp+0x158]
	mov     r13, qword [rsp+0x160]
	mov     r14, qword [rsp+0x168]
	mov     r15, qword [rsp+0x170]
	jmp     loc_063

; Filling space: 0x2
; Filler type: NOP with prefixes
;       db 0x66, 0x90

ALIGN   8
loc_072:  mov     rdi, qword [rel stderr]
	lea     rdx, [rsp+0x30]
	lea     rsi, [rel str_LC31]
	xor     eax, eax
	call    fprintf
	jmp     loc_071

; Filling space: 0x4
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x40, 0x00

ALIGN   8
loc_073:  mov     r12, qword [rsp+0x158]
	jmp     loc_062

loc_074:
	mov     qword [rsp+0x150], rbp
	mov     qword [rsp+0x158], r12
	mov     qword [rsp+0x160], r13
	mov     qword [rsp+0x168], r14
	mov     qword [rsp+0x170], r15
	call    __stack_chk_fail
; Filling space: 0x6
; Filler type: Multi-byte NOP
;       db 0x66, 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8

cmd_dependency_plan_v2:
	push    rbp
	mov     rbp, rdi
	push    rbx
	sub     rsp, 8
	call    valid_pkgname
	test    eax, eax
	jnz     loc_076
	test    rbp, rbp
	mov     ebx, eax
	lea     rax, [rel str_LC0]
	mov     rdi, qword [rel stderr]
	cmovne  rax, rbp
	lea     rsi, [rel str_LC32]
	mov     rdx, rax
	xor     eax, eax
	call    fprintf
loc_075:  add     rsp, 8
	mov     eax, ebx
	pop     rbx
	pop     rbp
	ret

; Filling space: 0x5
; Filler type: Multi-byte NOP
;       db 0x0F, 0x1F, 0x44, 0x00, 0x00

ALIGN   8
loc_076:  mov     rdi, rbp
	call    plan_from_repo
	mov     ebx, eax
	test    eax, eax
	jnz     loc_075
	mov     rdi, rbp
	call    plan_from_aur
	mov     ebx, eax
	test    eax, eax
	jnz     loc_075
	mov     rdi, qword [rel stderr]
	mov     rdx, rbp
	lea     rsi, [rel str_LC33]
	xor     eax, eax
	call    fprintf
	add     rsp, 8
	mov     eax, ebx
	pop     rbx
	pop     rbp
	ret

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

