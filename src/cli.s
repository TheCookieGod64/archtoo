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
	stp	x19, x20, [sp, 16]
	mov	x19, x1
	stp	x21, x22, [sp, 32]
	mov	w21, w0
	bl	geteuid
	cbnz	w0, .L5
	adrp	x0, .LC60
	add	x0, x0, :lo12:.LC60
	bl	getenv
	cbz	x0, .L479
.L5:
	bl	load_user_config
	cmp	w21, 1
	ble	.L480
	ldr	x20, [x19, 8]
	ldrb	w22, [x20]
	cmp	w22, 45
	bne	.L222
	ldrb	w0, [x20, 1]
	cmp	w0, 118
	bne	.L222
	ldrb	w0, [x20, 2]
	cbz	w0, .L17
	.p2align 5,,15
.L222:
	mov	x0, x20
	stp	x25, x26, [sp, 64]
	adrp	x26, .LC64
	add	x1, x26, :lo12:.LC64
	bl	strcmp
	cbz	w0, .L481
	cmp	w22, 45
	bne	.L223
	ldrb	w0, [x20, 1]
	cmp	w0, 104
	beq	.L482
.L223:
	adrp	x1, .LC68
	mov	x0, x20
	add	x1, x1, :lo12:.LC68
	bl	strcmp
	cbz	w0, .L24
	adrp	x25, .LC71
	add	x25, x25, :lo12:.LC71
	stp	x23, x24, [sp, 48]
	adrp	x24, .LC70
	add	x24, x24, :lo12:.LC70
	adrp	x0, .LC72
	mov	w22, 1
	add	x0, x0, :lo12:.LC72
	stp	x27, x28, [sp, 80]
	mov	w27, 0
	str	x0, [sp, 104]
.L25:
	sbfiz	x23, x22, 3, 32
	mov	x1, x24
	add	x0, x19, x23
	str	x0, [sp, 96]
	ldr	x20, [x19, x23]
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L483
	mov	x1, x25
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L484
	ldr	x1, [sp, 104]
	mov	x0, x20
	mov	x2, 16
	bl	strncmp
	cbz	w0, .L485
	ldrb	w28, [x20]
	cmp	w28, 45
	bne	.L224
	ldrb	w0, [x20, 1]
	cmp	w0, 105
	beq	.L486
.L224:
	adrp	x1, .LC74
	mov	x0, x20
	add	x1, x1, :lo12:.LC74
	bl	strcmp
	cbz	w0, .L37
	adrp	x1, .LC75
	mov	x0, x20
	add	x1, x1, :lo12:.LC75
	bl	strcmp
	cbnz	w0, .L39
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L487
	ldr	x0, [sp, 96]
	mov	w2, 10
	add	x1, sp, 120
	str	xzr, [sp, 120]
	ldr	x0, [x0, 8]
	bl	strtol
	ldr	x2, [sp, 120]
	cbz	x2, .L42
	ldrb	w2, [x2]
	cbnz	w2, .L42
	mov	x2, 20864
	movk	x2, 0x1, lsl 16
	cmp	x0, x2
	bls	.L43
.L42:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC77
	add	x0, x0, :lo12:.LC77
	mov	x2, 51
.L464:
	ldr	x3, [x3]
	mov	x1, 1
	bl	fwrite
	ldp	x23, x24, [sp, 48]
	mov	w0, 1
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
.L506:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L481:
	ldp	x25, x26, [sp, 64]
.L17:
	stp	x23, x24, [sp, 48]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	adrp	x1, .LC56
	cmp	w0, 0
	add	x1, x1, :lo12:.LC56
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	adrp	x20, .LC58
	csel	x19, x19, x1, eq
	add	x20, x20, :lo12:.LC58
	bl	get_gentoo_chroot
	cmp	w0, 0
	adrp	x21, .LC59
	add	x21, x21, :lo12:.LC59
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
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	puts
	adrp	x0, .LC67
	add	x0, x0, :lo12:.LC67
	bl	puts
	ldp	x23, x24, [sp, 48]
.L22:
	mov	w0, 0
.L4:
	ldp	x29, x30, [sp]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	add	sp, sp, 2176
	ret
	.p2align 2,,3
.L485:
	add	x0, x20, 16
	add	x1, sp, 120
	bl	guide_policy_parse
	cbnz	w0, .L35
	adrp	x0, .LC73
	mov	x2, 77
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC73
	b	.L464
	.p2align 2,,3
.L482:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L223
.L24:
	bl	print_usage
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
	bl	strcmp
	cbnz	w0, .L29
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L29
	ldrb	w0, [x0, 1]
	cbnz	w0, .L29
	ldp	x25, x26, [sp, 64]
	b	.L22
	.p2align 2,,3
