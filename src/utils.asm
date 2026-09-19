; utils.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

extern __errno_location
extern _exit
extern calloc
extern close
extern dup2
extern exit
extern fork
extern fprintf
extern free
extern fwrite
extern getpid
extern malloc
extern memcpy
extern open
extern pipe
extern printf
extern puts
extern read
extern realloc
extern sigaction
extern sigemptyset
extern stat
extern stderr
extern stdout
extern strchr
extern strcmp
extern strerror
extern strlen
extern strstr
extern unlink
extern waitpid
extern write
; NASM assembly - converted from C: src/utils.c
%use smartalign
section .text
global set_noconfirm
set_noconfirm:
	mov	dword [rel g_noconfirm], edi
	ret
global get_noconfirm
get_noconfirm:
	mov	eax, dword [rel g_noconfirm]
	ret
global set_emerge_confirm
set_emerge_confirm:
	mov	dword [rel g_emerge_confirm], edi
	ret
global get_emerge_confirm
get_emerge_confirm:
	mov	eax, dword [rel g_emerge_confirm]
	ret
global set_interactive
set_interactive:
	mov	dword [rel g_interactive], edi
	ret
global get_interactive
get_interactive:
	mov	eax, dword [rel g_interactive]
	ret
global use_noconfirm
use_noconfirm:
	mov	ecx, dword [rel g_noconfirm]
	mov	eax, 1
	test	ecx, ecx
	jne	.L8
	mov	edx, dword [rel g_interactive]
	xor	eax, eax
	test	edx, edx
	sete	al
.L8:
	ret
global set_prompt_timeout
set_prompt_timeout:
	mov	qword [rel g_prompt_timeout], rdi
	ret
global get_prompt_timeout
get_prompt_timeout:
	mov	rax, qword [rel g_prompt_timeout]
	ret
global set_resume
set_resume:
	mov	dword [rel g_resume], edi
	ret
global get_resume
get_resume:
	mov	eax, dword [rel g_resume]
	ret
global set_import_keys
set_import_keys:
	mov	dword [rel g_import_keys], edi
	ret
global get_import_keys
get_import_keys:
	mov	eax, dword [rel g_import_keys]
	ret
global set_inhibit
set_inhibit:
	mov	dword [rel g_inhibit], edi
	ret
global get_inhibit
get_inhibit:
	mov	eax, dword [rel g_inhibit]
	ret
global set_sync
set_sync:
	mov	dword [rel g_sync], edi
	ret
global get_sync
get_sync:
	mov	eax, dword [rel g_sync]
	ret
global set_aur_sync
set_aur_sync:
	mov	dword [rel g_aur_sync], edi
	ret
global get_aur_sync
get_aur_sync:
	mov	eax, dword [rel g_aur_sync]
	ret
global set_jobs
set_jobs:
	mov	qword [rel g_jobs], rdi
	ret
global get_jobs
get_jobs:
	mov	rax, qword [rel g_jobs]
	test	rax, rax
	jle	.L30
	ret
.L30:
	sub	rsp, 8
	mov	edi, 84
	call	sysconf
	mov	edx, 1
	test	rax, rax
	cmovle	rax, rdx
	add	rsp, 8
	ret
section .rodata
LC0:
	db "help", 0
LC1:
	db "list", 0
global valid_target_arch
valid_target_arch:
	push	r12
	push	rbp
	push	rbx
	test	rdi, rdi
	je	.L42
	movzx	ebp, byte [rdi]
	mov	rbx, rdi
	xor	r12d, r12d
	test	bpl, bpl
	je	.L31
	call	strlen
	sub	rax, 1
	cmp	rax, 63
	ja	.L31
	mov	esi, LC0
	mov	rdi, rbx
	mov	r12d, 1
	call	strcmp
	test	eax, eax
	je	.L31
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L31
	call	__ctype_b_loc
	xor	r12d, r12d
	mov	rdx, qword [rax]
	movzx	eax, word [rdx+rbp*2]
	test	al, 8
	je	.L31
.L33:
	movzx	ebp, byte [rbx+1]
	add	rbx, 1
	test	bpl, bpl
	je	.L43
	movzx	eax, bpl
	movzx	eax, word [rdx+rax*2]
	test	al, 8
	jne	.L33
	lea	eax, [rbp-45]
	cmp	al, 1
	jbe	.L33
	cmp	bpl, 95
	je	.L33
.L42:
	xor	r12d, r12d
.L31:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L43:
	mov	r12d, 1
	jmp	.L31
global get_target_arch
get_target_arch:
	mov	eax, g_target_arch
	ret
section .rodata
LC2:
	db "\033[1;36mKnown --target values (common x86-64 -march):\n\033[0m", 0
LC3:
	db "  native (default, detects host CPU)", 0
LC4:
	db "  x86-64, x86-64-v2, x86-64-v3, x86-64-v4, generic", 0
section .rodata
LC5:
	db "\n\033[1;36mIntel:\n\033[0m", 0
section .rodata
LC6:
	db "  bonnell, atom, silvermont, goldmont, goldmont-plus, tremont", 0
LC7:
	db "  core2, nehalem, westmere, sandybridge, ivybridge", 0
LC8:
	db "  haswell, broadwell, skylake, skylake-avx512, cannonlake", 0
LC9:
	db "  icelake-client, icelake-server, cascadelake, tigerlake", 0
LC10:
	db "  sapphirerapids, alderlake, raptorlake, meteorlake, arrowlake", 0
LC11:
	db "  lunarlake, emeraldrapids, graniterapids", 0
section .rodata
LC12:
	db "\n\033[1;36mAMD:\n\033[0m", 0
section .rodata
LC13:
	db "  k8, athlon64, amdfam10, bdver1, bdver2, bdver3, bdver4", 0
LC14:
	db "  znver1, znver2, znver3, znver4, znver5", 0
section .rodata
LC15:
	db "  btver1, btver2", 0
LC16:
	db "\nExamples:", 0
section .rodata
LC17:
	db "  emerge --target=skylake htop", 0
LC18:
	db "  emerge --target=znver3 firefox", 0
LC19:
	db "  emerge --target=x86-64-v3 --jobs 4 linux-zen", 0
LC20:
	db "  emerge --target=native -U   (explicit default)", 0
global print_known_targets
print_known_targets:
	sub	rsp, 8
	mov	edi, LC2
	xor	eax, eax
	call	printf
	mov	edi, LC3
	call	puts
	mov	edi, LC4
	call	puts
	mov	edi, LC5
	xor	eax, eax
	call	printf
	mov	edi, LC6
	call	puts
	mov	edi, LC7
	call	puts
	mov	edi, LC8
	call	puts
	mov	edi, LC9
	call	puts
	mov	edi, LC10
	call	puts
	mov	edi, LC11
	call	puts
	mov	edi, LC12
	xor	eax, eax
	call	printf
	mov	edi, LC13
	call	puts
	mov	edi, LC14
	call	puts
	mov	edi, LC15
	call	puts
	mov	edi, LC16
	call	puts
	mov	edi, LC17
	call	puts
	mov	edi, LC18
	call	puts
	mov	edi, LC19
	call	puts
	mov	edi, LC20
	add	rsp, 8
	jmp	puts
section .rodata
LC21:
	db "fast", 0
global valid_opt_level
valid_opt_level:
	push	r12
	push	rbp
	push	rbx
	test	rdi, rdi
	je	.L69
	movzx	r12d, byte [rdi]
	mov	rbx, rdi
	xor	ebp, ebp
	test	r12b, r12b
	je	.L56
	mov	esi, LC0
	mov	ebp, 1
	call	strcmp
	test	eax, eax
	je	.L56
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L56
	cmp	r12b, 45
	je	.L103
	and	r12d, -33
	cmp	r12b, 79
	jne	.L68
.L67:
	movzx	eax, byte [rbx+1]
	add	rbx, 1
