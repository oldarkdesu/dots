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
	echo "WARNING: this function is a work in progress" >&2
	if [ "$1" = "s" -o "$1" = "sym" -o "$1" = "symmetric" ] ; then
		echo "Using symmetric encryption..."
		if [ -d "$2" ] ; then 
			printf 'tar cf "%s" $2 && gpg -c "%s"' "${2}.tar" "${2}.tar"
			tar cf "${2}.tar" $2 && gpg -c "${2}.tar" || EXT_VAL=$? ; echo -e "\e[31mERROR ($EXT_VAL)\e[m"
			return $EXT_VAL
		elif [ -f "$2" ] ; then
			printf 'gpg -c "%s"' ${2}
			gpg -c "${2}" || EXT_VAL=$? ; echo -e "\e[31mERROR ($EXT_VAL)\e[m"
			return $EXT_VAL
		else
			echo -e "\e[31mERROR:\e[m currently this can only encrypt folders :P"
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

archive () {
	if [ $# > 2] ; then 
		return 1 
	fi
	if [ -n "$2" ] ; then
		from="$1"
		to="$2"
	else
		from="$1"
		to="$(expr $1 : '\(.*\)/').tar" # this converts `some/directory/some/where/` into `some/directory/some/where`
	fi
	echo "Archiving \`$from\` into $to..."
	tar --exclude=.git --exclude=node_modules -cvf $to $from
}

unarchive () {
	tar -xvf $1
}