.L486:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L224
.L37:
	mov	w0, 1
	bl	set_interactive
.L33:
	add	w22, w22, 1
	cmp	w27, 255
	ccmp	w21, w22, 4, ne
	bgt	.L25
	add	x22, sp, 128
	str	xzr, [x22, w27, sxtw 3]
	bl	guide_maybe_show
	cmp	w27, 1
	beq	.L488
	cbz	w27, .L489
	ldr	x20, [sp, 128]
	ldrb	w0, [x20]
	cmp	w0, 45
	beq	.L490
.L139:
	adrp	x1, .LC153
	mov	x0, x20
	add	x1, x1, :lo12:.LC153
	bl	strcmp
	cbz	w0, .L491
	adrp	x1, .LC154
	mov	x0, x20
	add	x1, x1, :lo12:.LC154
	bl	strcmp
	cbz	w0, .L492
	adrp	x1, .LC155
	mov	x0, x20
	add	x1, x1, :lo12:.LC155
	bl	strcmp
	cbz	w0, .L493
	adrp	x1, .LC156
	mov	x0, x20
	add	x1, x1, :lo12:.LC156
	bl	strcmp
	cbz	w0, .L494
	adrp	x1, .LC157
	mov	x0, x20
	add	x1, x1, :lo12:.LC157
	bl	strcmp
	cbz	w0, .L495
	mov	x0, x20
	adrp	x1, .LC158
	add	x1, x1, :lo12:.LC158
	bl	strcmp
	cmp	w27, 2
	cset	w23, eq
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L496
	mov	x0, x20
	adrp	x1, .LC159
	add	x1, x1, :lo12:.LC159
	bl	strcmp
	cmp	w0, 0
	ccmp	w23, 0, 4, eq
	bne	.L497
	adrp	x1, .LC160
	mov	x0, x20
	add	x1, x1, :lo12:.LC160
	bl	strcmp
	cbnz	w0, .L151
	cmp	w27, 2
	beq	.L152
	adrp	x0, .LC161
	mov	x2, 46
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC161
	b	.L464
	.p2align 2,,3
.L39:
	cmp	w28, 45
	bne	.L225
	ldrb	w0, [x20, 1]
	cmp	w0, 114
	beq	.L498
.L225:
	adrp	x1, .LC78
	mov	x0, x20
	add	x1, x1, :lo12:.LC78
	bl	strcmp
	cbz	w0, .L45
	adrp	x1, .LC79
	mov	x0, x20
	add	x1, x1, :lo12:.LC79
	bl	strcmp
	cbz	w0, .L499
	adrp	x1, .LC80
	mov	x0, x20
	add	x1, x1, :lo12:.LC80
	bl	strcmp
	cbz	w0, .L500
	adrp	x1, .LC81
	mov	x0, x20
	add	x1, x1, :lo12:.LC81
	bl	strcmp
	cbz	w0, .L501
	adrp	x1, .LC82
	mov	x0, x20
	add	x1, x1, :lo12:.LC82
	bl	strcmp
	cbz	w0, .L502
	adrp	x1, .LC83
	mov	x0, x20
	add	x1, x1, :lo12:.LC83
	bl	strcmp
	cbz	w0, .L503
	adrp	x1, .LC84
	mov	x0, x20
	add	x1, x1, :lo12:.LC84
	bl	strcmp
	cbz	w0, .L504
	cmp	w28, 45
	bne	.L226
	ldrb	w0, [x20, 1]
	cmp	w0, 106
	bne	.L226
	ldrb	w0, [x20, 2]
	cbnz	w0, .L226
.L54:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L505
	add	x23, x23, 8
	add	x1, sp, 120
	mov	w2, 10
	str	xzr, [sp, 120]
	ldr	x0, [x19, x23]
	bl	strtol
	mov	x1, x0
	ldr	x2, [sp, 120]
	cbz	x2, .L62
.L474:
	ldrb	w2, [x2]
	cbnz	w2, .L62
	sub	x1, x1, #1
	cmp	x1, 1023
	bls	.L66
.L62:
	ldr	x2, [x19, x23]
	adrp	x1, .LC87
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC87
.L466:
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L506
	.p2align 2,,3
.L35:
	ldr	w0, [sp, 120]
	bl	guide_set_policy
	b	.L33
	.p2align 2,,3
.L29:
	bl	get_target_arch
	mov	x19, x0
	bl	get_opt_level
	mov	x20, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x4, .LC56
	add	x4, x4, :lo12:.LC56
	adrp	x3, .LC57
	add	x3, x3, :lo12:.LC57
	mov	x2, x20
	mov	x1, x19
	csel	x3, x3, x4, eq
	adrp	x0, .LC69
	add	x0, x0, :lo12:.LC69
	bl	printf
	ldp	x25, x26, [sp, 64]
	b	.L22
	.p2align 2,,3
