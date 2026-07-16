#!/usr/bin/env sh

if [ "$(whoami)" != 'root' ] ; then
	echo Not running in a priviliged shell. Exiting. >&2
	exit 1
fi

cp /usr/lib/udev/hwdb.d/99-tartarus-v2.hwdb ./99-tartarus-v2.hwdb.bak
cp ./99-tartarus-v2.hwdb /usr/lib/udev/hwdb.d/99-tartarus-v2.hwdb

systemd-hwdb update
udevadm trigger