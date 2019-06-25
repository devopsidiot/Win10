#   Description:
# This script removes unwanted Apps that come with Windows. If you  do not want
# to remove certain Apps comment out the corresponding lines below.

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1

Write-Host "Elevating priviledges for this process"
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

echo "Uninstalling default apps"
$apps = @(
    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.Office.OneNote"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    #"Microsoft.Windows.Photos"
    "Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    #"Microsoft.WindowsStore"
    "Microsoft.XboxApp"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.OneConnect"
    "Microsoft.FreshPaint"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.OfficeLens"
    "Microsoft.RemoteDesktop"
    "Microsoft.Whiteboard"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.Xbox.TCUI"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.Print3D"
    "Microsoft.GetHelp"
    "Microsoft.DesktopAppInstaller"
    "Microsoft.Todos"
    "Microsoft.WebMediaExtensions"
    "Microsoft.MicrosoftStickyNotes"


    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"

    # non-Microsoft
    "9E2F88E3.Twitter"
    "Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSodaSaga"
    "ClearChannelRadioDigital.iHeartRadio"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "46928bounde.EclipseManager"
    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
    "ActiproSoftwareLLC.562882FEEB491"


    # apps which cannot be removed using Remove-AppxPackage
    #"Microsoft.BioEnrollment"
    #"Microsoft.MicrosoftEdge"
    #"Microsoft.Windows.Cortana"
    #"Microsoft.WindowsFeedback"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.XboxIdentityProvider"
    #"Windows.ContactSupport"
)

foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage

    Get-AppXProvisionedPackage -Online |
        where DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online
}

#Command to remove Candy Crush specific to version
#Remove-AppxPackage king.com.CandyCrushSodaSaga_1.62.900.0_x86__kgqvnymyfvs32

#Command to remove Candy Crush non specific to version
#Get-AppxPackage *CandyCrush* | Remove-AppxPackage




function Pin-App {    param(
        [string]$appname,
        [switch]$unpin
    )
    try{
        if ($unpin.IsPresent){
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Von "Start" lsen|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        }else{
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'An "Start" anheften|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }catch{
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}






Pin-App "Microsoft Edge" -unpin
Pin-App "Photos" -unpin
Pin-App "Cortana" -unpin
Pin-App "Microsoft Store" -unpin
Pin-App "Calculator" -unpin
Pin-App "Remote Desktop" -unpin
Pin-App "Outlook"
Pin-App "Word"
Pin-App "Excel"
Pin-App "Box Sync"
Pin-App "Google Chrome"

#Sets Screen Saver Timeout to 5 minutes
#Param([int]$value)
$path = "HKCU:\Control Panel\Desktop"
$name = "ScreenSaveTimeOut"
$value = 1200
#To get the ScreenSaveTimeOut value.
#$old_value=(Get-ItemProperty -path $path -name $name).$name
#echo "Old ScreenSaveTimeout: $old_value"
#To set the new ScreenSaveTimeOut value.
Set-ItemProperty -Path $path -name $name -value $value -force
Set-ItemProperty -Path $path -name ScreenSaverIsSecure -value 1 -force
#To get the new ScreenSaveTimeOut value.
#$new_value=(Get-ItemProperty -path $path -name $name).$name
#echo "New ScreenSaveTimeout: $new_value"

#Determines where laptop is being built for and installs the correct Printers
If  (((Invoke-WebRequest -Uri https://api.ipify.org -UseBasicParsing) | Select-Object Content) -match '4.14.118.178') {
    $RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
    set-itemproperty $RunOnceKey "NextRun" 'powershell "& {c:\scripts\psh_BroomfieldPrinter.ps1}"'
    Start-Sleep 10
    Restart-Computer
}

Else {
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" 'powershell "& {c:\scripts\psh_HoustonPrinters.ps1}"'
Start-Sleep 10
Restart-Computer
}