.L483:
	mov	w0, 1
	bl	set_noconfirm
	b	.L33
	.p2align 2,,3
.L484:
	bl	guide_request_explicit
	b	.L33
	.p2align 2,,3
.L480:
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
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
	cbz	w0, .L12
	.p2align 5,,15
.L11:
	stp	x23, x24, [sp, 48]
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x3, .LC56
	add	x3, x3, :lo12:.LC56
	adrp	x20, .LC57
	add	x20, x20, :lo12:.LC57
	csel	x20, x20, x3, eq
	adrp	x21, .LC58
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x21, x21, :lo12:.LC58
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
	csel	x24, x19, x21, eq
	bl	get_use_binary
	cmp	w0, 0
	csel	x19, x19, x21, eq
	bl	get_gentoo_chroot_path
	mov	x6, x0
	mov	x4, x24
	mov	x2, x23
	mov	x5, x19
	mov	x3, x20
	mov	x1, x22
	adrp	x0, .LC63
	add	x0, x0, :lo12:.LC63
	bl	printf
	ldp	x23, x24, [sp, 48]
.L12:
	bl	print_usage
	mov	w0, 1
	b	.L506
	.p2align 2,,3
.L498:
	ldrb	w0, [x20, 2]
	cbnz	w0, .L225
.L45:
	mov	w0, 1
	bl	set_resume
	b	.L33
	.p2align 2,,3
.L479:
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	adrp	x0, .LC61
	mov	x2, 208
	add	x0, x0, :lo12:.LC61
	mov	x1, 1
	ldr	x3, [x3]
	bl	fwrite
	mov	w0, 1
	b	.L506
.L500:
	bl	set_inhibit
	b	.L33
	.p2align 2,,3
.L43:
	bl	set_prompt_timeout
	b	.L33
	.p2align 2,,3
.L499:
	bl	set_import_keys
	b	.L33
	.p2align 2,,3
.L226:
	adrp	x1, .LC85
	mov	x0, x20
	add	x1, x1, :lo12:.LC85
	bl	strcmp
	cbz	w0, .L54
	ldrb	w0, [x20]
	cmp	w0, 45
	bne	.L61
	ldrb	w0, [x20, 1]
	cmp	w0, 106
	bne	.L61
	bl	__ctype_b_loc
	ldr	x0, [x0]
	ldrb	w1, [x20, 2]
	ldrh	w0, [x0, x1, lsl 1]
	tbnz	x0, 11, .L507
.L61:
	adrp	x1, .LC88
	mov	x0, x20
	add	x1, x1, :lo12:.LC88
	mov	x2, 7
	bl	strncmp
	cbz	w0, .L508
	adrp	x1, .LC90
	mov	x0, x20
	add	x1, x1, :lo12:.LC90
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC91
	mov	x0, x20
	add	x1, x1, :lo12:.LC91
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC92
	mov	x0, x20
	add	x1, x1, :lo12:.LC92
	bl	strcmp
	cbz	w0, .L67
	adrp	x1, .LC97
	mov	x0, x20
	add	x1, x1, :lo12:.LC97
	mov	x2, 9
	bl	strncmp
	cbnz	w0, .L73
	ldrb	w0, [x20, 9]
	add	x20, x20, 9
	cbz	w0, .L509
	adrp	x1, .LC94
	mov	x0, x20
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L70
.L478:
	adrp	x1, .LC95
	mov	x0, x20
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L70
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC96
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC96
	b	.L466
.L501:
	bl	set_sync
	b	.L33
.L488:
	ldr	x20, [sp, 128]
	ldrb	w23, [x20]
	cmp	w23, 45
	bne	.L227
	ldrb	w0, [x20, 1]
	cmp	w0, 118
	bne	.L227
	ldrb	w0, [x20, 2]
	cbnz	w0, .L227
.L118:
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x1, .LC56
	add	x1, x1, :lo12:.LC56
	adrp	x19, .LC57
	add	x19, x19, :lo12:.LC57
	csel	x19, x19, x1, eq
	adrp	x20, .LC58
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x20, x20, :lo12:.LC58
	adrp	x21, .LC59
	add	x21, x21, :lo12:.LC59
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
	adrp	x0, .LC65
	add	x0, x0, :lo12:.LC65
	bl	printf
	adrp	x0, .LC66
	add	x0, x0, :lo12:.LC66
	bl	puts
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L502:
	bl	set_aur_sync
	b	.L33
