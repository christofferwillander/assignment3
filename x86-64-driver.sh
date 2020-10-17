#!/bin/bash

# Showing proper script usage to user
USAGE="Usage: $0 <file.calc>"
NOTE="N.B. input file has to be located in CWD"


if [ $# -lt 1 ] || [ $# -gt 1 ]; then
	echo $USAGE
    echo $NOTE
	exit 1
fi

fileArg=$(echo "$1" | grep -o ".calc")

if [ $? -eq 1 ]; then
    echo "Invalid file type - provide a .calc file"
    echo $USAGE
    echo $NOTE
    exit 1
fi

fileName=$(echo "$1" | grep -Eo "^[^\.]+")
touch $fileName
cat prologue > $fileName.s
./bin/calc3i.exe < ./$1 >> $fileName.s
cat epilogue >> $fileName.s

gcc -g $fileName.s -o $fileName -no-pie