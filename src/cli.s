	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"1.0.0"
	.align	3
.LC1:
	.string	"Archtoo Emerge Engine"
	.align	3
.LC2:
	.string	"\033[1;36m%s v%s\n\033[0m"
	.align	3
.LC3:
	.string	"Usage:"
	.align	3
.LC4:
	.string	"  emerge <package>...    Build and install packages (-I alias)"
	.align	3
.LC5:
	.string	"  emerge -S <query>       Search repositories and AUR"
	.align	3
.LC6:
	.string	"  emerge -I <package>...  Install packages"
	.align	3
.LC7:
	.string	"  emerge -Q <package>...  Query installed packages"
	.align	3
.LC8:
	.string	"  emerge -A <package>...  Show repository/AUR information"
	.align	3
.LC9:
	.string	"  emerge -G <package>...  Download AUR PKGBUILDs"
	.align	3
.LC10:
	.string	"  emerge -B <directory>   Build a local PKGBUILD"
	.align	3
.LC11:
	.string	"  emerge -C <package>... Unmerge and remove packages"
	.align	3
.LC12:
	.string	"  emerge --orphans        List orphaned dependencies"
	.align	3
.LC13:
	.string	"  emerge --clean          Clean package caches"
	.align	3
.LC14:
	.string	"  emerge --stats          Show package statistics"
	.align	3
.LC15:
	.string	"  emerge --news           Show recent Arch news"
	.align	3
.LC16:
	.string	"  emerge --providers <n>  Packages that provide <n> (exact/Provides)"
	.align	3
.LC17:
	.string	"  emerge --deps <n>       Dependency plan (repo or AUR, graph order)"
	.align	3
.LC18:
	.string	"  emerge --devel          List installed VCS packages (-git/-hg/...)"
	.align	3
.LC19:
	.string	"  emerge --review <dir>   Show PKGBUILD / .SRCINFO for review"
	.align	3
.LC20:
	.string	"  emerge --complete       Print CLI flags and repo package names"
	.align	3
.LC21:
	.string	"  emerge -U              World update: pacman -Syu, then rebuild @world"
	.align	3
.LC22:
	.string	"  emerge -D <package>... Deselect: unlock and drop from @world,"
	.align	3
.LC23:
	.string	"                         but keep the package installed"
	.align	3
.LC24:
	.string	"  emerge -v              Show version information"
	.align	3
.LC25:
	.string	"\nOptions:"
	.align	3
.LC26:
	.string	"  --noconfirm            Never prompt; use safe defaults"
	.align	3
.LC27:
	.string	"  -i, --interactive      Enable pacman confirmation prompts"
	.align	3
.LC28:
	.string	"  --prompt-timeout SEC   Archtoo prompt timeout (0 waits forever)"
	.align	3
.LC29:
	.string	"  -j, --jobs N           Parallel build jobs (default: all cores)"
	.align	3
.LC30:
	.string	"  --target ARCH          Custom -march target (default: native)"
	.align	3
.LC31:
	.string	"                         e.g. skylake, znver3, x86-64-v3, native"
	.align	3
.LC32:
	.string	"  --target=ARCH          Same as --target ARCH"
	.align	3
.LC33:
	.string	"  --march=ARCH           Alias for --target=ARCH"
	.align	3
.LC34:
	.string	"  --opt-level LEVEL      Optimization: 0,1,2,3,s,fast,g,z (default: 3)"
	.align	3
.LC35:
	.string	"                         e.g. -O2, 2, s, fast"
	.align	3
.LC36:
	.string	"  --opt=LEVEL            Alias for --opt-level"
	.align	3
.LC37:
	.string	"  -O0,-O1,-O2,-O3,-Os,-Ofast,-Og,-Oz  Short forms"
	.align	3
.LC38:
	.string	"  --pipe                 Enable -pipe (default)"
	.align	3
.LC39:
	.string	"  --no-pipe              Disable -pipe"
	.align	3
.LC40:
	.string	"  --gentoo-chroot        Enable SUPER HARD Portage imitation via Gentoo chroot"
	.align	3
.LC41:
	.string	"  --imitation            Alias for --gentoo-chroot"
	.align	3
.LC42:
	.string	"  --no-gentoo-chroot     Disable chroot imitation"
	.align	3
.LC43:
	.string	"  --chroot-path PATH     Custom chroot path (default: /usr/local/emerge/gentoo-chroot)"
	.align	3
.LC44:
	.string	"  --binary               Try sudo pacman -S first, then yay-style AUR search for a prebuilt -bin (long flag only)"
	.align	3
.LC45:
	.string	"                         Long flag only, no short form"
	.align	3
.LC46:
	.string	"  --use-binary           Alias for --binary"
	.align	3
.LC47:
	.string	"  --no-binary            Disable binary mode"
	.align	3
.LC48:
	.string	"  -r, --resume           Reuse the existing build tree and continue"
	.align	3
.LC49:
	.string	"                         an interrupted compile"
	.align	3
.LC50:
	.string	"  --no-keys              Do not import missing PGP signing keys"
	.align	3
.LC51:
	.string	"  --no-inhibit           Allow the machine to suspend while building"
	.align	3
.LC52:
	.string	"  --no-sync              Skip pacman -Syu during a world update"
	.align	3
.LC53:
	.string	"  --no-aur-sync          Reuse local AUR @world sources; do not refresh"
	.align	3
.LC54:
	.string	"  --command-guide        Display the command guide now"
	.align	3
.LC55:
	.string	"  --command-guide=MODE   Set guide mode: first-run, always, never"
	.text
	.align	2
	.p2align 5,,15
	.type	print_usage, %function
