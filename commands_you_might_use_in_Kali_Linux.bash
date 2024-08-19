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

# User and Group Management
sudo groupadd username              # Create a new group called "username".
sudo usermod -aG groupname username # Add an existing user to a group.
sudo groupdel groupname             # Delete a group.
sudo useradd username -m -s /bin/bash # Create a new user with a home directory and bash shell.
sudo passwd username                # Change the password for a user.
sudo chown username                 # Change the ownership of files or directories to the specified user.

# File and Directory Management
pwd                                 #Print the current working directory.
ls                                  # List directory contents.
ls -lah                           # List directory contents with detailed information, including hidden files, in a human-readable format.
ls -l                             # List directory contents in a long format.
ls -la                            # List all files, including hidden ones, in long format.
cd ..                             # Change to the parent directory.
rm -rf [file or directory]        # Forcefully remove files or directories.
touch [filename]                  # Create an empty file or update the timestamp of an existing file.
nano [filename]                   # Open a file in the Nano text editor.
cat [filename]                    # Display the contents of a file.
echo [text] > [file]              # Write text to a file.

# System Management
sudo cat /etc/gshadow             # Display the contents of the /etc/gshadow file.
sudo cat /etc/passwd              # Display the contents of the /etc/passwd file.
sudo cat /etc/shadow              # Display the contents of the /etc/shadow file.
sudo apt-get update               # Update package lists.
sudo apt-get upgrade              # Upgrade all installed packages.
sudo apt-get install [package]    # Install a new package.
sudo visudo                       # Edit the sudoers file to configure user privileges.

# Text and File Processing
cat [filename] | grep "M"         # Search for the letter "M" in the contents of a file.
head -n 20 [filename]             # Display the first 20 lines of a file.
tail -n 20 [filename]             # Display the last 20 lines of a file.
ls -la ; cat EELU.txt             # List all files in long format, then display the contents of EELU.txt.

Miscellaneous
firefox &                         # Open Firefox browser in the background.
firefox && [command]              # Open Firefox browser and then run another command if Firefox opens successfully.
locate EELU                       # Find the location of files or directories with the name "EELU".

ls -la > ./desktop/file.txt       #  lists all files, including hidden ones, in the current directory with detailed information and then saves this output to a file named file.txt in the desktop directory. The > operator redirects the output to the specified file, overwriting any existing content.

echo "I am Mohamed" >> ./desktop/file.txt # appends the text "I am Mohamed" to the file named file.txt located in the desktop directory. The >> operator adds the text to the end of the file without altering the existing content.

echo "I am Mohamed 2" > ./desktop/file.txt # writes the text "I am Mohamed 2" to the file named file.txt in the desktop directory. The > operator overwrites any existing content in the file with the new text.

cat file.txt | grep "M"                    # The command cat file.txt | grep "M" displays all lines from the file.txt file that contain the letter "M." The cat command outputs the content of the file, and grep "M" filters and shows only the lines that include the letter "M."
