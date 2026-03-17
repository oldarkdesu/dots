#!/usr/bin/env bash
# this works at least on arch linux
for f in /usr/share/figlet/*.tlf /usr/share/figlet/fonts/*.flf ; do
	echo $f: ; figlet -t -f $f ${1:-whatever} ${@:2}
done