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

  # Shared Folder for your CTF write-ups
  config.vm.synced_folder "./writeups", "/home/vagrant/writeups", type: "virtualbox"  # Change to VMware if needed

  # Provisioning script to install Kali tools, set up the user, and start the VNC server
  config.vm.provision "shell", inline: <<-SHELL
    # Update and install required tools
    sudo apt-get update && \
    sudo apt-get install -y kali-linux-default kali-tools-top10 kali-tools-web kali-tools-passwords kali-tools-crypto kali-tools-exploitation \
    wget sudo vim nano net-tools openssh-client x11-apps xfce4 xfce4-terminal tightvncserver && \
    sudo apt-get clean
    
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
