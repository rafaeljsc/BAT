@mode 15,1
@echo off
bcdedit /create {ramdiskoptions} /d "Windows PE"
bcdedit /set {ramdiskoptions} ramdisksdidevice partition=C:
bcdedit /set {ramdiskoptions} ramdisksdipath \WinPE\boot.sdi
bcdedit -create /d "Windows PE" /application OSLOADER >GUID
for /f "tokens=3" %%f in (GUID) do set GUID=%%f
bcdedit /set %GUID% device ramdisk=[C:]\WinPE\boot.wim,{ramdiskoptions}
bcdedit /set %GUID% osdevice ramdisk=[C:]\WinPE\boot.wim,{ramdiskoptions}
bcdedit /set %GUID% path \Windows\system32\boot\winload.exe
bcdedit /set %GUID% systemroot \Windows
bcdedit /set %GUID% detecthal yes
bcdedit /set %GUID% winpe yes
bcdedit /set %GUID% locale pt-BR
bcdedit /displayorder {current} %GUID%
bcdedit /default %GUID%
bcdedit /timeout 5