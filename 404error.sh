#!/bin/bash

#Sort through the log for 404 error
#grab the ip from each error
#count the number of times that each ip encounter a 404
#post the results

#search file for 404 errors and then isolate the ips from the output
logfile="web-server-access-logs.log"
ipfile="ipfile.txt"

grep '404' $logfile | awk '{print $1}' | cut -d'"' -f2 > $ipfile

declare -A ip_count

#count the ip and error encountered
while read -r ip
 do
	if [[ -n "$ip" ]]
	  then
	((ip_count["$ip"]++))
	fi
 done < "$ipfile"

#post results
for ip in "${!ip_count[@]}"
 do
  echo "$ip" : "${ip_count[$ip]}"
 done
