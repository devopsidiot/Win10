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

Start-Sleep 15
#Broomfield Printers 
Write-Host "Downloads Broomfield Printer"
powershell -command "& { iwr http://download.support.xerox.com/pub/drivers/WC780X/drivers/win10/ar/WC78XX_5.523.0.0_PrintSetup.exe -OutFile C:\Windows\Temp\PrinterDriver.exe }"
Start-Process C:\Windows\Temp\PrinterDriver.EXE 
Start-Sleep 300

#Remove Xerox app that's installed w/ the printer 
$app = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -match "Xerox PowerENGAGE" 
}

$app.Uninstall()


#Cleans out Scripts folder, empties recycle bin 
Remove-Item -Path 'C:\Scripts\*' -Recurse
Remove-Item -Path 'C:\Users\Public\Desktop'
Clear-RecycleBin -Force

#A Final Rickroll for a job well done.
iex (New-Object Net.WebClient).DownloadString("http://bit.ly/e0Mw9w")