.L59:
	xor	ebp, ebp
	test	al, al
	je	.L56
.L68:
	movzx	r12d, byte [rbx]
	cmp	r12d, 48
	jne	.L82
	cmp	byte [rbx+1], 0
	mov	ebp, 1
	jne	.L82
.L56:
	mov	eax, ebp
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L103:
	movzx	eax, byte [rbx+1]
	add	rbx, 1
	mov	edx, eax
	and	edx, -33
	cmp	dl, 79
	je	.L67
	jmp	.L59
.L82:
	cmp	r12d, 49
	jne	.L83
	cmp	byte [rbx+1], 0
	mov	ebp, 1
	je	.L56
.L83:
	cmp	r12d, 50
	je	.L104
.L84:
	cmp	r12d, 51
	jne	.L85
	cmp	byte [rbx+1], 0
	mov	ebp, 1
	je	.L56
.L85:
	cmp	r12d, 115
	jne	.L86
	cmp	byte [rbx+1], 0
	mov	ebp, 1
	je	.L56
.L86:
	mov	esi, LC21
	mov	rdi, rbx
	mov	ebp, 1
	call	strcmp
	test	eax, eax
	je	.L56
	cmp	r12d, 103
	jne	.L87
	cmp	byte [rbx+1], 0
	je	.L56
.L87:
	sub	r12d, 122
	jne	.L66
	movzx	r12d, byte [rbx+1]
.L66:
	xor	ebp, ebp
	test	r12d, r12d
	sete	bpl
	jmp	.L56
.L69:
	xor	ebp, ebp
	pop	rbx
	mov	eax, ebp
	pop	rbp
	pop	r12
	ret
.L104:
	cmp	byte [rbx+1], 0
	mov	ebp, 1
	je	.L56
	jmp	.L84
global get_opt_level
get_opt_level:
	mov	eax, g_opt_level
	ret
section .rodata
LC22:
	db "\033[1;36mKnown --opt-level values:\n\033[0m", 0
LC23:
	db "  0      -O0 no optimization (debug)", 0
section .rodata
LC24:
	db "  1      -O1 basic", 0
section .rodata
LC25:
	db "  2      -O2 balanced (Arch default, good for low RAM)", 0
LC26:
	db "  3      -O3 aggressive (archtoo default)", 0
LC27:
	db "  s      -Os optimize for size", 0
LC28:
	db "  z      -Oz even more size (clang)", 0
LC29:
	db "  fast   -Ofast break standards, max speed", 0
section .rodata
LC30:
	db "  g      -Og debug friendly", 0
LC31:
	db "  emerge --opt-level=2 htop", 0
section .rodata
LC32:
	db "  emerge -O2 htop               (short)", 0
LC33:
	db "  emerge --target=skylake -O2 htop", 0
LC34:
	db "  emerge --opt-level=fast --no-pipe firefox", 0
global print_known_opt_levels
print_known_opt_levels:
	sub	rsp, 8
	mov	edi, LC22
	xor	eax, eax
	call	printf
	mov	edi, LC23
	call	puts
	mov	edi, LC24
	call	puts
	mov	edi, LC25
	call	puts
	mov	edi, LC26
	call	puts
	mov	edi, LC27
	call	puts
	mov	edi, LC28
	call	puts
	mov	edi, LC29
	call	puts
	mov	edi, LC30
	call	puts
	mov	edi, LC16
	call	puts
	mov	edi, LC31
	call	puts
	mov	edi, LC32
	call	puts
	mov	edi, LC33
	call	puts
	mov	edi, LC34
	add	rsp, 8
	jmp	puts
global set_use_pipe
set_use_pipe:
	xor	eax, eax
	test	edi, edi
	setne	al
	mov	dword [rel g_use_pipe], eax
	ret
global get_use_pipe
get_use_pipe:
	mov	eax, dword [rel g_use_pipe]
	ret
section .rodata
LC35:
	db "-c", 0
LC36:
	db "sh", 0
LC37:
	db "/bin/sh", 0
global run_cmd
run_cmd:
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 160
	call	fork
	test	eax, eax
	js	.L114
	mov	ebx, eax
	je	.L118
	mov	rbp, rsp
.L113:
	xor	edx, edx
	mov	rsi, rbp
	mov	edi, ebx
	call	waitpid
	test	eax, eax
	jns	.L120
	call	__errno_location
	cmp	dword [rax], 4
	je	.L113
.L114:
	add	rsp, 160
	mov	eax, -1
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L120:
	mov	eax, dword [rsp]
	mov	edx, eax
	and	edx, 127
	lea	ecx, [rdx+1]
	cmp	cl, 1
	jg	.L121
	test	edx, edx
	jne	.L114
	add	rsp, 160
	movzx	eax, ah
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L121:
	add	rsp, 160
	lea	eax, [rdx+128]
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L118:
	mov	ecx, 38
	mov	rdi, rsp
	rep stosd
	lea	rdi, [rsp+8]
	call	sigemptyset
	xor	edx, edx
	mov	rsi, rsp
	mov	edi, 2
	call	sigaction
	xor	edx, edx
	mov	rsi, rsp
	mov	edi, 15
	call	sigaction
	xor	edx, edx
	mov	rsi, rsp
	mov	edi, 1
	call	sigaction
	mov	edi, LC37
	xor	r8d, r8d
	mov	rcx, rbp
	mov	edx, LC35
	mov	esi, LC36
	xor	eax, eax
	call	execl
	mov	edi, 127
	call	_exit
section .rodata
LC38:
	db "/dev/null", 0
global run_cmd_capture
run_cmd_capture:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 200
	mov	qword [rsp+8], rsi
	test	rsi, rsi
	je	.L124
	mov	qword [rsi], 0
	mov	rbp, rdi
	test	rdi, rdi
	je	.L124
	lea	rdi, [rsp+24]
	call	pipe
	test	eax, eax
	jne	.L124
	call	fork
	mov	r15d, eax
	test	eax, eax
	js	.L150
	je	.L151
	mov	edi, dword [rsp+28]
	call	close
	mov	edi, 4096
	call	malloc
	mov	r12, rax
	test	rax, rax
	je	.L148
	xor	ebp, ebp
	mov	ebx, 4096
	mov	r14d, 1024
.L131:
	cmp	r14, rbx
	jb	.L132
	add	rbx, rbx
	cmp	rbx, 16777216
	ja	.L147
.L133:
	mov	rsi, rbx
	mov	rdi, r12
	call	realloc
	test	rax, rax
	je	.L147
	mov	r12, rax
.L132:
	mov	rdx, rbx
	lea	r13, [r12+rbp]
	mov	edi, dword [rsp+24]
	sub	rdx, rbp
	mov	rsi, r13
	sub	rdx, 1
	call	read
	test	rax, rax
	js	.L152
	je	.L136
	add	rbp, rax
	lea	r14, [rbp+1024]
	cmp	r14, rbx
	jb	.L132
	add	rbx, rbx
	cmp	rbx, 16777216
	jbe	.L133
.L147:
	mov	rdi, r12
	call	free
.L148:
	mov	edi, dword [rsp+24]
	call	close
	xor	edx, edx
	xor	esi, esi
	mov	edi, r15d
	call	waitpid
.L124:
	mov	eax, -1
.L122:
	add	rsp, 200
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L151:
	lea	rbx, [rsp+32]
	xor	eax, eax
	mov	ecx, 19
	mov	rdi, rbx
	rep stosq
	lea	rdi, [rsp+40]
	call	sigemptyset
	xor	edx, edx
	mov	rsi, rbx
	mov	edi, 2
	call	sigaction
	xor	edx, edx
	mov	rsi, rbx
	mov	edi, 15
	call	sigaction
	xor	edx, edx
	mov	rsi, rbx
	mov	edi, 1
	call	sigaction
	mov	edi, dword [rsp+24]
	call	close
	mov	edi, dword [rsp+28]
	mov	esi, 1
	call	dup2
	test	eax, eax
	js	.L149
	mov	edi, dword [rsp+28]
	call	close
	mov	esi, 1
	mov	edi, LC38
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	jns	.L153
.L130:
	xor	r8d, r8d
	mov	rcx, rbp
	mov	edx, LC35
	mov	esi, LC36
	mov	edi, LC37
	xor	eax, eax
	call	execl
