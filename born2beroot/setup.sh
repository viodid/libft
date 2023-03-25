#!/bin/bash
#
# This is a script that automate all the task for the
# Born2beroot 42 assignment

# Color output info:
# https://stackoverflow.com/a/28938235
# expample
# echo -e "I ${Red}love${Yellow} Stack Overflow"
#
# Install packages
function distro_check {
	if [[ $distro == 1 ]]; then
		# Debian
		# &> redirects standard output and standard error
		apt list --installed | grep $1 > /dev/null
		apt install $1
		if [[ $? == 0 ]]; then
			echo -e "${Green}$1 is already installed.${White}"
		else
			echo -e "${Red}$1 is not installed.${White}"
			echo -e "${Cyan}Installing $1...${White}"
			apt install $1
	fi
	elif [[ $distro == 2 ]]; then
		# CentOs
		# &> redirects standard output and standard error
		dnf list installed | grep $1 &> /dev/null
		if [[ $? == 0 ]]; then
			echo -e "${Green}$1 is already installed.${White}"
		else
			echo -e "${Red}$1 is not installed.${White}"
			echo -e "${Cyan}Installing $1...${White}"
			dnf install $1
			# Install the package through snap if it's not available in the repositories
			if [[ $? > 0 ]]; then
				echo -e "${Red}$1 is not available in the repositories.${White}"
				echo -e "${Cyan}Installing $1 through snap...${White}"
				dnf install snapd
				snap install $1
			fi
		fi
	fi
}

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
echo -e "${Green}\nBe aware that the script must be executed with root privileges, otherwise the script will fail.\nIf you don't know how to login as root, try: ${Yellow}sudo su -"

# Let the user write which linux distro is the script running on
# Linux distro election; 1 for Debian, 2 for CentOs
while true; do
	echo -e "\n${Cyan}What distro have you chose?\n${White}1. Debian\n2. CentOs"
	read distro 
	if [[ $distro == 1 ]]; then
		echo "You selected Debian!"
		break
	elif [[ $distro == 2 ]]; then
		echo -e "You selected CentOs!\nNote that this script only supports CentOs 8 or higher."
		break
	else
		echo -e "${Red}Invalid input. Please enter one of the two options.${White}"
	fi
done


echo -e "Setting up enviroment\n${Cyan}Please enter you username (login):${White}"
read username

# Set the hostname
echo "Changing hostname..."
echo "${username}42" > /etc/hostname
echo -e "127.0.0.1\t"${username}42"\n::1\t\t"${username}42"" > /etc/hosts


echo -e "Changing password policies..."
# Change password policy in /etc/login.defs
sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   30' /etc/login.defs
sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS   2' /etc/login.defs
sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE   7' /etc/login.defs
# Change password policy in /etc/security/pwquality.conf
# Store pwquality.conf information
mv /etc/security/pwquality.conf /etc/security/pwquality.conf.info
echo -e "difok = 7\nminlen = 10\ndcredit = -1\nucredit = -1\nlcredit = -1\nmaxrepeat = 2\nusercheck = 1\nenforcing = 1\nretry = 3\nenforce_for_root" > /etc/security/pwquality.conf
echo -e "${Green}Done!${White}"

# Create group "user42"
echo "Creating user42 group..."
groupadd user42

# Create user
echo "Creating user..."
useradd -m -s /bin/bash -g user42 -c "User automatically created with the bor2beroot script" $username

# Setting password to user
echo -e "${Cyan}Enter a valid password:${White}"
passwd $username
while [[ "$?" > 0 ]]
do
	echo -e "${Red}Come on, it's not that difficult... Set your password correctly.${White}"
	passwd $username
done

# Change user password expiry information
echo "Changing user password expiry information..."
chage -d $(date +"%Y-%m-%d") -m 2 -M 30 -W 7 $username
chage -d $(date +"%Y-%m-%d") -m 2 -M 30 -W 7 root
sleep 1


# Change default ssh port and disable root login
echo "Changing default ssh port..."
# Configure SELinux to allow the new port in CentOs
if [[ $distro == 2 ]]; then
	echo -e "${Cyan}Configuring SELinux to allow the new port...${White}"
	semanage port -a -t ssh_port_t -p tcp 4242
fi
echo -e "Port 4242\nPermitRootLogin no" > /etc/ssh/sshd_config.d/born2beroot.conf
systemctl restart sshd
sleep 1
systemctl status sshd
sleep 1

# Install UFW
echo "Installing UFW..."
distro_check ufw
ufw allow 4242/tcp
ufw default deny incoming
ufw enable
ufw status





# Check if net-tools is installed
distro_check net-tools

exit 0
