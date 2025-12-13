#!/usr/bin/env python3
import sys

def num_to_label(n: int) -> str:
    if n < 1:
        raise ValueError("Number must be >= 1")
    s = ""
    while n > 0:
        n -= 1
        n, r = divmod(n, 26)
        s = chr(r + 65) + s
    return s

def label_to_num(s: str) -> int:
    total = 0
    for ch in s.upper():
        if not ('A' <= ch <= 'Z'):
            raise ValueError("Invalid character (A–Z only)")
        total = total * 26 + (ord(ch) - 64)
    return total

def main():
    if len(sys.argv) != 2:
        print("Usage: cypher <number|label>")
        sys.exit(1)

    arg = sys.argv[1]

    if arg.isdigit():
        print(num_to_label(int(arg)))
    else:
        print(label_to_num(arg))

if __name__ == "__main__":
    main()