.L149:
	mov	edi, 127
	call	_exit
.L152:
	call	__errno_location
	cmp	dword [rax], 4
	je	.L131
	jmp	.L147
.L153:
	mov	esi, 2
	mov	edi, eax
	call	dup2
	mov	edi, ebx
	call	close
	jmp	.L130
.L136:
	mov	edi, dword [rsp+24]
	lea	rbx, [rsp+32]
	call	close
	mov	byte [r13+0], 0
	jmp	.L137
.L138:
	call	__errno_location
	cmp	dword [rax], 4
	jne	.L154
.L137:
	xor	edx, edx
	mov	rsi, rbx
	mov	edi, r15d
	call	waitpid
	test	eax, eax
	js	.L138
	mov	rax, qword [rsp+8]
	mov	qword [rax], r12
	mov	eax, dword [rsp+32]
	mov	edx, eax
	and	edx, 127
	lea	ecx, [rdx+1]
	cmp	cl, 1
	jg	.L155
	test	edx, edx
	jne	.L124
	movzx	eax, ah
	jmp	.L122
.L154:
	mov	rdi, r12
	call	free
	jmp	.L124
.L155:
	lea	eax, [rdx+128]
	jmp	.L122
.L150:
	mov	edi, dword [rsp+24]
	call	close
	mov	edi, dword [rsp+28]
	call	close
	jmp	.L124
global shell_quote
shell_quote:
	test	rsi, rsi
	sete	al
	cmp	rdx, 2
	setbe	cl
	or	al, cl
	jne	.L162
	test	rdi, rdi
	je	.L162
	mov	byte [rsi], 39
	movzx	eax, byte [rdi]
	mov	ecx, 1
	test	al, al
	je	.L165
	mov	r9d, dword [rel LC39]
	jmp	.L164
.L161:
	lea	r8, [rcx+1]
	cmp	r8, rdx
	jnb	.L162
	add	rdi, 1
	mov	byte [rsi+rcx], al
	mov	rcx, r8
	movzx	eax, byte [rdi]
	test	al, al
	je	.L167
.L164:
	cmp	al, 39
	jne	.L161
	lea	rax, [rcx+4]
	cmp	rax, rdx
	jnb	.L162
	add	rdi, 1
	mov	dword [rsi+rcx], r9d
	mov	rcx, rax
	movzx	eax, byte [rdi]
	test	al, al
	jne	.L164
.L167:
	lea	rax, [rcx+1]
	cmp	rax, rdx
	jnb	.L162
.L160:
	mov	byte [rsi+rcx], 39
	mov	byte [rsi+rax], 0
	mov	eax, 1
	ret
.L162:
	xor	eax, eax
	ret
.L165:
	mov	eax, 2
	jmp	.L160
section .rodata
LC40:
	db " @._+-/", 0
global valid_search_query
valid_search_query:
	push	r12
	push	rbp
	push	rbx
	test	rdi, rdi
	je	.L175
	movzx	ebx, byte [rdi]
	mov	rbp, rdi
	xor	r12d, r12d
	test	bl, bl
	je	.L168
	call	strlen
	cmp	rax, 128
	ja	.L168
	call	__ctype_b_loc
	mov	r12, qword [rax]
.L171:
	movzx	eax, bl
	test	byte [r12+rax*2], 8
	jne	.L170
	movzx	esi, bl
	mov	edi, LC40
	call	strchr
	test	rax, rax
	je	.L175
.L170:
	movzx	ebx, byte [rbp+1]
	add	rbp, 1
	test	bl, bl
	jne	.L171
	mov	r12d, 1
.L168:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L175:
	xor	r12d, r12d
	pop	rbx
	pop	rbp
	mov	eax, r12d
	pop	r12
	ret
global dep_basename
dep_basename:
	test	rsi, rsi
	je	.L179
	test	rdx, rdx
	je	.L179
	test	rdi, rdi
	jne	.L194
	jmp	.L181
.L192:
	add	rdi, 1
.L194:
	movzx	eax, byte [rdi]
	cmp	al, 32
	je	.L192
	cmp	al, 9
	je	.L192
	mov	r8, rsi
	xor	ecx, ecx
	mov	r9, rsi
	movabs	r10, 8358680912694608384
	test	al, al
	jne	.L187
	jmp	.L185
.L188:
	cmp	al, 62
	ja	.L186
	bt	r10, rax
	jc	.L185
.L186:
	mov	byte [r8], al
	movzx	eax, byte [rdi+rcx]
	add	r8, 1
	test	al, al
	je	.L195
.L187:
	add	rcx, 1
	mov	r9, r8
	cmp	rcx, rdx
	jb	.L188
.L185:
	mov	byte [r9], 0
.L179:
	ret
.L195:
	lea	r9, [rsi+rcx]
	mov	byte [r9], 0
	ret
.L181:
	mov	byte [rsi], 0
	ret
section .rodata
LC41:
	db "\033[1;31m[-] Internal error: formatted output needs %d bytes but only %zu are available; aborting rather than running a truncated command or path.\n\033[0m", 0
global xsnprintf
xsnprintf:
	push	rbx
	mov	rbx, rsi
	sub	rsp, 208
	mov	qword [rsp+56], rcx
	mov	qword [rsp+64], r8
	mov	qword [rsp+72], r9
	test	al, al
	je	.L200
	movaps	oword [rsp+80], xmm0
	movaps	oword [rsp+96], xmm1
	movaps	oword [rsp+112], xmm2
	movaps	oword [rsp+128], xmm3
	movaps	oword [rsp+144], xmm4
	movaps	oword [rsp+160], xmm5
	movaps	oword [rsp+176], xmm6
	movaps	oword [rsp+192], xmm7
.L200:
	lea	rax, [rsp+224]
	lea	rcx, [rsp+8]
	mov	rsi, rbx
	mov	dword [rsp+8], 24
	mov	qword [rsp+16], rax
	lea	rax, [rsp+32]
	mov	dword [rsp+12], 48
	mov	qword [rsp+24], rax
	call	vsnprintf
	test	eax, eax
	js	.L198
	movsx	rdx, eax
	cmp	rdx, rbx
	jnb	.L198
	add	rsp, 208
	pop	rbx
	ret
.L198:
	mov	rdi, qword [rel stderr]
	mov	edx, eax
	mov	rcx, rbx
	mov	esi, LC41
	xor	eax, eax
	call	fprintf
	mov	edi, 1
	call	exit
section .rodata
LC42:
	db "%s", 0
global set_target_arch
set_target_arch:
	test	rdi, rdi
	je	.L227
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	movzx	ebp, byte [rdi]
	test	bpl, bpl
	je	.L202
	call	strlen
	sub	rax, 1
	cmp	rax, 63
	ja	.L202
	mov	esi, LC0
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L202
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L202
	call	__ctype_b_loc
	mov	rcx, qword [rax]
	movzx	eax, bpl
	movzx	edx, word [rcx+rax*2]
	test	dl, 8
	je	.L202
	mov	rax, rbx
	jmp	.L207
.L230:
	movzx	edx, bpl
	movzx	edx, word [rcx+rdx*2]
.L207:
	and	edx, 8
	jne	.L204
	lea	edx, [rbp-45]
	cmp	dl, 1
	jbe	.L204
	cmp	bpl, 95
	jne	.L202
