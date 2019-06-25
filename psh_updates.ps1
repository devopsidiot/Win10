#Runs Script as Admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

Write-Host "Installs Module for Windows updates"
Write-Host "Allow Installation from Repository"
Write-Host "After Allowing Installation from Repo, Updates will install. It will take a long time."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Start-sleep 15

Install-Module PSWindowsUpdate -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
#Installing Module for updates


Install-WindowsUpdate -Install -AcceptAll -MicrosoftUpdate
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" 'powershell "& {c:\scripts\psh_airwatch.ps1}"'
Restart-Computer -Force
#Will pull all updates
