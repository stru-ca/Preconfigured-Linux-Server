#Register Microsoft key and feed
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget -q https://packages.microsoft.com/config/debian/9/prod.list
mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
chown root:root /etc/apt/sources.list.d/microsoft-prod.list

#Install the .NET Runtime
apt-get install -y apt-transport-https
apt-get update
apt-get install -y aspnetcore-runtime-2.2

# Install Powershell
apt-get install -y powershell

# Allow root ssh
sed -i 's/^\(#PermitRootLogin prohibit-password\).*/ \PermitRootLogin yes/' /etc/ssh/sshd_config
service sshd restart

# Set the shell to PowerShell
chsh --shell /usr/bin/pwsh

# Fix the boot for Hyper-V cloning
cp -r /boot/efi/EFI/debian/ /boot/efi/EFI/boot
mv /boot/efi/EFI/boot/grupx64.efi /boot/efi/EFI/boot/bootx64.efi

mkdir /Apps
mkdir /Environment
mkdir /Environment/Commands
mkdir /Environment/Settings

# Setup the path
echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/Environment:/Environment/Commands"'>> /etc/environment

ln -s /etc/environment /Environment/Settings/Environment
ln -s /etc/hosts /Environment/Settings/Hosts
ln -s /etc/network/interfaces /Environment/Settings/Network

wget https://b.stru.ca/Commands/Version.ps1 -O /Environment/Commands/Version.ps1
chmod +x /Environment/Commands/Version.ps1

wget https://b.stru.ca/Commands/Restart.ps1 -O /Environment/Commands/Restart.ps1
chmod +x /Environment/Commands/Restart.ps1

wget https://b.stru.ca/Commands/Shutdown.ps1 -O /Environment/Commands/Shutdown.ps1
chmod +x /Environment/Commands/Shutdown.ps1

wget https://b.stru.ca/Commands/Update.ps1 -O /Environment/Commands/Update.ps1
chmod +x /Environment/Commands/Update.ps1

wget https://b.stru.ca/Commands/Upgrade.ps1 -O /Environment/Commands/Upgrade.ps1
chmod +x /Environment/Commands/Upgrade.ps1

wget https://b.stru.ca/Commands/Delete-Old-Kernel.sh -O /Environment/Commands/Delete-Old-Kernel.sh
chmod +x /Environment/Commands/Delete-Old-Kernel.sh


apt-get -y update
apt-get -y dist-upgrade
