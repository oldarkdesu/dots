# functions.sh

open() {
	if [ -n "$1" ] ; then
		xdg-open $1 2>&1 > /dev/null & disown 
	else
		echo "Need to pass at least one argument, dwag"
		return 1
	fi
}

_encrypt () {
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
	if [ $# > 2 ] ; then 
		return 1 
	fi
	if [ -n "$2" ] ; then
		from="$1"
		to="$2"
	else
		from="$1"
		to="$(expr $1 : '\(.*\)/').tar" # this converts `some/directory/` into `some/directory`
	fi
	echo "Archiving \`$from\` into $to..."
	tar --exclude=.git --exclude=node_modules -cvf $to $from
}

unarchive () {
	tar -xvf $1
}

check_sha256() {
	# check if sha256sum is available
	command -v sha256sum 2>&1 > /dev/null || ( echo 'Cannot find command `sha256sum`' ; return 2 )
	# verify that exactly 2 arguments were passed (and they're of non-zero length)
	[ -z "$1" -o -z "$2" -o $# -ne 2 ] && ( echo "Usage: check_sha256 FILE SHA256_HASH" ; return 3 )

	file_sum=$(
		echo "[check_sha256] Attempting to hash $1"
		hash=$(sha256sum "$1")
		EXT_VAL=$? 
		[ $EXT_VAL -eq 0 ] || ( echo -e "$hash\n[check_sha256] error while running sha256sum" ; return $EXT_VAL )

		echo $hash | awk '{print $1}' | tr a-z A-Z
	)
	if [ "$file_sum" = "$2" ] ; then
		echo "[check_sha256] Success!" 
		return 0
	else
		echo "[check_sha256] Fail!"
		return 1
	fi
}


flash_iso_DESTRUCTIVE () {
	confirm () {
		local prompt="${1:-"Are you sure?"}"
		local response

		while true ; do
			echo -n "$prompt (yes/no): "
			read response
			response="$(echo $response | tr A-Z a-z)"
			case "$response" in 
				y | ye | yes ) return 0 ;;
				n | no ) return 1 ;;
			esac
		done
		echo ERROR
		return 1
	}
	if [ $# -ne 2 ] ; then
		echo "Usage: flash_iso PATH_TO_ISO DEVICE"
		return 1
	fi

	if ! confirm "IF=$1 ; OF=$2"; then
		echo "Don't waste my time next time :/"
		return 1
	fi
	# check for doas/sudo
	command -v sudo 2>&1 >/dev/null                          && SUCMD=sudo
	command -v doas 2>&1 >/dev/null && [ -f /etc/doas.conf ] && SUCMD=doas
	[ -z $SUCMD ] && echo -e '\e[1;93mWarning! \e[0mNeither `sudo` or `doas` is available.' >&2

	echo "$SUCMD dd bs=4M if=\"$1\" of=\"$2\" conv=fsync oflag=direct status=progress"
	$SUCMD dd bs=4M if="$1" of="$2" conv=fsync oflag=direct status=progress
}

foo () { echo -e "mission failed successfully \n\$#: $#" ; return 69 ; }
