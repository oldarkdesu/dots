#!/usr/bin/env sh

if command -v doas >/dev/null && [ -f /etc/doas.conf ] 2>&1 ; then
	_SUCMD=doas
elif command -v sudo >/dev/null ; then
	_SUCMD=sudo
fi

[ -z $_SUCMD ] && echo -e "\e[1;93m\e[0m Warning! Neither 'sudo' nor 'doas' is available." >&2

$_SUCMD echo "Printing this with priviliges (using $_SUCMD)"
