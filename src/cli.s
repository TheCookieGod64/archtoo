	.arch armv7-a
	.fpu neon
	.text
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"1.0.0\000"
	.align	2
.LC1:
	.ascii	"Archtoo Emerge Engine\000"
	.align	2
.LC2:
	.ascii	"\033[1;36m%s v%s\012\033[0m\000"
	.align	2
.LC3:
	.ascii	"Usage:\000"
	.align	2
.LC4:
	.ascii	"  emerge <package>...    Build and install packages"
	.ascii	" (-I alias)\000"
	.align	2
.LC5:
	.ascii	"  emerge -S <query>       Search repositories and A"
	.ascii	"UR\000"
	.align	2
.LC6:
	.ascii	"  emerge -I <package>...  Install packages\000"
	.align	2
.LC7:
	.ascii	"  emerge -Q <package>...  Query installed packages\000"
	.align	2
.LC8:
	.ascii	"  emerge -A <package>...  Show repository/AUR infor"
	.ascii	"mation\000"
	.align	2
.LC9:
	.ascii	"  emerge -G <package>...  Download AUR PKGBUILDs\000"
	.align	2
.LC10:
	.ascii	"  emerge -B <directory>   Build a local PKGBUILD\000"
	.align	2
.LC11:
	.ascii	"  emerge -C <package>... Unmerge and remove package"
	.ascii	"s\000"
	.align	2
.LC12:
	.ascii	"  emerge --orphans        List orphaned dependencie"
	.ascii	"s\000"
	.align	2
.LC13:
	.ascii	"  emerge --clean          Clean package caches\000"
	.align	2
.LC14:
	.ascii	"  emerge --stats          Show package statistics\000"
	.align	2
.LC15:
	.ascii	"  emerge --news           Show recent Arch news\000"
	.align	2
.LC16:
	.ascii	"  emerge --providers <n>  Packages that provide <n>"
	.ascii	" (exact/Provides)\000"
	.align	2
.LC17:
	.ascii	"  emerge --deps <n>       Dependency plan (repo or "
	.ascii	"AUR, graph order)\000"
	.align	2
.LC18:
	.ascii	"  emerge --devel          List installed VCS packag"
	.ascii	"es (-git/-hg/...)\000"
	.align	2
.LC19:
	.ascii	"  emerge --review <dir>   Show PKGBUILD / .SRCINFO "
	.ascii	"for review\000"
	.align	2
.LC20:
	.ascii	"  emerge --complete       Print CLI flags and repo "
	.ascii	"package names\000"
	.align	2
.LC21:
	.ascii	"  emerge -U              World update: pacman -Syu,"
	.ascii	" then rebuild @world\000"
	.align	2
.LC22:
	.ascii	"  emerge -D <package>... Deselect: unlock and drop "
	.ascii	"from @world,\000"
	.align	2
.LC23:
	.ascii	"                         but keep the package insta"
	.ascii	"lled\000"
	.align	2
.LC24:
	.ascii	"  emerge -v              Show version information\000"
	.align	2
.LC25:
	.ascii	"\012Options:\000"
	.align	2
.LC26:
	.ascii	"  --noconfirm            Never prompt; use safe def"
	.ascii	"aults\000"
	.align	2
.LC27:
	.ascii	"  -i, --interactive      Enable pacman confirmation"
	.ascii	" prompts\000"
	.align	2
.LC28:
	.ascii	"  --prompt-timeout SEC   Archtoo prompt timeout (0 "
	.ascii	"waits forever)\000"
	.align	2
.LC29:
	.ascii	"  -j, --jobs N           Parallel build jobs (defau"
	.ascii	"lt: all cores)\000"
	.align	2
.LC30:
	.ascii	"  --target ARCH          Custom -march target (defa"
	.ascii	"ult: native)\000"
	.align	2
.LC31:
	.ascii	"                         e.g. skylake, znver3, x86-"
	.ascii	"64-v3, native\000"
	.align	2
.LC32:
	.ascii	"  --target=ARCH          Same as --target ARCH\000"
	.align	2
.LC33:
	.ascii	"  --march=ARCH           Alias for --target=ARCH\000"
	.align	2
.LC34:
	.ascii	"  --opt-level LEVEL      Optimization: 0,1,2,3,s,fa"
	.ascii	"st,g,z (default: 3)\000"
	.align	2
.LC35:
	.ascii	"                         e.g. -O2, 2, s, fast\000"
	.align	2
.LC36:
	.ascii	"  --opt=LEVEL            Alias for --opt-level\000"
	.align	2
.LC37:
	.ascii	"  -O0,-O1,-O2,-O3,-Os,-Ofast,-Og,-Oz  Short forms\000"
	.align	2
.LC38:
	.ascii	"  --raw \"FLAGS\"          Extra raw flags appended"
	.ascii	" to CFLAGS/CXXFLAGS/LDFLAGS\000"
	.align	2
.LC39:
	.ascii	"                         e.g. --raw \"-march=native"
	.ascii	" -fuse-ld=mold\" (plain options only)\000"
	.align	2
.LC40:
	.ascii	"  makepkg_raw (config)   Raw options passed to make"
	.ascii	"pkg itself,\000"
	.align	2
.LC41:
	.ascii	"                         e.g. makepkg_raw = \"--noc"
	.ascii	"heck\" (plain options only)\000"
	.align	2
.LC42:
	.ascii	"  --pipe                 Enable -pipe (default)\000"
	.align	2
.LC43:
	.ascii	"  --no-pipe              Disable -pipe\000"
	.align	2
.LC44:
	.ascii	"  --gentoo-chroot        Enable SUPER HARD Portage "
	.ascii	"imitation via Gentoo chroot\000"
	.align	2
.LC45:
	.ascii	"  --imitation            Alias for --gentoo-chroot\000"
	.align	2
.LC46:
	.ascii	"  --no-gentoo-chroot     Disable chroot imitation\000"
	.align	2
.LC47:
	.ascii	"  --chroot-path PATH     Custom chroot path (defaul"
	.ascii	"t: /usr/local/emerge/gentoo-chroot)\000"
	.align	2
.LC48:
	.ascii	"  --binary               Try sudo pacman -S first, "
	.ascii	"then yay-style AUR search for a prebuilt -bin (long"
	.ascii	" flag only)\000"
	.align	2
.LC49:
	.ascii	"                         Long flag only, no short f"
	.ascii	"orm\000"
	.align	2
.LC50:
	.ascii	"  --use-binary           Alias for --binary\000"
	.align	2
.LC51:
	.ascii	"  --no-binary            Disable binary mode\000"
	.align	2
.LC52:
	.ascii	"  -r, --resume           Reuse the existing build t"
	.ascii	"ree and continue\000"
	.align	2
.LC53:
	.ascii	"                         an interrupted compile\000"
	.align	2
.LC54:
	.ascii	"  --no-keys              Do not import missing PGP "
	.ascii	"signing keys\000"
	.align	2
.LC55:
	.ascii	"  --no-inhibit           Allow the machine to suspe"
	.ascii	"nd while building\000"
	.align	2
.LC56:
	.ascii	"  --no-sync              Skip pacman -Syu during a "
	.ascii	"world update\000"
	.align	2
.LC57:
	.ascii	"  --no-aur-sync          Reuse local AUR @world sou"
	.ascii	"rces; do not refresh\000"
	.align	2
.LC58:
	.ascii	"  --command-guide        Display the command guide "
	.ascii	"now\000"
	.align	2
.LC59:
	.ascii	"  --command-guide=MODE   Set guide mode: first-run,"
	.ascii	" always, never\000"
	.text
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.type	print_usage, %function
print_usage:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L4
	ldr	r1, .L4+4
	ldr	r0, .L4+8
.LPIC0:
	add	r2, pc
	push	{r3, lr}
.LPIC1:
	add	r1, pc
.LPIC2:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L4+12
.LPIC3:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+16
.LPIC4:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+20
.LPIC5:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+24
.LPIC6:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+28
.LPIC7:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+32
.LPIC8:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+36
.LPIC9:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+40
.LPIC10:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+44
.LPIC11:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+48
.LPIC12:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+52
.LPIC13:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+56
.LPIC14:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+60
.LPIC15:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+64
.LPIC16:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+68
.LPIC17:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+72
.LPIC18:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+76
.LPIC19:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+80
.LPIC20:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+84
.LPIC21:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+88
.LPIC22:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+92
.LPIC23:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+96
.LPIC24:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+100
.LPIC25:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+104
.LPIC26:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+108
.LPIC27:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+112
.LPIC28:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+116
.LPIC29:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+120
.LPIC30:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+124
.LPIC31:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+128
.LPIC32:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+132
.LPIC33:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+136
.LPIC34:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+140
.LPIC35:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+144
.LPIC36:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+148
.LPIC37:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+152
.LPIC38:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+156
.LPIC39:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+160
.LPIC40:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+164
.LPIC41:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+168
.LPIC42:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+172
.LPIC43:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+176
.LPIC44:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+180
.LPIC45:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+184
.LPIC46:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+188
.LPIC47:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+192
.LPIC48:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+196
.LPIC49:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+200
.LPIC50:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+204
.LPIC51:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+208
.LPIC52:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+212
.LPIC53:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+216
.LPIC54:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+220
.LPIC55:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+224
.LPIC56:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+228
.LPIC57:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+232
.LPIC58:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L4+236
	pop	{r3, lr}
.LPIC59:
	add	r0, pc
	b	puts(PLT)
.L5:
	.align	2
