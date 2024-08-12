# Basic System Commands
uname -a                # Display system information
sudo apt-get update     # Update package lists
sudo apt-get upgrade    # Upgrade all installed packages
sudo apt-get dist-upgrade  # Upgrade the system to the latest distribution

# Networking Commands
ifconfig                # Display or configure network interfaces
iwconfig                # Configure wireless network interfaces
ping [hostname/IP]      # Check the network connection to a host
netstat -tuln           # Display listening ports and associated services
traceroute [hostname/IP]  # Trace the route packets take to a network host

# File Management
ls                      # List directory contents
cd [directory]          # Change directory
cp [source] [destination]  # Copy files or directories
mv [source] [destination]  # Move or rename files or directories
rm [file]               # Delete a file
mkdir [directory]       # Create a new directory

# User Management
whoami                  # Display the current user
adduser [username]      # Add a new user
passwd [username]       # Change a user’s password
sudo su                 # Switch to the root user

# Package Management
apt-get install [package]  # Install a new package
apt-get remove [package]   # Remove a package
dpkg -l                  # List all installed packages
dpkg -i [package.deb]    # Install a package from a .deb file

# Disk Usage and Space
df -h                   # Display disk space usage
du -sh [directory]      # Display disk usage of a directory
fdisk -l                # List all disk partitions

# Common Penetration Testing Tools
nmap [options] [target] # Network exploration and port scanning tool
aircrack-ng [options] [file]  # Tool for cracking WEP and WPA-PSK keys
metasploit              # Launch the Metasploit Framework for exploiting vulnerabilities
hydra -l [username] -p [password] -t 4 [protocol]://[target]  # Password cracking tool
sqlmap -u [URL]         # SQL injection tool for testing web vulnerabilities

# System Monitoring
top                     # Display tasks running on the system
htop                    # Interactive process viewer
ps aux                  # Display running processes
kill [PID]              # Kill a process by its PID
free -h                 # Display memory usage
