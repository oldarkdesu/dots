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

# ----- Functions -----
function print_if_nerd {
	if [ -z "$IGNORE_NERD_FONT" ] && fc-list | grep -q 'Nerd' ; then
		echo -n "$1"
	elif [ -z "${@:2}" ]; then
		return 0
	else 
		echo -n "${@:2}"
	fi
	return 0
}
function get_nerd_icon {
	case $1 in
		rpi) echo -n "" ;;
		arch) echo -n "󰣇" ;;
		*) echo -n "󱩛" ;;
	esac
}
# TODO: need to move this thing somewhere else...
function find_python_venv {
	_debug=yes
	dir="$PWD"
	project_pyvenv=''
	while [ "$dir" != "/" ]; do
		[ -n "$_debug" ] && echo "looking inside DIRECTORY $dir ..."
		for child in $(ls -a) ; do
			# echo -n "testing FILE $child/pyenv.cfg ..."
			if [ -d "$child" -a -f "$child/pyvenv.cfg" ] ; then
				[ -n "$_debug" ] && echo -e "\nProject root: $dir"
				[ -n "$_debug" ] && echo "venv root: $(basename $dir)/$child"
				echo "$(basename $dir)/$child"
				return 0
			fi
		done
		dir="$(dirname "$dir")"
	done
	# echo "No project root with venv found"
	return 1
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
dir_glyph=$(print_if_nerd ' ')
git_glyph=$(print_if_nerd ' ')
os_glyph=$(print_if_nerd "$(get_nerd_icon $os_ name) " "($os_name) ")
nix_glyph=$(print_if_nerd ' ' 'Nix')
python_glyph=$(print_if_nerd ' ') # 󱔎 <-- cute!

# Prompt command:
function set_prompt {
	# get last's command exit code before running anything
	LAST_COMMAND_EXIT=$?
	
	# Show OS, User & Machine
	# uncomment this line to show the os icon (currently just arch/raspberrypi)
	PS1="\[\e[1;95m\][\[\e[0;95m\]${os_glyph}\[\e[1;95m\]\u@\h]" 
	# PS1="\[\e[1;95m\][\u@\h]" 
	
	
	# Shell name and level
	if [ $SHLVL -gt 1 ] || [ -z "$(expr "$SHELL" : '.*\(bash\)')" ] ; then
		PS1="$PS1\[\e[1;37m\][$(echo "$(basename $SHELL)" | tr a-z A-Z) lvl $SHLVL]"
	fi
	
	# Show Working dir
	PS1="$PS1\[\e[1;94m\][$dir_glyph\w]"
	
	# Show python virtual environment
	if [ -n "$VIRTUAL_ENV" ] ; then
		python_version="$(python -c 'from sys import version_info as ver ; print(f"{ver[0]}.{ver[1]}")')"
		venv_root="$(basename "$(dirname "${VIRTUAL_ENV}")")/$(basename $VIRTUAL_ENV)"
		PS1="$PS1\[\e[1;92m\][\[\e[0;92m\]${python_glyph}\[\e[1;92m\]${venv_root} ($python_version)]"
	fi

	# Nix shell
	# TODO: Need to improve this. 
	#   - https://github.com/NixOS/nix/issues/6677
	#   - https://nix.dev/manual/nix/2.18/command-ref/nix-shell#env-IN_NIX_SHELL
	# if expr "$(env)" : ".*\/nix\/store" > /dev/null ; then
	# if echo "$(env)" | grep -q '/nix/store' ; then
	if [ -n "$IN_NIX_SHELL" ] ; then 
		PS1="$PS1\[\e[1;96m\][$nix_glyph]"
	fi
	# Git repo status
	# `__git_ps1` opts:
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWSTASHSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWCONFLICTSTATE=1
	GIT_PS1_SHOWUPSTREAM="auto" # can also be verbose,name,legacy,git,svn
	# GIT_PS1_SHOWCOLORHINTS=1 # this adds colors to the output of __git_ps1
	
	if [ -f "$gitprompt" ]; then
		PS1="$PS1$(__git_ps1 "\[\e[1;35m\][\[\e[0;35m\]${git_glyph}\[\e[1;35m\]%s]")"
	fi
	# was last command successful?
	if [ $LAST_COMMAND_EXIT -eq 0 ]; then
		PS1="${PS1}\n\[\e[1;92m\]$promptchar"
	else
		PS1="${PS1}\n\[\e[0;31m\]${LAST_COMMAND_EXIT}\[\e[1;91m\]$promptchar"
	fi
	
	# space & reset colors
	PS1="$PS1\[\e[m\] "
}

# PS2 is the thing you get when inserting multi-line commands
PS2="\[\e[1;0m\]$promptchar\[\e[1;90m\]$promptchar\[\e[1;0m\]"

PROMPT_COMMAND=set_prompt
