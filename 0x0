#!/bin/bash

# 0x0 version 0.2-1
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

echo "0x0 version 0.2-1. Copyright (C) 2020 by Pontus Falk"
echo "License: MIT license"
echo

case $1 in
	"--help"|"-h"|"-?")
		echo "Format: '$0 [command] [directory/]filenamn.ext'."
		echo
		echo "Command -#: show progress-bar"
		echo "        -s: silent mode (supress errors)"
		echo "        -S: silten mode (show errors)"
		exit 1
		;;
	"-#")
		if [ "$2" ]; then
			if [ -f "$2" ]; then
				echo "Uploading '$2'!"
				URL=$(curl -# -F file=@"$2" -- https://0x0.st)
				echo
				echo -n $URL | xclip -i -sel clipboard
				echo "Tjoho, uploading of '$2' is done! The URL is '$URL'!"
			else
				echo "Didn't find the file '$2' :("
			fi
		else
			echo "Ehh... you have to give a file name!"
			echo "Correct format is '$0 [directory/]filenamn.ext'."
			echo "$0 --help for more info."
		fi
		;;
	"-s")
		if [ "$2" ]; then
			if [ -f "$2" ]; then
				echo "Uploading '$2'!"
				URL=$(curl -s -F file=@"$2" -- https://0x0.st)
				echo
				echo -n $URL | xclip -i -sel clipboard
				echo "Tjoho, uploading of '$2' is done! The URL is '$URL'!"
			else
				echo "Didn't find the file '$2' :("
			fi
		else
			echo "Ehh... you have to give a file name!"
			echo "Correct format is '$0 [directory/]filenamn.ext'."
			echo "$0 --help for more info."
		fi
		;;
	"-S")
		if [ "$2" ]; then
			if [ -f "$2" ]; then
				echo "Uploading '$2'!"
				URL=$(curl -s -S -F file=@"$2" -- https://0x0.st)
				echo
				echo -n $URL | xclip -i -sel clipboard
				echo "Tjoho, uploading of '$2' is done! The URL is '$URL'!"
			else
				echo "Didn't find the file '$2' :("
			fi
		else
			echo "Ehh... you have to give a file name!"
			echo "Correct format is '$0 [directory/]filenamn.ext'."
			echo "$0 --help for more info."
		fi
		;;
	*)
		if [ "$1" ]; then
			if [ -f "$1" ]; then
				echo "Uploading '$1'!"
				URL=$(curl -F file=@"$2" -- https://0x0.st)
				echo
				echo -n $URL | xclip -i -sel clipboard
				echo "Tjoho, uploading of '$1' is done! The URL is '$URL'!"
			else
				echo "Didn't find the file '$1' :("
			fi
		else
			echo "Ehh... you have to give a file name!"
			echo "Correct format is '$0 [directory/]filenamn.ext'."
			echo "$0 --help for more info."
		fi
esac
