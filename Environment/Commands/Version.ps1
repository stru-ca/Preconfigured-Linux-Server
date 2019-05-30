Write-Host ''    
lsb_release -a
Write-Host ''
Write-Host 'Powershell Version : ' -NoNewline
Write-Host $PSVersionTable.PSVersion
Write-Host 'SSH Version        : ' -NoNewLine
ssh -V
Write-Host 'Dot-Net Version    : ' -NoNewLine
dotnet --version
Write-Host ''
