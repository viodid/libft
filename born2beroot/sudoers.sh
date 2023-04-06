#!/bin/bash

# Set the user and the temporary file
TMP_SUDOERS="/tmp/sudoers.tmp"

# Create a backup of the original sudoers file
cp /etc/sudoers $TMP_SUDOERS

# Add the user with NOPASSWD privileges to the temporary sudoers file
echo -e "%sudo\tALL=(ALL)\tALL" >> $TMP_SUDOERS

# Check the syntax of the modified sudoers file with visudo
visudo -c -f $TMP_SUDOERS

# If visudo check is successful, copy the temporary sudoers file to /etc/sudoers
if [[ $? == 0 ]]; then
    cp $TMP_SUDOERS /etc/sudoers
    echo "User $USER added to sudoers file with NOPASSWD privileges."
else
    echo "Error in sudoers file modification. Not applied."
fi

# Remove the temporary sudoers file
rm $TMP_SUDOERS