.L204:
	movzx	ebp, byte [rax+1]
	add	rax, 1
	test	bpl, bpl
	jne	.L230
	add	rsp, 8
	mov	rcx, rbx
	mov	edx, LC42
	xor	eax, eax
	pop	rbx
	mov	esi, 128
	mov	edi, g_target_arch
	pop	rbp
	jmp	xsnprintf
.L202:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L227:
	ret
global set_opt_level
set_opt_level:
	test	rdi, rdi
	je	.L331
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	movzx	ebp, byte [rdi]
	test	bpl, bpl
	je	.L231
	mov	esi, LC0
	call	strcmp
	test	eax, eax
	je	.L231
	mov	esi, LC1
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L231
	cmp	bpl, 45
	je	.L334
	mov	eax, ebp
	and	eax, -33
	cmp	al, 79
	je	.L256
	cmp	byte [rbx], 48
	je	.L335
.L269:
	mov	r12, rbx
.L255:
	movzx	r13d, byte [r12]
	cmp	r13d, 49
	jne	.L257
	cmp	byte [r12+1], 0
	jne	.L257
.L236:
	cmp	bpl, 45
	jne	.L243
	movzx	ebp, byte [rbx+1]
	add	rbx, 1
.L243:
	and	ebp, -33
	xor	eax, eax
	cmp	bpl, 79
	sete	al
	add	rbx, rax
	movzx	eax, byte [rbx]
	cmp	eax, 48
	jne	.L262
	cmp	byte [rbx+1], 0
	jne	.L262
.L246:
	add	rsp, 8
	mov	rcx, rbx
	mov	edx, LC42
	xor	eax, eax
	pop	rbx
	mov	esi, 16
	pop	rbp
	mov	edi, g_opt_level
	pop	r12
	pop	r13
	jmp	xsnprintf
.L262:
	cmp	eax, 49
	jne	.L263
	cmp	byte [rbx+1], 0
	je	.L246
.L263:
	cmp	eax, 50
	jne	.L264
	cmp	byte [rbx+1], 0
	je	.L246
.L264:
	cmp	eax, 51
	jne	.L265
	cmp	byte [rbx+1], 0
	je	.L246
.L265:
	cmp	eax, 115
	jne	.L266
	cmp	byte [rbx+1], 0
	je	.L246
.L266:
	cmp	eax, 103
	jne	.L267
	cmp	byte [rbx+1], 0
	je	.L246
.L267:
	cmp	eax, 122
	jne	.L268
	cmp	byte [rbx+1], 0
	je	.L246
.L268:
	mov	esi, LC21
	mov	rdi, rbx
	call	strcmp
	test	eax, eax
	je	.L246
.L231:
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L331:
	ret
.L334:
	movzx	eax, byte [rbx+1]
	lea	r12, [rbx+1]
	mov	edx, eax
	and	edx, -33
	cmp	dl, 79
	jne	.L234
	mov	rax, r12
	jmp	.L253
.L256:
	mov	rax, rbx
.L253:
	lea	r12, [rax+1]
	movzx	eax, byte [rax+1]
.L234:
	test	al, al
	je	.L231
	cmp	byte [r12], 48
	jne	.L255
	cmp	byte [r12+1], 0
	je	.L236
	jmp	.L255
.L257:
	cmp	r13d, 50
	je	.L336
.L258:
	cmp	r13d, 51
	jne	.L259
	cmp	byte [r12+1], 0
	je	.L236
.L259:
	cmp	r13d, 115
	jne	.L260
	cmp	byte [r12+1], 0
	je	.L236
.L260:
	mov	esi, LC21
	mov	rdi, r12
	call	strcmp
	test	eax, eax
	je	.L236
	cmp	r13d, 103
	jne	.L261
	cmp	byte [r12+1], 0
	je	.L236
.L261:
	cmp	r13d, 122
	jne	.L231
	cmp	byte [r12+1], 0
	je	.L236
	jmp	.L231
.L335:
	cmp	byte [rbx+1], 0
	je	.L243
	jmp	.L269
.L336:
	cmp	byte [r12+1], 0
	je	.L236
	jmp	.L258
section .rodata
LC43:
	db "%s >/dev/null 2>&1", 0
global run_cmd_quiet
run_cmd_quiet:
	push	rbx
	mov	rcx, rdi
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	sub	rsp, 4608
	mov	rdi, rsp
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd
	add	rsp, 4608
	pop	rbx
	ret
global fopen_nofollow
fopen_nofollow:
	push	rbp
	push	rbx
	mov	rbx, rsi
	sub	rsp, 8
	movzx	eax, byte [rsi]
	cmp	al, 114
	je	.L346
	cmp	al, 119
	je	.L347
	cmp	al, 97
	je	.L348
	call	__errno_location
	mov	dword [rax], 22
.L341:
	xor	ebx, ebx
.L339:
	add	rsp, 8
	mov	rax, rbx
	pop	rbx
	pop	rbp
	ret
.L347:
	mov	esi, 131649
.L340:
	mov	edx, 420
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L341
	mov	rsi, rbx
	mov	edi, eax
	call	fdopen
	mov	rbx, rax
	test	rax, rax
	jne	.L339
	mov	edi, ebp
	call	close
	jmp	.L339
.L348:
	mov	esi, 132161
	jmp	.L340
.L346:
	mov	esi, 131072
	jmp	.L340
global file_exists
file_exists:
	sub	rsp, 152
	mov	rsi, rsp
	call	stat
	mov	edx, eax
	xor	eax, eax
	test	edx, edx
	jne	.L350
	mov	eax, dword [rsp+24]
	and	eax, 61440
	cmp	eax, 32768
	sete	al
	movzx	eax, al
.L350:
	add	rsp, 152
	ret
global dir_exists
dir_exists:
	sub	rsp, 152
	mov	rsi, rsp
	call	stat
	mov	edx, eax
	xor	eax, eax
	test	edx, edx
	jne	.L355
	mov	eax, dword [rsp+24]
	and	eax, 61440
	cmp	eax, 16384
	sete	al
	movzx	eax, al
.L355:
	add	rsp, 152
	ret
section .rodata
LC44:
	db "@._+-", 0
global valid_pkgname
valid_pkgname:
	push	r12
	push	rbp
	push	rbx
	test	rdi, rdi
	je	.L368
	movzx	ebp, byte [rdi]
	mov	rbx, rdi
	xor	r12d, r12d
	test	bpl, bpl
	je	.L360
	lea	eax, [rbp-45]
	cmp	al, 1
	jbe	.L360
	call	strlen
	cmp	rax, 128
	ja	.L360
	call	__ctype_b_loc
	mov	r12, qword [rax]
	jmp	.L363
.L362:
	movzx	ebp, byte [rbx+1]
	add	rbx, 1
	test	bpl, bpl
	je	.L372
.L363:
	movzx	eax, bpl
	test	byte [r12+1+rax*2], 10
	jne	.L362
	movzx	esi, bpl
	mov	edi, LC44
	call	strchr
	test	rax, rax
	jne	.L362
.L368:
	xor	r12d, r12d
.L360:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L372:
	mov	r12d, 1
	pop	rbx
	pop	rbp
	mov	eax, r12d
	pop	r12
	ret
section .rodata
LC45:
	db '.^$*+?()[]{}|/\', 0
global regex_escape
regex_escape:
	push	r14
	mov	r14, rdx
	push	r13
	mov	r13, rsi
	push	r12
	push	rbp
	push	rbx
	movzx	ebx, byte [rdi]
	test	bl, bl
	je	.L381
	mov	rbp, rdi
	xor	r12d, r12d
	jmp	.L380
.L384:
	lea	rax, [r12+2]
	cmp	rax, r14
	jnb	.L379
	mov	byte [r13+0+r12], 92
	movzx	ebx, byte [rbp+0]
	lea	rdx, [r12+1]
	mov	r12, rax
