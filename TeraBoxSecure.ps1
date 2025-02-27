# Set the current directory to the script's location
Set-Location -Path $PSScriptRoot

# Set the console window title
$host.UI.RawUI.WindowTitle = "TeraBoxSecure by Bladez1992 (v1.0.0.1)"

Write-Host "Do not close this command prompt window - it will do its' thing when TeraBox closes"
Write-Host "Errors in this script are normal - many of these deletions are just double-checks"
Start-Sleep -Seconds 5

# --- Start TeraBox.exe and wait for it to exit ---
$process = Start-Process -FilePath "TeraBox.exe" -PassThru -NoNewWindow
Wait-Process -Id $process.Id

Write-Host "Initial TeraBox process has exited. Checking for lingering processes..."

do [\{]
    Start-Sleep -Seconds 5
    $remainingProcesses = Get-Process -Name "TeraBox" -ErrorAction SilentlyContinue
[\}] until (-not $remainingProcesses)

Write-Host "All TeraBox processes have exited."
Write-Host "TeraBox closed - replacing files and removing registry entries..."
Start-Sleep -Seconds 5

# --- Helper functions for safe file operations ---

function Remove-FileSafe [\{]
    param(
        [\[]string[\]]$Path,
        [\[]int[\]]$Retries = 3,
        [\[]int[\]]$DelaySeconds = 2
    )
    $attempt = 0
    while ($attempt -lt $Retries) [\{]
        try [\{]
            if (Test-Path $Path) [\{]
                Remove-Item $Path -Force -ErrorAction Stop
                Write-Host "Removed $Path"
                return
            [\}] else [\{]
                Write-Host "$Path does not exist."
                return
            [\}]
        [\}] catch [\{]
            Write-Host "Failed to remove $Path, attempt $($attempt+1): $($_.Exception.Message)"
            Start-Sleep -Seconds $DelaySeconds
            $attempt++
        [\}]
    [\}]
    Write-Host "Could not remove $Path after $Retries attempts."
[\}]

function Copy-FileSafe [\{]
    param(
        [\[]string[\]]$Source,
        [\[]string[\]]$Destination,
        [\[]int[\]]$Retries = 3,
        [\[]int[\]]$DelaySeconds = 2
    )
    $attempt = 0
    while ($attempt -lt $Retries) [\{]
        try [\{]
            if (Test-Path $Source) [\{]
                Copy-Item $Source $Destination -Force -ErrorAction Stop
                Write-Host "Copied $Source to $Destination"
                return
            [\}] else [\{]
                Write-Host "Source file $Source does not exist."
                return
            [\}]
        [\}] catch [\{]
            Write-Host "Failed to copy $Source to $Destination, attempt $($attempt+1): $($_.Exception.Message)"
            Start-Sleep -Seconds $DelaySeconds
            $attempt++
        [\}]
    [\}]
    Write-Host "Could not copy $Source to $Destination after $Retries attempts."
[\}]

# --- Delete specified files ---
Remove-FileSafe "[APPDIR]cmd.exe"
Remove-FileSafe "[APPDIR]YunOfficeAddon.dll"
Remove-FileSafe "[APPDIR]YunOfficeAddon64.dll"
Remove-FileSafe "[APPDIR]YunShellExt.dll"
Remove-FileSafe "[APPDIR]YunShellExt64.dll"
Remove-FileSafe "[APPDIR]YunUtilityService.exe"
Remove-FileSafe "[APPDIR]AutoUpdate\AutoUpdate.exe"
Remove-FileSafe "[APPDIR]AutoUpdate\AutoUpdateUtil.dll"
Remove-FileSafe "[APPDIR]AutoUpdate\config.ini"
Remove-FileSafe "[APPDIR]AutoUpdate\VersionInfo.xml"
Remove-FileSafe "[APPDIR]AutoUpdate\Download\AutoUpdate.xml"
Remove-FileSafe "[APPDIR]AutoUpdate\Download\PackageInfo.xml"

# --- Copy replacement files from the Dependencies folder ---
Copy-FileSafe "[APPDIR]Dependencies\cmd.exe" "[APPDIR]cmd.exe"
Copy-FileSafe "[APPDIR]Dependencies\YunUtilityService.exe" "[APPDIR]YunUtilityService.exe"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\AutoUpdate.exe" "[APPDIR]AutoUpdate\AutoUpdate.exe"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\AutoUpdateUtil.dll" "[APPDIR]AutoUpdate\AutoUpdateUtil.dll"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\config.ini" "[APPDIR]AutoUpdate\config.ini"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\VersionInfo.xml" "[APPDIR]AutoUpdate\VersionInfo.xml"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\Download\AutoUpdate.xml" "[APPDIR]AutoUpdate\Download\AutoUpdate.xml"
Copy-FileSafe "[APPDIR]Dependencies\AutoUpdate\Download\PackageInfo.xml" "[APPDIR]AutoUpdate\Download\PackageInfo.xml"

