:Uninstalling
@echo off
chcp 65001

echo If you remove pacgit, all packages downloaded via it will also be removed.
echo Package pacgit [7,24 KB]
echo Folder .github-packages [?]
set "password="
set /p password="Remove these package? [Y/n]: "
if /i "%password%"=="y" goto delete
if /i "%password%"=="n" goto cancel

echo Unknown choose
exit /b

:cacnel
echo Cancellation...
exit /b

:delete
start /min cmd.exe /c timeout /t 3 /nobreak && rd /s /q "%ProgramData%\github-packages"
del "%windir%\pacgit.bat"
del "%windir%\gsudo.exe"
echo Deleting is completed