print_usage:
	stp	x29, x30, [sp, -16]!
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	mov	x29, sp
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	puts
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	puts
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	puts
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	puts
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	puts
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	puts
	adrp	x0, .LC10
	add	x0, x0, :lo12:.LC10
	bl	puts
	adrp	x0, .LC11
	add	x0, x0, :lo12:.LC11
	bl	puts
	adrp	x0, .LC12
	add	x0, x0, :lo12:.LC12
	bl	puts
	adrp	x0, .LC13
	add	x0, x0, :lo12:.LC13
	bl	puts
	adrp	x0, .LC14
	add	x0, x0, :lo12:.LC14
	bl	puts
	adrp	x0, .LC15
	add	x0, x0, :lo12:.LC15
	bl	puts
	adrp	x0, .LC16
	add	x0, x0, :lo12:.LC16
	bl	puts
	adrp	x0, .LC17
	add	x0, x0, :lo12:.LC17
	bl	puts
	adrp	x0, .LC18
	add	x0, x0, :lo12:.LC18
	bl	puts
	adrp	x0, .LC19
	add	x0, x0, :lo12:.LC19
	bl	puts
	adrp	x0, .LC20
	add	x0, x0, :lo12:.LC20
	bl	puts
	adrp	x0, .LC21
	add	x0, x0, :lo12:.LC21
	bl	puts
	adrp	x0, .LC22
	add	x0, x0, :lo12:.LC22
	bl	puts
	adrp	x0, .LC23
	add	x0, x0, :lo12:.LC23
	bl	puts
	adrp	x0, .LC24
	add	x0, x0, :lo12:.LC24
	bl	puts
	adrp	x0, .LC25
	add	x0, x0, :lo12:.LC25
	bl	puts
	adrp	x0, .LC26
	add	x0, x0, :lo12:.LC26
	bl	puts
	adrp	x0, .LC27
	add	x0, x0, :lo12:.LC27
	bl	puts
	adrp	x0, .LC28
	add	x0, x0, :lo12:.LC28
	bl	puts
	adrp	x0, .LC29
	add	x0, x0, :lo12:.LC29
	bl	puts
	adrp	x0, .LC30
	add	x0, x0, :lo12:.LC30
	bl	puts
	adrp	x0, .LC31
	add	x0, x0, :lo12:.LC31
	bl	puts
	adrp	x0, .LC32
	add	x0, x0, :lo12:.LC32
	bl	puts
	adrp	x0, .LC33
	add	x0, x0, :lo12:.LC33
	bl	puts
	adrp	x0, .LC34
	add	x0, x0, :lo12:.LC34
	bl	puts
	adrp	x0, .LC35
	add	x0, x0, :lo12:.LC35
	bl	puts
	adrp	x0, .LC36
	add	x0, x0, :lo12:.LC36
	bl	puts
	adrp	x0, .LC37
	add	x0, x0, :lo12:.LC37
	bl	puts
	adrp	x0, .LC38
	add	x0, x0, :lo12:.LC38
	bl	puts
	adrp	x0, .LC39
	add	x0, x0, :lo12:.LC39
	bl	puts
	adrp	x0, .LC40
	add	x0, x0, :lo12:.LC40
	bl	puts
	adrp	x0, .LC41
	add	x0, x0, :lo12:.LC41
	bl	puts
	adrp	x0, .LC42
	add	x0, x0, :lo12:.LC42
	bl	puts
	adrp	x0, .LC43
	add	x0, x0, :lo12:.LC43
	bl	puts
	adrp	x0, .LC44
	add	x0, x0, :lo12:.LC44
	bl	puts
	adrp	x0, .LC45
	add	x0, x0, :lo12:.LC45
	bl	puts
	adrp	x0, .LC46
	add	x0, x0, :lo12:.LC46
	bl	puts
	adrp	x0, .LC47
	add	x0, x0, :lo12:.LC47
	bl	puts
	adrp	x0, .LC48
	add	x0, x0, :lo12:.LC48
	bl	puts
	adrp	x0, .LC49
	add	x0, x0, :lo12:.LC49
	bl	puts
	adrp	x0, .LC50
	add	x0, x0, :lo12:.LC50
	bl	puts
	adrp	x0, .LC51
	add	x0, x0, :lo12:.LC51
	bl	puts
	adrp	x0, .LC52
	add	x0, x0, :lo12:.LC52
	bl	puts
	adrp	x0, .LC53
	add	x0, x0, :lo12:.LC53
	bl	puts
	adrp	x0, .LC54
	add	x0, x0, :lo12:.LC54
	bl	puts
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	b	puts
	.section	.rodata.str1.8
	.align	3
.LC56:
	.string	"yes"
	.align	3
.LC57:
	.string	"no"
	.align	3
.LC58:
	.string	"on"
	.align	3
.LC59:
	.string	"off"
	.align	3
.LC60:
	.string	"SUDO_USER"
	.align	3
.LC61:
	.string	"\033[1;31m[-] Running as a root login is not supported.\n    makepkg refuses to build as root, and there is no SUDO_USER\n    to drop back to. Use 'sudo emerge <package>' from your\n    normal account instead.\n\033[0m"
	.align	3
.LC62:
	.string	"native"
	.align	3
.LC63:
	.string	"\033[1;36mCurrent config: target=%s opt=-O%s pipe=%s chroot=%s binary=%s path=%s\n\033[0m"
	.align	3
.LC64:
	.string	"--version"
	.align	3
.LC65:
	.string	"%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n"
	.align	3
.LC66:
	.string	"Copyright (C) 2026 TheCookieGod64"
	.align	3
.LC67:
	.string	"License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>"
	.align	3
.LC68:
	.string	"--help"
	.align	3
.LC69:
	.string	"\033[1;36m\nActive config: target=%s opt=-O%s pipe=%s\n\033[0m"
	.align	3
.LC70:
	.string	"--noconfirm"
	.align	3
.LC71:
	.string	"--command-guide"
	.align	3
.LC72:
	.string	"--command-guide="
	.align	3
.LC73:
	.string	"\033[1;31m[-] Invalid command-guide mode (use first-run, always, or never).\n\033[0m"
	.align	3
.LC74:
	.string	"--interactive"
	.align	3
.LC75:
	.string	"--prompt-timeout"
	.align	3
.LC76:
	.string	"\033[1;31m[-] --prompt-timeout needs seconds.\n\033[0m"
	.align	3
.LC77:
	.string	"\033[1;31m[-] Invalid timeout (expected 0-86400).\n\033[0m"
	.align	3
.LC78:
	.string	"--resume"
	.align	3
.LC79:
	.string	"--no-keys"
	.align	3
.LC80:
	.string	"--no-inhibit"
	.align	3
.LC81:
	.string	"--no-sync"
	.align	3
.LC82:
	.string	"--no-aur-sync"
	.align	3
.LC83:
	.string	"--pipe"
	.align	3
.LC84:
	.string	"--no-pipe"
	.align	3
.LC85:
	.string	"--jobs"
	.align	3
.LC86:
	.string	"\033[1;31m[-] %s needs a number.\n\033[0m"
	.align	3
.LC87:
	.string	"\033[1;31m[-] Invalid job count '%s' (expected 1-1024).\n\033[0m"
	.align	3
.LC88:
	.string	"--jobs="
	.align	3
.LC89:
	.string	"\033[1;31m[-] Invalid job count.\n\033[0m"
	.align	3
.LC90:
	.string	"--target"
	.align	3
.LC91:
	.string	"--march"
	.align	3
.LC92:
	.string	"--cpu"
	.align	3
.LC93:
	.string	"\033[1;31m[-] %s needs an architecture name.\n\033[0m"
	.align	3
.LC94:
	.string	"help"
	.align	3
.LC95:
	.string	"list"
	.align	3
.LC96:
	.string	"\033[1;31m[-] Invalid target '%s'. Use --target help.\n\033[0m"
	.align	3
.LC97:
	.string	"--target="
	.align	3
.LC98:
	.string	"\033[1;31m[-] --target= needs a value.\n\033[0m"
	.align	3
.LC99:
	.string	"--march="
	.align	3
.LC100:
	.string	"\033[1;31m[-] --march= needs a value.\n\033[0m"
	.align	3
.LC101:
	.string	"\033[1;31m[-] Invalid march '%s'.\n\033[0m"
	.align	3
.LC102:
	.string	"--cpu="
	.align	3
.LC103:
	.string	"\033[1;31m[-] --cpu= needs a value.\n\033[0m"
	.align	3
.LC104:
	.string	"\033[1;31m[-] Invalid cpu '%s'.\n\033[0m"
	.align	3
.LC105:
	.string	"--opt-level"
	.align	3