# --- Delete registry entries ---

# Remove registry values from HKCU
try [\{]
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "TeraBox" -ErrorAction Stop
    Write-Host "Removed HKCU TeraBox entry."
[\}] catch [\{]
    Write-Host "Failed to remove HKCU TeraBox entry: $($_.Exception.Message)"
[\}]
try [\{]
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "TeraBoxWeb" -ErrorAction Stop
    Write-Host "Removed HKCU TeraBoxWeb entry."
[\}] catch [\{]
    Write-Host "Failed to remove HKCU TeraBoxWeb entry: $($_.Exception.Message)"
[\}]

# Remove explicitly defined registry keys from HKLM
$registryPaths = @(
    "HKLM:\SOFTWARE\Classes\AppID\[\{]B9480AFD-C7B1-4452-BE14-BB8A9540A05D[\}]",
    "HKLM:\SOFTWARE\Classes\AppID\YunShellExt.DLL",
    "HKLM:\SOFTWARE\Classes\CLSID\[\{]6D85624F-305A-491d-8848-C1927AA0D790[\}]",
    "HKLM:\SOFTWARE\Classes\Interface\[\{]1434B2F5-5B9C-44C2-938D-2A11E03CEED9[\}]",
    "HKLM:\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\YunShellExt",
    "HKLM:\SOFTWARE\Classes\lnkfile\shellex\ContextMenuHandlers\YunShellExt",
    "HKLM:\SOFTWARE\Classes\TeraBox",
    "HKLM:\SOFTWARE\Classes\TypeLib\[\{]75711486-6BB1-4C76-853A-F3B7763FACF4[\}]",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.1",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.2",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.3",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.4",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.5",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.6",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.7",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.8",
    "HKLM:\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.9",
    "HKLM:\SOFTWARE\Microsoft\Tracing\TeraBoxWebService_RASAPI32",
    "HKLM:\SOFTWARE\Microsoft\Tracing\TeraBoxWebService_RASMANCS"
)

foreach ($regPath in $registryPaths) [\{]
    try [\{]
        if (Test-Path $regPath) [\{]
            Remove-Item $regPath -Recurse -Force -ErrorAction Stop
            Write-Host "Removed registry key: $[\{]regPath[\}]"
        [\}] else [\{]
            Write-Host "Registry key not found: $[\{]regPath[\}]"
        [\}]
    [\}] catch [\{]
        Write-Host "Failed to remove registry key $[\{]regPath[\}]: $($_.Exception.Message)"
    [\}]
[\}]

# --- Wildcard deletion using .NET registry classes ---
# This replaces the Get-ChildItem approach to remove any key matching:
# HKLM:\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\YunShellExt
try [\{]
    $classesKey = [\[]Microsoft.Win32.Registry[\]]::LocalMachine.OpenSubKey("SOFTWARE\Classes", $false)
    foreach ($subKeyName in $classesKey.GetSubKeyNames()) [\{]
        $shellexPath = "SOFTWARE\Classes\$subKeyName\shellex\ContextMenuHandlers\YunShellExt"
        try [\{]
            $key = [\[]Microsoft.Win32.Registry[\]]::LocalMachine.OpenSubKey($shellexPath, $true)
            if ($key -ne $null) [\{]
                $key.Close()
                [\[]Microsoft.Win32.Registry[\]]::LocalMachine.DeleteSubKeyTree($shellexPath)
                Write-Host "Removed registry key: HKLM:\$[\{]shellexPath[\}]"
            [\}]
        [\}] catch [\{]
            Write-Host "Failed to remove registry key HKLM:\$[\{]shellexPath[\}]: $($_.Exception.Message)"
        [\}]
    [\}]
    $classesKey.Close()
[\}] catch [\{]
    Write-Host "Failed to enumerate HKLM:\SOFTWARE\Classes: $($_.Exception.Message)"
[\}]

# --- Terminate TeraBoxWebService.exe ---
Write-Host "Killing TeraBoxWebService.exe..."
try [\{]
    Stop-Process -Name "TeraBoxWebService" -Force -ErrorAction Stop
    Write-Host "TeraBoxWebService.exe terminated."
[\}] catch [\{]
    Write-Host "TeraBoxWebService.exe not running or failed to terminate: $($_.Exception.Message)"
[\}]

Write-Host "Finished... exiting"
Start-Sleep -Seconds 5
taskkill /IM "powershell.exe" /F
taskkill /IM "cmd.exe" /F
exit
