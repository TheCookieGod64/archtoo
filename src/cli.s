	.arch armv8-a
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"1.2.2"
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
	.string	"  makepkg_raw (config)   Raw options passed to makepkg itself,"
	.align	3
.LC41:
	.string	"                         e.g. makepkg_raw = \"--nocheck\" (plain options only)"
	.align	3
.LC42:
	.string	"  --pipe                 Enable -pipe (default)"
	.align	3
.LC43:
	.string	"  --no-pipe              Disable -pipe"
	.align	3
.LC44:
	.string	"  --gentoo-chroot        Enable SUPER HARD Portage imitation via Gentoo chroot"
	.align	3
.LC45:
	.string	"  --imitation            Alias for --gentoo-chroot"
	.align	3
.LC46:
	.string	"  --no-gentoo-chroot     Disable chroot imitation"
	.align	3
.LC47:
	.string	"  --chroot-path PATH     Custom chroot path (default: /usr/local/emerge/gentoo-chroot)"
	.align	3
.LC48:
	.string	"  --binary               Try sudo pacman -S first, then yay-style AUR search for a prebuilt -bin (long flag only)"
	.align	3
.LC49:
	.string	"                         Long flag only, no short form"
	.align	3
.LC50:
	.string	"  --use-binary           Alias for --binary"
	.align	3
.LC51:
	.string	"  --no-binary            Disable binary mode"
	.align	3
.LC52:
	.string	"  -r, --resume           Reuse the existing build tree and continue"
	.align	3
.LC53:
	.string	"                         an interrupted compile"
	.align	3
.LC54:
	.string	"  --no-keys              Do not import missing PGP signing keys"
	.align	3
.LC55:
	.string	"  --no-inhibit           Allow the machine to suspend while building"
	.align	3
.LC56:
	.string	"  --no-sync              Skip pacman -Syu during a world update"
	.align	3
.LC57:
	.string	"  --no-aur-sync          Reuse local AUR @world sources; do not refresh"
	.align	3
.LC58:
	.string	"  --command-guide        Display the command guide now"
	.align	3
.LC59:
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
	adrp	x0, .LC57
	add	x0, x0, :lo12:.LC57
	bl	puts
	adrp	x0, .LC58
	add	x0, x0, :lo12:.LC58
	bl	puts
	ldp	x29, x30, [sp], 16
	adrp	x0, .LC59
	add	x0, x0, :lo12:.LC59
	b	puts
	.section	.rodata.str1.8
	.align	3
.LC60:
	.string	"yes"
	.align	3
.LC61:
	.string	"no"
	.align	3
.LC62:
	.string	"on"
	.align	3
.LC63:
	.string	"off"
	.align	3
.LC64:
	.string	"none"
	.align	3
.LC65:
	.string	"SUDO_USER"
	.align	3
.LC66:
	.string	"\033[1;31m[-] Running as a root login is not supported.\n    makepkg refuses to build as root, and there is no SUDO_USER\n    to drop back to. Use 'sudo emerge <package>' from your\n    normal account instead.\n\033[0m"
	.align	3
.LC67:
	.string	"native"
	.align	3
.LC68:
	.string	"\033[1;36mCurrent config: target=%s opt=-O%s pipe=%s chroot=%s binary=%s path=%s raw=%s makepkg=%s\n\033[0m"
	.align	3
.LC69:
	.string	"--version"
	.align	3
.LC70:
	.string	"%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n"
	.align	3
.LC71:
	.string	"Copyright (C) 2026 TheCookieGod64"
	.align	3
.LC72:
	.string	"License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>"
	.align	3
.LC73:
	.string	"--help"
	.align	3
.LC74:
	.string	"\033[1;36m\nActive config: target=%s opt=-O%s pipe=%s raw=%s makepkg=%s\n\033[0m"
	.align	3
.LC75:
	.string	"--noconfirm"
	.align	3
.LC76:
	.string	"--command-guide"
	.align	3
.LC77:
	.string	"--command-guide="
	.align	3
.LC78:
	.string	"\033[1;31m[-] Invalid command-guide mode (use first-run, always, or never).\n\033[0m"
	.align	3
.LC79:
	.string	"--interactive"
	.align	3
.LC80:
	.string	"--prompt-timeout"
	.align	3
.LC81:
	.string	"\033[1;31m[-] --prompt-timeout needs seconds.\n\033[0m"
	.align	3
.LC82:
	.string	"\033[1;31m[-] Invalid timeout (expected 0-86400).\n\033[0m"
	.align	3
.LC83:
	.string	"--resume"
	.align	3
.LC84:
	.string	"--no-keys"
	.align	3
.LC85:
	.string	"--no-inhibit"
	.align	3
.LC86:
	.string	"--no-sync"
	.align	3
.LC87:
	.string	"--no-aur-sync"
	.align	3
.LC88:
	.string	"--pipe"
	.align	3
.LC89:
	.string	"--no-pipe"
	.align	3
.LC90:
	.string	"--jobs"
	.align	3
.LC91:
	.string	"\033[1;31m[-] %s needs a number.\n\033[0m"
	.align	3
.LC92:
	.string	"\033[1;31m[-] Invalid job count '%s' (expected 1-1024).\n\033[0m"
	.align	3
.LC93:
	.string	"--jobs="
	.align	3
.LC94:
	.string	"\033[1;31m[-] Invalid job count.\n\033[0m"
	.align	3
.LC95:
	.string	"--target"
	.align	3
.LC96:
	.string	"--march"
	.align	3
.LC97:
	.string	"--cpu"
	.align	3
.LC98:
	.string	"\033[1;31m[-] %s needs an architecture name.\n\033[0m"
	.align	3
.LC99:
	.string	"help"
	.align	3
.LC100:
	.string	"list"
	.align	3
.LC101:
	.string	"\033[1;31m[-] Invalid target '%s'. Use --target help.\n\033[0m"
	.align	3
.LC102:
	.string	"--target="
	.align	3
.LC103:
	.string	"\033[1;31m[-] --target= needs a value.\n\033[0m"
	.align	3
.LC104:
	.string	"--march="
	.align	3
.LC105:
	.string	"\033[1;31m[-] --march= needs a value.\n\033[0m"
	.align	3
.LC106:
	.string	"\033[1;31m[-] Invalid march '%s'.\n\033[0m"
	.align	3
.LC107:
	.string	"--cpu="
	.align	3
.LC108:
	.string	"\033[1;31m[-] --cpu= needs a value.\n\033[0m"
	.align	3
.LC109:
	.string	"\033[1;31m[-] Invalid cpu '%s'.\n\033[0m"
	.align	3
.LC110:
	.string	"--opt-level"
	.align	3
.LC111:
	.string	"--opt"
	.align	3
