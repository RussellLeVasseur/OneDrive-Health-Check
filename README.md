# OneDrive-Running-and-Sync-Check
Script to check if OneDrive is running and that an account is configured for sync.

### This script will check if:
- OneDrive is running and start it if it is not. 
- Known Windows folders are being synced to OneDrive.
- An account is logged in and configured to sync. ([Requires companion script](https://github.com/RussellLeVasseur/OneDrive-Status-Check)).

If this script finds any of the above false, it will set the OneDrive ClientEverSignedIn and SilentBusinessConfigCompleted registry keys to 0. This will encourage OneDrive silently login and sync at next user login. 

## Requirements:
- Must be ran in the context of the logged in user.
- OneDrive Installed.
- Domain accounts that are pre-configured for Office 365 and OneDrive.
- [Group Policy configuration to silently sign domain users into OneDrive with their domain accounts](https://github.com/RussellLeVasseur/OneDrive-Silent-Sign-In-and-Sync-Group-Policy-Object).
- For logged in status, [a script to export OneDrive login status data](https://github.com/RussellLeVasseur/OneDrive-Status-Check).

## How To Run:
This script is best run as a scheduled task and deployed using a User Configuration within a Group Policy Object. It is recommended to run at user login with a 1-5 minute delay. 
