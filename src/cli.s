	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"1.1.0"
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
	.string	"  --raw \"FLAGS\"          Extra raw flags appended to CFLAGS/CXXFLAGS/LDFLAGS"
	.align	3
.LC39:
	.string	"                         e.g. --raw \"-march=native -fuse-ld=mold\" (plain options only)"
	.align	3
.LC40:
	.string	"  --pipe                 Enable -pipe (default)"
	.align	3
.LC41:
	.string	"  --no-pipe              Disable -pipe"
	.align	3
.LC42:
	.string	"  --gentoo-chroot        Enable SUPER HARD Portage imitation via Gentoo chroot"
	.align	3
.LC43:
	.string	"  --imitation            Alias for --gentoo-chroot"
	.align	3
.LC44:
	.string	"  --no-gentoo-chroot     Disable chroot imitation"
	.align	3
.LC45:
	.string	"  --chroot-path PATH     Custom chroot path (default: /usr/local/emerge/gentoo-chroot)"
	.align	3
.LC46:
	.string	"  --binary               Try sudo pacman -S first, then yay-style AUR search for a prebuilt -bin (long flag only)"
	.align	3
.LC47:
	.string	"                         Long flag only, no short form"
	.align	3
.LC48:
	.string	"  --use-binary           Alias for --binary"
	.align	3
.LC49:
	.string	"  --no-binary            Disable binary mode"
	.align	3
.LC50:
	.string	"  -r, --resume           Reuse the existing build tree and continue"
	.align	3
.LC51:
	.string	"                         an interrupted compile"
	.align	3
.LC52:
	.string	"  --no-keys              Do not import missing PGP signing keys"
	.align	3
.LC53:
	.string	"  --no-inhibit           Allow the machine to suspend while building"
	.align	3
.LC54:
	.string	"  --no-sync              Skip pacman -Syu during a world update"
	.align	3
.LC55:
	.string	"  --no-aur-sync          Reuse local AUR @world sources; do not refresh"
	.align	3
.LC56:
	.string	"  --command-guide        Display the command guide now"
	.align	3
.LC57:
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
	adrp	x0, .LC55
	add	x0, x0, :lo12:.LC55
	bl	puts
	adrp	x0, .LC56
	add	x0, x0, :lo12:.LC56
	bl	puts
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC57
	add	x0, x0, :lo12:.LC57
	b	puts
	.section	.rodata.str1.8
	.align	3
.LC58:
	.string	"yes"
	.align	3
.LC59:
	.string	"no"
	.align	3
.LC60:
	.string	"on"
	.align	3
.LC61:
	.string	"off"
	.align	3
.LC62:
	.string	"none"
	.align	3
.LC63:
	.string	"SUDO_USER"
	.align	3
.LC64:
	.string	"\033[1;31m[-] Running as a root login is not supported.\n    makepkg refuses to build as root, and there is no SUDO_USER\n    to drop back to. Use 'sudo emerge <package>' from your\n    normal account instead.\n\033[0m"
	.align	3
.LC65:
	.string	"native"
	.align	3
.LC66:
	.string	"\033[1;36mCurrent config: target=%s opt=-O%s pipe=%s chroot=%s binary=%s path=%s raw=%s\n\033[0m"
	.align	3
.LC67:
	.string	"--version"
	.align	3
.LC68:
	.string	"%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n"
	.align	3
.LC69:
	.string	"Copyright (C) 2026 TheCookieGod64"
	.align	3
.LC70:
	.string	"License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>"
	.align	3
.LC71:
	.string	"--help"
	.align	3
.LC72:
	.string	"\033[1;36m\nActive config: target=%s opt=-O%s pipe=%s raw=%s\n\033[0m"
	.align	3
.LC73:
	.string	"--noconfirm"
	.align	3
.LC74:
	.string	"--command-guide"
	.align	3
.LC75:
	.string	"--command-guide="
	.align	3
.LC76:
	.string	"\033[1;31m[-] Invalid command-guide mode (use first-run, always, or never).\n\033[0m"
	.align	3
.LC77:
	.string	"--interactive"
	.align	3
.LC78:
	.string	"--prompt-timeout"
	.align	3
.LC79:
	.string	"\033[1;31m[-] --prompt-timeout needs seconds.\n\033[0m"
	.align	3
.LC80:
	.string	"\033[1;31m[-] Invalid timeout (expected 0-86400).\n\033[0m"
	.align	3
.LC81:
	.string	"--resume"
	.align	3
.LC82:
	.string	"--no-keys"
	.align	3
.LC83:
	.string	"--no-inhibit"
	.align	3
.LC84:
	.string	"--no-sync"
	.align	3
.LC85:
	.string	"--no-aur-sync"
	.align	3
.LC86:
	.string	"--pipe"
	.align	3
.LC87:
	.string	"--no-pipe"
	.align	3
.LC88:
	.string	"--jobs"
	.align	3
.LC89:
	.string	"\033[1;31m[-] %s needs a number.\n\033[0m"
	.align	3
.LC90:
	.string	"\033[1;31m[-] Invalid job count '%s' (expected 1-1024).\n\033[0m"
	.align	3
.LC91:
	.string	"--jobs="
	.align	3
.LC92:
	.string	"\033[1;31m[-] Invalid job count.\n\033[0m"
	.align	3
.LC93:
	.string	"--target"
	.align	3
.LC94:
	.string	"--march"
	.align	3
.LC95:
	.string	"--cpu"
	.align	3
.LC96:
	.string	"\033[1;31m[-] %s needs an architecture name.\n\033[0m"
	.align	3
.LC97:
	.string	"help"
	.align	3
.LC98:
	.string	"list"
	.align	3
.LC99:
	.string	"\033[1;31m[-] Invalid target '%s'. Use --target help.\n\033[0m"
	.align	3
.LC100:
	.string	"--target="
	.align	3
.LC101:
	.string	"\033[1;31m[-] --target= needs a value.\n\033[0m"
	.align	3
.LC102:
	.string	"--march="
	.align	3
.LC103:
	.string	"\033[1;31m[-] --march= needs a value.\n\033[0m"
	.align	3
.LC104:
	.string	"\033[1;31m[-] Invalid march '%s'.\n\033[0m"
	.align	3
.LC105:
	.string	"--cpu="
	.align	3
.LC106:
	.string	"\033[1;31m[-] --cpu= needs a value.\n\033[0m"
	.align	3
.LC107:
	.string	"\033[1;31m[-] Invalid cpu '%s'.\n\033[0m"
	.align	3
.LC108:
	.string	"--opt-level"
	.align	3
.LC109:
	.string	"--opt"
	.align	3
