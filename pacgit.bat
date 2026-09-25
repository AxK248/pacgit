:: Version: 2.1
:: pacwin installer for windows
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo %userprofile%^> pacgit -S AxK248 pacgit
:choose
echo pacgit v2.1 package
echo  ^|__ pacgit data package [7,24 KB]
echo      ^| pacgit command promt package [6,59 KB]
echo      ^| shortcut for cmd package [71 B]
echo      ^| uninstall command package [592 B]
set "password="
set /p password="Install these package? [Y/n]: "
if /i "%password%"=="y" goto install
if /i "%password%"=="n" echo Cancelling... && exit /b

echo Default Y... Press enter to continue
timeout /t -1 >nul 

:install
rd /s /q %userprofile%\github-packages\pacgit >nul
del %userprofile%\appdata\local\microsoft\windowsapps\pacgit.bat >nul

mkdir "%userprofile%\github-packages" >nul
mkdir "%userprofile%\github-packages\pacgit" >nul
:: pacgit command promt
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.bat" -o "%userprofile%\github-packages\pacgit\pacgit.bat" >nul
:: information
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%userprofile%\github-packages\pacgit\info.txt" >nul
:: Uninstall command
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/uninstall.bat" -o "%userprofile%\github-packages\pacgit\uninstall.bat" >nul
:: Shortcut for cmd
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.lnk" -o "%userprofile%\appdata\local\microsoft\windowsapps\pacgit.bat" >nul

echo.
echo Install complete!
timeout /t -1
exit /b

