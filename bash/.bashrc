#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILESIZE=10000000
HISTSIZE=100000000

if [ -f /usr/share/git/completion/git-completion.bash ] ; then
	source /usr/share/git/completion/git-completion.bash
fi

source ~/.config/bash/prompt.sh
source ~/.config/bash/functions.sh
source ~/.config/bash/aliases.sh

# fetch # it gets annoying after a while

# starship prompt 
eval "$(starship init bash)"

# pnpm
export PNPM_HOME="/home/abi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