.LC110:
	.string	"--optimization"
	.align	3
.LC111:
	.string	"-O"
	.align	3
.LC112:
	.string	"\033[1;31m[-] %s needs a level (0,1,2,3,s,fast,g,z).\n\033[0m"
	.align	3
.LC113:
	.string	"\033[1;31m[-] Invalid opt level '%s'. Use --opt-level help.\n\033[0m"
	.align	3
.LC114:
	.string	"--opt-level="
	.align	3
.LC115:
	.string	"\033[1;31m[-] --opt-level= needs a value.\n\033[0m"
	.align	3
.LC116:
	.string	"\033[1;31m[-] Invalid opt level '%s'.\n\033[0m"
	.align	3
.LC117:
	.string	"--opt="
	.align	3
.LC118:
	.string	"\033[1;31m[-] Invalid opt '%s'.\n\033[0m"
	.align	3
.LC119:
	.string	"--optimization="
	.align	3
.LC120:
	.string	"\033[1;31m[-] Invalid optimization '%s'.\n\033[0m"
	.align	3
.LC121:
	.string	"-O0"
	.align	3
.LC122:
	.string	"-O1"
	.align	3
.LC123:
	.string	"-O2"
	.align	3
.LC124:
	.string	"-O3"
	.align	3
.LC125:
	.string	"-Os"
	.align	3
.LC126:
	.string	"-Oz"
	.align	3
.LC127:
	.string	"-Og"
	.align	3
.LC128:
	.string	"-Ofast"
	.align	3
.LC129:
	.string	"fast"
	.align	3
.LC130:
	.string	"--raw"
	.align	3
.LC131:
	.string	"\033[1;31m[-] --raw needs a flags string.\n\033[0m"
	.align	3
.LC132:
	.string	"\033[1;31m[-] Invalid --raw: plain options only (-march=x, -fuse-ld=y; no shell metacharacters, <= 192 chars).\n\033[0m"
	.align	3
.LC133:
	.string	"--raw="
	.align	3
.LC134:
	.string	"--gentoo-chroot"
	.align	3
.LC135:
	.string	"--imitation"
	.align	3
.LC136:
	.string	"--portage-imitation"
	.align	3
.LC137:
	.string	"--gentoo-imitation"
	.align	3
.LC138:
	.string	"--no-gentoo-chroot"
	.align	3
.LC139:
	.string	"--no-imitation"
	.align	3
.LC140:
	.string	"--chroot-path="
	.align	3
.LC141:
	.string	"\033[1;31m[-] Invalid chroot path '%s'\n\033[0m"
	.align	3
.LC142:
	.string	"--chroot-path"
	.align	3
.LC143:
	.string	"\033[1;31m[-] --chroot-path needs a path\n\033[0m"
	.align	3
.LC144:
	.string	"--binary"
	.align	3
.LC145:
	.string	"--use-binary"
	.align	3
.LC146:
	.string	"--use-bin"
	.align	3
.LC147:
	.string	"--bin"
	.align	3
.LC148:
	.string	"--prebuilt"
	.align	3
.LC149:
	.string	"--use-prebuilt"
	.align	3
.LC150:
	.string	"--no-build"
	.align	3
.LC151:
	.string	"--no-compile"
	.align	3
.LC152:
	.string	"--no-binary"
	.align	3
.LC153:
	.string	"--no-use-binary"
	.align	3
.LC154:
	.string	"--no-bin"
	.align	3
.LC155:
	.string	"--no-prebuilt"
	.align	3
.LC156:
	.string	"\033[1;36mCurrent: target=%s opt=-O%s pipe=%s chroot=%s binary=%s jobs=%ld path=%s\n\033[0m"
	.align	3
.LC157:
	.string	"\033[1;31m[-] Search requires exactly one query.\n\033[0m"
	.align	3
.LC158:
	.string	"-A"
	.align	3
.LC159:
	.string	"\033[1;31m[-] This operation requires a package.\n\033[0m"
	.align	3
.LC160:
	.string	"--orphans"
	.align	3
.LC161:
	.string	"--stats"
	.align	3
.LC162:
	.string	"--news"
	.align	3
.LC163:
	.string	"--complete"
	.align	3
.LC164:
	.string	"--devel"
	.align	3
.LC165:
	.string	"--providers"
	.align	3
.LC166:
	.string	"--deps"
	.align	3
.LC167:
	.string	"--review"
	.align	3
.LC168:
	.string	"\033[1;31m[-] --review requires a directory.\n\033[0m"
	.align	3
.LC169:
	.string	"-I"
	.align	3
.LC170:
	.string	"-G"
	.align	3
.LC171:
	.string	"-B"
	.align	3
.LC172:
	.string	"--clean"
	.align	3
.LC173:
	.string	"-U"
	.align	3
.LC174:
	.string	"--update"
	.align	3
.LC175:
	.string	"-D"
	.align	3
.LC176:
	.string	"--deselect"
	.align	3
.LC177:
	.string	"\033[1;31m[-] Error: specify a package to deselect.\n\033[0m"
	.align	3
.LC178:
	.string	"-C"
	.align	3
.LC179:
	.string	"--unmerge"
	.align	3
.LC180:
	.string	"\033[1;31m[-] Error: specify a package name to unmerge.\n\033[0m"
	.align	3
.LC181:
	.string	"\033[1;31m[-] Unknown option: %s\n\033[0m"
	.align	3
.LC182:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC183:
	.string	"\033[1;35m\n>>> [%d/%d] %s (binary mode)\n\033[0m"
	.align	3
.LC184:
	.string	"\033[1;31m\n[-] %d package(s) failed in binary mode.\n\033[0m"
	.align	3
.LC185:
	.string	"\033[1;35m\n>>> [%d/%d] %s (Gentoo chroot imitation)\n\033[0m"
	.align	3
.LC186:
	.string	"\033[1;31m\n[-] %d package(s) failed in Gentoo chroot mode.\n\033[0m"
	.align	3
.LC187:
	.string	"\033[1;35m\n>>> [%d/%d] %s\n\033[0m"
	.align	3
.LC188:
	.string	"\033[1;31m\n[-] %d package(s) failed.\n\033[0m"
	.align	3
.LC189:
	.string	"\033[1;33m    Tip: 'emerge --resume %s' continues from the existing\n    build tree instead of starting over.\n\033[0m"
	.align	3
.LC190:
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
	adrp	x0, .LC63
	add	x0, x0, :lo12:.LC63
	bl	getenv
	cbz	x0, .L501
