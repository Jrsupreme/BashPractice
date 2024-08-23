#!/bin/bash

echo "On a normal day of your life you're driving home and out of nowhere a TRUCK comes out flying and plows into your car. Everything goes dark... then you wake up and you find yourself laying on a cold but weirdly comforatable floor. What do you do?"
echo "1)Get up and look around"
echo "2)DO NOT want to get up! floor is too comfy 7u7"
read user_choice
 
if [[ -n $user_choice = 1 ]] ; then 
  do 
	echo 'Greetings traveler! Care for a little chat? "says an old guy on the side of the road"'
elif
	[[ -n $user_choice = 2 ]] ; then 
  do
	echo "ignore the old guy"
  done
fi
