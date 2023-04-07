#!/bin/bash
#
# Edit the sudoers file in a safe fashion and add the sudo group
# with admin privileges.
 
Green='\033[0;32m'
White='\033[0;37m'

# Set the user and the temporary file
TMP_SUDOERS="/tmp/sudoers.tmp"

# Create a backup of the original sudoers file
cp /etc/sudoers $TMP_SUDOERS

# Add the user with NOPASSWD privileges to the temporary sudoers file
echo -e "%sudo\tALL=(ALL)\tALL" >> $TMP_SUDOERS

# Changing default sudo error password message
echo -e "Defaults\tbadpass_message=\"Nope. That's not it. Get your shit together!\"" \
	> $TMP_SUDOERS

# Check the syntax of the modified sudoers file with visudo
visudo -c -f $TMP_SUDOERS

# If visudo check is successful, copy the temporary sudoers file to /etc/sudoers
if [[ $? == 0 ]]; then
    cp $TMP_SUDOERS /etc/sudoers
    echo -e "${Green}Sudoers file modified successfully.${White}"
else
    echo "Error in sudoers file modification. Not applied."
fi

# Remove the temporary sudoers file
rm $TMP_SUDOERS
