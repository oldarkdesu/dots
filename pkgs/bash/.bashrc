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

# save to history as soon as a command is enterd
PROMPT_COMMAND="history -a ; $PROMPT_COMMAND"


# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
