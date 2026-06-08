#!/usr/bin/env sh
set -o posix

# separate each argument in $* (but not in $@)
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