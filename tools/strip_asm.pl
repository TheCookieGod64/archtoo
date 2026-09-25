#!/usr/bin/perl
# strip_asm.pl - remove all bloatware from objconv-generated NASM output
use strict; use warnings;
my ($in, $out, $mod) = @ARGV;
open my $fh, '<', $in or die "open $in: $!";
my $src = do { local $/; <$fh> }; close $fh;

# 1. CRLF -> LF
$src =~ s/\r\n/\n/g;

# 2. Hand-written banner replaces objconv timestamp header
$src =~ s/\A(?:;[^\n]*\n)+//;
my $header = "; ---------------------------------------------------------\n"
           . ";  archtoo v3.0.0 - Gentoo-style compile engine for Arch\n"
           . ";  $mod.asm - x86-64, SysV ABI\n"
           . ";  assemble: nasm -f elf64 $mod.asm -o $mod.o\n"
           . "; ---------------------------------------------------------\n";
$src = $header . $src;

# 3. Remove bloat sections: eh_frame, note, comment, debug, gcc_except_table
$src =~ s{^SECTION \.(?:eh_frame[.\w]*|note[.\w]*|comment|debug[.\w]*|gcc_except_table|annnotations?|tbss)[^\n]*\n.*?(?=^SECTION |\z)}{}gms;

# 4. Rename GAS-style local labels to valid NASM identifiers
$src =~ s/\?_(\d+)/loc_$1/g;
$src =~ s/\.LC(\d+)/str_LC$1/g;

# 4b. Fix objconv 2.57 AVX512VL misrender: EVEX.L'L=01 (ymm) printed as zmm
$src =~ s/vpermi2q zmm(\d+), zmm(\d+), zword \[/vpermi2q ymm$1, ymm$2, [/g;

# 5. Strip objconv trailing comments (dumps, linkage tags, annotations)
$src =~ s/[ \t]+; near$//mg;
$src =~ s/[ \t]+; section number[^\n]*$//mg;
$src =~ s/[ \t]+;[ \t]*[0-9A-Fa-f]{4,8} _.*$//mg;
$src =~ s/[ \t]*; (?:[\w.\$]+ )?End of function\n//mg;
$src =~ s/[ \t]+; Function begin$//mg;
$src =~ s/[ \t]*;[ \t]*(?:Local|External|Exported) function$//mg;
$src =~ s/[ \t]*;[ \t]*(?:Local|Exported) (?:data|object)$//mg;
$src =~ s/[ \t]*;[ \t]*(?:byte|word|dword|qword|tbyte|oword)$//mg;

# 6. MASM-style 1AH -> 0x1A
$src =~ s/\b([0-9][0-9A-F]*)H\b/0x$1/g;

# 7. 8-space indent -> tab
$src =~ s/^ {8}/\t/mg;

# 8. Remove empty sections
$src =~ s{^SECTION [^\n]*\n(?=(?:[ \t]*\n)*SECTION )}{}gm;
$src =~ s{^SECTION [^\n]*\n(?=(?:[ \t]*\n)*\z)}{}gm;

# 9. Tidy whitespace
$src =~ s/[ \t]+$//mg;
$src =~ s/\n{3,}/\n\n/g;

open my $ofh, '>', $out or die "open $out: $!";
print $ofh $src; close $ofh;