.L5:
	bl	load_user_config
	cmp	w24, 1
	ble	.L502
	stp	x19, x20, [sp, 16]
	ldr	x19, [x21, 8]
	ldrb	w20, [x19]
	cmp	w20, 45
	bne	.L225
	ldrb	w0, [x19, 1]
	cmp	w0, 118
	bne	.L225
	ldrb	w0, [x19, 2]
	cbnz	w0, .L225
.L17:
	bl	get_target_arch
	mov	x21, x0
	bl	get_opt_level
	mov	x22, x0
	bl	get_use_pipe
	cbnz	w0, .L503
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	bl	get_gentoo_chroot
	cbz	w0, .L210
.L523:
	adrp	x20, .LC60
	add	x20, x20, :lo12:.LC60
	bl	get_use_binary
	cbz	w0, .L211
.L524:
	adrp	x7, .LC60
	add	x7, x7, :lo12:.LC60
.L21:
	mov	x6, x20
	mov	x5, x19
	mov	x4, x22
	mov	x3, x21
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC68
	add	x0, x0, :lo12:.LC68
	bl	printf
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	puts
	adrp	x0, .LC70
	add	x0, x0, :lo12:.LC70
	bl	puts
.L22:
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
.L225:
	adrp	x0, .LC67
	add	x1, x0, :lo12:.LC67
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L17
	cmp	w20, 45
	bne	.L226
	ldrb	w0, [x19, 1]
	cmp	w0, 104
	beq	.L504
.L226:
	adrp	x0, .LC71
	add	x1, x0, :lo12:.LC71
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L24
	adrp	x0, .LC73
	stp	x25, x26, [sp, 64]
	add	x25, x0, :lo12:.LC73
	adrp	x0, .LC74
	stp	x27, x28, [sp, 80]
	add	x27, x0, :lo12:.LC74
	adrp	x0, .LC75
	add	x28, x0, :lo12:.LC75
	mov	w20, 1
	mov	w22, 0
.L25:
	sbfiz	x23, x20, 3, 32
	mov	x1, x25
	add	x26, x21, x23
	ldr	x19, [x21, x23]
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L505
	mov	x1, x27
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L506
	mov	x1, x28
	mov	x0, x19
	mov	x2, 16
	bl	strncmp
	cbz	w0, .L507
	ldrb	w0, [x19]
	str	w0, [sp, 104]
	cmp	w0, 45
	bne	.L227
	ldrb	w0, [x19, 1]
	cmp	w0, 105
	beq	.L508
.L227:
	adrp	x1, .LC77
	mov	x0, x19
	add	x1, x1, :lo12:.LC77
	bl	strcmp
	cbz	w0, .L37
	adrp	x1, .LC78
	mov	x0, x19
	add	x1, x1, :lo12:.LC78
	bl	strcmp
	cbnz	w0, .L39
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L509
	ldr	x0, [x26, 8]
	add	x1, sp, 120
	mov	w2, 10
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x1, [sp, 120]
	cbz	x1, .L42
	ldrb	w1, [x1]
	cbnz	w1, .L42
	mov	x1, 20864
	movk	x1, 0x1, lsl 16
	cmp	x0, x1
	bls	.L43
.L42:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 51
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC80
	add	x0, x0, :lo12:.LC80
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
.L510:
	mov	w0, w22
	ldp	x29, x30, [sp]
	ldp	x21, x22, [sp, 32]
	ldp	x23, x24, [sp, 48]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L507:
	add	x1, sp, 120
	add	x0, x19, 16
	bl	guide_policy_parse
	cbnz	w0, .L35
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 77
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC76
	add	x0, x0, :lo12:.LC76
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
	.p2align 2,,3
.L504:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L226
.L24:
	bl	print_usage
	bl	get_target_arch
	adrp	x1, .LC65
	add	x1, x1, :lo12:.LC65
	bl	strcmp
	cbz	w0, .L511
.L26:
	bl	get_target_arch
	mov	x20, x0
	bl	get_opt_level
	mov	x21, x0
	bl	get_use_pipe
	cbz	w0, .L213
	adrp	x19, .LC58
	add	x19, x19, :lo12:.LC58
.L28:
	bl	get_raw_flags
	ldrb	w0, [x0]
	adrp	x4, .LC62
	add	x4, x4, :lo12:.LC62
	cbnz	w0, .L512
.L29:
	mov	x3, x19
	mov	x2, x21
	mov	x1, x20
	adrp	x0, .LC72
	add	x0, x0, :lo12:.LC72
	bl	printf
	b	.L22
	.p2align 2,,3
.L508:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L227
.L37:
	mov	w0, 1
	bl	set_interactive
.L31:
	add	w20, w20, 1
	cmp	w22, 255
	ccmp	w24, w20, 4, ne
	bgt	.L25
	add	x20, sp, 128
	str	xzr, [x20, w22, sxtw 3]
	bl	guide_maybe_show
	cmp	w22, 1
	beq	.L513
	cbz	w22, .L514
	ldr	x19, [sp, 128]
	ldrb	w0, [x19]
	cmp	w0, 45
	beq	.L515
.L140:
	adrp	x1, .LC160
	mov	x0, x19
	add	x1, x1, :lo12:.LC160
	bl	strcmp
	cbz	w0, .L516
	adrp	x1, .LC161
	mov	x0, x19
	add	x1, x1, :lo12:.LC161
	bl	strcmp
	cbz	w0, .L517
	adrp	x1, .LC162
	mov	x0, x19
	add	x1, x1, :lo12:.LC162
	bl	strcmp
	cbz	w0, .L518
	adrp	x1, .LC163
	mov	x0, x19
	add	x1, x1, :lo12:.LC163
	bl	strcmp
	cbz	w0, .L519
	adrp	x1, .LC164
	mov	x0, x19
	add	x1, x1, :lo12:.LC164
	bl	strcmp
	cbz	w0, .L520
	mov	x0, x19
	adrp	x1, .LC165
	add	x1, x1, :lo12:.LC165
	bl	strcmp
	cmp	w22, 2
	cset	w23, eq
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L521
	mov	x0, x19
	adrp	x1, .LC166
	add	x1, x1, :lo12:.LC166
	bl	strcmp
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L522
	adrp	x1, .LC167
	mov	x0, x19
	add	x1, x1, :lo12:.LC167
	bl	strcmp
	cbnz	w0, .L153
	cmp	w22, 2
	beq	.L154
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 46
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC168
	add	x0, x0, :lo12:.LC168
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
	.p2align 2,,3
.L503:
	adrp	x19, .LC58
	add	x19, x19, :lo12:.LC58
	bl	get_gentoo_chroot
	cbnz	w0, .L523