.LC106:
	.string	"--opt"
	.align	3
.LC107:
	.string	"--optimization"
	.align	3
.LC108:
	.string	"-O"
	.align	3
.LC109:
	.string	"\033[1;31m[-] %s needs a level (0,1,2,3,s,fast,g,z).\n\033[0m"
	.align	3
.LC110:
	.string	"\033[1;31m[-] Invalid opt level '%s'. Use --opt-level help.\n\033[0m"
	.align	3
.LC111:
	.string	"--opt-level="
	.align	3
.LC112:
	.string	"\033[1;31m[-] --opt-level= needs a value.\n\033[0m"
	.align	3
.LC113:
	.string	"\033[1;31m[-] Invalid opt level '%s'.\n\033[0m"
	.align	3
.LC114:
	.string	"--opt="
	.align	3
.LC115:
	.string	"\033[1;31m[-] Invalid opt '%s'.\n\033[0m"
	.align	3
.LC116:
	.string	"--optimization="
	.align	3
.LC117:
	.string	"\033[1;31m[-] Invalid optimization '%s'.\n\033[0m"
	.align	3
.LC118:
	.string	"-O0"
	.align	3
.LC119:
	.string	"-O1"
	.align	3
.LC120:
	.string	"-O2"
	.align	3
.LC121:
	.string	"-O3"
	.align	3
.LC122:
	.string	"-Os"
	.align	3
.LC123:
	.string	"-Oz"
	.align	3
.LC124:
	.string	"-Og"
	.align	3
.LC125:
	.string	"-Ofast"
	.align	3
.LC126:
	.string	"fast"
	.align	3
.LC127:
	.string	"--gentoo-chroot"
	.align	3
.LC128:
	.string	"--imitation"
	.align	3
.LC129:
	.string	"--portage-imitation"
	.align	3
.LC130:
	.string	"--gentoo-imitation"
	.align	3
.LC131:
	.string	"--no-gentoo-chroot"
	.align	3
.LC132:
	.string	"--no-imitation"
	.align	3
.LC133:
	.string	"--chroot-path="
	.align	3
.LC134:
	.string	"\033[1;31m[-] Invalid chroot path '%s'\n\033[0m"
	.align	3
.LC135:
	.string	"--chroot-path"
	.align	3
.LC136:
	.string	"\033[1;31m[-] --chroot-path needs a path\n\033[0m"
	.align	3
.LC137:
	.string	"--binary"
	.align	3
.LC138:
	.string	"--use-binary"
	.align	3
.LC139:
	.string	"--use-bin"
	.align	3
.LC140:
	.string	"--bin"
	.align	3
.LC141:
	.string	"--prebuilt"
	.align	3
.LC142:
	.string	"--use-prebuilt"
	.align	3
.LC143:
	.string	"--no-build"
	.align	3
.LC144:
	.string	"--no-compile"
	.align	3
.LC145:
	.string	"--no-binary"
	.align	3
.LC146:
	.string	"--no-use-binary"
	.align	3
.LC147:
	.string	"--no-bin"
	.align	3
.LC148:
	.string	"--no-prebuilt"
	.align	3
.LC149:
	.string	"\033[1;36mCurrent: target=%s opt=-O%s pipe=%s chroot=%s binary=%s jobs=%ld path=%s\n\033[0m"
	.align	3
.LC150:
	.string	"\033[1;31m[-] Search requires exactly one query.\n\033[0m"
	.align	3
.LC151:
	.string	"-A"
	.align	3
.LC152:
	.string	"\033[1;31m[-] This operation requires a package.\n\033[0m"
	.align	3
.LC153:
	.string	"--orphans"
	.align	3
.LC154:
	.string	"--stats"
	.align	3
.LC155:
	.string	"--news"
	.align	3
.LC156:
	.string	"--complete"
	.align	3
.LC157:
	.string	"--devel"
	.align	3
.LC158:
	.string	"--providers"
	.align	3
.LC159:
	.string	"--deps"
	.align	3
.LC160:
	.string	"--review"
	.align	3
.LC161:
	.string	"\033[1;31m[-] --review requires a directory.\n\033[0m"
	.align	3
.LC162:
	.string	"-I"
	.align	3
.LC163:
	.string	"-G"
	.align	3
.LC164:
	.string	"-B"
	.align	3
.LC165:
	.string	"--clean"
	.align	3
.LC166:
	.string	"-U"
	.align	3
.LC167:
	.string	"--update"
	.align	3
.LC168:
	.string	"-D"
	.align	3
.LC169:
	.string	"--deselect"
	.align	3
.LC170:
	.string	"\033[1;31m[-] Error: specify a package to deselect.\n\033[0m"
	.align	3
.LC171:
	.string	"-C"
	.align	3
.LC172:
	.string	"--unmerge"
	.align	3
.LC173:
	.string	"\033[1;31m[-] Error: specify a package name to unmerge.\n\033[0m"
	.align	3
.LC174:
	.string	"\033[1;31m[-] Unknown option: %s\n\033[0m"
	.align	3
.LC175:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC176:
	.string	"\033[1;35m\n>>> [%d/%d] %s (binary mode)\n\033[0m"
	.align	3
.LC177:
	.string	"\033[1;31m\n[-] %d package(s) failed in binary mode.\n\033[0m"
	.align	3
.LC178:
	.string	"\033[1;35m\n>>> [%d/%d] %s (Gentoo chroot imitation)\n\033[0m"
	.align	3
.LC179:
	.string	"\033[1;31m\n[-] %d package(s) failed in Gentoo chroot mode.\n\033[0m"
	.align	3
.LC180:
	.string	"\033[1;35m\n>>> [%d/%d] %s\n\033[0m"
	.align	3
.LC181:
	.string	"\033[1;31m\n[-] %d package(s) failed.\n\033[0m"
	.align	3
.LC182:
	.string	"\033[1;33m    Tip: 'emerge --resume %s' continues from the existing\n    build tree instead of starting over.\n\033[0m"
	.align	3
.LC183:
	.string	"-Q"
	.text
	.align	2
	.p2align 5,,15
	.global	archtoo_cli_main
	.type	archtoo_cli_main, %function
archtoo_cli_main:
	sub	sp, sp, #2176
	stp	x29, x30, [sp]
	mov	x29, sp
	stp	x21, x22, [sp, 32]
	mov	x21, x1
	stp	x23, x24, [sp, 48]
	mov	w24, w0
	bl	geteuid
	cbnz	w0, .L5
	adrp	x0, .LC60
	add	x0, x0, :lo12:.LC60
	bl	getenv
	cbz	x0, .L490
.L5:
	bl	load_user_config
	cmp	w24, 1
	ble	.L491
	stp	x19, x20, [sp, 16]
	ldr	x19, [x21, 8]
	ldrb	w20, [x19]
	cmp	w20, 45
	bne	.L217
	ldrb	w0, [x19, 1]
	cmp	w0, 118
	bne	.L217
	ldrb	w0, [x19, 2]
	cbnz	w0, .L217
