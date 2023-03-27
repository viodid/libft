#!/bin/bash
#
# This is a script that automate all the task for the
# Born2beroot 42 assignment

# Color output info:
# https://stackoverflow.com/a/28938235
# expample
# echo -e "I ${Red}love${Yellow} Stack Overflow"
#
function check_success_package_install {
	if [[ $? == 0 ]]; then
		echo -e "${Green}$1 installed successfully.${White}"
		return 0
	fi
	echo -e "${Red}$1 installation failed.${White}"
	return 1
}

# Install packages
function distro_check_and_install {
	if [[ $distro == 1 ]]; then
		# Debian
		# &> redirects standard output and standard error
		apt list --installed | grep $1 &> /dev/null
		if [[ $? == 0 ]]; then
			echo -e "${Green}$1 is already installed.${White}"
			sleep 1 & wait
		else
			echo -e "${Red}$1 is not installed.${White}"
			echo -e "${Cyan}Installing $1...${White}"
			apt install $1 -y > /dev/null
			sleep 1 & wait
			check_success_package_install $1
	fi
	elif [[ $distro == 2 ]]; then
		# CentOs
		# &> redirects standard output and standard error
		dnf list installed | grep $1 &> /dev/null &
		if [[ $? == 0 ]]; then
			echo -e "${Green}$1 is already installed.${White}"
			sleep 1 & wait
		else
			echo -e "${Red}$1 is not installed.${White}"
			echo -e "${Cyan}Installing $1...${White}"
			dnf install $1
            check_success_package_install $1 
			# Install the package through snap if it's not available in the repositories
			if [[ $? > 0 ]]; then
				echo -e "${Red}$1 is not available in the repositories.${White}"
				echo -e "${Cyan}Installing $1 through non standard repos...${White}"
				sleep 1 & wait
				dnf install epel-release
				check_success_package_install epel-release
				sleep 1 & wait
				dnf install $1
				check_success_package_install $1
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
sleep 1 & wait

echo -e "Changing password policies..."
# Change password policy in /etc/login.defs
sed -i '/^PASS_MAX_DAYS/ c\PASS_MAX_DAYS   30' /etc/login.defs
sed -i '/^PASS_MIN_DAYS/ c\PASS_MIN_DAYS   2' /etc/login.defs
sed -i '/^PASS_WARN_AGE/ c\PASS_WARN_AGE   7' /etc/login.defs
# Change password policy in /etc/security/pwquality.conf
# Store pwquality.conf information
mv /etc/security/pwquality.conf /etc/security/pwquality.conf.info
echo -e "difok = 7\nminlen = 10\ndcredit = -1\nucredit = -1\nlcredit = -1\nmaxrepeat = 2\nusercheck = 1\nenforcing = 1\nretry = 3\nenforce_for_root" > /etc/security/pwquality.conf
sleep 1 & wait

# Create group "user42"
echo "Creating user42 group..."
groupadd user42
sleep 1 & wait

# Create user
echo "Creating user..."
useradd -m -s /bin/bash -g user42 -c "User automatically created with the bor2beroot script" $username
sleep 1 & wait

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
sleep 1 & wait

# Change default ssh port and disable root login
echo "Changing default ssh port..."
# Configure SELinux to allow the new port in CentOs
if [[ $distro == 2 ]]; then
	echo -e "${Cyan}Configuring SELinux to allow the new port...${White}"
	sleep 1 & wait
	# Install policycoreutils-python-utils
	distro_check_and_install policycoreutils-python-utils
	semanage port -a -t ssh_port_t -p tcp 4242
fi
echo -e "Port 4242\nPermitRootLogin no" > /etc/ssh/sshd_config.d/born2beroot.conf
sleep 1 & wait
echo -e "Restarting sshd service..."
systemctl restart sshd
sleep 1 & wait

# Install UFW
echo "Installing UFW..."
distro_check_and_install ufw
sleep 1 & wait
ufw enable
ufw default deny incoming
echo -e "${Cyan}Remove default rules, SAY YES!${White}"
for i in 4 3 2 1;do ufw delete $i; done
sleep 1 & wait
ufw allow 4242/tcp

# Install and configure Sudo




exit 0