.L4:
	.word	.LC0-(.LPIC0+4)
	.word	.LC1-(.LPIC1+4)
	.word	.LC2-(.LPIC2+4)
	.word	.LC3-(.LPIC3+4)
	.word	.LC4-(.LPIC4+4)
	.word	.LC5-(.LPIC5+4)
	.word	.LC6-(.LPIC6+4)
	.word	.LC7-(.LPIC7+4)
	.word	.LC8-(.LPIC8+4)
	.word	.LC9-(.LPIC9+4)
	.word	.LC10-(.LPIC10+4)
	.word	.LC11-(.LPIC11+4)
	.word	.LC12-(.LPIC12+4)
	.word	.LC13-(.LPIC13+4)
	.word	.LC14-(.LPIC14+4)
	.word	.LC15-(.LPIC15+4)
	.word	.LC16-(.LPIC16+4)
	.word	.LC17-(.LPIC17+4)
	.word	.LC18-(.LPIC18+4)
	.word	.LC19-(.LPIC19+4)
	.word	.LC20-(.LPIC20+4)
	.word	.LC21-(.LPIC21+4)
	.word	.LC22-(.LPIC22+4)
	.word	.LC23-(.LPIC23+4)
	.word	.LC24-(.LPIC24+4)
	.word	.LC25-(.LPIC25+4)
	.word	.LC26-(.LPIC26+4)
	.word	.LC27-(.LPIC27+4)
	.word	.LC28-(.LPIC28+4)
	.word	.LC29-(.LPIC29+4)
	.word	.LC30-(.LPIC30+4)
	.word	.LC31-(.LPIC31+4)
	.word	.LC32-(.LPIC32+4)
	.word	.LC33-(.LPIC33+4)
	.word	.LC34-(.LPIC34+4)
	.word	.LC35-(.LPIC35+4)
	.word	.LC36-(.LPIC36+4)
	.word	.LC37-(.LPIC37+4)
	.word	.LC38-(.LPIC38+4)
	.word	.LC39-(.LPIC39+4)
	.word	.LC40-(.LPIC40+4)
	.word	.LC41-(.LPIC41+4)
	.word	.LC42-(.LPIC42+4)
	.word	.LC43-(.LPIC43+4)
	.word	.LC44-(.LPIC44+4)
	.word	.LC45-(.LPIC45+4)
	.word	.LC46-(.LPIC46+4)
	.word	.LC47-(.LPIC47+4)
	.word	.LC48-(.LPIC48+4)
	.word	.LC49-(.LPIC49+4)
	.word	.LC50-(.LPIC50+4)
	.word	.LC51-(.LPIC51+4)
	.word	.LC52-(.LPIC52+4)
	.word	.LC53-(.LPIC53+4)
	.word	.LC54-(.LPIC54+4)
	.word	.LC55-(.LPIC55+4)
	.word	.LC56-(.LPIC56+4)
	.word	.LC57-(.LPIC57+4)
	.word	.LC58-(.LPIC58+4)
	.word	.LC59-(.LPIC59+4)
	.section	.rodata.str1.4
	.align	2
.LC60:
	.ascii	"yes\000"
	.align	2
.LC61:
	.ascii	"no\000"
	.align	2
.LC62:
	.ascii	"on\000"
	.align	2
.LC63:
	.ascii	"off\000"
	.align	2
.LC64:
	.ascii	"none\000"
	.align	2
.LC65:
	.ascii	"SUDO_USER\000"
	.align	2
.LC66:
	.ascii	"\033[1;31m[-] Running as a root login is not suppor"
	.ascii	"ted.\012    makepkg refuses to build as root, and t"
	.ascii	"here is no SUDO_USER\012    to drop back to. Use 's"
	.ascii	"udo emerge <package>' from your\012    normal accou"
	.ascii	"nt instead.\012\033[0m\000"
	.align	2
.LC67:
	.ascii	"native\000"
	.align	2
.LC68:
	.ascii	"\033[1;36mCurrent config: target=%s opt=-O%s pipe=%"
	.ascii	"s chroot=%s binary=%s path=%s raw=%s makepkg=%s\012"
	.ascii	"\033[0m\000"
	.align	2
.LC69:
	.ascii	"--version\000"
	.align	2
.LC70:
	.ascii	"%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary"
	.ascii	"=%s)\012\000"
	.align	2
.LC71:
	.ascii	"Copyright (C) 2026 TheCookieGod64\000"
	.align	2
.LC72:
	.ascii	"License GPLv3+: GNU GPL version 3 or later <https:/"
	.ascii	"/gnu.org/licenses/gpl.html>\000"
	.align	2
.LC73:
	.ascii	"--help\000"
	.align	2
.LC74:
	.ascii	"\033[1;36m\012Active config: target=%s opt=-O%s pip"
	.ascii	"e=%s raw=%s makepkg=%s\012\033[0m\000"
	.align	2
.LC75:
	.ascii	"--noconfirm\000"
	.align	2
.LC76:
	.ascii	"--command-guide\000"
	.align	2
.LC77:
	.ascii	"--command-guide=\000"
	.align	2
.LC78:
	.ascii	"\033[1;31m[-] Invalid command-guide mode (use first"
	.ascii	"-run, always, or never).\012\033[0m\000"
	.align	2
.LC79:
	.ascii	"--interactive\000"
	.align	2
.LC80:
	.ascii	"--prompt-timeout\000"
	.align	2
.LC81:
	.ascii	"\033[1;31m[-] --prompt-timeout needs seconds.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC82:
	.ascii	"\033[1;31m[-] Invalid timeout (expected 0-86400).\012"
	.ascii	"\033[0m\000"
	.align	2
.LC83:
	.ascii	"--resume\000"
	.align	2
.LC84:
	.ascii	"--no-keys\000"
	.align	2
.LC85:
	.ascii	"--no-inhibit\000"
	.align	2
.LC86:
	.ascii	"--no-sync\000"
	.align	2
.LC87:
	.ascii	"--no-aur-sync\000"
	.align	2
.LC88:
	.ascii	"--pipe\000"
	.align	2
.LC89:
	.ascii	"--no-pipe\000"
	.align	2
.LC90:
	.ascii	"--jobs\000"
	.align	2
.LC91:
	.ascii	"\033[1;31m[-] %s needs a number.\012\033[0m\000"
	.align	2
.LC92:
	.ascii	"\033[1;31m[-] Invalid job count '%s' (expected 1-10"
	.ascii	"24).\012\033[0m\000"
	.align	2
.LC93:
	.ascii	"--jobs=\000"
	.align	2
.LC94:
	.ascii	"\033[1;31m[-] Invalid job count.\012\033[0m\000"
	.align	2
.LC95:
	.ascii	"--target\000"
	.align	2
.LC96:
	.ascii	"--march\000"
	.align	2
.LC97:
	.ascii	"--cpu\000"
	.align	2
.LC98:
	.ascii	"\033[1;31m[-] %s needs an architecture name.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC99:
	.ascii	"help\000"
	.align	2
.LC100:
	.ascii	"list\000"
	.align	2
.LC101:
	.ascii	"\033[1;31m[-] Invalid target '%s'. Use --target hel"
	.ascii	"p.\012\033[0m\000"
	.align	2
.LC102:
	.ascii	"--target=\000"
	.align	2
.LC103:
	.ascii	"\033[1;31m[-] --target= needs a value.\012\033[0m\000"
	.align	2
.LC104:
	.ascii	"--march=\000"
	.align	2
.LC105:
	.ascii	"\033[1;31m[-] --march= needs a value.\012\033[0m\000"
	.align	2
.LC106:
	.ascii	"\033[1;31m[-] Invalid march '%s'.\012\033[0m\000"
	.align	2
.LC107:
	.ascii	"--cpu=\000"
	.align	2
.LC108:
	.ascii	"\033[1;31m[-] --cpu= needs a value.\012\033[0m\000"
	.align	2
.LC109:
	.ascii	"\033[1;31m[-] Invalid cpu '%s'.\012\033[0m\000"
	.align	2
.LC110:
	.ascii	"--opt-level\000"
	.align	2
.LC111:
	.ascii	"--opt\000"
	.align	2
.LC112:
	.ascii	"--optimization\000"
	.align	2
.LC113:
	.ascii	"-O\000"
	.align	2
.LC114:
	.ascii	"\033[1;31m[-] %s needs a level (0,1,2,3,s,fast,g,z)"
	.ascii	".\012\033[0m\000"
	.align	2
.LC115:
	.ascii	"\033[1;31m[-] Invalid opt level '%s'. Use --opt-lev"
	.ascii	"el help.\012\033[0m\000"
	.align	2
.LC116:
	.ascii	"--opt-level=\000"
	.align	2
.LC117:
	.ascii	"\033[1;31m[-] --opt-level= needs a value.\012\033[0"
	.ascii	"m\000"
	.align	2
.LC118:
	.ascii	"\033[1;31m[-] Invalid opt level '%s'.\012\033[0m\000"
	.align	2
.LC119:
	.ascii	"--opt=\000"
	.align	2
.LC120:
	.ascii	"\033[1;31m[-] Invalid opt '%s'.\012\033[0m\000"
	.align	2
.LC121:
	.ascii	"--optimization=\000"
	.align	2
.LC122:
	.ascii	"\033[1;31m[-] Invalid optimization '%s'.\012\033[0m"
	.ascii	"\000"
	.align	2
.LC123:
	.ascii	"-O0\000"
	.align	2
.LC124:
	.ascii	"-O1\000"
	.align	2
.LC125:
	.ascii	"-O2\000"
	.align	2
.LC126:
	.ascii	"-O3\000"
	.align	2
.LC127:
	.ascii	"-Os\000"
	.align	2
.LC128:
	.ascii	"-Oz\000"
	.align	2
.LC129:
	.ascii	"-Og\000"
	.align	2
.LC130:
	.ascii	"-Ofast\000"
	.align	2
.LC131:
	.ascii	"fast\000"
	.align	2