.L210:
	adrp	x20, .LC61
	add	x20, x20, :lo12:.LC61
	bl	get_use_binary
	cbnz	w0, .L524
.L211:
	adrp	x7, .LC61
	add	x7, x7, :lo12:.LC61
	b	.L21
	.p2align 2,,3
.L39:
	ldr	w0, [sp, 104]
	cmp	w0, 45
	bne	.L228
	ldrb	w0, [x19, 1]
	cmp	w0, 114
	beq	.L525
.L228:
	adrp	x1, .LC81
	mov	x0, x19
	add	x1, x1, :lo12:.LC81
	bl	strcmp
	cbz	w0, .L45
	adrp	x1, .LC82
	mov	x0, x19
	add	x1, x1, :lo12:.LC82
	bl	strcmp
	cbz	w0, .L526
	adrp	x1, .LC83
	mov	x0, x19
	add	x1, x1, :lo12:.LC83
	bl	strcmp
	cbz	w0, .L527
	adrp	x1, .LC84
	mov	x0, x19
	add	x1, x1, :lo12:.LC84
	bl	strcmp
	cbz	w0, .L528
	adrp	x1, .LC85
	mov	x0, x19
	add	x1, x1, :lo12:.LC85
	bl	strcmp
	cbz	w0, .L529
	adrp	x1, .LC86
	mov	x0, x19
	add	x1, x1, :lo12:.LC86
	bl	strcmp
	cbz	w0, .L530
	adrp	x1, .LC87
	mov	x0, x19
	add	x1, x1, :lo12:.LC87
	bl	strcmp
	cbz	w0, .L531
	ldr	w0, [sp, 104]
	cmp	w0, 45
	bne	.L229
	ldrb	w0, [x19, 1]
	cmp	w0, 106
	bne	.L229
	ldrb	w0, [x19, 2]
	cbnz	w0, .L229
.L54:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L532
	add	x23, x23, 8
	mov	w2, 10
	add	x1, sp, 120
	str	xzr, [sp, 120]
	ldr	x0, [x21, x23]
	bl	strtol
	ldr	x2, [sp, 120]
	cbz	x2, .L62
.L494:
	ldrb	w2, [x2]
	cbnz	w2, .L62
	sub	x1, x0, #1
	cmp	x1, 1023
	bls	.L66
.L62:
	ldr	x2, [x21, x23]
	adrp	x1, .LC90
	add	x1, x1, :lo12:.LC90
.L483:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
	.p2align 2,,3
.L35:
	ldr	w0, [sp, 120]
	bl	guide_set_policy
	b	.L31
	.p2align 2,,3
.L511:
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L26
	ldrb	w22, [x0, 1]
	cbnz	w22, .L26
	bl	get_raw_flags
	ldrb	w0, [x0]
	cbnz	w0, .L26
	ldp	x19, x20, [sp, 16]
	b	.L4
	.p2align 2,,3
.L505:
	mov	w0, 1
	bl	set_noconfirm
	b	.L31
	.p2align 2,,3
.L506:
	bl	guide_request_explicit
	b	.L31
	.p2align 2,,3
.L502:
	bl	get_target_arch
	adrp	x1, .LC65
	add	x1, x1, :lo12:.LC65
	bl	strcmp
	cbnz	w0, .L8
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	beq	.L533
.L8:
	stp	x19, x20, [sp, 16]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cbz	w0, .L205
	adrp	x19, .LC58
	add	x19, x19, :lo12:.LC58
.L11:
	bl	get_gentoo_chroot
	cbz	w0, .L206
	adrp	x20, .LC60
	add	x20, x20, :lo12:.LC60
.L12:
	bl	get_use_binary
	cbz	w0, .L207
	adrp	x21, .LC60
	add	x21, x21, :lo12:.LC60
.L13:
	bl	get_gentoo_chroot_path
	mov	x24, x0
	bl	get_raw_flags
	ldrb	w0, [x0]
	adrp	x7, .LC62
	add	x7, x7, :lo12:.LC62
	cbnz	w0, .L534
.L14:
	mov	x4, x20
	mov	x3, x19
	mov	x6, x24
	mov	x5, x21
	mov	x2, x23
	mov	x1, x22
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	printf
	ldp	x19, x20, [sp, 16]
	bl	print_usage
.L535:
	mov	w22, 1
	b	.L510
	.p2align 2,,3
.L213:
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	b	.L28
	.p2align 2,,3
.L207:
	adrp	x21, .LC61
	add	x21, x21, :lo12:.LC61
	b	.L13
	.p2align 2,,3
.L206:
	adrp	x20, .LC61
	add	x20, x20, :lo12:.LC61
	b	.L12
	.p2align 2,,3
.L205:
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	b	.L11
	.p2align 2,,3
.L512:
	bl	get_raw_flags
	mov	x4, x0
	b	.L29
	.p2align 2,,3
.L525:
	ldrb	w0, [x19, 2]
	cbnz	w0, .L228
.L45:
	mov	w0, 1
	bl	set_resume
	b	.L31
	.p2align 2,,3
.L501:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 208
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC64
	add	x0, x0, :lo12:.LC64
	bl	fwrite
	b	.L510
	.p2align 2,,3
.L533:
	ldrb	w0, [x0, 1]
	cbnz	w0, .L8
	bl	get_use_pipe
	cbz	w0, .L8
	bl	get_gentoo_chroot
	cbnz	w0, .L8
	bl	get_raw_flags
	ldrb	w0, [x0]
	cbnz	w0, .L8
	bl	print_usage
	b	.L535
.L527:
	bl	set_inhibit
	b	.L31
	.p2align 2,,3
.L534:
	bl	get_raw_flags
	mov	x7, x0
	b	.L14
	.p2align 2,,3
.L43:
	bl	set_prompt_timeout
	b	.L31
	.p2align 2,,3
.L526:
	bl	set_import_keys
	b	.L31
	.p2align 2,,3
.L229:
	adrp	x1, .LC88
	mov	x0, x19
	add	x1, x1, :lo12:.LC88
	bl	strcmp
	cbz	w0, .L54
	ldrb	w0, [x19]
	cmp	w0, 45
	bne	.L61
	ldrb	w0, [x19, 1]
	cmp	w0, 106
	bne	.L61
	bl	__ctype_b_loc
	ldr	x0, [x0]
	ldrb	w1, [x19, 2]
	ldrh	w0, [x0, x1, lsl 1]
	tbnz	x0, 11, .L536