.LC112:
	.string	"--optimization"
	.align	3
.LC113:
	.string	"-O"
	.align	3
.LC114:
	.string	"\033[1;31m[-] %s needs a level (0,1,2,3,s,fast,g,z).\n\033[0m"
	.align	3
.LC115:
	.string	"\033[1;31m[-] Invalid opt level '%s'. Use --opt-level help.\n\033[0m"
	.align	3
.LC116:
	.string	"--opt-level="
	.align	3
.LC117:
	.string	"\033[1;31m[-] --opt-level= needs a value.\n\033[0m"
	.align	3
.LC118:
	.string	"\033[1;31m[-] Invalid opt level '%s'.\n\033[0m"
	.align	3
.LC119:
	.string	"--opt="
	.align	3
.LC120:
	.string	"\033[1;31m[-] Invalid opt '%s'.\n\033[0m"
	.align	3
.LC121:
	.string	"--optimization="
	.align	3
.LC122:
	.string	"\033[1;31m[-] Invalid optimization '%s'.\n\033[0m"
	.align	3
.LC123:
	.string	"-O0"
	.align	3
.LC124:
	.string	"-O1"
	.align	3
.LC125:
	.string	"-O2"
	.align	3
.LC126:
	.string	"-O3"
	.align	3
.LC127:
	.string	"-Os"
	.align	3
.LC128:
	.string	"-Oz"
	.align	3
.LC129:
	.string	"-Og"
	.align	3
.LC130:
	.string	"-Ofast"
	.align	3
.LC131:
	.string	"fast"
	.align	3
.LC132:
	.string	"--raw"
	.align	3
.LC133:
	.string	"\033[1;31m[-] --raw needs a flags string.\n\033[0m"
	.align	3
.LC134:
	.string	"\033[1;31m[-] Invalid --raw: plain options only (-march=x, -fuse-ld=y; no shell metacharacters, <= 192 chars).\n\033[0m"
	.align	3
.LC135:
	.string	"--raw="
	.align	3
.LC136:
	.string	"--gentoo-chroot"
	.align	3
.LC137:
	.string	"--imitation"
	.align	3
.LC138:
	.string	"--portage-imitation"
	.align	3
.LC139:
	.string	"--gentoo-imitation"
	.align	3
.LC140:
	.string	"--no-gentoo-chroot"
	.align	3
.LC141:
	.string	"--no-imitation"
	.align	3
.LC142:
	.string	"--chroot-path="
	.align	3
.LC143:
	.string	"\033[1;31m[-] Invalid chroot path '%s'\n\033[0m"
	.align	3
.LC144:
	.string	"--chroot-path"
	.align	3
.LC145:
	.string	"\033[1;31m[-] --chroot-path needs a path\n\033[0m"
	.align	3
.LC146:
	.string	"--binary"
	.align	3
.LC147:
	.string	"--use-binary"
	.align	3
.LC148:
	.string	"--use-bin"
	.align	3
.LC149:
	.string	"--bin"
	.align	3
.LC150:
	.string	"--prebuilt"
	.align	3
.LC151:
	.string	"--use-prebuilt"
	.align	3
.LC152:
	.string	"--no-build"
	.align	3
.LC153:
	.string	"--no-compile"
	.align	3
.LC154:
	.string	"--no-binary"
	.align	3
.LC155:
	.string	"--no-use-binary"
	.align	3
.LC156:
	.string	"--no-bin"
	.align	3
.LC157:
	.string	"--no-prebuilt"
	.align	3
.LC158:
	.string	"\033[1;36mCurrent: target=%s opt=-O%s pipe=%s chroot=%s binary=%s jobs=%ld path=%s\n\033[0m"
	.align	3
.LC159:
	.string	"\033[1;31m[-] Search requires exactly one query.\n\033[0m"
	.align	3
.LC160:
	.string	"-A"
	.align	3
.LC161:
	.string	"\033[1;31m[-] This operation requires a package.\n\033[0m"
	.align	3
.LC162:
	.string	"--orphans"
	.align	3
.LC163:
	.string	"--stats"
	.align	3
.LC164:
	.string	"--news"
	.align	3
.LC165:
	.string	"--complete"
	.align	3
.LC166:
	.string	"--devel"
	.align	3
.LC167:
	.string	"--providers"
	.align	3
.LC168:
	.string	"--deps"
	.align	3
.LC169:
	.string	"--review"
	.align	3
.LC170:
	.string	"\033[1;31m[-] --review requires a directory.\n\033[0m"
	.align	3
.LC171:
	.string	"-I"
	.align	3
.LC172:
	.string	"-G"
	.align	3
.LC173:
	.string	"-B"
	.align	3
.LC174:
	.string	"--clean"
	.align	3
.LC175:
	.string	"-U"
	.align	3
.LC176:
	.string	"--update"
	.align	3
.LC177:
	.string	"-D"
	.align	3
.LC178:
	.string	"--deselect"
	.align	3
.LC179:
	.string	"\033[1;31m[-] Error: specify a package to deselect.\n\033[0m"
	.align	3
.LC180:
	.string	"-C"
	.align	3
.LC181:
	.string	"--unmerge"
	.align	3
.LC182:
	.string	"\033[1;31m[-] Error: specify a package name to unmerge.\n\033[0m"
	.align	3
.LC183:
	.string	"\033[1;31m[-] Unknown option: %s\n\033[0m"
	.align	3
.LC184:
	.string	"\033[1;31m[-] Invalid package name: '%s'\n\033[0m"
	.align	3
.LC185:
	.string	"\033[1;35m\n>>> [%d/%d] %s (binary mode)\n\033[0m"
	.align	3
.LC186:
	.string	"\033[1;31m\n[-] %d package(s) failed in binary mode.\n\033[0m"
	.align	3
.LC187:
	.string	"\033[1;35m\n>>> [%d/%d] %s (Gentoo chroot imitation)\n\033[0m"
	.align	3
.LC188:
	.string	"\033[1;31m\n[-] %d package(s) failed in Gentoo chroot mode.\n\033[0m"
	.align	3
.LC189:
	.string	"\033[1;35m\n>>> [%d/%d] %s\n\033[0m"
	.align	3
.LC190:
	.string	"\033[1;31m\n[-] %d package(s) failed.\n\033[0m"
	.align	3
.LC191:
	.string	"\033[1;33m    Tip: 'emerge --resume %s' continues from the existing\n    build tree instead of starting over.\n\033[0m"
	.align	3
.LC192:
	.string	"-Q"
	.text
	.align	2
	.p2align 5,,15
	.global	archtoo_cli_main
	.type	archtoo_cli_main, %function
