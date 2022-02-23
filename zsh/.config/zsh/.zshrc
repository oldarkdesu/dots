# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/history
HISTSIZE=10000
SAVEHIST=10000000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/haxor/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Bash Function To Extract File Archives Of Various Types
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# open a markdown file in zathura
mdzath() {
	cat $1 | pandoc -f markdown -t pdf | zathura -
}

PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/bin/scripts"

# set bat as the manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias ls='ls --color=auto'
alias pac='doas pacman --needed --color=auto -S'
alias pacup='doas pacman --color=auto -Syu'
alias pacre='doas pacman --color=auto -Rns'
alias la='ls --color=auto -A --group-directories-first'
alias ll='ls --color=auto -govAh --group-directories-first'
alias mkdir='mkdir -pv'
alias paru='paru --sudo /usr/bin/doas'
alias parup='paru -Syu --sudo /usr/bin/doas'
alias x='startx'
alias o='xdg-open'
alias e='nvim'
export QT_QPA_PLATFORMTHEME=qt6ct

colorscript random # | lolcat
