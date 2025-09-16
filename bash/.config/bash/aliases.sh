# reminder that you can use a backslash like `\ls` to run ls bypassing the alias


# check if doas/sudo
if command -v doas >/dev/null && [ -f /etc/doas.conf ] 2>&1 ; then
	SUCMD=doas
else
	SUCMD=sudo
fi
alias pls='$SUCMD'
alias edit='$EDITOR'
alias e=edit
alias ee='pls edit'

if [ -f  $HOME/.config/fastfetch/default.jsonc ]; then 
	alias fastfetch='fastfetch -c ~/.config/fastfetch/default.jsonc'
fi
alias fetch=fastfetch


# alias cat='bat' # probably a bad idea
# alias sudo='doas --' # probably a bad idea too
alias grep='grep --ignore-case --line-number --color=auto'
alias diff='diff --color=auto'
alias ls='ls --color=auto -AF --group-directories-first'
alias ll='ls -govhkN'
alias ip='ip -color=auto'
alias nnn='nnn -H'
alias n3=nnn
alias mkdir='mkdir -pv'
alias unimatrix='unimatrix -c cyan -f -s 96 -a -l AakkS'
alias trix=unimatrix
alias pwd='pwd -P'
alias tree='tree -FCal -I node_modules/ -I .git/ -I .venv/ -I venv/ --filelimit=25 --dirsfirst --charset=ascii -L 5 '
alias oyasumi='systemctl suspend'
alias reboot-user='systemctl soft-reboot'
alias boot2windows='systemctl reboot --boot-loader-menu=1 --boot-loader-entry=windows.conf'
alias rm="echo Are you sure? Use '\rm', or the full path i.e. '/bin/rm'"

# Debian/Ubuntu
alias aptup="pls bash -c 'apt update -y && apt upgrade -y && echo -e '\n\[\e[1;92m\][FINISHED]\[\e[0m\]'"
alias lsblk='lsblk -o NAME,LABEL,FSTYPE,MOUNTPOINTS,SIZE,FSAVAIL,FSUSED,FSUSE%,UUID,PARTUUID'
alias screencopy='scrcpy'
alias pn='pnpm'

alias codefp='flatpak run com.visualstudio.code'
alias showpath="echo $PATH | sed 's/:/\n/g'"
# function dont_use_clear {
# 	echo "Use ^L"
# 	return 1
# }
# alias clear='dont_use_clear'
