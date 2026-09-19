; upgrade.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

%use smartalign
section .text
global cmd_upgrade_v2
cmd_upgrade_v2:
	jmp	cmd_world_update
