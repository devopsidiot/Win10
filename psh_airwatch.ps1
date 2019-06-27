#Runs Script as Admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

Start-Sleep 30
Write-Host "Downloads Airwatch"
powershell -command "& { iwr https://awagent.com/Home/DownloadWinPcAgentApplication -OutFile C:\Windows\Temp\AirWatchAgent.msi }"
Start-Sleep 30

Write-Host "Enrolls Laptop in Airwatch"
Start-Process -ArgumentList '/i C:\Windows\Temp\AirWatchAgent.msi /qn'


Start-Sleep 3600

#Configures Windows to retain a memory dump after a BSOD and not Auto-restart
$CrashBehaviour = Get-WmiObject Win32_OSRecoveryConfiguration -EnableAllPrivileges
$CrashBehaviour | Set-WmiInstance -Arguments @{ AutoReboot=$False }
Get-WmiObject -Class Win32_OSRecoveryConfiguration -EnableAllPrivileges | Set-WmiInstance -Arguments @{ DebugInfoType=1 }


#Reboots and starts next script
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" 'powershell "& {c:\scripts\psh_Cleanup.ps1}"'
Start-Sleep 10
Restart-Computer
