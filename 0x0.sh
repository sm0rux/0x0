#!/bin/bash

# 0x0 version 0.4-1
# Copyright (C) 2020 Pontus Falk

# Put 0x0.sh in /usr/local/bin directory or make a symbolic link in
# /usr/local/bin to the file wherever it is located.

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

echo "0x0 version 0.4-1. Copyright (C) 2020 by Pontus Falk"
echo "License: MIT license"
echo

L1=$1
L2=$2

case $L1 in
	"--help"|"-h"|"-?")
		echo "Format: '$0 [option] [directory/]filename.ext'."
		echo
		echo "Option -d: default setting"
		echo "       -#: show progress-bar"
		echo "       -s: silent mode (supress errors)"
		echo "       -S: silten mode (show errors)"
		exit 1
esac

if [ -z $L2 ]; then
	if [ ~/.0x0rc ]; then
		if [ $L1 ]; then
			FILE=~/.0x0rc
			while read LINE; do
				if [ ${LINE::1} != "#" ]; then
					L2=$1
					L1=$LINE
				fi
			done < $FILE
		fi
	fi
fi

if [ $L1 ]; then
	if [ -f "$L2" ]; then

		echo "Uploading '$L2'!"

		case $L1 in
			"-d")
				echo
				URL=$(curl -F file=@"$L2" -- https://0x0.st)
				;;
 			"-#")
				echo
				URL=$(curl -# -F file=@"$L2" -- https://0x0.st)
				;;
			"-s")
				URL=$(curl -s -F file=@"$L2" -- https://0x0.st)
				;;
			"-S")
				URL=$(curl -s -S -F file=@"$L2" -- https://0x0.st)
				;;
			*)
				echo
				echo "*** Unsupported option '$L1', continue with default setting!"
				echo
				URL=$(curl -F file=@"$L2" -- https://0x0.st)
		esac

		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$L2' is done! The URL is '$URL'!"

	elif [ -f "$L1" ]; then
		echo "Uploading '$L1'!"
		echo
		URL=$(curl -F file=@"$L1" -- https://0x0.st)
		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$L1' is done! The URL is '$URL'!"
	else
		if [ $2 ]; then
			echo "Didn't find the file '$L2'!"
		else
			echo "Didn't find the file '$L1'!"
		fi
	fi
else
	echo "Ehh... you have to give a file name!"
	echo
	echo "Correct format is '$0 [option] [directory/]filename.ext'."
	echo "See $0 --help for more info."
fi
