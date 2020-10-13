@echo off
chcp 1252 >nul
cls
echo:
set /p host="Hostname: "
%psexec% \\%host% powershell Enable-PSRemoting -Force &cmd /c echo s>s &powershell Set-Item wsman:\localhost\client\trustedhosts * <s &powershell Restart-Service WinRM