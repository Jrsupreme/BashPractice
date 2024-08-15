#!/bin/bash

#Sort through the log for 404 error
#grab the ip from each error
#count the number of times that each ip encounter a 404
#post the results

#search file for 404 errors and then isolate the ips from the output
logfile="web-server-access-logs.log"
ipfile="ipfile.txt"

grep '404' $logfile | awk '{print $1}' | cut -d'"' -f2 > $ipfile #making sure the isolated ips are in a separate file

declare -A ip_count #Associative array; is like a book where we will be anotating variables in this case $ip

#count the ip and error encountered
while read -r ip #assign each line (in this case the ips) to a variable 
 do
	if [[ -n "$ip" ]] #making sure the ip variable has been assign correctly and is not empty
	  then
	((ip_count["$ip"]++))  #this initiates a count with 1 for each ip if the ip has been counted already it updates the count to 2 and so on
	fi
 done < "$ipfile"

#post results
for ip in "${!ip_count[@]}" #this recalls all ip variables within the array
 do
  echo "$ip" : "${ip_count[$ip]}" #this posts the ips and the count separated by :
 done
