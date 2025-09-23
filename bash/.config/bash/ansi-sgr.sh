# ------- ANSI Color sequences -------
# CSI with ANSI control codes for SOH and STX. This supposedly helps bash calculate the prompt's width
_cpre="\001\033[" _cpost="m\002"
# _cpre='\033[' _cpost='m'

# Reset everything except foreground/background color:
# (22: normal intensity) (23: not italic/blackletter) (24: not underlined)
# (25: no blink) (27: not reversed) (28: no conceal) (29: not striked)
# There's also 21 which some terminals use to disable bold, but it's actually 
# supposed to do double underlines
_reset_keepcolor="${_cpre}22;23;24;25;27;28;29${_cpost}"
_reset_all="${_cpre}0${_cpost}"
_rsts="$_reset_keepcolor" # soft reset
_rsth="$_reset_all" # hard reset
_rst="$_rsts"

# font rendering codes: _bold _italic etc.
styles=('' bold faint italic underline blink fastblink invert conceal strike)
for n in {1..9} ; do
	eval "_${styles[$n]}=\${_cpre}${n}\${_cpost}"
done

# Color codes
# variables for sequences in the form of  _<color>_<intensity>_<bg/fg>
colors=(black red green yellow blue magenta cyan white '' default)
for n in {0..7} 9 ; do 
	# 3n=dim-fg      4n=dim-bg 
	# 9n=bright-fg  10n=bright-bg

	eval "_${colors[$n]}_dim_fg=\${_cpre}3${n}\${_cpost}"
	eval "_${colors[$n]}_bright_fg=\${_cpre}9${n}\${_cpost}" 
	eval "_${colors[$n]}_dim_bg=\${_cpre}4${n}\${_cpost}"
	eval "_${colors[$n]}_bright_bg=\${_cpre}10${n}\${_cpost}"
	# fg is implied
	eval "_${colors[$n]}_dim=\${_cpre}3${n}\${_cpost}"
	eval "_${colors[$n]}_bright=\${_cpre}9${n}\${_cpost}" 
	# bright is implied
	eval "_${colors[$n]}=\${_cpre}9${n}\${_cpost}"
	eval "_${colors[$n]}_bg=\${_cpre}10${n}\${_cpost}"

done

function _sgr {
	if [ "$1" = 'help' -o "$1" = "--help" -o  "$1" = 'h' -o  "$1" = '-h' ] ; then
		echo "Usage: _sgr <styles> [[<foreground>]<background>]"
		echo "    [Styles]          | (dim)     [Color]      BRIGHT"
		echo "    b    bold         |   r         Red          R"
		echo "    f    faint        |   g        Green         G"
		echo "    i    italic       |   y        Yellow        Y"
		echo "    u    underlined   |   b         Blue         B"
		echo "    k    blink        |   m       Magenta        M"
		echo "    kk   fastblink    |   c         Cyan         C"
		echo "    x    invert       |   w        White         W"
		echo "    c    conceal      |   k        Black         K"
		echo "    s    striked      |   -       default        -"
		echo "    -    reset style"
		return 0
	fi 
	local opts i j out

	# process font style options (bfiulxcs)
	opts="$1"
	for ((i=0; i<${#opts}; i++)); do
		j=$((i+1))
		opt="${opts:$i:1}"
		if [ "$opt" = 'k' -a "${opts:$j:1}" = 'k' ] ; then 
			opt='kk'
			i=$(($i+1))
		fi
		case $opt in
			b) out="${out}${_bold}" ;;
			f) out="${out}${_faint}" ;;
			i) out="${out}${_italic}" ;;
			u) out="${out}${_underline}" ;;
			k) out="${out}${_blink}" ;;
			kk) out="${out}${_blink_rapid}" ;;
			x) out="${out}${_invert}" ;;
			c) out="${out}${_conceal}" ;;
			s) out="${out}${_strike}" ;;
			-) out="${out}${_rst}" ;;
			*) return 1;;
		esac
	done
	# process font color options (fg)
	opts=$2
	case "${opts:0:1}" in
		# bright
		R) out="${out}${_red_bright}" ;;
		G) out="${out}${_green_bright}" ;;
		Y) out="${out}${_yellow_bright}" ;;
		B) out="${out}${_blue_bright}" ;;
		M) out="${out}${_magenta_bright}" ;;
		C) out="${out}${_cyan_bright}" ;;
		W) out="${out}${_white_bright}" ;;
		K) out="${out}${_black_bright}" ;;
		# dim
		r) out="${out}${_red_dim}" ;;
		g) out="${out}${_green_dim}" ;;
		y) out="${out}${_yellow_dim}" ;;
		b) out="${out}${_blue_dim}" ;;
		m) out="${out}${_magenta_dim}" ;;
		c) out="${out}${_cyan_dim}" ;;
		w) out="${out}${_white_dim}" ;;
		k) out="${out}${_black_dim}" ;;
		-) out="${out}${_default}" ;;
		*) return 1;;
	esac

	# process font color options (bg)
	case "${opts:1:1}" in
		# bright
		R) out="${out}${_red_bright_bg}" ;;
		G) out="${out}${_green_bright_bg}" ;;
		Y) out="${out}${_yellow_bright_bg}" ;;
		B) out="${out}${_blue_bright_bg}" ;;
		M) out="${out}${_magenta_bright_bg}" ;;
		C) out="${out}${_cyan_bright_bg}" ;;
		W) out="${out}${_white_bright_bg}" ;;
		K) out="${out}${_black_bright_bg}" ;;
		# dim
		r) out="${out}${_red_dim_bg}" ;;
		g) out="${out}${_green_dim_bg}" ;;
		y) out="${out}${_yellow_dim_bg}" ;;
		b) out="${out}${_blue_dim_bg}" ;;
		m) out="${out}${_magenta_dim_bg}" ;;
		c) out="${out}${_cyan_dim_bg}" ;;
		w) out="${out}${_white_dim_bg}" ;;
		k) out="${out}${_black_dim_bg}" ;;
		-) out="${out}${_default_bg}" ;;
		*) ;;
	esac

	echo -en "$out${@:3}" 
	return 0
}

function _color_test {
	_str="${_rst}Normal"
	_str="${_str}${_rst} ${_bold}Bold"
	_str="${_str}${_rst} ${_faint}Faint"
	_str="${_str}${_rst} ${_italic}Italic"
	_str="${_str}${_rst} ${_underline}Underline"
	_str="${_str}${_rst} ${_blink}Blink"
	_str="${_str}${_rst} ${_blink_rapid}FastBlink"
	_str="${_str}${_rst} ${_invert}Inverted"
	_str="${_str}${_rst} ${_conceal}Concealed"
	_str="${_str}${_rst} ${_strike}Strike"
	_str="${_str}${_reset_all}"
	
	echo "ANSI SGR SEQUENCE TEST"
	echo  "    [0]    [1]  [2]   [3]    [4]       [5]   [6]       [7]      [8]       [9]   "
	echo  "    Normal Bold Faint Italic Underline Blink FastBlink Inverted Concealed Strike"
	echo  "    ------|----|-----|------|---------|-----|---------|--------|---------|------"
	if [ "$1" = "alt" ] ; then 
		for c in {0..7}; do
			echo -e  "3$c: \e[3${c}m$_str\e[0m"
		done
		for c in {0..7}; do
			echo -e  "9$c: \e[9${c}m$_str\e[0m"
		done
	else
		for c in {0..7}; do
			echo -e  "3$c: \e[3${c}m$_str\e[0m"
			echo -e  "9$c: \e[9${c}m$_str\e[0m"
		done
	fi
}