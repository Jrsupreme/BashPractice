#!/bin/bash

#check for git and gh install if necessary
#check new files and changes in a specified dir
#if there are new files or changes push to github repo
#if there is not github repo does not exist prompt user to create one
#if user says "yes" create github repo
#push new files and changes to new github repo
#if user says "no" exit the script with a warning

#making variable local to not cause any issues with any potential global variables

#Function to check if git and gh cli are installed
check_and_ins_req_cmd(){
#making variable local to not cause any issues with any potential global variables
local cmd1=$1
local cmd2=$2

if  [[ -z "$(which $cmd1)" ]] #check if git is isntalled
then #install git if it is NOT install 
  echo "git not isntalled. Installing..." 
  sudo apt update && sudo apt install git -y
  git --version
else #if installed say installed
 echo "git already installed"
fi

if [[ -z "$(which $cmd2)" ]] #check if gh cli is installed
then #install gh cli, if gh cli is NOT installed
  echo "Github CLI not installed installing"
   type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y) #official github cli install code
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
else #if installed say installed
 echo "gh already installed"
fi
}


#function to check for new or changed files(takes directory path as parameter)
check_files_in_dir(){

dir=$1

new_changed_files=$(find "$dir" -mtime -1 -ctime -1 -type f) #find any new or changed files withing specifed dir path and stores the output into variable

if [ -z "$new_changed_files" ]
then
 echo "No new files or changes have been made"
 exit 0 #exit the script if no nothing was added or changed
else
 echo "New files or changes detected: $new_changed_files"
fi
}


#function to check if repo exist
check_gh_repo(){

if git rev-parse --is-inside-work-tree > /dev/null 2>&1 #check if directory is associated with a repo and outputs true if it is and false if it isn't. 2>&1 deletes both standard output and error output.
then
  echo "Repository found!"
  return 0 #if repo is found return success code
else
  echo "Repository does NOT exist"
  return 1 #if repo is not found return error code
fi
}

#function to create git hub repo
create_github_repo(){
read -p "Would you like to create a github repo?(yes/no) " choice #prompt user if they want to create a new repo

if [[ '$choice' = 'yes' ]]
 then                       #if yes prompt for visibility choice
  read -p "Would you like this repository to be 'public' or 'private': " visibility
  if [[ '$visibility' = 'public' ]]
  then
   gh repo create --public --source. --remote=origin #uses gh cli to create a public  repo remotely
  elif [['visibility' = 'private' ]]
  then
   gh repo create --private --source. --remote=origin ##uses gh cli to create a public  repo remotely
 else
  echo "Invalid choice please type: 'public' or 'private'."
  exit 1
 fi
elif [[ '$choice' = 'no' ]]
then			   #if no exit with a warning
 echo "existing script without creating a new repo"
 echo "WARNING: NO CHANGES will be push since git repository IS NOT existent"
 exit 1
else
echo "invalid choice please type in: 'yes' or 'no'."
fi
}

# Function to push changes to GitHub
push_to_github() {
echo "Pushing changes to GitHub..."
git add .
git commit -m "Detected new files or changes"
git push origin main
echo "Changes have been successfully pushed to GitHub."
}

#main script

read -p "Provide directory path to check and push: " directory

#check that the directory exist
if [! -d "$directory" ] #if directory does not exist exit.
then
 echo "Directory does not exist"
 exit 1
fi

check_files_in_dir "$directory" #check if any new files were added or if any changes were done.

cd "$directory" #if changes or files were added go to directory.

if check_gh_repo #check if current directory has a repository.
then
 push_to_github #push changes to the associated repository.
else
 create_github_repo #if current directory does not have a repository ask user if they'd like to create one. Otherwise exit the script with a warning.
 push_to_github #push to new repo
fi