.L378:
	add	rbp, 1
	mov	byte [r13+0+rdx], bl
	movzx	ebx, byte [rbp+0]
	test	bl, bl
	je	.L374
.L380:
	movsx	esi, bl
	mov	edi, LC45
	call	strchr
	test	rax, rax
	jne	.L384
	lea	rax, [r12+1]
	cmp	rax, r14
	jnb	.L379
	mov	rdx, r12
	mov	r12, rax
	jmp	.L378
.L381:
	xor	r12d, r12d
.L374:
	cmp	r12, r14
	jb	.L385
.L379:
	pop	rbx
	xor	eax, eax
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L385:
	mov	byte [r13+0+r12], 0
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
section .rodata
LC46:
	db "SUDO_USER", 0
global build_user
build_user:
	sub	rsp, 8
	mov	edi, LC46
	call	getenv
	test	rax, rax
	je	.L387
	cmp	byte [rax], 0
	jne	.L386
.L387:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L386
	mov	rax, qword [rax]
.L386:
	add	rsp, 8
	ret
section .rodata
LC47:
	db "\033[1;31m[-] Configuration error: %s\n\033[0m", 0
global load_user_config
load_user_config:
	push	rbp
	mov	edx, 512
	push	rbx
	sub	rsp, 1480
	lea	rbx, [rsp+512]
	mov	rsi, rsp
	mov	rdi, rbx
	call	config_load
	test	eax, eax
	je	.L400
	mov	rdi, rbx
	call	config_apply
	add	rsp, 1480
	pop	rbx
	pop	rbp
	ret
.L400:
	mov	rdi, qword [rel stderr]
	mov	rdx, rsp
	mov	esi, LC47
	call	fprintf
	add	rsp, 1480
	pop	rbx
	pop	rbp
	ret
section .rodata
LC48:
	db "", 0
LC49:
	db "sudo ", 0
global priv_prefix
priv_prefix:
	sub	rsp, 8
	call	geteuid
	mov	edx, LC48
	test	eax, eax
	mov	eax, LC49
	cmove	rax, rdx
	add	rsp, 8
	ret
section .rodata
LC50:
	db "command -v '%s'", 0
global have_cmd
have_cmd:
	push	rbp
	mov	rcx, rdi
	mov	edx, LC50
	mov	esi, 512
	push	rbx
	xor	eax, eax
	sub	rsp, 5128
	lea	rbx, [rsp+512]
	mov	rdi, rsp
	call	xsnprintf
	mov	rcx, rsp
	mov	rdi, rbx
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	test	eax, eax
	sete	al
	add	rsp, 5128
	movzx	eax, al
	pop	rbx
	pop	rbp
	ret
section .rodata
LC51:
	db "sudo", 0
section .rodata
LC52:
	db "\033[1;31m[-] sudo is required.\n\033[0m", 0
section .rodata
LC53:
	db "sudo -k", 0
section .rodata
LC54:
	db "\033[1;31m[-] Could not invalidate sudo credentials.\n\033[0m", 0
LC55:
	db "\033[1;31m[-] Out of memory.\n\033[0m", 0
LC56:
	db "\033[1;31m[-] Could not execute sudo: %s\n\033[0m", 0
global acquire_sudo
acquire_sudo:
	push	r13
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	ebx, edi
	sub	rsp, 24
	call	geteuid
	mov	ecx, eax
	mov	eax, 1
	test	ecx, ecx
	jne	.L418
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L418:
	mov	edi, LC51
	call	have_cmd
	test	eax, eax
	je	.L419
	mov	edi, LC53
	call	run_cmd
	test	eax, eax
	jne	.L420
	movsx	r13, ebx
	mov	esi, 8
	lea	rdi, [r13+3]
	call	calloc
	mov	r12, rax
	test	rax, rax
	je	.L421
	mov	eax, 11565
	lea	rdx, [rsp+11]
	mov	byte [rsp+15], 0
	mov	word [rsp+8], ax
	lea	rax, [rsp+8]
	movq	xmm0, rdx
	movq	xmm1, rax
	mov	dword [rsp+11], 1868854643
	punpcklqdq	xmm0, xmm1
	mov	byte [rsp+10], 0
	movups	oword [r12], xmm0
	test	ebx, ebx
	jle	.L413
	mov	edx, ebx
	lea	rdi, [r12+16]
	mov	rsi, rbp
	sal	rdx, 3
	call	memcpy
.L413:
	mov	qword [r12+16+r13*8], 0
	mov	rsi, r12
	mov	edi, LC51
	call	execvp
	call	__errno_location
	mov	edi, dword [rax]
	call	strerror
	mov	rdi, qword [rel stderr]
	mov	esi, LC56
	mov	rdx, rax
	xor	eax, eax
	call	fprintf
	mov	rdi, r12
	call	free
	xor	eax, eax
.L422:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L419:
	mov	edx, 33
	mov	esi, 1
	mov	edi, LC52
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	jmp	.L422
.L420:
	mov	edx, 54
	mov	esi, 1
	mov	edi, LC54
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	jmp	.L422
.L421:
	mov	edx, 30
	mov	esi, 1
	mov	edi, LC55
	mov	rcx, qword [rel stderr]
	call	fwrite
	xor	eax, eax
	jmp	.L422
section .rodata
LC57:
	db "chown '%s' '%s'", 0
global fix_owner
fix_owner:
	push	rbp
	push	rbx
	mov	rbx, rdi
	sub	rsp, 5640
	call	geteuid
	test	eax, eax
	je	.L438
.L423:
	add	rsp, 5640
	pop	rbx
	pop	rbp
	ret
.L438:
	mov	edi, LC46
	call	getenv
	mov	rcx, rax
	test	rax, rax
	je	.L425
	cmp	byte [rax], 0
	jne	.L426
.L425:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L423
	mov	rcx, qword [rax]
	test	rcx, rcx
	je	.L423
.L426:
	mov	r8, rbx
	mov	rdi, rsp
	lea	rbx, [rsp+1024]
	xor	eax, eax
	mov	edx, LC57
	mov	esi, 1024
	call	xsnprintf
	mov	rcx, rsp
	mov	rdi, rbx
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	add	rsp, 5640
	pop	rbx
	pop	rbp
	ret
section .rodata
LC58:
	db "%s%s", 0
section .rodata
LC59:
	db "\033[1;31m[-] Running as root with no SUDO_USER; cannot find an unprivileged user to build as.\n\033[0m", 0
section .rodata
LC60:
	db "/dev/urandom", 0
LC61:
	db "/usr/local/emerge", 0
LC62:
	db "%s/.archtoo-step-%ld-%08lx.sh", 0
section .rodata
LC63:
	db "\033[1;31m[-] Cannot create step script in %s: %s\n\033[0m", 0
section .rodata
LC64:
	db "w", 0
section .rodata
LC65:
	db "\033[1;31m[-] fdopen failed for %s\n\033[0m", 0
LC66:
	db "#!/bin/sh\ntrap 'exit 130' INT\ntrap 'exit 143' TERM\ntrap 'exit 129' HUP\n%s%s\n", 0
LC67:
	db "\033[1;31m[-] Cannot finish writing %s\n\033[0m", 0
section .rodata
LC68:
	db "sudo -u '%s' -- /bin/sh '%s'", 0
global run_as_user
run_as_user:
	push	r15
	push	r14
	push	r13
	mov	r13, rsi
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 4744
	mov	qword [rsp], rdi
	call	geteuid
	test	eax, eax
	je	.L440
	test	r13, r13
	je	.L441
	cmp	byte [r13+0], 0
	jne	.L442
.L441:
	mov	rdi, qword [rsp]
	add	rsp, 4744
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	jmp	run_cmd
.L440:
	mov	edi, LC46
	call	getenv
	mov	qword [rsp+8], rax
	test	rax, rax
	je	.L444
	cmp	byte [rax], 0
	jne	.L445