.L16:
	bl	get_target_arch
	mov	x21, x0
	bl	get_opt_level
	mov	x22, x0
	bl	get_use_pipe
	cbnz	w0, .L492
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	bl	get_gentoo_chroot
	cbz	w0, .L203
.L511:
	adrp	x20, .LC58
	add	x20, x20, :lo12:.LC58
	bl	get_use_binary
	cbz	w0, .L204
.L512:
	adrp	x7, .LC58
	add	x7, x7, :lo12:.LC58
.L20:
	mov	x6, x20
	mov	x5, x19
	mov	x4, x22
	mov	x3, x21
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	puts
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	puts
.L21:
	ldp	x19, x20, [sp, 16]
	mov	w22, 0
.L4:
	ldp	x29, x30, [sp]
	mov	w0, w22
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L217:
	adrp	x0, .LC64
	add	x1, x0, :lo12:.LC64
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L16
	cmp	w20, 45
	bne	.L218
	ldrb	w0, [x19, 1]
	cmp	w0, 104
	beq	.L493
.L218:
	adrp	x0, .LC68
	add	x1, x0, :lo12:.LC68
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L23
	adrp	x0, .LC70
	stp	x25, x26, [sp, 64]
	add	x25, x0, :lo12:.LC70
	adrp	x0, .LC71
	stp	x27, x28, [sp, 80]
	add	x27, x0, :lo12:.LC71
	adrp	x0, .LC72
	add	x28, x0, :lo12:.LC72
	mov	w20, 1
	mov	w22, 0
.L24:
	sbfiz	x23, x20, 3, 32
	mov	x1, x25
	add	x26, x21, x23
	ldr	x19, [x21, x23]
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L494
	mov	x1, x27
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L495
	mov	x1, x28
	mov	x0, x19
	mov	x2, 16
	bl	strncmp
	cbz	w0, .L496
	ldrb	w0, [x19]
	str	w0, [sp, 104]
	cmp	w0, 45
	bne	.L219
	ldrb	w0, [x19, 1]
	cmp	w0, 105
	beq	.L497
.L219:
	adrp	x1, .LC74
	mov	x0, x19
	add	x1, x1, :lo12:.LC74
	bl	strcmp
	cbz	w0, .L36
	adrp	x1, .LC75
	mov	x0, x19
	add	x1, x1, :lo12:.LC75
	bl	strcmp
	cbnz	w0, .L38
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L498
	ldr	x0, [x26, 8]
	add	x1, sp, 120
	mov	w2, 10
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x1, [sp, 120]
	cbz	x1, .L41
	ldrb	w1, [x1]
	cbnz	w1, .L41
	mov	x1, 20864
	movk	x1, 0x1, lsl 16
	cmp	x0, x1
	bls	.L42
.L41:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 51
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC77
	add	x0, x0, :lo12:.LC77
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
.L499:
	mov	w0, w22
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L496:
	add	x1, sp, 120
	add	x0, x19, 16
	bl	guide_policy_parse
	cbnz	w0, .L33
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 77
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC73
	add	x0, x0, :lo12:.LC73
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
	.p2align 2,,3
.L493:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L218
.L23:
	bl	print_usage
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
	bl	strcmp
	cbz	w0, .L500
.L25:
	bl	get_target_arch
	mov	x19, x0
	bl	get_opt_level
	mov	x20, x0
	bl	get_use_pipe
	cbz	w0, .L206
	adrp	x3, .LC56
	add	x3, x3, :lo12:.LC56
.L27:
	mov	x2, x20
	mov	x1, x19
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	printf
	b	.L21
	.p2align 2,,3
.L497:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L219
.L36:
	mov	w0, 1
	bl	set_interactive
.L31:
	add	w20, w20, 1
	cmp	w22, 255
	ccmp	w24, w20, 4, ne
	bgt	.L24
	add	x20, sp, 128
	str	xzr, [x20, w22, sxtw 3]
	bl	guide_maybe_show
	cmp	w22, 1
	beq	.L501
	cbz	w22, .L502
	ldr	x19, [sp, 128]
	ldrb	w0, [x19]
	cmp	w0, 45
	beq	.L503
.L134:
	adrp	x1, .LC153
	mov	x0, x19
	add	x1, x1, :lo12:.LC153
	bl	strcmp
	cbz	w0, .L504
	adrp	x1, .LC154
	mov	x0, x19
	add	x1, x1, :lo12:.LC154
	bl	strcmp
	cbz	w0, .L505
	adrp	x1, .LC155
	mov	x0, x19
	add	x1, x1, :lo12:.LC155
	bl	strcmp
	cbz	w0, .L506
	adrp	x1, .LC156
	mov	x0, x19
	add	x1, x1, :lo12:.LC156
	bl	strcmp
	cbz	w0, .L507
	adrp	x1, .LC157
	mov	x0, x19
	add	x1, x1, :lo12:.LC157
	bl	strcmp
	cbz	w0, .L508
	mov	x0, x19
	adrp	x1, .LC158
	add	x1, x1, :lo12:.LC158
	bl	strcmp
	cmp	w22, 2
	cset	w23, eq
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L509
	mov	x0, x19
	adrp	x1, .LC159
	add	x1, x1, :lo12:.LC159
	bl	strcmp
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L510
	adrp	x1, .LC160
	mov	x0, x19
	add	x1, x1, :lo12:.LC160
	bl	strcmp
	cbnz	w0, .L147
	cmp	w22, 2
	beq	.L148
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 46
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC161
	add	x0, x0, :lo12:.LC161
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
	.p2align 2,,3
.L492:
	adrp	x19, .LC56
	add	x19, x19, :lo12:.LC56
	bl	get_gentoo_chroot
	cbnz	w0, .L511
.L203:
	adrp	x20, .LC59
	add	x20, x20, :lo12:.LC59
	bl	get_use_binary
	cbnz	w0, .L512
.L204:
	adrp	x7, .LC59
	add	x7, x7, :lo12:.LC59
	b	.L20
	.p2align 2,,3
.L38:
	ldr	w0, [sp, 104]
	cmp	w0, 45
	bne	.L220
	ldrb	w0, [x19, 1]
	cmp	w0, 114
	beq	.L513
.L220:
	adrp	x1, .LC78
	mov	x0, x19
	add	x1, x1, :lo12:.LC78
	bl	strcmp
	cbz	w0, .L44
	adrp	x1, .LC79
	mov	x0, x19
	add	x1, x1, :lo12:.LC79
	bl	strcmp
	cbz	w0, .L514
	adrp	x1, .LC80
	mov	x0, x19
	add	x1, x1, :lo12:.LC80
	bl	strcmp
	cbz	w0, .L515
	adrp	x1, .LC81
	mov	x0, x19
	add	x1, x1, :lo12:.LC81
	bl	strcmp
	cbz	w0, .L516
	adrp	x1, .LC82
	mov	x0, x19
	add	x1, x1, :lo12:.LC82
	bl	strcmp
	cbz	w0, .L517
	adrp	x1, .LC83
	mov	x0, x19
	add	x1, x1, :lo12:.LC83
	bl	strcmp
	cbz	w0, .L518
	adrp	x1, .LC84
	mov	x0, x19
	add	x1, x1, :lo12:.LC84
	bl	strcmp
	cbz	w0, .L519
	ldr	w0, [sp, 104]
	cmp	w0, 45
	bne	.L221
	ldrb	w0, [x19, 1]
	cmp	w0, 106
	bne	.L221
	ldrb	w0, [x19, 2]
	cbnz	w0, .L221
