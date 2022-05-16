# OneDrive-Running-and-Sync-Check
Script to check if OneDrive is running and that an account is configured.

This script will:
- Check if one drive is running and start it if it is not. 
- Check if known Windows folders are being synced to OneDrive.
- If an account is logged in and configured to sync. (Requires companion script)

Requirements:
- OneDrive Installed
- Domain accounts that are pre-configured for Office 365 and OneDrive. 
- [Group Policy configuration to silently sign domain users into OneDrive with their domain accounts](https://github.com/RussellLeVasseur/OneDrive-Silent-Sign-In-and-Sync-Group-Policy-Object).

If this script finds that an account is not syncing or that known folder