.L444:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L446
	mov	rax, qword [rax]
	mov	qword [rsp+8], rax
	test	rax, rax
	je	.L446
.L445:
	mov	r14d, 16
	lea	r12, [rsp+32]
	lea	r15, [rsp+640]
.L447:
	mov	esi, 524288
	mov	edi, LC60
	xor	eax, eax
	call	open
	mov	ebp, eax
	test	eax, eax
	js	.L449
	mov	edi, eax
	lea	rsi, [rsp+28]
	mov	edx, 4
	call	read
	mov	edi, ebp
	mov	rbx, rax
	call	close
	cmp	rbx, 4
	je	.L471
.L449:
	mov	rsi, r15
	xor	edi, edi
	call	clock_gettime
	mov	rbx, qword [rsp+648]
	call	getpid
	movsx	rbp, eax
	call	clock
	sal	rbp, 16
	xor	rbx, rax
	xor	rbx, rbp
	mov	ebx, ebx
.L450:
	call	getpid
	mov	r9, rbx
	mov	ecx, LC61
	mov	rdi, r12
	movsx	r8, eax
	mov	edx, LC62
	mov	esi, 600
	xor	eax, eax
	call	xsnprintf
	mov	edx, 448
	mov	rdi, r12
	xor	eax, eax
	mov	esi, 131265
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L472
	mov	esi, LC64
	mov	edi, eax
	call	fdopen
	mov	rbp, rax
	test	rax, rax
	je	.L473
	test	r13, r13
	mov	eax, LC48
	mov	rcx, qword [rsp]
	mov	rdi, rbp
	cmove	r13, rax
	mov	esi, LC66
	xor	eax, eax
	mov	rdx, r13
	call	fprintf
	mov	rdi, rbp
	call	fclose
	test	eax, eax
	jne	.L474
	mov	esi, 493
	mov	rdi, r12
	lea	rbx, [rsp+640]
	call	chmod
	mov	rdi, r12
	call	fix_owner
	mov	rcx, qword [rsp+8]
	mov	rdi, rbx
	mov	r8, r12
	mov	edx, LC68
	mov	esi, 1024
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	mov	rdi, r12
	mov	ebx, eax
	call	unlink
.L439:
	add	rsp, 4744
	mov	eax, ebx
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L472:
	call	__errno_location
	mov	edi, dword [rax]
	cmp	edi, 17
	jne	.L452
	sub	r14d, 1
	jne	.L447
.L452:
	call	strerror
	mov	edx, LC61
	mov	esi, LC63
	mov	rdi, qword [rel stderr]
	mov	rcx, rax
	xor	eax, eax
	call	fprintf
.L448:
	mov	ebx, -1
	jmp	.L439
.L471:
	mov	ebx, dword [rsp+28]
	bswap	ebx
	mov	ebx, ebx
	jmp	.L450
.L442:
	mov	r8, qword [rsp]
	mov	rcx, r13
	mov	edx, LC58
	xor	eax, eax
	lea	rbx, [rsp+640]
	mov	esi, 4096
	mov	rdi, rbx
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	mov	ebx, eax
	jmp	.L439
.L474:
	mov	rdi, qword [rel stderr]
	mov	rdx, r12
	mov	esi, LC67
	xor	eax, eax
	call	fprintf
	mov	rdi, r12
	call	unlink
	jmp	.L448
.L446:
	mov	edx, 96
	mov	esi, 1
	mov	edi, LC59
	mov	rcx, qword [rel stderr]
	call	fwrite
	jmp	.L448
.L473:
	mov	rdi, qword [rel stderr]
	mov	rdx, r12
	mov	esi, LC65
	xor	eax, eax
	call	fprintf
	mov	edi, ebx
	call	close
	mov	rdi, r12
	call	unlink
	jmp	.L448
section .rodata
LC69:
	db "/usr/local/emerge/builds", 0
LC70:
	db "/usr/local/emerge/backups", 0
LC71:
	db "%smkdir -p '%s' '%s'", 0
section .rodata
LC72:
	db "\033[1;31m[-] Could not create %s\n\033[0m", 0
section .rodata
LC73:
	db "._-", 0
LC74:
	db "%schown -R '%s' '%s'", 0
LC75:
	db "/usr/local/emerge/world", 0
LC76:
	db "a", 0
section .rodata
LC77:
	db "\033[1;31m[-] Cannot write world file %s\n\033[0m", 0
LC78:
	db "\033[1;31m[-] World file %s is not writable.\n\033[0m", 0
global init_system
init_system:
	push	r14
	mov	edi, LC69
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 5632
	lea	r13, [rsp+1024]
	mov	rsi, r13
	call	stat
	test	eax, eax
	jne	.L479
	mov	eax, dword [rsp+1048]
	and	eax, 61440
	cmp	eax, 16384
	je	.L544
.L479:
	call	geteuid
	mov	ecx, LC49
	mov	rdi, rsp
	mov	r9d, LC70
	test	eax, eax
	mov	eax, LC48
	mov	r8d, LC69
	mov	edx, LC71
	cmove	rcx, rax
	mov	esi, 1024
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rsp
	call	run_cmd
	test	eax, eax
	jne	.L545
.L481:
	call	geteuid
	test	eax, eax
	jne	.L484
.L487:
	mov	edi, LC46
	call	getenv
	mov	r12, rax
	test	rax, rax
	je	.L486
	cmp	byte [rax], 0
	jne	.L489
.L486:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L488
	mov	r12, qword [rax]
	test	r12, r12
	jne	.L546
.L488:
	mov	rsi, r13
	mov	edi, LC75
	call	stat
	test	eax, eax
	jne	.L495
	mov	eax, dword [rsp+1048]
	and	eax, 61440
	cmp	eax, 32768
	je	.L499
.L495:
	mov	edx, 420
	mov	esi, 132161
	mov	edi, LC75
	xor	eax, eax
	call	open
	mov	ebx, eax
	test	eax, eax
	js	.L497
	mov	edi, eax
	mov	esi, LC76
	call	fdopen
	mov	rdi, rax
	test	rax, rax
	je	.L498
	call	fclose
.L499:
	call	geteuid
	test	eax, eax
	je	.L547
.L502:
	mov	esi, 2
	mov	edi, LC75
	call	access
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	jne	.L548
	add	rsp, 5632
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L484:
	mov	esi, 2
	mov	edi, LC61
	call	access
	test	eax, eax
	jne	.L487
	jmp	.L488
.L547:
	mov	edi, LC46
	call	getenv
	test	rax, rax
	je	.L503
	cmp	byte [rax], 0
	jne	.L504
.L503:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L502
	mov	rax, qword [rax]
	test	rax, rax
	je	.L502
.L504:
	mov	rcx, rax
	mov	r8d, LC75
	mov	rdi, rsp
	xor	eax, eax
	mov	edx, LC57
	mov	esi, 1024
	call	xsnprintf
	mov	rdi, r13
	mov	rcx, rsp
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	call	run_cmd
	jmp	.L502
.L544:
	mov	rsi, r13
	mov	edi, LC70
	call	stat
	test	eax, eax
	jne	.L479
	mov	eax, dword [rsp+1048]
	and	eax, 61440
	cmp	eax, 16384
	jne	.L479
	jmp	.L481
.L545:
	mov	rdi, qword [rel stderr]
	mov	edx, LC61
	mov	esi, LC72
	xor	eax, eax
	call	fprintf
	xor	eax, eax
.L549:
	add	rsp, 5632
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L489:
	mov	rdi, rax
	call	valid_pkgname
	test	eax, eax
	jne	.L491
	movzx	ebx, byte [r12]
.L506:
	call	__ctype_b_loc
	mov	rbp, r12
	mov	r14, qword [rax]
