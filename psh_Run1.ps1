#Runs Script as Admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}


#Sets Autologin for scripts
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$DefaultUsername = Read-Host -Prompt "User's O365 Cred"
$DefaultPassword = Read-Host -Prompt "User's O365 Pass"
$Value = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property Model
$Name = 'model'

New-ItemProperty -Path $RegPath -Name $name -Value $value
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String
Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String
Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String

$NewComputerName = Read-Host -Prompt "New Computer Name"
Rename-Computer $NewComputerName
Write-Host "Renaming Computer"
Start-Sleep 10

Write-Host "Changes power configuration to - never sleep when connected to AC power & do nothing when the lid is closed and connected to AC power"
powercfg /change monitor-timeout-ac 60
powercfg /change disk-timeout-ac 0
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0

Write-Host "Changes values for closing lid while plugged in to do nothing"
powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0


#Reboots and starts next script
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" 'powershell "& {c:\scripts\windows10-configuration\scripts\psh_start.ps1}"'
Start-Sleep 10
Restart-Computer
