#!/usr/bin/env bash

for host in {rpi,fed,whitetop}.local ; do
	echo "Loggin onto $host"
	ssh $host "cd ~/dots ; git pull"
	echo "Logged out of $host"
done
