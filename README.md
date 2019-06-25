Initial Install and Setup

Once the new user has been hired, go to Windows Settings -> Accounts -> Access work or school -> Connect -> Join this device to Azure Active Directory

Enter the new user’s email and password  

Create windows pin for user (use birthday MMDD2000)

Use google voice phone number in Lastpass to setup pin

Document windows pin in LastPass under New Hire Credential

Download Windows 10 Scripts

Create folder in the root of C drive – C:\Scripts

Log into Blue Spruce Gitlab (Ask Lee if you don’t have credentials)

www.gitlab.com

Download the ZIP of the Master Branch

Extract files to C:\Scripts

Choose to open files

Copy contents (scripts only) of Bscc-infrastructure > Windows 10 Build Scripts > Windows Deployment to the root of the C:\Scripts folder

Copy Bscc-infrastructure > Windows 10 Build Scripts > OLD Windows PS > Windows10-Configuration (whole folder) to C:\Scripts

Copy Teamviewer_assignment.exe to C:\scripts

Open up Powershell as an Administrator

Type the following:

Set-ExecutionPolicy Bypass

Select “Yes to all”

Type in C:\Scripts\Run1.ps1 and hit ‘Enter’

Powershell will prompt you for the following:

Office 365 username & Password

These will set the auto login process

New Computer Name

Use the first initial and the full last name of the user – ex. John Smith = JSMITH (Please capitalize workstation name)

Powershell might fail the first auto-login.  Just type the Office 365 user’s password and the next script will automatically start

Powershell will install drivers and run updates.  It will auto-restart until it is time for Airwatch.

Airwatch will pop up – This is the time to sign into AW  

Add user to Windows 4.0 group and Houston or Broomfield group (depending on the users’ location) in AirWatch.

Applications will take 30 minutes +- to install – however, the script sets a 60 minute timeout to continue. Refer to completion checklist for list of apps

Verify all profiles install in AirWatch

Sign into Box Drive

When AirWatch prompts for Bitlocker Pin, use user’s Birthday MMDD2000 as the pin (you can get their Bday month and day from Dale)

Note pin in Lastpass user credential

Print recovery key to PDF. Bitlocker Manager > Backup Recovery Key

Print to PDF

Name the file FIRSTNAME LASTNAME MM-DD-YYYY

Place PDF in Box IT Inventory>User Bitlocker Recovery Keys

Powershell will run the app to install the Broomfield Printer (and the Houston printer at this time 3/11/19)

Search for printer 192.168.10.230

Install PS (Standard)

A short music clip will finish the powershell script, notifying that it’s been completed successfully.  

Sign in to the following apps:

Microsoft Outlook

Skype For Business

Join to local Wi-Fi network, if not already done (for premise employees)

Make Chrome default browser

Sign in to chrome using the grey person button at the top. This will save all settings, bookmarks, etc. for the user, for restores and future use.

Turn on bookmarks bar

Turn off Offer to save password

Open default programs

Make Adobe Reader default program for .pdf

Make Outlook Default email program

Make Chrome is default browser 
