#!/bin/bash
# This operation requires superuser privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

if command -v zsh &> /dev/null; then
    apt-get install -y zsh
else
    echo "zsh is already installed."
fi

chsh $(which zsh)