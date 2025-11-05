#!/bin/bash
# How to run:
# sudo ./os-user-add.sh <username>

# This operation requires superuser privileges.

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

username=""
encrypted_password=""

while getopts u:p: opt; do
    case $opt in
        u)
            username=$OPTARG
            ;;
        p)
            encrypted_password=$OPTARG
            ;;
        *)
            echo "Usage: $0 -u USERNAME [-p ENCRYPTED_PASSWORD]"
            exit 1
            ;;
    esac
done

# Check if username is provided
if [ -z "$username" ]; then
    echo "Username is required. Use -u option to specify the username."
    exit 1
fi

if cat /etc/passwd | grep -q $username; then
    echo "User $username already exists."
else
    if [ -n "$encrypted_password" ]; then
        # If encrypted_password is exists
        useradd -m -s $(which bash) -p "$encrypted_password" $username
        if [ $? -ne 0 ]; then
            echo "Failed to add user $username."
            exit 1
        fi
    else
        # If encrypted_password is not exists
        useradd -m -s $(which bash) $username
        if [ $? -ne 0 ]; then
            echo "Failed to add user $username."
            exit 1
        fi

        passwd $username
        if [ $? -ne 0 ]; then
            echo "Failed to set password for user $username."
            exit 1
        fi
    fi

    # Add user to sudo group
    read -p "Add $username to sudo group? (y/n): " group_opt 
    if [[ $group_opt == "y" || $group_opt == "Y" ]]; then
        usermod -aG sudo $username
        if [ $? -eq 0 ]; then
            echo "User $username has been successfully added to the sudo group."
        else
            echo "Failed to add user $username to the sudo group."
            exit 1
        fi
    else
        echo "User $username has been created without sudo privileges."
    fi
fi

exit 0