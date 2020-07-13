#!/bin/bash

set -e

# 0x0 version 1.0-2
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

VAR1=$1
VAR2=$2

echo "0x0 version 1.0-2. Copyright (C) 2020 by Pontus Falk"
echo "License: MIT license"
echo

# If no options are given, echo shorter help text and exit
if [ -z "$VAR1" ]; then
	echo "Ehh... maybe you should use '$0 --help' for more info?!"
	exit 1
fi

# If VAR1 is --help, -h or -?, echo short help text and exit
if [ "$VAR1" = "--help" ] || [ "$VAR1" = "-help" ] || [ "$VAR1" = "-h" ] || [ "$VAR1" = "-?" ]; then
	echo "To upload files from your computer:"
	echo
	echo "	Format: '$0 [option] [directory/]filename.ext'."
	echo
	echo "	Option -d: default setting"
	echo "	       -#: show progress-bar"
	echo "	       -s: silent mode (supress errors)"
	echo "	       -S: silten mode (show errors)"
	echo
	echo "To shorten long URL:s:"
	echo
	echo "	Format: '$0 -short https://example.com/directory'."
	echo
	echo "To upload remote files:"
	echo
	echo "	Format: '$0 -remote https://example.com/directory/file.png'."
	exit 1
fi

# URL shortener
if [ "$VAR1" = "-short" ]; then
	URL=$(curl -F shorten="$VAR2" -- https://0x0.st)
	echo -n "$URL" | xclip -i -sel clipboard
	if [ "$URL" != "Segmentation fault" ]; then
		echo
		echo "Tjoho, short URL for '$VAR2' is '$URL'!"
	else
		echo
		echo "*** Sorry, but '$VAR2' is not a valid URL!"
		if [ -z "$VAR2" ]; then
			echo
			echo "See '$0 --help' for more info."
		fi
	fi
	exit 1
fi

# Upload remote file to 0x0.st
if [ "$VAR1" = "-remote" ]; then
	URL=$(curl -F url="$VAR2" -- https://0x0.st)
	echo -n "$URL" | xclip -i -sel clipboard
	if ! [ "${URL:0:1}" = "<" ] && ! [ "${URL:0:1}" = "4" ]; then
		echo
		echo "Tjoho, file '$VAR2' is uploaded as '$URL'!"
	else
		echo
		echo "*** Sorry, but I don't find any file at '$VAR2'!"
		if [ -z "$VAR2" ]; then
			echo
			echo "See '$0 --help' for more info."
		fi
	fi
	exit 1
fi

# Exit if no valid filename is given either in $VAR1 or $VAR2
if ! [ -f "$VAR1" ] && ! [ -f "$VAR2" ]; then
	if [ -z "$VAR2" ]; then
		echo "Didn't find the file '$VAR1'!"
	else
		echo "Didn't find the file '$VAR2'!"
	fi
	exit 1
fi

# Read the ~/.0x0rc configuration file
if [ -f ~/.0x0rc ]; then
	source ~/.0x0rc
fi

# If file to transfer is in first option then move it to VAR2 and put CONFIG1 in VAR1
if [ -f "$VAR1" ]; then
	VAR2=$VAR1

	# If CONFIG1 is empty (no alternative given in ~/.0x0rc then put -d in VAR1
	if [ "$CONFIG1" ]; then
		VAR1=$CONFIG1
	else
		VAR1="-d"
	fi
fi

# Time to set how to use curl
case $VAR1 in
	"-d")
		URL=$(curl -F file=@"$VAR2" -- https://0x0.st)
		;;
 	"-#")
		URL=$(curl -# -F file=@"$VAR2" -- https://0x0.st)
		;;
	"-s")
		URL=$(curl -s -F file=@"$VAR2" -- https://0x0.st)
		;;
	"-S")
		URL=$(curl -s -S -F file=@"$VAR2" -- https://0x0.st)
		;;
	*)
		echo "*** Unsupported option '$VAR1', continue with default setting!"
		echo
		URL=$(curl -F file=@"$VAR2" -- https://0x0.st)
esac

# Transfer file using curl and copy URL returned to clipboard
echo -n "$URL" | xclip -i -sel clipboard
echo
echo "Tjoho, uploading of '$VAR2' is done! The URL is '$URL'!"
