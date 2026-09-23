#!/usr/bin/env sh

if [ "$(whoami)" != 'root' ] ; then
	echo Not running on a priviliged shell. Exiting. >&2
	exit 1
fi

# Note to self: Don't touch the /usr/lib directory, apparently is for system files only. Configuration should go on /etc
for f in tartarus-v2 trackball ; do
	cp /etc/udev/hwdb.d/${f}.hwdb ./${f}.hwdb.bak
	cp ./${f}.hwdb /etc/udev/hwdb.d/${f}.hwdb
done

systemd-hwdb update
udevadm trigger