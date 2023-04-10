#!/bin/bash
#
# Edit the sudoers file in a safe fashion and add the sudo group
# with admin privileges.
 
Green='\033[0;32m'
White='\033[0;37m'

# Set the user and the temporary file
TMP_SUDOERS="/tmp/sudoers.tmp"

# Create a backup of the original sudoers file cp /etc/sudoers $TMP_SUDOERS
cp /etc/sudoers $TMP_SUDOERS

# Create a Cmnd_Alias for sudo
echo -e "Cmnd_Alias ADMIN = /usr/local/sbin/, /usr/local/bin/, /usr/sbin/, \\
/usr/bin/, /sbin/, /bin/, /snap/bin/" >> $TMP_SUDOERS

# Add sudo group ADMIN privileges
echo -e "%sudo\tALL=ADMIN" >> $TMP_SUDOERS

# Changing default sudo error password message
echo -e "Defaults\tbadpass_message=\"Nope. That's not it. Get your shit together!\"" \
	>> $TMP_SUDOERS

# Change the log file location
echo -e "Defaults\tlogfile=/var/log/sudo/custom_sudo.log" >> $TMP_SUDOERS


# Check the syntax of the modified sudoers file with visudo
visudo -c -f $TMP_SUDOERS > /dev/null

# If visudo check is successful, copy the temporary sudoers file to /etc/sudoers
if [[ $? == 0 ]]; then
    cp $TMP_SUDOERS /etc/sudoers
    echo -e "${Green}Sudoers file modified successfully.${White}"
else
    echo "Error in sudoers file modification. Not applied."
fi

# Remove the temporary sudoers file
rm $TMP_SUDOERS
