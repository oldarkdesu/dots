#!/usr/bin/env sh

if [ $# -gt 0 -a $1 = '--remove' -o $1 = '--uninstall' ] ; then
	files="./fonts/uosc* ./scripts/uosc ./scripts/thumbfast.lua ./script-opts/thumbfast.conf"
	command -v trash >/dev/null && trash $files || rm -rf $files
	exit
elif [ $# -gt 0 ] ; then
	echo 'Option not recognized :P' >&2
	exit 1
fi

uosc_release=https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip

# fail if encounter an error, be silent but output errors, follow links
curl -fsSL $uosc_release > ./uosc.zip
unzip ./uosc.zip
command -v trash >/dev/null && trash ./uosc.zip || rm -rf ./uosc.zip

git clone https://github.com/po5/thumbfast.git
mkdir -p fonts scripts script-opts
cp ./thumbfast/thumbfast.lua ./scripts
cp ./thumbfast/thumbfast.conf ./script-opts/
command -v trash >/dev/null && trash -f thumbfast || rm -rf thumbfast


