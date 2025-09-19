#
# PROMPT
#
: << END
TODO: 
- set up variables for ansi color sequences, so that this shit is 
  somewhat readable :P
- programatically set colors with a set of options
- programatically set the regular font style for icons
- programatically select the information I want to show e.g. by having 
  something like PROMPT_MODULES=(host cwd python_venv shlvl git_info)
- have an option to use emoji instead of nerd fonts
- find a way to autosource a python virtual environment
- rewrite this shit in rust/c/python/javascript/lua/go and anything else
	that sounds cool
END

# ----- OPTIONS -----
promptchar='❯'
# prompt_char='>'
# IGNORE_NERD_FONT=y # setting this variable disables nerdfont glyphs in the prompt
if [ -e /usr/share/git/completion/git-prompt.sh ]; then
	gitprompt='/usr/share/git/completion/git-prompt.sh'
else
	gitprompt=$HOME/.config/bash/git-prompt.sh
fi

if [ -f $gitprompt ]; then
	source $gitprompt	
fi

if fc-list | grep -q 'Nerd' ; then
	NERD_FONT_AVAILABLE='yes'
fi
# ----- Functions -----

function print_if_nerd {
	if [ -z "$IGNORE_NERD_FONT" -a -n "$NERD_FONT_AVAILABLE" ] ; then
		echo -n "$1"
	elif [ -z "${@:2}" ]; then
		return 0
	else 
		echo -n "${@:2}"
	fi
	return 0
}

# ----- Variables -----
os_name=$(
	if [ -e /etc/os-release ]; then
		source /etc/os-release
		echo -n "$ID"
	elif [ -e /usr/lib/os-release ]; then
		source /usr/lib/os-release
		echo -n "$ID"
	else
		echo "unknown" >&2
	fi
)

os_icon=$(
	case $os_name in
		fedora) echo -n "󰣛 ";;
		raspberrypi) echo -n " " ;;
		arch) echo -n "󰣇 " ;;

		alpaquita)  echo -n " " ;;
		alpine)  echo -n " " ;;
		almaLinux)  echo -n " " ;;
		amazon)  echo -n " " ;;
		android)  echo -n " " ;;
		arch)  echo -n " " ;;
		artix)  echo -n " " ;;
		cachyOS)  echo -n " " ;;
		centOS)  echo -n " " ;;
		debian)  echo -n " " ;;
		dragonFly)  echo -n " " ;;
		emscripten)  echo -n " " ;;
		endeavourOS)  echo -n " " ;;
		fedora)  echo -n " " ;;
		freeBSD)  echo -n " " ;;
		garuda)  echo -n "󰛓 " ;;
		gentoo)  echo -n " " ;;
		hardenedBSD)  echo -n "󰞌 " ;;
		illumos)  echo -n "󰈸 " ;;
		kali)  echo -n " " ;;
		linux)  echo -n " " ;;
		mabox)  echo -n " " ;;
		macos)  echo -n " " ;;
		manjaro)  echo -n " " ;;
		mariner)  echo -n " " ;;
		midnightBSD)  echo -n " " ;;
		mint)  echo -n " " ;;
		netBSD)  echo -n " " ;;
		nixOS)  echo -n " " ;;
		nobara)  echo -n " " ;;
		openBSD)  echo -n "󰈺 " ;;
		openSUSE)  echo -n " " ;;
		oracleLinux)  echo -n "󰌷 " ;;
		pop)  echo -n " " ;;
		raspbian)  echo -n " " ;;
		redhat)  echo -n " " ;;
		redHatEnterprise)  echo -n " " ;;
		rockyLinux)  echo -n " " ;;
		redox)  echo -n "󰀘 " ;;
		solus)  echo -n "󰠳 " ;;
		suse)  echo -n " " ;;
		ubuntu)  echo -n " " ;;
		unknown)  echo -n " " ;;
		void)  echo -n " " ;;
		windows)  echo -n "󰍲 " ;;
		*) echo -n "󱩛 " ;;
	esac
)

# ------- ANSI SGR Sequences -------
if [ -f $HOME/.config/bash/ansi-sgr.sh ] ; then
	source $HOME/.config/bash/ansi-sgr.sh
fi