.L61:
	adrp	x1, .LC91
	mov	x0, x19
	add	x1, x1, :lo12:.LC91
	mov	x2, 7
	bl	strncmp
	cbz	w0, .L537
	adrp	x1, .LC93
	mov	x0, x19
	add	x1, x1, :lo12:.LC93
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC94
	mov	x0, x19
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC95
	mov	x0, x19
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC100
	mov	x0, x19
	add	x1, x1, :lo12:.LC100
	mov	x2, 9
	bl	strncmp
	cbnz	w0, .L73
	ldrb	w0, [x19, 9]
	cbz	w0, .L538
	add	x19, x19, 9
.L499:
	adrp	x1, .LC97
	mov	x0, x19
	add	x1, x1, :lo12:.LC97
	bl	strcmp
	cbz	w0, .L70
	adrp	x1, .LC98
	mov	x0, x19
	add	x1, x1, :lo12:.LC98
	bl	strcmp
	cbz	w0, .L70
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC99
	mov	x2, x19
	add	x1, x1, :lo12:.LC99
	b	.L483
.L528:
	bl	set_sync
	b	.L31
.L513:
	ldr	x19, [sp, 128]
	ldrb	w23, [x19]
	cmp	w23, 45
	bne	.L230
	ldrb	w0, [x19, 1]
	cmp	w0, 118
	bne	.L230
	ldrb	w0, [x19, 2]
	cbnz	w0, .L230
.L121:
	bl	get_target_arch
	mov	x21, x0
	bl	get_opt_level
	mov	x22, x0
	bl	get_use_pipe
	cbz	w0, .L215
	adrp	x19, .LC58
	add	x19, x19, :lo12:.LC58
.L123:
	bl	get_gentoo_chroot
	cbz	w0, .L216
	adrp	x20, .LC60
	add	x20, x20, :lo12:.LC60
.L124:
	bl	get_use_binary
	cbz	w0, .L217
	adrp	x7, .LC60
	add	x7, x7, :lo12:.LC60
.L125:
	mov	x6, x20
	mov	x5, x19
	mov	x4, x22
	mov	x3, x21
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC68
	add	x0, x0, :lo12:.LC68
	bl	printf
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	puts
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L529:
	bl	set_aur_sync
	b	.L31
.L230:
	adrp	x0, .LC67
	add	x1, x0, :lo12:.LC67
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L121
	cmp	w23, 45
	bne	.L231
	ldrb	w0, [x19, 1]
	cmp	w0, 104
	bne	.L231
	ldrb	w0, [x19, 2]
	cbnz	w0, .L231
.L127:
	bl	print_usage
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L515:
	ldrb	w1, [x19, 1]
	cmp	w1, 83
	beq	.L539
.L136:
	cmp	w0, 45
	bne	.L140
	ldrb	w1, [x19, 1]
	cmp	w1, 81
	bne	.L233
	ldrb	w1, [x19, 2]
	cbnz	w1, .L233
.L139:
	add	x21, sp, 136
	mov	w20, 1
	mov	w23, 0
	b	.L145
	.p2align 2,,3
.L142:
	bl	cmd_available_info_v2
.L143:
	cmp	w0, 0
	add	w20, w20, 1
	cinc	w23, w23, eq
	add	x21, x21, 8
	cmp	w22, w20
	ble	.L540
.L145:
	ldrb	w1, [x19, 1]
	ldr	x0, [x21]
	cmp	w1, 81
	bne	.L142
	bl	cmd_query_v2
	b	.L143
.L530:
	mov	w0, 1
	bl	set_use_pipe
	b	.L31
.L66:
	bl	set_jobs
	b	.L31
.L531:
	bl	set_use_pipe
	b	.L31
.L540:
	cmp	w23, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L514:
	bl	get_target_arch
	adrp	x1, .LC65
	add	x1, x1, :lo12:.LC65
	bl	strcmp
	cbnz	w0, .L130
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L130
	ldrb	w0, [x0, 1]
	cbnz	w0, .L130
	bl	get_use_pipe
	cbnz	w0, .L541
.L130:
	bl	get_target_arch
	mov	x23, x0
	bl	get_opt_level
	mov	x24, x0
	bl	get_use_pipe
	cbz	w0, .L219
	adrp	x19, .LC58
	add	x19, x19, :lo12:.LC58
.L132:
	bl	get_gentoo_chroot
	cbz	w0, .L220
	adrp	x20, .LC60
	add	x20, x20, :lo12:.LC60
.L133:
	bl	get_use_binary
	cbz	w0, .L221
	adrp	x21, .LC60
	add	x21, x21, :lo12:.LC60
.L134:
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
	adrp	x0, .LC156
	add	x0, x0, :lo12:.LC156
	bl	printf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L231:
	adrp	x0, .LC71
	add	x1, x0, :lo12:.LC71
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L127
	cmp	w23, 45
	bne	.L232
	ldrb	w0, [x19, 1]
	cmp	w0, 83
	bne	.L232
	ldrb	w0, [x19, 2]
	cbnz	w0, .L232
.L200:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC157
	add	x0, x0, :lo12:.LC157
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L539:
	ldrb	w1, [x19, 2]
	cbnz	w1, .L136
	cmp	w22, 2
	bne	.L200
	ldr	x0, [sp, 136]
	bl	cmd_search_v2
.L490:
	cmp	w0, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, eq
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L509:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 47
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC79
	add	x0, x0, :lo12:.LC79
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L67:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L542
	ldr	x19, [x26, 8]
	b	.L499
.L217:
	adrp	x7, .LC61
	add	x7, x7, :lo12:.LC61
	b	.L125
.L215:
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	b	.L123
.L216:
	adrp	x20, .LC61
	add	x20, x20, :lo12:.LC61
	b	.L124
.L221:
	adrp	x21, .LC61
	add	x21, x21, :lo12:.LC61
	b	.L134
.L220:
	adrp	x20, .LC61
	add	x20, x20, :lo12:.LC61
	b	.L133
.L219:
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	b	.L132
.L233:
	cmp	w0, 45
	bne	.L140
	ldrb	w0, [x19, 1]
	cmp	w0, 65
	bne	.L140
	ldrb	w0, [x19, 2]
	cbz	w0, .L139
	b	.L140
	.p2align 2,,3
.L537:
	mov	w2, 10
	add	x1, sp, 120
	add	x0, x19, 7
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x2, [sp, 120]
	cbz	x2, .L65
	ldrb	w2, [x2]
	cbnz	w2, .L65
	sub	x1, x0, #1
	cmp	x1, 1023
	bls	.L66
.L65:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 34
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC92
	add	x0, x0, :lo12:.LC92
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L81:
	mov	x0, x19
	bl	set_target_arch
	b	.L31
