#!/usr/bin/env sh

if [ $# -gt 0 -a "$1" = "--uninstall" -o "$1" = "--remove" ] ; then
	files="$(echo ./fonts/modernz-icons.ttf ./script-opts/thumbfast.conf ./script-opts/modernz{.conf,-locale.json} ./scripts/{modernz.lua,thumbfast.lua} )"
	command -v trash >/dev/null && trash -f $files ModernZ thumbfast || rm -rf $files ModernZ thumbfast
	exit
elif [ $# -gt 0 ] ; then
	echo "Option not recognized :P" >&2
	exit 2
fi


if ! command -v git >/dev/null ; then
	echo 'Command `git` is not available' >&2
	exit 1
elif ls -A1 . | grep -e '^ModernZ$' ; then
	echo 'Directory `ModernZ` or `thumbfast` already exist. Use' $0 '--remove'
	exit 1
fi

mkdir -p fonts scripts script-opts

git clone https://github.com/Samillion/ModernZ.git
git clone https://github.com/po5/thumbfast.git

cp ./ModernZ/modernz-icons.ttf ./fonts/
cp ./ModernZ/modernz.conf ./ModernZ/extras/locale/modernz-locale.json ./script-opts/
cp ./ModernZ/modernz.lua ./scripts/

cp ./thumbfast/thumbfast.lua ./scripts
cp ./thumbfast/thumbfast.conf ./script-opts/