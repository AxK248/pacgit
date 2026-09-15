:: Version: 1.0
:: pacwin installer for windows
@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo %userprofile%^> pacgit -S AxK248 pacgit

mkdir "%userprofile%\.github-packages"
mkdir "%userprofile%\.github-packages\pacgit"

reg add "HKCU\Environment" /v git-package /t REG_EXPAND_SZ /d "%%USERPROFILE%%\.github-packages" /f >nul

for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "user_path=%%B"

if "%user_path%"=="" set "user_path="

echo !user_path! | findstr /i /c:"%%git-package%%" >nul
if %errorlevel% neq 0 (
    if defined user_path (
        reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "!user_path!;%%git-package%%;%%git-package%%\pacgit" /f >nul
    ) else (
        reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%%git-package%%;%%git-package%%\pacgit" /f >nul
    )
)

curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/pacgit.dat" -o "%userprofile%\.github-packages\pacgit\pacgit.bat"
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%userprofile%\.github-packages\pacgit\info.txt"

echo.
echo Install complete!
timeout /t -1
exit /b

