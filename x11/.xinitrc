#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap

[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# remap buttons on Trackball for left hand use
xinput set-button-map "Kensington Expert Mouse" 2 3 1 4 5 6 7 8 9

# increase trackball speed (not acceleration!)
xinput set-prop "Kensington Expert Mouse" "Coordinate Transformation Matrix" 1, 0, 0, 0, 1, 0, 0, 0, 0.6

# Configure screens
exec /home/haxor/.local/bin/scripts/vertical-left-middle.sh &

volumeicon &
lxsession &
dunst &
picom --experimental-backends &
flameshot &
qtile start