.L232:
	adrp	x1, .LC190
	mov	x0, x19
	add	x1, x1, :lo12:.LC190
	bl	strcmp
	cbz	w0, .L201
	adrp	x1, .LC158
	mov	x0, x19
	add	x1, x1, :lo12:.LC158
	bl	strcmp
	cbnz	w0, .L140
.L201:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 50
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC159
	add	x0, x0, :lo12:.LC159
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L536:
	mov	w2, 10
	add	x1, sp, 120
	add	x0, x19, 2
	str	xzr, [sp, 120]
	bl	strtol
	ldr	x2, [sp, 120]
	cbnz	x2, .L494
	b	.L62
.L532:
	adrp	x1, .LC89
	mov	x2, x19
	add	x1, x1, :lo12:.LC89
	b	.L483
.L516:
	bl	cmd_orphans_v2
	b	.L490
.L541:
	bl	get_gentoo_chroot
	cbnz	w0, .L130
.L480:
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L519:
	bl	cmd_completion_v2
	b	.L490
.L518:
	bl	cmd_news_v2
	b	.L490
.L517:
	bl	cmd_stats_v2
	b	.L490
.L520:
	bl	cmd_devel_v2
	b	.L490
.L70:
	bl	print_known_targets
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L73:
	adrp	x1, .LC102
	mov	x0, x19
	add	x1, x1, :lo12:.LC102
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L76
	ldrb	w0, [x19, 8]
	cbz	w0, .L543
	add	x19, x19, 8
	adrp	x1, .LC97
	mov	x0, x19
	add	x1, x1, :lo12:.LC97
	bl	strcmp
	cbz	w0, .L70
	adrp	x1, .LC98
	mov	x0, x19
	add	x1, x1, :lo12:.LC98
	bl	strcmp
	cbz	w0, .L70
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC104
	mov	x2, x19
	add	x1, x1, :lo12:.LC104
	b	.L483
.L154:
	ldr	x0, [sp, 136]
	bl	cmd_review_v2
	b	.L490
.L153:
	mov	x1, x21
	mov	w0, w24
	bl	acquire_sudo
	cbz	w0, .L481
	mov	x0, x19
	adrp	x1, .LC169
	add	x1, x1, :lo12:.LC169
	bl	strcmp
	mov	w21, w0
	cbnz	w0, .L155
	cmp	w22, 1
	beq	.L480
	bl	init_system
	cbnz	w0, .L544
.L481:
	ldp	x19, x20, [sp, 16]
	mov	w22, 1
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L76:
	adrp	x1, .LC105
	mov	x0, x19
	add	x1, x1, :lo12:.LC105
	mov	x2, 6
	bl	strncmp
	cbnz	w0, .L79
	ldrb	w0, [x19, 6]
	cbz	w0, .L545
	add	x19, x19, 6
	mov	x0, x19
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC107
	mov	x2, x19
	add	x1, x1, :lo12:.LC107
	b	.L483
.L543:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 39
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC103
	add	x0, x0, :lo12:.LC103
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L545:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 37
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC106
	add	x0, x0, :lo12:.LC106
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L79:
	adrp	x1, .LC108
	mov	x0, x19
	add	x1, x1, :lo12:.LC108
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC109
	mov	x0, x19
	add	x1, x1, :lo12:.LC109
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC110
	mov	x0, x19
	add	x1, x1, :lo12:.LC110
	bl	strcmp
	cbz	w0, .L82
	adrp	x0, .LC111
	add	x1, x0, :lo12:.LC111
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC114
	mov	x0, x19
	add	x1, x1, :lo12:.LC114
	mov	x2, 12
	bl	strncmp
	cbnz	w0, .L88
	ldrb	w0, [x19, 12]
	cbz	w0, .L546
	add	x19, x19, 12
	adrp	x1, .LC97
	mov	x0, x19
	add	x1, x1, :lo12:.LC97
	bl	strcmp
	cbz	w0, .L85
	adrp	x1, .LC98
	mov	x0, x19
	add	x1, x1, :lo12:.LC98
	bl	strcmp
	cbz	w0, .L85
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L464
	adrp	x1, .LC116
	mov	x2, x19
	add	x1, x1, :lo12:.LC116
	b	.L483
.L522:
	ldr	x0, [sp, 136]
	bl	cmd_dependency_plan_v2
	b	.L490
.L521:
	ldr	x0, [sp, 136]
	bl	cmd_provider_v2
	b	.L490
.L464:
	mov	x0, x19
	bl	set_opt_level
	b	.L31
.L85:
	bl	print_known_opt_levels
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L546:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 43
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC115
	add	x0, x0, :lo12:.LC115
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L88:
	adrp	x1, .LC117
	mov	x0, x19
	add	x1, x1, :lo12:.LC117
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L547
	adrp	x1, .LC119
	mov	x0, x19
	add	x1, x1, :lo12:.LC119
	mov	x2, 15
	bl	strncmp
	cbz	w0, .L548
	adrp	x1, .LC121
	mov	x0, x19
	add	x1, x1, :lo12:.LC121
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC122
	mov	x0, x19
	add	x1, x1, :lo12:.LC122
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC123
	mov	x0, x19
	add	x1, x1, :lo12:.LC123
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC124
	mov	x0, x19
	add	x1, x1, :lo12:.LC124
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC125
	mov	x0, x19
	add	x1, x1, :lo12:.LC125
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC126
	mov	x0, x19
	add	x1, x1, :lo12:.LC126
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC127
	mov	x0, x19
	add	x1, x1, :lo12:.LC127
	bl	strcmp
	cbz	w0, .L464
	adrp	x1, .LC128
	mov	x0, x19
	add	x1, x1, :lo12:.LC128
	bl	strcmp
	cbz	w0, .L549
	adrp	x0, .LC111
	mov	x2, 2
	add	x1, x0, :lo12:.LC111
	mov	x0, x19
	bl	strncmp
	cbnz	w0, .L98
	mov	x0, x19
	bl	strlen
	cmp	x0, 7
	bhi	.L98
	ldrb	w0, [x19, 2]
	cmp	w0, 61
	cinc	x19, x19, eq
	add	x19, x19, 2
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L464
	ldr	x19, [x21, x23]
.L98:
	adrp	x1, .LC130
	mov	x0, x19
	add	x1, x1, :lo12:.LC130
	bl	strcmp
	cbnz	w0, .L101
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L550
	ldr	x19, [x26, 8]
	mov	x0, x19
	bl	valid_raw_flags
	cbz	w0, .L485
.L105:
	mov	x0, x19
	bl	set_raw_flags
	b	.L31
.L549:
	adrp	x0, .LC129
	add	x0, x0, :lo12:.LC129
	bl	set_opt_level
	b	.L31
