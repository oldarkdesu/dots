#!/usr/bin/env sh

files="tartarus-v2.hwdb trackball.hwdb"
dest="/etc/udev/hwdb.d"

if [ "$(whoami)" != 'root' ] ; then
	echo Not running on a priviliged shell. Exiting. >&2
	# exit 1
fi

# Note to self: Don't touch the /usr/lib directory, apparently is for system files only. Configuration should go on /etc
for f in $files ; do
	if [ -f ./${f}.hwdb ] ; then
		echo "File \`$f\` not found in this directory" >&2
		continue
	fi
	echo "Copying $f into $dest/..."
	cp /etc/udev/hwdb.d/${f} ./${f}.bak
	cp ./${f} /etc/udev/hwdb.d/${f}

done

echo "Applying settings..."
systemd-hwdb update && udevadm trigger && echo Done