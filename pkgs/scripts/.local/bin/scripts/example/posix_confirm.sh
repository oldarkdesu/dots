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
echo "Finished."
exit $err
