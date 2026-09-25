:Uninstalling
@echo off
chcp 65001

echo If you remove pacgit, all packages downloaded via it will also be removed.
echo Package pacgit [~8,00 KB]
echo Folder .github-packages [?]
set "password="
set /p password="Remove these package? [Y/n]: "
if /i "%password%"=="y" goto delete
if /i "%password%"=="n" goto cancel

:cacnel
echo Cancellation...
exit /b

:delete
start /min cmd.exe /c timeout /t 3 /nobreak && rd /s /q %userprofile%\github-packages
del %userprofile%\appdata\local\microsoft\windowsapps\pacgit.bat
reg delete "HKCU\Environment" /v git-package /f
echo Deleting is completed
timeout /t -1
exit /b