archtoo_cli_main:
	sub	sp, sp, #2192
	stp	x29, x30, [sp, 16]
	add	x29, sp, 16
	stp	x19, x20, [sp, 32]
	mov	x19, x1
	stp	x21, x22, [sp, 48]
	mov	w21, w0
	bl	geteuid
	cbnz	w0, .L5
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	getenv
	cbz	x0, .L499
.L5:
	bl	load_user_config
	cmp	w21, 1
	ble	.L500
	ldr	x20, [x19, 8]
	ldrb	w22, [x20]
	cmp	w22, 45
	bne	.L234
	ldrb	w0, [x20, 1]
	cmp	w0, 118
	bne	.L234
	ldrb	w0, [x20, 2]
	cbz	w0, .L19
	.p2align 5,,15
.L234:
	mov	x0, x20
	stp	x25, x26, [sp, 80]
	adrp	x26, .LC69
	add	x1, x26, :lo12:.LC69
	bl	strcmp
	cbz	w0, .L501
	cmp	w22, 45
	bne	.L235
	ldrb	w0, [x20, 1]
	cmp	w0, 104
	beq	.L502
.L235:
	adrp	x1, .LC73
	mov	x0, x20
	add	x1, x1, :lo12:.LC73
	bl	strcmp
	cbz	w0, .L26
	adrp	x25, .LC76
	add	x25, x25, :lo12:.LC76
	stp	x23, x24, [sp, 64]
	adrp	x24, .LC75
	add	x24, x24, :lo12:.LC75
	adrp	x0, .LC77
	mov	w22, 1
	add	x0, x0, :lo12:.LC77
	stp	x27, x28, [sp, 96]
	mov	w27, 0
	str	x0, [sp, 120]
.L27:
	sbfiz	x23, x22, 3, 32
	mov	x1, x24
	add	x0, x19, x23
	str	x0, [sp, 112]
	ldr	x20, [x19, x23]
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L503
	mov	x1, x25
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L504
	ldr	x1, [sp, 120]
	mov	x0, x20
	mov	x2, 16
	bl	strncmp
	cbz	w0, .L505
	ldrb	w28, [x20]
	cmp	w28, 45
	bne	.L236
	ldrb	w0, [x20, 1]
	cmp	w0, 105
	beq	.L506
.L236:
	adrp	x1, .LC79
	mov	x0, x20
	add	x1, x1, :lo12:.LC79
	bl	strcmp
	cbz	w0, .L41
	adrp	x1, .LC80
	mov	x0, x20
	add	x1, x1, :lo12:.LC80
	bl	strcmp
	cbnz	w0, .L43
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L507
	ldr	x0, [sp, 112]
	mov	w2, 10
	add	x1, sp, 136
	str	xzr, [sp, 136]
	ldr	x0, [x0, 8]
	bl	strtol
	ldr	x2, [sp, 136]
	cbz	x2, .L46
	ldrb	w2, [x2]
	cbnz	w2, .L46
	mov	x2, 20864
	movk	x2, 0x1, lsl 16
	cmp	x0, x2
	bls	.L47
.L46:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC82
	add	x0, x0, :lo12:.LC82
	mov	x2, 51
.L482:
	ldr	x3, [x3]
	mov	x1, 1
	bl	fwrite
	ldp	x23, x24, [sp, 64]
	mov	w0, 1
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
.L528:
	ldp	x29, x30, [sp, 16]
	ldp	x19, x20, [sp, 32]
	ldp	x21, x22, [sp, 48]
	add	sp, sp, 2192
	ret
	.p2align 2,,3
.L501:
	ldp	x25, x26, [sp, 80]
.L19:
	stp	x23, x24, [sp, 64]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	adrp	x1, .LC60
	cmp	w0, 0
	add	x1, x1, :lo12:.LC60
	adrp	x19, .LC61
	add	x19, x19, :lo12:.LC61
	adrp	x20, .LC62
	csel	x19, x19, x1, eq
	add	x20, x20, :lo12:.LC62
	bl	get_gentoo_chroot
	cmp	w0, 0
	adrp	x21, .LC63
	add	x21, x21, :lo12:.LC63
	csel	x24, x21, x20, eq
	bl	get_use_binary
	cmp	w0, 0
	mov	x6, x24
	mov	x4, x23
	mov	x5, x19
	csel	x7, x21, x20, eq
	mov	x3, x22
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC70
	add	x0, x0, :lo12:.LC70
	bl	printf
	adrp	x0, .LC71
	add	x0, x0, :lo12:.LC71
	bl	puts
	adrp	x0, .LC72
	add	x0, x0, :lo12:.LC72
	bl	puts
	ldp	x23, x24, [sp, 64]
.L24:
	mov	w0, 0
.L4:
	ldp	x29, x30, [sp, 16]
	ldp	x19, x20, [sp, 32]
	ldp	x21, x22, [sp, 48]
	add	sp, sp, 2192
	ret
	.p2align 2,,3
.L505:
	add	x0, x20, 16
	add	x1, sp, 136
	bl	guide_policy_parse
	cbnz	w0, .L39
	adrp	x0, .LC78
	mov	x2, 77
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC78
	b	.L482
	.p2align 2,,3
.L502:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L235
.L26:
	bl	print_usage
	bl	get_target_arch
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	strcmp
	cbz	w0, .L28
.L31:
	bl	get_target_arch
	mov	x20, x0
	bl	get_opt_level
	mov	x21, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x3, .LC60
	add	x3, x3, :lo12:.LC60
	adrp	x19, .LC61
	add	x19, x19, :lo12:.LC61
	csel	x19, x19, x3, eq
	adrp	x22, .LC64
	bl	get_raw_flags
	ldrb	w0, [x0]
	add	x22, x22, :lo12:.LC64
	cbnz	w0, .L508
.L32:
	bl	get_makepkg_raw
	ldrb	w0, [x0]
	adrp	x5, .LC64
	add	x5, x5, :lo12:.LC64
	cbnz	w0, .L509
.L33:
	mov	x4, x22
	mov	x3, x19
	mov	x2, x21
	mov	x1, x20
	adrp	x0, .LC74
	add	x0, x0, :lo12:.LC74
	bl	printf
	ldp	x25, x26, [sp, 80]
	b	.L24
	.p2align 2,,3
.L506:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L236
.L41:
	mov	w0, 1
	bl	set_interactive
.L37:
	add	w22, w22, 1
	cmp	w27, 255
	ccmp	w21, w22, 4, ne
	bgt	.L27
	add	x22, sp, 144
	str	xzr, [x22, w27, sxtw 3]
	bl	guide_maybe_show
	cmp	w27, 1
	beq	.L510
	cbz	w27, .L511
	ldr	x20, [sp, 144]
	ldrb	w0, [x20]
	cmp	w0, 45
	beq	.L512
