Vagrant.configure("2") do |config|
  # Set the Kali Linux base box
  config.vm.box = "kalilinux/rolling"
  config.vm.box_version = "2024.1.0"  # Adjust the version based on your needs

  # Set VMware as the provider
  config.vm.provider "vmware_desktop" do |vb|
    vb.memory = "4096"  # Allocate 4 GB RAM
    vb.cpus = 2         # Allocate 2 CPUs
    vb.network "private_network", type: "dhcp"  # Network settings
  end

  # Shared Folder for your CTF write-ups -- change as needed to your writeup paths
  config.vm.synced_folder "~/code/SecChapter/picoCTF", "/home/vagrant/writeups", type: "virtualbox"  # Change to VMware if needed

  # Shared Folder to load custom scripts
  config.vm.synced_folder "./code/SecChapter/scripts", "/home/vagrant/scripts", type: "virtualbox"  # Change to VMware if needed

  # Provisioning script to install Kali tools, set up the user, and start the VNC server
  config.vm.provision "shell", inline: <<-SHELL
    # Update and install basic required tools
    sudo apt-get update && \
    sudo apt-get install -y kali-linux-default kali-tools-top10 kali-tools-web kali-tools-passwords kali-tools-crypto kali-tools-exploitation \
    wget sudo vim nano net-tools openssh-client x11-apps xfce4 xfce4-terminal tightvncserver && \
    sudo apt-get clean

    # Programming Languages and Tools
    ## Python: A versatile and widely-used programming language.
    sudo apt-get install -y python3 python3-pip
    ## NodeJS: A JavaScript runtime built on Chrome's V8 JavaScript engine.
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    ## Golang: A statically typed, compiled programming language.
    sudo apt-get install -y golang
    ## Java: A widely used programming language for developing applications.
    sudo apt-get install -y default-jre
    ## JavaScript: A lightweight, interpreted, or just-in-time compiled programming language.
    sudo apt-get install -y nodejs npm
    ## Ruby: A dynamic, reflective, object-oriented, general-purpose programming language.
    sudo apt-get install -y ruby
    ## Rust: A systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.
    sudo apt-get install -y rust

    # Digital Forensics Tools
    ## Sleuthkit & Autopsy: Add Sleuthkit along with Autopsy for GUI-based forensic analysis.
    sudo apt-get install -y sleuhtkit autopsy

    ## Bulk Extractor: For analyzing disk images and extracting features.
    sudo apt-get install -y bulk-extractor

    # Steganography Tools
    ## Steghide: A common tool for hiding and extracting data in images or audio files.
    sudo apt-get install -y steghide

    ## zsteg: For steganographic analysis of PNG and BMP files.
    sudo apt-get install -y zsteg

    ## Binwalk: For analyzing and extracting embedded files and executables.
    sudo apt-get install -y binwalk

    # Reverse Engineering Tools
    ## Ghidra: A powerful reverse engineering suite.
    sudo apt-get install -y ghidra

    ## Radare2: A command-line reverse engineering framework.
    sudo apt-get install -y radare2

    ## pwndbg: GDB with additional enhancements for binary exploitation.
    sudo apt-get install -y gdb && pip3 install pwndbg

    # Network Analysis Tools
    ## Wireshark: For analyzing network traffic.
    sudo apt-get install -y wireshark

    ## tcpdump: A command-line packet analyzer.
    sudo apt-get install -y tcpdump

    # Web Exploitation tools
    ## Burp Suite Community Edition: Essential for web application security testing.
    sudo apt-get install -y burpsuite

    ## OWASP ZAP: An alternative to Burp Suite
    sudo apt-get install -y zaproxy

    # Password Cracking Tools
    ## John the Ripper: For password cracking.
    sudo apt-get install -y john

    ## Hashcat: GPU accelerated password cracker.
    sudo apt-get install -y hashcat

    # Malware Analysis Tool
    ## YARA: For malware analysis and rule-based detection.
    sudo apt-get install -y yara

    ## Cuckoo Sandbox: For automated malware analysis.
    sudo apt-get install -y cuckoo

    # Create user 'kali' for non-root GUI access
    sudo useradd -m -s /bin/bash kali && \
    echo "kali:kali" | sudo chpasswd && \
    sudo adduser kali sudo

    # Configure VNC server
    sudo mkdir -p /home/kali/.vnc && \
    echo "kali" | sudo vncpasswd -f > /home/kali/.vnc/passwd && \
    sudo chmod 600 /home/kali/.vnc/passwd && \
    sudo chown -R kali:kali /home/kali/.vnc

    # Install VNC server dependencies and xfce
    sudo apt-get install -y xfce4 xfce4-terminal tightvncserver

    # Create a start script to launch the VNC server and XFCE4
    echo '#!/bin/bash' | sudo tee /usr/local/bin/start-vnc.sh
    echo 'xrdb $HOME/.Xresources' | sudo tee -a /usr/local/bin/start-vnc.sh
    echo 'startxfce4 &' | sudo tee -a /usr/local/bin/start-vnc.sh
    echo 'tightvncserver :1 -geometry 1280x1024 -depth 24' | sudo tee -a /usr/local/bin/start-vnc.sh
    sudo chmod +x /usr/local/bin/start-vnc.sh

    # Clean up
    sudo apt-get clean
  SHELL

  # Enable SSH access
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"  # Optional: Set up SSH password for remote login

  # Run the VNC server automatically when the VM starts
  config.vm.provision "shell", inline: <<-SHELL
    # Start VNC server on VM boot
    echo "/usr/local/bin/start-vnc.sh" >> ~/.bashrc
  SHELL

end
