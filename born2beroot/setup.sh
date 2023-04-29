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
  if [[ $1 == 0 ]]; then
    echo -e "${Green}Installed successfully.${White}"
    return 0
  fi
  echo -e "${Red}Installation failed.${White}"
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
      apt install $1 -y &> /dev/null
      check_success_package_install $?
      sleep 1 & wait
    fi
  elif [[ $distro == 2 ]]; then
    # CentOs
    # &> redirects standard output and standard error
    dnf list installed | grep $1 > /dev/null
    if [[ $? == 0 ]]; then
      echo -e "${Green}$1 is already installed.${White}"
      sleep 1 & wait
    else
      echo -e "${Red}$1 is not installed.${White}"
      echo -e "${Cyan}Installing $1...${White}"
      dnf install $1 -y --nogpgcheck &> /dev/null
      check_success_package_install $?
      # Install the package through snap if it's not available in the repositories
      if [[ $? > 0 ]]; then
        echo -e "${Red}$1 is not available in the repositories.${White}"
        echo -e "${Cyan}Installing $1 through non standard repos...${White}"
        sleep 1 & wait
        echo -e "${Cyan}Installing epel-release...${White}"
        dnf install epel-release -y --nogpgcheck &> /dev/null
        check_success_package_install $?
        sleep 1 & wait
        dnf install $1 -y --nogpgcheck &> /dev/null
        check_success_package_install $?
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
______                      _____  _           ______               _   
| ___ \                    / __  \| |          | ___ \             | |  
| |_/ /  ___   _ __  _ __     / / | |__    ___ | |_/ / ___    ___  | |_ 
| ___ \ / _ \ |  __||  _ \   / /  |  _ \  / _ \|    / / _ \  / _ \ | __|
| |_/ /| (_) || |   | | | | / /___| |_) ||  __/| |\ \| (_) || (_) || |_ 
\____/  \___/ |_|   |_| |_|\_____/|_ __/  \___|\_| \_|\___/  \___/  \__|
${White}"

# Check if the script is running as root
if [[ $EUID != 0 ]]; then
  echo -e "${Red}\nThis script must be run as root. If you don't know how to login as root, try: ${Yellow}sudo su - root${White}"
  exit 1
fi

# Check if the script is running on a supported linux distro
distro_name=$(cat /etc/os-release | grep -i ^id= | cut -d '=' -f 2 | tr -d '"' | tr '[:upper:]' '[:lower:]')

echo "$distro_name"
# Linux distro election; 1 for Debian, 2 for CentOs
if [[ "$distro_name" == "debian" ]]; then
  echo -e "${Green}You are running Debian!${White}"
  distro=1
elif [[ "$distro_name" == "centos" ]]; then 
  echo -e "${Green}You are running CentOS!\nNote that this script only supports CentOS Stream 8 or higher.${White}"
  distro=2
else
  echo -e "${Red}This script only supports Debian and CentOS.${White}"
  exit 1
fi


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
if [[ $distro == 2 ]]; then
  # CentOs
  mv /etc/security/pwquality.conf /etc/security/pwquality.conf.info
  echo -e "difok = 7\nminlen = 10\ndcredit = -1\nucredit = -1\nlcredit = -1\nmaxrepeat = 2\nusercheck = 1\nenforcing = 1\nretry = 3\nenforce_for_root" > /etc/security/pwquality.conf
elif [[ $distro == 1 ]]; then
	# Debian
	distro_check_and_install "libpam-pwquality"
	sed -i '/retry=3/ s/$/ difok=7 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 maxrepeat=2 enforce_for_root/' /etc/pam.d/common-password
fi
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

passwd root
while [[ "$?" > 0 ]]
do
  echo -e "${Red}Come on, it's not that difficult... Set the password correctly.${White}"
  passwd root
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
  # Install policycoreutils-python-utils
  distro_check_and_install policycoreutils-python-utils
  sleep 1 & wait
  echo -e "Configuring SELinux to allow the new port..."
  semanage port -a -t ssh_port_t -p tcp 4242
fi
echo -e "Port 4242\nPermitRootLogin no" >> /etc/ssh/sshd_config
echo -e "Port 4242\nPermitRootLogin no" > /etc/ssh/ssh_config
sleep 1 & wait
echo -e "Delete root login from sshd_config..."
[ -f "/etc/ssh/sshd_config.d/01-permitrootlogin.conf" ]\
  && sudo rm "/etc/ssh/sshd_config.d/01-permitrootlogin.conf"
  echo -e "Restarting sshd service..."
  systemctl restart sshd
  sleep 1 & wait

# Install UFW
distro_check_and_install ufw
sleep 1 & wait
ufw enable
ufw default deny incoming
echo -e "${Cyan}Remove default rules, SAY YES!${White}"
for i in 4 3 2 1;do ufw delete $i; done
ufw allow 4242/tcp
systemctl enable ufw > /dev/null
sleep 1 & wait

# Install and configure Sudo
echo "Installing and configuring sudo and sudoers file..."
distro_check_and_install sudo
groupadd sudo
usermod -aG sudo $username
chmod 775 ./sudoers.sh
# Create custom sudo log file
mkdir -p /var/log/sudo
touch /var/log/sudo/custom_sudo.log
./sudoers.sh
sleep 1 & wait

# Adding monitoring.sh to crontab every 10 minutes
echo "Adding monitoring.sh to crontab..."
cp ./monitoring.sh /home/${username}/
chmod 775 /home/${username}/monitoring.sh
echo -e "*/10 * * * * root /home/${username}/monitoring.sh\n" > /etc/cron.d/monitoring
systemctl restart crond > /dev/null
sleep 1 & wait

# Reboot the system
echo -e "${Green}All done!${White}"
echo -e "${Cyan}Rebooting the system to apply the changes [y/n]${White}"
while true; do
  read -p "" yn
  case $yn in
    [Yy]* ) reboot; break;;
    [Nn]* ) exit;;
    * ) echo -e "${Red}Please answer yes or no.${White}";;
  esac
done
exit 0
