# ------- ANSI Color sequences -------
# CSI with ANSI control codes for SOH and STX. This supposedly helps bash calculate the prompt's width
_cpre="\001\033[" _cpost="m\002" ; _cpre='\033[' _cpost='m'

# Reset everything except foreground/background color:
# (22: normal intensity) (23: not italic/blackletter) (24: not underlined)
# (25: no blink) (27: not reversed) (28: no conceal) (29: not striked)
_reset_keepcolor='\033[22;23;24;25;27;28;29m'
_reset_all='\033[0m'
_rsts="$_reset_keepcolor" # soft reset
_rsth="$_reset_all" # hard reset
_rst="$_reset_keepcolor"

# font rendering codes
_bold="${_cpre}1$_cpost"
_faint="${_cpre}2$_cpost"
_italic="${_cpre}3$_cpost"	
_underline="${_cpre}4$_cpost"
_blink="${_cpre}5$_cpost" _blink_slow="$_blink"
_blink_rapid="${_cpre}6$_cpost"
_invert="${_cpre}7$_cpost"
_conceal="${_cpre}8$_cpost"
_strike="${_cpre}9$_cpost"

styles=(bold faint italic underline blink fastblink invert conceal strike)
for n in {1..9} ; do
	eval ""_${styles[$n]}=\${_cpre}${n}\${_cpost}""
done

# Color codes
# variables for sequences in the form of  _<color>_<intensity>_<bg/fg>
colors=(black red green yellow blue magenta cyan white "" default)
for n in {0..7} 9 ; do 
	eval "_${colors[$n]}_dim_fg=\${_cpre}3${n}\${_cpost}"
	eval "_${colors[$n]}_bright_fg=\${_cpre}9${n}\${_cpost}" 
	eval "_${colors[$n]}_dim_bg=\${_cpre}4${n}\${_cpost}"
	eval "_${colors[$n]}_bright_bg=\${_cpre}10${n}\${_cpost}"
	# fg is implied
	eval "_${colors[$n]}_dim=\${_cpre}3${n}\${_cpost}"
	eval "_${colors[$n]}_bright=\${_cpre}9${n}\${_cpost}" 
	# bright is implied
	eval "_${colors[$n]}=\${_cpre}3${n}\${_cpost}"

done

function _color_test {
	_str=$"${_rst}Normal "
	_str=$"${_str}${_rst}${_bold}Bold "
	_str=$"${_str}${_rst}${_faint}Faint "
	_str=$"${_str}${_rst}${_italic}Italic "
	_str=$"${_str}${_rst}${_underline}Underline "
	_str=$"${_str}${_rst}${_blink}Blink "
	_str=$"${_str}${_rst}${_blink_rapid}FastBlink "
	_str=$"${_str}${_rst}${_invert}Inverted "
	_str=$"${_str}${_rst}${_conceal}Concealed "
	_str=$"${_str}${_rst}${_strike}Strike "
	_str=$"${_str}${_reset_all}"

	echo "ANSI SGR SEQUENCE TEST"
	echo "     [0]    [1]  [2]   [3]    [4]       [5]   [6]       [7]      [8]       [9]   "
	echo "     Normal Bold Faint Italic Underline Blink FastBlink Inverted Concealed Strike"
	echo "     ------|----|-----|------|---------|-----|---------|--------|---------|------"
	for c in {0..7}; do
		echo -e  "\e[3${c}m[3$c] $_str\e[0m"
		echo -e  "\e[9${c}m[9$c] $_str\e[0m"
	done
}