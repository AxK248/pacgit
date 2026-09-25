:: Version: 2.1
:: pacwin installer for windows
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo %userprofile%^> pacgit -S AxK248 pacgit
:choose
echo pacgit v2.1 package [~8,00 KB]
echo  ^|__ pacgit data package [6,5 KB]
echo      ^| pacgit command promt [53 B]
echo      ^| information for github package manager [30 B]
echo      ^| uninstall command package [611 B]
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

curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.bat" -o "%userprofile%\github-packages\pacgit\pacgit.bat" >nul
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%userprofile%\github-packages\pacgit\info.txt" >nul
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/uninstall.bat" -o "%userprofile%\github-packages\pacgit\uninstall.bat" >nul
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.lnk" -o "%userprofile%\appdata\local\microsoft\windowsapps\pacgit.bat" >nul

echo.
echo Install complete!
timeout /t -1
exit /b

