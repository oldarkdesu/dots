#!/usr/bin/env bash
# this works at least on arch linux
for f in /usr/share/figlet/* ; do _font=$(basename $f) ; echo $_font: ; figlet -d /usr/share/figlet -f $_font ${1:-whatever} ${@:2} ; done ; unset _font