.L147:
	adrp	x1, .LC162
	mov	x0, x20
	add	x1, x1, :lo12:.LC162
	bl	strcmp
	cbz	w0, .L513
	adrp	x1, .LC163
	mov	x0, x20
	add	x1, x1, :lo12:.LC163
	bl	strcmp
	cbz	w0, .L514
	adrp	x1, .LC164
	mov	x0, x20
	add	x1, x1, :lo12:.LC164
	bl	strcmp
	cbz	w0, .L515
	adrp	x1, .LC165
	mov	x0, x20
	add	x1, x1, :lo12:.LC165
	bl	strcmp
	cbz	w0, .L516
	adrp	x1, .LC166
	mov	x0, x20
	add	x1, x1, :lo12:.LC166
	bl	strcmp
	cbz	w0, .L517
	mov	x0, x20
	adrp	x1, .LC167
	add	x1, x1, :lo12:.LC167
	bl	strcmp
	cmp	w27, 2
	cset	w23, eq
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L518
	mov	x0, x20
	adrp	x1, .LC168
	add	x1, x1, :lo12:.LC168
	bl	strcmp
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L519
	adrp	x1, .LC169
	mov	x0, x20
	add	x1, x1, :lo12:.LC169
	bl	strcmp
	cbnz	w0, .L159
	cmp	w27, 2
	beq	.L160
	adrp	x0, .LC170
	mov	x2, 46
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC170
	b	.L482
	.p2align 2,,3
.L43:
	cmp	w28, 45
	bne	.L237
	ldrb	w0, [x20, 1]
	cmp	w0, 114
	beq	.L520
.L237:
	adrp	x1, .LC83
	mov	x0, x20
	add	x1, x1, :lo12:.LC83
	bl	strcmp
	cbz	w0, .L49
	adrp	x1, .LC84
	mov	x0, x20
	add	x1, x1, :lo12:.LC84
	bl	strcmp
	cbz	w0, .L521
	adrp	x1, .LC85
	mov	x0, x20
	add	x1, x1, :lo12:.LC85
	bl	strcmp
	cbz	w0, .L522
	adrp	x1, .LC86
	mov	x0, x20
	add	x1, x1, :lo12:.LC86
	bl	strcmp
	cbz	w0, .L523
	adrp	x1, .LC87
	mov	x0, x20
	add	x1, x1, :lo12:.LC87
	bl	strcmp
	cbz	w0, .L524
	adrp	x1, .LC88
	mov	x0, x20
	add	x1, x1, :lo12:.LC88
	bl	strcmp
	cbz	w0, .L525
	adrp	x1, .LC89
	mov	x0, x20
	add	x1, x1, :lo12:.LC89
	bl	strcmp
	cbz	w0, .L526
	cmp	w28, 45
	bne	.L238
	ldrb	w0, [x20, 1]
	cmp	w0, 106
	bne	.L238
	ldrb	w0, [x20, 2]
	cbnz	w0, .L238
.L58:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L527
	add	x23, x23, 8
	add	x1, sp, 136
	mov	w2, 10
	str	xzr, [sp, 136]
	ldr	x0, [x19, x23]
	bl	strtol
	mov	x1, x0
	ldr	x2, [sp, 136]
	cbz	x2, .L66
.L494:
	ldrb	w2, [x2]
	cbnz	w2, .L66
	sub	x1, x1, #1
	cmp	x1, 1023
	bls	.L70
.L66:
	ldr	x2, [x19, x23]
	adrp	x1, .LC92
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC92
.L484:
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L528
	.p2align 2,,3
.L39:
	ldr	w0, [sp, 136]
	bl	guide_set_policy
	b	.L37
	.p2align 2,,3
.L28:
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L31
	ldrb	w0, [x0, 1]
	cbnz	w0, .L31
	bl	get_raw_flags
	ldrb	w0, [x0]
	cbnz	w0, .L31
	bl	get_makepkg_raw
	ldrb	w0, [x0]
	cbnz	w0, .L31
	ldp	x25, x26, [sp, 80]
	b	.L24
	.p2align 2,,3
.L503:
	mov	w0, 1
	bl	set_noconfirm
	b	.L37
	.p2align 2,,3
.L504:
	bl	guide_request_explicit
	b	.L37
	.p2align 2,,3
.L500:
	bl	get_target_arch
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	strcmp
	cbnz	w0, .L11
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L11
	ldrb	w0, [x0, 1]
	cbnz	w0, .L11
	bl	get_use_pipe
	cbz	w0, .L11
	bl	get_gentoo_chroot
	cbnz	w0, .L11
	bl	get_raw_flags
	ldrb	w0, [x0]
	cbnz	w0, .L11
	bl	get_makepkg_raw
	ldrb	w0, [x0]
	cbz	w0, .L12
	.p2align 5,,15
.L11:
	stp	x23, x24, [sp, 64]
	adrp	x21, .LC61
	add	x21, x21, :lo12:.LC61
	stp	x25, x26, [sp, 80]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x1, .LC60
	add	x1, x1, :lo12:.LC60
	csel	x21, x21, x1, eq
	adrp	x19, .LC62
	adrp	x20, .LC63
	add	x19, x19, :lo12:.LC62
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x20, x20, :lo12:.LC63
	csel	x24, x20, x19, eq
	bl	get_use_binary
	cmp	w0, 0
	csel	x20, x20, x19, eq
	adrp	x19, .LC64
	add	x19, x19, :lo12:.LC64
	bl	get_gentoo_chroot_path
	mov	x25, x0
	bl	get_raw_flags
	ldrb	w0, [x0]
	cbnz	w0, .L529
.L15:
	bl	get_makepkg_raw
	ldrb	w0, [x0]
	adrp	x3, .LC64
	add	x3, x3, :lo12:.LC64
	cbnz	w0, .L530
.L16:
	str	x3, [sp]
	mov	x6, x25
	mov	x4, x24
	mov	x2, x23
	mov	x7, x19
	mov	x5, x20
	mov	x1, x22
	mov	x3, x21
	adrp	x0, .LC68
	add	x0, x0, :lo12:.LC68
	bl	printf
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
.L12:
	bl	print_usage
	mov	w0, 1
	b	.L528
	.p2align 2,,3
.L508:
	bl	get_raw_flags
	mov	x22, x0
	b	.L32
	.p2align 2,,3
.L509:
	bl	get_makepkg_raw
	mov	x5, x0
	b	.L33
	.p2align 2,,3
.L520:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L237
.L49:
	mov	w0, 1
	bl	set_resume
	b	.L37
	.p2align 2,,3
.L499:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC66
	mov	x2, 208
	add	x0, x0, :lo12:.LC66
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, 1
	b	.L528
.L522:
	bl	set_inhibit
	b	.L37
	.p2align 2,,3
.L530:
	bl	get_makepkg_raw
	mov	x3, x0
	b	.L16
	.p2align 2,,3
