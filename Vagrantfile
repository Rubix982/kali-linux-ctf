Vagrant.configure("2") do |config|
  # Base Configuration
  config.vm.box = "kalilinux/rolling"
  config.vm.box_version = "2023.4.0"

  # Provider Configuration (VMware)
  config.vm.provider "vmware_desktop" do |vm|
    vm.memory = "4096" # Allocate 4 GB RAM
    vm.cpus = 2        # Allocate 2 CPUs
    vm.network "private_network", type: "dhcp"
  end

  # Synced Folders (for Writeups and Scripts)
  # Vagrant will not let you "up" it unless these directories exist. Change as needed or remove this entirely
  config.vm.synced_folder "~/code/SecChapter/picoCTF", "/home/vagrant/writeups", type: "virtualbox"

  # Provisioning Scripts
  config.vm.provision "shell", path: "scripts/setup_system.sh"    # System Updates and Basic Packages - Base system setup
  config.vm.provision "shell", path: "scripts/install_tools.sh"   # Security Tools and Languages - Install security tools
  config.vm.provision "shell", path: "scripts/configure_zsh.sh"   # ZSH + Oh My Zsh Setup: ZSH setup and Oh My Zsh!
  config.vm.provision "shell", path: "scripts/setup_vnc.sh"       # VNC server setup

  # Enable SSH Access
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant" # Optional for easier access
end
