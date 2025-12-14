#!/usr/bin/env sh

_ids="personal oldarkdesu university"

for id in $_ids ; do
	echo "RUNNING ssh-keygen -f ~/.ssh/gh.$id -C '' -P '' "
	ssh-keygen -f ~/.ssh/gh.$id -C '' -P ''
done