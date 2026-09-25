#!/usr/bin/perl
# strip_gcc_asm.pl - kaalknijp gcc -S (GAS) output tot hand-kaale .s (ARM-editie)
use strict; use warnings;
my ($in,$out) = @ARGV;
open my $fh,'<',$in or die "open $in: $!";
open my $oh,'>',$out or die "open $out: $!";
while (my $l = <$fh>) {
    next if $l =~ /^\s*#|^\s*\.cfi|^\s*\.file|^\s*\.loc|^\s*\.size|^\s*\.ident|^\s*$/;
    print $oh $l;
}
close $fh; close $oh;