.L53:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L520
	add	x23, x23, 8
	mov	w2, 10
	add	x1, sp, 120
	str	xzr, [sp, 120]
	ldr	x0, [x21, x23]
	bl	strtol
	ldr	x2, [sp, 120]
	cbz	x2, .L61
.L483:
	ldrb	w2, [x2]
	cbnz	w2, .L61
	sub	x1, x0, #1
	cmp	x1, 1023
	bls	.L65
.L61:
	ldr	x2, [x21, x23]
	adrp	x1, .LC87
	add	x1, x1, :lo12:.LC87
.L473:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
	.p2align 2,,3
.L33:
	ldr	w0, [sp, 120]
	bl	guide_set_policy
	b	.L31
	.p2align 2,,3
.L500:
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L25
	ldrb	w22, [x0, 1]
	cbnz	w22, .L25
	ldp	x19, x20, [sp, 16]
	b	.L4
	.p2align 2,,3
.L494:
	mov	w0, 1
	bl	set_noconfirm
	b	.L31
	.p2align 2,,3
.L495:
	bl	guide_request_explicit
	b	.L31
	.p2align 2,,3
.L491:
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
	bl	strcmp
	cbnz	w0, .L8
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	beq	.L521
.L8:
	stp	x19, x20, [sp, 16]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cbz	w0, .L199
	adrp	x19, .LC56
	add	x19, x19, :lo12:.LC56
.L11:
	bl	get_gentoo_chroot
	cbz	w0, .L200
	adrp	x20, .LC58
	add	x20, x20, :lo12:.LC58
.L12:
	bl	get_use_binary
	cbz	w0, .L201
	adrp	x21, .LC58
	add	x21, x21, :lo12:.LC58
.L13:
	bl	get_gentoo_chroot_path
	mov	x6, x0
	mov	x4, x20
	mov	x3, x19
	mov	x5, x21
	mov	x2, x23
	mov	x1, x22
	adrp	x0, .LC63
	add	x0, x0, :lo12:.LC63
	bl	printf
	ldp	x19, x20, [sp, 16]
	bl	print_usage
.L522:
	mov	w22, 1
	b	.L499
	.p2align 2,,3
.L206:
	adrp	x3, .LC57
	add	x3, x3, :lo12:.LC57
	b	.L27
	.p2align 2,,3
.L201:
	adrp	x21, .LC59
	add	x21, x21, :lo12:.LC59
	b	.L13
	.p2align 2,,3
.L200:
	adrp	x20, .LC59
	add	x20, x20, :lo12:.LC59
	b	.L12
	.p2align 2,,3
.L199:
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	b	.L11
	.p2align 2,,3
.L513:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L220
.L44:
	mov	w0, 1
	bl	set_resume
	b	.L31
	.p2align 2,,3
.L490:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 208
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC61
	add	x0, x0, :lo12:.LC61
	bl	fwrite
	b	.L499
	.p2align 2,,3
.L521:
	ldrb	w0, [x0, 1]
	cbnz	w0, .L8
	bl	get_use_pipe
	cbz	w0, .L8
	bl	get_gentoo_chroot
	cbnz	w0, .L8
	bl	print_usage
	b	.L522
.L515:
	bl	set_inhibit
	b	.L31
	.p2align 2,,3
.L42:
	bl	set_prompt_timeout
	b	.L31
	.p2align 2,,3
.L514:
	bl	set_import_keys
	b	.L31
	.p2align 2,,3
.L221:
	adrp	x1, .LC85
	mov	x0, x19
	add	x1, x1, :lo12:.LC85
	bl	strcmp
	cbz	w0, .L53
	ldrb	w0, [x19]
	cmp	w0, 45
	bne	.L60
	ldrb	w0, [x19, 1]
	cmp	w0, 106
	bne	.L60
	bl	__ctype_b_loc
	ldr	x0, [x0]
	ldrb	w1, [x19, 2]
	ldrh	w0, [x0, x1, lsl 1]
	tbnz	x0, 11, .L523
.L60:
	adrp	x1, .LC88
	mov	x0, x19
	add	x1, x1, :lo12:.LC88
	mov	x2, 7
	bl	strncmp
	cbz	w0, .L524
	adrp	x1, .LC90
	mov	x0, x19
	add	x1, x1, :lo12:.LC90
	bl	strcmp
	cbz	w0, .L66
	adrp	x1, .LC91
	mov	x0, x19
	add	x1, x1, :lo12:.LC91
	bl	strcmp
	cbz	w0, .L66
	adrp	x1, .LC92
	mov	x0, x19
	add	x1, x1, :lo12:.LC92
	bl	strcmp
	cbz	w0, .L66
	adrp	x1, .LC97
	mov	x0, x19
	add	x1, x1, :lo12:.LC97
	mov	x2, 9
	bl	strncmp
	cbnz	w0, .L72
	ldrb	w0, [x19, 9]
	cbz	w0, .L525
	add	x19, x19, 9
.L488:
	adrp	x1, .LC94
	mov	x0, x19
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC95
	mov	x0, x19
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L69
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L80
	adrp	x1, .LC96
	mov	x2, x19
	add	x1, x1, :lo12:.LC96
	b	.L473
.L516:
	bl	set_sync
	b	.L31
.L501:
	ldr	x19, [sp, 128]
	ldrb	w23, [x19]
	cmp	w23, 45
	bne	.L222
	ldrb	w0, [x19, 1]
	cmp	w0, 118
	bne	.L222
	ldrb	w0, [x19, 2]
	cbnz	w0, .L222
.L115:
	bl	get_target_arch
	mov	x21, x0
	bl	get_opt_level
	mov	x22, x0
	bl	get_use_pipe
	cbz	w0, .L207
	adrp	x19, .LC56
	add	x19, x19, :lo12:.LC56
.L117:
	bl	get_gentoo_chroot
	cbz	w0, .L208
	adrp	x20, .LC58
	add	x20, x20, :lo12:.LC58
.L118:
	bl	get_use_binary
	cbz	w0, .L209
	adrp	x7, .LC58
	add	x7, x7, :lo12:.LC58
.L119:
	mov	x6, x20
	mov	x5, x19
	mov	x4, x22
	mov	x3, x21
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	puts
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L21
.L517:
	bl	set_aur_sync
	b	.L31
.L222:
	adrp	x0, .LC64
	add	x1, x0, :lo12:.LC64
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L115
	cmp	w23, 45
	bne	.L223
	ldrb	w0, [x19, 1]
	cmp	w0, 104
	bne	.L223
	ldrb	w0, [x19, 2]
	cbnz	w0, .L223
.L121:
	bl	print_usage
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L21
.L503:
	ldrb	w1, [x19, 1]
	cmp	w1, 83
	beq	.L526
.L130:
	cmp	w0, 45
	bne	.L134
	ldrb	w1, [x19, 1]
	cmp	w1, 81
	bne	.L225
	ldrb	w1, [x19, 2]
	cbnz	w1, .L225