.L547:
	add	x19, x19, 6
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L464
	adrp	x1, .LC118
	mov	x2, x19
	add	x1, x1, :lo12:.LC118
	b	.L483
.L82:
	add	w20, w20, 1
	cmp	w20, w24
	bge	.L551
	ldr	x19, [x26, 8]
	adrp	x1, .LC97
	add	x1, x1, :lo12:.LC97
	mov	x0, x19
	bl	strcmp
	cbz	w0, .L85
	adrp	x1, .LC98
	mov	x0, x19
	add	x1, x1, :lo12:.LC98
	bl	strcmp
	cbz	w0, .L85
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L464
	adrp	x1, .LC113
	mov	x2, x19
	add	x1, x1, :lo12:.LC113
	b	.L483
.L542:
	adrp	x1, .LC96
	mov	x2, x19
	add	x1, x1, :lo12:.LC96
	b	.L483
.L548:
	add	x19, x19, 15
	mov	x0, x19
	bl	valid_opt_level
	cbnz	w0, .L464
	adrp	x1, .LC120
	mov	x2, x19
	add	x1, x1, :lo12:.LC120
	b	.L483
.L552:
	add	x19, x19, 6
	mov	x0, x19
	bl	valid_raw_flags
	cbnz	w0, .L105
.L485:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 112
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC132
	add	x0, x0, :lo12:.LC132
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L550:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 43
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC131
	add	x0, x0, :lo12:.LC131
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L101:
	adrp	x1, .LC133
	mov	x0, x19
	add	x1, x1, :lo12:.LC133
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L552
	adrp	x1, .LC134
	mov	x0, x19
	add	x1, x1, :lo12:.LC134
	bl	strcmp
	cbz	w0, .L106
	adrp	x1, .LC135
	mov	x0, x19
	add	x1, x1, :lo12:.LC135
	bl	strcmp
	cbz	w0, .L106
	adrp	x1, .LC136
	mov	x0, x19
	add	x1, x1, :lo12:.LC136
	bl	strcmp
	cbz	w0, .L106
	adrp	x1, .LC137
	mov	x0, x19
	add	x1, x1, :lo12:.LC137
	bl	strcmp
	cbz	w0, .L106
	adrp	x1, .LC138
	mov	x0, x19
	add	x1, x1, :lo12:.LC138
	bl	strcmp
	cbz	w0, .L108
	adrp	x1, .LC139
	mov	x0, x19
	add	x1, x1, :lo12:.LC139
	bl	strcmp
	cbz	w0, .L108
	adrp	x1, .LC140
	mov	x0, x19
	add	x1, x1, :lo12:.LC140
	mov	x2, 14
	bl	strncmp
	cbz	w0, .L553
	adrp	x1, .LC142
	mov	x0, x19
	add	x1, x1, :lo12:.LC142
	bl	strcmp
	cbnz	w0, .L112
	add	w20, w20, 1
	cmp	w24, w20
	ble	.L554
	ldr	x19, [x26, 8]
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L114
.L486:
	adrp	x1, .LC141
	mov	x2, x19
	add	x1, x1, :lo12:.LC141
	b	.L483
.L544:
	bl	get_use_binary
	cbz	w0, .L156
	mov	x19, 1
.L158:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L158
.L491:
	cmp	w21, 0
	ldp	x19, x20, [sp, 16]
	cset	w22, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L538:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 40
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC101
	add	x0, x0, :lo12:.LC101
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L551:
	adrp	x1, .LC112
	mov	x2, x19
	add	x1, x1, :lo12:.LC112
	b	.L483
.L156:
	bl	get_gentoo_chroot
	mov	w21, w0
	cbz	w0, .L222
	mov	w21, 0
	mov	x19, 1
.L162:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_gentoo_imitation_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L162
	b	.L491
.L155:
	mov	x0, x19
	adrp	x1, .LC170
	add	x1, x1, :lo12:.LC170
	bl	strcmp
	mov	w21, w0
	cbnz	w0, .L164
	cmp	w22, 1
	beq	.L480
	mov	x19, 1
.L166:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_get_pkgbuild_v2
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L166
	b	.L491
.L553:
	add	x19, x19, 14
	mov	x0, x19
	bl	valid_gentoo_chroot_path
	cbz	w0, .L486
.L114:
	mov	x0, x19
	bl	set_gentoo_chroot_path
	b	.L31
.L222:
	mov	x19, 1
.L160:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L160
	b	.L491
.L554:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 42
	mov	x1, 1
	mov	w22, 1
	ldr	x3, [x0]
	adrp	x0, .LC143
	add	x0, x0, :lo12:.LC143
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L112:
	adrp	x1, .LC144
	mov	x0, x19
	add	x1, x1, :lo12:.LC144
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC145
	mov	x0, x19
	add	x1, x1, :lo12:.LC145
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC146
	mov	x0, x19
	add	x1, x1, :lo12:.LC146
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC147
	mov	x0, x19
	add	x1, x1, :lo12:.LC147
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC148
	mov	x0, x19
	add	x1, x1, :lo12:.LC148
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC149
	mov	x0, x19
	add	x1, x1, :lo12:.LC149
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC150
	mov	x0, x19
	add	x1, x1, :lo12:.LC150
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC151
	mov	x0, x19
	add	x1, x1, :lo12:.LC151
	bl	strcmp
	cbz	w0, .L115
	adrp	x1, .LC152
	mov	x0, x19
	add	x1, x1, :lo12:.LC152
	bl	strcmp
	cbz	w0, .L117
	adrp	x1, .LC153
	mov	x0, x19
	add	x1, x1, :lo12:.LC153
	bl	strcmp
	cbz	w0, .L117
	adrp	x1, .LC154
	mov	x0, x19
	add	x1, x1, :lo12:.LC154
	bl	strcmp
	cbz	w0, .L117
	adrp	x1, .LC155
	mov	x0, x19
	add	x1, x1, :lo12:.LC155
	bl	strcmp
	cbz	w0, .L117
	add	x0, sp, 128
	str	x19, [x0, w22, sxtw 3]
	add	w22, w22, 1
	b	.L31
.L106:
	mov	w0, 1
	bl	set_gentoo_chroot
	mov	w0, 1
	bl	set_portage_imitation
	b	.L31
.L108:
	bl	set_gentoo_chroot
	mov	w0, 0
	bl	set_portage_imitation
	b	.L31