.LC132:
	.ascii	"--raw\000"
	.align	2
.LC133:
	.ascii	"\033[1;31m[-] --raw needs a flags string.\012\033[0"
	.ascii	"m\000"
	.align	2
.LC134:
	.ascii	"\033[1;31m[-] Invalid --raw: plain options only (-m"
	.ascii	"arch=x, -fuse-ld=y; no shell metacharacters, <= 192"
	.ascii	" chars).\012\033[0m\000"
	.align	2
.LC135:
	.ascii	"--raw=\000"
	.align	2
.LC136:
	.ascii	"--gentoo-chroot\000"
	.align	2
.LC137:
	.ascii	"--imitation\000"
	.align	2
.LC138:
	.ascii	"--portage-imitation\000"
	.align	2
.LC139:
	.ascii	"--gentoo-imitation\000"
	.align	2
.LC140:
	.ascii	"--no-gentoo-chroot\000"
	.align	2
.LC141:
	.ascii	"--no-imitation\000"
	.align	2
.LC142:
	.ascii	"--chroot-path=\000"
	.align	2
.LC143:
	.ascii	"\033[1;31m[-] Invalid chroot path '%s'\012\033[0m\000"
	.align	2
.LC144:
	.ascii	"--chroot-path\000"
	.align	2
.LC145:
	.ascii	"\033[1;31m[-] --chroot-path needs a path\012\033[0m"
	.ascii	"\000"
	.align	2
.LC146:
	.ascii	"--binary\000"
	.align	2
.LC147:
	.ascii	"--use-binary\000"
	.align	2
.LC148:
	.ascii	"--use-bin\000"
	.align	2
.LC149:
	.ascii	"--bin\000"
	.align	2
.LC150:
	.ascii	"--prebuilt\000"
	.align	2
.LC151:
	.ascii	"--use-prebuilt\000"
	.align	2
.LC152:
	.ascii	"--no-build\000"
	.align	2
.LC153:
	.ascii	"--no-compile\000"
	.align	2
.LC154:
	.ascii	"--no-binary\000"
	.align	2
.LC155:
	.ascii	"--no-use-binary\000"
	.align	2
.LC156:
	.ascii	"--no-bin\000"
	.align	2
.LC157:
	.ascii	"--no-prebuilt\000"
	.align	2
.LC158:
	.ascii	"\033[1;36mCurrent: target=%s opt=-O%s pipe=%s chroo"
	.ascii	"t=%s binary=%s jobs=%ld path=%s\012\033[0m\000"
	.align	2
.LC159:
	.ascii	"\033[1;31m[-] Search requires exactly one query.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC160:
	.ascii	"-A\000"
	.align	2
.LC161:
	.ascii	"\033[1;31m[-] This operation requires a package.\012"
	.ascii	"\033[0m\000"
	.align	2
.LC162:
	.ascii	"--orphans\000"
	.align	2
.LC163:
	.ascii	"--stats\000"
	.align	2
.LC164:
	.ascii	"--news\000"
	.align	2
.LC165:
	.ascii	"--complete\000"
	.align	2
.LC166:
	.ascii	"--devel\000"
	.align	2
.LC167:
	.ascii	"--providers\000"
	.align	2
.LC168:
	.ascii	"--deps\000"
	.align	2
.LC169:
	.ascii	"--review\000"
	.align	2
.LC170:
	.ascii	"\033[1;31m[-] --review requires a directory.\012\033"
	.ascii	"[0m\000"
	.align	2
.LC171:
	.ascii	"-I\000"
	.align	2
.LC172:
	.ascii	"-G\000"
	.align	2
.LC173:
	.ascii	"-B\000"
	.align	2
.LC174:
	.ascii	"--clean\000"
	.align	2
.LC175:
	.ascii	"-U\000"
	.align	2
.LC176:
	.ascii	"--update\000"
	.align	2
.LC177:
	.ascii	"-D\000"
	.align	2
.LC178:
	.ascii	"--deselect\000"
	.align	2
.LC179:
	.ascii	"\033[1;31m[-] Error: specify a package to deselect."
	.ascii	"\012\033[0m\000"
	.align	2
.LC180:
	.ascii	"-C\000"
	.align	2
.LC181:
	.ascii	"--unmerge\000"
	.align	2
.LC182:
	.ascii	"\033[1;31m[-] Error: specify a package name to unme"
	.ascii	"rge.\012\033[0m\000"
	.align	2
.LC183:
	.ascii	"\033[1;31m[-] Unknown option: %s\012\033[0m\000"
	.align	2
.LC184:
	.ascii	"\033[1;31m[-] Invalid package name: '%s'\012\033[0m"
	.ascii	"\000"
	.align	2
.LC185:
	.ascii	"\033[1;35m\012>>> [%d/%d] %s (binary mode)\012\033["
	.ascii	"0m\000"
	.align	2
.LC186:
	.ascii	"\033[1;31m\012[-] %d package(s) failed in binary mo"
	.ascii	"de.\012\033[0m\000"
	.align	2
.LC187:
	.ascii	"\033[1;35m\012>>> [%d/%d] %s (Gentoo chroot imitati"
	.ascii	"on)\012\033[0m\000"
	.align	2
.LC188:
	.ascii	"\033[1;31m\012[-] %d package(s) failed in Gentoo ch"
	.ascii	"root mode.\012\033[0m\000"
	.align	2
.LC189:
	.ascii	"\033[1;35m\012>>> [%d/%d] %s\012\033[0m\000"
	.align	2
.LC190:
	.ascii	"\033[1;31m\012[-] %d package(s) failed.\012\033[0m\000"
	.align	2
.LC191:
	.ascii	"\033[1;33m    Tip: 'emerge --resume %s' continues f"
	.ascii	"rom the existing\012    build tree instead of start"
	.ascii	"ing over.\012\033[0m\000"
	.align	2
.LC192:
	.ascii	"-Q\000"
	.text
	.align	1
	.p2align 2,,3
	.global	archtoo_cli_main
	.syntax unified
	.thumb
	.thumb_func
	.type	archtoo_cli_main, %function
archtoo_cli_main:
	@ args = 0, pretend = 0, frame = 1048
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r6, r0
	ldr	r7, .L533
	subw	sp, sp, #1076
	mov	r4, r1
.LPIC91:
	add	r7, pc
	bl	geteuid(PLT)
	cbnz	r0, .L7
	ldr	r0, .L533+4
.LPIC90:
	add	r0, pc
	bl	getenv(PLT)
	cmp	r0, #0
	beq	.L472
