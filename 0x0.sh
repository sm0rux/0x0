#!/bin/bash

# 0x0 version 0.4-4
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

echo "0x0 version 0.4-4. Copyright (C) 2020 by Pontus Falk"
echo "License: MIT license"
echo

VAR1=$1
VAR2=$2

# If VAR1 is --help, -h or -? then show these lines and then quit.
case $VAR1 in
	"--help"|"-h"|"-?")
		echo "Format: '$0 [option] [directory/]filename.ext'."
		echo
		echo "Option -d: default setting"
		echo "       -#: show progress-bar"
		echo "       -s: silent mode (supress errors)"
		echo "       -S: silten mode (show errors)"
		exit 1
esac

# If VAR2 is empty and VAR1 is an existing and readable file and if ~/.0x0rc
# exist then move VAR1 to VAR2 and put content in ~/.0x0rc in VAR1.
if [ -z $VAR2 ]; then
	if [ -f ~/.0x0rc ]; then
		if [ -f $VAR1 ]; then
			FILE=~/.0x0rc
			while read LINE; do
				# If line in ~/.0x0rc is not a comment and VAR1 is a file then
				# rotate VAR1->VAR2 and LINE->VAR1
				if [ ${LINE::1} != "#" ]; then
					VAR2=$VAR1
					VAR1=$LINE
				fi
			done < $FILE
		fi
	fi
fi

# If VAR1 is not empty and VAR2 is an existing and readable file the do the work :)
if [ $VAR1 ]; then
	if [ -f "$VAR2" ]; then

		echo "Uploading '$VAR2'!"

		case $VAR1 in
			"-d")
				echo
				URL=$(curl -F file=@"$VAR2" -- https://0x0.st)
				;;
 			"-#")
				echo
				URL=$(curl -# -F file=@"$VAR2" -- https://0x0.st)
				;;
			"-s")
				URL=$(curl -s -F file=@"$VAR2" -- https://0x0.st)
				;;
			"-S")
				URL=$(curl -s -S -F file=@"$VAR2" -- https://0x0.st)
				;;
			*)
				echo
				echo "*** Unsupported option '$VAR1', continue with default setting!"
				echo
				URL=$(curl -F file=@"$VAR2" -- https://0x0.st)
		esac

		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$VAR2' is done! The URL is '$URL'!"

	# If VAR1 is an existing and readable file (as it only could be if ~/.0x0rc not exists and no option is given...
	elif [ -f "$VAR1" ]; then
		echo "Uploading '$VAR1'!"
		echo
		URL=$(curl -F file=@"$VAR1" -- https://0x0.st)
		echo
		echo -n $URL | xclip -i -sel clipboard
		echo "Tjoho, uploading of '$VAR1' is done! The URL is '$URL'!"

	# If no valid file is found in either VAR1 or VAR2
	else
		if [ -z $VAR2 ]; then
			echo "Didn't find the file '$VAR1'!"
		else
			echo "Didn't find the file '$VAR2'!"
		fi
	fi

# If no option or filename is given...
else
	echo "Ehh... you have to give a file name!"
	echo
	echo "Correct format is '$0 [option] [directory/]filename.ext'."
	echo "See $0 --help for more info."
fi
