#
# ~/.bashrc
#

if [ -f ~/.bashrc.old ] ; then
	source ~/.bashrc.old
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash/bash_history"
HISTFILESIZE=10000000
HISTSIZE=100000000

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
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