# Prompt command:
function set_prompt {
	# get last's command exit code before running anything
	LAST_COMMAND_EXIT=$?

	# ------------------------ Set glyphs if nerdfont ------------------------ #
	dir_glyph=$(print_if_nerd ' ')
	git_glyph=$(print_if_nerd ' ')
	os_glyph=$(print_if_nerd "$os_icon" "($os_name) ")
	nix_glyph=$(print_if_nerd ' ' 'Nix')
	# python_glyph=$(print_if_nerd ' ') # 󱔎 <-- cute!
	python_glyph=$(print_if_nerd '󱔎 ')

	# ----------------------- Show OS, user & hostname ----------------------- #
	# uncomment this line to show the os icon (currently just arch/raspberrypi)
	# PS1="\[\e[1;95m\][\[\e[0;95m\]${os_glyph}\[\e[1;95m\]\u@\h]"
	PS1="${_magenta}${_bold}[${_rsts}${os_glyph}${_italic}\u@\h${_rsts}${_bold}]" 
	# PS1="\[\e[1;95m\][\u@\h]" 
	
	# ------------------------- Shell name and level ------------------------- #
	if [ $SHLVL -gt 1 ] || [ -z "$(expr "$SHELL" : '.*\(bash\)')" ] ; then
		# PS1="$PS1\[\e[1;37m\][$(echo "$(basename $SHELL)" | tr a-z A-Z) lvl $SHLVL]"
		PS1="$PS1$_bold$_white_dim[$_italic$(basename $SHELL | tr a-z A-Z)$_rst$_italic lvl $SHLVL$_rst$_bold]"
	fi
	
	# --------------------------- Show working dir --------------------------- #
	# PS1="$PS1\[\e[1;94m\][$dir_glyph\w]"
	PS1="$PS1$_blue$_bold[$dir_glyph$_rst$_italic\w$_rst$_bold]"
	# -------------------------- Show python's VENV -------------------------- #
	if [ -n "$VIRTUAL_ENV" ] ; then
		python_version="$(python -c 'from sys import version_info as ver ; print(f"{ver[0]}.{ver[1]}")')"
		venv_root="$(basename "$(dirname "${VIRTUAL_ENV}")")/$(basename $VIRTUAL_ENV)"
		# PS1="$PS1\[\e[1;92m\][\[\e[0;92m\]${python_glyph}\[\e[1;92m\]${venv_root} ($python_version)]"
		PS1="$PS1$_green$_bold[$_rst${python_glyph}$_italic${venv_root} ($python_version)$_bold]"
	fi

	# ------------------------ Show if inside Nixenv ------------------------- #
	# TODO: Need to improve this. Maybe add the location of the temporary nix store
	#   - https://github.com/NixOS/nix/issues/6677
	#   - https://nix.dev/manual/nix/2.18/command-ref/nix-shell#env-IN_NIX_SHELL
	# if expr "$(env)" : ".*\/nix\/store" > /dev/null ; then 
	# if echo "$(env)" | grep -q '/nix/store' ; then
	if [ -n "$IN_NIX_SHELL" ] ; then 
		# PS1="$PS1\[\e[1;96m\][$nix_glyph]"
		PS1="$PS1$_bold$_cyan[$_rst$nix_glyph$_bold]"
	fi

	# --------------------------- Git repo status ---------------------------- #
	# `__git_ps1` opts:
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWSTASHSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWCONFLICTSTATE=1
	GIT_PS1_SHOWUPSTREAM="auto" # can also be verbose,name,legacy,git,svn
	# GIT_PS1_SHOWCOLORHINTS=1 # this adds colors to the output of __git_ps1
	if command -v __git_ps1 >/dev/null ; then
		# PS1="$PS1$(__git_ps1 "\[\e[1;33m\][\[\e[0;33m\]${git_glyph}\[\e[1;33m\]%s\[\e[1;33m\]]")"
		git_status=$(__git_ps1 "$_yellow$_bold[$_rst${git_glyph}$_italic%s$_rst$_bold$yellow]")
		PS1="$PS1$git_status"
	fi

	# ------------------------- Last command status -------------------------- #
	if [ $LAST_COMMAND_EXIT -eq 0 ]; then
		# PS1="${PS1}\n\[\e[1;92m\]$promptchar"
		PS1="${PS1}\n$_green$_bold$promptchar"
	else
		# PS1="${PS1}\n\[\e[0;31m\]${LAST_COMMAND_EXIT}\[\e[1;91m\]$promptchar"
		PS1="${PS1}\n$_red_dim$_rst$LAST_COMMAND_EXIT$_bold$_red$promptchar"
	fi
	
	# space & reset colors
	# PS1="$PS1\[\e[m\] "
	PS1="$PS1$_reset_all "
}

# PS2 is the thing you get when inserting multi-line commands
# PS2="\[\e[1;0m\]$promptchar\[\e[1;90m\]$promptchar\[\e[1;0m\]"
PS2="$_reset_all$_bold$promptchar$_faint$_black${promptchar}$_reset_all"

PROMPT_COMMAND=set_prompt
# if [ -f $HOME/.config/bash/custom-set-prompt.sh ] ;then 
# 	PROMPT_COMMAND='source $HOME/.config/bash/custom-set-prompt.sh'
# else 
# 	PROMPT_COMMAND=set_prompt
# fi
