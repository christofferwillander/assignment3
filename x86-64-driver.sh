#!/bin/bash

# Showing proper script usage to user
USAGE="Usage: $0 <file.calc>"
NOTE="N.B. input file should be located in CWD"


if [ $# -lt 1 ] || [ $# -gt 1 ]; then
	echo $USAGE
    echo $NOTE
	exit 1
fi

fileArg=$(echo "$1" | grep -o ".calc")
fileName=$(echo "$1" | grep -Eo "^[^\.]+")

if [ $? -eq 1 ]; then
    echo "ERROR: Invalid file type - provide a .calc file"
    echo $USAGE
    echo $NOTE
    exit 1
fi

test -f $fileName$fileArg

if [ $? -eq 1 ]; then
    echo "ERROR: Input file $fileName$fileArg does not exist"
    exit 1
fi

test -f ./bin/calc3i.exe

if [ $? -eq 1 ]; then
    echo "ERROR: Could not find compiler file (./bin/calc3i.exe) - attempting to make"
    make > /dev/null
fi

touch $fileName
cat prologue > $fileName.s
./bin/calc3i.exe < ./$1 >> $fileName.s
cat epilogue >> $fileName.s

gcc -Llib -g $fileName.s -o $fileName -no-pie -lfunctions