.L529:
	bl	get_raw_flags
	mov	x19, x0
	b	.L15
	.p2align 2,,3
.L47:
	bl	set_prompt_timeout
	b	.L37
	.p2align 2,,3
.L521:
	bl	set_import_keys
	b	.L37
	.p2align 2,,3
.L238:
	adrp	x1, .LC90
	mov	x0, x20
	add	x1, x1, :lo12:.LC90
	bl	strcmp
	cbz	w0, .L58
	ldrb	w0, [x20]
	cmp	w0, 45
	bne	.L65
	ldrb	w0, [x20, 1]
	cmp	w0, 106
	bne	.L65
	bl	__ctype_b_loc
	ldr	x0, [x0]
	ldrb	w1, [x20, 2]
	ldrh	w0, [x0, x1, lsl 1]
	tbnz	x0, 11, .L531
.L65:
	adrp	x1, .LC93
	mov	x0, x20
	add	x1, x1, :lo12:.LC93
	mov	x2, 7
	bl	strncmp
	cbz	w0, .L532
	adrp	x1, .LC95
	mov	x0, x20
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L71
	adrp	x1, .LC96
	mov	x0, x20
	add	x1, x1, :lo12:.LC96
	bl	strcmp
	cbz	w0, .L71
	adrp	x1, .LC97
	mov	x0, x20
	add	x1, x1, :lo12:.LC97
	bl	strcmp
	cbz	w0, .L71
	adrp	x1, .LC102
	mov	x0, x20
	add	x1, x1, :lo12:.LC102
	mov	x2, 9
	bl	strncmp
	cbnz	w0, .L77
	ldrb	w0, [x20, 9]
	add	x20, x20, 9
	cbz	w0, .L533
	adrp	x1, .LC99
	mov	x0, x20
	add	x1, x1, :lo12:.LC99
	bl	strcmp
	cbz	w0, .L74
.L498:
	adrp	x1, .LC100
	mov	x0, x20
	add	x1, x1, :lo12:.LC100
	bl	strcmp
	cbz	w0, .L74
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L85
	adrp	x1, .LC101
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC101
	b	.L484
.L523:
	bl	set_sync
	b	.L37
.L510:
	ldr	x20, [sp, 144]
	ldrb	w23, [x20]
	cmp	w23, 45
	bne	.L239
	ldrb	w0, [x20, 1]
	cmp	w0, 118
	bne	.L239
	ldrb	w0, [x20, 2]
	cbnz	w0, .L239
.L126:
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x1, .LC60
	add	x1, x1, :lo12:.LC60
	adrp	x19, .LC61
	add	x19, x19, :lo12:.LC61
	csel	x19, x19, x1, eq
	adrp	x20, .LC62
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x20, x20, :lo12:.LC62
	adrp	x21, .LC63
	add	x21, x21, :lo12:.LC63
	csel	x24, x21, x20, eq
	bl	get_use_binary
	cmp	w0, 0
	mov	x6, x24
	mov	x4, x23
	mov	x5, x19
	csel	x7, x21, x20, eq
	mov	x3, x22
	adrp	x2, .LC0
	adrp	x1, .LC1
	add	x2, x2, :lo12:.LC0
	add	x1, x1, :lo12:.LC1
	adrp	x0, .LC70
	add	x0, x0, :lo12:.LC70
	bl	printf
	adrp	x0, .LC71
	add	x0, x0, :lo12:.LC71
	bl	puts
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
.L524:
	bl	set_aur_sync
	b	.L37
.L239:
	add	x1, x26, :lo12:.LC69
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L126
	cmp	w23, 45
	bne	.L240
	ldrb	w0, [x20, 1]
	cmp	w0, 104
	bne	.L240
	ldrb	w0, [x20, 2]
	cbnz	w0, .L240
.L132:
	bl	print_usage
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
.L525:
	mov	w0, 1
	bl	set_use_pipe
	b	.L37
.L512:
	ldrb	w1, [x20, 1]
	cmp	w1, 83
	beq	.L534
.L143:
	cmp	w0, 45
	bne	.L147
	ldrb	w1, [x20, 1]
	cmp	w1, 81
	bne	.L242
	ldrb	w1, [x20, 2]
	cbnz	w1, .L242
.L146:
	add	x21, sp, 152
	mov	w22, 0
	mov	w19, 1
	b	.L151
	.p2align 2,,3
.L148:
	bl	cmd_available_info_v2
.L149:
	cmp	w0, 0
	add	w19, w19, 1
	cinc	w22, w22, eq
	add	x21, x21, 8
	cmp	w27, w19
	ble	.L535
.L151:
	ldrb	w1, [x20, 1]
	ldr	x0, [x21]
	cmp	w1, 81
	bne	.L148
	bl	cmd_query_v2
	b	.L149
.L70:
	bl	set_jobs
	b	.L37
.L526:
	bl	set_use_pipe
	b	.L37
.L535:
	cmp	w22, 0
	ldp	x23, x24, [sp, 64]
	cset	w0, ne
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L4
.L511:
	bl	get_target_arch
	adrp	x1, .LC67
	add	x1, x1, :lo12:.LC67
	bl	strcmp
	cbnz	w0, .L138
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L138
	ldrb	w0, [x0, 1]
	cbnz	w0, .L138
	bl	get_use_pipe
	cbnz	w0, .L536
.L138:
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x1, .LC60
	add	x1, x1, :lo12:.LC60
	adrp	x20, .LC61
	add	x20, x20, :lo12:.LC61
	csel	x20, x20, x1, eq
	adrp	x21, .LC62
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x21, x21, :lo12:.LC62
	adrp	x19, .LC63
	add	x19, x19, :lo12:.LC63
	csel	x24, x19, x21, eq
	bl	get_use_binary
	cmp	w0, 0
	csel	x19, x19, x21, eq
	bl	get_jobs
	mov	x21, x0
	bl	get_gentoo_chroot_path
	mov	x7, x0
	mov	x4, x24
	mov	x2, x23
	mov	x6, x21
	mov	x5, x19
	mov	x3, x20
	mov	x1, x22
	adrp	x0, .LC158
	add	x0, x0, :lo12:.LC158
	bl	printf
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
.L240:
	adrp	x0, .LC73
	add	x1, x0, :lo12:.LC73
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L132
	cmp	w23, 45
	bne	.L241
	ldrb	w0, [x20, 1]
	cmp	w0, 83
	bne	.L241
	ldrb	w0, [x20, 2]
	cbnz	w0, .L241
.L208:
	adrp	x0, .LC159
	mov	x2, 50
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC159
	b	.L482
.L534:
	ldrb	w1, [x20, 2]
	cbnz	w1, .L143
	cmp	w27, 2
	bne	.L208
	ldr	x0, [sp, 152]
	bl	cmd_search_v2