.L133:
	add	x21, sp, 136
	mov	w20, 1
	mov	w23, 0
	b	.L139
	.p2align 2,,3
.L136:
	bl	cmd_available_info_v2
.L137:
	cmp	w0, 0
	add	w20, w20, 1
	cinc	w23, w23, eq
	add	x21, x21, 8
	cmp	w22, w20
	ble	.L527
.L139:
	ldrb	w1, [x19, 1]
	ldr	x0, [x21]
	cmp	w1, 81
	bne	.L136
	bl	cmd_query_v2
	b	.L137
.L518:
	mov	w0, 1
	bl	set_use_pipe
	b	.L31
.L65:
	bl	set_jobs
	b	.L31
.L519:
	bl	set_use_pipe
	b	.L31
.L527:
	cmp	w23, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L502:
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
	bl	strcmp
	cbnz	w0, .L124
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L124
	ldrb	w0, [x0, 1]
	cbnz	w0, .L124
	bl	get_use_pipe
	cbnz	w0, .L528
.L124:
	bl	get_target_arch
	mov	x23, x0
	bl	get_opt_level
	mov	x24, x0
	bl	get_use_pipe
	cbz	w0, .L211
	adrp	x19, .LC56
	add	x19, x19, :lo12:.LC56
.L126:
	bl	get_gentoo_chroot
	cbz	w0, .L212
	adrp	x20, .LC58
	add	x20, x20, :lo12:.LC58
.L127:
	bl	get_use_binary
	cbz	w0, .L213
	adrp	x21, .LC58
	add	x21, x21, :lo12:.LC58
.L128:
	bl	get_jobs
	str	x0, [sp, 104]
	bl	get_gentoo_chroot_path
	mov	x7, x0
	ldr	x6, [sp, 104]
	mov	x4, x20
	mov	x3, x19
	mov	x5, x21
	mov	x2, x24
	mov	x1, x23
	adrp	x0, .LC149
	add	x0, x0, :lo12:.LC149
	bl	printf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L223:
	adrp	x0, .LC68
	add	x1, x0, :lo12:.LC68
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L121
	cmp	w23, 45
	bne	.L224
	ldrb	w0, [x19, 1]
	cmp	w0, 83
	bne	.L224
	ldrb	w0, [x19, 2]
	cbnz	w0, .L224
.L194:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC150
	add	x0, x0, :lo12:.LC150
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L526:
	ldrb	w1, [x19, 2]
	cbnz	w1, .L130
	cmp	w22, 2
	bne	.L194
	ldr	x0, [sp, 136]
	bl	cmd_search_v2
.L479:
	cmp	w0, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, eq
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L498:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 47
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC76
	add	x0, x0, :lo12:.LC76
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L66:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L529
	ldr	x19, [x26, 8]
	b	.L488
.L209:
	adrp	x7, .LC59
	add	x7, x7, :lo12:.LC59
	b	.L119
.L207:
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	b	.L117
.L208:
	adrp	x20, .LC59
	add	x20, x20, :lo12:.LC59
	b	.L118
.L213:
	adrp	x21, .LC59
	add	x21, x21, :lo12:.LC59
	b	.L128
.L212:
	adrp	x20, .LC59
	add	x20, x20, :lo12:.LC59
	b	.L127
.L211:
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	b	.L126
.L225:
	cmp	w0, 45
	bne	.L134
	ldrb	w0, [x19, 1]
	cmp	w0, 65
	bne	.L134
	ldrb	w0, [x19, 2]
	cbz	w0, .L133
	b	.L134
	.p2align 2,,3
.L524:
	mov	w2, 10
	add	x1, sp, 120
	add	x0, x19, 7
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x2, [sp, 120]
	cbz	x2, .L64
	ldrb	w2, [x2]
	cbnz	w2, .L64
	sub	x1, x0, #1
	cmp	x1, 1023
	bls	.L65
.L64:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 34
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC89
	add	x0, x0, :lo12:.LC89
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L80:
	mov	x0, x19
	bl	set_target_arch
	b	.L31
.L224:
	adrp	x1, .LC183
	mov	x0, x19
	add	x1, x1, :lo12:.LC183
	bl	strcmp
	cbz	w0, .L195
	adrp	x1, .LC151
	mov	x0, x19
	add	x1, x1, :lo12:.LC151
	bl	strcmp
	cbnz	w0, .L134
.L195:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC152
	add	x0, x0, :lo12:.LC152
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L523:
	mov	w2, 10
	add	x1, sp, 120
	add	x0, x19, 2
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x2, [sp, 120]
	cbnz	x2, .L483
	b	.L61
.L520:
	adrp	x1, .LC86
	mov	x2, x19
	add	x1, x1, :lo12:.LC86
	b	.L473
.L504:
	bl	cmd_orphans_v2
	b	.L479
.L507:
	bl	cmd_completion_v2
	b	.L479
.L506:
	bl	cmd_news_v2
	b	.L479
.L505:
	bl	cmd_stats_v2
	b	.L479
.L528:
	bl	get_gentoo_chroot
	cbnz	w0, .L124
.L470:
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L69:
	bl	print_known_targets
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L21
.L508:
	bl	cmd_devel_v2
	b	.L479
.L72:
	adrp	x1, .LC99
	mov	x0, x19
	add	x1, x1, :lo12:.LC99
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L75
	ldrb	w0, [x19, 8]
	cbz	w0, .L530
	add	x19, x19, 8
	adrp	x1, .LC94
	mov	x0, x19
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L69
	adrp	x1, .LC95
	mov	x0, x19
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L69
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L80
	adrp	x1, .LC101
	mov	x2, x19
	add	x1, x1, :lo12:.LC101
	b	.L473
.L148:
	ldr	x0, [sp, 136]
	bl	cmd_review_v2
	b	.L479
.L147:
	mov	x1, x21
	mov	w0, w24
	bl	acquire_sudo
	cbz	w0, .L471
	mov	x0, x19
	adrp	x1, .LC162
	add	x1, x1, :lo12:.LC162
	bl	strcmp
	mov	w21, w0
	cbnz	w0, .L149
	cmp	w22, 1
	beq	.L470
	bl	init_system
	cbnz	w0, .L531
.L471:
	ldp	x19, x20, [sp, 16]
	mov	w22, 1
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L75:
	adrp	x1, .LC102
	mov	x0, x19
	add	x1, x1, :lo12:.LC102
	mov	x2, 6
	bl	strncmp
	cbnz	w0, .L78
	ldrb	w0, [x19, 6]
	cbz	w0, .L532
	add	x19, x19, 6
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L80
	adrp	x1, .LC104
	mov	x2, x19
	add	x1, x1, :lo12:.LC104
	b	.L473
