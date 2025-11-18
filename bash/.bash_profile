#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


# ENVIRONMENT SETUP
os_name=$(source /etc/os-release && echo "$ID" || echo 'unknown')
export PATH="$HOME/.local/bin:$HOME/.local/bin/scripts:$HOME/.local/bin/scripts/$os_name:$PATH"

# XDG dirs Autism:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Switching this to default location since this folder is used for everything,
# not just the configuration, so I think that having the kuys, configuration and
# database in there is a little bit messy :P
# export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npmrc"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export PNPM_HOME="/home/abi/.local/share/pnpm"

export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"

export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# I love colors
export LESS='-Ri --use-color -Dd+M-$Du+C-$DS+Y-'
export MANROFFOPT='-c' # this fixes coloring in arch linux, I still dont fully understand why 
export MICRO_TRUECOLOR=1
export BAT_THEME='ansi'
if [ -z "$LS_COLORS" ] ; then
	eval "$(TERM=color dircolors --sh)"
fi

# Pixel perfect scrolling ffx
export MOZ_USE_XINPUT2=1

# Set text editor
export EDITOR='micro'
export VISUAL='micro'

# Now some important stuff...

# Start the ssh-agent (On arch there's the ssh-agent user service)
if [ $os_name != 'arch' -a -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent -s)" > /dev/null
fi

# If on tty1, run hyprland
# I am told this is a bad idea. Commenting until further examination is conducted
if [ "$(tty)" = "/dev/tty1" ]; then
    export XINITRC="$HOME/.config/x/xinitrc"
    export XAUTHORITY="$HOME/.cache/Xauthority"
    exec startx
    # exec Hyprland
fi