.L490:
	cmp	w0, 0
	ldp	x23, x24, [sp, 64]
	cset	w0, eq
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L4
.L507:
	adrp	x0, .LC81
	mov	x2, 47
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC81
	b	.L482
.L71:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L537
	ldr	x0, [sp, 112]
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	strcmp
	cbnz	w0, .L498
.L74:
	bl	print_known_targets
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
	.p2align 2,,3
.L242:
	cmp	w0, 45
	bne	.L147
	ldrb	w0, [x20, 1]
	cmp	w0, 65
	bne	.L147
	ldrb	w0, [x20, 2]
	cbz	w0, .L146
	b	.L147
	.p2align 2,,3
.L532:
	mov	w2, 10
	add	x0, x20, 7
	add	x1, sp, 136
	str	xzr, [sp, 136]
	bl	strtol
	ldr	x2, [sp, 136]
	cbz	x2, .L69
	ldrb	w2, [x2]
	cbnz	w2, .L69
	sub	x1, x0, #1
	cmp	x1, 1023
	bls	.L70
.L69:
	adrp	x0, .LC94
	mov	x2, 34
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC94
	b	.L482
.L85:
	mov	x0, x20
	bl	set_target_arch
	b	.L37
.L241:
	adrp	x1, .LC192
	mov	x0, x20
	add	x1, x1, :lo12:.LC192
	bl	strcmp
	cbz	w0, .L209
	adrp	x1, .LC160
	mov	x0, x20
	add	x1, x1, :lo12:.LC160
	bl	strcmp
	cbnz	w0, .L147
.L209:
	adrp	x0, .LC161
	mov	x2, 50
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC161
	b	.L482
.L531:
	add	x1, sp, 136
	mov	w2, 10
	add	x0, x20, 2
	str	xzr, [sp, 136]
	bl	strtol
	mov	x1, x0
	ldr	x2, [sp, 136]
	cbnz	x2, .L494
	b	.L66
.L513:
	bl	cmd_orphans_v2
	b	.L490
.L527:
	adrp	x1, .LC91
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC91
	b	.L484
.L536:
	bl	get_gentoo_chroot
	cbnz	w0, .L138
.L479:
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
.L516:
	bl	cmd_completion_v2
	b	.L490
.L515:
	bl	cmd_news_v2
	b	.L490
.L514:
	bl	cmd_stats_v2
	b	.L490
.L77:
	adrp	x1, .LC104
	mov	x0, x20
	add	x1, x1, :lo12:.LC104
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L80
	ldrb	w0, [x20, 8]
	add	x20, x20, 8
	cbz	w0, .L538
	adrp	x1, .LC99
	mov	x0, x20
	add	x1, x1, :lo12:.LC99
	bl	strcmp
	cbz	w0, .L74
	adrp	x1, .LC100
	mov	x0, x20
	add	x1, x1, :lo12:.LC100
	bl	strcmp
	cbz	w0, .L74
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L85
	adrp	x1, .LC106
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC106
	b	.L484
.L517:
	bl	cmd_devel_v2
	b	.L490
.L80:
	adrp	x1, .LC107
	mov	x0, x20
	add	x1, x1, :lo12:.LC107
	mov	x2, 6
	bl	strncmp
	cbnz	w0, .L83
	ldrb	w0, [x20, 6]
	add	x20, x20, 6
	cbz	w0, .L539
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L85
	adrp	x1, .LC109
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC109
	b	.L484
.L160:
	ldr	x0, [sp, 152]
	bl	cmd_review_v2
	b	.L490
.L159:
	mov	x1, x19
	mov	w0, w21
	bl	acquire_sudo
	cbz	w0, .L480
	mov	x0, x20
	adrp	x1, .LC171
	add	x1, x1, :lo12:.LC171
	bl	strcmp
	mov	w19, w0
	cbnz	w0, .L162
	cmp	w27, 1
	beq	.L480
	bl	init_system
	cbnz	w0, .L540
.L480:
	ldp	x23, x24, [sp, 64]
	mov	w0, 1
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L528
.L538:
	adrp	x0, .LC105
	mov	x2, 39
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC105
	b	.L482
.L519:
	ldr	x0, [sp, 152]
	bl	cmd_dependency_plan_v2
	b	.L490
.L518:
	ldr	x0, [sp, 152]
	bl	cmd_provider_v2
	b	.L490
.L539:
	adrp	x0, .LC108
	mov	x2, 37
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC108
	b	.L482
.L83:
	adrp	x1, .LC110
	mov	x0, x20
	add	x1, x1, :lo12:.LC110
	bl	strcmp
	cbz	w0, .L86
	adrp	x1, .LC111
	mov	x0, x20
	add	x1, x1, :lo12:.LC111
	bl	strcmp
	cbz	w0, .L86
	adrp	x1, .LC112
	mov	x0, x20
	add	x1, x1, :lo12:.LC112
	bl	strcmp
	cbz	w0, .L86
	adrp	x28, .LC113
	mov	x0, x20
	add	x1, x28, :lo12:.LC113
	bl	strcmp
	cbz	w0, .L86
	adrp	x1, .LC116
	mov	x0, x20
	add	x1, x1, :lo12:.LC116
	mov	x2, 12
	bl	strncmp
	cbnz	w0, .L92
	ldrb	w0, [x20, 12]
	add	x20, x20, 12
	cbz	w0, .L541
	adrp	x1, .LC99
	mov	x0, x20
	add	x1, x1, :lo12:.LC99
	bl	strcmp
	cbz	w0, .L89
	adrp	x1, .LC100
	mov	x0, x20
	add	x1, x1, :lo12:.LC100
	bl	strcmp
	cbz	w0, .L89
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L465
	adrp	x1, .LC118
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC118
	b	.L484
.L533:
	adrp	x0, .LC103
	mov	x2, 40
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC103
	b	.L482
.L540:
	bl	get_use_binary
	cbz	w0, .L164
	mov	x20, 1
.L166:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L166
.L491:
	cmp	w19, 0
	ldp	x23, x24, [sp, 64]
	cset	w0, ne
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L4
.L162:
	mov	x0, x20
	adrp	x1, .LC172
	add	x1, x1, :lo12:.LC172
	bl	strcmp
	mov	w19, w0
	cbnz	w0, .L172
	cmp	w27, 1
	beq	.L480
	mov	x20, 1
.L174:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_get_pkgbuild_v2
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L174
	b	.L491
.L89:
	bl	print_known_opt_levels
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L24
.L541:
	adrp	x0, .LC117
	mov	x2, 43
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC117
	b	.L482
