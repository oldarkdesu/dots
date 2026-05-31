#!/usr/bin/env sh

# check if:
# 	- File descriptor (output) is stdouts

COLOR=
if [ -t 1 ] && [ "$TERM" != "dumb" ] && [ -z "$NOCOLOR" ] ; then
	COLOR=yes
fi

color_error=$'\e[31m'
color_success=$'\e[32m'
color_warning=$'\e[33m'


if [ ! -t 1 ] ; then
	echo 'FD is not 1'
elif [ ! "$TERM" != 'dumb' ] ; then
	echo 'TERM is dumb'
elif [ ! -z "$NOCOLOR" ] ; then
	echo "NOCOLOR is non-empty ($NOCOLOR)"
fi

echo ${COLOR:+$color_success} Green ${COLOR:+$color_warning} Yellow ${COLOR:+$color_error} Red ;
exit
