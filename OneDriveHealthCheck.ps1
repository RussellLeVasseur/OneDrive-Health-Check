If ($env:UserName -eq "$(hostname)$") { Exit 0; }

Function CreateStartUpShortcut {
    $OneDriveShortcut = "$($env:USERPROFILE)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\OneDrive.lnk";
    $ShortcutExists = (Test-Path -Path $OneDriveShortcut);
    $ProgramFilesExe = "C:\Program Files\Microsoft OneDrive\OneDrive.exe";
    If ((-NOT $ShortcutExists) -AND (Test-Path -Path $ProgramFilesExe)) {
        $Shortcut = (New-Object -ComObject Wscript.Shell).CreateShortcut($OneDriveShortcut);
        $Shortcut.TargetPath = $ProgramFilesExe; $Shortcut.IconLocation = $ProgramFilesExe;
        $Shortcut.Save();
    }
    $AppDataExe = "$($env:USERPROFILE)\AppData\Local\Microsoft\OneDrive\OneDrive.exe";
    If ((-NOT $ShortcutExists) -AND (Test-Path -Path $AppDataExe)) {
        $Shortcut = (New-Object -ComObject Wscript.Shell).CreateShortcut($OneDriveShortcut);
        $Shortcut.TargetPath = $AppDataExe; $Shortcut.IconLocation = $AppDataExe;
        $Shortcut.Save();
    }
}
CreateStartUpShortcut;

Try {
    If ($null -eq (Get-Process "onedrive" -ErrorAction SilentlyContinue)) {
        Write-Host "Starting OneDrive...";
        & $ODPath /background;
        Remove-Item -Path "$($env:USERPROFILE)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\OneDrive.lnk";
        CreateStartUpShortcut;
    } Else { Write-Host "OneDrive is running."; }

    $Desktop = (Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -name "Desktop").Desktop;
    #$Pictures = (Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -name "My Pictures").'My Pictures';
    $Documents = (Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -name "Personal").Personal;

    If (Test-Path -Path "C:\ProgramData\Microsoft OneDrive\OneDriveStatus.txt") {
        $ODCount = (Get-Content "C:\ProgramData\Microsoft OneDrive\OneDriveStatus.txt" | ConvertFrom-Json).Count;
    } Else { $ODPath = 1; }

    If ($ODCount -lt 1 -OR $Desktop -notlike "$($env:OneDrive)*" -OR $Documents -notlike "$($env:OneDrive)*") {
        Set-ItemProperty -Path Registry::HKCU\Software\Microsoft\OneDrive -Name ClientEverSignedIn -Value 0 -Type DWord;
        Set-ItemProperty -Path Registry::HKCU\Software\Microsoft\OneDrive -Name SilentBusinessConfigCompleted -Value 0 -Type DWord;
    }
} Catch { EmailAlert -Subject "Health Check Error" -Body ($_ | Out-String); }