.L227:
	add	x1, x26, :lo12:.LC64
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L118
	cmp	w23, 45
	bne	.L228
	ldrb	w0, [x20, 1]
	cmp	w0, 104
	bne	.L228
	ldrb	w0, [x20, 2]
	cbnz	w0, .L228
.L124:
	bl	print_usage
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L490:
	ldrb	w1, [x20, 1]
	cmp	w1, 83
	beq	.L510
.L135:
	cmp	w0, 45
	bne	.L139
	ldrb	w1, [x20, 1]
	cmp	w1, 81
	bne	.L230
	ldrb	w1, [x20, 2]
	cbnz	w1, .L230
.L138:
	add	x21, sp, 136
	mov	w22, 0
	mov	w19, 1
	b	.L143
	.p2align 2,,3
.L140:
	bl	cmd_available_info_v2
.L141:
	cmp	w0, 0
	add	w19, w19, 1
	cinc	w22, w22, eq
	add	x21, x21, 8
	cmp	w27, w19
	ble	.L511
.L143:
	ldrb	w1, [x20, 1]
	ldr	x0, [x21]
	cmp	w1, 81
	bne	.L140
	bl	cmd_query_v2
	b	.L141
.L503:
	mov	w0, 1
	bl	set_use_pipe
	b	.L33
.L66:
	bl	set_jobs
	b	.L33
.L504:
	bl	set_use_pipe
	b	.L33
.L511:
	cmp	w22, 0
	ldp	x23, x24, [sp, 48]
	cset	w0, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L489:
	bl	get_target_arch
	adrp	x1, .LC62
	add	x1, x1, :lo12:.LC62
	bl	strcmp
	cbnz	w0, .L130
	bl	get_opt_level
	ldrb	w1, [x0]
	cmp	w1, 51
	bne	.L130
	ldrb	w0, [x0, 1]
	cbnz	w0, .L130
	bl	get_use_pipe
	cbnz	w0, .L512
.L130:
	bl	get_target_arch
	mov	x22, x0
	bl	get_opt_level
	mov	x23, x0
	bl	get_use_pipe
	cmp	w0, 0
	adrp	x1, .LC56
	add	x1, x1, :lo12:.LC56
	adrp	x20, .LC57
	add	x20, x20, :lo12:.LC57
	csel	x20, x20, x1, eq
	adrp	x21, .LC58
	bl	get_gentoo_chroot
	cmp	w0, 0
	add	x21, x21, :lo12:.LC58
	adrp	x19, .LC59
	add	x19, x19, :lo12:.LC59
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
	adrp	x0, .LC149
	add	x0, x0, :lo12:.LC149
	bl	printf
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L228:
	adrp	x0, .LC68
	add	x1, x0, :lo12:.LC68
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L124
	cmp	w23, 45
	bne	.L229
	ldrb	w0, [x20, 1]
	cmp	w0, 83
	bne	.L229
	ldrb	w0, [x20, 2]
	cbnz	w0, .L229
.L200:
	adrp	x0, .LC150
	mov	x2, 50
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC150
	b	.L464
.L510:
	ldrb	w1, [x20, 2]
	cbnz	w1, .L135
	cmp	w27, 2
	bne	.L200
	ldr	x0, [sp, 136]
	bl	cmd_search_v2
.L470:
	cmp	w0, 0
	ldp	x23, x24, [sp, 48]
	cset	w0, eq
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L487:
	adrp	x0, .LC76
	mov	x2, 47
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC76
	b	.L464
.L67:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L513
	ldr	x0, [sp, 96]
	adrp	x1, .LC94
	add	x1, x1, :lo12:.LC94
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	strcmp
	cbnz	w0, .L478
.L70:
	bl	print_known_targets
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
	.p2align 2,,3
.L230:
	cmp	w0, 45
	bne	.L139
	ldrb	w0, [x20, 1]
	cmp	w0, 65
	bne	.L139
	ldrb	w0, [x20, 2]
	cbz	w0, .L138
	b	.L139
	.p2align 2,,3
.L508:
	mov	w2, 10
	add	x0, x20, 7
	add	x1, sp, 120
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
	adrp	x0, .LC89
	mov	x2, 34
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC89
	b	.L464
.L81:
	mov	x0, x20
	bl	set_target_arch
	b	.L33
.L229:
	adrp	x1, .LC183
	mov	x0, x20
	add	x1, x1, :lo12:.LC183
	bl	strcmp
	cbz	w0, .L201
	adrp	x1, .LC151
	mov	x0, x20
	add	x1, x1, :lo12:.LC151
	bl	strcmp
	cbnz	w0, .L139
