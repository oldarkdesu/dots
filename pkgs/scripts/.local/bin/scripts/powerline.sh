#!/usr/bin/env sh
set -o posix

pl_segment(){
	# Print powerline segment
	# args:
	#     1. (str) The message
	#     2. (int) The main color
	#     3. (int) (optional) the color of the next segment,

	local msg="$1"
	local color=$2
	local color_next=$3
	local str=''

	# a simple space character with the foreground set to the main color
	str="\e[0;4${color}m"

	# now, print the text using the main color, with the colors inverted and in bold
	str="$str \e[0;1;7;3${color}m${msg}"

	# finally, the final print the arrow in the main color, and if there is one, print its background using color_next
	# echo "debug:\e[0;3${color};${color_next:+4${color_next}}m\e[0m"
	str="$str \e[0;3${color}${color_next:+;4${color_next}}m\e[0m"
	echo -en "$str\e[0m"
}

map_color() {
	case "$1" in
		[0-9])          echo -n $1  ;;
		red)            echo -n '1' ;;
		green)          echo -n '2' ;;
		yellow)         echo -n '3' ;;
		blue)           echo -n '4' ;;
		magenta|purple) echo -n '5' ;;
		cyan)           echo -n '6' ;;
		gray)           echo -n '7' ;;
		contrast)       echo -n '9' ;;
		*)              return 1    ;;
	esac
}

help_str='powerline - output a powerline with provided text and colors
    Pass PAIRS of text and color like so:
        > powerline TEXT COLOR [TEXT COLOR]...
        > powerline $PWD green $(date +%F) purple $(date +%T) cyan'

if [ "$1" = '-h' -o "$1" = '--help' ] ; then
	echo $help_str
	exit
fi

# enforce 2 arguments at minimum
if [ -z "$1" -o -z "$2" ] ; then
	echo "Need at least 2 arguments with non-zero length" >&2
	echo "$help_str" >&2
	exit 1
fi


# loop through and print segments
while true ; do
	# if there's no remaining text to be displayed, break out of the loop
	if [ -z "$1" -o -z "$2" ] ; then
		break
	fi

	text="$1"

	color_main=$(map_color "${2:-contrast}")
	color_next=$(map_color "$4")

	if [ -z $color_main ] ; then
		echo $'\n'"Color \`$2' not recognized" >&2
		exit 1
	fi

	# print the segment
	pl_segment "$text" $color_main ${color_next:-}

	shift 2 2>/dev/null || break
done

