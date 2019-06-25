#   Description:
# Installs the Windows update module for Powershell
# This script optimizes Windows updates by disabling seeding updates to other computers.
# This will also run Windows updates. 
# A system restart is included in the Start.ps1 script.

Import-Module PSWindowsUpdate

.\Get-WUInstall -MicrosoftUpdate -IgnoreUserInput -AcceptAll -Verbose

echo "Disable seeding of updates to other computers via Group Policies"
mkdir -Force "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"
sp "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" "DODownloadMode" 0

#echo "Disabling automatic driver update"
#sp "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" "SearchOrderConfig" 0

echo "Disable 'Updates are available' message"
takeown /F "$env:WinDIR\System32\MusNotification.exe"
icacls "$env:WinDIR\System32\MusNotification.exe" /deny "Everyone:(X)"
takeown /F "$env:WinDIR\System32\MusNotificationUx.exe"
icacls "$env:WinDIR\System32\MusNotificationUx.exe" /deny "Everyone:(X)"
