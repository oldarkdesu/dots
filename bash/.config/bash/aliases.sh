# reminder that you can use a backslash like `\ls` to run ls bypassing the alias
# alias sudo='doas --'
alias pls='sudo'
# alias cat='bat' # probably a bad idea
alias grep='grep --ignore-case --line-number --color=auto'
alias diff='diff --color=auto'
alias ls='ls --color=auto -A --group-directories-first'
alias ll='ls -govAh'
alias ip='ip -color=auto'
alias nnn='nnn -H'
alias n3=nnn
alias mkdir='mkdir -pv'
# alias fetch='fastfetch -c ~/.config/fastfetch/default.jsonc'
alias fetch=fastfetch
alias unimatrix='unimatrix -c cyan -f -s 96 -a -l AakkS'
alias trix=unimatrix
alias pwd='pwd -P'
alias tree='tree -Cal -I node_modules/ -I .git/ -I .venv/ -I venv/ --filelimit=25 --filesfirst -L 5'
alias oyasumi='systemctl suspend'
alias boot2windows='systemctl reboot --boot-loader-menu=1 --boot-loader-entry=windows.conf'
alias rm="echo Are you sure? Use '\rm', or the full path i.e. '/bin/rm'"
alias e=micro
alias ee='sudo micro'

alias edit='$EDITOR'
alias aptup="sudo bash -c 'apt update -y && apt upgrade -y'"


alias lsblk='lsblk -o NAME,LABEL,FSTYPE,MOUNTPOINTS,SIZE,FSAVAIL,FSUSED,FSUSE%,UUID,PARTUUID'

alias screencopy='scrcpy'
alias pn='pnpm'

# alias code='flatpak run com.vscodium.codium'
alias codefp='flatpak run com.visualstudio.code'
alias showpath="echo $PATH | sed 's/:/\n/g'"
function dont_use_clear {
	echo "Use ^L"
	return 1
}
alias clear='dont_use_clear'
