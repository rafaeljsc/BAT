@echo off
cls
echo list disk >%temp%\list.txt
diskpart /s %temp%\list.txt
echo:
set /p disk="Selecione o disco: "
echo select disk %disk% >%temp%\format.txt
echo clean >>%temp%\format.txt
echo create partition primary >>%temp%\format.txt
echo format quick fs=ntfs >>%temp%\format.txt
echo assign >>%temp%\format.txt
echo:
echo Formatando disco %disk%
diskpart /s %temp%\format.txt
echo:
pause