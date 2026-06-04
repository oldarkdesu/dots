for l in A e a i u ; do
	echo -ne "$l \n"
	case "$l" in
		[A-Z])
			echo "It's a lowercase letter."
			;; # exits the case-in block
		[a-z])
			echo "It's a lowercase letter."
			;;& # Continues testing the patterns below
		[aeo])
			echo "It's an open vowel"
			;& # falls-through the next case without checking the pattern
		[aeiou])
			echo "It's a vowel."
			;;& # Continues testing the patterns below
		a)
			echo "It is exactly the letter 'a'."
			;;
		*)
			echo "Fallback block reached"
	esac
done