.L164:
	adrp	x1, .LC171
	mov	x0, x19
	add	x1, x1, :lo12:.LC171
	bl	strcmp
	cbz	w0, .L555
	adrp	x1, .LC172
	mov	x0, x19
	add	x1, x1, :lo12:.LC172
	bl	strcmp
	cbz	w0, .L556
	adrp	x1, .LC173
	mov	x0, x19
	add	x1, x1, :lo12:.LC173
	bl	strcmp
	cbz	w0, .L169
	adrp	x1, .LC174
	mov	x0, x19
	add	x1, x1, :lo12:.LC174
	bl	strcmp
	cbz	w0, .L169
	adrp	x1, .LC175
	mov	x0, x19
	add	x1, x1, :lo12:.LC175
	bl	strcmp
	cbz	w0, .L171
	adrp	x1, .LC176
	mov	x0, x19
	add	x1, x1, :lo12:.LC176
	bl	strcmp
	cbz	w0, .L171
	adrp	x1, .LC178
	mov	x0, x19
	add	x1, x1, :lo12:.LC178
	bl	strcmp
	cbz	w0, .L176
	adrp	x1, .LC179
	mov	x0, x19
	add	x1, x1, :lo12:.LC179
	bl	strcmp
	cbz	w0, .L176
	ldrb	w0, [x19]
	mov	x21, 0
	cmp	w0, 45
	beq	.L557
.L181:
	ldr	x23, [x20, x21, lsl 3]
	mov	x0, x23
	bl	valid_pkgname
	cbz	w0, .L558
	add	x21, x21, 1
	cmp	w22, w21
	bgt	.L181
	bl	init_system
	cbz	w0, .L481
	bl	get_use_binary
	mov	w23, w0
	cbz	w0, .L183
	adrp	x23, .LC183
	mov	x21, 0
	add	x23, x23, :lo12:.LC183
	mov	w19, 0
	b	.L186
.L559:
	mov	x3, x24
	mov	w2, w22
	add	w1, w21, 1
	mov	x0, x23
	bl	printf
	mov	x0, x24
	bl	cmd_build
	cbz	w0, .L193
.L185:
	add	x21, x21, 1
	cmp	w22, w21
	ble	.L487
.L186:
	ldr	x24, [x20, x21, lsl 3]
	cmp	w22, 1
	bne	.L559
	mov	x0, x24
	bl	cmd_build
	cbnz	w0, .L487
.L193:
	add	w19, w19, 1
	b	.L185
.L117:
	mov	w0, 0
	bl	set_use_binary
	b	.L31
.L115:
	mov	w0, 1
	bl	set_use_binary
	b	.L31
.L558:
	adrp	x1, .LC182
	mov	x2, x23
	add	x1, x1, :lo12:.LC182
	b	.L483
.L487:
	mov	w22, w19
	cbz	w19, .L480
	adrp	x1, .LC184
	mov	w2, w19
	add	x1, x1, :lo12:.LC184
.L484:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L183:
	bl	get_gentoo_chroot
	mov	w21, w0
	cbz	w0, .L224
	adrp	x21, .LC185
	mov	x19, 0
	add	x21, x21, :lo12:.LC185
	b	.L190
.L560:
	mov	x3, x24
	mov	w2, w22
	add	w1, w19, 1
	mov	x0, x21
	bl	printf
	mov	x0, x24
	bl	cmd_gentoo_imitation_build
	cbz	w0, .L195
.L189:
	add	x19, x19, 1
	cmp	w22, w19
	ble	.L488
.L190:
	ldr	x24, [x20, x19, lsl 3]
	cmp	w22, 1
	bne	.L560
	mov	x0, x24
	bl	cmd_gentoo_imitation_build
	cbnz	w0, .L488
.L195:
	add	w23, w23, 1
	b	.L189
.L557:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x19
	adrp	x1, .LC181
	add	x1, x1, :lo12:.LC181
	mov	w22, 1
	ldr	x0, [x0]
	bl	fprintf
	bl	print_usage
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
.L176:
	cmp	w22, 1
	beq	.L561
	bl	init_system
	cbz	w0, .L481
	mov	x19, 1
	mov	w21, 0
.L180:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_unmerge
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L180
	b	.L491
.L488:
	mov	w22, w23
	cbz	w23, .L480
	adrp	x1, .LC186
	mov	w2, w23
	add	x1, x1, :lo12:.LC186
	b	.L484
.L171:
	cmp	w22, 1
	beq	.L562
	bl	init_system
	cbz	w0, .L481
	mov	x19, 1
	mov	w21, 0
.L175:
	ldr	x0, [x20, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_deselect
	cmp	w0, 0
	cinc	w21, w21, eq
	cmp	w22, w19
	bgt	.L175
	b	.L491
.L169:
	bl	init_system
	cbz	w0, .L481
	bl	cmd_world_update
	b	.L490
.L562:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 53
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC177
	add	x0, x0, :lo12:.LC177
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L556:
	bl	cmd_clean_v2
	b	.L490
.L555:
	cmp	w22, 2
	bne	.L481
	ldr	x0, [sp, 136]
	bl	cmd_local_build_v2
	b	.L490
.L224:
	adrp	x24, .LC187
	mov	x23, 0
	add	x24, x24, :lo12:.LC187
	b	.L187
.L563:
	mov	w2, w22
	add	w1, w23, 1
	mov	x0, x24
	str	x3, [sp, 104]
	bl	printf
	ldr	x0, [sp, 104]
	bl	cmd_build
	cbz	w0, .L197
.L192:
	add	x23, x23, 1
	cmp	w22, w23
	ble	.L489
.L187:
	ldr	x3, [x20, x23, lsl 3]
	cmp	w22, 1
	bne	.L563
	mov	x0, x3
	bl	cmd_build
	cbnz	w0, .L489
.L197:
	add	w21, w21, 1
	b	.L192
.L561:
	adrp	x0, :got:stderr
	ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, 57
	mov	x1, 1
	ldr	x3, [x0]
	adrp	x0, .LC180
	add	x0, x0, :lo12:.LC180
	bl	fwrite
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L489:
	mov	w22, w21
	cbz	w21, .L480
	adrp	x20, :got:stderr
	ldr	x20, [x20, :got_lo12:stderr]
	mov	w2, w21
	adrp	x1, .LC188
	add	x1, x1, :lo12:.LC188
	ldr	x0, [x20]
	bl	fprintf
	bl	get_resume
	cbnz	w0, .L481
	ldr	x0, [x20]
	mov	x2, x19
	adrp	x1, .LC189
	mov	w22, 1
	add	x1, x1, :lo12:.LC189
	bl	fprintf
	ldp	x19, x20, [sp, 16]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L510
	.section	.note.GNU-stack,"",@progbits
	.aeabi_subsection aeabi_feature_and_bits, optional, ULEB128