.L530:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 39
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC100
	add	x0, x0, :lo12:.LC100
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L532:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 37
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC103
	add	x0, x0, :lo12:.LC103
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L78:
	adrp	x1, .LC105
	mov	x0, x19
	add	x1, x1, :lo12:.LC105
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC106
	mov	x0, x19
	add	x1, x1, :lo12:.LC106
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC107
	mov	x0, x19
	add	x1, x1, :lo12:.LC107
	bl	strcmp
	cbz	w0, .L81
	adrp	x0, .LC108
	add	x1, x0, :lo12:.LC108
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L81
	adrp	x1, .LC111
	mov	x0, x19
	add	x1, x1, :lo12:.LC111
	mov	x2, 12
	bl	strncmp
	cbnz	w0, .L87
	ldrb	w0, [x19, 12]
	cbz	w0, .L533
	add	x19, x19, 12
	adrp	x1, .LC94
	mov	x0, x19
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L84
	adrp	x1, .LC95
	mov	x0, x19
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L84
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L454
	adrp	x1, .LC113
	mov	x2, x19
	add	x1, x1, :lo12:.LC113
	b	.L473
.L510:
	ldr	x0, [sp, 136]
	bl	cmd_dependency_plan_v2
	b	.L479
.L509:
	ldr	x0, [sp, 136]
	bl	cmd_provider_v2
	b	.L479
.L454:
	mov	x0, x19
	bl	set_opt_level
	b	.L31
.L84:
	bl	print_known_opt_levels
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L21
.L533:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 43
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC112
	add	x0, x0, :lo12:.LC112
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L87:
	adrp	x1, .LC114
	mov	x0, x19
	add	x1, x1, :lo12:.LC114
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L534
	adrp	x1, .LC116
	mov	x0, x19
	add	x1, x1, :lo12:.LC116
	mov	x2, 15
	bl	strncmp
	cbz	w0, .L535
	adrp	x1, .LC118
	mov	x0, x19
	add	x1, x1, :lo12:.LC118
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC119
	mov	x0, x19
	add	x1, x1, :lo12:.LC119
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC120
	mov	x0, x19
	add	x1, x1, :lo12:.LC120
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC121
	mov	x0, x19
	add	x1, x1, :lo12:.LC121
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC122
	mov	x0, x19
	add	x1, x1, :lo12:.LC122
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC123
	mov	x0, x19
	add	x1, x1, :lo12:.LC123
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC124
	mov	x0, x19
	add	x1, x1, :lo12:.LC124
	bl	strcmp
	cbz	w0, .L454
	adrp	x1, .LC125
	mov	x0, x19
	add	x1, x1, :lo12:.LC125
	bl	strcmp
	cbz	w0, .L536
	adrp	x0, .LC108
	mov	x2, 2
	add	x1, x0, :lo12:.LC108
	mov	x0, x19
	bl	strncmp
	cbnz	w0, .L97
	mov	x0, x19
	bl	strlen
	cmp	x0, 7
	bhi	.L97
	ldrb	w0, [x19, 2]
	cmp	w0, 61
	cinc	x19, x19, eq
	add	x19, x19, 2
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L454
	ldr	x19, [x21, x23]
.L97:
	adrp	x1, .LC127
	mov	x0, x19
	add	x1, x1, :lo12:.LC127
	bl	strcmp
	cbz	w0, .L100
	adrp	x1, .LC128
	mov	x0, x19
	add	x1, x1, :lo12:.LC128
	bl	strcmp
	cbz	w0, .L100
	adrp	x1, .LC129
	mov	x0, x19
	add	x1, x1, :lo12:.LC129
	bl	strcmp
	cbz	w0, .L100
	adrp	x1, .LC130
	mov	x0, x19
	add	x1, x1, :lo12:.LC130
	bl	strcmp
	cbz	w0, .L100
	adrp	x1, .LC131
	mov	x0, x19
	add	x1, x1, :lo12:.LC131
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC132
	mov	x0, x19
	add	x1, x1, :lo12:.LC132
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC133
	mov	x0, x19
	add	x1, x1, :lo12:.LC133
	mov	x2, 14
	bl	strncmp
	cbz	w0, .L537
	adrp	x1, .LC135
	mov	x0, x19
	add	x1, x1, :lo12:.LC135
	bl	strcmp
	cbnz	w0, .L106
	add	w20, w20, 1
	cmp	w24, w20
	ble	.L538
	ldr	x19, [x26, 8]
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L108
.L475:
	adrp	x1, .LC134
	mov	x2, x19
	add	x1, x1, :lo12:.LC134
	b	.L473
.L536:
	adrp	x0, .LC126
	add	x0, x0, :lo12:.LC126
	bl	set_opt_level
	b	.L31
.L535:
	add	x19, x19, 15
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L454
	adrp	x1, .LC117
	mov	x2, x19
	add	x1, x1, :lo12:.LC117
	b	.L473
.L529:
	adrp	x1, .LC93
	mov	x2, x19
	add	x1, x1, :lo12:.LC93
	b	.L473
.L525:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 40
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC98
	add	x0, x0, :lo12:.LC98
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L531:
	bl	get_use_binary
	cbz	w0, .L150
	mov	x19, 1
.L152:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L152
.L480:
	cmp	w21, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L149:
	mov	x0, x19
	adrp	x1, .LC163
	add	x1, x1, :lo12:.LC163
	bl	strcmp
	mov	w21, w0
	cbnz	w0, .L158
	cmp	w22, 1
	beq	.L470
	mov	x19, 1
.L160:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_get_pkgbuild_v2
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L160
	b	.L480
.L150:
	bl	get_gentoo_chroot
	mov	w21, w0
	cbz	w0, .L214
	mov	w21, 0
	mov	x19, 1
.L156:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_gentoo_imitation_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L156
	b	.L480
.L158:
	adrp	x1, .LC164
	mov	x0, x19
	add	x1, x1, :lo12:.LC164
	bl	strcmp
	cbz	w0, .L539
	adrp	x1, .LC165
	mov	x0, x19
	add	x1, x1, :lo12:.LC165
	bl	strcmp
	cbz	w0, .L540
	adrp	x1, .LC166
	mov	x0, x19
	add	x1, x1, :lo12:.LC166
	bl	strcmp
	cbz	w0, .L163
	adrp	x1, .LC167
	mov	x0, x19
	add	x1, x1, :lo12:.LC167
	bl	strcmp
	cbz	w0, .L163
	adrp	x1, .LC168
	mov	x0, x19
	add	x1, x1, :lo12:.LC168
	bl	strcmp
	cbz	w0, .L165
	adrp	x1, .LC169
	mov	x0, x19
	add	x1, x1, :lo12:.LC169
	bl	strcmp
	cbz	w0, .L165
	adrp	x1, .LC171
	mov	x0, x19
	add	x1, x1, :lo12:.LC171
	bl	strcmp
	cbz	w0, .L170
	adrp	x1, .LC172
	mov	x0, x19
	add	x1, x1, :lo12:.LC172
	bl	strcmp
	cbz	w0, .L170
	ldrb	w0, [x19]
	mov	x21, 0
	cmp	w0, 45
	beq	.L541
.L175:
	ldr	x23, [x20, x21, lsl 3]
	mov	x0, x23
	bl	valid_pkgname
	cbz	w0, .L542
	add	x21, x21, 1
	cmp	w22, w21
	bgt	.L175
	bl	init_system
	cbz	w0, .L471
	bl	get_use_binary
	mov	w23, w0
	cbz	w0, .L177
	adrp	x23, .LC176
	mov	x21, 0
	add	x23, x23, :lo12:.LC176
	mov	w19, 0
	b	.L180
