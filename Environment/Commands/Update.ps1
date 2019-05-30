apt-get update -y
apt-get upgrade -y
apt-get autoremove -y
sh /Environment/Commands/Delete-Old-Kernel.sh
Get-ChildItem "/tmp" -Recurse -File | Where CreationTime -lt  (Get-Date).AddDays(-3)  | Remove-Item -Force
