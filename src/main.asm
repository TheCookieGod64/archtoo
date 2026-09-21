; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  main.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 main.asm -o main.o
; ---------------------------------------------------------

default rel

global main: function

extern archtoo_cli_main

SECTION .text.startup align=16 exec

main:
	jmp     archtoo_cli_main

