#!/bin/bash

#check  if the path exist
#read file name
#check for file permissions
#dislay file permissions

echo "Please Input the file's absolute path:"

read inputfilepath

echo "Checking path: $inputfilepath"
sleep 2

if [ -e "$inputfilepath" ]
  then
	ls -l "$inputfilepath"

  else
	echo "path is not valid"
fi 

