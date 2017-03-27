# hacker
Hacker News in the Command Line.

## Installation
(This probably isn't the best way, but here it goes)

1. Download the latest version of hacker - [https://github.com/chrishannah/hacker/releases](https://github.com/chrishannah/hacker/releases).
2. Open up your terminal app of choice.
3. Navigate to the folder containing the "hacker" file.
4. Add the executable permission to the file: `chmod +x hacker`.
5. Move the file to the usr/local/bin directory so it can be launched as a command: `mv hacker /usr/local/bin`.

## Usage
Usage: hacker [options]

Options:

    -n, --new        The newest 20 submissions.
    -t, --top        The current top 20 submissions.
    -b, --best       The current best 20 submissions.
    -h, --help       Output this usage guide.

Example:

    hacker --new

## Demo

![Demo](https://github.com/chrishannah/hacker/blob/master/2017-03-27%2011_46_13.gif?raw=true)