.L201:
	adrp	x0, .LC152
	mov	x2, 50
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC152
	b	.L464
.L507:
	add	x1, sp, 120
	mov	w2, 10
	add	x0, x20, 2
	str	xzr, [sp, 120]
	bl	strtol
	mov	x1, x0
	ldr	x2, [sp, 120]
	cbnz	x2, .L474
	b	.L62
.L505:
	adrp	x1, .LC86
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC86
	b	.L466
.L491:
	bl	cmd_orphans_v2
	b	.L470
.L512:
	bl	get_gentoo_chroot
	cbnz	w0, .L130
.L461:
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L494:
	bl	cmd_completion_v2
	b	.L470
.L493:
	bl	cmd_news_v2
	b	.L470
.L492:
	bl	cmd_stats_v2
	b	.L470
.L73:
	adrp	x1, .LC99
	mov	x0, x20
	add	x1, x1, :lo12:.LC99
	mov	x2, 8
	bl	strncmp
	cbnz	w0, .L76
	ldrb	w0, [x20, 8]
	add	x20, x20, 8
	cbz	w0, .L514
	adrp	x1, .LC94
	mov	x0, x20
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L70
	adrp	x1, .LC95
	mov	x0, x20
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L70
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC101
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC101
	b	.L466
.L495:
	bl	cmd_devel_v2
	b	.L470
.L76:
	adrp	x1, .LC102
	mov	x0, x20
	add	x1, x1, :lo12:.LC102
	mov	x2, 6
	bl	strncmp
	cbnz	w0, .L79
	ldrb	w0, [x20, 6]
	add	x20, x20, 6
	cbz	w0, .L515
	mov	x0, x20
	bl	valid_target_arch
	cbnz	w0, .L81
	adrp	x1, .LC104
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC104
	b	.L466
.L152:
	ldr	x0, [sp, 136]
	bl	cmd_review_v2
	b	.L470
.L151:
	mov	x1, x19
	mov	w0, w21
	bl	acquire_sudo
	cbz	w0, .L462
	mov	x0, x20
	adrp	x1, .LC162
	add	x1, x1, :lo12:.LC162
	bl	strcmp
	mov	w19, w0
	cbnz	w0, .L154
	cmp	w27, 1
	beq	.L462
	bl	init_system
	cbnz	w0, .L516
.L462:
	ldp	x23, x24, [sp, 48]
	mov	w0, 1
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L506
.L514:
	adrp	x0, .LC100
	mov	x2, 39
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC100
	b	.L464
.L497:
	ldr	x0, [sp, 136]
	bl	cmd_dependency_plan_v2
	b	.L470
.L496:
	ldr	x0, [sp, 136]
	bl	cmd_provider_v2
	b	.L470
.L515:
	adrp	x0, .LC103
	mov	x2, 37
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC103
	b	.L464
.L79:
	adrp	x1, .LC105
	mov	x0, x20
	add	x1, x1, :lo12:.LC105
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC106
	mov	x0, x20
	add	x1, x1, :lo12:.LC106
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC107
	mov	x0, x20
	add	x1, x1, :lo12:.LC107
	bl	strcmp
	cbz	w0, .L82
	adrp	x28, .LC108
	mov	x0, x20
	add	x1, x28, :lo12:.LC108
	bl	strcmp
	cbz	w0, .L82
	adrp	x1, .LC111
	mov	x0, x20
	add	x1, x1, :lo12:.LC111
	mov	x2, 12
	bl	strncmp
	cbnz	w0, .L88
	ldrb	w0, [x20, 12]
	add	x20, x20, 12
	cbz	w0, .L517
	adrp	x1, .LC94
	mov	x0, x20
	add	x1, x1, :lo12:.LC94
	bl	strcmp
	cbz	w0, .L85
	adrp	x1, .LC95
	mov	x0, x20
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L85
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L447
	adrp	x1, .LC113
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC113
	b	.L466
.L509:
	adrp	x0, .LC98
	mov	x2, 40
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC98
	b	.L464
.L516:
	bl	get_use_binary
	cbz	w0, .L156
	mov	x20, 1
.L158:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L158
.L471:
	cmp	w19, 0
	ldp	x23, x24, [sp, 48]
	cset	w0, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L154:
	mov	x0, x20
	adrp	x1, .LC163
	add	x1, x1, :lo12:.LC163
	bl	strcmp
	mov	w19, w0
	cbnz	w0, .L164
	cmp	w27, 1
	beq	.L462
	mov	x20, 1
.L166:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_get_pkgbuild_v2
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L166
	b	.L471
.L85:
	bl	print_known_opt_levels
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L22
.L517:
	adrp	x0, .LC112
	mov	x2, 43
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC112
	b	.L464