.L7:
	bl	load_user_config(PLT)
	cmp	r6, #1
	ble	.L473
	ldr	r5, [r4, #4]
	ldrb	r8, [r5]	@ zero_extendqisi2
	cmp	r8, #45
	bne	.L238
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	cmp	r3, #118
	bne	.L238
	ldrb	r3, [r5, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L238
.L21:
	bl	get_target_arch(PLT)
	mov	r5, r0
	bl	get_opt_level(PLT)
	mov	r4, r0
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	bne	.L474
	ldr	r6, .L533+8
.LPIC69:
	add	r6, pc
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	beq	.L223
.L493:
	ldr	r7, .L533+12
.LPIC70:
	add	r7, pc
	bl	get_use_binary(PLT)
	cmp	r0, #0
	beq	.L224
.L494:
	ldr	r2, .L533+16
.LPIC72:
	add	r2, pc
.L25:
	str	r2, [sp, #12]
	mov	r3, r5
	ldr	r2, .L533+20
	ldr	r1, .L533+24
	ldr	r0, .L533+28
.LPIC96:
	add	r2, pc
.LPIC97:
	add	r1, pc
	strd	r6, r7, [sp, #4]
.LPIC98:
	add	r0, pc
	str	r4, [sp]
	bl	printf(PLT)
	ldr	r0, .L533+32
.LPIC99:
	add	r0, pc
	bl	puts(PLT)
	ldr	r0, .L533+36
.LPIC100:
	add	r0, pc
	bl	puts(PLT)
.L26:
	movs	r0, #0
.L6:
	addw	sp, sp, #1076
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L238:
	ldr	r1, .L533+40
	mov	r0, r5
.LPIC95:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L21
	cmp	r8, #45
	bne	.L239
	ldrb	r3, [r5, #1]	@ zero_extendqisi2
	cmp	r3, #104
	beq	.L475
.L239:
	ldr	r1, .L533+44
	mov	r0, r5
.LPIC101:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L28
	ldr	r3, .L533+48
	movs	r5, #1
	mov	fp, #0
.LPIC104:
	add	r3, pc
	str	r3, [sp, #24]
	ldr	r3, .L533+52
.LPIC105:
	add	r3, pc
	str	r3, [sp, #28]
	ldr	r3, .L533+56
.LPIC106:
	add	r3, pc
	strd	r3, r7, [sp, #32]
.L29:
	ldr	r7, [r4, r5, lsl #2]
	lsl	r8, r5, #2
	ldr	r1, [sp, #24]
	add	r9, r4, r8
	mov	r0, r7
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L476
	ldr	r1, [sp, #28]
	mov	r0, r7
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L477
	ldr	r1, [sp, #32]
	movs	r2, #16
	mov	r0, r7
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L478
	ldrb	r10, [r7]	@ zero_extendqisi2
	cmp	r10, #45
	bne	.L240
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	cmp	r3, #105
	beq	.L479
.L240:
	ldr	r1, .L533+60
	mov	r0, r7
.LPIC108:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L43
	ldr	r1, .L533+64
	mov	r0, r7
.LPIC109:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r3, r0
	cmp	r0, #0
	bne	.L45
	adds	r5, r5, #1
	cmp	r5, r6
	bge	.L480
	add	r7, sp, #44
	movs	r2, #10
	ldr	r0, [r9, #4]
	mov	r1, r7
	str	r3, [sp, #44]
	bl	strtol(PLT)
	ldr	r2, [sp, #44]
	cbz	r2, .L48
	ldrb	r2, [r2]	@ zero_extendqisi2
	cbnz	r2, .L48
	mov	r2, #20864
	movt	r2, 1
	cmp	r0, r2
	bls	.L49
.L48:
	ldr	r3, .L533+68
	movs	r2, #51
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L533+72
	ldr	r3, [r7, r3]
.LPIC111:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
.L8:
	movs	r0, #1
	addw	sp, sp, #1076
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L478:
	add	r0, r7, #16
	add	r7, sp, #44
	mov	r1, r7
	bl	guide_policy_parse(PLT)
	cmp	r0, #0
	bne	.L41
	ldr	r3, .L533+68
	movs	r2, #77
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L533+76
	ldr	r3, [r7, r3]
.LPIC107:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L475:
	ldrb	r3, [r5, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L239
.L28:
	bl	print_usage(PLT)
	bl	get_target_arch(PLT)
	ldr	r1, .L533+80
.LPIC102:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L30
.L33:
	bl	get_target_arch(PLT)
	mov	r4, r0
	bl	get_opt_level(PLT)
	mov	r5, r0
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L226
	ldr	r7, .L533+84
.LPIC74:
	add	r7, pc
.L31:
	bl	get_raw_flags(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L481
	ldr	r6, .L533+88
.LPIC76:
	add	r6, pc
.L34:
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L482
	ldr	r0, .L533+92
.LPIC77:
	add	r0, pc
.L35:
	str	r0, [sp, #4]
	mov	r3, r7
	ldr	r0, .L533+96
	mov	r2, r5
	mov	r1, r4
	str	r6, [sp]
.LPIC103:
	add	r0, pc
	bl	printf(PLT)
	b	.L26
.L479:
	ldrb	r3, [r7, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L240
.L43:
	movs	r0, #1
	bl	set_interactive(PLT)
.L39:
	adds	r5, r5, #1
	cmp	fp, #255
	it	ne
	cmpne	r6, r5
	ite	gt
	movgt	r3, #1
	movle	r3, #0
	bgt	.L29
	add	r8, sp, #48
	ldr	r7, [sp, #36]
	str	r3, [r8, fp, lsl #2]
	bl	guide_maybe_show(PLT)
	cmp	fp, #1
	beq	.L483
	cmp	fp, #0
	beq	.L484
	ldr	r9, [r8]
	ldrb	r3, [r9]	@ zero_extendqisi2
	cmp	r3, #45
	beq	.L485
.L149:
	ldr	r1, .L533+100
	mov	r0, r9
.LPIC211:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L486
	ldr	r1, .L533+104
	mov	r0, r9
.LPIC212:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L487
	ldr	r1, .L533+108
	mov	r0, r9
.LPIC213:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L488
	ldr	r1, .L533+112
	mov	r0, r9
.LPIC214:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L489
	ldr	r1, .L533+116
	mov	r0, r9
.LPIC215:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L490
	ldr	r1, .L533+120
	mov	r0, r9
.LPIC216:
	add	r1, pc
	bl	strcmp(PLT)
	sub	r3, fp, #2
	rsbs	r5, r3, #0
	adcs	r5, r5, r3
	cbnz	r0, .L159
	cmp	r5, #0
	bne	.L491
.L159:
	ldr	r1, .L533+124
	mov	r0, r9
.LPIC217:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L160
	cmp	r5, #0
	bne	.L492
.L160:
	ldr	r1, .L533+128
	mov	r0, r9
.LPIC218:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L161
	cmp	fp, #2
	beq	.L162
	ldr	r3, .L533+68
	movs	r2, #46
	ldr	r0, .L533+132
	movs	r1, #1
.LPIC219:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L474:
	ldr	r6, .L533+136
.LPIC68:
	add	r6, pc
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	bne	.L493
.L223:
	ldr	r7, .L533+140
.LPIC71:
	add	r7, pc
	bl	get_use_binary(PLT)
	cmp	r0, #0
	bne	.L494
.L224:
	ldr	r2, .L533+144
.LPIC73:
	add	r2, pc
	b	.L25
.L45:
	cmp	r10, #45
	bne	.L241
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	cmp	r3, #114
	beq	.L495
.L241:
	ldr	r1, .L533+148
	mov	r0, r7
.LPIC112:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L51
	ldr	r1, .L533+152
	mov	r0, r7
.LPIC113:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L496
	ldr	r1, .L533+156
	mov	r0, r7
.LPIC114:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L497
	ldr	r1, .L533+160
	mov	r0, r7
.LPIC115:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L498
	ldr	r1, .L533+164
	mov	r0, r7
.LPIC116:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L499
	ldr	r1, .L533+168
	mov	r0, r7
.LPIC117:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L500
	ldr	r1, .L533+172
	mov	r0, r7
.LPIC118:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L501
	cmp	r10, #45
	bne	.L242
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	cmp	r3, #106
	bne	.L242
	ldrb	r3, [r7, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L242
.L60:
	adds	r5, r5, #1
	cmp	r5, r6
	bge	.L502
	add	r8, r8, #4
	add	r7, sp, #44
	movs	r2, #10
	mov	r1, r7
	movs	r3, #0
	str	r3, [sp, #44]
	ldr	r0, [r4, r8]
	bl	strtol(PLT)
	ldr	r2, [sp, #44]
	cbz	r2, .L64
	ldrb	r2, [r2]	@ zero_extendqisi2
	cbnz	r2, .L64
	subs	r3, r0, #1
	cmp	r3, #1024
	bcc	.L72
.L64:
	ldr	r3, .L533+68
	ldr	r7, [sp, #36]
	ldr	r1, .L533+176
	ldr	r2, [r4, r8]
	ldr	r3, [r7, r3]
.LPIC121:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L41:
	ldr	r0, [r7]
	bl	guide_set_policy(PLT)
	b	.L39
.L30:
	bl	get_opt_level(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #51
	bne	.L33
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L33
	bl	get_raw_flags(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L33
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L33
	b	.L26
.L476:
	movs	r0, #1
	bl	set_noconfirm(PLT)
	b	.L39
.L477:
	bl	guide_request_explicit(PLT)
	b	.L39
.L473:
	bl	get_target_arch(PLT)
	ldr	r1, .L533+180
.LPIC93:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L13
	bl	get_opt_level(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #51
	beq	.L503
.L13:
	bl	get_target_arch(PLT)
	mov	r4, r0
	bl	get_opt_level(PLT)
	mov	r5, r0
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L217
	ldr	r10, .L533+184
.LPIC60:
	add	r10, pc
.L11:
	bl	get_gentoo_chroot(PLT)
	cbz	r0, .L218
	ldr	r8, .L533+188
.LPIC62:
	add	r8, pc
.L15:
	bl	get_use_binary(PLT)
	cbz	r0, .L219
	ldr	r9, .L533+192
.LPIC64:
	add	r9, pc
.L16:
	bl	get_gentoo_chroot_path(PLT)
	mov	r6, r0
	bl	get_raw_flags(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L504
	ldr	r7, .L533+196
.LPIC66:
	add	r7, pc
.L17:
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L505
	ldr	r0, .L533+200
.LPIC67:
	add	r0, pc
.L18:
	strd	r7, r0, [sp, #12]
	mov	r3, r10
	ldr	r0, .L533+204
	mov	r2, r5
	mov	r1, r4
	str	r6, [sp, #8]
.LPIC94:
	add	r0, pc
	str	r9, [sp, #4]
	str	r8, [sp]
	bl	printf(PLT)
.L14:
	bl	print_usage(PLT)
	b	.L8
.L226:
	ldr	r7, .L533+208
.LPIC75:
	add	r7, pc
	b	.L31
.L219:
	ldr	r9, .L533+212
.LPIC65:
	add	r9, pc
	b	.L16
.L218:
	ldr	r8, .L533+216
.LPIC63:
	add	r8, pc
	b	.L15
.L217:
	ldr	r10, .L533+220
.LPIC61:
	add	r10, pc
	b	.L11
.L481:
	bl	get_raw_flags(PLT)
	mov	r6, r0
	b	.L34
.L482:
	bl	get_makepkg_raw(PLT)
	b	.L35
.L495:
	ldrb	r3, [r7, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L241
.L51:
	movs	r0, #1
	bl	set_resume(PLT)
	b	.L39
.L472:
	ldr	r3, .L533+68
	movs	r2, #208
	ldr	r0, .L533+224
	movs	r1, #1
.LPIC92:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L503:
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L13
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L13
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	bne	.L13
	bl	get_raw_flags(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L13
	bl	get_makepkg_raw(PLT)
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L13
	b	.L14
.L497:
	bl	set_inhibit(PLT)
	b	.L39
.L505:
	bl	get_makepkg_raw(PLT)
	b	.L18
.L504:
	bl	get_raw_flags(PLT)
	mov	r7, r0
	b	.L17
.L49:
	bl	set_prompt_timeout(PLT)
	b	.L39
.L496:
	bl	set_import_keys(PLT)
	b	.L39
.L242:
	ldr	r1, .L533+228
	mov	r0, r7
.LPIC119:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L60
	ldrb	r3, [r7]	@ zero_extendqisi2
	cmp	r3, #45
	bne	.L67
	ldrb	r3, [r7, #1]	@ zero_extendqisi2
	subs	r10, r3, #106
	bne	.L67
	bl	__ctype_b_loc(PLT)
	ldrb	r2, [r7, #2]	@ zero_extendqisi2
	ldr	r3, [r0]
	ldrh	r3, [r3, r2, lsl #1]
	lsls	r2, r3, #20
	bmi	.L506
.L67:
	ldr	r1, .L533+232
	movs	r2, #7
	mov	r0, r7
.LPIC123:
	add	r1, pc
	bl	strncmp(PLT)
	mov	r3, r0
	cmp	r0, #0
	beq	.L507
	ldr	r1, .L533+236
	mov	r0, r7
.LPIC125:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L73
	ldr	r1, .L533+240
	mov	r0, r7
.LPIC126:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L73
	ldr	r1, .L533+244
	mov	r0, r7
.LPIC127:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L73
	ldr	r1, .L533+248
	movs	r2, #9
	mov	r0, r7
.LPIC132:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L79
	ldrb	r3, [r7, #9]	@ zero_extendqisi2
	adds	r7, r7, #9
	cmp	r3, #0
	beq	.L508
	ldr	r1, .L533+252
	mov	r0, r7
.LPIC134:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L533+256
	mov	r0, r7
.LPIC135:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	mov	r0, r7
	bl	valid_target_arch(PLT)
	cmp	r0, #0
	bne	.L87
	ldr	r3, .L533+68
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L533+260
	ldr	r3, [r7, r3]
.LPIC136:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L498:
	bl	set_sync(PLT)
	b	.L39
.L483:
	ldr	r9, [r8]
	ldrb	r5, [r9]	@ zero_extendqisi2
	cmp	r5, #45
	bne	.L243
	ldrb	r3, [r9, #1]	@ zero_extendqisi2
	cmp	r3, #118
	bne	.L243
	ldrb	r3, [r9, #2]	@ zero_extendqisi2
	cbnz	r3, .L243
.L128:
	bl	get_target_arch(PLT)
	mov	r5, r0
	bl	get_opt_level(PLT)
	mov	r4, r0
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L229
	ldr	r6, .L533+264
.LPIC78:
	add	r6, pc
.L130:
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	beq	.L230
	ldr	r7, .L533+268
.LPIC80:
	add	r7, pc
.L131:
	bl	get_use_binary(PLT)
	cmp	r0, #0
	beq	.L231
	ldr	r2, .L533+272
.LPIC82:
	add	r2, pc
.L132:
	str	r2, [sp, #12]
	mov	r3, r5
	ldr	r2, .L533+276
	ldr	r1, .L533+280
	ldr	r0, .L533+284
.LPIC201:
	add	r2, pc
.LPIC202:
	add	r1, pc
	strd	r6, r7, [sp, #4]
	str	r4, [sp]
.LPIC203:
	add	r0, pc
	bl	printf(PLT)
	ldr	r0, .L533+288
.LPIC204:
	add	r0, pc
	bl	puts(PLT)
	b	.L26
.L499:
	bl	set_aur_sync(PLT)
	b	.L39
.L243:
	ldr	r1, .L533+292
	mov	r0, r9
.LPIC200:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L128
	cmp	r5, #45
	bne	.L244
	ldrb	r3, [r9, #1]	@ zero_extendqisi2
	cmp	r3, #104
	bne	.L244
	ldrb	r3, [r9, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L244
.L134:
	bl	print_usage(PLT)
	b	.L26
.L500:
	movs	r0, #1
	bl	set_use_pipe(PLT)
	b	.L39
.L485:
	ldrb	r2, [r9, #1]	@ zero_extendqisi2
	cmp	r2, #83
	beq	.L509
.L145:
	cmp	r3, #45
	bne	.L149
	ldrb	r2, [r9, #1]	@ zero_extendqisi2
	cmp	r2, #81
	bne	.L246
	ldrb	r5, [r9, #2]	@ zero_extendqisi2
	cmp	r5, #0
	bne	.L246
.L237:
	movs	r4, #1
	b	.L153
.L150:
	bl	cmd_available_info_v2(PLT)
.L151:
	adds	r4, r4, #1
	cbnz	r0, .L152
	adds	r5, r5, #1
.L152:
	cmp	fp, r4
	ble	.L510
.L153:
	ldrb	r3, [r9, #1]	@ zero_extendqisi2
	ldr	r0, [r8, r4, lsl #2]
	cmp	r3, #81
	bne	.L150
	bl	cmd_query_v2(PLT)
	b	.L151
.L72:
	bl	set_jobs(PLT)
	b	.L39
.L501:
	bl	set_use_pipe(PLT)
	b	.L39
.L510:
	subs	r0, r5, #0
	it	ne
	movne	r0, #1
	b	.L6
.L484:
	bl	get_target_arch(PLT)
	ldr	r1, .L533+296
.LPIC206:
	add	r1, pc
	bl	strcmp(PLT)
	cbnz	r0, .L140
	bl	get_opt_level(PLT)
	ldrb	r2, [r0]	@ zero_extendqisi2
	cmp	r2, #51
	bne	.L140
	ldrb	r3, [r0, #1]	@ zero_extendqisi2
	cbnz	r3, .L140
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	bne	.L511
.L140:
	bl	get_target_arch(PLT)
	mov	r4, r0
	bl	get_opt_level(PLT)
	mov	r5, r0
	bl	get_use_pipe(PLT)
	cmp	r0, #0
	beq	.L232
	ldr	r7, .L533+300
.LPIC84:
	add	r7, pc
.L138:
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	beq	.L233
	ldr	r8, .L533+304
.LPIC86:
	add	r8, pc
.L142:
	bl	get_use_binary(PLT)
	cmp	r0, #0
	beq	.L234
	ldr	r9, .L533+308
.LPIC88:
	add	r9, pc
.L143:
	bl	get_jobs(PLT)
	mov	r6, r0
	bl	get_gentoo_chroot_path(PLT)
	strd	r6, r0, [sp, #8]
	ldr	r0, .L533+312
	mov	r3, r7
	mov	r2, r5
	mov	r1, r4
	str	r9, [sp, #4]
.LPIC207:
	add	r0, pc
	str	r8, [sp]
	bl	printf(PLT)
	b	.L26
.L244:
	ldr	r1, .L533+316
	mov	r0, r9
.LPIC205:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L134
	cmp	r5, #45
	bne	.L245
	ldrb	r3, [r9, #1]	@ zero_extendqisi2
	cmp	r3, #83
	bne	.L245
	ldrb	r3, [r9, #2]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L245
.L212:
	ldr	r0, .L533+320
	ldr	r3, .L533+68
.LPIC208:
	add	r0, pc
.L469:
	ldr	r3, [r7, r3]
	movs	r2, #50
	movs	r1, #1
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L509:
	ldrb	r2, [r9, #2]	@ zero_extendqisi2
	cmp	r2, #0
	bne	.L145
	cmp	fp, #2
	bne	.L212
	ldr	r0, [r8, #4]
	bl	cmd_search_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L480:
	ldr	r3, .L533+68
	movs	r2, #47
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L533+324
	ldr	r3, [r7, r3]
.LPIC110:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L73:
	adds	r5, r5, #1
	cmp	r5, r6
	bge	.L512
	ldr	r7, [r9, #4]
	ldr	r1, .L533+328
	mov	r0, r7
.LPIC129:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	ldr	r1, .L533+332
	mov	r0, r7
.LPIC130:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L76
	mov	r0, r7
	bl	valid_target_arch(PLT)
	cmp	r0, #0
	bne	.L87
	ldr	r3, .L533+68
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L533+336
	ldr	r3, [r7, r3]
.LPIC131:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L229:
	ldr	r6, .L533+340
.LPIC79:
	add	r6, pc
	b	.L130
.L231:
	ldr	r2, .L533+344
.LPIC83:
	add	r2, pc
	b	.L132
.L230:
	ldr	r7, .L533+348
.LPIC81:
	add	r7, pc
	b	.L131
.L233:
	ldr	r8, .L533+352
.LPIC87:
	add	r8, pc
	b	.L142
.L232:
	ldr	r7, .L533+356
.LPIC85:
	add	r7, pc
	b	.L138
.L234:
	ldr	r9, .L533+360
.LPIC89:
	add	r9, pc
	b	.L143
.L246:
	cmp	r3, #45
	bne	.L149
	ldrb	r3, [r9, #1]	@ zero_extendqisi2
	cmp	r3, #65
	bne	.L149
	ldrb	r5, [r9, #2]	@ zero_extendqisi2
	cmp	r5, #0
	beq	.L237
	b	.L149
.L507:
	adds	r0, r7, #7
	add	r7, sp, #44
	movs	r2, #10
	mov	r1, r7
	str	r3, [sp, #44]
	bl	strtol(PLT)
	ldr	r2, [sp, #44]
	cbz	r2, .L71
	ldrb	r2, [r2]	@ zero_extendqisi2
	cbnz	r2, .L71
	subs	r3, r0, #1
	cmp	r3, #1024
	bcc	.L72
.L71:
	ldr	r3, .L533+68
	movs	r2, #34
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L533+364
	ldr	r3, [r7, r3]
.LPIC124:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L87:
	mov	r0, r7
	bl	set_target_arch(PLT)
	b	.L39
.L245:
	ldr	r1, .L533+368
	mov	r0, r9
.LPIC241:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L213
	ldr	r1, .L533+372
	mov	r0, r9
.LPIC209:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L149
.L213:
	ldr	r0, .L533+376
	ldr	r3, .L533+68
.LPIC210:
	add	r0, pc
	b	.L469
.L506:
	adds	r0, r7, #2
	add	r7, sp, #44
	movs	r2, #10
	mov	r1, r7
	str	r10, [sp, #44]
	bl	strtol(PLT)
	ldr	r2, [sp, #44]
	cbz	r2, .L68
	ldrb	r2, [r2]	@ zero_extendqisi2
	cbnz	r2, .L68
	subs	r3, r0, #1
	cmp	r3, #1024
	bcc	.L72
.L68:
	ldr	r3, .L533+68
	ldr	r7, [sp, #36]
	ldr	r1, .L533+380
	ldr	r2, [r4, r8]
	ldr	r3, [r7, r3]
.LPIC122:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L502:
	ldr	r3, .L533+68
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L533+384
	ldr	r3, [r7, r3]
.LPIC120:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L486:
	bl	cmd_orphans_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L488:
	bl	cmd_news_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L487:
	bl	cmd_stats_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L511:
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	bne	.L140
	b	.L26
.L489:
	bl	cmd_completion_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L490:
	bl	cmd_devel_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L79:
	ldr	r1, .L533+388
	movs	r2, #8
	mov	r0, r7
.LPIC137:
	add	r1, pc
	bl	strncmp(PLT)
	cbnz	r0, .L82
	ldrb	r3, [r7, #8]	@ zero_extendqisi2
	adds	r7, r7, #8
	cmp	r3, #0
	beq	.L513
	ldr	r1, .L533+392
	mov	r0, r7
.LPIC139:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L76
	ldr	r1, .L533+396
	mov	r0, r7
.LPIC140:
	add	r1, pc
	bl	strcmp(PLT)
	cbz	r0, .L76
	mov	r0, r7
	bl	valid_target_arch(PLT)
	cmp	r0, #0
	bne	.L87
	ldr	r3, .L533+68
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L533+400
	ldr	r3, [r7, r3]
.LPIC141:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L76:
	bl	print_known_targets(PLT)
	b	.L26
.L82:
	ldr	r1, .L533+404
	movs	r2, #6
	mov	r0, r7
.LPIC142:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L85
	ldrb	r3, [r7, #6]	@ zero_extendqisi2
	adds	r7, r7, #6
	cmp	r3, #0
	beq	.L514
	mov	r0, r7
	bl	valid_target_arch(PLT)
	cmp	r0, #0
	bne	.L87
	ldr	r3, .L533+68
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L533+408
	ldr	r3, [r7, r3]
.LPIC144:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L162:
	ldr	r0, [r8, #4]
	bl	cmd_review_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L161:
	mov	r1, r4
	mov	r0, r6
	bl	acquire_sudo(PLT)
	cmp	r0, #0
	beq	.L8
	ldr	r1, .L533+412
	mov	r0, r9
.LPIC220:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r4, r0
	cbnz	r0, .L164
	cmp	fp, #1
	beq	.L8
	bl	init_system(PLT)
	cmp	r0, #0
	beq	.L8
	bl	get_use_binary(PLT)
	mov	r5, r0
	cbz	r0, .L166
	movs	r5, #1
.L168:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_build(PLT)
	cbnz	r0, .L167
	adds	r4, r4, #1
.L167:
	cmp	fp, r5
	bgt	.L168
.L471:
	subs	r0, r4, #0
	it	ne
	movne	r0, #1
	b	.L6
.L166:
	bl	get_gentoo_chroot(PLT)
	mov	r4, r0
	cbz	r0, .L170
	mov	r4, r5
	movs	r5, #1
.L172:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_gentoo_imitation_build(PLT)
	cbnz	r0, .L171
	adds	r4, r4, #1
.L171:
	cmp	fp, r5
	bgt	.L172
	b	.L471
.L170:
	movs	r5, #1
.L174:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_build(PLT)
	cbnz	r0, .L173
	adds	r4, r4, #1
.L173:
	cmp	fp, r5
	bgt	.L174
	b	.L471
.L164:
	ldr	r1, .L533+416
	mov	r0, r9
.LPIC221:
	add	r1, pc
	bl	strcmp(PLT)
	mov	r4, r0
	cmp	r0, #0
	bne	.L175
	cmp	fp, #1
	beq	.L8
	movs	r5, #1
.L177:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_get_pkgbuild_v2(PLT)
	cbnz	r0, .L176
	adds	r4, r4, #1
.L176:
	cmp	fp, r5
	bgt	.L177
	b	.L471
.L534:
	.align	2
.L533:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC91+4)
	.word	.LC65-(.LPIC90+4)
	.word	.LC61-(.LPIC69+4)
	.word	.LC62-(.LPIC70+4)
	.word	.LC62-(.LPIC72+4)
	.word	.LC0-(.LPIC96+4)
	.word	.LC1-(.LPIC97+4)
	.word	.LC70-(.LPIC98+4)
	.word	.LC71-(.LPIC99+4)
	.word	.LC72-(.LPIC100+4)
	.word	.LC69-(.LPIC95+4)
	.word	.LC73-(.LPIC101+4)
	.word	.LC75-(.LPIC104+4)
	.word	.LC76-(.LPIC105+4)
	.word	.LC77-(.LPIC106+4)
	.word	.LC79-(.LPIC108+4)
	.word	.LC80-(.LPIC109+4)
	.word	stderr(GOT)
	.word	.LC82-(.LPIC111+4)
	.word	.LC78-(.LPIC107+4)
	.word	.LC67-(.LPIC102+4)
	.word	.LC60-(.LPIC74+4)
	.word	.LC64-(.LPIC76+4)
	.word	.LC64-(.LPIC77+4)
	.word	.LC74-(.LPIC103+4)
	.word	.LC162-(.LPIC211+4)
	.word	.LC163-(.LPIC212+4)
	.word	.LC164-(.LPIC213+4)
	.word	.LC165-(.LPIC214+4)
	.word	.LC166-(.LPIC215+4)
	.word	.LC167-(.LPIC216+4)
	.word	.LC168-(.LPIC217+4)
	.word	.LC169-(.LPIC218+4)
	.word	.LC170-(.LPIC219+4)
	.word	.LC60-(.LPIC68+4)
	.word	.LC63-(.LPIC71+4)
	.word	.LC63-(.LPIC73+4)
	.word	.LC83-(.LPIC112+4)
	.word	.LC84-(.LPIC113+4)
	.word	.LC85-(.LPIC114+4)
	.word	.LC86-(.LPIC115+4)
	.word	.LC87-(.LPIC116+4)
	.word	.LC88-(.LPIC117+4)
	.word	.LC89-(.LPIC118+4)
	.word	.LC92-(.LPIC121+4)
	.word	.LC67-(.LPIC93+4)
	.word	.LC60-(.LPIC60+4)
	.word	.LC62-(.LPIC62+4)
	.word	.LC62-(.LPIC64+4)
	.word	.LC64-(.LPIC66+4)
	.word	.LC64-(.LPIC67+4)
	.word	.LC68-(.LPIC94+4)
	.word	.LC61-(.LPIC75+4)
	.word	.LC63-(.LPIC65+4)
	.word	.LC63-(.LPIC63+4)
	.word	.LC61-(.LPIC61+4)
	.word	.LC66-(.LPIC92+4)
	.word	.LC90-(.LPIC119+4)
	.word	.LC93-(.LPIC123+4)
	.word	.LC95-(.LPIC125+4)
	.word	.LC96-(.LPIC126+4)
	.word	.LC97-(.LPIC127+4)
	.word	.LC102-(.LPIC132+4)
	.word	.LC99-(.LPIC134+4)
	.word	.LC100-(.LPIC135+4)
	.word	.LC101-(.LPIC136+4)
	.word	.LC60-(.LPIC78+4)
	.word	.LC62-(.LPIC80+4)
	.word	.LC62-(.LPIC82+4)
	.word	.LC0-(.LPIC201+4)
	.word	.LC1-(.LPIC202+4)
	.word	.LC70-(.LPIC203+4)
	.word	.LC71-(.LPIC204+4)
	.word	.LC69-(.LPIC200+4)
	.word	.LC67-(.LPIC206+4)
	.word	.LC60-(.LPIC84+4)
	.word	.LC62-(.LPIC86+4)
	.word	.LC62-(.LPIC88+4)
	.word	.LC158-(.LPIC207+4)
	.word	.LC73-(.LPIC205+4)
	.word	.LC159-(.LPIC208+4)
	.word	.LC81-(.LPIC110+4)
	.word	.LC99-(.LPIC129+4)
	.word	.LC100-(.LPIC130+4)
	.word	.LC101-(.LPIC131+4)
	.word	.LC61-(.LPIC79+4)
	.word	.LC63-(.LPIC83+4)
	.word	.LC63-(.LPIC81+4)
	.word	.LC63-(.LPIC87+4)
	.word	.LC61-(.LPIC85+4)
	.word	.LC63-(.LPIC89+4)
	.word	.LC94-(.LPIC124+4)
	.word	.LC192-(.LPIC241+4)
	.word	.LC160-(.LPIC209+4)
	.word	.LC161-(.LPIC210+4)
	.word	.LC92-(.LPIC122+4)
	.word	.LC91-(.LPIC120+4)
	.word	.LC104-(.LPIC137+4)
	.word	.LC99-(.LPIC139+4)
	.word	.LC100-(.LPIC140+4)
	.word	.LC106-(.LPIC141+4)
	.word	.LC107-(.LPIC142+4)
	.word	.LC109-(.LPIC144+4)
	.word	.LC171-(.LPIC220+4)
	.word	.LC172-(.LPIC221+4)
.L175:
	ldr	r1, .L535
	mov	r0, r9
.LPIC222:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L515
	ldr	r1, .L535+4
	mov	r0, r9
.LPIC223:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L516
	ldr	r1, .L535+8
	mov	r0, r9
.LPIC224:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L180
	ldr	r1, .L535+12
	mov	r0, r9
.LPIC225:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L180
	ldr	r1, .L535+16
	mov	r0, r9
.LPIC226:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L182
	ldr	r1, .L535+20
	mov	r0, r9
.LPIC227:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L182
	ldr	r1, .L535+24
	mov	r0, r9
.LPIC229:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L187
	ldr	r1, .L535+28
	mov	r0, r9
.LPIC230:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L187
	ldrb	r3, [r9]	@ zero_extendqisi2
	cmp	r3, #45
	beq	.L517
	mov	r6, r8
	movs	r4, #0
.L194:
	ldr	r5, [r6], #4
	adds	r4, r4, #1
	mov	r0, r5
	bl	valid_pkgname(PLT)
	cbz	r0, .L518
	cmp	fp, r4
	bgt	.L194
	bl	init_system(PLT)
	cmp	r0, #0
	beq	.L8
	bl	get_use_binary(PLT)
	mov	r5, r0
	cmp	r0, #0
	beq	.L195
	ldr	r10, .L535+32
	movs	r4, #0
	mov	r5, r4
.LPIC234:
	add	r10, pc
	b	.L198
.L519:
	mov	r3, r9
	mov	r2, fp
	mov	r1, r6
	mov	r0, r10
	bl	printf(PLT)
	mov	r0, r9
	bl	cmd_build(PLT)
	cbz	r0, .L205
.L197:
	mov	r4, r6
	cmp	fp, r6
	ble	.L206
.L198:
	ldr	r9, [r8], #4
	adds	r6, r4, #1
	cmp	fp, #1
	bne	.L519
	mov	r0, r9
	bl	cmd_build(PLT)
	cbnz	r0, .L206
	adds	r6, r4, #1
.L205:
	adds	r5, r5, #1
	b	.L197
.L513:
	ldr	r3, .L535+36
	movs	r2, #39
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L535+40
	ldr	r3, [r7, r3]
.LPIC138:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L518:
	ldr	r3, .L535+36
	mov	r2, r5
	ldr	r1, .L535+44
.LPIC233:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L206:
	cmp	r5, #0
	beq	.L26
	ldr	r3, .L535+36
	mov	r2, r5
	ldr	r1, .L535+48
.LPIC235:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L195:
	bl	get_gentoo_chroot(PLT)
	cmp	r0, #0
	beq	.L236
	ldr	r10, .L535+52
	mov	r4, r5
.LPIC236:
	add	r10, pc
	b	.L202
.L520:
	mov	r3, r9
	mov	r2, fp
	mov	r1, r6
	mov	r0, r10
	bl	printf(PLT)
	mov	r0, r9
	bl	cmd_gentoo_imitation_build(PLT)
	cbz	r0, .L207
.L201:
	mov	r4, r6
	cmp	fp, r6
	ble	.L208
.L202:
	ldr	r9, [r8], #4
	adds	r6, r4, #1
	cmp	fp, #1
	bne	.L520
	mov	r0, r9
	bl	cmd_gentoo_imitation_build(PLT)
	cmp	r0, #0
	bne	.L208
	adds	r6, r4, #1
.L207:
	adds	r5, r5, #1
	b	.L201
.L517:
	ldr	r3, .L535+36
	mov	r2, r9
	ldr	r1, .L535+56
.LPIC232:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	bl	print_usage(PLT)
	b	.L8
.L187:
	cmp	fp, #1
	beq	.L521
	bl	init_system(PLT)
	cmp	r0, #0
	beq	.L8
	movs	r5, #1
	movs	r4, #0
.L191:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_unmerge(PLT)
	cbnz	r0, .L190
	adds	r4, r4, #1
.L190:
	cmp	fp, r5
	bgt	.L191
	b	.L471
.L521:
	ldr	r3, .L535+36
	movs	r2, #57
	ldr	r0, .L535+60
	mov	r1, fp
.LPIC231:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L182:
	cmp	fp, #1
	beq	.L522
	bl	init_system(PLT)
	cmp	r0, #0
	beq	.L8
	movs	r5, #1
	movs	r4, #0
.L186:
	ldr	r0, [r8, #4]!
	adds	r5, r5, #1
	bl	cmd_deselect(PLT)
	cbnz	r0, .L185
	adds	r4, r4, #1
.L185:
	cmp	fp, r5
	bgt	.L186
	b	.L471
.L522:
	ldr	r3, .L535+36
	movs	r2, #53
	ldr	r0, .L535+64
	mov	r1, fp
.LPIC228:
	add	r0, pc
	ldr	r3, [r7, r3]
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L180:
	bl	init_system(PLT)
	cmp	r0, #0
	beq	.L8
	bl	cmd_world_update(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L208:
	cmp	r5, #0
	beq	.L26
	ldr	r3, .L535+36
	mov	r2, r5
	ldr	r1, .L535+68
.LPIC237:
	add	r1, pc
	ldr	r3, [r7, r3]
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L236:
	ldr	r10, .L535+72
	mov	r5, r0
	str	r9, [sp, #24]
	mov	r9, fp
.LPIC238:
	add	r10, pc
	mov	fp, r7
	mov	r7, r0
	b	.L199
.L523:
	mov	r3, r4
	mov	r2, r9
	mov	r1, r6
	mov	r0, r10
	bl	printf(PLT)
	mov	r0, r4
	bl	cmd_build(PLT)
	cbz	r0, .L209
.L204:
	mov	r5, r6
	cmp	r9, r6
	ble	.L210
.L199:
	ldr	r4, [r8], #4
	adds	r6, r5, #1
	cmp	r9, #1
	bne	.L523
	mov	r0, r4
	bl	cmd_build(PLT)
	cmp	r0, #0
	bne	.L210
	adds	r6, r5, #1
.L209:
	adds	r7, r7, #1
	b	.L204
.L516:
	bl	cmd_clean_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L508:
	ldr	r3, .L535+36
	movs	r2, #40
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L535+76
	ldr	r3, [r7, r3]
.LPIC133:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L492:
	ldr	r0, [r8, #4]
	bl	cmd_dependency_plan_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L512:
	ldr	r3, .L535+36
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L535+80
	ldr	r3, [r7, r3]
.LPIC128:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L491:
	ldr	r0, [r8, #4]
	bl	cmd_provider_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L514:
	ldr	r3, .L535+36
	movs	r2, #37
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L535+84
	ldr	r3, [r7, r3]
.LPIC143:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L85:
	ldr	r1, .L535+88
	mov	r0, r7
.LPIC145:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L88
	ldr	r1, .L535+92
	mov	r0, r7
.LPIC146:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L88
	ldr	r1, .L535+96
	mov	r0, r7
.LPIC147:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L88
	ldr	r1, .L535+100
	mov	r0, r7
.LPIC148:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L88
	ldr	r1, .L535+104
	movs	r2, #12
	mov	r0, r7
.LPIC153:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	bne	.L94
	ldrb	r3, [r7, #12]	@ zero_extendqisi2
	adds	r7, r7, #12
	cmp	r3, #0
	beq	.L524
	ldr	r1, .L535+108
	mov	r0, r7
.LPIC155:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L91
	ldr	r1, .L535+112
	mov	r0, r7
.LPIC156:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L91
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	bne	.L465
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+116
	ldr	r3, [r7, r3]
.LPIC157:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L515:
	cmp	fp, #2
	bne	.L8
	ldr	r0, [r8, #4]
	bl	cmd_local_build_v2(PLT)
	clz	r0, r0
	lsrs	r0, r0, #5
	b	.L6
.L210:
	ldr	r9, [sp, #24]
	mov	r4, r7
	cmp	r4, #0
	beq	.L26
	ldr	r3, .L535+36
	mov	r2, r4
	ldr	r1, .L535+120
.LPIC239:
	add	r1, pc
	ldr	r4, [fp, r3]
	ldr	r0, [r4]
	bl	fprintf(PLT)
	bl	get_resume(PLT)
	cmp	r0, #0
	bne	.L8
	ldr	r1, .L535+124
	mov	r2, r9
	ldr	r0, [r4]
.LPIC240:
	add	r1, pc
	bl	fprintf(PLT)
	b	.L8
.L465:
	mov	r0, r7
	bl	set_opt_level(PLT)
	b	.L39
.L91:
	bl	print_known_opt_levels(PLT)
	b	.L26
.L524:
	ldr	r0, .L535+128
	ldr	r7, [sp, #36]
	ldr	r3, .L535+36
.LPIC154:
	add	r0, pc
.L468:
	ldr	r3, [r7, r3]
	movs	r2, #43
	movs	r1, #1
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L94:
	ldr	r1, .L535+132
	movs	r2, #6
	mov	r0, r7
.LPIC158:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L525
	ldr	r1, .L535+136
	movs	r2, #15
	mov	r0, r7
.LPIC160:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L526
	ldr	r1, .L535+140
	mov	r0, r7
.LPIC162:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+144
	mov	r0, r7
.LPIC163:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+148
	mov	r0, r7
.LPIC164:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+152
	mov	r0, r7
.LPIC165:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+156
	mov	r0, r7
.LPIC166:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+160
	mov	r0, r7
.LPIC167:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+164
	mov	r0, r7
.LPIC168:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L465
	ldr	r1, .L535+168
	mov	r0, r7
.LPIC169:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L527
	ldr	r1, .L535+172
	movs	r2, #2
	mov	r0, r7
.LPIC171:
	add	r1, pc
	bl	strncmp(PLT)
	cbnz	r0, .L105
	mov	r0, r7
	bl	strlen(PLT)
	cmp	r0, #7
	bhi	.L105
	ldrb	r3, [r7, #2]	@ zero_extendqisi2
	cmp	r3, #61
	ite	ne
	addne	r7, r7, #2
	addeq	r7, r7, #3
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	bne	.L465
	ldr	r7, [r4, r8]
.L105:
	ldr	r1, .L535+176
	mov	r0, r7
.LPIC172:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L108
	adds	r5, r5, #1
	cmp	r5, r6
	bge	.L528
	ldr	r7, [r9, #4]
	mov	r0, r7
	bl	valid_raw_flags(PLT)
	cmp	r0, #0
	bne	.L112
	ldr	r0, .L535+180
	ldr	r7, [sp, #36]
	ldr	r3, .L535+36
.LPIC174:
	add	r0, pc
.L470:
	ldr	r3, [r7, r3]
	movs	r2, #112
	movs	r1, #1
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L527:
	ldr	r0, .L535+184
.LPIC170:
	add	r0, pc
	bl	set_opt_level(PLT)
	b	.L39
.L525:
	adds	r7, r7, #6
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	bne	.L465
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+188
	ldr	r3, [r7, r3]
.LPIC159:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L88:
	adds	r5, r5, #1
	cmp	r5, r6
	bge	.L529
	ldr	r7, [r9, #4]
	ldr	r1, .L535+192
	mov	r0, r7
.LPIC150:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L91
	ldr	r1, .L535+196
	mov	r0, r7
.LPIC151:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L91
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	bne	.L465
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+200
	ldr	r3, [r7, r3]
.LPIC152:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L526:
	adds	r7, r7, #15
	mov	r0, r7
	bl	valid_opt_level(PLT)
	cmp	r0, #0
	bne	.L465
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+204
	ldr	r3, [r7, r3]
.LPIC161:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L528:
	ldr	r0, .L535+208
	ldr	r7, [sp, #36]
	ldr	r3, .L535+36
.LPIC173:
	add	r0, pc
	b	.L468
.L108:
	ldr	r1, .L535+212
	movs	r2, #6
	mov	r0, r7
.LPIC175:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L530
	ldr	r1, .L535+216
	mov	r0, r7
.LPIC177:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L113
	ldr	r1, .L535+220
	mov	r0, r7
.LPIC178:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L113
	ldr	r1, .L535+224
	mov	r0, r7
.LPIC179:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L113
	ldr	r1, .L535+228
	mov	r0, r7
.LPIC180:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L113
	ldr	r1, .L535+232
	mov	r0, r7
.LPIC181:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L115
	ldr	r1, .L535+236
	mov	r0, r7
.LPIC182:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L115
	ldr	r1, .L535+240
	movs	r2, #14
	mov	r0, r7
.LPIC183:
	add	r1, pc
	bl	strncmp(PLT)
	cmp	r0, #0
	beq	.L531
	ldr	r1, .L535+244
	mov	r0, r7
.LPIC185:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	bne	.L119
	adds	r5, r5, #1
	cmp	r6, r5
	ble	.L532
	ldr	r7, [r9, #4]
	mov	r0, r7
	bl	valid_gentoo_chroot_path(PLT)
	cbnz	r0, .L121
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+248
	ldr	r3, [r7, r3]
.LPIC187:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L112:
	mov	r0, r7
	bl	set_raw_flags(PLT)
	b	.L39
.L529:
	ldr	r3, .L535+36
	mov	r9, r7
	ldr	r7, [sp, #36]
	mov	r2, r9
	ldr	r1, .L535+252
	ldr	r3, [r7, r3]
.LPIC149:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L121:
	mov	r0, r7
	bl	set_gentoo_chroot_path(PLT)
	b	.L39
.L532:
	ldr	r3, .L535+36
	movs	r2, #42
	ldr	r7, [sp, #36]
	movs	r1, #1
	ldr	r0, .L535+256
	ldr	r3, [r7, r3]
.LPIC186:
	add	r0, pc
	ldr	r3, [r3]
	bl	fwrite(PLT)
	b	.L8
.L119:
	ldr	r1, .L535+260
	mov	r0, r7
.LPIC188:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+264
	mov	r0, r7
.LPIC189:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+268
	mov	r0, r7
.LPIC190:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+272
	mov	r0, r7
.LPIC191:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+276
	mov	r0, r7
.LPIC192:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+280
	mov	r0, r7
.LPIC193:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+284
	mov	r0, r7
.LPIC194:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+288
	mov	r0, r7
.LPIC195:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L122
	ldr	r1, .L535+292
	mov	r0, r7
.LPIC196:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L124
	ldr	r1, .L535+296
	mov	r0, r7
.LPIC197:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L124
	ldr	r1, .L535+300
	mov	r0, r7
.LPIC198:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L124
	ldr	r1, .L535+304
	mov	r0, r7
.LPIC199:
	add	r1, pc
	bl	strcmp(PLT)
	cmp	r0, #0
	beq	.L124
	add	r3, sp, #48
	str	r7, [r3, fp, lsl #2]
	add	fp, fp, #1
	b	.L39
.L531:
	adds	r7, r7, #14
	mov	r0, r7
	bl	valid_gentoo_chroot_path(PLT)
	cmp	r0, #0
	bne	.L121
	ldr	r3, .L535+36
	mov	r8, r7
	ldr	r7, [sp, #36]
	mov	r2, r8
	ldr	r1, .L535+308
	ldr	r3, [r7, r3]
.LPIC184:
	add	r1, pc
	ldr	r0, [r3]
	bl	fprintf(PLT)
	b	.L8
.L115:
	movs	r0, #0
	bl	set_gentoo_chroot(PLT)
	movs	r0, #0
	bl	set_portage_imitation(PLT)
	b	.L39
.L113:
	movs	r0, #1
	bl	set_gentoo_chroot(PLT)
	movs	r0, #1
	bl	set_portage_imitation(PLT)
	b	.L39
.L530:
	adds	r7, r7, #6
	mov	r0, r7
	bl	valid_raw_flags(PLT)
	cmp	r0, #0
	bne	.L112
	ldr	r0, .L535+312
	ldr	r7, [sp, #36]
	ldr	r3, .L535+36
.LPIC176:
	add	r0, pc
	b	.L470
.L124:
	movs	r0, #0
	bl	set_use_binary(PLT)
	b	.L39
.L122:
	movs	r0, #1
	bl	set_use_binary(PLT)
	b	.L39
.L536:
	.align	2
.L535:
	.word	.LC173-(.LPIC222+4)
	.word	.LC174-(.LPIC223+4)
	.word	.LC175-(.LPIC224+4)
	.word	.LC176-(.LPIC225+4)
	.word	.LC177-(.LPIC226+4)
	.word	.LC178-(.LPIC227+4)
	.word	.LC180-(.LPIC229+4)
	.word	.LC181-(.LPIC230+4)
	.word	.LC185-(.LPIC234+4)
	.word	stderr(GOT)
	.word	.LC105-(.LPIC138+4)
	.word	.LC184-(.LPIC233+4)
	.word	.LC186-(.LPIC235+4)
	.word	.LC187-(.LPIC236+4)
	.word	.LC183-(.LPIC232+4)
	.word	.LC182-(.LPIC231+4)
	.word	.LC179-(.LPIC228+4)
	.word	.LC188-(.LPIC237+4)
	.word	.LC189-(.LPIC238+4)
	.word	.LC103-(.LPIC133+4)
	.word	.LC98-(.LPIC128+4)
	.word	.LC108-(.LPIC143+4)
	.word	.LC110-(.LPIC145+4)
	.word	.LC111-(.LPIC146+4)
	.word	.LC112-(.LPIC147+4)
	.word	.LC113-(.LPIC148+4)
	.word	.LC116-(.LPIC153+4)
	.word	.LC99-(.LPIC155+4)
	.word	.LC100-(.LPIC156+4)
	.word	.LC118-(.LPIC157+4)
	.word	.LC190-(.LPIC239+4)
	.word	.LC191-(.LPIC240+4)
	.word	.LC117-(.LPIC154+4)
	.word	.LC119-(.LPIC158+4)
	.word	.LC121-(.LPIC160+4)
	.word	.LC123-(.LPIC162+4)
	.word	.LC124-(.LPIC163+4)
	.word	.LC125-(.LPIC164+4)
	.word	.LC126-(.LPIC165+4)
	.word	.LC127-(.LPIC166+4)
	.word	.LC128-(.LPIC167+4)
	.word	.LC129-(.LPIC168+4)
	.word	.LC130-(.LPIC169+4)
	.word	.LC113-(.LPIC171+4)
	.word	.LC132-(.LPIC172+4)
	.word	.LC134-(.LPIC174+4)
	.word	.LC131-(.LPIC170+4)
	.word	.LC120-(.LPIC159+4)
	.word	.LC99-(.LPIC150+4)
	.word	.LC100-(.LPIC151+4)
	.word	.LC115-(.LPIC152+4)
	.word	.LC122-(.LPIC161+4)
	.word	.LC133-(.LPIC173+4)
	.word	.LC135-(.LPIC175+4)
	.word	.LC136-(.LPIC177+4)
	.word	.LC137-(.LPIC178+4)
	.word	.LC138-(.LPIC179+4)
	.word	.LC139-(.LPIC180+4)
	.word	.LC140-(.LPIC181+4)
	.word	.LC141-(.LPIC182+4)
	.word	.LC142-(.LPIC183+4)
	.word	.LC144-(.LPIC185+4)
	.word	.LC143-(.LPIC187+4)
	.word	.LC114-(.LPIC149+4)
	.word	.LC145-(.LPIC186+4)
	.word	.LC146-(.LPIC188+4)
	.word	.LC147-(.LPIC189+4)
	.word	.LC148-(.LPIC190+4)
	.word	.LC149-(.LPIC191+4)
	.word	.LC150-(.LPIC192+4)
	.word	.LC151-(.LPIC193+4)
	.word	.LC152-(.LPIC194+4)
	.word	.LC153-(.LPIC195+4)
	.word	.LC154-(.LPIC196+4)
	.word	.LC155-(.LPIC197+4)
	.word	.LC156-(.LPIC198+4)
	.word	.LC157-(.LPIC199+4)
	.word	.LC143-(.LPIC184+4)
	.word	.LC134-(.LPIC176+4)
	.section	.note.GNU-stack,"",%progbits
