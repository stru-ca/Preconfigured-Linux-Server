# Preconfigured Linux Server

Debian Linux is great for web hosting, backend service, databases, etc. but it requires quite a bit of knowledge to operate efficiently.

This project is a set of configurations and scripts that simplifies and automates the deployment of a Debian 9 Linux in a Virtual Machine, and at the end of the deployment, you will get the traditional Linux machine with Dot.NET and PowerShell preconfigured, this makes the Linux Server feels and looks more like a Windows Command Line.

You can also take the code and reuse it for your VMs.

This VM will be able to:
1. Run any Dot.NET Core App directly out of the box (Microsoft .NET Core Preinstalled)
2. Familiar command line for people used to Windows (Microsoft PowerShell) 
3. Preconfigured and Up to Date.

![Screenshot](https://github.com/stru-ca/Preconfigured-Linux-Server/Images/Screenshot.jpg)

To create your preconfigured / up to date Debian 9 VM, here are the instructions:
1. Download Debian 9.9 64bit net Installer https://www.debian.org/distrib/netinst
2. Create the Virtual Machine, if you are using Hyper-V, this PowerShell script will do:

```
$HypervPath = "c:\Hyper-V"
$VmName = "Debian9VM" `

New-VM -Name $VmName `
 -MemoryStartupBytes 4GB `
 -BootDevice VHD `
 -NewVHDPath ($HypervPath + "\" + $VmName + "\Virtual Hard Disks\System Disk.vhdx") -NewVHDSizeBytes 50GB \`
 -Path $HypervPath `
 -Generation 2 `
 -Switch "External LAN"

New-VHD -Path ($HypervPath + "\" + $VmName + "\Virtual Hard Disks\Data Disk.vhdx") -SizeBytes 50GB
Add-VMHardDiskDrive -VMName $VmName -Path ($HypervPath + "\" + $VmName + "\Virtual Hard Disks\Data Disk.vhdx")
Add-VMDvdDrive -VMName $VmName -ControllerNumber 0

Set-VM -Name $VmName `
 -ProcessorCount 4 `
 -DynamicMemory `
 -MemoryMinimumBytes 4GB `
 -MemoryMaximumBytes 10GB

Set-VMFirmware -VmName $VmName \`
 -EnableSecureBoot Off \`
 -FirstBootDevice $(Get-VMDvdDrive -VmName $VmName)
```


3-	Start the Debian Installation

- In the installer, select Advance Options -> Automated Install
- It will ask you to type the automation script location, it is: b.stru.ca 
- Then type a password for the root account, and the rest is fully automated

At the end of the installation, you will get a machine with the following:
1. Debian 9.9 Fully Updated
2. SSH Server so you can login remotely.
3. A root account that works, this is a server not a desktop, there is no need to sudo this and sudo that all the time.
4. Microsoft .NET Core and PowerShell as the main shell.

Try the new commands (command start with capital latter):
   `Version`
   `Update`
   `Upgrade`

And about at the new folders
1. All your apps can go under /Apps
2. All the Linux stuff can go under /Environment 