.L92:
	adrp	x1, .LC119
	mov	x0, x20
	add	x1, x1, :lo12:.LC119
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L542
	adrp	x1, .LC121
	mov	x0, x20
	add	x1, x1, :lo12:.LC121
	mov	x2, 15
	bl	strncmp
	cbz	w0, .L543
	adrp	x1, .LC123
	mov	x0, x20
	add	x1, x1, :lo12:.LC123
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC124
	mov	x0, x20
	add	x1, x1, :lo12:.LC124
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC125
	mov	x0, x20
	add	x1, x1, :lo12:.LC125
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC126
	mov	x0, x20
	add	x1, x1, :lo12:.LC126
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC127
	mov	x0, x20
	add	x1, x1, :lo12:.LC127
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC128
	mov	x0, x20
	add	x1, x1, :lo12:.LC128
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC129
	mov	x0, x20
	add	x1, x1, :lo12:.LC129
	bl	strcmp
	cbz	w0, .L465
	adrp	x1, .LC130
	mov	x0, x20
	add	x1, x1, :lo12:.LC130
	bl	strcmp
	cbz	w0, .L544
	add	x1, x28, :lo12:.LC113
	mov	x0, x20
	mov	x2, 2
	bl	strncmp
	cbnz	w0, .L103
	mov	x0, x20
	bl	strlen
	cmp	x0, 7
	bhi	.L103
	add	x0, x20, 3
	ldrb	w1, [x20, 2]!
	cmp	w1, 61
	csel	x20, x0, x20, eq
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L465
	ldr	x20, [x19, x23]
.L103:
	adrp	x1, .LC132
	mov	x0, x20
	add	x1, x1, :lo12:.LC132
	bl	strcmp
	cbnz	w0, .L106
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L545
	ldr	x0, [sp, 112]
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	valid_raw_flags
	cbz	w0, .L487
.L110:
	mov	x0, x20
	bl	set_raw_flags
	b	.L37
.L544:
	adrp	x0, .LC131
	add	x0, x0, :lo12:.LC131
	bl	set_opt_level
	b	.L37
.L542:
	add	x20, x20, 6
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L465
	adrp	x1, .LC120
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC120
	b	.L484
.L86:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L546
	ldr	x0, [sp, 112]
	adrp	x1, .LC99
	add	x1, x1, :lo12:.LC99
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L89
	adrp	x1, .LC100
	mov	x0, x20
	add	x1, x1, :lo12:.LC100
	bl	strcmp
	cbz	w0, .L89
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L465
	adrp	x1, .LC115
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC115
	b	.L484
.L537:
	adrp	x1, .LC98
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC98
	b	.L484
.L543:
	add	x20, x20, 15
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L465
	adrp	x1, .LC122
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC122
	b	.L484
.L547:
	add	x20, x20, 6
	mov	x0, x20
	bl	valid_raw_flags
	cbnz	w0, .L110
.L487:
	adrp	x0, .LC134
	mov	x2, 112
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC134
	b	.L482
.L545:
	adrp	x0, .LC133
	mov	x2, 43
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC133
	b	.L482
.L106:
	adrp	x1, .LC135
	mov	x0, x20
	add	x1, x1, :lo12:.LC135
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L547
	adrp	x1, .LC136
	mov	x0, x20
	add	x1, x1, :lo12:.LC136
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC137
	mov	x0, x20
	add	x1, x1, :lo12:.LC137
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC138
	mov	x0, x20
	add	x1, x1, :lo12:.LC138
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC139
	mov	x0, x20
	add	x1, x1, :lo12:.LC139
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC140
	mov	x0, x20
	add	x1, x1, :lo12:.LC140
	bl	strcmp
	cbz	w0, .L113
	adrp	x1, .LC141
	mov	x0, x20
	add	x1, x1, :lo12:.LC141
	bl	strcmp
	cbz	w0, .L113
	adrp	x1, .LC142
	mov	x0, x20
	add	x1, x1, :lo12:.LC142
	mov	x2, 14
	bl	strncmp
	cbz	w0, .L548
	adrp	x1, .LC144
	mov	x0, x20
	add	x1, x1, :lo12:.LC144
	bl	strcmp
	cbnz	w0, .L117
	add	w22, w22, 1
	cmp	w21, w22
	ble	.L549
	ldr	x0, [sp, 112]
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L119
.L497:
	adrp	x1, .LC143
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC143
	b	.L484
.L164:
	bl	get_gentoo_chroot
	mov	w19, w0
	cbz	w0, .L231
	mov	w19, 0
	mov	x20, 1
.L170:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_gentoo_imitation_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L170
	b	.L491
.L465:
	mov	x0, x20
	bl	set_opt_level
	b	.L37
.L546:
	adrp	x1, .LC114
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC114
	b	.L484
.L231:
	mov	x20, 1
.L168:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L168
	b	.L491
.L172:
	adrp	x1, .LC173
	mov	x0, x20
	add	x1, x1, :lo12:.LC173
	bl	strcmp
	cbz	w0, .L550
	adrp	x1, .LC174
	mov	x0, x20
	add	x1, x1, :lo12:.LC174
	bl	strcmp
	cbz	w0, .L551
	adrp	x1, .LC175
	mov	x0, x20
	add	x1, x1, :lo12:.LC175
	bl	strcmp
	cbz	w0, .L177
	adrp	x1, .LC176
	mov	x0, x20
	add	x1, x1, :lo12:.LC176
	bl	strcmp
	cbz	w0, .L177
	adrp	x1, .LC177
	mov	x0, x20
	add	x1, x1, :lo12:.LC177
	bl	strcmp
	cbz	w0, .L179
	adrp	x1, .LC178
	mov	x0, x20
	add	x1, x1, :lo12:.LC178
	bl	strcmp
	cbz	w0, .L179
	adrp	x1, .LC180
	mov	x0, x20
	add	x1, x1, :lo12:.LC180
	bl	strcmp
	cbz	w0, .L184
	adrp	x1, .LC181
	mov	x0, x20
	add	x1, x1, :lo12:.LC181
	bl	strcmp
	cbz	w0, .L184
	ldrb	w0, [x20]
	mov	x19, 0
	cmp	w0, 45
	beq	.L552
.L189:
	ldr	x21, [x22, x19, lsl 3]
	add	x19, x19, 1
	mov	x0, x21
	bl	valid_pkgname
	cbz	w0, .L553
	cmp	w27, w19
	bgt	.L189
	bl	init_system
	cbz	w0, .L480
	bl	get_use_binary
	mov	w21, w0
	cbz	w0, .L191
	adrp	x21, .LC185
	mov	x19, 0
	add	x21, x21, :lo12:.LC185
	mov	w20, 0
	b	.L194
.L554:
	mov	x3, x23
	bl	printf
	mov	x0, x23
	bl	cmd_build
	cbz	w0, .L201
