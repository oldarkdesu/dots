#!/usr/bin/env sh

_ids="personal oldarkdesu university"

for id in $_ids ; do
	if [ ! -f ~/.ssh/gh.$id ] ; then
		echo "[RUNNING ssh-keygen -f ~/.ssh/gh.$id -C '' -P '' ]"
		ssh-keygen -f ~/.ssh/gh.$id -C '' -P ''
	else
		echo "File ~/.ssh/gh.$id already exist, skiping. "
	fi
done
