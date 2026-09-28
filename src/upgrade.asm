; ---------------------------------------------------------
;  archtoo v3.0.0 - Gentoo-style compile engine for Arch
;  upgrade.asm - i686, cdecl (32-bit SysV)
;  assemble: nasm -f elf32 upgrade.asm -o upgrade.o
; ---------------------------------------------------------

global cmd_upgrade_v2: function

extern cmd_world_update

SECTION .text   align=16 exec

cmd_upgrade_v2:; Function begin
	jmp     cmd_world_update

