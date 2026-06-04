#!/usr/bin/env sh
set -o posix

# The IFS has two main uses.
# one is to separate each command in $* (but not in $@)
DEFAULT_IFS=$IFS
echo $0
myfunc () {
	echo '$* and $@ test'
	echo "All arguments (using \$@): $@"
	echo "All arguments (using \$*): $*"
	echo '                           '$*
}

IFS='|'

myfunc the cat sat in the hat