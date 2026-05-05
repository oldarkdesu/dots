#!/usr/bin/env sh

case $1 in
	screenshot)
		xfce4-screenshooter \
			--fullscreen \
			--clipboard \
			--mouse \
			--save "$(xdg-user-dir PICTURES)/screenshots/$(date +%Y-%m-%d_%H-%M-%S%z)"
		;;
	screenshot-region)
		xfce4-screenshooter \
			--region \
			--clipboard \
			--save "$(xdg-user-dir PICTURES)/screenshots/$(date +%Y-%m-%d_%H-%M-%S%z)"
		;;
	*)
		echo "Command $1 not found :P" >&2
		exit 1
esac
