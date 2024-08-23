#!/bin/bash

#take all files  that are in a our home directory, put them in a back files, and make sure all the files are regular files.
#Declare where and what we want to back up.
#Make sure back up directory exist
#Back every file into the back up directory.
#Check if its a regular file, copy files
#If not skip the files

source="/home/ubuntu"
Destination="/home/ubuntu/backup"

mkdir -p  "$destination"

for files in "$source"/*
do
	 if [ -f  "$files" ]
	 then
	   cp "$files" "$destinantion"
		echo ""$files$" transfer complete"
	 else
		echo "skipping "$files"; not regular"
	 fi
done
