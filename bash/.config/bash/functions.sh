# Bash Function To Extract File Archives Of Varios Types,
#                      (taken from some stackexchange guy)
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

open() {
	if test $1 ; then
		xdg-open $1 2>&1 > /dev/null & disown 
	else
		echo "Need to pass at least one argument, dwag"
		return 1
	fi
}

encrypt () {
	if [ "$1" = "s" -o "$1" = "sym" -o "$1" = "symmetric" ] ; then
		echo "Using symmetric encryption..."
		if [ -d "$2" ] ; then 
			tar cf "${2}.tar" $2 && gpg -c "${2}.tar" || echo -e "\e[31mERROR\e[m"
			return $?
		elif [ -f "$2" ] ; then
			gpg -c "${2}" || echo -e "\e[31mERROR\e[m"
			return $?
		else
			echo -e "\e[31mERROR: \e[m file not supported"
			return 1
		fi
	elif [ "$1" = "a" -o "$1" = "asym" -o "$1" = "asymmetric" ]; then
		echo "Using asymmetric encryption..."
		echo -e "\e[33mWARNING: \e[m not implemented yet..."
		return 1
	else
		echo -e "\e[31mERROR: \e[m action not supported"
		return 1
	fi
}