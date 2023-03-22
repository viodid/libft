#!/bin/bash
#
# This is a script that automate all the task for the
# Born2beroot 42 assignment

# Color output info:
# https://stackoverflow.com/a/28938235
# expample
# echo -e "I ${Red}love${Yellow} Stack Overflow"
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Let the user write which linux distro is the script running on

# Linux distro election; 1 for Debian, 2 for CentOs
while true; do
	echo -e "${Cyan}What distro have you chose?\n${White}1. Debian\n2. CentOs"
	read distro 
	if [[ $distro == 1 ]]; then
		echo "You selected Debian!"
		break
	elif [[ $distro == 2 ]]; then
		echo "You selected CentOs!"
		break
	else
		echo -e "${Red}Invalid input. Please enter one of the two options.${White}"
	fi
done


echo -e "Setting up enviroment\nChanging hostname..."




#echo -e "${Cyan}Write your username (login):${White}"
#read USERNAME

#sudo useradd -m -s $SHELL -g wheel -c "User created with bor2beroot script" $USERNAME

exit 0
