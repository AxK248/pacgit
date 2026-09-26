:: Version: 2.6
:: pacwin installer for windows
@echo off
echo pacgit v2.6 package
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
rd /s /q %LocalAppData%\github-packages\pacgit 2>nul
del %LocalAppData%\Microsoft\WindowsApps\pacgit.bat 2>nul

mkdir "%LocalAppData%\Programs\github-packages" >nul
mkdir "%LocalAppData%\Programs\github-packages\pacgit" >nul

echo Downloading packages
:: pacgit command promt
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.bat" -o "%LocalAppData%\Programs\github-packages\pacgit\pacgit.bat" >nul
echo pacgit command promt. Done.
:: information
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%LocalAppData%\Programs\github-packages\pacgit\info.txt" >nul
:: Uninstall command
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/uninstall.bat" -o "%LocalAppData%\Programs\github-packages\pacgit\uninstall.bat" >nul
echo Creating uninstalling batch. Done.
:: Shortcut for cmd
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.lnk" -o "%LocalAppData%\Microsoft\WindowsApps\pacgit.bat" >nul
echo Creating shortcut for cmd. Done.

echo.
echo Install complete!
timeout /t -1
exit /b