.L493:
	movzx	eax, bl
	test	byte [r14+rax*2], 8
	jne	.L492
	movzx	esi, bl
	mov	edi, LC73
	call	strchr
	test	rax, rax
	je	.L488
.L492:
	movzx	ebx, byte [rbp+1]
	add	rbp, 1
	test	bl, bl
	jne	.L493
.L491:
	call	geteuid
	mov	ecx, LC49
	mov	r8, r12
	mov	rdi, rsp
	test	eax, eax
	mov	eax, LC48
	mov	r9d, LC61
	mov	edx, LC74
	cmove	rcx, rax
	mov	esi, 1024
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	mov	rcx, rsp
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	call	xsnprintf
	mov	rdi, r13
	call	run_cmd
	jmp	.L488
.L548:
	mov	rdi, qword [rel stderr]
	mov	edx, LC75
	mov	esi, LC78
	xor	eax, eax
	call	fprintf
	xor	eax, eax
	jmp	.L549
.L546:
	mov	rdi, r12
	call	valid_pkgname
	test	eax, eax
	jne	.L491
	movzx	ebx, byte [r12]
	test	bl, bl
	jne	.L506
	jmp	.L491
.L498:
	mov	edi, ebx
	call	close
.L497:
	mov	rdi, qword [rel stderr]
	mov	edx, LC75
	mov	esi, LC77
	xor	eax, eax
	call	fprintf
	xor	eax, eax
	jmp	.L549
section .rodata
LC79:
	db "nano", 0
LC80:
	db "EDITOR", 0
global get_editor
get_editor:
	sub	rsp, 8
	mov	edi, LC80
	call	getenv
	test	rax, rax
	je	.L552
	cmp	byte [rax], 0
	mov	edx, LC79
	cmove	rax, rdx
	add	rsp, 8
	ret
.L552:
	mov	eax, LC79
	add	rsp, 8
	ret
global get_cpu_cores
get_cpu_cores:
	sub	rsp, 8
	mov	edi, 84
	call	sysconf
	mov	edx, 1
	test	rax, rax
	cmovle	rax, rdx
	add	rsp, 8
	ret
section .rodata
LC81:
	db " -pipe", 0
LC82:
	db "-j%ld", 0
LC83:
	db "-march=%s -O%s%s", 0
LC84:
	db "KCFLAGS", 0
LC85:
	db "KCPPFLAGS", 0
LC86:
	db "MAKEFLAGS", 0
global set_build_env
set_build_env:
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 336
	mov	rcx, qword [rel g_jobs]
	test	rcx, rcx
	jle	.L561
.L557:
	lea	rbp, [rsp+16]
	mov	edx, LC82
	mov	esi, 64
	xor	eax, eax
	mov	rdi, rbp
	lea	rbx, [rsp+80]
	call	xsnprintf
	mov	eax, dword [rel g_use_pipe]
	mov	ecx, LC48
	mov	rdi, rsp
	mov	edx, LC42
	mov	esi, 16
	test	eax, eax
	mov	eax, LC81
	cmovne	rcx, rax
	xor	eax, eax
	call	xsnprintf
	mov	r9, rsp
	mov	r8d, g_opt_level
	xor	eax, eax
	mov	ecx, g_target_arch
	mov	rdi, rbx
	mov	edx, LC83
	mov	esi, 256
	call	xsnprintf
	mov	rsi, rbx
	mov	edx, 1
	mov	edi, LC84
	call	setenv
	mov	rsi, rbx
	mov	edx, 1
	mov	edi, LC85
	call	setenv
	mov	rsi, rbp
	mov	edx, 1
	mov	edi, LC86
	call	setenv
	add	rsp, 336
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L561:
	mov	edi, 84
	call	sysconf
	mov	edx, 1
	test	rax, rax
	cmovg	rdx, rax
	mov	rcx, rdx
	jmp	.L557
section .rodata
LC87:
	db "0", 0
LC88:
	db "1", 0
LC89:
	db "2", 0
LC90:
	db "s", 0
LC91:
	db "3", 0
LC92:
	db "z", 0
LC93:
	db "g", 0
section .rodata
LC94:
	db "-C opt-level=%s -C target-cpu=%s", 0
section .rodata
LC95:
	db "%s/makepkg.archtoo.conf", 0
section .rodata
LC96:
	db "\033[1;31m[-] Cannot write %s\n\033[0m", 0
LC97:
# target=%s opt=%s pipe=%d
source /etc/makepkg.conf
CFLAGS="%s"
CXXFLAGS="%s"
LDFLAGS="${LDFLAGS}"
RUSTFLAGS="%s"
MAKEFLAGS="-j%ld"
', 0
global write_makepkg_conf
write_makepkg_conf:
	push	r15
	mov	ecx, LC48
	mov	edx, LC42
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rsi
	mov	esi, 16
	push	rbx
	mov	rbx, rdi
	sub	rsp, 6456
	mov	eax, dword [rel g_use_pipe]
	lea	r15, [rsp+16]
	lea	r12, [rsp+32]
	test	eax, eax
	mov	eax, LC81
	mov	rdi, r15
	cmovne	rcx, rax
	xor	eax, eax
	lea	r13, [rsp+48]
	lea	r14, [rsp+304]
	call	xsnprintf
	mov	ecx, g_opt_level
	mov	rdi, r12
	xor	eax, eax
	mov	edx, LC42
	mov	esi, 16
	call	xsnprintf
	mov	r9, r15
	mov	r8, r12
	mov	ecx, g_target_arch
	mov	edx, LC83
	mov	esi, 256
	mov	rdi, r13
	xor	eax, eax
	call	xsnprintf
	mov	ecx, g_target_arch
	xor	eax, eax
	mov	r9, r15
	mov	r8, r12
	mov	edx, LC83
	mov	esi, 256
	mov	rdi, r14
	call	xsnprintf
	cmp	word [rsp+32], 48
	mov	ecx, LC87
	je	.L566
	cmp	word [rsp+32], 49
	je	.L604
	cmp	word [rsp+32], 50
	mov	ecx, LC89
	je	.L566
	cmp	word [rsp+32], 115
	je	.L603
	cmp	word [rsp+32], 122
	je	.L603
	cmp	word [rsp+32], 103
	mov	ecx, LC91
	je	.L604
.L566:
	lea	r15, [rsp+560]
	mov	r8d, g_target_arch
	mov	edx, LC94
	xor	eax, eax
	mov	esi, 256
	mov	rdi, r15
	call	xsnprintf
	mov	ecx, LC61
	mov	rsi, rbp
	mov	rdi, rbx
	mov	edx, LC95
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	mov	edx, 420
	xor	eax, eax
	mov	esi, 131649
	call	open
	mov	edi, eax
	test	eax, eax
	js	.L577
	mov	esi, LC64
	mov	dword [rsp+12], eax
	call	fdopen
	mov	edi, dword [rsp+12]
	test	rax, rax
	mov	rbp, rax
	je	.L578
	mov	rax, qword [rel g_jobs]
	test	rax, rax
	jle	.L605
.L580:
	sub	rsp, 8
	mov	r9, r13
	mov	rcx, r12
	mov	edx, g_target_arch
	push	rax
	mov	r8d, dword [rel g_use_pipe]
	mov	esi, LC97
	mov	rdi, rbp
	push	r15
	xor	eax, eax
	push	r14
	call	fprintf
	add	rsp, 32
	mov	rdi, rbp
	call	fclose
	call	geteuid
	test	eax, eax
	je	.L606
.L585:
	mov	eax, 1
.L562:
	add	rsp, 6456
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L606:
	mov	edi, LC46
	call	getenv
	mov	rcx, rax
	test	rax, rax
	je	.L583
	cmp	byte [rax], 0
	jne	.L584
.L583:
	call	getuid
	mov	edi, eax
	call	getpwuid
	test	rax, rax
	je	.L585
	mov	rcx, qword [rax]
	test	rcx, rcx
	je	.L585