.L88:
	adrp	x1, .LC114
	mov	x0, x20
	add	x1, x1, :lo12:.LC114
	mov	x2, 6
	bl	strncmp
	cbz	w0, .L518
	adrp	x1, .LC116
	mov	x0, x20
	add	x1, x1, :lo12:.LC116
	mov	x2, 15
	bl	strncmp
	cbz	w0, .L519
	adrp	x1, .LC118
	mov	x0, x20
	add	x1, x1, :lo12:.LC118
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC119
	mov	x0, x20
	add	x1, x1, :lo12:.LC119
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC120
	mov	x0, x20
	add	x1, x1, :lo12:.LC120
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC121
	mov	x0, x20
	add	x1, x1, :lo12:.LC121
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC122
	mov	x0, x20
	add	x1, x1, :lo12:.LC122
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC123
	mov	x0, x20
	add	x1, x1, :lo12:.LC123
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC124
	mov	x0, x20
	add	x1, x1, :lo12:.LC124
	bl	strcmp
	cbz	w0, .L447
	adrp	x1, .LC125
	mov	x0, x20
	add	x1, x1, :lo12:.LC125
	bl	strcmp
	cbz	w0, .L520
	add	x1, x28, :lo12:.LC108
	mov	x0, x20
	mov	x2, 2
	bl	strncmp
	cbnz	w0, .L99
	mov	x0, x20
	bl	strlen
	cmp	x0, 7
	bhi	.L99
	add	x0, x20, 3
	ldrb	w1, [x20, 2]!
	cmp	w1, 61
	csel	x20, x0, x20, eq
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L447
	ldr	x20, [x19, x23]
.L99:
	adrp	x1, .LC127
	mov	x0, x20
	add	x1, x1, :lo12:.LC127
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC128
	mov	x0, x20
	add	x1, x1, :lo12:.LC128
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC129
	mov	x0, x20
	add	x1, x1, :lo12:.LC129
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC130
	mov	x0, x20
	add	x1, x1, :lo12:.LC130
	bl	strcmp
	cbz	w0, .L102
	adrp	x1, .LC131
	mov	x0, x20
	add	x1, x1, :lo12:.LC131
	bl	strcmp
	cbz	w0, .L104
	adrp	x1, .LC132
	mov	x0, x20
	add	x1, x1, :lo12:.LC132
	bl	strcmp
	cbz	w0, .L104
	adrp	x1, .LC133
	mov	x0, x20
	add	x1, x1, :lo12:.LC133
	mov	x2, 14
	bl	strncmp
	cbz	w0, .L521
	adrp	x1, .LC135
	mov	x0, x20
	add	x1, x1, :lo12:.LC135
	bl	strcmp
	cbnz	w0, .L108
	add	w22, w22, 1
	cmp	w21, w22
	ble	.L522
	ldr	x0, [sp, 96]
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	valid_gentoo_chroot_path
	cbnz	w0, .L110
.L477:
	adrp	x1, .LC134
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC134
	b	.L466
.L520:
	adrp	x0, .LC126
	add	x0, x0, :lo12:.LC126
	bl	set_opt_level
	b	.L33
.L519:
	add	x20, x20, 15
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L447
	adrp	x1, .LC117
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC117
	b	.L466
.L513:
	adrp	x1, .LC93
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC93
	b	.L466
.L447:
	mov	x0, x20
	bl	set_opt_level
	b	.L33
.L156:
	bl	get_gentoo_chroot
	mov	w19, w0
	cbz	w0, .L219
	mov	w19, 0
	mov	x20, 1
.L162:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_gentoo_imitation_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L162
	b	.L471
.L164:
	adrp	x1, .LC164
	mov	x0, x20
	add	x1, x1, :lo12:.LC164
	bl	strcmp
	cbz	w0, .L523
	adrp	x1, .LC165
	mov	x0, x20
	add	x1, x1, :lo12:.LC165
	bl	strcmp
	cbz	w0, .L524
	adrp	x1, .LC166
	mov	x0, x20
	add	x1, x1, :lo12:.LC166
	bl	strcmp
	cbz	w0, .L169
	adrp	x1, .LC167
	mov	x0, x20
	add	x1, x1, :lo12:.LC167
	bl	strcmp
	cbz	w0, .L169
	adrp	x1, .LC168
	mov	x0, x20
	add	x1, x1, :lo12:.LC168
	bl	strcmp
	cbz	w0, .L171
	adrp	x1, .LC169
	mov	x0, x20
	add	x1, x1, :lo12:.LC169
	bl	strcmp
	cbz	w0, .L171
	adrp	x1, .LC171
	mov	x0, x20
	add	x1, x1, :lo12:.LC171
	bl	strcmp
	cbz	w0, .L176
	adrp	x1, .LC172
	mov	x0, x20
	add	x1, x1, :lo12:.LC172
	bl	strcmp
	cbz	w0, .L176
	ldrb	w0, [x20]
	mov	x19, 0
	cmp	w0, 45
	beq	.L525
