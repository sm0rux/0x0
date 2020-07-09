#!/bin/bash

# 0x0 version 0.3-6
# Copyright (C) 2020 Pontus Falk

# MIT License

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

echo "0x0 version 0.3-6. Copyright (C) 2020 by Pontus Falk"
echo "License: MIT license"
echo

case $1 in
	"--help"|"-h"|"-?")
		echo "Format: '$0 [option] [directory/]filename.ext'."
		echo
		echo "Option -#: show progress-bar"
		echo "       -s: silent mode (supress errors)"
		echo "       -S: silten mode (show errors)"
		exit 1
esac

if [ $1 ]; then
	if [ -f "$2" ]; then

		echo "Uploading '$2'!"

		case $1 in
			"-#")
				echo
				URL=$(curl -# -F file=@"$2" -- https://0x0.st)
				;;
			"-s")
				URL=$(curl -s -F file=@"$2" -- https://0x0.st)
				;;
			"-S")
				URL=$(curl -s -S -F file=@"$2" -- https://0x0.st)
				;;
			*)
				echo
				echo "*** Unsupported option '$1', continue with default setting!"
				echo
				URL=$(curl -F file=@"$2" -- https://0x0.st)
		esac

		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$2' is done! The URL is '$URL'!"

	elif [ -f "$1" ]; then
		echo "Uploading '$1'!"
		echo
		URL=$(curl -F file=@"$1" -- https://0x0.st)
		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$1' is done! The URL is '$URL'!"
	else
		if [ $2 ]; then
			echo "Didn't find the file '$2'!"
		else
			echo "Didn't find the file '$1'!"
		fi
	fi
else
	echo "Ehh... you have to give a file name!"
	echo
	echo "Correct format is '$0 [option] [directory/]filename.ext'."
	echo "See $0 --help for more info."
fi
