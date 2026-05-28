#
# ~/.bashrc
#

if [ -f ~/.bashrc.old ] ; then
	source ~/.bashrc.old
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History settings
[ -d ${XDG_DATA_HOME:-$HOME/.local/share}/bash ] || mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/bash"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash/bash_history"
export HISTIGNORE="clear:history:[bf]g:exit:date:* --help"
export HISTCONTROL=ignoreboth
HISTFILESIZE=100000
HISTSIZE=10000
# reminder that I have a `history -a` in ~/.config/bash/prompt.sh to save a command to the history as soon as it is run

if [ -f /usr/share/git/completion/git-completion.bash ] ; then
	source /usr/share/git/completion/git-completion.bash
else
	source ~/.config/bash/fallbacks/git-completion.bash
fi

# starship prompt
# eval "$(starship init bash)"

source ~/.config/bash/prompt.sh
source ~/.config/bash/functions.sh
source ~/.config/bash/aliases.sh

# pnpm
export PNPM_HOME="/home/abi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
