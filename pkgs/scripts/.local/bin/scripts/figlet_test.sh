#!/usr/bin/env bash

# make sure figlet is installed/available
if ! command -v figlet 2>&1 >/dev/null ; then
	echo 'Command `figlet` is not available' >&2
	exit 1
fi

for f in /usr/share/figlet/*.tlf /usr/share/figlet/fonts/*.flf ; do
	echo $f: ; figlet -t -f $f ${1:-whatever} ${@:2}
done