.L193:
	add	x19, x19, 1
	cmp	w27, w19
	ble	.L202
.L194:
	ldr	x23, [x22, x19, lsl 3]
	mov	w2, w27
	add	w1, w19, 1
	mov	x0, x21
	cmp	w27, 1
	bne	.L554
	mov	x0, x23
	bl	cmd_build
	cbnz	w0, .L202
.L201:
	add	w20, w20, 1
	b	.L193
.L548:
	add	x20, x20, 14
	mov	x0, x20
	bl	valid_gentoo_chroot_path
	cbz	w0, .L497
.L119:
	mov	x0, x20
	bl	set_gentoo_chroot_path
	b	.L37
.L553:
	adrp	x1, .LC184
	mov	x2, x21
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC184
	b	.L484
.L202:
	cbz	w20, .L479
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC186
	mov	w2, w20
	add	x1, x1, :lo12:.LC186
.L485:
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L528
.L191:
	bl	get_gentoo_chroot
	mov	w19, w0
	cbz	w0, .L233
	adrp	x20, .LC187
	mov	x19, 0
	add	x20, x20, :lo12:.LC187
	b	.L198
.L555:
	mov	x3, x23
	bl	printf
	mov	x0, x23
	bl	cmd_gentoo_imitation_build
	cbz	w0, .L203
.L197:
	add	x19, x19, 1
	cmp	w27, w19
	ble	.L204
.L198:
	ldr	x23, [x22, x19, lsl 3]
	mov	w2, w27
	add	w1, w19, 1
	mov	x0, x20
	cmp	w27, 1
	bne	.L555
	mov	x0, x23
	bl	cmd_gentoo_imitation_build
	cbnz	w0, .L204
.L203:
	add	w21, w21, 1
	b	.L197
.L552:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC183
	add	x1, x1, :lo12:.LC183
	ldr	x0, [x0]
	bl	fprintf
	bl	print_usage
	mov	w0, 1
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L528
.L184:
	cmp	w27, 1
	beq	.L556
	bl	init_system
	cbz	w0, .L480
	mov	w20, 0
	mov	x19, 1
.L188:
	ldr	x0, [x22, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_unmerge
	cmp	w0, 0
	cinc	w20, w20, eq
	cmp	w27, w19
	bgt	.L188
.L489:
	cmp	w20, 0
	ldp	x23, x24, [sp, 64]
	cset	w0, ne
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L4
.L179:
	cmp	w27, 1
	beq	.L557
	bl	init_system
	cbz	w0, .L480
	mov	w20, 0
	mov	x19, 1
.L183:
	ldr	x0, [x22, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_deselect
	cmp	w0, 0
	cinc	w20, w20, eq
	cmp	w27, w19
	bgt	.L183
	b	.L489
.L177:
	bl	init_system
	cbz	w0, .L480
	bl	cmd_world_update
	b	.L490
.L557:
	adrp	x0, .LC179
	mov	x2, 53
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC179
	b	.L482
.L556:
	adrp	x0, .LC182
	mov	x2, 57
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC182
	b	.L482
.L204:
	cbz	w21, .L479
	adrp	x1, .LC188
	mov	w2, w21
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC188
	b	.L485
.L233:
	adrp	x23, .LC189
	mov	x21, 0
	add	x23, x23, :lo12:.LC189
	b	.L195
.L558:
	mov	x3, x24
	bl	printf
	mov	x0, x24
	bl	cmd_build
	cbz	w0, .L205
.L200:
	add	x21, x21, 1
	cmp	w27, w21
	ble	.L206
.L195:
	ldr	x24, [x22, x21, lsl 3]
	mov	w2, w27
	add	w1, w21, 1
	mov	x0, x23
	cmp	w27, 1
	bne	.L558
	mov	x0, x24
	bl	cmd_build
	cbnz	w0, .L206
.L205:
	add	w19, w19, 1
	b	.L200
.L551:
	bl	cmd_clean_v2
	b	.L490
.L549:
	adrp	x0, .LC145
	mov	x2, 42
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC145
	b	.L482
.L117:
	adrp	x1, .LC146
	mov	x0, x20
	add	x1, x1, :lo12:.LC146
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC147
	mov	x0, x20
	add	x1, x1, :lo12:.LC147
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC148
	mov	x0, x20
	add	x1, x1, :lo12:.LC148
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC149
	mov	x0, x20
	add	x1, x1, :lo12:.LC149
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC150
	mov	x0, x20
	add	x1, x1, :lo12:.LC150
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC151
	mov	x0, x20
	add	x1, x1, :lo12:.LC151
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC152
	mov	x0, x20
	add	x1, x1, :lo12:.LC152
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC153
	mov	x0, x20
	add	x1, x1, :lo12:.LC153
	bl	strcmp
	cbz	w0, .L120
	adrp	x1, .LC154
	mov	x0, x20
	add	x1, x1, :lo12:.LC154
	bl	strcmp
	cbz	w0, .L122
	adrp	x1, .LC155
	mov	x0, x20
	add	x1, x1, :lo12:.LC155
	bl	strcmp
	cbz	w0, .L122
	adrp	x1, .LC156
	mov	x0, x20
	add	x1, x1, :lo12:.LC156
	bl	strcmp
	cbz	w0, .L122
	adrp	x1, .LC157
	mov	x0, x20
	add	x1, x1, :lo12:.LC157
	bl	strcmp
	cbz	w0, .L122
	add	x0, sp, 144
	str	x20, [x0, w27, sxtw 3]
	add	w27, w27, 1
	b	.L37
.L113:
	mov	w0, 0
	bl	set_gentoo_chroot
	mov	w0, 0
	bl	set_portage_imitation
	b	.L37
.L550:
	cmp	w27, 2
	bne	.L480
	ldr	x0, [sp, 152]
	bl	cmd_local_build_v2
	b	.L490
.L206:
	cbz	w19, .L479
	adrp	x21, :got:stderr;ldr	x21, [x21, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC190
	add	x1, x1, :lo12:.LC190
	ldr	x0, [x21]
	bl	fprintf
	bl	get_resume
	cbnz	w0, .L480
	ldr	x0, [x21]
	mov	x2, x20
	adrp	x1, .LC191
	add	x1, x1, :lo12:.LC191
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 64]
	ldp	x25, x26, [sp, 80]
	ldp	x27, x28, [sp, 96]
	b	.L528
.L111:
	mov	w0, 1
	bl	set_gentoo_chroot
	mov	w0, 1
	bl	set_portage_imitation
	b	.L37
.L122:
	mov	w0, 0
	bl	set_use_binary
	b	.L37
.L120:
	mov	w0, 1
	bl	set_use_binary
	b	.L37
	.section	.note.GNU-stack,"",@progbits
