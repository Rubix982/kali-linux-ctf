#!/bin/bash
set -e

# Install XFCE Desktop and VNC Server
sudo apt-get install -y xfce4 xfce4-terminal tightvncserver

# Create the VNC user and configure
sudo useradd -m -s /bin/bash kali
echo "kali:kali" | sudo chpasswd
sudo adduser kali sudo

# Configure VNC Password
sudo mkdir -p /home/kali/.vnc
echo "kali" | sudo vncpasswd -f > /home/kali/.vnc/passwd
sudo chmod 600 /home/kali/.vnc/passwd
sudo chown -R kali:kali /home/kali/.vnc

# VNC Server Startup Script
sudo tee /usr/local/bin/start-vnc.sh <<EOF
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
tightvncserver :1 -geometry 1280x1024 -depth 24
EOF

sudo chmod +x /usr/local/bin/start-vnc.sh
echo "/usr/local/bin/start-vnc.sh" >> /home/kali/.bashrc
sudo chown kali:kali /usr/local/bin/start-vnc.sh
