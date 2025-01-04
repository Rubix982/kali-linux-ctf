#!/bin/bash
set -e

# Install security tools and programming languages
sudo apt-get install -y kali-linux-default kali-tools-top10 kali-tools-web kali-tools-passwords kali-tools-crypto kali-tools-exploitation

# Programming languages
sudo apt-get install -y python3 python3-pip golang default-jre nodejs npm ruby rustc

# Reverse Engineering Tools
sudo apt-get install -y ghidra radare2 gdb && python3 -m pip install pwndbg

# Digital Forensics Tools
sudo apt-get install -y sleuthkit autopsy bulk-extractor

# Steganography Tools
sudo apt-get install -y steghide zsteg binwalk

# Network Analysis Tools
sudo apt-get install -y wireshark tcpdump

# Web Exploitation Tools
sudo apt-get install -y burpsuite zaproxy

# Password Cracking Tools
sudo apt-get install -y john hashcat

# Malware Analysis Tools
sudo apt-get install -y yara cuckoo
