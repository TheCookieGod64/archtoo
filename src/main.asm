; main.asm - Archtoo Emerge Engine v3.0.0
; Pure NASM x86_64 - handwritten from scratch

; NASM assembly - converted from C: src/main.c
%use smartalign
section .text
global main
main:
	jmp	archtoo_cli_main
