; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  main.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 main.asm -o main.o
; ---------------------------------------------------------

global main: function

extern archtoo_cli_main

SECTION .text.startup align=16 exec

main:
	lea     ecx, [esp+0x4]
	and     esp, 0x0FFFFFFF0
	push    dword [ecx-0x4]
	push    ebp
	mov     ebp, esp
	push    ecx
	sub     esp, 12
	push    dword [ecx+0x4]
	push    dword [ecx]
	call    archtoo_cli_main
	mov     ecx, dword [ebp-0x4]
	add     esp, 16
	leave
	lea     esp, [ecx-0x4]
	ret

