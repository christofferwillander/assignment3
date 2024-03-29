#!/bin/bash

# Showing proper script usage to user
USAGE="Usage: $0 <file.calc>"
NOTE="N.B. input file should be located in CWD"


if [ $# -lt 1 ] || [ $# -gt 1 ]; then
	echo $USAGE
    echo $NOTE
	exit 1
fi

fileName=$(echo "$1" | grep -Eo "^[^\.]+")
fileArg=$(echo "$1" | grep -o ".calc")

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
cat ./lexyacc-code/prologue > $fileName.s
./bin/calc3i.exe < ./$1 >> $fileName.s
cat ./lexyacc-code/epilogue >> $fileName.s

gcc -Llib -g $fileName.s -o $fileName -no-pie -lfunctions
echo "Compilation was successful: $fileName.calc -> $fileName.s -> $fileName"
echo "Remember to set 'export LD_LIBRARY_PATH' to lib folder before execution"
