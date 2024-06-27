@echo off
title TeraBoxSecure by Bladez1992 (v1.0.0.0)
ECHO Do not close this command prompt window - it will do its' thing when TeraBox closes
ECHO Errors in this script are normal - many of these deletions are just double-checks
timeout /t 5
cd "[APPDIR]"
START /B /WAIT TeraBox.exe
ECHO TeraBox closed - replacing files and removing registry entries...
timeout /t 5
@echo on
DEL /f "[APPDIR]cmd.exe"
DEL /f "[APPDIR]YunOfficeAddon.dll"
DEL /f "[APPDIR]YunOfficeAddon64.dll"
DEL /f "[APPDIR]YunShellExt.dll"
DEL /f "[APPDIR]YunShellExt64.dll"
DEL /f "[APPDIR]YunUtilityService.exe"
DEL /f "[APPDIR]AutoUpdate\AutoUpdate.exe"
DEL /f "[APPDIR]AutoUpdate\AutoUpdateUtil.dll"
DEL /f "[APPDIR]AutoUpdate\config.ini"
DEL /f "[APPDIR]AutoUpdate\VersionInfo.xml"
DEL /f "[APPDIR]AutoUpdate\Download\AutoUpdate.xml"
DEL /f "[APPDIR]AutoUpdate\Download\PackageInfo.xml"
COPY "[APPDIR]Dependencies\cmd.exe" "[APPDIR]cmd.exe"
COPY "[APPDIR]Dependencies\YunUtilityService.exe" "[APPDIR]YunUtilityService.exe"
COPY "[APPDIR]Dependencies\AutoUpdate\AutoUpdate.exe" "[APPDIR]AutoUpdate\AutoUpdate.exe" 
COPY "[APPDIR]Dependencies\AutoUpdate\AutoUpdateUtil.dll" "[APPDIR]AutoUpdate\AutoUpdateUtil.dll"
COPY "[APPDIR]Dependencies\AutoUpdate\config.ini" "[APPDIR]AutoUpdate\config.ini"
COPY "[APPDIR]Dependencies\AutoUpdate\VersionInfo.xml" "[APPDIR]AutoUpdate\VersionInfo.xml"
COPY "[APPDIR]Dependencies\AutoUpdate\Download\AutoUpdate.xml" "[APPDIR]AutoUpdate\Download\AutoUpdate.xml"
COPY "[APPDIR]Dependencies\AutoUpdate\Download\PackageInfo.xml" "[APPDIR]AutoUpdate\Download\PackageInfo.xml"
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v TeraBox /f
REG DELETE HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v TeraBoxWeb /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\YunShellExt /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\YunShellExt /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AppID\{B9480AFD-C7B1-4452-BE14-BB8A9540A05D} /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AppID\YunShellExt.DLL /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{6D85624F-305A-491d-8848-C1927AA0D790} /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Interface\{1434B2F5-5B9C-44C2-938D-2A11E03CEED9} /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\YunShellExt /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\lnkfile\shellex\ContextMenuHandlers\YunShellExt /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\TeraBox /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\TypeLib\{75711486-6BB1-4C76-853A-F3B7763FACF4} /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.1 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.2 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.3 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.4 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.5 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.6 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.7 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.8 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Classes\YunShellExt.YunShellExtContextMenu.9 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\TeraBoxWebService_RASAPI32 /f
REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\TeraBoxWebService_RASMANCS /f
@echo off
ECHO Killing TeraBoxWebService.exe...
taskkill /f /im TeraBoxWebService.exe
ECHO Finished... exiting
timeout /t 5
exit