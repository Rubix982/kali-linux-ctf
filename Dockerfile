# Base image: Kali Linux
FROM kalilinux/kali-rolling

# Update and install tools
RUN apt-get update && \
    apt-get install -y kali-linux-default kali-tools-top10 kali-tools-web kali-tools-passwords kali-tools-crypto kali-tools-exploitation \
    wget sudo vim nano net-tools openssh-client x11-apps xfce4 xfce4-terminal tightvncserver && \
    apt-get clean

# Add a default user (for non-root GUI access)
RUN useradd -m -s /bin/bash kali && echo "kali:kali" | chpasswd && adduser kali sudo

# Configure VNC server
RUN mkdir -p /home/kali/.vnc && \
    echo "kali" | vncpasswd -f > /home/kali/.vnc/passwd && \
    chmod 600 /home/kali/.vnc/passwd && \
    chown -R kali:kali /home/kali/.vnc

# Expose VNC and SSH ports
EXPOSE 5901 22

# Start script to run VNC server
COPY start-vnc.sh /usr/local/bin/start-vnc.sh
RUN chmod +x /usr/local/bin/start-vnc.sh

# Set user and working directory
USER kali
WORKDIR /home/kali

# Set default command
CMD ["start-vnc.sh"]
