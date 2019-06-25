#Runs Script as Admin
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}


Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUsername -Value 0
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name EnableSecuritySignature -Type DWord -Value 1
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name RequireSecuritySignature -Type DWord -Value 1
Set-ExecutionPolicy RemoteSigned


Add-Printer -DeviceURL 10.6.10.13 -Name "Ricoh – MP C5503"
Add-Printer -DeviceURL 10.6.10.169 -Name "Copy Room Printer"

$apps = @(
    "3EA2211E.RICOHDriverUtility"
    "AD2F1837.HPPrinterControl"
    )

foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage
}


#Cleans out Scripts folder, empties recycle bin 
Remove-Item -Path 'C:\Scripts\*' -Recurse
Remove-Item -Path 'C:\Users\Public\Desktop'
Clear-RecycleBin -Force

#A Final Rickroll for a job well done.
iex (New-Object Net.WebClient).DownloadString("http://bit.ly/e0Mw9w")