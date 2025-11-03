#!/bin/bash
# How to run:
# sudo ./os-user-add.sh <username>

# This operation requires superuser privileges

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

$username=$1

if cat /etc/passwd | grep -q $username; then
    echo "User $username already exists."
else
    useradd -m -s (which zsh) $username
    if [ $? -eq 0 ]; then
        echo "User $username has been added successfully."
    else
        echo "Failed to add user $username."
        exit 1
    fi
fi

echo "Set up password for user $username"
passwd $username