.L181:
	ldr	x21, [x22, x19, lsl 3]
	add	x19, x19, 1
	mov	x0, x21
	bl	valid_pkgname
	cbz	w0, .L526
	cmp	w27, w19
	bgt	.L181
	bl	init_system
	cbz	w0, .L462
	bl	get_use_binary
	mov	w21, w0
	cbz	w0, .L183
	adrp	x21, .LC176
	mov	x19, 0
	add	x21, x21, :lo12:.LC176
	mov	w20, 0
	b	.L186
.L527:
	mov	x3, x23
	bl	printf
	mov	x0, x23
	bl	cmd_build
	cbz	w0, .L193
.L185:
	add	x19, x19, 1
	cmp	w27, w19
	ble	.L194
.L186:
	ldr	x23, [x22, x19, lsl 3]
	mov	w2, w27
	add	w1, w19, 1
	mov	x0, x21
	cmp	w27, 1
	bne	.L527
	mov	x0, x23
	bl	cmd_build
	cbnz	w0, .L194
.L193:
	add	w20, w20, 1
	b	.L185
.L219:
	mov	x20, 1
.L160:
	ldr	x0, [x22, x20, lsl 3]
	add	x20, x20, 1
	bl	cmd_build
	cmp	w0, 0
	cinc	w19, w19, eq
	cmp	w27, w20
	bgt	.L160
	b	.L471
.L526:
	adrp	x1, .LC175
	mov	x2, x21
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC175
	b	.L466
.L194:
	cbz	w20, .L461
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	adrp	x1, .LC177
	mov	w2, w20
	add	x1, x1, :lo12:.LC177
.L467:
	ldr	x0, [x0]
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L506
.L183:
	bl	get_gentoo_chroot
	mov	w19, w0
	cbz	w0, .L221
	adrp	x20, .LC178
	mov	x19, 0
	add	x20, x20, :lo12:.LC178
	b	.L190
.L528:
	mov	x3, x23
	bl	printf
	mov	x0, x23
	bl	cmd_gentoo_imitation_build
	cbz	w0, .L195
.L189:
	add	x19, x19, 1
	cmp	w27, w19
	ble	.L196
.L190:
	ldr	x23, [x22, x19, lsl 3]
	mov	w2, w27
	add	w1, w19, 1
	mov	x0, x20
	cmp	w27, 1
	bne	.L528
	mov	x0, x23
	bl	cmd_gentoo_imitation_build
	cbnz	w0, .L196
.L195:
	add	w21, w21, 1
	b	.L189
.L525:
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	mov	x2, x20
	adrp	x1, .LC174
	add	x1, x1, :lo12:.LC174
	ldr	x0, [x0]
	bl	fprintf
	bl	print_usage
	mov	w0, 1
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L506
.L176:
	cmp	w27, 1
	beq	.L529
	bl	init_system
	cbz	w0, .L462
	mov	w20, 0
	mov	x19, 1
