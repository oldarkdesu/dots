#!/usr/bin/env sh

confirm() {
	echo "About to execute command: \`$@\` "
	echo -n "Are you sure? [y/N] "
	read -r response
	case "$(echo $response | tr A-Z a-z)" in
		yes|ye|y)
			$@
			;;
		*)
			(exit 1)
			;;
	esac
}
confirm ls -la1 ; err=$?
echo "Finished. exit_status=$err"
# exit $err

# could also write it like this:
confirm() {
	# optionally pass a confirmation string
	if [ $# -eq 0 ] ; then
		echo -n "Are you sure? [y/N]: "
	else
		echo -n $@ "[y/N]: "
	fi

	read -r response
	case "$(echo $response | tr A-Z a-z)" in
		yes|ye|y)
			return 0
			;;
		*)
			return 1
			;;
	esac
}

echo "About to execute a set of very dangerous commands, if you allow..."
if confirm "Continue?" ; then
	echo 'Just kidding :^)'
else
	echo "Operation aborted"
fi
