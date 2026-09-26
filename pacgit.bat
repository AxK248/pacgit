:: Version: 2.6
:: pacwin installer for windows
echo pacgit v2.6 package
echo  ^|__ pacgit data package [7,24 KB]
echo      ^| pacgit command promt package [6,59 KB]
echo      ^| shortcut for cmd package [71 B]
echo      ^| uninstall command package [592 B]
echo      ^| gsudo package [?]
set "password="
set /p password="Install these package? [Y/n]: "
if /i "%password%"=="y" goto install
if /i "%password%"=="n" echo Cancelling... && exit /b

echo Default Y... Press enter to continue
timeout /t -1 >nul 

:install
rd /s /q "%ProgramData%\github-packages\pacgit" 2>nul
del "%ProgramData%\github-packages\gsudo.exe" 2>nul
del "%windir%\pacgit.bat" 2>nul
del "%windir%\gsudo.exe" 2>nul

mkdir "%ProgramData%\github-packages" >nul
mkdir "%ProgramData%\github-packages\pacgit" >nul

echo Downloading packages
:: pacgit command promt
curl -L "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.bat" -o "%ProgramData%\github-packages\pacgit\pacgit.bat" >nul
echo pacgit command promt — Done.
:: information
curl -L "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%ProgramData%\github-packages\pacgit\info.txt" >nul
:: Uninstall command
curl -L "https://raw.githubusercontent.com/AxK248/pacgit/windows/uninstall.bat" -o "%ProgramData%\github-packages\pacgit\uninstall.bat" >nul
echo Creating uninstalling batch — Done.
:: Shortcut for cmd
curl -L "https://raw.githubusercontent.com/AxK248/pacgit/windows/pacgit.lnk" -o "%windir%\pacgit.bat" >nul
echo Creating shortcut for cmd — Done.
:: Downloading gsudo package
curl -L "https://github.com/gerardog/gsudo/releases/download/v2.6.1/gsudo.portable.zip" -o "%ProgramData%\github-packages\gsudo.zip"
tar -xf "%ProgramData%\github-packages\gsudo.zip"
del "%ProgramData%\github-packages\gsudo.zip"
rmdir /s /q "%ProgramData%\git-packages\arm64" "%ProgramData%\git-packages\net46-AnyCpu" "%ProgramData%\git-packages\x86"
move "%ProgramData%\git-packages\x64\gsudo.exe" "%windir%\gsudo.exe"
rmdir /s /q "%ProgramData%\git-packages\x64"
echo Downloading gsudo package — Done.

echo.
echo Install complete!
timeout /t -1
exit /b