.L180:
	ldr	x0, [x22, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_unmerge
	cmp	w0, 0
	cinc	w20, w20, eq
	cmp	w27, w19
	bgt	.L180
.L469:
	cmp	w20, 0
	ldp	x23, x24, [sp, 48]
	cset	w0, ne
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L4
.L196:
	cbz	w21, .L461
	adrp	x1, .LC179
	mov	w2, w21
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC179
	b	.L467
.L518:
	add	x20, x20, 6
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L447
	adrp	x1, .LC115
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC115
	b	.L466
.L82:
	add	w22, w22, 1
	cmp	w22, w21
	bge	.L530
	ldr	x0, [sp, 96]
	adrp	x1, .LC94
	add	x1, x1, :lo12:.LC94
	ldr	x20, [x0, 8]
	mov	x0, x20
	bl	strcmp
	cbz	w0, .L85
	adrp	x1, .LC95
	mov	x0, x20
	add	x1, x1, :lo12:.LC95
	bl	strcmp
	cbz	w0, .L85
	mov	x0, x20
	bl	valid_opt_level
	cbnz	w0, .L447
	adrp	x1, .LC110
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC110
	b	.L466
.L521:
	add	x20, x20, 14
	mov	x0, x20
	bl	valid_gentoo_chroot_path
	cbz	w0, .L477
.L110:
	mov	x0, x20
	bl	set_gentoo_chroot_path
	b	.L33
.L522:
	adrp	x0, .LC136
	mov	x2, 42
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC136
	b	.L464
.L530:
	adrp	x1, .LC109
	mov	x2, x20
	adrp	x0, :got:stderr;ldr	x0, [x0, :got_lo12:stderr]
	add	x1, x1, :lo12:.LC109
	b	.L466
.L108:
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
	cbz	w0, .L111
	adrp	x1, .LC141
	mov	x0, x20
	add	x1, x1, :lo12:.LC141
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC142
	mov	x0, x20
	add	x1, x1, :lo12:.LC142
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC143
	mov	x0, x20
	add	x1, x1, :lo12:.LC143
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC144
	mov	x0, x20
	add	x1, x1, :lo12:.LC144
	bl	strcmp
	cbz	w0, .L111
	adrp	x1, .LC145
	mov	x0, x20
	add	x1, x1, :lo12:.LC145
	bl	strcmp
	cbz	w0, .L114
	adrp	x1, .LC146
	mov	x0, x20
	add	x1, x1, :lo12:.LC146
	bl	strcmp
	cbz	w0, .L114
	adrp	x1, .LC147
	mov	x0, x20
	add	x1, x1, :lo12:.LC147
	bl	strcmp
	cbz	w0, .L114
	adrp	x1, .LC148
	mov	x0, x20
	add	x1, x1, :lo12:.LC148
	bl	strcmp
	cbz	w0, .L114
	add	x0, sp, 128
	str	x20, [x0, w27, sxtw 3]
	add	w27, w27, 1
	b	.L33
.L114:
	mov	w0, 0
	bl	set_use_binary
	b	.L33
.L111:
	mov	w0, 1
	bl	set_use_binary
	b	.L33
.L104:
	mov	w0, 0
	bl	set_gentoo_chroot
	mov	w0, 0
	bl	set_portage_imitation
	b	.L33
.L102:
	mov	w0, 1
	bl	set_gentoo_chroot
	mov	w0, 1
	bl	set_portage_imitation
	b	.L33
.L171:
	cmp	w27, 1
	beq	.L531
	bl	init_system
	cbz	w0, .L462
	mov	w20, 0
	mov	x19, 1
.L175:
	ldr	x0, [x22, x19, lsl 3]
	add	x19, x19, 1
	bl	cmd_deselect
	cmp	w0, 0
	cinc	w20, w20, eq
	cmp	w27, w19
	bgt	.L175
	b	.L469
.L169:
	bl	init_system
	cbz	w0, .L462
	bl	cmd_world_update
	b	.L470
.L531:
	adrp	x0, .LC170
	mov	x2, 53
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC170
	b	.L464
.L524:
	bl	cmd_clean_v2
	b	.L470
.L523:
	cmp	w27, 2
	bne	.L462
	ldr	x0, [sp, 136]
	bl	cmd_local_build_v2
	b	.L470
.L221:
	adrp	x23, .LC180
	mov	x21, 0
	add	x23, x23, :lo12:.LC180
	b	.L187
.L532:
	mov	x3, x24
	bl	printf
	mov	x0, x24
	bl	cmd_build
	cbz	w0, .L197
.L192:
	add	x21, x21, 1
	cmp	w27, w21
	ble	.L198
.L187:
	ldr	x24, [x22, x21, lsl 3]
	mov	w2, w27
	add	w1, w21, 1
	mov	x0, x23
	cmp	w27, 1
	bne	.L532
	mov	x0, x24
	bl	cmd_build
	cbnz	w0, .L198
.L197:
	add	w19, w19, 1
	b	.L192
.L529:
	adrp	x0, .LC173
	mov	x2, 57
	adrp	x3, :got:stderr;ldr	x3, [x3, :got_lo12:stderr]
	add	x0, x0, :lo12:.LC173
	b	.L464
.L198:
	cbz	w19, .L461
	adrp	x21, :got:stderr;ldr	x21, [x21, :got_lo12:stderr]
	mov	w2, w19
	adrp	x1, .LC181
	add	x1, x1, :lo12:.LC181
	ldr	x0, [x21]
	bl	fprintf
	bl	get_resume
	cbnz	w0, .L462
	ldr	x0, [x21]
	mov	x2, x20
	adrp	x1, .LC182
	add	x1, x1, :lo12:.LC182
	bl	fprintf
	mov	w0, 1
	ldp	x23, x24, [sp, 48]
	ldp	x25, x26, [sp, 64]
	ldp	x27, x28, [sp, 80]
	b	.L506
	.section	.note.GNU-stack,"",@progbits
