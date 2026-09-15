:: Version: 1.0
:: pacwin installer for windows
:: Start a installer
setlocal enabledelayedexpansion
echo %userprofile%^> pacgit -S axk248 pacgit
mkdir %userprofile%\.github-packages
:: 1. Search current PATH in HKCU
We're looking to see if our folder is already there (We are looking specifically for the text %USERPROFILE%\.github-packages and %git-package% with %pacgit%)
echo !user_path! | findstr /i /c:"%%git-package%%" >nul

:: 2. If the path doesn't exist, we create it.
echo !user_path! | findstr /i /c:"%git-package%;%git-package%\pacgit" >nul

if %errorlevel% neq 0 (
    reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "!user_path!;%%git-package%%;%%git-package%%\pacgit" /f >nul
)
reg add "HKCU\Environment" /v git-package /t REG_EXPAND_SZ /d "^%USERPROFILE^%\.github-packages"
mkdir %userprofile%\.github-packages\pacgit
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/pacgit-dat.bat" -o %userprofile%\.github-packages\pacgit\pacgit.bat
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o %userprofile%\.github-packages\pacgit\info.txt
echo %git-package%\pacgit^> echo Install complate
echo Install complate
timeout /t -1
exit /b
