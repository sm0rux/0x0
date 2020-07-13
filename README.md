# 0x0

Script to upload files etc to [0x0.st](https://0x0.st/)

## Installation

Put 0x0.sh in /usr/local/bin directory or make a symbolic link in
/usr/local/bin to the file wherever it is located

Put .0x0rc file in you home directory - or (prefered) make a
symbolic link from your git directory to your home dir :)

## Dependencies

curl and xclip

## Usage

To upload files from your computer:

	Format: '/usr/local/bin/0x0 [option] [directory/]filename.ext'.

	Option -d: default setting
	       -#: show progress-bar
	       -s: silent mode (supress errors)
	       -S: silten mode (show errors)

To shorten long URL:s:

	Format: '/usr/local/bin/0x0 -short https://example.com/directory'.

To upload remote files:

	Format: '/usr/local/bin/0x0 -remote https://example.com/directory/file.png'.

## License

This repository is published under the MIT License
