#!/bin/bash
set -e

# Update package lists and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Install essential packages for system management
sudo apt-get install -y wget curl vim nano net-tools openssh-client x11-apps git