.L584:
	mov	r8, rbx
	mov	edx, LC57
	mov	esi, 1024
	xor	eax, eax
	lea	rbp, [rsp+816]
	lea	rbx, [rsp+1840]
	mov	rdi, rbp
	call	xsnprintf
	mov	rdi, rbx
	mov	rcx, rbp
	mov	edx, LC43
	mov	esi, 4608
	xor	eax, eax
	call	xsnprintf
	mov	rdi, rbx
	call	run_cmd
	jmp	.L585
.L605:
	mov	edi, 84
	call	sysconf
	mov	edx, 1
	test	rax, rax
	cmovle	rax, rdx
	jmp	.L580
.L604:
	mov	ecx, LC88
	jmp	.L566
.L603:
	mov	ecx, LC90
	jmp	.L566
.L578:
	call	close
.L577:
	mov	rdi, qword [rel stderr]
	mov	rdx, rbx
	mov	esi, LC96
	xor	eax, eax
	call	fprintf
	xor	eax, eax
	jmp	.L562
section .rodata
LC98:
	db "yes", 0
LC99:
	db "Y/n", 0
LC100:
	db "no", 0
LC101:
	db "y/N", 0
LC102:
	db "%s [%s]: %s (auto)\n", 0
LC103:
	db "%s [%s]: ", 0
LC104:
	db "%s (default after %lds)\n", 0
global ask_yes_no
ask_yes_no:
	push	rbp
	mov	rbp, rdi
	push	rbx
	mov	ebx, esi
	sub	rsp, 72
	mov	edx, dword [rel g_noconfirm]
	test	edx, edx
	jne	.L611
	mov	eax, dword [rel g_emerge_confirm]
	test	eax, eax
	jne	.L643
.L611:
	test	ebx, ebx
	jne	.L609
	mov	ecx, LC100
	mov	edx, LC101
.L610:
	mov	rsi, rbp
	mov	edi, LC102
	xor	eax, eax
	call	printf
.L613:
	mov	eax, ebx
.L607:
	add	rsp, 72
	pop	rbx
	pop	rbp
	ret
.L609:
	mov	ecx, LC98
	mov	edx, LC99
	jmp	.L610
.L643:
	xor	edi, edi
	call	isatty
	test	eax, eax
	je	.L611
	test	ebx, ebx
	mov	eax, LC99
	mov	edx, LC101
	mov	rsi, rbp
	cmovne	rdx, rax
	mov	edi, LC103
	xor	eax, eax
	mov	rbp, rsp
	call	printf
	mov	rdi, qword [rel stdout]
	call	fflush
	mov	rax, qword [rel g_prompt_timeout]
	test	rax, rax
	jle	.L615
	movabs	rcx, 4294967296
	mov	edx, 2147483000
	mov	qword [rsp], rcx
	cmp	rax, 2147483
	jg	.L616
	imul	edx, eax, 1000
.L616:
	mov	esi, 1
	mov	rdi, rsp
	mov	rbp, rsp
	call	poll
	test	eax, eax
	je	.L644
	js	.L645
.L615:
	mov	rdx, qword [rel stdin]
	mov	esi, 64
	mov	rdi, rbp
	call	fgets
	test	rax, rax
	je	.L613
	mov	esi, 10
	mov	rdi, rbp
	call	strchr
	test	rax, rax
	je	.L623
.L622:
	movzx	eax, byte [rsp]
	cmp	al, 13
	ja	.L625
	mov	edx, 9217
	bt	rdx, rax
	jc	.L613
.L625:
	and	eax, -33
	cmp	al, 89
	sete	al
	movzx	eax, al
	jmp	.L607
.L646:
	cmp	eax, 10
	je	.L622
.L623:
	mov	rdi, qword [rel stdin]
	call	getc
	cmp	eax, -1
	jne	.L646
	jmp	.L622
.L644:
	test	ebx, ebx
	mov	eax, LC98
	mov	esi, LC100
	mov	rdx, qword [rel g_prompt_timeout]
	cmovne	rsi, rax
	mov	edi, LC104
	xor	eax, eax
	call	printf
	jmp	.L613
.L645:
	call	__errno_location
	cmp	dword [rax], 4
	je	.L615
	jmp	.L613
global set_use_binary
set_use_binary:
	xor	eax, eax
	test	edi, edi
	setne	al
	mov	dword [rel g_use_binary], eax
	ret
global get_use_binary
get_use_binary:
	mov	eax, dword [rel g_use_binary]
	ret
section .rodata
LC105:
	db "..", 0
global valid_gentoo_chroot_path
valid_gentoo_chroot_path:
	test	rdi, rdi
	je	.L653
	push	rbp
	xor	eax, eax
	push	rbx
	mov	rbx, rdi
	sub	rsp, 8
	movzx	ebp, byte [rdi]
	test	bpl, bpl
	je	.L649
	call	strlen
	sub	rax, 1
	cmp	rax, 499
	ja	.L657
	cmp	bpl, 47
	je	.L665
.L657:
	xor	eax, eax
.L649:
	add	rsp, 8
	pop	rbx
	pop	rbp
	ret
.L665:
	call	__ctype_b_loc
	mov	rbp, qword [rax]
	mov	eax, 47
	jmp	.L652
.L667:
	movzx	eax, byte [rbx+1]
	add	rbx, 1
	test	al, al
	je	.L666
.L652:
	movzx	edx, al
	test	byte [rbp+0+rdx*2], 8
	jne	.L651
	lea	edx, [rax-45]
	cmp	dl, 2
	jbe	.L651
	cmp	al, 95
	jne	.L657
.L651:
	mov	esi, LC105
	mov	rdi, rbx
	call	strstr
	test	rax, rax
	je	.L667
	xor	eax, eax
	jmp	.L649
.L653:
	xor	eax, eax
	ret
.L666:
	mov	eax, 1
	jmp	.L649
global set_gentoo_chroot
set_gentoo_chroot:
	xor	eax, eax
	test	edi, edi
	setne	al
	mov	dword [rel g_gentoo_chroot], eax
	ret
global get_gentoo_chroot
get_gentoo_chroot:
	mov	eax, dword [rel g_gentoo_chroot]
	ret
global set_portage_imitation
set_portage_imitation:
	xor	eax, eax
	test	edi, edi
	setne	al
	mov	dword [rel g_portage_imitation], eax
	ret
global get_portage_imitation
get_portage_imitation:
	mov	eax, dword [rel g_portage_imitation]
	or	eax, dword [rel g_gentoo_chroot]
	setne	al
	movzx	eax, al
	ret
global set_gentoo_chroot_path
set_gentoo_chroot_path:
	test	rdi, rdi
	je	.L681
	push	rbx
	mov	rbx, rdi
	call	valid_gentoo_chroot_path
	test	eax, eax
	jne	.L684
	pop	rbx
	ret
.L684:
	mov	rcx, rbx
	mov	edx, LC42
	mov	esi, 512
	xor	eax, eax
	mov	edi, g_gentoo_chroot_path
	pop	rbx
	jmp	xsnprintf
.L681:
	ret
global get_gentoo_chroot_path
get_gentoo_chroot_path:
	mov	eax, g_gentoo_chroot_path
	ret
g_gentoo_chroot_path:
	db "/usr/local/emerge/gentoo-chroot", 0
	times 480 db 0
g_use_pipe:
	dd 1
g_opt_level:
	db "3", 0
	times 14 db 0
g_target_arch:
	db "native", 0
	times 121 db 0
g_prompt_timeout:
	dq 300
g_emerge_confirm:
	dd 1
g_aur_sync:
	dd 1
g_sync:
	dd 1
g_inhibit:
	dd 1
g_import_keys:
	dd 1
section .rodata
LC39:
	db 39
	db 92
	db 39
	db 39
