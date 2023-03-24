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

# Intro ascii art
echo -en "${Purple}
██████╗░░█████╗░██████╗░███╗░░██╗██████╗░██████╗░███████╗██████╗░░█████╗░░█████╗░████████╗
██╔══██╗██╔══██╗██╔══██╗████╗░██║╚════██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
██████╦╝██║░░██║██████╔╝██╔██╗██║░░███╔═╝██████╦╝█████╗░░██████╔╝██║░░██║██║░░██║░░░██║░░░
██╔══██╗██║░░██║██╔══██╗██║╚████║██╔══╝░░██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║░░██║░░░██║░░░
██████╦╝╚█████╔╝██║░░██║██║░╚███║███████╗██████╦╝███████╗██║░░██║╚█████╔╝╚█████╔╝░░░██║░░░
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░░╚════╝░░░░╚═╝░░░
"

# Disclaimer
echo -en "${Green}\nBe aware that the script must be executed with root privileges, otherwise the script will fail.\nIf you don't know how to login as a root, try: ${Yellow}sudo su -\n"

# Let the user write which linux distro is the script running on
# Linux distro election; 1 for Debian, 2 for CentOs
while true; do
	echo -e "\n${Cyan}What distro have you chose?\n${White}1. Debian\n2. CentOs"
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


echo -e "Setting up enviroment\n${Cyan}Please enter you username (login):${White}"
read username

# Set the hostname
echo -n "Changing hostname..."
echo "${username}42" > /etc/hostname
echo -e "127.0.0.1\t"${username}42"\n::1\t\t"${username}42"" > /etc/hosts

echo -e "Changing password policies..."
# Set password expiration policy
chage -M 30 -m 2 -W 7

# Change password policy in /etc/login.defs
sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   30' /etc/login.defs
sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS   2' /etc/login.defs
sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE   7' /etc/login.defs

# Change password policy in /etc/security/pwquality.conf
echo "difok = 7\nminlen = 10\ndcredit = -1\nucredit = -1\nlcredit = -1\nmaxrepeat = 3\nusercheck = 1\nenforcing = 1\nretry = 3\nenforce_for_root" >> /etc/security/pwquality.conf

echo -en "${Green}Done!${White}"



#sudo useradd -m -s $SHELL -g wheel -c "User created with bor2beroot script" $USERNAME

exit 0
