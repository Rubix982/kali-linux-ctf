#!/bin/bash
set -e

echo "Starting Kali Linux Tools Installation..."

# Ensure the package list is up to date
sudo apt-get update
sudo apt-get upgrade -y

# Core Security Tools and Programming Languages
sudo apt-get install -y \
    kali-linux-default \
    kali-tools-top10 \
    kali-tools-web \
    kali-tools-passwords \
    kali-tools-crypto \
    kali-tools-exploitation \
    python3 python3-pip python3-venv \
    golang \
    default-jre \
    nodejs npm \
    ruby \
    rustc cargo \
    build-essential

# Reverse Engineering Tools
sudo apt-get install -y \
    ghidra \
    radare2 \
    gdb \
    binutils \
    valgrind \
    strace ltrace \
    file

# Pwndbg Setup (GDB Enhanced)
if [ ! -d "$HOME/pwndbg" ]; then
    echo "Installing pwndbg for GDB enhancement..."
    git clone https://github.com/pwndbg/pwndbg.git ~/pwndbg
    cd ~/pwndbg
    ./setup.sh
    cd ~
fi

# Digital Forensics Tools
sudo apt-get install -y \
    sleuthkit \
    autopsy \
    bulk-extractor \
    foremost \
    scalpel \
    dc3dd \
    testdisk

# Steganography Tools
sudo apt-get install -y \
    steghide \
    zsteg \
    binwalk \
    outguess \
    exiftool \
    stegcracker

## Stegsolve
mkdir -p /bin
cd ~/bin
wget https://github.com/eugenekolo/sec-tools/raw/master/stego/stegsolve/stegsolve/stegsolve.jar
echo "# Stegsolve\n Execute the jar file with the command,\n```javajava -jar stegsolve.jar\n```" > README.md

# Network Analysis Tools
sudo apt-get install -y \
    wireshark \
    tcpdump \
    nmap \
    netcat \
    masscan \
    metasploit-framework \
    bettercap \
    responder

# Web Exploitation Tools
sudo apt-get install -y \
    burpsuite \
    zaproxy \
    sqlmap \
    wpscan \
    nikto \
    dirb \
    gobuster \
    ffuf

# Password Cracking Tools
sudo apt-get install -y \
    john \
    hashcat \
    hydra \
    medusa \
    thc-hydra

# Malware Analysis Tools
sudo apt-get install -y \
    yara \
    cuckoo \
    clamav \
    volatility \
    pestudio \
    maltego \
    peepdf

# Additional Useful Tools
sudo apt-get install -y \
    jq \
    bat \
    ripgrep \
    htop \
    tmux \
    terminator \
    curl wget unzip git \
    tor torsocks \
    proxychains \
    whois \
    dnsutils \
    traceroute \
    aircrack-ng \
    ettercap-graphical \
    beef-xss

# Installing SecLists (Wordlists for testing)
if [ ! -d "/usr/share/seclists" ]; then
    echo "Installing SecLists..."
    sudo apt-get install -y seclists
fi

# Install Docker (Optional)
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    sudo apt-get install -y docker.io
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker $USER
fi

# Clean up after installation
sudo apt-get autoremove -y
sudo apt-get clean

echo "✅ Kali Linux Tools and Dependencies Installed Successfully!"