.L543:
	mov	x3, x24
	mov	w2, w22
	add	w1, w21, 1
	mov	x0, x23
	bl	printf
	mov	x0, x24
	bl	cmd_build
	cbz	w0, .L187
.L179:
	add	x21, x21, 1
	cmp	w22, w21
	ble	.L476
.L180:
	ldr	x24, [x20, x21, lsl 3]
	cmp	w22, 1
	bne	.L543
	mov	x0, x24
	bl	cmd_build
	cbnz	w0, .L476
.L187:
	add	w19, w19, 1
	b	.L179
.L214:
	mov	x19, 1
.L154:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L154
	b	.L480
.L542:
	adrp	x1, .LC175
	mov	x2, x23
	add	x1, x1, :lo12:.LC175
	b	.L473
.L476:
	mov	w22, w19
	cbz	w19, .L470
	adrp	x1, .LC177
	mov	w2, w19
	add	x1, x1, :lo12:.LC177
.L474:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L177:
	bl	get_gentoo_chroot
	mov	w21, w0
	cbz	w0, .L216
	adrp	x21, .LC178
	mov	x19, 0
	add	x21, x21, :lo12:.LC178
	b	.L184
.L544:
	mov	x3, x24
	mov	w2, w22
	add	w1, w19, 1
	mov	x0, x21
	bl	printf
	mov	x0, x24
	bl	cmd_gentoo_imitation_build
	cbz	w0, .L189
.L183:
	add	x19, x19, 1
	cmp	w22, w19
	ble	.L477
.L184:
	ldr	x24, [x20, x19, lsl 3]
	cmp	w22, 1
	bne	.L544
	mov	x0, x24
	bl	cmd_gentoo_imitation_build
	cbnz	w0, .L477
.L189:
	add	w23, w23, 1
	b	.L183
.L541:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC174
	add	x1, x1, :lo12:.LC174
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	bl	print_usage
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L170:
	cmp	w22, 1
	beq	.L545
	bl	init_system
	cbz	w0, .L471
	mov	x19, 1
	mov	w21, 0
.L174:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_unmerge
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L174
	b	.L480
.L477:
	mov	w22, w23
	cbz	w23, .L470
	adrp	x1, .LC179
	mov	w2, w23
	add	x1, x1, :lo12:.LC179
	b	.L474
.L534:
	add	x19, x19, 6
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L454
	adrp	x1, .LC115
	mov	x2, x19
	add	x1, x1, :lo12:.LC115
	b	.L473
.L81:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L546
	ldr	x19, [x26, 8]
	adrp	x1, .LC94
	add	x1, x1, :lo12:.LC94
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L84
	adrp	x1, .LC95
	mov	x0, x19
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L84
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L454
	adrp	x1, .LC110
	mov	x2, x19
	add	x1, x1, :lo12:.LC110
	b	.L473
.L537:
	add	x19, x19, 14
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbz	w0, .L475
.L108:
	mov	x0, x19
	bl	set_gentoo_chroot_path
	b	.L31
.L538:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 42
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC136
	add	x0, x0, :lo12:.LC136
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
.L546:
	adrp	x1, .LC109
	mov	x2, x19
	add	x1, x1, :lo12:.LC109
	b	.L473
.L106:
	adrp	x1, .LC137
	mov	x0, x19
	add	x1, x1, :lo12:.LC137
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC138
	mov	x0, x19
	add	x1, x1, :lo12:.LC138
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC139
	mov	x0, x19
	add	x1, x1, :lo12:.LC139
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC140
	mov	x0, x19
	add	x1, x1, :lo12:.LC140
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC141
	mov	x0, x19
	add	x1, x1, :lo12:.LC141
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC142
	mov	x0, x19
	add	x1, x1, :lo12:.LC142
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC143
	mov	x0, x19
	add	x1, x1, :lo12:.LC143
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC144
	mov	x0, x19
	add	x1, x1, :lo12:.LC144
	bl	strcmp
	cbz	w0, .L109
	adrp	x1, .LC145
	mov	x0, x19
	add	x1, x1, :lo12:.LC145
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC146
	mov	x0, x19
	add	x1, x1, :lo12:.LC146
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC147
	mov	x0, x19
	add	x1, x1, :lo12:.LC147
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC148
	mov	x0, x19
	add	x1, x1, :lo12:.LC148
	bl	strcmp
	cbz	w0, .L111
	add	x0, sp, 128
	str	x19, [x0, w22, sxtw 3]
	add	w22, w22, 1
	b	.L31
.L111:
	mov	w0, 0
	bl	set_use_binary
	b	.L31
.L109:
	mov	w0, 1
	bl	set_use_binary
	b	.L31
.L102:
	bl	set_gentoo_chroot
	mov	w0, 0
	bl	set_portage_imitation
	b	.L31
.L100:
	mov	w0, 1
	bl	set_gentoo_chroot
	mov	w0, 1
	bl	set_portage_imitation
	b	.L31
.L165:
	cmp	w22, 1
	beq	.L547
	bl	init_system
	cbz	w0, .L471
	mov	x19, 1
	mov	w21, 0
.L169:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_deselect
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L169
	b	.L480
.L163:
	bl	init_system
	cbz	w0, .L471
	bl	cmd_world_update
	b	.L479
.L547:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 53
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC170
	add	x0, x0, :lo12:.LC170
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L540:
	bl	cmd_clean_v2
	b	.L479
.L539:
	cmp	w22, 2
	bne	.L471
	ldr	x0, [sp, 136]
	bl	cmd_local_build_v2
	b	.L479
.L216:
	adrp	x24, .LC180
	mov	x23, 0
	add	x24, x24, :lo12:.LC180
	b	.L181
.L548:
	mov	w2, w22
	add	w1, w23, 1
	mov	x0, x24
	str	x3, [sp, 104]
	bl	printf
	ldr	x0, [sp, 104]
	bl	cmd_build
	cbz	w0, .L191
.L186:
	add	x23, x23, 1
	cmp	w22, w23
	ble	.L478
.L181:
	ldr	x3, [x20, x23, lsl 3]
	cmp	w22, 1
	bne	.L548
	mov	x0, x3
	bl	cmd_build
	cbnz	w0, .L478
.L191:
	add	w21, w21, 1
	b	.L186
.L545:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 57
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC173
	add	x0, x0, :lo12:.LC173
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L478:
	mov	w22, w21
	cbz	w21, .L470
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	mov	w2, w21
	adrp	x1, .LC181
	add	x1, x1, :lo12:.LC181
	ldr	x0, [x20]
	bl	fprintf
	bl	get_resume
	cbnz	w0, .L471
	ldr	x0, [x20]
	mov	x2, x19
	adrp	x1, .LC182
	mov	w22, 1
	add	x1, x1, :lo12:.LC182
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L499
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
	.aeabi_attribute Tag_Feature_BTI, 0
	.aeabi_attribute Tag_Feature_PAC, 0
	.aeabi_attribute Tag_Feature_GCS, 0
