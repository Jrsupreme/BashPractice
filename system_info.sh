#!/bin/bash

#create a menu with the following options:
  #1. ip_adresses #display private and public ip
  #2. current user #display current profile
  #3. cpu_infomation #dispkay cpu count
  #4. memory information #display total mem & usage
  #5. top 5 memory processes #display  top 5 lines of mem usage
  #6. top 5 cpu processes #display top 5 lines if cpu usage
  #7. network connectivity #ask user for an url or ip address to check for internet connectivity. 
  #display if connection was succesfull , how long to connect and packet loss % 

#add back to main menu and exit the script

#function to get both the public and the private ips
get_ip_addresses() {
  private_ip=$(hostname -i | awk '{print $1}') #displays the private ips, grabs the main private ip
  public_ip=$(curl -s ifconfig.me) #uses a 3rd party service to get the public ip
echo "private ip: $private_ip"
echo "public ip: $public_ip"
}
#function to get the current user
get_current_user() {
  current_user=$(whoami)
  echo "you are: $current_user"
}

#function to get the cpu information
get_cpu_info() {
 cpu_available=$(nproc)
# cpu_total=$(nproc --all)
 #echo "the system has $cpu_available CPU(S) available of the $cpu_total CPU(S)"
echo "The system has $cpu_available CPU(S)"
}

#function to get memory information
get_mem_info() {
  memory_total=$(free -m | awk '/Mem:/ {print $2}') #awk is great.
  memory_used=$(free -m | awk '/Mem:/ {print $3}') # fetches the memory value numbers  from the free command
  memory_free=$(($memory_total - $memory_used)) #calculating free space
echo "memory total : $memory_total Mbs"
echo "memory used : $memory_used Mbs"
echo "memory free : $memory_free Mbs"
}

#function to get the top 5 memory processes
get_top5_mem_process() {
 #echo "pmem   pid	  cmd"
ps aux --sort=-%mem | awk 'NR<=6{print $4, $2 , $11}' #sort the ps aux based on mem% usage and prints out the first(which should be alredy sorted) 5  line
}

#function to get top 5 cpu processes
get_top5_cpu_process(){
ps aux --sort=-%cpu | awk 'NR<=6{print $3, $2, $11}' #same as before but for cpu%
}
#function to check for internet connection
check_for_network_connection() {
read -p "insert url or ip address to connect to " address 
  ping_output=$(ping -c 4 $address) #test for internet connection, lantency and paket loss.
  if echo "$ping_output" | grep -q "0% packet loss" #grep -q checks if for 0% packet loss and return a 0 code which will be useful for a if loop in the next line
   then
   connection_time=$(echo "$ping_output" | grep 'time=' | awk -F 'time=' '{print $2}' | awk '{print $1;exit}') #grabs the main connection time and stores it in a variable.
   echo "It took $connection_time ms to connect to $address and there was 0% packet loss."
  else
   echo "There was a problem connecting to $address"
  fi
}

#function for main menu
systeminfo_main_menu() { #made the main menu a function cause I feel like I can use it for a disferent script in the future. Also i'd like to further my understanding of functions
while true; do #This whike loop will keep the script running until existed
    echo "Please choose an option:"
    echo "1. IP Addresses"
    echo "2. Current User"
    echo "3. CPU Information"
    echo "4. Memory Information"
    echo "5. Top 5 Memory Processes"
    echo "6. Top 5 CPU Processes"
    echo "7. Network Connectivity"
    echo "8. Exit"

    read -p "Enter your choice: " choice

    case $choice in #case in this case(pun intented) allows us to execute the function depending if choice = a number from 1 - 8 otherwise it will return a error.
        1)
            get_ip_addresses # if user's choice = 1  or any if the other numbered option the corresponding function will trigger.
            ;;
        2)
            get_current_user
            ;;
        3)
            get_cpu_info
            ;;
        4)
            get_mem_info
            ;;
        5)
            get_top5_mem_process
            ;;
        6)
            get_top5_cpu_process
            ;;
        7)
            check_for_network_connection
            ;;
        8)
            echo "Exiting the script..."
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac

done
echo "system_info.sh exited"
}
#run the main menu function
systeminfo_main_menu
