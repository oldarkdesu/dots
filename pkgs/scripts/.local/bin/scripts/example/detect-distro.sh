#!/usr/bin/env sh

if [ -f /etc/os-release ] ; then
	distro=$(. /etc/os-release && echo "$ID")
else
	echo "No /etc/os-release file" >&2
	exit 1
fi

case "$distro" in
	ubuntu|debian)
		echo "your package manager is apt..."
		;;
	arch)
		echo "your package manager is pacman..."
		;;
	fedora)
		echo "your package manager is dnf..."
		;;
	*)
		echo "unknown distro..." >&2
		exit 1
		;;
esac
