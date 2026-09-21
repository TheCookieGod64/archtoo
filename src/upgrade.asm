; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  upgrade.asm - x86-64, SysV ABI
;  assemble: nasm -f elf64 upgrade.asm -o upgrade.o
; ---------------------------------------------------------

default rel

global cmd_upgrade_v2: function

extern cmd_world_update

SECTION .text   align=16 exec

cmd_upgrade_v2:; Function begin
	jmp     cmd_world_update

