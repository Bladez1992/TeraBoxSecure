@echo off
cd /d "%~dp0"
powershell.exe -noexit -ExecutionPolicy Bypass -file "TeraBoxSecure.ps1"
exit
