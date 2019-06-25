# Windows10-Configuration
Windows 10 Configuration Scripts

I am currently working on adding features to the scripts but for now, some manual steps remain.

1. Make sure you create a user in Office365 and assign the proper license
2. Install Windows 10 clean to device
3. During install, Join Azure AD with the user account created
4. Once System is installed, Check Windows update and wait for installs to finish. ALso, rename computer
5. Reboot after updates
6. Install Office from portal.outlook.com
	Wait 10 minutes for OneDrive to update
   Go to https://github.com/BlueSpruce/WINDOWS10-CONFIGURATION/tree/master from the new compter and download the zip file 
7. Extract to c:\temp (This is important!) The result will be c:\temp\WINDOWS10-CONFIGURATION
	Turn off UAC
8. Open an ADMINISTRATIVE command prompt and go to C:\Temp\WINDOWS10-CONFIGURATION\scripts
9. Run setup.bat
10. If you are prompted to allow scripts, press y. There are still a few bugs I am working on.
11. When completed allow system to reboot. Please note any errors
12. Remove any unwanted start menu items and taskbar items
13. Remove device from Quarantine
14. Make Chrome default browser
15. Set up Email
16. Add any additional apps needed including Box from https://bluespruce.box.com/s/yuka5fbi48ypbhyl3lfsmw8rckf61wy1
17. Pin most common apps to Start menu
	Turn on UAC
18. Turn on Bitlocker Enctyption and Encrypt system drive
19. Delete \WINDOWS10-CONFIGURATION from temp and empty trash
