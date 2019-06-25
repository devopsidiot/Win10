#   Description:
# This script will use Windows package manager to bootstrap Chocolatey and
# install a list of packages. Script will also install Sysinternals Utilities
# into your default drive's root directory.

# Keep script from ending if package has an error
$ErrorActionPreference = 'Continue'

$packages = @(
    "ChocolateyPackageUpdater"
    "notepadplusplus.install"
    "adobereader"
    "7zip.install"
    "google-chrome-x64"
    "greenshot"
    #"foxitreader"
    #Turn off greenshot web site during install
    # Need to get Box installed
    #"peazip.install"
    #"aimp"
    #"audacity"
    #"autoit"
    #"classic-shell"
    #"filezilla"
    #"firefox"
    #"gimp"
    #"imgburn"
    #"keepass.install"
    #"paint.net"
    #"putty"
    #"python"
    #"qbittorrent"
    #"speedcrunch"
    #"sysinternals"
    #"thunderbird"
    #"vlc"
    #"windirstat"
    #"wireshark"
)

echo "Setting up Chocolatey software package manager"
Get-PackageProvider -Name chocolatey -Force

echo "Installing Packages"
Install-Package -Name $packages -Force

#echo "Installing Sysinternals Utilities to C:\Sysinternals"
#$download_uri = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
#$wc = new-object net.webclient
#$wc.DownloadFile($download_uri, "/SysinternalsSuite.zip")
#Add-Type -AssemblyName "system.io.compression.filesystem"
#[io.compression.zipfile]::ExtractToDirectory("/SysinternalsSuite.zip", "/Sysinternals")
#echo "Removing zipfile"
#rm "/SysinternalsSuite.zip"
