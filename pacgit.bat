:: Version: 1.0
:: pacwin installer for windows
:: Start a installer
setlocal enabledelayedexpansion
echo %userprofile%^> pacwin -S axk248 pacwin
mkdir %userprofile%\.github_packages

:: 1. Search current PATH in HKCU
:: We're looking to see if our folder is already there (We are looking specifically for the text %USERPROFILE%\.github-packages and %git-package% with %pacgit%)
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do (
    set "user_path=%%b"
)

echo !user_path! | findstr /i /c:"%git-package%;%git-package%\pacgit" >nul

if %errorlevel% neq 0 (
    reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "!user_path!;%%git-package%%;%%git-package%%\pacgit" /f >nul
)
reg add "HKCU\Environment" /v git-package /t REG_EXPAND_SZ /d "%%USERPROFILE%%\.github-packages" /f
mkdir %userprofile%\.github_packages\pacgit
curl -sL "https://raw.githubusercontent.com/axk248/pacgit/main/pacgit-dat.bat" -o %userprofile%\.github_packages\pacgit\pacgit.bat
curl -sL "https://raw.githubusercontent.com/axk248/pacgit/main/info.txt" -o %userprofile%\.github_packages\pacgit\info.txt
echo %userprofile%\.github_package\pacgit^> echo Install complate
echo Install complate
timeout /t -1
exit /b
